Return-Path: <linux-kernel+bounces-96029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25242875648
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 19:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAA6DB22712
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:47:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EA5134CD4;
	Thu,  7 Mar 2024 18:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S1PlKLmg"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4EA11332AA
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 18:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709837241; cv=none; b=NU2fy1p9NTrbWoT7aOFG/2+W9ybCwEwrYU0O6pxSf4v3AK8azIAfSy33LkrZCdK+O7lGfWRaUADJwlVQoiGPTcoVhtWh/MWfCqveAXFKqjDG+3W2OzCWkQjCAek2mU5ZzHbRtblpvONuwM7eiVpxTDv3xG5W0LZAzXflM4BPJ1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709837241; c=relaxed/simple;
	bh=YBA+JzhY+WWVxp2xOJqOcfQlzI++o56huXdoHOMGLU4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=brNM8MiLyDOw+OtISpTCgF4IoIaJddkhMxKu5KHXMrSmLquF68G21a/iDOb7M6xsT/hOkMuYXmCThm0f1At8RvAKRiv81GgB1dkbNIgVxAQqCSOlYVeL+9vkY9cs1U1Lpyhtn0X+T/KrTZ/hNnWZB4/sYT+0OSnlJkEKg0VY9Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S1PlKLmg; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709837238;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=E3Wt+xQ7ZJjAEKeswQIK11lh68qsEXxaORrhK6d9Ec8=;
	b=S1PlKLmgbFyYG6on05qK9CJQXcW3LnEl24IstrrFNzhffpsDljIHfvTxXle/QerGfAlHD0
	fFo2+TNnClaZT1fDoXB/qfgVTbL/auEeohANMvTzLULzkeEfITZMHAXQ4PqdVrUeLQ603N
	6pZEMWtOLsIkHnkIZXoyeLd15mDKQQI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-vZHoSYt2PqWhBdleFVRGrQ-1; Thu,
 07 Mar 2024 13:47:14 -0500
X-MC-Unique: vZHoSYt2PqWhBdleFVRGrQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E80D61C05AF8;
	Thu,  7 Mar 2024 18:47:13 +0000 (UTC)
Received: from llong.com (unknown [10.22.17.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C119C1121306;
	Thu,  7 Mar 2024 18:47:12 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Audra Mitchell <aubaker@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] mm/kmemleak: Don't hold kmemleak_lock when calling printk()
Date: Thu,  7 Mar 2024 13:47:07 -0500
Message-Id: <20240307184707.961255-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

When some error conditions happen (like OOM), some kmemleak functions
call printk() to dump out some useful debugging information while holding
the kmemleak_lock. This may cause deadlock as the printk() function
may need to allocate additional memory leading to a create_object()
call acquiring kmemleak_lock again.

An abbreviated lockdep splat is as follows:

[ 3991.452440] ======================================================
[ 3991.452441] WARNING: possible circular locking dependency detected
[ 3991.452442] 4.18.0-513.el8.x86_64+debug #1 Not tainted
[ 3991.452444] ------------------------------------------------------
[ 3991.452445] kworker/21:1H/436 is trying to acquire lock:
[ 3991.452446] ffffffff8b64c460 (console_owner) {....}-{0:0}, at: console_unlock+0x3dc/0xaa0
[ 3991.452452]
[ 3991.452453] but task is already holding lock:
[ 3991.452454] ffffffff8bd2b138 (kmemleak_lock){..}-{2:2}, at: create_object+0x4ba/0xac0
[ 3991.452459]
[ 3991.452460] which lock already depends on the new lock.
  :
[ 3991.452556] other info that might help us debug this:
[ 3991.452557]
[ 3991.452558] Chain exists of:
[ 3991.452559] console_owner -> &port>lock --> kmemleak_lock
[ 3991.452565]
[ 3991.452566] Possible unsafe locking scenario:
[ 3991.452566]
[ 3991.452567] CPU0 CPU1
[ 3991.452568] ---- ----
[ 3991.452569] lock(kmemleak_lock);
[ 3991.452572] lock(&port->lock);
[ 3991.452574] lock(kmemleak_lock);
[ 3991.452577] lock(console_owner);
[ 3991.452579]
[ 3991.452580] *** DEADLOCK ***
[ 3991.452582] 7 locks held by kworker/21:1H/436:
[ 3991.452582] #0: ff110003ec46b548 ((wq_completion)kblockd){..}-{0:0}, at: process_one_work+0x816/0x17e0
[ 3991.452588] #1: ffa0000004617e00 ((work_completion)(&(&hctx->run_work)>work)){..} {0:0}, at: process_one_work+0x84a/0x17e0
[ 3991.452594] #2: ffffffff8ba0b440 (rcu_read_lock) {....}-{1:2}, at: hctx_lock+0x6d/0x190
[ 3991.452599] #3: ff110001906ad818 (&host->lock){..}-{2:2}, at: ata_scsi_queuecmd+0x87/0x180 [libata]
[ 3991.452604] #4: ffffffff8bad8118 (radix_lock){..}-{2:2}, at: add_dma_entry+0x20f/0x4e0
[ 3991.452609] #5: ffffffff8bd2b138 (kmemleak_lock){..}-{2:2}, at: create_object+0x4ba/0xac0
[ 3991.452614] #6: ffffffff8b9ccae0 (console_lock){..}-{0:0}, at: vprintk_emit+0x1f5/0x420
[ 3991.452619]
[ 3991.452620] stack backtrace:
[ 3991.452621] CPU: 21 PID: 436 Comm: kworker/21:1H Kdump: loaded Not tainted 4.18.0-513.el8.x86_64+debug #1
[ 3991.452622] Hardware name: Lenovo ThinkSystem SR650 V2/7Z73CTO1WW, BIOS AFE118M-1.32 06/29/2022
[ 3991.452623] Workqueue: kblockd blk_mq_run_work_fn
[ 3991.452625] Call Trace:
[ 3991.452626] dump_stack+0x5c/0x80
[ 3991.452627] check_noncircular+0x283/0x320
[ 3991.452631] check_prevs_add+0x3fa/0x18b0
[ 3991.452635] __lock_acquire+0x21b6/0x2b70
[ 3991.452637] lock_acquire+0x1db/0x620
[ 3991.452640] console_unlock+0x44b/0xaa0
[ 3991.452644] vprintk_emit+0x1fe/0x420
[ 3991.452645] printk+0x9f/0xc9
[ 3991.452648] create_object.cold.19+0x13/0x86
[ 3991.452650] slab_post_alloc_hook+0x66/0x3b0
[ 3991.452652] kmem_cache_alloc+0x155/0x360
[ 3991.452653] radix_tree_node_alloc.constprop.7+0x172/0x2f0
[ 3991.452654] radix_tree_insert+0x197/0x580
[ 3991.452657] add_dma_entry+0x224/0x4e0
[ 3991.452659] debug_dma_map_sg+0x5d7/0xc10
[ 3991.452661] dma_map_sg_attrs+0xc7/0x190
[ 3991.452662] ata_qc_issue+0x65c/0xd60 [libata]
[ 3991.452665] __ata_scsi_queuecmd+0x45f/0xc40 [libata]
[ 3991.452666] ata_scsi_queuecmd+0xa5/0x180 [libata]
[ 3991.452667] scsi_queue_rq+0x16bc/0x3200
[ 3991.452668] blk_mq_dispatch_rq_list+0x3a3/0x2100
[ 3991.452675] blk_mq_do_dispatch_sched+0x72c/0xac0
[ 3991.452679] __blk_mq_sched_dispatch_requests+0x293/0x3f0
[ 3991.452682] blk_mq_sched_dispatch_requests+0xd0/0x130
[ 3991.452683] __blk_mq_run_hw_queue+0xa7/0x110
[ 3991.452686] process_one_work+0x93d/0x17e0
[ 3991.452688] worker_thread+0x87/0xb50
[ 3991.452691] kthread+0x334/0x3f0
[ 3991.452693] ret_from_fork+0x24/0x50
[ 3991.865403] kmemleak: Automatic memory scanning thread ended

Fix this deadlock issue by making sure that printk() is only called
after releasing the kmemleak_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 62 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 44 insertions(+), 18 deletions(-)

 [v2] Add lockdep splat & don't hold object->lock when calling
      dump_object_info()

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6a540c2b27c5..4f58f6170cdf 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -401,6 +401,19 @@ static struct rb_root *object_tree(unsigned long objflags)
 	return &object_tree_root;
 }
 
