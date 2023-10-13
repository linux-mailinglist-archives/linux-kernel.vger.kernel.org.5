Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB737C8526
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjJML7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjJML7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:59:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BD1EA;
        Fri, 13 Oct 2023 04:59:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E070C433C7;
        Fri, 13 Oct 2023 11:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198365;
        bh=661eskRrrn3a2q2Gc7DQU5Vpxig1R977JLUBlgWFz9M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JzRgL/7G2NKdgepQIw580jwYQf78okNF3NQ7Yh6KggurGldEHEarYXCCKpmg9vE1U
         RebNIbFvV5eEneaH4YuaPWr6mA/zAAPf46Pro1qsP7gKq1tO+gKIGKsfpaKS94YZOr
         qFGwVaOEsFLLb8e7/WM3NDiX+XBFiPnqPCMgfcxgTinx1ySo9Ym4H4fJrxbFAFM+gl
         0JWMn/SZnUWxITKP5piPgSM+r65d42sskl7bZc+IrLRndHIDy6sPfGdpZ6i238Mauv
         m9OOsF+zoIztDofBjvspP8PJoav/zg4OpSSJZRSyLHvaJA5BgjKOYN/KEhCJ/ovgc/
         AOo//PccRp3CA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Uladzislau Rezki <urezki@gmail.com>, rcu <rcu@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH 06/18] mm: Remove kmem_valid_obj()
Date:   Fri, 13 Oct 2023 13:58:50 +0200
Message-Id: <20231013115902.1059735-7-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013115902.1059735-1-frederic@kernel.org>
References: <20231013115902.1059735-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Function kmem_dump_obj() will splat if passed a pointer to a non-slab
object. So nothing calls it directly, instead calling kmem_valid_obj()
first to determine whether the passed pointer to a valid slab object. This
means that merging kmem_valid_obj() into kmem_dump_obj() will make the
code more concise. Therefore, convert kmem_dump_obj() to work the same
way as vmalloc_dump_obj(), removing the need for the kmem_dump_obj()
caller to check kmem_valid_obj().  After this, there are no remaining
calls to kmem_valid_obj() anymore, and it can be safely removed.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/slab.h |  5 +++--
 mm/slab_common.c     | 41 +++++++++++------------------------------
 mm/util.c            |  4 +---
 3 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 8228d1276a2f..ff56ab804bf6 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -245,8 +245,9 @@ DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
 size_t ksize(const void *objp);
 
 #ifdef CONFIG_PRINTK
-bool kmem_valid_obj(void *object);
-void kmem_dump_obj(void *object);
+bool kmem_dump_obj(void *object);
+#else
+static inline bool kmem_dump_obj(void *object) { return false; }
 #endif
 
 /*
diff --git a/mm/slab_common.c b/mm/slab_common.c
index cd71f9581e67..a425bedf2103 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -528,26 +528,6 @@ bool slab_is_available(void)
 }
 
 #ifdef CONFIG_PRINTK
-/**
- * kmem_valid_obj - does the pointer reference a valid slab object?
- * @object: pointer to query.
- *
- * Return: %true if the pointer is to a not-yet-freed object from
- * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
- * is to an already-freed object, and %false otherwise.
- */
-bool kmem_valid_obj(void *object)
-{
-	struct folio *folio;
-
-	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
-	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
-		return false;
-	folio = virt_to_folio(object);
-	return folio_test_slab(folio);
-}
-EXPORT_SYMBOL_GPL(kmem_valid_obj);
-
 static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *slab)
 {
 	if (__kfence_obj_info(kpp, object, slab))
@@ -566,11 +546,11 @@ static void kmem_obj_info(struct kmem_obj_info *kpp, void *object, struct slab *
  * and, if available, the slab name, return address, and stack trace from
  * the allocation and last free path of that object.
  *
- * This function will splat if passed a pointer to a non-slab object.
- * If you are not sure what type of object you have, you should instead
- * use mem_dump_obj().
+ * Return: %true if the pointer is to a not-yet-freed object from
+ * kmalloc() or kmem_cache_alloc(), either %true or %false if the pointer
+ * is to an already-freed object, and %false otherwise.
  */
-void kmem_dump_obj(void *object)
+bool kmem_dump_obj(void *object)
 {
 	char *cp = IS_ENABLED(CONFIG_MMU) ? "" : "/vmalloc";
 	int i;
@@ -578,13 +558,13 @@ void kmem_dump_obj(void *object)
 	unsigned long ptroffset;
 	struct kmem_obj_info kp = { };
 
-	if (WARN_ON_ONCE(!virt_addr_valid(object)))
-		return;
+	/* Some arches consider ZERO_SIZE_PTR to be a valid address. */
+	if (object < (void *)PAGE_SIZE || !virt_addr_valid(object))
+		return false;
 	slab = virt_to_slab(object);
-	if (WARN_ON_ONCE(!slab)) {
-		pr_cont(" non-slab memory.\n");
-		return;
-	}
+	if (!slab)
+		return false;
+
 	kmem_obj_info(&kp, object, slab);
 	if (kp.kp_slab_cache)
 		pr_cont(" slab%s %s", cp, kp.kp_slab_cache->name);
@@ -621,6 +601,7 @@ void kmem_dump_obj(void *object)
 		pr_info("    %pS\n", kp.kp_free_stack[i]);
 	}
 
+	return true;
 }
 EXPORT_SYMBOL_GPL(kmem_dump_obj);
 #endif
diff --git a/mm/util.c b/mm/util.c
index 8cbbfd3a3d59..6eddd891198e 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1060,10 +1060,8 @@ void mem_dump_obj(void *object)
 {
 	const char *type;
 
-	if (kmem_valid_obj(object)) {
-		kmem_dump_obj(object);
+	if (kmem_dump_obj(object))
 		return;
-	}
 
 	if (vmalloc_dump_obj(object))
 		return;
-- 
2.34.1

