Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE43078344A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbjHUUpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 16:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjHUUow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 16:44:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA8B1723
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 13:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uZKmm6KWu5gIA8MZSDwDZfTtk9T5DcLVj5SgxVN7+4w=; b=v0t2Syi3ZRpGhRgAu0OekJV8fg
        i1bZOE90UDMiASJIcuWOZSxmfOOePDQlvt8HvZfsbeZ6oq5e/e3hdmJa6CjWaFDpueGvhk5C4O7RG
        mM3iWkWtoMQIoEsJRcifKq6bTwVt/5uIPogb9Y4GHBmo/+CAqeS21plFM9t9F/hJ8SyqTLDKZw6ZJ
        fl/px1t9awQR5d266OlhyEh/q6fQ1QH7FNmMZYESIgL6huigzRGkKtCQwXvAWgD40tyLj/m54ZLp8
        yj46PeNE7g2cbyCrU4r6JMxWVOD71/V7EEtmktVZCqtbvz3nLMg1bcnMJF1HOVhJs+M4eBiIC1uZs
        1Z1cVBng==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qYBlE-00CL0D-RA; Mon, 21 Aug 2023 20:44:28 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Mateusz Guzik <mjguzik@gmail.com>, linux-kernel@vger.kernel.org,
        dennis@kernel.org, tj@kernel.org, cl@linux.com,
        akpm@linux-foundation.org, shakeelb@google.com, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 4/7] mm: Use folios_put() in __folio_batch_release()
Date:   Mon, 21 Aug 2023 21:44:22 +0100
Message-Id: <20230821204425.2940496-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230821204425.2940496-1-willy@infradead.org>
References: <ZOPMNyZ3gKb/bdjO@casper.infradead.org>
 <20230821204425.2940496-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no need to indirect through release_pages() and iterate
over this batch of folios an extra time; we can just use the batch
that we have.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/swap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/swap.c b/mm/swap.c
index 11ca25d4843f..9d31185dc27b 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1072,7 +1072,7 @@ void __folio_batch_release(struct folio_batch *fbatch)
 		lru_add_drain();
 		fbatch->percpu_pvec_drained = true;
 	}
-	release_pages(fbatch->folios, folio_batch_count(fbatch));
+	folios_put(fbatch);
 	folio_batch_reinit(fbatch);
 }
 EXPORT_SYMBOL(__folio_batch_release);
-- 
2.40.1

