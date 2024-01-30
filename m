Return-Path: <linux-kernel+bounces-45072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C862842B60
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 19:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D18C1C23DA4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 18:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3C086AD7;
	Tue, 30 Jan 2024 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkFyQXRZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA0115703D
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 18:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706637613; cv=none; b=Bk+L9VPwI0bs7AdMLDz3ZMrAeec4kiKCLqoDOBLeMdXafvbLao8K23IiVnDNxfKAnVhhM6i5HX0U1RPfH3w0BZmUb6+bWu4ptu5BOC9s01dzKO6mMeTjbLepxzJfr5Ui3RukfJXrNCOObevxYERxJojmhUfv5b/o0UhEp+ex5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706637613; c=relaxed/simple;
	bh=ITl6oV/WNkvlyLydSH2T+rbMdDPi3tohEN6tuqsmxUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FUmFXlRsdxweo2NXKPmD38lctSf4DmxAnlH6ctA1tliv+0KDdHQoCoAdO33nZZByA6i9en281PupXtPYi0rurpgu/AOUsmz2/zCF6/6ljlNTtSi2qhwaPEfSve0dx8u8gdasj4TzD7KAknUXYUIMPfrrYjOM6YFsXTQ16lwO2rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkFyQXRZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F51C43394;
	Tue, 30 Jan 2024 18:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706637612;
	bh=ITl6oV/WNkvlyLydSH2T+rbMdDPi3tohEN6tuqsmxUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AkFyQXRZagpAuuMMmYV2u502Hi0aiPocdmvT4h8dlL1ZPo4pMR0BMqBTTWL8gZAzf
	 5WZh5iH2jIV1uMgR7sd7uqFa1XjlH5F3Cdi+xTB2ln4FUKlQaz+WCDa5BLvKEdy0fe
	 sBAHZ6wVWSF5tJIfqVFJ3sBAZlZtQ3fZ8NNXxsQ50vOCK9SqoE+iai2HGxnjYjWixR
	 davSVg0WWErGshxEKBwzEoPKFxmqdfcyrUYB/ZeLKzJypaeDA6fIXOJr1iQajJ1+kK
	 +ldgo1u2uuM45zZp7NUNoP0HOhkmT0ig3Bq/cYQKkiJlBsKIxgVVW2pbQ5k5sMJxTR
	 mpCQojS9QGtTA==
Date: Tue, 30 Jan 2024 11:00:10 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com, kernel-team@meta.com
Subject: Re: [PATCH v4 08/10] workqueue: Introduce struct wq_node_nr_active
Message-ID: <20240130180010.GA2011608@dev-arch.thelio-3990X>
References: <20240125170628.2017784-1-tj@kernel.org>
 <20240125170628.2017784-9-tj@kernel.org>
 <CAJhGHyA=uO4P4skas0-DZCE+cS453V+PrJMOFj2G2DAc1tE0jA@mail.gmail.com>
 <Zbfq8egWUfYgkOsa@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbfq8egWUfYgkOsa@slm.duckdns.org>

Hi Tejun,

