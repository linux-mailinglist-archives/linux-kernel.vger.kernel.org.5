Return-Path: <linux-kernel+bounces-69248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE5C858639
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 544CE282F98
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 19:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC60137C31;
	Fri, 16 Feb 2024 19:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="jGu7TOKU"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2123.outbound.protection.outlook.com [40.107.12.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3651350E4;
	Fri, 16 Feb 2024 19:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708112137; cv=fail; b=uFF3+volEuL2/3rn6NZWGHu1PRWn9lUeCgJEQndNYaMlMrVqgmk1VGTD47zo0qEDgCp3G/2l5+WjRqRZtFiKQzgkipl07qSh8+lA9CEv7viDryhHKLcS1YyojDtLVIH5O4sqT46OrHjusj5bY2/Lo79rCF2AAgAohmDDZLCZgds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708112137; c=relaxed/simple;
	bh=EojwXAbU5kHOn4ZIlJ0TT2fBiUmrcYEjqvRV+ECtbhQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D1obfPcABwsO91cstSn94WnOb1WclQqxrLuU1vW6odtNnRuX1la79crKsuBQEaf5iowpbrMETQ5/2aYLpX4SF0/MYQ16g1yh1nVrKklIYD7gqmASH9qE8BSe4Y+oOAAzEYFuA4VcEhvuaeqOqwJaukaBnzac8OMuwKwqxHibyVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=jGu7TOKU; arc=fail smtp.client-ip=40.107.12.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P938WWysBglOuLrjWDHkaim1wpqjaMPN32/imh2BBY5ncBI0w4nmPhzqBFGXUGB2gGyFVbsUaE/7qP/a8mw+crd0mxabhUGnd1ukPal8l5j8vGKk6KRoYElLRhgYjVIRw8/pT18rYIkW37qCvAIspUX1O9qZLgXbRn5puybrRSMlJqItNcCbyoLCfM3FwR6A/ZstfLl6pUvEkM4xJUPu/14AhzB1c3MJ8AvsywhnXIXhkhohPPG/ardKwnrmcpy57Wp4zAlzB97U+8uQQTtfcWsRm/fiqLy5xctpltGdWq+Dyi5aNGjN6q+pcIFRM0wpHAl0Txl4yUl57LV7X9v9cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EojwXAbU5kHOn4ZIlJ0TT2fBiUmrcYEjqvRV+ECtbhQ=;
 b=M+oyttbMoI4qsud4YbvaeOmXVXk2DA4fSAWbCZdV6BOOU8DZLzYPJQMUP9NlqSh1OKiSPhbtoBuFer2hvo+daJjKojjvih0H/IJAeFrC6qlHggpT+2q5vHdATHHedEs2gAXSnyWaODOcRfxtUJbSXjlxjUEozHgLXnByEB2CjXERNmP8HqAdS4CRoWKEbIPKdzltj9sqlBnHTq9wtieDiHF83Qh+gXtn/cds6o+9+ee9J2i7L3iSVCWexw+SLpJEKf9ElZfnpZnAvGfsuPuiTzu0fkpSsx9MxfKJOoebSKLjFmn+xIyI4zVyb+LDilo6wpQGG+16kGK7IRbt7T0j9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EojwXAbU5kHOn4ZIlJ0TT2fBiUmrcYEjqvRV+ECtbhQ=;
 b=jGu7TOKUvCFU5QVGQunNsdbPSJPoVL6qWjpWgV3vMMvg/yopD6W09ma0i+Pi9dFlgZqiD/YvxdUFcUPFZzZAI3JRsC/FazWMYpHFHiclAOTH29gr9nn0kAhVLpubBVbWMbc+yTZUNfrShCQc4mNJ9ua3rbXuPir4m1N89ZjfOOibxzczqULxT5WoXyel7+fQ5Lg0I9cgWvKJi4ZMR9dAhnb2czVdhljVdXouiUPbOcF34+43yw7oQlwUMGGyXvMEmf1+OqiwJOwQsQHr+n4i/5RZpRlRiAVVoupabkbTCplPR+PoizAkN3w0TiExBkoneDVPSt6eh8q6DZnOl3E16A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB3285.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:141::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Fri, 16 Feb
 2024 19:35:32 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.029; Fri, 16 Feb 2024
 19:35:32 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Kees Cook <keescook@chromium.org>
CC: Luis Chamberlain <mcgrof@kernel.org>, "linux-modules@vger.kernel.org"
	<linux-modules@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening @ vger . kernel . org"
	<linux-hardening@vger.kernel.org>, Marek Szyprowski
	<m.szyprowski@samsung.com>, Mark Rutland <mark.rutland@arm.com>, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Thread-Topic: [PATCH v2] module: Don't ignore errors from set_memory_XX()
Thread-Index: AQHaYLA4WWYhqLg05kqaZUvko5K+cLENW1cAgAAB44A=
Date: Fri, 16 Feb 2024 19:35:32 +0000
Message-ID: <12b5fa1e-c6cf-489b-b7bd-4f9d5ed9aba6@csgroup.eu>
References:
 <21037bf38438a285f5dff9501668f1675bc45989.1708070781.git.christophe.leroy@csgroup.eu>
 <202402161128.21EA3F8@keescook>
In-Reply-To: <202402161128.21EA3F8@keescook>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB3285:EE_
x-ms-office365-filtering-correlation-id: 8841c7cd-ffa9-43a3-26ca-08dc2f26707b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Y7xGRo6NLc8iOcEV3W5mN66Kj9/bK4P1GM//l0r5MChAeocxsuIUb9SafIfQ+vBV5AgaPYSutMLcAEblLVEQNzc2XfeMtSP4CmcOF6/UcP+i2Lt/+I1Hv6IYeLWW/kTNIcGvQBc/HedV4zoQsk/jWbZDFCRy32jReoowvEgFWp+ToZoGP91Aii5+cO3CXvqdnSN3EOLeqQ3krh5XIDcWJq/IKz+jejqm6OrZPMfL1D34RxRYPRBt1BH8Y1FRwOQ0RkYHQd9fsgiqixzjC+Sj5IDqiVwnglP9JTWySj1VYpWNlwQPH+ol0mzArIfJhM+sVjZ1QV6yWlHooF5XeVJNTBLtAPDol2sDqZByi84eGKouHpaKdjBJ0ZWAiMd3ZCKw/3titutudTaO4SGUFMm7MdJqf3lSpbwQYuDTEgGXFs8o2omWwwY/3Xzw5lmIG4fRe66dUg8cylfPcf7rN5RG54VTes1sEkptL/WTctcP3ECnKaplpZ/0IaaHrGhV7ytWjUAO37wnnR/18+e/yIUxQogpt/ikYggCO1xz3BNymu+Pnbn+Y0S7xUsCoFAtVG6r7dkmN6uzFN8XdpyQBUIX4xdYiCpydOavAxk8xpKhOs0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(376002)(396003)(39850400004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(8676002)(8936002)(4326008)(6916009)(44832011)(5660300002)(2906002)(38070700009)(36756003)(41300700001)(2616005)(26005)(478600001)(38100700002)(122000001)(83380400001)(66574015)(31696002)(86362001)(966005)(66556008)(66476007)(66446008)(64756008)(66946007)(76116006)(6512007)(6506007)(6486002)(316002)(54906003)(71200400001)(31686004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3IrY1VDcDN5K1pnMHl0RWRkOW4zSU4xOTNPTzFjN0MyZlA3RXZQdlRZRnFR?=
 =?utf-8?B?V0tVYmk1S0tmejRpYS9rVmlja0FKcURlZGZhbHJOL2I3NXFHMXF3RXZ5bzhM?=
 =?utf-8?B?SHUvQU12ZkFtRWpZdXdSSzRFam1wWllFbWtNVjA2NXlXaDZMZjFYbGNTQlNK?=
 =?utf-8?B?S3BYWTlOODVaUWZTc0sxNHZ5OC9RcXRmS1c3djZHSElza1lYeUp3Q1IydzdT?=
 =?utf-8?B?VzVmZTc1WUFpN0oreXlUU1krTStzNnFHMGFlMkdjRUJJMHBVUEVKUXZsTngz?=
 =?utf-8?B?Q0tLeFFZdGJtakRKQTNSM2xGTWk5Y1dBN1lSeEpvNkJPRWFtNjVrQ1Q2Misv?=
 =?utf-8?B?eWNENzFNODVSRVFHenNmbEJ5dlA1anpNam1qTkMxVXFyd1pRK0JiYms4VW94?=
 =?utf-8?B?VWpLcXRTaEwrZ2NwcCtDb08raTdISUFkN3VDcUw4elFaaEVrRFR0TWJwOWEx?=
 =?utf-8?B?WDB0WkdNMTJ0YmdhWnFoVElXMjdMK0Q5dWkra3cyalQ5MFVMVG44KzVOZVl1?=
 =?utf-8?B?SmhBdGszdm9CaTlKVlRELzNldU13MGxoeDhwYUpZUUNJa050ajZnTzdPclhW?=
 =?utf-8?B?Z1FLMFcybk9mNG9DT0wxTVdDZnZhN3h6K05Dck9LajF4dUpmcG1XSW9hUXJm?=
 =?utf-8?B?SWVKSzdpL0ppSk9BaFBqa1FNSlJtc3dHMEJUMW5WQTdqcHAxRmlldUVwbHdW?=
 =?utf-8?B?dlhvbXN2V0ZjRW5kc2VrTFBIZ3poWVRDc01MT1drR3RYUU5EblFKV29CaHNk?=
 =?utf-8?B?S0t6QmJNTWVRVFRvLzNCNVh6d2syaUdMT3p5NmhhakZENmJFRlFVOHFuazVQ?=
 =?utf-8?B?bzBrNHRKMDcxaXY2NFd1OGQwSHd6eHQ4RjArenB2YVBCMkduN2wyRjhiV3M5?=
 =?utf-8?B?bUwreEhaTlZPRTd6QzBKN1JaYU45M2lFeGpnbWFSTU5XOEg1VitVdElZSitO?=
 =?utf-8?B?QW8reVNUakx2a0pHai85NkdUclN3bFlxK3VkUXNmY0F3emV0bk15eXF0OTVm?=
 =?utf-8?B?c3RJempXWHhqZVZFTVRvaEpMeWM3aStrMDVSOFIvZDFvRkxlZEZHRHNDZ1dn?=
 =?utf-8?B?UnQzeml4ZVdaRVFSL05zNFp6UmZ1YjJ0MjVWSmtabDkxbmFqeXozWjRSNSsw?=
 =?utf-8?B?RytXY3RWSHFzYmYxYW94SVJUNnh4amU5TEtRZE9oVUJHTmtKNnk2ZDJXNjJE?=
 =?utf-8?B?SUJ4VXNUcFFYSkVKekZVUzZMckgxTTlSVkhTZGdWQnJkaGtxQ3J5Y1dsazdt?=
 =?utf-8?B?MThoeUc2dHdidXpxQ1cyckxhKzhTQVNkaEh4NzFDTTlab3ZGcHlsMEMvZm9T?=
 =?utf-8?B?SlR4V3ZBQzFkMjkyT09ocGI4aVFPWW1oZmlpNm9pYmE3S0V2V1hoa2ExUTk2?=
 =?utf-8?B?NkI1b0p2NEMrdno3eUR6VkFrek81bjFLMjBZTkROTlorU3ZweW5wRldnaEVN?=
 =?utf-8?B?bjg5NDNaeHdmSFYvQk9VMVhuQmNaSEExdllrdHZRTVJoVFpKaDIxQVdCbDNX?=
 =?utf-8?B?QjhsaTQwczJGUE5KV2VMSFhlczdISFEzcDU2OUJpRDd2emJYaC9CdE5TN3ZZ?=
 =?utf-8?B?ek10SWRId0VVODdoa21sbm5DUWxTUlNaRVhvNGREMmZKR0RrMS93dktnYWhs?=
 =?utf-8?B?UGVSc0x4SnkyOU5qZzNaWm1vZ0tXcDdNTE1kWTlPYXQyZW5GM2pQRUJtUUQv?=
 =?utf-8?B?bVVmRXVFQVVueGQ3VEpFZWhQVk1PR0F1ZHAwUXlUWXlBWTNtVFVuUjFzamdr?=
 =?utf-8?B?aHJyQzRiUGt0ZGEyL3BSV3ZVdkRIZlVMUUNVNHJGd1RJYzRWWjFSNGVBMFF1?=
 =?utf-8?B?bGM5OXhmaWdPMU0vL1U2dzZMNjhuV0lEQmNTWDkxbndsQlMzMW96QXoxRHhF?=
 =?utf-8?B?VVJucmVqbWx1OU1tRUlSNnhoUVpENkxaZjh5ZXFNb2RrdjhjL3p1RTlHZk0y?=
 =?utf-8?B?MmNyakFvZkJXQmQvRGtpdFZrZTZFTllXeG5TdjdPZzFzbXltUHJ2ejhDVnBM?=
 =?utf-8?B?NVkvdlYvVWVkS2NYL0hXU1AveDA2VDZadU1FV1ZJRTNtc3ZJa3llZVk2OEhu?=
 =?utf-8?B?TVd0d1VjSGxORXZmS2R5MklzSlJzbnZqQ01HZFdEVVMwRmF5RU1RVThVK3Nj?=
 =?utf-8?Q?5LUn50q95B1COwF5jxC8mVjWX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B9E2B01DD578949B623E5D9CE7DB1E3@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8841c7cd-ffa9-43a3-26ca-08dc2f26707b
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2024 19:35:32.1598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f1cACIdlRwOSPXv8TTfEKSHmd4ySx6g3emgO7byMf8IvGeXrtO5KiacQUfIoef+qVuwqE9b8Oj+z6VAVW2jbp3qqLyXx/yeaRj/V2xNrqf0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB3285

DQoNCkxlIDE2LzAyLzIwMjQgw6AgMjA6MjgsIEtlZXMgQ29vayBhIMOpY3JpdMKgOg0KPiBPbiBG
cmksIEZlYiAxNiwgMjAyNCBhdCAwOToxNDoyN0FNICswMTAwLCBDaHJpc3RvcGhlIExlcm95IHdy
b3RlOg0KPj4gc2V0X21lbW9yeV9ybygpLCBzZXRfbWVtb3J5X254KCksIHNldF9tZW1vcnlfeCgp
IGFuZCBvdGhlciBoZWxwZXJzDQo+PiBjYW4gZmFpbCBhbmQgcmV0dXJuIGFuIGVycm9yLiBJbiB0
aGF0IGNhc2UgdGhlIG1lbW9yeSBtaWdodCBub3QgYmUNCj4+IHByb3RlY3RlZCBhcyBleHBlY3Rl
ZCBhbmQgdGhlIG1vZHVsZSBsb2FkaW5nIGhhcyB0byBiZSBhYm9ydGVkIHRvDQo+PiBhdm9pZCBz
ZWN1cml0eSBpc3N1ZXMuDQo+Pg0KPj4gQ2hlY2sgcmV0dXJuIHZhbHVlIG9mIGFsbCBjYWxscyB0
byBzZXRfbWVtb3J5X1hYKCkgYW5kIGhhbmRsZQ0KPj4gZXJyb3IgaWYgYW55Lg0KPj4NCj4+IEFk
ZCBhIGNoZWNrIHRvIG5vdCBjYWxsIHNldF9tZW1vcnlfWFgoKSBvbiBOVUxMIHBvaW50ZXJzIGFz
IHNvbWUNCj4+IGFyY2hpdGVjdHVyZXMgbWF5IG5vdCBsaWtlIGl0IGFsbHRob3VnaCBudW1wYWdl
cyBpcyBhbHdheXMgMCBpbiB0aGF0DQo+PiBjYXNlLiBUaGlzIGFsc28gYXZvaWQgYSB1c2VsZXNz
IGNhbGwgdG8gc2V0X3ZtX2ZsdXNoX3Jlc2V0X3Blcm1zKCkuDQo+Pg0KPj4gTGluazogaHR0cHM6
Ly9naXRodWIuY29tL0tTUFAvbGludXgvaXNzdWVzLzcNCj4+IFNpZ25lZC1vZmYtYnk6IENocmlz
dG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4gDQo+IFlheSEgR2xh
ZCB0byBzZWUgdGhpcyBoYXBwZW5pbmcuIFVuaXZlcnNhbCBfX211c3RfY2hlY2sgZm9yIHNldF9t
ZW1vcnlfKigpDQo+IHN0YXJ0cyB0byBhcHBlYXIgb24gdGhlIGhvcml6b24uIDspDQo+IA0KPiBS
ZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IA0KDQpUaGFu
a3MNCg0KSSBhbHNvIHNlbnQgMyBwYXRjaGVzIHRvIHBvd2VycGMsIEkgZm9yZ290IHRvIGNvcHkg
eW91IGJ1dCBJIHB1dCB0aGUgDQpsaW5rcyBpbiBodHRwczovL2dpdGh1Yi5jb20vS1NQUC9saW51
eC9pc3N1ZXMvNw0KDQpDaHJpc3RvcGhlDQo=

