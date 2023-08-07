Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A3B772C59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 19:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbjHGRMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 13:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232076AbjHGRMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 13:12:14 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B5A199E;
        Mon,  7 Aug 2023 10:12:04 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686ed1d2594so4588739b3a.2;
        Mon, 07 Aug 2023 10:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691428323; x=1692033123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm9RgRC6tznwqooFeD+lKnTxioeCkD8Qbdpn7m4WEDU=;
        b=a08MWCAMTCs175Y5okb3Z1QzVI9NJf/EqYItJGXAf+RNjvvPoTNlv7B0dWyXU0kva1
         pKbi3614Ymc/drUmxFQeHePCXdQItH+L80U2JlkxwusdxMh5dVWZQF1itvIZJ8NN+2PD
         CBwQlDewOJV0p/qGMW/cYnQRBTYPqWex8fg6WpqlUf1ufsyctFNFkxw9r8TMW2VhXAWW
         XIY9o7mqBRH7ol+p4qF6DcdZQygz6zrsQEhEmInfXLyuS7HkbQX+EbZ4w1bXoSb1abXx
         016T+e3ChFonuma6BFtdsIv9ZPoSXOplKqG4MiG8OWudYVDAGbiI3S6f5X9xHFYSGp2f
         hbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691428323; x=1692033123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xm9RgRC6tznwqooFeD+lKnTxioeCkD8Qbdpn7m4WEDU=;
        b=UUVQOXzBVAU+RQYPUARUeHCWUEYVH5gnGLIzy219pnUD40P9Sty4znFAPkR1MQjtd0
         xYXpHrVPlG3DHFiW8eY/tk8cLWaM9oo7LzRh/5nK00FmEBC+Jt77rQ0ooRBjtMGjflCM
         pWASvcfLTMS3WC5rN4EGPc8OptRq7VBtuYePGP9tFTA2Ayog5vvNCZ1OJNMQjEppSpN0
         rxTGxVH/uFYY7ncUonoZjE966sRNcG6a+ngvHG/w6VMOTPyHH6cEPHIWy5a+I6+HRZzM
         Xprey112rlY5Cbz+tBs3HqBHziyOzlqBE25gcMWk1tCsv/tmxqPTz2U+gk5Wycm50kJ7
         6AZw==
X-Gm-Message-State: AOJu0YxFSue7SyOeH4husDltD1gsficdj+KzXPv5PdHtdceC+X7F7VuM
        Ock9Mpp7U+RElCPth4+4q+U=
X-Google-Smtp-Source: AGHT+IF6kuKj6C6S06HJR0xiaMcT6iPTjFa3X7M1J3b2Z+2QtWLtotUul4QpU1D7GhnlElz1rFaTXA==
X-Received: by 2002:a05:6a00:2288:b0:687:82f9:3d89 with SMTP id f8-20020a056a00228800b0068782f93d89mr13698158pfe.24.1691428323391;
        Mon, 07 Aug 2023 10:12:03 -0700 (PDT)
Received: from localhost ([2a00:79e1:abd:4a00:6c80:7c10:75a0:44f4])
        by smtp.gmail.com with ESMTPSA id f7-20020aa78b07000000b00686f082cc0fsm6353234pfd.106.2023.08.07.10.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 10:12:02 -0700 (PDT)
From:   Rob Clark <robdclark@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org (open list:HIBERNATION (aka Software Suspend,
        aka swsusp)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/9] PM / QoS: Fix constraints alloc vs reclaim locking
Date:   Mon,  7 Aug 2023 10:11:37 -0700
Message-ID: <20230807171148.210181-4-robdclark@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807171148.210181-1-robdclark@gmail.com>
References: <20230807171148.210181-1-robdclark@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rob Clark <robdclark@chromium.org>

