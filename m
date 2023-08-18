Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2FB780392
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 03:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357137AbjHRBz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 21:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357161AbjHRBzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 21:55:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E84A100
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 18:55:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692323714; x=1723859714;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=z/ochIVUafwiZPN1bzFkAs/EOKyEsbzWFR16jpVsBSk=;
  b=nhypNmlyaUoBN2gpE4p6H8p2VkVi1p6w/SXO4ktQI8QccD7EdXLYD96h
   JQkIrqe7pzaq2fBPIS9hU3PxdAbgMZeF0PnFWcBqQsW5QjIclIbJiVmIH
   3bIl2IanbmqDGYYQEidkxRBcmDIqmjtueZK2pO0Ow4lBBt8ZB/KgMHG/i
   z5VZ+s8v6JGWmyma5JmYIQnevZ6bUrU5v3fx8+Q9SwA65MR2KwnXkmH4h
   4KfnPPvi9AE9IhfAXO64T84NnBRha+mqi6zsEV9ch2enmOyiEhP1YbODG
   NrMkBcajEOZ98wOtSLeRYk8G+Bl/DVpTwk9fZgGEClEUdsP2JBDp2OT/+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="372971695"
X-IronPort-AV: E=Sophos;i="6.01,181,1684825200"; 
   d="scan'208";a="372971695"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 18:55:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="878476822"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga001.fm.intel.com with ESMTP; 17 Aug 2023 18:55:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 18:55:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 18:55:12 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 18:55:12 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 18:55:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEQoorl3aqBxWOPMh8z5yffhyHimVsRnlYbUUAeLmzOXx2CP09ECvoixeSlPB2h0qhL7MVTjZx92twvOCH6D/tUEhOhgtpeaPhQeXcFGb9pGIkBvulmZepUhMw0QVzkMX2/9WHopRNj8i3OZjCh+giRd9wDYnfIEuo+ZwxoSbi/nOdf/KRX8uiZwv2pSIrZYSPUkrQ24mLGAVWdLBlz4/LoGhF2MrbElkkYreYZ7O+HoXVH1CnPwpyRjscCI8ZNTb1ByuqVslWID6T5BqdkymUyb12evUfFqnzmCWX9bkI1J7BgoJj4j4mR1i1hfUemtVYr5ptxYIrsDrBdBKaj5Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAjV7p4kKykL2o5dRxKt0n7GV3n4NlBi3Uo5hDIi4uM=;
 b=LP16EnHhEjPVmSEOJ9DH3h4qTFrXlZrhkvRPxqUU+EsG9ZxpOSFzW+UVR7BH1TPlq6AF3ovDO7/9TifTS7GcOgnBYASDBvE6fd+J8E7klIUWLeIYtJ2jhRWRdMl5hosJ+fIg2KCzB8NjQHr43Y3/kGCWf1JBmBcYxMcT3Pu+ryhcxrc+YsCJwmAiFb6iDAvFzbqh9v48jxU/Ka5vUQoGxsleANGlbrRjr/H5CH+Rzn2/iw6CAJkR3t/aS0PDcu7yPqN6/sLSaYrbqNB8B6nsJtx5awzU6stxAd9rvr5OjaM4RoZzA5Cn+v1XZisgJBLKqd+ZlykJG9qtcRJ7dgOnUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by SA1PR11MB6808.namprd11.prod.outlook.com (2603:10b6:806:24f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.30; Fri, 18 Aug
 2023 01:55:11 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::d9d9:1535:1180:603a%2]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 01:55:11 +0000
Date:   Fri, 18 Aug 2023 09:54:54 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     kernel test robot <oliver.sang@intel.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        "Ingo Molnar" <mingo@kernel.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>
Subject: Re: [tip:sched/eevdf] [sched/fair]  e0c2ff903c:
 phoronix-test-suite.blogbench.Write.final_score -34.8% regression
Message-ID: <ZN7Pbrb3GJyJ+hev@chenyu5-mobl2>
References: <202308101628.7af4631a-oliver.sang@intel.com>
 <ZNWKuccyWnS3UJjK@chenyu5-mobl2.bbrouter>
 <20230814124914.GJ776869@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230814124914.GJ776869@hirez.programming.kicks-ass.net>
