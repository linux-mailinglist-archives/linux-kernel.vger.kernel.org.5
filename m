Return-Path: <linux-kernel+bounces-54939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EB3A84B52F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 484B9B277EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79595131E20;
	Tue,  6 Feb 2024 12:17:02 +0000 (UTC)
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01on2093.outbound.protection.outlook.com [40.107.239.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF8C13175A
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 12:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.239.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221821; cv=fail; b=UCHLhbRL1vaM59+NHunrfRVgJbYbOvAxsqI10RRiUILKOI+KiJJJPk/pkg+Rr12ZJwjlHM1AQTqrQxdv5yIEWoonygLcFj13FBHR4yW5bmb4WWJohX2eyLGmjXr2T9WFRCF5uMD1KToa0a+wKITRZUlX3nMAYsuvSPjHTWDtWEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221821; c=relaxed/simple;
	bh=JZgrdmoV1z3Ab3olGw7PKS1e4apVbScS9aJbVw9mytY=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Tfh3tvYA6PPggG5lMc7IBqHnoa65V2jPUzQ2n6J4JXj5KkJ/0MuTqO2Fs4aQ7ucpAR1FxqueSQGjFRW4b+Mc3xC40APfB3JnsmSh4BGVJppGl1LjG8TMH6Xxbf2l0MYViBXvRXySLJ8boVQiMAty39EYGbn06NqFcVp69BpsRlo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=USbIZinfodata.onmicrosoft.com; spf=pass smtp.mailfrom=USbIZinfodata.onmicrosoft.com; arc=fail smtp.client-ip=40.107.239.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=USbIZinfodata.onmicrosoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=USbIZinfodata.onmicrosoft.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWGLGjgSMoyZAMJZkWGl4gYCPWjSIsid3mGGAkP3mokl65bjS1kv5qQcTeX8i3SXRBRRPwWhYn4uwIjE7Og7dQ7j/nDnW5updy27nmkUYYEdcipC3/fCn+GLvCDkOg0KIf95yzlJqQ5RuE82VMW2VWLZ2+EDSwOnkfG2jbPbs8wmujWHNiOcdBMQA8DW4w2tVjr8ONq4slqJYqn7Zg+F+UmflAXKqNWtVr07QVgAUAtTqH3YwqrwTORufcvOseozsC8trLwfhX8a78uujGa8PXKk5ecyIot88csd8y/oR011An14qzgojSt5e9G0s2bGAzcPSf4NXx8t+fYbztT9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZgrdmoV1z3Ab3olGw7PKS1e4apVbScS9aJbVw9mytY=;
 b=U41J4O23OaGipBMkPXUm6idau/EZYWXSDakkKZtQ3D2iCwOli6SrDvn7qRBLfUzk/t/+ID+kjOIKsnxWfRkNac9mkmwTriRHgyVhG3UIzuC9iuc1SwOxGaDHgIrPtHR1qWlcSWXn8H9Fekt2aDUkWmq/Kcbjq4OWrLGA9RY3ngFo+kDEClOfJktoX67Su9z9CkPjkt4n6G/REYFI6naarOf1bTtv5E7u6MzfSGBgEFxeIZ2ApIb/iTFkPJ31Z6ZPjS5gOmp2m9KsLwbHUIJ5vd3SIFxaJVAGklbOSBMlFnN4EBHTKM9xe/nNzTfmDM2LATwENdHFOW66hAFj627MYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=usbizinfodata.onmicrosoft.com; dmarc=pass action=none
 header.from=usbizinfodata.onmicrosoft.com; dkim=pass
 header.d=usbizinfodata.onmicrosoft.com; arc=none
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:208::9)
 by PN3P287MB0826.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 12:16:57 +0000
Received: from PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325]) by PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
 ([fe80::d2ef:b83c:14b9:f325%6]) with mapi id 15.20.7270.016; Tue, 6 Feb 2024
 12:16:56 +0000
From: Emma Conner <Emma.Conner@USbIZinfodata.onmicrosoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: vger Facilities Management Contacts
Thread-Topic: vger Facilities Management Contacts
Thread-Index: AQHaWPZghu2wBYsPjUKw7VTYAimTQg==
Date: Tue, 6 Feb 2024 12:16:56 +0000
Message-ID:
 <3a361181-c518-cae6-71cc-33150f73b10c@USbIZinfodata.onmicrosoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none
 header.from=USbIZinfodata.onmicrosoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2559:EE_|PN3P287MB0826:EE_
