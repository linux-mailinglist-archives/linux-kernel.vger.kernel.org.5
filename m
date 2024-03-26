Return-Path: <linux-kernel+bounces-118516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0367688BBFD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC37C2E4757
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3564133983;
	Tue, 26 Mar 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="RpsBbCIS"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2130.outbound.protection.outlook.com [40.107.113.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4950132C23;
	Tue, 26 Mar 2024 08:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711440533; cv=fail; b=Lnw9voPd8OqCVT3pQntoMJhY97oqWqFdCTLoDq1uJyQXTIkdqZjc1kxgalobRA1CNOFvI3HWwlgWcWtykvOX29fumM/h+nT3eb89b8Jj1PRWKeeesKZfTb5I3Kj15LUJdw/ruMEhTQOVgFRJJKWDdJ/qf5fe7f/LT/W0mubLHH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711440533; c=relaxed/simple;
	bh=jFeaG2X9/hIru0NrxezYmLs5PaTOgKUSybgp0Wu38V0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PpGsTTPGl2QYkDQKcpA/wvlagz07dCO9juThcVDrKPnSX3uUjKai7CF1eFSp1Q8OSa5fVSeoYZ1sxJN3blbfS2lCPVyXsEON0Hq/59eOfK7gKoxAJw19aOFVAh8RMa+R4lUFF8V7ZyYhB60ujWovd5lthtxjRH/iam/6HTVuKGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=RpsBbCIS; arc=fail smtp.client-ip=40.107.113.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GNzB2demXR2UHyUvcuPxxgswRB6tajxWnGUhR7h5XEYTltIIMTdhCE2nYgipXAhrCCO26M/oULC0cJMRY307DdnZPZjvFxk2AUr7LFPrUZxFKm2uh1HyB9zWzDqruvVQIO4/C9uyWQms7OjJzA5QKXw+oG7wGlvSiRMhpdye+O1oiaseedzMf5UU9ANS0nU1DQxJuYqAMMzs5vC3JxYqrFi0iBTuSMzQLjZhsDivmh1U3bFCn0Ae3RxFXudcZkom5UOWzhx3GP1YYLD5njYKz5ZQqKuxQYxacb0tFYNDIGx9pNSiVxLdTN7pLApwaP4NJaG9ctfrZayBEQ/BTTV0wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFeaG2X9/hIru0NrxezYmLs5PaTOgKUSybgp0Wu38V0=;
 b=af9II3IMvtwFiWthPzJ02o8EJQA+6CVFChQz5KB+E03ISt/5d3LLqpCixeGjfKkkfG40OmNoQSQNPYcB+2vZCa4eygCVeLOTjddkvEOd5uC7LOnE3AiN6zap+eacNOyGmmA0xTqW5/NVOVAd16CRuBdMuATa+iE1AWr8bEeOaM/a0UNgr+GwZWbIyL01oxVYof6bcpMFHxVk851pY4ul4A13YtC+rujqsajAxI+lwwTbXc8+D8Hk41ydccrfFhWBPDR5ExwnGKrzoHrr1IFpQEfHqq7iFarJotqsuZek3F57wdjS+HaNXvsPbpWOReV/iiYNEPtQHIIm2A/DYYeA9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFeaG2X9/hIru0NrxezYmLs5PaTOgKUSybgp0Wu38V0=;
 b=RpsBbCISfWDHA0taEOvnGT4A1WP8TdYdjumrjW5SWaVEh7rAM/U8k1kClJDSxZyPSjD696ITwPP9m4ff08XQtjL89JV5dTcMaS2lOlV6U31a1YhNVaXvXzBATaXIAYXPHOl63veWgeq8HZJDGkhKwHOgGrrMNNnweqmn/bNzwHI=
Received: from OSBPR01MB1592.jpnprd01.prod.outlook.com (2603:1096:603:6::18)
 by TYWPR01MB8872.jpnprd01.prod.outlook.com (2603:1096:400:16f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 26 Mar
 2024 08:08:46 +0000
Received: from OSBPR01MB1592.jpnprd01.prod.outlook.com
 ([fe80::b920:d0d0:b0d:af60]) by OSBPR01MB1592.jpnprd01.prod.outlook.com
 ([fe80::b920:d0d0:b0d:af60%5]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 08:08:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Prabhakar <prabhakar.csengg@gmail.com>, Greg Kroah-Hartman
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
Thread-Index: AQHafGepLpCbH9nzEkaXOHWLeIChIbFIp7LwgAEHY4CAAADcMA==
Date: Tue, 26 Mar 2024 08:08:46 +0000
Message-ID:
 <OSBPR01MB15921757B5C4E46A316B560886352@OSBPR01MB1592.jpnprd01.prod.outlook.com>
References: <20240322144355.878930-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20240322144355.878930-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OSAPR01MB15871221D42B6CEAA08168C386362@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXtPPwzgwekKiuNF5MzDvLSOqvBXWgQd4tgPtTnnQp2VQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSBPR01MB1592:EE_|TYWPR01MB8872:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 QfE4EDjGub021u69Kg+wETnkFokRyb3rKmFA+T9xcyKBE4UHy0CKK0IbwixWh+D9jg0CcQSWBGww5xN2x1wpjvLzvWCehoPzVoqRXK85Bqp+4NLDOQL2pANV6AmoY9tAVYy2xQAKYb/Bh4ZU5qt1Ngb2EhFJez/e5d3hQeqUEZ0mi5euCv78cmZF0iNZFVahDGiESLdB7mJwY/ns22h4YEGsu0dnYhdtTNn9PmWlXs/f+Pohj0XVROEM7dj7T/9rIvFI4aTxMAZGOAybVxa8Q2TorvblT+Y5pUV/PWwzAPzIqh8B1wXlwyCguCMt//a7r5JD4XkVMaoN66F8Zv6gRgstbH6K/u/f+Sk3LBuzW/yJAb55UUrh6oMDwDFHvJTKneJSM4O6BLZqtpuUUcdVsWl1QjQZ7nZLq4Z+9J5Rg2QUxnVXBsBRGZKBuxbpN+RVBpEB+hsjIpg/N8ukNFNM7k8cRciSXoiiLX1zUJHo9S0DvapTx3cz/9enh1z5IZFkeMlPm3R8P5lfIJfu6SYmAIp+91WlTqWfcV9j7JZ4i6G7ohO+c/Xaq4CD2t88f3qKQUPh4Cz4Bk0o8MvHgX9F8xxfjAFf0hA2pTPg7dzGAj3srKnmHwMElN6LKTzQ0kbPKMkSfEbqJAMf7KIG1Z0CalQuXNEqqcqnDmLoFp1XtAk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB1592.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NlZoNW5FV3BWdkVqQWk1VGoyWFlyVXpva0tDY2Z4c1BVZ2ZZdzN2eHhyQTBS?=
 =?utf-8?B?T3N4RnpmLzRyV2swLzM1WFZhdjhHQmIxSTBoUWdkRE9VZEkvYWsxSEc5VVNl?=
 =?utf-8?B?RkJJTVJmMTlqcHNMUGQzTUgxTExRRVF2Mjg4M1N6N0dHZmF4ZlhONlBVTnpV?=
 =?utf-8?B?eUtkaldKMlhyMDE2VlEzNkg4VXA3MGczeVFhNmxGL095Vkl0ekswbEcyV1NL?=
 =?utf-8?B?R05yMEZIYWRYOUVxMWJEZGdEcm95OGozOElwT1hKeVhlaGo1Q0ZlMlRGNGJE?=
 =?utf-8?B?OVZ4N3pBampNd0JXY3BxK1VWdnRxL3g0MVZEUGhGb2l0RlhMV0dXLzM4RjNi?=
 =?utf-8?B?NDBSQ0EwZ2JHcExmYmY5eU5tME1tbmdkT1dGMHc4cCtlUjFDRE5VWkZXbzRI?=
 =?utf-8?B?enV2Z1hybVh1VnIrMFhrY1NiWHpWcWJzSEQxa3E0NmNSbHEvd2JTV1ZzNVh6?=
 =?utf-8?B?Q3FlaUZ5TTZvdGg2SEkvWHNrU2JhdHAzaHpBMml3ckEzMk9jeDJIZHphNE9q?=
 =?utf-8?B?QUtBRzlER2pEUXdnOVZqRnBIbDRRc0c3NStnUzNCWHdZVjdLZ01JSzM2SFRj?=
 =?utf-8?B?SFFIbC9QOG5LSkRlMk5aVXdWTDNsM05sMXUxSHFzTDdxRGlCMC9RTy9Ddjk3?=
 =?utf-8?B?cE9wWXRFa1VROGgxOGViU0ErcE5TRnFCRUc3clhuNzRZQ0YrRVgzRmlsYXBO?=
 =?utf-8?B?RVJHVmNYTmg3akJUTUQ3MmJWUm85UXJhL1EzakhlNjVndS9rb2h1UXE2TWxD?=
 =?utf-8?B?aExBS0NFVHpua09CcWpGNk55S0dEMUdwRnpHK2pFb1dhVWQ1dzFvZHgvQ3p2?=
 =?utf-8?B?TFRxOENROUxXSlBFaXRQM1JLZ0w1WXFvZm5OMnU1R2p6OVpuL1VmM0V3SmdJ?=
 =?utf-8?B?NDZEWEE1UmloV1QxL3pGNzN0OStiNmt1NW15c0NYMUh4WkZWajNVNzZ1Wmxt?=
 =?utf-8?B?Um5WaHBZZFM1R1hDSGxHMXpGRm8wMXgxTlVPcmhwWEw5dDhlbEpEdXZmRE1u?=
 =?utf-8?B?S01TY1JhbDJyN0sxMm4wVVJrVXh2SGdUZ1B1VVh4RnppL1BSQ0FtSGNadXpY?=
 =?utf-8?B?Vks3cHVvd0pOeWRtcXVSTjhja0tTNE9zQjFZeEd6Vk45TlpwVTl3UnllSFpZ?=
 =?utf-8?B?MkNybCtMYVlrcDJXMkFYSFg0dk40QUFWZkxnbC9FWHdBRm94cW9kd0NFM01B?=
 =?utf-8?B?QWFRa1A2MkovaXlXQitkUTZpZjQ4OEU1YU9TWCtrcmU5VmwrTzdHcG51bWto?=
 =?utf-8?B?V0ttdDFUV1Z5SDRCaDhWMklRNGprczZhbmc1REN4SnRoZUJ2akNHRDFMQnRw?=
 =?utf-8?B?SEQxdEpHbDcwZXNGbWJUaC9YL2FSaDVDK1QyUEtxUVRQTlpEUnp3SlR3S29M?=
 =?utf-8?B?cmF1SENrR2gvN08xL282bzBXV21FN0FsQXFHdkV1alJhcUd6YjJzWEhrN0RR?=
 =?utf-8?B?VDIvTWlOVlpkbjJuSFRQNE03UGNlSEdEZEJPRnZIUUpqYnE1V0pNZEJFRDZ6?=
 =?utf-8?B?ZEc0ZytReDJub0xWYnY2SlRndUVzekVVWDRkcFhoQ0ZSczZEMTFPQTJlNzcy?=
 =?utf-8?B?QjA1WmQ2VkhQbXZ6K3QvVytlZ3J0czR5dFdxcFo0VTFXZy9jSkpqeGNJSEtw?=
 =?utf-8?B?ejJjUktXWkJQY1ptYzJWeUM4WWlJMnF2WmxVUFRnaE96ZUY3ZjVjQUdBZVN2?=
 =?utf-8?B?MHRkYzJRL0ZsUjlpNWxkeUlzRGJpMzNlWVZOLzQzMDJmbkFZYnBNSDZoZXdx?=
 =?utf-8?B?a0x4c0FyRWZwY0dGbUZBU2trL1grMXVkTWtzZkJ5cmJyRjRlOWxPNVdSUDly?=
 =?utf-8?B?NGRqMldQeFRaSVdLcm42Tkt2VXpKajM4MVN3M2hSOUkzb09YYmFtTVVTVFRM?=
 =?utf-8?B?L2RwTGZ3QjRkU1U1bHUvRU9sYkxOM0NXUlNBUmk1eEdtd3RyTEpGUjkvOWRs?=
 =?utf-8?B?dkdvQ25Ldjl0eWthKzNod2hRcFpQbVhXa3BKbzN5K2dVaWJOMkVVWXMvVkFz?=
 =?utf-8?B?enVhclRaV3A5NmdzK1ZpSHZpOVNLM2NoNE1mbVJIYklXMnJmc2NPeDFHeUJE?=
 =?utf-8?B?ZlFmYjUrRldKeEFRLzVZcWVSa2hIYWtxTktLZHRGeHpXS0hRUnZ2WnFWODB1?=
 =?utf-8?B?TTY2YnpXRUgxTFljL1Q0Ym5BR0pwUS94bkFnc2pjSGZTUStkYmZLTkhVWlhU?=
 =?utf-8?B?V0E9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 20fa24f7-99fb-4736-0cc4-08dc4d6bf63c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 08:08:46.7640
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MEIUdW4USEnJ41Z2ugT9LKnqcI0ul6r5nmh+08UAaRXS1in4tHr4+dN6k/MKDLEFAQzuu2a9tJ/YlOPrtMPwhjhgKVbnt1tCkm/uK68h0po=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB8872

DQpIaSBHZWVydCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHZWVy
dCBVeXR0ZXJob2V2ZW4gPGdlZXJ0QGxpbnV4LW02OGsub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBN
YXJjaCAyNiwgMjAyNCA4OjAyIEFNDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMi81XSBkdC1i
aW5kaW5nczogc2VyaWFsOiByZW5lc2FzLHNjaWY6IFZhbGlkYXRlICdpbnRlcnJ1cHRzJyBhbmQN
Cj4gJ2ludGVycnVwdC1uYW1lcycNCj4gDQo+IEhpIEJpanUsDQo+IA0KPiBPbiBNb24sIE1hciAy
NSwgMjAyNCBhdCA1OjIx4oCvUE0gQmlqdSBEYXMgPGJpanUuZGFzLmp6QGJwLnJlbmVzYXMuY29t
PiB3cm90ZToNCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBQ
cmFiaGFrYXIgPHByYWJoYWthci5jc2VuZ2dAZ21haWwuY29tPg0KPiA+ID4gU2VudDogRnJpZGF5
LCBNYXJjaCAyMiwgMjAyNCAyOjQ0IFBNDQo+ID4gPiBTdWJqZWN0OiBbUEFUQ0ggdjQgMi81XSBk
dC1iaW5kaW5nczogc2VyaWFsOiByZW5lc2FzLHNjaWY6IFZhbGlkYXRlDQo+ID4gPiAnaW50ZXJy
dXB0cycgYW5kICdpbnRlcnJ1cHQtIG5hbWVzJw0KPiA+ID4NCj4gPiA+IEZyb206IExhZCBQcmFi
aGFrYXIgPHByYWJoYWthci5tYWhhZGV2LWxhZC5yakBicC5yZW5lc2FzLmNvbT4NCj4gPiA+DQo+
ID4gPiBUaGlzIGNvbW1pdCBhZGRzIHN1cHBvcnQgdG8gdmFsaWRhdGUgdGhlICdpbnRlcnJ1cHRz
JyBhbmQgJ2ludGVycnVwdC1uYW1lcycNCj4gPiA+IHByb3BlcnRpZXMgZm9yIGV2ZXJ5IHN1cHBv
cnRlZCBTb0MuIFRoaXMgZW5zdXJlcyBwcm9wZXIgaGFuZGxpbmcgYW5kDQo+ID4gPiBjb25maWd1
cmF0aW9uIG9mIGludGVycnVwdC0gcmVsYXRlZCBwcm9wZXJ0aWVzIGFjcm9zcyBzdXBwb3J0ZWQg
cGxhdGZvcm1zLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IExhZCBQcmFiaGFrYXINCj4g
PiA+IDxwcmFiaGFrYXIubWFoYWRldi1sYWQucmpAYnAucmVuZXNhcy5jb20+DQo+ID4gPiBSZXZp
ZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5iZT4NCj4g
PiA+IC0tLQ0KPiA+ID4gdjMtPnY0DQo+ID4gPiAtIFJldmVydGVkIGJhY2sgdG8gdjIgdmVyc2lv
biBvZiB0aGUgcGF0Y2guDQo+ID4gPiAtIFVzZWQgc3VnZ2VzdGlvbiBmcm9tIEtyenlzenRvZiBm
b3IgaW50ZXJydXB0cw0KPiA+ID4gLSBSZXN0b3JlZCBSQiB0YWcgZnJvbSBHZWVydA0KPiA+ID4N
Cj4gPiA+IHYyLT52Mw0KPiA+ID4gLSBMaXN0ZWQgaW50ZXJydXB0cyBhbmQgaW50ZXJydXB0LW5h
bWVzIGZvciBldmVyeSBTb0MgaW4gaWYgY2hlY2sNCj4gPiA+IC0tLQ0KPiA+ID4gIC4uLi9iaW5k
aW5ncy9zZXJpYWwvcmVuZXNhcyxzY2lmLnlhbWwgICAgICAgICB8IDczICsrKysrKysrKysrKysr
LS0tLS0NCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTUgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL3JlbmVzYXMsc2NpZi55YW1sDQo+ID4gPiBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvcmVuZXNhcyxzY2lmLnlhbWwNCj4g
PiA+IGluZGV4IGFmNzJjMzQyMDQ1My4uZWIyYWE1ZTc1ZTAyIDEwMDY0NA0KPiA+ID4gLS0tIGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9yZW5lc2FzLHNjaWYueWFt
bA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NlcmlhbC9y
ZW5lc2FzLHNjaWYueWFtbA0KPiA+ID4gQEAgLTg2LDExICs4Niw2IEBAIHByb3BlcnRpZXM6DQo+
ID4gPiAgICAgIG9uZU9mOg0KPiA+ID4gICAgICAgIC0gaXRlbXM6DQo+ID4gPiAgICAgICAgICAg
IC0gZGVzY3JpcHRpb246IEEgY29tYmluZWQgaW50ZXJydXB0DQo+ID4gPiAtICAgICAgLSBpdGVt
czoNCj4gPiA+IC0gICAgICAgICAgLSBkZXNjcmlwdGlvbjogRXJyb3IgaW50ZXJydXB0DQo+ID4g
PiAtICAgICAgICAgIC0gZGVzY3JpcHRpb246IFJlY2VpdmUgYnVmZmVyIGZ1bGwgaW50ZXJydXB0
DQo+ID4gPiAtICAgICAgICAgIC0gZGVzY3JpcHRpb246IFRyYW5zbWl0IGJ1ZmZlciBlbXB0eSBp
bnRlcnJ1cHQNCj4gPiA+IC0gICAgICAgICAgLSBkZXNjcmlwdGlvbjogQnJlYWsgaW50ZXJydXB0
DQo+ID4gPiAgICAgICAgLSBpdGVtczoNCj4gPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjog
RXJyb3IgaW50ZXJydXB0DQo+ID4gPiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IFJlY2VpdmUg
YnVmZmVyIGZ1bGwgaW50ZXJydXB0IEBAIC05OCwyMSArOTMsMTcgQEAgcHJvcGVydGllczoNCj4g
PiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjogQnJlYWsgaW50ZXJydXB0DQo+ID4gPiAgICAg
ICAgICAgIC0gZGVzY3JpcHRpb246IERhdGEgUmVhZHkgaW50ZXJydXB0DQo+ID4gPiAgICAgICAg
ICAgIC0gZGVzY3JpcHRpb246IFRyYW5zbWl0IEVuZCBpbnRlcnJ1cHQNCj4gPiA+ICsgICAgICAg
IG1pbkl0ZW1zOiA0DQo+ID4NCj4gPiBJIHRoaW5rIGhlcmUgbWluSXRlbXMgaXMgMSBhcyBpdCBp
cyBlaXRoZXIgMSBvciA0IG9yIDYNCj4gDQo+IFRoZSBzaW5nbGUgaW50ZXJydXB0IGlzIGhhbmRs
ZWQgYnkgdGhlIGZpcnN0IGNhc2UgaW4gdGhlIG9uZU9mICh3aGljaCBjYW4gcHJvYmFibHkgYmUg
c2ltcGxpZmllZCBieQ0KPiBkcm9wcGluZyB0aGUgIml0ZW1zIj8pLg0KDQpHb29kIHBvaW50LCBp
dCBpcyBub3QgaXRlbXMsIHNvIGl0IGNhbiBiZSBkcm9wcGVkLg0KDQpDaGVlcnMsDQpCaWp1DQo=

