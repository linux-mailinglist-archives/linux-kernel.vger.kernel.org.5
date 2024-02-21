Return-Path: <linux-kernel+bounces-75152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A39285E3E2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EA2B1F2460D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7A0839F4;
	Wed, 21 Feb 2024 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kFrWEkzq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E7B82D9F
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 17:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534803; cv=fail; b=B4zRPTyejiK8pkc0yiXv8z+ZrIsNOzkvo6HX8JTNO7/jeRMVTOjPLXbY3OOCyEIWNsvUtxJ5qIvZeZ546bvu0ULgmDIEGAS70qC+MbED1sskUJ4yFLPJeUKb1BF75TJYH2+lOuPmQpjlSViNpAQu1Ucw5hv4mDSR6F9Fe41t3/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534803; c=relaxed/simple;
	bh=7uLRnIv+FatdTUciFP+Iilsm4yZrxDB5UFM3BsHS6Js=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tgsvoNx5jS5MgWtgTOjYeMCBxaI+wOHuFS/cEwiqxhTgfeO6vS8FLIA5anJRHgjUYFW1h+Bk7Ej85u7gCsJpCoIBQkaoqjQ2Kb9aJSr1KimZlPOhwPBrbG5EPKJWa+PZB6Md45Ha4JzRjkHS7oxv+D7IAUaHWOuuk8JS8DOFEYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kFrWEkzq; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708534802; x=1740070802;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7uLRnIv+FatdTUciFP+Iilsm4yZrxDB5UFM3BsHS6Js=;
  b=kFrWEkzqGdqY2jGPsPQ/7P+gZSJacaOCzm+OETIbaaC3JRmSSiByRFVT
   ASjQxuMTJ2qqxaxocWhuWIA6mHYtMqnaNmk6ncKbPd6W0TmfCLLBSVMuY
   m6DuuROdtem4Mv9H+mF1VYZIQzxSKu6BxspEmIt7sHw0kwsrh8+KxxnTr
   S14oKDPYfNfCbuEKzurkk+dtARiapz3yn6yRoBFytcESh3mCe3U1Gy8P6
   USVXVcwwo+QetJ5H0pplNlvnPZ/qx+vorhlKF7UDZqjWgnKmHYtB7ujVZ
   26y85/f+XdMs28Zd9wNrxQ6xM8pRsQVNVEJfXV/kn671gvYv2pFszliNT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2853427"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="2853427"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:59:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="42666570"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 08:59:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 08:59:53 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 08:59:53 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 08:59:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMVuGpnJ4Voo7oYR0TOJMy6S+EYiZj+nmVNMKNFNV0OpDQnlKi9zCM1nrqeX2XpnNcgkBnLm3sWBxUEp/aDD/xds7LFshczasfeWBxKznjeuJ0hp2uIoRX0snq7plFwvv8iGO1/hF9aJ9ni9F3PPkgcysiLP758q7Rm85OGCZZfq2N+X/0GfoVwaY6hwboQDjqgEw0C7yrOPb1g1fKxgMFzFKF6Zx/6WC9BKNpPYUNg9ptJ05I1BqdKrC/JyqmAnqTRrKk6UgO5VHGV4tdnlteavtnEQ7NLiHNzZiZQlE/fHLzkjLf3kxoLHZxY/QT5WOpOvxlP2j+RLM7NKvZ5AmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uLRnIv+FatdTUciFP+Iilsm4yZrxDB5UFM3BsHS6Js=;
 b=DCKhTfm0C1mdpbC2kx+KWNHcfQ3iRJr1V20TXxz7k3B4np6XIaSvRXwrFfSUp3yJAeqlPW/s3wbVC1r5m9ogG4CAI2PAnRm30YbkCi0+fIoFxDFhztRh0rpQunhjU1fcducCILbwnywxw56uD/AmEROjlqPNra1G5HmLIO9SWGdSPFqdqLS8lbiq6VpS9aaKS9FQIoK3fUhc6jfZOTrVeM6y1v1BnEbghtPSh/LGhFHFx7Bmabo19ApkjWHeLpb3MiD0vLrCh3fj1nCG1v55JBME58lIzhtiaeyAPi8+xJY0/vWu9yLuLSUcDJvpVr/10eX8gCxbeFZe4qDvGsrL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by CH3PR11MB8188.namprd11.prod.outlook.com (2603:10b6:610:15e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Wed, 21 Feb
 2024 16:59:51 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5d40:83fd:94ac:d409%7]) with mapi id 15.20.7316.018; Wed, 21 Feb 2024
 16:59:51 +0000
From: "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To: "rppt@kernel.org" <rppt@kernel.org>
CC: "keescook@chromium.org" <keescook@chromium.org>, "luto@kernel.org"
	<luto@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Thread-Topic: [RFC PATCH 1/8] mm: Switch mm->get_unmapped_area() to a flag
