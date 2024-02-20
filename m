Return-Path: <linux-kernel+bounces-73091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2F85BD71
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4A211C22D69
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE586A355;
	Tue, 20 Feb 2024 13:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="pGmpyXOe"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2121.outbound.protection.outlook.com [40.107.22.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5704C60;
	Tue, 20 Feb 2024 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436582; cv=fail; b=uxtq/hEhgEA8rq3jzfiIlzf0UCRrJc4PePf08UVcpU0WcZ7W6f+S/wVUEuBlsGi6CL3bg5XKH+bvNnzOgZzHamwCvPRkXi1OrSTawbo94sN3lPodpET0a2AapWpc63Z1U5C/XsITXPLpYYKWbH8cVULMR+4APSyCZgbfq8IzZEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436582; c=relaxed/simple;
	bh=wbmaR5kikYHOScgTWcZb+KMTieFGGDacDh7kaxU322w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uVphTeXLCyPe9AGtmA6J6ss5SEvKEjLe5HCIyD/hJIEMXX9ruUcB0+gtDlQoAxSwR9+sw0ANPtGWyHjAgB2UobalQI/JC1921/FFrkhVZrprTrxqssJ2xfeaGwxWd0JIYFdBCZQg07/38nRPAoCPVg3SYjJrXoI2xyC8QnQ0LBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=pGmpyXOe; arc=fail smtp.client-ip=40.107.22.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcbP2/RmIGoD0Hfxk6MR64HjhdngJHpFZKf9vI3OGtKU6RRFrR7nl3szWkRVKi1RBaVpfGGLNCmSRdmaDVEq1yaIZgX9bIRTf4DHpJEN2yFkVHpRLwNxrfvHn7YXAkyfkbZHoEf4f9oZiNzHnO86s03OeHQ6KZOkU2MYzNYSH9G0kf7C8TZ/Mn0PDrl3RInjKamV6r2iRlYyYOtVIhmNt4em24EgLgdre9z9P8dIDk70Vqps7IvMqvo0R7KFY7msBxKWSFZUVZBDC2VQVuW2E27yKFmOn+kaXHOX7REpcPisVqyg4WkS6TZBzcb+aE5XBW09e9XSX2PCmdU1oXMdXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wbmaR5kikYHOScgTWcZb+KMTieFGGDacDh7kaxU322w=;
 b=Hi/93UFo7sKw6ivN4yracNPaXZA7b9GID+EDPMysR/jovsSJtTZ+9MV0IFZhF1ynvVYy7SMXl4mAbTLke6aTYpvrGlqoMLc0ZUwDHKAy73zfUcxrEW5sljVEcOa69P8FgB1MtV1clIDvXj5NzHbE3ja7bUJKBgJB7B6etnKA0BU3KDL739V789AkOAoTbCBpf7JQp6SbOGmipsaaZ8MtTKaipeUzuw1zvpcaKKV5x0A+paJ7yAd0I2/sloPiZa+ct4iakhVzvk10sI7UDlDCzLkNVvPwLNj+fr/h/FW2hap58fm/B+ukFJkfl8clm139VvBjS+8jsMUNGoRG5GGK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbmaR5kikYHOScgTWcZb+KMTieFGGDacDh7kaxU322w=;
 b=pGmpyXOewhmOBC64X8FmKdWHtbotRZ7RFR8IMr682iL1bWurUh0GNV2zI4erJvm6OoFgLPlK7ckeQBTM7gk6obxBFTRUKj+47XymhB0kCXf2qjdvQn4SmoOhLFJeqs7Fga0oilcamiuUoEmbKuxiLHoxLBG7cfcNotdVtr/4NS8=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by AS2PR03MB9611.eurprd03.prod.outlook.com (2603:10a6:20b:595::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Tue, 20 Feb
 2024 13:42:56 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 13:42:56 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Topic: [PATCH net-next v4 3/3] net: dsa: realtek: support reset
 controller
Thread-Index: AQHaY42tH0aJAWy/AU6VqyhRW8ot+rETB3+AgAAgaACAABLxAIAAA3UA
Date: Tue, 20 Feb 2024 13:42:56 +0000
Message-ID: <da5u4h7ypegbyiwd3be664wa35ur5zazmfdbalm7ei3jsbuw74@jws5oqh4tntm>
References: <20240219-realtek-reset-v4-0-858b82a29503@gmail.com>
 <20240219-realtek-reset-v4-3-858b82a29503@gmail.com>
 <lvt7su5mmf7b3w4gbxd6vlt25klsyziuuaznfzjy7d4oxz46qx@4dzc4cgmfkbc>
 <CAJq09z5ak_S3iFnGw+rw0JQwoxf=x69=Ync3Xg5AQ0hx_tsGXg@mail.gmail.com>
 <s4r5fdkrci2thuv4o6pstdxwkh7vfsd3w63rlcke3qqz6pdqne@t5jvkqwpgy7r>
In-Reply-To: <s4r5fdkrci2thuv4o6pstdxwkh7vfsd3w63rlcke3qqz6pdqne@t5jvkqwpgy7r>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|AS2PR03MB9611:EE_
x-ms-office365-filtering-correlation-id: 397a9013-4b6d-4fad-4cc8-08dc3219d830
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PfERqk+gwwwXQitzQlPC5fVqeQbTO1GMySfOYrB7TsQxmXZAzcZPwgBIixedSYKR0cZjwzxWAy0N1aeOnntp1bUnrBtmeXM6VuWWgcNDDanEJVfAywpFoZRWiAL5LSrzMltTtP0qyoUrvQbf8Phqi5Prc73hu7J09Qm4t7+4vHPHUrQfHOhtQlgQZxLXaRsm/DNyI/mYmu5M/dINJcw/dcBeIG+7kOVC8ycIz8gmw+0gN4Zwuf++tyuxhEsoKB19b5KlwXn5QMd9VcOcTkzNNXR97s+34AHbH236imcmr2etRm5d3QauogiPl88dFwIVoYLO/CAEcXyEocxI14y4CzprhccO70AiviKAGZoEceFFlH9XPTlD3qMSGMalNMb5SMN6kHSNnsTBH28j/jD5A4u1mQgz95iFUHopy6ExVrU2fqf32cL4hO26veA/C7xwZ7FproHw12Bp1gk85GxBaKZB8Uok2Cm3d/sdeM1894Sm3/FUmGhEdmXs8EMPA39WwejGcVWXD49/xgbYSLmzekbkq5xCL/gLCp/VdjVNY5x4q/DKWCiuh/1Z/5VJ0TIOsyQemOOT23r4lXIkXcWj5wtPbuoPZOqJa84MDTdJiZopb5jdI8CpBHt7Aj9Bvz9h
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M2xlQWJvMXpvU3lJdXZxbXg2TU1uS0ZsMlZPOTdlRklRRVo1TDFzRHFmdWhz?=
 =?utf-8?B?dmgzS0J0bXBtaW9OWkRkdGFBYm95Nk5xeUhMQlcxbXExVytCV2hzNlhtOUE0?=
 =?utf-8?B?ekpSNTRqOHJMR0VkbmpwbEdTdFJ5cVAyWWFTWElUVlFPVzRFeWk4TzVidDBj?=
 =?utf-8?B?ZHlGWEZiUTFPUDFJV2JzQW50OE1EUmgxbXBBU0E1TE51UkxvNzVweS9pUnlD?=
 =?utf-8?B?anE0QWd5SkhOU1FwcklGSDNpaE9sbmpZWjNIbmxXRzQ5c3RMUDYrdWh5aFpn?=
 =?utf-8?B?eFNBMWhhWkFaRE9JZUhlbUFIVTVnbHd4OTRWT3FNc3NOSCtaNjg1U2R6MFc3?=
 =?utf-8?B?Q3k1aVR0WTZMT1VIbXF3Ky96aS9GUWlZYzE3NERBMVBRWnJKQlVUcktoNkRI?=
 =?utf-8?B?SW9wbHVicU0xVEdVRjBaeWlERkhoQUZRbGpUdlczN01TYy93NDd3U1JJeUc4?=
 =?utf-8?B?OGtGdzdNc3VZRUdlVzkzZ0RiclF2YlU2UXpTcDJlSWE0YVZtc3crL09jS0VP?=
 =?utf-8?B?dkxyQmpCUUM4TXIwb1ZvSnVkVFZhYXljazRYMVR3TzN0OFVNRStqN1NtT2NP?=
 =?utf-8?B?MXVUSllJRDlCWGVEQmlsK1dCWGFuWFdJdXQvZEpyUWUzRGowaHFUand3UDlB?=
 =?utf-8?B?ZnE4V0daQ2lQb1p6Y1c0V0FrcENtVEl6S2pFLzZxTXlBUzMvMGxmanBNTFZl?=
 =?utf-8?B?cWpkWVBBR0YrS2lIcW5hQjNTazZpc2hMb0c1U1lMTTVXc09lTElBeTlvdmxt?=
 =?utf-8?B?SS9UeHFMZ1pjYUVoMVF2LzdGNjFDMkxUSjUrT1VKSnBvSUhmdktiaE10UVZF?=
 =?utf-8?B?a3hhOUFuM2ZITjRqUlpnVmhoL040UytJb1dMQVR0eTU2UXMzSGZWMlFJTGNG?=
 =?utf-8?B?d3NlTDQwRkozRkF0VXQ4clFJcHBFN1RLSmhLZCs1bE5pYWljZ0FTN3E3VVZH?=
 =?utf-8?B?OENUdUVYd1RCaEtJNlljY081Vk5MS2ZabFNNQ1ROV29hRmw2cVI5TXYxUFdJ?=
 =?utf-8?B?N3JFVjBGQm0zS0RNam15Qy8zK1VyVG1NSTNESlhpNjVEMkdHYkdJZTFBR0Zu?=
 =?utf-8?B?N0QyVnBSYzh6QkJQYlRiUEtzbExHb2JBU2ZVenJVUDMwUnFmYkhNY1lQa1dT?=
 =?utf-8?B?TTR5L1FQWmh4UGRuQ3hyK2pLbzFCMVU5d2JHMUZRQ3J6SnBrUFMzc1VKdXVK?=
 =?utf-8?B?dnJ1ZGhJQW1VdHRFMTJPSGg4dG5UZVU3TlBETlVHbml6SXNuVzFISWFhZXlD?=
 =?utf-8?B?c1cyRk5TSUZ6MXlOdlBUOE10UFJZdk5Zc1ZONEtoc2RXWVgxRHkxay83aEEy?=
 =?utf-8?B?VGUzdXFQeEh6c3g0Wkl2Q00yeTk0citJT09sQ1RtUmFBWFdSOHF0YTJBMXpP?=
 =?utf-8?B?cDNuRnl5amlSWVBhajZ3bjIxWEZQTTArYVF5cmMwVmFzRi9KTUdLTWc1b09F?=
 =?utf-8?B?Zk1iUmJaWUVwSUJod29Gb1dLbDNONHdXd3hHRTI5UkNZSDZZRkRUS2lPUHZx?=
 =?utf-8?B?c1NUWW5YaDRsWDh1ZnY5TlZiRFhBdXNuYTROdTFhVVRjclFoTC9jNEhacmRk?=
 =?utf-8?B?QXVLUU02YTdMMjNKOFlOVEJaOTRxY3dHclkxeHQxV0VTbndBR3BmOUpSaldx?=
 =?utf-8?B?ZGdlNnc4YlpvNWJFQnpZZUphR0pIekx0ZUpLa1VaZ1dmc2tVL2lpY2JBWThM?=
 =?utf-8?B?SjRCVGhSZFZOMlcyc1ZmdkNmbnB6c3dwYStDa3VkRGtXMkxFa3dIS2hUWFEz?=
 =?utf-8?B?MGUyMmYyVlpCU3RUTFVZZHdMTjlhU2hjK2RzSVl0eWtQa2ZtU3hlYmRBMlA5?=
 =?utf-8?B?NkF5NWoyRTVqcmRwUDErbzVxeTN1YTV6dW5ndG1JbkR5aTJUNlpnNlZEODI1?=
 =?utf-8?B?V1ZvME1rd3dGZERTMDU5SzZBK01YT1RwaWVkMk4vdC9RVlF2V0IwR0o3UW4r?=
 =?utf-8?B?Tmd0STdMMTlKek5HUnU4SXFTbVB4U0FRKzQ5QWxBQW1vcWVBNmxLR1NubkNO?=
 =?utf-8?B?ZGxIVUJ6aGlXNzVnQ0ZmMkQ0SmJEdXYvbG5CY2xvYm90UVcrN0l4ZWpzajha?=
 =?utf-8?B?NklSWEhlZjF3NDNsSytZODhSSTBHUEcvTTRJRnAxOElkZ3VjL2V0OElEc0gy?=
 =?utf-8?B?RDVuV1p5b1FwUUwvYlQySWdDUWdtT1EraE91UTVzMDhqTjdObkQ1b1h1L0h5?=
 =?utf-8?B?T2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3061434491C617468B76A855C1030E10@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397a9013-4b6d-4fad-4cc8-08dc3219d830
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 13:42:56.2175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hjsHmOlbr7SGoYduriyGUreQPfwKYeNp3Ed8sFT1zHpSTKNFoplUEszeyRP99s0vU1Mmmb2EmSiodi86gXMNmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR03MB9611

T24gVHVlLCBGZWIgMjAsIDIwMjQgYXQgMDE6MzA6MzNQTSArMDAwMCwgQWx2aW4gxaBpcHJhZ2Eg
d3JvdGU6DQo+IE9uIFR1ZSwgRmViIDIwLCAyMDI0IGF0IDA5OjIyOjQ0QU0gLTAzMDAsIEx1aXog
QW5nZWxvIERhcm9zIGRlIEx1Y2Egd3JvdGU6DQo+ID4gSGkgQWx2aW4sDQo+ID4gDQo+ID4gPiBP
biBNb24sIEZlYiAxOSwgMjAyNCBhdCAwODo0NDo0MlBNIC0wMzAwLCBMdWl6IEFuZ2VsbyBEYXJv
cyBkZSBMdWNhIHdyb3RlOg0KPiA+ID4gPiArdm9pZCBydGw4M3h4X3Jlc2V0X2Fzc2VydChzdHJ1
Y3QgcmVhbHRla19wcml2ICpwcml2KQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICBpbnQgcmV0
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIHJldCA9IHJlc2V0X2NvbnRyb2xfYXNzZXJ0KHBy
aXYtPnJlc2V0X2N0bCk7DQo+ID4gPiA+ICsgICAgIGlmICghcmV0KQ0KPiA+ID4gPiArICAgICAg
ICAgICAgIHJldHVybjsNCj4gPiA+DQo+ID4gPiBJZiBwcml2LT5yZXNldF9jdGwgaXMgTlVMTCAt
IGkuZS4gaWYgbm8gRFQgcHJvcGVydHkgaXMgc3BlY2lmaWVkIC0gdGhlbg0KPiA+ID4gdGhpcyB3
aWxsIGFsd2F5cyByZXR1cm4gZWFybHkgYW5kIHRoZSBHUElPIHdpbGwgbm90IGJlIGFzc2VydGVk
Lg0KPiA+IA0KPiA+IEkgbWFkZSBhIG1pc3Rha2UuIEkgc2hvdWxkIGJlDQo+ID4gDQo+ID4gaWYg
KHJldCkgew0KPiA+ICAgICAgICAgICBkZXZfd2Fybi4uLg0KPiA+IH0NCj4gPiANCj4gPiBub3Qg
cmV0dXJuaW5nIG9uIGVycm9yIChhcyB5b3Ugc3VnZ2VzdGVkIGJlbG93KS4NCj4gPiANCj4gPiBJ
IHdhcyBzdXJlIEkgd2FzIGRvaW5nIGp1c3QgdGhhdC4uLiBJIHdhcyBzdXJwcmlzZWQgdG8gc2Vl
IGl0IGFzIGl0DQo+ID4gaXMuICBJJ2xsIHJlY2hlY2sgbXkgYnJhbmNoIHdpdGggYWxsIHRoZSBp
bnRlZ3JhdGVkIGNoYW5nZXMuIEl0IHBhc3NlZA0KPiA+IG15IHRlc3RzIGFzIHdoZW4gcmVzZXQg
aXMgbWlzc2VkLCBpdCBub3JtYWxseSBkb2VzIG5vdCBtYXR0ZXIuIFRoYW5rcw0KPiA+IGZvciB0
aGUgY2F0Y2guDQo+ID4gDQo+ID4gPg0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgIGRldl93YXJu
KHByaXYtPmRldiwNCj4gPiA+ID4gKyAgICAgICAgICAgICAgIkZhaWxlZCB0byBhc3NlcnQgdGhl
IHN3aXRjaCByZXNldCBjb250cm9sOiAlcGVcbiIsDQo+ID4gPiA+ICsgICAgICAgICAgICAgIEVS
Ul9QVFIocmV0KSk7DQo+ID4gPg0KPiA+ID4gWW91IG9ubHkgbG9nIGFuIGVycm9yIGlmIHRoZSBy
ZXNldCBjb250cm9sbGVyIGFzc2VydCBmYWlscywgYnV0IG5vdCBpZg0KPiA+ID4gdGhlIEdQSU8g
YXNzZXJ0IGZhaWxzLiBXaHkgdGhlIHVuZXF1YWwgdHJlYXRtZW50Pw0KPiA+IA0KPiA+IEJlY2F1
c2UgaXQgZG9lcyBub3QgcmV0dXJuIGEgdmFsdWUuIFRoZXJlIGlzIG5vIHdheSB0byB0ZWxsIGlm
IGl0IGZhaWxlZC4NCj4gDQo+IEFoIG9rLCBuZXZlcm1pbmQgdGhhdCBwYXJ0IHRoZW4uDQo+IA0K
PiBCVFcsIHBsZWFzZSB1c2UgZ3Bpb2Rfc2V0X3ZhbHVlX2NhbnNsZWVwKCkuIFdpdGggdGhhdCBJ
IHRoaW5rIHRoaXMgaXMgZ29vZC4NCg0KT0ssIGFjdHVhbGx5IHRoZSBvcmlnaW5hbCBjb2RlIHdh
c24ndCBkb2luZyB0aGF0LCBzbyBub3QgY3J1Y2lhbCBmb3IgdGhpcw0KY2hhbmdlLiBJdCBjYW4g
YmUgZG9uZSBpbiBhIGZvbGxvdy11cC4=

