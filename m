Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 652857704BC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 17:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbjHDPbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 11:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbjHDPbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 11:31:18 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4B4ECB
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:30:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe4cdb724cso2632975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 08:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691163013; x=1691767813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RXaxv8hcHUdAQDuDXdR+JYDGYLfy9qfQFPylmIIm4N4=;
        b=kR2M1EIlMLWfC0e4+/yLdb6eOVbY/rAHPmTwRlGy6Dpv+9PmFHJvM0ATxK8S8a9ewo
         k8Ikp1exO1kewBQHMRQE6M20eivk7aQkB9fjjsjclHFayzxd5NVoAQerHHQoCIcTU9aV
         x95vYsZ2LnrEL4i0xDcNb+Dazci3oawAQucEoyvSuutKYAnxmVj1AwWAMQGxv+1pOezB
         iNzp/HZrNqE6JdoyBuNK2vqCV1+zQEbpKT0Ev1/cLPhtaHZxdoCX5+95lBn7cNi5wHFr
         1XdfasYviPizpfXVazt1s6Q6MLOf8zW6EVYo420tmfq1h/v6sQEfe7myJ4v2w378FjJM
         p+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691163013; x=1691767813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RXaxv8hcHUdAQDuDXdR+JYDGYLfy9qfQFPylmIIm4N4=;
        b=KZMcEUSb05lf+0B4wIheIpEJdRVrhv2LrvfRTZQMcPcfmcUx5/RDlkFhNHeNyk2Zb7
         TGUG1JML2bKi6esDzQs6PDALk+m26aU9qc2vsP/PeQMQHoRS8XcOKyYX9hav416Vg61Y
         HmLcelsj8WB2RXxcwtrlaTXNpJtxpePY0g/MjZDcPBEKWvoiEn4qkhwMnIEZQSFPsBH+
         YFZOWePHeb2IfWws5jMUILt6QCOhCaJ1flnQG5RtM6AgX9ic9rRWgQ0+6YiY/H17l16x
         9Ntok+j6oVHYZRdi/+/WZ60JtvjucXyLF3ZdrHIHk4HwBPnggCBoOqC1Nzs4JCGxYnt5
         wh9g==
X-Gm-Message-State: AOJu0Yys2fexdi9IUekJ/9y1SWpBiZ7z9IJi7b5e9SPVZUYf1avLnHvr
        5Xvw3YiuGtETojE87HiHImEHrshrGauIIPWtKqAcaA==
X-Google-Smtp-Source: AGHT+IGU1blOwJN0gtAEwUqtPLIbTH/TdHJ7JGDlA7F7P39nIq2eeBcpkmhBy9gGZ1JoYraEeF4Oic6V9ZmmqswzNrI=
X-Received: by 2002:a5d:4e07:0:b0:317:5252:57e7 with SMTP id
 p7-20020a5d4e07000000b00317525257e7mr1544652wrt.21.1691163013278; Fri, 04 Aug
 2023 08:30:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230803172652.2849981-1-surenb@google.com>
In-Reply-To: <20230803172652.2849981-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 4 Aug 2023 08:29:57 -0700
Message-ID: <CAJuCfpFVE6z=ZVsQbFB3CEwMzE1O8fphuZb-FetQacCVtjS=cg@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] make vma locking more obvious
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
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 10:26=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
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
> Changes since v2:
> - removed vma locking from hfi1_file_mmap(), per Linus
> - moved vma locking out of dup_anon_vma(), per Liam
> - added Liam's Reviewed-by

v4 is posted at
https://lore.kernel.org/all/20230804152724.3090321-1-surenb@google.com/

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
>   mm: move vma locking out of vma_prepare and dup_anon_vma
>
>  arch/powerpc/kvm/book3s_hv_uvmem.c      |  1 +
>  arch/powerpc/mm/book3s64/subpage_prot.c |  1 +
>  arch/riscv/mm/pageattr.c                |  1 +
>  arch/s390/mm/gmap.c                     |  5 ++++
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
>  mm/mmap.c                               | 32 ++++++++++++++--------
>  mm/mprotect.c                           |  2 ++
>  mm/pagewalk.c                           | 36 ++++++++++++++++++++++---
>  mm/vmscan.c                             |  1 +
>  25 files changed, 147 insertions(+), 43 deletions(-)
>
> --
> 2.41.0.585.gd2178a4bd4-goog
>
