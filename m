Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB43475A3FE
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 03:33:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjGTBdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 21:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbjGTBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 21:33:21 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2F8F269F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:33:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fc075d9994so40405e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 18:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689816784; x=1690421584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=axi8/ydXGpVdXXhaXsUkDkCMMEYa0OL+dOx0IDR8aaE=;
        b=WXjrMbr9atquLfOw+cjpQSkzNcjeB8WcdPo7aPf/kY5i5sKJkjlYf9saHwOWOiMmp9
         d1lPJf7sKH1qXAQe5SvE7AzwVa9EKBIB7d8a6b/h+2znx182BUQV+XrCbeQukmVZWAGG
         EK+ngylAIFNJKreIW8IXx3skMmCKmQ/BsesYnF5Gf+6AIran2pP58gigVzi7UJ0ZyWY9
         56mzVIg8dVxIxYxRaFO8+6VmNcDPZmjgDmbnGPhruQ7QW0gfRTRnhJ8wtGc3UXmJMPP7
         g+aGIt/gNTJFGDVNRTs7KTVm6MZ0wyn6JgtV4eGg/b6EBhpbkNju1t3sz59OHAqB3nmF
         SNpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689816784; x=1690421584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axi8/ydXGpVdXXhaXsUkDkCMMEYa0OL+dOx0IDR8aaE=;
        b=YRPoIy8yAbCI1yLWpRyKsuAg8QXMaVO2rQCoFtKQzuhCF2lPOjWZ6SCjZ11nkiUHRd
         rzK9oofFzkj7BfM/O1XexbhBa2vC0GS/DD6M4rBuKClif5/VMdV1tAyIatxmx0rq4yhc
         DsJWCHrktSffOzXpF6HKBIVp/taKAKHuKeKlhvZQkVPFq5GeP2gLu5LRdTIE7dMV/lft
         KoLeBjVaxOeujfSWXvA5jzhAyfi5zFzDzQ9oYPTly0IXMoviu6EAxN3ymw4SoEXLOmOV
         3ENKpBzZ+SJepSMvn9rsdogu9XuhmqwGCDKf/FIqyD4Stfb1uQP1JA3EbTFdoT57mI42
         xuhA==
X-Gm-Message-State: ABy/qLZjm+8oKcZDWOxK+zlwv1MhjvDRdZ2DjpheyFe8KV+ux+HBwGQX
        Pbra6Wykp50x6id93W9c/lF1lA==
X-Google-Smtp-Source: APBJJlFAX20Favw69oaawKb8T42JtB/oQ/U0QzgvZR+zGnkhN/R/v8l4DvPE15vHFI6zzTYVkUHMjw==
X-Received: by 2002:a05:600c:3d95:b0:3f7:3e85:36a with SMTP id bi21-20020a05600c3d9500b003f73e85036amr32366wmb.7.1689816784258;
        Wed, 19 Jul 2023 18:33:04 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:5d60:25da:5b42:67a3])
        by smtp.gmail.com with ESMTPSA id c7-20020adfe747000000b003143c9beeaesm6625099wrn.44.2023.07.19.18.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 18:33:03 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: Don't drop VMA locks in mm_drop_all_locks()
Date:   Thu, 20 Jul 2023 03:32:49 +0200
Message-ID: <20230720013249.199981-1-jannh@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
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

Fixes: eeff9a5d47f8 ("mm/mmap: prevent pagefault handler from racing with mmu_notifier registration")
Cc: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
 mm/mmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 3eda23c9ebe7..1ff354b1e23c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3758,7 +3758,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
 		if (vma->vm_file && vma->vm_file->f_mapping)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
-	vma_end_write_all(mm);
 
 	mutex_unlock(&mm_all_locks_mutex);
 }

base-commit: bfa3037d828050896ae52f6467b6ca2489ae6fb1
-- 
2.41.0.255.g8b1d071c50-goog

