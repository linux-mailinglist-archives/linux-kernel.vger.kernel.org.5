Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C862576F0A8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 19:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjHCR3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 13:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234734AbjHCR3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 13:29:13 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038AD44A4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 10:28:47 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-c5ffb6cda23so1381232276.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 10:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691083726; x=1691688526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFcyQ1gcNX+fOmKbC9Gh83QONnit8k95E+VA88GAWoM=;
        b=u+XdrAihfGpvID0yROds2wCTMW8NXs5L1vAOwA1j6Evl2I0RyjyMbiahw4g11/DF6S
         P/GoFHSSGbs7DEAbzcxQ7+19M0s+k+7DBioD7PnjXyWbiTNKJTS054tH9O3tGhKp0BgG
         wvK+dhh7Il62fgf21QZcSsGaVqNLAJjenyLNO08gv5TjVACfaB4TUNz6oAe/eQjnZnrr
         Qt+M91gK0s1NiyeYMArnuSFUkCZBZImkTdDd/jfLfhG6qY3IuCVvnE6z0QzGlSqbUvAL
         35Fqzp1FdsayCfcFCi4cDy4/N1ff1C71FwcjOCBdayMsKupZtv/D4jvrsxWoTHEwtDpM
         Knng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691083726; x=1691688526;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFcyQ1gcNX+fOmKbC9Gh83QONnit8k95E+VA88GAWoM=;
        b=ZP2jmmQbMZuqawRDU4ar0f+rlikGTdm2FI/WNpSX+6S7Fr6QkFyyAauGfH/r/4v+5H
         9lFAiFfYAVRJthaT/s5Z9kuxNTMMavm5lTq94rqWYXGKOi5FUSl27Gx+nJfYNh1rZUsk
         IBdsLIJPkHWd6dJmwuj1QKWplAfdbss2N6pufOQLGq5ZnCmoHlxCQ3nAzcAOwAiGJzpz
         GxBqdLkTq5D/YfoXyWEdCQ1eYvHIwx4O/iwtaalPCGVsdzMuKA5D8KTMBAGhEJs3XbDU
         1Fw36obzgbGabs+Lm5aA4M3EOORVLPXT7ofhTn9KL4dsy6mGkZVYT+0nnh/QB7KgwbOs
         1iEQ==
X-Gm-Message-State: ABy/qLbMRxCgK2x91rZcc8JiXy+Iv7w473NFA/LHbCqhrEr2T8jrFo8q
        XnQd8YITbN5hCUyS0270o51k/zU600nzA+akg+qe7g==
X-Google-Smtp-Source: APBJJlH0/4s+VJkKkahHWGlGjtB8xBLjlsvii854DL1sAB7SOFNU6zuSbeBvxcFJ3UFfsm7icMI2KedJ7c38rWwKxBI=
X-Received: by 2002:a25:4114:0:b0:d1f:6886:854a with SMTP id
 o20-20020a254114000000b00d1f6886854amr17351559yba.9.1691083725840; Thu, 03
 Aug 2023 10:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230801220733.1987762-1-surenb@google.com>
In-Reply-To: <20230801220733.1987762-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 3 Aug 2023 10:28:32 -0700
Message-ID: <CAJuCfpEow+uz5tGgV2y=bAAh2tdwjcqv+hUz0Om68usLaw0jsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] make vma locking more obvious
To:     akpm@linux-foundation.org
Cc:     torvalds@linux-foundation.org, jannh@google.com,
        willy@infradead.org, liam.howlett@oracle.com, david@redhat.com,
        peterx@redhat.com, ldufour@linux.ibm.com, vbabka@suse.cz,
        michel@lespinasse.org, jglisse@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, dave@stgolabs.net, hughd@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, Aug 1, 2023 at 3:07=E2=80=AFPM Suren Baghdasaryan <surenb@google.co=
