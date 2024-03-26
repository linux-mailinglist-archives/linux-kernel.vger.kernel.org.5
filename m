Return-Path: <linux-kernel+bounces-118804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 366A088BF8E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 686791C3E20D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 10:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8395468E;
	Tue, 26 Mar 2024 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VMwCMlB9"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C31B2F2A
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449031; cv=fail; b=H+GeDIPG2omGS/m/DOCJVdzq2g3Fjqh9tA1jG5uf93CStrV6zNFCBDmSVqQkC+7UeGyOP8dy85ZvFIMaS98SIdOHOXO1m7oT7d03X4R6A0wq9cGpASkjMQg7x1CiMSoXDak8vc0o/7ccIIQPNWy9wtH5CihEV1gEXKzFjpEJq94=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449031; c=relaxed/simple;
	bh=hyuTLHlYR+RSjN+U+INk76FgHrLbKjMlDiYT10ZqeuU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lcesZYZNI7bABBBHbSE9LcdcdvGTh4UdnK+anaLnHEdCQz8rO9145/YX9wvhfM6vQ+BaCRDhD9R2l5rbHfpvXfo5sSL1MVaqsG4jJY9pC8ernoiA+GBHECZR8BaAhwbvu/BNxyrezkwGC7eohLq0/vG16dBgDgdlO7dYEqDWDOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VMwCMlB9; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711449030; x=1742985030;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hyuTLHlYR+RSjN+U+INk76FgHrLbKjMlDiYT10ZqeuU=;
  b=VMwCMlB9QOuresjd+tqnprFx9IXaJmusMIOaN9O2H3TaLFPPQfSqu7nh
   +tvObcvLZ9arnufrOfmYu3MkL4d5fXAzsqpPK859P6GGtVeXAf1DSWW0z
   dNWMW+nWFZIhIaQc4i4WCcBTRfObBbJGvGt5nacClIf+rzDYBHajlVzYE
   PRUCx1FLLloVDrzicchNHNNYI6g1BY6u6TajkSwWAPnfLaWKJ71dtbne5
   L50+1VYFrnz0JYtKxRtTY8+fn8a50UUZw5aFq3kXNkao2SLIvbqSeKzZV
   08iW9lKRRgUnXucM4qg6Zij6jcyg8o2ObAzeoZCdUcuvtqTf0cOyguz2F
   Q==;
X-CSE-ConnectionGUID: Go1KtGRySnOIMw2o/fDJPA==
X-CSE-MsgGUID: 3ux2VAfLTJ65+1w9iw08+w==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6703389"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="6703389"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 03:30:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="15837570"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Mar 2024 03:30:29 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:28 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 26 Mar 2024 03:30:28 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 26 Mar 2024 03:30:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DWkTmKsx8m797/vEMHrBgEd9wa7eEGIoPYWzVN7zVY68Sw3HgBs/DvOJirQym0ooVYhQ1GJeQQ7PAuZFGyd6X+CdUL21HU3jcFVIZ6IQzpLaNP9VP1rCoi7dqEDgsj0A2UN9UE0uQCUVKL6uppLlKbTQZBin+QvMfmWldYv39laUPBBTP66F4b2yspWBTGX4yAVPw50obq1MrFdysdDBOEbTZK+O1WHKKg6w3n5mYe84NYm7E3TE1lvdFq5GReAkvhCoBB7gAtcdh4kChmyVXXz3FE7Ozyedk+SQJSGOf6giRHt2pi4e4yQC6h9sZ7Eo5A6vJAvHo/K8qMeKmBeUFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyuTLHlYR+RSjN+U+INk76FgHrLbKjMlDiYT10ZqeuU=;
 b=ON97SxOgMhMxYf/BHL8i3nLfWegp3S1apxhEh/JOCeAdTM/heQ5c9g5jzEeQu06iJMOB6pHyOLsK1LbtHvwfga4xtbuSw4sM0Ny0d7wjPli4IQ9asKq5eVXtkNKmsU4+RN3VjYZ7681zfVc5hx7cP/VsEU12sKcDMDI5c/0b+oHAGNYwOoiADUm4LiSd53uBGNIZdrWAf4niP+Dd53FZerchU5aVYrQSGmWzh6SqDncpJllqOcyjPfKH17YX5l9LyZ3wVeb3C3Hnuds/Z+/a6lZBvItGmEFYCKgRqg5Tg8N9grbpO9yyCsM/r1R0eHDoBP2da6I29Ne/jjl4eSa45A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by SA1PR11MB8328.namprd11.prod.outlook.com (2603:10b6:806:376::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Tue, 26 Mar
 2024 10:30:19 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::ef2c:d500:3461:9b92%4]) with mapi id 15.20.7409.031; Tue, 26 Mar 2024
 10:30:19 +0000
