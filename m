Return-Path: <linux-kernel+bounces-132775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD148999FB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:55:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7E11C2214A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D8D16D316;
	Fri,  5 Apr 2024 09:52:52 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853E016C87F;
	Fri,  5 Apr 2024 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310772; cv=none; b=Hgd5+xOHPTlK66IGF4TEiltDljKX5mUXN9FugZnzbGd92TQGKLlN8pXddD+MjPqiyfHNx37U9RQURAc4TYL2UGjyULNDShLWimR9ure06WvnB9PVlm3tg/ln4BNbgtD7lia5AMAiGQeam79ZTiFLsAPaneYOHcGYmSPzFImcqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310772; c=relaxed/simple;
	bh=Cd32nAS4wjxMldROP8jmFEdqvn59+sAVNup8vx4Txdw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lzMnXPEiCJRnoibN5KkFXtyiJ0SnQyYYsTFGBNwMSgFgBmjTjnUca8sgjZA08NuGrl9RIGOEAeutyh5L2/xeuHQAe+NbyRO+SGsWjz/IUsos25XygxnFn2ge7imZ2h8gfNb5e/UXenAkKvoFF4qiFmekWUIksh3piaw2tQ4ieJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V9tvp1hqnz6J7pk;
	Fri,  5 Apr 2024 17:48:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A3E05140A36;
	Fri,  5 Apr 2024 17:52:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 5 Apr
 2024 10:52:46 +0100
Date: Fri, 5 Apr 2024 10:52:44 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Mark Rutland <mark.rutland@arm.com>
CC: Dawei Li <dawei.li@shingroup.cn>, <will@kernel.org>,
	<yury.norov@gmail.com>, <linux@rasmusvillemoes.dk>,
	<xueshuai@linux.alibaba.com>, <renyu.zj@linux.alibaba.com>,
	<yangyicong@hisilicon.com>, <andersson@kernel.org>,
	<konrad.dybcio@linaro.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] perf/hisi_pcie: Avoid placing cpumask var on
 stack
Message-ID: <20240405105244.00003eb8@Huawei.com>
In-Reply-To: <Zg1pHsWnzczoXBb4@FVFF77S0Q05N>
References: <20240403125109.2054881-1-dawei.li@shingroup.cn>
	<20240403125109.2054881-8-dawei.li@shingroup.cn>
	<Zg1pHsWnzczoXBb4@FVFF77S0Q05N>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 3 Apr 2024 15:35:10 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> On Wed, Apr 03, 2024 at 08:51:06PM +0800, Dawei Li wrote:
> > For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> > variable on stack is not recommended since it can cause potential stack
> > overflow.
> > 
> > Instead, kernel code should always use *cpumask_var API(s) to allocate
> > cpumask var in config-neutral way, leaving allocation strategy to
> > CONFIG_CPUMASK_OFFSTACK.
> > 
> > But dynamic allocation in cpuhp's teardown callback is somewhat problematic
> > for if allocation fails(which is unlikely but still possible):
> > - If -ENOMEM is returned to caller, kernel crashes for non-bringup
> >   teardown;
> > - If callback pretends nothing happened and returns 0 to caller, it may
> >   trap system into an in-consisitent/compromised state;
> > 
> > Use newly-introduced cpumask_any_and_but() to address all issues above.
> > It eliminates usage of temporary cpumask var in generic way, no matter how
> > the cpumask var is allocated.
> > 
> > Suggested-by: Mark Rutland <mark.rutland@arm.com>
> > Signed-off-by: Dawei Li <dawei.li@shingroup.cn>  
> 
> The logic looks good to me, but I'd like the commit message updated the same as
> per my comment on patch 2.
> 
> With that commit message:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> Mark.
> 
> > ---
> >  drivers/perf/hisilicon/hisi_pcie_pmu.c | 9 ++++-----
> >  1 file changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/perf/hisilicon/hisi_pcie_pmu.c b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > index 5d1f0e9fdb08..06b192cc31d5 100644
> > --- a/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > +++ b/drivers/perf/hisilicon/hisi_pcie_pmu.c
> > @@ -673,7 +673,6 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >  {
> >  	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node, struct hisi_pcie_pmu, node);
> >  	unsigned int target;
> > -	cpumask_t mask;
> >  	int numa_node;
> >  
> >  	/* Nothing to do if this CPU doesn't own the PMU */
> > @@ -684,10 +683,10 @@ static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> >  
> >  	/* Choose a local CPU from all online cpus. */
> >  	numa_node = dev_to_node(&pcie_pmu->pdev->dev);
> > -	if (cpumask_and(&mask, cpumask_of_node(numa_node), cpu_online_mask) &&
> > -	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
> > -		target = cpumask_any(&mask);
> > -	else
> > +
> > +	target = cpumask_any_and_but(cpumask_of_node(numa_node),
> > +				     cpu_online_mask, cpu);
> > +	if (target >= nr_cpu_ids)
> >  		target = cpumask_any_but(cpu_online_mask, cpu);
> >  
> >  	if (target >= nr_cpu_ids) {
> > -- 
> > 2.27.0
> >   


