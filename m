Return-Path: <linux-kernel+bounces-136263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF389D212
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDE051C21E18
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 05:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFDBD6A012;
	Tue,  9 Apr 2024 05:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="UBcaLkPw"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020003.outbound.protection.outlook.com [52.101.167.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBBC54FAF;
	Tue,  9 Apr 2024 05:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712642007; cv=fail; b=fqpldOAIY5/kNciMDMN8ectiuvxeRNGHsgNB/PmacpXpvLBs1LTpGO/AgaocH/B3ZIyShbeF5Be5tE2XZ1poarcr/p/K/M2vPv4k+fA0q49VSPDHcB+uPxAshKGXJ0PfNmUfXUW58dzcDYGN3O/9Zihee0G+u931z4KeBoVoHtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712642007; c=relaxed/simple;
	bh=bRfdUbRMQstEbaiuHIgFxeEy6G0OxmN//G/sMVm0iA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I8C1LzdSa84Ni7VweBkIauOKwlmZ1WVpv7v/hICyVaU5lHi/fnw6pTDVIMrCrZwqxVgvOAZH/fej8UGWxIOshqZuwPxV9bucnpRFw1ItUI1Sl4aOip/GrSuy6oTbNFameC36f/anFUwJMKFrd9Yt5ZKKUv1so+J1sVdHuNXpQQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=UBcaLkPw; arc=fail smtp.client-ip=52.101.167.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YRhURCcCvPrL0bJ33z85+rPcaQvXkHBzXjP0XRwdAtnQtlZJo9DRiqJPB0LojVFoCNABYo9gyTmnqwr6KncOnkBvBfuWypJ66sELX1x7ar8J/4gOQj7hH95BDMJRUuujlCpw/Yao3h8RCNGNQA/K/s1eP69kHaHdzc3f7fy/7YX48LjInC0g2b2R/2GF1zhtkXh1srHUzU5ivPx47KTJ93uya98f5F2rLSi9ZVOXse7DIWEC0Dx37rh1Yj33LG6GCHjK2rk4B89I/5+L99Ev/rWOYESS311DwX/YPrfpddPVkOwOWj4p8Rg5gcdBJeZYK8tBgxFwyhMITCvzFGxbTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bRfdUbRMQstEbaiuHIgFxeEy6G0OxmN//G/sMVm0iA0=;
 b=Wo5SXf01VIrFfH3nwyT/Zx8EtdzgFVSN23WBiglxIrKqbpfy0n2RZyIyU9yzSU7usfQ0xRG63cpeyp7n4YhRSEhsdIo02NPB1bGdRCmVsf8nu/nBTwDD4MY9tDtI5witOOumCs47pxLhbVL7kKT+YsT3Ir/AXLEXWDCXrvqY1oiiWAYVrxvf75ZAF7Pe3CvfFcpTSIdwcpk49fgB0II3tEQAxRdO6vMG8Tgp4mxuNxHWS9UpNaCRElyDa+JuAURHKS4iEmx1jjcmwUE7RsTQvQJry4HirIvubKjAVrjAOjJzyz79ozph7lz4lERHIjnRQR/v3Dhz5i/4OVjT8Z9r4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bRfdUbRMQstEbaiuHIgFxeEy6G0OxmN//G/sMVm0iA0=;
 b=UBcaLkPwTQsK+qfevDOG/a74B0Gqot4ZY1DVTx6TiND2lFByO15by/cTmDf7Rh6ONpukxBUe6zkHvL+HPoMUalhzF7LkVqjR29YS3mxDCQaCswnK+B7AmXkWxunb6Qmh8h9syQh/v/1l0ZfNNoDQJfTCjg25IlBE29kpOMRw9mg0kW8wH8g3cfaZ5x47arJEHvVrpA66VZ0Kt5kTmxYrr065AdRoxLHPUYFkhEJOHHgb6Q3l4Yw0EWBScsi6N1sB/l9cCTYnmgvSaWeDqA2gmqtMgPOAGaygbzTVIr4TYshpYTvRSulmqlSLzOzicUJ/2Cew++0v5+KJ+HArTYqE4g==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2628.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 05:53:21 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7409.053; Tue, 9 Apr 2024
 05:53:21 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Michael Ellerman <michaele@au1.ibm.com>, Andrew Donnellan
	<ajd@linux.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-scsi@vger.kernel.org"
	<linux-scsi@vger.kernel.org>
CC: "fbarrat@linux.ibm.com" <fbarrat@linux.ibm.com>, "ukrishn@linux.ibm.com"
	<ukrishn@linux.ibm.com>, "manoj@linux.ibm.com" <manoj@linux.ibm.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
Thread-Topic: [PATCH 2/2] MAINTAINERS: Make cxl obsolete
Thread-Index: AQHaiixpjWHcPtQ8tk2i6z/hvOuqJrFfWvmAgAAVIQA=
Date: Tue, 9 Apr 2024 05:53:21 +0000
Message-ID: <0dd09e90-440d-46f0-827e-cbef93ce72c6@csgroup.eu>
References: <20240409031027.41587-1-ajd@linux.ibm.com>
 <20240409031027.41587-2-ajd@linux.ibm.com> <87bk6jb17s.fsf@mail.lhotse>
In-Reply-To: <87bk6jb17s.fsf@mail.lhotse>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2628:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 v9zqD0kLm2vrNltjwybJp4bkFIkWQ58CcG8/WDrr3Fhx+d54LvLhrsQWH2KqRrIhgdMmTejis9yjX8w+6lfG8OZVWf7fnImiFHLYetYxjAqf7zRrjforu6f2b14jVO+L0fErvlRw5q02QLoX63tsL5RaYx8dTagoWkpGyLPVUEHjh3+p4p2BQQ1H0rBG6uY7qvqfUdeg0lMEu6jA1AFXXk5zDuDuyu0exESliH/UoAa2QkKDHbGGAvRheNJKslMHe0DE5KCepD1g1/D6kKVQ37xODJyvQtyZwJjSN+I+SrENbb2H2s9a+owI+d3W6rRmucBlf468kQa3in0ePrNb35unOBAoniPi1hvgsK3dymieYTiGggL/X5fJbComMoT3SnbSyZ6/4OdmxY9eaqAcH1PTQIDCueeCWg4UcxcnZcLivRtF21k9IpAx2ldUvcuz1TPdEbc+tTXnJC4FJhsrj0YaN1qJgISzjTtwHgzNyEJ2hYAa1eQTid/6aq/LUlbuitljrbWK+sbD8hOr44clIHqALEWir37/gOGlXgUw5kkycnbpvzs5kz3J/SupPLjLesFaekwVXIwNrwsDa6grACKPFFcK7h9UI5ugqopBN3AU3yuM9Hg5WZ60KhK8KKkIeSK/1yiNHk0wsLh1OyEUtNoeLJKjdKHCXPPy+22tYjE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eG5PdTQzWCs2NzVOVWtNWDAraDZ2eVN0aDAxdzNPeTkxN2l4bWhYUE9rYjlY?=
 =?utf-8?B?MThtdHZZRWtudFFibjFYOWJYR1VQQStkbUlqK0I1VTdVL0NzOVZ3Rk9mYnNw?=
 =?utf-8?B?cFc0RVNUOTJUYXoxaTk0bTlmYy9Tb25tckhOZ3JLdG81ZXFkSFAwdllETjhI?=
 =?utf-8?B?UEcwVUliWHREWURmSjJ2eTlYSW50aHFkRzJaMGVsK3lWZUkwak1Mak43d2lr?=
 =?utf-8?B?NFNtUTlHMHFGTDNvUlYxa3NCVGtEbTM3VG43U0FMTWF2eis4bjBHVkVraUcv?=
 =?utf-8?B?eE85aEFCeDRpVktZcllWV0hTUk9JTlRPL2FCSE1aNUVSZDYyc3pLYkNDd3lD?=
 =?utf-8?B?aEZ2VkZObnJhcCs3dXZIKzg1V3huVFBYQUlSMllJTjZOTVRXazhzVTB6STFU?=
 =?utf-8?B?b0xVaE5LVDlnZjBCQk9LZ2FKdmZVS0x5YVcxMW5XL0IyTnVzTU1MeGVxYklv?=
 =?utf-8?B?MDFwNEk5TmdPNENnbW5wWkduWi9tdTZ3WHE1NysyYkp1OFdaaEJVTzRPcktC?=
 =?utf-8?B?d0lBbDNUM3ZqaHlxVTA5TWRDZzJZdStldCs4RW9kRDlpazl1SktvYTBTRjE2?=
 =?utf-8?B?aFlsMEhrOWszd0tBUUFOcW1HVUpTRzF2d1FxUElWZGVKVmZpYTRjQStwVUFE?=
 =?utf-8?B?TFpzaEFYN1krakxpUWV4Mm94VU1ORFFqWWZzOTRmMVBQckFKOThydXd6Sk9w?=
 =?utf-8?B?UGx1Wm5oR1NtcTZJSFV4MGtGdXRWTXB0WS9Ec0VkSGdEUE1sdUMxenBJaEpx?=
 =?utf-8?B?RHk5Q054MHpkRFV1VjBJM29SRDVRUHJtMUQ3aVhNZkZrWFhiWisxTVhkemNC?=
 =?utf-8?B?ZFV1WUZmNnhKUUJCbXduNUR3WEJzaksyRk11blI1ZEJJOFVnN0U5N1IzSU5D?=
 =?utf-8?B?MkxHYWVPb1ZQbzVtd2NTSE5kSkJEVXpkVUVSdFJGckIxRkhLOHhyZnYxaE1R?=
 =?utf-8?B?UlVsVDRrd3p1eWxmOFBka1l5RE93M2dCSnhhWnlZUFZmaHltMHVqOHRnNmw4?=
 =?utf-8?B?bmM0SnZQeVMvN0lxQkZZdVF0YlFyZlVBeC9HUExWL2g2bEVudWlFNEZ3OTY3?=
 =?utf-8?B?TkVuTzFRc1dIUkFRVHFobkRCTkQvUWRpWmkvVURLNUkwZzdibGlPcTZlZ3Rh?=
 =?utf-8?B?RjByenNqbzdCNmJaSVhFb1l2SytUNzBCVThPY2FmUnVLSy8ycmRnekhEN3l6?=
 =?utf-8?B?dkxxMjIyblhMdG5ZS29QYmxqWFZ0ZVBCNCt0U3R5ZVI4U3hMNzlFWVNTSTZZ?=
 =?utf-8?B?RExrU1FpbGZvd1p1QWp3akhHM1BSRUtDSXcxdXFFbDkxRzYxd1VpVDhCaFJt?=
 =?utf-8?B?WDhBSFhmZDE4MSsrOXRpVnhtcjltTFl0MWpaWkJmK1FBeitJSU9McG5hODVn?=
 =?utf-8?B?NE5OUW9zTS9NTHZIZVJHbzg2RGVqTVRvT1dHSFRwWElzTzFOVFZxVk4xLzIr?=
 =?utf-8?B?TmovTjNBYWFpUERpM2hnSHJUUW1wTGszZ0kxK1J1WDcvNGl3S2twaTlvMUJW?=
 =?utf-8?B?NTdjU3BBNEx1TUxDQ1RhSHA4dFdhU0JuU0cwZEh1YXlydm9aMzloY2tONndI?=
 =?utf-8?B?ZzhDdzBYSlJsMHQzYVp0cU5SMWp0V2R1K25CZDdCV1ZhcDR1WmlFeERyK3NN?=
 =?utf-8?B?TXlGOVBPUDRncGExSUNvUzlEZU9BWDJ5L3VqNlFtdXVHUlpyeEIwVTNXRWd4?=
 =?utf-8?B?QURKZ3ZlN3U2bHF5ckJ4eWdib0tlVkJwQ3dTcnZlVStIeENOVkMya2U3c3Mz?=
 =?utf-8?B?YVNUV1hybkJUQUZpa1hyVG9LV3N4V2cwTUJDcXE0THVWVGJsMDI2a2ZjcnQw?=
 =?utf-8?B?b2M5eHpNdlpGMkJqVEZ5OEtUaHhOdjcrRTdIcXM3NmtlRVNLMjAyQi9GdCtv?=
 =?utf-8?B?S2lYd3p4WWM4d2NuT3Z1M0RLd1pIenE3OC9ESzJkL2h3WHFWdFhWUXNKd3Rm?=
 =?utf-8?B?UzdTTWNrb25RY0kwbFVXWTc5bWtyZ0FpdmpGMm9JQVlickl6Y2p0NTFGRTZ4?=
 =?utf-8?B?d2dDQitUWFI5cGdaKy9TV0M1UjJNQzA3RkNnYnNiT1hIanhPc01KUUJMVHdi?=
 =?utf-8?B?cEhtTXJjRjljOG8wUFliQ05pRVl2UzM2UW05d21PSUxVSEdSY2c3UUt4eHhC?=
 =?utf-8?Q?H5SDK2O5IWWMWGGkA6rQoboL4?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EF11712D706DCB4BB927A53D4D84FE88@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8af0c15c-3f67-4307-bbfa-08dc58595cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2024 05:53:21.2416
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KQQI+oQsqugX58Z0LVIaP4OrRrI7X03Ezbw7krOXIuRm0OZsAPwzrIa3Kd4e9u5gIdWbCn7xmx7Chep7iDlB6EQgNbHy/JRCgWFhNJzy9FQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2628

DQoNCkxlIDA5LzA0LzIwMjQgw6AgMDY6MzcsIE1pY2hhZWwgRWxsZXJtYW4gYSDDqWNyaXTCoDoN
Cj4gQW5kcmV3IERvbm5lbGxhbiA8YWpkQGxpbnV4LmlibS5jb20+IHdyaXRlczoNCj4+IFRoZSBj
eGwgZHJpdmVyIGlzIG5vIGxvbmdlciBhY3RpdmVseSBtYWludGFpbmVkIGFuZCB3ZSBpbnRlbmQg
dG8gcmVtb3ZlIGl0DQo+PiBpbiBhIGZ1dHVyZSBrZXJuZWwgcmVsZWFzZS4gQ2hhbmdlIGl0cyBz
dGF0dXMgdG8gb2Jzb2xldGUsIGFuZCB1cGRhdGUgdGhlDQo+PiBzeXNmcyBBQkkgZG9jdW1lbnRh
dGlvbiBhY2NvcmRpbmdseS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBBbmRyZXcgRG9ubmVsbGFu
IDxhamRAbGludXguaWJtLmNvbT4NCj4+IC0tLQ0KPj4gICBEb2N1bWVudGF0aW9uL0FCSS97dGVz
dGluZyA9PiBvYnNvbGV0ZX0vc3lzZnMtY2xhc3MtY3hsIHwgMyArKysNCj4+ICAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IDQgKystLQ0K
Pj4gICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4+
ICAgcmVuYW1lIERvY3VtZW50YXRpb24vQUJJL3t0ZXN0aW5nID0+IG9ic29sZXRlfS9zeXNmcy1j
bGFzcy1jeGwgKDk5JSkNCj4gDQo+IFRoaXMgaXMgYSBnb29kIHN0YXJ0LCBidXQgSSBzdXNwZWN0
IGlmIHRoZXJlIGFyZSBhbnkgYWN0dWFsIHVzZXJzIHRoZXkNCj4gYXJlIG5vdCBnb2luZyB0byBi
ZSBtb25pdG9yaW5nIHRoZSBzdGF0dXMgb2YgY3hsIGluIHRoZSBNQUlOVEFJTkVSUyBmaWxlIDop
DQo+IA0KPiBJIHRoaW5rIHdlIHNob3VsZCBwcm9iYWJseSBtb2RpZnkgS2NvbmZpZyBzbyB0aGF0
IGFueW9uZSB3aG8ncyB1c2luZyBjeGwNCj4gb24gcHVycG9zZSBoYXMgc29tZSBjaGFuY2UgdG8g
bm90aWNlIGJlZm9yZSB3ZSByZW1vdmUgaXQuDQo+IA0KPiBTb21ldGhpbmcgbGlrZSB0aGUgcGF0
Y2ggYmVsb3cuIEFueW9uZSB3aG8gaGFzIGFuIGV4aXN0aW5nIGNvbmZpZyBhbmQNCj4gcnVucyBv
bGRjb25maWcgd2lsbCBnZXQgYSBwcm9tcHQsIGVnOg0KPiANCj4gICAgRGVwcmVjYXRlZCBzdXBw
b3J0IGZvciBJQk0gQ29oZXJlbnQgQWNjZWxlcmF0b3JzIChDWEwpIChERVBSRUNBVEVEX0NYTCkg
W04vbS95Lz9dIChORVcpDQo+IA0KPiBGb2xrcyB3aG8ganVzdCB1c2UgZGVmY29uZmlnIGV0Yy4g
d29uJ3Qgbm90aWNlIGFueSBjaGFuZ2Ugd2hpY2ggaXMgYQ0KPiBwaXR5LiBXZSBjb3VsZCBhbHNv
IGNoYW5nZSB0aGUgZGVmYXVsdCB0byBuLCBidXQgdGhhdCByaXNrcyBicmVha2luZw0KPiBzb21l
b25lJ3MgbWFjaGluZS4gTWF5YmUgd2UgZG8gdGhhdCBpbiBhIGFub3RoZXIgcmVsZWFzZXMgdGlt
ZS4NCg0KV2hlbiBJIGJvb3Qgb25lIG9mIG15IGJvYXJkcyBJIHNlZToNCg0KWyAgICAwLjY0MTA5
MF0gbWNyMzAwMC1od21vbiAxMDAwMDgwMC5od21vbjogaHdtb25fZGV2aWNlX3JlZ2lzdGVyKCkg
aXMgDQpkZXByZWNhdGVkLiBQbGVhc2UgY29udmVydCB0aGUgZHJpdmVyIHRvIHVzZSANCmh3bW9u
X2RldmljZV9yZWdpc3Rlcl93aXRoX2luZm8oKS4NCg0KQ291bGQgd2UgZG8gc29tZXRoaW5nIHNp
bWlsYXIsIHdyaXRlIGEgbWVzc2FnZSBhdCBib290dGltZSB3aGVuIHRoZSBDWEwgDQpkcml2ZXIg
Z2V0cyBwcm9iZWQgPw0KDQpDaHJpc3RvcGhlDQo=

