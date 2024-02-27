Return-Path: <linux-kernel+bounces-83801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A38EF869EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6AB0B269D1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C626148FEB;
	Tue, 27 Feb 2024 18:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="S9eRDiTJ"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2120.outbound.protection.outlook.com [40.107.9.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06FD3D541;
	Tue, 27 Feb 2024 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057493; cv=fail; b=IQ9C3HtSF+mgnuTDaJuvg4okApC4iqQD2sFAIRyRs4xqC+jogqL7SbAMTCuZCPiF1fRAZe8FyukOuGz0lGN5yLlSiftGOGcv9itHhtMbj9EoS+rfp1Mn1/vlhcYCvkfAopxcHIaJ9aT0RZti7n7jPefaLJE6c5HdHDvCDkBMBGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057493; c=relaxed/simple;
	bh=GLzANI9f9OppO2W73sTBkzTCR0F/jj9rKM4L3uvRfkk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=vB8ymeQKQs8SwA/dZPyIouBHBP8pH3Dw9F5BN3+vKxlnaT6qH7W8hl5FAT+hTHQJMCOZiuzPLb4RexKS5BXtR2fmeFcP7CBvhPcOLns0Zik3EIuqYQqUzseLGTWFXPf1Pr68GDAe2HwfskEU/lXrEqXtRUoZmKfBCVVQ/wwUwBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=S9eRDiTJ; arc=fail smtp.client-ip=40.107.9.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pz2VIKR8xlIzB+qzivpBUWAWqmwm3IwjwRdn/MPYvddfog3C47kwbxM0WYP8tlruiyBVx4fO8FUjij8v5IY9dzK0uKwAoDEmddJCw8i/LbY606NtVcPdijPbuTEt9+ocPUlnSPI3w54TRVUBo1RGrrrJFhpHr8QNYb913ArXKiR8b/oqZI1kH8H1hI949yCFKYzZl0aVJvPIWrMReYfghQTkWZdYT1Qc3g5JiJVXcqoxOzvPJlehaBjvWDFFESIis7HQVFTk4mn4+FuocGxTC6XaiAMPL3z9Q06zFFjKU1vWHjRFtgUXVUCQbBkiieOB+1+ufiRbmtr8yU7wVhGvvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GLzANI9f9OppO2W73sTBkzTCR0F/jj9rKM4L3uvRfkk=;
 b=hbv+U70GPxhGkrZcGL1MdNGpVFGoZIXnpALw8HGOmr7v/U9UHqRKCz1dlZUSyPSnhjLmNVuO2l3gInWj89os9S1pPA0Qzr0W5phEsb5tJX4HHiAzIM+nBx6PLBmeTSvnPCkvNyAw+nbr3egqD3os8HehhhxFT5TuVFcvv7HVdVHqE44pKwA8N7at3l1KYIaAyggaVMUdtjMZ9KSvSx0rAk18ljfSANCDfvO8VOxn3NiKActQX3V0tBp0OY4Qf5xTYLetbEQCqKBxlZBa2TzfXOAlgEtM4vmTpePV9wCaQVEeAOEoFfg9V642bw/9vtZiS7YZfpQTgKceR8qZM+Vjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GLzANI9f9OppO2W73sTBkzTCR0F/jj9rKM4L3uvRfkk=;
 b=S9eRDiTJb14EwXFgaNTp1Tgbmsu303cZx47ssZ39HMKlorOuA21SD+7La+a2fj1Oxho5gl+KI3N/bvBgFI1CXB71cq5QJ2jWmWOk7GjJlgmd43WKbteHJQu0KOjrfQe9sOBwdF/UI3Br9/maELKOpE0ZqdeYzgwpddNiFo0An+jXvM8Q0PNgYY5qcVKlK2gggtHaXYOfu8C3sE3A5yDz8ETuc8ROcCq6d8Q5xnrXe5T9nGx0NPZRjyOQaDnEja5Q1sbeestAbIWTbvS+91dzskEx+avhGtITYyQfUU6i1YErIb835Q04wiPjg1jlYawtj5+Ej1qeB3zbm1uxSnlxZw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB3772.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 18:11:27 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 18:11:24 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: "Russell King (Oracle)" <linux@armlinux.org.uk>, Guenter Roeck
	<linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index:
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAIAAPciAgAARwQCAAGrggIAABKIA
Date: Tue, 27 Feb 2024 18:11:24 +0000
Message-ID: <9f756413-806c-4cd0-a6cf-8dd82af14e88@csgroup.eu>
References: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk>
 <c8ddcc98-acb0-4d2d-828a-8dd12e771b5f@csgroup.eu> <Zd4h6ZhvLSWfWJG/@ghost>
In-Reply-To: <Zd4h6ZhvLSWfWJG/@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB3772:EE_
x-ms-office365-filtering-correlation-id: 93f0ed72-3892-4f53-cf02-08dc37bf8277
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Esf1xX5ESfftegnFJLGdhUnYE9rsOmblXYMpyE7S8OLVYtlN6L+wPAcyLljQVa2b50lfcwRYTdzWRab0XLSSqMAp2dyjoFVaKsCEzWvF28X1XAVYeSmy0kxqH68MTCx9xCChRedXDWPGoWG5xdcZaIKR3DFthjw/O4jonxy+NYP3NNHSS83vIh3P0tvJ9b7ZXOGr9pLZIPOs7r3TSOE8TZxkIlRaEbhHetjG9CxNJQVG26AzLcwwewLIQJ7KC0H4gu/l/8TZsitOeRbhaapWiHip1kRBa48RxiI3TomGPBhUeTLlX5IKLNiQPspqlZXiJnONRBLIjX+O+Ugx/Ce2AJQL/JQa/UmcA9LIz11R3ivKbzo15DcpbhTjtHM2xwcXNQV+X9ju1ifF+WXNG+ye/oWhis2oN+DqWmHtNqZhS6f+KotbfTASrEOmvbaim9hRsED3Zc/sxOFIhxJozTaV+5+03Pq5oebZhrDskByHtpF7lSoGm6KzYHI8VbOEhr0vR3Q0+Hv6WfpnjJR+BJRk4WNxWKvlCB6IdxaICtbPN7f5r4azhC2KEhxnenFOwZMxJILYwBh+4chgcAU/82bGEm07Czad7j8kbO8YzR/YOWH2ahpYH4ZMs7v6zTn2IKrbUJEJxG9q6uQ2Rf4Pj4Lq7tr9VOFegkHXWG/SkaK/gRFgMGJOyeuPAtjcwCqDw+f2o5+3G0D0McLvrPVmqOuwggKom788erEGu9ctxLiKCBg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NXNSaHBtUzlhWk0vZzliWkRGUGtCSjEvYU93UENvcjQrcGhYcnQyUGltaWN5?=
 =?utf-8?B?MnBZYk43dm1PVFBBOTQ2ckdSelpSZ1NQa0gzYTRvbkdES09aNXYyNXhEV2ly?=
 =?utf-8?B?WTB2UW5LaTJRcEZvcnlUTzEzbXptZ1Q2VmM5aHgwR0hTTVVQN3RRVkprM1pR?=
 =?utf-8?B?ZDl0TGx2enJHTk5nZm14MkxaMGF4WGhHMi82Rk14RlNmNlYrVkVPUUlZUGN2?=
 =?utf-8?B?T2J5TkdUTEJJQUpqWFVWQVdLcGtKZFlGdmtZMm1sbEFqN1BqNWVzWS9hN21Y?=
 =?utf-8?B?Ty9QSVFKRG1ycm01VFc3ZHo3ZmNtKzhjN0p3aW9rK2xxcjV4c29GRUdzZEpj?=
 =?utf-8?B?Y2UwZEJTREtaOWxrd1ZjeXpsUXlONU53VU5zVWVoRk9UV2RxaUVXbnhTSzh5?=
 =?utf-8?B?Wmdndmw2aGZVY09ZOUNMUjE5Sk4xbnJRd2VsQWl0RWVzOERWa285UUJXZXBj?=
 =?utf-8?B?bmRqNXNlck5jSmQrUGw5cjUwc1ZZc3J1WEpWWktxU1FGNVZvRVk3ZjgvdGhx?=
 =?utf-8?B?emRJb1lmUVZTZlIwanJ0NENLeHJJQWNLdkk0TEdJYkZIWEdYelM3Y1BkUHdL?=
 =?utf-8?B?cklFdUNMUEhMTFRJMzQ5WlRDYjVhMnJ6VEJ2OFY4WEx3QnBDWFdwc1c2S2Fi?=
 =?utf-8?B?YzFMTkVyclVJZ0xqOTkza3BaVEtKL2hVREZ4NVNKVnI1MER5RGdqVURldFMr?=
 =?utf-8?B?dkI1cUFMNzhUOVpydU1tdzd5MkZ2VTQ0eDBQYXkvWUh1WmpFNEUxS3BRMFZX?=
 =?utf-8?B?VlBwWHhLSWxMT1VZSmMzU1JtaWlwaGxkY2xXeCt0ZVNUOWcxY2d2NUZrdCtU?=
 =?utf-8?B?cEg0U1NmZVNDL29MeHdKYXQvK093ajRqaHJrTW5nWjVSUVAwM3ZaSTU4Zmg2?=
 =?utf-8?B?em0vQ0lWR0JtTFBvN0xUZ25laEZlcTYxVXNVNDNVdDZsa3RpYVY3VkxodDdF?=
 =?utf-8?B?cEkrakFPYzBKbFdhYU1OVVRFSkQ4UnFwMVdjZEk2Rjg3R0Ztak56N1IxUGFU?=
 =?utf-8?B?TG5nd293RjVhaGJzSXI0cWZZQjlIcnEzcERYOWhlZlAyN3VPeS9DMlI5SXNr?=
 =?utf-8?B?bStRS2tIL29UczZOMThBV1RNanJ0L2kxdlBob0NBeUtteER4RUZTbENGQlpI?=
 =?utf-8?B?eHNXODZRV2tWcXIvTHZxdHZWTTZmUTZDR2hmUXErRHNFV2JIMTF1ZE5mQmNL?=
 =?utf-8?B?eVplR0pjVWtMajJydENvenNucFVXVVAvK1VNU3dTbzUvUVVrOVlkMHVQZUh3?=
 =?utf-8?B?UitieG83Ky8rNG1RY0I1ZzVnNHhVQUhBTmQwZndWSUg4OUJpR0k1MUkrV3ZG?=
 =?utf-8?B?VXhTenVlQWdISk5tVFNJM1JiN1VmVkxCU1YrWWhpZnNndFIvVGlIbTNKRXRz?=
 =?utf-8?B?ZnVzQWZkZnE0d2U5QmFPSnduTmZZOGp2RFg1WWNURzVKNldNV0VrR3E2YThr?=
 =?utf-8?B?bTdBbVU1djNYNW50b3JmQmIwUHljcVpnRitINkF4Z0hFY3dxZ1VKT1QvbEdB?=
 =?utf-8?B?c0Q3d1J4SEtwU282WStZKzhkWjEyQ1lRQjhkMzJFaWRyUlFYWWE0R3Z2V0dj?=
 =?utf-8?B?bDZDYk83SEx5OThxNDhpbmlseC9xcEJEZG1NU095VW5jYjBFMHZid0hVdHRl?=
 =?utf-8?B?cEN4UFExcEhod0IweFNzMW5SMXpoUVk2azUxanRJUERQaWNkNXhDWlhtSnZF?=
 =?utf-8?B?Ny9TbUozdXI3OUVJK2UzV1ZBSVpyWmdrN2lvM1FMZUhWMWdXa1Nla2tXWGxB?=
 =?utf-8?B?ckVjYnI3WTRvN1NmUVRXdGRYMHdody9sOWZlNVpNQnFHc3hGejlsTU1kTGlY?=
 =?utf-8?B?ay9nRjY2d0RBWnF6cHJ2Sk40OFlwOUJnVWxGQkFqMG02SE02dHFoSW5WeGJR?=
 =?utf-8?B?Wk8reHpDZEIvZFJXQmF5cS9NTm5WMXRacCsvVGdWcitpd2VTTHNvTmQ5dENN?=
 =?utf-8?B?dlRNcENyUnJnUE1vTlNOeG0zMmlMQWgzMnVlZUZHT1J5b3Q3MHpQdTNZU1lu?=
 =?utf-8?B?eFhyMFN5UGJ4ZTVoY1VHeUZ2MHl5ZDZhQ1lnays0bVZSSzJ6eXVJeVFQbWsy?=
 =?utf-8?B?TjNic2R1Ymw4WUNUVEgvaUFFa0tDSlZjbmROMFJvK1E5bzh5NWlLMjdOdHRi?=
 =?utf-8?B?OHBmK1ZuWDRGQzEzL2thS0RPWkhCMW92eEJ5bDRBMmszdFJMSnc1RHExTzl2?=
 =?utf-8?B?eGtSbUhoZDFURTNuQUJQSmZwcm81WmFMVVFPU3ZYTkxUYjJRUk1ZdzA3bndW?=
 =?utf-8?B?RFRINE8vcUY1MkNoZ2o0TG9lc1BnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D757988231CD944C995A21F94E725D59@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 93f0ed72-3892-4f53-cf02-08dc37bf8277
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 18:11:24.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wkwSrTo6E7RYnkFp1xGRz1URaLDt1jF29LFIzvcoNRVr0Npcv1WVqx0dozmezuwJE6+bUi9g7QGGh63Q3Og/1aJc7KD5zyLUh9J5NPcHQjo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB3772

DQoNCkxlIDI3LzAyLzIwMjQgw6AgMTg6NTQsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAxMTozMjoxOUFNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAyNy8wMi8yMDI0IMOgIDExOjI4LCBSdXNzZWxsIEtp
bmcgKE9yYWNsZSkgYSDDqWNyaXTCoDoNCj4+PiBPbiBUdWUsIEZlYiAyNywgMjAyNCBhdCAwNjo0
NzozOEFNICswMDAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+Pg0KPj4+Pg0KPj4+PiBM
ZSAyNy8wMi8yMDI0IMOgIDAwOjQ4LCBHdWVudGVyIFJvZWNrIGEgw6ljcml0wqA6DQo+Pj4+PiBP
biAyLzI2LzI0IDE1OjE3LCBDaGFybGllIEplbmtpbnMgd3JvdGU6DQo+Pj4+Pj4gT24gTW9uLCBG
ZWIgMjYsIDIwMjQgYXQgMTA6MzM6NTZQTSArMDAwMCwgRGF2aWQgTGFpZ2h0IHdyb3RlOg0KPj4+
Pj4+PiAuLi4NCj4+Pj4+Pj4+IEkgdGhpbmsgeW91IG1pc3VuZGVyc3RhbmQuICJORVRfSVBfQUxJ
R04gb2Zmc2V0IGlzIHdoYXQgdGhlIGtlcm5lbA0KPj4+Pj4+Pj4gZGVmaW5lcyB0byBiZSBzdXBw
b3J0ZWQiIGlzIGEgZ3Jvc3MgbWlzaW50ZXJwcmV0YXRpb24uIEl0IGlzIG5vdA0KPj4+Pj4+Pj4g
ImRlZmluZWQgdG8gYmUgc3VwcG9ydGVkIiBhdCBhbGwuIEl0IGlzIHRoZSBfcHJlZmVycmVkXyBh
bGlnbm1lbnQNCj4+Pj4+Pj4+IG5vdGhpbmcgbW9yZSwgbm90aGluZyBsZXNzLg0KPj4+Pj4+DQo+
Pj4+Pj4gVGhpcyBkaXN0aW5jdGlvbiBpcyBhcmJpdHJhcnkgaW4gcHJhY3RpY2UsIGJ1dCBJIGFt
IG9wZW4gdG8gYmVpbmcgcHJvdmVuDQo+Pj4+Pj4gd3JvbmcgaWYgeW91IGhhdmUgZGF0YSB0byBi
YWNrIHVwIHRoaXMgc3RhdGVtZW50LiBJZiB0aGUgZHJpdmVyIGNob29zZXMNCj4+Pj4+PiB0byBu
b3QgZm9sbG93IHRoaXMsIHRoZW4gdGhlIGRyaXZlciBtaWdodCBub3Qgd29yay4gQVJNIGRlZmlu
ZXMgdGhlDQo+Pj4+Pj4gTkVUX0lQX0FMSUdOIHRvIGJlIDIgdG8gcGFkIG91dCB0aGUgaGVhZGVy
IHRvIGJlIG9uIHRoZSBzdXBwb3J0ZWQNCj4+Pj4+PiBhbGlnbm1lbnQuIElmIHRoZSBkcml2ZXIg
Y2hvb3NlcyB0byBwYWQgd2l0aCBvbmUgYnl0ZSBpbnN0ZWFkIG9mIDINCj4+Pj4+PiBieXRlcywg
dGhlIGRyaXZlciBtYXkgZmFpbCB0byB3b3JrIGFzIHRoZSBDUFUgbWF5IHN0YWxsIGFmdGVyIHRo
ZQ0KPj4+Pj4+IG1pc2FsaWduZWQgYWNjZXNzLg0KPj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IEkn
bSBzdXJlIEkndmUgc2VlbiBjb2RlIHRoYXQgd291bGQgcmVhbGlnbiBJUCBoZWFkZXJzIHRvIGEg
NCBieXRlDQo+Pj4+Pj4+IGJvdW5kYXJ5IGJlZm9yZSBwcm9jZXNzaW5nIHRoZW0gLSBidXQgdGhh
dCBtaWdodCBub3QgaGF2ZSBiZWVuIGluDQo+Pj4+Pj4+IExpbnV4Lg0KPj4+Pj4+Pg0KPj4+Pj4+
PiBJJ20gYWxzbyBzdXJlIHRoZXJlIGFyZSBjcHUgd2hpY2ggd2lsbCBmYXVsdCBkb3VibGUgbGVu
Z3RoIG1pc2FsaWduZWQNCj4+Pj4+Pj4gbWVtb3J5IHRyYW5zZmVycyAtIHdoaWNoIG1pZ2h0IGJl
IHVzZWQgdG8gbWFyZ2luYWxseSBzcGVlZCB1cCBjb2RlLg0KPj4+Pj4+PiBBc3N1bWluZyBtb3Jl
IHRoYW4gNCBieXRlIGFsaWdubWVudCBmb3IgdGhlIElQIGhlYWRlciBpcyBsaWtlbHkNCj4+Pj4+
Pj4gJ3dpc2hmdWwgdGhpbmtpbmcnLg0KPj4+Pj4+Pg0KPj4+Pj4+PiBUaGVyZSBpcyBwbGVudHkg
b2YgZXRoZXJuZXQgaGFyZHdhcmUgdGhhdCBjYW4gb25seSB3cml0ZSBmcmFtZXMNCj4+Pj4+Pj4g
dG8gZXZlbiBib3VuZGFyaWVzIGFuZCBwbGVudHkgb2YgY3B1IHRoYXQgZmF1bHQgbWlzYWxpZ25l
ZCBhY2Nlc3Nlcy4NCj4+Pj4+Pj4gVGhlcmUgYXJlIGV2ZW4gY2FzZXMgb2YgYm90aCBvbiB0aGUg
c2FtZSBzaWxpY29uIGRpZS4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gWW91IGFsc28gcHJldHR5IG11Y2gg
bmV2ZXIgd2FudCBhIGZhdWx0IGhhbmRsZXIgdG8gZml4dXAgbWlzYWxpZ25lZA0KPj4+Pj4+PiBl
dGhlcm5ldCBmcmFtZXMgKG9yIHJlYWxseSBhbnl0aGluZyBlbHNlIGZvciB0aGF0IG1hdHRlciku
DQo+Pj4+Pj4+IEl0IGlzIGFsd2F5cyBnb2luZyB0byBiZSBiZXR0ZXIgdG8gY2hlY2sgaW4gdGhl
IGNvZGUgaXRzZWxmLg0KPj4+Pj4+Pg0KPj4+Pj4+PiB4ODYgaGFzIGp1c3QgbWFkZSBwZW9wbGUg
J3Nsb3BweScgOi0pDQo+Pj4+Pj4+DQo+Pj4+Pj4+ICAgwqDCoMKgwqBEYXZpZA0KPj4+Pj4+Pg0K
Pj4+Pj4+PiAtDQo+Pj4+Pj4+IFJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLA0KPj4+Pj4+PiBNSzEgMVBULCBVSw0KPj4+
Pj4+PiBSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KPj4+Pj4+Pg0KPj4+Pj4+DQo+
Pj4+Pj4gSWYgc29tZWJvZHkgaGFzIGEgc29sdXRpb24gdGhleSBkZWVtIHRvIGJlIGJldHRlciwg
SSBhbSBoYXBweSB0byBjaGFuZ2UNCj4+Pj4+PiB0aGlzIHRlc3QgY2FzZS4gT3RoZXJ3aXNlLCBJ
IHdvdWxkIGFwcHJlY2lhdGUgYSBtYWludGFpbmVyIHJlc29sdmluZw0KPj4+Pj4+IHRoaXMgZGlz
Y3Vzc2lvbiBhbmQgYXBwbHkgdGhpcyBmaXguDQo+Pj4+Pj4NCj4+Pj4+IEFncmVlZC4NCj4+Pj4+
DQo+Pj4+PiBJIGRvIGhhdmUgYSBjb3VwbGUgb2YgcGF0Y2hlcyB3aGljaCBhZGQgZXhwbGljaXQg
dW5hbGlnbmVkIHRlc3RzIGFzIHdlbGwgYXMNCj4+Pj4+IGNvcm5lciBjYXNlIHRlc3RzICh3aGlj
aCBhcmUgaW50ZW5kZWQgdG8gdHJpZ2dlciBhcyBtYW55IGNhcnJ5IG92ZXJmbG93cw0KPj4+Pj4g
YXMgcG9zc2libGUpLiBPbmNlIEkgZ2V0IHRob3NlIHdvcmtpbmcgcmVsaWFibHksIEknbGwgYmUg
aGFwcHkgdG8gc3VibWl0DQo+Pj4+PiB0aGVtIGFzIGFkZGl0aW9uYWwgdGVzdHMuDQo+Pj4+Pg0K
Pj4+Pg0KPj4+PiBUaGUgZnVuY3Rpb25zIGRlZmluaXRlbHkgaGF2ZSB0byB3b3JrIGF0IGxlYXN0
IHdpdGggYW5kIHdpdGhvdXQgVkxBTiwNCj4+Pj4gd2hpY2ggbWVhbnMgdGhlIGFsaWdubWVudCBj
YW5ub3QgYmUgZ3JlYXRlciB0aGFuIDQgYnl0ZXMuIFRoYXQncyBhbHNvDQo+Pj4+IHRoZSBvdXRj
b21lIG9mIHRoZSBkaXNjdXNzaW9uLg0KPj4+DQo+Pj4gVGhhbmtzIGZvciBjb21wbGV0ZWx5IGln
bm9yaW5nIHdoYXQgSSd2ZSBzYWlkLiBOby4gVGhlIGFsaWdubWVudCBlbmRzIHVwDQo+Pj4gYmVp
bmcgY29tbW9ubHkgMiBieXRlcy4NCj4+Pg0KPj4+IEFzIEkndmUgc2FpZCBzZXZlcmFsIHRpbWVz
LCBuZXR3b3JrIGRyaXZlcnMgZG8gX25vdF8gaGF2ZSB0byByZXNwZWN0DQo+Pj4gTkVUX0lQX0FM
SUdOLiBUaGVyZSBhcmUgMzItYml0IEFSTSBkcml2ZXJzIHdoaWNoIGhhdmUgYSBETUEgZW5naW5l
IGluDQo+Pj4gdGhlbSB3aGljaCBjYW4gb25seSBETUEgdG8gYSAzMi1iaXQgYWxpZ25lZCBhZGRy
ZXNzLiBUaGlzIG1lYW5zIHRoYXQNCj4+PiB0aGUgc3RhcnQgb2YgdGhlIGV0aGVybmV0IGhlYWRl
ciBpcyBwbGFjZWQgYXQgYSAzMi1iaXQgYWxpZ25lZCBhZGRyZXNzDQo+Pj4gbWFraW5nIHRoZSBJ
UCBoZWFkZXIgbWlzYWxpZ25lZCB0byAzMi1iaXQuDQo+Pj4NCj4+PiBJIGRvbid0IHNlZSB3aGF0
IGlzIHNvIGRpZmZpY3VsdCB0byB1bmRlcnN0YW5kIGFib3V0IHRoaXMuLi4gYnV0IGl0DQo+Pj4g
c2VlbXMgdGhhdCBteSBjb21tZW50cyBvbiB0aGlzIGFyZSBiZWluZyBpZ25vcmVkIHRpbWUgYW5k
IHRpbWUgYWdhaW4sDQo+Pj4gYW5kIEkgY2FuIG9ubHkgdGhpbmsgdGhhdCB0aG9zZSB3aG8gYXJl
IGlnbm9yaW5nIG15IGNvbW1lbnRzIGhhdmUNCj4+PiBzb21lIGFsdGVyaW9yIG1vdGl2ZSBoZXJl
Lg0KPj4+DQo+Pg0KPj4gSSdtIHNvcnJ5IGZvciB0aGlzIG1pc3VuZGVyc3RhbmRpbmcuIEknbSBu
b3QgaWdub3Jpbmcgd2hhdCB5b3Ugc2FpZCBhdA0KPj4gYWxsLiBJIHVuZGVyc3Rvb2QgdGhhdCBB
Uk0gaXMgYWJsZSB0byBoYW5kbGUgdW5hbGlnbmVkIGFjY2Vzc2VzIHdpdGgNCj4+IHNvbWUgZXhj
ZXB0aW9uIGhhbmRsZXJzIGF0IHdvcnN0IGNhc2UgYW5kIHRoYXQgRE1BIGNvbnN0cmFpbnRzIG1h
eSBsZWFkDQo+PiB0byB0aGUgSVAgaGVhZGVyIGJlZWluZyBvbiBhIDIgYnl0ZXMgYWxpZ25tZW50
IG9ubHkuDQo+Pg0KPj4gSG93ZXZlciBJIGFsc28gdW5kZXJzdG9vZCBmcm9tIG90aGVycyB0aGF0
IHNvbWUgYXJjaGl0ZWN0dXJlcyBjYW4ndA0KPj4gaGFuZGxlIHN1Y2ggYSAyIGJ5dGVzIG9ubHkg
YWxpZ25tZW50cy4NCj4+DQo+PiBJdCdzIGJlZW4gc3VnZ2VzdGVkIGR1cmluZyB0aGUgZGlzY3Vz
c2lvbiB0aGF0IGFsaWdubWVudCB0ZXN0cyBzaG91bGQgYmUNCj4+IGFkZGVkIGxhdGVyIGluIGEg
Zm9sbG93LXVwIHBhdGNoLiBTbyBmb3IgdGhlIHRpbWUgYmVpbmcgSSdtIHRyeWluZyB0bw0KPj4g
ZmluZCBhIGNvbXByb21pc2UgYW5kIGdldCB0aGUgZXhpc3RpbmcgdGVzdHMgd29ya2luZyBvbiBh
bGwgcGxhdGZvcm1zDQo+PiBidXQgd2l0aCBhIHNtYWxsZXIgYWxpZ25tZW50IHRoYW4gdGhlIDE2
LWJ5dGVzIGFsaWdubWVudCBicm91Z2h0IGJ5DQo+PiBDaGFybGllJ3MgdjEwIHBhdGNoLiBBbmQg
YSA0IGJ5dGVzIGFsaWdubWVudCBzZWVtZWQgdG8gbWUgdG8gYmUgYSBnb29kDQo+PiBjb21wcm9t
aXNlIGZvciB0aGlzIGZpeC4gVGhlIGlkZWEgaXMgYWxzbyB0byBtYWtlIHRoZSBmaXggYXMgbWlu
aW1hbCBhcw0KPj4gcG9zc2libGUsIHVubGlrZSBDaGFybGllJ3MgcGF0Y2ggdGhhdCBpcyBjaHVy
bmluZyB1cCB0aGUgdGVzdHMgcXVpdGUNCj4+IGhlYXZpbHkuDQo+IA0KPiBEbyB5b3UgaGF2ZSBh
IGxpc3Qgb2YgcGxhdGZvcm1zIHRoaXMgaXMgZmFpbGluZyBvbj8gSSBoYXZlbid0IHNlZW4gYW55
DQo+IHJlcG9ydHMgdGhhdCBoYXZlbid0IGJlZW4gZml4ZWQuDQoNCkkgZG9uJ3QgaGF2ZSBzdWNo
IGEgbGlzdCwgYnV0IEkgZ3Vlc3MgeW91IGRvID8gSWYgYWxsIHBsYXRmb3JtcyBoYXZlIA0KYWxy
ZWFkeSBiZWVuIGZpeGVkLCB3aHkgYXJlIHlvdSBzZW5kaW5nIHRoaXMgcGF0Y2ggYXQgYWxsID8N
Cg0KQ2hyaXN0b3BoZQ0K

