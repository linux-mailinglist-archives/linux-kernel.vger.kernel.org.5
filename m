Return-Path: <linux-kernel+bounces-87970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D6C86DBA0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51C851F25E3B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D65A67E9D;
	Fri,  1 Mar 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="f+l7wB+0"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2095.outbound.protection.outlook.com [40.107.9.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F46567E90;
	Fri,  1 Mar 2024 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709275573; cv=fail; b=pHxcegGXQHUc/a11wtP2mE9oOTmX2QslMERJRWbRztSmTDlLBrhsDTrHrMK5H+JJW94QMAUp1KLdr3P3/37pVSzjBAneOKfapSBbq0sC4+e6Zo1xu/Co6NnIO+y2BGo1YgoFu+2Dfd/qPIANjofGGugNKlCyaRCA/4LhkfQ83e8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709275573; c=relaxed/simple;
	bh=Mbmej7DTPKrcTyiBy8oewiQhk5ktEG/Dmb6RkhXZtnQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kBP39lO2bR+OrpH9ZiCXvw9NtxuZnSSp+6dQnFzuqXQzci9//QDXqV1g+C5ys6DJVBpQGqjEuy/VxZ2TPuwTsGDyUaJVaXJQNOKlDgxYLnNIwK8WDENFsvh6JZIkaYvH/89enDzM2yFaRVUj6wHflGJ3ENkTPwgWI7ngn3tvxvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=f+l7wB+0; arc=fail smtp.client-ip=40.107.9.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bACM3AwBKxIRO4TNAxzeOIQ3ZOJNKbImk2Owyj+SaDMj7Gj7uoKEFQOeXsZdXtwuK9PsDAOgGfTQKc8uZoayxCcTf5zSGsGSP1CDyi+pKplRccRPDTLK2wKAYnT5xTwgdY+zGZweVWD7UWOK1Bnbfnm/zNk3H++xdJ/xWzVVmeKXw0wjkD9a+0WrTSWG9gcAdKwzmGmygDef3jkxSmZJweRaGbOUcotuZ1HQD29Hk884JXhYMvaGIlQmJo1cV77d7fFr0dRz9c0zwuA877H/f8DbanutJXByu/yHHxzW1PFpyVFZlrCJBRS5sosElYYTnr1dJVMjqRNKiPQAtk6TSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mbmej7DTPKrcTyiBy8oewiQhk5ktEG/Dmb6RkhXZtnQ=;
 b=HLZVn4nuilSZGGyjUYMjJHHtI3TKQq5Uf0IXR+ABVT4Fxvio52WRUg2Teq6vEtnwyUyaMtlgO4XR8zF+aZeBvtY8rkN8YVH8CMsE8aoooyds///N4fEkybViLfCItaWIOgLtmnHGrpcL9RuIcvi4BjHUMgzMBL0ETa4eUnXKmedlqBQ3lvxjICFRnyI9sPpgaFSUkYkOWctnGY2G4Si6hMl+l/qgh1h4FYQ5l8ENdPbgT92QxY2XeHNa+HeSz//RBe+mKaIVQtwJ8wbX2OPjgY1HWqlGiPMkM2thRNooUYh3xBZ3q1PpcOuFF1qg4Amt8Xrd5f5gb/nAiNbx/FoJXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mbmej7DTPKrcTyiBy8oewiQhk5ktEG/Dmb6RkhXZtnQ=;
 b=f+l7wB+04MCDYBojmr/lXZqALgkic/i4oG8KSpxgN1ILIuXTBuLHISiHST/clRuYuxEKGY4fwy6Uh8IljZ8gcVgDAHWJnc7zs4JrLsFGmk4ZoMNPjJw//bv/uF7dDPtyiIkY2aa+47IpqB99/yuMawQ9jPp42tFGgmoYoolF3Riy+7ALvFyI5ytfCow/BZ5+lVYYkRbwzMTsRt/xUht/wkfUYwiMzdjW7mW1+hC/RAmmb2xyX20mUPl2SOi1FFqOHIepRWOuLMIZtgZ03yqj0MmH/HE9iY0uxSN1InB7LlzdTuGkWY+GvpuJJl3WDR9GVS+7364yRbmC6OnYxLOuRQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB2488.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1e3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Fri, 1 Mar
 2024 06:46:05 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.039; Fri, 1 Mar 2024
 06:46:05 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Guenter Roeck <linux@roeck-us.net>, Charlie Jenkins
	<charlie@rivosinc.com>, David Laight <David.Laight@aculab.com>, Palmer
 Dabbelt <palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>,
	Helge Deller <deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer
 Dabbelt <palmer@rivosinc.com>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgABWg4CABaIhgA==
Date: Fri, 1 Mar 2024 06:46:05 +0000
Message-ID: <0bd79258-b8c4-45f9-9201-4d7ddf02dfea@csgroup.eu>
References:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
In-Reply-To: <e11fea7a-e99e-4539-a489-0aa145ee65f0@roeck-us.net>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR0P264MB2488:EE_
x-ms-office365-filtering-correlation-id: 34113522-5fa3-46b7-14a3-08dc39bb4491
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 xcir3gkzoJ9Ar8K0mtagOh/ziAdOdA7q8RnPY9KdfmnLiTx5QSghWcENGNT+8EjFAK5aDBPdq4mJkBOyC+ovpBUlyx6p9WQ8on+RkqHn9bmlr4rB7BTyoRTnh/0NG7bKfWHJyflyWxUhwkzXgt4NfUcic4OHa+CZha63wbGOC441+MdXuViMJPC4UvHAN6ddy9PlTWskzOYYgl7XvsdxKdEEtq0cvVcSfU0EYkse0ILlZUKVhjmmomSgMdBTRpntR+4vmEN/2MhnD0Nct6VqqMtrOHAy88rgB8UeigWU16wq7Sn3dpG5j5cqYPiKPpQ3BXGMOkGQZm/8LynbZEtggf5mvy0rSIbMgSNuYOKMIhxxoPTNrB+tOJE2VMmlyfk/Wz3+qdTfLRZdyx7Y0fJTknT+eufHpqUoRKNHKUK/QxvNWEF3uQAHauwuXG8DRIRuvvMIijxhG9RRZLM0U9zNEIr6v2+mI4ch4DE+thBMwSyT6UqOQ6IAsnMOSESBQiFdu0ZqFRE8azNdF91+ktHzjY8+yf9MpPxYjXm1yBlkoJ1p9Esx8Q/g2nobaUd/+KJm6Gy2vm/I4+aFAjeHboZxVt0g//Y7ePIdcfAvqzFCsEeYqouMR6/Z/M9kML5jPJ9nVR+Y0RDwhmc/i3/l4bB00svMcmwN6PjsUrnPFPxiS4mQp/3PLwuy78EUrR8ZuERhZWW3NwqaO5a9OI6L4UumHwTp5xdxk6nxVcHNFrpRRbo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q3dYSWNCSzBLaGxhTEFsczZENFdSTVVLbFdyWE5SdWZmb2FlZklSb2gyelNq?=
 =?utf-8?B?aERnazY2R0VFSGFDWThOVnJQbGE3enZKb2tpaTlzREIydnNkTFdmZU02b2ps?=
 =?utf-8?B?OVo5dE1JVjI4ZW5tWmc0OUdCSHNkQnEyS1J1SWVRRHl2aS9NZUgzbFpwY0Zq?=
 =?utf-8?B?cDV6aDNPazFibCtkOG1MWFdvTWkweFpYcFJxQUxibFZFWXVLa3pSVTdqYUdP?=
 =?utf-8?B?eTcxbThRb29nL1NPVHlTVzV3TGNGWkNyVVZIcVhQWW41aXUxSTVlVEc1a01E?=
 =?utf-8?B?TWVxMkx1OUNXb1NmZWNEcytjV3dHZ2Q3WGsrZFI2bVR1Y1ZST1NoU3VZTzRz?=
 =?utf-8?B?ekRwTndtOXI3T3VRZEk5N05oamltSGFmK3YzR2gzZklFYkJMMGdQelJTL3JK?=
 =?utf-8?B?UElJTFQrcVRodGVMSGRTNGVTV3BwZjR1MGlPY0lneUdpTlZiSGRLTERyeWIy?=
 =?utf-8?B?R3dNTkkrbEpZeUhCWFlWM3hvMk56N2N3R3dnSklEdVVtZkFvb3pWejhVM2tx?=
 =?utf-8?B?T29mdVRxK1VxcFJYdGU4YmJPTFJ6WTd3THI2N0JINGczUVlRQzRPUDBCNVpL?=
 =?utf-8?B?d1R0a2tIRU1xbE40ZlUxRjM5TU41OHNFRVdjaHowVGlYN1RjUUxWWHNlMlo1?=
 =?utf-8?B?QU5temd2L3pBaVdwZ2RXckpLaGFZMTNaekszTmpyTlpKdzRXRUhpWnRZYUYy?=
 =?utf-8?B?NlVVZ1dnUlhlZGV5OUhJZ3FQL0l0d1ZNT3FKcVZDazlOOTR1d1dPZzBkTmtr?=
 =?utf-8?B?UVFIMzJDOWd2TVo1RXROSFpPanFHdGZlODBlblVIdHpkOEtSclZDR3IySEJZ?=
 =?utf-8?B?eldrV3NTcE9uNlZMVEdHUDFLM1NCK3Z5U01ZYVk4UlN0bHphNFBZUW0rTkQ0?=
 =?utf-8?B?b29HVEpaRGducDFFaHdUZnNjakZIWTZHNTlkZmZKeHkwdklTbHpSb3J0MFQ3?=
 =?utf-8?B?blozRWxURVMzY3FTRi9JWUgzMUQzaWgzTHZBTTYrZERjSnpZM1QzaVM4T0NV?=
 =?utf-8?B?QWZCN0JQWEtGWk51bmlnc3RTbkhkVHdxSzRVaUJwRCtBcXVHSUF4OGNGaDd3?=
 =?utf-8?B?VWFLSnJwWGdtUm5JMEo4a2swbVJwMG8xcmJldG5QTURoMnp2Yy9EcGZQdVdH?=
 =?utf-8?B?WE81enFxMEJlb25SUVZMTzlBalZxVC9WUnRnME54ZTJvanpYNXF2bVI1Uklt?=
 =?utf-8?B?MlptTGx4OHFhdTM1dVlBNXV5cHNvdGRWZWRqQnpXa1M0b1I2dEhRZzk0U1ZH?=
 =?utf-8?B?OFdxN3hraUVtSXhMTi9HR0pEVzNOY2xQOGlReW50ZWU1S29JVEF0MGZNSzM2?=
 =?utf-8?B?SjZQUWd0NEhPZkh0YlM2Z2NyVTdvWTNMa3Q5UW41ZExqcXpxVXFkQ3ltbW1E?=
 =?utf-8?B?UWdGNnFrMEErT3RXbjFZVE40NnJHeDRyVzNaMVM1M3JPNUV1UXJ6TlUvM2hB?=
 =?utf-8?B?RnFPcFZRT1dOcTFuU3BQRFg1ZVZjWnU4R09SUGZyL0dvelE1WXMwRFVIT3U5?=
 =?utf-8?B?WFhNYmZWNEVTTTNMTVhNendjNFB6ZW5ROENlUHJCTFZuZ1ZJRjd6a1ZETmJv?=
 =?utf-8?B?Z1FOTkwwSjN3MmdYbDF1MGxIVk9WRDBvWHVXZ3F4dDBRQW5KTjFHRUowYzdS?=
 =?utf-8?B?cHBBcjNTYWJJZFg0Vnd2V3BmOW5BdEhHK3BuVzJXVGkxQ21uckhNeDZQOFRw?=
 =?utf-8?B?MlozYW5WMjQ0SGEybFFJVXRTVytDVmtOWkd4NXE4RGpqNXBBZXVyUzFRTDAv?=
 =?utf-8?B?cDlldUpjanZqeWVVQ25wNTc0TllXemdmRkFXK0VsSGdlZlJZQTk3Q21xbkdn?=
 =?utf-8?B?d1g5ZmtsWmVyRy9GUmtCMDNESVcxaFJ6bFJaL05UWEhqQmRPL2FabUZnREdx?=
 =?utf-8?B?cmIxTTRjQlpOc3NUbStPKzUvdEljN0RvY0hLeHhOZU54OU9QSDluQis3eVlE?=
 =?utf-8?B?bEhxYzl4ZW1KUjh0VlQvYmNVOVBwUGs2T2ZENVFLMVNYT2creitjTFE5K09W?=
 =?utf-8?B?MGo3ZTQxcUpOdGZOM1ZsYnhXQnhIeEVZL2JzNkxQZWxJaXo3SmJHRjh5bkR1?=
 =?utf-8?B?V1ZIK0xuRDU5dDNQaFdSR3E5RG1QTXNZUXdwc3RhMU1XVUJmcmdCZDhSWWc2?=
 =?utf-8?B?MHNHd1E3MUdEd1hkTnFGZ29CbnVOUGhTZ2Z4cFBDVXBXWDdCQTZEb3RuRE1q?=
 =?utf-8?B?NXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10647ACA6529BB43BF8D82B6597B5782@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34113522-5fa3-46b7-14a3-08dc39bb4491
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 06:46:05.1706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eYvG+7JiNcAld8LHGM0Dm5wqGdHTN9z0zyY0SU63MV48leol4H+X35hO3F8KHz5un9y+33eQU9cH8Gfws5X/hv07PLfDCzrqAEofwD5gmao=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB2488

DQoNCkxlIDI2LzAyLzIwMjQgw6AgMTc6NDQsIEd1ZW50ZXIgUm9lY2sgYSDDqWNyaXTCoDoNCj4g
T24gMi8yNi8yNCAwMzozNCwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+DQo+Pg0KPj4gTGUg
MjMvMDIvMjAyNCDDoCAyMzoxMSwgQ2hhcmxpZSBKZW5raW5zIGEgw6ljcml0wqA6DQo+Pj4gVGhl
IHRlc3QgY2FzZXMgZm9yIGlwX2Zhc3RfY3N1bSBhbmQgY3N1bV9pcHY2X21hZ2ljIHdlcmUgbm90
IHByb3Blcmx5DQo+Pj4gYWxpZ25pbmcgdGhlIElQIGhlYWRlciwgd2hpY2ggd2VyZSBjYXVzaW5n
IGZhaWx1cmVzIG9uIGFyY2hpdGVjdHVyZXMNCj4+PiB0aGF0IGRvIG5vdCBzdXBwb3J0IG1pc2Fs
aWduZWQgYWNjZXNzZXMgbGlrZSBzb21lIEFSTSBwbGF0Zm9ybXMuIFRvDQo+Pj4gc29sdmUgdGhp
cywgYWxpZ24gdGhlIGRhdGEgYWxvbmcgKDE0ICsgTkVUX0lQX0FMSUdOKSBieXRlcyB3aGljaCBp
cyB0aGUNCj4+PiBzdGFuZGFyZCBhbGlnbm1lbnQgb2YgYW4gSVAgaGVhZGVyIGFuZCBtdXN0IGJl
IHN1cHBvcnRlZCBieSB0aGUNCj4+PiBhcmNoaXRlY3R1cmUuDQo+Pg0KPj4gSSdtIHN0aWxsIHdv
bmRlcmluZyB3aGF0IHdlIGFyZSByZWFsbHkgdHJ5aW5nIHRvIGZpeCBoZXJlLg0KPj4NCj4+IEFs
bCBvdGhlciB0ZXN0cyBhcmUgZXhwbGljaXRlbHkgdGVzdGluZyB0aGF0IGl0IHdvcmtzIHdpdGgg
YW55IGFsaWdubWVudC4NCj4+DQo+PiBTaG91bGRuJ3QgaXBfZmFzdF9jc3VtKCkgYW5kIGNzdW1f
aXB2Nl9tYWdpYygpIHdvcmsgZm9yIGFueSBhbGlnbm1lbnQgYXMNCj4+IHdlbGwgPyBJIHdvdWxk
IGV4cGVjdCBpdCwgSSBzZWUgbm8gY29tbWVudCBpbiBhcm0gY29kZSB3aGljaCBleHBsaWNpdHMN
Cj4+IHRoYXQgYXNzdW1wdGlvbiBhcm91bmQgdGhvc2UgZnVuY3Rpb25zLg0KPj4NCj4+IElzbid0
IHRoZSBwcm9ibGVtIG9ubHkgdGhlIGZvbGxvd2luZyBsaW5lLCBiZWNhdXNlIGNzdW1fb2Zmc2V0
IGlzDQo+PiB1bmFsaWduZWQgPw0KPj4NCj4+IGNzdW0gPSAqKF9fd3N1bSAqKShyYW5kb21fYnVm
ICsgaSArIGNzdW1fb2Zmc2V0KTsNCj4+DQo+PiBPdGhlcndpc2UsIGlmIHRoZXJlIHJlYWxseSBp
cyBhbiBhbGlnbm1lbnQgaXNzdWUgZm9yIHRoZSBJUHY2IHNvdXJjZSBvcg0KPj4gZGVzdGluYXRp
b24gYWRkcmVzcywgaXNuJ3QgaXQgZW5vdWdoIHRvIHBlcmZvcm0gYSAzMiBiaXRzIGFsaWdubWVu
dCA/DQo+Pg0KPiANCj4gSXQgaXNuJ3QganVzdCBhcm0uDQo+IA0KPiBRdWVzdGlvbiBzaG91bGQg
YmUgd2hhdCBhbGlnbm1lbnRzIHRoZSBmdW5jdGlvbnMgYXJlIHN1cHBvc2VkIHRvIGJlIGFibGUN
Cj4gdG8gaGFuZGxlLCBub3Qgd2hhdCB0aGV5IGFyZSBvcHRpbWl6ZWQgZm9yLiBJZiBieXRlIGFu
ZC9vciBoYWxmIHdvcmQgDQo+IGFsaWdubWVudHMNCj4gYXJlIGV4cGVjdGVkIHRvIGJlIHN1cHBv
cnRlZCwgdGhlcmUgaXMgc3RpbGwgYXJjaGl0ZWN0dXJlIGNvZGUgd2hpY2ggd291bGQNCj4gaGF2
ZSB0byBiZSBmaXhlZC4gVW5hbGlnbmVkIGFjY2Vzc2VzIGFyZSBrbm93biB0byBmYWlsIG9uIGhw
cGE2NC9wYXJpc2M2NA0KPiBhbmQgb24gc2g0LCBmb3IgZXhhbXBsZS4gSWYgdW5hbGlnbmVkIGFj
Y2Vzc2VzIGFyZSBleHBlY3RlZCB0byBiZSBoYW5kbGVkLA0KPiBpdCB3b3VsZCBwcm9iYWJseSBt
YWtlIHNlbnNlIHRvIGFkZCBhIHNlcGFyYXRlIHRlc3QgY2FzZSwgdGhvdWdoLCB0byANCj4gY2xh
cmlmeQ0KPiB0aGF0IHRoZSB0ZXN0IGZhaWxzIGR1ZSB0byBhbGlnbm1lbnQgaXNzdWVzLCBub3Qg
ZHVlIHRvIGlucHV0IHBhcmFtZXRlcnMuDQo+IA0KDQpXaGVuIHlvdSBzYXkgIlVuYWxpZ25lZCBh
Y2Nlc3NlcyBhcmUga25vd24gdG8gZmFpbCBvbiBocHBhNjQvcGFyaXNjNjQgDQphbmQgb24gc2g0
IiwgZG8geW91IG1lYW4gdW5hbGlnbmVkIGFjY2Vzc2VzIGluIGdlbmVyYWwgb3IgZG8geW91IG1l
YW4gDQppcF9mYXN0X2NzdW0oKSB3aXRoIHVuYWxpZ25lZCBpcCBoZWFkZXIgYW5kIGNzdW1faXB2
Nl9tYWdpYygpIHdpdGggDQp1bmFsaWduZWQgc291cmNlIGFuZCBkZXN0IGFkZHJlc3NlcyA/DQoN
CkJlY2F1c2UgbGF0ZXIgaW4gdGhpcyB0aHJlYWQgaXQgaXMgc2FpZCB0aGF0IG9ubHkgQVJNIGFu
ZCBOSU9TMiANCnBvdGVudGlhbGx5IGhhdmUgYW4gaXNzdWUuDQoNCkFuZCB3aGVuIHlvdSBzYXkg
InVuYWxpZ25lZCIsIHRvIHdoYXQgbGV2ZWwgaXMgdGhhdCA/IElzIGl0IDQtYnl0ZXMgDQphbGln
bm1lbnQgb3IgbW9yZSBvciBsZXNzID8NCg0KQ2hyaXN0b3BoZQ0K

