Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0012178DF04
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243471AbjH3TNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:13:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245618AbjH3Pnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 11:43:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD63122
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:43:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-269304c135aso3602627a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 08:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693410206; x=1694015006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hos3zNX5Io5VszHAL6d9NfCD5Tpud5Aief4IW0Tj/2M=;
        b=IZkblzV6cY/ISsDtmJfeCIYJFpeg06vZvW9Xq9Xp24AFnIyzpU5YZd8sqQFUEG9TIP
         SkFJ1LZNYtbhgYFySeAtYrMTL4LfEcWJDhdStINsH0rrvKVKz8+bwZMQ5e5MYGFdKV7S
         LhjjfMU0qsWOocr8NBeLeYh46MpqYkZatfZx3qmFZ+0DGnhybIAVtT+o/BFo9y1o8ja3
         L/hiBnteZy9HLYyNh4opa+oYsubAGTM+sRUaFOy3SbnHkL4pbMV6cYSJ3cGBj7iCGcT4
         chW4z95kZ7GqQZhRGXErJ8m2VQ7hz3Op7bvSZDF6I5Cfa2l93B1l0v/aWcV36EDrb3eT
         hzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693410206; x=1694015006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hos3zNX5Io5VszHAL6d9NfCD5Tpud5Aief4IW0Tj/2M=;
        b=Z3c819Rxs/LF/EHeGuA/D4jAgOM7afIwic3Zj5BXmBTYJs5D53dEzcr3hZow4W+rkA
         aOobVgh6Lt+GJlxCcsQRbX6Wg4/LUnr1bgf8hlOsT1Vj3ypT96P2dOfVdD10RuF+19bS
         5YXhX4EfWHIVqiBPbhpu83iYf1/qXVBXrSkPKWsXSKGWc3FR8zckLRdQoEVTduVzmF2j
         Fm/It6iRKVRe2WPcfgKBS7MVp18HQpiIEHOYtT/xqkZQyEvo/7aIf82npXBzJewoOTX7
         0HA98gRGW+CEShx9g0xGi13JFFvU6aNk2hIZr5fj4F21PAc2z0ISwX775DYJnf3iNps8
         IOvQ==
X-Gm-Message-State: AOJu0YxjbkzRB6PmOgzsuresgcf5jZ1ZASihTKdPcVNGcXEi+5ecyfmq
        ZYJVAGVH7VaNj7AJkWII3t38PoFxR7fAi+Y6msEb4Q==
X-Google-Smtp-Source: AGHT+IEsJ1Cl8XaoVMweojYTDPN11CHHEkD8agAJrPI6cbuCn2+rGf8ONpDPUvLR8wSaPSnOZX1qf1oGAV4C2TLEokU=
X-Received: by 2002:a17:90b:3b48:b0:26d:1e2d:51a7 with SMTP id
 ot8-20020a17090b3b4800b0026d1e2d51a7mr2465522pjb.37.1693410206364; Wed, 30
 Aug 2023 08:43:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230830004549.16131-1-anthony.yznaga@oracle.com>
In-Reply-To: <20230830004549.16131-1-anthony.yznaga@oracle.com>
From:   Brian Geffon <bgeffon@google.com>
Date:   Wed, 30 Aug 2023 11:42:50 -0400
Message-ID: <CADyq12xd+o0fjkjh-MzDmopC94XSxMCKVnQ+jcBr3yJdx+v7sg@mail.gmail.com>
Subject: Re: [PATCH] mm/mremap: fix unaccount of memory on vma_merge() failure
To:     Anthony Yznaga <anthony.yznaga@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, 0x7f454c46@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:46=E2=80=AFPM Anthony Yznaga
<anthony.yznaga@oracle.com> wrote:
>
> Fix mremap so that only accounted memory is unaccounted if the
> mapping is expandable but vma_merge() fails.
>
> Fixes: fdbef6149135 ("mm/mremap: don't account pages in vma_to_resize()")
> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>

Looks correct to me.

Acked-by: Brian Geffon <bgeffon@google.com>

> ---
>  mm/mremap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/mm/mremap.c b/mm/mremap.c
> index 056478c106ee..07cdb04d4ab5 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -1037,12 +1037,14 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsi=
gned long, old_len,
>                         pgoff_t extension_pgoff =3D vma->vm_pgoff +
>                                 ((extension_start - vma->vm_start) >> PAG=
E_SHIFT);
>                         VMA_ITERATOR(vmi, mm, extension_start);
> +                       long charged =3D 0;
>
>                         if (vma->vm_flags & VM_ACCOUNT) {
>                                 if (security_vm_enough_memory_mm(mm, page=
s)) {
>                                         ret =3D -ENOMEM;
>                                         goto out;
>                                 }
> +                               charged =3D pages;
>                         }
>
>                         /*
> @@ -1058,7 +1060,7 @@ SYSCALL_DEFINE5(mremap, unsigned long, addr, unsign=
ed long, old_len,
>                                 vma->vm_file, extension_pgoff, vma_policy=
(vma),
>                                 vma->vm_userfaultfd_ctx, anon_vma_name(vm=
a));
>                         if (!vma) {
> -                               vm_unacct_memory(pages);
> +                               vm_unacct_memory(charged);
>                                 ret =3D -ENOMEM;
>                                 goto out;
>                         }
> --
> 2.39.3
>
