Return-Path: <linux-kernel+bounces-81315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279D867404
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DDAF289BC3
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 11:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226485A7BB;
	Mon, 26 Feb 2024 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="YVp7QDxM"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2092.outbound.protection.outlook.com [40.107.9.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617F91CFA7;
	Mon, 26 Feb 2024 11:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708948649; cv=fail; b=F0ZGuClqkRy3M3qHnI9DuEvbxEtkygWpip7WpUcV1KF0yTEgGSdNyVER//A0X4GYoN7iquIraub5teCjIGQ6N5r1YOaSlFH9q4nm5ZBOlNqTeKVzsRNFK2Dk0bN3QO5aOwflSaQY/5KO0uRHL9BwaJ/yfC+kr+Lcso5f/0kgcpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708948649; c=relaxed/simple;
	bh=XiH9HbTJvy5PUl/70pNKGVdSxUYLuYy+y9abUmwWgks=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ruOQuGJf/azEDM2vnWVSfIgynaXdm3Myd87058OaOFVQYzSsJP2D5SMObG5pXSiIc+6CuBmTI3yuwx5S3c8NxnclJ9/JpuCgEIyI4YhHwaZjFl36yVpWeR6b2K7wA0GqeLPDPbYG8IenEBvm7x8FUJTBZSnxiVzOx/DIfDZkCxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=YVp7QDxM; arc=fail smtp.client-ip=40.107.9.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SKOdpzS8aSBJObagPceujP6+JuTSmjER69x6gTj0GG7l3LzbuuRsQ7JwMPte8OrRVLeYzX4pHSKx+6EY2VoleixzS4y5jjTyAIOwuwE2zfFjqyyLSubitT1onHdFh/ylE5bnz3nITTrK7Eh15sXcDu5SNSrDVK7ob8gkI8eT43DsN1okbK22YYbSMptJDm3O2wVy1OTxHkAOwtNAisIQlnyHzim3vXnADqHpfT30Vgk2blyXDUUBRfniB0yvCrQVTLhBoy4lo/RQs1q5pa4yfc1Ms4/lUfABLiKqT0oL+RsgCGqFvR9kFj+mwd3aPUO58JsxsPHWOK1g/aX4XSTqhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiH9HbTJvy5PUl/70pNKGVdSxUYLuYy+y9abUmwWgks=;
 b=QbLmB0hZBXgTAupKvUugejJdO99zphTTP1YRji+QDb1aoF0gN7JEUDh+Rt54ukN8K7CT6pGdQnXUBNxxhYgsq/wZmpcaP38k5vG2dWv67j/RWz8vAn6wGTH2X9GiKPi7qbkbXX+w7Kkw8WJwE/WcOkzQcDkh3iHwrOpWf31nXwSlbgK9lNcvaRG9eHt0sgtR25EWQs718B0Hlc1I/LkPrXTR9yB93dQ2Jk+BIOYx8SflB4XHnBDV7XiU1xCW1MiCpmb6IeRY0Jl4Pv1l57uM7qmxemk7jdUgU1GRzmsyphaj88mG6eB7tDo1ijvmcgzCrXliUgGjLBe4or8Zkrz60Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiH9HbTJvy5PUl/70pNKGVdSxUYLuYy+y9abUmwWgks=;
 b=YVp7QDxM8mnaC3qtDIRYMag9QA4lPCIADsL53WXk8WzfVxK75EpAK4E+J3ftrJMus+cdu5stpYRHEgebNLnyE5k3UDp5Lto1ITQuVtCbbdYKh6Lzzk75Dr0T/rSCKfhOfR1C6abmfj9sOb94G/TY7m3gawqNja+zlsrkwtfBoYdSWuUDjdZxRxpOv+VfpBsF9eFFt/G+NgVDqOMV2a62P28A1iipYE/areef+wBH+7GJyck/tGTabz69qbosk2njU9RsYXYWyyfNA1t35GcqOb+Q8yYGK/OaC2q9zq1C6vbgvk+j+SkpzkvzRnY+lkRc3IywPOzSuD4h/vHWghdqqg==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2398.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Mon, 26 Feb
 2024 11:57:24 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7316.035; Mon, 26 Feb 2024
 11:57:24 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck
	<linux@roeck-us.net>, David Laight <David.Laight@aculab.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Andrew Morton <akpm@linux-foundation.org>, Helge Deller
	<deller@gmx.de>, "James E.J. Bottomley"
	<James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v10] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaZqVM7f0VA9oidkaHzRbh3i5s67EcglMAgAADmgCAAAK0AA==
