Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CB175D7E0
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 01:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjGUX0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 19:26:43 -0400
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 420C21BE2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:26:42 -0700 (PDT)
Received: by mail-yb1-xb32.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so2440831276.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689982001; x=1690586801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUHZ776Bm2oIhw/I04pXo56/BBLF8A8d1FrFm8C5MeE=;
        b=aOvY1nSYP6R+GYSR1MUsDUI7MDecIVTPHeBI1/wVE6wtXOInor6/w6wiInRKR7oZkY
         Vb8+Ffr4fUWfndJZ3hV+O6k+OzkCf9LEy3win7geLhd0Me87AXSg2ZSFSv3maJ9QDWZ3
         UxW6YOrgqr8LG5/nMZ+RxkBKWo3XLpJoix1iZXjtEiuLBfmZ4aaC9CiiVw4KUVFDPJaG
         zYJp7Bs67aqlGIqKXFBgXwcDssebNiXKw+PVXgG2tzD43znxtvPiq6d3iLfJV4wCDRuB
         LFpT6M/sDEmuDkym8GdDS0/2dkuJQmTKcwYuQDkIrEkUQihSce5t3yhglPUGsaOvp+9B
         SZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689982001; x=1690586801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUHZ776Bm2oIhw/I04pXo56/BBLF8A8d1FrFm8C5MeE=;
        b=ihz+XZQzAj9RGkoc9ohiEbLqJUzCfLAAgakmRR4LYIJhcjldB8Mh1NotFU9fqklU98
         t8psZsmqA6pQXgh1u3hiFZA5Ch3G/H7gJ2CcsWx+RUtdDHrqJnE7eVzIevCeU/M1r18B
         1HZREeYFFjtReS4wNjGXOlqlQcKbbts3Jl2GL6dAC2brEmw4l0+g9Fq9VTRTJXaxb0zG
         KlG+fH98izZGGRkp0nR9LYQld6SGGy3ZMdrnTqmCOsbL6M74cQCqSMYEYkOSMOcMAZJF
         ekiAXsPPTwGGeEiMxAPqjHxyZelogBOX/7uHMGYJ2H9/L7/bFHdTSbkRL6pzbte6HdNm
         xVlA==
X-Gm-Message-State: ABy/qLbLUVHyWwZ7i+4EQH8Tzf2iWFYdpoaEUTKC7UJgVN20AVvtZUYF
        QqNy8wbeKvaR12jlJc9P96kxvYtIQ6aLfeRj5/yYig==
X-Google-Smtp-Source: APBJJlEBbig5223U+bEbJ+O/ryTylSKExBz5kSKSWTn6s5aq5V/pn+8KrhupwJ7FMGKbLq7WVT6YVIl4zdepm1M1Hps=
X-Received: by 2002:a25:b319:0:b0:cfd:64e4:a2ed with SMTP id
 l25-20020a25b319000000b00cfd64e4a2edmr3058397ybj.52.1689982001178; Fri, 21
 Jul 2023 16:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230721225107.942336-1-jannh@google.com>
In-Reply-To: <20230721225107.942336-1-jannh@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Fri, 21 Jul 2023 16:26:27 -0700
Message-ID: <CAJuCfpHHKFDgj0DELVPLyx+YRxW=EY+JWO5SJB9+OPjPE3K3vw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Fix memory ordering for mm_lock_seq and vm_lock_seq
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
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

