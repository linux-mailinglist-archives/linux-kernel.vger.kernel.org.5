Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C527BFF51
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233232AbjJJO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjJJO3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:29:06 -0400
Received: from out-197.mta0.migadu.com (out-197.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33307B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:29:03 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8iM6qPUOV4SzLi4G7vOLG6YfwWxmIMlrGIRntMRiEaw=;
        b=LGQ17jWAmO3AzMTEsiisqBbOeFYutV+KmHjON926qys/pAgpt4siIMYDJofdhHOETudxF3
        D4Y7Fa+Xzgy6CTNCoSSFTQWg1Owoi4swnyZrRm/n404f16vqJBzEonrBhPIQKvt0miTdvg
        JaSCNdpTWTvdYNouWp5c6jdVh0y3xac=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 4/5] mm, kpageflags: fix invalid output for PageSlab
Date:   Tue, 10 Oct 2023 23:28:00 +0900
Message-Id: <20231010142801.3780917-5-naoya.horiguchi@linux.dev>
In-Reply-To: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
References: <20231010142801.3780917-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

The flag field of slab tail pages is used for internal purpose and
there's no point in exposing such info to userspace.

Here's the output of `page-types -r -b slab` command now:

               flags      page-count       MB  symbolic-flags                     long-symbolic-flags
  0x0000000000000080            5304       20  _______S_____________________________________      slab
  0x0000000000008080            1488        5  _______S_______H_____________________________      slab,compound_head
  0x0000000000010081             365        1  L______S________T____________________________      locked,slab,compound_tail
  0x0000000000010080            4142       16  _______S________T____________________________      slab,compound_tail
  0x0000000000010180             649        2  _______SW_______T____________________________      slab,writeback,compound_tail
  0x0000000000010181             474        1  L______SW_______T____________________________      locked,slab,writeback,compound_tail
  0x0000000000201080             192        0  _______S____a________x_______________________      slab,anonymous,ksm
  0x0000000000001080             427        1  _______S____a________________________________      slab,anonymous
  0x0000000000409080             237        0  _______S____a__H______t______________________      slab,anonymous,compound_head,thp
  0x0000000000411081              78        0  L______S____a___T_____t______________________      locked,slab,anonymous,compound_tail,thp
  0x0000000000609080              77        0  _______S____a__H_____xt______________________      slab,anonymous,compound_head,ksm,thp
  0x0000000000611081              32        0  L______S____a___T____xt______________________      locked,slab,anonymous,compound_tail,ksm,thp
  0x0000000000411080             698        2  _______S____a___T_____t______________________      slab,anonymous,compound_tail,thp
  0x0000000000611080             142        0  _______S____a___T____xt______________________      slab,anonymous,compound_tail,ksm,thp
  0x0000000000611180              32        0  _______SW___a___T____xt______________________      slab,writeback,anonymous,compound_tail,ksm,thp
  0x0000000000411181              95        0  L______SW___a___T_____t______________________      locked,slab,writeback,anonymous,compound_tail,thp
  0x0000000000411180              64        0  _______SW___a___T_____t______________________      slab,writeback,anonymous,compound_tail,thp
  0x0000000000611181              13        0  L______SW___a___T____xt______________________      locked,slab,writeback,anonymous,compound_tail,ksm,thp

In this output, "locked" and "writeback" flags are completely pointless
because these are encoded in folio->_flags_1 via folio_set_order() and
those pages are actually not locked nor written back.

As for "anonymous" and "ksm" flags, these are encoded in folio->mapping
and the actual value is like 0xdead000000000003.  I'm not sure how this
value is set, but according to the comment in include/linux/page-flags.h:

  > * For slab pages, since slab reuses the bits in struct page to store its
  > * internal states, the page->mapping does not exist as such, nor do these
  > * flags below.  So in order to avoid testing non-existent bits, please
  > * make sure that PageSlab(page) actually evaluates to false before calling
  > * the following functions (e.g., PageAnon).  See mm/slab.h.

