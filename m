Return-Path: <linux-kernel+bounces-100451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5658797BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:37:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E92B1F24F13
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0807D067;
	Tue, 12 Mar 2024 15:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0skDiUO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A427D064;
	Tue, 12 Mar 2024 15:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257834; cv=fail; b=r7eBKe6UT1iq1MSI4fdzQ5Q4HK1dUz4GZ4G5JySRzl+/Cbhk4Jd05NnpBKs5xA+o6ZtzG56nhDAlVrQ9CuOLY8SojaM/gA7PTGPITthDJ3W2HRUXK0M4WfYs5+CJreWF5FHpTVnAKqW2qk7EA2c3qFRiQ5V5d6CFsch8xz9VyuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257834; c=relaxed/simple;
	bh=TViuQke2DIjRKejB/ks2r0QF6j2P3NTCWjbwe30in9s=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sV9APUIWbSGVQjOPrEYL6Ap9FqU5kt+n36kMrgl4EOafCJYk9g4PBCy+YGCQx1IzoQe7eg0G4NsOIeqrzC4okc4zGzIB4pw+zJN5TXqGsrIZ4vmzy2fIuOs0fRveF6UYy4l7lhcAgoi6ZDHsNHnZIYMZNVFUYZe1hRXN1WcVDns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0skDiUO; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710257833; x=1741793833;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TViuQke2DIjRKejB/ks2r0QF6j2P3NTCWjbwe30in9s=;
  b=Y0skDiUO3qH0bOB/7a62Lp0CA/knwxvBLZc5lvztMhaK7LXjccm5RU6k
   2avVZO6N2n4Q5JI1Rku9qApnvVchkQsQOIQekSm3Vdmzco7Au0iwDEWGD
   KLsjnT8z7+m+xbY8t+FXmOCNuiWPRaB12m+Uw7Hx48vnsgOimTb0EczlP
   F/01MYalQMVNBLLZeD6KNyRwExb4Z9IDDy1PC7EyyPjUy3CkTBgn4QMVp
   SIuCO6HZTHUkouKEwNCFzjfTLHhCXH+9TzOdueU9JyeXITQFCuwNF59qD
   Ol5kWiXVn4dXagcgoMXyklM5V5YI9s+J5CNvFniG2L6ucs5BoA2E7zMUW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11011"; a="5106853"
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="5106853"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2024 08:37:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,119,1708416000"; 
   d="scan'208";a="42579463"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Mar 2024 08:37:11 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 08:37:10 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 12 Mar 2024 08:37:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 12 Mar 2024 08:37:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 12 Mar 2024 08:37:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq/xENGc/f4I/RZ7pa8y6J81x2afDaSrLRiFhYiNu1dB7coa66qFAX7heH1DlMa2F6dT4TJ/ehbqhIlyy52cMJ6ouesnwwK8cC/4qFiAbSw9udQXKbSwhYiOCg+2sWd9H29FAjNt3twx4VKpFnwdY81kCM2Zo1dXHVkknaDoC8KXmK3YNJtlEU7OoDDc22+uZiGGGi//RTxQMjGdsqJKPU3n68f7p5rjQsVmYnL2SK8FE0VUN7FET9MxWMddjnRvp3j1FeEt0mM0j+29KEkFzHF2M4mdxhcm8fZVufE9NWY1KXBm8q4DzH024cxW5RT5iNo9s0b1GoqzmSIYOAurwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V0rlEtbrLwph8VVmkBZRMGFXEyzulH2xS3qxY6PiQXU=;
 b=RDYBQBEtuOqL1kcxrzVtG6z2DlRTW8mYaBF5bJDevh0mxPQ9OZm7WzTyPqrFBBgOrB6qy9s+GItajX/4u13iwy+UdcTMBlgZ9z4DOd6x4jL6WHaK0j6XzI4Q4mC4+5gzxvLQa67wLHs7zJVh2Oz2A5EqmS0l8h0H6mRivW6iG6CTNKl3H31HaQBsM6ZRq8cfFpVPCSLvmEC+0BOA4AVP2nfn7mTQOHYnHWxEpoKfJbQG7QP2+RG7p8Zkn4jSexbeKAHMqe2px6Ml06b7HkXVz2q+IpPtXjqI+EFVIRK3+EVkX2A1+M1qPJrazBV88SI7bmGlmp07qq7OAmoGmn8UbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW4PR11MB7164.namprd11.prod.outlook.com (2603:10b6:303:212::6)
 by LV8PR11MB8510.namprd11.prod.outlook.com (2603:10b6:408:1e8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.18; Tue, 12 Mar
 2024 15:37:07 +0000
Received: from MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1]) by MW4PR11MB7164.namprd11.prod.outlook.com
 ([fe80::b5bc:2406:7431:8c1%7]) with mapi id 15.20.7386.015; Tue, 12 Mar 2024
 15:37:07 +0000
