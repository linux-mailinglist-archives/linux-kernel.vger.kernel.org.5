Return-Path: <linux-kernel+bounces-85581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655986B7F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 20:15:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A70B1C226E5
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B2C1332BC;
	Wed, 28 Feb 2024 19:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hyY2jmKB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4142240849
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709147713; cv=none; b=hB53CM/qap9k3TovHIuNznQwRi3h9wcGgDzuAsrHkr+P5a/vMI2jLGGTrcGJb+jnyXPYVrIPRgAorv0Oe5VBCpYfH1ljM2NkwVfcVGwSTQ+ZeDRWDEIO0nhYxgqcUFed01AomepJWBrukLR2zrMh9crhsVGz+42aHahpWZA/tJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709147713; c=relaxed/simple;
	bh=SowfoK/PmICKWh7EUg5Z1noipNIU58W8LZzQ1HeePlY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NFH1mXc6NFFUX2e1mIQ2tVQRReQODDo1nDNS6rTLptN6IU30O36Tg51nIFBPvDLbAquTwc+Ar0mYZBaBtXFWJsLUKEhP/+p7C5mCazV602I83+dfJ6UzhW8L7HmYQvrTq1QWE2eJ/7IPNeANH6jzs2hhIr2OTQ+0dfhQ+sVdpGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hyY2jmKB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709147709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=MljlOyunqu2jlYMmKl9aQOW/JRFU3MLIYOB1XnVuGaw=;
	b=hyY2jmKB4bDz3sHOPIAlGuGbmKiT9FyOd2qLO+C8AG9KPM2rlbktYhfd5a1jP7UCzNCGDY
	uIQjsFy/Q3ffXvSp8dgxh6pjyCJBD++5XjC/070ZXTI9b2hmQHv7tp1qH0JsF9CyemuLG0
	MNBsXw07tB93qcHTshEwEKrFiwhP4gQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-nZC1LXXDMsqMC0i9D60IlA-1; Wed,
 28 Feb 2024 14:15:06 -0500
X-MC-Unique: nZC1LXXDMsqMC0i9D60IlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 91FC71C592A2;
	Wed, 28 Feb 2024 19:15:04 +0000 (UTC)
Received: from llong.com (unknown [10.22.9.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6548A40C94AB;
	Wed, 28 Feb 2024 19:15:03 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Audra Mitchell <aubaker@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: [PATCH] mm/kmemleak: Don't hold kmemleak_lock when calling printk()
Date: Wed, 28 Feb 2024 14:14:44 -0500
Message-Id: <20240228191444.481048-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

When some error conditions happen (like OOM), some kmemleak functions
call printk() to dump out some useful debugging information while holding
the kmemleak_lock. This may cause deadlock as the printk() function
may need to allocate additional memory leading to a create_object()
call acquiring kmemleak_lock again.

Fix this deadlock issue by making sure that printk() is only called
after releasing the kmemleak_lock.

Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/kmemleak.c | 64 ++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 46 insertions(+), 18 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 6a540c2b27c5..acd8742c80b5 100644
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
@@ -427,9 +442,20 @@ static struct kmemleak_object *__lookup_object(unsigned long ptr, int alias,
 		else if (untagged_objp == untagged_ptr || alias)
 			return object;
 		else {
+			if (!get_object(object))
+				break;
+			/*
+			 * Release kmemleak_lock and acquire object->lock
+			 * temporarily to avoid deadlock in printk().
+			 */
+			raw_spin_unlock(&kmemleak_lock);
 			kmemleak_warn("Found object by alias at 0x%08lx\n",
 				      ptr);
+			raw_spin_lock(&object->lock);
 			dump_object_info(object);
+			raw_spin_unlock(&object->lock);
+			put_object(object);
+			raw_spin_lock(&kmemleak_lock);
 			break;
 		}
 	}
@@ -442,22 +468,12 @@ static struct kmemleak_object *lookup_object(unsigned long ptr, int alias)
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
 
@@ -477,9 +493,11 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
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
 
@@ -692,6 +710,8 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
 	unsigned long untagged_ptr;
 	unsigned long untagged_objp;
 
+	lockdep_assert_held(&kmemleak_lock);
+
 	object->flags = OBJECT_ALLOCATED | objflags;
 	object->pointer = ptr;
 	object->size = kfence_ksize((void *)ptr) ?: size;
@@ -718,13 +738,21 @@ static int __link_object(struct kmemleak_object *object, unsigned long ptr,
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
+			 * Release kmemleak_lock & acquire parent->lock
+			 * temporarily to avoid deadlock in printk().
 			 */
+			raw_spin_unlock(&kmemleak_lock);
+
+			kmemleak_stop("Cannot insert 0x%lx into the object search tree (overlaps existing)\n",
+				      ptr);
+			raw_spin_lock(&parent->lock);
 			dump_object_info(parent);
+			raw_spin_unlock(&parent->lock);
+			put_object(parent);
+			raw_spin_lock(&kmemleak_lock);
 			return -EEXIST;
 		}
 	}
@@ -839,11 +867,12 @@ static void delete_object_part(unsigned long ptr, size_t size,
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
@@ -862,7 +891,6 @@ static void delete_object_part(unsigned long ptr, size_t size,
 			   object->min_count, objflags))
 		object_r = NULL;
 
-unlock:
 	raw_spin_unlock_irqrestore(&kmemleak_lock, flags);
 	if (object)
 		__delete_object(object);
-- 
2.39.3


