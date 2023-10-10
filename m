Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058FA7BFF52
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbjJJO3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjJJO2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:54 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC34B91
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ct5h8XiEF6Z6bh0u0KQdOShLvibauoLK/pnF+aCIbHs=;
        b=bpjtc/LFwjIYuknqBdChdrg6pH5LhH0gERemOAwGNiqO/B0yhaIPcKkXhCyk1Y+6QiAB6D
        pdmVPLFHqF8iWcxI7QpWy2AkvCdR7eOxKKaViIq1Qya/PPl2bRQHZMcyklBZ8+34tDxuvO
        QoG/rGqvVIFHC+5eFcdEu8fJDv1/1Hs=
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
Subject: [PATCH v1 2/5] mm: kpageflags: distinguish thp and folio
Date:   Tue, 10 Oct 2023 23:27:58 +0900
Message-Id: <20231010142801.3780917-3-naoya.horiguchi@linux.dev>
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

Currently a large folio is considered as thp in the output of
/proc/kpageflags because stable_page_flags() does not have resolution to
distinguish thp and large folio.  This is confusing and the readers of
/proc/kpageflags need additional checks in userspace, which is inefficient.

Check page order in stable_page_flags() to distinguish thp and large folio.
Although thp (or other types of compound page) is a special form of folio,
but the KPF_FOLIO means "folio" in narrower meaning (representing folios
in page cache), so KPF_FOLIO is not set on thp or hugetlb pages.  This is
because thp and hugetlb (and other compound pages) have their own KPF_*
flags, so those are already identifiable.

Thp and folio use some struct page's field of the first tail pages for
internal use.  There's no point to parse and show flag info based on tail
pages, so return immediately when finding thp/folio tail pages.

The output below shows how this patch changes the output of page-types.

Before patch:

  // anonymous thp
  voffset         offset  len     flags
  ...
  700000000       156c00  1       ___U_l_____Ma_bH______t_____________f_d_____1
  700000001       156c01  1       L__U_______Ma___T_____t_____________f_______1
  700000002       156c02  1fe     ___________Ma___T_____t_____________f_______1
                                                        ^
                                                    this 't' means thp
  // file thp
  700000000       15d600  1       __RUDl_____M__bH______t_____________f__I____1
  700000001       15d601  1       L__U_______M____T_____t_____________f_______1
  700000002       15d602  1fe     ___________M____T_____t_____________f_______1

  // large folio
  700000000       154f84  1       __RU_l_____M___H______t________P____f_____F_1
  700000001       154f85  1       ________W__M____T_____t_____________f_____F_1
  700000002       154f86  2       ___________M____T_____t_____________f_____F_1

After patch:

  // anonymous thp
  700000000       117000  1       ___U_l_____Ma_bH______t_____________f_d_____1
  700000001       117001  1ff     ________________T_____t_____________f_______1

  // file thp
  700000000       118400  1       __RUDl_____M__bH______t_____________f__I____1
  700000001       118401  1ff     ________________T_____t_____________f_______1

  // large folio
  700000000       148da4  1       __RU_l_____M___H___________f___P____f_____F_1
  700000001       148da5  3       ________________T__________f________f_____F_1
                                                             ^
                                                    this 'f' means folio

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 fs/proc/page.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 195b077c0fac..78f675f791c1 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -154,11 +154,24 @@ u64 stable_page_flags(struct page *page)
 	else if (PageTransCompound(page)) {
 		struct page *head = compound_head(page);
 
-		if (PageLRU(head) || PageAnon(head))
-			u |= 1 << KPF_THP;
-		else if (is_huge_zero_page(head)) {
+		/*
+		 * We need to check PageLRU/PageAnon to make sure a given page
+		 * is a thp, not a huge zero page or a generic compound page
+		 * (allocated by drivers with __GFP_COMP).
+		 */
+		if (PageLRU(head) || PageAnon(head)) {
+			if (compound_order(head) == HPAGE_PMD_ORDER)
+				u |= 1 << KPF_THP;
+			else
+				u |= 1 << KPF_FOLIO;
+		} else if (is_huge_zero_page(head))
 			u |= 1 << KPF_ZERO_PAGE;
-			u |= 1 << KPF_THP;
+
+		if (PageHead(page))
+			u |= 1 << KPF_COMPOUND_HEAD;
+		if (PageTail(page)) {
+			u |= 1 << KPF_COMPOUND_TAIL;
+			return u;
 		}
 	} else if (is_zero_pfn(page_to_pfn(page)))
 		u |= 1 << KPF_ZERO_PAGE;
-- 
2.25.1