+/*
+ * Increment the object use_count. Return 1 if successful or 0 otherwise. Note
+ * that once an object's use_count reached 0, the RCU freeing was already
+ * registered and the object should no longer be used. This function must be
+ * called under the protection of rcu_read_lock().
+ */
+static int get_object(struct kmemleak_object *object)
+{
+	return atomic_inc_not_zero(&object->use_count);
+}
+
+static void put_object(struct kmemleak_object *object);
+
 /*
  * Look-up a memory block metadata (kmemleak_object) in the object search
  * tree based on a pointer value. If alias is 0, only values pointing to the
@@ -413,6 +426,8 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 	struct rb_node *rb = object_tree(objflags)->rb_node;
 	unsigned long untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
 
+	lockdep_assert_held(&kmemleak_lock);
+
 	while (rb) {
 		struct kmemleak_object *object;
 		unsigned long untagged_objp;
@@ -427,9 +442,19 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 		else if (untagged_objp == untagged_ptr || alias)
 			return object;
 		else {
+			if (!get_object(object))
+				break;
+			/*
+			 * Release kmemleak_lock temporarily to avoid deadlock
+			 * in printk(). dump_object_info() is called without
+			 * holding object->lock (race unlikely).
+			 */
+			raw_spin_unlock(&kmemleak_lock);
 			kmemleak_warn("Found object by alias at 0x%08lx\n",
 				      ptr);
 			dump_object_info(object);
+			put_object(object);
+			raw_spin_lock(&kmemleak_lock);
 			break;
 		}
 	}
@@ -442,22 +467,12 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
 	return __lookup_object(ptr, alias, 0);
 }
 
-/*
- * Increment the object use_count. Return 1 if successful or 0 otherwise. Note
- * that once an object's use_count reached 0, the RCU freeing was already
- * registered and the object should no longer be used. This function must be
- * called under the protection of rcu_read_lock().
- */
-static int get_object(struct kmemleak_object *object)
-{
-	return atomic_inc_not_zero(&object->use_count);
-}
-
 /*
  * Memory pool allocation and freeing. kmemleak_lock must not be held.
  */
 static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 {
+	bool warn = false;
 	unsigned long flags;
 	struct kmemleak_object *object;
 
@@ -477,9 +492,11 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 	else if (mem_pool_free_count)
 		object = &mem_pool[--mem_pool_free_count];
 	else
-		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
+		warn = true;
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 
+	if (unlikely(warn))
+		pr_warn_once("Memory pool empty, consider increasing CONFIG_DEBUG_KMEMLEAK_MEM_POOL_SIZE\n");
 	return object;
 }
 
@@ -692,6 +709,8 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	unsigned long untagged_ptr;
 	unsigned long untagged_objp;
 
+	lockdep_assert_held(&kmemleak_lock);
+
 	object->flags = OBJECT_ALLOCATED | objflags;
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
@@ -718,13 +737,20 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 		else if (untagged_objp + parent->size <= untagged_ptr)
 			link = &parent->rb_node.rb_right;
 		else {
-			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
-				      ptr);
+			if (!get_object(parent))
+				return -EEXIST;
 			/*
-			 * No need for parent->lock here since "parent" cannot
-			 * be freed while the kmemleak_lock is held.
+			 * Release kmemleak_lock temporarily to avoid deadlock
+			 * in printk(). dump_object_info() is called without
+			 * holding parent->lock (race unlikely).
 			 */
+			raw_spin_unlock(&kmemleak_lock);
+
+			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
+				      ptr);
 			dump_object_info(parent);
+			put_object(parent);
+			raw_spin_lock(&kmemleak_lock);
 			return -EEXIST;
 		}
 	}
@@ -839,11 +865,12 @@ static void delete_object_part(unsigned long ptr, size_t size,
 	raw_spin_lock_irqsave(&kmemleak_lock, flags);
 	object = __find_and_remove_object(ptr, 1, objflags);
 	if (!object) {
+		raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 #ifdef DEBUG
 		kmemleak_warn("Partially freeing unknown object at 0x%08lx (size %zu)\n",
 			      ptr, size);
 #endif
-		goto unlock;
+		goto out;
 	}
 
 	/*
@@ -862,7 +889,6 @@ static void delete_object_part(unsigned long ptr, size_t size,
 			   object->min_count, objflags))
 		object_r = NULL;
 
-unlock:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	if (object)
 		__delete_object(object);
-- 
2.39.3


