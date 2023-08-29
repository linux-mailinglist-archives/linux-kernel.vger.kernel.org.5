Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA3378C007
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbjH2IMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234044AbjH2ILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:11:53 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C59CE9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:51 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so62258411fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 01:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693296709; x=1693901509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9p+6vvdULZ9qjvQwfG8p+E9kLRCcHqiWfMDpSf+E74=;
        b=C+0ZPJKeh2AIn7VDgao2/FXWVrLlcnX1KA3YLoJi7cwPkwXL9e5UDGxjNsRNkYgr/B
         QjzB0HDDO9cPrCbMbmzlbj58HYnOEwytSJhrd1l0DnARX/+hknfvFf2YJASBluevQcEF
         +yzAAGe/wZSpO9edu3hwtl/H38HwNAdqnmh/yA0Zbszg1MKGDQ56gb0c2lfUNJkKdMlB
         OFqll7OSQXP932CL5iFUyLqfIJQIr8tPj0euSy+qV8bKyVZaU1zZjBccPJ/+qXwW5q4Z
         4WHcDl9RIYZZxsBZfJkiqYhk9NRoTEKZAywVQarXxpFzSE/gcYhUE4lKKGSIP24Hj6Xu
         8IGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693296709; x=1693901509;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9p+6vvdULZ9qjvQwfG8p+E9kLRCcHqiWfMDpSf+E74=;
        b=QCYlnXdu7tzxb0dYN3zqIKV1IIuMYPnZj88+xanIcLB2ihIDZMseX+NifIdHJfqE2H
         fbr6ejLsABhxr5Cz7OOxZVir9rZWf1ooX0WBUlgIQWrmixPWJjxI+aTzfAWhTOnG7n8T
         iOBdqCuxVpluskWl82fgAxGFA8rVwjUPQtDQtcDoO6X71F6vjXJk2LOVWSzVyeDtCpp3
         rZ4MObiOFPe1muJJAGmy+Aa/zrpuZSjnQlVjSTcMG95jwfB8fNOe53r8eGYimROKfzhc
         tv2im0D641rQTZl9NeKftQ11pCys7g+1Hcl0uT6hNjDUuo0jI1ZRKkyg77l6aZc4Pi0B
         zuPg==
X-Gm-Message-State: AOJu0YzHfh0aasQTAzQ7Mwg9amtMcDa9Ux780Dtyt1ZKRQTGh84aizu5
        Qojm0geEDizUrV7VJprjHfM=
X-Google-Smtp-Source: AGHT+IEC0NgW8tXM5qfPn6xExqsQCK2vQIifZS1j4TtRZBSspdGvCpkqpIJnDNq8vdHZtzaDCvPsdg==
X-Received: by 2002:a05:6512:3115:b0:500:79a6:38d4 with SMTP id n21-20020a056512311500b0050079a638d4mr16193053lfb.40.1693296709391;
        Tue, 29 Aug 2023 01:11:49 -0700 (PDT)
Received: from pc638.lan ([155.137.26.201])
        by smtp.gmail.com with ESMTPSA id f25-20020a19ae19000000b004fbad341442sm1868026lfc.97.2023.08.29.01.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 01:11:49 -0700 (PDT)
From:   "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Baoquan He <bhe@redhat.com>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>
Subject: [PATCH v2 7/9] mm: vmalloc: Support multiple nodes in vread_iter
Date:   Tue, 29 Aug 2023 10:11:40 +0200
Message-Id: <20230829081142.3619-8-urezki@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230829081142.3619-1-urezki@gmail.com>
References: <20230829081142.3619-1-urezki@gmail.com>
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

Extend the vread_iter() to be able to perform a sequential
reading of VAs which are spread among multiple nodes. So a
data read over the /dev/kmem correctly reflects a vmalloc
memory layout.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 mm/vmalloc.c | 67 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 53 insertions(+), 14 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 4fd4915c532d..968144c16237 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -870,7 +870,7 @@ unsigned long vmalloc_nr_pages(void)
 
 /* Look up the first VA which satisfies addr < va_end, NULL if none. */
 static struct vmap_area *