From: "Huang, Kai" <kai.huang@intel.com>
To: "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC: "Hansen, Dave" <dave.hansen@intel.com>, "Edgecombe, Rick P"
	<rick.p.edgecombe@intel.com>, "Reshetova, Elena" <elena.reshetova@intel.com>,
	"Nakajima, Jun" <jun.nakajima@intel.com>, "rafael@kernel.org"
	<rafael@kernel.org>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"sathyanarayanan.kuppuswamy@linux.intel.com"
	<sathyanarayanan.kuppuswamy@linux.intel.com>, "Hunter, Adrian"
	<adrian.hunter@intel.com>, "thomas.lendacky@amd.com"
	<thomas.lendacky@amd.com>, "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>, "seanjc@google.com"
	<seanjc@google.com>, "bhe@redhat.com" <bhe@redhat.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>
Subject: Re: [PATCHv9 06/17] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Thread-Topic: [PATCHv9 06/17] x86/mm: Make
 x86_platform.guest.enc_status_change_*() return errno
Thread-Index: AQHafqDeRqRp+9VTAkKm7R5QQmVZ57FJ0+0A
Date: Tue, 26 Mar 2024 10:30:19 +0000
Message-ID: <807fe8b1ea0e5a8415d2a5016e80566bf90f81f4.camel@intel.com>
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
	 <20240325103911.2651793-7-kirill.shutemov@linux.intel.com>
