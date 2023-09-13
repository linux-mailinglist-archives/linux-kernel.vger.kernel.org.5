Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4080079F4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 00:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjIMWLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 18:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233025AbjIMWLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 18:11:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D401F198B;
        Wed, 13 Sep 2023 15:11:14 -0700 (PDT)
Date:   Wed, 13 Sep 2023 22:11:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694643072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KVcvQkGvp7fS8Avnst4PUBRgBgjhrPSnSMnAH3ynEg=;
        b=WPLdx78d1BZIYvBZsxC/pJfX4Xo8roccqLmGo4P3Q8vNrCqv3NvNv3ycQWhhYLv4Vylx0I
        1u5YK5t29BCM4Ahatk3nOaM4XC0bQWjSXdO9HkdHjKJvjgvtql6PzTSrWHRudarLJvxPi+
        vRy3qN4UAcwsiP6RYe7nUB1t6Mgq9QcfXAXCq9Y4qcI9qEcycFtd0msPv0cqzKOErtEASi
        E5XMd7lSfIQCDIHvDw5R1fdMnUYnoGD4MGN3PuJYzT0cRNEkc6dsBWGAuXKTqXv9OtpEv8
        Z5zXQM7m1p/hTNME/VsE+Qf4ie8UZnaHpLd5+AZfKAaYq0Kbu74jXO/kRklmvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694643072;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9KVcvQkGvp7fS8Avnst4PUBRgBgjhrPSnSMnAH3ynEg=;
        b=wb2SaqhQEyiqKiXBdIjcOzhejs91+vsFnAlREGFUNp+rvd+wIvGvBvAfEYbsu1NRL+Umut
        LkQPB9q9rOVVWGCg==
From:   "tip-bot2 for Matthew Wilcox (Oracle)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] futex: Use a folio instead of a page
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230821142207.2537124-1-willy@infradead.org>
References: <20230821142207.2537124-1-willy@infradead.org>
MIME-Version: 1.0
Message-ID: <169464307131.27769.15832171531627182162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     e35a6cf1cc343d720ad235f678f1cd2a9876b777
Gitweb:        https://git.kernel.org/tip/e35a6cf1cc343d720ad235f678f1cd2a9876b777
Author:        Matthew Wilcox (Oracle) <willy@infradead.org>
AuthorDate:    Mon, 21 Aug 2023 15:22:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 14 Sep 2023 00:03:09 +02:00

futex: Use a folio instead of a page

The futex code already handles compound pages correctly, but using a folio
tells the compiler that there is already a reference to the head page and
it doesn't need to call compound_head() again.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230821142207.2537124-1-willy@infradead.org

---
 kernel/futex/core.c | 67 +++++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 34 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 514e458..adf7e2c 100644
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
 
@@ -273,54 +274,52 @@ again:
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
@@ -331,14 +330,14 @@ again:
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
@@ -357,10 +356,10 @@ again:
 
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
@@ -368,9 +367,9 @@ again:
 		 */
 		rcu_read_lock();
 
-		if (READ_ONCE(page->mapping) != mapping) {
+		if (READ_ONCE(folio->mapping) != mapping) {
 			rcu_read_unlock();
-			put_page(page);
+			folio_put(folio);
 
 			goto again;
 		}
@@ -378,19 +377,19 @@ again:
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
 
