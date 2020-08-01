
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	КопироватьДанныеФормы(Параметры.Объект, Объект);
	
	СтрокаУникальныйИдентификатор = Параметры.Значение;
	
КонецПроцедуры

&НаКлиенте
Процедура КомандаОК(Команда)
	
	Если ЗначениеЗаполнено(СтрокаУникальныйИдентификатор) Тогда
		Значение = Новый УникальныйИдентификатор(СтрокаУникальныйИдентификатор);
	Иначе
		Значение = Новый УникальныйИдентификатор;
	КонецЕсли;
	
	ВозвращаемоеЗначение = Новый Структура("Значение", Значение);

	Закрыть(ВозвращаемоеЗначение);
		
КонецПроцедуры

&НаКлиенте
Процедура УникальныйИдентификаторОкончаниеВводаТекста(Элемент, Текст, ДанныеВыбора, ПараметрыПолученияДанных, СтандартнаяОбработка)
	//СтандартнаяОбработка = Ложь;
	Если ЗначениеЗаполнено(Текст) Тогда
		Попытка
			ъ = Новый УникальныйИдентификатор(Текст);
		Исключение
			ВызватьИсключение "Некорректный уникальный идентификатор!";
		КонецПопытки;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура УникальныйИдентификаторПриИзменении(Элемент)
	Если ЗначениеЗаполнено(Ссылка) И Строка(Ссылка.УникальныйИдентификатор()) <> СтрокаУникальныйИдентификатор Тогда
		Ссылка = Неопределено;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура СсылкаПриИзменении(Элемент)
	Если Ссылка <> Неопределено Тогда
		СтрокаУникальныйИдентификатор = Ссылка.УникальныйИдентификатор();
	КонецЕсли;
КонецПроцедуры

&НаСервереБезКонтекста
Процедура ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, КлассСсылки, Менеджер, СтрокаУникальныйИдентификатор)
	
	Ссылка = Менеджер.ПолучитьСсылку(Новый УникальныйИдентификатор(СтрокаУникальныйИдентификатор));
	стрИмя = Ссылка.Метаданные().Имя;
	стрТаблица = КлассСсылки + "." + стрИмя;
	стрИмяПараметра = КлассСсылки + стрИмя;;
	
	маЗапросПоиска.Добавить(
		"ВЫБРАТЬ ПЕРВЫЕ 1
		|	Таблица.Ссылка КАК Ссылка
		|ИЗ
		|	" + стрТаблица + " КАК Таблица
		|ГДЕ
		|	Таблица.Ссылка = &" + стрИмяПараметра);
	зЗапросПоиска.УстановитьПараметр(стрИмяПараметра, Ссылка);
		
КонецПроцедуры

&НаСервереБезКонтекста
Функция КомандаНайтиНаСервере(СтрокаУникальныйИдентификатор)
	
	зЗапросПоиска = Новый Запрос;
	маЗапросПоиска = Новый Массив;
	
	Для Каждого Менеджер Из Справочники Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "Справочник", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из Документы Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "Документ", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из ПланыСчетов Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "ПланСчетов", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	                                                         
	Для Каждого Менеджер Из ПланыВидовХарактеристик Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "ПланВидовХарактеристик", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из ПланыВидовРасчета Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "ПланВидовРасчета", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из БизнесПроцессы Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "БизнесПроцесс", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из Задачи Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "Задача", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	Для Каждого Менеджер Из ПланыОбмена Цикл
		ДобавитьЗапрос(маЗапросПоиска, зЗапросПоиска, "ПланОбмена", Менеджер, СтрокаУникальныйИдентификатор);
	КонецЦикла;
	
	стрЗапрос = СтрСоединить(маЗапросПоиска, "
		|ОБЪЕДИНИТЬ ВСЕ
		|");
	
	зЗапросПоиска.Текст = стрЗапрос;
	выб = зЗапросПоиска.Выполнить().Выбрать();
	Если выб.Следующий() Тогда
		Возврат выб.Ссылка;
	КонецЕсли;
	
	Возврат Неопределено;
	
КонецФункции

&НаКлиенте
Процедура КомандаНайти(Команда)
	Ссылка = КомандаНайтиНаСервере(СтрокаУникальныйИдентификатор);
КонецПроцедуры