In the process of adding lockdep annotation for drm GPU scheduler's
job_run() to detect potential deadlock against shrinker/reclaim, I hit
this lockdep splat:

   ======================================================
   WARNING: possible circular locking dependency detected
   6.2.0-rc8-debug+ #558 Tainted: G        W
   ------------------------------------------------------
   ring0/125 is trying to acquire lock:
   ffffffd6d6ce0f28 (dev_pm_qos_mtx){+.+.}-{3:3}, at: dev_pm_qos_update_request+0x38/0x68

   but task is already holding lock:
   ffffff8087239208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178

   which lock already depends on the new lock.

   the existing dependency chain (in reverse order) is:

   -> #4 (&gpu->active_lock){+.+.}-{3:3}:
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          msm_gpu_submit+0xec/0x178
          msm_job_run+0x78/0x150
          drm_sched_main+0x290/0x370
          kthread+0xf0/0x100
          ret_from_fork+0x10/0x20

   -> #3 (dma_fence_map){++++}-{0:0}:
          __dma_fence_might_wait+0x74/0xc0
          dma_resv_lockdep+0x1f4/0x2f4
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #2 (mmu_notifier_invalidate_range_start){+.+.}-{0:0}:
          fs_reclaim_acquire+0x80/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          __kmalloc+0xd8/0x100
          topology_parse_cpu_capacity+0x8c/0x178
          get_cpu_for_node+0x88/0xc4
          parse_cluster+0x1b0/0x28c
          parse_cluster+0x8c/0x28c
          init_cpu_topology+0x168/0x188
          smp_prepare_cpus+0x24/0xf8
          kernel_init_freeable+0x18c/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #1 (fs_reclaim){+.+.}-{0:0}:
          __fs_reclaim_acquire+0x3c/0x48
          fs_reclaim_acquire+0x54/0xa8
          slab_pre_alloc_hook.constprop.0+0x40/0x25c
          __kmem_cache_alloc_node+0x60/0x1cc
          kmalloc_trace+0x50/0xa8
          dev_pm_qos_constraints_allocate+0x38/0x100
          __dev_pm_qos_add_request+0xb0/0x1e8
          dev_pm_qos_add_request+0x58/0x80
          dev_pm_qos_expose_latency_limit+0x60/0x13c
          register_cpu+0x12c/0x130
          topology_init+0xac/0xbc
          do_one_initcall+0x104/0x2bc
          kernel_init_freeable+0x344/0x34c
          kernel_init+0x30/0x134
          ret_from_fork+0x10/0x20

   -> #0 (dev_pm_qos_mtx){+.+.}-{3:3}:
          __lock_acquire+0xe00/0x1060
          lock_acquire+0x1e0/0x2f8
          __mutex_lock+0xcc/0x3c8
          mutex_lock_nested+0x30/0x44
          dev_pm_qos_update_request+0x38/0x68
          msm_devfreq_boost+0x40/0x70
          msm_devfreq_active+0xc0/0xf0
          msm_gpu_submit+0x10c/0x178
          msm_job_run+0x78/0x150
          drm_sched_main+0x290/0x370
          kthread+0xf0/0x100
          ret_from_fork+0x10/0x20

   other info that might help us debug this:

   Chain exists of:
     dev_pm_qos_mtx --> dma_fence_map --> &gpu->active_lock

    Possible unsafe locking scenario:

          CPU0                    CPU1
          ----                    ----
     lock(&gpu->active_lock);
                                  lock(dma_fence_map);
                                  lock(&gpu->active_lock);
     lock(dev_pm_qos_mtx);

    *** DEADLOCK ***

   3 locks held by ring0/123:
    #0: ffffff8087251170 (&gpu->lock){+.+.}-{3:3}, at: msm_job_run+0x64/0x150
    #1: ffffffd00b0e57e8 (dma_fence_map){++++}-{0:0}, at: msm_job_run+0x68/0x150
    #2: ffffff8087251208 (&gpu->active_lock){+.+.}-{3:3}, at: msm_gpu_submit+0xec/0x178

   stack backtrace:
   CPU: 6 PID: 123 Comm: ring0 Not tainted 6.2.0-rc8-debug+ #559
   Hardware name: Google Lazor (rev1 - 2) with LTE (DT)
   Call trace:
    dump_backtrace.part.0+0xb4/0xf8
    show_stack+0x20/0x38
    dump_stack_lvl+0x9c/0xd0
    dump_stack+0x18/0x34
    print_circular_bug+0x1b4/0x1f0
    check_noncircular+0x78/0xac
    __lock_acquire+0xe00/0x1060
    lock_acquire+0x1e0/0x2f8
    __mutex_lock+0xcc/0x3c8
    mutex_lock_nested+0x30/0x44
    dev_pm_qos_update_request+0x38/0x68
    msm_devfreq_boost+0x40/0x70
    msm_devfreq_active+0xc0/0xf0
    msm_gpu_submit+0x10c/0x178
    msm_job_run+0x78/0x150
    drm_sched_main+0x290/0x370
    kthread+0xf0/0x100
    ret_from_fork+0x10/0x20

The issue is that dev_pm_qos_mtx is held in the runpm suspend/resume (or
freq change) path, but it is also held across allocations that could
recurse into shrinker.

Solve this by changing dev_pm_qos_constraints_allocate() into a function
that can be called unconditionally before the device qos object is
needed and before aquiring dev_pm_qos_mtx.  This way the allocations can
be done without holding the mutex.  In the case that we raced with
another thread to allocate the qos object, detect this *after* acquiring
the dev_pm_qos_mtx and simply free the redundant allocations.

Suggested-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
One small change from the RFC[1], it skips the allocation if
dev->power.qos is already allocated.  Since this is only freed on
device removal, it seems safe to rely on not seeing a !null to null
transition.

[1] https://patchwork.freedesktop.org/patch/551436/?series=122056&rev=1

 drivers/base/power/qos.c | 76 +++++++++++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 20 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 8e93167f1783..7e95760d16dc 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -185,27 +185,33 @@ static int apply_constraint(struct dev_pm_qos_request *req,
 }
 
 /*
- * dev_pm_qos_constraints_allocate
+ * dev_pm_qos_constraints_allocate: Allocate and initializes qos constraints
  * @dev: device to allocate data for
  *
- * Called at the first call to add_request, for constraint data allocation
- * Must be called with the dev_pm_qos_mtx mutex held
+ * Called to allocate constraints before dev_pm_qos_mtx mutex is held.  Should
+ * be matched with a call to dev_pm_qos_constraints_set() once dev_pm_qos_mtx
+ * is held.
  */
-static int dev_pm_qos_constraints_allocate(struct device *dev)
+static struct dev_pm_qos *dev_pm_qos_constraints_allocate(struct device *dev)
 {
 	struct dev_pm_qos *qos;
 	struct pm_qos_constraints *c;
 	struct blocking_notifier_head *n;
 
-	qos = kzalloc(sizeof(*qos), GFP_KERNEL);
+	/*
+	 * If constraints are already allocated, we can skip speculatively
+	 * allocating a new one, as we don't have to work about qos transitioning
+	 * from non-null to null.  The constraints are only freed on device
+	 * removal.
+	 */
+	if (dev->power.qos)
+		return NULL;
+
+	qos = kzalloc(sizeof(*qos) + 3 * sizeof(*n), GFP_KERNEL);
 	if (!qos)
-		return -ENOMEM;
+		return NULL;
 
-	n = kzalloc(3 * sizeof(*n), GFP_KERNEL);
-	if (!n) {
-		kfree(qos);
-		return -ENOMEM;
-	}
+	n = (struct blocking_notifier_head *)(qos + 1);
 
 	c = &qos->resume_latency;
 	plist_head_init(&c->list);
@@ -227,11 +233,29 @@ static int dev_pm_qos_constraints_allocate(struct device *dev)
 
 	INIT_LIST_HEAD(&qos->flags.list);
 
+	return qos;
+}
+
+/*
+ * dev_pm_qos_constraints_set: Ensure dev->power.qos is set
+ *
+ * If dev->power.qos is already set, free the newly allocated qos constraints.
+ * Otherwise set dev->power.qos.  Must be called with dev_pm_qos_mtx held.
+ *
+ * This split unsynchronized allocation and synchronized set moves allocation
+ * out from under dev_pm_qos_mtx, so that lockdep does does not get angry about
+ * drivers which use dev_pm_qos in paths related to shrinker/reclaim.
+ */
+static void dev_pm_qos_constraints_set(struct device *dev, struct dev_pm_qos *qos)
+{
+	if (dev->power.qos) {
+		kfree(qos);
+		return;
+	}
+
 	spin_lock_irq(&dev->power.lock);
 	dev->power.qos = qos;
 	spin_unlock_irq(&dev->power.lock);
-
-	return 0;
 }
 
 static void __dev_pm_qos_hide_latency_limit(struct device *dev);