Date: Mon, 26 Feb 2024 11:57:24 +0000
Message-ID: <96b3fcfd-6932-4987-9831-5abdad8d445c@csgroup.eu>
References:
 <20240223-fix_sparse_errors_checksum_tests-v10-1-b6a45914b7d8@rivosinc.com>
 <7ae930a7-3b10-4470-94ee-89cb650b3349@csgroup.eu>
 <Zdx6YMRdPmb595M2@shell.armlinux.org.uk>
In-Reply-To: <Zdx6YMRdPmb595M2@shell.armlinux.org.uk>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2398:EE_
x-ms-office365-filtering-correlation-id: cf2845b1-528d-496c-2e19-08dc36c218ac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PXLWTM+kyTmX1NobggX3fydf2PXgF+7aFyrnwUQngIcmXVSRrdPYwynEaO+UC3I9015xEhPK3DuhoIAbPCfefiRkD/hvO3IjlfwVK5UlgwXzUAx0om7/rEHUoPPD7ZGoJxHNTpRI8MG5p9qogcG7MWvUKnfIDxBJJUtkdGrVLd0LFi/A4XyKfUJDArN66DJroF9QuYqsZtdR5eWNo9YRfH/4v7wa+TObqf0z41CgvCRPa/TTDMrmmY6sLDp73hIXeJK5I7KOfXNCJKMbY1AM3jNJBb9G6kkJ1tfnPiIn8f1ABfwR6mSTBp8c0XNmEIJKY5jY2NVaktC9SWO1pCNJsmyvejq7T4sh91RMiSvQ0ismyBf9BcMmnG3zrnricafguiVVOIs+qZrFyWsER/xWYp9HFshXZTxmQQTiTDnNCp4zsI0F7C8rifcbgKP5XNGinGsaBKBLRpDJyj4IDeXJYwQ7RHWJiB5cAyB37QhodWDhX6ug377LK0OA9sC+BwUXBDaJ0hwRG/5dx44LvtX7Ok3GxPysFA/dh96nYIGXcn85cnGctpDZvHLJ47Hh6rbAug1ejnLo2h2MoPTeue/RiNKY0TL2+65s7BVkvPwOZHWWlMC12TDA8daclCqUg3RzhJ6ZBNYXVzEVw4lqJvTS2qEG2ES983suz95izu99+OxEhgtsavGEaP+biXevLjrlLs40J6choCRVxyJsJ56V8P/MwDDTcXquPAyRuFenkRk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MzdTUnFCNVFyQ3NqbTF6UWJQbmVtMXhyUDdCU0J6MTJSYkhhSElqUmhJOVcy?=
 =?utf-8?B?WGQ0NldhRGRxSHorRm5QbHNTOUJJdEdqeTlRR0tpaVpkYURJaFJ2aXN0U29M?=
 =?utf-8?B?NmtqQU1xbHlwVlBqZ2dTdjlrWWpTZzNoN0Q5Rkc4b0RRbmNudmdZOHdkR2ZG?=
 =?utf-8?B?UUNjdGhuK2FOZnBIL1U1eSsvbmRZVDdFTXBBV2FWYWs1NE5LWU5ZQ2oxQ0N2?=
 =?utf-8?B?SEJIYlNLbE1pczF5Z1hMVTZUeWh0K3dMKzRFR1ZKaGNvOEh0VE5UNW41R1VN?=
 =?utf-8?B?YnYraXdHTEpQYkJ1UXVPUWlxQml5ZkZ2ZkRmVnJ2MWlERHI3TUFwdWJkbHp2?=
 =?utf-8?B?R096QmtJOGZ0bG1IMzh0ZzdwRVVQZFhuN2xCSlJDVkludDBiZEFKaSswc1ZP?=
 =?utf-8?B?UW5WV1J5cTBWT2pSSVJQbmxHL1VFdTF3bjF4dlRDdHRqTlpLUnNHaC9ySi9t?=
 =?utf-8?B?azZyRzBuZFRBNWtpaWYvM3B0Z3g1UDloaVJYVFVidTdNZ25ZZnphNGVlVzhy?=
 =?utf-8?B?NHNGS29wenR4aVFMeHlWNlZiVjFNUmdQZkFZV2ttQWlNRElWZGZSV1hrRG9H?=
 =?utf-8?B?OUhwK3BOb0JESnpJTUdkYlRxdjFhRjhPN1UrcE9SQXowMW44YUhLWDRMY3pX?=
 =?utf-8?B?Mm5QcEVERm5nYlEzWnc1TFcvTWY3TC9VaGN6aGNzZXRCbHVKRW8xTEpURldW?=
 =?utf-8?B?aVMvdG1QMEF0LzU5RHpKYUZrajFoL1kvcEp2YTZWVGtXUTIzMHF4RkdMOCsw?=
 =?utf-8?B?citVTUdqaHh4bERia21vVVh0WXkyU1NWUnFhSTVXZDBoVEl4TUEzZmxFYnpt?=
 =?utf-8?B?UlVGcHRPc3p2dUUyc3o1WXpyYjVTT2tadGl2SFQ0OGVFbjdEaC94UWNIaWF3?=
 =?utf-8?B?aUZSUEwwRmJTdkpqeUtaeXJ0VU5PZUZlMzNQSmxEUHRBQ1hNRlJVajVpdjBo?=
 =?utf-8?B?UmVkenJaVCtlUGpTa1FKbFAxZVhpTEVtNVRvenROc3lHT0huM2oyQ09mZTNN?=
 =?utf-8?B?TWF1Wm9qZzVqSkUrNjhDMnlrUU1kaTNiVHJXMzhmQ0pDanBOWXRuZlllN1R5?=
 =?utf-8?B?SWNVQVdSdEZGbm5uUE5mS2hLTUUzVHY1MldYeEdrVjU3a1RaUGlYOGVkbWF2?=
 =?utf-8?B?QzFzcGhubnYzN2ErN1JKUHFDa3M4dEh5TGxaN0lCbmdCL00xdlh5VG1IcWd0?=
 =?utf-8?B?TkNERzd0KzBFWHlucXIwdWcrOTVRb09JY2gxeGFQVUZtYWNpNXZndUVmU3d5?=
 =?utf-8?B?a2gwejZ1MllRaGZWaWlFd0g5eVc3Tmc1aWpyN2JycEFCeFFWS3RmUTZGWE1s?=
 =?utf-8?B?Y2IrL2ZTWXlqZkc2WnhqZHVZTVFKaEQyRnpnMUl4MjR5SWlJcmk3Q2JkT05y?=
 =?utf-8?B?WStHZnBvQ2d3M3pjOEF4aE5Pak9xMENvNWl3dWIxOFZ2QnZtOVlqWm56SG5z?=
 =?utf-8?B?b2k3V1h4UGUvZERES2VOM0NyS21LOTRtRUhXenpZZGRBS2ZwU1ZUalVycmZY?=
 =?utf-8?B?L0U3cDdJUTBlL21mUVBrK0p5TTJheThLNERtNG9OeWZYb3ZWMmxGcFNxbUhl?=
 =?utf-8?B?QnJzZkcyMGtieWpQd1ZFcThFbmtFUkFqbC9Xc0M3ajRNNThGZVRyMXo2WEdX?=
 =?utf-8?B?dnVDY3FXSnFKcWtSSTFjNFVwQ1owNEg5cjF5dVd2bGdiSVVZalJFVnU4b0NG?=
 =?utf-8?B?VFhlTHRHK0ZZZXoxUnJsOXdTZmFiMis3OUhjM2FzZExoYUpFMXBzWHJ0Zm5M?=
 =?utf-8?B?QnN1Q24rRHhOL2FRSmtZellWNFJCWUJYbjRiOU1pY2EyYkFQeXVyWlhBbHlO?=
 =?utf-8?B?ZUhlVEpSRHJONS92K3N2b1cyVEZmdkJKTElLTzAzWEFKZlNqVnZWckFXT3NY?=
 =?utf-8?B?TzhwUkJDdUxMMzlyaFhLU0lzY2VvdTczOFVOTHByMjA2SzV0ZEpXc095Y1p0?=
 =?utf-8?B?NXlHL1Y5b29CemU3QWx0QW03eFdGeWVYRHZaek1JR0RmZndTajlzNW4vZjht?=
 =?utf-8?B?NFdhWUlaakxVMHRhblRzL1dsNk1xZTRuQlhDQ2RYV0hlL0tYUjAzMVd3SUxZ?=
 =?utf-8?B?T3hCUnkrc3FIdDBrL0xPeDhMOGFtMmo5SWM0RlNCczhMVmxMOTFiNC9BblM0?=
 =?utf-8?Q?lRjYH6yvxUa+8ScPeWsJvZfMg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6CB17FA176D95249BE9627EB7CED324B@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2845b1-528d-496c-2e19-08dc36c218ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 11:57:24.5243
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nvdrkv3t4nuG77Fq3jeP/Cs4yeeh0dxIcjzVQuVb6XZ/a1H96HthamN49zJOg2lCPOK+R2fhyc4wV0k7m6M6rVnF6lBvkVhsaH8Ev+EaNJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2398

