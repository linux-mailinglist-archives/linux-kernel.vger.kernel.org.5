Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8E876C01B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjHAWH4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231596AbjHAWHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:07:48 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2ADA1BCF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:07:46 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-585f04ffa3eso55638497b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927666; x=1691532466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RKZo+1hfRepjKtnKDtyG+lpMw+Id83I1mtUQG8twV1g=;
        b=ZFUINCXp69DsytCWVUi4i3FblzMVDA9BptWaaF+sKX0xKEjgkgju+DXhX3HccVVQYK
         XfNP/c2GWyfqQJHV5buiUdSz9eeuWGGs7bmeQuEchsb8OOL3n9wvyCurtr7tkXCQi0aN
         yP++75VtrNJXUbKenp0F1ykufx1TsQbFC4T42Fu0rToUR5fYyKHd1/8JmARUNH7JC7wS
         Lj5lgymUX89V5GFOqGp4x1br6gngtFB+xvWjpzgbM1kSIUiCB0dwywo6Jf8riCeEpuU+
         fuTx3ZM3NBd+NW9LDhz7+Fp9WswDCH8sARSCiBtGMaTHvckO5JPymvcy35BZOGdWDtwz
         dWHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927666; x=1691532466;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RKZo+1hfRepjKtnKDtyG+lpMw+Id83I1mtUQG8twV1g=;
        b=BKDhC/bd25f1jorevOrANrKmuVA2c3KRfTim2Mzq5Hd90gCf2AjFRHr12M2IBTYTP8
         hHd+EmRP6trCj1GDEMSLXkKg85h+FqBRvRvnDOeOD5RcdBtbp2ry4b+Iv34B5ODXKc/L
         zmMEsp4ljT5cmWoh15NPGJm5uPpbJFWLc/TpjG8w1sAu3GKlglKob7JdKnT/NTKtG6xT
         gl2oTXsSwYjXvb/ANGsjFjAC/bdnVaZsQlQ/SuLmYCcdW2J5yxXJVbiay08VJ7/+U+0Y
         uIxcy5RcNVWuPT/vznUxB2oN1s8XSLjij/HD/U4hLCiM3aNtU11SUCAbHFHfS0RiUoyB
         J0ug==
X-Gm-Message-State: ABy/qLZ4lKuH6l7iHm0PMsDhtkypc+oFa23K4jnbetk6pou410w+1oys
        VwOZOZJ6UrWu79jJYM1cLT3eZLcHy9Q=
X-Google-Smtp-Source: APBJJlEVrG0ZaZS1XJkKCyoFSCws8IlmHUWrBIIEhqF/1GbPoPNJFMVdqT5uK6xuibwesECoWBa2n5oiBr4=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a81:b104:0:b0:583:9913:f293 with SMTP id
 p4-20020a81b104000000b005839913f293mr116951ywh.1.1690927666209; Tue, 01 Aug
 2023 15:07:46 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:30 -0700
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
Mime-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-5-surenb@google.com>
Subject: [PATCH v2 4/6] mm: lock vma explicitly before doing vm_flags_reset
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
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
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
 arch/powerpc/kvm/book3s_hv_uvmem.c    |  1 +
 drivers/infiniband/hw/hfi1/file_ops.c |  1 +
 fs/userfaultfd.c                      |  6 ++++++
 include/linux/mm.h                    | 10 +++++++---
 mm/madvise.c                          |  5 ++---
 mm/mlock.c                            |  3 ++-
 mm/mprotect.c                         |  1 +
 7 files changed, 20 insertions(+), 7 deletions(-)

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
diff --git a/drivers/infiniband/hw/hfi1/file_ops.c b/drivers/infiniband/hw/hfi1/file_ops.c
index a5ab22cedd41..5920bfc1e1c5 100644
--- a/drivers/infiniband/hw/hfi1/file_ops.c
+++ b/drivers/infiniband/hw/hfi1/file_ops.c
@@ -344,6 +344,7 @@ static int hfi1_file_mmap(struct file *fp, struct vm_area_struct *vma)
 		goto done;
 	}
 
+	vma_start_write(vma);
 	/*
 	 * vm_pgoff is used as a buffer selector cookie.  Always mmap from
 	 * the beginning.
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

