Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF1975B813
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjGTTez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjGTTev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:34:51 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C147026AB
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:34:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-521db0bb0e8so2806a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689881684; x=1690486484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=t32Deh0rq1ive9pTh7+v9bOa6uVnCR209D3Ju5e1XgA=;
        b=th0hsoe8iAVfUQpoHROmt10fhpl4jBCsJhrVBKS1gSyCfcM9WdbyDtBevXnASCiXLZ
         /5gGvHfA3Ly1z4ShyZNYI6Ouineppw63pczjip6MfLVuuwHYgkL0kRoOvBZtGR+HU+9q
         lwjGA5WGrltSoNwL++z3wDvNYxxtQ103MVoXWK3270l+X0wJamiZ0ex+3ta+zbz6Itp0
         IZLPLocq/lHtU2y6aRUNawA6J3tjhrQP/W4JtdN1rfjtmvEWrBrdxyGYQ7vFsWF27IOV
         3L6g9yU7Vse8qeHAsFjCESR10hy782RK7M567CrQ2eduKKro7rp+QhIzT19cwJgY7rLL
         Qavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689881684; x=1690486484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t32Deh0rq1ive9pTh7+v9bOa6uVnCR209D3Ju5e1XgA=;
        b=jdD9HMmHSweEtc0UACEY5Wo9B0bNFbGrqlubiJZDQ363+HmLdM8UN0P72a0SFRPUvH
         f33Ie/RUqbCw2CJEOUj22ZIx8+dVfBaLASTNUDusJeVoClj0w0YuRVLojMYgXnMOgorX
         HutQIDpo0RKs801A4UF8Cosir0mKXJRBU2i/l8Y9sGB5xQAlXl/oOTeBTQGkaM1HtA0W
         NRXWPK8S9uBSx+waH4EjjQsQYZR/LDL7/tUV34MqtOpKthrahSAVGPFmS63Rt7qxNDOf
         x4oNLSw06ZaV1oyX8dz9ohBRAqzY6S2JCBtOJ5DakFQqtUNpnrrO+K7v1hDemLoD291j
         M9Jg==
X-Gm-Message-State: ABy/qLaP9oInzoXPRZBU5PCpclbfM1maMWhv9V2VMQU8a5fgkKyU/5b5
        tVraM2gVvJSzefB2qytC1d0hvWtAluKfKlRFmoho9g==
X-Google-Smtp-Source: APBJJlEUI0k7zCtePQO9GpQLmLYNX6ZSbQuzDmKpGLap3hFDkG6Np3m+JsOlNPqAXd/RvLATa1bjAA==
X-Received: by 2002:a50:99d7:0:b0:50b:c48c:8a25 with SMTP id n23-20020a5099d7000000b0050bc48c8a25mr17186edb.6.1689881684072;
        Thu, 20 Jul 2023 12:34:44 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5f41:554c:a4f4:69d])
        by smtp.gmail.com with ESMTPSA id 12-20020a05600c020c00b003fc16ee2864sm1815609wmi.48.2023.07.20.12.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:34:43 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] mm: Don't drop VMA locks in mm_drop_all_locks()
Date:   Thu, 20 Jul 2023 21:34:36 +0200
Message-ID: <20230720193436.454247-1-jannh@google.com>
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

Despite its name, mm_drop_all_locks() does not drop _all_ locks; the mmap
lock is held write-locked by the caller, and the caller is responsible for
dropping the mmap lock at a later point (which will also release the VMA
locks).
Calling vma_end_write_all() here is dangerous because the caller might have
write-locked a VMA with the expectation that it will stay write-locked
until the mmap_lock is released, as usual.

This _almost_ becomes a problem in the following scenario:

An anonymous VMA A and an SGX VMA B are mapped adjacent to each other.
Userspace calls munmap() on a range starting at the start address of A and
ending in the middle of B.

Hypothetical call graph with additional notes in brackets:

do_vmi_align_munmap
  [begin first for_each_vma_range loop]
  vma_start_write [on VMA A]
  vma_mark_detached [on VMA A]
  __split_vma [on VMA B]
    sgx_vma_open [== new->vm_ops->open]
      sgx_encl_mm_add
        __mmu_notifier_register [luckily THIS CAN'T ACTUALLY HAPPEN]
          mm_take_all_locks
          mm_drop_all_locks
            vma_end_write_all [drops VMA lock taken on VMA A before]
  vma_start_write [on VMA B]
  vma_mark_detached [on VMA B]
  [end first for_each_vma_range loop]
  vma_iter_clear_gfp [removes VMAs from maple tree]
  mmap_write_downgrade
  unmap_region
  mmap_read_unlock

In this hypothetical scenario, while do_vmi_align_munmap() thinks it still
holds a VMA write lock on VMA A, the VMA write lock has actually been
invalidated inside __split_vma().

The call from sgx_encl_mm_add() to __mmu_notifier_register() can't
actually happen here, as far as I understand, because we are duplicating an
existing SGX VMA, but sgx_encl_mm_add() only calls
__mmu_notifier_register() for the first SGX VMA created in a given process.
So this could only happen in fork(), not on munmap().
But in my view it is just pure luck that this can't happen.

Also, we wouldn't actually have any bad consequences from this in
do_vmi_align_munmap(), because by the time the bug drops the lock on VMA A,
we've already marked VMA A as detached, which makes it completely
ineligible for any VMA-locked page faults.
But again, that's just pure luck.

So remove the vma_end_write_all(), so that VMA write locks are only ever
released on mmap_write_unlock() or mmap_write_downgrade().

Also add comments to document the locking rules established by this
patch.

Fixes: eeff9a5d47f8 ("mm/mmap: prevent pagefault handler from racing with mmu_notifier registration")
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
v2:
 - add comments (Suren)

 include/linux/mm.h        | 5 +++++
 include/linux/mmap_lock.h | 8 ++++++++
 mm/mmap.c                 | 7 ++++++-
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 2dd73e4f3d8e..20b1fe17cccf 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -680,6 +680,11 @@ static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lock_seq)
 	return (vma->vm_lock_seq == *mm_lock_seq);
 }
 
+/*
+ * Begin writing to a VMA.
+ * Exclude concurrent readers under the per-VMA lock until the currently
+ * write-locked mmap_lock is dropped or downgraded.
+ */
 static inline void vma_start_write(struct vm_area_struct *vma)
 {
 	int mm_lock_seq;
diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
index aab8f1b28d26..0b1d8430a638 100644
--- a/include/linux/mmap_lock.h
+++ b/include/linux/mmap_lock.h
@@ -73,6 +73,14 @@ static inline void mmap_assert_write_locked(struct mm_struct *mm)
 }
 
 #ifdef CONFIG_PER_VMA_LOCK
+/*
+ * Drop all currently-held per-VMA locks.
+ * This is called from the mmap_lock implementation directly before releasing
+ * a write-locked mmap_lock (or downgrading it to read-locked).
+ * This should normally NOT be called manually from other places.
+ * If you want to call this manually anyway, keep in mind that this will release
+ * *all* VMA write locks, including ones from further up the stack.
+ */
 static inline void vma_end_write_all(struct mm_struct *mm)
 {
 	mmap_assert_write_locked(mm);
diff --git a/mm/mmap.c b/mm/mmap.c
index 3eda23c9ebe7..3dc509fb2102 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3662,6 +3662,12 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 	mutex_lock(&mm_all_locks_mutex);
 
+	/*
+	 * vma_start_write() does not have a complement in mm_drop_all_locks()
+	 * because vma_start_write() is always asymmetrical; it marks a VMA as
+	 * being written to until mmap_write_unlock() or mmap_write_downgrade()
+	 * is reached.
+	 */
 	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (signal_pending(current))
 			goto out_unlock;
@@ -3758,7 +3764,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
-	vma_end_write_all(mm);
 
 	mutex_unlock(&mm_all_locks_mutex);
 }

base-commit: bfa3037d828050896ae52f6467b6ca2489ae6fb1
-- 
2.41.0.487.g6d72f3e995-goog

