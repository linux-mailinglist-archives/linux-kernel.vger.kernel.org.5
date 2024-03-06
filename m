Return-Path: <linux-kernel+bounces-93443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805C3872FEF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 08:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4B5E1C21271
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 07:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E125CDD1;
	Wed,  6 Mar 2024 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b="kQqx9yzW"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2110.outbound.protection.outlook.com [40.107.215.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888CA5C8F9;
	Wed,  6 Mar 2024 07:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710905; cv=fail; b=awlk1GMNL+w4nyEKkJiua6+RIHoGdCWwgtL6Q7TwwK2AvQ+7N9+gKjfIP154PeSpd9j8MCZbrgiXLFIepkZpQ1pxa27/E3858QvuinAGR9k1pHshPAxCglaZ22ocljPbi/LBwv9ggF+WcpwLNSnXoIwt5Dnkcw8t+SLAbUlaees=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710905; c=relaxed/simple;
	bh=q/mYZuakaFRDzPePeUyz8PyKq70GrFfEYpnYQhZH8jI=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QwZM0POO4S1sgSP4dAQsO6ONWezKOMzfKbilkelss/DrKxr3C0A+94WERvxSokuedH6QS7GdsMgst0uUoIyywrpNl5Q4iPtjMruiW3dLRieNOziAF72pa3YWV5ZKqyBwAp7ObISLXMYaEfXVBAvy/NFnniNVPFZmJ2RG0JjGm3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com; spf=pass smtp.mailfrom=fibocom.com; dkim=pass (1024-bit key) header.d=fibocomcorp.onmicrosoft.com header.i=@fibocomcorp.onmicrosoft.com header.b=kQqx9yzW; arc=fail smtp.client-ip=40.107.215.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fibocom.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fibocom.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VC/JwRvKVMFvmpJrl0kQ7iYu2wbZCR4HDvozvJLIIem+4hQpkvp36QWKj5CRLUCoTx6UpeqlAzjTYNzKhaViZ4PC4B9eyQwqZncA/CYinkO+UkWp/Uu7HfEmll7l5ugvSTne5ixXvreojqZRuvLSeOj8QB1vaQ4DPlYdBuljzNBLDRayDQnUsFwxtgD0InXEWF/w8AkdA1G6pYJmWN9/B6bF+eyaEd4ltOeJtQI5Ttn3+iQl6BvL2iBIYjfQFHYS6OKsOH7nMlQ1hmJwdrTFcTPuvfPI+n4h0AzvJ/To707MwdsDCVetfWxl+FBWcPrTHdHMpobQ5Rk1IAZ2Mw1ZTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q/mYZuakaFRDzPePeUyz8PyKq70GrFfEYpnYQhZH8jI=;
 b=HlC4LOdb4zgyB0F4vkoBVNMhQQgdI36yAF2ZyfvGHgxzPb5aAnXLokfm43HwN51buI/iCWJZehGFkT9FPbGmrgolVtUhZX1BeCHvsT7jokQjZ8l9Ql7a74RQpC8iPq0m1pEJhd7PTqPIelTlwz5dpZw8Lb2L4gE/zL/3xQ4Sz8j1WUMBTu+JKNQl14lo2go7ShC56voQnOHw/xjqAzyM8HPmGHtiwD/AAyjfS1ZDYqgzSVwc9lVA1y0A5SnBu+Qlqbjuaogor/5VC1V3a1smJzPmlqFhPQhCV/87toltD0ZXmHX9q9bIPYoO9hgt73HizSeaOgNA7XFtJ2ddtjRxTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fibocom.com; dmarc=pass action=none header.from=fibocom.com;
 dkim=pass header.d=fibocom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fibocomcorp.onmicrosoft.com; s=selector1-fibocomcorp-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q/mYZuakaFRDzPePeUyz8PyKq70GrFfEYpnYQhZH8jI=;
 b=kQqx9yzWP2TjIegJ+1fpD2cwM/uR4y3j/rQNSTGLXVAFsA8BrfLgMpr0drt65H2FYiF627kCwC+Fb7pM7HWLUKH3WLyh8QzbxgzzJcldFVQatHf2bGj0wDZcod+B26I0rHuiI2QmvajEoBwqGU1dOCjxInbEPjBh2AwRmIg3uLI=
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com (2603:1096:820:dc::11)
 by TYZPR02MB6074.apcprd02.prod.outlook.com (2603:1096:400:25c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 07:41:37 +0000
Received: from KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75]) by KL1PR02MB6283.apcprd02.prod.outlook.com
 ([fe80::87a8:fbd4:757d:2f75%7]) with mapi id 15.20.7316.023; Wed, 6 Mar 2024
 07:41:37 +0000
