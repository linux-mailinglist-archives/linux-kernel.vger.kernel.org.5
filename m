Return-Path: <linux-kernel+bounces-19056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F052826755
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 04:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9506A1F215C2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 03:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C936D8F59;
	Mon,  8 Jan 2024 03:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X/akvWL6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 848B08F54
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 03:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704683079; x=1736219079;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vfi6p3l2hPvrsKn6u3wp4uxBxGCZfWf0ElucQpI+cmY=;
  b=X/akvWL66LGrLhkNivqnFN0GPAzlBYahIxouFBOwt8c8vx4xdjCaokaY
   KJdOZVV+dVoAWxJP+/V4RjbxQKoGQnfihCAoXZaPhkGT4b8GDyJbJq4Q6
   X+qUSFHMtnMzMjc5p37nM4LLKizdNWBsgYNL+s5TVQPSfLfomtLVhkC9z
   d9a2yoqfMLZFVDMjJ6ZMHZOODHC9BB/lyugxl+UP0fIkB4fgswLbYUJ4L
   FscMbM0ZBlm1tml1cMLuxUnBSGsBIlmtT2Y0H3C2PFbYkA/0b4P5ZbwOx
   HJXjWbU5mEYvk4HZ4B0V6Pb7bgv19UkavrFXrtFDl+aEBmhMN11tzmwMs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="464183337"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="464183337"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2024 19:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10946"; a="954509346"
X-IronPort-AV: E=Sophos;i="6.04,340,1695711600"; 
   d="scan'208";a="954509346"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Jan 2024 19:04:34 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:33 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Jan 2024 19:04:33 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 7 Jan 2024 19:04:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ilgevlVZuckEESHWjjI3eRhkS1iulS2wEKIB8aN8UGtljHXvABWeo+QxTH7cXNE6bgPBzjwT0+F1ETnovlzwu5KkgUqrRLPRsOVf9qWt1kGGqSvqhjuD6nlExp+rxFYX9RhbNoy2ds71ZIbNH+IWD/ysXBEyu+iUZ334HWJDKu5e3i1MK9kJ/VnonN6qeNM8ghEPzhYJsT+kwYfcmTIFQqtFcoQHWa9bngJZ9Q85lL4ykmspon/gBNMvkuBSiooupC2Zu/VSwrzp1wVsIHRE2Fch57ZyaVnUlW+nrkLDxrQ95eA2R4Tb5Zx1bT2W8NgNFct0q5LqHr4fhtqi2bTpZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vfi6p3l2hPvrsKn6u3wp4uxBxGCZfWf0ElucQpI+cmY=;
 b=hCAbBVNusAfAYY9OjOc2x0ke5q8uABwQE+SDf/DaklJIiabpuCeLlrujFBofVaP6OuKM2uSuEBYxsUEmQNnJsLtzAXjn9Co0Khi95RD4VDGA9slHKUbmfzlgMJtqSVknYCob6GFXeeO+Kd0MH5cYezm6FgN1/eSLAfhhqUpp5lXuAhUOsNwdi1Ok0Pnow28y1F7M74EvKrZU46cE+nQyIootshTyAmMlp2cZxqJaTHNsYg1OaDk4Argmc4RB0ojLLIhw1NW546cb4eNd15a5YvHA7fXm56GfQHwe/fSZYK3peGJjb82ZuL2nsLlE8tZEGDhWrkFphkjhyBDtdPqI/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.21; Mon, 8 Jan
 2024 03:04:31 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ca1e:db:ee01:887%5]) with mapi id 15.20.7159.020; Mon, 8 Jan 2024
 03:04:31 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>
CC: "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"ashish.kalra@amd.com" <ashish.kalra@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "Hunter, Adrian" <adrian.hunter@intel.com>,
	"Reshetova, Elena" <elena.reshetova@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "bhe@redhat.com" <bhe@redhat.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "Nakajima, Jun" <jun.nakajima@intel.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "bp@alien8.de" <bp@alien8.de>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Topic: [PATCHv5.1 14/16] x86/smp: Add smp_ops.stop_this_cpu() callback
