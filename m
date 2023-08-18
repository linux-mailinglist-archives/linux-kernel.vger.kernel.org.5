Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A75D780774
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358751AbjHRItY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358758AbjHRItV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:49:21 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F6930E6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:49:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6J0m3U9faqy1MDP2991z3KeJx0f9vdhlYTwb6Zg4DwdXZiRcXr6ldrc6SejOnA/fg26stqxD6XaA84NjQTbO3/ynAqcoxNgAzHb8F1J235fuExXAQS4wp4YloGPYGy+8VDPkzt/mPh23JTMOEURG9lIejNz5zufBZ2Jzu7aaOtMR2bCVDYswzBmLCn4Nd/XgIGHEqxvuCGZVhYqcZqOZz+8+CxuLu74BU73/sj73vHIvKx3QpyXkyun7ByS6lu1pq26I44cEZ9AbtRQ+jlok4oS09SIEGPJYilkZb+y3RiCZpY5kmXAd/mw2GIYcWrr8hskE9LJNQjaGGtdrum7eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GomqI4nh9fJAuDTaHAJf3whjWUgG40nP3hUIfomEhks=;
 b=DIKXjOuL+eT/qPrB8z2n0geN9slVXrrGdsewBIupCYvUqivef+AEq1ZY8S6+3DLRosjI/y2SYmTpwJCTaoZX9KjN43Xbrl2EqVGNUj9FP6x5fh/AWZyPJ99wYfQQBVSULKUc1pEdvhlfQvszwalDy3Y0CIUvUx+ftbyy+eheWCjcaJ98voPOOdMJTPuMvKBjsnPCDB85vAakeVOo7/AVjM4bhY4TY6RMd+ODi+Xh4c60HR7nGG2ibf4Fp1xdMUkFklFDU9nadfC+hRiZ+mSfalAvvA9NoDMrGjcUJtGsjNZG9AsZskyFI1y6tl9tLOraK6YCrjKiujAJrOjrMjx4tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GomqI4nh9fJAuDTaHAJf3whjWUgG40nP3hUIfomEhks=;
 b=nEyrwQd/9fA06BU7db435gLp5JVoV/WFpBkxtTXEHd6wNVmtqGe+hn3XHyeI6d0rXQIZTQhUTK8UjYZhZ399eV4ZuRgS8az6FLUNsOsBm/v/q5BxYp/VzaH+swUrLKuVjfVijtuxKyYPQxHFjZs8GsGP236PYsa+MG4YNPr13Eg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB8252.namprd12.prod.outlook.com (2603:10b6:8:ee::7) by
 PH7PR12MB6833.namprd12.prod.outlook.com (2603:10b6:510:1af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 08:49:16 +0000
Received: from DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab]) by DS7PR12MB8252.namprd12.prod.outlook.com
 ([fe80::6769:d6da:514c:90ab%7]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 08:49:16 +0000
Date:   Fri, 18 Aug 2023 14:19:03 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     David Vernet <void@manifault.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, tj@kernel.org,
        roman.gushchin@linux.dev, kprateek.nayak@amd.com,
        aaron.lu@intel.com, wuyun.abel@bytedance.com, kernel-team@meta.com
Subject: Re: [PATCH v3 0/7] sched: Implement shared runqueue in CFS
Message-ID: <ZN8wfiAVttkNnFDe@BLR-5CG11610CF.amd.com>
References: <20230809221218.163894-1-void@manifault.com>
 <ZN3dW5Gvcb0LFWjs@BLR-5CG11610CF.amd.com>
 <20230818050355.GA5718@maniforge>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818050355.GA5718@maniforge>
X-ClientProxiedBy: PN2PR01CA0228.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:eb::16) To DS7PR12MB8252.namprd12.prod.outlook.com
 (2603:10b6:8:ee::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB8252:EE_|PH7PR12MB6833:EE_
X-MS-Office365-Filtering-Correlation-Id: 525ed619-8cdc-4cd5-bca8-08db9fc800b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xJ9nlo3U0QvrrMyXg9WNqD7KHKz6ovxsqI6Mz+QIlomJGhLGmfVnryqhUR/r/RFi9LU1i5bKTKxAqRIZPfFD431igg2Ddxp/yttpqfryMSeoTjuLpX6R9ZGPEpEhn5u/J0W6sK0eHE57eqX8QprGouGlnm/bR7o1aCbc22Am22w9VH+wuGRLlYLWHSV1QMFYUMRN81kIPEl2/oUXDpABvMh4SPoYQOvs21ktIKUlrZN6V53saEjWXrtw5EX9Wfi07FI/a2yd/9ytDQ829J8g2GnNHCxRyYzBJX0P59zKJ1xTpXhto/mO42wnPciBiRADxZGGcn2MIKNOzrLSRf1W/+lrKfJpjhpbPrN/mBRJdvLDpGZ1dtru7VbXCVWCpkaEpmyMy2ZyvAThnFHQv9eiIdH5XiFYXiIIOZ0w5vj4FkvN/pBjE7ukiteQhZTxHOccMMmdAy7qaxa2aV8iUEiFlrdw3E83TAJaccao9sovp8FVuMw9hhIlzF78FhKSTW3A1YDBz3mO/AfCkpZ84uW9l4fCixnLizCT9QRjPW1AD+m+57t5kCWwdQG1KU+EbNiTNzHIp2SpqgS/acfQMyQUMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB8252.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(39860400002)(346002)(136003)(396003)(451199024)(186009)(1800799009)(86362001)(83380400001)(30864003)(8936002)(8676002)(4326008)(5660300002)(2906002)(41300700001)(26005)(6666004)(6506007)(6512007)(6486002)(966005)(478600001)(7416002)(66476007)(316002)(6916009)(38100700002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PQhpRGnlTQfCETy0Omb96wRJcnkk7dIJ8t7KAoJMEfUSYI7FzjfAwOyWOYWm?=
 =?us-ascii?Q?gpIZ+zHsh/CIaMbTGhHKuaaNNRUEnDWGsOlYECb40qTF3XiuARP6qYkRTLfJ?=
 =?us-ascii?Q?v2sLW6yY8aHaBEAzZ1YIDpl9KjnRk702rc9MPkNQXsNNpyMchWHH4ZpAAJyV?=
 =?us-ascii?Q?xqUvqUvT4tTs7AWYXw+4DPPn6Dhns5WDRZUcPQt4u5N3Ni+7/p26sgC0MzGD?=
 =?us-ascii?Q?D6bNn13fkADwgX2Z12hm2T/1Jvw+VfKUB9WpgVRWG9GeowUy1rYEP5OT8Vrf?=
 =?us-ascii?Q?m71fEvkbyIqD/frvS87rYBGK6u8veNZrQhSCIP/lTXqvyGRLzpjChbeVA7az?=
 =?us-ascii?Q?QO5FkGhLHCUxMBJT69K+y1EqXjKiawf6TUB2SK6yXgIMMPI/wPnx5tWmOlr2?=
 =?us-ascii?Q?MfC/QCAnmBWwMf1aLMTVMcb9FFZ2KPLAU317rl+vitzLilSfhCKFYa+dDeFx?=
 =?us-ascii?Q?PZjlEHDLifsFCLuTcX6cJK6afN9NKYNsRMkfaP9aFlMBRiAroPX2DS9fhjnH?=
 =?us-ascii?Q?yBNfl6pTFwC7eYLFhmqb1aVxArFJWR/zhenfr0CULe/+kJCRgfZYe+E41+wS?=
 =?us-ascii?Q?O6zFj0/qHRn8Ngz0V6JU5xh0JY9ujMGvo2KShDqqSXo/Z1g3tAoVs6vFXZGH?=
 =?us-ascii?Q?yvZCwhMKooRj7f86DJRk0RBvCIe3VO7DKyNvKKqdkaYwM0/RP0NLnZr4JypK?=
 =?us-ascii?Q?KhmRShEgF9Ka6+a173p5ej15IFO5fpgrQli2wn145pT+1BI8Vp28ylwder5p?=
 =?us-ascii?Q?sEeedtFxwgVo+5aVcL50U4A2NpXqScsLiSdxfHvqEsgEsILICycuaYLlxbaq?=
 =?us-ascii?Q?QQANbiUzs5XDOuo9Dru7hurxWsfzpk6vGUA6hz1GJ+vxNr0/EiFxrmGsPoNs?=
 =?us-ascii?Q?I5q+6J0eXECiOFlzkt0riaSCUZDGqtMnW9QmNjhJhu+4zJNuAI3O+EmyLE0t?=
 =?us-ascii?Q?lbR6gWNdh2AzVH/iNUNRtFL37SBA8NQEjGG3a+iyttOfYwvROgC/xJ3HPP05?=
 =?us-ascii?Q?tQ4KzWrIiuQSNJ4eybe0DyqdzhHIZxuOO6zWPXr35JOYwhYmI+2xucGRF+DX?=
 =?us-ascii?Q?4ktLokXV1H7egHDWE3uNbXmMbX6rOJSM7wnRvOquD7IbPwxA5HjZmW+Ga6QM?=
 =?us-ascii?Q?U4WU8GwhsIz2twyZO06YFA/uA4GgSfhMuu4ilTJsBYlghWs3VuofZvaCMs2n?=
 =?us-ascii?Q?r6ITXWGDbQc1EJ9YDPpHxYO3grxinFlKkoeCU0ncWhr5d0uvKYeMiNZtrsW1?=
 =?us-ascii?Q?YVAG1HehIYZkc3K1KWYIjuYHhi5ulwcJDqXTpcyus6hJ5LdmuPFBYgCKBGp3?=
 =?us-ascii?Q?/RUApsxUtfnkDBnS0GN7LZjdaJXkKPKnVYGzSStMAW6+wNnwnI+FFwxfQXVo?=
 =?us-ascii?Q?HeN5/xcSXu1KPXREFIHMCJhXXa3/MHjC4zIVdUW8eA05U/BM4Ql19adG2Jr7?=
 =?us-ascii?Q?hyNRyxtBmmUURLiL25Xa2hSYSUYLzdeTMPUkbI9xiEJb6ENDgQ7qQQLKzeg0?=
 =?us-ascii?Q?Qc4aKtlgoeYl9xmzKgWPZyMXI0AdAKwXCdgAOFiU+YogrNg7R4o4shjDOQH0?=
 =?us-ascii?Q?nw0V3kg4bsnoYdoclBBJFTn68id3t9eQSr7ILZzm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 525ed619-8cdc-4cd5-bca8-08db9fc800b9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB8252.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 08:49:15.9637
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0wyhQc5uTlHfilAQ7gd2wCZXmeEK/91V/y9SoJSR98/z2s7GNYoHbIfUsbpc9LIbw+FFrKD5T+HV+BJdKsVd8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6833
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Fri, Aug 18, 2023 at 12:03:55AM -0500, David Vernet wrote:
> On Thu, Aug 17, 2023 at 02:12:03PM +0530, Gautham R. Shenoy wrote:
> > Hello David,
> 
> Hello Gautham,
> 
> Thanks a lot as always for running some benchmarks and analyzing these
> changes.
> 
> > On Wed, Aug 09, 2023 at 05:12:11PM -0500, David Vernet wrote:
> > > Changes
> > > -------
> > > 
> > > This is v3 of the shared runqueue patchset. This patch set is based off
> > > of commit 88c56cfeaec4 ("sched/fair: Block nohz tick_stop when cfs
> > > bandwidth in use") on the sched/core branch of tip.git.
> > 
> > 
> > I tested the patches on Zen3 and Zen4 EPYC Servers like last time. I
> > notice that apart from hackbench, every other bechmark is showing
> > regressions with this patch series. Quick summary of my observations:
> 
> Just to verify per our prior conversation [0], was this latest set of
> benchmarks run with boost disabled?

Boost is enabled by default. I will queue a run tonight with boost
disabled.

> Your analysis below seems to
> indicate pretty clearly that v3 regresses some workloads regardless of
> boost, but I did just want to double check regardless just to bear it in
> mind when looking over the results.
> 
> [0]: https://lore.kernel.org/all/ZMn4dLePB45M5CGa@BLR-5CG11610CF.amd.com/
> 
> > * With shared-runqueue enabled, tbench and netperf both stop scaling
> >   when we go beyond 32 clients and the scaling issue persists until
> >   the system is overutilized. When the system is overutilized,
> >   shared-runqueue is able to recover quite splendidly and outperform
> >   tip.
> 
> Hmm, I still don't understand why we perform better when the system is
> overutilized. I'd expect vanilla CFS to perform better than shared_runq
> in such a scenario in general, as the system will be fully utilized
> regardless.

My hunch is that when every rq is equally loaded, we perhaps don't
have so much time to spend doing newidle load balance at higher levels
because any idle CPU will likely find a task to pull from the shared
runqueue.

IOW, the shared runqueue feature is generally useful, but we need to
figure out why are we doing excessive load-balance when the system is
moderately utilized.


[..snip..]

> > 
> > ==================================================================
> > Test          : tbench 
> > Units         : Normalized throughput 
> > Interpretation: Higher is better 
> > Statistic     : AMean 
> > ==================================================================
> > Clients:  tip[pct imp](CV)       sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
> >    32     1.00 [  0.00]( 2.90)     0.44 [-55.53]( 1.44)     0.98 [ -2.23]( 1.72)
> >    64     1.00 [  0.00]( 1.02)     0.27 [-72.58]( 0.35)     0.74 [-25.64]( 2.43)
> >   128     1.00 [  0.00]( 0.88)     0.19 [-81.29]( 0.51)     0.52 [-48.47]( 3.92)
> >   256     1.00 [  0.00]( 0.28)     0.17 [-82.80]( 0.29)     0.88 [-12.23]( 1.76)
> 
> Just to make sure we're on the same page, "CV" here is the coefficient
> of variation (i.e. standard deviation / mean), correct?

Yes, CV is coefficient of variance : Ratio of the standard deviation
to the mean.


[..snip..]

> > So, I counted the number of times the CPUs call find_busiest_group()
> > without and with shared_rq and the distribution is quite stark.
> > 
> > =====================================================
> > per-cpu             :          Number of CPUs       :
> > find_busiest_group  :----------------:--------------:
> > count               :  without-sh.rq :  with-sh.rq  :
> > =====================================:===============
> > [      0 -  200000) :     77
> > [ 200000 -  400000) :     41
> > [ 400000 -  600000) :     64
> > [ 600000 -  800000) :     63
> > [ 800000 - 1000000) :     66
> > [1000000 - 1200000) :     69
> > [1200000 - 1400000) :     52
> > [1400000 - 1600000) :     34              5
> > [1600000 - 1800000) :     17		 31
> > [1800000 - 2000000) :      6		 59
> > [2000000 - 2200000) :     13		109
> > [2200000 - 2400000) :      4		120
> > [2400000 - 2600000) :      3		157
> > [2600000 - 2800000) :      1		 29
> > [2800000 - 3000000) :      1		  2
> > [9200000 - 9400000) :      1
> > 
> > As you can notice, the number of calls to find_busiest_group() without
> > the shared.rq is greater at the lower end of distribution, which
> > implies fewer calls in total. With shared-rq enabled, the distribution
> > is normal, but shifted to the right, which implies a lot more calls to
> > find_busiest_group().
> 
> Huh, that's very much unexpected for obvious reasons -- we should be
> hitting the load_balance() path _less_ due to scheduling tasks with the
> shared_runq.

I would like to verify what is the shared_rq hit-ratio when the system
is moderately loaded, while running short-running tasks such as
tbench/netperf. My hunch is that in the moderately loaded case, the
newly idle CPUs are not finding any task in the shared-runqueue.


> 
> > To investigate further, where this is coming from, I reran tbench with
> > sched-scoreboard (https://github.com/AMDESE/sched-scoreboard), and the
> > schedstats shows the the total wait-time of the tasks on the runqueue
> > *increases* by a significant amount when shared-rq is enabled.
> > 
> > Further, if you notice the newidle load_balance() attempts at the DIE
> > and the NUMA domains, they are significantly higher when shared-rq is
> > enabled. So it appears that a lot more time is being spent trying to
> > do load-balancing when shared runqueue is enabled, which is counter
> > intutitive.
> 
> Certainly agreed on it being counter intuitive. I wonder if this is due
> to this change in the latest v3 revision [1]:
> 
> @@ -12093,6 +12308,16 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
>  	rcu_read_lock();
>  	sd = rcu_dereference_check_sched_domain(this_rq->sd);
>  
> +	/*
> +	 * Skip <= LLC domains as they likely won't have any tasks if the
> +	 * shared runq is empty.
> +	 */
> +	if (sched_feat(SHARED_RUNQ)) {
> +		sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
> +		if (likely(sd))
> +			sd = sd->parent;
> +	}
> +
>  	if (!READ_ONCE(this_rq->rd->overload) ||
>  	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
> 
> [1]: https://lore.kernel.org/all/20230809221218.163894-7-void@manifault.com/
> 
> I originally added this following Peter's suggestion in v2 [2] with the
> idea that we'd skip the <= LLC domains when shared_runq is enabled, but
> in hindsight, we also aren't walking the shared_runq list until we find
> a task that can run on the current core. If there's a task, and it can't
> run on the current core, we give up and proceed to the rest of
> newidle_balance(). So it's possible that we're incorrectly assuming
> there's no task in the current LLC because it wasn't enqueued at the
> head of the shared_runq. I think we'd only want to add this improvement
> if we walked the list as you tried in v1 of the patch set, or revert it
> otherwise.

Yes, the optimization does make sense if we are sure that there are no
tasks to be pulled in the SMT and the MC domain. Since I am not
pinning any tasks, if a newly idle CPU is doing load-balance it is
very likely because the shared-rq is empty. Which implies that the the
SMT and MC domains are not overloaded.

But that also means exploring load-balance at a fairly large DIE
domain much early on. And once we go past the should_we_balance()
check, we bail out only after doing the find_busiest_group()/queue,
which can take quite a bit of time on a DIE domain that spans 256
threads. By this time, if a task was woken up on the CPU, it would
have to wait for the load-balance to complete.

In any case, this can be easily verified by reverting the
optimization.

> 
> [2]: https://lore.kernel.org/lkml/20230711094547.GE3062772@hirez.programming.kicks-ass.net/
> 
> Would you be able to try running your benchmarks again with that change
> removed, or with your original idea of walking the list added?

I will queue this for later today.

> I've
> tried to reproduce this issue on my 7950x, as well as a single-socket /
> CCX 26 core / 52 thread Cooper Lake host, but have been unable to. For
> example, if I run funccount.py 'load_balance' -d 30 (from [3]) while
> running the below netperf command on the Cooper Lake, this is what I
> see:
> 
> for i in `seq 128`; do netperf -6 -t UDP_RR -c -C -l 60 & done
> 
> NO_SHARED_RUNQ
> --------------
> FUNC                                    COUNT
> b'load_balance'                         39636
> 
> 
> SHARED_RUNQ
> -----------
> FUNC                                    COUNT
> b'load_balance'                         32345
> 
> [3]: https://github.com/iovisor/bcc/blob/master/tools/funccount.py
> 
> The stack traces also don't show us running load_balance() excessively.
> Please feel free to share how you're running tbench as well and I can
> try that on my end.

This is how I am running tbench:

# wget https://www.samba.org/ftp/tridge/dbench/dbench-4.0.tar.gz
# tar xvf dbench-4.0.tar.gz
# cd dbench-4.0
# ./autogen.sh
# ./configure 
# make
# nohup ./tbench_srv 0 &
# ./tbench -t 60 <nr-clients> -c ./client.txt


[..snip..]

> 
> > ==================================================================
> > Test          : hackbench 
> > Units         : Normalized time in seconds 
> > Interpretation: Lower is better 
> > Statistic     : AMean 
> > ==================================================================
> > Case:        tip[pct imp](CV)        sh_rq_v3[pct imp](CV)    sh_rq_v3_tgload_fix[pct imp](CV)
> >  1-groups     1.00 [  0.00]( 8.41)     0.96 [  3.63]( 6.04)     0.94 [  6.48]( 9.16)
> >  2-groups     1.00 [  0.00](12.96)     0.96 [  4.46]( 9.76)     0.89 [ 11.02]( 8.28)
> >  4-groups     1.00 [  0.00]( 2.90)     0.85 [ 14.77]( 9.18)     0.86 [ 14.35](13.26)
> >  8-groups     1.00 [  0.00]( 1.06)     0.91 [  8.96]( 2.83)     0.94 [  6.34]( 2.02)
> > 16-groups     1.00 [  0.00]( 0.57)     1.19 [-18.91]( 2.82)     0.74 [ 26.02]( 1.33)
> 
> Nice, this matches what I observed when running my benchmarks as well.

Yes, hackbench seems to benefit from the shared-runqueue patches, more
so with Aaron's ratelimiting patch.

[..snip..]


> > Test          : netperf 
> 
> Could you please share exactly how you're invoking netperf? Is this
> with -t UDP_RR (which is what Aaron was running with), or the default?

No, this is how I am invoking netperf.

Having started the netserver that is listening in on 127.0.0.1,

I run N copies of the following command, where N is the number of clients.

netperf -H 127.0.0.1 -t TCP_RR -l 100 -- -r 100 -k REQUEST_SIZE,RESPONSE_SIZE,ELAPSED_TIME,THROUGHPUT,THROUGHPUT_UNITS,MIN_LATENCY,MEAN_LATENCY,P50_LATENCY,P90_LATENCY,P99_LATENCY,MAX_LATENCY,STDDEV_LATENCY

> 
> [...]
> 
> As far as I can tell there weren't many changes between v2 and v3 that
> could have caused this regression. I strongly suspect the heuristic I
> mentioned above, especially with your analysis on us excessively calling
> load_balance().

Sure. I will get back once I have those results.

> 
> Thanks,
> David

--
Thanks and Regards
gautham.
