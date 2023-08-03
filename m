Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3767176F09C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjHCR1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234670AbjHCR1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:27:06 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 865553581
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:27:05 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d1ef70d6a02so1379698276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083624; x=1691688424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=520TPAR42nWNvH3iwlw29nIZA75JEpTNGHc6Ua8ufv4=;
        b=3B64s3BVubEniqIBf5qTeAuU3p0nbnmnuBYsB+RpN6AZa3i3GGRn+/I8B0TAlv2Nks
         vcgJasJ0d6hq72DZeM0Lcm55BQ6bd/hb6ifugNbYwHXuziylKqPLbEduqiIbOnQiwIfT
         g0u3Le+LiGigCWodBqgYIs5hzDhaFXFQSJpVsN0EpnORpmgSB4VWx1SGQLrVpR398SXM
         jj5YOFr/dtJESoBiTGX4JBxqkjM8c4oYCcIgTjq3iohH0dJbfezpHUzECnQsmKYwCHk1
         6xSsPFv1N8/zqJ0kI7aEpFrdp9jeZJ3j7FBpEWsso+eK/G/Snk1NGW/K3h+S2znshr9F
         Fcxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083624; x=1691688424;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=520TPAR42nWNvH3iwlw29nIZA75JEpTNGHc6Ua8ufv4=;
        b=K4GxG+pt1uk5sO2tRgDj6xoHbQ6UvJK2OwfU1XA3WeSKtDcwmBw0+9ao53pHMFityD
         Jxlk/fXabmr8pLy3CwD1meXBSXbxfj5lO9DJBKjY7uAbNXbeESoSrqk8lrvm52CltalI
         bvm5I5QiMhjD5yum6wSCLIfshRZzCXJuqVBIXn2oIe/YmJX3vf1Kowqgubt/I+eYVQKQ
         b7AivNEiBdOIV22w2P/jpCj+J9N23DpOVo4tj0ZLZ+dDRvR0SddJ/w3ylGNCvmWVpnlF
         /yOzJpulQFbhtHau3q6/3XnvudE+ssBoc5JcbWk4ZSkkIapwaRDDJgADagaTRw5P7jFR
         PjMw==
X-Gm-Message-State: ABy/qLZt7K5OqYkO/iRI9MENgtW3b6aUsgRIBWyjRSu/mtcDsoT4ptCm
        8Y1V7YQ2PCRHCQft7v4YgsAsSYx5uA8=
X-Google-Smtp-Source: APBJJlERLM1xcqSCyBewM6WMczSZdvf6/mfoOsnnM0je8oG7l6a+OZ1VwOuI0MHYyPuiy7m+zNnSmK0xJcM=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a25:250a:0:b0:d0a:86fc:536c with SMTP id
 l10-20020a25250a000000b00d0a86fc536cmr131344ybl.2.1691083624748; Thu, 03 Aug
 2023 10:27:04 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:49 -0700
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
Mime-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-5-surenb@google.com>
Subject: [PATCH v3 4/6] mm: lock vma explicitly before doing vm_flags_reset
 and vm_flags_reset_once
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implicit vma locking inside vm_flags_reset() and vm_flags_reset_once() is
not obvious and makes it hard to understand where vma locking is happening.
Also in some cases (like in dup_userfaultfd()) vma should be locked earlier
than vma_flags modification. To make locking more visible, change these
functions to assert that the vma write lock is taken and explicitly lock
the vma beforehand. Fix userfaultfd functions which should lock the vma
earlier.

Suggested-by: Linus Torvalds <torvalds@linuxfoundation.org>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 arch/powerpc/kvm/book3s_hv_uvmem.c |  1 +
 fs/userfaultfd.c                   |  6 ++++++
 include/linux/mm.h                 | 10 +++++++---
 mm/madvise.c                       |  5 ++---
 mm/mlock.c                         |  3 ++-
 mm/mprotect.c                      |  1 +
 6 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 709ebd578394..e2d6f9327f77 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -410,6 +410,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 			ret = H_STATE;
 			break;
 		}