, so we don't have to check PageAnon and PageKsm for slab pages.
So return immediately when finding slab tail pages.

Note that KPF_HWPOISON is special and it can be helpful to make it visible
in /prock/kpageflag even on compound tail pages.

After this patch, `page-types -r -b slab` command shows the following simpler
output (without any invalid flags).

  0x0000000000000080            5659       22  _______S_____________________________________      slab
  0x0000000000008080            1644        6  _______S_______H_____________________________      slab,compound_head
  0x0000000000010080            6196       24  _______S________T____________________________      slab,compound_tail

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 fs/proc/page.c | 44 ++++++++++++++++++++++----------------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 9b6ded8a2c90..899b96a26fbd 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -122,18 +122,18 @@ u64 stable_page_flags(struct page *page)
 	k = page->flags;
 	u = 0;
 
-	/*
-	 * pseudo flags for the well known (anonymous) memory mapped pages
-	 *
-	 * Note that page->_mapcount is overloaded in SLAB, so the
-	 * simple test in page_mapped() is not enough.
-	 */
-	if (!PageSlab(page) && page_mapped(page))
-		u |= 1 << KPF_MMAP;
-	if (PageAnon(page))
-		u |= 1 << KPF_ANON;
-	if (PageKsm(page))
-		u |= 1 << KPF_KSM;
+#ifdef CONFIG_MEMORY_FAILURE
+	u |= kpf_copy_bit(k, KPF_HWPOISON, PG_hwpoison);
+#endif
+
+	if (PageSlab(page)) {
+		u |= 1 << KPF_SLAB;
+		if (PageHead(page))
+			u |= 1 << KPF_COMPOUND_HEAD;
+		if (PageTail(page))
+			u |= 1 << KPF_COMPOUND_TAIL;
+		return u;
+	}
 
 	if (PageHuge(page)) {
 		u |= 1 << KPF_HUGE;
@@ -173,9 +173,18 @@ u64 stable_page_flags(struct page *page)
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= 1 << KPF_ZERO_PAGE;
 
+	/*
+	 * pseudo flags for the well known (anonymous) memory mapped pages
+	 */
+	if (page_mapped(page))
+		u |= 1 << KPF_MMAP;
+	if (PageAnon(page))
+		u |= 1 << KPF_ANON;
+	if (PageKsm(page))
+		u |= 1 << KPF_KSM;
 
 	/*
-	 * Caveats on high order pages: PG_buddy and PG_slab will only be set
+	 * Caveats on high order pages: PG_buddy will only be set
 	 * on the head page.
 	 */
 	if (PageBuddy(page))
@@ -192,11 +201,6 @@ u64 stable_page_flags(struct page *page)
 		u |= 1 << KPF_IDLE;
 
 	u |= kpf_copy_bit(k, KPF_LOCKED,	PG_locked);
-
-	u |= kpf_copy_bit(k, KPF_SLAB,		PG_slab);
-	if (PageTail(page) && PageSlab(page))
-		u |= 1 << KPF_SLAB;
-
 	u |= kpf_copy_bit(k, KPF_ERROR,		PG_error);
 	u |= kpf_copy_bit(k, KPF_DIRTY,		PG_dirty);
 	u |= kpf_copy_bit(k, KPF_UPTODATE,	PG_uptodate);
@@ -214,10 +218,6 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_UNEVICTABLE,	PG_unevictable);
 	u |= kpf_copy_bit(k, KPF_MLOCKED,	PG_mlocked);
 
-#ifdef CONFIG_MEMORY_FAILURE
-	u |= kpf_copy_bit(k, KPF_HWPOISON,	PG_hwpoison);
-#endif
-
 #ifdef CONFIG_ARCH_USES_PG_UNCACHED
 	u |= kpf_copy_bit(k, KPF_UNCACHED,	PG_uncached);
 #endif
-- 
2.25.1

