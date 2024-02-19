Return-Path: <linux-kernel+bounces-71877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 293EA85AC20
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EA971C21047
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2C750A97;
	Mon, 19 Feb 2024 19:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="RNlnjOlT"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2093.outbound.protection.outlook.com [40.107.9.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3604544C86
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371442; cv=fail; b=hxC2VzK0w4GwxJ5xt4BPkdWlU8al9dLEEfvy3eskDjbA7oKU9Ol1tPI2SZNZMLIQRIR2tJe6BhEFOhxcXEkOjFZRp0SHKUlS/XNng7O7K3W3UuWmn1XeJzyQJnQfcbv/FkP5pmN6cr2ZFv8sFaDxKRYs8iFpIzX/PUi1JkU+dt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371442; c=relaxed/simple;
	bh=m2Z2mvMuoxNNdwhEPust+2q6gJFIpi+h/Ujzq+0we7k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UBY3ba64t4hZoxeZiNZmhsbMN7lr9pEoi7AxHS02P+MnS50Se/VdEjyj5zU2ro7wxHJIh3P6Xiz/NwotlRwfrphiFTkyZQA31EBw+JNFzwPZlMMGKQflJKNHGQQ8fR2oEgQqMbZnAw6iYDLgkbPsKXLOE8W9EdzuvHhaEbMEFhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=RNlnjOlT; arc=fail smtp.client-ip=40.107.9.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBvhX6iuOwLW//FlRPFZq7AKfNh3xrs2i1wQfgGkeb++14viNhuBPbUkEi2Fv7URHkQtiifiYGTz9ZbumOzvXFkSx42MrGNfkrjLtJ1VobKuoha6eZGlaa33hqdl+I+MtigYQOpkCh+qrZ/F9DHPQ4JzP8KcAAY/ERf9EhN+B5bmWWHiBbMcS7W5jwkY4ucBwURsnYwr3rLggBqXEKH9tG4p0TBsCgFkatQsHZJVDqawbuVdX8b0Uqlzf0nfuuwFFo0jdHup91ybA0Tf8It64AV4HayA50M8XW9tCANULc8idmnr3P8KwevFYxWqUXj3bzRCTrWSRRQdTzI26+SIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2Z2mvMuoxNNdwhEPust+2q6gJFIpi+h/Ujzq+0we7k=;
 b=BCsRCBCfonic3fJHHCrL5LUrGHqoInlMcO7M9zaz2bIuGIuzNPv9KZyGFLLNq6LrrAyDpj1avGhqUmiFlXRREq6zGg6PCMyU+8fg+5MhSYhf00CencW9vIOZkyG7sudpHn5vrH5Ky4na4C5Ky7bnqPAo2/wrWfekSE7dBbnE4P1Tq5yiyk2j40mRrTpQZywKnlN1+q6GJTcsodSLWrFOp+wuQjc1thPYGNWjUknvPUKk8GYL4DRrRgHLT31ZQ1pgu1s55YEITOrhXqyIAOtsBDBoXE6a+PPJPv5bihl73v1Dqw6hrQU57uVpV3sowPnd39RpKUsafUyHCCeGHuxT4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2Z2mvMuoxNNdwhEPust+2q6gJFIpi+h/Ujzq+0we7k=;
 b=RNlnjOlTmcWEsmkQ+i97aoXJK2zlnHvTNogFsYW6eKn9yWg9xDJyhhHjqBv5Uz5d5lypWHoXgv7VFfyauXzeYFHstajXB18UiAyyLAHGIzya2cfCR7mq/Pb8rk3frQvN1KWDnngISE8uHlyXLlgSDh6iMWR8kuNr6ghCjyyQx6FzkegzkqF8gifK9xUOjApvKnZCU1c6lgmvP2BLrUZq6t1bvHIqaXUJKy3mkF/sa7/lE2no7cnyiQrF/sLpV/MCXhVvnPRMqeFLrVgGGH++68ZgeOFy1MoWpU1ao6oeU1I2sSqXipND0eDRjuPVY9b2c6eFDkyjh40MYTsgnmktCA==
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 PAZP264MB3087.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.38; Mon, 19 Feb 2024 19:37:17 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::91e3:2737:5a73:cc27]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::91e3:2737:5a73:cc27%5]) with mapi id 15.20.7292.036; Mon, 19 Feb 2024
 19:37:16 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Nicholas Miehlbradt <nicholas@linux.ibm.com>, "glider@google.com"
	<glider@google.com>, "elver@google.com" <elver@google.com>,
	"dvyukov@google.com" <dvyukov@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
	"npiggin@gmail.com" <npiggin@gmail.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "iii@linux.ibm.com" <iii@linux.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/13] kmsan: Export kmsan_handle_dma
Thread-Topic: [PATCH 01/13] kmsan: Export kmsan_handle_dma
Thread-Index: AQHaLlLqGF6G1r00j0eFh2nARNDtb7ESeXAA
Date: Mon, 19 Feb 2024 19:37:16 +0000
Message-ID: <b1b0e05b-099d-4667-a54e-16575e83a327@csgroup.eu>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
 <20231214055539.9420-2-nicholas@linux.ibm.com>
In-Reply-To: <20231214055539.9420-2-nicholas@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MR1P264MB2980:EE_|PAZP264MB3087:EE_
x-ms-office365-filtering-correlation-id: a97c7e72-7100-422f-93a2-08dc31822e23
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 8tHmjJKJ23zxmk0bQaw9oTg9PlXz++Yn6JmXIcgU+KuNA1ATZFYYnbLgbygnDvJjqIlZpTMfcNVIN4DRSwV2F5KaupzzVUjSvDVKtyko23HgmkqizFcTJyx3jfnBs8OtdJqEcXpxABf2+J8m6u8zIiAj+3jNfHIa48WfDNcYOZuLM20KolSIEAjot4HDi+ZHrAPOps9wS15zdnWkXbporXZZCdOdUolXE4VF8pa9kG84n5SZ9ZuoVdIWPunA9vpj1v2e+kFhdpdsllwf9T/khdJi/WnWKfOxRMdJ2uoqREhjpHzDHhrca2Wva8+6HbHdY/t7OE75y9wFyGtfbVTwuLAPAmuKZJQG1F/7zYGhSN6CY7H8LySBEw/bfYnXCp21qI4j+aNCzxlSfJyxbacYmyozDxYLf+wEloctz+/yNg3h7hpFD7at4nlDV5+tv1pTKFxUuxkwkSPgBHDP96966KR6FW6UjYy/hp0fwtJKt5gL02Adpua75NibXAxyW8ZVrw1G+3j+B+ORpJSx1cX3wTYPLyHbYA3VAZSDt8Sbm5DYwUFT+vU4LLHw9sfUbDUVVkOsAC5hpJPH8IJuMA/5sCEEcjKF3VXrcmGyZ8fDxDhD2cQVidN06sIWso737Xls
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWtMRC92M2tCL3dzQ1I1UFFxU1hQK242dVBXclpma3RGTlM2WFpBOFNMS0hx?=
 =?utf-8?B?eGtsdnJydDMxa0k5VHk0TU5mZnJFcmdHUUpIY0hNZFUrb0pYRzV3aWtpKzNZ?=
 =?utf-8?B?VXc3YmRQcFVqa3ZRVGE5SllhY1M5czhuWjNCWC9nOGR0c016YTZZd3FQYzlK?=
 =?utf-8?B?V1RpRlAxaExveitKanFRT1FmZzcyUG1wb2RoaGJXWW9yOUN0Z0t4aldsVXN4?=
 =?utf-8?B?clBGb1d0SU5PMzl5RnlpK0RhNzg0cHdpd0dBam8zQ0RNaUwyY3dRLzlydFpy?=
 =?utf-8?B?ZzhhMXhzS09Cd1B5NnBvc1NKeEZWUWlCYzRwdDY0N0hFdTZPRHZaL0EranhF?=
 =?utf-8?B?NTI1T3NFeFFCM2hlT3UxbEJyM3h4Slhsc2ZPMzgvWXV3bGZTZHp1RHY1UGkv?=
 =?utf-8?B?aEFXdVVDWmM1NDdhZXl0Tml0VHFuYnZFYi9naUFWb2VVcVJKV0cySmluTzNQ?=
 =?utf-8?B?ZW8yRGRZeld3RGlObXg2cnExTUJuaVhBZWptenVCMi8zQUZXeDlZcEYzQlNG?=
 =?utf-8?B?d240MEpaM1hIY1JPSXFTQmZwMzhmbi9LYWdxR3lzYjhlT1VVaERDcUNWOWNy?=
 =?utf-8?B?QjNXem1DVHk3U2pVSXVVMmV5czlXSkxhbm0xU1pZcHAyK1orM2Z6dkVNZUR6?=
 =?utf-8?B?bk95WmgreTRicUlha2JqYU8xd3hCQ1NldDI1d2xXc3B6QmlJb1hrYU1iRlpM?=
 =?utf-8?B?MGJ6M044Ym8wSmFxcUszdUpPQUlhajdNMW8yd3NBSitkR2hZa3lwdk1YdUxj?=
 =?utf-8?B?NzgwV3NTNWNmUWJNM3RiNmZaRlpZZFMzdDd0SFU3Q3lqZ2hwNExlRHRJS3lM?=
 =?utf-8?B?WmxHMWNuazQ5K21WdXdzSXRpeHplWDNycXMxV3BVMVVDUDlEa0hhZVZOWDdw?=
 =?utf-8?B?UE1hb1BIam4yaUEzSEY1ejZtUk9xelhxMmtFaG1zN3gwQjNhSUZUaGgwOUwr?=
 =?utf-8?B?a1V3VWxMUUpEU2t2UWMvSnU4dlpsd25kck1sUnhlUFlWVGgzZlppVkYxVTg5?=
 =?utf-8?B?bGkzY0FRc3JaR1E2QlJmdGMrYW1VTXhWdzU2L3YvMTZvOUlLenM4Znhld2Mz?=
 =?utf-8?B?TmlTOU95UUMzNU1qNGxsUWNDdW9IK20vNUQ5dTNYdGQ3UTFEdkxRNjJPQ2ZX?=
 =?utf-8?B?VHIvaXgwd0tiM3BZc1M2K24zQlJNVlllQlVURU5vQndsT01qK255OEhOQnJG?=
 =?utf-8?B?SXhJeklkT0QvQVdOeUJoZlNWazhSTUpDMjR6SDQxaWRjNXZ5WC9LbmxCZi9Z?=
 =?utf-8?B?M01XaHBHcnVnMnZOOUN2L3lQOXh3ZzZ0YVBnTE1pbHRULzZ2UFRDcG1OUTcv?=
 =?utf-8?B?NitmeGViT3FSOFJiRTNYS2plQ202QnArUmQ0QjFOc09JdGF5enUyYmRGZmJl?=
 =?utf-8?B?bkhKZUpnK0JQMk1rOFZnVnVrZnBEczRaTm5ON1E1VHZ1Zjh3Wm5QV2M5Ri9z?=
 =?utf-8?B?YkMvc0l1aUQyTEpDUWxOV2dBbUtQT0xla0xPVk1mOG9pVEZ4M0R6cXpGOGt5?=
 =?utf-8?B?WkYxVWhOc3BEOVRHbGJQL1ZTdnN3SkMrNnNmZkpaUTQ5Rk9iUlpaOW9hSjNt?=
 =?utf-8?B?Wk1YYXh2OWlpK3M4Tm9LTCtWVUJxdnpKTUtlOG4wRUg2Sk80b0UxeWtpdU9h?=
 =?utf-8?B?VDBVeWkzSnM1YThVLy8zUEl3dGUrZXk3VW1PWk9BYXFRL1hCRDloU2lkdVdL?=
 =?utf-8?B?NllUUEJlZ3F0QlJCaG1tM0V3VGh2QUZPbytLdXMycFhmSDJOZUQvRnpnVitz?=
 =?utf-8?B?MUQ0YVpienNlUG1FSlpnRGFqcTRIUjQ0bHBJb2wyWWFiTnFkZHdKY0dQU3kx?=
 =?utf-8?B?djRDT04xRndsdVJ4cGhmS1lFSGRQTVcwcEowWnVqMjdaaXo3UWhCL2RVV1kr?=
 =?utf-8?B?UXRWOFNicEZoYlczWk1UNHozSkhUZ3l5aVJWTUN2YzFSVGFpMEZyMmU2QWZn?=
 =?utf-8?B?SnJrWGNyRWxJVHFLMVpPbXRhWWxyTmErelZlVE9MVWk4anNRTHpUMS9nUkc3?=
 =?utf-8?B?YUlGaVFhdi9MT21naFQ5MkprM2ttckhiTVQ0UGNId3I3TUh5amlBUjNab29G?=
 =?utf-8?B?RkdlbnBJLzhaSU5tbWE2VGtjR3pXNGQ0bXJRVkNJN2Jia21yUlp5aTQrQnVq?=
 =?utf-8?Q?Mck1xvAeHXUZg3tP9kUiCZ5eh?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DBF264256FE114EA010ABEBC0F35806@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: a97c7e72-7100-422f-93a2-08dc31822e23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 19:37:16.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Gd5KW6zGeEGqGUf3ibS/n55GuppiX4pX0xwc+UisJX2D3wcYPAbDMo9XTb+qS78dkZmDVm457x46WnEv8j4soZLEdO62fJXCvwJcoToPJq4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3087

