Return-Path: <linux-kernel+bounces-124372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D88891662
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA1E1F22E76
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22655524D3;
	Fri, 29 Mar 2024 09:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="WgeDp8iz"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2104.outbound.protection.outlook.com [40.107.6.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C328DC1;
	Fri, 29 Mar 2024 09:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711706318; cv=fail; b=UN0Pn4MLLFi8J7/PABNHgOk3NLhp2oU7Zfwh49Nv2jD16Y4vEeMthHTqVRqcrpITiUGzWDOak3Bi782pNHh/7K/KTTUIt65sKFG17NFZIk9Jv73GkBlADYRXAWloh/z1azB7lm1W6ZyOvHv5vscaFVm2FmPK02HeON49v1n7Q38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711706318; c=relaxed/simple;
	bh=TrdWKA6qPIP/elR688U2mUF29Gi5bYd5C27dXbt6vhc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OOCi0vjQNv63Unq4UlTznAlreoNP60s2vpHdGk9IhvvY/qPbLyes2SxgaizJ6Ss7IE8Uvgav059U9q1y4MKHwxfByGNLDrgZ7iEqGmjvqgKgeofls6otmXU1eVLj5SUA8jYZo2A6OLkRuiCyM7T4LEK/YCEcm4sIZ6Y7s2bZsqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=WgeDp8iz; arc=fail smtp.client-ip=40.107.6.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VGDgyKStKh397/VCufJvlS54o8U7CcN78fuZQI+LiHlJfFRP/zX425WvhCLANo/RegyNRojrRtI8bPH3pGUayHxBkixUOgFXjCdXOyESn3IbI3end27y705SAkbOw29rcHRqszx6u6OAFPrOE+ZK4nFRgoYIWC/mhh65nV/pN7YiqqF6+Aj5Nl5LyiSNx4ZsBNsScxYDDSEnbcWFI5/r2cCBf/p7oqpQEJP7MIv/COPtaHhVrMOzbjM2Gzz5Zi8MEug6r9rHwPD2pKUIqoM+Ayvy8ZxLs77K6t057UE85uq63yTYPdZewGkISPiYuFeQWczNeX0AaggU8shM+Sm6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrdWKA6qPIP/elR688U2mUF29Gi5bYd5C27dXbt6vhc=;
 b=bjj2BW+gRM6zUxLXOC2WCEfgb+kUKjSnRcXMd+lz1dftxsxiSnKHNc0oYajcahIqKmi67Kb92GFodp6qKcOIHSxDLQslIHWdUE8698eXSmcnt4BqaOnXuilH0JMOKggcyi+phccP0YmuWiShVxcNZvp2IEK+dazIplgcgYHNNbSzdBVXoPw2RA0v3z3ioJ9uVA2Ewc5Erw7h+LCRFUaRrXuCeSzbr9vPlShcgiSklmmFy7l6o0YUfuGaGp/2zzjitF9N+aBRoEDAWdMnYkib+trtRHSHOUpmCCV9nwrji4m32DOsyR/aYsXL6aSP8rfKXMn79xDWEALOhtuDEH/p1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrdWKA6qPIP/elR688U2mUF29Gi5bYd5C27dXbt6vhc=;
 b=WgeDp8izFuCPnBQ6habiBnjUNFjgefQJkjoaPrsbV/ZShVBBN3GKJtTSCDu7wfm/yK9m1ciLLWp83+w7QpK4H5OS2hiAfHiDNkVU3EDVauthJZzXgRQgoWvgaBcQ3Q5B2ti0GpbNIIsbgR3eRB2xPrHJU3mnUUoglt/mqV+fLKA=
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com (2603:10a6:102:273::20)
 by VI2PR04MB10148.eurprd04.prod.outlook.com (2603:10a6:800:224::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Fri, 29 Mar
 2024 09:58:33 +0000
Received: from PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7]) by PA4PR04MB9638.eurprd04.prod.outlook.com
 ([fe80::6e8:79bd:7877:afa7%3]) with mapi id 15.20.7409.039; Fri, 29 Mar 2024
 09:58:32 +0000
