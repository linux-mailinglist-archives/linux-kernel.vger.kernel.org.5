Return-Path: <linux-kernel+bounces-87982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E51C86DBC4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9774B1F2634F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA136930D;
	Fri,  1 Mar 2024 07:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="fWSGdK8J"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2122.outbound.protection.outlook.com [40.107.9.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1567E6E;
	Fri,  1 Mar 2024 07:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709276433; cv=fail; b=q6nnEGngQjhU9wNJowitu0KnFWPmC/2I+UNv67T1+qoFhviiomxEuWgSmGUyl0OuVQBfRTvEzkxE+dS4SLTzJlv8CLuxXkygpmOPLZ9IgBhnvJqiGOu/6RjXQzh3iCVl5bqmvcF11s5gWlLemKt981DKGvay2NhRcpcAOtNgfD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709276433; c=relaxed/simple;
	bh=OcqiXlelwOic7toyDMxrk2oHGRG7Ez88CLCAoD5wtPU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0ZsmJhHDgTOaDcI6OZlLWUkmbwvIq2sAEOjXX9GLizkd/gkO6n7rlIxvzUcnKJSJcECg28+rzldgprRtUXFNbQnUAvi/ek0S4hwvg0XU30wa2kkdVnvMUE9kWXQUB5Ulk8QzqElRsLqTbmU1TtkXAnN7B2DTtxvya9trkFFa0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=fWSGdK8J; arc=fail smtp.client-ip=40.107.9.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VCJZgy+tpuCyHJvhR6t/UU5PEF42/vyfZLx6aML827TEWCk/p4+1WYIDa2gMbo7WB5y8AnVlWJrK4Y0PsKJMYebxQfPRfEV6gOa/0eEzypqPKdkHVb5Wf67FyfNMDt42G3ecdcANekHkN5EtN7brm7Z6QaCyN+VEpfAyXjaaM8LihSJlUhmCVVUsA9nGW1Mxz5k+S51wywjCNFzsBY9tgg6c6uwN+Q+UewFECSrFY/QD/K6qkUU62SljEbVf7tPJJKIbmXNDf9/wXVW72qx1LXuha74b95k64y711AP6qOcaYhR3/0EwIqruGB/YThlKNoy3ecELewBLrPIUBeWE9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcqiXlelwOic7toyDMxrk2oHGRG7Ez88CLCAoD5wtPU=;
 b=cm3MsTjbk6iK2P+Q9oUsEPrH8TyYJ/yU0xY68YP6yll4nBZkxkCB4U6a0Lq7mlhBjzI+tKf4Ksj5UCJu4cmLkhSWBSGiPqnobn9m1ucSYGLL0voEvGIWOP8q0RdGuHHMRmlItHim+Hun7V22ISkseYgI8sXWD8lVDO4nd7k4i70pxbQ+GOTd/5EFvre6nqFRrVA80t36ax1vgoRB+q8MRAm88nwpJiW2A+Ag1xOhYrYpeyTNkD18JauaFB35I37sC4Ocw8uyopFR/smI3FjhnMiM6zFE4bLfEkEytIXqzeBP1gh/J1n2J7dOp1mFxkHNG5Ln6XEHM9t9sPRiOLuJxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcqiXlelwOic7toyDMxrk2oHGRG7Ez88CLCAoD5wtPU=;
 b=fWSGdK8JHVPILDzhNKzDkT4O+D6C3/SeARjOB0tckMNZDe0uCjegs4EUtzN5RkD9zIE4DHaa7l3FJlP/pYeyByVogElgDdDZaQ6+FkdBUNWJS4WdI79i7Y+zxAv2VaL/Pstk01PkoUIhJ4t2TRN7Ar/p0/340x+hOTdeHn8brGmTl1VCbDyD0C5bxYkZTzCncgcESQaa7RwY8w6YQ+qvmbUCK61Xpbxhu17b19/Wgt8lDhNg/IfgH/ODYlxaGVM6iYdyP9iW7KbgjMKtgbGIBXrm8c6nsZd0JdWuPJx5l1p6DFsj1Uwz6BE4HviRxjrDL/obNrBRrqFNP9jRJyk2MQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.34; Fri, 1 Mar
 2024 07:00:25 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 07:00:25 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: David Laight <David.Laight@aculab.com>, Palmer Dabbelt
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
 AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CAABKTgIAADGQAgAAIygCAADniAIAADA6AgAAI14CAAHULAIAAPciAgADorwCAAHaTgIAACVsAgAMUKQA=
Date: Fri, 1 Mar 2024 07:00:24 +0000
Message-ID: <3a560f7f-667e-432b-a18f-cc77b453e180@csgroup.eu>
References: <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
 <ZdzPgSCTntY7JD5i@shell.armlinux.org.uk> <ZdzZ5tk459bgUrgz@ghost>
 <ZdzhRntTHApp0doV@shell.armlinux.org.uk>
 <b13b8847977d4cfa99b6a0c9a0fcbbcf@AcuMS.aculab.com> <Zd0b8SDT8hrG/0yW@ghost>
 <cdd09f7a-83b2-41ba-a32c-9886dd79c43e@roeck-us.net>
 <9b4ce664-3ddb-4789-9d5d-8824f9089c48@csgroup.eu>
 <Zd25XWTkDPuIjpF8@shell.armlinux.org.uk> <Zd58jvN3PjQSe+yt@ghost>
 <c0449c0a-33bc-49c4-97e3-56a79a6ce93e@csgroup.eu>
 <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
In-Reply-To: <02bb92c3-a14c-4a77-a3b0-a7c857d1d60d@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3076:EE_
x-ms-office365-filtering-correlation-id: dc96a5a3-d104-4085-9df8-08dc39bd450b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6veEm7nOUw0HyZ7mDl/0eI87PiDzxhnlsdEMVNhK3XTXKfOY0haW031O8cFZv5V9zLr4cipeVX9EyDtKYFq3tM7AyLQQhJ0ePXMLw8V+6yEPGwuJnBOyE9b4reKXCJCzLZesXyUVDIXlk7erRt7sNEkYmkUr0oRRKbeHuOdLHFUOHNEdtMMffxmLvYAjAlvaCsUM9zWRjxruaYe2s2JqleEaWiO3S88vdTWM6smUcf3Qbdpvwsvt9D13iKnomCBxZIiAtoiEF7ukXh8CS5DnXCz/cOemA8AGK8tAzoFoxKWqmUKYsAd/o//SvCgA1SfcFXJl+Tn63ucvsodyQLgm+K9WfV2rocdVYZZzPqFY25jAfZqBTwAr+/Es/njqQJaZT5KbPL9/FJuQhghUmRLH8IwAVJP/cDuMn7Yt9TPBENLe4uMCX6h73rn5vxXCK5qeTwF7j9U0fApdecJWBvBrRrldN8IlQmqxP2s/ZEjexBDtJrIAusbNDd2d5uQqVonFbvENbwT9tCRULrSN1Y0sx96HCZB7AFDlveTGcwWXV2Ad6TX5DHdqP2gbQNLY0DXAdeO9dQeT1NguyCyAAuJvfP77uJEdN9GCpEOE75PIDi6uNEXhLoGfBaKMlS3iewZ4SpwFVvoD7jEFNjFHzwrG3GKmHAt27I7XEpoxJGmOqZkfENy7yidpsHW8TbStgamVIV5ZdA6cvFrW+jbdRAvPtf+N4vU1p6gmn/GwUPYgwTs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cVJRaEEvR1c2N2xiSkJvV0pSaXhHazdHeUFVK1d5aWhmOU11bW1vZkV4dDF2?=
 =?utf-8?B?eEI1UVpYWTdmaWRWSkpybU9sMHdMeGtwMnBwckttZWsrbWNCYnZ5Vm4zY1RP?=
 =?utf-8?B?bWtmYWZXYmxVQ3lrSHZrMFhyeFozc295Z0xJRkdENUFpUGVpL3FLdzhmTCtP?=
 =?utf-8?B?YVRjazUzcGt4WnpnNXMvdW4wVFZ1SjZUS2tIWW9RUlo2OUZRdEU3S3dKL1hE?=
 =?utf-8?B?UWhKY0c2ck1qL2FrZDcxb3FHZjFqNmd5aGZ1UVFVRHpFbUpHZXR1WFFlNkI0?=
 =?utf-8?B?VU9uSGIyTmtOb2tsYlM3TENDS0FwaFhURGExNktZcm1nckdsNUEwMm1wb2JG?=
 =?utf-8?B?Vkdxd3d1SEsyZTNlTDBPTEtjeXg0VnUwWEJRekxBSDVCZjk4M21iVHVUbUZh?=
 =?utf-8?B?d0dFOVBDbU5CWkQ5TUFNSWhsM2J5QWFZRlA5SDNIYWw1Rjl6anhaQUFwSmhw?=
 =?utf-8?B?Z3JOR04yN1ZrOUZtY0JOZDljalFXKyswLzREVzUwU2xUVGpKTE9NU3pvYitO?=
 =?utf-8?B?eGt3eWRqZkRKYUhJNGg2VGxCcjRBV2wzeGVZa2tOT0VhVDZpY2RhYzJaOVF1?=
 =?utf-8?B?NmN3NWVBS01Wb2V2NnRDblNWNUo4SlBCQVZteGZSM1RtamVaaVBmRDUrYWlE?=
 =?utf-8?B?WExTV0xZbkxJT2JTejFyNkZkVFYvdFBRZCtzQlFzM00zdjBUU0VXZEpUUGNB?=
 =?utf-8?B?dDNuZHJ0MXhnTXdwVXNUZlE1dUdKc1FoOFBralMrbjdudmNqdzRCRTNPRmVw?=
 =?utf-8?B?WGozZHVNMStoNktJMnhhZ2svUWtyMFhDVE1GNGlFQVpudUlJa2VyQWZxSmxn?=
 =?utf-8?B?dTNjSDE2eWQ5RHM2VjAvYTBCa2FpMVFiZnNlMjNRUGpQNHNnRURDbU1CbjY5?=
 =?utf-8?B?b25WdFJ4cHdvL0Y3RXIvY3l5NEw5WC92QXFzQU9rRlhFUWtmUGl6NTBOakE0?=
 =?utf-8?B?b3NXdExnakpXcFkwOGtwelFSeStldE15WnRzd0tHL3dhS0JlRnJCZDJ5MG9D?=
 =?utf-8?B?djc5YzQzSnhXWlFNYjRQNzdwNk9Wb213cnNqV3R1Tm5jT1dneWZQVGVJdGEr?=
 =?utf-8?B?dEl2YnZGbWZERU1YdVJpQkxFQlY3NkxabzFCT2FSQk1NK041TjBldFNILzky?=
 =?utf-8?B?SXVINjFnZkMvaXNVTGp5UjUxWXBOVWhuU2xYdnVwM3hqUWJBdVZPTWg3MGNh?=
 =?utf-8?B?VE1KYVNXQ05nQTZ1V2d1MGZ2SE0zK2xya3lGNHNoNUpkM01FL2xSV3JFUlBm?=
 =?utf-8?B?cWNMS2REQTRnWEd1NnhCeFJ3Q0Iydm9QWTc5Mk9TRHV2MFZYTnVSbTRtUktB?=
 =?utf-8?B?S3E4Wlh4Q2x3dVUySE1sSVB4RDNvNHNHTFllOUpwQXk0WHVkazJsTkFZUHVE?=
 =?utf-8?B?Qlg2S3ErKzgvSmpsZ2NHQVFpRG9SRGZnTWxhWDkzRE4rcU5yWFZScmE0czlW?=
 =?utf-8?B?bVhQMnpVT3dMNlF1ZHRpWVRYL3B0RTlYR1VvQ2ZDQ25oQkFqdGh4eGNaVXdh?=
 =?utf-8?B?bnM4bzlhMTJXV0t4TDg3Wlp4bm9iWUJ2SkhheXBhSVh5SEYzSTFsMzVHT3d2?=
 =?utf-8?B?ZEtCTGMyeTl4d2xDb01rVWxNbzRQU3hCU0NBbE5paWZOSHFkUUg0K2xDK0Jx?=
 =?utf-8?B?RklNN3NwbExyYXhNdndtZ0cwSGFtaG1Qcnpsb2hQZ0JqZmgvL3VrZUNwVGlw?=
 =?utf-8?B?RVJSL0g5UER6V1daY20xZG9tUWdZcFhadU1RN0ZkZkZSN3ladHJsNk1PNElO?=
 =?utf-8?B?ais0TXV4Y1oyWHhMSWVBZEFBNUtMdkZ1T3k4Sk9Kelp0OERPTG14d21VVFJK?=
 =?utf-8?B?UmhoU1VYOTQwdHhIcVZOcnkxUjJHN1hYK3hBZVA0dXAzcWYyTFJEN000OGlR?=
 =?utf-8?B?QXpkN0pidTc5MWpURzVFNlA2T2VzMXpxdzByTDh2b0FDZlZpeExCU3lOMmN5?=
 =?utf-8?B?eVhVMUpUdERUam5qYmVJSDlYN0ZPWDJGTy8renhmQ3hQRk1YUlFCS081V2Ru?=
 =?utf-8?B?b2IwUTdnL3RXcWNHMjBYOC9SVlpXK3NDTms2UWpGTEN4NWRGcHQyc1k4a2Ra?=
 =?utf-8?B?YXZQbENRQzg4R3dHWU42L2pTK1BqYUxJakE0VW1ieDZCcXUvNXNxZ1hNT3FV?=
 =?utf-8?B?NUFJT2dNL3h5OHZGY2pWbUtXZ25OM01DQXdiNksvbGVWRnNJREN2b3dPRkxt?=
 =?utf-8?B?T0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <433936FB090E684B8DC89F0164DF4153@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc96a5a3-d104-4085-9df8-08dc39bd450b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 07:00:24.9156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mq1TeLPBX4t1sW6gTKQubFBw//7rrIbhn6ZtyEN/0uLFq1I6f5gwS9BFUP0DCqanPFSsdRDJ7lU1qXzVuoPt6q1xzpBzna7UOFl+RYnOXvg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3076

DQoNCkxlIDI4LzAyLzIwMjQgw6AgMDg6NTksIEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4g
T24gMi8yNy8yNCAyMzoyNSwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4gWyAuLi4gXQ0KPj4+
DQo+Pj4gVGhpcyB0ZXN0IGNhc2UgaXMgc3VwcG9zZWQgdG8gYmUgYXMgdHJ1ZSB0byB0aGUgImdl
bmVyYWwgY2FzZSIgYXMNCj4+PiBwb3NzaWJsZSwgc28gSSBoYXZlIGFsaWduZWQgdGhlIGRhdGEg
YWxvbmcgMTQgKyBORVRfSVBfQUxJR04uIE9uIEFSTQ0KPj4+IHRoaXMgd2lsbCBiZSBhIDE2LWJ5
dGUgYm91bmRhcnkgc2luY2UgTkVUX0lQX0FMSUdOIGlzIDIuIEEgZHJpdmVyIHRoYXQNCj4+PiBk
b2VzIG5vdCBmb2xsb3cgdGhpcyBtYXkgbm90IGJlIGFwcHJvcHJpYXRlbHkgdGVzdGVkIGJ5IHRo
aXMgdGVzdCBjYXNlLA0KPj4+IGJ1dCBhbnlvbmUgaXMgd2VsY29tZSB0byBzdWJtaXQgYWRkaXRp
b25hbCB0ZXN0IGNhc2VzIHRoYXQgYWRkcmVzcyB0aGlzDQo+Pj4gYWRkaXRpb25hbCBhbGlnbm1l
bnQgY29uY2Vybi4NCj4+DQo+PiBCdXQgdGhlbiB0aGlzIHRlc3QgY2FzZSBpcyBiZWNvbWluZyBs
ZXNzIGFuZCBsZXNzIHRydWUgdG8gdGhlICJnZW5lcmFsDQo+PiBjYXNlIiB3aXRoIHRoaXMgcGF0
Y2gsIHdoZXJlYXMgeW91ciBpbml0aWFsIGltcGxlbWVudGF0aW9uIHdhcyBhbG1vc3QNCj4+IHBl
cmZlY3QgYXMgaXQgd2FzIGNvdmVyaW5nIG1vc3QgY2FzZXMsIGEgbG90IG1vcmUgdGhhbiB3aGF0
IHdlIGdldCB3aXRoDQo+PiB0aGF0IHBhdGNoIGFwcGxpZWQuDQo+Pg0KPiBOUCB3aXRoIG1lIGlm
IHRoYXQgaXMgd2hlcmUgcGVvcGxlIHdhbnQgdG8gZ28uIEknbGwgc2ltcGx5IGRpc2FibGUgY2hl
Y2tzdW0NCj4gdGVzdHMgb24gYWxsIGFyY2hpdGVjdHVyZXMgd2hpY2ggZG9uJ3Qgc3VwcG9ydCB1
bmFsaWduZWQgYWNjZXNzZXMgKHNvIGZhcg0KPiBpdCBsb29rcyBsaWtlIHRoYXQgaXMgb25seSBh
cm0gd2l0aCB0aHVtYiBpbnN0cnVjdGlvbnMsIGFuZCBwb3NzaWJseSANCj4gbmlvczIpLg0KPiBJ
IHBlcnNvbmFsbHkgZmluZCB0aGF0IGxlc3MgZGVzaXJhYmxlIGFuZCB3b3VsZCBoYXZlIHByZWZl
cnJlZCBhIHNlY29uZA0KPiBjb25maWd1cmFibGUgc2V0IG9mIHRlc3RzIGZvciB1bmFsaWduZWQg
YWNjZXNzZXMsIGJ1dCBJIGhhdmUgbm8gcHJvYmxlbQ0KPiB3aXRoIGl0Lg0KPiANCg0KQ2FuIHlv
dSB0ZWxsIG1vcmUgYWJvdXQgdGhlIHN5bXB0b21zIHlvdSBlbmNvdW50ZXIgb24gQVJNID8gQWNj
b3JkaW5nIHRvIA0KUnVzc2VsbCAoQVJNIE1haW50YWluZXIpIGl0IHNob3VsZCB3b3JrLCBxdW90
aW5nIGhpbSBiZWxvdzoNCg0KCUhvd2V2ZXIsIHRoYXQgbWF5IG5vdCBhbHdheXMgYmUgdGhlIGNh
c2UgZm9yIGluY29taW5nIHBhY2tldHMsIGFuZCB3aGF0DQoJc2F2ZXMgMzItYml0IEFybSBpcyB0
aGUgYWJpbGl0eSB0byBkbyB1bmFsaWduZWQgbG9hZHMgaW4gbGF0ZXIgcmV2aXNpb25zDQoJb2Yg
dGhlIGFyY2hpdGVjdHVyZSwgb3IgdGhlIGFsaWdubWVudCBmYXVsdCBoYW5kbGVyIChzbG93KSBv
biBvbGRlcg0KCXJldmlzaW9ucy4NCg0KDQpOSU9TMiBkb2Vzbid0IGhhdmUgaGVyIGhvdyBmdW5j
dGlvbnMgYW5kIHJlbGllcyBvbiBDT05GSUdfR0VORVJJQ19DU1VNLiANCldoaWNoIG1lYW5zIHRo
YXQgaXBfZmFzdF9jc3VtKCkgaXMgZnJvbSBsaWIvY2hlY2tzdW0uYyBhbmQgaXMgDQppbXBsZW1l
bnRlZCB1c2luZyBkb19jc3VtKCkgd2hpY2ggaGFuZGxlcyB1bmFsaWduZWQgYWNjZXNzZXMgYnkg
DQpzcGxpdHRpbmcgYWNjZXNzZXMgaW50byBzbWFsbGVyIGFsaWduZWQgYWNjZXNzZXMuDQpUaGVy
ZWZvcmUsIGlwX2Zhc3RfY3N1bSgpIHNob3VsZG4ndCBiZSBhbiBpc3N1ZSBmb3IgTklPUzIuDQoN
ClJlZ2FyZGluZyBjc3VtX2lwdjZfbWFnaWMoKSwgTklPUzIgdXNlcyB0aGUgZnVuY3Rpb24gaW4g
DQpuZXQvaXB2Ni9pcDZfY2hlY2tzdW0uYw0KVGhpcyBmdW5jdGlvbiBkZXJlZmVyZW5jZXMgc2Fk
ZHIgYW5kIGRhZGRyIHdpdGggMzItYml0cyBhY2Nlc3NlczogDQpzYWRkci0+czZfYWRkcjMyWzBd
LCBpcyB0aGF0IGEgcHJvYmxlbSB3aGVuIHNhZGRyIGFuZCBkYWRkciBhcmUgbm90IA0KMzItYml0
cyBhbGlnbmVkID8gRG9lcyBpdCBPb3BzID8NCg0K

