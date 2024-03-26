Return-Path: <linux-kernel+bounces-118568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 249DD88BCB8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 489E41C2D890
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DEE91CD1B;
	Tue, 26 Mar 2024 08:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Wyro2xNW"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2093.outbound.protection.outlook.com [40.107.114.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212218641;
	Tue, 26 Mar 2024 08:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442799; cv=fail; b=t8MF4OzkXwgcRTUD0oFJpjd306AV2A1sHrjIn9Kz2xj792FgEHn1/JCebn3nO1ShsTl7Wi0Rygei5nchQghrBA1RUzEbcwNQ5YOyN+WSADfCCGnNXVgGRsATajA8RQtcZ2JX9PqNRcP5evhKXitHquI8FeCYT7yXTbHcce/al/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442799; c=relaxed/simple;
	bh=yFKkm2U23LxfGw4navWaLV7k40sA5Bc1qzvuj9ehaVc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FOYK/bFLaBYOFLIs4UYoCgdTNi/k7sUD1svWFFK5OErhDVaGm3gr3WlWFYr5IVQ9+SQAvQUsfikiuAemiJEHqw6XF7xJjXRV3l1bYemmk3pPJIx64IJWjXuSbn5tdnX8/1WyfuPZ51CKXYAEWdT9FbCeoJpO9MWxCyCyZDZ3pHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Wyro2xNW; arc=fail smtp.client-ip=40.107.114.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h1pBGOsDjC8NhrqZUlBN9vp3Kr6HwdZTV/k2bUZG6pFuwABo2L1lkxXh+UoMnrToJxtXLh2Jel4s+Lu/SGFNChrBdrf9BIelo0+h2Zc5Do/JCPf/dQhu963gnG7W+LWyS/qinchJG4wHRzYj1T+6j944pT0aKotBonOKTJZjTdhLXZ565LLyYcLUKEHs4sIagAbZizr3saaj1BTRrh9YYi3c+A4pMrdy8WMsKHq1YVFYw/Y7JTf22fF1U/vXb0GOt7KZHEIDRa+l+8333GhEOy9ySWSc0BswPThYbvj8S3OPaE7WphAiHaCmD/26xAFjoFxoZ/nVF1VdBnjQsHnDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFKkm2U23LxfGw4navWaLV7k40sA5Bc1qzvuj9ehaVc=;
 b=cyY67waQYAwgG//cTLUR3iVZ7i31YrEU+m+YDtC2W4swBGQjfcOuzl4hQZp1jlFiDG3iB0DGwSicG+cCRSiMY4Wa6J92XTuu/QhyrvzShARtOkp3hu1bx5qm21tXqIIArgLB5JNjxt7FFfMWU6ZeZLy44uWc0f7re7VshnbAo2m/qO8ytOFKGCMaA28sqaOJbMTmMf3qSMeqWE5M1oKuCSbPv0brXQKpbGk2WQ3dZAddyGR/YNBYsi9mURyjisQz2CIME871YKCubx0SGjw/R20l2leCaA6XgrEOPEKWP0cw4eSxSkREVN0rBVzL9iVtYNcTorkX7JqYrONWjZduiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFKkm2U23LxfGw4navWaLV7k40sA5Bc1qzvuj9ehaVc=;
 b=Wyro2xNW/6n2JhvNSzvvz/w9T1W9GcnYgnS7WuyznROAUcW6GZStbx4yxuwuGEwm+HBFO5DRgy+obXQzU9WX5Q4lFfAFJkKezosEVq+7EAYrrX60wAiJq6qjo7BI8viTC3/oA89J1tEblKoGSNO65mpJ+8/miRk1ZyMrSaXWuV4=
