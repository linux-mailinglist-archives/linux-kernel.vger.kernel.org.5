Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A1E7F9C08
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbjK0IrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232433AbjK0IrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:47:21 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBBC10A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:26 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6cb66fbc63dso2699932b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701074846; x=1701679646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6GtJdFrAMiD9TMiTJ2tpU0p4EP2T7FpthDyFgbUgV8=;
        b=JK2rLiLk5C6NgABJegVYOvqttLOTHHaXyatuv08w8tdfYGXzbNJrfbPRywfUU/+WD4
         +RRgVQGDzpe8q6B1xNYcIHxG9lUUBJPiG4fQLb9scAvd0m8bH0QnbcOx8BQrNB2GMpDB
         pwO4YEcAinaT27aK6rdMF7PzAfdEVZqr6bt2uSNyCWTU2lFMboi9wAVseRSVhSJ6SgZh
         yOFPguqRUM5cuQZzN3jQjHdU38EayC8Hfvo1MZ5hlTtTHdnZXDE3tbGp2upioQgWo9YY
         naVg1YigsV2W/5eiZI0CqF/eGlxS4XW2VWYsvcAmM3kKz3KLuOk80eFH2kep3I9DA3Q4
         30Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074846; x=1701679646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6GtJdFrAMiD9TMiTJ2tpU0p4EP2T7FpthDyFgbUgV8=;
        b=sMt43rWJVVDbqyg2N7GXa7mH2xj14C1/Eyz13Yw/rsnF/iTVl64S3VPiMaPSloII63
         gHbWdvmyzYvrkZtZgWo0csSd3s90Td/U3BMUHpUlUmrPmANIzMFnfxPv2CKEqDqW2ozz
         3s3O7YYCfvx81jPKkwLDy6Ng1kBZ67bGJfdwkwOxTZMJhzEhiWRIH/avLE7izUikOgho
         RIKkNrTd5HNl7ygtY+kJSrB8egdUC6neCsOC4oCoC1xXuMuDwACUPaF04c77Puw9JbSp
         vahJ+J+foiDNmElBLOgk5TGU8jCmkLLdHZXDuACGMBYRqE+E/4sv8c07P8QTPpLnJkky
         zuHg==
X-Gm-Message-State: AOJu0YwmKZcBRDiDeBkoWbCyN8iyZaJQVhq+T0kSMWCboXgmyzxAbmE/
        ZLO5MFZWAWvwt7qtURrAAmnu3A==
X-Google-Smtp-Source: AGHT+IH8dlIQBo06oYLZpoUw9SLI1+YxmO7I/y/nkByjLUJqY3NGvBpQZM1zhaq6gplUxS6RY2JFSg==
X-Received: by 2002:a05:6a20:9390:b0:18c:5178:9649 with SMTP id x16-20020a056a20939000b0018c51789649mr7667438pzh.14.1701074846205;
        Mon, 27 Nov 2023 00:47:26 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm6686932pfd.121.2023.11.27.00.47.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Nov 2023 00:47:25 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 2/4] mm: hugetlb_vmemmap: use walk_page_range_novma() to simplify the code
Date:   Mon, 27 Nov 2023 16:46:43 +0800
Message-Id: <20231127084645.27017-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231127084645.27017-1-songmuchun@bytedance.com>
References: <20231127084645.27017-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is unnecessary to implement a series of dedicated page table walking
helpers since there is already a general one walk_page_range_novma().
So use it to simplify the code.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 148 ++++++++++++-------------------------------
 1 file changed, 39 insertions(+), 109 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index 87818ee7f01d7..ef14356855d13 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -14,6 +14,7 @@
 #include <linux/moduleparam.h>
 #include <linux/bootmem_info.h>
 #include <linux/mmdebug.h>
+#include <linux/pagewalk.h>
 #include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 #include "hugetlb_vmemmap.h"
@@ -45,21 +46,14 @@ struct vmemmap_remap_walk {
 	unsigned long		flags;
 };
 
-static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
+static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
+			     struct vmemmap_remap_walk *walk)
 {
 	pmd_t __pmd;
 	int i;
 	unsigned long addr = start;
-	struct page *head;
 	pte_t *pgtable;
 
-	spin_lock(&init_mm.page_table_lock);
-	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
-	spin_unlock(&init_mm.page_table_lock);
-
-	if (!head)
-		return 0;
-
 	pgtable = pte_alloc_one_kernel(&init_mm);
 	if (!pgtable)
 		return -ENOMEM;
@@ -88,7 +82,7 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 		/* Make pte visible before pmd. See comment in pmd_install(). */
 		smp_wmb();
 		pmd_populate_kernel(&init_mm, pmd, pgtable);
-		if (flush)
+		if (!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH))
 			flush_tlb_kernel_range(start, start + PMD_SIZE);
 	} else {
 		pte_free_kernel(&init_mm, pgtable);
@@ -98,123 +92,59 @@ static int split_vmemmap_huge_pmd(pmd_t *pmd, unsigned long start, bool flush)
 	return 0;
 }
 
