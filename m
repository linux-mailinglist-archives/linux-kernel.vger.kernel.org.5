Return-Path: <linux-kernel+bounces-2082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C73E81579D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A169A1C233B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD2DF199BF;
	Sat, 16 Dec 2023 04:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e1qG3dvH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32144199AF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702702789; x=1734238789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tc/b0c3HHVSml9pFtgrc1VnIsFNuCtwX5JkDku2osAo=;
  b=e1qG3dvHe3wjaKPhzcJuOx+FyKO0QDFZahMDVABcsckWjl1v8W4JPO0A
   jF/U3dDD6WoMWCD6lv+Znq3s/PrNRON90vdYTmQ08Ti6F7ZT4YY3M1MIK
   GEOVB711GEo9hx+iltQtoeU35+D3kxl1L6s910hopYrT0Dz9t3GAstV9y
   tGqd6qBkqkoCHgjsfVl6v0rZq7jsK0jdht4LQ1nd2CpGzIIgZ0HTd8C25
   T1A60PwIawHInPHsW98KlRQQxTMKr9j6lrFgXQa72ax4mpo8t9/MCs8lj
   PRvoqQeArMiWujjv8/ivZr/zCXXnmNv4gHKTusHGvl4/u1V9UBUvjnV/X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="394233058"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="394233058"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 20:59:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="845342917"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="845342917"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 20:59:47 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 20:59:47 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 20:59:47 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 20:59:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aPjkPPMHnKqNGQrQanX6X4ZbTARn9ltx9VZJFAPmQOfCFVDR7L4elxRxKiE2dIbaEICbsNH1+h29mD5GKZEnFdBVUtwNtZKEG5+OVPfWHugGrs39+SPUGXsAXiiFn+CY5XiMD56yKiNPIXAMsrMFEn7O6Z46+mjnIJcShQr8ZdtaGpROfAu4PXThEgLJALT7CJRMMVtitGelbcVUUaxikq76D9a66Dm27i0NsNLlvj0VvvkjnE731VST/fm0ua79QFE1t+kTptk+oqib0df9m3VVDlm/nsM+eTYbV+uoZLVfGQ8KWGfRDNxhlfHVwrJCXlJ3bSq6cpdvaFCk5y05ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b23MC7Z3+dto4n+rAZcbvy9KPbiEZ/NzYAGwUO0ReQQ=;
 b=Zk6k27NLSnYouYwKW1+KlWJSZtx0D3UPEmpvz3e9n1O2WLU1LkTNA97WIDxs43n7e8Rh2K3TMB5WJa2VSRP+SYAsVtYipcm/cCtcolYACqaIRUe9soSNpFF4Yq62G+MknoCbarY1BI1dKD/20lZtnnEt7CF3gpqGzcl79BhuNNmpxt4/gSG9pf2yx7J+b6uqWpDeL5e1kWhO1909pKD9la6F6JCGKdpWSa32WngaLaKLoF/TNG0koB2IAqJ924E/tgT/jvbSdkOi9BPJICxER44aASmuI5uJHcpUuY4UGrbZw/qRW1Qx/PhttGirzWwitEgPguoBm2qgcTvT9Wvmgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by IA1PR11MB6147.namprd11.prod.outlook.com (2603:10b6:208:3ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.33; Sat, 16 Dec
 2023 04:57:53 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7091.028; Sat, 16 Dec 2023
 04:57:52 +0000
Message-ID: <6ebf108a-49e7-4fc7-a61e-b993ab696c6c@intel.com>
Date: Fri, 15 Dec 2023 20:57:49 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/24] x86/resctrl: kfree() rmid_ptrs from
 resctrl_exit()