In-Reply-To: <20240325103911.2651793-7-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.50.3 (3.50.3-1.fc39) 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|SA1PR11MB8328:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6h9hEd9yIieTA49uGj1qEUpeuvq9kdOP+cw5cFDwtaz5bXUmSMZPoAXookHy4XkurdTDdFOE6rFjaprePuVVzd9BFG+IedHy6z8e3lHh/Nh+yDLMo7bXE+VnKxSlByuL2oIG5DxoyGbPUO7+/fUHHY75Vt3cw+vJA6Rlpwnu5lwdbPMa6/bjV75cw3E26g8/ETwIDSz2GsX72nFhN/zXE9bikIu5mETiLWumVUs8EwgSAncj1/70E1FNagt7OyBPCJIuNH+Vm6G56OBUVqmnigsgx3B+RpF6F5K53q2OaJU6Of1JkTBr6ENTp/UPbXW0fPaHd9kRGGTnsaJJqIK4rbyQh06UDnILodSFgzkfTRE+1UQmpbMc96eotk9ctj/x++ggBWVA5zFKyLnPvIa6vqWAlA678yEm9THmT3RFbodoc76oGC8A0InxxdT9cjZPXGGW36C6qVglAHqCo8v2ZBazYTbo89BR8oHYVK2o5Rpvfi/NKmACKIudhK6lmerUhYPJh3J0LxRKr1q+fQPeqxD8fYcGTkKk3ZO9S01WlIGXaG0r2xfLOW6ABlEL9o0SSPpMqXCv+zRjkw+ec3sCpBw+KPCroX9vPh6M5xo8Xzxw5/a2TB+jJJuXpiT2qoZR2YooP7rzQNaVUCBSJx2NaLwslEMdFMHZbPmNaRNNtUY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2RuQkVtOEZ6SnJNY1hnc2h1ajdqWlN2elZXNEFNdkYzMVZ4ais4OUIvMTFP?=
 =?utf-8?B?bXhLUEw3ZW02WEJieE9yQXNrZ1ZiaUl0RHVJNnRibTgvQ2lIbXdSQjhMdndm?=
 =?utf-8?B?YWNtVHRlUlJ5SklrbnI4TjU1Wk9Ya2tFcjlwUUNPajVld2NTOEN2WjVwWXZ5?=
 =?utf-8?B?YnowaG93Wlo3cHZuY1BlczdnRHB1emN4R21CT2dGQkhQb29xQ0ZaSG1nYVpz?=
 =?utf-8?B?OHdNekRtRVpUUFVpdTFLeXRvYkc0elh6VnFYcGZzZnhsdVpWc05iOCs1NGVV?=
 =?utf-8?B?K05lTXRFQmFpQU00RU1EOHVpbFhSQlU5Y2JXb1hJclpQYWpCSHVTZzVFMCtR?=
 =?utf-8?B?UnNyOWg4VWtWOXdJSmVLRzBXTDJiM2JJcXlmV2xma203ZDhlUmt6NmluR0xP?=
 =?utf-8?B?QThzQXl2RDM3d3p1N2RQbTlDOVJ0RW95dkhSbHdtaDBRVlZKaVZyOUp5WEUw?=
 =?utf-8?B?VHNDb1pSWS81L0V0eXBZcXhHZE4vQkxrUUU2U3ByYlBGNnplN01HZGNwYnIr?=
 =?utf-8?B?QUhaV05HQjh6OFVYamJ1SXl0UVZkRVJUQ1l2bUU4TjhFRjJLTDhvWHppN2pG?=
 =?utf-8?B?Nzg1NGUwalBWbU5ZVGpqNmdmLzFOaXQ2czl3ZjJiVkwxUG9OUHZCb1ZpMHE2?=
 =?utf-8?B?TVhmZXkycUpiRVNPZHQreDIzck5EVEdCMmczcFFqeURCRTJNYTVML3hPVVVH?=
 =?utf-8?B?Vk9Ob0k0NEVuU0k0b2h0U0ZjcmpGRC9oK1pCRFAvKzl5eTI1bWRkc3Q5UGxH?=
 =?utf-8?B?R1IyRlRqZDRuZUFtelNhQkpkTVZXRG85QkNmSUpFTDlLNTBtWi9oS3ZPNVRm?=
 =?utf-8?B?WHpoaFdQR3M4ekdhTWorVGRrcjJWd3AyMHl6UGgxYzRUdVJQVDYrdmJmU2Va?=
 =?utf-8?B?MGMwVGw5emlTNG1nZElvTWdSM0N1cjl5SzlkL2F3aWlsdVlpaG14Uk5YNHJm?=
 =?utf-8?B?dHNTR09xNWkzbDRjTFRIVU9LMEZkcEcxNnNPM1RYK21VK0pIV1c5c1V3aEs2?=
 =?utf-8?B?UWdUWW5DZ0EyVnZIaUVPVzlIYmo5Z0tCenBheW1rWTB4VTdaWW1aVHZmZFgv?=
 =?utf-8?B?NzF6MWZ4Y2xFR1AwZHBJS0tTaWg4T0gzNUZzRFFDUzJJWUQrQVNwTFBSeFI1?=
 =?utf-8?B?TFRDR2ZBUCtiUkhidEpaUlVhdDRiL1pSVnEyRXVmaGIyNzdXcXQwR3pDVlBi?=
 =?utf-8?B?ZEtoazNSOVh4NGx3eUhTUGJ3SjZ2dlN6TGZlYkJweHZQOEVqSkNDejF5Qml3?=
 =?utf-8?B?R2VJa0twdmJwV1YrOFk5ZGZNZEZnM1FMV0Y2VmZDS0U5WFltNGx0TGlGdzlr?=
 =?utf-8?B?SEZRUkc3UzR5RjQwb0NEQWxsamNLRFRUN09RZ0R5cFdCZXZaaVpyMlNtazdq?=
 =?utf-8?B?TVR3RUZiZm9IM1JudnMrMTNDNDM5VHo5bnZKSzBkUDFrQS9UNnBrSUdwa1Zm?=
 =?utf-8?B?MU1MV2EwcWNyUGVtWms5V0NFZm9CWG9LZEFrakVsRUpkT0ZuQ0txTFp1TGNx?=
 =?utf-8?B?RHVKTXRRRWpha0dQUkVnVEhmUFY5b3pDaG81emhJeldNUlRGdGd1eTI2cEJY?=
 =?utf-8?B?VU1PY2FVcEZ3ejRaeHFNZjl2Zyt2L1hrTmFzcy8zSmo0YnNNQzNkbndkTVd2?=
 =?utf-8?B?SjY4eXRBQWdLSEhXbzgzZzlSQngzYW11RmdzZ3F4eStVNkZjSEtCZEVjRG1W?=
 =?utf-8?B?ZFpjYkdtWUo3UGV3VWFRc2ZPTHZub3llekRScFJhb2RWd0dUS3FRUHVkK25D?=
 =?utf-8?B?RTdDdHFpbk1rd2lyM2NlUWFjNTZGVzF4eWgyRUo3YVkyU1dtR0NkS3dhVGhv?=
 =?utf-8?B?ZHltY3FhRzBjQ2wreEM2NkdoYmpMQmg0SGtmM2FWcXRCRk9zWFBkK2Rodk5T?=
 =?utf-8?B?Qm9ZU2xwdHMvMTd4R3hQNmU0Q3Z6dHZDVFgvZXVGTlkzRjRBc2hiM3ZqSXor?=
 =?utf-8?B?Vnk4L3oySHRCemlDdlZPRVNiaU5TY25BVXpseGNnMDRlbG9wQUk5OC9vQ1po?=
 =?utf-8?B?T281dDJSSXJyRTZyOTdLZS9ZRzdxWHdUS2hPSDBDbXg4dzVhRXZPNGdzR3cv?=
 =?utf-8?B?TFl0TGRPdkU2RWl6S2RWSDRsWE4wRktFMUhvaEhyQStlenRlQTV2YndPMVRu?=
 =?utf-8?B?UExlNnlNTHRobE1RenFqSmxrRk1SSkl2UUlCdjVIQ0R0QXdRUUF3YURTWUhO?=
 =?utf-8?B?Zmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <15D67166648CF347836FF79511C41846@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b5b17fa-2a71-48c8-7077-08dc4d7fbc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2024 10:30:19.6087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BlgzEt/SohODgvsU2hpMs8DSHx1t6qPzO3l79Jwwkl4O70xy1pO1t0yMZOciHYi5A7uHsTmt5pkF/Fi98q1Z2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8328