DQoNCkxlIDI2LzAyLzIwMjQgw6AgMTI6NDcsIFJ1c3NlbGwgS2luZyAoT3JhY2xlKSBhIMOpY3Jp
dMKgOg0KPiBPbiBNb24sIEZlYiAyNiwgMjAyNCBhdCAxMTozNDo1MUFNICswMDAwLCBDaHJpc3Rv
cGhlIExlcm95IHdyb3RlOg0KPj4gTGUgMjMvMDIvMjAyNCDDoCAyMzoxMSwgQ2hhcmxpZSBKZW5r
aW5zIGEgw6ljcml0wqA6DQo+Pj4gVGhlIHRlc3QgY2FzZXMgZm9yIGlwX2Zhc3RfY3N1bSBhbmQg
Y3N1bV9pcHY2X21hZ2ljIHdlcmUgbm90IHByb3Blcmx5DQo+Pj4gYWxpZ25pbmcgdGhlIElQIGhl
YWRlciwgd2hpY2ggd2VyZSBjYXVzaW5nIGZhaWx1cmVzIG9uIGFyY2hpdGVjdHVyZXMNCj4+PiB0
aGF0IGRvIG5vdCBzdXBwb3J0IG1pc2FsaWduZWQgYWNjZXNzZXMgbGlrZSBzb21lIEFSTSBwbGF0
Zm9ybXMuIFRvDQo+Pj4gc29sdmUgdGhpcywgYWxpZ24gdGhlIGRhdGEgYWxvbmcgKDE0ICsgTkVU
X0lQX0FMSUdOKSBieXRlcyB3aGljaCBpcyB0aGUNCj4+PiBzdGFuZGFyZCBhbGlnbm1lbnQgb2Yg
YW4gSVAgaGVhZGVyIGFuZCBtdXN0IGJlIHN1cHBvcnRlZCBieSB0aGUNCj4+PiBhcmNoaXRlY3R1
cmUuDQo+Pg0KPj4gSSdtIHN0aWxsIHdvbmRlcmluZyB3aGF0IHdlIGFyZSByZWFsbHkgdHJ5aW5n
IHRvIGZpeCBoZXJlLg0KPj4NCj4+IEFsbCBvdGhlciB0ZXN0cyBhcmUgZXhwbGljaXRlbHkgdGVz
dGluZyB0aGF0IGl0IHdvcmtzIHdpdGggYW55IGFsaWdubWVudC4NCj4+DQo+PiBTaG91bGRuJ3Qg
aXBfZmFzdF9jc3VtKCkgYW5kIGNzdW1faXB2Nl9tYWdpYygpIHdvcmsgZm9yIGFueSBhbGlnbm1l
bnQgYXMNCj4+IHdlbGwgPyBJIHdvdWxkIGV4cGVjdCBpdCwgSSBzZWUgbm8gY29tbWVudCBpbiBh
cm0gY29kZSB3aGljaCBleHBsaWNpdHMNCj4+IHRoYXQgYXNzdW1wdGlvbiBhcm91bmQgdGhvc2Ug
ZnVuY3Rpb25zLg0KPiANCj4gTm8sIHRoZXNlIGZ1bmN0aW9ucyBhcmUgZXhwbGljaXRseSAqbm90
KiBkZXNpZ25lZCB0byBiZSB1c2VkIHdpdGggYW55DQo+IGFsaWdubWVudC4gVGhleSBhcmUgZm9y
IDE2LWJpdCBhbGlnbm1lbnQgb25seS4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aGVyZSB0aGUgaWRl
YSB0aGF0ICJhbnkgYWxpZ25tZW50IiBoYXMgY29tZSBmcm9tLCBidXQgaXQncw0KPiBuZXZlciBi
ZWVuIHRoZSBjYXNlIEFGQUlLIHRoYXQgd2UndmUgc3VwcG9ydGVkIHRoYXQgLSBvciBpZiB3ZSBk
byBub3csDQo+IHRoYXQncyBzb21ldGhpbmcgd2hpY2ggaGFzIGNyZXB0IGluIHVuZGVyIHRoZSBy
YWRhci4NCj4gDQoNCk9rLCAxNi1iaXQgaXMgZmluZSBmb3IgbWUsIHRoZW4gdGhlcmUgaXMgbm8g
bmVlZCB0byByZXF1aXJlIGEgKDE0ICsgDQpORVRfSVBfQUxJR04pIGllIGEgMTYtYnl0ZXMgKDEy
OC1iaXQpIGFsaWdubWVudCBhcyB0aGlzIHBhdGNoIGlzIGRvaW5nLg0KDQpDaHJpc3RvcGhlDQo=

