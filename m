Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD2676F094
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234648AbjHCR1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232007AbjHCR05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:26:57 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9247030C0
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:26:56 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d1851c52f3dso1293607276.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083615; x=1691688415;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cZ2Sq6VO6+Afhr0Ggao6dyfVObiTvoIor2VOxBVDNUQ=;
        b=cPa0RPACNVX2ZeSvOhETX/ApTMwoNjLDFtBMJdLBKbqOKgAAEKVJMkmX1+OQ7m8oiI
         nRP9dxXeihwf7k+zwxVZYSLnzRl/3JxkUUNRlD6Gvn/x7J2A7e3AY9bMxKGHDUnYEq5N
         o8EuuDVdrIS8TSLSQiSFDmCQ6u+OXs1RjNjBxv66OvBImpxNx75I6pIHzHRxbqE1jHx+
         MzseOT8F/Kd8sNYb6fBF3zFP8F62hl44NTK/dGbAFtvvwpjb87wyJa64+nJnDfV6zKYS
         +cd/NndJD0wTB7neqWgh5qF6tawh9ZhwnDWDlfOBAjPlMXZYz+dn+b76zDzzI/KCYrnF
         86Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083615; x=1691688415;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZ2Sq6VO6+Afhr0Ggao6dyfVObiTvoIor2VOxBVDNUQ=;
        b=PQNY3FIaCpYVqyaSCET7kNJFeXarSgrHYASZOSFOkWhlvL5ka73l2TeW63v5nfMdEf
         pH1cbAZJo2YUdSUSmY1JTrrOT5kS6NnbLkFx4VZq3K/FcKaDEFGYEBPeH4uRvvkecetu
         zy4MUA6Y5lCIN8HU3BquhPipSuaS/napaMS6ijmLbVVpC//mZH9JytQAgl9ydJzVumn8
         bH+qG3+6TLzmx0P1m0Bl2+9mpizSacIs04jp1JtioJ9JCMNQFRS/b1WDRFwdSwfeNjB5
         YwMvAqAZEN7JYlJkYjE5F0a+L4D/N1dMaK/yJmqVMonN47lH8d2DZ1wBZwjbEeu1xL2R
         iP+Q==
X-Gm-Message-State: ABy/qLZyM7b5W3gJaG430rZrGtY7onNE7peaIPwh6IFcOoRTjqIH6xz6
        rjkOFQ5KuU32LRsZgXOrFceTyoZRnps=
X-Google-Smtp-Source: APBJJlHkaDlFGikr7jzCQXoOIxsLN4xYUczw/VwZSwj+TSdWsNmAHDKAVdQ/qIeXeWYgtRctJkUUMzW4e8E=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:3dec:ef9e:7bf4:7a6])
 (user=surenb job=sendgmr) by 2002:a05:6902:100f:b0:cf9:3564:33cc with SMTP id
 w15-20020a056902100f00b00cf9356433ccmr181148ybt.13.1691083615709; Thu, 03 Aug
 2023 10:26:55 -0700 (PDT)
Date:   Thu,  3 Aug 2023 10:26:45 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230803172652.2849981-1-surenb@google.com>
Subject: [PATCH v3 0/6] make vma locking more obvious
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

Changes since v2:
- removed vma locking from hfi1_file_mmap(), per Linus
- moved vma locking out of dup_anon_vma(), per Liam
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
  mm: move vma locking out of vma_prepare and dup_anon_vma

 arch/powerpc/kvm/book3s_hv_uvmem.c      |  1 +
 arch/powerpc/mm/book3s64/subpage_prot.c |  1 +
 arch/riscv/mm/pageattr.c                |  1 +
 arch/s390/mm/gmap.c                     |  5 ++++
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
 mm/mmap.c                               | 32 ++++++++++++++--------
 mm/mprotect.c                           |  2 ++
 mm/pagewalk.c                           | 36 ++++++++++++++++++++++---
 mm/vmscan.c                             |  1 +
 25 files changed, 147 insertions(+), 43 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog

