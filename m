Return-Path: <linux-kernel+bounces-90519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5279E870086
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 853D0284107
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E04EB3A1B1;
	Mon,  4 Mar 2024 11:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="d1TsflQF"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2098.outbound.protection.outlook.com [40.107.12.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32ACA3A1A3;
	Mon,  4 Mar 2024 11:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552348; cv=fail; b=lEybxOZC1F0YwEU6MaQptOjnwQwztgMAkmJR9BD8Ip1yYaxqDJsA6HdGgDpwjRyhbonbibEMSBSw9mMYgN+l6AkDPTrtllSxFkhW60DQ8zwYretfS7aEecMkHT385AZfl7qdsfQKxGEVEX7JfX9pW2jOpOPKvytNLuzZ3oKdskM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552348; c=relaxed/simple;
	bh=NBrasRAnRzwIWvEqzbDSF1YZY/WTRKljD1LMHx21oCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FmsbqmpnwYC1uSImUBCbgwJymGjw/4pvsap1+DHL3W2vifqV0+Bf5MmFz6wYrUlkarsPItIHuQpEvCAA+0nwXLJ9Zr0xbUz7bw9jDhKdSoYKuMdT0z47vxXiETY02U0qDiifTEvLf5A09hd+i0Bqu3FSIUOzm6BrSskOAI7dEHA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=d1TsflQF; arc=fail smtp.client-ip=40.107.12.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G9NwPgthzmU1epnjZmAlyvSHzm7fHij+/kx0mvHfAn6pbNL+dAnbzhg9dR2GTGMROQGKUG1WvEDDjXif2NFkmajv5Ev3V/sh8zs5a+bVMXGLpDgHveL/xtDZk+jqSLsrtG5HY9BQnuqLb7u8M8nDFpS08VI/pMQ5bXaRfJ3LHELBKjfthv4PINH0Ij5ZYx4P/yQOJnscaTxhm7DPUEXxFMy/QAXxzWpcJulkwZAOJgGo70iqn9yzs+rtzDtBQDMKiZvMJVFFBaSRDYvgYsVKf19J06TGZ+y81wUhip3rVuMwm1U7ctAdd8WbpoDYLzPo7SuEKZq7BuzcY87aOQBNuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NBrasRAnRzwIWvEqzbDSF1YZY/WTRKljD1LMHx21oCw=;
 b=I2koNTaZ9UkHrDlBBOvBJCqW2gbN7tLsNUvOdwl+IiDX2XmAcJLRPT0AOuU+UTC95C6sU4ODViudElkgR6bI/jKDc0e5/+IY2Tzj49fIe7lELIBXBHTxENt2dwRJUy2aEKiVAf/77bqCEUqH/pXCM5jwXXwHPZDfPLOaRGnuSl9wuLIGCWFVtYYU0BA9NsXeXBIboo3+3MIZ3RA2NhcbsHakieTS8F5JwFVBOL0eocbB1w12A398yEtYsdSo6gbz8wzBnCoiYC1GlDzEaBakCFnahp/mfUdnV48wXhC4kuW5Xq5BWRRAWhxuMFNp2GmF2A71BaCP0CoTYWOHGaTXCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NBrasRAnRzwIWvEqzbDSF1YZY/WTRKljD1LMHx21oCw=;
 b=d1TsflQF28Jxr1R5zqqvzogAdy3A3OOCi4zVVIxyJ1j6GdZ01Z4If5TvjfALe9o6WyUgd53019Rni7rj3CKFjuF0w5R+aJkknaffQFIHzCeAlaIhiBO8NBfeA1t6fgbK1fez4+IsRksGECjjVE6qFbS8OClK4rMeZRrTt4wMhM67bkoRDx/5u3myeg/SdE/hSxw1lcz0yovRybHW66DKFobaYWehXQXhY39roxfhWePOTMAMSqQfUF04I1ohUCaiFKlmkPOUHknBMlYSW1p2yIV1WQlUzFTtkR7GRX2jCgyZy0OxWgwV5C7FTRDIkjgTIaNg5mjg+vD8YeT55eGoEA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2423.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 11:39:03 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 11:39:03 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Russell King <linux@armlinux.org.uk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@dabbelt.com>, David Laight <David.Laight@aculab.com>, Charlie
 Jenkins <charlie@rivosinc.com>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, Palmer
 Dabbelt <palmer@rivosinc.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
	Arnd Bergmann <arnd@arndb.de>, Andrew Morton <akpm@linux-foundation.org>,
	Parisc List <linux-parisc@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaa2FN/UPATTv23UaTwsptpp4BsbEjNucAgAKbLgCAAFWagIABUqoA
Date: Mon, 4 Mar 2024 11:39:02 +0000
Message-ID: <4e227412-ccac-4771-8aa6-a716e7c07090@csgroup.eu>
References:
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net>
 <f422742a-4c86-4cb0-a4f7-a62f0310eb23@csgroup.eu>
 <6df98c91-26b1-497a-9202-18bf86c0130d@roeck-us.net>
In-Reply-To: <6df98c91-26b1-497a-9202-18bf86c0130d@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2423:EE_
x-ms-office365-filtering-correlation-id: dfcf3226-0fa0-4998-f386-08dc3c3fb0ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iZNIpLs46OEkhkHA7wBBYkn5sojGqgIabMECJTCNBj71/x6dvxivFua6lzDej1STmkMDntNcRqqrTVG7qzaxSak/gjmx8Kls8tQfDOo4xB+mu6HRGaLIz96UloXdFO3pMbeY3A9WCvl7oymO4sa/0x+ox17o/BPV4lq8IzHCZqkv0z6Ur+Oc0nEggV1I3K0y0Di2Yq6sIJtVbMOq+oDElakxyJWKQXObkXXH2cCoLXnXbHmLuTWIK08SLQBzi9/teDgH1EfxKdEWez/T9GCWXL3tBrOY7ptIqc2LwNcqEQLtc3vYE3730prsZ1+eERng3OKg5jqH2722BL1GPEeROYvoKgXRn/7NLd3WxuPtwo6QPYm7186l8C/Fq+eL5ayTItwxRe3xK51eoZ3APeZ8blfXY30P46glzc2m3BPv3fidakg9muCiDJmlf9uhUb9eAT5yMqKNLkh7PdApSSCBaqAB+j8sS3IRADnfYSAduyGgOX0b8YqRgnW9yQKhkZnvRItEagEoaNgZRl6Mt/NbgJbapewnyVbw+C4qAr9iHvph0kwNYCv0JABbRnjbj+2KBIRmDlzhX1Z0LaX28jehKlBFf33wVRXswfJoY4tCeBkmOdFOtYJOSJkE2Fd26al6g6xTBUMFsRggzycVHbJdcuB8Eyvax83jSRnZ8eBckY+eBEZjWfZWtlPjCH/OB8t4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OG5BdWY0cGNkVjZ1d3p3cDF1MjFKZUs4Vk93VnV3U0dCaDNUU09xZzh6UHlP?=
 =?utf-8?B?bjJaaVJjY0cwdVN0cjd3d1ZxYm9yWVpkaVN2RWtiMmVYSlNxWFV4VGtEOUxa?=
 =?utf-8?B?WXUrSEEvQ21xemk2b2VmSjljeFZLaVcyYjVUbWVDeCtEMjN5bTJYTTFRS3FC?=
 =?utf-8?B?VXoxQmozUXZXUkdFbXJBNCtQVUdyNTZ5K0dibHg5T3Z4aEJyVG1QdEpJQWRF?=
 =?utf-8?B?bndnNUFiZ3ZNeXRKNTNXQ0REQXVDLzNaZ3MwczRJTFlpZW1iOXd6VFZvUXZq?=
 =?utf-8?B?b1UxL0huTVRNRTBreG0veFNKejROZXZtUWM5cW1DWTY3K1hqQjVWRzlPamZ5?=
 =?utf-8?B?Y2txR0o2SC9NeXFSeVdsUEdzNjdURWloR0Uxc1Ara0JaTUxXOG1IRVZuaGFR?=
 =?utf-8?B?N1lkVkVSZjhJZVQ1djMvd1kwR1dwMGZJVjFkcUg1cHVpWlI2cVdMNC9hcnBB?=
 =?utf-8?B?MjlQZm41NGNZZkY1dTJ6T3lpTzk5dFdER1RXZXNBZndRMU00YlZIbm11TDd2?=
 =?utf-8?B?U0hNTWVjYWZVNk83MWpGMVEySmdHRFJCVHkvaXN6dDQ1RTZOc0RldDh5aVV3?=
 =?utf-8?B?Wkx0RCsyWVp1SEhUYkM4elI4MkJCTUQxMFA1Y1NmdTN5dWprVWd4SjRPMXNH?=
 =?utf-8?B?WWZJTXNoNjNGVUxxTkdHb29CU25PdGxjWGw1c2d0WWIxOUFodi9NZEFJNmVZ?=
 =?utf-8?B?THoxVDhmeExSZElLanJaN2xQS3JEcndtenREeVU3YjJUQzlqbDB5bk9TRW1R?=
 =?utf-8?B?dFEyWkx3UHdRVXFuQW9yeUdCcjVPWGw5ZkxyZERBcFNFMndtS1VtSEtGam96?=
 =?utf-8?B?OTNyK2RzckhTTnRFVEcyalFlbkh0a3V5RU5QQnY4UDY3UnFZMENLQXlrd0ZO?=
 =?utf-8?B?ZkczVm9sSDBCV1JueWVpQVVubGFmaHVYUGFEOXdBWXVPdm5DdS8xd2kwZ3RR?=
 =?utf-8?B?azkvWndVZXRtbXM0T2VXcEI0V0JMUmFxemE5NURTYmZIV3I1QTFIVEJ1WU10?=
 =?utf-8?B?QzcyVUQ2Qk1wMjhkSlhNS01heDRKZ0Z0Uzdwa0FYTVUvZS9kamhMblFvR1Y5?=
 =?utf-8?B?QXB3ektGVkYvN2dLUzBQZVZsakZwN0ZWUTRqT3QrRktaUHR1MGNLdDk0aW1t?=
 =?utf-8?B?QWFNRHcrWnRsYXdLaEdVcUc2MUxYc3BNei9RS2dpVkV4dndqWFk2QlFtMWZk?=
 =?utf-8?B?VFR4SjNKUk1uRTB1RmtOMWpLdXhiTzM4THBPSUlaMGpRaTZ4MFZ0eERTSHFP?=
 =?utf-8?B?d3Ayb1YzK00zVG55akpEMEJqL3hBMi9OeDJ3VmpFZGdaQ1JNc3ZxR0lvMmIx?=
 =?utf-8?B?akszamVVMkdDdnQ3ZkQ4VCtjS3VRblVXaXNPckpxYUdsS1VyQkJDMS95RHVK?=
 =?utf-8?B?dklLYTNSMTFSejJKSHZ1M3FqdWRRdXd5VnhlRkoyNGNRL2NHYU1hcGM1OW1D?=
 =?utf-8?B?MEUwTmlyNW5mRFBmNExGZngreTlYMGVUYW1qb0JES0lDMTdkV0hWUzN1QjlY?=
 =?utf-8?B?TGx0OG1oMjE0c24wc2lSZ1VvOTA2QncxaTA1bXU5ZzE5eW5vUUgzd25XMkhJ?=
 =?utf-8?B?ZGx1RTlZTFltZVYvUnlXb0xwVE9EL3pyajViVHMzUU9CVkdRNXI2RUJSWklm?=
 =?utf-8?B?b000YWpqelNNNXBQdTZYU3hrQUZNTFU2ZDdHdGx3R1IyRlA4cytSWTY3TDlq?=
 =?utf-8?B?UlNtQ0YwSndTY0RFNGFmT0wyd1dUNzNEVVMrM1I2RzNZNmhQUHdWYkhhOTZv?=
 =?utf-8?B?MVNFQjdVbXV1Z0YxRFV2QVpJcWFWNWJhcVVyWTJsRm9aUGxnT0wvQW5WTEQz?=
 =?utf-8?B?MUx5b0p4RW42ZFFpdEl2VVhrakdQZVBwNGxEUmFBbmZIQk1WTVpQdmNWY3Ra?=
 =?utf-8?B?aXVuZ3VTZTlCaW52NlB5ZHI0QzdyKzlSQ1UwQjllRTVIbHJud0NlSGlyNU5o?=
 =?utf-8?B?d21nbkRqY29VZDIrMTZTb2ZmYlByM2RtQ09rSkhEb1FGUkdaWWFrS3VKVUU1?=
 =?utf-8?B?RXN4TE9jeFpuVGp6dVhEVVdQOHpxUVoyUUViZHQxd25CSW5TS3pTYXd2RG5D?=
 =?utf-8?B?VDJwdE5udk5tSXQxSE9TM0RqSm4xSVJZWTYwZ0hmSFlqbzJaZlhlakNWVDJE?=
 =?utf-8?Q?XRfidOYtzQelq35O/iiZVfaqo?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B308E9D333A9FC4BAC7D1FA152FBD469@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcf3226-0fa0-4998-f386-08dc3c3fb0ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 11:39:02.9341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WnxEbQqeHrS0Q3o6nFzEYDU8tcaix7+zqzobE5u4L9Wn8s+yRfByiOATdDzAjGNQrM6o3MKUGG0ou3dAU1wydEWkV2VQxge/qXHN7ImrtM4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2423

SGkgUnVzc2VsbCBhbmQgR3VlbnRlciwNCg0KTGUgMDMvMDMvMjAyNCDDoCAxNjoyNiwgR3VlbnRl
ciBSb2VjayBhIMOpY3JpdMKgOg0KPiBPbiAzLzMvMjQgMDI6MjAsIENocmlzdG9waGUgTGVyb3kg
d3JvdGU6DQo+Pg0KPj4NCj4+IExlIDAxLzAzLzIwMjQgw6AgMTk6MzIsIEd1ZW50ZXIgUm9lY2sg
YSDDqWNyaXTCoDoNCj4+PiBUaGlzIGxlYXZlcyB0aGUgbXBzMi1hbjM4NTptcHMyX2RlZmNvbmZp
ZyBjcmFzaCwgd2hpY2ggaXMgYXZvaWRlZCBieQ0KPj4+IHRoaXMgcGF0Y2guDQo+Pj4gTXkgdW5k
ZXJzdGFuZGluZywgd2hpY2ggbWF5IGJlIHdyb25nLCBpcyB0aGF0IGFybSBpbWFnZXMgd2l0aCB0
aHVtYg0KPj4+IGluc3RydWN0aW9ucw0KPj4+IGRvIG5vdCBzdXBwb3J0IHVuYWxpZ25lZCBhY2Nl
c3NlcyAobWF5YmUgSSBzaG91bGQgc2F5IGRvIG5vdCBzdXBwb3J0DQo+Pj4gdW5hbGlnbmVkDQo+
Pj4gYWNjZXNzZXMgd2l0aCB0aGUgbXBzMi1hbjM4NSBxZW11IGVtdWxhdGlvbjsgSSBkaWQgbm90
IHRlc3Qgd2l0aCByZWFsDQo+Pj4gaGFyZHdhcmUsDQo+Pj4gYWZ0ZXIgYWxsKS4NCg0KLi4uDQoN
Cj4+DQo+PiBDYW4geW91IHRlbGwgaG93IHRvIHByb2NlZWQgPw0KPj4NCj4gDQo+IFlvdSBjYW4n
dCBydW4gaXQgZGlyZWN0bHkuIG1wczItYW4zODUgaXMgb25lIG9mIHRoZSBwbGF0Zm9ybXMgd2hl
cmUNCj4gdGhlIHFlbXUgbWFpbnRhaW5lcnMgaW5zaXN0ZWQgdGhhdCBxZW11IHNoYWxsIG5vdCBp
bml0aWFsaXplIHRoZSBDUFUuDQo+IFlvdSBoYXZlIHRvIHByb3ZpZGUgYSBzaGltIHN1Y2ggYXMN
Cj4gaHR0cHM6Ly9naXRodWIuY29tL2dyb2Vjay9saW51eC1idWlsZC10ZXN0L2Jsb2IvbWFzdGVy
L3Jvb3Rmcy9hcm0vbXBzMi1ib290LmF4Zg0KPiBhcyBiaW9zLiBZb3UgYWxzbyBoYXZlIHRvIHBy
b3ZpZGUgdGhlIGR0YiBmaWxlLg0KPiANCj4gT24gdG9wIG9mIHRoYXQsIHlvdSB3b3VsZCBuZWVk
IGEgY3VzdG9taXplZCB2ZXJzaW9uIG9mIHFlbXUgd2hpY2gNCj4gYWN0dWFsbHkgcmVhZHMgdGhl
IGNvbW1hbmQgbGluZSwgdGhlIGJpb3MgZmlsZSwgYW5kIHRoZSBkdGIuIFNlZQ0KPiBodHRwczov
L2dpdGh1Yi5jb20vZ3JvZWNrL2xpbnV4LWJ1aWxkLXRlc3QvdHJlZS9tYXN0ZXIvcWVtdQ0KPiBi
cmFuY2ggdjguMi4xLWxvY2FsIG9yIHY4LjEuNS1sb2NhbC4NCj4gDQoNCk1hbnkgdGhhbmtzIGZv
ciB5b3VyIGd1aWRhbmNlLiBTbywgSSBkaWQgdGhlIHRlc3QgYW5kIHdoYXQgSSBjYW4gc2F5Og0K
DQppcF9mYXN0X2NzdW0oKSB3b3JrcyB3aGF0ZXZlciB0aGUgYWxpZ25tZW50IGlzLg0KDQpjc3Vt
X2lwdjZfbWFnaWMoKSBpcyB0aGUgcHJvYmxlbSB3aXRoIHVuYWxpZ25lZCBpcHY2IHNvdXJjZSBv
ciANCmRlc3RpbmF0aW9uIGFkZHJlc3NlczoNCg0KWyAgICAwLjUwMzc1N10gS1RBUCB2ZXJzaW9u
IDENClsgICAgMC41MDM4NTRdIDEuLjENClsgICAgMC41MDQxNTZdICAgICBLVEFQIHZlcnNpb24g
MQ0KWyAgICAwLjUwNDI1MV0gICAgICMgU3VidGVzdDogY2hlY2tzdW0NClsgICAgMC41MDQ1NjNd
ICAgICAjIG1vZHVsZTogY2hlY2tzdW1fa3VuaXQNClsgICAgMC41MDQ3MzBdICAgICAxLi41DQpb
ICAgIDAuNTQ2NDE4XSAgICAgb2sgMSB0ZXN0X2NzdW1fZml4ZWRfcmFuZG9tX2lucHV0cw0KWyAg
ICAwLjYyNzg1M10gICAgIG9rIDIgdGVzdF9jc3VtX2FsbF9jYXJyeV9pbnB1dHMNClsgICAgMC43
MDQ5MThdICAgICBvayAzIHRlc3RfY3N1bV9ub19jYXJyeV9pbnB1dHMNClsgICAgMC43MDU4NDVd
ICAgICBvayA0IHRlc3RfaXBfZmFzdF9jc3VtDQpbICAgIDAuNzA2MzIwXQ0KWyAgICAwLjcwNjMy
MF0gVW5oYW5kbGVkIGV4Y2VwdGlvbjogSVBTUiA9IDAwMDAwMDA2IExSID0gZmZmZmZmZjENClsg
ICAgMC43MDY3OTZdIENQVTogMCBQSUQ6IDI4IENvbW06IGt1bml0X3RyeV9jYXRjaCBUYWludGVk
OiBHIA0KICAgICAgIE4gNi44LjAtcmMxLTAwNjA5LWc5YzBiN2EyZTI1ZjAgIzY0OQ0KWyAgICAw
LjcwNzE3N10gSGFyZHdhcmUgbmFtZTogR2VuZXJpYyBEVCBiYXNlZCBzeXN0ZW0NClsgICAgMC43
MDc0MDBdIFBDIGlzIGF0IF9fY3N1bV9pcHY2X21hZ2ljKzB4OC8weGI0DQpbICAgIDAuNzA4MTcw
XSBMUiBpcyBhdCB0ZXN0X2NzdW1faXB2Nl9tYWdpYysweDNkLzB4YTQNClsgICAgMC43MDg0MTVd
IHBjIDogWzwyMTFiMGRhOD5dICAgIGxyIDogWzwyMTBlM2JmNT5dICAgIHBzcjogMDEwMDAyMGIN
ClsgICAgMC43MDg2OTJdIHNwIDogMjE1M2RlYmMgIGlwIDogNDZjN2YwZDIgIGZwIDogMDAwMDAw
MDANClsgICAgMC43MDg5MTldIHIxMDogMDAwMDAwMDAgIHI5IDogMjE0MWRjNDggIHI4IDogMjEx
ZTBlMjANClsgICAgMC43MDkxNDhdIHI3IDogMDAwMDMwODUgIHI2IDogMDAwMDAwMDEgIHI1IDog
MjE0MWRkMjQgIHI0IDogMjExZTBjMmUNClsgICAgMC43MDk0MjJdIHIzIDogMmMwMDAwMDAgIHIy
IDogMWFjN2YwZDIgIHIxIDogMjExZTBjMTkgIHIwIDogMjExZTBjMDkNClsgICAgMC43MDk3MDRd
IHhQU1I6IDAxMDAwMjBiDQoNCg0KSSBkb24ndCBrbm93IG11Y2ggYWJvdXQgQVJNIGluc3RydWN0
aW9uIHNldCwgc2VlbXMgbGlrZSB0aGUgbGRyIA0KaW5zdHJ1Y3Rpb24gdXNlZCBpbiBpcF9mYXN0
X2NzdW0oKSBkb2Vzbid0IG1pbmQgdW5hbGlnbmVkIGFjY2Vzc2VzIHdoaWxlIA0KbGRtaWEgaW5z
dHJ1Y3Rpb24gdXNlZCBpbiBjc3VtX2lwdjZfbWFnaWMoKSBtaW5kcy4gT3IgaXMgaXQgYSB3cm9u
ZyANCmJlaGF2aW91ciBvZiBRRU1VID8NCg0KSWYgSSBjaGFuZ2UgdGhlIHRlc3QgYXMgZm9sbG93
cyB0byBvbmx5IHVzZSB3b3JkIGFsaWduZWQgSVB2NiBhZGRyZXNzZXMsIA0KaXQgd29ya3M6DQoN
CmRpZmYgLS1naXQgYS9saWIvY2hlY2tzdW1fa3VuaXQuYyBiL2xpYi9jaGVja3N1bV9rdW5pdC5j
DQppbmRleCAyMjViYjc3MDE0NjAuLjRkODZmYzhjY2Q3OCAxMDA2NDQNCi0tLSBhL2xpYi9jaGVj
a3N1bV9rdW5pdC5jDQorKysgYi9saWIvY2hlY2tzdW1fa3VuaXQuYw0KQEAgLTYwNyw3ICs2MDcs
NyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NzdW1faXB2Nl9tYWdpYyhzdHJ1Y3Qga3VuaXQgKnRlc3Qp
DQogIAljb25zdCBpbnQgY3N1bV9vZmZzZXQgPSBzaXplb2Yoc3RydWN0IGluNl9hZGRyKSArIHNp
emVvZihzdHJ1Y3QgDQppbjZfYWRkcikgKw0KICAJCQkgICAgc2l6ZW9mKGludCkgKyBzaXplb2Yo
Y2hhcik7DQoNCi0JZm9yIChpbnQgaSA9IDA7IGkgPCBOVU1fSVB2Nl9URVNUUzsgaSsrKSB7DQor
CWZvciAoaW50IGkgPSAwOyBpIDwgTlVNX0lQdjZfVEVTVFM7IGkgKz0gNCkgew0KICAJCXNhZGRy
ID0gKGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqKShyYW5kb21fYnVmICsgaSk7DQogIAkJZGFkZHIg
PSAoY29uc3Qgc3RydWN0IGluNl9hZGRyICopKHJhbmRvbV9idWYgKyBpICsNCiAgCQkJCQkJICBk
YWRkcl9vZmZzZXQpOw0KDQoNCklmIEkgY2hhbmdlIGNzdW1faXB2Nl9tYWdpYygpIGFzIGZvbGxv
d3MgdG8gdXNlIGluc3RydWN0aW9uIGxkciBpbnN0ZWFkIA0Kb2YgbGRtaWEsIGl0IGFsc28gd29y
a3Mgd2l0aG91dCBhbnkgY2hhbmdlIHRvIHRoZSB0ZXN0Og0KDQpkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbGliL2NzdW1pcHY2LlMgYi9hcmNoL2FybS9saWIvY3N1bWlwdjYuUw0KaW5kZXggMzU1OWQ1
MTUxNDRjLi5hMzEyZDA4MzZiOTUgMTAwNjQ0DQotLS0gYS9hcmNoL2FybS9saWIvY3N1bWlwdjYu
Uw0KKysrIGIvYXJjaC9hcm0vbGliL2NzdW1pcHY2LlMNCkBAIC0xMiwxMiArMTIsMTggQEANCiAg
RU5UUlkoX19jc3VtX2lwdjZfbWFnaWMpDQogIAkJc3RyCWxyLCBbc3AsICMtNF0hDQogIAkJYWRk
cwlpcCwgcjIsIHIzDQotCQlsZG1pYQlyMSwge3IxIC0gcjMsIGxyfQ0KKwkJbGRyCXIyLCBbcjFd
LCAjNA0KKwkJbGRyCXIzLCBbcjFdLCAjNA0KKwkJbGRyCWxyLCBbcjFdLCAjNA0KKwkJbGRyCXIx
LCBbcjFdDQogIAkJYWRjcwlpcCwgaXAsIHIxDQogIAkJYWRjcwlpcCwgaXAsIHIyDQogIAkJYWRj
cwlpcCwgaXAsIHIzDQogIAkJYWRjcwlpcCwgaXAsIGxyDQotCQlsZG1pYQlyMCwge3IwIC0gcjN9
DQorCQlsZHIJcjEsIFtyMF0sICM0DQorCQlsZHIJcjIsIFtyMF0sICM0DQorCQlsZHIJcjMsIFty
MF0sICM0DQorCQlsZHIJcjAsIFtyMF0NCiAgCQlhZGNzCXIwLCBpcCwgcjANCiAgCQlhZGNzCXIw
LCByMCwgcjENCiAgCQlhZGNzCXIwLCByMCwgcjINCg0KDQpTbyBub3cgd2UgYXJlIGJhY2sgdG8g
dGhlIGluaXRpYWwgcXVlc3Rpb24sIHNob3VsZCBjaGVja3N1bW1pbmcgb24gDQp1bmFsaWduZWQg
YWRkcmVzc2VzIGJlIHN1cHBvcnRlZCBvciBub3QgPw0KDQpSdXNzZWxsIEkgdW5kZXJzdGFuZCBm
cm9tIHByZXZpb3VzIGFuc3dlcnMgZnJvbSB5b3UgdGhhdCBoYWxmLXdvcmQgDQphbGlnbm1lbnQg
c2hvdWxkIGJlIHN1cHBvcnRlZCwgaW4gdGhhdCBjYXNlIHNob3VsZCBBUk0gdmVyc2lvbiBvZiAN
CmNzdW1faXB2Nl9tYWdpYygpIGJlIG1vZGlmaWVkID8gSW4gdGhhdCBjYXNlIGNhbiB5b3UgcHJv
cG9zZSB0aGUgbW9zdCANCm9wdGltaXNlZCBmaXggPw0KDQpJZiBub3QsIHRoZW4gdGhlIHRlc3Qg
aGFzIHRvIGJlIGZpeGVkIHRvIG9ubHkgdXNlIHdvcmQtYWxpZ25lZCBJUHY2IA0KYWRkcmVzc2Vz
Lg0KDQpUaGFua3MNCkNocmlzdG9waGUNCg==

