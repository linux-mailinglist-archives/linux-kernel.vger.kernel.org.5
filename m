Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C460782B9B
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbjHUOWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjHUOWi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:22:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DC1188
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 07:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=gG7pdGsI6/OPp6WkwdrC+mA3dT68163o1ZnN7Zyaym0=; b=nNI19ZuWtiV5y5m/vpr8ocAr2U
        chezZLz3ntHiSOjSP7k8oAvqJp0hovvGuzPTvh24Ly8kabrlM4rc5e0s5adQOvN9Khi+TdJv0DhAg
        beRGqyW/uUx6FD/CJbgTboBkSqyHVNr5tCvpvjfeTnGjSi4Fzaw8wHP1Tnxm2V+jQSzt0iMSx7CTO
        I0JmDgLJtDvOTOyv6O3xJpXXdIIT0MVbPXcrYjxBhnU8FxbK15jewIguBLKgg2yqfrBFNlphukmtK
        0HLNvPdrNeJmzDLAFfDRokKBR4ILRj47cWI0wb5LVpEifImmRAP+LpNynnemAPaBO+4GIAux9TZck
        K66BRrmQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qY5nF-00Ae1V-Ml; Mon, 21 Aug 2023 14:22:09 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Ingo Molnar <mingo@redhat.com>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] futex: Use a folio instead of a page
Date:   Mon, 21 Aug 2023 15:22:07 +0100
Message-Id: <20230821142207.2537124-1-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
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

The futex code already handles compound pages correctly, but using a
folio lets us tell the compiler that we already have the head page and
it doesn't need to call compound_head() again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/futex/core.c | 67 ++++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index f10587d1d481..d1d7b3c175a4 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -222,7 +222,8 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 {
 	unsigned long address = (unsigned long)uaddr;
 	struct mm_struct *mm = current->mm;
-	struct page *page, *tail;
+	struct page *page;
+	struct folio *folio;
 	struct address_space *mapping;
 	int err, ro = 0;
 
@@ -273,54 +274,52 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		err = 0;
 
 	/*
-	 * The treatment of mapping from this point on is critical. The page
-	 * lock protects many things but in this context the page lock
+	 * The treatment of mapping from this point on is critical. The folio
+	 * lock protects many things but in this context the folio lock
 	 * stabilizes mapping, prevents inode freeing in the shared
 	 * file-backed region case and guards against movement to swap cache.
 	 *
-	 * Strictly speaking the page lock is not needed in all cases being
-	 * considered here and page lock forces unnecessarily serialization
+	 * Strictly speaking the folio lock is not needed in all cases being
+	 * considered here and folio lock forces unnecessarily serialization.
 	 * From this point on, mapping will be re-verified if necessary and
-	 * page lock will be acquired only if it is unavoidable
+	 * folio lock will be acquired only if it is unavoidable
 	 *
-	 * Mapping checks require the head page for any compound page so the
-	 * head page and mapping is looked up now. For anonymous pages, it
-	 * does not matter if the page splits in the future as the key is
-	 * based on the address. For filesystem-backed pages, the tail is
-	 * required as the index of the page determines the key. For
-	 * base pages, there is no tail page and tail == page.
+	 * Mapping checks require the folio so it is looked up now. For
+	 * anonymous pages, it does not matter if the folio is split
+	 * in the future as the key is based on the address. For
+	 * filesystem-backed pages, the precise page is required as the
+	 * index of the page determines the key.
 	 */