From: David Lin <yu-hao.lin@nxp.com>
To: Johannes Berg <johannes@sipsolutions.net>, Brian Norris
	<briannorris@chromium.org>
CC: Francesco Dolcini <francesco@dolcini.it>, "kvalo@kernel.org"
	<kvalo@kernel.org>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Pete Hsieh <tsung-hsien.hsieh@nxp.com>,
	rafael.beims <rafael.beims@toradex.com>, Francesco Dolcini
	<francesco.dolcini@toradex.com>
Subject: RE: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Topic: [EXT] Re: [PATCH v9 0/2] wifi: mwifiex: add code to support host
 mlme
Thread-Index:
 AQHab2onJLj7by1TDUGmc5gbcJq9YLE4nU6AgAD7hoCABXXFAIAA1QEAgAAD/+CAAIccgIAA07QAgAd5WoCABeQz4A==
Date: Fri, 29 Mar 2024 09:58:32 +0000
Message-ID:
 <PA4PR04MB9638DCE7B8D49785F7DFCF06D13A2@PA4PR04MB9638.eurprd04.prod.outlook.com>
References: <20240306020053.18054-1-yu-hao.lin@nxp.com>
	 <20240315094927.GA6624@francesco-nb> <ZfTspRKFgrO9xCTH@google.com>
	 <969e95ccc4a1d35b45212b7fcb536ee90995e3b5.camel@sipsolutions.net>
	 <PA4PR04MB9638D253189D6DD330B198B2D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <PA4PR04MB9638BE73DDBCE1CE8AA32BA8D1332@PA4PR04MB9638.eurprd04.prod.outlook.com>
	 <b2d9a7ef53c5ab4212617e8edf202bbafe52e2f8.camel@sipsolutions.net>
	 <ZftaJEIeNfV7YrVo@google.com>
 <283623e0b227d843a83f8fcd6e9302b1f9f6995a.camel@sipsolutions.net>
