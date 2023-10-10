Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F6C7BFF50
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbjJJO3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjJJO27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:28:59 -0400
Received: from out-193.mta0.migadu.com (out-193.mta0.migadu.com [IPv6:2001:41d0:1004:224b::c1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A212FAF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 07:28:56 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696948135;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/jN8h55KNP3RtmvUZhOGO1MAcrm7V1DX54vKKCbAGW4=;
        b=FLuxcLJc7MCThBfukRGPV/s0DkOpYhPtv8G1oc+pjfFNMFlePzS1gd3bcdx3OjEWEtwW79
        Y93/hs4sGbhOPLdoBK9ceAD39O+cKFKsl5IBEFQ7Vu0D4I1DeN5FK3Bj6lQjjmpW2x8c+Z
        HfvyEq0sy9NhAJKbfwL6i2M897zQLx4=
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
Subject: [PATCH v1 3/5] mm, kpageflags: separate code path for hugetlb pages
Date:   Tue, 10 Oct 2023 23:27:59 +0900
Message-Id: <20231010142801.3780917-4-naoya.horiguchi@linux.dev>
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

Hugetlb pages use some struct page's field of the first few tail pages for
internal use.  There's no point to parse and show the kpageflags info based
on tail pages, so return immediately when finding hugetlb tail pages.

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 fs/proc/page.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index 78f675f791c1..9b6ded8a2c90 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -135,23 +135,20 @@ u64 stable_page_flags(struct page *page)
 	if (PageKsm(page))
 		u |= 1 << KPF_KSM;
 
-	/*
-	 * compound pages: export both head/tail info
-	 * they together define a compound page's start/end pos and order
-	 */
-	if (PageHead(page))
-		u |= 1 << KPF_COMPOUND_HEAD;
-	if (PageTail(page))
-		u |= 1 << KPF_COMPOUND_TAIL;
-	if (PageHuge(page))
+	if (PageHuge(page)) {
 		u |= 1 << KPF_HUGE;
+		if (PageHead(page))
+			u |= 1 << KPF_COMPOUND_HEAD;
+		if (PageTail(page)) {
+			u |= 1 << KPF_COMPOUND_TAIL;
+			return u;
+		}
 	/*
-	 * PageTransCompound can be true for non-huge compound pages (slab
-	 * pages or pages allocated by drivers with __GFP_COMP) because it
-	 * just checks PG_head/PG_tail, so we need to check PageLRU/PageAnon
-	 * to make sure a given page is a thp, not a non-huge compound page.
+	 * PageTransCompound can be true for any types of compound pages,
+	 * because it just checks PG_head and PageTail, but at this point
+	 * PageSlab and PageHuge are already checked to be false.
 	 */
-	else if (PageTransCompound(page)) {
+	} else if (PageTransCompound(page)) {
 		struct page *head = compound_head(page);
 
 		/*
-- 
2.25.1

