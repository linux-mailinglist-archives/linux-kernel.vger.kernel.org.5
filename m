Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0237652FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 13:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjG0L5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbjG0L44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 07:56:56 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1A52D4B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 04:56:53 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RBTh66H48zLntw;
        Thu, 27 Jul 2023 19:54:14 +0800 (CST)
Received: from huawei.com (10.174.151.185) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 27 Jul
 2023 19:56:50 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
CC:     <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 2/4] mm: memory-failure: fix potential unexpected return value from unpoison_memory()
Date:   Thu, 27 Jul 2023 19:56:41 +0800
Message-ID: <20230727115643.639741-3-linmiaohe@huawei.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If unpoison_memory() fails to clear page hwpoisoned flag, return value
ret is expected to be -EBUSY. But when get_hwpoison_page() returns 1
and fails to clear page hwpoisoned flag due to races, return value will
be unexpected 1 leading to users being confused. And there's a code smell
that the variable "ret" is used not only to save the return value of
unpoison_memory(), but also the return value from get_hwpoison_page().
Make a further cleanup by using another auto-variable solely to save the
return value of get_hwpoison_page() as suggested by Naoya.

Fixes: bf181c582588 ("mm/hwpoison: fix unpoison_memory()")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/memory-failure.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a114c8c3039c..4a3e88c15631 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2502,7 +2502,7 @@ int unpoison_memory(unsigned long pfn)
 {
 	struct folio *folio;
 	struct page *p;
-	int ret = -EBUSY;
+	int ret = -EBUSY, ghp;
 	unsigned long count = 1;
 	bool huge = false;
 	static DEFINE_RATELIMIT_STATE(unpoison_rs, DEFAULT_RATELIMIT_INTERVAL,
@@ -2550,29 +2550,28 @@ int unpoison_memory(unsigned long pfn)
 	if (folio_test_slab(folio) || PageTable(&folio->page) || folio_test_reserved(folio))
 		goto unlock_mutex;
 
-	ret = get_hwpoison_page(p, MF_UNPOISON);
-	if (!ret) {
+	ghp = get_hwpoison_page(p, MF_UNPOISON);
+	if (!ghp) {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
-			if (count == 0) {
-				ret = -EBUSY;
+			if (count == 0)
 				goto unlock_mutex;
-			}
 		}
 		ret = folio_test_clear_hwpoison(folio) ? 0 : -EBUSY;
-	} else if (ret < 0) {
-		if (ret == -EHWPOISON) {
+	} else if (ghp < 0) {
+		if (ghp == -EHWPOISON) {
 			ret = put_page_back_buddy(p) ? 0 : -EBUSY;
-		} else
+		} else {
+			ret = ghp;
 			unpoison_pr_info("Unpoison: failed to grab page %#lx\n",
 					 pfn, &unpoison_rs);
+		}
 	} else {
 		if (PageHuge(p)) {
 			huge = true;
 			count = folio_free_raw_hwp(folio, false);
 			if (count == 0) {
-				ret = -EBUSY;
 				folio_put(folio);
 				goto unlock_mutex;
 			}
-- 
2.33.0

