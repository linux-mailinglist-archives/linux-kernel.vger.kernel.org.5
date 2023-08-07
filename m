Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05C4D7722F8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233028AbjHGLom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233139AbjHGLo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:44:28 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B38E210C
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 04:42:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RKDph3QRhztRxT;
        Mon,  7 Aug 2023 19:38:20 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 19:41:47 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH] mm: memory-failure: use helper macro llist_for_each_entry_safe()
Date:   Mon, 7 Aug 2023 19:41:25 +0800
Message-ID: <20230807114125.3440802-1-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.151.185]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's more convenient to use helper macro llist_for_each_entry_safe().
No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 6781bb0c5eb2..7b01fffe7a79 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -1869,13 +1869,12 @@ bool is_raw_hwpoison_page_in_hugepage(struct page *page)
 
 static unsigned long __folio_free_raw_hwp(struct folio *folio, bool move_flag)
 {
-	struct llist_node *t, *tnode, *head;
+	struct llist_node *head;
+	struct raw_hwp_page *p, *next;
 	unsigned long count = 0;
 
 	head = llist_del_all(raw_hwp_list_head(folio));
-	llist_for_each_safe(tnode, t, head) {
-		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
-
+	llist_for_each_entry_safe(p, next, head, node) {
 		if (move_flag)
 			SetPageHWPoison(p->page);
 		else
@@ -1890,7 +1889,7 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 {
 	struct llist_head *head;
 	struct raw_hwp_page *raw_hwp;
-	struct llist_node *t, *tnode;
+	struct raw_hwp_page *p, *next;
 	int ret = folio_test_set_hwpoison(folio) ? -EHWPOISON : 0;
 
 	/*
@@ -1901,9 +1900,7 @@ static int folio_set_hugetlb_hwpoison(struct folio *folio, struct page *page)
 	if (folio_test_hugetlb_raw_hwp_unreliable(folio))
 		return -EHWPOISON;
 	head = raw_hwp_list_head(folio);
-	llist_for_each_safe(tnode, t, head->first) {
-		struct raw_hwp_page *p = container_of(tnode, struct raw_hwp_page, node);
-
+	llist_for_each_entry_safe(p, next, head->first, node) {
 		if (p->page == page)
 			return -EHWPOISON;
 	}
-- 
2.33.0

