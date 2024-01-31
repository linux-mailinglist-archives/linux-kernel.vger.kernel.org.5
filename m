Return-Path: <linux-kernel+bounces-45733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF918434C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 218CE28225A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 04:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7109D17C75;
	Wed, 31 Jan 2024 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oQbdiNky"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A631117BD1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706674328; cv=none; b=Ks6SOITWDCjFi6BF5CTkAWLcj5bhQ7PpQ7BJ9RAwaUd4RK7LvCGZOy7KK4GXV8qbLqKY2iIWRE7uGSizw2uGev+fSxo6sPRQWTlrpzlg80nN3IXrNWZljFDMdMZaUDM+H8xtPWs2tfhmAuLG7L2w7WsGmj+d7AtPA/hDirgM+ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706674328; c=relaxed/simple;
	bh=wDi1Oro3rTdTt+42vp1EG46jR9Q6ptLTjzWksMHjRRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W0jfXH67wllVYN1OrUqc5ssbflsz0fA2uU/mMN6d7GuH2QvHjYjUAMp6y1R6l7Wtmu5SQ9Dm2GnIVJ2uGGqBdmlttfcolIw/lTEtTLCm31i8kneuu4WsSj1REtIjtyRZKBw/RLtF+yy7Pu/lq6NWCwHERcBWov1gflstw500eyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oQbdiNky; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7B3C433F1;
	Wed, 31 Jan 2024 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706674328;
	bh=wDi1Oro3rTdTt+42vp1EG46jR9Q6ptLTjzWksMHjRRk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oQbdiNky1dYdknHwOoNcxXRgs530OxrC074Y/qko3VY6vkAYwGJ0ofiQXX/vyi0Z7
	 YwUhf5H/hX08y1w4Z8CQiuWNoo6dMPDt0K0FTQN0UJkILiiNe3gbTaYmJSkgniYy7o
	 76viUbk4KoZiStzDVsWcSaDzPWdzpTBSLnBN8+cAAxPkzSn1pKsJ3DuvAwNn9gMvCB
	 LOwyu+GheBCNiMMlLViLMis71HMkzOo37/38mBunDtIgXf5xCjejuRziFDcdDcoNZG
	 CBuKTk2gToj+WyANFvdxw673zxXkmMqgMeMtqQsCooTnruJIQPyDk02hug0Olrzmid
	 c9DZQfX5zc0Vg==
Date: Tue, 30 Jan 2024 21:12:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com,
	kernel-team@meta.com
Subject: Re: [PATCH v4 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
Message-ID: <20240131041205.GA3517117@dev-arch.thelio-3990X>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-10-tj@kernel.org>
 <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
 <ZbfrEx9nnkr0FnZE@slm.duckdns.org>
 <CGME20240130223021eucas1p1172b060d53847b8b77f6455d6257528e@eucas1p1.samsung.com>
 <91eacde0-df99-4d5c-a980-91046f66e612@samsung.com>
 <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbnGbC8YM0rcI8Jm@slm.duckdns.org>

Hi Tejun,

On Tue, Jan 30, 2024 at 06:02:52PM -1000, Tejun Heo wrote:
> Hello,
> 
> Thanks for the report. Can you please test whether the following patch fixes
> the problem?

I just tested this change on top of 5797b1c18919 but it does not appear
to resolve the issue for any of the three configurations that I tested.

Cheers,
Nathan

> ----- 8< -----
> From: Tejun Heo <tj@kernel.org>
> Subject: workqueue: Fix crash due to premature NUMA topology access on some archs
> 
> System workqueues are allocated early during boot from
> workqueue_init_early(). While allocating unbound workqueues,
> wq_update_node_max_active() is invoked from apply_workqueue_attrs() and
> accesses NUMA topology information - cpumask_of_node() and cpu_to_node().
> 
> At this point, topology information is not initialized yet and on arm and
> some other archs, it leads to an oops like the following:
> 
>   Unable to handle kernel paging request at virtual address ffff0002100296e0
>   Mem abort info:
>      ESR = 0x0000000096000005
>      EC = 0x25: DABT (current EL), IL = 32 bits
>      SET = 0, FnV = 0
>      EA = 0, S1PTW = 0
>      FSC = 0x05: level 1 translation fault
>   Data abort info:
>      ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
>      CM = 0, WnR = 0, TnD = 0, TagAccess = 0
>      GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
>   swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000255a000
>   [ffff0002100296e0] pgd=18000001ffff7003, p4d=18000001ffff7003, 
>   pud=0000000000000000
>   Internal error: Oops: 0000000096000005 [#1] PREEMPT SMP
>   Modules linked in:
>   CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.8.0-rc2-next-20240130+ #14392
>   Hardware name: Hardkernel ODROID-M1 (DT)
>   pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   pc : wq_update_node_max_active+0x50/0x1fc
>   lr : wq_update_node_max_active+0x1f0/0x1fc
>   ...
>   Call trace:
>     wq_update_node_max_active+0x50/0x1fc
>     apply_wqattrs_commit+0xf0/0x114
>     apply_workqueue_attrs_locked+0x58/0xa0
>     alloc_workqueue+0x5ac/0x774
>     workqueue_init_early+0x460/0x540
>     start_kernel+0x258/0x684
>     __primary_switched+0xb8/0xc0
>   Code: 9100a273 35000d01 53067f00 d0016dc1 (f8607a60)
>   ---[ end trace 0000000000000000 ]---
>   Kernel panic - not syncing: Attempted to kill the idle task!
>   ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---
> 
> Fix it by initializing wq->node_nr_active[].max to WQ_DFL_MIN_ACTIVE on
> allocation and making wq_update_node_max_active() noop until
> workqueue_init_topology(). Note that workqueue_init_topology() invokes
> wq_update_node_max_active() on all unbound workqueues, so the end result is
> still the same.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Link: http://lkml.kernel.org/r/91eacde0-df99-4d5c-a980-91046f66e612@samsung.com
> Fixes: 5797b1c18919 ("workqueue: Implement system-wide nr_active enforcement for unbound workqueues")
> ---
>  kernel/workqueue.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 9221a4c57ae1..a65081ec6780 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -386,6 +386,8 @@ static const char *wq_affn_names[WQ_AFFN_NR_TYPES] = {
>  	[WQ_AFFN_SYSTEM]		= "system",
>  };
>  
> +static bool wq_topo_initialized = false;
> +
>  /*
>   * Per-cpu work items which run for longer than the following threshold are
>   * automatically considered CPU intensive and excluded from concurrency
> @@ -1510,6 +1512,9 @@ static void wq_update_node_max_active(struct workqueue_struct *wq, int off_cpu)
>  
>  	lockdep_assert_held(&wq->mutex);
>  
> +	if (!wq_topo_initialized)
> +		return;
> +
>  	if (!cpumask_test_cpu(off_cpu, effective))
>  		off_cpu = -1;
>  
> @@ -4356,6 +4361,7 @@ static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
>  
>  static void init_node_nr_active(struct wq_node_nr_active *nna)
>  {
> +	nna->max = WQ_DFL_MIN_ACTIVE;
>  	atomic_set(&nna->nr, 0);
>  	raw_spin_lock_init(&nna->lock);
>  	INIT_LIST_HEAD(&nna->pending_pwqs);
> @@ -7400,6 +7406,8 @@ void __init workqueue_init_topology(void)
>  	init_pod_type(&wq_pod_types[WQ_AFFN_CACHE], cpus_share_cache);
>  	init_pod_type(&wq_pod_types[WQ_AFFN_NUMA], cpus_share_numa);
>  
> +	wq_topo_initialized = true;
> +
>  	mutex_lock(&wq_pool_mutex);
>  
>  	/*

