Return-Path: <linux-kernel+bounces-339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F393A813FAD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8099B1F22D46
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217CB1856;
	Fri, 15 Dec 2023 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSrv14Hc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA16A15A1;
	Fri, 15 Dec 2023 02:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702606866; x=1734142866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7UGw352ofV5ZBbeKYqcjvo6Y62UrHT6D0IxWrmYdS/k=;
  b=VSrv14HcR+0eW6hP1RqBuLoATlMnwQxYFTJ59L4pYzT7uDHqQW/izA3l
   gkv1SWbIsTyxQxMGuPkxFP73mgj2lUxvtVT+dIh/JVCNxjeKtAWFSTbZI
   XLuH3JG/D2DDMRMlf9kKVMLaEgNTHgZzfX5huKAOU0b+jWIZgSLYedpzi
   cBxXu9snDNVDlaQdpQ0ziis1RlXGHPdmpv4XpPbarMsA38gOe3A6KY9o7
   PSIFNJEQj50lQGHbWl4TvtAVq6ss7ioy1PYTHQeD6oA2tHlfgYzPC4rGt
   oDz9rmk/tPWRPxDRujHVBvO0VrrZmFZmBj1pXzAv/efUL873yFcZPJ2tK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="2039917"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="2039917"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 18:21:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="897974810"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="897974810"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 18:21:04 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:21:04 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 18:21:03 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 18:21:03 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 18:21:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iVsje1LI9OxsTgVpOhEkSEct3FUpq19RnICdgtvOM0+1ONhRHWw5qgyVrkbarCP8dU+x4jl1t/QI1/jFaUEeOtOTc6pXLiwNN/bPE+c95XrphCi0b9NYyxQ00mpFOnq869pqyB6gtiOtkX1KPmueWYNe4vjU70ocLGU96uucO/1ZqUbUYIsjpuKCoPdIccse3YjY3qHX64C1rUT9E7HtMCFiFDGRE26LtRLZm0JXK0W+GrFNRV8dp1zUk46jNZEts7/8o4JUMbUg5b/362468/WRxlHR+qGZ6Jy7geM5Arc+lihuPqRAv/aQqjV318Kssx+tvI3Krf8gtqEJ+6rlnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cxfKbh1JREyaikwn237/x0MGePtuRMW8cdVnwzeoU6U=;
 b=IK7ZsnbjcW7Dbzr5buTCEbaoSAUnnBlV9SeK4VGXlLYB8FbudbxQDJj/lx3F7dIxWjMbcpEx0KrActTFB13xhxBqHQy7uiLVCkF1Y4wP9pckNIIWxEyzLYOPIuV4Br5/g99JUWCWvb6wPP35zIgizbdBIwK6mbZlkPhTqBf/z1RrpsOW5Nk6T8i8E9QiScuvIujcxsrPAgQWcf3uhGAiiwqu1sApXY4LNwAnIcRNNn4nBXPS1i2cZ2YvlZqumlRThu0Lv84+D/kDuvs0L3w9AspU1P2hIJ0GCDkRt8h+3qbDSNVkeV2YXjlB4UAH8rcLJcqSPlZgmPvCqcqigAamkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB7822.namprd11.prod.outlook.com (2603:10b6:208:3f2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 02:21:00 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 02:21:00 +0000
Message-ID: <70b27d47-fdd8-46e3-a5d8-6bd9c1ca95fe@intel.com>
Date: Thu, 14 Dec 2023 18:20:56 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] x86/resctrl: Remove hard-coded memory bandwidth
 limit