From: "Bolan Wang(Bolan)" <bolan.wang@fibocom.com>
To: Lars Melin <larsm17@gmail.com>, "johan@kernel.org" <johan@kernel.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Topic: [PATCH] USB: serial: option: add Fibocom FM135-GL variants
Thread-Index: Adpvko0jRh2Nq0RESdW8MpHCbG6u0A==
Date: Wed, 6 Mar 2024 07:41:37 +0000
Message-ID:
 <KL1PR02MB6283F5203E50CD87F344331689212@KL1PR02MB6283.apcprd02.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fibocom.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: KL1PR02MB6283:EE_|TYZPR02MB6074:EE_
x-ms-office365-filtering-correlation-id: 59c7b070-aab2-4808-26ef-08dc3db0daac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uf3oiHAe1MZUE6kJmaSKiPXJf/6asKTm8zvxc8v1ODy905xWNclRX+crABos1CbCS5qbjwtWMX23luQLWiNhwRqIafcPmDQiJ7gFoHtsF+GJf7VTX0TurjariqOH63ppVYUntws5EhI7qE3U/kFFiAVYUHmF8t6l/9UDoD7+7/L/n2lWJPiqxw82GIkqXs/qmVy/DgVDvTr1dNmxEAuRQLGd/MIFKUZ6KAvG2LVLMv5h2jFEl8OHs6R/xMFCAvYb6POhMTtB98ebdvMnQiyjRDU4h/Fy556tr15MMmTK9+je+Ph5i8jYiVp3kCvhd7quI7bzdVSIlEXhL+MQ6govqrbU8hJJlCq+O8PHq+ebLepiHGCtsk4n0o/bFvhittt3qiL+gOC5Fu58Wg9V0z3PIkLrw6nguPY0YYgHSmB39UInhhN3aYEBDQqwhdZ3uKiqmmXlVt2vFXfK7288rmEHFJV0x39k48LEGS8oOqnPwLFBGSQi0f9/9j/db04/j8b7gN2ZmZa5yzeRJOZFtP2euUqpQg0CIxCEzynzpD0T04H8IJ41QQzJ2qg0ZGQ6vjvCI9NTgaaleyMek90cr/8tTssPvdEsNtUN/va3B8C+KF9GQqCrrHT4L+dhsmQE/f83aL+aArrZXMlrP/ujFBBG18ctcgCme+xLtzo6yyaKo47/9tgveABj5BvsiDOPSeADdAgVor97cqwyk7KVJTn+9A==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6283.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bDVHRlhBQUlLUFlSRmpxT1JaSDlHU05OZW9SRWJzUFpaT041UWlLWWRoeHZB?=
 =?utf-8?B?STIwV1kvWEYyb1VpUkNjVFQvSmVzNlJFUDRWQk9rYU5qRnU1MnlLaG9nSlhX?=
 =?utf-8?B?M0dIN1p2T2NRUkJOcGVlTzREa1V3UnRZbWg3TDUxV1RWcUJJYlBnR0lNbFIx?=
 =?utf-8?B?Rjg2ZVhOLzBTMDhJN21IM1JyM011Q1BQOFN1czN3OVZxWUpLLzVpTmFKdUJK?=
 =?utf-8?B?MFFDOTNVSlJQNGIvRyt3VXVMbTRVSnNrN0lIT3p0SG1NZVBYRUI1S1JtcG9u?=
 =?utf-8?B?R2Q2b3dEOVZmamZlQUhFUTdUNUpJZWZ3UUJKSklZQ0NsaTFCSmUxZTd2MHRG?=
 =?utf-8?B?Q05OZXJOTWZTbjAvb2RuMzdUTk1OODI3RmJVQ3M2KytJQmhOdjd6djFHZVpC?=
 =?utf-8?B?TjQwNGZQS3lPV1hWUmxEcFN3aGxpNnUrNzVoSnNNbDlsUG1OVGsrTzdxdHJO?=
 =?utf-8?B?SVhEbDBoTGtzVUtZYzR0cmxHVGd3ZnJBaThyUVduSWVxeWJnRy95akUrenU0?=
 =?utf-8?B?aGpTK3lqUWhTRndVUlFkU3BiT080a2I1aktJS0FPVUM3Q3FGU3labjNrM1ht?=
 =?utf-8?B?b1AydUlPU0o5L0JlQ0J3N1BNNEZSZnJra0NtVGlpb0EzbitlYjRlQUJzRVZM?=
 =?utf-8?B?aGFlNlZIZ0RYZ1hqV2pwaWxxSk5GSFcxaTY0VVJYaTVTc0d5RUxoN21lemJ3?=
 =?utf-8?B?ckVSQk9kU25MUGY0R1BpUDZPYTIvV0QvNko1aENoZENENnhiN1Z4S2hZZ0Yx?=
 =?utf-8?B?TE9OMENsNldDUmtwUldVNEV3RFl3ZjIzdHUyVy8xTWhvVnRLT3Rpdk13dGZE?=
 =?utf-8?B?WUhoaXJCZ0hqWFViUkw3eVYxQ2FPMzV0dDRIRUw3N0I4SHpnUFVDWm02ZXJ4?=
 =?utf-8?B?aG5tdWtzQmFOaG5BQUpFWnNYbVE3VVB4QWpTZHBCK0lNNjRxeDNLWEhTd2Yz?=
 =?utf-8?B?NHR5eXB5dlBNOXNSMmJwU1hDS2VRWUdKbWpIUjFmQ3V2Zm9zOCtaa2ZPSDVQ?=
 =?utf-8?B?V3VkQ0cwajRVZG5nTUlRK2UxN2xuN3cvQ2NDaWxlNkZ4Zm5PS2dNUDUxYTdS?=
 =?utf-8?B?YUxnNmh2VEJsY0plT2xscloyV2p5enNVcFJhbS9YVXRCdWlEbFo3VndJcWRM?=
 =?utf-8?B?enVnWDZwL3JBNWhNT0hoeVpsYVdyRDJ3ZXhKTldVRldLdkZpQVAwMmovbTB4?=
 =?utf-8?B?ZzZZYWVEM2Y4dngwWjdQWTRzdWkrTUpyOEhxZHhhUVVFaVl5cXJuM3RXcjMz?=
 =?utf-8?B?UDB0NkhySnFFT2ZJYkdJbkVpQnJXNXJTTUNsUDZYNU1KT0dwNmRvNU1uVFNq?=
 =?utf-8?B?S2l5eUdRUDRnSHFCQ0cxNk1mUTBPWmVYVmRFYzFTcEttckdhRTM4WERkTVRS?=
 =?utf-8?B?R3N0WFlBbFdoVWZmUXZPRHM0aDdCcS9WS3ZCdnc1dkt1RTlaMWE1emk1VG1L?=
 =?utf-8?B?Z00rT3NIZzMvUDU3M0NSb0g0N21RY01YSmxZTy9Xd1g3djQrclpJWFRnckNK?=
 =?utf-8?B?LzcxeDVlUHdocDFRZ0tMcU9XZndPRTBaQkIrZTJqcUhYS0Q4VVBLdzlpWnlq?=
 =?utf-8?B?VUZjMlR6Y0d5eU5wekRtK1JWQ2syRXpFSnNibUFya2JJd0p0UHpIcmMvL2FV?=
 =?utf-8?B?TWFXMkhRcXZnWklVS2lQYm5zSTZMK2JFUGdVZmJNbWh1VWtPSnRTTWZhY2U4?=
 =?utf-8?B?TUt6eERkUUVsL0Q5VXZGUEJ6b2cyemRiWDc1aDlDbndZQ080WW1zUW9KZVVv?=
 =?utf-8?B?SFJwWXdaL0FudDc3ZWprTHN2UWlPL2VPR3FFWHVEb0hkOGxIM0htZnpqVnpJ?=
 =?utf-8?B?d3JtRG1WWTN5ZTJaS1NzaGwyQnhiS1pNL0ZadjlqQ1dRb0p3YlhSTERlaW1p?=
 =?utf-8?B?ZTFBNFo3ZlgrU0RQTzlta1BjV1d2R2pvdXlzdEFGWUtUYzVEOXd1anZCSGFF?=
 =?utf-8?B?M1UxSXc0TllnZWhiY3ArNmZVc2F4dlduL0lCaE5SKzZnOVZVTGdGOWUzemc4?=
 =?utf-8?B?bTV2dUFXeFFIOTNEVFB0S2ZzUU5kYTRaQWhsVnY0MHhLdDlBYzJRNCtQWkNN?=
 =?utf-8?B?WHFydk16NE1Fd1k0SXdINnVQblFVMTM3L3g2Z2ZsYkp1c3pVSC9FRzhMVUNr?=
 =?utf-8?Q?4ufec39zR2rcVmtGUkVysd5C2?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: fibocom.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6283.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59c7b070-aab2-4808-26ef-08dc3db0daac
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2024 07:41:37.1392
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 889bfe61-8c21-436b-bc07-3908050c8236
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ID8GmbrTVSF4MD/kLEqFZIbb61K6THwI3juzMyLMIgDPVWZGq8o6858jPnEkHv4yw5xYDpxvGS5qnGNst4bfRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR02MB6074

