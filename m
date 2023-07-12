Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B39375119B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjGLUAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjGLUAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:00:53 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437881FE6
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:00:52 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-cada5e4e40cso270165276.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689192051; x=1691784051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gTJiVQesou1SgmF7llvKQyMv+UdaLm0f7p83u13+5xg=;
        b=1wEQWwA1pT2jGY0r7ydRYYJYo3V9/IHs7e9LWlLMS8rqAIlHAy3gLDGdi9lrycSGtu
         kpzHYZAx47OXFAz2Hbyg14x2k+M0yMr0b4uMoPEX05dfQpUORe1SXIj4IzeZG5GDe8UZ
         8PFbNrU0z3u8nYBMJDaLPONQrTSA9TE9raToi4W0eh0cckJtVQsdD0hZJpZbsOZhIW+Z
         z+He6VNaEXeiiUEXCdYwiwbvg7nE+1yGeZhs7c+VuSDCTi06q/WKoioCfNytNcdrj/IF
         yiqH6K3sk1shOUigIhNCaMQlG7VWam1yHEQmhSJ8uj142nj1xzERbsz+HzJFaJGKPhbp
         RzbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689192051; x=1691784051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTJiVQesou1SgmF7llvKQyMv+UdaLm0f7p83u13+5xg=;
        b=jeVV4Ii1i0dA27uHNv/JChXBNECFIPybfwEmI00STYCva3yvYFCrV/zus2O12s3099
         3sa7GHb31g3027vGRKQoI29kEgMg/38ZzhMxwkIZbVmoT7iFU9XxO8VtSzfOt/jdEyn3
         dtZXCVpvNvAZgXy+amRvDltrDg6qyQ82mG2rGqrswYxXKpejhLOsl3dcCQHccOu/E5TU
         7csLoMAAte6ZqAuRc39SLN4+/aQ/TNRjUhI0Rp9uRMpBWtg2sA9ZA+nVd+zABcoX71/x
         zWYD4VRUYSqfmk1DdQxIi7PnJ951rzsCgvqp5pegcDU4jwhBKtNO5dGa5oY3iJPMLC6V
         v62A==
X-Gm-Message-State: ABy/qLbu7xmxAcGbgPQyF70JXMUw0e/cqo/JzJOkYRUz293eW2IGnDL3
        AJtYrvUa234LRtHKTidfO0UE8Px91u1ILrLpoCNG+Q==
X-Google-Smtp-Source: APBJJlH29LWXVQfDA//ZifgMVnhAvikiS3IILs0UlpGo8FjXZuugWhPwijyqz1ggKx7dcrqXF8BQvMC6CdDB/MFmYnY=
X-Received: by 2002:a25:5f06:0:b0:cab:4a58:2535 with SMTP id
 t6-20020a255f06000000b00cab4a582535mr1307273ybb.17.1689192051154; Wed, 12 Jul
 2023 13:00:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230712195652.969194-1-surenb@google.com>
In-Reply-To: <20230712195652.969194-1-surenb@google.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 12 Jul 2023 13:00:40 -0700
Message-ID: <CAJuCfpEX2fpHpJYzgBp8-3nbySUo758wuKt_fqUrs6_eM75LbA@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: fix a lockdep issue in vma_assert_write_locked
To:     akpm@linux-foundation.org
Cc:     Liam.Howlett@oracle.com, linux-mm@kvack.org, willy@infradead.org,
        ldufour@linux.ibm.com, michel@lespinasse.org, jglisse@google.com,
        vbabka@suse.cz, paulmck@kernel.org, brauner@kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
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

On Wed, Jul 12, 2023 at 12:56=E2=80=AFPM Suren Baghdasaryan <surenb@google.=
com> wrote:
>
> __is_vma_write_locked() can be used only when mmap_lock is write-locked
> to guarantee vm_lock_seq and mm_lock_seq stability during the check.
> Therefore it asserts this condition before further checks. Because of
> that it can't be used unless the user expects the mmap_lock to be
> write-locked. vma_assert_locked() can't assume this before ensuring
> that VMA is not read-locked.
> Change the order of the checks in vma_assert_locked() to check if the
> VMA is read-locked first and only then assert if it's not write-locked.
>
> Fixes: 50b88b63e3e4 ("mm: handle userfaults under VMA lock")
> Reported-by: Liam R. Howlett <liam.howlett@oracle.com>
> Closes: https://lore.kernel.org/all/20230712022620.3yytbdh24b7i4zrn@revol=
ver/
> Reported-by: syzbot+339b02f826caafd5f7a8@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000002db68f05ffb791bc@google.c=
om/
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>

Should have mentioned that this patch is for mm-unstable.

> ---
>  include/linux/mm.h | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 9687b48dfb1b..e3b022a66343 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -668,6 +668,7 @@ static inline void vma_end_read(struct vm_area_struct=
 *vma)
>         rcu_read_unlock();
>  }
>
> +/* WARNING! Can only be used if mmap_lock is expected to be write-locked=
 */
>  static bool __is_vma_write_locked(struct vm_area_struct *vma, int *mm_lo=
ck_seq)
>  {
>         mmap_assert_write_locked(vma->vm_mm);
> @@ -707,22 +708,17 @@ static inline bool vma_try_start_write(struct vm_ar=
ea_struct *vma)
>         return true;
>  }
>
> -static inline void vma_assert_locked(struct vm_area_struct *vma)
> +static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>  {
>         int mm_lock_seq;
>
> -       if (__is_vma_write_locked(vma, &mm_lock_seq))
> -               return;
> -
> -       lockdep_assert_held(&vma->vm_lock->lock);
> -       VM_BUG_ON_VMA(!rwsem_is_locked(&vma->vm_lock->lock), vma);
> +       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
>  }
>
> -static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> +static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -       int mm_lock_seq;
> -
> -       VM_BUG_ON_VMA(!__is_vma_write_locked(vma, &mm_lock_seq), vma);
> +       if (!rwsem_is_locked(&vma->vm_lock->lock))
> +               vma_assert_write_locked(vma);
>  }
>
>  static inline void vma_mark_detached(struct vm_area_struct *vma, bool de=
tached)
> --
> 2.41.0.455.g037347b96a-goog
>