-	tail = page;
-	page = compound_head(page);
-	mapping = READ_ONCE(page->mapping);
+	folio = page_folio(page);
+	mapping = READ_ONCE(folio->mapping);
 
 	/*
-	 * If page->mapping is NULL, then it cannot be a PageAnon
+	 * If folio->mapping is NULL, then it cannot be an anonymous
 	 * page; but it might be the ZERO_PAGE or in the gate area or
 	 * in a special mapping (all cases which we are happy to fail);
 	 * or it may have been a good file page when get_user_pages_fast
 	 * found it, but truncated or holepunched or subjected to
-	 * invalidate_complete_page2 before we got the page lock (also
+	 * invalidate_complete_page2 before we got the folio lock (also
 	 * cases which we are happy to fail).  And we hold a reference,
 	 * so refcount care in invalidate_inode_page's remove_mapping
 	 * prevents drop_caches from setting mapping to NULL beneath us.
 	 *
 	 * The case we do have to guard against is when memory pressure made
 	 * shmem_writepage move it from filecache to swapcache beneath us:
-	 * an unlikely race, but we do need to retry for page->mapping.
+	 * an unlikely race, but we do need to retry for folio->mapping.
 	 */
 	if (unlikely(!mapping)) {
 		int shmem_swizzled;
 
 		/*
-		 * Page lock is required to identify which special case above
-		 * applies. If this is really a shmem page then the page lock
+		 * Folio lock is required to identify which special case above
+		 * applies. If this is really a shmem page then the folio lock
 		 * will prevent unexpected transitions.
 		 */
-		lock_page(page);
-		shmem_swizzled = PageSwapCache(page) || page->mapping;
-		unlock_page(page);
-		put_page(page);
+		folio_lock(folio);
+		shmem_swizzled = folio_test_swapcache(folio) || folio->mapping;
+		folio_unlock(folio);
+		folio_put(folio);
 
 		if (shmem_swizzled)
 			goto again;
@@ -331,14 +330,14 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 	/*
 	 * Private mappings are handled in a simple way.
 	 *
-	 * If the futex key is stored on an anonymous page, then the associated
+	 * If the futex key is stored in anonymous memory, then the associated
 	 * object is the mm which is implicitly pinned by the calling process.
 	 *
 	 * NOTE: When userspace waits on a MAP_SHARED mapping, even if
 	 * it's a read-only handle, it's expected that futexes attach to
 	 * the object not the particular process.
 	 */
-	if (PageAnon(page)) {
+	if (folio_test_anon(folio)) {
 		/*
 		 * A RO anonymous page will never change and thus doesn't make
 		 * sense for futex operations.
@@ -357,10 +356,10 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 
 		/*
 		 * The associated futex object in this case is the inode and
-		 * the page->mapping must be traversed. Ordinarily this should
-		 * be stabilised under page lock but it's not strictly
+		 * the folio->mapping must be traversed. Ordinarily this should
+		 * be stabilised under folio lock but it's not strictly
 		 * necessary in this case as we just want to pin the inode, not
-		 * update the radix tree or anything like that.
+		 * update i_pages or anything like that.
 		 *
 		 * The RCU read lock is taken as the inode is finally freed
 		 * under RCU. If the mapping still matches expectations then the
@@ -368,9 +367,9 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		 */
 		rcu_read_lock();
 
-		if (READ_ONCE(page->mapping) != mapping) {
+		if (READ_ONCE(folio->mapping) != mapping) {
 			rcu_read_unlock();
-			put_page(page);
+			folio_put(folio);
 
 			goto again;
 		}
@@ -378,19 +377,19 @@ int get_futex_key(u32 __user *uaddr, bool fshared, union futex_key *key,
 		inode = READ_ONCE(mapping->host);
 		if (!inode) {
 			rcu_read_unlock();
-			put_page(page);
+			folio_put(folio);
 
 			goto again;
 		}
 
 		key->both.offset |= FUT_OFF_INODE; /* inode-based key */
 		key->shared.i_seq = get_inode_sequence_number(inode);
-		key->shared.pgoff = page_to_pgoff(tail);
+		key->shared.pgoff = folio->index + folio_page_idx(folio, page);
 		rcu_read_unlock();
 	}
 
 out:
-	put_page(page);
+	folio_put(folio);
 	return err;
 }
 
-- 
2.40.1