PiBIaSBCb2xhbiwNCj4gc28geW91IGFscmVhZHkga25vdyB0aGF0IG90aGVyIHZlcnNpb25zIG9m
IHRoZSBjYXJkIHdpbGwgaGF2ZSB0aGUgcGlkDQo+IDB4MDFhMSBhbmQgdGhlIHNlcmlhbCBpbnRl
cmZhY2VzIHdpbGwgYmUgb2YgY2xhc3MgZmYgYnV0IHlvdSBkb24ndCBrbm93IHdoYXQgdGhvc2Ug
aW50ZXJmYWNlcyB3aWxsIGJlIHVzZWQgZm9yPw0KPiBZb3Ugc2hhbGwgb25seSBhZGQgZHJpdmVy
IHN1cHBvcnQgZm9yIHdoYXQgeW91IGtub3cgdG9kYXkgYW5kIG5vdCBmb3Igc29tZXRoaW5nIHRo
YXQgbWlnaHQgb3IgbWlnaHQgbm90IGJlIGltcGxlbWVudGVkIGluIHRoZSBmdXR1cmUuDQoNCj4g
Rm9yIHRoZSBkZXZpY2Ugd2l0aCBwaWQgMHgwMTE1IHlvdSBoYXZlIGxpc3RlZCBhbiBhZGIgaW50
ZXJmYWNlIGFuZCBhZGIgaW50ZXJmYWNlcyBzaG91bGQgbm90IGJlIGluIHRoZSBvcHRpb24gZHJp
dmVyLg0KDQpIaSBMYXJzOg0KDQpPaywgSSB3aWxsIHJlbW92ZSAweDAxYTEgZnJvbSBvcHRpb24g
c2VyaWFsIGRyaXZlci4gQW5kIHRoZSBhZGIgbGlzdGVkIGluIHBpZCAweDAxMTUgd2lsbCBhbHNv
IGJlIHJlbW92ZWQuDQpBY3R1YWxseSBhZGIgaW50ZXJmYWNlIGluZm8gd2l0aCBwaWQgMHgwMTE1
IGlzOiBDbGFzc19mZiZTdWJDbGFzc180MiZQcm90XzAxLCB0aGUgb3B0aW9uIGRyaXZlciB3aWxs
IG5vdCBiaW5kIGl0Pw0KSSB3aWxsIHJlc3VibWl0IGEgbmV3IHBhdGNoLCBwbGVhc2UgaGVscCBy
ZXZpZXcgYW5kIGFiYW5kb24gdGhpcy4NCg0KdGhhbmtzDQpib2xhbg0KDQoNCg==