m> wrote:
>
> During recent vma locking patch reviews Linus and Jann Horn noted a numbe=
r
> of issues with vma locking and suggested improvements:
>
> 1. walk_page_range() does not have ability to write-lock a vma during the
> walk when it's done under mmap_write_lock. For example s390_reset_cmma().
>
> 2. Vma locking is hidden inside vm_flags modifiers and is hard to follow.
> Suggestion is to change vm_flags_reset{_once} to assert that vma is
> write-locked and require an explicit locking.
>
> 3. Same issue with vma_prepare() hiding vma locking.
>
> 4. In userfaultfd vm_flags are modified after vma->vm_userfaultfd_ctx and
> page faults can operate on a context while it's changed.
>
> 5. do_brk_flags() and __install_special_mapping() not locking a newly
> created vma before adding it into the mm. While not strictly a problem,
> this is fragile if vma is modified after insertion, as in the
> mmap_region() case which was recently fixed. Suggestion is to always lock
> a new vma before inserting it and making it visible to page faults.
>
> 6. vma_assert_write_locked() for CONFIG_PER_VMA_LOCK=3Dn would benefit fr=
om
> being mmap_assert_write_locked() instead of no-op and then any place whic=
h
> operates on a vma and calls mmap_assert_write_locked() can be converted
> into vma_assert_write_locked().
>
> I CC'ed stable only on the first patch because others are cleanups and th=
e
> bug in userfaultfd does not affect stable (lock_vma_under_rcu prevents
> uffds from being handled under vma lock protection). However I would be
> happy if the whole series is merged into stable 6.4 since it makes vma
> locking more maintainable.
>
> The patches apply cleanly over Linus' ToT and will conflict when applied
> over mm-unstable due to missing [1]. The conflict can be easily resolved
> by ignoring conflicting deletions but probably simpler to take [1] into
> mm-unstable and avoid later conflict.
>
> [1] commit 6c21e066f925 ("mm/mempolicy: Take VMA lock before replacing po=
licy")
>
> Changes since v1:
> - replace walk_page_range() parameter with mm_walk_ops.walk_lock,
> per Linus
> - introduced page_walk_lock enum to allow different locking modes
> during a walk, per Linus
> - added Liam's Reviewed-by

v3 is posted at
https://lore.kernel.org/all/20230803172652.2849981-1-surenb@google.com/

>
> Suren Baghdasaryan (6):
>   mm: enable page walking API to lock vmas during the walk
>   mm: for !CONFIG_PER_VMA_LOCK equate write lock assertion for vma and
>     mmap
>   mm: replace mmap with vma write lock assertions when operating on a
>     vma
>   mm: lock vma explicitly before doing vm_flags_reset and
>     vm_flags_reset_once
>   mm: always lock new vma before inserting into vma tree
>   mm: move vma locking out of vma_prepare
>
>  arch/powerpc/kvm/book3s_hv_uvmem.c      |  1 +
>  arch/powerpc/mm/book3s64/subpage_prot.c |  1 +
>  arch/riscv/mm/pageattr.c                |  1 +
>  arch/s390/mm/gmap.c                     |  5 ++++
>  drivers/infiniband/hw/hfi1/file_ops.c   |  1 +
>  fs/proc/task_mmu.c                      |  5 ++++
>  fs/userfaultfd.c                        |  6 +++++
>  include/linux/mm.h                      | 13 ++++++---
>  include/linux/pagewalk.h                | 11 ++++++++
>  mm/damon/vaddr.c                        |  2 ++
>  mm/hmm.c                                |  1 +
>  mm/hugetlb.c                            |  2 +-
>  mm/khugepaged.c                         |  5 ++--
>  mm/ksm.c                                | 25 ++++++++++-------
>  mm/madvise.c                            |  8 +++---
>  mm/memcontrol.c                         |  2 ++
>  mm/memory-failure.c                     |  1 +
>  mm/memory.c                             |  2 +-
>  mm/mempolicy.c                          | 22 +++++++++------
>  mm/migrate_device.c                     |  1 +
>  mm/mincore.c                            |  1 +
>  mm/mlock.c                              |  4 ++-
>  mm/mmap.c                               | 29 +++++++++++++-------
>  mm/mprotect.c                           |  2 ++
>  mm/pagewalk.c                           | 36 ++++++++++++++++++++++---
>  mm/vmscan.c                             |  1 +
>  26 files changed, 146 insertions(+), 42 deletions(-)
>
> --
> 2.41.0.585.gd2178a4bd4-goog
>
