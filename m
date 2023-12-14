Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5883813167
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 14:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573281AbjLNN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 08:26:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjLNNZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 08:25:59 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3265A126;
        Thu, 14 Dec 2023 05:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kn8CvxNi5qh4QD11jnSpjHpiIFyaVQYj8SeXOQ3UR/M=; b=Ymphf93hcUsna9RWYEJ1i5FWvm
        QO6gwTupm7fmG37py0aAXd+CtC/OWntiYIUrRYG0S0iL4KGmW9loE7n35WfYgdg691tA0ruuq6o4g
        IeDqgCs8n01sx4MFcEbNm+2m0hZqKnCp7Zw9dtKciOW7NNtD0AEDtDyqISiSMDti0I1itZcbNUgD/
        jMgr3PyeOqtJrmyP2pLCfONU1HegzPe9JqCZ9Csc0091UoP3UlDRA//18mMkH7b69/r2MpVkIq0Uo
        nDWtlbXZyGAC+4temfdUdkV73P7SE/c7vhXe5EQDsJCuWNGfcAJjCphLs5vTZ+zr6TS9uVwvaxdhL
        m8a+e+BQ==;
Received: from [88.128.88.27] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1rDlj2-000N2I-1X;
        Thu, 14 Dec 2023 13:26:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: [PATCH 03/11] writeback: Factor should_writeback_folio() out of write_cache_pages()
Date:   Thu, 14 Dec 2023 14:25:36 +0100
Message-Id: <20231214132544.376574-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231214132544.376574-1-hch@lst.de>
References: <20231214132544.376574-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Reduce write_cache_pages() by about 30 lines; much of it is commentary,
but it all bundles nicely into an obvious function.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page-writeback.c | 59 ++++++++++++++++++++++++---------------------
 1 file changed, 32 insertions(+), 27 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 5d33e7b468e2cc..5a3df8665ff4f9 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2394,6 +2394,36 @@ static void writeback_get_batch(struct address_space *mapping,
 			&wbc->fbatch);
 }
 
+static bool should_writeback_folio(struct address_space *mapping,
+		struct writeback_control *wbc, struct folio *folio)
+{
+	/*
+	 * Folio truncated or invalidated. We can freely skip it then,
+	 * even for data integrity operations: the folio has disappeared
+	 * concurrently, so there could be no real expectation of this
+	 * data integrity operation even if there is now a new, dirty
+	 * folio at the same pagecache index.
+	 */
+	if (unlikely(folio->mapping != mapping))
+		return false;
+
+	/* Did somebody write it for us? */
+	if (!folio_test_dirty(folio))
+		return false;
+
+	if (folio_test_writeback(folio)) {
+		if (wbc->sync_mode == WB_SYNC_NONE)
+			return false;
+		folio_wait_writeback(folio);
+	}
+
+	BUG_ON(folio_test_writeback(folio));
+	if (!folio_clear_dirty_for_io(folio))
+		return false;
+
+	return true;
+}
+
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.
  * @mapping: address space structure to write
@@ -2462,38 +2492,13 @@ int write_cache_pages(struct address_space *mapping,
 			wbc->done_index = folio->index;
 
 			folio_lock(folio);
-
-			/*
-			 * Page truncated or invalidated. We can freely skip it
-			 * then, even for data integrity operations: the page
-			 * has disappeared concurrently, so there could be no
-			 * real expectation of this data integrity operation
-			 * even if there is now a new, dirty page at the same
-			 * pagecache address.
-			 */
-			if (unlikely(folio->mapping != mapping)) {
-continue_unlock:
+			if (!should_writeback_folio(mapping, wbc, folio)) {
 				folio_unlock(folio);
 				continue;
 			}
 
-			if (!folio_test_dirty(folio)) {
-				/* someone wrote it for us */
-				goto continue_unlock;
-			}
-
-			if (folio_test_writeback(folio)) {
-				if (wbc->sync_mode != WB_SYNC_NONE)
-					folio_wait_writeback(folio);
-				else
-					goto continue_unlock;
-			}
-
-			BUG_ON(folio_test_writeback(folio));
-			if (!folio_clear_dirty_for_io(folio))
-				goto continue_unlock;
-
 			trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
+
 			error = writepage(folio, wbc, data);
 			nr = folio_nr_pages(folio);
 			if (unlikely(error)) {
-- 
2.39.2

