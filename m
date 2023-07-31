Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36D769F1D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbjGaRPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbjGaRPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:15:10 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEEB26B8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:37 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c647150c254so8699632276.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690823557; x=1691428357;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=c3PYDZ1RN/B3pu1J25lpMbrKPoFg0ktyB6SwecJ4DzU=;
        b=6FV+nnfj59v0O8qa3GSfbEYQhq8YmdgJWLU8iPRuV+6j61UppVaAn5rOGOl+8YHMdt
         5zb59tU4zOXjjNhOid4WniiNCPgSltUe6NgoO/pX6+qFqRqYlePiUlahDQXFWxHbwf7U
         5JRbk/t2axk1kdap2kYPs2NLmGWi6QwrywA09T4kw5cif/b+/jnjeTHz4ALKCCdCRMun
         OfBd07Zdyr5thNsiyTKJzJGNXUd12BPg0pSFSz+ZdMgFAejegH2kK9khBYiJ5O2FuNPa
         X7b6E6HKN6OD8odj1FJxZrLHyXxOw3Yun7LkiSKkR3ofC+PTL6zZ8gYhvyXgVUdmB4tx
         AR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690823557; x=1691428357;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c3PYDZ1RN/B3pu1J25lpMbrKPoFg0ktyB6SwecJ4DzU=;
        b=U1Uy3EmJKTkogTo1Timi6hIOI3Y7XpQtQbI7OQdsnXFEyHkBffUSYf6HrtiB22iLS3
         r8RHiQExorgLOy7zr/QUu7GWpgPx6TQqnYEKxPcooKZ189Kt/9pPULLcJaU9WwL0XzrV
         ILa9ICZ8t+UCpxYTcmgQ6hK7HXZLNDvUe8SjEdw+08u4usIDY8YVHA02kYN1Iouz2Xvz
         awKLRnWOgrhxFXvhDlPVFKXcfEO+RCuYgZEFF1Hu7Q+h1KNGAr2OI+oT6/HJyJwtU3bQ
         4MdTY2fpIgEYpP8q8T7JQnVSVWT/Lp/Z1hy3fglviFECScAWQkJuEMrSZcWTBFZ7l+gV
         Ks6g==
X-Gm-Message-State: ABy/qLZ9Bfurr+t2pkNW7d9CQnmuDjSCLs0vKM4As5sA5W4i3qDUIf7S
        lFf4mHepF9n8K/KrrrFIt8FpiW8aNf8=
X-Google-Smtp-Source: APBJJlEKfgHW3Pt+D+HW+X08sGkNnzE7rrwZeKVkKbn6HinHN7XInD85rNYlUT2BXDYNkx/+RNlDUje3uTI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:d4d3:7e41:cb80:21ea])
 (user=surenb job=sendgmr) by 2002:a25:305:0:b0:d0c:44d5:4530 with SMTP id
 5-20020a250305000000b00d0c44d54530mr115944ybd.3.1690823556992; Mon, 31 Jul
 2023 10:12:36 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:12:26 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.487.g6d72f3e995-goog
Message-ID: <20230731171233.1098105-1-surenb@google.com>
Subject: [PATCH 0/6] make vma locking more obvious
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 arch/powerpc/mm/book3s64/subpage_prot.c |  2 +-
 arch/riscv/mm/pageattr.c                |  4 ++--
 arch/s390/mm/gmap.c                     | 10 ++++-----
 drivers/infiniband/hw/hfi1/file_ops.c   |  1 +
 fs/proc/task_mmu.c                      | 10 ++++-----
 fs/userfaultfd.c                        |  6 +++++
 include/linux/mm.h                      | 13 +++++++----
 include/linux/pagewalk.h                |  6 ++---
 mm/damon/vaddr.c                        |  4 ++--
 mm/hmm.c                                |  2 +-
 mm/hugetlb.c                            |  2 +-
 mm/khugepaged.c                         |  5 +++--
 mm/ksm.c                                | 16 +++++++-------
 mm/madvise.c                            | 13 +++++------
 mm/memcontrol.c                         |  4 ++--
 mm/memory-failure.c                     |  2 +-
 mm/memory.c                             |  2 +-
 mm/mempolicy.c                          | 12 ++++------
 mm/migrate_device.c                     |  2 +-
 mm/mincore.c                            |  2 +-
 mm/mlock.c                              |  5 +++--
 mm/mmap.c                               | 29 ++++++++++++++++---------
 mm/mprotect.c                           |  3 ++-
 mm/pagewalk.c                           | 13 ++++++++---
 mm/vmscan.c                             |  3 ++-
 26 files changed, 100 insertions(+), 72 deletions(-)

-- 
2.41.0.487.g6d72f3e995-goog