@@ -309,7 +333,6 @@ void dev_pm_qos_constraints_destroy(struct device *dev)
 	dev->power.qos = ERR_PTR(-ENODEV);
 	spin_unlock_irq(&dev->power.lock);
 
-	kfree(qos->resume_latency.notifiers);
 	kfree(qos);
 
  out:
@@ -341,7 +364,7 @@ static int __dev_pm_qos_add_request(struct device *dev,
 	if (IS_ERR(dev->power.qos))
 		ret = -ENODEV;
 	else if (!dev->power.qos)
-		ret = dev_pm_qos_constraints_allocate(dev);
+		ret = -ENOMEM;
 
 	trace_dev_pm_qos_add_request(dev_name(dev), type, value);
 	if (ret)
@@ -388,9 +411,11 @@ static int __dev_pm_qos_add_request(struct device *dev,
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value)
 {
+	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
 	int ret;
 
 	mutex_lock(&dev_pm_qos_mtx);
+	dev_pm_qos_constraints_set(dev, qos);
 	ret = __dev_pm_qos_add_request(dev, req, type, value);
 	mutex_unlock(&dev_pm_qos_mtx);
 	return ret;
@@ -535,14 +560,15 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_remove_request);
 int dev_pm_qos_add_notifier(struct device *dev, struct notifier_block *notifier,
 			    enum dev_pm_qos_req_type type)
 {
+	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
 	int ret = 0;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
+	dev_pm_qos_constraints_set(dev, qos);
+
 	if (IS_ERR(dev->power.qos))
 		ret = -ENODEV;
-	else if (!dev->power.qos)
-		ret = dev_pm_qos_constraints_allocate(dev);
 
 	if (ret)
 		goto unlock;
@@ -903,12 +929,22 @@ s32 dev_pm_qos_get_user_latency_tolerance(struct device *dev)
  */
 int dev_pm_qos_update_user_latency_tolerance(struct device *dev, s32 val)
 {
-	int ret;
+	struct dev_pm_qos *qos = dev_pm_qos_constraints_allocate(dev);
+	int ret = 0;
 
 	mutex_lock(&dev_pm_qos_mtx);
 
-	if (IS_ERR_OR_NULL(dev->power.qos)
-	    || !dev->power.qos->latency_tolerance_req) {
+	dev_pm_qos_constraints_set(dev, qos);
+
+	if (IS_ERR(dev->power.qos))
+		ret = -ENODEV;
+	else if (!dev->power.qos)
+		ret = -ENOMEM;
+
+	if (ret)
+		goto out;
+
+	if (!dev->power.qos->latency_tolerance_req) {
 		struct dev_pm_qos_request *req;
 
 		if (val < 0) {
-- 
2.41.0

