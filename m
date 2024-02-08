Return-Path: <linux-kernel+bounces-57680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5351E84DC23
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75AAA1C25F68
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AF36A325;
	Thu,  8 Feb 2024 08:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="lc510mV/"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2044.outbound.protection.outlook.com [40.107.104.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEE167C45;
	Thu,  8 Feb 2024 08:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707382693; cv=fail; b=MGxHOotW8KPCdpuWitOld/SjntV4hoYpMo7HtHqPl65AzSUUb/opEgkMMQuktcfW60ujgxArVweYx+QkOkn8gQ8ms+ew5rqR4FOiyUB8C8RqDsUJIHLI1HRKLdqqzfj4Bai3fQfyEl6QfQo6JG5pvzvY6DPEtzPvXpupwCgfyis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707382693; c=relaxed/simple;
	bh=ycmzxQG9ijfaNJ+SxVC0gklawaCQ1fCEreHu5JSEMF8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rSDm8PQMwmdoVl3wCYHPD5tv8I+sYXfMu21/vQvJNKx0QVK9SrIWkd6ClWSugMfBtT3Y4UKei9g3TIMwXuOGaorEHPv1LzQLLNRydyLav9lxQitj47YF3U7IaAUatWMWNsYqB8MnYwPeeIi5LjFnTyGlnUB0A1y9L9VKojYeGAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=lc510mV/; arc=fail smtp.client-ip=40.107.104.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGIH5jta7IDgUUjTGDpDqM1RoK/6y//cwGmkhrgroxuOvB/D2uqBpbQlUZzSShoCGTehBgsBkSDS7i/nHiMXZnRQzlvwdBCBY4txH88JtGUCiyac5BdtMcyDBSGyPR+TVwGi9ZTRgdkjCMNcB5Tj+tl8tj/kI7xKwk/NJa/lA29nj/Tr47jRQgBchxmu2zb6lNkgUylC73MmSK60H3hiO/nmn2SFvJg5C3uMIelb5si7TceqgZqQYUFOWAi/U+/oxkcd48ZDFHGrU8Px9vh5gKf8p65Cb1Ef7LDNf8vYL1tlKxE2UJUdLWnkweMYtJWJjw94MzIqq9wZfPYzWa9x1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ycmzxQG9ijfaNJ+SxVC0gklawaCQ1fCEreHu5JSEMF8=;
 b=YO6R+R+vu5l4RmPoo/iOTX9d1kmPeUJh9Cvw5QvmsEaoSCNmc7I+gTUFzR2LQ5dGqx08LfZ4gass9eAubYa0AefSYtG06lIhJk3Wjq4wqhJ6P9PgYrc7qcHbRHaV+hRkstcomRoYnwm/icbAjmoiWomorQPO/b96uWaIqvKY6zQQw/7dyT1+2DY/Hk2MkEfLstj3PL16k5k1YspZPgrMqXFYC9QXdqMByDbzjgUjQuNb46VnCydTtVAIauLUADGBIiO5ACwUoGxzZeNbPc3FpL/b+sqCbb48rvsTx+5v9s7QOkb1mp/4ICz3v9mewnGcbeX7UlaPvBnIfgsDX/NsLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ycmzxQG9ijfaNJ+SxVC0gklawaCQ1fCEreHu5JSEMF8=;
 b=lc510mV/sAQaXyfRPqWo1Unz1KBWO53PswMF019dpBvYlak0gopVsAsZ2wIH4uGDtuqtb+jJL5hLXubVDPoeYNO3wYF7Xp8Nlyk11NhVgIVLoHdraD4/gN770fgtqgsYLtyt37mB6aPIqkmUwJwAvra2RQbZGT393AYMsA3houo=
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com (2603:10a6:20b:59::18)
 by VI1PR06MB8781.eurprd06.prod.outlook.com (2603:10a6:800:1d8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Thu, 8 Feb
 2024 08:58:08 +0000
Received: from AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a]) by AM6PR06MB4705.eurprd06.prod.outlook.com
 ([fe80::2eff:83f6:f08f:4d3a%6]) with mapi id 15.20.7249.037; Thu, 8 Feb 2024
 08:58:08 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afd@ti.com" <afd@ti.com>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Topic: [PATCH v2 2/2] net: phy: dp83826: support TX data voltage tuning