Thread-Index: AQHaYGTEKf96GFhAWkioh52NHqqmQ7EUaTAAgACkyQA=
Date: Wed, 21 Feb 2024 16:59:51 +0000
Message-ID: <fe2236eb709bad3ebe4b9f837746b75ce0c34738.camel@intel.com>
References: <20240215231332.1556787-1-rick.p.edgecombe@intel.com>
	 <20240215231332.1556787-2-rick.p.edgecombe@intel.com>
	 <ZdWhylSaUwZkdDFb@kernel.org>
In-Reply-To: <ZdWhylSaUwZkdDFb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|CH3PR11MB8188:EE_
x-ms-office365-filtering-correlation-id: 5a6db875-fbc7-4094-eea0-08dc32fe852a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZMjqPFQ26GS/sxH1pGTJJ1Kr2SB02TDeGESogJ4AvMjsaxPeZGjhENoXu76RBWqHJPTRyj5Pk07GQXTL5lVoA/tK77rYfF3NEbErO3DYgHeHFNt9Ih6S/2HsGO/7WdU+CAott5ZFqsOIJ+CP0HFXU6riDSeodRbWxop0WakUiSrjBB1DweLT7ar31h87aZx/is3BLPkQuaM6e7oR9Ej5b0UDD3iZJxu9Z0k0KgXYQ0qoR6TDbPejAxl1R5t9WtK3UAR4BzNIGM7SBMqo6JQMFc0nTHyC4Z4/Q+G9RqyffFeqs70CsEOl5ti4911s7Hr+zwBXk9XEoUoVBwJqq5MhGxqmj3SOdZeLOcXX1oQiSYTwtfAqaZw3K+bsu9dDVIRDJZPaXRtmz2++21OKfItEvMrfVK5pVLYiQL3Rqa253iVnJDAuq302Xwup5WP31fCU6BawBo5F0N3jr3NSadUUjs7eLwBs9miHYxFcEb4ZtNcl3npjsz6egJOR3/MWIqZ9jdqSrzg4+/I6SDDWv2v7gPXF34ALpuuBrLnBlG8XBcTXyZAZr5rdz0D9RGQJObhLNQWLADkBoV+oTQwyAL2fv8BgRYGApAgYc5I1oKZMKfsrf0KaOruGXIP4Qz20rblD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWUvWDdMU0kyVlRJZk5MQWdGMktmQ00xZks5QUpTMCtpNS9lM3JPRUgyTGhj?=
 =?utf-8?B?bkNtQWM4MkQ0cmQ1T2h1NzN2c25WZ0dGM3ZRa3JjeHkzWllLVHFpeDZmaGFR?=
 =?utf-8?B?VjIrZEhEajFzUlhOQU9mUU1wQUNKR3NYSk9GOCtSRzk2RHV2QmFsaDdRQTZp?=
 =?utf-8?B?YnIwTjkyckIzRWVHRVAzeGZsN1VyRVFQVUsweWtEdC9sMFFWUWFsalFlQ21T?=
 =?utf-8?B?cE56Um1ObjRJVGVvTkVERyt6bHJoTENmYURWNVEyVWNkMllRNzg5bU1FVHAr?=
 =?utf-8?B?dnkzUi9rL05XOFJSYzF6MnVmYjB2R0NMaWNZVktRbnhCNHFXUmFDU0xPL0xm?=
 =?utf-8?B?T1lYcElZa3A5T2ZNZ2J0bFdacDYzL1F3SytHaTlmZzUwYUo5SndlbGtJVGRj?=
 =?utf-8?B?VldxS1lyZmFGS1dyaDRKN0tHNk5IRDdZNHdaUXltZzM5Y2pYcC9YbFRwbjJQ?=
 =?utf-8?B?VGc3TS84TjhxUzQ0cU51dW4xTXlJbitBSThqZ3ZtRmI4MkV2bS9mTmVtcjJB?=
 =?utf-8?B?K0xGQmlVOTZjTnlPWEFPbnB2aXhnWHRaYW9hbVc5VXBzZFRWN3F1bEExYVAv?=
 =?utf-8?B?MmUxTzdGUE1PSDAwS2tvQ2JPOHh4WDBGNGQ2V3poalcwUUF6d0h3V0wrcE43?=
 =?utf-8?B?WGhiSXh1a2N0M01SNnhVUmtNNWR6Ylc1ZjVIVHJQSEVBbVBBaU1kZWpaS09J?=
 =?utf-8?B?Zm94ZiszQXIrNlY4dkZ5aXFoRGRhSWR4ZjE3ZENPVFFiMmprMzIyMzhVd1RU?=
 =?utf-8?B?YTEzTG5BcFhsV0hTeFpnS0NmcnJyeXpQc08vcktac29RK1lFeTR4V0FRSm00?=
 =?utf-8?B?aGNSWjhJMU5aM0MrckhGV3BNUmlyR0pHK1ZEallMd3F5UFFmeEV5K3ZJcEZj?=
 =?utf-8?B?QmE1MWFZNTcwcjN1N0xFbkJjU0hQNlNEUGFkVXNHTEZOZFV4ZXV5eUdkWjNQ?=
 =?utf-8?B?RTY0VEhaSGg4Z3NOcTltYzNyT1h2TFYrVnp4WDRPR1NIQ0ZRUmh2YlpacTlF?=
 =?utf-8?B?aG5PenAxeHB6cFdXOFZpbDJOV1h3TTNCWDczemNWRE5KVkVNL2tqL3hSNTJB?=
 =?utf-8?B?d3hYYkQ3R1JUT2tDZHJHMk8yR2h2cEszdm5kdVh0UW1BZkZ5cGpiLytOK3cx?=
 =?utf-8?B?NkR5Zy9QR2JJQ0dsY1JCQk1VYkRkMWYxaDFaSWh6ZjIwbzEvNklyMzlDb2lo?=
 =?utf-8?B?dkpvRThPWHFjQ2ljcExyem5MSHVXUndndTBBWlNKU1BnZ0hlRDBqMkQrUkpk?=
 =?utf-8?B?Q2VJQ1FUZWprbzUxektBcUpkaUorY09PZEUvY0dGZFBQUEN0a1g5VzQ5d1g3?=
 =?utf-8?B?a256ZDVRRU5tRDlhcGlERVlKbTNqRG9pdjBRVk9Ud1BUUDJuNEdPZUhybm90?=
 =?utf-8?B?Nm1tcEVBZ0wzLzI0V2lXY0RLNW9rTkx6MEdMNGVLelh2aUI5RGd4WWRPMi9B?=
 =?utf-8?B?ZGVycEljbE5aRXlFVGxVS2JVUTMzVmNyMHN5OVltZ3doc290TENFY00vZ1BY?=
 =?utf-8?B?bnVQb1RjcDVzb0dnTVF3aXUrRWJJZjhITm9Fc2pkNDRCcllPZW1HdWhOU2xO?=
 =?utf-8?B?OExvMDhScm5SOXhlaS9tRGEvWkIrSXVrdGpYVThwYWtVZXNwT0RLWHZqeUJP?=
 =?utf-8?B?b2ZmZ0RYRVlBREM1aUJmem1YZE5PbE1zUGplMGNNT0RncU1xNWdLZ3BCajE4?=
 =?utf-8?B?dVVpRmlGSHowa0xXVUp0OGtDUHlUaEs4VWpxUHdwcmxVTHpmSVlPQmZlN1hR?=
 =?utf-8?B?RHM4L3BCK2ZQSlhWeWtUMXc2aVB6Z2pmc0REUVRhREl0cks5QUJHWnBKejBG?=
 =?utf-8?B?dUR2R21Ld0VLZ0g2NFRWS3kxR1BRSjR2eWV0Ums0MVZNczYveXkwNTNvVkta?=
 =?utf-8?B?eFJSb3JrZTRZU2dqY0R5cEpqb1dhSysrMVJxRU1TbVZORGphUzAwcWRIM2VR?=
 =?utf-8?B?c0lVUDlCdisrYlgvV0w4Y1B0R0pFYnYweE04Wm81ZFFlNHpQZDJFWFl6S3BS?=
 =?utf-8?B?NXdPcUtIKzB0ZTBpRllvenNuR1hqQW0zRVRZTzRublA3S1VuSVVqM3hmTVRM?=
 =?utf-8?B?ZFdtSmxSSzJjNTNwYStPSzZ2SW1JdS9ESEQwc0VmUFZWQWE2WG91bHZVR2Rs?=
 =?utf-8?B?dXJaWGpMbWFqMk5xMW5wa09XTzhVeFdNWk9ESHEwY1FjUk1ycFRESGZDVHNX?=
 =?utf-8?Q?ib+nIB7x/lM2egD4pz/Iuh4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25558A0A2E8E5041B66934013F69A1BF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a6db875-fbc7-4094-eea0-08dc32fe852a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 16:59:51.6473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OAflifL3CnKGOX3gLlkPKZP+BBy98NJwugye1IwMZmv+46LZKjY43IvZNx8QMqdrCBwofl8g0O0eayyRnpk9R8jXAUC78drcudltFLjFBP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8188
X-OriginatorOrg: intel.com

T24gV2VkLCAyMDI0LTAyLTIxIGF0IDA5OjEwICswMjAwLCBNaWtlIFJhcG9wb3J0IHdyb3RlOgo+
ID4gwqAgI2RlZmluZSBNTUZfTVVMVElQUk9DRVNTwqDCoMKgwqDCoMKgMjbCoMKgwqDCoMKgwqAv
KiBtbSBpcyBzaGFyZWQgYmV0d2Vlbgo+ID4gcHJvY2Vzc2VzICovCj4gPiArI2RlZmluZSBNTUZf
VE9QRE9XTsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoDI3wqDCoMKgwqDCoMKgLyogbW0gaXMgc2hh
cmVkIGJldHdlZW4KPiA+IHByb2Nlc3NlcyAqLwo+IAo+IE5pdDogeW91IG1heSB3YW50IHRvIHVw
ZGF0ZSB0aGUgY29tbWVudCBoZXJlIDstKQoKWWVwLCB0aGFua3MuCg==

