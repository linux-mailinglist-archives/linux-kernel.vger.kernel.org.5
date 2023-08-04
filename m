Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4C770492
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbjHDP2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbjHDP1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:27:50 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3BDA5269
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:27:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d455e15476eso439086276.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691162848; x=1691767648;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aKhfr50CytyPbKf+4uDwSSo7M3ThccfnnQRTLUrmmdg=;
        b=rl5bqp6tQA+TvGmYH1sXrLGzVDzye+UxvtNuwcEIDmzJGGlknWXhoFyPeEQGbc4XD+
         7fM9lJOnJSiZSATLTJv3lekc5ku8HZo/nf4jfPtN3Fe5WBitNR8zGCbswnEaYIUzD+7O
         Un4sHHA5u0qnfGbDg3ILOXQ9MXQFmEoBp9lKyPtUgd0i3DALjgoR4XmoewAydqS8KwlJ
         iTaE4JCJ61Pyd3AwuTgsGPqPMPxOvJvOeVLYm6+ZtoMhi2WJkTS6sYe7btl4ERrgaLlb
         2a/NnBQcYIpOtEOaDknfe4XqbeBloJxtgUbI2ZhlK9wThhAOg4P/sTKROcpLCrp+NoCv
         kLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691162848; x=1691767648;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aKhfr50CytyPbKf+4uDwSSo7M3ThccfnnQRTLUrmmdg=;
        b=FsB65QccfS/p8rMTINtsWnLOuKkejKH6+3wkPzo5z5qCpWF3Ih9TwkHBaFCVpA4jIB
         XeuJ5ZuA4GD1l0ImvICpklg4hdMbGg3Kw0rBZMrPc4hUmwA3pJMaksFYylFVar+PlUJB
         fhnmJ5guAONg7oYMvS5FERACsPpiyMpDwonLPaChxebvV3nPmHrSBqwy0ASULar7RNy0
         SCViGHDeMcb08yy4JA4IGfZw4s6VhGFU0wPq1t8MxCEy/RgNmVuxR6Y1BbGwJB/2zh29
         gwVP6L0GTHHJzvXGWvHkdEMMg94xPFt4bRpVcVEHyBmj0klplGzjKWW7wdCKMkjwZiH+
         LRbA==
X-Gm-Message-State: AOJu0YwhBdL44iKy9D0k8PSnuHpXDXSBpMwt4eDfxicaDyEWPrPG32ur
        q4IxjGY7iL+aSlsKjUVsw8byoO0OO98=
X-Google-Smtp-Source: AGHT+IG4f9A7dcMT8UcSpgTJBpsi+cGM1Bu1NXzOWKN5ONFOXPvmLmwOt9qFc68A9Gb/dy1voP9Rr8Da5Cw=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:43a7:a50f:b0fd:a068])
 (user=surenb job=sendgmr) by 2002:a5b:94d:0:b0:d09:17f2:d3b0 with SMTP id
 x13-20020a5b094d000000b00d0917f2d3b0mr12917ybq.9.1691162848092; Fri, 04 Aug
 2023 08:27:28 -0700 (PDT)
Date:   Fri,  4 Aug 2023 08:27:18 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.585.gd2178a4bd4-goog
Message-ID: <20230804152724.3090321-1-surenb@google.com>
Subject: [PATCH v4 0/6] make vma locking more obvious
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org, kernel-team@android.com,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes since v3:
- changed vma locking in vma_merge to avoid locking prev when not
necessary, per Liam

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
 mm/mmap.c                               | 33 +++++++++++++++--------
 mm/mprotect.c                           |  2 ++
 mm/pagewalk.c                           | 36 ++++++++++++++++++++++---
 mm/vmscan.c                             |  1 +
 25 files changed, 148 insertions(+), 43 deletions(-)

-- 
2.41.0.585.gd2178a4bd4-goog

