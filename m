Return-Path: <linux-kernel+bounces-128191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7C89895757
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBB1D1C219A0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC26612BF27;
	Tue,  2 Apr 2024 14:42:08 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8B135A6D;
	Tue,  2 Apr 2024 14:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068928; cv=none; b=aAlWJvXc3+bLi0jg0mQz+mQHMxrfAlLsjvVLhSyJfVk9xxTy1oKCPSs/dpKuGewa4YTXqnwnN3K+r4t4vczPnKGyhrznGvHtGtAUYyc1xqvhhS0brnSaD5xojocbGbV1gP0hcKaX3LjYvQarLpNyBoNahfQg4j89PgIctc9G1Hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068928; c=relaxed/simple;
	bh=/AAqIDQjFV7gvCRqscag5yk5TdtfYJl3vulAQY42ikA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uqhBm6ZKHdV2NVU/qf5CEesPLaRNseHU7izgn1iFGUZaO3rtAcwoZpE+auKec13W/3SeJEHkBFfsaBBitMUD/MY+m3nU/R4JnXeHVj07SK0LaENPwDZ4A5qetb7plXaRwNrpHpjAOrmUScEN71ktgLgcdNp6T9nsOrryV4bGCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6268A1007;
	Tue,  2 Apr 2024 07:42:36 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.17.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C08043F64C;
	Tue,  2 Apr 2024 07:42:02 -0700 (PDT)
Date: Tue, 2 Apr 2024 15:41:51 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Dawei Li <dawei.li@shingroup.cn>
Cc: will@kernel.org, xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	yangyicong@hisilicon.com, jonathan.cameron@huawei.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] perf: Avoid explicit cpumask var allocation from
 stack
Message-ID: <ZgwZL679Tc1S3AxH@FVFF77S0Q05N>
References: <20240402105610.1695644-1-dawei.li@shingroup.cn>
 <ZgvoMunpbaE-x3jV@FVFF77S0Q05N>
 <190FE91C35AB9AE8+ZgwKuORh3VzTkfeJ@centos8>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190FE91C35AB9AE8+ZgwKuORh3VzTkfeJ@centos8>

On Tue, Apr 02, 2024 at 09:40:08PM +0800, Dawei Li wrote:
> Hi Mark,
> 
> Thanks for the quick review.
> 
> On Tue, Apr 02, 2024 at 12:12:50PM +0100, Mark Rutland wrote:
> > On Tue, Apr 02, 2024 at 06:56:01PM +0800, Dawei Li wrote:
> > > Hi,
> > > 
> > > This series try to eliminate direct cpumask var allocation from stack
> > > for perf subsystem.
> > > 
> > > Direct/explicit allocation of cpumask on stack could be dangerous since
> > > it can lead to stack overflow for systems with big NR_CPUS or
> > > CONFIG_CPUMASK_OFFSTACK=y.
> > > 
> > > For arm64, it's more urgent since commit 3fbd56f0e7c1 ("ARM64: Dynamically
> > > allocate cpumasks and increase supported CPUs to 512").
> > > 
> > > It's sort of a pattern that almost every cpumask var in perf subystem
> > > occurs in teardown callback of cpuhp. In which case, if dynamic
> > > allocation failed(which is unlikely), we choose return 0 rather than
> > > -ENOMEM to caller cuz:
> > > @teardown is not supposed to fail and if it does, system crashes:
> > 
> > .. but we've left the system in an incorrect state, so that makes no sense.
> > 
> > As I commented on the first patch, NAK to dynamically allocating cpumasks in
> > the CPUHP callbacks. Please allocate the necessry cpumasks up-front when we
> > probe the PMU. At that time we can handle an allocation failure by cleaning up
> > and failing to probe the PMU, and then the CPUHP callbacks don't need to
> > allocate memory to offline a CPU...
> 
> Agreed that dynamically allocation in callbacks lead to inconsistency
> to system.
> 
> My (original)alternative plan is simple but ugly, just make cpumask var
> _static_ and add extra static lock to protect it.
> 
> The only difference between solution above and your proposal is static/
> dynamic alloction. CPUHP's teardown cb is supposed to run in targetted
> cpuhp thread for most cases, and it's racy. Even the cpumask var is
> wrapped in dynamically allocated struct xxx_pmu, it's still shareable
> between different threads/contexts and needs proper protection.

I was under the impression that the cpuhp callbacks were *strictly* serialised.
If that's not the case, the existing offlining callbacks are horrendously
broken.

Are you *certain* these can race?

Regardless, adding additional locking here is not ok.

> Simple as this(_untested_):
> 
> diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
> index 7ef9c7e4836b..fa89c3db4d7d 100644
> --- a/drivers/perf/arm-cmn.c
> +++ b/drivers/perf/arm-cmn.c
> @@ -1950,18 +1950,24 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
>         struct arm_cmn *cmn;
>         unsigned int target;
>         int node;
> -       cpumask_t mask;
> +       static cpumask_t mask;
> +       static DEFINE_SPINLOCK(cpumask_lock);
> 
>         cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
>         if (cpu != cmn->cpu)
>                 return 0;
> 
> +       spin_lock(&cpumask_lock);
> +
>         node = dev_to_node(cmn->dev);
>         if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
>             cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
>                 target = cpumask_any(&mask);
>         else
>                 target = cpumask_any_but(cpu_online_mask, cpu);
> +
> +       spin_unlock(&cpumask_lock);
> +
>         if (target < nr_cpu_ids)
>                 arm_cmn_migrate(cmn, target);
>         return 0;

Looking at this case, the only reason we need the mask is because it made the
logic a little easier to write. All we really want is to choose some CPU in the
intersection of two masks ignoring a specific CPU, and there was no helper
function to do that.

We can add a new helper to do that for us, which would avoid redundant work to
manipulate the entire mask, and it would make the existing code simpler.  I had
a series a few years back to add cpumask_any_and_but():

  https://lore.kernel.org/lkml/1486381132-5610-1-git-send-email-mark.rutland@arm.com/

.. and that's easy to use here, e.g.

| diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
| index 7ef9c7e4836b7..c6bbd387ccf8b 100644
| --- a/drivers/perf/arm-cmn.c
| +++ b/drivers/perf/arm-cmn.c
| @@ -1950,17 +1950,15 @@ static int arm_cmn_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_no
|         struct arm_cmn *cmn;
|         unsigned int target;
|         int node;
| -       cpumask_t mask;
|  
|         cmn = hlist_entry_safe(cpuhp_node, struct arm_cmn, cpuhp_node);
|         if (cpu != cmn->cpu)
|                 return 0;
|  
|         node = dev_to_node(cmn->dev);
| -       if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
| -           cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
| -               target = cpumask_any(&mask);
| -       else
| +       target = cpumask_any_and_but(cpu_online_mask, cpumask_of_node(node),
| +                                    cpu);
| +       if (target >= nr_cpu_ids)
|                 target = cpumask_any_but(cpu_online_mask, cpu);
|         if (target < nr_cpu_ids)
|                 arm_cmn_migrate(cmn, target);

It doesn't trivially rebase since the cpumask code has changed a fair amount,
but I've managed to do that locally, and I can send that out as a
seven-years-late v2 if it's useful.

From a quick scan, it looks like that'd handle all cases in this series. Are
there any patterns in this series for which that would not be sufficient?

Mark.

> 
> And yes, static allocation is evil :) 
> 
> 
> Thanks,
> 
>     Dawei
> 
> > 
> > Also, for the titles it'd be better to say something like "avoid placing
> > cpumasks on the stack", because "explicit cpumask var allocation" sounds like
> > the use of alloc_cpumask_var().
> 
> Sound great! I will update it.
> 
> > 
> > Mark.
> > 
> > > 
> > > static int cpuhp_issue_call(int cpu, enum cpuhp_state state, bool bringup,
> > >                             struct hlist_node *node)
> > > {
> > >         struct cpuhp_step *sp = cpuhp_get_step(state);
> > >         int ret;
> > > 
> > >         /*
> > >          * If there's nothing to do, we done.
> > >          * Relies on the union for multi_instance.
> > >          */
> > >         if (cpuhp_step_empty(bringup, sp))
> > >                 return 0;
> > >         /*
> > >          * The non AP bound callbacks can fail on bringup. On teardown
> > >          * e.g. module removal we crash for now.
> > >          */
> > > 	#ifdef CONFIG_SMP
> > >         if (cpuhp_is_ap_state(state))
> > >                 ret = cpuhp_invoke_ap_callback(cpu, state, bringup, node);
> > >         else
> > >                 ret = cpuhp_invoke_callback(cpu, state, bringup, node,
> > > 		NULL);
> > > 	#else
> > >         ret = cpuhp_invoke_callback(cpu, state, bringup, node, NULL);
> > > 	#endif
> > >         BUG_ON(ret && !bringup);
> > >         return ret;
> > > }
> > > 
> > > Dawei Li (9):
> > >   perf/alibaba_uncore_drw: Avoid explicit cpumask var allocation from
> > >     stack
> > >   perf/arm-cmn: Avoid explicit cpumask var allocation from stack
> > >   perf/arm_cspmu: Avoid explicit cpumask var allocation from stack
> > >   perf/arm_dsu: Avoid explicit cpumask var allocation from stack
> > >   perf/dwc_pcie: Avoid explicit cpumask var allocation from stack
> > >   perf/hisi_pcie: Avoid explicit cpumask var allocation from stack
> > >   perf/hisi_uncore: Avoid explicit cpumask var allocation from stack
> > >   perf/qcom_l2: Avoid explicit cpumask var allocation from stack
> > >   perf/thunder_x2: Avoid explicit cpumask var allocation from stack
> > > 
> > >  drivers/perf/alibaba_uncore_drw_pmu.c    | 13 +++++++++----
> > >  drivers/perf/arm-cmn.c                   | 13 +++++++++----
> > >  drivers/perf/arm_cspmu/arm_cspmu.c       | 13 +++++++++----
> > >  drivers/perf/arm_dsu_pmu.c               | 18 +++++++++++++-----
> > >  drivers/perf/dwc_pcie_pmu.c              | 17 +++++++++++------
> > >  drivers/perf/hisilicon/hisi_pcie_pmu.c   | 15 ++++++++++-----
> > >  drivers/perf/hisilicon/hisi_uncore_pmu.c | 13 +++++++++----
> > >  drivers/perf/qcom_l2_pmu.c               | 15 ++++++++++-----
> > >  drivers/perf/thunderx2_pmu.c             | 20 ++++++++++++--------
> > >  9 files changed, 92 insertions(+), 45 deletions(-)
> > > 
> > > 
> > > Thanks,
> > > 
> > >     Dawei
> > > 
> > > -- 
> > > 2.27.0
> > > 
> > 

