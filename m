Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D064F75B760
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 21:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjGTTDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 15:03:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjGTTD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 15:03:27 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6EF1984
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:03:22 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-635d9e0aa6dso8329526d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 12:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689879801; x=1690484601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4r0G41HIiGcQMHB4pEZiHr5BAGtm82arbVI+LgNPL4=;
        b=RaiDUPvR+vvyd1OyTp20JMJCSJvrT0S6zGhWxDNzZMzS0AGy8SJBsyyhckBfm5nRE/
         K959Kw6uN6SafOVgbBVZ+Oid0aF4pL3At4mcK4EYDh2N0ahdN4oxnvkMxXbT00+CocPB
         /HjuM6QjdsPfWVRr2V+eaIs7pkDvmDgkgh7d/Ym1sn6HWGhCcBKB0DjUUSFo9YDCmmj1
         +oTy23pA1nrzKlp5cOpJCHtIu479n28nKBoerhiWnRrAbNKK2lvX/4i92s6Aqo54Ahca
         Dq/TtIbjm5Z2285umaAaxnlGBq18gt9npli7BW0C7g60kmtT/Dk9l9hoWtaFFjKxcuUL
         fgvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689879801; x=1690484601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4r0G41HIiGcQMHB4pEZiHr5BAGtm82arbVI+LgNPL4=;
        b=VxZs4qdL+FtEMyb9DAd92JMg8pH9V8DzOaIKxTVriiOz/UnnkbLArQGpv02cP/au+5
         qCQOyUnhDLpxZLEVH13396ADreuj6v22A19m3mc3P/IezzU6riJFxRlz4aF5TavLDUE+
         UaYUjACzpfZXo5y47bnluMrdjqy3w0UHuyWT9jZEil49tPAuAGqvcJLdsvu7BbWz/EwF
         KPOksQcom/jthUGgmJTFzgGGbdrPzW2NoxgForzerPYlqNJjj1TIhG9OeubZNO7is28M
         pxgWFlGobTUSmhrgl+YVnsD/m1TEFg1Du9TRd6UIYSDZql4ptpgUSuwZoy0yrYJQ92wj
         pdTQ==
X-Gm-Message-State: ABy/qLbzTGcXh+B8b64nVXdXAJsupyXGDB/KaEcYLQaZuoUB8tJz/c4y
        1M8Q/MQK06s8rWJ/GSZh9lixk+iwVESnAFlcMfh7Bg==
X-Google-Smtp-Source: APBJJlHkLrHgRt203UkLUnU1mzzoW8tKVTFkDinsOgPBv+ELiQhdC9JCY+rvznAKn+8iCDefYEeSZshxr+gK8Y2fwW8=
X-Received: by 2002:a0c:e306:0:b0:635:e528:5213 with SMTP id
 s6-20020a0ce306000000b00635e5285213mr3710654qvl.23.1689879801348; Thu, 20 Jul
 2023 12:03:21 -0700 (PDT)
MIME-Version: 1.0
References: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
In-Reply-To: <tencent_C2D6865561F23A8141BB145149ACC682B408@qq.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 20 Jul 2023 12:03:10 -0700
Message-ID: <CAKwvOdmMUMpPOWoUZYQ1Mr=FmdVQYQ6XrDzPsEmuV=bSqDFvow@mail.gmail.com>
Subject: Re: [PATCH v3] hugetlbfs: Fix integer overflow check in hugetlbfs_file_mmap()
To:     Linke Li <lilinke99@foxmail.com>
Cc:     linux-mm@kvack.org, mike.kravetz@oracle.com, muchun.song@linux.dev,
        nathan@kernel.org, trix@redhat.com, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, dan.carpenter@linaro.org,
        Linke Li <lilinke99@gmail.com>
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

On Thu, Jul 20, 2023 at 7:50=E2=80=AFAM Linke Li <lilinke99@foxmail.com> wr=
ote:
>
> From: Linke Li <lilinke99@gmail.com>
>
> ```
>         vma_len =3D (loff_t)(vma->vm_end - vma->vm_start);
>         len =3D vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
>         /* check for overflow */
>         if (len < vma_len)
>                 return -EINVAL;
> ```
>
> There is a signed integer overflow in the code, which is undefined
> behavior according to the C stacnard. Although this works, it's

typo: s/stacnard/standard/

I think the commit message should explicitly mention that the Linux
kernel is built with -fno-strict-overflow, but IMO that kind of makes
this patch moot.

> still a bit ugly and static checkers will complain.
>
> Using macro "check_add_overflow" to do the overflow check can
> effectively detect integer overflow and avoid any undefined behavior.
>
> Signed-off-by: Linke Li <lilinke99@gmail.com>
> ---
> v3: fix checkpatch warning and better description.
>  fs/hugetlbfs/inode.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
> index 7b17ccfa039d..326a8c0af5f6 100644
> --- a/fs/hugetlbfs/inode.c
> +++ b/fs/hugetlbfs/inode.c
> @@ -154,10 +154,7 @@ static int hugetlbfs_file_mmap(struct file *file, st=
ruct vm_area_struct *vma)
>         if (vma->vm_pgoff & (~huge_page_mask(h) >> PAGE_SHIFT))
>                 return -EINVAL;
>
> -       vma_len =3D (loff_t)(vma->vm_end - vma->vm_start);
> -       len =3D vma_len + ((loff_t)vma->vm_pgoff << PAGE_SHIFT);
> -       /* check for overflow */
> -       if (len < vma_len)
> +       if (check_add_overflow(vma_len, (loff_t)vma->vm_pgoff << PAGE_SHI=
FT, &len))
>                 return -EINVAL;
>
>         inode_lock(inode);
> --
> 2.25.1
>


--=20
Thanks,
~Nick Desaulniers