In-Reply-To: <283623e0b227d843a83f8fcd6e9302b1f9f6995a.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9638:EE_|VI2PR04MB10148:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 BgO3wHZIBYjigTUJOLRJvPOp3lyPqTrSVtJn8sCegUCkN/RTXg2g/Zyp92i/17z4JVYRcG3OBPCK/hwrzqUB+4+in6ma5LGHJwztykqsRyjPnU8QewEk4aPAcbHh9lYX9FM+KdxKMDEO+j78pzTQvC/5yAtR/Lc07RI7Mver95EzkxDfHJx+h6Ta5/fPauF2LSp/5oAWLVcKRLx41pYI7YFBbgLED/ymqAzVU55FHH5m3i6/LaEcGO/Mny9G09kWz4xKfeKDcYg7HvI5lZV4MKzFgFzE3W/2cHc9A5HA4blZvXEHf6Me+1hOYPn4yLusNB7fFXfv0sqx/9g4dRwXkyQuvWEG6kccFaIbT0kawSyfA04wMozlytNyQI8UDRdsZZc5Ajx5rwps0w/mr/gB2pDk1TmFHXbWImpj2Oz3eS91ZOigXl1u1x2Mj90jTzXpUGccjVJG2cODH61xLMCE94Jdt0TPFZFeKOyhUvMSs4sBBarB7dNCIBhrlAsfEogqHABxeeCMEA0eJtSZyz5yZ5XyPbKI1dqRjg6lT8mcM+RijAElhj6xAzzt22c0Wb8l5AO23mbmjk+gCDAALKXJ/QgWBnynMC7o21oDrzhtikwjM7IoRAMRvUrsKx9v1EM6VajXPWK/iJUjCoRTEM5DVqaGMPdzSG7XHDdRPDEfJOw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9638.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NElzM0F1cUtEbEduT01KNEFlcEZUdUFESmZtTzk1b2hZTU03NC9pbTVOUytH?=
 =?utf-8?B?akNGL2I4Q3JrUDAvempTM2VTSk82L2RvVWczSTQxK0FCcFo2a3dvN0JTUzZl?=
 =?utf-8?B?WU1kdDBPb0hVYjE4VGFDOWhRS1c3Ymkxc3dTVEpKbHUyZTdTVUZmeDd1ZVls?=
 =?utf-8?B?VmZvZzY1SW1ETFRTWGE5cEFvN2xaeTJoV1FjbjEvaDRNRHMxdnZCY00xd3VH?=
 =?utf-8?B?NlJGZkZPL1BabnYyVk1yTjRGYXluZG1vb0FGbzhDVWJabnpYRXRpS3BxV0FB?=
 =?utf-8?B?SEYyN2dZM09oaEY3TDV4ZEtUdG52S0JRUkRiWmZUYWIvV0V6YW5LUG8ycFNQ?=
 =?utf-8?B?c096SmQ4Q2tRME16OXB3TCsrYzZKTisxZmV5VHZTbUxxcE5ORkdXM2U5V0hH?=
 =?utf-8?B?dE0wOXJTQ0Mwd1d1Wm8vbkZZYUtySHM2OE51SVFsUzVUc2cyMUFFK1ZXdEdC?=
 =?utf-8?B?VERYOTVZV1R4TkprQmtCNE9SRWNhVmo1blhGcmlrYWtOcTBqeSsyb2RqekFr?=
 =?utf-8?B?dzBuTmFmV0l5SzFwUzdlQkZCQ1AveDA5ZW1Cdnptd3ZYWGZaeGJzMEV1R3Uw?=
 =?utf-8?B?eklTQVg5cmw4S3JJUnVwRGxCYm5mMUsvanhiWi9IbWtCMGl5YWdCZUt4bVph?=
 =?utf-8?B?MVVUc25Fcmg5NGVvMUxPckM0Nnc4eXpkeWlTTTFJOW5DcTkzM2NlZlNTWVhR?=
 =?utf-8?B?QSs2MDBHTlRjeTcrYjRuTy85RXc2dTNFdlJ1bUk2aDA2RWErdEpCekRGMTBr?=
 =?utf-8?B?QitEblJNUHJZUTZsSW1STGF1SXJYcnk0UXYrOCs4YkRHNWlMUEsvZ0c3dHcz?=
 =?utf-8?B?emJsaWtaUXRtK3pOOFFjRmFRTFM3VWRTNzNzaVh2L0pkOGpwM1kwN1Vqak05?=
 =?utf-8?B?Qnlwa3NzdUNaYWxqYmNBQ04zcFplVktTSG4xczJlMW1YM3RVV0hkRWJ1OHo0?=
 =?utf-8?B?Vytyd0w4S2pwK3hLUUFCUTFLRTFNeGs1alk2cEN2SGZQTHl4ZkpvQzBWQVhB?=
 =?utf-8?B?b3hVMHowQ2pyTkpndFgxRmgwWlNBS3VWM1RvUUdBQ0twMitaK3hpa3BTc2RM?=
 =?utf-8?B?b1h1M2xUSk1oQmNFV0taamVuZGhnekc1YzBDeGRzblQ2cmUzVVVWVGpCSVl1?=
 =?utf-8?B?c1VRblBpVm1aYTZjQ3kycFdFaWR6WjRnWGJGWkx6Wk1GZmFmUzdGbkFxd3lJ?=
 =?utf-8?B?aUNOOVJUS3JTZUtLRlRVekJzRHRDL0RHMzdWd1dzL3pXN1lYaGo5bGY4Tzhv?=
 =?utf-8?B?Sm1IMFNJYXRoTW0zQzBVTytvSUJxZ0R0OHdmVHU2TEoxN0kxTGFoeDhjUzl0?=
 =?utf-8?B?UC81R1hTbi96V1BLbHlnSGo1dmhPOGMwSHF0N21yMVM1VUd4OGJGVDJhS2M1?=
 =?utf-8?B?a1Y1Y1daSmZHUStscWFaamRHQlpvT3I2Nm80YUhEeDdyS2VkS2l1NmFBeHk3?=
 =?utf-8?B?dTA3dnFHRStWdHZ0dUphamwzOFA2Z2dWMldqUVRCeVBxSHN1YXVqQU42K29D?=
 =?utf-8?B?NFpJZjBXVHJPMG9VdjZWQlFlQVR0VjJOOFB2RURJdXJmVy93bGxWcHNpN2c0?=
 =?utf-8?B?U1E4VU03NXh2YllJdlVxZi8wOURIRFJKTW5pbGVTbVVrZllIS3BQSlh6dW90?=
 =?utf-8?B?dDlLVXpvYVY4RUkvV1hUWnhac1NTSDBZQytWS1RVRldwd29Ea2orOTI1K25z?=
 =?utf-8?B?UVlhVVlMYzRvZlM5SkNrZ01Idk1rTFJFdFQ2ZVVVY0FMbHZMdWp6RXNzeVFN?=
 =?utf-8?B?Nk93TStTQkNTZm9iem1NdnRlandvZ2Jtc0ZZWkx4OHIyaWc1R3VQcVpBUkpM?=
 =?utf-8?B?dDVnWHg2bDluQ1FNeFR1MTJBa3pETHlFQUlVVGtHRHgydGtNSW0vekRoWThG?=
 =?utf-8?B?UFpHMVJkTTdRdlZjRlZoekY5MjZmMUdUT0ZtWmJVdU5yUXIvbU1mWUpTT21P?=
 =?utf-8?B?NExlTW5MNlUxU1FYWVg2dEV2TXRrVUNURW9yZmVUOENJTmtRYnVITWVYeHlx?=
 =?utf-8?B?dzBiZkd4TmZqK2Z4Q2c1cGFGckNYWXFzdFBVUlErTXpac2czVnFYUDJkL0VN?=
 =?utf-8?B?c0FSZkFsdFpHM3dYRTdVM1pkeFNWWXowUG4rZXJkSHV6cEJoZWsvYktBZlRM?=
 =?utf-8?Q?6LiJU/K3SuF/EihsFf1FV2h3Q?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9638.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6bd3663-969a-4909-3b65-08dc4fd6cb14
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2024 09:58:32.8051
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: snrPPz7ByHfL/SSAgpDPfn3TALQ0EjnXuAjhKu2KoR/LlUBDJb8yPbEXNqRzBR2XCHHfkXFjinvKQm8A3NPxnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10148

PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pg0KPiBTZW50
OiBNb25kYXksIE1hcmNoIDI1LCAyMDI0IDExOjU5IFBNDQo+IFRvOiBCcmlhbiBOb3JyaXMgPGJy
aWFubm9ycmlzQGNocm9taXVtLm9yZz4NCj4gQ2M6IERhdmlkIExpbiA8eXUtaGFvLmxpbkBueHAu
Y29tPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNjb0Bkb2xjaW5pLml0Pjsga3ZhbG9A
a2VybmVsLm9yZzsgbGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJu
ZWxAdmdlci5rZXJuZWwub3JnOyBQZXRlIEhzaWVoIDx0c3VuZy1oc2llbi5oc2llaEBueHAuY29t
PjsNCj4gcmFmYWVsLmJlaW1zIDxyYWZhZWwuYmVpbXNAdG9yYWRleC5jb20+OyBGcmFuY2VzY28g
RG9sY2luaQ0KPiA8ZnJhbmNlc2NvLmRvbGNpbmlAdG9yYWRleC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbRVhUXSBSZTogW1BBVENIIHY5IDAvMl0gd2lmaTogbXdpZmlleDogYWRkIGNvZGUgdG8gc3Vw
cG9ydCBob3N0DQo+IG1sbWUNCj4gDQo+IENhdXRpb246IFRoaXMgaXMgYW4gZXh0ZXJuYWwgZW1h
aWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBsaW5rcyBvcg0KPiBvcGVuaW5nIGF0
dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhlIG1lc3NhZ2UgdXNpbmcgdGhlICdS
ZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+IA0KPiANCj4gT24gV2VkLCAyMDI0LTAzLTIw
IGF0IDE0OjUwIC0wNzAwLCBCcmlhbiBOb3JyaXMgd3JvdGU6DQo+ID4NCj4gPiBBRkFJQ1QsIG13
aWZpZXggZmlybXdhcmUgc3RpbGwgaXNuJ3QgYWxsb3dpbmcgInBhcnNpbmcgYW5kIGdlbmVyYXRp
b24NCj4gPiBvZg0KPiA+IDgwMi4xMSB3aXJlbGVzcyBmcmFtZXMiIGluIGFueSBnZW5lcmFsIGZv
cm0gLS0gZXZlcnl0aGluZyBJIHNlZSBpcw0KPiA+IHN0aWxsIHdyYXBwZWQgaW4gY3VzdG9tIGZp
cm13YXJlIGNvbW1hbmQgcHJvdG9jb2xzLiBJIGRvIHNlZSB0aGF0IHRoZQ0KPiA+IEFVVEggZnJh
bWUgbG9va3MgbGlrZSBpdCdzIGVzc2VudGlhbGx5IGR1cGxpY2F0aW5nIHRoZSBzdGFuZGFyZCBt
Z210DQo+ID4gZm9ybWF0LCBhbmQgdXNlcyB0aGUgZHJpdmVyJ3MgVFggcGF0aCBmb3IgaXQsIGJ1
dCB0aGVyZSBpc24ndCBhDQo+ID4gY29ycmVzcG9uZGluZyBBU1NPQyBtYW5hZ2VtZW50IGZyYW1l
IHRoYXQgSSBjYW4gc2VlLi4uDQo+IA0KPiBGYWlyIHBvaW50LCBJIGRpZG4ndCByZWFsbHkgbG9v
ayBiZXlvbmQgImF1dGggY3JlYXRlcyBhdXRoIGZyYW1lcyBhbmQgc2VuZHMNCj4gdGhlbSBub3Jt
YWxseSBsaWtlIGFueSBvdGhlciBmcmFtZSIgLi4uDQo+IA0KPiA+IC4uLnNvIEkgcmVhbGx5IGNh
bid0IHRlbGwgaG93IG11Y2ggY29udHJvbCB0aGlzIGZpcm13YXJlICpkb2VzKiBnaXZlDQo+ID4g
dGhlIGhvc3QgcmVnYXJkaW5nIGFyYml0cmFyeSA4MDIuMTEgZnJhbWUgbWFuYWdlbWVudC4NCj4g
DQo+IFBlcmhhcHMgaW5kZWVkIEZXIGRvZXMgcmVxdWlyZSB0aGUgYXNzb2MgdG8gYmUgZG9uZSB3
aXRoIHRoYXQgY29tbWFuZC4NCj4gDQoNCkRyaXZlciB1c2VzIGFzc29jIGNvbW1hbmQgdG8gY29t
bXVuaWNhdGUgU1RBIGNhcGFiaWxpdHkgdG8gRlcuIA0KRlcgZG9lc24ndCBuZWVkIGZ1cnRoZXIg
cHJvY2VzcyBBdXRoIHNvIGl0J3MgY29udmVydGVkIHRvIDgwMi4xMSBmb3JtYXQgYW5kIHNlbnQg
ZGlyZWN0bHkNCg0KPiA+IEJ1dCB0aGF0J3MgcHJldHR5IG11Y2ggYnVzaW5lc3MgYXMgdXN1YWwg
Zm9yIGFueWJvZHkgYnV0IHRoZSB2ZW5kb3IgaW4NCj4gPiBwcmlvcmlldGFyeSBmaXJtd2FyZSBs
YW5kOyBJIGNhbid0IGFuc3dlciBwcmV0dHkgbXVjaCBhbnkgcXVlc3Rpb24sDQo+ID4gb3RoZXIg
dGhhbiB3aGF0IEkgY2FuIGdsZWFuIGZyb20gYSBkcml2ZXIuDQo+IA0KPiA6KQ0KPiANCj4gam9o
YW5uZXMNCg==