Thread-Index: AQHaNwlbb6SzZl77y0qzncigU+XbULDPULYA
Date: Mon, 8 Jan 2024 03:04:31 +0000
Message-ID: <d23475c878ce1bc899a6b9f613252e985d97d094.camel@intel.com>
References: <20231222235209.32143-15-kirill.shutemov@linux.intel.com>
	 <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231225080524.4240-1-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.2 (3.50.2-1.fc39) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|LV2PR11MB6048:EE_
x-ms-office365-filtering-correlation-id: 6f0171c0-66c7-44d8-c3a9-08dc0ff68939
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GhBcX31gujzJf1Se3KSYu/wI3mDPgmMJPn8WuogsKMxvfS7XSt7nwA2ctssKs3EW13VekBYzdP875baRYMqfk8FuSZdMeGmcMymB3dHCrv5tlSKP3/L8VA7T09TAcDM1N+xhbiQWDw9xTm+hZkbB75RWJeG0yypD8s/r5P0hrYpuD1MCUEi6hA/MfZ+DeDclZBlufTIKiEPXb2KWxJdyQ7IY0jTAExyqphDDNyI2yDmf30/cY8HFqCK7tvUaEwdQGShDE3fl7SI7B9NZL0PNvDbl67kXar4FwvM3B3baV3eqzbyZ8dwWmNfHGteMDRTWjyQgoExQEQswg5IUV3G7SppQcTARuZ3erECdbX9BldhuE755WPPTKAbwtbqa2G8ua4Ds9zPKi80X2eevC0YzEYAIblKetpW8+Pv9MNHRV4+/YQS/P7G+J6tvRDnCig12ksptqEUHQ60pPC/r1jP1JAVpwlp4dGq3VfZP/hFmk4weTO3XV884rCokM6il5V6NmMoxWLcgd7GJsozXSpbOiqaiRWuVwYCCLPvqPktSNTDkBp9h4j9JGnqG+t1ZQFMcx97cvAZ2rcoy9/Vv9baDXY+o3pcKyTxu25dYpzNnfF4eollElaMmUGKztb3GnnTD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(82960400001)(36756003)(8676002)(8936002)(54906003)(316002)(6916009)(5660300002)(4326008)(83380400001)(478600001)(6506007)(6512007)(71200400001)(26005)(38070700009)(91956017)(66946007)(66556008)(66476007)(66446008)(64756008)(76116006)(6486002)(2616005)(122000001)(41300700001)(38100700002)(4001150100001)(7416002)(2906002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eHFHR3VQdjFnN0FESU9Va0xaWmNwQVlyemt3ak9Kd1hwWDhZbjZSSjNYWjhj?=
 =?utf-8?B?SjQva0dNZG1hVzh0VVVCcjQ0eEh1TlpxcXhUOHdVaDFHZXhEY3R1eVVNMFU5?=
 =?utf-8?B?SmRBYUluU3J5c3ZRSFkrbXpIZ2VUemgvV0phTTZxSWhDNXZyZGZEcFN0eVBP?=
 =?utf-8?B?aTVYeG8vRk02Z0cybDVkTVhkMzI3dGxoYS9yV3Jnd2JpdS8wYTNXcnJCZzRr?=
 =?utf-8?B?bHQ1Kzl5djU1UzV6T1daZ01wNlQyQ3BMSWRQV1M2MWhlc0dZcHNobS82SG43?=
 =?utf-8?B?eUFVTVpObEJsU1VsM21KOFNhYnpDdmNBZVVwbnhTQ1ZpeWZEaUVKM3JHc0NU?=
 =?utf-8?B?K29zTlNHY1YwNVV4UVdSUlBhaG0wVE5YdFlodjVOSUljcnRZbXdNaENqVVN3?=
 =?utf-8?B?RTRwTjMwdDhxSU9Ba0ExTXpILytPZktITVovd3YxbG1MRHUxVk1ZSjZNQjVL?=
 =?utf-8?B?OGJvN1NjZ3JEbEY0VG11Zm1obU5LQU5aOGFPRGZIeXdtWTlMak5MNXR3K0lC?=
 =?utf-8?B?NFVreStUQTlTc253eklWR0NYSlhLUEtVc081alRUQjV6cUEvWU1ZRS9mcUVq?=
 =?utf-8?B?U2hEYUxzdnpjWTcxV25Fb2ZBSUxDTmMyQXdHa3h4cVhWakVlTEVadkdSbGIy?=
 =?utf-8?B?S1A4TG52cUNSZFU3bWxmNG44Z3YrU0s2WkkyM0NtZG0zOVFvMW1ma1hOL1hF?=
 =?utf-8?B?Ukxib3RaZjBibElRTy9uQ29PcEdoQzd1MVpralVSS25kUHNaTEZWR2dLaTRo?=
 =?utf-8?B?Y3BQbk11b3JzZTdnczB6Q1NsbzdBeE9yNGhSbW1tNjFxLzl0c1ZuckRZQ3ZU?=
 =?utf-8?B?QVV0aEdaL0FneE5SbEdkS2M0UEJEWlhLS0RQUjNESmpUZTJVVTUyQ0MwVjZJ?=
 =?utf-8?B?c3dRT2xhSmJaSVYyTnhIcUtLMHR1Vkw2YjQvY3dNenN2ZVZOMU9xRHZpN2tM?=
 =?utf-8?B?NXlNQXlubTdDL01XSHUzTjVuUldGZGszSXpjR0tVVk1ISFdpL2VxZlhtQnlr?=
 =?utf-8?B?RXVYOVdaa1lBUmpYdklkcHU3ZkNwSUFUQnVxQ2hlMjlKZW8yNVhtWmV6YnZT?=
 =?utf-8?B?QkhxeGVDN3A1bFhLTXVBVk9jMjJZSW1DWTFXQU9HQW5YVUk5OWd5MEplMTV0?=
 =?utf-8?B?dXppVHRwTzBSYlZoREEveTRNb0drUEJHUk80b0ZLTm9sZnl2OUNQUThQZzRl?=
 =?utf-8?B?TDMzN1paMUUvRGE1aTFWU1o1M3U2SlAxYythcGNiWTdDY0Fwa05sTXgwcExl?=
 =?utf-8?B?N1picGZLaFhSeGtsMGoxWUo1QW1VY0VvRzRpVXNJU2o2dHhsY3JGcVoyUnF5?=
 =?utf-8?B?ZVdvelg4ZmNhb1FkbmFOcVVib3p4ZjlKek1QemNlTXBBUUs2VDdyU08wMGFi?=
 =?utf-8?B?eWZwZG9FY2U0eWx2b244dWZaYno0cTNLSGlaREhqWnl5QnZKdHNaMEp0K05D?=
 =?utf-8?B?NE9iVytoZlFMMU5GWkp1d3RNaUJ5c3Y4K0VRd1pxUjc0RGtNbEFvUHc4WVFl?=
 =?utf-8?B?MDVPRVFZRGRBT2JOOGxQMGY4Y3VKNS9RR3FEaDZHcStjOTF6OGJtbmpYeUF2?=
 =?utf-8?B?dWFnUnUrdUhUa1hnditiclN5UnBIZUxCZ01KbTZJa2o2SFdHVi94dDB5V2FJ?=
 =?utf-8?B?WGUxVnYyMjNSQk1YNWZkV2tNWTYxdVRIRDFFODFTUWlpMWhPbzROMUM0RlB1?=
 =?utf-8?B?bk4zRG1VZlRJMzkrS2VxR1JIajVmR3ZkNWFBYWRGZHptemc2SVRCVkQyZ1Ez?=
 =?utf-8?B?Yk0xUzcyZThqcmlJbmE3VjdOU3cySkNPSFNCVDNteHhYaWRXdU8xdjkwRlEz?=
 =?utf-8?B?QVRyWTg4V2hTRE1QbkhKNmFwUTNad2E0d2o4UDB3WnRlVEMyK201L0dPeVda?=
 =?utf-8?B?R01GUGRoV2xUbzFCR0hzYmxJSWJtcjBZVVY2Q20xYjNtdSt6SEhXZHd1S1RC?=
 =?utf-8?B?bEJmUG94cHNlQmVvWHp3UFJEeGN1cHZ4YS90L014cDdSMnN1eGIyaE5oWU1D?=
 =?utf-8?B?bVhPSC9NaWhhWlZ3WnVBa3dIL0xRMlFlU0ZTR2dqZFI0QmRSSmJIckt1bWVJ?=
 =?utf-8?B?cmdicmNpejRVRWZ5blRJcHovcFgyUHF2SEFHaUlFVnJwTUE0eng2U24rUnRP?=
 =?utf-8?B?MFprS3dmZGJrQkVFNGI0Nkt6bkZQOGZtdVR1KzE1VDltVzZrczl3YWpSZmo1?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <49EDB7409C153644AB3F036E06C7EA0C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f0171c0-66c7-44d8-c3a9-08dc0ff68939
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 03:04:31.8383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3Tg2BnrJ7DsWirrlUYsvaR1GYCP5ao4AWEvnGcZ71pXXxR+x5m5p4WHayc2s1j6rQtRYzoCwBRkZvs1EGbo7XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDIzLTEyLTI1IGF0IDExOjA1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IElmIHRoZSBoZWxwZXIgaXMgZGVmaW5lZCwgaXQgaXMgY2FsbGVkIGluc3RlYWQgb2Yg
aGFsdCgpIHRvIHN0b3AgdGhlIENQVQ0KPiBhdCB0aGUgZW5kIG9mIHN0b3BfdGhpc19jcHUoKSBh
bmQgb24gY3Jhc2ggQ1BVIHNodXRkb3duLg0KPiANCj4gQUNQSSBNQURUIHdpbGwgdXNlIGl0IHRv
IGhhbmQgb3ZlciB0aGUgQ1BVIHRvIEJJT1MgaW4gb3JkZXIgdG8gYmUgYWJsZQ0KPiB0byB3YWtl
IGl0IHVwIGFnYWluIGFmdGVyIGtleGVjLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEu
IFNodXRlbW92IDxraXJpbGwuc2h1dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiAtLS0NCj4gDQo+
ICB2NS4xOg0KPiAgICAtIEZpeCBidWlsZCBmb3IgIVNNUDsNCj4gDQo+IC0tLQ0KPiAgYXJjaC94
ODYvaW5jbHVkZS9hc20vc21wLmggfCAgMSArDQo+ICBhcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5j
ICB8ICA3ICsrKysrKysNCj4gIGFyY2gveDg2L2tlcm5lbC9yZWJvb3QuYyAgIHwgMTIgKysrKysr
KystLS0tDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25z
KC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc21wLmggYi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9zbXAuaA0KPiBpbmRleCA0ZmFiMmVkNDU0ZjMuLjM5MGQ1M2ZkMzRm
OSAxMDA2NDQNCj4gLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vc21wLmgNCj4gKysrIGIvYXJj
aC94ODYvaW5jbHVkZS9hc20vc21wLmgNCj4gQEAgLTM4LDYgKzM4LDcgQEAgc3RydWN0IHNtcF9v
cHMgew0KPiAgCWludCAoKmNwdV9kaXNhYmxlKSh2b2lkKTsNCj4gIAl2b2lkICgqY3B1X2RpZSko
dW5zaWduZWQgaW50IGNwdSk7DQo+ICAJdm9pZCAoKnBsYXlfZGVhZCkodm9pZCk7DQo+ICsJdm9p
ZCAoKnN0b3BfdGhpc19jcHUpKHZvaWQpOw0KPiAgDQo+ICAJdm9pZCAoKnNlbmRfY2FsbF9mdW5j
X2lwaSkoY29uc3Qgc3RydWN0IGNwdW1hc2sgKm1hc2spOw0KPiAgCXZvaWQgKCpzZW5kX2NhbGxf
ZnVuY19zaW5nbGVfaXBpKShpbnQgY3B1KTsNCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5l
bC9wcm9jZXNzLmMgYi9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vzcy5jDQo+IGluZGV4IGI2ZjRlODM5
OWZjYS4uZWE0YzgxMmM3YmYzIDEwMDY0NA0KPiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvcHJvY2Vz
cy5jDQo+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMNCj4gQEAgLTgzNSw2ICs4MzUs
MTMgQEAgdm9pZCBfX25vcmV0dXJuIHN0b3BfdGhpc19jcHUodm9pZCAqZHVtbXkpDQo+ICAJICov
DQo+ICAJY3B1bWFza19jbGVhcl9jcHUoY3B1LCAmY3B1c19zdG9wX21hc2spOw0KPiAgDQo+ICsj
aWZkZWYgQ09ORklHX1NNUA0KPiArCWlmIChzbXBfb3BzLnN0b3BfdGhpc19jcHUpIHsNCj4gKwkJ
c21wX29wcy5zdG9wX3RoaXNfY3B1KCk7DQo+ICsJCXVucmVhY2hhYmxlKCk7DQo+ICsJfQ0KPiAr
I2VuZGlmDQoNCklmIEkgcmVhZCBjb3JyZWN0bHkgdGhpcyB3aWxsIHJlc3VsdCBpbiBzdG9wX3Ro
aXNfY3B1KCkgaGF2aW5nIGRpZmZlcmVudA0KYmVoYXZpb3VyIGZvciBTTVAgYW5kICFTTVAgYnVp
bGQgZm9yIFREWCBndWVzdC4gIEZvciBleGFtcGxlLCBBRkFJQ1QNCm1hY2hpbmVfaGFsdCgpIGFs
c28gY2FsbHMgc3RvcF90aGlzX2NwdSgpIG9uIGxvY2FsIGNwdSBhZnRlciBpdCBzdG9wcyBvdGhl
cg0KY3B1cy4gIFNvIGZvciB0aGUgbG9jYWwgY3B1LCBpbiBTTVAgYnVpbGQgaXQgd2lsbCBjYWxs
cyBpbnRvIEJJT1MncyByZXNldCB2ZWN0b3INCmJ1dCBpbiAhU01QIGl0IHdpbGwgY2FsbCBuYXRp
dmVfaGFsdCgpLg0KDQo+ICsNCj4gIAlmb3IgKDs7KSB7DQo+ICAJCS8qDQo+ICAJCSAqIFVzZSBu
YXRpdmVfaGFsdCgpIHNvIHRoYXQgbWVtb3J5IGNvbnRlbnRzIGRvbid0IGNoYW5nZQ0KPiBkaWZm
IC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3JlYm9vdC5jIGIvYXJjaC94ODYva2VybmVsL3JlYm9v
dC5jDQo+IGluZGV4IDE2ZGRlODNkZjQ5YS4uNzM4YjNlODEwMTk2IDEwMDY0NA0KPiAtLS0gYS9h
cmNoL3g4Ni9rZXJuZWwvcmVib290LmMNCj4gKysrIGIvYXJjaC94ODYva2VybmVsL3JlYm9vdC5j
DQo+IEBAIC04ODEsMTAgKzg4MSwxNCBAQCBzdGF0aWMgaW50IGNyYXNoX25taV9jYWxsYmFjayh1
bnNpZ25lZCBpbnQgdmFsLCBzdHJ1Y3QgcHRfcmVncyAqcmVncykNCj4gIAljcHVfZW1lcmdlbmN5
X2Rpc2FibGVfdmlydHVhbGl6YXRpb24oKTsNCj4gIA0KPiAgCWF0b21pY19kZWMoJndhaXRpbmdf
Zm9yX2NyYXNoX2lwaSk7DQo+IC0JLyogQXNzdW1lIGhsdCB3b3JrcyAqLw0KPiAtCWhhbHQoKTsN
Cj4gLQlmb3IgKDs7KQ0KPiAtCQljcHVfcmVsYXgoKTsNCj4gKw0KPiArCWlmIChzbXBfb3BzLnN0
b3BfdGhpc19jcHUpIHsNCj4gKwkJc21wX29wcy5zdG9wX3RoaXNfY3B1KCk7DQoNCkNvdWxkIHlv
dSBleHBsYWluIHdoeSB1bnJlYWNoYWJsZSgpIGlzIGNhbGxlZCBpbiBzdG9wX3RoaXNfY3B1KCkg
YnV0IG5vdCBoZXJlPw0KDQo+ICsJfSBlbHNlIHsNCj4gKwkJaGFsdCgpOw0KPiArCQlmb3IgKDs7
KQ0KPiArCQkJY3B1X3JlbGF4KCk7DQo+ICsJfQ0KDQpTaW1pbGFyIHRvIHN0b3BfdGhpc19jcHUo
KSwgaWYgeW91IGFsc28gY2FsbCB1bnJlYWNoYWJsZSgpIGhlcmUsIHRoZW4gSSB0aGluaw0KeW91
IGNhbiByZW1vdmUgdGhlICdlbHNlJyBoZXJlIGJ1dCBkaXJlY3RseSBjYWxscyBoYWx0KCkgKyBj
cHVfcmVsYXgoKSBsb29wLg0KDQo=

