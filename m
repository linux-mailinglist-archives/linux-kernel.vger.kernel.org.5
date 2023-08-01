Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D852476C013
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 00:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjHAWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbjHAWHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 18:07:37 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50FA19B7
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 15:07:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c926075a50cso502679276.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Aug 2023 15:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690927656; x=1691532456;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zPqUPKbdP+iIzl/rUw5yUEFwwtlQE8s7qBJDuJeMKGo=;
        b=q+9OzccPgu9rBNj9tTxxF496DJEUfuPzUq4NJySwfPgbdDOoCMU555Hl/qdgpDWovQ
         7P3zZ2+VclqiHfT8jA4l3nOEOoF0zeP3xfx+eBZo8NuKWI2ZlGst5RVijFL/SYmXNX/c
         EBGSWByJHdwURfZYTxEjjL+Gk5CcvbvFODRPLV4eb+3Hdcu6jAz1S/kBv/TmRram3Lho
         5D6Ft49iUVjSDYwIZScsTg7jzmD27EWtWIFAjuv16Hq0nXtyiO4YzEP8YH3AjuH1xlwu
         TugHF9nnoRBAvRJEC95ny2FaSbtI6beld/hDOO7xdUTap77spYX6TCXHiNvth+9pWjuR
         OyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690927656; x=1691532456;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zPqUPKbdP+iIzl/rUw5yUEFwwtlQE8s7qBJDuJeMKGo=;
        b=JolMiHcGT4dP5lUvQJ3VQK4oXhXGFCq158mByVLcil1mEZLY/Zmo837VOpqV+u3xMD
         A178+1jPdWtfTK1q6CoB3TkcxasBU2HMsnCvk8XGt0ecFWbFrXDB9wknTX4tfzwYlVhW
         HQBJIZjOEiu4e8D7RV0aXtQl3QRsIqSBJWWguWEhxHr6n05H04TlCmModwyAZesHk9b5
         i9DLwukwf2hYztkWpy2bv1jWwpYtLh/FPym0ruUG6jXwSrFSZberp9B5oF9jGw9qbc/I
         HoX9/HvNnIOTiI7QfeteY2E+7x+St9XX+3jvnuNPTdq2dOQQ6W4DoDsB10NV8Q2y5SCh
         P3fw==
X-Gm-Message-State: ABy/qLat22i58jDLXSY5agr7nyudeJB4VNe1GqbKJJvTeWgasZYl68JY
        PdztMpsN9+2siBHpIkoSTGIU5CXoRtY=
X-Google-Smtp-Source: APBJJlH688tL11JqgwaFAglSA8dGEv9/GHDNslVjpwq0rCCbRaezorHBoZHbvJTwlN1g7j/8quBF3BFvjSU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:211c:a2ff:f17b:c5e9])
 (user=surenb job=sendgmr) by 2002:a05:6902:11cb:b0:d16:7ccc:b406 with SMTP id
 n11-20020a05690211cb00b00d167cccb406mr160911ybu.5.1690927655996; Tue, 01 Aug
 2023 15:07:35 -0700 (PDT)
Date:   Tue,  1 Aug 2023 15:07:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230801220733.1987762-1-surenb@google.com>
Subject: [PATCH v2 0/6] make vma locking more obvious
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>
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

During recent vma locking patch reviews Linus and Jann Horn noted a number
of issues with vma locking and suggested improvements:

1. walk_page_range() does not have ability to write-lock a vma during the
walk when it's done under mmap_write_lock. For example s390_reset_cmma().

2. Vma locking is hidden inside vm_flags modifiers and is hard to follow.
Suggestion is to change vm_flags_reset{_once} to assert that vma is
write-locked and require an explicit locking.

3. Same issue with vma_prepare() hiding vma locking.

4. In userfaultfd vm_flags are modified after vma->vm_userfaultfd_ctx and
page faults can operate on a context while it's changed.

5. do_brk_flags() and __install_special_mapping() not locking a newly
created vma before adding it into the mm. While not strictly a problem,
this is fragile if vma is modified after insertion, as in the
mmap_region() case which was recently fixed. Suggestion is to always lock
a new vma before inserting it and making it visible to page faults.

6. vma_assert_write_locked() for CONFIG_PER_VMA_LOCK=n would benefit from
being mmap_assert_write_locked() instead of no-op and then any place which
operates on a vma and calls mmap_assert_write_locked() can be converted
into vma_assert_write_locked().

I CC'ed stable only on the first patch because others are cleanups and the
bug in userfaultfd does not affect stable (lock_vma_under_rcu prevents
uffds from being handled under vma lock protection). However I would be
happy if the whole series is merged into stable 6.4 since it makes vma
locking more maintainable.

The patches apply cleanly over Linus' ToT and will conflict when applied
over mm-unstable due to missing [1]. The conflict can be easily resolved
by ignoring conflicting deletions but probably simpler to take [1] into
mm-unstable and avoid later conflict.

[1] commit 6c21e066f925 ("mm/mempolicy: Take VMA lock before replacing policy")

Changes since v1:
- replace walk_page_range() parameter with mm_walk_ops.walk_lock,
per Linus
- introduced page_walk_lock enum to allow different locking modes
during a walk, per Linus
- added Liam's Reviewed-by

Suren Baghdasaryan (6):
  mm: enable page walking API to lock vmas during the walk
  mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and
    mmap
  mm: replace mmap with vma write lock assertions when operating on a
    vma
  mm: lock vma explicitly before doing vm_flags_reset and
    vm_flags_reset_once
  mm: always lock new vma before inserting into vma tree
  mm: move vma locking out of vma_prepare

 arch/powerpc/kvm/book3s_hv_uvmem.c      |  1 +
 arch/powerpc/mm/book3s64/subpage_prot.c |  1 +
 arch/riscv/mm/pageattr.c                |  1 +
 arch/s390/mm/gmap.c                     |  5 ++++
 drivers/infiniband/hw/hfi1/file_ops.c   |  1 +
 fs/proc/task_mmu.c                      |  5 ++++
 fs/userfaultfd.c                        |  6 +++++
 include/linux/mm.h                      | 13 ++++++---
 include/linux/pagewalk.h                | 11 ++++++++
 mm/damon/vaddr.c                        |  2 ++
 mm/hmm.c                                |  1 +
 mm/hugetlb.c                            |  2 +-
 mm/khugepaged.c                         |  5 ++--
 mm/ksm.c                                | 25 ++++++++++-------
 mm/madvise.c                            |  8 +++---
 mm/memcontrol.c                         |  2 ++
 mm/memory-failure.c                     |  1 +
 mm/memory.c                             |  2 +-
 mm/mempolicy.c                          | 22 +++++++++------
 mm/migrate_device.c                     |  1 +
 mm/mincore.c                            |  1 +
 mm/mlock.c                              |  4 ++-
 mm/mmap.c                               | 29 +++++++++++++-------
 mm/mprotect.c                           |  2 ++
 mm/pagewalk.c                           | 36 ++++++++++++++++++++++---
 mm/vmscan.c                             |  1 +
 26 files changed, 146 insertions(+), 42 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog

