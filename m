Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE0B7FAA85
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 20:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjK0TmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 14:42:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0TmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 14:42:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B620BAA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 11:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701114128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MFZzVrvyAJtc2SlqHRdiv4fw2bU3px82Ljm8ZqJTVGo=;
        b=TJcXvEWgPQcCIfu4+ALXQxIE+jmBIFXgRMLao9c768sMDCcWh2ZSposCgzFDIqP4HYsF5O
        s/0ydMH3chEAH6uqiKHr4JvfyYmPQdW8A8sjfFFjdZg+7u3AjdlPRaPKQ0D4P1XoJT17a+
        zrkv9AKewJAGHjvDfQIH6fDng5znKuE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-ja_pP7llNLy2rv8ntPW8Bg-1; Mon,
 27 Nov 2023 14:42:05 -0500
X-MC-Unique: ja_pP7llNLy2rv8ntPW8Bg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 26B0A28040B7;
        Mon, 27 Nov 2023 19:42:05 +0000 (UTC)
Received: from llong.com (unknown [10.22.8.93])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C2A3DC15881;
        Mon, 27 Nov 2023 19:42:04 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/kmemleak: Add cond_resched() to kmemleak_free_percpu()
Date:   Mon, 27 Nov 2023 14:41:53 -0500
Message-Id: <20231127194153.289626-1-longman@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was found that on systems with large number of CPUs, the following soft
lockup splat might sometimes happen:

[ 2656.001617] watchdog: BUG: soft lockup - CPU#364 stuck for 21s! [ksoftirqd/364:2206]
  :
[ 2656.141194] RIP: 0010:_raw_spin_unlock_irqrestore+0x3d/0x70
  :
 2656.241214] Call Trace:
[ 2656.243971]  <IRQ>
[ 2656.246237]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.251152]  ? show_trace_log_lvl+0x1c4/0x2df
[ 2656.256066]  ? kmemleak_free_percpu+0x11f/0x1f0
[ 2656.261173]  ? watchdog_timer_fn+0x379/0x470
[ 2656.265984]  ? __pfx_watchdog_timer_fn+0x10/0x10
[ 2656.271179]  ? __hrtimer_run_queues+0x5f3/0xd00
[ 2656.276283]  ? __pfx___hrtimer_run_queues+0x10/0x10
[ 2656.281783]  ? ktime_get_update_offsets_now+0x95/0x2c0
[ 2656.287573]  ? ktime_get_update_offsets_now+0xdd/0x2c0
[ 2656.293380]  ? hrtimer_interrupt+0x2e9/0x780
[ 2656.298221]  ? __sysvec_apic_timer_interrupt+0x184/0x640
[ 2656.304211]  ? sysvec_apic_timer_interrupt+0x8e/0xc0
[ 2656.309807]  </IRQ>
[ 2656.312169]  <TASK>
[ 2656.326110]  kmemleak_free_percpu+0x11f/0x1f0
[ 2656.331015]  free_percpu.part.0+0x1b/0xe70
[ 2656.335635]  free_vfsmnt+0xb9/0x100
[ 2656.339567]  rcu_do_batch+0x3c8/0xe30
[ 2656.363693]  rcu_core+0x3de/0x5a0
[ 2656.367433]  __do_softirq+0x2d0/0x9a8
[ 2656.381119]  run_ksoftirqd+0x36/0x60
[ 2656.385145]  smpboot_thread_fn+0x556/0x910
[ 2656.394971]  kthread+0x2a4/0x350
[ 2656.402826]  ret_from_fork+0x29/0x50
[ 2656.406861]  </TASK>

Fix this by adding a cond_resched() call in the percpu freeing loop
and defer the freeing of percpu kmemleak objects to a workqueue if it
is being called from a non-task context.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 59 +++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 1eacca03bedd..03385f4a8008 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -168,6 +168,14 @@ struct kmemleak_object {
 	char comm[TASK_COMM_LEN];	/* executable name */
 };
 
+/*
+ * A percpu address to be submitted to a workqueue for being freed.
+ */
+struct kmemleak_percpu_addr {
+	struct work_struct work;
+	const void __percpu *ptr;
+};
+
 /* flag representing the memory block allocation status */
 #define OBJECT_ALLOCATED	(1 << 0)
 /* flag set after the first reporting of an unreference object */
@@ -1120,23 +1128,60 @@ void __ref kmemleak_free_part(const void *ptr, size_t size)
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_part);
 
+static void __kmemleak_free_percpu(const void __percpu *ptr)
+{
+	unsigned int cpu;
+
+	for_each_possible_cpu(cpu) {
+		delete_object_full((unsigned long)per_cpu_ptr(ptr, cpu));
+		if (in_task())
+			cond_resched();
+	}
+}
+
+/*
+ * Work function for deferred freeing of kmemleak objects associated with
+ * a freed percpu memory block.
+ */
+static void kmemleak_free_percpu_workfn(struct work_struct *work)
+{
+	struct kmemleak_percpu_addr *addr;
+
+	addr = container_of(work, struct kmemleak_percpu_addr, work);
+	__kmemleak_free_percpu(addr->ptr);
+	kfree(addr);
+}
+
 /**
  * kmemleak_free_percpu - unregister a previously registered __percpu object
  * @ptr:	__percpu pointer to beginning of the object
  *
  * This function is called from the kernel percpu allocator when an object
- * (memory block) is freed (free_percpu).
+ * (memory block) is freed (free_percpu). Since this function is inherently
+ * slow especially on systems with a large number of CPUs, defer the actual
+ * removal of kmemleak objects associated with the percpu pointer to a
+ * workqueue if it is not in a task context.
  */
 void __ref kmemleak_free_percpu(const void __percpu *ptr)
 {
-	unsigned int cpu;
-
 	pr_debug("%s(0x%px)\n", __func__, ptr);
 
-	if (kmemleak_free_enabled && ptr && !IS_ERR(ptr))
-		for_each_possible_cpu(cpu)
-			delete_object_full((unsigned long)per_cpu_ptr(ptr,
-								      cpu));
+	if (!kmemleak_free_enabled || !ptr || IS_ERR(ptr))
+		return;
+
+	if (!in_task()) {
+		struct kmemleak_percpu_addr *addr;
+
+		addr = kzalloc(sizeof(*addr), GFP_ATOMIC);
+		if (addr) {
+			INIT_WORK(&addr->work, kmemleak_free_percpu_workfn);
+			addr->ptr = ptr;
+			queue_work(system_long_wq, &addr->work);
+			return;
+		}
+		/* Fallback to do direct deletion */
+	}
+	__kmemleak_free_percpu(ptr);
 }
 EXPORT_SYMBOL_GPL(kmemleak_free_percpu);
 
-- 
2.39.3

