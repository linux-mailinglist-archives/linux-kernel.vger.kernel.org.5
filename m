Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC47E07B7
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjKCRoh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjKCRof (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:44:35 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34D19136;
        Fri,  3 Nov 2023 10:44:33 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-7ba7b361b22so1011209241.1;
        Fri, 03 Nov 2023 10:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699033472; x=1699638272; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kZL7aD2LIQS1QMUnxLSKHT0y6kq3jGESZfcc0nsmv6c=;
        b=SQnIZ6ZU5g5MzGgAHJ2j41NLx68v4vNuJtjxHPY2nhM7NB2CjUQlWanSTMKs00SMjP
         s5yB1kmKrNFvYnjRTIAmMZbzxdUlDLR1n2zesz5mVOJp9lDmkT6ZYgcY/k3JnU4wjVMY
         S1DYTJ8tcfLhlkYKD83+tSz3kKned84ZwtQJjhlnKKd4UTBk67mkRokYaelpVXqkxS0F
         VE6c+oNnzcca9ncSoMoORizZB0YVZJfUk3IeHC4FdF6KcKZZrDN2WWT+WAY6XE8mY+6U
         UhVvDnCH9Bgmgw5fGp6xC5xPGyECZxbj9YPXVoUt9v+RAX7bl0U4+qOswmltbR/PKv5C
         8wUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699033472; x=1699638272;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kZL7aD2LIQS1QMUnxLSKHT0y6kq3jGESZfcc0nsmv6c=;
        b=rO7QBMmqJf+VpVb7idIZQnbVuNXFtWzI4X7VFfhA0NJi4sHJJoTx2//6qVs8cmpa4N
         mKFz/0eiMkccRDJhBcfCAbmgXFZ5wa2cpxJJ1FqalQWX+QZ4CAtUZZ/CECqvWWKp3M+H
         ssPH7DS/EHoLbBzgodF/9Oq6DtFgICAVJylBvoiL0UW9N+a4URmvf54cj0fZxFfTcwic
         XvJS73VPOQF1KajS0DHPcigGljyP+SHxZ2Fem7bIvKZtmNAi5i7NsagTOadNg2IFXLy+
         afRJKCe67FsmMnuIdKe46xOf2W8R1I11oN6z+0gcAopopte6bm2hZA768SfucNTp1A+y
         I/kg==
X-Gm-Message-State: AOJu0Yw1a3jZRFwYChYPxRMptAPSpx08SM+uAQL7f+O3AWD7VWSH+TCf
        SQrQNckOUB32Q2RI0bVwy6G7yhaxkEQ2u8gmuR1CicjiPPo=
X-Google-Smtp-Source: AGHT+IGnPqSfc3yOvW0vZu/JaSIPHddLzKRRYt0Yi3+QaQOCtFbPF4jf3HM2qjyAxiHLK4o3pafMhQ5xnd1LqPFvQo0=
X-Received: by 2002:a67:f581:0:b0:45b:6d6b:1843 with SMTP id
 i1-20020a67f581000000b0045b6d6b1843mr17000210vso.0.1699033471708; Fri, 03 Nov
 2023 10:44:31 -0700 (PDT)
MIME-Version: 1.0
References: <20231102183751.47413-1-pstanner@redhat.com>
In-Reply-To: <20231102183751.47413-1-pstanner@redhat.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 4 Nov 2023 02:44:15 +0900
Message-ID: <CAKFNMok9WTV5uX3BBfr8eYiuJXvUY6TuYW=tQYvBzdCUYsxcwA@mail.gmail.com>
Subject: Re: [PATCH] fs/nilfs2: copy userspace-array safely
To:     Philipp Stanner <pstanner@redhat.com>
Cc:     linux-nilfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dave Airlie <airlied@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 3, 2023 at 3:38=E2=80=AFAM Philipp Stanner wrote:
>
> ioctl.c utilizes memdup_user() to copy a userspace array. This is done
> without an overflow-check.
>
> Use the new wrapper memdup_array_user() to copy the array more safely.
>
> Suggested-by: Dave Airlie <airlied@redhat.com>
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
> Linus recently merged this new wrapper for Kernel v6.7

The following overflow check is performed just before the usage of
memdup_user():

        if (nsegs > UINT_MAX / sizeof(__u64))
                goto out;

This was introduced by commit 1ecd3c7ea76488 ("nilfs2: avoid
overflowing segment numbers in nilfs_ioctl_clean_segments()") to avoid
overflowing nsegs * sizeof(__u64) in the subsequent call to
memdup_user().

I learned about memdup_array_user() this time, and it seems to check
for overflow when multiplying two size_t arguments (i.e. the number of
elements and size of the array to be copied).

Since size_t is 32-bit or 64-bit depending on the architecture, I
think the overflow check that memdup_array_user() does
is included in the above upper limit check by UINT_MAX.

So, for security reasons, I don't think this change is necessary.  (Am
I missing something?)

In terms of cleanup, I think the clarification this patch brings is
good, but in that case, I'm concerned about the duplication of
overflow checks.

Thanks,
Ryusuke Konishi

> ---
>  fs/nilfs2/ioctl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index 40ffade49f38..6a9dceebb18d 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -877,11 +877,11 @@ static int nilfs_ioctl_clean_segments(struct inode =
*inode, struct file *filp,
>
>         /*
>          * argv[4] points to segment numbers this ioctl cleans.  We
> -        * use kmalloc() for its buffer because memory used for the
> -        * segment numbers is enough small.
> +        * use kmalloc() for its buffer because the memory used for the
> +        * segment numbers is small enough.
>          */
> -       kbufs[4] =3D memdup_user((void __user *)(unsigned long)argv[4].v_=
base,
> -                              nsegs * sizeof(__u64));
> +       kbufs[4] =3D memdup_array_user((void __user *)(unsigned long)argv=
[4].v_base,
> +                                    nsegs, sizeof(__u64));
>         if (IS_ERR(kbufs[4])) {
>                 ret =3D PTR_ERR(kbufs[4]);
>                 goto out;
> --
> 2.41.0
>
