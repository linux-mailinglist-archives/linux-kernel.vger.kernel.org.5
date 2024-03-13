Return-Path: <linux-kernel+bounces-102252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0F187AFD4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5183E28BD54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D3A01A38FE;
	Wed, 13 Mar 2024 17:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="e9wvEIRm"
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022018.outbound.protection.outlook.com [52.101.167.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098536215F
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350418; cv=fail; b=DdtNo+0hDgyvQ7hY9pU3LpzbXgz7HLExcxuoU/sByMyGBVrqealmhEZTZ2emxB3lppmp/LamAkqK8aE4Sp2wiLzvPpb5JUX3UA4SojcfwOQuUzGBT8HBZPrBITSdM9o9c9T2Byd+U+hHBb6R6PJzj9JtVksreqvSsn2mwWMVmIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350418; c=relaxed/simple;
	bh=ndk55hIh6OwsJ9XecQ9W2YqgNpqHgkNvTjv/7xnUsL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ELa2aktBnTMKNBVlBe1D2x9LGIU/olxMO4R41/NBTxeiFiTmcZWV96RZU2wJH6obcinHYVlnOy59Vp8fad59dXJ1Y2SmBWPnd8pLtR9Y+O6Covr8NYqCROCcU5L3wt34rG+b/RnTWScRTFNikugXChn4vJhkT3OB94OKemB0ddc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=e9wvEIRm; arc=fail smtp.client-ip=52.101.167.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrsC6N7U0+AQKqVMBGqs58bg/F+kORP7JuDArmUvcUTuXeB77jzogkyCQBYNfsBT08zQX/YBbHc/u3k5wLqd9+bZBR40e6LfrtG0uNtWiqsGt7RyW/FfGbFcP91NvdLbBlAJzrm353AA2CxqOUaD+vvC0Q7hcBGv8T/WWvfRm6HeUnhMgVdQfHiHiSOQf296RpTRtKtjN6wVuLD9R9RtlxCc/3+abgPEbhuht2QeZJPOQn37v4vf7u6rwc940J3+d7De07kkoW9mJnObU4VJeqE+o4oQIN+thfBG0mWTFPm7vNi64MA8lkJXDxxgK6YmMjnjeL6pCtB6CGebkSIevg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ndk55hIh6OwsJ9XecQ9W2YqgNpqHgkNvTjv/7xnUsL8=;
 b=BdTtJ497mw/pGD8RFBzXhY4IAJaQXfQZAR/pLd0dQ5I2L6+V5mKnXowvLoGsVCTVuFuVDddHprzR0Bk/bQBakQNjymhkvw1GZ2XX69lkLTcysR9hpDsP4RMOf9Nu82oFeQJbP+OkIrwV7ZSn8alfR2RSyRHwvmzqmHQKFRRE4HCRIKhiALAIoGaMKm0eOu7ue4cp+8J3x/IgcEDWPknIVzj1SNsO+7yl15TWig8iqnLpG46QgwQ3hoV619hg8yDW//Q8/QC4+fTCLDlzE3YFqQn3abLK4V9vwbvL+OsvWWO5nwnx2aS9Vw26Kl+v8YF7rgSP6yZBPDi8CCJ9POFVKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndk55hIh6OwsJ9XecQ9W2YqgNpqHgkNvTjv/7xnUsL8=;
 b=e9wvEIRmQDLTnIU3zFAselFRxq+dSGdzeshNmFY5ugE1eklo6H9tZGpM4wVOUiRJde2owaJEKYDJcnC0ODVaHCcuwrf22NTqOvBOAZyIg+z1V/20K/J/N/UKYND1eGCO2Umt6VhV0YvMKDnZLw+n6EuH/PljjYUzYtRwquqzfiwoR3WohHSmD0TFNSIncpE+1n075UwVEaFgaeUkQSa/gpFA0uVZNJ6smvPv/VgDYfndcGnaPObGq+MUu7sbCE2hYQ/pRf/9+2+QXO7dbkJWzbRxhmfCfjcYFvk82+SNglg7ggXOo8S/UW3BwryzcS4svH6VlBFYfzSMC+ZH81UwpQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2969.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 17:20:12 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 17:20:12 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>, "debug@rivosinc.com"
	<debug@rivosinc.com>, "luto@kernel.org" <luto@kernel.org>, "x86@kernel.org"
	<x86@kernel.org>, "Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "keescook@chromium.org"
	<keescook@chromium.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "peterz@infradead.org"
	<peterz@infradead.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 01/12] mm: Switch mm->get_unmapped_area() to a flag
