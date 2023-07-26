Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50E9764154
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 23:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbjGZVmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 17:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjGZVmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 17:42:42 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DF8273B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:37 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-51e24210395so5303a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690407756; x=1691012556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnxlTQ81gBkdr1VZeZ5grDVpqKwEzxWr0+2QMvZdbw4=;
        b=ZT7e5mFKmEjRvrVQuTedSQV41BFemV0+PsYevKA+8imKkzuDRAtcFIbIUdR9E8C8y5
         mGQ3fPtU7rUQZYGDjS+rlBMFgxJl3o94OARmhkozh297cSA29pDo968oVAM/VT+eY1eo
         QrmmWq+JvqrjNpX7kfXDbATZKEpHl8mnW7xgjHjiAw0prL1C68NwVno61v/yfeA/3JEk
         ifTpBmtq+vgkH9rXP7YKn9mRFhiZGFi7cAN4/ab7F+3Nwhyz/7g6DQXlSgi+LhCw9DBH
         IITYMKT4ppkdLXdByRhNnRjpGrXANG4tlE0Uo7Zl1D8i+OddboAI4iJp9BjDWJa56qTL
         tdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690407756; x=1691012556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LnxlTQ81gBkdr1VZeZ5grDVpqKwEzxWr0+2QMvZdbw4=;
        b=Axjo09dWdp+r4Mivs0zSX/w3Aii9jeQxpCmUf2qfFfmM/J+R+FtKg3CIGdAILX2FL2
         256prCpzMfD02u5pOBrIn3xlDKYfuU5HIcO3C22X7x1sU2U0944+MhzxSmyTBjx4E4ks
         rNVYTstL1epzLMC3jgPG4yzRYNbPiSKXmcBMCns89m3LDnCVoU/mAP6uewI5EjifNhqy
         O93eW7W0lidg04hRWcPr9eNv1seiVZMnM2mGVbbr05Ou4E67YrV8oMaM2x35o851W7xX
         rp8RYg14hpCHpvSWCB5NRho1PXsb8dNlly5qAnoZYkABa0NVbeSaadFzkuEv5Wu6wa+a
         IGOw==
X-Gm-Message-State: ABy/qLaVTn+GBcxhW4KvD6M3L/BZa2fIfY3Fq+ZfCvH6IBKn1356Imkw
        sDU20G4nC0pa/r/Nd/m63YTT1A==
X-Google-Smtp-Source: APBJJlHT6JhhN0rsM8945Np541PJMPvbMof5t9ayuXm7MKU7Bh0TmGN48BMSDVKd1nNPTnseRIjpmA==
X-Received: by 2002:a50:8a89:0:b0:51e:5773:891d with SMTP id j9-20020a508a89000000b0051e5773891dmr6251edj.4.1690407755587;
        Wed, 26 Jul 2023 14:42:35 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:e8c:2042:5dec:b586])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c020800b003fc07e1908csm150681wmi.43.2023.07.26.14.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 14:42:34 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 2/2] mm: Fix anon_vma memory ordering
Date:   Wed, 26 Jul 2023 23:41:04 +0200
Message-ID: <20230726214103.3261108-4-jannh@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
In-Reply-To: <20230726214103.3261108-1-jannh@google.com>
References: <20230726214103.3261108-1-jannh@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A read of vma->anon_vma under mmap_lock in read mode (in particular in
anon_vma_prepare()) can race with a concurrent update under mmap_lock
in read mode plus pagetable lock (in __prepare_anon_vma()).
However, the only allowed concurrent update is one that changes
vma->anon_vma from NULL to a non-NULL pointer; once vma->anon_vma has
been set to a non-NULL value, it will keep that value as long as the
mmap lock is held in read mode.

This clearly means that we need an smp_store_release() in
__prepare_anon_vma() (unless we happen to have some equivalent barrier
there, which doesn't seem to be the case).

The harder choice is what to do for all the readers.
In the page fault path, we probably want to only have a single piece of
code (in __prepare_anon_vma()) that has to deal with ensuring that
vma->anon_vma is stable, and then be able to use it with normal memory
accesses afterwards.
One way we can do this is with smp_load_acquire(), which is what this
patch does; however, I expect that we can have a lot of bikeshedding on
whether that is the right barrier to use and whether it should be moved
into a helper function for other places outside the page fault path that
look at vma->anon_vma in read mode.

The other approach is to use read-dependency ordering with READ_ONCE(),
maybe combined with a barrier() afterwards to prevent compiler
reordering. Based on some discussion we had on the security list (and in
particular repeating much of what Linus explained), this would probably
be correct on all currently-supported architectures, because reads from
the same location are guaranteed to not be reordered by the CPU
(I think?), so subsequent loads from the same location would be
guaranteed to see the same value for vma->anon_vma.
And then on anything other than alpha, we'd get implicit
address-dependency ordering against the plain load; while on alpha, we
have a memory barrier inside the READ_ONCE().

Since smp_load_acquire() is allegedly fairly cheap on the main
architectures with weak memory ordering, and the reasoning for why
READ_ONCE() works is kinda iffy, I figured I should use READ_ONCE() for
v1 of the patch and then we can bikeshed it from there.

Also I tried looking through every single access to vma->anon_vma and
put smp_load_acquire() on every one that might reasonably need it, but
again we can probably bikeshed on that.

Cc: stable@vger.kernel.org
Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Jann Horn <jannh@google.com>
---
 include/linux/rmap.h | 15 ++++++++++++++-
 mm/huge_memory.c     |  4 +++-
 mm/khugepaged.c      |  2 +-
 mm/ksm.c             | 16 +++++++++++-----
 mm/memory.c          |  6 +++++-
 mm/mmap.c            | 13 ++++++++++---
 mm/rmap.c            |  6 ++++--
 mm/swapfile.c        |  3 ++-
 8 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/include/linux/rmap.h b/include/linux/rmap.h
index b87d01660412..f7f669a7149b 100644
--- a/include/linux/rmap.h
+++ b/include/linux/rmap.h
@@ -153,9 +153,22 @@ int anon_vma_fork(struct vm_area_struct *, struct vm_area_struct *);
 
 static inline int anon_vma_prepare(struct vm_area_struct *vma)
 {
-	if (likely(vma->anon_vma))
+	/*
+	 * Pairs with smp_store_release() in __anon_vma_prepare().
+	 *
+	 * Holding the mmap lock in read mode guarantees that the only possible
+	 * concurrent modification of vma->anon_vma is that it changes from NULL
+	 * to another value. Therefore, if we see a non-NULL value here, future
+	 * plain loads of vma->anon_vma are okay.
+	 */
+	if (likely(smp_load_acquire(&vma->anon_vma)))
 		return 0;
 
+	/*
+	 * If __anon_vma_prepare() succeeds, it has loaded or stored a non-NULL
+	 * value in vma->anon_vma while protected against concurrent changes by
+	 * the page table lock.
+	 */
 	return __anon_vma_prepare(vma);
 }
 
diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index eb3678360b97..1d0322d45187 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -144,8 +144,10 @@ bool hugepage_vma_check(struct vm_area_struct *vma, unsigned long vm_flags,
 	 *
 	 * Allow page fault since anon_vma may be not initialized until
 	 * the first page fault.
+	 *
+	 * See anon_vma_prepare() for barrier.
 	 */
-	if (!vma->anon_vma)
+	if (!smp_load_acquire(&vma->anon_vma))
 		return (smaps || in_pf);
 
 	return true;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 78c8d5d8b628..4553efe08264 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -939,7 +939,7 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
 	 * hugepage_vma_check may return true for qualified file
 	 * vmas.
 	 */
-	if (expect_anon && (!(*vmap)->anon_vma || !vma_is_anonymous(*vmap)))
+	if (expect_anon && (!smp_load_acquire(&vma->anon_vma) || !vma_is_anonymous(vma)))
 		return SCAN_PAGE_ANON;
 	return SCAN_SUCCEED;
 }
diff --git a/mm/ksm.c b/mm/ksm.c
index ba266359da55..89e69c43a857 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -545,7 +545,9 @@ static struct vm_area_struct *find_mergeable_vma(struct mm_struct *mm,
 	if (ksm_test_exit(mm))
 		return NULL;
 	vma = vma_lookup(mm, addr);
-	if (!vma || !(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+	/* see anon_vma_prepare() */
+	if (!vma || !(vma->vm_flags & VM_MERGEABLE) ||
+			!smp_load_acquire(&vma->anon_vma))
 		return NULL;
 	return vma;
 }
@@ -1026,7 +1028,8 @@ static int unmerge_and_remove_all_rmap_items(void)
 			goto mm_exiting;
 
 		for_each_vma(vmi, vma) {
-			if (!(vma->vm_flags & VM_MERGEABLE) || !vma->anon_vma)
+			if (!(vma->vm_flags & VM_MERGEABLE) ||
+					!smp_load_acquire(&vma->anon_vma))
 				continue;
 			err = unmerge_ksm_pages(vma,
 						vma->vm_start, vma->vm_end);
@@ -2367,7 +2370,8 @@ static struct ksm_rmap_item *scan_get_next_rmap_item(struct page **page)
 			continue;
 		if (ksm_scan.address < vma->vm_start)
 			ksm_scan.address = vma->vm_start;
-		if (!vma->anon_vma)
+		/* see anon_vma_prepare() */
+		if (!smp_load_acquire(&vma->anon_vma))
 			ksm_scan.address = vma->vm_end;
 
 		while (ksm_scan.address < vma->vm_end) {
@@ -2529,7 +2533,8 @@ static int __ksm_del_vma(struct vm_area_struct *vma)
 	if (!(vma->vm_flags & VM_MERGEABLE))
 		return 0;
 
-	if (vma->anon_vma) {
+	/* see anon_vma_prepare() */
+	if (smp_load_acquire(&vma->anon_vma)) {
 		err = unmerge_ksm_pages(vma, vma->vm_start, vma->vm_end);
 		if (err)
 			return err;
@@ -2667,7 +2672,8 @@ int ksm_madvise(struct vm_area_struct *vma, unsigned long start,
 		if (!(*vm_flags & VM_MERGEABLE))
 			return 0;		/* just ignore the advice */
 
-		if (vma->anon_vma) {
+		/* see anon_vma_prepare() */
+		if (smp_load_acquire(&vma->anon_vma)) {
 			err = unmerge_ksm_pages(vma, start, end);
 			if (err)
 				return err;
diff --git a/mm/memory.c b/mm/memory.c
index 603b2f419948..ac602eb70eb4 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -5401,8 +5401,12 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
 	 * This check must happen after vma_start_read(); otherwise, a
 	 * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the VMA
 	 * from its anon_vma.
+	 *
+	 * We don't rely on the READ_ONCE() here for ordering; we're guaranteed
+	 * to go through anon_vma_prepare() before we actually access
+	 * vma->anon_vma.
 	 */
-	if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
+	if (unlikely(!READ_ONCE(vma->anon_vma) && !vma_is_tcp(vma)))
 		goto inval_end_read;
 
 	/*
diff --git a/mm/mmap.c b/mm/mmap.c
index 3eda23c9ebe7..092f64d30522 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1057,8 +1057,7 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
  * the anon_vma of 'old' is concurrently in the process of being set up
  * by another page fault trying to merge _that_. But that's ok: if it
  * is being set up, that automatically means that it will be a singleton
- * acceptable for merging, so we can do all of this optimistically. But
- * we do that READ_ONCE() to make sure that we never re-load the pointer.
+ * acceptable for merging, so we can do all of this optimistically.
  *
  * IOW: that the "list_is_singular()" test on the anon_vma_chain only
  * matters for the 'stable anon_vma' case (ie the thing we want to avoid
@@ -1072,7 +1071,15 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
 static struct anon_vma *reusable_anon_vma(struct vm_area_struct *old, struct vm_area_struct *a, struct vm_area_struct *b)
 {
 	if (anon_vma_compatible(a, b)) {
-		struct anon_vma *anon_vma = READ_ONCE(old->anon_vma);
+		/*
+		 * Pairs with smp_store_release() in __anon_vma_prepare().
+		 *
+		 * We could get away with a READ_ONCE() here, but
+		 * smp_load_acquire() ensures that the following
+		 * list_is_singular() check on old->anon_vma_chain doesn't race
+		 * with __anon_vma_prepare().
+		 */
+		struct anon_vma *anon_vma = smp_load_acquire(&old->anon_vma);
 
 		if (anon_vma && list_is_singular(&old->anon_vma_chain))
 			return anon_vma;
diff --git a/mm/rmap.c b/mm/rmap.c
index 0c0d8857dfce..83bc4267269f 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -210,8 +210,9 @@ int __anon_vma_prepare(struct vm_area_struct *vma)
 	anon_vma_lock_write(anon_vma);
 	/* page_table_lock to protect against threads */
 	spin_lock(&mm->page_table_lock);
+	/* no need for smp_load_acquire() here, the lock prevents concurrency */
 	if (likely(!vma->anon_vma)) {
-		vma->anon_vma = anon_vma;
+		smp_store_release(&vma->anon_vma, anon_vma);
 		anon_vma_chain_link(vma, avc, anon_vma);
 		anon_vma->num_active_vmas++;
 		allocated = NULL;
@@ -755,8 +756,9 @@ unsigned long page_address_in_vma(struct page *page, struct vm_area_struct *vma)
 		/*
 		 * Note: swapoff's unuse_vma() is more efficient with this
 		 * check, and needs it to match anon_vma when KSM is active.
+		 * See anon_vma_prepare() for barrier.
 		 */
-		if (!vma->anon_vma || !page__anon_vma ||
+		if (!smp_load_acquire(&vma->anon_vma) || !page__anon_vma ||
 		    vma->anon_vma->root != page__anon_vma->root)
 			return -EFAULT;
 	} else if (!vma->vm_file) {
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 8e6dde68b389..bdc71829df85 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1986,7 +1986,8 @@ static int unuse_mm(struct mm_struct *mm, unsigned int type)
 
 	mmap_read_lock(mm);
 	for_each_vma(vmi, vma) {
-		if (vma->anon_vma) {
+		/* see anon_vma_prepare() */
+		if (smp_load_acquire(&vma->anon_vma)) {
 			ret = unuse_vma(vma, type);
 			if (ret)
 				break;
-- 
2.41.0.487.g6d72f3e995-goog

