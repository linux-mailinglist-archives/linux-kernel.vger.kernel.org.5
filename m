Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5D375D7B1
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbjGUWvU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGUWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:51:18 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA043A84
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:51:17 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbb07e7155so27815e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689979876; x=1690584676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=elohkkDV87wvNDTR2jsFWkT0oP/sefmnnrdNmfHP874=;
        b=p0LoYFvmdEhS2v57N04R2NYWhY/gsDBii0fSZugz/0R0VEvyz2Ib5+5/Yg4jw7ll0U
         1/Mg1pWgNCe3ikLnZI2hVjTqy3JM4qOVFuXbMbJKc45Y1b9PGSM6rCx2j65yzVD55lF6
         uJXb62jzNqA1gdeeDxasalkWHvpnn/aZcd57LOw1ZFsxRLZZ1HRw6nc9uqnpR4bvRA25
         YX8LP5VCFtDP6wX+w990POt7CaFcBQpz5GBD0y9ORO38oBuoy9PfPo+uGDFIUTotqwTN
         /1WGXZuAXjbrTcJcv3ogmYc7wNLHeGwi7kZgDoPsSCTGLGYJL39c1+2B5EwQf+mLGmmU
         A1SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689979876; x=1690584676;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elohkkDV87wvNDTR2jsFWkT0oP/sefmnnrdNmfHP874=;
        b=NjpIawjtPLyVeJnOUKdLR8KJcT3G8d3dBKsvoVXLeTXVi+kwwoyBG/hxfXU9uYzSPm
         lQAjqkT3/CF+PNkdupw2+64RTU2Zmr1q4UK3sKgWvl+guobRYfPSHg+mcazC2QPMHxh2
         tBHE+GVPaKonEw7MQkN13bnQxD26WpwUc7mql5ZXK6S3V/iUYkhKGORQcRHT2miPeVZ+
         etaeviCfK22KIuDf+vEg9PRjlTmPF3Qftfmeu8rjkqNr66wR/8YS6FJmhVAU2ZEAFeHw
         pZuhfqnXrB3j3YGtMWuhObB6kgifzOXvT+lul3ZiFCCUZ++6uyr86WBJNQxQ7O+rJtS/
         kYLA==
X-Gm-Message-State: ABy/qLaRIkNQdlw1+7tVUMvDbMYXDlbQ3BnIWinR2yRduwq0GqKEHIbB
        2bXZpyvaFD3rDCNQpxqzqZJiyQ==
X-Google-Smtp-Source: APBJJlGhnxfItsRVlRyIJgcAPSHMwKvdMffVps2sPBaVtcO2K2UberiVtqIG1w63Hb3OWu0SAz+e4g==
X-Received: by 2002:a05:600c:3b22:b0:3f7:e59f:2183 with SMTP id m34-20020a05600c3b2200b003f7e59f2183mr19372wms.5.1689979875582;
        Fri, 21 Jul 2023 15:51:15 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:cce4:681f:e44b:4f75])
        by smtp.gmail.com with ESMTPSA id q3-20020a05600c46c300b003fc3b03caa5sm7078473wmo.1.2023.07.21.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 15:51:14 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2] mm: Fix memory ordering for mm_lock_seq and vm_lock_seq
Date:   Sat, 22 Jul 2023 00:51:07 +0200
Message-ID: <20230721225107.942336-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mm->mm_lock_seq effectively functions as a read/write lock; therefore it
must be used with acquire/release semantics.

A specific example is the interaction between userfaultfd_register() and
lock_vma_under_rcu().
userfaultfd_register() does the following from the point where it changes
a VMA's flags to the point where concurrent readers are permitted again
(in a simple scenario where only a single private VMA is accessed and no
merging/splitting is involved):

