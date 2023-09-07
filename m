Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6FEB797F49
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 01:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbjIGXlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 19:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbjIGXlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 19:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EF91BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 16:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694130052;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0oM1ssWxMjgdk1YS4u11+h65Kummyok+rDsO3Fg0IQw=;
        b=X17/LaSIFNZpRmq0RAnDKFU9dAZGAEfbWADNpA1h8Unn/M583b23QvBFDrVeVoxRZuZc3p
        3uwz6vreDJd2Ty0cwNQfX0GkoMhf/e5nWMK+ejYKb7VvR23o+AmYnTux+B96lL3CPrWNAb
        gA8F4veepkBDj/z6yaZ360zCNWcUUYo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-6NQ9vefGMWyv6XydIaa9ag-1; Thu, 07 Sep 2023 19:40:50 -0400
X-MC-Unique: 6NQ9vefGMWyv6XydIaa9ag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8775C948C02;
        Thu,  7 Sep 2023 23:40:50 +0000 (UTC)
Received: from pasta.redhat.com (unknown [10.45.224.39])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DD1C412F2CF;
        Thu,  7 Sep 2023 23:40:49 +0000 (UTC)
From:   Andreas Gruenbacher <agruenba@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [RFC] kthread: Add kthread_stop_put
Date:   Fri,  8 Sep 2023 01:40:48 +0200
Message-Id: <20230907234048.2499820-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a kthread_stop_put() helper that stops a thread and puts its task
struct.  Use it to replace the various instances of kthread_stop()
followed by put_task_struct().

Remove the kthread_stop_put() macro in usbip that is similar but
doesn't return the result of kthread_stop().

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

diff --git a/drivers/accel/ivpu/ivpu_job.c b/drivers/accel/ivpu/ivpu_job.c
index de9e69f70af7..76f468c9f761 100644
--- a/drivers/accel/ivpu/ivpu_job.c
+++ b/drivers/accel/ivpu/ivpu_job.c
@@ -618,6 +618,5 @@ int ivpu_job_done_thread_init(struct ivpu_device *vdev)
 
 void ivpu_job_done_thread_fini(struct ivpu_device *vdev)
 {
-	kthread_stop(vdev->job_done_thread);
-	put_task_struct(vdev->job_done_thread);
+	kthread_stop_put(vdev->job_done_thread);
 }
diff --git a/drivers/dma-buf/st-dma-fence-chain.c b/drivers/dma-buf/st-dma-fence-chain.c
index c0979c8049b5..9c2a0c082a76 100644
--- a/drivers/dma-buf/st-dma-fence-chain.c
+++ b/drivers/dma-buf/st-dma-fence-chain.c
@@ -476,10 +476,9 @@ static int find_race(void *arg)
 	for (i = 0; i < ncpus; i++) {
 		int ret;
 
-		ret = kthread_stop(threads[i]);
+		ret = kthread_stop_put(threads[i]);
 		if (ret && !err)
 			err = ret;
-		put_task_struct(threads[i]);
 	}
 	kfree(threads);
 
@@ -591,8 +590,7 @@ static int wait_forward(void *arg)
 	for (i = 0; i < fc.chain_length; i++)
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
@@ -621,8 +619,7 @@ static int wait_backward(void *arg)
 	for (i = fc.chain_length; i--; )
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
@@ -669,8 +666,7 @@ static int wait_random(void *arg)
 	for (i = 0; i < fc.chain_length; i++)
 		dma_fence_signal(fc.fences[i]);
 
-	err = kthread_stop(tsk);
-	put_task_struct(tsk);
+	err = kthread_stop_put(tsk);
 
 err:
 	fence_chains_fini(&fc);
diff --git a/drivers/dma-buf/st-dma-fence.c b/drivers/dma-buf/st-dma-fence.c
index fb6e0a6ae2c9..b7c6f7ea9e0c 100644
--- a/drivers/dma-buf/st-dma-fence.c
+++ b/drivers/dma-buf/st-dma-fence.c
@@ -548,11 +548,9 @@ static int race_signal_callback(void *arg)
 		for (i = 0; i < ARRAY_SIZE(t); i++) {
 			int err;
 
-			err = kthread_stop(t[i].task);
+			err = kthread_stop_put(t[i].task);
 			if (err && !ret)
 				ret = err;
-
-			put_task_struct(t[i].task);
 		}
 	}
 