Content-Language: en-US
To: James Morse <james.morse@arm.com>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, <carl@os.amperecomputing.com>,
	<lcherian@marvell.com>, <bobo.shaobowang@huawei.com>,
	<tan.shaopeng@fujitsu.com>, <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	<peternewman@google.com>, <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20231215174343.13872-1-james.morse@arm.com>
 <20231215174343.13872-3-james.morse@arm.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231215174343.13872-3-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0227.namprd04.prod.outlook.com
 (2603:10b6:303:87::22) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|IA1PR11MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea03c98-1af7-450a-6256-08dbfdf38f38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j29NruI8joTVI8BjKFBo9DnLK5fEz4Ea4Djhut6hiakI9DvAJpUa0RkZXkreVIin7Odxbs6Npsr6FP5wORQUHiEMZan4UYm28FLz91/fNSp/E1YXRV0IxpquORzZxnHwpb/iepvLEElgcyHNXr44WgGFRB4rsQQumB+F5mGNC/rFCwyQx4aWCzUBx0J/J2gO3E+Sgg7qSY4mR+hfHMuD9xJX1oHWq5QDghIojrE5d/bcEfJ0UA5ruyt254HmhHkMUSkLx8s/wsrmhsswy6LrnGBtlvQfWurUHdXM0c7MeTJq+MRhTbaanGj6qKJuJz+mo59a9GH9tonQT6JGpbd6BwGV1hhkbLAVOQnj7A7RGACUbKTf1NdBGhFy8F6jNMjGO0tFnBPW4Mfrz/qDxvv/DY3iQJxA77m8JwPIIa9xkFxv7RTE7TQllX1W1yWWi77bCI+XwuDfeqCihxG9ZQm38ZdDiqr0MNzU2DJZgV1Wm0jjVs9QCt2GLowQ02dRB6PmYKwW/3C8K7i/hzWjRZ4qH5yM4OhAu+kgAREyGhTWNoItG69KsxAariyC/dASEeweWdc+VfqbvFde2higqJpsJoqLmDtCWr2B55VflrN9mWJhlhpiLM6IidURLfc+ZphiY/Xw/ITMykouq6EbiKePIw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(136003)(376002)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(83380400001)(478600001)(82960400001)(86362001)(31696002)(41300700001)(38100700002)(966005)(6486002)(8936002)(8676002)(4326008)(66946007)(66556008)(2616005)(66476007)(316002)(54906003)(36756003)(7416002)(2906002)(26005)(5660300002)(6506007)(44832011)(6666004)(53546011)(6512007)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTRrRVpkWVFyZlpYaS9FSHk0SWpEaFU5dHJXcVdaKzZ0eGNwZGRnSjRZWEQr?=
 =?utf-8?B?TDNZOVhxVWdDc05VZmhPT1dsTjFsVHlXbHUvRnhBWXlvQkZ1YzJUeksyQjFq?=
 =?utf-8?B?bm9sS2VKMEd2OWVMVFF4NTR0ZUJ1YnpBbFdrQ3dza01QN20xNEIyM0ZlaTVY?=
 =?utf-8?B?QmN5ZVdYRHhPbXI4UGlHaXVaOThVVTBWNktCRmRKejhLd0lwWVZRVVk2YlY3?=
 =?utf-8?B?QU54ZTAzNUxHREE1TzhvUEVSc2lUOENlZ2FZdWZRQmp2WDM2TndSdnU0aElW?=
 =?utf-8?B?bFI5TllsbVJacVhaWWRkSU9vQmRoeElha3FYd2VoZVRIMUo0b2pmTXlQc2lh?=
 =?utf-8?B?TlFOZm4xYzFEYWFmSEx5NmExSHlWcmVsY1B2enhKODNHeWpNRVB2Y09NbHdD?=
 =?utf-8?B?TldoS29OdTdjU1V5azVNOC9FTVUyRWdTU3l2bXVOYlk2ZTdJRnY3VGJuL0ti?=
 =?utf-8?B?Y0g2NVZ1MXBmRTVEVkZ5Rjh0clVHSkZudmZSRmI5Q1VaNmNhN0dvQ2RXWnRU?=
 =?utf-8?B?MWtzZmg5RUxBaDdPcVpzYy9YVFlxemZNci9DNDRDUFBSY2tjbHNMVFdnVndF?=
 =?utf-8?B?SFd5eXpDYm5ydko4V1JmUXRpd21BSW8vUnNNR05Pb0dSWUZwell4bFNNRTlw?=
 =?utf-8?B?VjQ3V21URS8yNGx1V3ptLzZYK2RQYjlZNnBTQlNBM0Z2K3pWcDVJVk9vWlp3?=
 =?utf-8?B?eEVIUVZPeERiaHplTnBPbGx0Q0tLRGgvM1VMaW5GUFNjc0dFWFM4YzJPNVdU?=
 =?utf-8?B?MlRYaUMzaUlEeXdFby9wQ0s1RkxROVl6NUNGRml6NHllakhWb2ZNV2VVSUc1?=
 =?utf-8?B?NmlmbitqZFZ4aC9iekplSFdiQlhlRDBxT3hYdklEV1ZxMjI0cmtSdkNnVTcz?=
 =?utf-8?B?bGo3eEtNMjY1MmlLL3BwQWR5WEpTbFE0cUE3bGRlNzUrWEtTZGNjQUVNa1d3?=
 =?utf-8?B?Ym83RStqQ1RrS3paamprQit1bkdaQWlvOXFqUnRCaFlXU0FPNWhPQVBwQjht?=
 =?utf-8?B?bVVsTFlBL2Q4aHlDQkxmQlhYU0lORHBNNXBTNGRZUDdUcEVoZmpldVJlZlFV?=
 =?utf-8?B?MGVLVEFSNUNCUVZ5TVQ2WGpJalBPNkUzSmZaS1lEZDB4c09lZ0VrTmhSSVI1?=
 =?utf-8?B?M3RCSjlpQlJ0WHp3YUdZZ2R3Qmk0bUtwV0diUVFCL3ZvSkpMV2kvMnhnMllH?=
 =?utf-8?B?Nm1mcjF2alplbVZuS1NDVkgyN1RSeVJvS1ZabEt5YmVabk9vSjdsVXNjOFlr?=
 =?utf-8?B?bWFiRjMxcXNKQ2JsZWRseHpmdktDMmY4bTY0U3V0VEpoSDAvODFlRCtiOVYw?=
 =?utf-8?B?NTVVRG9rMk5RSEx5TnZqZE1tZkI4K0dpNEFENWNVTndGTEpVc1VmMGZSMmlz?=
 =?utf-8?B?Nm42alNaYWh1cGtIbjBMTSs1d1NLbjc2ZmJTQUswWUppVVU1bHhJQnpSRzhR?=
 =?utf-8?B?di9najVraytKRE9xTHVNZHhnQVV5MXNXelFRSjhzVHlqNm94bFVZNFZ6WjJY?=
 =?utf-8?B?OFBOMnVrTXNNNGkvdEIycjNBVDM4MFRjWHorMUZFeDI0eEJvWE83RUxHc2NZ?=
 =?utf-8?B?Y1p6dFhhR1J2YlpVNjRwZzNwSXpzVWVsbENheHI5OWQ0YkFNaE9Wc0c2Yks1?=
 =?utf-8?B?Z0pSYjRtYzB6cFB4WmxWcXJSajdtVkFudHkzdVZ3NytyKytKNko3L2NzZUJ6?=
 =?utf-8?B?VnlTVmF2eG5VckVtbEtQcytOY3cwbDhIZVArY2Z1WnlYeDJ4aXk4MFdTdnU2?=
 =?utf-8?B?UC9SMzRxQkltYm5iMXk2dFR5UnNBWWFwKzI2VElUT1daQzY1K0ZBbUdzK05r?=
 =?utf-8?B?TWVtSGF1d0RCa2VvV0p1SU4zWW52NFNkRXF2eGg3RkcweEJmSDJhZmt0Wk1W?=
 =?utf-8?B?Uy8rVE5raFJzL05ESEFQc01KdHB5VEtjLy90VXJ6d3MwQXZCekZ1eFl2U1Q3?=
 =?utf-8?B?RE84QzVQanFrckNpUmNia2pCVVFWODA3UERIa0ROdkNHZDdoVEpIcmdlQzZ3?=
 =?utf-8?B?TU1hbE9JMVZPQmlPSXl2b3piaEY1bUROYkhoaHppRjdwdVVVWk9qelBEbG9Z?=
 =?utf-8?B?UkJVNmZabmx1RmdkMyszRVVkRmhnaURFdUJ5SVJONWtJMmhLTTlUWGFXNW9a?=
 =?utf-8?B?NWhGZkM5ZDc2a1JGZUtRQjEzVGFaZkRDSDdrdVJPT3lNM2xHZjQ4UVpxZ3FK?=
 =?utf-8?B?cmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea03c98-1af7-450a-6256-08dbfdf38f38
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2023 04:57:52.6399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2YEEwa7T5256CMMdIwRyoruZrhNMHjGuX+YCRkWAhVjLI+xl60gROXVDHsjDchEPCFQWEMgH5Nbm1Inq9WqFTApcfAFNy/SPsNvfdSflQo0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6147
X-OriginatorOrg: intel.com