Thread-Index: AQHaWe9Wo7eR3DxLokuTFbBUDe4Vo7D/NRCAgADw8AA=
Date: Thu, 8 Feb 2024 08:58:08 +0000
Message-ID: <f37e9df4-e1bd-4d40-bd99-3998cfd803f4@leica-geosystems.com>
References: <20240207175845.764775-1-catalin.popescu@leica-geosystems.com>
 <20240207175845.764775-2-catalin.popescu@leica-geosystems.com>
 <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
In-Reply-To: <4dc382bd-3477-45cb-8044-fc5c2c7251f4@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM6PR06MB4705:EE_|VI1PR06MB8781:EE_
x-ms-office365-filtering-correlation-id: 5d300b32-82f7-4664-9b37-08dc28841226
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iQb4l2s4cXeAkI+NVV7m8G7pP9x+WxIdwC8YXpqfiGERx5EOXBItxvQ47IzXb0ZCjEEOuDWTNXHGcvZXu93eG+sgkFBCPdgrJkuyATyWjzyoEzrpSDR5FSFaTZFGNLsiPMk641OffcEpntMsUuZLK8juMCEz7Sk3za8lQptLeJMILiWAqZtPmCaODPmp4OCIt/M0X8VGqeY2YMtjdhKMM40aqWY9gJIkHy26VM3Q6LiPBht2jB2XNgFvGfxB4PmtwA9DZa9U/3ajkS8BSoArQDGIY2ggGEaheGsvyV/E72koTbOaTaueiyU9N1HxiF7G6ftHm69kA6tlvJyPNqbr4rxSGJjT+NTbmWeijK2yvrtyQe4tqhze2xL48XpgTmaaQT9+pCxZ333ZWLDqm9TZovzMS1xwda1UNcKzV3REQHKnZnVyNBE07hqAgPpRWIQ7gkzHrARROz3KHHTyTucAXUgrw1drRLS7g9SomB+WJXDWBrbi1xYwkhXSOTcvOTtHTJkz1EHi3RQy4SWPLlvpRp+GWW9RR37VGOwpTMtMnF5xhKJQ0Du/a32qxivM7JodEO7oF/KvTZyzuRK7IfTvKZl0JjfXCxmxifVsYvWkZ/ToONIqy06uEr3MH+5KNi2J
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR06MB4705.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230273577357003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38100700002)(122000001)(31686004)(83380400001)(26005)(2616005)(6486002)(45080400002)(86362001)(31696002)(71200400001)(478600001)(53546011)(6506007)(6512007)(966005)(36756003)(76116006)(91956017)(66946007)(6916009)(4326008)(316002)(38070700009)(41300700001)(54906003)(66556008)(66476007)(66446008)(64756008)(8676002)(2906002)(8936002)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UlRYdE9LYm83NFJZVVlIa2RXWnJyeWdBN2FUVUZEZlUwRHRyWnlub3FBWEc0?=
 =?utf-8?B?ZFVUQ1dxU3hVTlAxd2diT2JZUjN4VU9VUnBQYzlMRDJBVWhkK0dFYUVRZkx6?=
 =?utf-8?B?UUxvWTZod1BXdmZ4bDgwMEVqbVBSZW02enVjdzdmRU0vV0VFdFRpQWFITGhO?=
 =?utf-8?B?WHV6aXBJNytuZDVQRTR4dVpWQ1lvOElOcmRuM01yUGNzaVpQbFZqeG9vWVFr?=
 =?utf-8?B?d2pkSkFvSC9aOG5zWTdKcG9WaldDZ09DK0R3MVV6WmFSZTF1blJielM5ZGhn?=
 =?utf-8?B?c3R6WGcxbE1wV3ZOY1RGVTZSV1R6OGVSMUxOcDlkL2p6Z1BCb0E1MVVDRExs?=
 =?utf-8?B?QkkxeW9uSUtrYjJTekk5bnRtelhTYlE4bHMzS0cxT2dsL1NNN0l6VHZ1UlE3?=
 =?utf-8?B?U25Hb2JnWVVOSDg3QWdIMUxHZVBaQjhnRzU2bmdRUW9kQk50aXRZdVllRm4z?=
 =?utf-8?B?NVVyWmVzd1haWms3UDAzdEZBN3Q4NSs3OTZVR2VLa2d4VzhnS0JIRG9mUVAy?=
 =?utf-8?B?cUdoZFI5SUNYM3I0MVc1KytSTWRPV2pDWW9HMkpBTjlEU2lGekVabHJpeE54?=
 =?utf-8?B?YWhEeTc4QnBBQkZZL2JUbmt4QVl4dVV5R2lRL3ZSdEJKNzBwTzFETU9IUXNU?=
 =?utf-8?B?aWpMM0UrWFBZTWdldmloMG93WVcyRWtKNjVoQllWWFhJZ0hPMjB5cHhkNnFH?=
 =?utf-8?B?SjdZeThaOXczUEhRUnY2NEkyMWM0SVJVR1psWVhId1paYjlLeGN0TW1RUlFT?=
 =?utf-8?B?YXJCQXhIcHVXTW90dGJ2VXN1WUx0K2NENEQyM2NhMzNuMmRKMzI4anl5V05a?=
 =?utf-8?B?R1NBS2dodmhPODY0V1ZqdTZLYTNFQm80UE1qZHNkUGlsVGVZdldqYUg1RytR?=
 =?utf-8?B?VnFjeHJFMnBvclNyc2pQL0RmMVhrTkZiVzRrbkxsY2s2cThhamk4RFJLMXh5?=
 =?utf-8?B?MndSV1dSTWFhTWZpdHJ2MnArNzMwTHYxcUNvbVhZVkpSdmh5a0EyOVdhd1M1?=
 =?utf-8?B?ck5Fc2k5aU5iMXBLYzZEVFQrTmlmQVpSUkNjY3A0ak9MMFc2c1BMZ1h1cWJY?=
 =?utf-8?B?aEpNaWR1c0hEV1hTajlKbHZjc3RJK2ErQ3JMWnh4SEdtVm02OHphdnJJMnBu?=
 =?utf-8?B?NlZndXBuSy9XbklvU3IzYUV1bWJXTXF3bk1wMlRNM2RNNnpzeGR0dFZEUHNQ?=
 =?utf-8?B?VHFMb2IxQWtEYXZxZkZYNFFDTlJLb0xMT2l3QW54UDJoM0VsaDYwUWU0NUxh?=
 =?utf-8?B?VFhORUd5RTJuKzVjalRBQWtVMkZ4c292RUNEaUZSWVpHL1E2Y25pdThYV2pC?=
 =?utf-8?B?ZkxVaXFzdUV3S2pySU5PWXNsNnZyYnQvNXNrbkZsdk5vTVd5eWFHcys1VzI3?=
 =?utf-8?B?bmd2WncxR3RvTjNWdzRUQ0xyeUZOenpjb1huUUR1d05SeFUzLzlWbmtINkpK?=
 =?utf-8?B?blI3WE5YYVBDK2pGcFVjUDZPbUZnb1J5VWZZOWVXNURHeDc4dXZ5TVB6Y1Mw?=
 =?utf-8?B?cmQ2ak9SWDBWWkF4YVcyVUlzU3RzWTM4bTN6REV2TjdiREpoZnB2WDNhVTQz?=
 =?utf-8?B?bG8xcWN4ZlJnZXR2L0lzQkZHeDQwQkc0aCsvVXZjVm02ZG1QelJuRGNkM1Fl?=
 =?utf-8?B?UjJnZ1IzWUtJYmp1MnhzdGJuTUx4UWRMWU8yVDB2ZmJSWERVZjN4VUE3VzYw?=
 =?utf-8?B?dXpZMXBHdCtRekRZTEdXUUZpM3dPOGFhVXpROFQyZEgxMWwxSmRodkhrYzEr?=
 =?utf-8?B?Rmt1WElqWUQ4aGhzd1Y5ajlNT213V0dHV0pqZFNyRTJFM0oxaHNoeGhvWHp4?=
 =?utf-8?B?WVlETWowK1poMVhOVGtESWx1bVBlU1B1ei9OZG5uV013U2kxV1IyQXF0bzZ5?=
 =?utf-8?B?WC9aU0JKY1B1TDJTTGlCL2xxRTgya0pPYWlzS2hVTzJWT0xhT05JUG5YcUdP?=
 =?utf-8?B?akNCMk9Yb1RQbGQvcGpZVGxMeXhPN3YwS3IrUHY4S01scWZjUFVmTG1iRWFE?=
 =?utf-8?B?SytjdGtSUGVCbjI1ZSs0TFVjL21kZk56aW5VQXMvUEZOV01USTNDS3NuTGRi?=
 =?utf-8?B?Mm1YdnozdG1hQmZDc1lPdkVpWWZoZk9oZllVRkoyMUx4aUJtQ2VpUkNQUTBz?=
 =?utf-8?B?OHlKa0RxYzlmTXlNenRLdW92M3hSbDdQNmVmV1BJQjZ6NHBvc3dqTHdhbmZu?=
 =?utf-8?B?Z2c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C35675D51B7154DB4AB18460C827D5C@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR06MB4705.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d300b32-82f7-4664-9b37-08dc28841226
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 08:58:08.4857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eSmA7Lr5oYkpX4fexboIU4XhOb4Md4nenl2953qQDaBe7GSeMQxagckigz4/YzJWApD654QMQ8UkX4XPKXGwSF2QDlqlwfjC9VHjAwvcVzwnuFkN64ImaeCCArtdkV5i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR06MB8781