userfaultfd_register
  userfaultfd_set_vm_flags
    vm_flags_reset
      vma_start_write
        down_write(&vma->vm_lock->lock)
        vma->vm_lock_seq = mm_lock_seq [marks VMA as busy]
        up_write(&vma->vm_lock->lock)
      vm_flags_init
        [sets VM_UFFD_* in __vm_flags]
  vma->vm_userfaultfd_ctx.ctx = ctx
  mmap_write_unlock
    vma_end_write_all
      WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1) [unlocks VMA]

There are no memory barriers in between the __vm_flags update and the
mm->mm_lock_seq update that unlocks the VMA, so the unlock can be reordered
to above the `vm_flags_init()` call, which means from the perspective of a
concurrent reader, a VMA can be marked as a userfaultfd VMA while it is not
VMA-locked. That's bad, we definitely need a store-release for the unlock
operation.

The non-atomic write to vma->vm_lock_seq in vma_start_write() is mostly
fine because all accesses to vma->vm_lock_seq that matter are always
protected by the VMA lock. There is a racy read in vma_start_read() though
that can tolerate false-positives, so we should be using WRITE_ONCE() to
keep things tidy and data-race-free (including for KCSAN).

On the other side, lock_vma_under_rcu() works as follows in the relevant
region for locking and userfaultfd check:

lock_vma_under_rcu
  vma_start_read
    vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [early bailout]
    down_read_trylock(&vma->vm_lock->lock)
    vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq) [main check]
  userfaultfd_armed
    checks vma->vm_flags & __VM_UFFD_FLAGS

Here, the interesting aspect is how far down the mm->mm_lock_seq read
can be reordered - if this read is reordered down below the vma->vm_flags
access, this could cause lock_vma_under_rcu() to partly operate on
information that was read while the VMA was supposed to be locked.
To prevent this kind of downwards bleeding of the mm->mm_lock_seq read, we
need to read it with a load-acquire.

Some of the comment wording is based on suggestions by Suren.

BACKPORT WARNING: One of the functions changed by this patch (which I've
written against Linus' tree) is vma_try_start_write(), but this function
no longer exists in mm/mm-everything. I don't know whether the merged
version of this patch will be ordered before or after the patch that
removes vma_try_start_write(). If you're backporting this patch to a
tree with vma_try_start_write(), make sure this patch changes that
function.

Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to control it")
Cc: stable@vger.kernel.org
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---

Notes:
    v2: made the comments much clearer based on off-list input from Suren

 include/linux/mm.h        | 29 +++++++++++++++++++++++------
 include/linux/mm_types.h  | 28 ++++++++++++++++++++++++++++
 include/linux/mmap_lock.h | 10 ++++++++--
 3 files changed, 59 insertions(+), 8 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..406ab9ea818f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -641,8 +641,14 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
  */
 static inline bool vma_start_read(struct vm_area_struct *vma)
 {
-	/* Check before locking. A race might cause false locked result. */
-	if (vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))
+	/*
+	 * Check before locking. A race might cause false locked result.
+	 * We can use READ_ONCE() for the mm_lock_seq here, and don't need
+	 * ACQUIRE semantics, because this is just a lockless check whose result
+	 * we don't rely on for anything - the mm_lock_seq read against which we
+	 * need ordering is below.
+	 */
+	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq))
 		return false;
 
 	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
@@ -653,8 +659,13 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
 	 * False unlocked result is impossible because we modify and check
 	 * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock_seq
 	 * modification invalidates all existing locks.
+	 *
+	 * We must use ACQUIRE semantics for the mm_lock_seq so that if we are
+	 * racing with vma_end_write_all(), we only start reading from the VMA
+	 * after it has been unlocked.
+	 * This pairs with RELEASE semantics in vma_end_write_all().
 	 */