On Fri, Jul 21, 2023 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> mm->mm_lock_seq effectively functions as a read/write lock; therefore it
> must be used with acquire/release semantics.
>
> A specific example is the interaction between userfaultfd_register() and
> lock_vma_under_rcu().
> userfaultfd_register() does the following from the point where it changes
> a VMA's flags to the point where concurrent readers are permitted again
> (in a simple scenario where only a single private VMA is accessed and no
> merging/splitting is involved):
>
> userfaultfd_register
>   userfaultfd_set_vm_flags
>     vm_flags_reset
>       vma_start_write
>         down_write(&vma->vm_lock->lock)
>         vma->vm_lock_seq =3D mm_lock_seq [marks VMA as busy]
>         up_write(&vma->vm_lock->lock)
>       vm_flags_init
>         [sets VM_UFFD_* in __vm_flags]
>   vma->vm_userfaultfd_ctx.ctx =3D ctx
>   mmap_write_unlock
>     vma_end_write_all
>       WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1) [unlocks VMA]
>
> There are no memory barriers in between the __vm_flags update and the
> mm->mm_lock_seq update that unlocks the VMA, so the unlock can be reorder=
ed
> to above the `vm_flags_init()` call, which means from the perspective of =
a
> concurrent reader, a VMA can be marked as a userfaultfd VMA while it is n=
ot
> VMA-locked. That's bad, we definitely need a store-release for the unlock
> operation.
>
> The non-atomic write to vma->vm_lock_seq in vma_start_write() is mostly
> fine because all accesses to vma->vm_lock_seq that matter are always
> protected by the VMA lock. There is a racy read in vma_start_read() thoug=
h
> that can tolerate false-positives, so we should be using WRITE_ONCE() to
> keep things tidy and data-race-free (including for KCSAN).
>
> On the other side, lock_vma_under_rcu() works as follows in the relevant
> region for locking and userfaultfd check:
>
> lock_vma_under_rcu
>   vma_start_read
>     vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq) [early bai=
lout]
>     down_read_trylock(&vma->vm_lock->lock)
>     vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq) [main chec=
k]
>   userfaultfd_armed
>     checks vma->vm_flags & __VM_UFFD_FLAGS
>
> Here, the interesting aspect is how far down the mm->mm_lock_seq read
> can be reordered - if this read is reordered down below the vma->vm_flags
> access, this could cause lock_vma_under_rcu() to partly operate on
> information that was read while the VMA was supposed to be locked.
> To prevent this kind of downwards bleeding of the mm->mm_lock_seq read, w=
e
> need to read it with a load-acquire.
>
> Some of the comment wording is based on suggestions by Suren.
>
> BACKPORT WARNING: One of the functions changed by this patch (which I've
> written against Linus' tree) is vma_try_start_write(), but this function
> no longer exists in mm/mm-everything. I don't know whether the merged
> version of this patch will be ordered before or after the patch that
> removes vma_try_start_write(). If you're backporting this patch to a
> tree with vma_try_start_write(), make sure this patch changes that
> function.
>
> Fixes: 5e31275cc997 ("mm: add per-VMA lock and helper functions to contro=
l it")
> Cc: stable@vger.kernel.org
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Thanks for fixing the ordering and making the rules clear! I
completely missed the reordering issue during vma unlocking.

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>
> Notes:
>     v2: made the comments much clearer based on off-list input from Suren
>
>  include/linux/mm.h        | 29 +++++++++++++++++++++++------
>  include/linux/mm_types.h  | 28 ++++++++++++++++++++++++++++
>  include/linux/mmap_lock.h | 10 ++++++++--
>  3 files changed, 59 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 2dd73e4f3d8e..406ab9ea818f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -641,8 +641,14 @@ static inline void vma_numab_state_free(struct vm_ar=
ea_struct *vma) {}
>   */
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>  {
> -       /* Check before locking. A race might cause false locked result. =
*/
> -       if (vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_lock_seq))
> +       /*
> +        * Check before locking. A race might cause false locked result.
> +        * We can use READ_ONCE() for the mm_lock_seq here, and don't nee=
d
> +        * ACQUIRE semantics, because this is just a lockless check whose=
 result
> +        * we don't rely on for anything - the mm_lock_seq read against w=
hich we
> +        * need ordering is below.
> +        */
> +       if (READ_ONCE(vma->vm_lock_seq) =3D=3D READ_ONCE(vma->vm_mm->mm_l=
ock_seq))
>                 return false;
>
>         if (unlikely(down_read_trylock(&vma->vm_lock->lock) =3D=3D 0))
> @@ -653,8 +659,13 @@ static inline bool vma_start_read(struct vm_area_str=
uct *vma)
>          * False unlocked result is impossible because we modify and chec=
k
>          * vma->vm_lock_seq under vma->vm_lock protection and mm->mm_lock=
_seq
>          * modification invalidates all existing locks.
> +        *
> +        * We must use ACQUIRE semantics for the mm_lock_seq so that if w=
e are
> +        * racing with vma_end_write_all(), we only start reading from th=
e VMA
> +        * after it has been unlocked.
> +        * This pairs with RELEASE semantics in vma_end_write_all().
>          */
> -       if (unlikely(vma->vm_lock_seq =3D=3D READ_ONCE(vma->vm_mm->mm_loc=
k_seq))) {
> +       if (unlikely(vma->vm_lock_seq =3D=3D smp_load_acquire(&vma->vm_mm=
->mm_lock_seq))) {
>                 up_read(&vma->vm_lock->lock);
>                 return false;
>         }
> @@ -676,7 +687,7 @@ static bool __is_vma_write_locked(struct vm_area_stru=
ct *vma, int *mm_lock_seq)
>          * current task is holding mmap_write_lock, both vma->vm_lock_seq=
 and
>          * mm->mm_lock_seq can't be concurrently modified.
>          */
> -       *mm_lock_seq =3D READ_ONCE(vma->vm_mm->mm_lock_seq);
> +       *mm_lock_seq =3D vma->vm_mm->mm_lock_seq;
>         return (vma->vm_lock_seq =3D=3D *mm_lock_seq);
>  }
>
> @@ -688,7 +699,13 @@ static inline void vma_start_write(struct vm_area_st=
ruct *vma)
>                 return;
>
>         down_write(&vma->vm_lock->lock);
> -       vma->vm_lock_seq =3D mm_lock_seq;
> +       /*
> +        * We should use WRITE_ONCE() here because we can have concurrent=
 reads
> +        * from the early lockless pessimistic check in vma_start_read().
> +        * We don't really care about the correctness of that early check=
, but
> +        * we should use WRITE_ONCE() for cleanliness and to keep KCSAN h=
appy.
> +        */
> +       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>         up_write(&vma->vm_lock->lock);
>  }
>
> @@ -702,7 +719,7 @@ static inline bool vma_try_start_write(struct vm_area=
_struct *vma)
>         if (!down_write_trylock(&vma->vm_lock->lock))
>                 return false;
>
> -       vma->vm_lock_seq =3D mm_lock_seq;
> +       WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
>         up_write(&vma->vm_lock->lock);
>         return true;
>  }
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index de10fc797c8e..5e74ce4a28cd 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -514,6 +514,20 @@ struct vm_area_struct {
>         };
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +       /*
> +        * Can only be written (using WRITE_ONCE()) while holding both:
> +        *  - mmap_lock (in write mode)
> +        *  - vm_lock->lock (in write mode)
> +        * Can be read reliably while holding one of:
> +        *  - mmap_lock (in read or write mode)
> +        *  - vm_lock->lock (in read or write mode)
> +        * Can be read unreliably (using READ_ONCE()) for pessimistic bai=
lout
> +        * while holding nothing (except RCU to keep the VMA struct alloc=
ated).
> +        *
> +        * This sequence counter is explicitly allowed to overflow; seque=
nce
> +        * counter reuse can only lead to occasional unnecessary use of t=
he
> +        * slowpath.
> +        */
>         int vm_lock_seq;
>         struct vma_lock *vm_lock;
>
> @@ -679,6 +693,20 @@ struct mm_struct {
>                                           * by mmlist_lock
>                                           */
>  #ifdef CONFIG_PER_VMA_LOCK
> +               /*
> +                * This field has lock-like semantics, meaning it is some=
times
> +                * accessed with ACQUIRE/RELEASE semantics.
> +                * Roughly speaking, incrementing the sequence number is
> +                * equivalent to releasing locks on VMAs; reading the seq=
uence
> +                * number can be part of taking a read lock on a VMA.
> +                *
> +                * Can be modified under write mmap_lock using RELEASE
> +                * semantics.
> +                * Can be read with no other protection when holding writ=
e
> +                * mmap_lock.
> +                * Can be read with ACQUIRE semantics if not holding writ=
e
> +                * mmap_lock.
> +                */
>                 int mm_lock_seq;
>  #endif
>
> diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> index aab8f1b28d26..e05e167dbd16 100644
> --- a/include/linux/mmap_lock.h
> +++ b/include/linux/mmap_lock.h
> @@ -76,8 +76,14 @@ static inline void mmap_assert_write_locked(struct mm_=
struct *mm)
>  static inline void vma_end_write_all(struct mm_struct *mm)
>  {
>         mmap_assert_write_locked(mm);
> -       /* No races during update due to exclusive mmap_lock being held *=
/
> -       WRITE_ONCE(mm->mm_lock_seq, mm->mm_lock_seq + 1);
> +       /*
> +        * Nobody can concurrently modify mm->mm_lock_seq due to exclusiv=
e
> +        * mmap_lock being held.
> +        * We need RELEASE semantics here to ensure that preceding stores=
 into
> +        * the VMA take effect before we unlock it with this store.
> +        * Pairs with ACQUIRE semantics in vma_start_read().
> +        */
> +       smp_store_release(&mm->mm_lock_seq, mm->mm_lock_seq + 1);
>  }
>  #else
>  static inline void vma_end_write_all(struct mm_struct *mm) {}
>
> base-commit: d192f5382581d972c4ae1b4d72e0b59b34cadeb9
> --
> 2.41.0.487.g6d72f3e995-goog
>