x-ms-office365-filtering-correlation-id: 79e7d0f2-883e-4e11-4499-08dc270d8334
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6tbM0g/7s0R/IVpcdBdxa6FrSKaSAljF9kMUL+sp90xj5b7fFaCUtP1RKbwm/LnOnO9zT8jPj5vDIfTq36aR8hqndTRhlW+0LrayV9bZoUN4zfbHdD5K2y07saDcuMIAG44Wi0/jNewXIAR1BQjyZIB3o3viZCxvaS27YElwZIjgK+/B/9A6cXho020X0qQ/PB3xv7bK5/sYQrCaArK6jXy1u6skMiJq3WcBncN2kxBLGMW6rzY0MYekNc8YZaGcvW4mMs2fkLYOKA5aLPdn9auA1AvpXY36AObxsLQwrYDVk0fJokbQzW/glpxOShpqTWDfjvMmYbjDRz+TipOU+eDAEGFwdgNPVQ++fnM3MoEvKGmXUOefP6UYFB4AgoP+st0lQCtbHMNzRNJACO/xI0t7dZuwMFlh3kLmWc/JNCYzmlm+nowlaaraoBKH8f6jp6xS6mmgsgkNt6fcp+2kW8nLzCBaF86oE+iiSKZrLMjSgbWeyfd/a5vgdC/S63a55AaFxOoI5l0+AtSnc117IOwAEr4h8BQMKtez7EtWjITRDR6bO0nEZrV7jhaLxsv9DGVz4Pk9ftSFVOoFufbYjypTZJ6YeguqKnErurN+1wC9l28d2+FoH25QVT/hRZ5gBhneWh9ioXVV8hGzlobXgA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2559.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(376002)(396003)(366004)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(31686004)(38100700002)(41300700001)(2906002)(3480700007)(2616005)(83380400001)(6506007)(26005)(71200400001)(122000001)(53546011)(6512007)(66899024)(64756008)(6916009)(316002)(76116006)(86362001)(6486002)(66446008)(66556008)(66476007)(38070700009)(91956017)(478600001)(31696002)(8676002)(8936002)(5660300002)(66946007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SHgzZEExc2RvWnhHMkM0NGxpemNIUGRDREdpMnYrdWsvbHFDbXdRSDlQSkh4?=
 =?utf-8?B?NThxTGV3b1JSTHNlNEl1SkFtOVRiVnYxczR0a1dPMjBsanQ1TGd4ckRwUjdl?=
 =?utf-8?B?UmswNkZNSURkWHBUd05QNFlBMTkrd1pGMUt2ck95Q0lHcVlhUklXQ2ZEK3J5?=
 =?utf-8?B?cjh0RWIyOFY4aWJYSWJzcUZDR1IzNmdCekNKWmNqR1JKQ0dYU1h4SGkxLzNh?=
 =?utf-8?B?WTRXaU51S0JJaERoTmlCYTdOSnZBZkg1MVQ0SHNXTHU3WFVMQWNlRytTbDFS?=
 =?utf-8?B?dmw2dkpDR0NibjNpSU9JTmkzQWF1am1UM2ZRWHNTQTJzNUR6aHpTdzlaRU1T?=
 =?utf-8?B?a0lWOTh6ZWs1T3VKWmU4NUlnZndoUllOQjhEWER2UGptaWVNUnpreGlzS2FF?=
 =?utf-8?B?NjBXQkxBR3ZVVytsVmpNcG9vWGVlRGx1OTgvYjBpZDdxdC9UMzZaL2t0eXU2?=
 =?utf-8?B?aCsxWmk3R29aRlZNQk9JWEw2ZDkzV0FZeHl5OGp4NHdvbEpLeFdVYjQ1TkRk?=
 =?utf-8?B?UkxldGJxM25za1Q1NytVUFdBdEhpV2RkK0xRUEF6dHY4c1FZQW1NcXVRMHNP?=
 =?utf-8?B?RDcyM2s1TU9nTTdNMGd3SzF2TldPZ1BCdjlvNnBGakVjME85cHcxUklGcTFs?=
 =?utf-8?B?RHkvQ09OcVM4SDZOQW5pY1IydkFMTXlpUWx6WGF3Z1Z5U0c5L09kbEgrRnV6?=
 =?utf-8?B?TFJBTzBSUDlHemYwaXYyRXdsVS8vb2JnWHJvTFlDVmV1L0VMOW9QRHNUR3Fn?=
 =?utf-8?B?bEd2cE51WHRLUG9EdWNkZlRyYmsxbThPUC9PMnFveTMvM2daSGRsNG5GanBQ?=
 =?utf-8?B?cktoN2ZaYnFuRERHb2NDQ2J4VnhKSmJGQW9DY3B0MDlTMDkxNmREaHlpeGhU?=
 =?utf-8?B?Yko0ZVVjejdxNVRzMXVwVzUxKzEyUDQ5R0l3WjNGYmJQcjdZZlMrdVM3WHJU?=
 =?utf-8?B?dnF0aDlqVWFNcnhoeEF6R3FhZTBycHAwZ0ZWbUlHOUFtcUFtRHpjLy9RSVhY?=
 =?utf-8?B?Tno2NjdoR2lsbFhIaFZVVkMzVlNDNFhBY09JTGNFSURRbVVRS1M0aW5MbVVH?=
 =?utf-8?B?RW1qV0NhdFVFTFFrMzhOeExPWWh0dkFpNUg5b3Q2VTJPT1hmY3ExbU1iWXF2?=
 =?utf-8?B?T2M1QWdmSk9La3o1Qy9weU5aUXBsdU5UZ2Vyajc5WDUrMzhPTmhMVmhwa0U1?=
 =?utf-8?B?Z1FnakZYbURqZ3Q0TlBZdmZSbEY2OG9WUk5mK1pGNVF0a3l2WUdJbVByZVk3?=
 =?utf-8?B?Z3ZhbkwyU3VBdWVkZFUyR2ZDS3IrWlBpNjNOS3hHdjBmNkZtVWl2UExjczFK?=
 =?utf-8?B?V2g5N25GTlJkWE0xWC9ySEJTcFJPSmVQaVZvbzAvT3J0U0ZscHV2azg4cWc4?=
 =?utf-8?B?OUdiTEpkVXpUWmwrT3FQVXNSbDlIcktaRUFmL1FBM0NjdHJzK2VpNUFycmZ2?=
 =?utf-8?B?aU8wbE50QUpKV1JERGYzSkVIQ0FCVFJNdHV4TGxYbVlqbjZ1dHAwelZLREhr?=
 =?utf-8?B?SzFXYXoyQllwb3JJdUNDMlNrRDQxN251d1VFQTYxN3pnNnhPcTFhWjRkalV5?=
 =?utf-8?B?WVI5Z2daMTBEUnY2cG8vVng3VkdjajJBb2hZUkRwZjcwa2dueGFHM2Q0ZENs?=
 =?utf-8?B?TVBzRzlwOEkzaUl6ZXUwSHFuRjZUQTViSFRIWDN1cVlwWDNFOGdJMmNlcVoy?=
 =?utf-8?B?bVhJcS8rN3hOeFVabjZxS1RhMXZCWWFhNldFQTRGNkY1eDU0YnIrWWdVYW9I?=
 =?utf-8?B?dU43Z0VPZllhZmRTeGdYZCtDYW4vWTZIR0QvTXAyVDFDZFU1NVlRQjhTRlF2?=
 =?utf-8?B?T0ZuSjl4dERRblVjd2RCM0tnbEZTUmNLSkNPb2IrTUZJNDNvTHZwVWIrQ0E4?=
 =?utf-8?B?NXYya1dZRXZEaTRwMWJ4dkJQdEhkUGx4RnluRU8xZEMrOVhaMG9UWWdZcFNZ?=
 =?utf-8?B?VUpaM3pUSmpGUm9rQmJidU96MWpKN29tZ282ZWxFQ3Fuc0JNdFJNN0tqNjgy?=
 =?utf-8?B?RUNnYlpsNGRNbHhSVjN0R09LUjFLdDhlNjBZNlN3S2tkbEszSzdXZm1kTWdr?=
 =?utf-8?B?dW1xV2UzbFBVK0F1QXZyWWdEeS9URkYvYkRqdGtPSXE0dFduRlA4L1dhN3FP?=
 =?utf-8?B?RjgxM09SYmVyYVFydzFaWFZJMnFmOG5ObUlCUXpqdWV5ODV5eitoT2Q1UmJO?=
 =?utf-8?Q?0Yw/8Xeo8EGDK0aJWC6vfMg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8562904BEDE6C74CBCA87EEC1352B469@INDP287.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: USbIZinfodata.onmicrosoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2559.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e7d0f2-883e-4e11-4499-08dc270d8334
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2024 12:16:56.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c8985d2c-274e-4d2e-b47a-e4113825a86d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7vTqbl+8QBsgm3bSMKoh6WpcNNE7UYPm81Iz/czQsdSYJZfPYCXTDS+RtMPFj2D9VvbI8W7vnXTBFEnvCWO03jHd0XFkt3T2zDLL5PGyO+rL9v5PelGTog1fgwW00RI6mCkatfj8AqinDQdQdrE2pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0826

SGksDQoNCkp1c3Qgd2FudGVkIHRvIG1ha2Ugc3VyZSB5b3UgcmVjZWl2ZWQgbXkgbGFzdCBlbWFp
bCByZWdhcmRpbmcgYSANCmN1c3RvbWl6ZWQgbGlzdCBvZiBSZWFsIEVzdGF0ZSBkZWNpc2lvbiBt
YWtlcnMgYmVsb3cuIEnigJltIGxvb2tpbmcgdG8gDQpmaW5kIHRoZSByaWdodCBwZXJzb24gd2hv
IGxvb2tzIGFmdGVyIHlvdXIgbWFya2V0aW5nIGFuZCBsZWFkIGdlbmVyYXRpb24uDQoNCldlIGhl
bHAgY29tcGFuaWVzIGdyb3cgc2FsZXMgcmV2ZW51ZSB3aXRoIG91ciBoaWdobHkgdGFyZ2V0ZWQg
ZW1haWwgDQpsaXN0cyBkaXJlY3RseSBzb3VyY2VkLg0KDQpQbGVhc2UgbGV0IHVzIGtub3cgeW91
ciB0YXJnZXQgaW5kdXN0cmllcyBhbmQgam9iIHRpdGxlcyBzbyB3ZSBjYW4gc2VuZCANCnlvdSB0
aGUgbnVtYmVycyBvZiBjb250YWN0cy4NCg0KUmVnYXJkcywNCkVtbWENCg0KRW1tYSBDb25uZXJ8
IE1hcmtldGluZyBDb25zdWx0YW50DQoNCk9uIDA4LTAyLTIwMjMgMTE6NDMsIEVtbWEgQ29ubmVy
IHdyb3RlOg0KDQpIaSwNCg0KV291bGQgeW91IGJlIGludGVyZXN0ZWQgaW4gYW4gdXBkYXRlZCBG
YWNpbGl0aWVzIE1hbmFnZW1lbnQgZW1haWwgbGlzdD8NCg0KT3duZXJzLCBQcmVzaWRlbnRzDQpG
YWNpbGl0aWVzIERpcmVjdG9yDQpNYWludGVuYW5jZSBEaXJlY3Rvcg0KSGVhbHRoIGFuZCBzYWZl
dHkNCldvcmtwbGFjZSBNYW5hZ2VyDQpCdWlsZGluZyBNYW5hZ2VyDQpQbGFudCBEaXJlY3Rvcg0K
RGlyZWN0b3IgU2FmZXR5IGFuZCBTZWN1cml0eQ0KSGVhZCBvZiBSZWFsIEVzdGF0ZSBhbmQgRmFj
aWxpdGllcw0KRmFjaWxpdGllcyBFbmdpbmVlcg0KU2l0ZSBNYW5hZ2VyDQoNCldlIGNhbiBwcm92
aWRlIGNvbnRhY3RzIG9mIHZhcmlvdXMgam9iIHRpdGxlcyBmcm9tIHNldmVyYWwgbGV2ZWxzIC0g
Zm9yIA0KZS5nLjogQyBTdWl0LCBWUHMsIERpcmVjdG9ycywgTWFuYWdlcnMgYW5kIHN0YWZmIGxl
dmVsIGNvbnRhY3RzDQoNCldlIGNhbiBjdXN0b21pemUgeW91ciBsaXN0IGFjY29yZGluZ2x5IGZv
ciBhbnkgb3RoZXIgcmVxdWlyZW1lbnRzIHRoYXQgDQp5b3UgaGF2ZS4NCg0KTGV0IHVzIGtub3cg
dGhlIGpvYiB0aXRsZXMgYW5kIHlvdXIgdGFyZ2V0IGF1ZGllbmNlIHNvIHdlIHByb2Nlc3MgYW5k
IA0Kc2VuZCB0aGUgY291bnRzLg0KDQpBcHByZWNpYXRlIHlvdXIgcmVzcG9uc2UuDQoNClJlZ2Fy
ZHMsDQpFbW1hIENvbm5lciB8IE1hcmtldGluZyBDb25zdWx0YW50DQoNClJlcGx5IG9ubHkgb3B0
LW91dCBpbiB0aGUgc3ViamVjdCBsaW5lIHRvIHJlbW92ZSBmcm9tIHRoZSBtYWlsaW5nIGxpc3Qu
DQo=

