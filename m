Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2957EAFEE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 13:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjKNMg4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 07:36:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbjKNMgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 07:36:55 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E5BDF0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 04:36:50 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4SV5QM6HcCz1Fhp
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:36:43 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.138])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4SV5QG4Qqkz67Ckc
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 20:36:38 +0800 (CST)
Received: from mse-fl2.zte.com.cn (unknown [10.5.228.133])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4SV5Q82TyLz4xPYj;
        Tue, 14 Nov 2023 20:36:32 +0800 (CST)
Received: from szxlzmapp04.zte.com.cn ([10.5.231.166])
        by mse-fl2.zte.com.cn with SMTP id 3AECaR48053112;
        Tue, 14 Nov 2023 20:36:27 +0800 (+08)
        (envelope-from yang.yang29@zte.com.cn)
Received: from mapi (szxlzmapp01[null])
        by mapi (Zmail) with MAPI id mid14;
        Tue, 14 Nov 2023 20:36:30 +0800 (CST)
Date:   Tue, 14 Nov 2023 20:36:30 +0800 (CST)
X-Zmail-TransId: 2b03655369ceffffffff932-85ee3
X-Mailer: Zmail v1.0
Message-ID: <202311142036302357580@zte.com.cn>
Mime-Version: 1.0
From:   <yang.yang29@zte.com.cn>
To:     <akpm@linux-foundation.org>, <david@redhat.com>
Cc:     <imbrenda@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <ran.xiaokai@zte.com.cn>,
        <xu.xin.sc@gmail.com>, <xu.xin16@zte.com.cn>,
        <yang.yang29@zte.com.cn>, <jiang.xuexin@zte.com.cn>,
        <wang.yong12@zte.com.cn>
Subject: =?UTF-8?B?W1BBVENIXSBrc206IGRlbGF5IHRoZSBjaGVjayBvZiBzcGxpdHRpbmcgY29tcG91bmQgcGFnZXM=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl2.zte.com.cn 3AECaR48053112
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 655369DA.001/4SV5QM6HcCz1Fhp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

Background
==========
When trying to merge two pages, it may fail because the two pages
belongs to the same compound page and split_huge_page fails due to
the incorrect reference to the page. To solve the problem, the commit
77da2ba0648a4 ("mm/ksm: fix interaction with THP") tries to split the
compound page after try_to_merge_two_pages() fails and put_page in
that case. However it is too early to calculate of the variable 'split' which
indicates whether the two pages belongs to the same compound page.

What to do
==========
If try_to_merge_two_pages() succeeds, there is no need to check whether
to splitting compound pages. So we delay the check of splitting compound
pages until try_to_merge_two_pages() fails, which can improve the
processing efficiency of cmp_and_merge_page() a little.

Signed-off-by: xu xin <xu.xin16@zte.com.cn>
Reviewed-by: Yang Yang <yang.yang29@zte.com.cn>
---
 mm/ksm.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 7efcc68ccc6e..c952fe5d9e43 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -2229,24 +2229,10 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 	tree_rmap_item =
 		unstable_tree_search_insert(rmap_item, page, &tree_page);
 	if (tree_rmap_item) {
-		bool split;
-
 		kpage = try_to_merge_two_pages(rmap_item, page,
 						tree_rmap_item, tree_page);
-		/*
-		 * If both pages we tried to merge belong to the same compound
-		 * page, then we actually ended up increasing the reference
-		 * count of the same compound page twice, and split_huge_page
-		 * failed.
-		 * Here we set a flag if that happened, and we use it later to
-		 * try split_huge_page again. Since we call put_page right
-		 * afterwards, the reference count will be correct and
-		 * split_huge_page should succeed.
-		 */
-		split = PageTransCompound(page)
-			&& compound_head(page) == compound_head(tree_page);
-		put_page(tree_page);
 		if (kpage) {
+			put_page(tree_page);
 			/*
 			 * The pages were successfully merged: insert new
 			 * node in the stable tree and add both rmap_items.
@@ -2271,7 +2257,25 @@ static void cmp_and_merge_page(struct page *page, struct ksm_rmap_item *rmap_ite
 				break_cow(tree_rmap_item);
 				break_cow(rmap_item);
 			}
-		} else if (split) {
+		} else {
+			bool split;
+			/*
+			 * If both pages we tried to merge belong to the same compound
+			 * page, then we actually ended up increasing the reference
+			 * count of the same compound page twice, and split_huge_page
+			 * failed.
+			 * Here we set a flag if that happened, and we use it later to
+			 * try split_huge_page again. Since we call put_page right
+			 * afterwards, the reference count will be correct and
+			 * split_huge_page should succeed.
+			 */
+
+			split = PageTransCompound(page)
+				&& compound_head(page) == compound_head(tree_page);
+			put_page(tree_page);
+
+			if (!split)
+				return;
 			/*
 			 * We are here if we tried to merge two pages and
 			 * failed because they both belonged to the same
-- 
2.15.2
