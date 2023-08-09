Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9518A775363
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjHIHBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjHIHBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:01:19 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 590EA19BC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691564479; x=1723100479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=6wPH99rbiFNYPBC1tGxhU7ZbM6u8WWSbBo7McaqZIbQ=;
  b=Hx9tAOufYH0I0/pnhpImZfW0Frs4OB1Zab2++nfaSgR9IMG7DDfviX++
   LxmLxpemEbGROseWywLLNgbEZNUCmhJWDTiklypIiQRUpavGj5EdVhLRN
   coti1Vf96/ZunCdeQaNK8xARWfUceF9xIcQZ3WgVu7E2ntKViyqjnAy6J
   Xj6IrV523OoemblibghuNhgyss0zn8miGtQkfcgDP25F5z3j//eVTeo3N
   mjCya7heW83hejXSQyeybLHv/yAZ+xSd7znv2ta1/IYiJ/IIbFApYg0u5
   SLx3/OEHiZQjXx4uUrwZY8s9VSQ8by7Q2eZEopSLm2RiW3mZOZ0qSPsAk
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351349797"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="351349797"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 00:01:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062331416"
X-IronPort-AV: E=Sophos;i="6.01,158,1684825200"; 
   d="scan'208";a="1062331416"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2023 00:01:18 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 00:01:18 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 00:01:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 00:01:18 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 00:01:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jj5tNflOOKePdIRpAedcAKEQS1AJM95WdND6mKeaSsjZiQma/LEunMfaR866IN2sQASjT9iHApIkNZuQz7DvsqfkVW7xGqW2eyuRx9g1V+eYr8XbIxUEGDHva2QTUzaI9LcxnoXLr0zc05D7qQpE+CnnoNftpUmFWNNjAqp9pRrhT220v6Wso2LqSjr3Bmke3cgEEYJ9nHwUcAh002PRLqAwU+VglQ668xFzrOoJR+Rdo8n36cUdOkU/QkDeaoUElY791m6fdqSt2WfQaE+sS/U24CriJVQlZ1aAixSC/qFZ1sd4/t4Z9D3p45lpHW8uSjS61zNoH1U9MuR3JXqHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ts9MV0ys+HaUW8FM0XDUEnvjh0AsWJ4zfN1BbQezbHY=;
 b=O7MXjokgOpOCpsZ/3KVM8l7BrNnmtv7oO4zpraAcoWHzwuA579pJuBgtETDYA43ypa5om/EHpcmBbIyaBG77j1IXcyLy7AL68HvndgjiHbxHsszTjV2pmtVS6aHdpPpl2baarw8BQoN23VvxbEULaSxKJi7ApVL/R/ZiAf64QiZ2JSx1CF+V2NyJ+2zkko2rqcHot/6Tgqcm8GLleg87dH1cok5RYbJwlEVZZo2we8Dsi9XLv7nLYsNUJ0pnBRsvXS7dyxPnVwveEZWVX05uP5m38F6oF8+xhzIV6auaRow7t4840BbxE4/x2Jk6KEoi/lG64BAwzz0B/8vFdQW6Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SN7PR11MB7439.namprd11.prod.outlook.com (2603:10b6:806:343::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Wed, 9 Aug
 2023 07:01:16 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 07:01:16 +0000
Date:   Wed, 9 Aug 2023 15:00:58 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
CC:     <mingo@redhat.com>, <peterz@infradead.org>,
        <vincent.guittot@linaro.org>, <linux-kernel@vger.kernel.org>,
        <tj@kernel.org>, <srinivas.pandruvada@intel.com>
Subject: Re: [PATCH] sched/fair: Skip cpus with no sched domain attached
 during NOHZ idle balance
Message-ID: <ZNM5qoUSCdBwNTuH@chenyu5-mobl2>
References: <20230804090858.7605-1-rui.zhang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230804090858.7605-1-rui.zhang@intel.com>
X-ClientProxiedBy: SI1PR02CA0005.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::13) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SN7PR11MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: 972fd49e-14e7-49dc-8b67-08db98a66cce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KavM2yX/rhPXCc7EHogYbwM347HqnehS70xgBSbP3BCsWcBOOUnGey4BwNEUAST2lQ+oqC1BBVP4urIG6OmzRuiEiK8j98Qg9F2c8qlUwPAg/RprbwDDYfmxhR9Tr4HfbB+712rgZ5n9c2qXitkEzYmB9VLr/lU1C1Eplrq14jP5FGfM0Pnb5MRp1ik8eyJcgvpPTiVXVULf+MxzR/YtZ5MkMRkSW7ft+UrVeLV6AeZqKDmeSfzad7zwXX/t4MyIOYhcFDSHm/BdhLS7LN3pA5EjQK61E1LOV1j8CkAU3Lfx+MXslnFtB4eE0YvNviURu7gzcP3WCrBikv6E0jHbBNiM0b5WJWLwzAR9TAq/lvHmLSBBnhKs0IpO+0+JC5A0s3fdCdPZ3g50eoXJIlLzZJKVpqyHKB1IU6YkbXc+botTHFKSKtykUmJquHSUHlkroIUClsKaksBKAeQPMoh7+yLraVFsXdaJyMsxKSOZDKP2tTIaIWPPncypPVjF4merKAnwPMLA80Bl7bEzkJYxJ9vcuqMrb3vk1PDn+wiKxjoa66JEh7h9ccaBOuHVbvCw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(376002)(396003)(366004)(136003)(346002)(39860400002)(1800799006)(451199021)(186006)(6666004)(86362001)(6512007)(82960400001)(9686003)(41300700001)(33716001)(6486002)(26005)(107886003)(6506007)(478600001)(53546011)(6862004)(8936002)(316002)(8676002)(38100700002)(5660300002)(2906002)(6636002)(66556008)(4326008)(66946007)(66476007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wXFsYyvotQT5oX1GMcWKULZv7Xa92ODXp7wPu/MJ8hUQHeWeP75GXFVMzOf7?=
 =?us-ascii?Q?qtcUN2B90FJn+JtAP4qzANP19esrwuxPrSn0PsHXLGet3Gke3W32VMUwVlCr?=
 =?us-ascii?Q?SDtFT4qPvGJs7JoMS0V1RP2hx9FWNBxCuiDdrnd6jncLPJ3uFXTCGMAjWBii?=
 =?us-ascii?Q?Crot3ZCYNgEmvAebg43Yl5raOGFgj8xZMAi/5UZPKYS3EbFRErUd5VKoLMNN?=
 =?us-ascii?Q?j8RvnaQouBhuwBt+B1QSh17AEauH4cr4x8UipfoOwaQJSN9ZZm7nROVIxiLR?=
 =?us-ascii?Q?ptnJy0sO9CF0fhAzBzW8RaESgnCHo9U7+eqZ0OLeFP8c0tprmVV6cbLkRVgH?=
 =?us-ascii?Q?2K0Pf8k4bbkCOUQPwq0d555gNkjdOdTyKVBhA9epY18HHMZFXtGgpJNznf5d?=
 =?us-ascii?Q?hZYM7OykPxqiYr7XUn1k+9mrQyu0dA1h2SlXOoNF9VVHmnqaBtzqHDFWrIqB?=
 =?us-ascii?Q?8IugF8Y6zdKiVznXkO7iLDlb8jPIUduEAEA4I7OHDtREGcj87B20PXFZKvWZ?=
 =?us-ascii?Q?zObQl1xOdsCAHp5hBK5Ej4siqFl0jcR4ICb3VbRGG3UijjM41l0/t6jjiKSI?=
 =?us-ascii?Q?iwmHWidJYsFDgyOptTqaBKxC1QtVyK6vaDwMhqYOZhGBlyhJAD0o48FiNTeI?=
 =?us-ascii?Q?mO1Q1Lu5EbcSWu2FeBqXWuz9SJRhHAGPUP20seqFve0dzTWbQKeDK3o/BkiC?=
 =?us-ascii?Q?nllUdnUVIaF20Tof4ungQWgRbqvylq7zbpum2va4r/bAcbSipklQgqeE4zFj?=
 =?us-ascii?Q?tefubpdnsPgQNSjdQDR6jAo9a6qjyQmTS4EU133bXpuwT875pWJZV2/oW+Lf?=
 =?us-ascii?Q?U5puHAgpBc0ljWotO5tG+RmreXF5UjV07yOkoCvUNgcCSbihLKA5KjAo5bNR?=
 =?us-ascii?Q?oOczynHOO0M1DHcopUibXgrUlp/LKM5UqkBykM/gseAwHPxeph/rAX/uc2Pk?=
 =?us-ascii?Q?Q84gLq78wS2BRKPc5mWvEgLXUgq69Wn5H25rhQ7hVqLiKovGMITXwtZnwyOg?=
 =?us-ascii?Q?U7tZwuVLTTlfwRglB33PNEzwBsqQ1/b9wxIgoZR8aPOzi08I9leCnOsChX0J?=
 =?us-ascii?Q?MZbtU1ddop05bOo0UePI94TgxXD+hin5cgg74oxWdLDbqyk5dQ5H4c6PQ/49?=
 =?us-ascii?Q?gHwKi5Gpg4sWlbXKIoJyerK3UK7SawLWu8kXRW4KK042AMvy/bNh/XceY5sI?=
 =?us-ascii?Q?aOc0neVXhPN8jopXbPXR5V/7DcoIS0KVVe5Jv4k+0+E/XgNeswBVL4t4/rEK?=
 =?us-ascii?Q?KiRe/tX3RqkzMUlBdWwi0YnWLwidLXZ2i/yRa64BAxXZMK6YQrFtXpwNLtfu?=
 =?us-ascii?Q?3aiyLmToG1d2qVkuiANTjwtWJ5aiIsU4lt23Kyj+220ti0aYs4TJQVtKZIXm?=
 =?us-ascii?Q?Tdntjm7pVXPKivNW7eEa36ps/h6ma5EInlXc22SiVvEPVsx0lPdDbVin38J0?=
 =?us-ascii?Q?bb5Q2uQ/MsFuox7WixTLx5UvRtfJhNIkWmcY6gRIgTmPt76LL4TTRe1CoYEn?=
 =?us-ascii?Q?sOxSUe++hL+0asz87vzAxUzitS7hp5hem3WDE8Mg8pB7HwMPUjxJd/Ia1psD?=
 =?us-ascii?Q?hZthRPEeIB5WOMil7unPZRWn10cHxEuTpgRGhMpi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 972fd49e-14e7-49dc-8b67-08db98a66cce
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 07:01:16.3314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0O0pkzEfNPnTE9lUpjt9uG4Cjyb9B1fRcpIoxzgGRFh2PNM0ELERc8HdMkMXIoKzcdbKgV1HENBeo04KW0N4wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7439
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-04 at 17:08:58 +0800, Zhang Rui wrote:
> Problem statement
> -----------------
> When using cgroup isolated partition to isolate cpus including cpu0, it
> is observed that cpu0 is woken up frequenctly but doing nothing. This is
> not good for power efficiency.
> 
> <idle>-0     [000]   616.491602: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
> <idle>-0     [000]   616.491608: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=615996000000 softexpires=615996000000
> <idle>-0     [000]   616.491616: rcu_utilization:      Start context switch
> <idle>-0     [000]   616.491618: rcu_utilization:      End context switch
> <idle>-0     [000]   616.491637: tick_stop:            success=1 dependency=NONE
> <idle>-0     [000]   616.491637: hrtimer_cancel:       hrtimer=0xffff8e8fdf623c10
> <idle>-0     [000]   616.491638: hrtimer_start:        hrtimer=0xffff8e8fdf623c10 function=tick_sched_timer/0x0 expires=616420000000 softexpires=616420000000
> 
> The above pattern repeats every one or multiple ticks, results in total
> 2000+ wakeups on cpu0 in 60 seconds, when running workload on the
> cpus that are not in the isolated partition.
> 
> Rootcause
> ---------
> In NOHZ mode, an active cpu either sends an IPI or touches the idle
> cpu's polling flag to wake it up, so that the idle cpu can pull tasks
> from the busy cpu. The logic for selecting the target cpu is to use the
> first idle cpu that presents in both nohz.idle_cpus_mask and
> housekeeping_cpumask.
> 
> In the above scenario, when cpu0 is in the cgroup isolated partition,
> its sched domain is deteched, but it is still available in both of the
> above cpumasks. As a result, cpu0
> 1. is always selected when kicking idle load balance
> 2. is woken up from the idle loop
> 3. calls __schedule() but cannot find any task to pull because it is not
>    in any sched_domain, thus it does nothing and reenters idle.
> 
> Solution
> --------
> Fix the problem by skipping cpus with no sched domain attached during
> NOHZ idle balance.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  kernel/sched/fair.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b3e25be58e2b..ea3185a46962 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -11340,6 +11340,9 @@ static inline int find_new_ilb(void)
>  		if (ilb == smp_processor_id())
>  			continue;
>  
> +		if (unlikely(on_null_domain(cpu_rq(ilb))))
> +			continue;
> +
>  		if (idle_cpu(ilb))
>  			return ilb;
>  	}

Is it possible to pass a valid cpumask to kick_ilb() via nohz_balancer_kick()
and let find_new_ilb() scan in that mask? So we could shrink the scan range
and also reduce the null domain check in each loop. CPUs in different
cpuset are in different root domains, the busy CPU(in cpuset0) will not ask
nohz idle CPU0(in isolated cpuset1) to launch idle load balance.

struct root_domain *rd = rq->rd;
...
kick_ilb(flags, rd->span)
	 
thanks,
Chenyu
