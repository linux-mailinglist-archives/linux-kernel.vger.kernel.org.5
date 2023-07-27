Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCDF87652FA
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbjG0L5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233573AbjG0L44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:56:56 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84B0A2738
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:56:52 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RBTk351PczrS0M;
        Thu, 27 Jul 2023 19:55:55 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:56:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 1/4] mm/swapfile: fix wrong swap entry type for hwpoisoned swapcache page
Date:   Thu, 27 Jul 2023 19:56:40 +0800
Message-ID: <20230727115643.639741-2-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20230727115643.639741-1-linmiaohe@huawei.com>
References: <20230727115643.639741-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hwpoisoned dirty swap cache page is kept in the swap cache and there's
simple interception code in do_swap_page() to catch it. But when trying
to swapoff, unuse_pte() will wrongly install a general sense of "future
accesses are invalid" swap entry for hwpoisoned swap cache page due to
unaware of such type of page. The user will receive SIGBUS signal without
expected BUS_MCEERR_AR payload. BTW, typo 'hwposioned' is fixed.

Fixes: 6b970599e807 ("mm: hwpoison: support recovery from ksm_might_need_to_copy()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/ksm.c      | 2 ++
 mm/swapfile.c | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 97a9627116fa..74804158ee02 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2794,6 +2794,8 @@ struct page *ksm_might_need_to_copy(struct page *page,
 			anon_vma->root == vma->anon_vma->root) {
 		return page;		/* still no need to copy it */
 	}
+	if (PageHWPoison(page))
+		return ERR_PTR(-EHWPOISON);
 	if (!PageUptodate(page))
 		return page;		/* let do_swap_page report the error */
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index e04eb9c0482d..0df94c4000ea 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1744,7 +1744,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	struct page *swapcache;
 	spinlock_t *ptl;
 	pte_t *pte, new_pte, old_pte;
-	bool hwposioned = false;
+	bool hwpoisoned = PageHWPoison(page);
 	int ret = 1;
 
 	swapcache = page;
@@ -1752,7 +1752,7 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 	if (unlikely(!page))
 		return -ENOMEM;
 	else if (unlikely(PTR_ERR(page) == -EHWPOISON))
-		hwposioned = true;
+		hwpoisoned = true;
 
 	pte = pte_offset_map_lock(vma->vm_mm, pmd, addr, &ptl);
 	if (unlikely(!pte || !pte_same_as_swp(ptep_get(pte),
@@ -1763,11 +1763,11 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 
 	old_pte = ptep_get(pte);
 
-	if (unlikely(hwposioned || !PageUptodate(page))) {
+	if (unlikely(hwpoisoned || !PageUptodate(page))) {
 		swp_entry_t swp_entry;
 
 		dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
-		if (hwposioned) {
+		if (hwpoisoned) {
 			swp_entry = make_hwpoison_entry(swapcache);
 			page = swapcache;
 		} else {
-- 
2.33.0

