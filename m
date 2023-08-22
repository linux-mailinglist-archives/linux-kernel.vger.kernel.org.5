Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACBF784994
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjHVSsR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Aug 2023 14:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjHVSsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:48:15 -0400
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB2B8E45;
        Tue, 22 Aug 2023 11:48:09 -0700 (PDT)
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-564670fad4bso387891a12.1;
        Tue, 22 Aug 2023 11:48:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692730089; x=1693334889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XdhnjEqGkn654kwZJJbDQRxBLHCMtvoG6zMeUHjRtHQ=;
        b=eC40gsuX+r1tr9d5DG6NmdwMJkaP1aUxZPOkQ8COt76gSGnW/AnW9OIL+R86Lk/Ltd
         dp1b9rSQ/xA6THmtWfqdoj6Fvank0IJt7WYIVKTab0hFJXSlkQOk9JuK2TUmozzq6Eol
         9XLwJCb1pDfd/51cAvwxUfk0sarX844uBADXtkGUbYpJY7p3j5QMAXU0hkXOWVfPUy3C
         3LKJ3QhbgjJvAkL0VYBXaxkA/zbuBVPtk/Uu9l05R7J3Np1A5I22h0R/aImsZggZotzG
         WP3eLH1PiTZPtpVIaMrAkAbrT1XbQGQK76sa8RJ8YmloXPaQNa5st6o3SrVe4/cFqS4O
         0+qw==
X-Gm-Message-State: AOJu0YzuvVyKR0dtWPS7hQ3Ga5ZoGbWoQ/xILpXf4gdiUGvGqT/WoPlX
        KjzSefwtidUeAfFNorN0HuKLGl3NVNu3U9Mz1bw=
X-Google-Smtp-Source: AGHT+IFb5plnw81r8Ob/AEkd1Svx7o/j+unH4q1Wk9vtrNFLZzoNf4g6zqyr7VDkOkT3SjYsRpl3mpVYYJpLsuKfYpY=
X-Received: by 2002:a05:6a00:2d82:b0:68a:5954:fda4 with SMTP id
 fb2-20020a056a002d8200b0068a5954fda4mr5238577pfb.1.1692730088972; Tue, 22 Aug
 2023 11:48:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230822180208.95556-1-robdclark@gmail.com> <20230822180208.95556-4-robdclark@gmail.com>