Content-Language: en-US
To: Babu Moger <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>
CC: <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
	<rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
	<seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
	<ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
	<kan.liang@linux.intel.com>, <nikunj@amd.com>,
	<daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
	<rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
	<maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <eranian@google.com>,
	<peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <170240413801.760665.7930294172146734221.stgit@bmoger-ubuntu>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <170240413801.760665.7930294172146734221.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0005.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::10) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB7822:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ebb4e2f-c992-48aa-a3f3-08dbfd147a77
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5Wv5SO4p2dplSVJM8G2Bbn7OOkx1PMW8Qfsm+tYyicLaJpT/Jzx5Ktgrkbr1F2D+2HqgyNr+UC42UR+D1gqlWCibB7g/G3FQD8+7gTGxz3fLSHcbBcJ1W74NRZQ1szNEafhf4Leox34AQBr1pXvPv/PblOO+ORYuhHZ7NIDxxa+ZpxgECLillQ8EmgzcnqjI0YlSBtyOil3CIdIPbIGpVa0Z9/VnPZSYWEgfCkr0ENnC486OjSC4tiy3eN0CK6GADd761NfCsp6V2mROdOwZD6Ioy8enKMLixo9Mvd81GuT+hKgKeMtCr0L2XYRvRBClmxeGM4zZLswYmGsIABdFchXjk8sNRJa48KA+Xnq5k9qIwmCp9nRDGFV+GS1L/cldGhfGS+cm+vrIXIJqTSwT95tOSx2gF1SB5pMgCC9CWpbbv6arbpqJYHR5/q0g4bu7EZye1BAl9pXAqjZRtGpMoJsnssfdNgLEVwICmqFd8cfLBobfckO2XIn9atMxnT/dL7X1pkSN4Wk0xQ7Y8L/oxHY7QDoioLsB9MC7iSTX6Lk9WrA4I1j3j6lVN/buJPxSp401s5PKrv/VwJeynJrOgfNd7LwIat6e/a1U1Sck1p2pqYeLLxzR1ZUznoVir7Z2OgUbNvtKDZaJEBAGI13gtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(366004)(346002)(396003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(31696002)(86362001)(36756003)(31686004)(82960400001)(41300700001)(6666004)(478600001)(6506007)(53546011)(66946007)(66556008)(66476007)(26005)(6512007)(38100700002)(83380400001)(7416002)(2616005)(4744005)(2906002)(966005)(6486002)(316002)(44832011)(5660300002)(8936002)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ync3T1Y0OHlGTFlxdFpBRkZBZVFNZzBSdWI1aE5MNHhRV2s0K1JoRmgvcWNB?=
 =?utf-8?B?Y0x3ckpjTVVQYnVNM0JkNFZzTmlGek1pTDlhellsSExBM3JmY05jdVU4RnB5?=
 =?utf-8?B?ZjEzcURGaDFXQWtUaDVrNGtOU0hPcGhpVEZJbkFXYlNqMlhldG5Hc1NyenR1?=
 =?utf-8?B?ZFYzUkVqOGJSOWMzU0tpbmZZK2dGd1Q4bmwzL052ZGVvQzRmREM0elNFRXls?=
 =?utf-8?B?TGhFcWttanNvb0FiT2dqTURWN0Z4VjBEVmYraUFUdE11Q3hPMmlmbUJJK2Jj?=
 =?utf-8?B?emgybGszMVNoUlhTSEo5dnN3WFRFd043alJ6VWZmY3J0SlpuYlBhYklIZ2xr?=
 =?utf-8?B?dTdjOE9La0RVdkNWNlgyZngreUtaemcrRWFwK1R6UjlCeHJwRjVZQldrZDNR?=
 =?utf-8?B?M2o1VFhBSHVLdnZWM3pVZEdieFVjZFpNbmROaDd2RmJiYUlGWk1iR1UyYnBC?=
 =?utf-8?B?ZVRtS2JRNmhGQm5BdHU3QmwzWUpyZkFuTHBKU2llbEE2OW1MUTB0RVFQdlNl?=
 =?utf-8?B?dVpEdzZ6alIwYm5HMm9WR2Z3SE9lV3NNRFRFMDlENGFreHpQRDJYQkJyY05F?=
 =?utf-8?B?TnZHaEJXVWxwN1lvUHFOdjBnc0hOSnh3YTNpTWYzTy9aMlQyOXdXR3dUaDA4?=
 =?utf-8?B?NlRuektIMFMrRHRlaURsZFl1OGZBeWpmMUdMOUJ4WFRtOWZ3QzVlTUw4WkZV?=
 =?utf-8?B?Z3owazhqS09PWHdPNWRLbDJPczhtUVBlYzRjc1QwYSthNkNrZmZubFVqSC9C?=
 =?utf-8?B?V3F5bGZpWENUcUczb282b0pudUFVcHk5SjFJcXlta0k3b05YdnM1K1VuU2tJ?=
 =?utf-8?B?SFZOV3k4VDd0OXRVUHcxRHNYZ2FqVkJDZ0ozRWlPTjczWTJNdlNpc0FGRzMx?=
 =?utf-8?B?L29Ha1NJQVA2Mnh0WnRNOWVDdHN4NXdlUG1UVllRMjdDUHdNSUJPc2cwUUlG?=
 =?utf-8?B?ZGpUd08rU3F4TUw4ZzN6WlRnNjhRaWhrNDV1bHRXK3lvVC9JNEhGZXhhb3RI?=
 =?utf-8?B?OWhIYWV3QXJwcW12bDkvd2Q2QVlMbWNRVExFQXhJU01JTHB2M1JSbHJFdTBs?=
 =?utf-8?B?QVJQeEhzQzRoZWs1aGdRZWRPakV4RE0wdk5QN1Z4ZkxXa1Q5UG1Tek5WUnh1?=
 =?utf-8?B?ZHJmeGxwMitUem5nbVpqbU1FaEZhMUZLbUZKaU9id0UxUGlreW5VS0E2bXk4?=
 =?utf-8?B?eTRIVlNSZ3hUd01JckJYOEV2Y3NFODY0YlhmRU9ob3VESnJ6cm1GU3krWFVl?=
 =?utf-8?B?NEE1VjNxWnRSZ0RqTjI0SjlTa2NRMFYzNnR6K0ZJQlBtaEpkdFpYZWlJNlpj?=
 =?utf-8?B?ZzRHWGJ2TlRpUTRaQ2tIRmRWazM0RDlVdGxGUmVjWityRXhhcnNmSUNWZERI?=
 =?utf-8?B?Skw4bGVEWFpwZ3FJTittRHBtbVVMeldsdmlOZ2hTcGxMQjJKSTZMUVFHdUtY?=
 =?utf-8?B?ZXBybk81d1pXS1JYak1DSmNWS0dkVjhwL2kyQms3RWtvTWpXVVF1TEpKRGk5?=
 =?utf-8?B?dDM0SGdyaFMvNkY4M05udkZvdjNSM3lDZWMvS0o3eDdJQ2NKT1FwSHJmbThT?=
 =?utf-8?B?RVdGdS9ucjBKaEdVZGxDeElRNHlJTXowTkNRR3hvcG54NHBSWHptZkNZc2Vi?=
 =?utf-8?B?WUJic3c3WDNzcEJxdjR3cWt6MFp4c3VENXNselg3V1pLQTgzRVgyUDNTaFll?=
 =?utf-8?B?dE1CdXBnS1JvNUpZK1dNN01wejRUUFVhVXJLaEhwVTd3dTluZ1NwNDBOT0Vu?=
 =?utf-8?B?My9BNUJkbEY1R05yWDBVRGxaMCs2QzFWWHpnek5XVENoYTRTUTI5SnUrUlVN?=
 =?utf-8?B?Y050cjlod2cwR0g5b2xLbkZEemw5RXYrSDVBSHl5T0tKNmpzc1d3MVN1NEZV?=
 =?utf-8?B?b0FJbWJVYVE0d0ZFNEVNamdPWkZlbVExMUM2SHlnR1B0anNaL2ZUY1RSUVN3?=
 =?utf-8?B?ek9ETmQ2Z0NNMHpHdXpPakc1Y1libmp5SXZWYmdZVGRQWE00dHVGQW5GUmxZ?=
 =?utf-8?B?TmRwUWJtYmpSYVZxaUdmdGxVWHl1M2dIbS9KbHlmbUpuQkJvMXBXMUU3NnYv?=
 =?utf-8?B?RXp0ZDdXbDcraXM1NnRoOGx3VVJTK0EwSy9HSEF2enFYMG5TbW1FY2J0NW5n?=
 =?utf-8?B?dWhsZXRPM1BuRFozZTIvK1praWlmeVFLM0lEWDBjM0tJcHRHelJsSDdLbzJI?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ebb4e2f-c992-48aa-a3f3-08dbfd147a77
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 02:21:00.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rbO7UVqdZJ4Phtj83UjzDF2XK/y09hOWvuUhV+PFTd1s539+a6Xi+FQwu0Fr4JFGkH1tDbX59CnBF1ZVGgBhj7PU218FKcFQtY22Prxw1HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7822
X-OriginatorOrg: intel.com

Hi Babu,

On 12/12/2023 10:02 AM, Babu Moger wrote:
> The QOS Memory Bandwidth Enforcement Limit is reported by
> CPUID_Fn80000020_EAX_x01 and CPUID_Fn80000020_EAX_x02.
> Bits Description
> 31:0 BW_LEN: Size of the QOS Memory Bandwidth Enforcement Limit.
> 
> Newer processors can support higher bandwidth limit than the current
> hard-coded value. Remove the hard-coded value and detect using CPUID
> command. Also update the register variables eax and edx to match the
> AMD CPUID definition.
> 
> The CPUID details are documentation in the PPR listed below [1].
> [1] Processor Programming Reference (PPR) Vol 1.1 for AMD Family 19h Model
> 11h B1 - 55901 Rev 0.25.
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> 
> ---

Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