X-ClientProxiedBy: SG2P153CA0033.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::20)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6206:EE_|SA1PR11MB6808:EE_
X-MS-Office365-Filtering-Correlation-Id: 07709976-e7ea-41b5-16d2-08db9f8e27f4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqTcmxFL1xs5xoMT3tJPRmQ1GbjW3pVTZffuz4yRyc1fr2OwPI3PMlbtQ+zNJWWgmY/i/7AnqQrO1uDfAQxLBmW8F98bHtAeqMaWgHjK7eXAxaK1rb1bDQDmI5hyJ0KHReqkQJJjFVX7WR8NZfIjNzzw6quqffccrGZSpipku0KriyEL0p+vgxdVZOXfy0QhSvJFP/dHfDe4kdcjLy6zdQq35EPxFahDdRkNSkzFG8OiIUc8W0s0aPh6iUvJt12/+2TyMs3APRMe5K4iV8wG5R1OBoe3APNxSpWv1qGB30tqbYjqfMjhfxT0nBVCLxYEuZpVrRtxOCquuu3uMWHhf/OyTng0HA7ngURPP4Ug4bSYUJXtbQnQ6j1/WY/A9RgwRuTmpi5RKXBuyLNgz3eBHf9p7TggC++kiDbiJsPVEVI/sozOmsD14Xh8aDCydMQJ6RahbHX1a2YmVcBv71tZw1RXwaLqrjXZDC7QpEzpFnpq34PiCgS/5S/EQnBbBZNu89ASXbJB3lo4S3kZsYoR/QY8m+J/2UHNC1V8jbexFOVygLK2vvHvfjJ3r+JFI1LYga+aiScBJg6OdVafcEkNfA00k/ZJNMlmzeCK+fz3rrI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(396003)(366004)(376002)(346002)(39860400002)(186009)(451199024)(1800799009)(33716001)(86362001)(6916009)(4326008)(5660300002)(8936002)(8676002)(83380400001)(2906002)(41300700001)(6666004)(6506007)(9686003)(6486002)(53546011)(26005)(6512007)(966005)(66946007)(478600001)(316002)(54906003)(38100700002)(82960400001)(66556008)(66476007)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i49gMiq6wfd00MBpT9932vOE3Tj/GIRSQprG97NW3unN4csekjk3TTQQw4oP?=
 =?us-ascii?Q?KvlRrEENG3VpwFqHUk1yDSp1LrPD74ouL7A1jGdkaRNP1mOtw94B8EiW8R62?=
 =?us-ascii?Q?4ceM4rFnOx8+b+dMMQDcwV8eG7TnaitSSa9QSx+Hw2BgK3YqXvNxq7bpxBlX?=
 =?us-ascii?Q?oFJSDvqEPd1JFMqH4IbqsrBBtUav6ohNiO5ScfKB1MAnyZItjJ0qgbAHZYpe?=
 =?us-ascii?Q?EFo9VC1PwqTslcBTOZH1erZtry4Nd1xI/BnxEpT1OqInJWDi7vl4fheYtxEv?=
 =?us-ascii?Q?ypm7Oqk7NaXFxyt4Ih2M7jR1OrTPf+WsNTv2MfEG3ELP17d7LGszNmXGnlDT?=
 =?us-ascii?Q?gUmgaHJEW/3sWuw5+u3KVK9nGBICGLIfw5el70W8i+NXCEoE3OJKoYSZXkbu?=
 =?us-ascii?Q?ThOyZxfuaheiV8XFi5uSSPKf3fSBDtxgWJ7scArOUrB0UPzSJuFjhV0eWkJV?=
 =?us-ascii?Q?8J1nRXSNIfp/1RxFKnhygUZbUXEbIa53XIYlwnTKo7GzzQTr5NhkxVb/CKAa?=
 =?us-ascii?Q?Sf3l9YaSKQfay/R9TQfYc/tnKqYzK/3YAxfuvZYIJ8HXx0XwlSgQe8eTfOqL?=
 =?us-ascii?Q?8zfVS73yHIv1dY0nwra2uGIXulYTT3cMqQqm8UQCp1X4zTIodOLkrco/bRr9?=
 =?us-ascii?Q?i8cQTgoyiorJtvnOUYMRLqKhJVebJZFXKWV3HEkW2TEmPNLKWifSA8kKe7db?=
 =?us-ascii?Q?bvbRQopDLGKmy2T9MK+soChcdO4VZJuhYir7zvlJtuRVMp/30R4ctB/W6YpX?=
 =?us-ascii?Q?sa07jHNqnvPk+xK88eetmPkXpA7rtzxLTHzYe2yWkC9hV4OytfSsIvJh0xVK?=
 =?us-ascii?Q?h+Qa8lME0gkDD8A4f0XuVDU5y4I+nN2v+KNwZgRV/4hUKov6GwZvfgxDVJnl?=
 =?us-ascii?Q?U/qU/KGiBaemwuoDl6nJcjRkmoHLVsBf99HcGPQSluXVLbYB0B0FDXSBZenT?=
 =?us-ascii?Q?KMjRwnjSFt0r1mYsz5Apmz3Y5lb+63f5RfO0xB2nawqTXq3ACes43IdC7gkj?=
 =?us-ascii?Q?VNog6epKKIYDYhW3075Khc7/El0iaFsxi06/Z7toMq7PnX6NAwwPT1Xr9LFw?=
 =?us-ascii?Q?2tOIIb95zt5EiTPXSb5Aq0XQbtX8/pERMG0PS+pmQUuLAIpDGI7lX3hy2aUy?=
 =?us-ascii?Q?NZzA34dv6ZVJEJCQujwP/i7ZVCdYsu9gCD/2Vyt2/qdgMLmKAXwKw1G6EpaD?=
 =?us-ascii?Q?uZBmFNL2aJ5iaaLE+X+OQoTxTjKYDhf9Qlg/SEB0CZfeS/9F8qqNzx48x5ZF?=
 =?us-ascii?Q?ZcDNpJFoaJIUX+u0vIn07CZliaQVJ1XfecvZW2awl+dvyzEoNthJLxZXUcJA?=
 =?us-ascii?Q?HeB70+ae66ynnKQgTvecsRWAh/0g0ZNKOJAZLmyw2F7VIH2OOhz3CIYIprjW?=
 =?us-ascii?Q?7gTlU7elXRbrW7omwbTxA7uam+ylt7ZxT8IDbAx1ujXtjW6cYzUU+gBB2PvY?=
 =?us-ascii?Q?3hjwrqhEDCsX569Cf94aiEtZ671BOrDwCb7YOzt0lr2yzSSm/15+1Oed5yMD?=
 =?us-ascii?Q?szfXVp/9ZT8ccdCmc3ufZKOQkFDR3MEGu97JC6+VF6Oe2yvs500ZhgGGIEHB?=
 =?us-ascii?Q?IkSnAR1bbp1TsN2cKJpYeEutyo/ld08qTyxLorSi?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 07709976-e7ea-41b5-16d2-08db9f8e27f4
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 01:55:10.9324
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rE3pBkD+CstSZfiqrJdgQk/sU/ggsFV9WDYRRIsbrN61LHuptvCQBdJwh15GZNA+X8z3bl5dv++jtaWchpDlOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6808
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-08-14 at 14:49:14 +0200, Peter Zijlstra wrote:
> On Fri, Aug 11, 2023 at 09:11:21AM +0800, Chen Yu wrote:
> > On 2023-08-10 at 21:24:37 +0800, kernel test robot wrote:
> > > 
> > > 
> > > Hello,
> > > 
> > > kernel test robot noticed a -34.8% regression of phoronix-test-suite.blogbench.Write.final_score on:
> > > 
> > > 
> > > commit: e0c2ff903c320d3fd3c2c604dc401b3b7c0a1d13 ("sched/fair: Remove sched_feat(START_DEBIT)")
> > > https://git.kernel.org/cgit/linux/kernel/git/tip/tip.git sched/eevdf
> > > 
> > > testcase: phoronix-test-suite
> > > test machine: 96 threads 2 sockets Intel(R) Xeon(R) Gold 6252 CPU @ 2.10GHz (Cascade Lake) with 512G memory
> > > parameters:
> > > 
> > > 	test: blogbench-1.1.0
> > > 	option_a: Write
> > > 	cpufreq_governor: performance
> > > 
> 
> Is this benchmark fork() heavy?
>

It is not fork() heavy. After created the threads, it becomes a
loop to write to some files.
 
> > It seems that commit e0c2ff903c32 removed the sched_feat(START_DEBIT) for initial
> > task, but also increases the vruntime for non-initial task:
> > Before the e0c2ff903c32, the vruntime for a enqueued task is:
> > cfs_rq->min_vruntime
> > After the e0c2ff903c32, the vruntime for a enqueued task is:
> > avg_vruntime(cfs_rq) = \Sum v_i * w_i / W
> >                      = \Sum v_i / nr_tasks
> > which is usually higher than cfs_rq->min_vruntime, and we give less sleep bonus to
> > the wakee, which could bring more or less impact to different workloads.
> > But since later we switched to lag based placement, this new vruntime will minus
> > lag, which could mitigate this problem. 
> 
> Right.. but given this problem was bisected through the lag based
> placement to this commit, I wondered about fork() / pthread_create().
> 
> If this is indeed fork()/pthread_create() heavy, could you please see if
> disabling PLACE_DEADLINE_INITIAL helps?

Tested with PLACE_DEADLINE_INITIAL disabled, no much difference is observed.

The baseline is Commit 246c6d7ab4d0 ("sched/eevdf: Better handle mixed slice length")

PLACE_DEADLINE_I   NO_PLACE_DEADLINE_INITIAL
---------------- ---------------------------
       fail:runs  %reproduction    fail:runs
           |             |             |
      4166            -4.7%       3969        phoronix-test-suite.blogbench.Write.final_score
    330.88            +4.4%     345.49        phoronix-test-suite.time.elapsed_time
    330.88            +4.4%     345.49        phoronix-test-suite.time.elapsed_time.max
    150672            -0.0%     150640        phoronix-test-suite.time.file_system_inputs
  29947344            -2.2%   29277840        phoronix-test-suite.time.file_system_outputs
   1954038            -0.3%    1947949        phoronix-test-suite.time.involuntary_context_switches
    163.00            +1.2%     165.00        phoronix-test-suite.time.major_page_faults
     32256            +0.7%      32472        phoronix-test-suite.time.maximum_resident_set_size
    152607            -1.1%     150874        phoronix-test-suite.time.minor_page_faults
      4096            +0.0%       4096        phoronix-test-suite.time.page_size
      8169            -5.0%       7764        phoronix-test-suite.time.percent_of_cpu_this_job_got
     26616            -0.9%      26374        phoronix-test-suite.time.system_time
    416.59            +8.3%     450.98        phoronix-test-suite.time.user_time
   1764497            -0.8%    1749992        phoronix-test-suite.time.voluntary_context_switches


blogbench.Write.final_score on different commits in eevdf branch:

sched/fair: Add cfs_rq::avg_vruntime
5217

sched/fair: Remove sched_feat(START_DEBIT)
3223

sched/fair: Add lag based placement
2736

sched/fair: Implement an EEVDF-like scheduling policy
3942

sched/fair: Commit to EEVDF
3957

sched/eevdf: Better handle mixed slice length
3836


It seems that, "Remove sched_feat(START_DEBIT)" brings some impact
and "Implement an EEVDF-like scheduling policy" restores some
throughput. The score from "sched/fair: Add lag based placement"
might not be reliable that, in place_entity() it scales the vlag
based on se->load.weight directly, while
"Implement an EEVDF-like scheduling policy" fixes that by using
scale_load_down().

I'll check what RUN_TO_PARITY brings to blogbench.

thanks,
Chenyu

