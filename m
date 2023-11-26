Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5A27F91FC
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjKZJ0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjKZJ0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:26:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4A810A
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 01:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700990772; x=1732526772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IfGPLUFmyqpjdSoVm3r04xpSCIFNTDD8vfkb97v49Wo=;
  b=cDFxmUoOQ2z1rf31c+c1aTz+5E0QnZgKgJc4CC26mQ7kyjvk3o/YNNWW
   2y2DQGRaTYrSWXe5tlBjUDn/rFAMyEpTGsSJgwvvvvqKq4Fi1RVqNunkE
   wkDtPmf8qa/KWYJ0OqXGmYrKY/SKy4mHvyX+DOA2/O8g3+cuTz69laBxg
   p1E9pXs5OP1rMAb/jmU8QettfI4vI8PB3+L2MNPrIuUSeRNeN5k0Et4R4
   aqD279ai99qif/C7/cx3wa8q/Bbpp1eLJ9NEVv8vQ5z3/t4NI2C2sAgdC
   GmEwLLldkUzFo73TEeUpKmye3p0n8XMPIlJbzIb05NbsiqdEpcomCvmI9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10905"; a="396462230"
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="396462230"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2023 01:26:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,228,1695711600"; 
   d="scan'208";a="9516118"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Nov 2023 01:26:11 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 01:26:11 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 26 Nov 2023 01:26:10 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 26 Nov 2023 01:26:10 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 26 Nov 2023 01:26:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WXA17GmSJbUjiFbo+2v9UDIW7tRS9vsbN9ez6BG6ehph57xkOET/O2kg3AA/5Zwf30z3zRLSCgOgPrPPHQV699K8FdffIsHoeWlnMy242VOO6XGNUeZbvA8h3WIJVnunexx/Snq71ocXyzJxAQBrAJ6SfVx0Yl5VPEaWRAOGs+0gLjOtJfJXBOz9Mn+7CnwNCWKC5K6m5RYLdmb8I+uXbaNKB1AMa2T5l4xTlgSJ9EA7xsNufyEhVasoHoLUetXxg2jtBwpku9JKgkKTqh3KLedyW8s71aZoeZrMWkd1OT/xTR3twh/IRjw2L7X7/DdrRoKJfFsOpOG7EZr+A8g5cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJGggY22YBR2J1389QXzzffMgDASgEMdNXtrWZnuKbA=;
 b=O4JTm9SG3Dx8UH6Ekt+XVgpRuRkvbuMhuHT7u6Q/XeTE+0RXL363CN9oDIUDmwrooJU8Iey6bNQf4TCl+XV2N9uHftzRflKHFWDsBHwtBPE95WB8YvbLHIAO0zNBbUK5GkgXGuAzHMtog1SOD7D/uY5qb4ceR7b04dHpuDnpDSpWnItXdFMMHpbn+UysyBwQRXvwbSAxJX860TxAbS4d471xLEnk1bPW8/4vlq3SbsiVHuSTMR1vWV89/HCqD5t5BAclI74eSjAukkBB3mA4W8ToEGKRsJJbv6l7T2Q8uR7dXQ+KNX5J0ql+3jLh/RUaaVmUq/NYlhX5QVTMUY9wGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH0PR11MB7633.namprd11.prod.outlook.com (2603:10b6:510:26c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Sun, 26 Nov
 2023 09:26:07 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::8c24:7666:7047:d99e%4]) with mapi id 15.20.7025.022; Sun, 26 Nov 2023
 09:26:07 +0000
Date:   Sun, 26 Nov 2023 17:25:48 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Madadi Vineeth Reddy <vineethr@linux.ibm.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Vincent Guittot" <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, Aaron Lu <aaron.lu@intel.com>,
        "Dietmar Eggemann" <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Introduce SIS_CACHE to choose previous CPU during
 task wakeup
