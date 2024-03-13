Return-Path: <linux-kernel+bounces-101255-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB74A87A49D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80AD428290B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33EF1BDC8;
	Wed, 13 Mar 2024 09:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="DoCi27fB"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021011.outbound.protection.outlook.com [52.101.167.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F1F20310
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320713; cv=fail; b=PuQ16Ait5gxURytG1TVguISL92CFTeHjADbJ1HLB02Y1UFuPB25s3OJ7WwxwU032dzMhmoKcltQsQ6En+eF+v6ffyk46LNyBNvrH+coB79hEIcr2BrdlesKoch+9mHUx/IoJ9S0xh5biFiVeDs0WFWU6ZgOqNm9IwDZ3ZsX3jCk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320713; c=relaxed/simple;
	bh=kR6xbr3Z8l4YZfBpKeTaItBe+medyIlM7cvyZcfFKY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8stz9hLCAxiLjh9A2FMzWOiuPP7jRYdoI/OfW2xfavZK0zAcMZz/az62TEuI4B3oJ7KQCud/ovPgusdDsH/VMvunKfN20KQVHadMAANggMZxi+9lHaTSWK5nMa8HBP91v/gRLn6kOBVHby5sQJGWufyBzyIcZwGGNPTyOMVAN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=DoCi27fB; arc=fail smtp.client-ip=52.101.167.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YApQjBRjlUugxkkdSqbrDKrGfW5S3DMO9Yg8EXsNRb+CuVjyoF104ngZbw4VvFkI0tF0EH2RZf4TXf7yz211HJlM8BMYPHwUYWCX3IDOfK4dhivuGDrv4p117nBlSVuZ6JULq5cs2mrNb/xFEY+oAxXu4U4kfu5IBk80oBshJmV05wR9RnWX2xDdibWTAAEat2K8FdZ5tqLxGWWJrcEB/CErh+6O/qqt2m/pd+gQW/smjQC987YKs5RGpf6kt7c2gXcqSGkQBptp5Ta+cyYZCM+fUOgZPC8Wvx+mkG9Qq91JrN6VJy1vETZf3Rmf6YJE31RVsBwE+vyCQEi6Xdc59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR6xbr3Z8l4YZfBpKeTaItBe+medyIlM7cvyZcfFKY0=;
 b=dtOls+L1LyHJkMrMFZ1k4l0U1EfRV9yfYvmRjwRM33ZA/U1+Jm50idY5tLAYEDGws0ReUMeTixqCQlNk/fTeTM8CW+uGtRY0QftxTCWOJ2aqfAFd9fejGjVzgf32se3Am2Befx19+D9eZIZNr9E3QNa1bwWjxPoJ5aZCHOa+fXQlBGCg/TEGQ5F2LdNZx8hKFjG8IlEMqiTPQ8SHLgNtDtI74iG28uT4aExhhJ1OBVr/VqRD76OuTWuU/lyAQqi9gcAWAkWnCIfOwFargCeQ65+NWXx437wgE7wtJfE7cbIB1wiK5Hz25aoauHf1OSIuEDfIfWW/T9ZVzuzR5EVVZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kR6xbr3Z8l4YZfBpKeTaItBe+medyIlM7cvyZcfFKY0=;
 b=DoCi27fB6FEaSuuKCNXaQOoHIM7ge81bZxMrjEoGMypTDI7Q1ic/QG/jRVwp+sE4y1gTyizQv2MPh/ZjvwmAy3T8IaI/bw7h6M9gNsS7ODi1Tcee8Bu+m0H7RIhdk+vgb2XxCWmS+w1BIu4PRprb9BzRwOuTbKSm5Otm/Se7LW24ELO59AhWc0gDEzYU+8uz5MvdF/3U/E6j3numE/S29rmeK37YFUaV+HpMG7RUkZv9xokxNeahpchy+9LP4BRn1Bzu2TjiWesSy2pRODXWOYCNuKfJjJlWKGiDj251sMXnnq4pEUBVOXoNcwGjy4lHy/jjq/XB9bC/PYZwga+1Fw==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1924.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:10::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Wed, 13 Mar
 2024 09:05:08 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:05:08 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Topic: [PATCH v3 03/12] mm: Use get_unmapped_area_vmflags()
Thread-Index: AQHadMy0Na1Epyvoi0WcqC5L5hFBL7E1YXsA
Date: Wed, 13 Mar 2024 09:05:08 +0000
Message-ID: <660fbd50-64e8-497e-89a2-05cfd4755bec@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-4-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-4-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB1924:EE_
x-ms-office365-filtering-correlation-id: 84256aad-0f28-456e-e556-08dc433cae6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ExypXj91jmBdEsmN4SonwFCOnIZyam7fF/85VLcOssygUAqSAolmm7o7nuSlM15drvEF55ZAuuIqjpMsZ0VFj/GEYUIBJGoeKZ7IQQ5BmLdwAyP0XbU0ZB/L7ftiPBFhHo5hQ+06p/cF80FqNsxw6HOgRfyI8pHumKRSGGVrSdhCHFnKhS/Q18OaaucadsHNigZ+AV9Pey6Q2Gumcp7Ty/C1TvJXVrVbLEatUMuE5i8I8elCfDzpPFzPdJnf1aZrTErPTMfLhk2/W4xtj4yh/7NX9vz69rrvtnH2rVgiawYT/LRoVPT+kKQh9+1XwnP7owNE4k5Mp3h4w6OrabAtjOOtxGeIFM39D4j0ck9PWYCjvoz+/hNetr/8+eqQVUYmFY1PnyObB44E2J+EDJ4/1ggaTnddIBdnYC06QYrMltW3c5Z5ovtjyx9exvXcg2cDOGo6X1N6fA7+IhQaTN17ZWljEWnn/3DMavdMnHpFvE4gzf1wHfA5zPlLjPBrJNr8bUM7KDztbYKdCk0CQDlFeYJ0CWCP+bdAPzDcysuUfKKRyMoczNExcfN6k0/wHIqsjorzuaM+QM5gFm2eDx6ConmTlsOnu2Zau4rsNktMRQCe7C62UYtYCvFnReq3P77bKixxlR2cyNqSOOdkbE0bnYKT4f25c3bWo7Tgv8ZBiulO/U9k54htcRbvgHpO2Zp/XesrvJNtNKOQkazDJiz3Cq/zWg+M/xsi+9e6Xrjgc2s=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MVRPdzg4WEhhSTV1dDM5ZlZ5WTVwL0phN1VldGhpSUNZV1J6KzdVakNTOVdv?=
 =?utf-8?B?dXJvNUFDNnY5YlJZZXR2dXN3elQxc1hEajBCRlhObjg3UTVDaHVRcFBCNWNW?=
 =?utf-8?B?TUdhbVhHWUZxRjlKVlZMMUEyUllHY1V0bzdiLzljamZuWXdEWjczYXhlVE4r?=
 =?utf-8?B?clZKZ1V0eXRXajdYNDlsQ0F6NDI3QUw4ZTY2RXB1c0w3bTEwSHVhcjhieG1C?=
 =?utf-8?B?aFY1dEFLbk9CMDBDbzU5T0RRUU9VWmU3T0k5bytCYTRQZmhwTFB1U0dIWXVp?=
 =?utf-8?B?R01vV3J3Skg2UHFlRS9oaVROUVlROUVzVFBMNFdoTUZNNThHSEpHdExMKzlR?=
 =?utf-8?B?ZE1DREY1c3pFWVVidHpoa1JJeXlUUmVtRDdBVm5SOVZTMmpVM1lJRmt1NDYz?=
 =?utf-8?B?ZExYaVg4dUgyclJ6bEJFZlp3ejIwZWlMZEhjUFJxeG5hSnAvSW1ITmNqRll1?=
 =?utf-8?B?aDZlRjdYMlBZZnBiUW1QM0JlKzV6aFFmYkh1Z1g2akVYRFdxSjF5RElUZmRj?=
 =?utf-8?B?VWsxa25JaVlWN290V09EZElnaENrbWhRSTRGeWxRc3R0RHZROFkrY3lyQk90?=
 =?utf-8?B?ZUhxNy9zV0ZzZC9sd1pKWnFwOGtsaERrRlBxUmVuOTYxM0owSmg5NHRnbXpK?=
 =?utf-8?B?c0FMVXpENkxHeEhPZi9CZlZUMWlTSStRQzh0eTRnMGVsSHJ6YXFlMWhHcUVQ?=
 =?utf-8?B?aHBIdGlBazMvZjlCM2lwVkg3SkowaHZQRUZ1cWI1eE9jSnZNTm1ITEVNeFJL?=
 =?utf-8?B?ZTd3eTZzbFF1b3pIdWIzQWpzbE9nOEswODkxZGV6ZnpBTnZ0RUwvS2JueFBv?=
 =?utf-8?B?Qyt4eE1CUHhLczNuOXNGZDF2QXlJbWNPMWRETVNxejdocFlnRUpLN3JMRVBU?=
 =?utf-8?B?ekhKMW9XTWxzck5Mc3IvS3k0YzFCV09nUlVXeUtGT05NRWJNWWRBK2dEcHF6?=
 =?utf-8?B?enNVTnpYalpIR0UyNjdVVVg3Si9CNnNoQk84bWhyYnIvU0JjVUpETHdVS0pO?=
 =?utf-8?B?Q3A3RzFsZ2ZyVlRnT0Zib2NDak5Ud0ZUZGt1MHRxU3RGanUzd1NQa1hUNTA0?=
 =?utf-8?B?aGJ0bE9CMHc4NERWMElYek9Fa2RpemZLQlVCTEpUVnF6bjB5Q0RIazMzZnVo?=
 =?utf-8?B?OHZTR1daZjlzanFaWHJBSG5XZTZjeG5DOGFsVzdFVmtyZnZRWVlpMlpmallY?=
 =?utf-8?B?THdwMGxnK0pLemhHMm9sV0tvcnZZdk1SdklLTEVGSnNoQVp6aWRndWx6SDlx?=
 =?utf-8?B?MktIUG9iSkR2OWhJb0RGNWdiYmFxcU9xMnFaTHBvdGh1U1BzN0pnUzJVaTBP?=
 =?utf-8?B?cXZjcjVvU01hbWw1c1pqTGk2SGp3REVaenJQNkUrN1BNVTNZNk5SSzh3eWIv?=
 =?utf-8?B?ZjRuemo1Sld1ZkFnWEJjZE41WDBjVU0rT3pQUU81amFITi9XdENlelhTR1Bx?=
 =?utf-8?B?OStIeisvWUQrYTdaSmpZR0lKYU1FQ2g5cHNzZy9aRVpIcDhOOU9MVU5wc0dS?=
 =?utf-8?B?cXdoei9BOW1MNEE4amRNc3owS2htOW9PbGJWajIxNUg3M0JnNFcrZmZwRTNz?=
 =?utf-8?B?ZVFKdmpHWWNMOTRraHJ1anZXZnNOblVabTRmclpDVGpPTXJncEhsMSsxRTFj?=
 =?utf-8?B?d29aTHBZQWdUL0d4aGlXY2M4U0dDTS9KWkNkbjNEcmZ6TjVQOHNHZHhlWXJo?=
 =?utf-8?B?eVRuRVZkZTZWSFkvY01vOEltZzBmUzJkZE1XU3JGSTB6RGFyc0tKbldIcGJp?=
 =?utf-8?B?R1cvd2FSck52OHNDeUxxTnNYYTVzY3U3TjlDRXdnQzJoVldWWXN6V213WndF?=
 =?utf-8?B?eTI2ZVMvMVpmdklXR002czVXY1NqdDkrYmxVT3JvYmRVZXYrY1NjQXR1L3pr?=
 =?utf-8?B?VENnY283K2o3aXdiNTVVdTFPbkFwdmRQQXBtRXkzOGxNY2J2N2lFMUtCWlhu?=
 =?utf-8?B?ZllpTjljUTVWSldKZ3k1K1ZvVm1HVzlxQjV2clVOMFVGVENkVzV0dnVxNmZN?=
 =?utf-8?B?QjlDWUl5czlraEdyS3NkbDZQV3VSMkVkdG1ielRvT2ErRG9HMko5ZVJLaHc0?=
 =?utf-8?B?UUZwWmYxM2dTMi83Nm9jb1JRVlYzM2pNN1lIbU40TzN5ZVcxZlQ2RlByeGRr?=
 =?utf-8?Q?D5PR7zDVBFUFljwHdRPw/v+mH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9C8C5139203E4D4BA4D4761DB21FC9A8@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 84256aad-0f28-456e-e556-08dc433cae6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:05:08.2860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rm+KCfnJ7384Bw79B/z0bJoMBy4a/AC3nqSvusZSNy1sRDco3AyPX20wlSWMgo6A2KugZjxPQ/gbjpOiFlI7f2DFcOFq68vVUb3VYCLMCJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1924

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IFdoZW4gbWVtb3J5IGlzIGJlaW5nIHBsYWNlZCwgbW1hcCgpIHdpbGwgdGFrZSBjYXJlIHRvIHJl
c3BlY3QgdGhlIGd1YXJkDQo+IGdhcHMgb2YgY2VydGFpbiB0eXBlcyBvZiBtZW1vcnkgKFZNX1NI
QURPV1NUQUNLLCBWTV9HUk9XU1VQIGFuZA0KPiBWTV9HUk9XU0RPV04pLiBJbiBvcmRlciB0byBl
bnN1cmUgZ3VhcmQgZ2FwcyBiZXR3ZWVuIG1hcHBpbmdzLCBtbWFwKCkNCj4gbmVlZHMgdG8gY29u
c2lkZXIgdHdvIHRoaW5nczoNCj4gICAxLiBUaGF0IHRoZSBuZXcgbWFwcGluZyBpc27igJl0IHBs
YWNlZCBpbiBhbiBhbnkgZXhpc3RpbmcgbWFwcGluZ3MgZ3VhcmQNCj4gICAgICBnYXBzLg0KPiAg
IDIuIFRoYXQgdGhlIG5ldyBtYXBwaW5nIGlzbuKAmXQgcGxhY2VkIHN1Y2ggdGhhdCBhbnkgZXhp
c3RpbmcgbWFwcGluZ3MNCj4gICAgICBhcmUgbm90IGluICppdHMqIGd1YXJkIGdhcHMuDQo+IA0K
PiBUaGUgbG9uZyBzdGFuZGluZyBiZWhhdmlvciBvZiBtbWFwKCkgaXMgdG8gZW5zdXJlIDEsIGJ1
dCBub3QgdGFrZSBhbnkgY2FyZQ0KPiBhcm91bmQgMi4gU28gZm9yIGV4YW1wbGUsIGlmIHRoZXJl
IGlzIGEgUEFHRV9TSVpFIGZyZWUgYXJlYSwgYW5kIGENCj4gbW1hcCgpIHdpdGggYSBQQUdFX1NJ
WkUgc2l6ZSwgYW5kIGEgdHlwZSB0aGF0IGhhcyBhIGd1YXJkIGdhcCBpcyBiZWluZw0KPiBwbGFj
ZWQsIG1tYXAoKSBtYXkgcGxhY2UgdGhlIHNoYWRvdyBzdGFjayBpbiB0aGUgUEFHRV9TSVpFIGZy
ZWUgYXJlYS4gVGhlbg0KPiB0aGUgbWFwcGluZyB0aGF0IGlzIHN1cHBvc2VkIHRvIGhhdmUgYSBn
dWFyZCBnYXAgd2lsbCBub3QgaGF2ZSBhIGdhcCB0bw0KPiB0aGUgYWRqYWNlbnQgVk1BLg0KPiAN
Cj4gVXNlIG1tX2dldF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3MoKSBpbiB0aGUgZG9fbW1hcCgpIHNv
IGZ1dHVyZSBjaGFuZ2VzDQo+IGNhbiBjYXVzZSBzaGFkb3cgc3RhY2sgbWFwcGluZ3MgdG8gYmUg
cGxhY2VkIHdpdGggYSBndWFyZCBnYXAuIEFsc28gdXNlDQo+IHRoZSBUSFAgdmFyaWFudCB0aGF0
IHRha2VzIHZtX2ZsYWdzLCBzdWNoIHRoYXQgVEhQIHNoYWRvdyBzdGFjayBjYW4gZ2V0IHRoZQ0K
PiBzYW1lIHRyZWF0bWVudC4gQWRqdXN0IHRoZSB2bV9mbGFncyBjYWxjdWxhdGlvbiB0byBoYXBw
ZW4gZWFybGllciBzbyB0aGF0DQo+IHRoZSB2bV9mbGFncyBjYW4gYmUgcGFzc2VkIGludG8gX19n
ZXRfdW5tYXBwZWRfYXJlYSgpLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUg
PHJpY2sucC5lZGdlY29tYmVAaW50ZWwuY29tPg0KPiAtLS0NCj4gdjI6DQo+ICAgLSBNYWtlIGdl
dF91bm1hcHBlZF9hcmVhKCkgYSBzdGF0aWMgaW5saW5lIChLaXJpbGwpDQo+IC0tLQ0KPiAgIGlu
Y2x1ZGUvbGludXgvbW0uaCB8IDExICsrKysrKysrKystDQo+ICAgbW0vbW1hcC5jICAgICAgICAg
IHwgMzQgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLQ0KPiAgIDIgZmlsZXMgY2hh
bmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9tbS5oIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+IGluZGV4IGY1YTk3
ZGVjNTE2OS4uZDkxY2RlNzlhYWVlIDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2xpbnV4L21tLmgN
Cj4gKysrIGIvaW5jbHVkZS9saW51eC9tbS5oDQo+IEBAIC0zMzYzLDcgKzMzNjMsMTYgQEAgZXh0
ZXJuIGludCBpbnN0YWxsX3NwZWNpYWxfbWFwcGluZyhzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4g
ICB1bnNpZ25lZCBsb25nIHJhbmRvbWl6ZV9zdGFja190b3AodW5zaWduZWQgbG9uZyBzdGFja190
b3ApOw0KPiAgIHVuc2lnbmVkIGxvbmcgcmFuZG9taXplX3BhZ2UodW5zaWduZWQgbG9uZyBzdGFy
dCwgdW5zaWduZWQgbG9uZyByYW5nZSk7DQo+ICAgDQo+IC1leHRlcm4gdW5zaWduZWQgbG9uZyBn
ZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmlsZSAqLCB1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBs
b25nLCB1bnNpZ25lZCBsb25nLCB1bnNpZ25lZCBsb25nKTsNCj4gK3Vuc2lnbmVkIGxvbmcNCj4g
K19fZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcgYWRk
ciwgdW5zaWduZWQgbG9uZyBsZW4sDQo+ICsJCSAgICB1bnNpZ25lZCBsb25nIHBnb2ZmLCB1bnNp
Z25lZCBsb25nIGZsYWdzLCB2bV9mbGFnc190IHZtX2ZsYWdzKTsNCj4gKw0KPiArc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nDQo+ICtnZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmls
ZSwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4gKwkJICB1bnNpZ25l
ZCBsb25nIHBnb2ZmLCB1bnNpZ25lZCBsb25nIGZsYWdzKQ0KPiArew0KPiArCXJldHVybiBfX2dl
dF91bm1hcHBlZF9hcmVhKGZpbGUsIGFkZHIsIGxlbiwgcGdvZmYsIGZsYWdzLCAwKTsNCj4gK30N
Cj4gICANCj4gICBleHRlcm4gdW5zaWduZWQgbG9uZyBtbWFwX3JlZ2lvbihzdHJ1Y3QgZmlsZSAq
ZmlsZSwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgIAl1bnNpZ25lZCBsb25nIGxlbiwgdm1fZmxh
Z3NfdCB2bV9mbGFncywgdW5zaWduZWQgbG9uZyBwZ29mZiwNCj4gZGlmZiAtLWdpdCBhL21tL21t
YXAuYyBiL21tL21tYXAuYw0KPiBpbmRleCBlMjNjZThjYTI0YzkuLmEzMTI4ZWQyNjY3NiAxMDA2
NDQNCj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBiL21tL21tYXAuYw0KPiBAQCAtMTI1NywxOCAr
MTI1Nyw2IEBAIHVuc2lnbmVkIGxvbmcgZG9fbW1hcChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWdu
ZWQgbG9uZyBhZGRyLA0KPiAgIAlpZiAobW0tPm1hcF9jb3VudCA+IHN5c2N0bF9tYXhfbWFwX2Nv
dW50KQ0KPiAgIAkJcmV0dXJuIC1FTk9NRU07DQo+ICAgDQo+IC0JLyogT2J0YWluIHRoZSBhZGRy
ZXNzIHRvIG1hcCB0by4gd2UgdmVyaWZ5IChvciBzZWxlY3QpIGl0IGFuZCBlbnN1cmUNCj4gLQkg
KiB0aGF0IGl0IHJlcHJlc2VudHMgYSB2YWxpZCBzZWN0aW9uIG9mIHRoZSBhZGRyZXNzIHNwYWNl
Lg0KPiAtCSAqLw0KPiAtCWFkZHIgPSBnZXRfdW5tYXBwZWRfYXJlYShmaWxlLCBhZGRyLCBsZW4s
IHBnb2ZmLCBmbGFncyk7DQo+IC0JaWYgKElTX0VSUl9WQUxVRShhZGRyKSkNCj4gLQkJcmV0dXJu
IGFkZHI7DQo+IC0NCj4gLQlpZiAoZmxhZ3MgJiBNQVBfRklYRURfTk9SRVBMQUNFKSB7DQo+IC0J
CWlmIChmaW5kX3ZtYV9pbnRlcnNlY3Rpb24obW0sIGFkZHIsIGFkZHIgKyBsZW4pKQ0KPiAtCQkJ
cmV0dXJuIC1FRVhJU1Q7DQo+IC0JfQ0KPiAtDQo+ICAgCWlmIChwcm90ID09IFBST1RfRVhFQykg
ew0KPiAgIAkJcGtleSA9IGV4ZWN1dGVfb25seV9wa2V5KG1tKTsNCj4gICAJCWlmIChwa2V5IDwg
MCkNCj4gQEAgLTEyODIsNiArMTI3MCwxOCBAQCB1bnNpZ25lZCBsb25nIGRvX21tYXAoc3RydWN0
IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gICAJdm1fZmxhZ3MgfD0gY2FsY192
bV9wcm90X2JpdHMocHJvdCwgcGtleSkgfCBjYWxjX3ZtX2ZsYWdfYml0cyhmbGFncykgfA0KPiAg
IAkJCW1tLT5kZWZfZmxhZ3MgfCBWTV9NQVlSRUFEIHwgVk1fTUFZV1JJVEUgfCBWTV9NQVlFWEVD
Ow0KPiAgIA0KPiArCS8qIE9idGFpbiB0aGUgYWRkcmVzcyB0byBtYXAgdG8uIHdlIHZlcmlmeSAo
b3Igc2VsZWN0KSBpdCBhbmQgZW5zdXJlDQo+ICsJICogdGhhdCBpdCByZXByZXNlbnRzIGEgdmFs
aWQgc2VjdGlvbiBvZiB0aGUgYWRkcmVzcyBzcGFjZS4NCj4gKwkgKi8NCj4gKwlhZGRyID0gX19n
ZXRfdW5tYXBwZWRfYXJlYShmaWxlLCBhZGRyLCBsZW4sIHBnb2ZmLCBmbGFncywgdm1fZmxhZ3Mp
Ow0KPiArCWlmIChJU19FUlJfVkFMVUUoYWRkcikpDQo+ICsJCXJldHVybiBhZGRyOw0KPiArDQo+
ICsJaWYgKGZsYWdzICYgTUFQX0ZJWEVEX05PUkVQTEFDRSkgew0KPiArCQlpZiAoZmluZF92bWFf
aW50ZXJzZWN0aW9uKG1tLCBhZGRyLCBhZGRyICsgbGVuKSkNCj4gKwkJCXJldHVybiAtRUVYSVNU
Ow0KPiArCX0NCj4gKw0KPiAgIAlpZiAoZmxhZ3MgJiBNQVBfTE9DS0VEKQ0KPiAgIAkJaWYgKCFj
YW5fZG9fbWxvY2soKSkNCj4gICAJCQlyZXR1cm4gLUVQRVJNOw0KPiBAQCAtMTgzOSw4ICsxODM5
LDggQEAgdW5zaWduZWQgbG9uZyBtbV9nZXRfdW5tYXBwZWRfYXJlYV92bWZsYWdzKHN0cnVjdCBt
bV9zdHJ1Y3QgKm1tLCBzdHJ1Y3QgZmlsZSAqZmkNCj4gICB9DQo+ICAgDQo+ICAgdW5zaWduZWQg
bG9uZw0KPiAtZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGxv
bmcgYWRkciwgdW5zaWduZWQgbG9uZyBsZW4sDQo+IC0JCXVuc2lnbmVkIGxvbmcgcGdvZmYsIHVu
c2lnbmVkIGxvbmcgZmxhZ3MpDQo+ICtfX2dldF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpm
aWxlLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0KPiArCQl1bnNpZ25l
ZCBsb25nIHBnb2ZmLCB1bnNpZ25lZCBsb25nIGZsYWdzLCB2bV9mbGFnc190IHZtX2ZsYWdzKQ0K
PiAgIHsNCj4gICAJdW5zaWduZWQgbG9uZyAoKmdldF9hcmVhKShzdHJ1Y3QgZmlsZSAqLCB1bnNp
Z25lZCBsb25nLA0KPiAgIAkJCQkgIHVuc2lnbmVkIGxvbmcsIHVuc2lnbmVkIGxvbmcsIHVuc2ln
bmVkIGxvbmcpDQo+IEBAIC0xODc1LDggKzE4NzUsOCBAQCBnZXRfdW5tYXBwZWRfYXJlYShzdHJ1
Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4g
ICAJaWYgKGdldF9hcmVhKQ0KPiAgIAkJYWRkciA9IGdldF9hcmVhKGZpbGUsIGFkZHIsIGxlbiwg
cGdvZmYsIGZsYWdzKTsNCg0KV2hhdCBhYm91dCBnZXRfYXJlYSgpLCB3aGF0IGhhcHBlbnMgdG8g
dm1fZmxhZ3MgaW4gY2FzZSB0aGF0IGZ1bmN0aW9uIGlzIA0KdXNlZCA/DQoNCj4gICAJZWxzZQ0K
PiAtCQlhZGRyID0gbW1fZ2V0X3VubWFwcGVkX2FyZWEoY3VycmVudC0+bW0sIGZpbGUsIGFkZHIs
IGxlbiwNCj4gLQkJCQkJICAgIHBnb2ZmLCBmbGFncyk7DQo+ICsJCWFkZHIgPSBtbV9nZXRfdW5t
YXBwZWRfYXJlYV92bWZsYWdzKGN1cnJlbnQtPm1tLCBmaWxlLCBhZGRyLCBsZW4sDQo+ICsJCQkJ
CQkgICAgcGdvZmYsIGZsYWdzLCB2bV9mbGFncyk7DQo+ICAgCWlmIChJU19FUlJfVkFMVUUoYWRk
cikpDQo+ICAgCQlyZXR1cm4gYWRkcjsNCj4gICANCj4gQEAgLTE4ODksOCArMTg4OSw2IEBAIGdl
dF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBsb25nIGFkZHIsIHVu
c2lnbmVkIGxvbmcgbGVuLA0KPiAgIAlyZXR1cm4gZXJyb3IgPyBlcnJvciA6IGFkZHI7DQo+ICAg
fQ0KPiAgIA0KPiAtRVhQT1JUX1NZTUJPTChnZXRfdW5tYXBwZWRfYXJlYSk7DQo+IC0NCg0KRG9u
J3QgeW91IGhhdmUgdG8gZXhwb3J0IF9fZ2V0X3VubWFwcGVkX2FyZWEoKSBzbyB0aGF0IHRoZSBz
dGF0aWMgaW5saW5lIA0KZ2V0X3VubWFwcGVkX2FyZWEoKSB1c2VkIGluIGEgbW9kdWxlIGhhdmUg
YWNjZXNzIHRvIF9fZ2V0X3VubWFwcGVkX2FyZWEoKSA/DQoNCklmIGl0IHdhcyBwb2ludGxlc3Mg
dG8gZXhwb3J0IGdldF91bm1hcHBlZF9hcmVhKCksIGl0cyByZW1vdmFsIHNob3VsZCBiZSANCmEg
c2VwYXJhdGUgcGF0Y2guDQoNCj4gICB1bnNpZ25lZCBsb25nDQo+ICAgbW1fZ2V0X3VubWFwcGVk
X2FyZWEoc3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCBmaWxlICpmaWxlLA0KPiAgIAkJICAg
ICB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0K

