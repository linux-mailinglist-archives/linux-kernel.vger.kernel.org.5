Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B6C765E6F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjG0VxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbjG0Vw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:52:59 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AC9E2686
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:42 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so1297416276.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690494760; x=1691099560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4KPOtYqoOes1CwPA7Jr9Y4W2AOtCMCx1fJ4T2541xI4=;
        b=jXRZ7KmjH+Cq+ZbNqpwHiH19bHmNc0OqzIL99k8dYjmCAriZEMM4GIedx5Gx59m9po
         N1uxwosjUlYFte8gwy9D4899dUV9CRZ1QgAnWLYXjdvOiZLC+Lp+mkQLOUxFemL3DNGO
         HqkKqxZos4jyrP9XafK+sQhavS7+FVtz9WX103LkbYPB9VN4H0QUinLu+F/UD2mN6pp7
         ecIwU08PWKmaTB/zAUrN0hMhe6DdmngiqIp3E6W1z//C4pohRKjQkBFdIzJaa+yLX4/N
         ASGe7bsL9a6aAryuxBc/Fr04nvbcyWj/97W5VSA0MrVll+ryz0FFh4lwhEyFXyr64HVN
         Y/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690494760; x=1691099560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4KPOtYqoOes1CwPA7Jr9Y4W2AOtCMCx1fJ4T2541xI4=;
        b=bdURmJrSpYIdLvcEjmYTtxVj03AD/bVQ9i2RD94AXWgg8H5EwpRuo8efnDuHQMGUz9
         H9Np4PWxTZAkRsX4w5CpElimF1Kl5EENqZW637FwkC5NsvmZwgWl0ZR4Ge1r3A5RKV3j
         FgZUTMvG0lhcAMZnA0KEqTKwtbsI32+1CGgld9FgrULMeQPEx/SV/8VVBYlp6p6rV1jz
         eRJwN728YTv7uJAUuvyn4i7RC1qt0aO1i5uTDM52FUAcShsQIgppnRzQ0f+ykWSTvXHc
         mI5vidcGSO9Kkepb1rxXBmpKrOTDPG54gVIPcVzgMZA3E47CXWWRljmi8JyJbSGGhztt
         KyoA==
X-Gm-Message-State: ABy/qLYFMyzfqJL420KRSZ5W7JsFEEPmQtp6iqUKNx/mFdzKYa5MFNge
        t2pqZnDMFjxcw9C+ITyxbvXfvMpUBxbcdfF50oVjxA==
X-Google-Smtp-Source: APBJJlEHWnUxP3CNpH110VR9IOFcKCDj3y0RSICD5X196CVQj2DfSuSMYXTixdZVusBvsAkkuk46WrN4HqVIrU84qoQ=
X-Received: by 2002:a25:bc88:0:b0:d14:6e28:69a4 with SMTP id
 e8-20020a25bc88000000b00d146e2869a4mr584794ybk.29.1690494760452; Thu, 27 Jul
 2023 14:52:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230726214103.3261108-1-jannh@google.com> <20230726214103.3261108-3-jannh@google.com>
In-Reply-To: <20230726214103.3261108-3-jannh@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 27 Jul 2023 14:52:26 -0700
Message-ID: <CAJuCfpHtE-2-NygxOJB+iaaEYuuLzqw3m=DLp0grQXwYPs5nLQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: lock_vma_under_rcu() must check vma->anon_vma
 under vma lock
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 2:42=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> lock_vma_under_rcu() tries to guarantee that __anon_vma_prepare() can't
> be called in the VMA-locked page fault path by ensuring that
> vma->anon_vma is set.
> However, this check happens before the VMA is locked, which means a
> concurrent move_vma() can concurrently call unlink_anon_vmas(), which
> disassociates the VMA's anon_vma.
>
> This means we can get UAF in the following scenario:
>
>   THREAD 1                   THREAD 2
>   =3D=3D=3D=3D=3D=3D=3D=3D                   =3D=3D=3D=3D=3D=3D=3D=3D
>   <page fault>
>     lock_vma_under_rcu()
>       rcu_read_lock()
>       mas_walk()
>       check vma->anon_vma
>
>                              mremap() syscall
>                                move_vma()
>                                 vma_start_write()
>                                  unlink_anon_vmas()
>                              <syscall end>
>
>     handle_mm_fault()
>       __handle_mm_fault()
>         handle_pte_fault()
>           do_pte_missing()
>             do_anonymous_page()
>               anon_vma_prepare()
>                 __anon_vma_prepare()
>                   find_mergeable_anon_vma()
>                     mas_walk() [looks up VMA X]
>
>                              munmap() syscall (deletes VMA X)
>
>                     reusable_anon_vma() [called on freed VMA X]
>
> This is a security bug if you can hit it, although an attacker would
> have to win two races at once where the first race window is only a
> few instructions wide.
>
> This patch is based on some previous discussion with Linus Torvalds on
> the security list.
>
> Cc: stable@vger.kernel.org
> Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to contro=
l it")
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/memory.c | 28 ++++++++++++++++------------
>  1 file changed, 16 insertions(+), 12 deletions(-)
>
> diff --git a/mm/memory.c b/mm/memory.c
> index 01f39e8144ef..603b2f419948 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5393,27 +5393,28 @@ struct vm_area_struct *lock_vma_under_rcu(struct =
mm_struct *mm,
>         if (!vma_is_anonymous(vma) && !vma_is_tcp(vma))
>                 goto inval;
>
> -       /* find_mergeable_anon_vma uses adjacent vmas which are not locke=
d */
> -       if (!vma->anon_vma && !vma_is_tcp(vma))
> -               goto inval;
> -
>         if (!vma_start_read(vma))
>                 goto inval;
>
> +       /*
> +        * find_mergeable_anon_vma uses adjacent vmas which are not locke=
d.
> +        * This check must happen after vma_start_read(); otherwise, a
> +        * concurrent mremap() with MREMAP_DONTUNMAP could dissociate the=
 VMA
> +        * from its anon_vma.
> +        */
> +       if (unlikely(!vma->anon_vma && !vma_is_tcp(vma)))
> +               goto inval_end_read;
> +
>         /*
>          * Due to the possibility of userfault handler dropping mmap_lock=
, avoid
>          * it for now and fall back to page fault handling under mmap_loc=
k.
>          */
> -       if (userfaultfd_armed(vma)) {
> -               vma_end_read(vma);
> -               goto inval;
> -       }
> +       if (userfaultfd_armed(vma))
> +               goto inval_end_read;
>
>         /* Check since vm_start/vm_end might change before we lock the VM=
A */
> -       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
) {
> -               vma_end_read(vma);
> -               goto inval;
> -       }
> +       if (unlikely(address < vma->vm_start || address >=3D vma->vm_end)=
)
> +               goto inval_end_read;
>
>         /* Check if the VMA got isolated after we found it */
>         if (vma->detached) {
> @@ -5425,6 +5426,9 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm=
_struct *mm,
>
>         rcu_read_unlock();
>         return vma;
> +
> +inval_end_read:
> +       vma_end_read(vma);
>  inval:
>         rcu_read_unlock();
>         count_vm_vma_lock_event(VMA_LOCK_ABORT);
> --
> 2.41.0.487.g6d72f3e995-goog
>
