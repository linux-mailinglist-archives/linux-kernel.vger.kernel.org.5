Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58D2A7D3B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbjJWPmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjJWPmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:42:52 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 665D8BC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version:
        Content-Type; bh=zYiXtfVmofgN8fsdrL5yrW9lXdRUcGbVHp2UDjk1nZ8=;
        b=dLPinXuPgEe6AI8aBTctHDjuVzDHlIkw7Y7t3KW7888gS6fTH0di3jo719Ucdk
        1Osv+Qd4Cc8FnLInprfnbTyRfAPnoi276PHj5ko+sfijV3lvfQEwsfLyMvl2dooc
        yWrJtmy7lUW4I0nSNGU9m2uNmcZYTAaYkkYby+8XW7Rf4=
Received: from localhost.localdomain (unknown [124.90.109.239])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wB3n_NZlDZlHoE8BQ--.20243S2;
        Mon, 23 Oct 2023 23:42:17 +0800 (CST)
From:   wang wei <a929244872@163.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     wang wei <a929244872@163.com>
Subject: [PATCH] mm/page_alloc: fix the potential memory waste in page_frag_alloc_align
Date:   Mon, 23 Oct 2023 23:42:16 +0800
Message-Id: <20231023154216.376522-1-a929244872@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wB3n_NZlDZlHoE8BQ--.20243S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R2Q6XDUUUU
X-Originating-IP: [124.90.109.239]
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/xtbBFhoSplgi7YMtdAAAs1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First step, allocating a memory fragment with size 1KB bytes uses
page_frag_alloc_align.  It will allocate PAGE_FRAG_CACHE_MAX_SIZE
bytes by __page_frag_cache_refill, store the pointer at nc->va and
then return the last 1KB memory fragment which address is nc->va
+ PAGE_FRAG_CACHE_MAX_SIZE - 1KB. The remaining PAGE_FRAG_CACHE_MAX_SIZE
- 1KB bytes of memory can Meet future memory requests.

Second step, if the caller requests a memory fragment with size
more then PAGE_FRAG_CACHE_MAX_SIZE bytes,  page_frag_alloc_align,
it will also allocate PAGE_FRAG_CACHE_MAX_SIZE bytes by
__page_frag_cache_refill,  store the pointer at nc->va, and
return NULL.  this behavior makes the rest of
PAGE_FRAG_CACHE_MAX_SIZE - 1KB bytes memory at First step are
wasted(allocate from buddy system but not used).

So we should check the size of memory requests. If it beyound
PAGE_FRAG_CACHE_MAX_SIZE, we should return NULL directly.

Signed-off-by: wang wei <a929244872@163.com>
---
 mm/page_alloc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 8cf86d0c6aa8..3182c648e86e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4757,6 +4757,9 @@ void *page_frag_alloc_align(struct page_frag_cache *nc,
 	struct page *page;
 	int offset;
 
+	if（unlikely(fragsz > PAGE_FRAG_CACHE_MAX_SIZE)）
+		return NULL;
+
 	if (unlikely(!nc->va)) {
 refill:
 		page = __page_frag_cache_refill(nc, gfp_mask);
-- 
2.25.1

