Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D635E7706B9
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjHDRIN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 4 Aug 2023 13:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbjHDRHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:07:48 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0092E4C37;
        Fri,  4 Aug 2023 10:07:32 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-56c9f7830c2so283039eaf.0;
        Fri, 04 Aug 2023 10:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691168852; x=1691773652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z1CXsgfrjEAWep9hI/ctvaaP8FIhfUSQJg+TJpDHVxQ=;
        b=Vr2ZwRZfS+nxRvqz+dwkAp4LI1iMP5xkdppxDYuxAo1FNScCMlEyPXtVv7Gb7a50rJ
         y3uOaDlTOnq7iF1FryxuZuUnrU+P3R79/e240Bif342cenW3Uk+EsbvLhkzzkmpecy0p
         xNggnknF5EBduATuEllzneNXL6WViHPKpxTKm6euCsmN2CIbY0nbVavMkHlxmRYxIHlM
         c/MTa2Vhg1SWRThQeO8k+nWPN5zA2D9+zihxg1I5+Uwbha8iNk5VhlMfFQ5ck6UKwwB6
         kKaTjxckM/w1xE+YbYUy82kACevQj1VEaxK/HSlQuVAeeK59j9wcerAu771wsfkOsuTs
         BJog==
X-Gm-Message-State: ABy/qLa2GlJU+xjL9QRBu0euWL+Aac/USY1DD+kSLETT5n5wdk6SCAOK
        x5R8Y0eU/AmQf2E1xanLnY3z3TBVrFad7jVEKYLEoU87
X-Google-Smtp-Source: APBJJlFCJhoiui5Hxa1jzIDk2waWFhczbVSi6aneX2Ij8bD/evEWwOn5+icDcP1ALUzOlsu6rNLTPwSB3X1p4UiH+gU=
X-Received: by 2002:a05:6820:1686:b0:56c:5e21:c730 with SMTP id
 bc6-20020a056820168600b0056c5e21c730mr18404719oob.1.1691168851909; Fri, 04
 Aug 2023 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230803220202.78036-1-robdclark@gmail.com> <20230803220202.78036-4-robdclark@gmail.com>
In-Reply-To: <20230803220202.78036-4-robdclark@gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 4 Aug 2023 19:07:19 +0200
Message-ID: <CAJZ5v0jV+Da+kw5JuGAhuGA6QJKmteCfnjGCk8DrNOe8Gvdg5w@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] PM / QoS: Fix constraints alloc vs reclaim locking
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:HIBERNATION (aka Software Suspend, aka swsusp)" 
        <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 12:02 AM Rob Clark <robdclark@gmail.com> wrote:
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
> be done without holding the mutex.  In the case that we raced with
> another thread to allocate the qos object, detect this *after* acquiring
> the dev_pm_qos_mtx and simply free the redundant allocations.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/base/power/qos.c | 60 +++++++++++++++++++++++++++-------------
>  1 file changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
> index 8e93167f1783..f3e0c6b65635 100644
> --- a/drivers/base/power/qos.c
> +++ b/drivers/base/power/qos.c
> @@ -185,18 +185,24 @@ static int apply_constraint(struct dev_pm_qos_request *req,
>  }
>
>  /*
> - * dev_pm_qos_constraints_allocate
> + * dev_pm_qos_constraints_ensure_allocated
>   * @dev: device to allocate data for
>   *
> - * Called at the first call to add_request, for constraint data allocation
> - * Must be called with the dev_pm_qos_mtx mutex held
> + * Called to ensure that devices qos is allocated, before acquiring
> + * dev_pm_qos_mtx.
>   */
> -static int dev_pm_qos_constraints_allocate(struct device *dev)
> +static int dev_pm_qos_constraints_ensure_allocated(struct device *dev)
>  {
>         struct dev_pm_qos *qos;
>         struct pm_qos_constraints *c;
>         struct blocking_notifier_head *n;
>
> +       if (!dev)
> +               return -ENODEV;
> +
> +       if (!IS_ERR_OR_NULL(dev->power.qos))
> +               return 0;
> +
>         qos = kzalloc(sizeof(*qos), GFP_KERNEL);
>         if (!qos)
>                 return -ENOMEM;
> @@ -227,10 +233,26 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
>
>         INIT_LIST_HEAD(&qos->flags.list);
>
> +       mutex_lock(&dev_pm_qos_mtx);
> +
> +       if (!IS_ERR_OR_NULL(dev->power.qos)) {
> +               /*
> +                * We have raced with another task to create the qos.
> +                * No biggie, just free the resources we've allocated
> +                * outside of dev_pm_qos_mtx and move on with life.
> +                */
> +               kfree(n);
> +               kfree(qos);
> +               goto unlock;
> +       }
> +
>         spin_lock_irq(&dev->power.lock);
>         dev->power.qos = qos;
>         spin_unlock_irq(&dev->power.lock);
>
> +unlock:
> +       mutex_unlock(&dev_pm_qos_mtx);
> +
>         return 0;
>  }
>
> @@ -331,17 +353,15 @@ static int __dev_pm_qos_add_request(struct device *dev,
>  {
>         int ret = 0;
>
> -       if (!dev || !req || dev_pm_qos_invalid_req_type(dev, type))
> +       if (!req || dev_pm_qos_invalid_req_type(dev, type))
>                 return -EINVAL;
>
>         if (WARN(dev_pm_qos_request_active(req),
>                  "%s() called for already added request\n", __func__))
>                 return -EINVAL;
>
> -       if (IS_ERR(dev->power.qos))
> +       if (IS_ERR_OR_NULL(dev->power.qos))
>                 ret = -ENODEV;
> -       else if (!dev->power.qos)
> -               ret = dev_pm_qos_constraints_allocate(dev);
>
>         trace_dev_pm_qos_add_request(dev_name(dev), type, value);
>         if (ret)
> @@ -390,6 +410,10 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
>  {
>         int ret;
>
> +       ret = dev_pm_qos_constraints_ensure_allocated(dev);
> +       if (ret)
> +               return ret;
> +

It is a bit unfortunate that the mutex is dropped and then immediately
re-acquired again.  I don't think that this is strictly necessary.

>         mutex_lock(&dev_pm_qos_mtx);
>         ret = __dev_pm_qos_add_request(dev, req, type, value);
>         mutex_unlock(&dev_pm_qos_mtx);
> @@ -537,15 +561,11 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>  {
>         int ret = 0;
>
> -       mutex_lock(&dev_pm_qos_mtx);
> -
> -       if (IS_ERR(dev->power.qos))
> -               ret = -ENODEV;
> -       else if (!dev->power.qos)
> -               ret = dev_pm_qos_constraints_allocate(dev);
> -
> +       ret = dev_pm_qos_constraints_ensure_allocated(dev);
>         if (ret)
> -               goto unlock;
> +               return ret;
> +
> +       mutex_lock(&dev_pm_qos_mtx);
>
>         switch (type) {
>         case DEV_PM_QOS_RESUME_LATENCY:
> @@ -565,7 +585,6 @@ int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
>                 ret = -EINVAL;
>         }
>
> -unlock:
>         mutex_unlock(&dev_pm_qos_mtx);
>         return ret;
>  }
> @@ -905,10 +924,13 @@ int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
>  {
>         int ret;
>
> +       ret = dev_pm_qos_constraints_ensure_allocated(dev);
> +       if (ret)
> +               return ret;
> +
>         mutex_lock(&dev_pm_qos_mtx);
>
> -       if (IS_ERR_OR_NULL(dev->power.qos)
> -           || !dev->power.qos->latency_tolerance_req) {
> +       if (!dev->power.qos->latency_tolerance_req) {
>                 struct dev_pm_qos_request *req;
>
>                 if (val < 0) {
> --
> 2.41.0
>