On Mon, Jan 29, 2024 at 08:14:09AM -1000, Tejun Heo wrote:
> >From 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5 Mon Sep 17 00:00:00 2001
> From: Tejun Heo <tj@kernel.org>
> Date: Mon, 29 Jan 2024 08:11:24 -1000
> 
> Currently, for both percpu and unbound workqueues, max_active applies
> per-cpu, which is a recent change for unbound workqueues. The change for
> unbound workqueues was a significant departure from the previous behavior of
> per-node application. It made some use cases create undesirable number of
> concurrent work items and left no good way of fixing them. To address the
> problem, workqueue is implementing a NUMA node segmented global nr_active
> mechanism, which will be explained further in the next patch.
> 
> As a preparation, this patch introduces struct wq_node_nr_active. It's a
> data structured allocated for each workqueue and NUMA node pair and
> currently only tracks the workqueue's number of active work items on the
> node. This is split out from the next patch to make it easier to understand
> and review.
> 
> Note that there is an extra wq_node_nr_active allocated for the invalid node
> nr_node_ids which is used to track nr_active for pools which don't have NUMA
> node associated such as the default fallback system-wide pool.
> 
> This doesn't cause any behavior changes visible to userland yet. The next
> patch will expand to implement the control mechanism on top.
> 
> v4: - Fixed out-of-bound access when freeing per-cpu workqueues.
> 
> v3: - Use flexible array for wq->node_nr_active as suggested by Lai.
> 
> v2: - wq->max_active now uses WRITE/READ_ONCE() as suggested by Lai.
> 
>     - Lai pointed out that pwq_tryinc_nr_active() incorrectly dropped
>       pwq->max_active check. Restored. As the next patch replaces the
>       max_active enforcement mechanism, this doesn't change the end result.
> 
> Signed-off-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  kernel/workqueue.c | 142 ++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 135 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index b5aba0e5a699..8d465478adb9 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -284,6 +284,16 @@ struct wq_flusher {
>  
>  struct wq_device;
>  
> +/*
> + * Unlike in a per-cpu workqueue where max_active limits its concurrency level
> + * on each CPU, in an unbound workqueue, max_active applies to the whole system.
> + * As sharing a single nr_active across multiple sockets can be very expensive,
> + * the counting and enforcement is per NUMA node.
> + */
> +struct wq_node_nr_active {
> +	atomic_t		nr;		/* per-node nr_active count */
> +};
> +
>  /*
>   * The externally visible workqueue.  It relays the issued work items to
>   * the appropriate worker_pool through its pool_workqueues.
> @@ -330,6 +340,7 @@ struct workqueue_struct {
>  	/* hot fields used during command issue, aligned to cacheline */
>  	unsigned int		flags ____cacheline_aligned; /* WQ: WQ_* flags */
>  	struct pool_workqueue __percpu __rcu **cpu_pwq; /* I: per-cpu pwqs */
> +	struct wq_node_nr_active *node_nr_active[]; /* I: per-node nr_active */
>  };
>  
>  static struct kmem_cache *pwq_cache;
> @@ -1425,6 +1436,31 @@ work_func_t wq_worker_last_func(struct task_struct *task)
>  	return worker->last_func;
>  }
>  
> +/**
> + * wq_node_nr_active - Determine wq_node_nr_active to use
> + * @wq: workqueue of interest
> + * @node: NUMA node, can be %NUMA_NO_NODE
> + *
> + * Determine wq_node_nr_active to use for @wq on @node. Returns:
> + *
> + * - %NULL for per-cpu workqueues as they don't need to use shared nr_active.
> + *
> + * - node_nr_active[nr_node_ids] if @node is %NUMA_NO_NODE.
> + *
> + * - Otherwise, node_nr_active[@node].
> + */
> +static struct wq_node_nr_active *wq_node_nr_active(struct workqueue_struct *wq,
> +						   int node)
> +{
> +	if (!(wq->flags & WQ_UNBOUND))
> +		return NULL;
> +
> +	if (node == NUMA_NO_NODE)
> +		node = nr_node_ids;
> +
> +	return wq->node_nr_active[node];
> +}
> +
>  /**
>   * get_pwq - get an extra reference on the specified pool_workqueue
>   * @pwq: pool_workqueue to get
> @@ -1506,12 +1542,17 @@ static bool pwq_activate_work(struct pool_workqueue *pwq,
>  			      struct work_struct *work)
>  {
>  	struct worker_pool *pool = pwq->pool;
> +	struct wq_node_nr_active *nna;
>  
>  	lockdep_assert_held(&pool->lock);
>  
>  	if (!(*work_data_bits(work) & WORK_STRUCT_INACTIVE))
>  		return false;
>  
> +	nna = wq_node_nr_active(pwq->wq, pool->node);
> +	if (nna)
> +		atomic_inc(&nna->nr);
> +
>  	pwq->nr_active++;
>  	__pwq_activate_work(pwq, work);
>  	return true;
> @@ -1528,14 +1569,18 @@ static bool pwq_tryinc_nr_active(struct pool_workqueue *pwq)
>  {
>  	struct workqueue_struct *wq = pwq->wq;
>  	struct worker_pool *pool = pwq->pool;
> +	struct wq_node_nr_active *nna = wq_node_nr_active(wq, pool->node);
>  	bool obtained;
>  
>  	lockdep_assert_held(&pool->lock);
>  
>  	obtained = pwq->nr_active < READ_ONCE(wq->max_active);
>  
> -	if (obtained)
> +	if (obtained) {
>  		pwq->nr_active++;
> +		if (nna)
> +			atomic_inc(&nna->nr);
> +	}
>  	return obtained;
>  }
>  
> @@ -1572,10 +1617,26 @@ static bool pwq_activate_first_inactive(struct pool_workqueue *pwq)
>  static void pwq_dec_nr_active(struct pool_workqueue *pwq)
>  {
>  	struct worker_pool *pool = pwq->pool;
> +	struct wq_node_nr_active *nna = wq_node_nr_active(pwq->wq, pool->node);
>  
>  	lockdep_assert_held(&pool->lock);
>  
> +	/*
> +	 * @pwq->nr_active should be decremented for both percpu and unbound
> +	 * workqueues.
> +	 */
>  	pwq->nr_active--;
> +
> +	/*
> +	 * For a percpu workqueue, it's simple. Just need to kick the first
> +	 * inactive work item on @pwq itself.
> +	 */
> +	if (!nna) {
> +		pwq_activate_first_inactive(pwq);
> +		return;
> +	}
> +
> +	atomic_dec(&nna->nr);
>  	pwq_activate_first_inactive(pwq);
>  }
>  
> @@ -4039,11 +4100,63 @@ static void wq_free_lockdep(struct workqueue_struct *wq)
>  }
>  #endif
>  
> +static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
> +{
> +	int node;
> +
> +	for_each_node(node) {
> +		kfree(nna_ar[node]);
> +		nna_ar[node] = NULL;
> +	}
> +
> +	kfree(nna_ar[nr_node_ids]);
> +	nna_ar[nr_node_ids] = NULL;
> +}
> +
> +static void init_node_nr_active(struct wq_node_nr_active *nna)
> +{
> +	atomic_set(&nna->nr, 0);
> +}
> +
> +/*
> + * Each node's nr_active counter will be accessed mostly from its own node and
> + * should be allocated in the node.
> + */
> +static int alloc_node_nr_active(struct wq_node_nr_active **nna_ar)
> +{
> +	struct wq_node_nr_active *nna;
> +	int node;
> +
> +	for_each_node(node) {
> +		nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, node);
> +		if (!nna)
> +			goto err_free;
> +		init_node_nr_active(nna);
> +		nna_ar[node] = nna;
> +	}
> +
> +	/* [nr_node_ids] is used as the fallback */
> +	nna = kzalloc_node(sizeof(*nna), GFP_KERNEL, NUMA_NO_NODE);
> +	if (!nna)
> +		goto err_free;
> +	init_node_nr_active(nna);
> +	nna_ar[nr_node_ids] = nna;
> +
> +	return 0;
> +
> +err_free:
> +	free_node_nr_active(nna_ar);
> +	return -ENOMEM;
> +}
> +
>  static void rcu_free_wq(struct rcu_head *rcu)
>  {
>  	struct workqueue_struct *wq =
>  		container_of(rcu, struct workqueue_struct, rcu);
>  
> +	if (wq->flags & WQ_UNBOUND)
> +		free_node_nr_active(wq->node_nr_active);
> +
>  	wq_free_lockdep(wq);
>  	free_percpu(wq->cpu_pwq);
>  	free_workqueue_attrs(wq->unbound_attrs);
> @@ -4785,7 +4898,8 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  {
>  	va_list args;
>  	struct workqueue_struct *wq;
> -	int len;
> +	size_t wq_size;
> +	int name_len;
>  
>  	/*
>  	 * Unbound && max_active == 1 used to imply ordered, which is no longer
> @@ -4801,7 +4915,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  		flags |= WQ_UNBOUND;
>  
>  	/* allocate wq and format name */
> -	wq = kzalloc(sizeof(*wq), GFP_KERNEL);
> +	if (flags & WQ_UNBOUND)
> +		wq_size = struct_size(wq, node_nr_active, nr_node_ids + 1);
> +	else
> +		wq_size = sizeof(*wq);
> +
> +	wq = kzalloc(wq_size, GFP_KERNEL);
>  	if (!wq)
>  		return NULL;
>  
> @@ -4812,11 +4931,12 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	}
>  
>  	va_start(args, max_active);
> -	len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
> +	name_len = vsnprintf(wq->name, sizeof(wq->name), fmt, args);
>  	va_end(args);
>  
> -	if (len >= WQ_NAME_LEN)
> -		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n", wq->name);
> +	if (name_len >= WQ_NAME_LEN)
> +		pr_warn_once("workqueue: name exceeds WQ_NAME_LEN. Truncating to: %s\n",
> +			     wq->name);
>  
>  	max_active = max_active ?: WQ_DFL_ACTIVE;
>  	max_active = wq_clamp_max_active(max_active, flags, wq->name);
> @@ -4835,8 +4955,13 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  	wq_init_lockdep(wq);
>  	INIT_LIST_HEAD(&wq->list);
>  
> +	if (flags & WQ_UNBOUND) {
> +		if (alloc_node_nr_active(wq->node_nr_active) < 0)
> +			goto err_unreg_lockdep;
> +	}
> +
>  	if (alloc_and_link_pwqs(wq) < 0)
> -		goto err_unreg_lockdep;
> +		goto err_free_node_nr_active;
>  
>  	if (wq_online && init_rescuer(wq) < 0)
>  		goto err_destroy;
> @@ -4861,6 +4986,9 @@ struct workqueue_struct *alloc_workqueue(const char *fmt,
>  
>  	return wq;
>  
> +err_free_node_nr_active:
> +	if (wq->flags & WQ_UNBOUND)
> +		free_node_nr_active(wq->node_nr_active);
>  err_unreg_lockdep:
>  	wq_unregister_lockdep(wq);
>  	wq_free_lockdep(wq);
> -- 
> 2.43.0
> 

I just bisected a crash that I see when booting several different architectures
in QEMU in -next to this change as commit 5797b1c18919 ("workqueue: Implement
system-wide nr_active enforcement for unbound workqueues"). For example, with
arm64 virtconfig (I also see it with ARCH=arm multi_v7_defconfig and
ARCH=riscv defconfig):

$ make -skj"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux- virtconfig Image.gz

$ qemu-system-aarch64 \
    -display none \
    -nodefaults \
    -cpu max,pauth-impdef=true \
    -machine virt,gic-version=max,virtualization=true \
    -append 'console=ttyAMA0 earlycon' \
    -kernel arch/arm64/boot/Image.gz \
    -initrd rootfs.cpio \
    -m 512m \
    -serial mon:stdio
[    0.000000] Booting Linux on physical CPU 0x0000000000 [0x000f0510]
[    0.000000] Linux version 6.7.0-09946-g5797b1c18919 (nathan@dev-arch.thelio-3990X) (aarch64-linux-gcc (GCC) 13.2.0, GNU ld (GNU Binutils) 2.41) #1 SMP PREEMPT Tue Jan 30 10:10:57 MST 2024
..
[    0.000000] Unable to handle kernel paging request at virtual address ffff000021c0b380
[    0.000000] Mem abort info:
[    0.000000]   ESR = 0x0000000096000006
[    0.000000]   EC = 0x25: DABT (current EL), IL = 32 bits
[    0.000000]   SET = 0, FnV = 0
[    0.000000]   EA = 0, S1PTW = 0
[    0.000000]   FSC = 0x06: level 2 translation fault
[    0.000000] Data abort info:
[    0.000000]   ISV = 0, ISS = 0x00000006, ISS2 = 0x00000000
[    0.000000]   CM = 0, WnR = 0, TnD = 0, TagAccess = 0
[    0.000000]   GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[    0.000000] swapper pgtable: 4k pages, 48-bit VAs, pgdp=00000000413b1000
[    0.000000] [ffff000021c0b380] pgd=180000005fff7003, p4d=180000005fff7003, pud=180000005fff6003, pmd=0000000000000000
[    0.000000] Internal error: Oops: 0000000096000006 [#1] PREEMPT SMP
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-09946-g5797b1c18919 #1
[    0.000000] Hardware name: linux,dummy-virt (DT)
[    0.000000] pstate: 600000c9 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[    0.000000] pc : wq_update_node_max_active+0x48/0x1d8
[    0.000000] lr : apply_wqattrs_commit+0x160/0x180
[    0.000000] sp : ffffda8d476b3be0
[    0.000000] x29: ffffda8d476b3be0 x28: ffff000001c0d600 x27: 0000000000000000
[    0.000000] x26: ffff000001c0d6c0 x25: 0000000000000001 x24: 0000000000000200
[    0.000000] x23: 00000000ffffffff x22: ffffda8d476b9c40 x21: 0000000000000008
[    0.000000] x20: ffffda8d476b9a40 x19: ffff000001c0b360 x18: ffff00001feebed0
[    0.000000] x17: 0000000000c65c70 x16: ffff00001feebb28 x15: fffffc0000070488
[    0.000000] x14: 0000000000000000 x13: 0000000000000000 x12: ffff00001feebb28
[    0.000000] x11: 0000000000000001 x10: ffff000001c0b388 x9 : 0000000000000000
[    0.000000] x8 : 0000000000000000 x7 : 0000000000000000 x6 : ffff000001c0d600
[    0.000000] x5 : ffff000001c0d600 x4 : ffff000001c0e880 x3 : ffff000001c0d600
[    0.000000] x2 : ffff000001c0b388 x1 : ffffda8d476b9000 x0 : 0000000003ffffff
[    0.000000] Call trace:
[    0.000000]  wq_update_node_max_active+0x48/0x1d8
[    0.000000]  apply_wqattrs_commit+0x160/0x180
[    0.000000]  apply_workqueue_attrs_locked+0x50/0x84
[    0.000000]  alloc_workqueue+0x588/0x6c8
[    0.000000]  workqueue_init_early+0x480/0x554
[    0.000000]  start_kernel+0x240/0x5e8
[    0.000000]  __primary_switched+0xb8/0xc0
[    0.000000] Code: f9418033 d000a081 9100a262 f90037e2 (f8607840)
[    0.000000] ---[ end trace 0000000000000000 ]---
[    0.000000] Kernel panic - not syncing: Attempted to kill the idle task!
[    0.000000] ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

If there is any more information I can provide or patches I can test, I
am more than happy to do so.

Cheers,
Nathan

# bad: [41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52] Add linux-next specific files for 20240130
# good: [41bccc98fb7931d63d03f326a746ac4d429c1dd3] Linux 6.8-rc2
git bisect start '41d66f96d0f15a0a2ad6fa2208f6bac1a66cbd52' '41bccc98fb7931d63d03f326a746ac4d429c1dd3'
# good: [f3f89885646036e16b325aea597fc9f375f1a56a] Merge branch 'main' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
git bisect good f3f89885646036e16b325aea597fc9f375f1a56a
# good: [8042d32dd6c3730b0b4c8c9c811e204ed9f5f829] Merge branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
git bisect good 8042d32dd6c3730b0b4c8c9c811e204ed9f5f829
# bad: [f0edba72fe5ae932877f49796aaef8adf1a2eb8c] Merge branch 'togreg' of git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git
git bisect bad f0edba72fe5ae932877f49796aaef8adf1a2eb8c
# bad: [549632942a27cc3987473f8a8629200bc2ab0734] Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt.git
git bisect bad 549632942a27cc3987473f8a8629200bc2ab0734
# good: [9eb48e8d465d67362dac65963979e65cb2ad7634] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git
git bisect good 9eb48e8d465d67362dac65963979e65cb2ad7634
# good: [bc83a87759cabbf6f3366568e44bda088b315204] dt-bindings: usb: dwc3: Add snps,host-vbus-glitches-quirk avoid vbus glitch
git bisect good bc83a87759cabbf6f3366568e44bda088b315204
# bad: [2c0ea2f8eb6140767fae8d01a30ce45dcf4ead85] Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git
git bisect bad 2c0ea2f8eb6140767fae8d01a30ce45dcf4ead85
# good: [a045a272d887575da17ad86d6573e82871b50c27] workqueue: Move pwq->max_active to wq->max_active
git bisect good a045a272d887575da17ad86d6573e82871b50c27
# good: [9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab] workqueue: RCU protect wq->dfl_pwq and implement accessors for it
git bisect good 9f66cff212bb3c1cd25996aaa0dfd0c9e9d8baab
# good: [91ccc6e7233bb10a9c176aa4cc70d6f432a441a5] workqueue: Introduce struct wq_node_nr_active
git bisect good 91ccc6e7233bb10a9c176aa4cc70d6f432a441a5
# bad: [07daa99b7fd7adfffa22180184e39ec124e73013] tools/workqueue/wq_dump.py: Add node_nr/max_active dump
git bisect bad 07daa99b7fd7adfffa22180184e39ec124e73013
# bad: [5797b1c18919cd9c289ded7954383e499f729ce0] workqueue: Implement system-wide nr_active enforcement for unbound workqueues
git bisect bad 5797b1c18919cd9c289ded7954383e499f729ce0
# first bad commit: [5797b1c18919cd9c289ded7954383e499f729ce0] workqueue: Implement system-wide nr_active enforcement for unbound workqueues

