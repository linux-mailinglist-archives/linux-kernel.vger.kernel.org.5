Return-Path: <linux-kernel+bounces-99137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED28783EC
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A99284A5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719064643A;
	Mon, 11 Mar 2024 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="CzPK9KJK"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021011.outbound.protection.outlook.com [52.101.167.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE554597A;
	Mon, 11 Mar 2024 15:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710171265; cv=fail; b=F4Y/TPe4urCUOn2p5mv6DmpMoWI6XP6FNl4L9I99kCm6qn8CljINAcihY65eB8rCCUO3qoVOwuERXB/OO89KlJGntNMC/6IYW2hfgSRxRKKyyvdN3Sq0JZWdLQuw04ZCEPoF1koKHilsf6JpHlPhQvQeC0X8qxUmGJAJRqWJgnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710171265; c=relaxed/simple;
	bh=V/exIoWpvWlmwS/gKZ2Rd8PBtUYNXoD21dVW6r0qEMU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KIegSV3Npb+E03pKTi6pSbca5ofdLtL5PrB75yKlC3bMGHbZpb47kVTpsqvPkZ6KG3iN5keUSLk9rAu9cAumnKizv0eGTJ0A3v/qxOH8ecncshrAVTY3IKJYxDGff1HmZxLfILtCgPI59fE2AWnQly+d7XxWIunEuTJXncrBiIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=CzPK9KJK; arc=fail smtp.client-ip=52.101.167.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gcTRyEgsY2m8k1HOOcu0uhLbaFUk7sc/ZfBG+jksoem+7MELw42RWUT39/aq1HyA4oUEhcT6tOfbelJtkhCIwugsS8VsGWdWefRbUOOVAOSnjRh3tcKTLyENAV/8Nhzk0YG5MT1WDEqS8sWU+GiDXBj8U5aTutkXVRONjfozMSivVRfs4SGa8GkL/hG7f4mp0VBAYMpd+c8eFdQTxEEE0iDzXaZm2KyJNuZIWG8vmAMTsK5hSUN7KOXcnYreP3BNlNxwUvExQFdl2LOwvpR8mlYQbHBcBgffAMbiP2crIbASSSSI/+thtWFn+/9ct/oeXzE3ykkJJgct1iqvOaY49A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V/exIoWpvWlmwS/gKZ2Rd8PBtUYNXoD21dVW6r0qEMU=;
 b=XS8mASSfu+iIRxwNeZFtKfIqGaKEh9yQoesoXGfvJYA/01vhDQ6zIwkm/OYbVWHwKsOXfXlqmuE9mIxgE7Ex9y2IDQwYnER9HCgLNvbIx1X5kLDaDwlis28WzqLdTNZDqu4xI2QccbyK2Eups218bH16ifqf4g+6FhGJxHL69+oFRMptZitzn8fi0yz9DJcLsxJxSbghxKRBk0EIiYGsruLWvzdCIByunOZKGhnfRMxItfzv8CbecJdjS5M6z6a6rQRWqzXIkY5dECB0xDu8QkK6bVPB6lO1vnpmy5TPJWidx2KUwbglI8/5Gh4vFr0c7pcul+cJMqPoLz3YzCDupg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V/exIoWpvWlmwS/gKZ2Rd8PBtUYNXoD21dVW6r0qEMU=;
 b=CzPK9KJKOeIC3MPq7pYszPOgV/3cJiuy/32ETM4pgFKdwVDYb4pQNRYMsbnZE5mpSdblCVgIklDJbDYFKmahlqZKqpsi2r5e4pAu4sVzEnfQXzLQOLkVX+mN4G3nPtV3hgg9enkY6NyJ3T8zmdZSp4sNcWruVpcZJE/VvpyMW8+IvtSsUXMlxjQ2StyNth8MlF7zjLt0JJbm7DbvY+u2NIa8Fgf/lXt9etKv+SLzxL6wZobua6GqqlBWRHjdtw4S60ZWgf2ilF5UFiGT1yV6AaE3C5+iDhQcOBeaiinQSiKQjjwsOa60EthHAP48TAvxknMXP4jVTytEByNqcEWfJg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB1673.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:16a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 15:34:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 15:34:15 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck <linux@roeck-us.net>
CC: David Laight <David.Laight@aculab.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Geert
 Uytterhoeven <geert@linux-m68k.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaa2FN/UPATTv23UaTwsptpp4BsbEjNucAgAAHJoCAD35UAA==
Date: Mon, 11 Mar 2024 15:34:15 +0000
Message-ID: <41d77dbb-468d-4bc3-8f03-a9d4271abd75@csgroup.eu>
References:
 <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <62b69aaf-7633-4bd8-aefe-5ba47147dba7@roeck-us.net> <ZeIlQ+suWjH3f3UZ@ghost>
In-Reply-To: <ZeIlQ+suWjH3f3UZ@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB1673:EE_
x-ms-office365-filtering-correlation-id: f74e05b8-51dd-4c45-70b4-08dc41e0b557
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hbQNOLAEt8eMfbjVuR2nzQLaUC2g/0lXR8AVTSyey3nFHeZ+So/nPsdkYlTYKwvd6Ban8iA9EQM9kQeREzTcYlRK/YgolLqwt1jPC5IhOzq2miryCIom1vvhOMJDuIRE/LvgfJmqGPOsaQRArX+8iv5K5Q4paBeeFTDl5s1Cia/Egs3wdAzqbVBl93KYZCBU/xnU2318AqDEtKt1Z7FoYUz9bZOJfpEIGTJ1sYZyMeYQ7tknkDWv/lR2HgZjPpCwnwd01nZlvcxb5WqJPMeM3pOfkf4Plv7D7pmcNAxjlKbgjWr5Yt46IS7pCCvfd5mCx1hs72iOsAU9GSnbmSzQcbh4OKJZkvAFqFQg4GpmcGMhwQRPuUA3xJ6tJyAmd/HKkAT6/GKasgnljAT6ZD6I7jnlVqDxmo1kT+zEHjs0WQbatIzsBGGmeVKgEkhZ3tE/TMB2Innb6Gz1tHT5oj959JkMYEp6XtHnsi5Kmu2UmI/usk0Gnh1xV5LEtQoJYdUh29DDoSq0c2trqgd/AV/yiiGUOKSW3DOvXMxSq6c7uibiYmtHPV702B2B6MnklTZUyYXzqHRT2UWFadFyjyfXwypsYeqp4yyxZdwDaoWmexmPyA2TtJrKhRA3RGfntyEUyvHN+yJPXULjbUMgeCiVPMBzJyY03b/RJpRtcttNs+8=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dnA4VG5GOVZoM1VNazhDQSt6NVlaNFU2VWFTeCtkTDRIZDRTa1I2NWFray9l?=
 =?utf-8?B?MGhkSGQ0QjhYU2dPRnRVelptcURjWkY0SlZWRzIxaTJkWFRMT05yZUdVK3g3?=
 =?utf-8?B?bXVUS1A1TzA4d1piZkhKelhWNEt3K3pTNlZydjdKRUJxNHBpTHRJbjE5VS96?=
 =?utf-8?B?Q0YyRHpoeXExSTRNeTJsN2YrbHMyTGtMRjR4bzJXY2FndHhMbytVemM2U0pr?=
 =?utf-8?B?eXFkWEpDcm5TdTB1SnF6QUgrRGdCUlV1cjZBbm9HY3VVaFFzbXNUdGRRYlB1?=
 =?utf-8?B?M2I4bFQ1eGJMTzFOQndhVDE1S010QmdzUzhGVXhMR1VBejR6NjkvSWs2b25T?=
 =?utf-8?B?M3dHbUJwenE5UGxIYzdrcE1NRy82ZStYSUJManlFWmhJcWlWbG54cHdBY015?=
 =?utf-8?B?RjhwTXVzbmJ2U25lU0J2WGtldkhyU1plZVM1cm0zMlE5Zi9HL3c0aVhuYXky?=
 =?utf-8?B?UFhRc1k4SXdOVVp1Yy9GajdGTnJERW94TTBoOCs5UUhSNGZ3K3hCaG9RYWdR?=
 =?utf-8?B?NncrTjBNczVrWGNHcUxZTmMrMVBza0ptdnFWTzdmQ1YvSmxnbVp6M3Z4Smxj?=
 =?utf-8?B?SXFiUEJGdVJtNkhYK0lzRjZHTjhTa0R1eVdrZ2xpOUsrYXNITnBtRFVkL3Ns?=
 =?utf-8?B?NGZEcXZzUDI0MW0yUE1KUEhPKzhJeUZNWG0zYmd6VGFGN1Q0R3dBYUFBUlFT?=
 =?utf-8?B?RVArQWVpZmxlbld3SzZyeTAzai9vSVphVkF5NnkzQjBnNWZRR0xiVDJFT09I?=
 =?utf-8?B?SGZtU1ZQbFVTalQvTUxlNjhkWDU1SEVHZU9lb0ZmYWhwdWgreWdaYmFLZXE5?=
 =?utf-8?B?YkorNVNpSXNwYXdydWZkMFpWekRIYWQxeWQ3SDhtWWQ3MFdBdllIWnBVRWRO?=
 =?utf-8?B?cVBWeTJYWkJtWUE2ZzlCb2tvY1B6enRLV3ZoR3BuNWEvNm1rYlR5MzFLUjM0?=
 =?utf-8?B?WHYva0tHcndDZDMwWmN2ZGtacmJPUTd4N2R5dzQwTnlpT0p6SnV4QTNaNjdl?=
 =?utf-8?B?STBCMDZCWWJCZzB2cXNFcHZMTzVoUU5aSmZSdXpja1dzWmtFdjJwQmNlcmpT?=
 =?utf-8?B?MEdoaW1zVXpQZHdtL3BNNHZDV210aTM5bjl3amJ6U0F1UkNsQzE3VXAzTm9j?=
 =?utf-8?B?WEluR2xzWFVNUHo2WTlJckVQMWxXenQ1UlVpL2doODVLV3lhWWd4WkZKTTBj?=
 =?utf-8?B?N0RlZHY1T0dkT0hXbmVnRWFxYXZkYUVaNDFOUnBsK0ZBRDhTbmxERzcwajg3?=
 =?utf-8?B?MHMrZFp6SjErd1kxcERETmw5djZldFZla3VueXgwbFRqYzMrMU9NLytuZTJx?=
 =?utf-8?B?MFVZS0t4Q29VMjcvbjJWRFJqSDk5dFd2R2pHVUFhdFZQZGw5M2tweFo4MFRO?=
 =?utf-8?B?clRWNkY3dXpHZXhiK0FhNlN1Wkd0akpocWJZTEIzNklvN2xUVHRMNTNIZXg0?=
 =?utf-8?B?aFZmbHZlR0hkdUVSVXhRWjROR1Z5dVR2d3dOaGc3WUxESThXeG1UeEh4OHhI?=
 =?utf-8?B?b050aGFEc3dma053SWhkKzROU3JTalhqaVVtU0ZpSjVLNER5bDB3YmltalFF?=
 =?utf-8?B?cHZQUDNhU2liTENxWkdHc1RtQjBud1ZNcStxWFJvZ0JwVHdqNm10SEtDblVU?=
 =?utf-8?B?dzFGWmIrS201Y0VrT1BMRVdFOXFzQU1mMndYUlc1L1JxVW5nVWNNZjMxYWVW?=
 =?utf-8?B?TmhNSzJ3cU5EOGl2bFkvOFZzNEkzQkpUeWVmd2diaFRGbGpzc2l4VCtFVW90?=
 =?utf-8?B?bHBhSWdRendVMW82VndIWkRCUGxFUW52ck9YNUxRTmFDTCtrV05KM1NXNmdQ?=
 =?utf-8?B?czlLemRrZGxqakZsZHpuelhWbHlIQml2NEE1bW1JOVN0SmpwOUpCMEE3ZVFR?=
 =?utf-8?B?blp0bU80bmVXYUN3UStMc1hmL2gyaVZyOU9RZ0Q5WUJXM3pOWmx2R2hFd3hK?=
 =?utf-8?B?K1hUUFhrK0J4MFpRSHhVaEtiMmFnT1pOTHFYUmxvc1AzWFM0cGVxYnhWNkpZ?=
 =?utf-8?B?M0x5N213MVQwYUpPcjlSMnFHM3pqclpuTFFUNWMxY01XVXdjbUM3czZicUkx?=
 =?utf-8?B?UGxKSjNvMnF0SVk5VytXeDZ3QzVqeWwxSGxaRTR1cjh1R1QyVFN5RVYwWi9s?=
 =?utf-8?Q?QHDTE9BFNDC2xjqGGqm55ggLd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E26E03DB7E78F4AA759F133A21C4A11@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f74e05b8-51dd-4c45-70b4-08dc41e0b557
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 15:34:15.0350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rO5FgWRdiQUNST7SKSH05jvsRqKPdASdPr/GOZkTI4HnHWtC6eR2xgGhoWiLLAKKRiI1qDzoBjq9Vj4APqN2J9HGkybkVCmAgn+X0S+gbF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB1673

DQoNCkxlIDAxLzAzLzIwMjQgw6AgMTk6NTgsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBGcmksIE1hciAwMSwgMjAyNCBhdCAxMDozMjozNkFNIC0wODAwLCBHdWVudGVyIFJvZWNr
IHdyb3RlOg0KPj4gT24gMi8yOS8yNCAxNDo0NiwgQ2hhcmxpZSBKZW5raW5zIHdyb3RlOg0KPj4+
IFRoZSB0ZXN0IGNhc2VzIGZvciBpcF9mYXN0X2NzdW0gYW5kIGNzdW1faXB2Nl9tYWdpYyB3ZXJl
IG5vdCBwcm9wZXJseQ0KPj4+IGFsaWduaW5nIHRoZSBJUCBoZWFkZXIsIHdoaWNoIHdlcmUgY2F1
c2luZyBmYWlsdXJlcyBvbiBhcmNoaXRlY3R1cmVzDQo+Pj4gdGhhdCBkbyBub3Qgc3VwcG9ydCBt
aXNhbGlnbmVkIGFjY2Vzc2VzIGxpa2Ugc29tZSBBUk0gcGxhdGZvcm1zLiBUbw0KPj4+IHNvbHZl
IHRoaXMsIGFsaWduIHRoZSBkYXRhIGFsb25nICgxNCArIE5FVF9JUF9BTElHTikgYnl0ZXMgd2hp
Y2ggaXMgdGhlDQo+Pj4gc3RhbmRhcmQgYWxpZ25tZW50IG9mIGFuIElQIGhlYWRlciBhbmQgbXVz
dCBiZSBzdXBwb3J0ZWQgYnkgdGhlDQo+Pj4gYXJjaGl0ZWN0dXJlLg0KPj4+DQo+Pj4gRnVydGhl
cm1vcmUsIGFsbCBhcmNoaXRlY3R1cmVzIGV4Y2VwdCB0aGUgbTY4ayBwYWQgInN0cnVjdA0KPj4+
IGNzdW1faXB2Nl9tYWdpY19kYXRhIiB0byA0NCBieXRlcy4gVG8gbWFrZSBjb21wYXRpYmxlIHdp
dGggdGhlIG02OGssDQo+Pj4gbWFudWFsbHkgcGFkIHRoaXMgc3RydWN0dXJlIHRvIDQ0IGJ5dGVz
Lg0KPj4+DQo+Pj4gRml4ZXM6IDZmNGM0NWNiY2IwMCAoImt1bml0OiBBZGQgdGVzdHMgZm9yIGNz
dW1faXB2Nl9tYWdpYyBhbmQgaXBfZmFzdF9jc3VtIikNCj4+PiBTaWduZWQtb2ZmLWJ5OiBDaGFy
bGllIEplbmtpbnMgPGNoYXJsaWVAcml2b3NpbmMuY29tPg0KPj4+IFJldmlld2VkLWJ5OiBHdWVu
dGVyIFJvZWNrIDxsaW51eEByb2Vjay11cy5uZXQ+DQo+Pj4gQWNrZWQtYnk6IFBhbG1lciBEYWJi
ZWx0IDxwYWxtZXJAcml2b3NpbmMuY29tPg0KPj4+IC0tLQ0KPj4+IFRoZSBpcF9mYXN0X2NzdW0g
YW5kIGNzdW1faXB2Nl9tYWdpYyB0ZXN0cyBkaWQgbm90IHdvcmsgb24gYWxsDQo+Pj4gYXJjaGl0
ZWN0dXJlcyBkdWUgdG8gZGlmZmVyZW5jZXMgaW4gbWlzYWxpZ25lZCBhY2Nlc3Mgc3VwcG9ydC4N
Cj4+PiBGaXggdGhvc2UgaXNzdWVzIGJ5IGNoYW5naW5nIGVuZGlhbm5lc3Mgb2YgZGF0YSBhbmQg
YWxpZ25pbmcgdGhlIGRhdGEuDQo+Pj4NCj4+PiBUaGlzIHBhdGNoIHJlbGllcyB1cG9uIGEgcGF0
Y2ggZnJvbSBDaHJpc3RvcGhlOg0KPj4+DQo+Pj4gW1BBVENIIG5ldF0ga3VuaXQ6IEZpeCBhZ2Fp
biBjaGVja3N1bSB0ZXN0cyBvbiBiaWcgZW5kaWFuIENQVXMNCj4+Pg0KPj4NCj4+IFZhcmlvdXMg
dGVzdCByZXN1bHRzOg0KPj4NCj4+IE9uIHY2LjgtcmM2LTEyMC1nODdhZGVkZWJhNTFhIChjdXJy
ZW50IG1haW5saW5lKSwgd2l0aG91dCB0aGlzIHBhdGNoDQo+Pg0KPj4gLSBtcHMyLWFuMzg1Om1w
czJfZGVmY29uZmlnIGNyYXNoZXMgaW4gSVB2NiBjaGVja3N1bSB0ZXN0cw0KPj4gLSBpcHY2IGNo
ZWNrc3VtIHRlc3RzIGZhaWwgb24gcGFyaXNjLCBwYXJpc2M2NCwgc2gsIGFuZCBzaGViLg0KPj4N
Cj4+IFRoZSBwcmV2aW91c2x5IHNlZW4gcHJvYmxlbXMgb24gYmlnIGVuZGlhbiBzeXN0ZW1zIGFy
ZSBzdGlsbCBzZWVuIHdpdGgNCj4+IHY2LjgtcmM2LCBidXQgYXJlIGdvbmUgYWZ0ZXIgY29tbWl0
IDNkNjQyM2VmOGQ1MSAoImt1bml0OiBGaXggYWdhaW4NCj4+IGNoZWNrc3VtIHRlc3RzIG9uIGJp
ZyBlbmRpYW4gQ1BVcyIpIGhhcyBiZWVuIGFwcGxpZWQgdXBzdHJlYW0uIFRoaXMgaW5jbHVkZXMN
Cj4+IHRoZSB0ZXN0IGZhaWx1cmVzIHNlZW4gd2l0aCBtNjhrLg0KPj4NCj4+IFRoZSBwYXJpc2Mv
cGFyaXNjNjQgdGVzdCBmYWlsdXJlcyBhcmUgaW5kZXBlbmRlbnQgb2YgdGhpcyBwYXRjaC4gRml4
ZXMgYXJlDQo+PiBhdmFpbGFibGUgaW4gbGludXgtbmV4dCBhbmQgcGVuZGluZyBpbiBxZW11LiBU
aGUgc2gvc2hlYiBmYWlsdXJlcyBhcmUgZHVlDQo+PiB0byB1cHN0cmVhbSBjb21taXQgY2FkYzRl
MWEyYjQgYW5kIGFyZSBubyBsb25nZXIgc2VlbiBhZnRlciByZXZlcnRpbmcgdGhhdA0KPj4gcGF0
Y2guDQo+Pg0KPj4gVGhpcyBsZWF2ZXMgdGhlIG1wczItYW4zODU6bXBzMl9kZWZjb25maWcgY3Jh
c2gsIHdoaWNoIGlzIGF2b2lkZWQgYnkgdGhpcyBwYXRjaC4NCj4+IE15IHVuZGVyc3RhbmRpbmcs
IHdoaWNoIG1heSBiZSB3cm9uZywgaXMgdGhhdCBhcm0gaW1hZ2VzIHdpdGggdGh1bWIgaW5zdHJ1
Y3Rpb25zDQo+PiBkbyBub3Qgc3VwcG9ydCB1bmFsaWduZWQgYWNjZXNzZXMgKG1heWJlIEkgc2hv
dWxkIHNheSBkbyBub3Qgc3VwcG9ydCB1bmFsaWduZWQNCj4+IGFjY2Vzc2VzIHdpdGggdGhlIG1w
czItYW4zODUgcWVtdSBlbXVsYXRpb247IEkgZGlkIG5vdCB0ZXN0IHdpdGggcmVhbCBoYXJkd2Fy
ZSwNCj4+IGFmdGVyIGFsbCkuDQo+Pg0KPj4gR2l2ZW4gYWxsIHRoYXQsIHRoZSBjb250aW51ZWQg
ZGlzY3Vzc2lvbiBhcm91bmQgdGhlIHN1YmplY3QsIGFuZCB0aGUgbGFjaw0KPj4gb2YgYWdyZWVt
ZW50IGlmIHVuYWxpZ25lZCBhY2Nlc3NlcyBzaG91bGQgYmUgdGVzdGVkIG9yIG5vdCwgSSBkb24n
dCByZWFsbHkNCj4+IHNlZSBhIHBhdGggZm9yd2FyZCBmb3IgdGhpcyBwYXRjaC4gVGhlIHJlbWFp
bmluZyBrbm93biBwcm9ibGVtIGlzIGFybSB3aXRoDQo+PiB0aHVtYiBpbnN0cnVjdGlvbnMuIEkg
ZG9uJ3QgdGhpbmsgdGhhdCBpcyBnb2luZyB0byBiZSBmaXhlZC4gSSBzdXNwZWN0IHRoYXQNCj4+
IG5vIG9uZSBidXQgbWUgZXZlbiB0cmllcyB0byBydW4gdGhhdCBjb2RlIChvciBhbnkgYXJtOm5v
bW11IGltYWdlcywgZm9yIHRoYXQNCj4+IG1hdHRlcikuIEknZCBzdWdnZXN0IHRvIGRyb3AgdGhp
cyBwYXRjaCwgYW5kIEknbGwgc3RvcCB0ZXN0aW5nIElQIGNoZWNrc3VtDQo+PiBnZW5lcmF0aW9u
IGZvciBtcHMyLWFuMzg1Om1wczJfZGVmY29uZmlnLg0KPj4NCj4+IFNvcnJ5IGZvciBhbGwgdGhl
IG5vaXNlIHRoaXMgaGFzIGdlbmVyYXRlZC4NCj4+DQo+PiBUaGFua3MsDQo+PiBHdWVudGVyDQo+
IA0KPiBJZiB0aGF0J3Mgd2hhdCBwZW9wbGUgd2FudC4gSSBzdGlsbCBkb24ndCB1bmRlcnN0YW5k
IHdoeSB0aGVyZSBpcyBhbnkNCj4gcHJvYmxlbSB3aXRoIHJlbHlpbmcgb24gTkVUX0lQX0FMSUdO
IGFzIHRoYXQgc2VlbXMgbGlrZSB0aGF0IG1hY3JvIHdhcw0KPiBkZWZpbmVkIHRvIGNyZWF0ZSBh
biBleHBlY3RlZCBhbGlnbm1lbnQuDQo+IA0KPiBJdCB3b3VsZCBiZSBuaWNlIHRvIHVzZSB0aGUg
c3RydWN0IGNzdW1faXB2Nl9tYWdpY19kYXRhIGluc3RlYWQgb2YgZG9pbmcNCj4gbWFudWFsIGFs
aWdubWVudCBhbmQgcmVzdHJpY3RpbmcgbGVuIHRvIDE2IGJpdHMuIEkgY2FuIHNlbmQgYSBwYXRj
aCB0aGF0DQo+IG9ubHkgY292ZXJzIHRoYXQgaWYgcGVvcGxlIGFyZSBpbnRlcmVzdGVkLg0KPiAN
Cj4gVGhpcyB3YXMgbXkgZmlyc3QgZm9yYXkgaW50byB3cml0aW5nIGdlbmVyaWMgdGVzdCBjYXNl
cyBhbmQgaXQgZHJldyBhDQo+IHNpZ25pZmljYW50IGFtb3VudCBvZiBjcml0aWNpc20uIEkgYXBw
cmVjaWF0ZSBHdWVudGVyJ3MgZWZmb3J0cyB0byBtYWtlDQo+IHRoZSB0ZXN0cyBoYXZlIG1vcmUg
ZXhwZWN0ZWQgYmVoYXZpb3IgYWNyb3NzIGFsbCBzdXBwb3J0ZWQgcGxhdGZvcm1zLA0KPiBidXQg
dGhlIGNvbW11bml0eSBvYnZpb3VzbHkgZG9lc24ndCBhZ3JlZSB0aGF0IGlzIGEgcmVhc29uYWJs
ZSBnb2FsLg0KPiBNYWtlcyBteSBsaWZlIGVhc2llciB0aG91Z2gsIGJlY2F1c2UgdGhlbiBJIGNh
biBqdXN0IG5vdCB1cHN0cmVhbSB0ZXN0DQo+IGNhc2VzIGFuZCBmb2N1cyBvbiBmZWF0dXJlIHdv
cmsuLi4NCg0KSGkgQ2hhcmxpZSwNCg0KRG8gbm90IGdldCBkaXNjb3VyYWdlZC4NCg0KWW91ciBh
ZGRpdGlvbmFsIGt1bml0IGNoZWNrc3VtIHRlc3RzIGFyZSB2ZXJ5IHZhbHVhYmxlIGFuZCB1c2Vm
dWxsLCBhbmQgDQphcyBmYXIgYXMgSSB1bmRlcnN0YW5kIHRoZXkgaGF2ZSBhbGxvd2VkIHRvIGlk
ZW50aWZ5IGFuZCBmaXggcHJvYmxlbXMgDQp0aGF0IGhhZCBnb25lIHVubm90aWNlZCB1bnRpbCBu
b3cuIEkgbXlzZWxmIHdvdWxkIGhhdmUgYmVlbiB2ZXJ5IGhhcHB5IA0KdG8gaGF2ZSBzdWNoIHRl
c3RzIGF2YWlsYWJsZSB3aGVuIEkgaW5saW5lZCBpcF9mYXN0X2NzdW0oKSBhbmQgDQppbXBsZW1l
bnRlZCBjc3VtX2lwdjZfbWFnaWMoKSBmb3IgcG93ZXJwYy4NCg0KVGhlIHRoaW5nIHdoaWNoIGJy
b3VnaHQgeW91IGNyaXRpY2lzbSAoZnJvbSBteXNlbGYgYXQgbGVhc3QpIGlzIHRoYXQgDQp5b3Vy
IHJlbmNlbnQgdGVudGF0aXZlIGZpeGVzIGRpc3RvcnQgeW91ciBvcmlnaW5hbCB3b3JrIGFuZCBt
YWtlcyBpdCANCm11Y2ggbGVzcyB1c2VmdWwgdGhhbiBpdCBvcmlnaW5hbGx5IHdhcy4gSSBmZWFy
IHRoYXQgaWYgeW91ciB0ZXN0IGhhZCANCmJlZW4gbGlrZSB0aGF0IGF0IHRoZSBiZWdpbmluZywg
dGhleSB3b3VsZG4ndCBoYXZlIGFsbG93ZWQgdG8gZGlzY292ZXIgDQphbmQgZml4IHRoZSBzYW1l
IHByb2JsZW1zLg0KDQpTbyB5ZXMgeW91ciB0ZXN0cyBhcmUgdmVyeSB3ZWxjb21lIGZvciB1cHN0
cmVhbWluZyBhbmQgSSBlbmNvdXJhZ2UgeW91IA0KdG8gY29udGludWUgdXBzdHJlYW1pbmcgZ29v
ZCB0ZXN0cyBhcyB0aGUgb25lIHlvdSBpbml0aWFseSB1cHN0cmVhbWVkIA0KZm9yIGNoZWNrc3Vt
IHRlc3RzLg0KDQpJZiB5b3UgaGF2ZSBub3QgYWxyZWFkeSBkb25lLCBJIHJlY29tbWVuZCB5b3Ug
dG8gcmVhZCB0aGUgZ3VpZGFuY2UgYWJvdXQgDQpwYXRjaCBzdWJtaXNzaW9uOg0KDQpodHRwczov
L2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzLzYuRm9sbG93dGhyb3VnaC5odG1sDQoNCg0KaHR0cHM6
Ly9kb2NzLmtlcm5lbC5vcmcvcHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMuaHRtbA0KDQpBbmQg
ZXNwZWNpYWxseQ0KDQpodHRwczovL2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5odG1sI3Jlc3BvbmQtdG8tcmV2aWV3LWNvbW1lbnRzDQoNCmFuZA0KDQpodHRwczov
L2RvY3Mua2VybmVsLm9yZy9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5odG1sI2Rvbi10LWdl
dC1kaXNjb3VyYWdlZC1vci1pbXBhdGllbnQNCg0KQ2hyaXN0b3BoZQ0K