Thread-Topic: [PATCH v3 01/12] mm: Switch mm->get_unmapped_area() to a flag
Thread-Index: AQHadMy0T5WtX19oUE+qwK/qPHezQ7E1Q+4AgAB9fwCAACpgAA==
Date: Wed, 13 Mar 2024 17:20:11 +0000
Message-ID: <94e818d7-eca8-4067-b39f-81a447d2a50e@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-2-rick.p.edgecombe@intel.com>
 <21ba6b8e-b9c7-41ae-8815-46525557c687@csgroup.eu>
 <9d0a0ba73438031bf60172c7126cee87d63c070e.camel@intel.com>
In-Reply-To: <9d0a0ba73438031bf60172c7126cee87d63c070e.camel@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB2969:EE_
x-ms-office365-filtering-correlation-id: 61a51bd1-deff-4de2-7a4b-08dc4381d72f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Abl0RLUASViSaZJcFBpYVdfLCU/eXyI184YI8r2Fr3SNcNYNMd5eEvUnB8ZApnfjnIRJEXRp1mSZqoR7JGHpBFP+BqFNzdmvNoToerRM3MMk6M7/gBHd+FH76uPpnnIM9jolSUVvfNl74gA3bSeJXIdFmsVVHlRXhjQK62dgMuZ2ghEFoTInS07/pWtQ6o0b/FDnp1/DXqpBmNnXqZZkAuQ4XLpY9c4c/oOkja2BZpVyd8gdCAPOlsFVN03MuhyFccRyiSK0n0siJGKQkBwEpvYXI+O+eYzthNLdqjh3iUq82FmLvZzRmTI5SGNpqF2DWbiPzTDQHrQL3aD2NyXlbp1/lR9IOMONLiVk6rJbwtVqhZ9J0N30ffCuygxEumTVeKB/LY4jFXMaHJz+p5Po0k1u2vZdc5ctQzKrWHSeoE5ZunD3fiDyS/gCdE7muQlegQxqgRj9cny54O+icRPDLte75vByF/Pb0ClVDIml1bpR/SoAaEX6RreW8kov1j/XXgqRRXwqJhkztEOtSc1e61/GpurAwqQbDjLXWVVaC+EiERs5CtztibqaC6zh/Ro036o8Xf03LQPrwHk6M4ft5uPB3DHT69ne+GQFVZ45YQU6IdOwRiLbmTUEBq3ZlGU1OoGcIrp5X0Ch1BAemC9TdFnEW1tGOwBIxSDle5YvlGGd+gYU/0rUePn0K+vvdc1MFiQb/2NaBF8kJFvPTnoJTmLfFyGpsRfsp04xnfplkio=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SnlNeS9kQytWZUVOc2dWM3JUNVBsTFFCcDQ2ZmdEeTFPajBvOEd2dXUrZll0?=
 =?utf-8?B?aGowakFDeTlENmwwaTVkN0xVQnNCQ2dSVTFJL0s1d3ozaWdObFhYdXl1cEs0?=
 =?utf-8?B?VGZCcUV5VldzcXgvZFl6OXVlaTY3TlNHVVp0dVUyMFd5RGI5N1pRU1dHZzdE?=
 =?utf-8?B?RE8yL0l1bHdaVEQ3NE0rWWM5eWkrdWhUcWpLVXpBK1Vpdzd6RjIwK0NmQ1JH?=
 =?utf-8?B?UzBqVU54NjJHbnRtQU9UaVN4ZDJUcWE2OGhhUHlsNE5kb0hxK3JIV2FPZjh2?=
 =?utf-8?B?eFZRZHdKYWM4bkVmRmc3K0FVaU9xUkV0VkJEQXZlMG9YMTZCK2VUNzFGeC9w?=
 =?utf-8?B?VkZ6MktielBVaFlJV09yYlE1L1JzcVFlYk1YWGR2Wjk2ZlF2Vnp0SlJQMXFR?=
 =?utf-8?B?WU12aGRYRTJyZkRrRCtCSE9pbUFXMmpOekJHMzRicUx3LzJuNXkvUFdIRjFp?=
 =?utf-8?B?Z3hRK2FEd0ZNWXdLY1JWRDZNbyszZEg3VFVmTmFsakRHaWQ5T3ROdmtKSzI3?=
 =?utf-8?B?R0hxZlBUcFVKWU15Wis3WXlUbElXUG52bGU0ZUpxWlAvRzVlMzR2OWl2MUs3?=
 =?utf-8?B?UG1XUkZlalhFNTNLWElYTWhxdmJFbEZ3aFhVaTdWSWZTL2p5anVUcWhNNkVr?=
 =?utf-8?B?Q3hNYjlMcnRKQ3ZWd08wYXJtVEVacGZNTnNsWmszSmVvZkJjVWJTWHZzM3I5?=
 =?utf-8?B?ZEE1TUZ1Ry90dWpsMjQva1R4L1dUNEV5QkJDQ2VRZTFBNU4wVzEyRjZaS2Y1?=
 =?utf-8?B?d0NKdmFNNHM3eUN2bWtQbFpTbzMwV3Bia0xOaDhFM0k3WGR5amg2a3FCUGFY?=
 =?utf-8?B?RDNCb0FFRnUvQzJZU3MwQmdSSFhrWGRXZW1VK2xFVUFINWpVZHNIUGlsQy93?=
 =?utf-8?B?b2pndVFheTlQeFp4YkZwSGhpcUp6VWc5Q2JQbzZWZHJ6dTFPMHM1RDZmR0th?=
 =?utf-8?B?aE5mTnJONW13OVF4a2hXNWs4QVRTOVNCbzlCck5JUzVFcTRlTzZJY05IZmN4?=
 =?utf-8?B?clEzWEdiZXQ2SHRudXRMcmw1cG5qYzEyU3hkQzRud1lnNHhGcUxYMHh2SjNL?=
 =?utf-8?B?eTJJQ29SaE83MmtvVjhObElxWGU1VVkwMGxpc25BdDN6aFhGc0RZZGNQNisx?=
 =?utf-8?B?VWppOVVVaFV6RjU0MFM1VmtWTmFCU21USUZlaFA3TmxMUmMzWjM5RHNvYndD?=
 =?utf-8?B?eVYraVpSTmI0bUsyMWVwdDdQMSt1TVVyWFdnbU56OWhneEdsOWhjUzJJUXpi?=
 =?utf-8?B?VG5Qem5tZXlGcm5JSEIvbEF3RlIySGVTcGRHRTdxQW8yN2hBK3hDcGdhaVNm?=
 =?utf-8?B?OTRTM3V5R24zRFlZbGxnazVnL24rMGpVbHIzdnozSko5VCt2TEhydkdJZ003?=
 =?utf-8?B?Rk93OFBDWkdLQ0NHODhzMThDT0RFL3Ztd2hGTDZqUEF4MS9PbnBQTUp4TkFw?=
 =?utf-8?B?NjlDTXQvUlhUWWFiL2VtV29sME84SjRuYVcxd1BHOTFpNU9jaXdmUnU4Q1RJ?=
 =?utf-8?B?ekVQN0lOYUNVbW05S05jd1V1aUhDMDRKME5zQlkyUURYblBid0hMTEprUjRo?=
 =?utf-8?B?ZEFWcXFrSENzTmZXSzVzZjB4eFlJekREUFZ5bWhjRTh1Z3B2ekhlcjhDZnlJ?=
 =?utf-8?B?UDJ4T1FDbEtjK0t4U0dIVGhVNWRRREJPanUwWTQxU2NWQituYVp0djJHTFZM?=
 =?utf-8?B?b2pySHFhM2VOTVB0YmIyRTFlMENNTlNvK0JaZ0hIUnF1VjhpaVJyWnZRRTdC?=
 =?utf-8?B?VXF1ZEwrUkkvWWlDZXR4OWptNSs3cmFyaCtCdFBTVnNmYkh6cHVyZkROczRI?=
 =?utf-8?B?RVlMUkdkRmFKN2dTYWU0R3JXM0xwV0w2VzVQbFlQYWFaaWRLNFFwVEs2U3E0?=
 =?utf-8?B?Z3p6cWxLeHh1Q0NyNUhBa2RFajdobHBDRHNvRWhxVDZ4RE0zL1QyRVN2MnIw?=
 =?utf-8?B?YUR6VCthenJmVEZTWVFJSUxRRVNqUit4RFBjWUt1SFErc21sRWw4WkJxNnhH?=
 =?utf-8?B?WFQwMldGMjhDbVdrcXJTNXo2TTBmQk9VemhPM3dxU1lhanUvMzl5aHVBZmYv?=
 =?utf-8?B?ZkYyTWJmS0xHd1hkOVdicXZpNExta25kZk1kdU54VTloYUxoNmFwSDB1ekx4?=
 =?utf-8?B?M2JKNzM5d2ZQTVVxK3MyY3AwZkZsTHBPclgvOGRTcmRuVXNDSzllVWpXWTVu?=
 =?utf-8?B?SHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7689953034E2D44FAF8903CA2E0522F8@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 61a51bd1-deff-4de2-7a4b-08dc4381d72f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 17:20:11.9804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ek/tw15qJkX8aP2i4IiFzENI9l4KagnANjDzyz1CZqqEIVrteYf4QSsKh9gidp+472kI+SmGKOE2CVQx4gntDeoFNaQ4vquuU1V9PIxWAo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2969