Message-ID: <ZWMPHC+uWdojgDB3@chenyu5-mobl2.ccr.corp.intel.com>
References: <cover.1700548379.git.yu.c.chen@intel.com>
 <23e9a0f2-be96-4eb6-0242-2865180c1d6c@linux.ibm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <23e9a0f2-be96-4eb6-0242-2865180c1d6c@linux.ibm.com>
X-ClientProxiedBy: SG2P153CA0017.APCP153.PROD.OUTLOOK.COM (2603:1096::27) To
 MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|PH0PR11MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 47017963-6a29-40ad-c3be-08dbee61b72d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hBY/yIQH67M+1IPdTJGYnckByPyQfU5+/FzVQ9ere5gaWZfMBvHox60SRnR5beKogvdE2yZG+ZWrB9XahhzGduzjKkF5UuW2xm+bwNRKCoxri5GkslpDNyweOJGR/uj1E5pWMz9+0LJlcjmBkkReo8uz8VD1t8eYqOWQFKaBQZpOp89dUgu4Yt7zALaNKSlZP/HfaT9ePZtULSXdZkJPOl3UoXuveTr5474SKKhRzguQnqn9cp5UQlitmWT1nAcbv8gIiwPd3Xu5WPelzcQhinlbE5nGEPWZTUASNX+M9uMwL5UB2lGOR6KGlrNPfJZ3IMUWc138ApolrwWZPjoFutGjqXWjpbR136KtkiiAz8fREw8KZzRJI23k+sIxsVRwrEkIG2cHUsaKw+26bq7uEzkfuLzGEBlyrkMFf126iD+dA/WgRALHmTbO4h0/OTq31PbPEizfRG1yIjayAFM4pyK/SG3Sc0jTQ5lAdB33e6fWFlCThpheaw5WVuV+Kf4UP37uwtsX7B+M0D9WwT0qQePSt/gRAZNSFc5dlm7vqHLYtAa3mfSHqheIXzrh7DSS/XDK4tw03+QykDwHYzCjrbeY8K4IIKiNDJ7LAK12mFw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(4326008)(41300700001)(4001150100001)(2906002)(8936002)(8676002)(6512007)(53546011)(6506007)(86362001)(316002)(66476007)(66556008)(66946007)(6916009)(5660300002)(7416002)(54906003)(478600001)(6486002)(6666004)(26005)(82960400001)(83380400001)(38100700002)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KPmTbCVDQS5BfOER0LXpm5q0s8UZFN6w8kG18tnZ0KXECCt7h7ITc6b8AbjX?=
 =?us-ascii?Q?Mzdx5rdenrf6FyQwUcROj5QEnOUb1OC3YXOrh8RJDhnGNXVj5VqqfDDJYnoF?=
 =?us-ascii?Q?/Amw9si0R/LL3RG9DBYuN1SaIZCEGAulzl63MaFLE/rx4nq4vs1beswtQnxe?=
 =?us-ascii?Q?n+U+SG7KRxGyFUgF9ggwTp2gbCyhyK7ZzLC/owto4hclynNmQh0yopaOO24F?=
 =?us-ascii?Q?pJ2hmbRP3mbhQvqVX/iby56u3B8f2WDz+lYoPZh6QwDq23N0r+HikauWIPBZ?=
 =?us-ascii?Q?eW7YB7DqG4Bb5Bv45snNkBET4D1rZmBhmGuNElfHtXrk7cpuYYGwZ9mvfLRE?=
 =?us-ascii?Q?LFkzBYkzjELoX6Ds2+D1IHHDuDs6zo8GWVXYWICLyxmFEnNdAwtURUaarhXx?=
 =?us-ascii?Q?ZDbjSi/St68McemjfrYyBFoVPiYeTooYSe214F30U2UPPtFAecfYrY9yH1Dy?=
 =?us-ascii?Q?SDmTZaNJ8ng9tvBL09+Kkws/AKsc40P2rTsTEWOAkYST05tQ6s24q6xu6AgV?=
 =?us-ascii?Q?SkS+NMRyctTfoc/rA5BmfXmhdXUIk5R+Zlmgl92zYLCMdnFACPIjKvMArnSW?=
 =?us-ascii?Q?07cGgv5JGOvKU3B7TqmdcqIJM1OWnObZTraRTm76nHK94ZfXpQhG4u/aQ2XU?=
 =?us-ascii?Q?3FY6qHS941LTTq/YwCEYNowqbLIR8JH2fXFVM8wuJUTUiXaGvozSr8ZjZ1rY?=
 =?us-ascii?Q?hxitVe2z67Ztk954y8yGRVqepEZIqlPe1Oi3OftTd7/sK+0eZux1fv7ayFzl?=
 =?us-ascii?Q?C1bpKeZ9NTDwLlk/ZLSyfaSrH+xRd5us1gLQjZm4Vedxs4fMUJRf+jL+8Qlm?=
 =?us-ascii?Q?Wje65lNGMuakMaJqSJ6Jf9P/8umR/bDJAfwAZXxphNKZ6sahu75KkWmcPAXv?=
 =?us-ascii?Q?rXEusvZcL4w/Ea24Ls8iXfz+Dd9t46/M/Y1qLam8rQmssH2vnWlvzSaZ/Z39?=
 =?us-ascii?Q?/1CS6yGvmx/L7PZtHb0JQWAQrLylz4e+N+980HB9n6x12WuxiK7/mBxqgVJI?=
 =?us-ascii?Q?ymsTIgHCs5ax45L+4nWVb7s14j38zuUNOwALNpZA03uHk5Y3rQUAea1oYHeU?=
 =?us-ascii?Q?XjO2M3pVZI+vU5ueQlEy9pK9Zs+hxkM2M8tH+p0RtgLpMIsdNu2x+c/VM6GM?=
 =?us-ascii?Q?1utF1CrRfZYWZx8lhc8eBV/lKHyAwAIzC1PxtV8lDOAFqCDZIioK9EOgFem3?=
 =?us-ascii?Q?NWiT3ZEnsyvYOyRx0RnbuCPU/m1Qr4Ijt3+qekudxZitl6HL9uX9b8tYP3dh?=
 =?us-ascii?Q?1dB+8eJnuhAYljtTfzCOFi3myvNcRvGAjl0qNy/rxWwUbpcR+6QZSzS1fVXF?=
 =?us-ascii?Q?+f7+16uOeEqro3jQpseosucKBguwyPCDH9riBXzVSDBHnHxgqAs9KuQKLZO0?=
 =?us-ascii?Q?Z0eW618qC/T9fvnQk2cW1+8QRcwZedb5doujCGknBEwjwd/x786DZfQM5dpf?=
 =?us-ascii?Q?3Hds6jOtUqm6qCABe8BuxvbJuTcSDQMKH3e802oCMy6NNju2qzBZLkKlERx5?=
 =?us-ascii?Q?g/kxGjDucv4brb5e1wBZZdVq/ijU6M2FwW5FqA86q7DE4M7kpZQpqDrwaeeI?=
 =?us-ascii?Q?ONXrzk6DuFLdKrnFhtJgEgInk6P/Nbx5iWfqpTim?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 47017963-6a29-40ad-c3be-08dbee61b72d
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2023 09:26:06.3403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ys1JCPYJ+SxATCIL+luscWrkNi50Qwd3koIkt6ePSlftQ4VEF3x+cKts8rtze6j4SsFBFqWdeaLdpkr+vgEhMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7633
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-26 at 14:14:20 +0530, Madadi Vineeth Reddy wrote:
> Hi Chen Yu,
> 
> On 21/11/23 13:09, Chen Yu wrote:
> > v1  -> v2:
> > - Move the task sleep duration from sched_entity to task_struct. (Aaron Lu)
> > - Refine the task sleep duration calculation based on task's previous running
> >   CPU. (Aaron Lu)
> > - Limit the cache-hot idle CPU scan depth to reduce the time spend on
> >   searching, to fix the regression. (K Prateek Nayak)
> > - Add test results of the real life workload per request from Ingo
> >     Daytrader on a power system. (Madadi Vineeth Reddy)
> >     OLTP workload on Xeon Sapphire Rapids.
> > - Refined the commit log, added Reviewed-by tag to PATCH 1/3
> >   (Mathieu Desnoyers).
> > 
> > RFC -> v1:
> > - drop RFC
> > - Only record the short sleeping time for each task, to better honor the
> >   burst sleeping tasks. (Mathieu Desnoyers)
> > - Keep the forward movement monotonic for runqueue's cache-hot timeout value.
> >   (Mathieu Desnoyers, Aaron Lu)
> > - Introduce a new helper function cache_hot_cpu() that considers
> >   rq->cache_hot_timeout. (Aaron Lu)
> > - Add analysis of why inhibiting task migration could bring better throughput
> >   for some benchmarks. (Gautham R. Shenoy)
> > - Choose the first cache-hot CPU, if all idle CPUs are cache-hot in
> >   select_idle_cpu(). To avoid possible task stacking on the waker's CPU.
> >   (K Prateek Nayak)
> > 
> > Thanks for the comments and tests!
> > 
> > ----------------------------------------------------------------------
> > 
> > This series aims to continue the discussion of how to make the wakee
> > to choose its previous CPU easier.
> > 
> > When task p is woken up, the scheduler leverages select_idle_sibling()
> > to find an idle CPU for it. p's previous CPU is usually a preference
> > because it can improve cache locality. However in many cases, the
> > previous CPU has already been taken by other wakees, thus p has to
> > find another idle CPU.
> > 
> > Inhibit the task migration could benefit many workloads. Inspired by
> > Mathieu's proposal to limit the task migration ratio[1], introduce
> > the SIS_CACHE. It considers the sleep time of the task for better
> > task placement. Based on the task's short sleeping history, tag p's
> > previous CPU as cache-hot. Later when p is woken up, it can choose
> > its previous CPU in select_idle_sibling(). When other task is
> > woken up, skip this cache-hot idle CPU and try the next idle CPU
> > when possible. The idea of SIS_CACHE is to optimize the idle CPU
> > scan sequence. The extra scan time is minimized by restricting the
> > scan depth of cache-hot CPUs to 50% of the scan depth of SIS_UTIL.
> > 
> > This test is based on tip/sched/core, on top of
> > Commit ada87d23b734
> > ("x86: Fix CPUIDLE_FLAG_IRQ_ENABLE leaking timer reprogram")
> > 
> > This patch set has shown 15% ~ 70% improvements for client/server
> > workloads like netperf and tbench. It shows 0.7% improvement of
> > OLTP with 0.2% run-to-run variation on Xeon 240 CPUs system.
> > There is 2% improvement of another real life workload Daytrader
> > per the test of Madadi on a power system with 96 CPUs. Prateek
> > has helped check there is no obvious microbenchmark regression
> > of the v2 on a 3rd Generation EPYC System with 128 CPUs.
> > 
> 
> Tested the patch on power system with 46 cores. Total of 368 CPU's.
> System has 8 NUMA nodes.
> 
> Below are some of the benchmark results.
> 
> schbench(new) 99.0th latency (lower is better)
> ========
> case            load        	baseline[pct imp](std%)       SIS_CACHE[pct imp]( std%)
> normal          1-mthreads      1.00 [ 0.00]( 4.34)            1.02 [ -2.00]( 5.98)
> normal          2-mthreads      1.00 [ 0.00]( 13.95)           1.08 [ -8.00]( 10.39)
> normal          4-mthreads      1.00 [ 0.00]( 6.20)            0.94 [ +6.00]( 10.90)
> normal          6-mthreads      1.00 [ 0.00]( 12.76)           1.03 [ -3.00]( 9.33)
> 
> It seems like schbench is not much impacted with this patch(The pct imp of schbench is within the std%).
> I expected some regression in wakeup latency while searching for an idle cpu which is not cache hot.
> But I guess limiting the search depth had helped.
>