DQoNCkxlIDE0LzEyLzIwMjMgw6AgMDY6NTUsIE5pY2hvbGFzIE1pZWhsYnJhZHQgYSDDqWNyaXTC
oDoNCj4ga21zYW5faGFuZGxlX2RtYSBpcyByZXF1aXJlZCBieSB2aXJ0aW8gZHJpdmVycy4gRXhw
b3J0IGttc2FuX2hhbmRsZV9kbWENCj4gc28gdGhhdCB0aGUgZHJpdmVycyBjYW4gYmUgY29tcGls
ZWQgYXMgbW9kdWxlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE5pY2hvbGFzIE1pZWhsYnJhZHQg
PG5pY2hvbGFzQGxpbnV4LmlibS5jb20+DQo+IC0tLQ0KPiAgIG1tL2ttc2FuL2hvb2tzLmMgfCAx
ICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQg
YS9tbS9rbXNhbi9ob29rcy5jIGIvbW0va21zYW4vaG9va3MuYw0KPiBpbmRleCA3YTMwMjc0Yjg5
M2MuLjM1MzJkOTI3NWNhNSAxMDA2NDQNCj4gLS0tIGEvbW0va21zYW4vaG9va3MuYw0KPiArKysg
Yi9tbS9rbXNhbi9ob29rcy5jDQo+IEBAIC0zNTgsNiArMzU4LDcgQEAgdm9pZCBrbXNhbl9oYW5k
bGVfZG1hKHN0cnVjdCBwYWdlICpwYWdlLCBzaXplX3Qgb2Zmc2V0LCBzaXplX3Qgc2l6ZSwNCj4g
ICAJCXNpemUgLT0gdG9fZ287DQo+ICAgCX0NCj4gICB9DQo+ICtFWFBPUlRfU1lNQk9MKGttc2Fu
X2hhbmRsZV9kbWEpOw0KDQp2aXJ0aW8gaXMgR1BMIGFuZCBhbGwgZXhwb3J0cyBpbnNpZGUgdmly
dGlvIGFyZSBFWFBPUlRfU1lNQk9MX0dQTCgpLg0KU2hvdWxkIHRoaXMgb25lIGJlIF9HUEwgYXMg
d2VsbCA/DQoNCj4gICANCj4gICB2b2lkIGttc2FuX2hhbmRsZV9kbWFfc2coc3RydWN0IHNjYXR0
ZXJsaXN0ICpzZywgaW50IG5lbnRzLA0KPiAgIAkJCSBlbnVtIGRtYV9kYXRhX2RpcmVjdGlvbiBk
aXIpDQo=