DQoNCkxlIDEzLzAzLzIwMjQgw6AgMTU6NDgsIEVkZ2Vjb21iZSwgUmljayBQIGEgw6ljcml0wqA6
DQo+IE9uIFdlZCwgMjAyNC0wMy0xMyBhdCAwNzoxOSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJveSB3
cm90ZToNCj4+IFRoaXMgcGF0Y2ggaXMgcXVpdGUgYmlnIGFuZCB1bi1lYXN5IHRvIGZvbGxvdy4g
V291bGQgYmUgd29ydGgNCj4+IHNwbGl0dGluZw0KPj4gaW4gc2V2ZXJhbCBwYXRjaGVzIGlmIHBv
c3NpYmxlLiBTb21lIG9mIHRoZSBjaGFuZ2VzIHNlZW0gdG8gZ28NCj4+IGZ1cnRoZXINCj4+IHRo
YW4ganVzdCBzd2l0Y2hpbmcgbW0tPmdldF91bm1hcHBlZF9hcmVhKCkgdG8gYSBmbGFnLg0KPj4N
Cj4+IEZpcnN0IHBhdGNoIGNvdWxkIGFkZCB0aGUgbmV3IGZsYWcgYW5kIG5lY2Vzc2FyeSBoZWxw
ZXJzLCB0aGVuDQo+PiBmb2xsb3dpbmcNCj4+IHBhdGNoZXMgY291bGQgY29udmVydCBzdWItc3lz
dGVtcyBvbmUgYnkgb25lIHRoZW4gbGFzdCBwYXRjaCB3b3VsZA0KPj4gcmVtb3ZlIG1tLT5nZXRf
dW5tYXBwZWRfYXJlYSgpIG9uY2UgYWxsIHVzZXJzIGFyZSBjb252ZXJ0ZWQuDQo+IA0KPiBTbyB5
b3UgYXJlIHNheWluZyB0byBkbyB0aGUgdHJhY2tpbmcgaW4gYm90aCB0aGUgbmV3IGZsYWcgYW5k
IG1tLQ0KPj4gZ2V0X3VubWFwcGVkX2FyZWEoKSBkdXJpbmcgdGhlIGNvbnZlcnNpb24gcHJvY2Vz
cyBhbmQgdGhlbiByZW1vdmUgdGhlDQo+IHBvaW50ZXIgYXQgdGhlIGVuZD8gSSBndWVzcyBpdCBj
b3VsZCBiZSBicm9rZW4gb3V0LCBidXQgbW9zdCBvZiB0aGUNCj4gY29udmVyc2lvbnMgYXJlIHRy
aXZpYWwgb25lIGxpbmUgY2hhbmdlcy4gSG1tLCBJJ20gbm90IHN1cmUuDQo+IA0KPiBbc25pcF0N
Cj4+DQo+Pj4gIMKgwqAgI2lmZGVmIENPTkZJR19NTVUNCj4+PiAtwqDCoMKgwqDCoMKgwqBpZiAo
IWdldF9hcmVhKQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBnZXRfYXJlYSA9
IGN1cnJlbnQtPm1tLT5nZXRfdW5tYXBwZWRfYXJlYTsNCj4+PiArwqDCoMKgwqDCoMKgwqBlbHNl
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiBtbV9nZXRfdW5tYXBw
ZWRfYXJlYShjdXJyZW50LT5tbSwgZmlsZSwNCj4+PiBvcmlnX2FkZHIsDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBsZW4sIHBnb2ZmLCBmbGFncyk7DQo+Pj4gIMKgwqAgI2VuZGlm
DQo+Pj4gLcKgwqDCoMKgwqDCoMKgaWYgKGdldF9hcmVhKQ0KPj4+IC3CoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqByZXR1cm4gZ2V0X2FyZWEoZmlsZSwgb3JpZ19hZGRyLCBsZW4sIHBnb2Zm
LA0KPj4+IGZsYWdzKTsNCj4+PiArDQo+Pj4gIMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gb3JpZ19h
ZGRyOw0KPj4+ICDCoMKgIH0NCj4+DQo+PiBUaGUgY2hhbmdlIGxvb2tzIHVuY2xlYXIgYXQgZmly
c3QgbG9vay4gT2sgYWZ0ZXIgbG9va2luZyBhIHNlY29uZA0KPj4gdGltZQ0KPj4gaXQgc2VlbXMg
dG8gc2ltcGxpZnkgdGhpbmdzLCBidXQgd291bGQgYmUgYmV0dGVyIGFzIGEgc2VwYXJhdGUgcGF0
Y2guDQo+PiBEb24ndCBrbm93Lg0KPiANCj4gSG1tLiBJIHRoaW5rIHRoZSBvbmx5IHdheSB0byBk
byBpdCBpbiBzbWFsbGVyIGNodW5rcyBpcyB0byBkbyBib3RoDQo+IG1ldGhvZHMgb2YgdHJhY2tp
bmcgdGhlIGRpcmVjdGlvbiBkdXJpbmcgdGhlIGNvbnZlcnNpb24gcHJvY2Vzcy4gQW5kDQo+IHRo
ZW4gdGhlIHNtYWxsZXIgcGllY2VzIHdvdWxkIGJlIHJlYWxseSBzbWFsbC4gU28gaXQgd291bGQg
cHJvYmFibHkNCj4gaGVscCBmb3IgY2hhbmdlcyBsaWtlIHRoaXMsIGJ1dCBvdGhlcndpc2Ugd291
bGQgZ2VuZXJhdGUgYSBsb3Qgb2YNCj4gcGF0Y2hlcyB3aXRoIHNtYWxsIGNoYW5nZXMuDQoNClll
cy4gTWF5YmUgdGhlIGJlc3Qgd291bGQgYmUgdG8gaGF2ZSBhIHByZXBhcmF0aW9uIHBhdGNoIHRv
IGNodXJuIHRoaXMgDQpmdW5jdGlvbiBhIGJpdCBzbyB0aGF0IHdoZW4gaXQgY29tZXMgdG8gdGhl
IGNvbnNlcnZpb24gaXQgaXMgdHJpdmlhbC4NCg0KU29tZXRoaW5nIGxpa2U6DQoNCglpZiAocGRl
LT5wcm9jX29wcy0+cHJvY19nZXRfdW5tYXBwZWRfYXJlYSkNCgkJcmV0dXJuIHBkZS0+cHJvY19v
cHMtPnByb2NfZ2V0X3VubWFwcGVkX2FyZWEoZmlsZSwgb3JpZ19hZGRyLCBsZW4sIA0KcGdvZmYs
IGZsYWdzKTsNCg0KI2lmZGVmIENPTkZJR19NTVUNCglyZXR1cm4gY3VycmVudC0+bW0tPmdldF91
bm1hcHBlZF9hcmVhKGZpbGUsIG9yaWdfYWRkciwgbGVuLCBwZ29mZiwgZmxhZ3MpOw0KI2VuZGlm
DQoJcmV0dXJuIG9yaWdfYWRkcjsNCg0KDQpOb3RlIHRoYXQgYSBsZW5ndGggb2YgMTAwIGNoYXJz
IGlzIG5vdyB0b2xlcmF0ZWQgd2hlbiBpdCBlYXNlcyByZWFkaW5nIA0Kc28geW91IHNob3VsZCBh
dm9pZCB0aG9zZSAzIGxpbmVzLg0KDQpBbmQgdGhlIGVsc2UgaW5zaWRlICNpZmRlZiBDT05GSUdf
TU1VIGlzIG5vdCBuZWVkZWQgYmVjYXVzZSAnaWYnIGhhcyANCnJldHVybmVkLg0KDQo+IA0KPiBU
aGUgc3RlcHMgYXJlIGJhc2ljYWxseToNCj4gMS4gSW50cm9kdWNlIGZsYWcgYW5kIGhlbHBlcnMN
Cj4gMi4gY29udmVydCBhcmNoJ3MgdG8gdXNlIGl0IG9uZSBieSBvbmUNCj4gMy4gY29udmVydCBj
YWxsZXJzIHRvIHVzZSBtbV9nZXRfdW5tYXBwZWRfYXJlYSgpIG9uZSBieSBvbmUNCj4gNC4gcmVt
b3ZlIHNldHRpbmcgZ2V0X3VubWFwcGVkX2FyZWEgaW4gZWFjaCBhcmNoDQo+IDUuIHJlbW92ZSBn
ZXRfdW5tYXBwZWRfYXJlYQ0KPiANCj4gU3RlcCAzIGlzIHdoZXJlIHRoZSBmZXcgbm9uLW9uZWxp
bmUgY2hhbmdlcyB3b3VsZCBiZSwgYnV0IG1vc3Qgd291bGQNCj4gc3RpbGwgYmUgb25lIGxpbmVy
cy4gMSwgMiwgNCBhbmQgNSBzZWVtIHNpbXBsZXIgYXMgYSB0cmVlIHdpZGUgcGF0Y2gNCj4gYmVj
YXVzZSBvZiB0aGUgb25lIGxpbmUgY2hhbmdlcy4NCg0KSSBtaXNzZWQgdGhlIHNldHRpbmcgb2Yg
Z2V0X3VubWFwcGVkX2FyZWEgYnkgZWFjaCBhcmNoLCB5b3UgYXJlIHJpZ2h0IGl0IA0KbWlnaHQg
YmUgY29tcGxpY2F0ZWQgYXQgdGhlIGVuZC4NCg0KPiANCj4gSSBkb24ndCBrbm93IGFueSBvdGhl
ciB2YXJpYXRpb25zIGFyZSBhIHRvbiBzaW1wbGVyLiBIb3BlZnVsbHkgb3RoZXJzDQo+IHdpbGwg
d2VpZ2ggaW4uDQo+IA0KPiANCj4gDQo+IFtzbmlwXQ0KPj4+ICAgICANCj4+PiArdW5zaWduZWQg
bG9uZw0KPj4+ICttbV9nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3Ry
dWN0IGZpbGUgKmZpbGUsDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBsZW4sDQo+Pj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcGdvZmYsIHVuc2ln
bmVkIGxvbmcgZmxhZ3MpDQo+Pj4gK3sNCj4+PiArwqDCoMKgwqDCoMKgwqBpZiAodGVzdF9iaXQo
TU1GX1RPUERPV04sICZtbS0+ZmxhZ3MpKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYV90b3Bkb3duKGZpbGUsIGFkZHIsDQo+
Pj4gbGVuLCBwZ29mZiwgZmxhZ3MpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoHJldHVybiBhcmNoX2dl
dF91bm1hcHBlZF9hcmVhKGZpbGUsIGFkZHIsIGxlbiwgcGdvZmYsDQo+Pj4gZmxhZ3MpOw0KPj4+
ICt9DQo+Pg0KPj4gVGhpcyBmdW5jdGlvbiBzZWVtcyBxdWl0ZSBzaW1wbGUsIHdvdWxkbid0IGl0
IGJlIGJldHRlciB0byBtYWtlIGl0IGENCj4+IHN0YXRpYyBpbmxpbmUgPw0KPiANCj4gVGhlbiBh
bGwgb2YgdGhlIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWEoKSBhbmQNCj4gYXJjaF9nZXRfdW5tYXBw
ZWRfYXJlYV90b3Bkb3duKCkgd291bGQgbmVlZCB0byBiZSBleHBvcnRlZC4gSSB0aGluayBpdA0K
PiBpcyBiZXR0ZXIgdG8gb25seSBleHBvcnQgdGhlIGhpZ2hlciBsZXZlbCBmdW5jdGlvbnMuDQoN
ClJpZ2h0Lg0K