-find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
+__find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 {
 	struct vmap_area *va = NULL;
 	struct rb_node *n = root->rb_node;
@@ -894,6 +894,41 @@ find_vmap_area_exceed_addr(unsigned long addr, struct rb_root *root)
 	return va;
 }
 
+/*
+ * Returns a node where a first VA, that satisfies addr < va_end, resides.
+ * If success, a node is locked. A user is responsible to unlock it when a
+ * VA is no longer needed to be accessed.
+ *
+ * Returns NULL if nothing found.
+ */
+static struct vmap_node *
+find_vmap_area_exceed_addr_lock(unsigned long addr, struct vmap_area **va)
+{
+	struct vmap_node *vn, *va_node = NULL;
+	struct vmap_area *va_lowest;
+	int i;
+
+	for (i = 0; i < nr_nodes; i++) {
+		vn = &nodes[i];
+
+		spin_lock(&vn->busy.lock);
+		va_lowest = __find_vmap_area_exceed_addr(addr, &vn->busy.root);
+		if (va_lowest) {
+			if (!va_node || va_lowest->va_start < (*va)->va_start) {
+				if (va_node)
+					spin_unlock(&va_node->busy.lock);
+
+				*va = va_lowest;
+				va_node = vn;
+				continue;
+			}
+		}
+		spin_unlock(&vn->busy.lock);
+	}
+
+	return va_node;
+}
+
 static struct vmap_area *__find_vmap_area(unsigned long addr, struct rb_root *root)
 {
 	struct rb_node *n = root->rb_node;
@@ -4048,6 +4083,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 	struct vm_struct *vm;
 	char *vaddr;
 	size_t n, size, flags, remains;
+	unsigned long next;
 
 	addr = kasan_reset_tag(addr);
 
@@ -4057,19 +4093,15 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 	remains = count;
 
-	/* Hooked to node_0 so far. */
-	vn = addr_to_node(0);
-	spin_lock(&vn->busy.lock);
-
-	va = find_vmap_area_exceed_addr((unsigned long)addr, &vn->busy.root);
-	if (!va)
+	vn = find_vmap_area_exceed_addr_lock((unsigned long) addr, &va);
+	if (!vn)
 		goto finished_zero;
 
 	/* no intersects with alive vmap_area */
 	if ((unsigned long)addr + remains <= va->va_start)
 		goto finished_zero;
 
-	list_for_each_entry_from(va, &vn->busy.head, list) {
+	do {
 		size_t copied;
 
 		if (remains == 0)
@@ -4084,10 +4116,10 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 		WARN_ON(flags == VMAP_BLOCK);
 
 		if (!vm && !flags)
-			continue;
+			goto next_va;
 
 		if (vm && (vm->flags & VM_UNINITIALIZED))
-			continue;
+			goto next_va;
 
 		/* Pair with smp_wmb() in clear_vm_uninitialized_flag() */
 		smp_rmb();
@@ -4096,7 +4128,7 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 		size = vm ? get_vm_area_size(vm) : va_size(va);
 
 		if (addr >= vaddr + size)
-			continue;
+			goto next_va;
 
 		if (addr < vaddr) {
 			size_t to_zero = min_t(size_t, vaddr - addr, remains);
@@ -4125,15 +4157,22 @@ long vread_iter(struct iov_iter *iter, const char *addr, size_t count)
 
 		if (copied != n)
 			goto finished;
-	}
+
+	next_va:
+		next = va->va_end;
+		spin_unlock(&vn->busy.lock);
+	} while ((vn = find_vmap_area_exceed_addr_lock(next, &va)));
 
 finished_zero:
-	spin_unlock(&vn->busy.lock);
+	if (vn)
+		spin_unlock(&vn->busy.lock);
+
 	/* zero-fill memory holes */
 	return count - remains + zero_iter(iter, remains);
 finished:
 	/* Nothing remains, or We couldn't copy/zero everything. */
-	spin_unlock(&vn->busy.lock);
+	if (vn)
+		spin_unlock(&vn->busy.lock);
 
 	return count - remains;
 }
-- 
2.30.2

