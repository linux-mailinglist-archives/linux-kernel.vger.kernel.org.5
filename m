Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC33E7E9CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:01:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjKMNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:01:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjKMNAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:00:43 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC701984;
        Mon, 13 Nov 2023 05:00:38 -0800 (PST)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4STTwZ5Mryz1P8HW;
        Mon, 13 Nov 2023 20:57:18 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 13 Nov 2023 21:00:35 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>
CC:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
Subject: [PATCH RFC 4/8] skbuff: explicitize the semantics of skb_frag_fill_page_desc()
Date:   Mon, 13 Nov 2023 21:00:36 +0800
Message-ID: <20231113130041.58124-5-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231113130041.58124-1-linyunsheng@huawei.com>
References: <20231113130041.58124-1-linyunsheng@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we have ensured that the page and the offset to the page
for the skb frag is passed togetherly in one function call,
see [1], make it explicit that skb_frag_fill_page_desc()
expect a base page or head page for a compound page, so
that we can avoid the compound_head() in the net stack.

Log a warning if the caller passes a tail page of compoud
page and adjust 'page' to point to it's head page and
'offset' to point to start of it's head page. The warning
can be removed if we have ensured all the caller is passing
non tail page to skb_frag_fill_page_desc() in the future.

1. https://lore.kernel.org/all/20230511011213.59091-2-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 include/linux/skbuff.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27998f73183e..3e2f806c8ed8 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2423,6 +2423,14 @@ static inline void skb_frag_fill_page_desc(skb_frag_t *frag,
 					   struct page *page,
 					   int off, int size)
 {
+	/* expect head page for compound page */
+	if (WARN_ON_ONCE(PageTail(page))) {
+		struct page *head = compound_head(page);
+
+		off += (page_to_pfn(page) - page_to_pfn(head)) * PAGE_SIZE;
+		page = head;
+	}
+
 	frag->bv_page = page;
 	frag->bv_offset = off;
 	skb_frag_size_set(frag, size);
-- 
2.33.0