-static void vmemmap_pte_range(pmd_t *pmd, unsigned long addr,
-			      unsigned long end,
-			      struct vmemmap_remap_walk *walk)
-{
-	pte_t *pte = pte_offset_kernel(pmd, addr);
-
-	/*
-	 * The reuse_page is found 'first' in table walk before we start
-	 * remapping (which is calling @walk->remap_pte).
-	 */
-	if (!walk->reuse_page) {
-		walk->reuse_page = pte_page(ptep_get(pte));
-		/*
-		 * Because the reuse address is part of the range that we are
-		 * walking, skip the reuse address range.
-		 */
-		addr += PAGE_SIZE;
-		pte++;
-		walk->nr_walked++;
-	}
-
-	for (; addr != end; addr += PAGE_SIZE, pte++) {
-		walk->remap_pte(pte, addr, walk);
-		walk->nr_walked++;
-	}
-}
-
-static int vmemmap_pmd_range(pud_t *pud, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
+static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
+			     unsigned long next, struct mm_walk *walk)
 {
-	pmd_t *pmd;
-	unsigned long next;
-
-	pmd = pmd_offset(pud, addr);
-	do {
-		int ret;
-
-		ret = split_vmemmap_huge_pmd(pmd, addr & PMD_MASK,
-				!(walk->flags & VMEMMAP_SPLIT_NO_TLB_FLUSH));
-		if (ret)
-			return ret;
+	struct page *head;
+	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
 
-		next = pmd_addr_end(addr, end);
+	/* Only splitting, not remapping the vmemmap pages. */
+	if (!vmemmap_walk->remap_pte)
+		walk->action = ACTION_CONTINUE;
 
-		/*
-		 * We are only splitting, not remapping the hugetlb vmemmap
-		 * pages.
-		 */
-		if (!walk->remap_pte)
-			continue;
-
-		vmemmap_pte_range(pmd, addr, next, walk);
-	} while (pmd++, addr = next, addr != end);
+	spin_lock(&init_mm.page_table_lock);
+	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
+	spin_unlock(&init_mm.page_table_lock);
+	if (!head)
+		return 0;
 
-	return 0;
+	return vmemmap_split_pmd(pmd, head, addr & PMD_MASK, vmemmap_walk);
 }
 
-static int vmemmap_pud_range(p4d_t *p4d, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
+static int vmemmap_pte_entry(pte_t *pte, unsigned long addr,
+			     unsigned long next, struct mm_walk *walk)
 {
-	pud_t *pud;
-	unsigned long next;
-
-	pud = pud_offset(p4d, addr);
-	do {
-		int ret;
+	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
 
-		next = pud_addr_end(addr, end);
-		ret = vmemmap_pmd_range(pud, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (pud++, addr = next, addr != end);
+	/*
+	 * The reuse_page is found 'first' in page table walking before
+	 * starting remapping.
+	 */
+	if (!vmemmap_walk->reuse_page)
+		vmemmap_walk->reuse_page = pte_page(ptep_get(pte));
+	else
+		vmemmap_walk->remap_pte(pte, addr, vmemmap_walk);
+	vmemmap_walk->nr_walked++;
 
 	return 0;
 }
 
-static int vmemmap_p4d_range(pgd_t *pgd, unsigned long addr,
-			     unsigned long end,
-			     struct vmemmap_remap_walk *walk)
-{
-	p4d_t *p4d;
-	unsigned long next;
-
-	p4d = p4d_offset(pgd, addr);
-	do {
-		int ret;
-
-		next = p4d_addr_end(addr, end);
-		ret = vmemmap_pud_range(p4d, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (p4d++, addr = next, addr != end);
-
-	return 0;
-}
+static const struct mm_walk_ops vmemmap_remap_ops = {
+	.pmd_entry	= vmemmap_pmd_entry,
+	.pte_entry	= vmemmap_pte_entry,
+};
 
 static int vmemmap_remap_range(unsigned long start, unsigned long end,
 			       struct vmemmap_remap_walk *walk)
 {
-	unsigned long addr = start;
-	unsigned long next;
-	pgd_t *pgd;
-
-	VM_BUG_ON(!PAGE_ALIGNED(start));
-	VM_BUG_ON(!PAGE_ALIGNED(end));
+	int ret;
 
-	pgd = pgd_offset_k(addr);
-	do {
-		int ret;
+	VM_BUG_ON(!PAGE_ALIGNED(start | end));
 
-		next = pgd_addr_end(addr, end);
-		ret = vmemmap_p4d_range(pgd, addr, next, walk);
-		if (ret)
-			return ret;
-	} while (pgd++, addr = next, addr != end);
+	ret = walk_page_range_novma(&init_mm, start, end, &vmemmap_remap_ops,
+				    NULL, walk);
+	if (ret)
+		return ret;
 
 	if (walk->remap_pte && !(walk->flags & VMEMMAP_REMAP_NO_TLB_FLUSH))
 		flush_tlb_kernel_range(start, end);
-- 
2.20.1