diff --git a/drivers/gpu/drm/i915/gt/selftest_migrate.c b/drivers/gpu/drm/i915/gt/selftest_migrate.c
index 3def5ca72dec..0fb07f073baa 100644
--- a/drivers/gpu/drm/i915/gt/selftest_migrate.c
+++ b/drivers/gpu/drm/i915/gt/selftest_migrate.c
@@ -719,11 +719,9 @@ static int threaded_migrate(struct intel_migrate *migrate,
 		if (IS_ERR_OR_NULL(tsk))
 			continue;
 
-		status = kthread_stop(tsk);
+		status = kthread_stop_put(tsk);
 		if (status && !err)
 			err = status;
-
-		put_task_struct(tsk);
 	}
 
 	kfree(thread);
diff --git a/drivers/net/xen-netback/interface.c b/drivers/net/xen-netback/interface.c
index f3f2c07423a6..33c8143619f0 100644
--- a/drivers/net/xen-netback/interface.c
+++ b/drivers/net/xen-netback/interface.c
@@ -672,8 +672,7 @@ int xenvif_connect_ctrl(struct xenvif *vif, grant_ref_t ring_ref,
 static void xenvif_disconnect_queue(struct xenvif_queue *queue)
 {
 	if (queue->task) {
-		kthread_stop(queue->task);
-		put_task_struct(queue->task);
+		kthread_stop_put(queue->task);
 		queue->task = NULL;
 	}
 
diff --git a/drivers/usb/usbip/usbip_common.h b/drivers/usb/usbip/usbip_common.h
index d8cbd2dfc2c2..282efca64a01 100644
--- a/drivers/usb/usbip/usbip_common.h
+++ b/drivers/usb/usbip/usbip_common.h
@@ -298,12 +298,6 @@ struct usbip_device {
 	__k;								   \
 })
 
-#define kthread_stop_put(k)		\
-	do {				\
-		kthread_stop(k);	\
-		put_task_struct(k);	\
-	} while (0)
-
 /* usbip_common.c */
 void usbip_dump_urb(struct urb *purb);
 void usbip_dump_header(struct usbip_header *pdu);
diff --git a/fs/gfs2/ops_fstype.c b/fs/gfs2/ops_fstype.c
index 33ca04733e93..ecf789b7168c 100644
--- a/fs/gfs2/ops_fstype.c
+++ b/fs/gfs2/ops_fstype.c
@@ -1126,8 +1126,7 @@ static int init_threads(struct gfs2_sbd *sdp)
 	return 0;
 
 fail:
-	kthread_stop(sdp->sd_logd_process);
-	put_task_struct(sdp->sd_logd_process);
+	kthread_stop_put(sdp->sd_logd_process);
 	sdp->sd_logd_process = NULL;
 	return error;
 }
@@ -1135,13 +1134,11 @@ static int init_threads(struct gfs2_sbd *sdp)
 void gfs2_destroy_threads(struct gfs2_sbd *sdp)
 {
 	if (sdp->sd_logd_process) {
-		kthread_stop(sdp->sd_logd_process);
-		put_task_struct(sdp->sd_logd_process);
+		kthread_stop_put(sdp->sd_logd_process);
 		sdp->sd_logd_process = NULL;
 	}
 	if (sdp->sd_quotad_process) {
-		kthread_stop(sdp->sd_quotad_process);
-		put_task_struct(sdp->sd_quotad_process);
+		kthread_stop_put(sdp->sd_quotad_process);
 		sdp->sd_quotad_process = NULL;
 	}
 }
diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 2c30ade43bc8..b11f53c1ba2e 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -86,6 +86,7 @@ void free_kthread_struct(struct task_struct *k);
 void kthread_bind(struct task_struct *k, unsigned int cpu);
 void kthread_bind_mask(struct task_struct *k, const struct cpumask *mask);
 int kthread_stop(struct task_struct *k);
+int kthread_stop_put(struct task_struct *k);
 bool kthread_should_stop(void);
 bool kthread_should_park(void);
 bool kthread_should_stop_or_park(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d309ba84e08a..1782f90cd8c6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1852,15 +1852,13 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		struct task_struct *t = new->thread;
 
 		new->thread = NULL;
-		kthread_stop(t);
-		put_task_struct(t);
+		kthread_stop_put(t);
 	}
 	if (new->secondary && new->secondary->thread) {
 		struct task_struct *t = new->secondary->thread;
 
 		new->secondary->thread = NULL;
-		kthread_stop(t);
-		put_task_struct(t);
+		kthread_stop_put(t);
 	}
 out_mput:
 	module_put(desc->owner);
@@ -1971,12 +1969,9 @@ static struct irqaction *__free_irq(struct irq_desc *desc, void *dev_id)
 	 * the same bit to a newly requested action.
 	 */
 	if (action->thread) {
-		kthread_stop(action->thread);
-		put_task_struct(action->thread);
-		if (action->secondary && action->secondary->thread) {
-			kthread_stop(action->secondary->thread);
-			put_task_struct(action->secondary->thread);
-		}
+		kthread_stop_put(action->thread);
+		if (action->secondary && action->secondary->thread)
+			kthread_stop_put(action->secondary->thread);
 	}
 
 	/* Last action releases resources */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index c46128ec0c0a..99ee8d11bfcc 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -715,6 +715,30 @@ int kthread_stop(struct task_struct *k)
 }
 EXPORT_SYMBOL(kthread_stop);
 
+/**
+ * kthread_stop_put - stop a thread and put its task struct
+ *
+ * Stops a kthread and put its task_struct.  This is meant for callers
+ * that are holding an extra reference on the task struct, for example:
+ *
+ *   t = kthread_create(...);
+ *   if (!IS_ERR(t)) {
+ *     get_task_struct(t);
+ *     wake_up_process(t);
+ *   }
+ *
+ * Returns the result of kthread_stop().
+ */
+int kthread_stop_put(struct task_struct *k)
+{
+	int ret;
+
+	ret = kthread_stop(k);
+	put_task_struct(k);
+	return ret;
+}
+EXPORT_SYMBOL(kthread_stop_put);
+
 int kthreadd(void *unused)
 {
 	struct task_struct *tsk = current;
diff --git a/kernel/smpboot.c b/kernel/smpboot.c
index f47d8f375946..1992b62e980b 100644
--- a/kernel/smpboot.c
+++ b/kernel/smpboot.c
@@ -272,8 +272,7 @@ static void smpboot_destroy_threads(struct smp_hotplug_thread *ht)
 		struct task_struct *tsk = *per_cpu_ptr(ht->store, cpu);
 
 		if (tsk) {
-			kthread_stop(tsk);
-			put_task_struct(tsk);
+			kthread_stop_put(tsk);
 			*per_cpu_ptr(ht->store, cpu) = NULL;
 		}
 	}
diff --git a/mm/damon/core.c b/mm/damon/core.c
index bcd2bd9d6c10..2f54f153d7f5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -699,8 +699,7 @@ static int __damon_stop(struct damon_ctx *ctx)
 	if (tsk) {
 		get_task_struct(tsk);
 		mutex_unlock(&ctx->kdamond_lock);
-		kthread_stop(tsk);
-		put_task_struct(tsk);
+		kthread_stop_put(tsk);
 		return 0;
 	}
 	mutex_unlock(&ctx->kdamond_lock);
diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index f56b8d697014..826250a0f5b1 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -3982,8 +3982,7 @@ static void __net_exit pg_net_exit(struct net *net)
 	list_for_each_safe(q, n, &list) {
 		t = list_entry(q, struct pktgen_thread, th_list);
 		list_del(&t->th_list);
-		kthread_stop(t->tsk);
-		put_task_struct(t->tsk);
+		kthread_stop_put(t->tsk);
 		kfree(t);
 	}
 