T24gMDcuMDIuMjQgMTk6MzUsIEFuZHJldyBMdW5uIHdyb3RlOg0KPiBbU29tZSBwZW9wbGUgd2hv
IHJlY2VpdmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbSBhbmRyZXdA
bHVubi5jaC4gTGVhcm4gd2h5IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8vYWthLm1zL0xl
YXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IFRoaXMgZW1haWwgaXMgbm90IGZy
b20gSGV4YWdvbuKAmXMgT2ZmaWNlIDM2NSBpbnN0YW5jZS4gUGxlYXNlIGJlIGNhcmVmdWwgd2hp
bGUgY2xpY2tpbmcgbGlua3MsIG9wZW5pbmcgYXR0YWNobWVudHMsIG9yIHJlcGx5aW5nIHRvIHRo
aXMgZW1haWwuDQo+DQo+DQo+PiArc3RhdGljIGludCBkcDgzODI2X2NvbmZpZ19pbml0KHN0cnVj
dCBwaHlfZGV2aWNlICpwaHlkZXYpDQo+PiArew0KPj4gKyAgICAgc3RydWN0IGRwODM4MjJfcHJp
dmF0ZSAqZHA4MzgyMiA9IHBoeWRldi0+cHJpdjsNCj4+ICsgICAgIHUxNiB2YWwsIG1hc2s7DQo+
PiArICAgICBpbnQgcmV0Ow0KPj4gKw0KPj4gKyAgICAgaWYgKGRwODM4MjItPmNmZ19kYWNfbWlu
dXMgIT0gRFA4MzgyNl9DRkdfREFDX01JTlVTX0RFRkFVTFQpIHsNCj4+ICsgICAgICAgICAgICAg
dmFsID0gRklFTERfUFJFUChEUDgzODI2X1ZPRF9DRkcxX01JTlVTX01ESV9NQVNLLCBkcDgzODIy
LT5jZmdfZGFjX21pbnVzKSB8DQo+PiArICAgICAgICAgICAgICAgICAgIEZJRUxEX1BSRVAoRFA4
MzgyNl9WT0RfQ0ZHMV9NSU5VU19NRElYX01BU0ssDQo+PiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgRklFTERfR0VUKERQODM4MjZfQ0ZHX0RBQ19NSU5VU19NRElYXzVfVE9fNCwNCj4+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZHA4MzgyMi0+Y2ZnX2Rh
Y19taW51cykpOw0KPj4gKyAgICAgICAgICAgICBtYXNrID0gRFA4MzgyNl9WT0RfQ0ZHMV9NSU5V
U19NRElYX01BU0sgfCBEUDgzODI2X1ZPRF9DRkcxX01JTlVTX01ESV9NQVNLOw0KPj4gKyAgICAg
ICAgICAgICByZXQgPSBwaHlfbW9kaWZ5X21tZChwaHlkZXYsIERQODM4MjJfREVWQUREUiwgTUlJ
X0RQODM4MjZfVk9EX0NGRzEsIG1hc2ssIHZhbCk7DQo+PiArICAgICAgICAgICAgIGlmIChyZXQp
DQo+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsgICAgICAg
ICAgICAgdmFsID0gRklFTERfUFJFUChEUDgzODI2X1ZPRF9DRkcyX01JTlVTX01ESVhfTUFTSywN
Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBGSUVMRF9HRVQoRFA4MzgyNl9DRkdf
REFDX01JTlVTX01ESVhfM19UT18wLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBkcDgzODIyLT5jZmdfZGFjX21pbnVzKSk7DQo+PiArICAgICAgICAgICAgIG1h
c2sgPSBEUDgzODI2X1ZPRF9DRkcyX01JTlVTX01ESVhfTUFTSzsNCj4+ICsgICAgICAgICAgICAg
cmV0ID0gcGh5X21vZGlmeV9tbWQocGh5ZGV2LCBEUDgzODIyX0RFVkFERFIsIE1JSV9EUDgzODI2
X1ZPRF9DRkcyLCBtYXNrLCB2YWwpOw0KPj4gKyAgICAgICAgICAgICBpZiAocmV0KQ0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICB9DQo+IEkgY291bGQgYmUg
cmVhZGluZyB0aGlzIHdyb25nLCBidXQgaXQgbG9va3MgbGlrZQ0KPiBEUDgzODI2X0NGR19EQUNf
TUlOVVNfREVGQVVMVCBhY3R1YWxseSBtZWFucyBsZWF2ZSB0aGUgdmFsdWUNCj4gdW5jaGFuZ2Vk
PyBJcyB0aGVyZSBhbnl0aGluZyBndWFyYW50ZWVpbmcgaXQgZG9lcyBpbiBmYWN0IGhhdmUgdGhl
DQo+IGRlZmF1bHQgdmFsdWUgaW4gdGhlIGhhcmR3YXJlPw0KPg0KPiAgICAgICAgICBBbmRyZXcN
Cg0KWWVzLCB0aGUgZGF0YXNoZWV0IGNsZWFybHkgc3RhdGVzIHRoZSBkZWZhdWx0L3Jlc2V0IHZh
bHVlcyBvZiBib3RoIA0KcmVnaXN0ZXJzIFZPRF9DRkcxICYgVk9EX0NGRzIgd2hpY2ggYXJlIDoN
Ci0gY2ZnX2RhY19taW51cyA6IDMwaA0KLSBjZmdfZGFjX3BsdXMgOiAxMGgNCg0KDQo=