X-OriginatorOrg: intel.com

T24gTW9uLCAyMDI0LTAzLTI1IGF0IDEyOjM5ICswMjAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6DQo+IFREWCBpcyBnb2luZyB0byBoYXZlIG1vcmUgdGhhbiBvbmUgcmVhc29uIHRvIGZhaWwN
Cj4gZW5jX3N0YXR1c19jaGFuZ2VfcHJlcGFyZSgpLg0KPiANCj4gQ2hhbmdlIHRoZSBjYWxsYmFj
ayB0byByZXR1cm4gZXJybm8gaW5zdGVhZCBvZiBhc3N1bWluZyAtRUlPOw0KPiBlbmNfc3RhdHVz
X2NoYW5nZV9maW5pc2goKSBjaGFuZ2VkIHRvbyB0byBrZWVwIHRoZSBpbnRlcmZhY2Ugc3ltbWV0
cmljLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogS2lyaWxsIEEuIFNodXRlbW92IDxraXJpbGwuc2h1
dGVtb3ZAbGludXguaW50ZWwuY29tPg0KPiBSZXZpZXdlZC1ieTogRGF2ZSBIYW5zZW4gPGRhdmUu
aGFuc2VuQGludGVsLmNvbT4NCj4gDQoNClJldmlld2VkLWJ5OiBLYWkgSHVhbmcgPGthaS5odWFu
Z0BpbnRlbC5jb20+DQo=