Message-ID: <d7340cb0-8835-4816-9bb1-6ceb6f662b34@intel.com>
Date: Tue, 12 Mar 2024 08:37:04 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: x86/aesni - Update aesni_set_key() to return void
Content-Language: en-US
To: Ard Biesheuvel <ardb@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ebiggers@kernel.org>,
	<x86@kernel.org>
References: <20230607053558.GC941@sol.localdomain>
 <20240311213232.128240-1-chang.seok.bae@intel.com>
 <CAMj1kXEQpFhDaxJ-rBb221ggdZEYWPzeoueKJr5SqRx60Ezf-w@mail.gmail.com>
 <7d463faa-94ae-4c62-b3bc-b4d1084e4600@intel.com>
 <CAMj1kXEr3egDCZ+DYrZt8ohG3fA3jEr_D2iLZp+c9yoj3mr5eQ@mail.gmail.com>
From: "Chang S. Bae" <chang.seok.bae@intel.com>
In-Reply-To: <CAMj1kXEr3egDCZ+DYrZt8ohG3fA3jEr_D2iLZp+c9yoj3mr5eQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0039.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::14) To MW4PR11MB7164.namprd11.prod.outlook.com
 (2603:10b6:303:212::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR11MB7164:EE_|LV8PR11MB8510:EE_
X-MS-Office365-Filtering-Correlation-Id: 132fb284-9f10-4804-663d-08dc42aa4647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jmbbT0/cwUKY2kgh63JGhnMhOI3pQCSjFwCqSvVuWMm4N77Qi6+oTxBA6QI6RtItsqNxeTJWNKH6sluxJ4ntUWs2jg6Co3Kkh1Otk+wI9RwCEmdeCfJQ8El/6IGkMbjmk89brrvvF1cXZNmUK5GbsKsOzI0I1hNmii0b9aGWaQRPOYk5maCV89DrnobdyG0HD9aI6lieX1xy8lIQ79NAXED1waIT/pzsrBRUDWhZpnadKAT30RoU9ChxAJs8uk5IzowJEFCD+V/QrLcmxIwWh8FJE1q7fm2zX+YEa3GEg3XqOm83EZETRRSO4s4SQWbAMYmsi0ihp6ympkD+qvG4Tt1rzVh1srd/o2GoRLtLBzj0kLOZlAkvwhs3QLkqopEo3tuyemdK8e16XnnZeE4mxfKqoC6LCOAwUXkj8d08qRh9EQLL30lOwG8fsmgS0dNFxvU4+NCiub2PHPmLwPBmcMJRtDjfnlV/UjtknHXZTMkzoBSMC7CYIsE80MtJTv8Pd8AExuXreC+EidaAemdhVGsd8EzGs/6gvoq668h9Eh3F2bItF00ICISmZ77MimuzeKzHAA0hrQDssh5xL37B8rA9EzRwb7KnobJvBlxxMIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7164.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENCM2VoQmIxZmVQYlFwSXdjV2NtOU5pSzZpU0ZoOGVDS3BFaGdtNXllc3Bs?=
 =?utf-8?B?K1NuL1VtYTl4OXpscUpJSnh5SjdMbE5KSTdDUFBLMldsdDducmxiNnZrbG1F?=
 =?utf-8?B?R05MSnNBRmw4Y1FGZW5ENjhGOEM0bGhyNkZIRHkxVW9xdlIwc0JxTHFRWWQ1?=
 =?utf-8?B?RnljQWliZmczZDRHNU1RWnVwUjNiMzZtV2FJWjV0ZXRUamplMkpMT25tVnlt?=
 =?utf-8?B?NzBqQlBDVis2bFd2T2FhWEMxWlFKYjhpMkxvR0NEV3NHSGk2SHhZOHRDRjZP?=
 =?utf-8?B?U0F2TzBzUUZxc1RINktVOWNMbmlQdittOThZLzhvMlZLVlBWK3RZaW5PUHoy?=
 =?utf-8?B?QjZQS1N1ZUF1WEMzY0Y0OTZLTXl5OFcvaWVIbXlvZm9oMCt0aUZhMGN3UENW?=
 =?utf-8?B?Y05XNWhCanZTaUxmelh6ejl3T25ST05IamtMTjBEa2o5b2pvZFJEa0s5NUlC?=
 =?utf-8?B?VmIydy9PUzlPaTlIeE5xYXFta3gzWDV2YzlwR0xlT0Y1aVkySHJCaXNVUHVj?=
 =?utf-8?B?bUpxK05PYUpjUEMvbmdPUHNicVFTMk5xMi9tK1NySTY5RmJpYitlL2hLLzJm?=
 =?utf-8?B?ZGFmaFAzNFpUdkovY2k3ZGZ6RzRNMGxQZlhVOWlzQWFNWXI1bXYwK0FnODZX?=
 =?utf-8?B?a0gvY1p4dVgwdnBjMU5LNzdKemg4bGE0bUVoZjZRUm1raHJUT21xYlU4bStk?=
 =?utf-8?B?Q1k0ZXZiNi9xQUZZSUNFNk1veGJyV1JSb3JoRnJQVlVTZUczM0F1NTczeTRq?=
 =?utf-8?B?a2dXK2tJUHRNZTV3ZFdFQll6Y2hlWHhZRGVSNXNIMWpaM1llTmtuZGt2ZHdF?=
 =?utf-8?B?a3J4UUNxTkp4Tm1mNnUzMW5WcmhPMmVSUDl1N0wwRlNPeGl5THFqNnlDWms4?=
 =?utf-8?B?eCtCbWVNYU9FcXdGZ3BEeHVuZ2ppeFB6VUFpcWNLSVFVdDZXbnN6blJpQmZt?=
 =?utf-8?B?VERJMW5FTGkxTTRwU3BtcHM3OFoxN2d6Q1dCWlFPM2gzVTA3WHZueEpJQTdv?=
 =?utf-8?B?cUI2amtVeUFlNEJCUVdsbURiNFpWMEpoM1h4TCtUWnN2WGVNQWZCS2ZnUHZF?=
 =?utf-8?B?VnMra0xadVp6MGpIM2M4SGxKZzJhNkdpY0NHRXQrNllMbzRQeG42N1JtTFN4?=
 =?utf-8?B?YUtlR2w0RnRQOWg3UVd4M3VWSjNOWkNkdVlKT2FrMnl0RlJYOUtRdlZBQ0RL?=
 =?utf-8?B?bHpGeFhsSFlvamlQZnBmTkFRcE9VZlhINHlvRkI3Vk5Ia1drYklmM1pyejFN?=
 =?utf-8?B?RjZlZlRBTmdJR05CUHhuZEI5UTJBQTZmVUR5cHdpdGZzMDZXUWY3QmFjck5R?=
 =?utf-8?B?L0hSKzVXU3lDRkZRdUVXV3g4RTNDSDZZSm54aHBhYmE0Y1V5UFVqT2RyTlZo?=
 =?utf-8?B?c0xWYnpZN2IvN0pOaU1NRU1hbWJZQmgwVExEN0F1akYxNXI0TXZ4Q3ZsSG9C?=
 =?utf-8?B?Y1l3bjFxSHFqQVBzZDZSUzVOQllrS1JWMEtjd2ZpbEpmRmJhaUNZSVZTU1Uw?=
 =?utf-8?B?amZBMFlYS01EMHhXSXJTSE85UnNLVXV4T243SUIvMlZMRXV2TEZRN1VqN0Rk?=
 =?utf-8?B?MWk2ekpZUE1qaEM5bHlneTJuQkJBb1VTTEx2QlMvZmJMM1FpZUh1V1VoUG5o?=
 =?utf-8?B?OG1iNmg4eGN6ZW50bThCVnVxVHh0K1hNdk44NDBDN3FiaW9qRmd1Y1liTEhR?=
 =?utf-8?B?ekZWZkVpUzB1V1VRbmxjbjRtczdrbHJjTU93UUd0V1VJa2pydURTeDIvSnNJ?=
 =?utf-8?B?aWZZMG02R0d0S095YmJoU3N4dzd3emtUanNwUDN1WXBLRmxrUm03NlNjcHVa?=
 =?utf-8?B?YUZXMm9qWUd3OTZZUXJyaDJ2SkNsWnRqNDZMQ25rL1Uxb3lqczd1YVJWMnJx?=
 =?utf-8?B?WVFUYmZDdFZveXVJQk5KMjRDaStKRS9YVjE5Tzl4YXBaRVFyaFNSdzRkdUI5?=
 =?utf-8?B?TG9tQ3dGMlJDcCtWeHFVTkpvUTFnY2VadXh5aGw3dkNsWHpyWmpZb0p1TTZu?=
 =?utf-8?B?eUVwZENoMjhBTmswVVJ5VitZR0pyOEo0dGZBRkVoRlgzZjBDalY2dTlEalZr?=
 =?utf-8?B?MWpTY00wUWNEbE8yOW5TUnpUcEJqVnNmTHVHUWFkNDBGYm1vbGVrRzhlV0E5?=
 =?utf-8?B?N3FwL2xYQ05CR3N2cVhnSitEcDliRnIxTXpRamcwY3QrRktsVFdya2dVb3hn?=
 =?utf-8?B?T1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 132fb284-9f10-4804-663d-08dc42aa4647
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7164.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2024 15:37:07.2294
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tb1BooILoi8fSqWUP0DOzYAj/Q6ED+B3w+4apEqJJMorSry/bj2RPK8GlaslYpSs0f4W9d/KoxuhotE026825fcXbvPj1ZQSJuqnrCbd78Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8510
X-OriginatorOrg: intel.com

On 3/12/2024 8:18 AM, Ard Biesheuvel wrote:
> 
> I wonder whether we need aesni_set_key() at all.

The following looks to be relevant from the AES-NI whitepaper [1]:

The Relative Cost of the Key Expansion
     ...
     Some less frequent applications require frequent key scheduling. For
     example, some random number generators may rekey frequently to
     achieve forward secrecy. One extreme example is a Davies-Meyer
     hashing construction, which uses a block cipher primitive as a
     compression function, and the cipher is re-keyed for each processed
     data block.

     Although these are not the mainstream usage models of the AES
     instructions, we point out that the AESKEYGENASSIST and AESIMC
     instructions facilitate Key Expansion procedure which is lookup
     tables free, and faster than software only key expansion. In
     addition, we point out that unrolling of the key expansion code,
     which is provided in the previous sections, improves the key
     expansion performance. The AES256 case can also utilize the
     instruction AESENCLAST, for the sbox transformation, that is faster
     than using AESKEYGENASSIST.

[1] 
https://www.intel.com/content/dam/doc/white-paper/advanced-encryption-standard-new-instructions-set-paper.pdf

Thanks,
Chang

