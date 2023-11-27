Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070A37F9C0C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:47:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbjK0Irt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjK0Irp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:47:45 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1072D12D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:30 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cbd24d9557so2680844b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1701074849; x=1701679649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CXU92qYOzo6aL9X8rG2XQuljOMNrDRKtELmWJz0kLI0=;
        b=B/YT8SJhhS2MaSe7M+ZGUJYqWiINJk7d03Pina1PcV65HL36rHV16DJzwQwtsunOjt
         Nm3IQThzcXPTNuyryQtp9dIQL2uNDTBjPjexjnE3ekHiqhPZUOUdziJCr+W2/OsLwjhN
         aHvRsoNmQGc0zzf1jGoFoAmy7tw22TrlNzPmeR1RqMzSTfMj9ZaRWWoM/ASMdjxs9v8o
         mY6c1uyKofT8RcqVdn/x9DFcQFHc9s44WXsDBVGpTxj3oc0UplKEVdnG1X/jLeYrjDSC
         4cnxUpUzP1uRkrrQ6M0jBC81tuRw3TEhcNUA9HjHzcyHaDukAApm8yuAUZLoJZOemm+f
         OT1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701074849; x=1701679649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CXU92qYOzo6aL9X8rG2XQuljOMNrDRKtELmWJz0kLI0=;
        b=HlgZsqSkdepdk3lo64JnyJ4RmmRRBJilIV+/xcHpefdNv7+mKNUeNbSWMyia0jv/si
         ZeVQlWGCDBwW0K9CZiwTDAU2qCIxPMr2OpEkM+872ZYOtmesZQ4AW/10xOPhXHrzVwZ7
         OQo5iqCJBRfZoPVlTCh2S63sBmLXeJbSljWYsWRkfchd0boSSorkmBq71iKvGBrbPZhQ
         SkouTp+OS8tgxId/Mj6TnUThjbGrG6CSiHHoxkC7fHbLgZJ3E77vpbeAKMQdhaNdoStr
         fKPdFOvAvz5xLWAk+Sfd21INvOE6TgKu+40AuCF45bz+xV2b8nBOWrF9XMguQAkxuz3t
         WsDA==
X-Gm-Message-State: AOJu0YzXc1zhXHBW3KvieZdnLJVzqqYckub91kN9yAh/a9EZhu3RISD4
        wCV1Vpv6JrE92AVTqaNP7Pwyfg==
X-Google-Smtp-Source: AGHT+IHXNermaEvQJyziObFn7H4znAJ2WmRDi/l1vX6FLLvpxZ6tTRgBpFuCL+ANq0CYCQTGl1dHCg==
X-Received: by 2002:a05:6a00:878c:b0:6cb:cc23:f69f with SMTP id hk12-20020a056a00878c00b006cbcc23f69fmr18033800pfb.16.1701074849478;
        Mon, 27 Nov 2023 00:47:29 -0800 (PST)
Received: from PXLDJ45XCM.bytedance.net ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id e22-20020aa78c56000000b006c875abecbcsm6686932pfd.121.2023.11.27.00.47.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Nov 2023 00:47:28 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 3/4] mm: hugetlb_vmemmap: move PageVmemmapSelfHosted() check to split_vmemmap_huge_pmd()
Date:   Mon, 27 Nov 2023 16:46:44 +0800
Message-Id: <20231127084645.27017-4-songmuchun@bytedance.com>
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

To check a page whether it is self-hosted needs to traverse the page table (e.g.
pmd_off_k()), however, we already have done this in the next calling of
vmemmap_remap_range().  Moving PageVmemmapSelfHosted() check to vmemmap_pmd_entry()
could simplify the code a bit.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb_vmemmap.c | 70 +++++++++++++++-----------------------------
 1 file changed, 24 insertions(+), 46 deletions(-)

diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
index ef14356855d13..ce920ca6c90ee 100644
--- a/mm/hugetlb_vmemmap.c
+++ b/mm/hugetlb_vmemmap.c
@@ -95,6 +95,7 @@ static int vmemmap_split_pmd(pmd_t *pmd, struct page *head, unsigned long start,
 static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
 			     unsigned long next, struct mm_walk *walk)
 {
+	int ret = 0;
 	struct page *head;
 	struct vmemmap_remap_walk *vmemmap_walk = walk->private;
 
@@ -104,9 +105,30 @@ static int vmemmap_pmd_entry(pmd_t *pmd, unsigned long addr,
 
 	spin_lock(&init_mm.page_table_lock);
 	head = pmd_leaf(*pmd) ? pmd_page(*pmd) : NULL;
+	/*
+	 * Due to HugeTLB alignment requirements and the vmemmap
+	 * pages being at the start of the hotplugged memory
+	 * region in memory_hotplug.memmap_on_memory case. Checking
+	 * the vmemmap page associated with the first vmemmap page
+	 * if it is self-hosted is sufficient.
+	 *
+	 * [                  hotplugged memory                  ]
+	 * [        section        ][...][        section        ]
+	 * [ vmemmap ][              usable memory               ]
+	 *   ^  | ^                        |
+	 *   +--+ |                        |
+	 *        +------------------------+
+	 */
+	if (unlikely(!vmemmap_walk->nr_walked)) {
+		struct page *page = head ? head + pte_index(addr) :
+				    pte_page(ptep_get(pte_offset_kernel(pmd, addr)));
+
+		if (PageVmemmapSelfHosted(page))
+			ret = -ENOTSUPP;
+	}
 	spin_unlock(&init_mm.page_table_lock);
-	if (!head)
-		return 0;
+	if (!head || ret)
+		return ret;
 
 	return vmemmap_split_pmd(pmd, head, addr & PMD_MASK, vmemmap_walk);
 }
@@ -524,50 +546,6 @@ static bool vmemmap_should_optimize(const struct hstate *h, const struct page *h
 	if (!hugetlb_vmemmap_optimizable(h))
 		return false;
 
-	if (IS_ENABLED(CONFIG_MEMORY_HOTPLUG)) {
-		pmd_t *pmdp, pmd;
-		struct page *vmemmap_page;
-		unsigned long vaddr = (unsigned long)head;
-
-		/*
-		 * Only the vmemmap page's vmemmap page can be self-hosted.
-		 * Walking the page tables to find the backing page of the
-		 * vmemmap page.
-		 */
-		pmdp = pmd_off_k(vaddr);
-		/*
-		 * The READ_ONCE() is used to stabilize *pmdp in a register or
-		 * on the stack so that it will stop changing under the code.
-		 * The only concurrent operation where it can be changed is
-		 * split_vmemmap_huge_pmd() (*pmdp will be stable after this
-		 * operation).
-		 */
-		pmd = READ_ONCE(*pmdp);
-		if (pmd_leaf(pmd))
-			vmemmap_page = pmd_page(pmd) + pte_index(vaddr);
-		else
-			vmemmap_page = pte_page(*pte_offset_kernel(pmdp, vaddr));
-		/*
-		 * Due to HugeTLB alignment requirements and the vmemmap pages
-		 * being at the start of the hotplugged memory region in
-		 * memory_hotplug.memmap_on_memory case. Checking any vmemmap
-		 * page's vmemmap page if it is marked as VmemmapSelfHosted is
-		 * sufficient.
-		 *
-		 * [                  hotplugged memory                  ]
-		 * [        section        ][...][        section        ]
-		 * [ vmemmap ][              usable memory               ]
-		 *   ^   |     |                                        |
-		 *   +---+     |                                        |
-		 *     ^       |                                        |
-		 *     +-------+                                        |
-		 *          ^                                           |
-		 *          +-------------------------------------------+
-		 */
-		if (PageVmemmapSelfHosted(vmemmap_page))
-			return false;
-	}
-
 	return true;
 }
 
-- 
2.20.1