+		vma_start_write(vma);
 		/* Copy vm_flags to avoid partial modifications in ksm_madvise */
 		vm_flags = vma->vm_flags;
 		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 7cecd49e078b..6cde95533dcd 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -667,6 +667,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 		mmap_write_lock(mm);
 		for_each_vma(vmi, vma) {
 			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
+				vma_start_write(vma);
 				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 				userfaultfd_set_vm_flags(vma,
 							 vma->vm_flags & ~__VM_UFFD_FLAGS);
@@ -702,6 +703,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 
 	octx = vma->vm_userfaultfd_ctx.ctx;
 	if (!octx || !(octx->features & UFFD_FEATURE_EVENT_FORK)) {
+		vma_start_write(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
 		return 0;
@@ -783,6 +785,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		atomic_inc(&ctx->mmap_changing);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
+		vma_start_write(vma);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
 	}
@@ -940,6 +943,7 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 			prev = vma;
 		}
 
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 	}
@@ -1502,6 +1506,7 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx.ctx = ctx;
 
@@ -1685,6 +1690,7 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 		 * the next vma was merged into the current one and
 		 * the current one has not been updated yet.
 		 */
+		vma_start_write(vma);
 		userfaultfd_set_vm_flags(vma, new_flags);
 		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
 
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 262b5f44101d..2c720c9bb1ae 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -780,18 +780,22 @@ static inline void vm_flags_init(struct vm_area_struct *vma,
 	ACCESS_PRIVATE(vma, __vm_flags) = flags;
 }
 
-/* Use when VMA is part of the VMA tree and modifications need coordination */
+/*
+ * Use when VMA is part of the VMA tree and modifications need coordination
+ * Note: vm_flags_reset and vm_flags_reset_once do not lock the vma and
+ * it should be locked explicitly beforehand.
+ */
 static inline void vm_flags_reset(struct vm_area_struct *vma,
 				  vm_flags_t flags)
 {
-	vma_start_write(vma);
+	vma_assert_write_locked(vma);
 	vm_flags_init(vma, flags);
 }
 
 static inline void vm_flags_reset_once(struct vm_area_struct *vma,
 				       vm_flags_t flags)
 {
-	vma_start_write(vma);
+	vma_assert_write_locked(vma);
 	WRITE_ONCE(ACCESS_PRIVATE(vma, __vm_flags), flags);
 }
 
diff --git a/mm/madvise.c b/mm/madvise.c
index bfe0e06427bd..507b1d299fec 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -173,9 +173,8 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	}
 
 success:
-	/*
-	 * vm_flags is protected by the mmap_lock held in write mode.
-	 */
+	/* vm_flags is protected by the mmap_lock held in write mode. */
+	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
 	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
 		error = replace_anon_vma_name(vma, anon_name);
diff --git a/mm/mlock.c b/mm/mlock.c
index 479e09d0994c..06bdfab83b58 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -387,6 +387,7 @@ static void mlock_vma_pages_range(struct vm_area_struct *vma,
 	 */
 	if (newflags & VM_LOCKED)
 		newflags |= VM_IO;
+	vma_start_write(vma);
 	vm_flags_reset_once(vma, newflags);
 
 	lru_add_drain();
@@ -461,9 +462,9 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	 * It's okay if try_to_unmap_one unmaps a page just after we
 	 * set VM_LOCKED, populate_vma_page_range will bring it back.
 	 */
-
 	if ((newflags & VM_LOCKED) && (oldflags & VM_LOCKED)) {
 		/* No work to do, and mlocking twice would be wrong */
+		vma_start_write(vma);
 		vm_flags_reset(vma, newflags);
 	} else {
 		mlock_vma_pages_range(vma, start, end, newflags);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 3aef1340533a..362e190a8f81 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -657,6 +657,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 	 * vm_flags and vm_page_prot are protected by the mmap_lock
 	 * held in write mode.
 	 */
+	vma_start_write(vma);
 	vm_flags_reset(vma, newflags);
 	if (vma_wants_manual_pte_write_upgrade(vma))
 		mm_cp_flags |= MM_CP_TRY_CHANGE_WRITABLE;
-- 
2.41.0.585.gd2178a4bd4-goog

