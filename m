Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DAF375B4FF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbjGTQwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGTQwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:52:15 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E15123
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:52:10 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ca3cc52ee62so941265276.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689871929; x=1690476729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5sT590ZNf5oA0ecIubHbzawara7tE0cyX/8/BfRRfw=;
        b=cTwEcR3dDZCGUsyyrtSSrQeh5rWfGnkr1t+8OTB+RL3YgGzMu91HyDpRfuy2+70yPC
         zcz71mVSslyXbkrOo65RGCZTGhoEU+UHsSN1wgfExqgmSFeJa8Si8bZQs13g1Zm4WHJi
         4fG1rVaG01sFmeXpaqF3fk1lpBbBRWSdTtTXjTqdJmh+zxXye9sA/rYInfTNKRY6FsRV
         hZcT8DB2WNr0r9fiOc+SDuZ/uwdUlowEuNH72vUrryxSta8RLu/PJLeJMTsQa6ZgMOX2
         eiG/3pSOqFs1DT4+gBRXhrfqJX4UlltbJpI1lAPOhC4Ezq8rey5ypsaJhXvUFxa5h6uE
         MROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689871929; x=1690476729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t5sT590ZNf5oA0ecIubHbzawara7tE0cyX/8/BfRRfw=;
        b=NUqdgL9pnvWhtZCd2QBdi4FWKDkklTMMc+W2NlHiYUTVT7q4SqrDeXAncJn/jAfzvT
         D/7zdAzSpzTwDA0z26iuQ7T2TpraYYXHbLtRQvw8atUdPYNC9HtH2PRNeEkYUR0K3kmy
         FiIyBYN3sULo7CXl+UE0fpeDYEvk3rJuU/p3qxfVviQwOzXKJC7+NwokdTisFQ4ceU/A
         EpievdfLvnDx+bxfJYpy82bEtCQLB335KPmKsytrOawAiVH2n4J3BdO32L42gvDeVizE
         aHHgrYRZKBC+Va79UFiGiYeN+dYVx7vsnPKFy7p63X5N4XLjR9rPUKqSU0F/XlyDep8+
         a/DQ==
X-Gm-Message-State: ABy/qLYCTs8EMaHwlHvdoxdeSlKEufAE4Zg+Q4J379+vpejXWpoUpo3X
        u1B5QY423FxYxc/11t0gdG9BfdWYLjE6BmyO5exVCQ==
X-Google-Smtp-Source: APBJJlFF0tdRBONYXI2KxFgRqDCV0gM6UX7F2ZUbl1LFnd91UNVb6OC9BBn14dIUliRLGzdYu/Ja61d6mTQ2MkefHlQ=
X-Received: by 2002:a25:870f:0:b0:bc3:8c94:8e34 with SMTP id
 a15-20020a25870f000000b00bc38c948e34mr5909501ybl.26.1689871929420; Thu, 20
 Jul 2023 09:52:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230720013249.199981-1-jannh@google.com>
In-Reply-To: <20230720013249.199981-1-jannh@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Thu, 20 Jul 2023 09:51:55 -0700
Message-ID: <CAJuCfpEs=jwaJEJQV9=Qo4h9JobrR1S=vETy1h8Q7TfS3eF_Qw@mail.gmail.com>
Subject: Re: [PATCH] mm: Don't drop VMA locks in mm_drop_all_locks()
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
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

On Wed, Jul 19, 2023 at 6:33=E2=80=AFPM Jann Horn <jannh@google.com> wrote:
>
> Despite its name, mm_drop_all_locks() does not drop _all_ locks; the mmap
> lock is held write-locked by the caller, and the caller is responsible fo=
r
> dropping the mmap lock at a later point (which will also release the VMA
> locks).
> Calling vma_end_write_all() here is dangerous because the caller might ha=
ve
> write-locked a VMA with the expectation that it will stay write-locked
> until the mmap_lock is released, as usual.
>
> This _almost_ becomes a problem in the following scenario:
>
> An anonymous VMA A and an SGX VMA B are mapped adjacent to each other.
> Userspace calls munmap() on a range starting at the start address of A an=
d
> ending in the middle of B.
>
> Hypothetical call graph with additional notes in brackets:
>
> do_vmi_align_munmap
>   [begin first for_each_vma_range loop]
>   vma_start_write [on VMA A]
>   vma_mark_detached [on VMA A]
>   __split_vma [on VMA B]
>     sgx_vma_open [=3D=3D new->vm_ops->open]
>       sgx_encl_mm_add
>         __mmu_notifier_register [luckily THIS CAN'T ACTUALLY HAPPEN]
>           mm_take_all_locks
>           mm_drop_all_locks
>             vma_end_write_all [drops VMA lock taken on VMA A before]
>   vma_start_write [on VMA B]
>   vma_mark_detached [on VMA B]
>   [end first for_each_vma_range loop]
>   vma_iter_clear_gfp [removes VMAs from maple tree]
>   mmap_write_downgrade
>   unmap_region
>   mmap_read_unlock
>
> In this hypothetical scenario, while do_vmi_align_munmap() thinks it stil=
l
> holds a VMA write lock on VMA A, the VMA write lock has actually been
> invalidated inside __split_vma().
>
> The call from sgx_encl_mm_add() to __mmu_notifier_register() can't
> actually happen here, as far as I understand, because we are duplicating =
an
> existing SGX VMA, but sgx_encl_mm_add() only calls
> __mmu_notifier_register() for the first SGX VMA created in a given proces=
s.
> So this could only happen in fork(), not on munmap().
> But in my view it is just pure luck that this can't happen.
>
> Also, we wouldn't actually have any bad consequences from this in
> do_vmi_align_munmap(), because by the time the bug drops the lock on VMA =
A,
> we've already marked VMA A as detached, which makes it completely
> ineligible for any VMA-locked page faults.
> But again, that's just pure luck.
>
> So remove the vma_end_write_all(), so that VMA write locks are only ever
> released on mmap_write_unlock() or mmap_write_downgrade().

Your logic makes sense to be. mm_drop_all_locks() unlocking all VMAs,
even the ones which were locked before mm_take_all_locks() seems
dangerous.
One concern I have is that mm_take_all_locks() and mm_drop_all_locks()
become asymmetric with this change: mm_take_all_locks() locks all VMAs
but mm_drop_all_locks() does not release them. I think there should be
an additional comment explaining this asymmetry.
Another side-effect which would be nice to document in a comment is
that when mm_take_all_locks() fails after it locked the VMAs, those
VMAs will stay locked until mmap_write_unlock/mmap_write_downgrade.
This happens because of failure mm_take_all_locks() jumps to perform
mm_drop_all_locks() and this will not unlock already locked VMAs.
Other than that LGTM. Thanks!

>
> Fixes: eeff9a5d47f8 ("mm/mmap: prevent pagefault handler from racing with=
 mmu_notifier registration")
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Jann Horn <jannh@google.com>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/mmap.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 3eda23c9ebe7..1ff354b1e23c 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3758,7 +3758,6 @@ void mm_drop_all_locks(struct mm_struct *mm)
>                 if (vma->vm_file && vma->vm_file->f_mapping)
>                         vm_unlock_mapping(vma->vm_file->f_mapping);
>         }
> -       vma_end_write_all(mm);
>
>         mutex_unlock(&mm_all_locks_mutex);
>  }
>
> base-commit: bfa3037d828050896ae52f6467b6ca2489ae6fb1
> --
> 2.41.0.255.g8b1d071c50-goog
>
