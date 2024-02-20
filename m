Return-Path: <linux-kernel+bounces-72417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D9EC85B2FE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 07:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E12FE1F22326
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409E51EB38;
	Tue, 20 Feb 2024 06:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="MOjZEVxM"
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2120.outbound.protection.outlook.com [40.107.12.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D012E43AD9
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 06:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708411175; cv=fail; b=RokuVd7jf9on9FVkHffBLr+pUct284Q9NrU9y6J83kcnyadblwZ5UvA1/X7xpv2ySDtU6XFtBZcb8yQWv2dYu/A+oTrUmJ5pVW4h7yjLP06jOtsJDwRFcs58QJq94wVk/H2hWZav1tI039/7qCKIvIoGvrQmxsRFkPTAW/c3WC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708411175; c=relaxed/simple;
	bh=R2nM8YqQTUwDz5bAB2sJ7xFHqoayx/n0l0EAcd2yvg4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NAaoyU3iLnJuLvTGva/r2xuZiEmbCDwL8vliCbRyL3XglvfGQoD2NL7bIyKpFOwmsvYegZdm6oR3NwRGs6sRJaQqWMOn2ORRkHpI0gxEMlKZo+4B4FG+DVDa+v/B3iJ7cvXV4W+pWFW777I6gbnGKPIqZeNP2piCdOrBWlQE7ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=MOjZEVxM; arc=fail smtp.client-ip=40.107.12.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eXKdLTcaHydqNCJOYf+/DlgAVgA3fEMJR7QX8msWf+tRpyW1ld1TtbTlE6lH7kGX98Ogiyf7gb97uWmQPzpeUXVpzxzrP2PelKFsx+AKywNXYprlATnsTARQhKfprZrsERHK9vRlZj8zGsyvrDiZ0fVPwjq/YZ5k/4UCYiYxMexvBWNE/LIf/TKTzLZ7JGk2dfK/qJ9/POVs6xr7z0tNmOIoJlo0MXwLqobZf0aHv5l46sfaM4MfY/YXb4Cg8gKKzs0lWUWGOTXN8HywJx5pvfgewjF8hjlTaoKsYjRxTtQuG5Eaha5aeD3SsOQcQW5Zdq4x05iARKawUnLHqxUhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R2nM8YqQTUwDz5bAB2sJ7xFHqoayx/n0l0EAcd2yvg4=;
 b=fBqCBPtGcX+wXlQh/e0dJvfLy98rnTyCL4Mf5dGdTGnvtFHh7AWAUakFCZmyvYY1neO/cA91I9cvfhwUUYRuDAjQkPPeEUvZBrN+MROEhpQDlJuXSGRH/qRfx2onSLTEbS48nEgsRRv/lH31d5zCQxktu3c6Dr4TAg6LryqE7PW3LlaqGLMeggyuLpK3/d/QRKLglQjovXkACGpFAA6v2bgMOCS1WG7rgJ4ssymydAumAySIoLo6q5nEgmwcJNfyKgtZnegFQrhgauK21aGYIeh9fF2XaqdcTw+f1IHxreyRsFFSL1r4jTl5z7+WD7DXaVu9DFr4H+Zgz7eI7POvTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R2nM8YqQTUwDz5bAB2sJ7xFHqoayx/n0l0EAcd2yvg4=;
 b=MOjZEVxMSqREAw1nn+guViyMyYQ3v7CrqmvMq7xcH2SqDnLhnj0x/d+FftNHBNrO19gFhlOJg05Aat8t/jKw54HHC3oKjHpUiL+nZ0bDkc7z9LN4hm8Fhdcv+XlqO1Rx3g4rv2NWnXxWTQJ2J9Bku00Zq2TL2bVLc2YSInkdUCLaqYnWN40yFp/gEUHiwN37HoysjNkLW2G4uq3wlw+ehri/bkZOpL+Ha9HqJWXaQ6r214bWnjn5nGI37tAjOTQpYKbGPAXjhJ/4BKavgTjTk0u3YpM467kmzJIkatH9oVssoGZT+J/euilOEFOs8/5uQfB2QRfN6DOnAutQLXQO+A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1793.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:10::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 06:39:29 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 06:39:29 +0000
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
Subject: Re: [PATCH 00/13] kmsan: Enable on powerpc
Thread-Topic: [PATCH 00/13] kmsan: Enable on powerpc
Thread-Index: AQHaLlJJUsT14twO30yc2wWFVbaBWrETMnUA
Date: Tue, 20 Feb 2024 06:39:29 +0000
Message-ID: <7233932b-ef98-480b-9d47-702315fa9875@csgroup.eu>
References: <20231214055539.9420-1-nicholas@linux.ibm.com>
In-Reply-To: <20231214055539.9420-1-nicholas@linux.ibm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1793:EE_
x-ms-office365-filtering-correlation-id: 3db0ae37-f262-4404-5fe3-08dc31deb0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 H2WGzcvg2MAS9W3dIfP6iJmWKnv3O717ACrjAwWgP/CA+az5gvUgq9Q1djnV6pcBKnx2wtZK4yqSWrLpD9VtRjHVWBIZMCSVBoT8KAPMP5Jl96XqYeALKqEPq9ByIvwi8NOhq975scZr5DXKSXqk8wDc1uziHsuz8wBLlq+3SOJd7YlFxaz5uCWE1eY2a1SkSNth/j4IHY5JeGSzyhpncx5hq6xC008RP3UP+nq0X4jV23i1MXZdH3mUu76/4pkgAdQ4fr99b5PcQ2fsP+Cd1nh47cSLDWY4kHzfC5ZXK24a9a4DWBON5E+PcjNN8CHDNn4iB6YLdzz8NWtCtbnZrFHFm32zRtzu0vpv42bRT4s05Hir2HDDzz5snYNUR5xodEoITwApQtRwXFR83+lm9mHrlE5MmER4k+L7pJumSe0PspU9VzSYJCQF6Adkn4XZx4o4KYq8y86tfJFZvN8tRGvPVpZCW+iGpdImyVAcWNpko25sawN7Vtij9zI5n4dHhOwMZ2LzxKPd/8NZJrxW8dAQSeb1GXgqKaJqbwJ1zSu5F3V5ApxExx4oaQIUJ4MEZvARmHZHiilFY+oM7aPCRHENH4r+1PGQy4b73ykvZuQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aGh0ellzYVJIcEhVeUpHT0VTeDJndUFwYmtKREhFWWVjUEpDUTdTWCtReUhG?=
 =?utf-8?B?ZjlrajF1aTMzVEVBS1BsRW5tYUNWUUQ3RjYvYVdHSWFIRFBpbDdhY3NiNEtY?=
 =?utf-8?B?TXhrTlBER1VrZGR3RXRkSnlJZ2RhanJzRmd3eFhySThObkxML1NXdHE3bHN1?=
 =?utf-8?B?bmthMUhPWHppOE9LUlZGU3M3Z2lNL3lLQWE5L3hOOHZnOUtlZkdzc0tDcWFC?=
 =?utf-8?B?OWtmS3ZRVS9RYmtBRmhPaUlkQjRlVzhsYnk4aGhtRDJTYXhSdis5T0RLLzF3?=
 =?utf-8?B?dHduNzlyRVV5a2MyVTZLRmNEWk1JSGRGTjJrYjlVMXZBRHpTVm45UmtNUXF4?=
 =?utf-8?B?V1lOeVhUdGVCbm9mTWZpZHlKQmFDenZBc1lXc2UzbDQrRjMyOCtXaTVNN1ls?=
 =?utf-8?B?WEhyNm1rZXl4a1NYL2E4a1ZOSEtnVXlkUExJejNmRGNGK3dTR0FUOUlmSDBO?=
 =?utf-8?B?QUVWVXdDT2pSKzhQMnZNVDZXWFRkVjVzdDNTbEpSbXdSYlNWU3hESHE2cFZC?=
 =?utf-8?B?NWpDeFo1Y1BFUmt5aWc2clV2L21DNHpkNGtwcG55NytGWUwvZk9QL2I5Zmc5?=
 =?utf-8?B?NUNSQ3d2RmFBZmRlekMyK2lnLy9sUThnMkVxTEVqTHV5T09zKzdIbTVoVFgw?=
 =?utf-8?B?MWpNTlpoUFNxNE1jL0ZvMkVJTnNsQmxLbDExVDRaNjNMbW45cDNMc1lRWnVx?=
 =?utf-8?B?cHl6K2pnN3RYMlhyVXdUck5sUXRXNHJHelhRZGlycitZaUtibGVlQ2Z1UXk1?=
 =?utf-8?B?YStNTHloQzAyZmZiZXpnZUwxTmMzZHdyNWdGbmlwbU8zelN0VHhnS0J4blRi?=
 =?utf-8?B?RnQrS1ZSZFAvVkh1R24vY1ZGMGtsN3hKMnU0SFgrVXhKV1RqLzJhNnRyR2Ns?=
 =?utf-8?B?c0txRWJpTEV6SmVERnF4VFRxR3h6SDFyUXA1ZXppMFpGKytHaEFCaHpVaDlH?=
 =?utf-8?B?V0F4ZDdCQXVxUGRhellJYXVMS0FkcDlRWlVkbUoyaVpiSkptL3p5b09MVmZX?=
 =?utf-8?B?TW1FdmVySHBRc0QzUHBpcS9vcURNMkV3V2d2WWtoUWNtdm5Bd2txZzlhQ05v?=
 =?utf-8?B?d3Npcnl4eElXd2g0T3RTSVVMenFxYUJNRkhLbFp4Y0RhSms0bFBDM2dLL2lr?=
 =?utf-8?B?czlxYVk3c1JRcmNBcktMZ0ZHWHIyR0J3eGdyMjBwWE9BcWo4akpVVWxnRmZk?=
 =?utf-8?B?Q2NZZWhWK1VWL2Mzclc5R25yMGllRStINGJMdDIxRTF1aktjT24yNjFRYkJW?=
 =?utf-8?B?NzVydXhBaWc4dURoNnREd2EzOFNta0xkTHVVb0FZTmtIV3RUMHZ4V1dRUFZu?=
 =?utf-8?B?Mkk4U0g3K0RyTnVUaTJvaWpWd3lyYms5SjhEVG5PNGtmQjJnalhRenBpMTJv?=
 =?utf-8?B?V0lPb2FJbUJ2Um8zSk4zNzhrUDJLcHJBMSttYWF5c0hVbE1ST2RBMUMxL0JR?=
 =?utf-8?B?c2J0MTdsOG9FUFNnSkk4REpVMlRSUGxXOEx2d3JQc0lTRm4yaGtqL1ZSRGN1?=
 =?utf-8?B?YTMwOWNRVlBwc3l2TmdWRDh3eTlBS1FBUGFpNjZESzB2MUlUUkxoSnJicXpH?=
 =?utf-8?B?clpLSXB3RU5yYncycElhaloxVTJMV2lGbDc4V1JrQ3dwbjZVVUlVTEV4SVNF?=
 =?utf-8?B?NzNhb1YwL2dnV3RzcjdEb2NhL1kxaFhLUFJGWTZNSjVkL0VDRHRVSng1SlY1?=
 =?utf-8?B?Syt6SEhyekYxc1E2dUVQN24zZGVZM3NaMmcxQ2U0MTNJd2xFdzFRWnMxMjdp?=
 =?utf-8?B?OWRNamRMdWVlRTd5NnpYUzNKOUpwOExlM2Nha3EvZXBnR2czNFhwZzh4cFZw?=
 =?utf-8?B?UUozWlN5WVUwMWFPUTI5WWk4OUZpUTAvVGJoZUtiQjBVbXhKZ21CbFg1VkRu?=
 =?utf-8?B?eW5pWlo0SkFqRGFOazJBUGtxKzZvZHgwOHh6MlRXTGxBT1lDWlZ3UEt4ZmE4?=
 =?utf-8?B?cTFVOVZ1aFBOY2tWOVlCR0hTUkNLbENvdUhwaEZLYjN5c0dxODlrYkVTTmZ3?=
 =?utf-8?B?NEVQKzlOejNOOHZHN3hocTVURmlpaXM1UFNPaXJFaS8xc0t4K09kOWxWcUZS?=
 =?utf-8?B?M2RGUXNxeTlxaTRCNk1tdTQyWW1WQlR1Wm15dzRobTB5UTVtbzQ2RTlzSVlF?=
 =?utf-8?Q?fGCsF/6KG9VNj1wU3rp967ohs?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA422DBD7C262C4F8EAEFE9E04243EF8@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3db0ae37-f262-4404-5fe3-08dc31deb0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 06:39:29.5899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Oe+DWXsFsnQf3jvCWjpo3PDrojRajT6JWCKzHEjd6LAZ/W2fGupOWG26fPYsX0ZnuiuafAa1Yj26iDlvlHYd/NC1os9Arf58Cg/1hmRa/jY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1793

DQoNCkxlIDE0LzEyLzIwMjMgw6AgMDY6NTUsIE5pY2hvbGFzIE1pZWhsYnJhZHQgYSDDqWNyaXTC
oDoNCj4gVGhpcyBzZXJpZXMgcHJvdmlkZXMgdGhlIG1pbmltYWwgc3VwcG9ydCBmb3IgS2VybmFs
IE1lbW9yeSBTYW5pdGl6ZXIgb24NCj4gcG93ZXJwYyBwc2VyaWVzIGxlIGd1ZXN0cy4gS2VybmFs
IE1lbW9yeSBTYW5pdGl6ZXIgaXMgYSB0b29sIHdoaWNoIGRldGVjdHMNCj4gdXNlcyBvZiB1bmlu
aXRpYWxpemVkIG1lbW9yeS4gQ3VycmVudGx5IEtNU0FOIGlzIGNsYW5nIG9ubHkuDQo+IA0KPiBU
aGUgY2xhbmcgc3VwcG9ydCBmb3IgcG93ZXJwYyBoYXMgbm90IHlldCBiZWVuIG1lcmdlZCwgdGhl
IHB1bGwgcmVxdWVzdCBjYW4NCj4gYmUgZm91bmQgaGVyZSBbMV0uDQoNCkFzIGNsYW5nIGRvZXNu
J3Qgc3VwcG9ydCBpdCB5ZXQsIGl0IGlzIHByb2JhYmx5IHByZW1hdHVyYXRlIHRvIG1lcmdlIA0K
dGhhdCBpbiB0aGUga2VybmVsLg0KDQpJIGhhdmUgb3BlbiBodHRwczovL2dpdGh1Yi5jb20vbGlu
dXhwcGMvaXNzdWVzL2lzc3Vlcy80NzUgdG8gZm9sbG93IHRocm91Z2gNCg0KSW4gdGhlIG1lYW50
aW1lIEkgZmxhZyB0aGlzIHNlcmllcyBhcyAiY2hhbmdlIHJlcXVlc3RlZCIgZm9yIGEgcmV2aXNp
dCANCml0IHdoZW4gdGltZSBjb21lcw0KDQpDaHJpc3RvcGhlDQoNCj4gDQo+IEluIGFkZGl0aW9u
IHRvIHRoaXMgc2VyaWVzLCB0aGVyZSBhcmUgYSBudW1iZXIgb2YgY2hhbmdlcyByZXF1aXJlZCBp
bg0KPiBnZW5lcmljIGttc2FuIGNvZGUuIFRoZXNlIGNoYW5nZXMgYXJlIGFscmVhZHkgb24gbWFp
bGluZyBsaXN0cyBhcyBwYXJ0IG9mDQo+IHRoZSBzZXJpZXMgaW1wbGVtZW50aW5nIEtNU0FOIGZv
ciBzMzkwIFsyXS4gVGhpcyBzZXJpZXMgaXMgaW50ZW5kZWQgdG8gYmUNCj4gcmViYXNlZCBvbiB0
b3Agb2YgdGhlIHMzOTAgc2VyaWVzLg0KPiANCj4gSW4gYWRkaXRpb24sIEkgZm91bmQgYSBidWcg
aW4gdGhlIHJ0YyBkcml2ZXIgdXNlZCBvbiBwb3dlcnBjLiBJIGhhdmUgc2VudA0KPiBhIGZpeCB0
byB0aGlzIGluIGEgc2VwZXJhdGUgc2VyaWVzIFszXS4NCj4gDQo+IFdpdGggdGhpcyBzZXJpZXMg
YW5kIHRoZSB0d28gc2VyaWVzIG1lbnRpb25lZCBhYm92ZSwgSSBjYW4gc3VjY2Vzc2Z1bGx5DQo+
IGJvb3QgcHNlcmllcyBsZSBkZWZjb25maWcgd2l0aG91dCBLTVNBTiB3YXJuaW5ncy4gSSBoYXZl
IG5vdCB0ZXN0ZWQgb3RoZXINCj4gcG93ZXJwYyBwbGF0Zm9ybXMuDQo+IA0KPiBbMV0gaHR0cHM6
Ly9naXRodWIuY29tL2xsdm0vbGx2bS1wcm9qZWN0L3B1bGwvNzM2MTENCj4gWzJdIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIwMjMxMTIxMjIwMTU1LjEyMTcwOTAtMS1paWlAbGlu
dXguaWJtLmNvbS8NCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXJ0Yy8yMDIz
MTEyOTA3MzY0Ny4yNjI0NDk3LTEtbmljaG9sYXNAbGludXguaWJtLmNvbS8NCj4gDQo+IE5pY2hv
bGFzIE1pZWhsYnJhZHQgKDEzKToNCj4gICAga21zYW46IEV4cG9ydCBrbXNhbl9oYW5kbGVfZG1h
DQo+ICAgIGh2YzogRml4IHVzZSBvZiB1bmluaXRpYWxpemVkIGFycmF5IGluIHVkYmdfaHZjX3B1
dGMNCj4gICAgcG93ZXJwYzogRGlzYWJsZSBLTVNBTiBzYW50aXRpemF0aW9uIGZvciBwcm9tX2lu
aXQsIHZkc28gYW5kIHB1cmdhdG9yeQ0KPiAgICBwb3dlcnBjOiBEaXNhYmxlIENPTkZJR19EQ0FD
SEVfV09SRF9BQ0NFU1Mgd2hlbiBLTVNBTiBpcyBlbmFibGVkDQo+ICAgIHBvd2VycGM6IFVucG9p
c29uIGJ1ZmZlcnMgcG9wdWxhdGVkIGJ5IGhjYWxscw0KPiAgICBwb3dlcnBjL3BzZXJpZXMvbnZy
YW06IFVucG9pc29uIGJ1ZmZlciBwb3B1bGF0ZWQgYnkgcnRhc19jYWxsDQo+ICAgIHBvd2VycGMv
a3Byb2JlczogVW5wb2lzb24gaW5zdHJ1Y3Rpb24gaW4ga3Byb2JlIHN0cnVjdA0KPiAgICBwb3dl
cnBjOiBVbnBvaXNvbiBwdF9yZWdzDQo+ICAgIHBvd2VycGM6IERpc2FibGUgS01TQU4gY2hlY2tz
IG9uIGZ1bmN0aW9ucyB3aGljaCB3YWxrIHRoZSBzdGFjaw0KPiAgICBwb3dlcnBjOiBEZWZpbmUg
S01TQU4gbWV0YWRhdGEgYWRkcmVzcyByYW5nZXMgZm9yIHZtYWxsb2MgYW5kIGlvcmVtYXANCj4g
ICAgcG93ZXJwYzogSW1wbGVtZW50IGFyY2hpdGVjdHVyZSBzcGVjaWZpYyBLTVNBTiBpbnRlcmZh
Y2UNCj4gICAgcG93ZXJwYy9zdHJpbmc6IEFkZCBLTVNBTiBzdXBwb3J0DQo+ICAgIHBvd2VycGM6
IEVuYWJsZSBLTVNBTiBvbiBwb3dlcnBjDQo+IA0KPiAgIGFyY2gvcG93ZXJwYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICAgICAgICB8ICAzICstDQo+ICAgYXJjaC9wb3dlcnBjL2luY2x1ZGUv
YXNtL2Jvb2szcy82NC9wZ3RhYmxlLmggIHwgNDIgKysrKysrKysrKysrKysrDQo+ICAgYXJjaC9w
b3dlcnBjL2luY2x1ZGUvYXNtL2ludGVycnVwdC5oICAgICAgICAgIHwgIDIgKw0KPiAgIGFyY2gv
cG93ZXJwYy9pbmNsdWRlL2FzbS9rbXNhbi5oICAgICAgICAgICAgICB8IDUxICsrKysrKysrKysr
KysrKysrKysNCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vc3RyaW5nLmggICAgICAgICAg
ICAgfCAxOCArKysrKystDQo+ICAgYXJjaC9wb3dlcnBjL2tlcm5lbC9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgIHwgIDIgKw0KPiAgIGFyY2gvcG93ZXJwYy9rZXJuZWwvaXJxXzY0LmMgICAgICAg
ICAgICAgICAgICB8ICAyICsNCj4gICBhcmNoL3Bvd2VycGMva2VybmVsL2twcm9iZXMuYyAgICAg
ICAgICAgICAgICAgfCAgMiArDQo+ICAgYXJjaC9wb3dlcnBjL2tlcm5lbC9tb2R1bGUuYyAgICAg
ICAgICAgICAgICAgIHwgIDIgKy0NCj4gICBhcmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYyAg
ICAgICAgICAgICAgICAgfCAgNiArLS0NCj4gICBhcmNoL3Bvd2VycGMva2VybmVsL3N0YWNrdHJh
Y2UuYyAgICAgICAgICAgICAgfCAxMCArKy0tDQo+ICAgYXJjaC9wb3dlcnBjL2tlcm5lbC92ZHNv
L01ha2VmaWxlICAgICAgICAgICAgIHwgIDEgKw0KPiAgIGFyY2gvcG93ZXJwYy9saWIvTWFrZWZp
bGUgICAgICAgICAgICAgICAgICAgICB8ICAyICsNCj4gICBhcmNoL3Bvd2VycGMvbGliL21lbV82
NC5TICAgICAgICAgICAgICAgICAgICAgfCAgNSArLQ0KPiAgIGFyY2gvcG93ZXJwYy9saWIvbWVt
Y3B5XzY0LlMgICAgICAgICAgICAgICAgICB8ICAyICsNCj4gICBhcmNoL3Bvd2VycGMvcGVyZi9j
YWxsY2hhaW4uYyAgICAgICAgICAgICAgICAgfCAgMiArLQ0KPiAgIGFyY2gvcG93ZXJwYy9wbGF0
Zm9ybXMvcHNlcmllcy9odmNvbnNvbGUuYyAgICB8ICAyICsNCj4gICBhcmNoL3Bvd2VycGMvcGxh
dGZvcm1zL3BzZXJpZXMvbnZyYW0uYyAgICAgICAgfCAgNCArKw0KPiAgIGFyY2gvcG93ZXJwYy9w
dXJnYXRvcnkvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAxICsNCj4gICBhcmNoL3Bvd2VycGMv
c3lzZGV2L3hpdmUvc3BhcHIuYyAgICAgICAgICAgICAgfCAgMyArKw0KPiAgIGRyaXZlcnMvdHR5
L2h2Yy9odmNfdmlvLmMgICAgICAgICAgICAgICAgICAgICB8ICAyICstDQo+ICAgbW0va21zYW4v
aG9va3MuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKw0KPiAgIC4uLi9zZWxm
dGVzdHMvcG93ZXJwYy9jb3B5bG9vcHMvYXNtL2ttc2FuLmggICB8ICAwDQo+ICAgLi4uL3Bvd2Vy
cGMvY29weWxvb3BzL2xpbnV4L2V4cG9ydC5oICAgICAgICAgIHwgIDEgKw0KPiAgIDI0IGZpbGVz
IGNoYW5nZWQsIDE1MiBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkNCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL2ttc2FuLmgNCj4gICBjcmVhdGUg
bW9kZSAxMDA2NDQgdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvcG93ZXJwYy9jb3B5bG9vcHMvYXNt
L2ttc2FuLmgNCj4gDQo=