I think so. Cutting the cache-hot cpu scan depth to 50% seems to also cure the regression
reported by Prateek.
 
> 
> producer_consumer avg time/access (lower is better)
> ========
> loads per consumer iteration   baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
> 5                  		1.00 [ 0.00]( 0.00)            0.93 [ +7.00]( 4.77)
> 10                   		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
> 20                    		1.00 [ 0.00]( 0.00)            1.00 [  0.00]( 0.00)
> 
> The main goal of the patch of improving cache locality is reflected as SIS_CACHE only improves in this workload, 
> when loads per consumer iteration is lower.
> 
> 
> hackbench normalized time in seconds (lower is better)
> ========
> case            load        baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
> process-sockets 1-groups     1.00 [ 0.00]( 4.78)            0.99 [ +1.00]( 6.45)
> process-sockets 2-groups     1.00 [ 0.00]( 0.97)            1.02 [ -2.00]( 1.87)
> process-sockets 4-groups     1.00 [ 0.00]( 3.63)            1.01 [ -1.00]( 2.96)
> process-sockets 8-groups     1.00 [ 0.00]( 0.43)            1.00 [  0.00]( 0.27)
> process-pipe    1-groups     1.00 [ 0.00](23.77)            0.88 [+12.00](22.77)
> process-pipe    2-groups     1.00 [ 0.00]( 3.44)            1.03 [ -3.00]( 4.00)
> process-pipe    4-groups     1.00 [ 0.00]( 2.41)            0.98 [ +2.00]( 3.88)
> process-pipe    8-groups     1.00 [ 0.00]( 7.09)            1.07 [ -7.00]( 4.25)
> threads-pipe    1-groups     1.00 [ 0.00](18.47)            1.11 [-11.00](24.21)
> threads-pipe    2-groups     1.00 [ 0.00]( 6.45)            0.97 [ +3.00]( 5.58)
> threads-pipe    4-groups     1.00 [ 0.00]( 5.63)            0.96 [ +2.00]( 5.90)
> threads-pipe    8-groups     1.00 [ 0.00]( 1.65)            1.03 [ -3.00]( 3.97)
> threads-sockets 1-groups     1.00 [ 0.00]( 2.00)            1.00 [  0.00]( 0.65)
> threads-sockets 2-groups     1.00 [ 0.00]( 1.69)            1.02 [ -2.00]( 1.48)
> threads-sockets 4-groups     1.00 [ 0.00]( 5.66)            1.01 [ -1.00]( 3.56)
> threads-sockets 8-groups     1.00 [ 0.00]( 0.26)            0.99 [ +1.00]( 0.36)
> 
> hackbench is not impacted.
> 
> 
> Daytrader throughput (higher is better)
> ========
> instances,users                baseline[pct imp](std%)         SIS_CACHE[pct imp]( std%)
> 3,30                 		1.00 [ 0.00]( 2.30)            1.02 [ +2.00]( 1.64)
> 3,60                 		1.00 [ 0.00]( 0.55)            1.01 [ +1.00]( 1.41)
> 3,90                  		1.00 [ 0.00]( 1.20)            1.02 [ +2.00]( 1.04)
> 3,120                  		1.00 [ 0.00]( 0.84)            1.02 [ +2.00]( 1.02)
> 
> A real life workload like daytrader is benefiting slightly with this patch.
> 
> 
> Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
>

Thanks!

Best,
Chenyu 
> Thanks and Regards
> Madadi Vineeth Reddy