-	if (unlikely(vma->vm_lock_seq == READ_ONCE(vma->vm_mm->mm_lock_seq))) {
+	if (unlikely(vma->vm_lock_seq == smp_load_acquire(&vma->vm_mm->mm_lock_seq))) {
 		up_read(&vma->vm_lock->lock);
 		return false;
 	}
@@ -676,7 +687,7 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	 * current task is holding mmap_write_lock, both vma->vm_lock_seq and
 	 * mm->mm_lock_seq can't be concurrently modified.
 	 */
-	*mm_lock_seq = READ_ONCE(vma->vm_mm->mm_lock_seq);
+	*mm_lock_seq = vma->vm_mm->mm_lock_seq;
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
@@ -688,7 +699,13 @@ static inline void vma_start_write(struct vm_area_struct *vma)
 		return;
 
 	down_write(&vma->vm_lock->lock);
-	vma->vm_lock_seq = mm_lock_seq;
+	/*
+	 * We should use WRITE_ONCE() here because we can have concurrent reads
+	 * from the early lockless pessimistic check in vma_start_read().
+	 * We don't really care about the correctness of that early check, but
+	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
+	 */
+	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
 	up_write(&vma->vm_lock->lock);
 }
 
@@ -702,7 +719,7 @@ static inline bool vma_try_start_write(struct vm_area_struct *vma)
 	if (!down_write_trylock(&vma->vm_lock->lock))
 		return false;
 
-	vma->vm_lock_seq = mm_lock_seq;
+	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
 	up_write(&vma->vm_lock->lock);
 	return true;
 }
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index de10fc797c8e..5e74ce4a28cd 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -514,6 +514,20 @@ struct vm_area_struct {
 	};
 
 #ifdef CONFIG_PER_VMA_LOCK
+	/*
+	 * Can only be written (using WRITE_ONCE()) while holding both:
+	 *  - mmap_lock (in write mode)
+	 *  - vm_lock->lock (in write mode)
+	 * Can be read reliably while holding one of:
+	 *  - mmap_lock (in read or write mode)
+	 *  - vm_lock->lock (in read or write mode)
+	 * Can be read unreliably (using READ_ONCE()) for pessimistic bailout
+	 * while holding nothing (except RCU to keep the VMA struct allocated).
+	 *
+	 * This sequence counter is explicitly allowed to overflow; sequence
+	 * counter reuse can only lead to occasional unnecessary use of the
+	 * slowpath.
+	 */
 	int vm_lock_seq;
 	struct vma_lock *vm_lock;
 
@@ -679,6 +693,20 @@ struct mm_struct {
 					  * by mmlist_lock
 					  */
 #ifdef CONFIG_PER_VMA_LOCK
+		/*
+		 * This field has lock-like semantics, meaning it is sometimes
+		 * accessed with ACQUIRE/RELEASE semantics.
+		 * Roughly speaking, incrementing the sequence number is
+		 * equivalent to releasing locks on VMAs; reading the sequence
+		 * number can be part of taking a read lock on a VMA.
+		 *
+		 * Can be modified under write mmap_lock using RELEASE
+		 * semantics.
+		 * Can be read with no other protection when holding write
+		 * mmap_lock.
+		 * Can be read with ACQUIRE semantics if not holding write
+		 * mmap_lock.
+		 */
 		int mm_lock_seq;
 #endif
 
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index aab8f1b28d26..e05e167dbd16 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -76,8 +76,14 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 static inline void vma_end_write_all(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
-	/* No races during update due to exclusive mmap_lock being held */
-	WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
+	/*
+	 * Nobody can concurrently modify mm->mm_lock_seq due to exclusive
+	 * mmap_lock being held.
+	 * We need RELEASE semantics here to ensure that preceding stores into
+	 * the VMA take effect before we unlock it with this store.
+	 * Pairs with ACQUIRE semantics in vma_start_read().
+	 */
+	smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
 }
 #else
 static inline void vma_end_write_all(struct mm_struct *mm) {}

base-commit: d192f5382581d972c4ae1b4d72e0b59b34cadeb9
-- 
2.41.0.487.g6d72f3e995-goog

