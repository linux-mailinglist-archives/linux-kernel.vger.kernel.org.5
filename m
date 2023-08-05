Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFCBC770D81
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 05:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjHEDVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 23:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjHEDU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 23:20:59 -0400
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2F84ED7;
        Fri,  4 Aug 2023 20:20:57 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4RHnsb5wm9z4f3lXL;
        Sat,  5 Aug 2023 11:20:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.174.178.55])
        by APP4 (Coremail) with SMTP id gCh0CgAHoZQRwM1kZdNePg--.61999S5;
        Sat, 05 Aug 2023 11:20:54 +0800 (CST)
From:   thunder.leizhen@huaweicloud.com
To:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-mm@kvack.org,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Zqiang <qiang.zhang1211@gmail.com>, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v7 1/2] mm: Remove kmem_valid_obj()
Date:   Sat,  5 Aug 2023 11:17:25 +0800
Message-Id: <20230805031726.1230-2-thunder.leizhen@huaweicloud.com>
X-Mailer: git-send-email 2.37.3.windows.1
In-Reply-To: <20230805031726.1230-1-thunder.leizhen@huaweicloud.com>
References: <20230805031726.1230-1-thunder.leizhen@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAHoZQRwM1kZdNePg--.61999S5
X-Coremail-Antispam: 1UD129KBjvJXoWxZr1ftry5Jr4fXr1fKF1rZwb_yoWrCrWkpw
        nxGr9xJFW8Jr1xGrsrJF1kurW5Zr4kuF17Ca9aqw18Ar1UXrs7ur1kG3s2qF98GFW8XF10
        ya1vkF43uryUArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4
        xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
        Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x
        0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIx
        AIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1D73DUUUUU=
        =
X-CM-SenderInfo: hwkx0vthuozvpl2kv046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhen Lei <thunder.leizhen@huawei.com>

Function kmem_dump_obj() will splat if passed a pointer to a non-slab
object. So no one will call it directly. It is always necessary to call
kmem_valid_obj() first to determine whether the passed pointer to a
valid slab object. Then merging kmem_valid_obj() into kmem_dump_obj()
will make the code more concise. So convert kmem_dump_obj() to work the
same way as vmalloc_dump_obj(). After this, no one calls kmem_valid_obj()
anymore, and it can be safely removed.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/slab.h |  5 +++--
 mm/slab_common.c     | 41 +++++++++++------------------------------
 mm/util.c            |  4 +---
 3 files changed, 15 insertions(+), 35 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 848c7c82ad5ad0b..d8ed2e810ec4448 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -244,8 +244,9 @@ DEFINE_FREE(kfree, void *, if (_T) kfree(_T))
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
index d1555ea2981ac51..ee6ed6dd7ba9fa5 100644
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
index dd12b9531ac4cad..ddfbb22dc1876d3 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -1063,10 +1063,8 @@ void mem_dump_obj(void *object)
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

