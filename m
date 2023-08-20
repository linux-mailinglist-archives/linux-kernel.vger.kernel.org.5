Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE1F781F9C
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 21:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjHTTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 15:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjHTTn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 15:43:29 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885CF49EC;
        Sun, 20 Aug 2023 12:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=yffIQNHXKypeq1zIbfQo6NWIljVNd0Nx7ZtnKKW0FkU=; b=I0Bjq8yycB77341iiR/zTAxcIT
        vO+8N98DOUbc+RGu/Hqc9NyFi8XxjM7Ml3FihLSP6eYTbFqteKBbanuDDIeqYHLBc1UqJv/PPnI/b
        EuMHcb5LEPsYDFkawKb47igSVrxW9de7/ZdedEsqOok3aN7UsiBVnaR9C6QO9fXOIIhAt3Osayuh/
        o4dREqomZL9IE0AcG5x1+9nEr82plu1WwZzXQEkskM+PkoJguDPKst2yPvfzrGq8yQACK1k2b+xl8
        otLkyw28y1S9EpqrT4tB88+5sMSLxVjr0fA/n5TzLXr4irModmrbclMIhIhdgi1b4elpL7nlF9Mn0
        IDgQeMbw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qXoHq-005r8H-Gc; Sun, 20 Aug 2023 19:40:34 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Add vmalloc_user_node()
Date:   Sun, 20 Aug 2023 20:40:31 +0100
Message-Id: <20230820194031.1395870-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow memory to be allocated on a specified node.  Use it in the
perf ring-buffer code.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
I was looking at the perf ringbuffer code for other reasons, and I noticed
that everything else gets allocated on the specified node ... except
there's no way to do this for vmalloc.  I assume it'd be helpful here too.

 include/linux/vmalloc.h     | 17 ++++++++++++++++-
 kernel/events/ring_buffer.c |  2 +-
 mm/vmalloc.c                |  9 +++++----
 3 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..030bfe1a60ab 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -6,6 +6,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/llist.h>
+#include <linux/numa.h>
 #include <asm/page.h>		/* pgprot_t */
 #include <linux/rbtree.h>
 #include <linux/overflow.h>
@@ -139,7 +140,7 @@ static inline unsigned long vmalloc_nr_pages(void) { return 0; }
 
 extern void *vmalloc(unsigned long size) __alloc_size(1);
 extern void *vzalloc(unsigned long size) __alloc_size(1);
-extern void *vmalloc_user(unsigned long size) __alloc_size(1);
+extern void *vmalloc_user_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vzalloc_node(unsigned long size, int node) __alloc_size(1);
 extern void *vmalloc_32(unsigned long size) __alloc_size(1);
@@ -158,6 +159,20 @@ extern void *vmalloc_array(size_t n, size_t size) __alloc_size(1, 2);
 extern void *__vcalloc(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
 extern void *vcalloc(size_t n, size_t size) __alloc_size(1, 2);
 
+/**
+ * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
+ * @size: allocation size
+ *
+ * The resulting memory area is zeroed so it can be mapped to userspace
+ * without leaking data.
+ *
+ * Return: pointer to the allocated memory or %NULL on error
+ */
+static inline void *vmalloc_user(size_t size)
+{
+	return vmalloc_user_node(size, NUMA_NO_NODE);
+}
+
 extern void vfree(const void *addr);
 extern void vfree_atomic(const void *addr);
 
diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index cc90d5299005..c73add132618 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -918,7 +918,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 
 	INIT_WORK(&rb->work, rb_free_work);
 
-	all_buf = vmalloc_user((nr_pages + 1) * PAGE_SIZE);
+	all_buf = vmalloc_user_node((nr_pages + 1) * PAGE_SIZE, node);
 	if (!all_buf)
 		goto fail_all_buf;
 
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 228a4a5312f2..3616bfe4348f 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3461,22 +3461,23 @@ void *vzalloc(unsigned long size)
 EXPORT_SYMBOL(vzalloc);
 
 /**
- * vmalloc_user - allocate zeroed virtually contiguous memory for userspace
+ * vmalloc_user_node - allocate zeroed virtually contiguous memory for userspace
  * @size: allocation size
+ * @node: NUMA node
  *
  * The resulting memory area is zeroed so it can be mapped to userspace
  * without leaking data.
  *
  * Return: pointer to the allocated memory or %NULL on error
  */
-void *vmalloc_user(unsigned long size)
+void *vmalloc_user_node(unsigned long size, int node)
 {
 	return __vmalloc_node_range(size, SHMLBA,  VMALLOC_START, VMALLOC_END,
 				    GFP_KERNEL | __GFP_ZERO, PAGE_KERNEL,
-				    VM_USERMAP, NUMA_NO_NODE,
+				    VM_USERMAP, node,
 				    __builtin_return_address(0));
 }
-EXPORT_SYMBOL(vmalloc_user);
+EXPORT_SYMBOL(vmalloc_user_node);
 
 /**
  * vmalloc_node - allocate memory on a specific node
-- 
2.40.1