In-Reply-To: <20230822180208.95556-4-robdclark@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Aug 2023 20:47:56 +0200
Message-ID: <CAJZ5v0jLzhhMM58EtyKaFOa8c=bE+XU5=OafvCx0vTBQpNZ0gQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/11] PM / QoS: Fix constraints alloc vs reclaim locking
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 8:02 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> In the process of adding lockdep annotation for drm GPU scheduler's
> job_run() to detect potential deadlock against shrinker/reclaim, I hit
> this lockdep splat:
>
>    ======================================================
>    WARNING: possible circular locking dependency detected
>    6.2.0-rc8-debug+ #558 Tainted: G        W
>    ------------------------------------------------------
>    ring0/125 is trying to acquire lock:
>    ffffffd6d6ce0f28 (dev_pm_qos_mtx){+.+.}-{3:3}, at: dev_pm_qos_update_request+0x38/0x68
>
>    but task is already holding lock:
>    ffffff8087239208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178
>
>    which lock already depends on the new lock.
>
>    the existing dependency chain (in reverse order) is:
>
>    -> #4 (&gpu->active_lock){+.+.}-{3:3}:
>           __mutex_lock+0xcc/0x3c8
>           mutex_lock_nested+0x30/0x44
>           msm_gpu_submit+0xec/0x178
>           msm_job_run+0x78/0x150
>           drm_sched_main+0x290/0x370
>           kthread+0xf0/0x100
>           ret_from_fork+0x10/0x20
>
>    -> #3 (dma_fence_map){++++}-{0:0}:
>           __dma_fence_might_wait+0x74/0xc0
>           dma_resv_lockdep+0x1f4/0x2f4
>           do_one_initcall+0x104/0x2bc
>           kernel_init_freeable+0x344/0x34c
>           kernel_init+0x30/0x134
>           ret_from_fork+0x10/0x20
>
>    -> #2 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
>           fs_reclaim_acquire+0x80/0xa8
>           slab_pre_alloc_hook.constprop.0+0x40/0x25c
>           __kmem_cache_alloc_node+0x60/0x1cc
>           __kmalloc+0xd8/0x100
>           topology_parse_cpu_capacity+0x8c/0x178
>           get_cpu_for_node+0x88/0xc4
>           parse_cluster+0x1b0/0x28c
>           parse_cluster+0x8c/0x28c
>           init_cpu_topology+0x168/0x188
>           smp_prepare_cpus+0x24/0xf8
>           kernel_init_freeable+0x18c/0x34c
>           kernel_init+0x30/0x134
>           ret_from_fork+0x10/0x20
>
>    -> #1 (fs_reclaim){+.+.}-{0:0}:
>           __fs_reclaim_acquire+0x3c/0x48
>           fs_reclaim_acquire+0x54/0xa8
>           slab_pre_alloc_hook.constprop.0+0x40/0x25c
>           __kmem_cache_alloc_node+0x60/0x1cc
>           kmalloc_trace+0x50/0xa8
>           dev_pm_qos_constraints_allocate+0x38/0x100
>           __dev_pm_qos_add_request+0xb0/0x1e8
>           dev_pm_qos_add_request+0x58/0x80
>           dev_pm_qos_expose_latency_limit+0x60/0x13c
>           register_cpu+0x12c/0x130
>           topology_init+0xac/0xbc
>           do_one_initcall+0x104/0x2bc
>           kernel_init_freeable+0x344/0x34c
>           kernel_init+0x30/0x134
>           ret_from_fork+0x10/0x20
>
>    -> #0 (dev_pm_qos_mtx){+.+.}-{3:3}:
>           __lock_acquire+0xe00/0x1060
>           lock_acquire+0x1e0/0x2f8
>           __mutex_lock+0xcc/0x3c8
>           mutex_lock_nested+0x30/0x44
>           dev_pm_qos_update_request+0x38/0x68
>           msm_devfreq_boost+0x40/0x70
>           msm_devfreq_active+0xc0/0xf0
>           msm_gpu_submit+0x10c/0x178
>           msm_job_run+0x78/0x150
>           drm_sched_main+0x290/0x370
>           kthread+0xf0/0x100
>           ret_from_fork+0x10/0x20
>
>    other info that might help us debug this:
>
>    Chain exists of:
>      dev_pm_qos_mtx --> dma_fence_map --> &gpu->active_lock
>
>     Possible unsafe locking scenario:
>
>           CPU0                    CPU1
>           ----                    ----
>      lock(&gpu->active_lock);
>                                   lock(dma_fence_map);
>                                   lock(&gpu->active_lock);
>      lock(dev_pm_qos_mtx);
>
>     *** DEADLOCK ***
>
>    3 locks held by ring0/123:
>     #0: ffffff8087251170 (&gpu->lock){+.+.}-{3:3}, at: msm_job_run+0x64/0x150
>     #1: ffffffd00b0e57e8 (dma_fence_map){++++}-{0:0}, at: msm_job_run+0x68/0x150
>     #2: ffffff8087251208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178
>
>    stack backtrace:
>    CPU: 6 PID: 123 Comm: ring0 Not tainted 6.2.0-rc8-debug+ #559
>    Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
>    Call trace:
>     dump_backtrace.part.0+0xb4/0xf8
>     show_stack+0x20/0x38
>     dump_stack_lvl+0x9c/0xd0
>     dump_stack+0x18/0x34
>     print_circular_bug+0x1b4/0x1f0
>     check_noncircular+0x78/0xac
>     __lock_acquire+0xe00/0x1060
>     lock_acquire+0x1e0/0x2f8
>     __mutex_lock+0xcc/0x3c8
>     mutex_lock_nested+0x30/0x44
>     dev_pm_qos_update_request+0x38/0x68
>     msm_devfreq_boost+0x40/0x70
>     msm_devfreq_active+0xc0/0xf0
>     msm_gpu_submit+0x10c/0x178
>     msm_job_run+0x78/0x150
>     drm_sched_main+0x290/0x370
>     kthread+0xf0/0x100
>     ret_from_fork+0x10/0x20
>
> The issue is that dev_pm_qos_mtx is held in the runpm suspend/resume (or
> freq change) path, but it is also held across allocations that could
> recurse into shrinker.
>
> Solve this by changing dev_pm_qos_constraints_allocate() into a function
> that can be called unconditionally before the device qos object is
> needed and before aquiring dev_pm_qos_mtx.  This way the allocations can

acquiring

> be done without holding the mutex.  In the case that we raced with
> another thread to allocate the qos object, detect this *after* acquiring
> the dev_pm_qos_mtx and simply free the redundant allocations.
>
> Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Please feel free to add

Acked-by: Rafael J. Wysocki <rafael@kernel.org>

to this patch and the next 2 PM QoS ones in this series.

Thanks!

> ---
>  drivers/base/power/qos.c | 76 +++++++++++++++++++++++++++++-----------
>  1 file changed, 56 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 8e93167f1783..7e95760d16dc 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -185,27 +185,33 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>  }
>
>  /*
> - * dev_pm_qos_constraints_allocate
> + * dev_pm_qos_constraints_allocate: Allocate and initializes qos constraints
>   * @dev: device to allocate data for
>   *
> - * Called at the first call to add_request, for constraint data allocation
> - * Must be called with the dev_pm_qos_mtx mutex held
> + * Called to allocate constraints before dev_pm_qos_mtx mutex is held.  Should
> + * be matched with a call to dev_pm_qos_constraints_set() once dev_pm_qos_mtx
> + * is held.
>   */
> -static int dev_pm_qos_constraints_allocate(struct device *dev)
> +static struct dev_pm_qos *dev_pm_qos_constraints_allocate(struct device *dev)
>  {
>         struct dev_pm_qos *qos;
>         struct pm_qos_constraints *c;
>         struct blocking_notifier_head *n;
>
> -       qos = kzalloc(sizeof(*qos), GFP_KERNEL);
> +       /*
> +        * If constraints are already allocated, we can skip speculatively
> +        * allocating a new one, as we don't have to work about qos transitioning
> +        * from non-null to null.  The constraints are only freed on device
> +        * removal.
> +        */
> +       if (dev->power.qos)
> +               return NULL;
> +
> +       qos = kzalloc(sizeof(*qos) + 3 * sizeof(*n), GFP_KERNEL);
>         if (!qos)
> -               return -ENOMEM;
> +               return NULL;
>
> -       n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
> -       if (!n) {
> -               kfree(qos);
> -               return -ENOMEM;
> -       }
> +       n = (struct blocking_notifier_head *)(qos + 1);
>
>         c = &qos->resume_latency;
>         plist_head_init(&c->list);
> @@ -227,11 +233,29 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>
>         INIT_LIST_HEAD(&qos->flags.list);
>
> +       return qos;
> +}
> +
> +/*
> + * dev_pm_qos_constraints_set: Ensure dev->power.qos is set
> + *
> + * If dev->power.qos is already set, free the newly allocated qos constraints.
> + * Otherwise set dev->power.qos.  Must be called with dev_pm_qos_mtx held.
> + *
> + * This split unsynchronized allocation and synchronized set moves allocation
> + * out from under dev_pm_qos_mtx, so that lockdep does does not get angry about
> + * drivers which use dev_pm_qos in paths related to shrinker/reclaim.
> + */
> +static void dev_pm_qos_constraints_set(struct device *dev, struct dev_pm_qos *qos)
> +{
> +       if (dev->power.qos) {
> +               kfree(qos);
> +               return;
> +       }
> +
>         spin_lock_irq(&dev->power.lock);
>         dev->power.qos = qos;
>         spin_unlock_irq(&dev->power.lock);
> -
> -       return 0;
>  }
>
>  static void __dev_pm_qos_hide_latency_limit(struct device *dev);
> @@ -309,7 +333,6 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
>         dev->power.qos = ERR_PTR(-ENODEV);
>         spin_unlock_irq(&dev->power.lock);
>
> -       kfree(qos->resume_latency.notifiers);
>         kfree(qos);
>
>   out:
> @@ -341,7 +364,7 @@ static int __dev_pm_qos_add_request(struct device *dev,
>         if (IS_ERR(dev->power.qos))
>                 ret = -ENODEV;
>         else if (!dev->power.qos)
> -               ret = dev_pm_qos_constraints_allocate(dev);
> +               ret = -ENOMEM;
>
>         trace_dev_pm_qos_add_request(dev_name(dev), type, value);
>         if (ret)
> @@ -388,9 +411,11 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>                            enum dev_pm_qos_req_type type, s32 value)
>  {
> +       struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
>         int ret;
>
>         mutex_lock(&dev_pm_qos_mtx);
> +       dev_pm_qos_constraints_set(dev, qos);
>         ret = __dev_pm_qos_add_request(dev, req, type, value);
>         mutex_unlock(&dev_pm_qos_mtx);
>         return ret;
> @@ -535,14 +560,15 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
>  int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>                             enum dev_pm_qos_req_type type)
>  {
> +       struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
>         int ret = 0;
>
>         mutex_lock(&dev_pm_qos_mtx);
>
> +       dev_pm_qos_constraints_set(dev, qos);
> +
>         if (IS_ERR(dev->power.qos))
>                 ret = -ENODEV;
> -       else if (!dev->power.qos)
> -               ret = dev_pm_qos_constraints_allocate(dev);
>
>         if (ret)
>                 goto unlock;
> @@ -903,12 +929,22 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
>   */
>  int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>  {
> -       int ret;
> +       struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
> +       int ret = 0;
>
>         mutex_lock(&dev_pm_qos_mtx);
>
> -       if (IS_ERR_OR_NULL(dev->power.qos)
> -           || !dev->power.qos->latency_tolerance_req) {
> +       dev_pm_qos_constraints_set(dev, qos);
> +
> +       if (IS_ERR(dev->power.qos))
> +               ret = -ENODEV;
> +       else if (!dev->power.qos)
> +               ret = -ENOMEM;
> +
> +       if (ret)
> +               goto out;
> +
> +       if (!dev->power.qos->latency_tolerance_req) {
>                 struct dev_pm_qos_request *req;
>
>                 if (val < 0) {
> --
> 2.41.0
>