Hi James,

On 12/15/2023 9:43 AM, James Morse wrote:
> rmid_ptrs[] is allocated from dom_data_init() but never free()d.
> 
> While the exit text ends up in the linker script's DISCARD section,
> the direction of travel is for resctrl to be/have loadable modules.
> 
> Add resctrl_put_mon_l3_config() to cleanup any memory allocated
> by rdt_get_mon_l3_config().
> 
> There is no reason to backport this to a stable kernel.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Tested-by: Babu Moger <babu.moger@amd.com>
> Reviewed-by: Babu Moger <babu.moger@amd.com>
> ---
> Changes since v5:
>  * This patch is new
> 
> Changes since v6:
>  * Removed struct rdt_resource argument, added __exit markers to match the
>    only caller.
>  * Adedd a whole stack of functions to maintain symmetry.
> 
> Changes since v7:
>  * Moved the eventual kfree() call to be after rdtgroup_exit()
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     |  6 ++++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  1 +
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 15 +++++++++++++++
>  3 files changed, 22 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 19e0681f0435..b5d4b76f97c5 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -992,8 +992,14 @@ late_initcall(resctrl_late_init);
>  
>  static void __exit resctrl_exit(void)
>  {
> +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> +
>  	cpuhp_remove_state(rdt_online);
> +
>  	rdtgroup_exit();
> +
> +	if (r->mon_capable)
> +		rdt_put_mon_l3_config(r);
>  }
>  
>  __exitcall(resctrl_exit);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..f68c6aecfa66 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -546,6 +546,7 @@ void closid_free(int closid);
>  int alloc_rmid(void);
>  void free_rmid(u32 rmid);
>  int rdt_get_mon_l3_config(struct rdt_resource *r);
> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r);
>  bool __init rdt_cpu_has(int flag);
>  void mon_event_count(void *info);
>  int rdtgroup_mondata_show(struct seq_file *m, void *arg);
> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index f136ac046851..5d9864919f1c 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -741,6 +741,16 @@ static int dom_data_init(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +static void __exit dom_data_exit(struct rdt_resource *r)
> +{
> +	mutex_lock(&rdtgroup_mutex);
> +
> +	kfree(rmid_ptrs);
> +	rmid_ptrs = NULL;
> +
> +	mutex_unlock(&rdtgroup_mutex);
> +}
> +
>  static struct mon_evt llc_occupancy_event = {
>  	.name		= "llc_occupancy",
>  	.evtid		= QOS_L3_OCCUP_EVENT_ID,
> @@ -830,6 +840,11 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
>  	return 0;
>  }
>  
> +void __exit rdt_put_mon_l3_config(struct rdt_resource *r)
> +{
> +	dom_data_exit(r);
> +}
> +

I expected the unused resource parameter to be removed because you said ([1]) it would.

>  void __init intel_rdt_mbm_apply_quirk(void)
>  {
>  	int cf_index;

Reinette

[1] https://lore.kernel.org/lkml/c4157536-7e57-0250-dc44-8914f5965ce6@arm.com/