Received: from OSBPR01MB1592.jpnprd01.prod.outlook.com (2603:1096:603:6::18)
 by TYCPR01MB7163.jpnprd01.prod.outlook.com (2603:1096:400:f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 08:46:32 +0000
Received: from OSBPR01MB1592.jpnprd01.prod.outlook.com
 ([fe80::b920:d0d0:b0d:af60]) by OSBPR01MB1592.jpnprd01.prod.outlook.com
 ([fe80::b920:d0d0:b0d:af60%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:46:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
CC: Geert Uytterhoeven <geert+renesas@glider.be>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org"
	<linux-serial@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, Fabrizio Castro
	<fabrizio.castro.jz@renesas.com>, Prabhakar Mahadev Lad
	<prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: RE: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Thread-Topic: [PATCH v4 2/5] dt-bindings: serial: renesas,scif: Validate
 'interrupts' and 'interrupt-names'
Thread-Index: AQHafGepLpCbH9nzEkaXOHWLeIChIbFIp7LwgAEO0QCAAAQjYA==
Date: Tue, 26 Mar 2024 08:46:32 +0000
Message-ID:
 <OSBPR01MB15924978EADEACA98A17FE1286352@OSBPR01MB1592.jpnprd01.prod.outlook.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CA+V-a8sL9+ZCdWtqrFn9KF4f+jXJ5BBSqOkSCfAAe-LSLJxF0A@mail.gmail.com>
In-Reply-To:
 <CA+V-a8sL9+ZCdWtqrFn9KF4f+jXJ5BBSqOkSCfAAe-LSLJxF0A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1592:EE_|TYCPR01MB7163:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GIYFUGbxm81Q1jmf3Nrk/cDrhB4DwYRHtHsmIrBgVOI5rkiuR1RY45wvpiyeS8z/DOl80Mk4R2u6WM7q4ise+ydrO7XKGSwGAoRy+8Evx8DSUWY3G4clNzcLFNkFqw+mhGtm+yRsZZ4kFvVE5dmUmFEAsqK90BSfuxnIdw6lP4uRgzD/dkWLrB7BYscTOP5JGyBsFH/2NS2tiPikYO3ul/GtXOq0SgnPEJm/QRPsJ3p5sZzSR/Ie3ZoPCVRv8exDHxfLNq5wyKmFUEBykbnXf5evnmOqptC+4Qz5fNLgzbtJMQQwxFaYo+0eo6TEa9H4NNmUyMnXFSfGLIoRHWebVR17qOpvXX6QtA6ciSaDkDUhNfxZMFd9BRSKaiY3FYdogs/VFXobjC6yOE8FOBxdemDQLUHLs0dQ4P1a1sC8WZ7XbBkUgajEwcisUPeDgiyTzlJXA8eZ+VAJWa9XwPyYf/3+XlPVxd+22wCEpJWdWqU2tYx//mb8twTtgDzUfSQtutatJrYxM2jlwQ+0lUEzfAka26LiOMChrQpLEymGXKitcWAsox4VnSXByMoRuvpQH/iKSIlzd709ZWy5dARA+8mG9SyZRp3aYUJBgHyaazphkmN5yftHOchYaFtjfDuJv5RX5Mp5tm1rfDiKvREoU/yhs58l5YpF4+pvkdNMSsI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1592.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TzVUVG02UmZPYlBZWXVDekxvYmtqWUJkV0pMQXF6RGQxaFJQK1JHaDRhRy81?=
 =?utf-8?B?SExaaDJKVjlaaStIdmNIdTFrZmJTSUZUbFRoRTQ0c1dYc2tKYXBEcCt6TXJ3?=
 =?utf-8?B?bjk1ajdhU3BuSDBvc1VwVEFGZzdMdHovT21KbGVMaXVlTVZLQmtFUHUvU2sw?=
 =?utf-8?B?eDhJaTFVK1ZPQ0tPb3g3c21LRHdNbHlmamNkTjJLblFaMHRhL2lOcDYxcm5I?=
 =?utf-8?B?VWZ1NzRLUEd0Q3NlUGRackdMdWptcy9sbXpZOW5YZURZcTZ6dEMwV1ZCa0NC?=
 =?utf-8?B?eXlCWCtGMUc3M2ppRzRTMFF0UEMzMjJHNm1yOGhCeG8yQUc3TG12SnBqdFJt?=
 =?utf-8?B?dWhHSUVYWFRmYk1sLzBtTW4rTE55WVVkN25Xa09nbVFjNUhodHVsUUNtUzN3?=
 =?utf-8?B?WVdVeUlwbHZqNkZ5ZUxvV3hheW9NRHZaZlZaM2tkNzhNNk1UUk5FMkdmOHlT?=
 =?utf-8?B?Z0lFam9jUDErUE5KenFRRFVMOTVXWm5JRkM5c2tZU29YbzNTZmZlWElsMzgv?=
 =?utf-8?B?bEsxRjZkUEVxT3VYSjlqLzhJV1VFUXNkNS9tTCtidk5vajd3Q1A0bWcvN2pC?=
 =?utf-8?B?VUhFa0dBdUwva2dPRHptQTJqZG5yTmZxeEJYTlRBQ1VGNHdrZzZWZGY3RzhP?=
 =?utf-8?B?SzJsRWE0Zzc1N3VaRUI0QXlsM1FBb2hkaG9WbEp5WHJQK1Q1eE5VeHFseVla?=
 =?utf-8?B?TUVSWHdsNzhUMGdBR0gvdTVKaHBOU2lYK3I1SUVHVi9OYkdHd3FBbmxibzFF?=
 =?utf-8?B?ZFFuWFZPd0tESjJVODMwRytUeU1vZm1CaFB1RDlzTmY3dTlpZDNMcHVJc3lk?=
 =?utf-8?B?U1NQQXM1Q0w5blFjaGlQak96emdMRVV1UTh6OFdqckllQisydkxOd2NxSHRF?=
 =?utf-8?B?MTRZUTBnemNzSDFmdysySjZhVkFWaHNUeWR2di9wWmNFeHdDV3hOZE54QTNZ?=
 =?utf-8?B?NGNnQ0Ftb1J2QWFhT28zeG9GUm9yVWFYeVQ1USs1NFNrYXlMKzUxbnB2S3hw?=
 =?utf-8?B?QVhmMytCdWNsMGJpYlJIdjBrb3Z5d3h1WUxOdjcxZnBab3Zzemk1ak5BU0cv?=
 =?utf-8?B?ZTdIQktFeHRWM0h5emVZMk1VNDQzYXlNUVZqQnoyQlFQbFdob2dFUUJlckNu?=
 =?utf-8?B?TWp4TlhvZkRKTk1zdXpDWmN1NDRKZVVLVXNDYmJDV2d4WjQ0WUtBbmVxOXlw?=
 =?utf-8?B?akF0MHNPQUFpaUY4V2pEeEloWDgyT2VOZUo4TVlEL0lpSEJUa2ZNVFJPUFZT?=
 =?utf-8?B?Wjc1cCtuempIbUFyajc4ZVF2Ync5aSszdlorVnBmTjJid2RxNUFSdHpUVWFE?=
 =?utf-8?B?bENoVWZ2SlVLWlF5ODhwdDJyUVVQa0tFUlpYRkhCblpMVnJMdk8rcWpBTmFF?=
 =?utf-8?B?S3VJSC9OOE13YU5vSmpQSGQ0T1JydUhiRDk4UUUyOFBDY3l5Qm9SQ05MZE91?=
 =?utf-8?B?V2l0YXRsWlhoOWNQQ1JBZVF5R25ranVkZzB6R09RQnFVM3FXWG5LN2pZbzF0?=
 =?utf-8?B?SXpFTzlzVnJiQnRMV09EaHNmYkRNcmVoTmpaSzUrOWdlVDkzeHNxUjJSVGlO?=
 =?utf-8?B?OWlEaC9SdkQxejlDUjBWanI2TVRHSmFvcVFwc2JIQUh3TDlycU01S1Y5cW9H?=
 =?utf-8?B?V0xIVGIvUWpZYUZva2F4bVV5RnhNQWxqMXZYRVlZbzF4RWdoRzA2dmtiN3Za?=
 =?utf-8?B?bTZjdmJhSFhzREY5c1RpNGRHeWswNkdVRkhhWEc1c2VreEYxcGd6Q21ONVVG?=
 =?utf-8?B?ZzgyQVlKOHg0TVVxVEhaSFppR0lBZUszbWdpSXRDbmZmeGZ2ckkwQXByTWJs?=
 =?utf-8?B?MkZreHJyRGtOd0ZXUDJFQW1xbXlnclg0SE5jSXNuWmhJZFdudEdXR3I2c1pR?=
 =?utf-8?B?ZTEwdmFPUFBSQkpjbWUvelBEOVp6M1R5a2hvejJ2WXFGSDV1WW9zNXNSMm9k?=
 =?utf-8?B?YWl5VmFVMWFIdFhieHl2d2Q1OU54bWI2R01ZMlh6TnpKV0xJajdKOEpvUjdS?=
 =?utf-8?B?REYzV1BCdGtNTzlpanNPU2tQUVNMV1ZGcmNJekdUdkkrSDFYQVRjc0trcnZk?=
 =?utf-8?B?SGZENWE4UWtPM0pTcXV0THhmMXB0V1ZiYW10SW5GMW5HUHBCVHlSbERxTkpo?=
 =?utf-8?B?YlVqZUZKang1VjlEU250c3FPWGtHWldnemF6eHkwQmtCaVJ0VVVzY2p3SVI5?=
 =?utf-8?B?cWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB1592.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6f61ed-cc81-4ef8-d816-08dc4d713cb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 08:46:32.4435
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8WSho4oGvV6borRPBcmyaa29+2TBsZSQppcld55fa7NAuRKWyzqpkY6COq1rkUcjZFBkIA2joZJpgcrvBKwq6/d1/UUWJ8ritu7tqkLqm40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7163

SGkgUHJhYmhha2FyLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExh
ZCwgUHJhYmhha2FyIDxwcmFiaGFrYXIuY3NlbmdnQGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2Rh
eSwgTWFyY2ggMjYsIDIwMjQgODoyOSBBTQ0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY0IDIvNV0g
ZHQtYmluZGluZ3M6IHNlcmlhbDogcmVuZXNhcyxzY2lmOiBWYWxpZGF0ZSAnaW50ZXJydXB0cycg
YW5kDQo+ICdpbnRlcnJ1cHQtbmFtZXMnDQo+IA0KPiBIaSBCaWp1LA0KPiANCj4gT24gTW9uLCBN
YXIgMjUsIDIwMjQgYXQgNDoyMeKAr1BNIEJpanUgRGFzIDxiaWp1LmRhcy5qekBicC5yZW5lc2Fz
LmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBIaSBQcmFiaGFrYXIsDQo+ID4NCj4gPiA+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQcmFiaGFrYXIgPHByYWJoYWthci5jc2Vu
Z2dAZ21haWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5LCBNYXJjaCAyMiwgMjAyNCAyOjQ0IFBN
DQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMi81XSBkdC1iaW5kaW5nczogc2VyaWFsOiByZW5l
c2FzLHNjaWY6IFZhbGlkYXRlDQo+ID4gPiAnaW50ZXJydXB0cycgYW5kICdpbnRlcnJ1cHQtIG5h
bWVzJw0KPiA+ID4NCj4gPiA+IEZyb206IExhZCBQcmFiaGFrYXIgPHByYWJoYWthci5tYWhhZGV2
LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGlzIGNvbW1pdCBhZGRzIHN1
cHBvcnQgdG8gdmFsaWRhdGUgdGhlICdpbnRlcnJ1cHRzJyBhbmQgJ2ludGVycnVwdC1uYW1lcycN
Cj4gPiA+IHByb3BlcnRpZXMgZm9yIGV2ZXJ5IHN1cHBvcnRlZCBTb0MuIFRoaXMgZW5zdXJlcyBw
cm9wZXIgaGFuZGxpbmcgYW5kDQo+ID4gPiBjb25maWd1cmF0aW9uIG9mIGludGVycnVwdC0gcmVs
YXRlZCBwcm9wZXJ0aWVzIGFjcm9zcyBzdXBwb3J0ZWQgcGxhdGZvcm1zLg0KPiA+ID4NCj4gPiA+
IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXINCj4gPiA+IDxwcmFiaGFrYXIubWFoYWRldi1s
YWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9l
dmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4gPiA+IC0tLQ0KPiA+ID4gdjMtPnY0DQo+
ID4gPiAtIFJldmVydGVkIGJhY2sgdG8gdjIgdmVyc2lvbiBvZiB0aGUgcGF0Y2guDQo+ID4gPiAt
IFVzZWQgc3VnZ2VzdGlvbiBmcm9tIEtyenlzenRvZiBmb3IgaW50ZXJydXB0cw0KPiA+ID4gLSBS
ZXN0b3JlZCBSQiB0YWcgZnJvbSBHZWVydA0KPiA+ID4NCj4gPiA+IHYyLT52Mw0KPiA+ID4gLSBM
aXN0ZWQgaW50ZXJydXB0cyBhbmQgaW50ZXJydXB0LW5hbWVzIGZvciBldmVyeSBTb0MgaW4gaWYg
Y2hlY2sNCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5kaW5ncy9zZXJpYWwvcmVuZXNhcyxzY2lm
LnlhbWwgICAgICAgICB8IDczICsrKysrKysrKysrKysrLS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hh
bmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pDQo+ID4gPg0KPiA+ID4gZGlm
ZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc2VyaWFs
L3JlbmVzYXMsc2NpZi55YW1sDQo+ID4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9zZXJpYWwvcmVuZXNhcyxzY2lmLnlhbWwNCj4gPiA+IGluZGV4IGFmNzJjMzQyMDQ1My4u
ZWIyYWE1ZTc1ZTAyIDEwMDY0NA0KPiA+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NlcmlhbC9yZW5lc2FzLHNjaWYueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZW5lc2FzLHNjaWYueWFtbA0KPiA+ID4g
QEAgLTg2LDExICs4Niw2IEBAIHByb3BlcnRpZXM6DQo+ID4gPiAgICAgIG9uZU9mOg0KPiA+ID4g
ICAgICAgIC0gaXRlbXM6DQo+ID4gPiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IEEgY29tYmlu
ZWQgaW50ZXJydXB0DQo+ID4gPiAtICAgICAgLSBpdGVtczoNCj4gPiA+IC0gICAgICAgICAgLSBk
ZXNjcmlwdGlvbjogRXJyb3IgaW50ZXJydXB0DQo+ID4gPiAtICAgICAgICAgIC0gZGVzY3JpcHRp
b246IFJlY2VpdmUgYnVmZmVyIGZ1bGwgaW50ZXJydXB0DQo+ID4gPiAtICAgICAgICAgIC0gZGVz
Y3JpcHRpb246IFRyYW5zbWl0IGJ1ZmZlciBlbXB0eSBpbnRlcnJ1cHQNCj4gPiA+IC0gICAgICAg
ICAgLSBkZXNjcmlwdGlvbjogQnJlYWsgaW50ZXJydXB0DQo+ID4gPiAgICAgICAgLSBpdGVtczoN
Cj4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogRXJyb3IgaW50ZXJydXB0DQo+ID4gPiAg
ICAgICAgICAgIC0gZGVzY3JpcHRpb246IFJlY2VpdmUgYnVmZmVyIGZ1bGwgaW50ZXJydXB0IEBA
IC05OCwyMSArOTMsMTcgQEAgcHJvcGVydGllczoNCj4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlw
dGlvbjogQnJlYWsgaW50ZXJydXB0DQo+ID4gPiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IERh
dGEgUmVhZHkgaW50ZXJydXB0DQo+ID4gPiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFRyYW5z
bWl0IEVuZCBpbnRlcnJ1cHQNCj4gPiA+ICsgICAgICAgIG1pbkl0ZW1zOiA0DQo+ID4NCj4gPiBJ
IHRoaW5rIGhlcmUgbWluSXRlbXMgaXMgMSBhcyBpdCBpcyBlaXRoZXIgMSBvciA0IG9yIDYNCj4g
Pg0KPiBtaW5JdGVtcyAxIGNhc2UgaXMgYWxyZWFkeSBoYW5kbGVkIGFib3ZlLg0KDQpJSUMsIEFz
IHBlciB0aGUgYWJvdmUgb25lT2YgbGlzdCwgaXRlbXN7MSwgNCwgNn0gZm9yIG1pbkl0ZW1zIGlz
IDEuDQoNCkNoZWVycywNCkJpanUNCg==

