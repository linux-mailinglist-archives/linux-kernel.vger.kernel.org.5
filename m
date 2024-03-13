Return-Path: <linux-kernel+bounces-101254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7158187A49C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB56B215A7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8837B1B965;
	Wed, 13 Mar 2024 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="S4eFiSs7"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021010.outbound.protection.outlook.com [52.101.167.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313BD3BB2E
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710320706; cv=fail; b=CKaGas6YUlx0U1aoLim5YFcAyoOufmg8gc/jNn7T6KfK3EE0FXig2EuksDJgNCK6d/V9raPyEQQSOne4PWR0+THqPVQDjhT7J0zcl1va7LA6vlI+/jax/hwwZvAMMgZkNEulcwsk70LLu8+JW2NIzvQ+AbFGLBnxj2P9POVDMN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710320706; c=relaxed/simple;
	bh=I99lxRcMWs2/o4ThNdGoblA+Jbfo3R3kvFoJV9zlnxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L5k3kpiss9bhamCzbubuYION3LcJDJjco4M2zy+AKzsgqNrTL5n6nRW9X1xAO5d8x2uzWDOI6+2Jlid9NEKwtggJ6YkpNgDc/bg6ih0nsyutqfC0puD1rayUzE729GiWGPAYg288/canEax2n3mNZv9NtLwD0Sfr9zfFE2LVAUU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=S4eFiSs7; arc=fail smtp.client-ip=52.101.167.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLG1TFmRb3NJmOy2uOZap0vFFP4lPMIXJW8kpdQwbxORXUTk+B5iFIbNabmPrfYRLbiXLAYIO4mGeA1cN2t95qqQlLEO64WG8jyvdPjCXDZsjgvnY/EWsqFgKDsCSdW8IAaAWTabWM2EKVt8CTOrf12DpI3KfIH1t1WLxZmF3RqILtVT3dRmIKDpUxS23bS6J+4VReRDA5rh3UxeoR2tVRq6UeVKKWNNp8nt+LcO8VUAdRhHrMvJm+Rp0TUk1DidzoKU1zgLxneG5mzGpayEh0UELaUMI8h3W1V5uLnyKayhrASbMFhkou7gn2ivSXjo3UI/CnJlk7srUnASdKzACQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I99lxRcMWs2/o4ThNdGoblA+Jbfo3R3kvFoJV9zlnxo=;
 b=WhSUfWceYwGVjjt3Hv0Q9M3c/nF4HLXDvHlNwvbfh6bQuJIToy9PliQ08AqooUdvANLQjIUmgzKHcZE34wkM5oTItv+dfhw/NxL6jdoUchNU13ewPS/KnKP61FD7gg9BMoi6v57GlngNMA7t4t5sKfFjHsYb9oHqyFnxgbmJgAc7IbNpPBe3e7YyB9W1kBWJuNG7u8ZSRt2+Q9rNVMkkhqG+nGPNh0jXeV4wCA9E7bs/xXn4D363Mpk2cCR5QovHSTVIMii2+8PyySItFTB7k21mkzSCPoEc2ifaUsb5alF2fl43to5nkrAO5C98IWXjcy/o8yIJ7Q4WgxXOKCEZRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I99lxRcMWs2/o4ThNdGoblA+Jbfo3R3kvFoJV9zlnxo=;
 b=S4eFiSs7jxSTXJzYwsoRLM1NM4Bf6K0heIi/xiY2YMZJByxCZy0U3z52m59y5x8BM/5BYfnPws5oj3Dhehg2GbUsLzZP0hvFPPECx0y7/0aqznfevQfn1Sdg4FA3rb66BAct7krp3olBpZQGUCG9C5K19clu+5J6G8NnwL4akwrqp+KPO+XfGp3iJzVFbEgppZyuFxiAjcSVJSDQuuskD7vDr/XGmZnCWatQrk2w51eDUHZoT4lEjLVHMuXNQkcU99ksbBvIK6thRa+OXEOjQKX60trACdqNwNDB1/pGrofNjhhKJGZempIIy/CRXiL9dLV7O4mINuJE49yvYEOQ0A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB2527.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1f1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 09:04:55 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 09:04:55 +0000
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
Subject: Re: [PATCH v3 04/12] thp: Add thp_get_unmapped_area_vmflags()
Thread-Topic: [PATCH v3 04/12] thp: Add thp_get_unmapped_area_vmflags()
Thread-Index: AQHadMy16BePzokCC069CZ0WQj/41LE1YWyA
Date: Wed, 13 Mar 2024 09:04:55 +0000
Message-ID: <d68e362c-be2b-473c-88cd-122bd918f877@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-5-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-5-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PAZP264MB2527:EE_
x-ms-office365-filtering-correlation-id: e066b01a-9aeb-4ae5-d8b0-08dc433ca68a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ttWOjZaLC4FC8GiW5StSY5T1T7EfES1XhO6cFoq3pgSxt5mftLzTqHKa/AOWFfmzqRrLkFsh8revah+t3jgASt3tsztOCpeC6EUt608mKEA0LnS45jT3kRFSgpmDEjTymjtORtiXLPdy3gpTIG7NfLqVv+OZC0r7ndw5YzZZEHOUNKpxnBQTteXeSbMUYQfbmp9JAS8+XURJjtoSD2VzelukvQKp0Ux6jbtrGboNfXmDtzABY9LxTJdNGA9wchk2ijc6+o1BVavb1YNaT/w6W4OFQh04YEkZmm7oHIgBLNGMnqsLwqcd9CjjYmTPCCkHjXAOmxVlwL+hv+fGTbU/KofV5USPTQ0dfiqONI1Nv5T7I1ky9S3Pqr4Tef1te9hzDlAxc9QSC18pO4bW+yuCXZHImZkeVw39vbnAoyP81Ytkqvu2+hmA62O/h2mdvrqRe827rkIXiusyFKdh8jksC+3TbnkyFH41ItUNFsd/pRTpZbPcOboJiG43xIPEk4Mg+TGkkA3Jx1oAYEbIvfeP0WnWuJrSWnIQZkASqIciz7vhS+bIzIUv0Bw6CZk2eH3w3XGSTEZDvI1mGaj4tmXA8iqpsA6o3HLyYh3aahYxksy2HYbtOYnTLu2A4jdERAXwcka5enpDbRC2vIjG4YQc0MTdpalKK86zIAg7TovsWt8J7PhIXkD8x9EhReM66BtLj5Fg2anyEIm6Nagbvh0+N6grkXTvlHg44KaQQIBmSsc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q0pmbE82WXVuNVFJSWN0YXl0QXFrcnpvZXFwazZTWXVZLzhsVjJRUVdxRlpK?=
 =?utf-8?B?aTV6RzFBcnlwSUxENXFKTVVZUTB4T3VmcVhDOGwvZFMwS3RZaDdIWlFENERx?=
 =?utf-8?B?eWVURnFQa2o4SGR0eFpHNkZsdDlvbXFQYnR3d0orUmRZUGkxb2tSSk1Dck0w?=
 =?utf-8?B?TnZZeDR6amNwVHZUYkNZd281cEVvajNoUFR3SVBHY3JnUWRYbDFndE8zV0xi?=
 =?utf-8?B?QjZvVll4WmdrVzViaHRWck11d2g2MHRZRVQ0dk4zYXkzYVljMGhkS3JZZTh6?=
 =?utf-8?B?TEVVS1NlaW8xeVo1a3g2eTcwdkFEbk0rNldtRi9RczYxd2pwUG42RFZpTmZ0?=
 =?utf-8?B?VkZBSjhPZHVlMWpGVG00ajBySmRERkJOaE4yb2VQSUJPRWp3R0VpclJXdC82?=
 =?utf-8?B?QkNzcU1EcEwvZE5kQjlEcmc3c0EwVUxpL2FhanBXclRJWktvZ04vM3crR2d5?=
 =?utf-8?B?VUVYSFh0UUgyOVFUV0ZUeWNrVVlITEVlbzFMNGErcHNzQ0lDYnp2RVN0S1lz?=
 =?utf-8?B?TWYwbURLZHBJTW04ZmNPUVUrenZheXR6elB0MGk2RG42cTRrU0lsbVVXc25x?=
 =?utf-8?B?YkFaeEk5NE5IdERySFEyWXV6aTd6UXR5djNsUDJIYXdUdkR1Y2t6TnZjUVZD?=
 =?utf-8?B?Skhya1JxRE5zbldaUlBxK0s5aUVQc3ZEQ01xZHJrTjJwNUc2NzcwN0ZrL2lw?=
 =?utf-8?B?eUNQNk9ITjllb2xoRTVXWlBTTVJ5dEJYRk5IMmIwTzRiWGh4dW05Rzl3Vllt?=
 =?utf-8?B?UExIOXp5MndUYVRTemtZT3ptRnA2OGFSQ2JRL3N5YTNUSmUvQVdSb1IxZVJa?=
 =?utf-8?B?WWQ2RlJndG44OVBCM0w2MFVDMzJ4WjhlVEZUeXRqekJyeEFkbEl4WWo1bG8y?=
 =?utf-8?B?eHU0cHNEbnhETHY1Y0FDeG8yc2Nid0FTS2NCSnZsUEtsK1JtK0hlWnhid0U5?=
 =?utf-8?B?bXk1ZzhvTFRIMGYyWk4zOXBGcjdyM2ZrMXJhN1BmODVUNjVTQlFOTHlHQVpT?=
 =?utf-8?B?TG9YZlRsV0tIYjFCWWN1SFdTaVVsQkgxSFZuMWpZV0ZHY2E5Z05VczF2WFdT?=
 =?utf-8?B?U0VqWFhFVHFrRGhGSm9pdi8wN0tiZG54T0hRZ3c3QTUvSzZxWlFJWkt0V1BL?=
 =?utf-8?B?bE5DSzZhaWhtbGVObDNHd1IyOVJrdjRhcXlqd1NFbWlWa0I5R3FrYTErTTBT?=
 =?utf-8?B?UE40MHFVL0hUNm1QQksrNnpNa0JJa0s4ZWVFMnJCZXZFM1lYMlNDYXlncVdZ?=
 =?utf-8?B?Mmt3cllRbEVKQ3RoQ1dacWhBLzNKcGw4SFFjelJrRWN1YysvenRnbXlPQ29F?=
 =?utf-8?B?d1FNZmtEMG16TnRCNjkyMC9GSzE2TklzeUExa1J5cFNsWGN6Ti9RcXU4bi9B?=
 =?utf-8?B?UnR5aGZpbHZkTnhORWZZaFhDRXhaVmZBQmNQZVJIYXp3UVNKRjQ4WndrcXRi?=
 =?utf-8?B?a2k3amc3Lzcra0tvaTlWa2pzNXNaK0IycldYUmlmZm8rZDJDVEdjK2NPSUpD?=
 =?utf-8?B?bjBodmp5UzFZVmdWemlFNkRGelh2Tk8wK3ZRVENsOFRMaFZ3T2NFRDNIQ29o?=
 =?utf-8?B?SDV1UDZMRWlCT28vaGNmN085bjFIb2VJYWRWaVQxVnZOUmdYUnhXblNFbkpB?=
 =?utf-8?B?ODJDd253SVJ1dXB6NDJSLy9wMzdEQWEvWW0ybEoxekZra2ZYYW1PaDFhSzI0?=
 =?utf-8?B?Nnc2LzZyNnNXcERZQlJoWStCRTArdXd1S1NTcUI0SGZmSVZJUUVUTUhmZStK?=
 =?utf-8?B?aW82dlk4c3ZUbGlWaWVFS3Rvc05JYkVpMCs5ZGh4Vm9XR2RWcjl1RVdpcjB2?=
 =?utf-8?B?RDg4TEZhd01iS1dTVHg2UCszRnZmT24vYUtuYVZaSFVJd0lrallsOHQwRlRO?=
 =?utf-8?B?YlFONVR3eUJ3a3FnYjhPMHg2ajMyOWpFUlhEdytqVjBuOU9MWXl6REpRczZv?=
 =?utf-8?B?S1JqbExVUjNNd1NuNXNEWmI3TEFYMWl4emFER0NCcW5zQS8vVXljK3pablBs?=
 =?utf-8?B?dHkxSncwUVNwcHpLUFllcUwzMVNqcFlBUkZ6OWdZVkxldHhMZ1c4Y1lBWmgx?=
 =?utf-8?B?eXFPTVpkaXZEV01iOXNCTTB2S1VzRThnbGVHUzUrRXdURmJSSUFTRWRucEhu?=
 =?utf-8?Q?DutJ3x/Z6BesWuUhVerbPeXcu?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <312F31C820A7DF489F5A2ECFEE46AF9B@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e066b01a-9aeb-4ae5-d8b0-08dc433ca68a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 09:04:55.0652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPeci479ny+WpJ9ieKVInJoQIPlSGGZwKGwqjCDGWVjYFq8j6eFpn1MBdXKoY0qls5Bdsvw1jdeYhIZuksQ89JqGUZ0jvZVKACNOe4vpnSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB2527

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
Cj4gQWRkIGEgVEhQIGltcGxlbWVudGF0aW9ucyBvZiB0aGUgdm1fZmxhZ3MgdmFyaWFudCBvZiBn
ZXRfdW5tYXBwZWRfYXJlYSgpLg0KPiBGdXR1cmUgY2hhbmdlcyB3aWxsIGNhbGwgdGhpcyBmcm9t
IG1tYXAuYyBpbiB0aGUgZG9fbW1hcCgpIHBhdGggdG8gYWxsb3cNCj4gc2hhZG93IHN0YWNrcyB0
byBiZSBwbGFjZWQgd2l0aCBjb25zaWRlcmF0aW9uIHRha2VuIGZvciB0aGUgc3RhcnQgZ3VhcmQN
Cj4gZ2FwLiBTaGFkb3cgc3RhY2sgbWVtb3J5IGlzIGFsd2F5cyBwcml2YXRlIGFuZCBhbm9ueW1v
dXMgYW5kIHNvIHNwZWNpYWwNCj4gZ3VhcmQgZ2FwIGxvZ2ljIGlzIG5vdCBuZWVkZWQgaW4gYSBs
b3Qgb2YgY2FzZWlzLCBidXQgaXQgY2FuIGJlIG1hcHBlZCBieQ0KPiBUSFAsIHNvIG5lZWRzIHRv
IGJlIGhhbmRsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5w
LmVkZ2Vjb21iZUBpbnRlbC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxj
aHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+DQoNCj4gLS0tDQo+ICAgaW5jbHVkZS9saW51eC9o
dWdlX21tLmggfCAxMSArKysrKysrKysrKw0KPiAgIG1tL2h1Z2VfbWVtb3J5LmMgICAgICAgIHwg
MjMgKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gICBtbS9tbWFwLmMgICAgICAgICAgICAgICB8
IDEyICsrKysrKystLS0tLQ0KPiAgIDMgZmlsZXMgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKSwg
MTIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9odWdlX21t
LmggYi9pbmNsdWRlL2xpbnV4L2h1Z2VfbW0uaA0KPiBpbmRleCA1YWRiODZhZjM1ZmMuLjg3NDRj
ODA4ZDM4MCAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9odWdlX21tLmgNCj4gKysrIGIv
aW5jbHVkZS9saW51eC9odWdlX21tLmgNCj4gQEAgLTI2Miw2ICsyNjIsOSBAQCB1bnNpZ25lZCBs
b25nIHRocF92bWFfYWxsb3dhYmxlX29yZGVycyhzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSwN
Cj4gICANCj4gICB1bnNpZ25lZCBsb25nIHRocF9nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmls
ZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgIAkJdW5zaWduZWQgbG9uZyBsZW4sIHVu
c2lnbmVkIGxvbmcgcGdvZmYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MpOw0KPiArdW5zaWduZWQgbG9u
ZyB0aHBfZ2V0X3VubWFwcGVkX2FyZWFfdm1mbGFncyhzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWdu
ZWQgbG9uZyBhZGRyLA0KPiArCQl1bnNpZ25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZ29m
ZiwgdW5zaWduZWQgbG9uZyBmbGFncywNCj4gKwkJdm1fZmxhZ3NfdCB2bV9mbGFncyk7DQo+ICAg
DQo+ICAgdm9pZCBmb2xpb19wcmVwX2xhcmdlX3JtYXBwYWJsZShzdHJ1Y3QgZm9saW8gKmZvbGlv
KTsNCj4gICBib29sIGNhbl9zcGxpdF9mb2xpbyhzdHJ1Y3QgZm9saW8gKmZvbGlvLCBpbnQgKnBl
eHRyYV9waW5zKTsNCj4gQEAgLTQxNiw2ICs0MTksMTQgQEAgc3RhdGljIGlubGluZSB2b2lkIGZv
bGlvX3ByZXBfbGFyZ2Vfcm1hcHBhYmxlKHN0cnVjdCBmb2xpbyAqZm9saW8pIHt9DQo+ICAgDQo+
ICAgI2RlZmluZSB0aHBfZ2V0X3VubWFwcGVkX2FyZWEJTlVMTA0KPiAgIA0KPiArc3RhdGljIGlu
bGluZSB1bnNpZ25lZCBsb25nDQo+ICt0aHBfZ2V0X3VubWFwcGVkX2FyZWFfdm1mbGFncyhzdHJ1
Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiArCQkJICAgICAgdW5zaWduZWQg
bG9uZyBsZW4sIHVuc2lnbmVkIGxvbmcgcGdvZmYsDQo+ICsJCQkgICAgICB1bnNpZ25lZCBsb25n
IGZsYWdzLCB2bV9mbGFnc190IHZtX2ZsYWdzKQ0KPiArew0KPiArCXJldHVybiAwOw0KPiArfQ0K
PiArDQo+ICAgc3RhdGljIGlubGluZSBib29sDQo+ICAgY2FuX3NwbGl0X2ZvbGlvKHN0cnVjdCBm
b2xpbyAqZm9saW8sIGludCAqcGV4dHJhX3BpbnMpDQo+ICAgew0KPiBkaWZmIC0tZ2l0IGEvbW0v
aHVnZV9tZW1vcnkuYyBiL21tL2h1Z2VfbWVtb3J5LmMNCj4gaW5kZXggYmMzYmY0NDFlNzY4Li4z
NDljOTNhMWE3YzMgMTAwNjQ0DQo+IC0tLSBhL21tL2h1Z2VfbWVtb3J5LmMNCj4gKysrIGIvbW0v
aHVnZV9tZW1vcnkuYw0KPiBAQCAtODA2LDcgKzgwNiw4IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBp
c190cmFuc3BhcmVudF9odWdlcGFnZShzdHJ1Y3QgZm9saW8gKmZvbGlvKQ0KPiAgIA0KPiAgIHN0
YXRpYyB1bnNpZ25lZCBsb25nIF9fdGhwX2dldF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpm
aWxwLA0KPiAgIAkJdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGxlbiwNCj4gLQkJ
bG9mZl90IG9mZiwgdW5zaWduZWQgbG9uZyBmbGFncywgdW5zaWduZWQgbG9uZyBzaXplKQ0KPiAr
CQlsb2ZmX3Qgb2ZmLCB1bnNpZ25lZCBsb25nIGZsYWdzLCB1bnNpZ25lZCBsb25nIHNpemUsDQo+
ICsJCXZtX2ZsYWdzX3Qgdm1fZmxhZ3MpDQo+ICAgew0KPiAgIAlsb2ZmX3Qgb2ZmX2VuZCA9IG9m
ZiArIGxlbjsNCj4gICAJbG9mZl90IG9mZl9hbGlnbiA9IHJvdW5kX3VwKG9mZiwgc2l6ZSk7DQo+
IEBAIC04MjIsOCArODIzLDggQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgX190aHBfZ2V0X3VubWFw
cGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbHAsDQo+ICAgCWlmIChsZW5fcGFkIDwgbGVuIHx8IChv
ZmYgKyBsZW5fcGFkKSA8IG9mZikNCj4gICAJCXJldHVybiAwOw0KPiAgIA0KPiAtCXJldCA9IG1t
X2dldF91bm1hcHBlZF9hcmVhKGN1cnJlbnQtPm1tLCBmaWxwLCBhZGRyLCBsZW5fcGFkLA0KPiAt
CQkJCSAgIG9mZiA+PiBQQUdFX1NISUZULCBmbGFncyk7DQo+ICsJcmV0ID0gbW1fZ2V0X3VubWFw
cGVkX2FyZWFfdm1mbGFncyhjdXJyZW50LT5tbSwgZmlscCwgYWRkciwgbGVuX3BhZCwNCj4gKwkJ
CQkJICAgb2ZmID4+IFBBR0VfU0hJRlQsIGZsYWdzLCB2bV9mbGFncyk7DQo+ICAgDQo+ICAgCS8q
DQo+ICAgCSAqIFRoZSBmYWlsdXJlIG1pZ2h0IGJlIGR1ZSB0byBsZW5ndGggcGFkZGluZy4gVGhl
IGNhbGxlciB3aWxsIHJldHJ5DQo+IEBAIC04NDgsMTcgKzg0OSwyNSBAQCBzdGF0aWMgdW5zaWdu
ZWQgbG9uZyBfX3RocF9nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmlscCwNCj4gICAJ
cmV0dXJuIHJldDsNCj4gICB9DQo+ICAgDQo+IC11bnNpZ25lZCBsb25nIHRocF9nZXRfdW5tYXBw
ZWRfYXJlYShzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAtCQl1bnNp
Z25lZCBsb25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZ29mZiwgdW5zaWduZWQgbG9uZyBmbGFncykN
Cj4gK3Vuc2lnbmVkIGxvbmcgdGhwX2dldF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3Moc3RydWN0IGZp
bGUgKmZpbHAsIHVuc2lnbmVkIGxvbmcgYWRkciwNCj4gKwkJdW5zaWduZWQgbG9uZyBsZW4sIHVu
c2lnbmVkIGxvbmcgcGdvZmYsIHVuc2lnbmVkIGxvbmcgZmxhZ3MsDQo+ICsJCXZtX2ZsYWdzX3Qg
dm1fZmxhZ3MpDQo+ICAgew0KPiAgIAl1bnNpZ25lZCBsb25nIHJldDsNCj4gICAJbG9mZl90IG9m
ZiA9IChsb2ZmX3QpcGdvZmYgPDwgUEFHRV9TSElGVDsNCj4gICANCj4gLQlyZXQgPSBfX3RocF9n
ZXRfdW5tYXBwZWRfYXJlYShmaWxwLCBhZGRyLCBsZW4sIG9mZiwgZmxhZ3MsIFBNRF9TSVpFKTsN
Cj4gKwlyZXQgPSBfX3RocF9nZXRfdW5tYXBwZWRfYXJlYShmaWxwLCBhZGRyLCBsZW4sIG9mZiwg
ZmxhZ3MsIFBNRF9TSVpFLCB2bV9mbGFncyk7DQo+ICAgCWlmIChyZXQpDQo+ICAgCQlyZXR1cm4g
cmV0Ow0KPiAgIA0KPiAtCXJldHVybiBtbV9nZXRfdW5tYXBwZWRfYXJlYShjdXJyZW50LT5tbSwg
ZmlscCwgYWRkciwgbGVuLCBwZ29mZiwgZmxhZ3MpOw0KPiArCXJldHVybiBtbV9nZXRfdW5tYXBw
ZWRfYXJlYV92bWZsYWdzKGN1cnJlbnQtPm1tLCBmaWxwLCBhZGRyLCBsZW4sIHBnb2ZmLCBmbGFn
cywNCj4gKwkJCQkJICAgIHZtX2ZsYWdzKTsNCj4gK30NCj4gKw0KPiArdW5zaWduZWQgbG9uZyB0
aHBfZ2V0X3VubWFwcGVkX2FyZWEoc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGxvbmcgYWRk
ciwNCj4gKwkJdW5zaWduZWQgbG9uZyBsZW4sIHVuc2lnbmVkIGxvbmcgcGdvZmYsIHVuc2lnbmVk
IGxvbmcgZmxhZ3MpDQo+ICt7DQo+ICsJcmV0dXJuIHRocF9nZXRfdW5tYXBwZWRfYXJlYV92bWZs
YWdzKGZpbHAsIGFkZHIsIGxlbiwgcGdvZmYsIGZsYWdzLCAwKTsNCj4gICB9DQo+ICAgRVhQT1JU
X1NZTUJPTF9HUEwodGhwX2dldF91bm1hcHBlZF9hcmVhKTsNCj4gICANCj4gZGlmZiAtLWdpdCBh
L21tL21tYXAuYyBiL21tL21tYXAuYw0KPiBpbmRleCBhMzEyOGVkMjY2NzYuLjY4MzgxYjkwZjkw
NiAxMDA2NDQNCj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBiL21tL21tYXAuYw0KPiBAQCAtMTg2
MywyMCArMTg2MywyMiBAQCBfX2dldF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpmaWxlLCB1
bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0KPiAgIAkJICogc28gdXNlIHNo
bWVtJ3MgZ2V0X3VubWFwcGVkX2FyZWEgaW4gY2FzZSBpdCBjYW4gYmUgaHVnZS4NCj4gICAJCSAq
Lw0KPiAgIAkJZ2V0X2FyZWEgPSBzaG1lbV9nZXRfdW5tYXBwZWRfYXJlYTsNCj4gLQl9IGVsc2Ug
aWYgKElTX0VOQUJMRUQoQ09ORklHX1RSQU5TUEFSRU5UX0hVR0VQQUdFKSkgew0KPiAtCQkvKiBF
bnN1cmVzIHRoYXQgbGFyZ2VyIGFub255bW91cyBtYXBwaW5ncyBhcmUgVEhQIGFsaWduZWQuICov
DQo+IC0JCWdldF9hcmVhID0gdGhwX2dldF91bm1hcHBlZF9hcmVhOw0KPiAgIAl9DQo+ICAgDQo+
ICAgCS8qIEFsd2F5cyB0cmVhdCBwZ29mZiBhcyB6ZXJvIGZvciBhbm9ueW1vdXMgbWVtb3J5LiAq
Lw0KPiAgIAlpZiAoIWZpbGUpDQo+ICAgCQlwZ29mZiA9IDA7DQo+ICAgDQo+IC0JaWYgKGdldF9h
cmVhKQ0KPiArCWlmIChnZXRfYXJlYSkgew0KPiAgIAkJYWRkciA9IGdldF9hcmVhKGZpbGUsIGFk
ZHIsIGxlbiwgcGdvZmYsIGZsYWdzKTsNCj4gLQllbHNlDQo+ICsJfSBlbHNlIGlmIChJU19FTkFC
TEVEKENPTkZJR19UUkFOU1BBUkVOVF9IVUdFUEFHRSkpIHsNCj4gKwkJLyogRW5zdXJlcyB0aGF0
IGxhcmdlciBhbm9ueW1vdXMgbWFwcGluZ3MgYXJlIFRIUCBhbGlnbmVkLiAqLw0KPiArCQlhZGRy
ID0gdGhwX2dldF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3MoZmlsZSwgYWRkciwgbGVuLA0KPiArCQkJ
CQkJICAgICBwZ29mZiwgZmxhZ3MsIHZtX2ZsYWdzKTsNCj4gKwl9IGVsc2Ugew0KPiAgIAkJYWRk
ciA9IG1tX2dldF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3MoY3VycmVudC0+bW0sIGZpbGUsIGFkZHIs
IGxlbiwNCj4gICAJCQkJCQkgICAgcGdvZmYsIGZsYWdzLCB2bV9mbGFncyk7DQo+ICsJfQ0KPiAg
IAlpZiAoSVNfRVJSX1ZBTFVFKGFkZHIpKQ0KPiAgIAkJcmV0dXJuIGFkZHI7DQo+ICAgDQo=

