Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C9A6780F81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378296AbjHRPqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378292AbjHRPpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:45:47 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7CBF;
        Fri, 18 Aug 2023 08:45:46 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-48be61950aeso374159e0c.1;
        Fri, 18 Aug 2023 08:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692373545; x=1692978345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ls3ALkFSoDTpx8/mKPc9zSMNgW/T408i4zWcAjGPcxI=;
        b=bYEC44XZGPKIlC2sahzxuEV7OW5jukbNbgWx+9uKGKJTg695W2EB17Yl9/a7bNIBNB
         SKrTi8magbWMOJjor4n+WEuvx/1dS6o/Zxd50OsZw0Dojjtp5N3CUR5G6l9W5Qu4rMtG
         +S+GZ8LOBJW9lvQYlfQIOEuFgQO6mnjyeQyoHRRoweRYIGRoLsqBU1V3fywp4ia4xiMs
         OlnYFEwEJV6Evd7ssYXQk2M2FYV3A5j9MIfywCc8qoOAXioSBAvdwxfE0KqfWXFA95kZ
         naAml3ihdI5Y6o6pv4lGQt1g9iuTxgu5WvAXCantNLYheyuGawTIJMPy+ey4+QxYHUuj
         YyMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692373545; x=1692978345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ls3ALkFSoDTpx8/mKPc9zSMNgW/T408i4zWcAjGPcxI=;
        b=B3FALLXHTwITRff/OyN2hNuVsTVa3q6jIFGxhRIP2ZbknaH2hb6jQDdOeen/ngMUQU
         orWNJBOLlS12R/GnbIUZCMG4YdsGyscVAyl9dU8oRFLszbf+KXVj/spE9rLLgw51Rb3W
         iq18C8Gf0Q3u1Lhb6Q8T+8/NE/ouhciVmkuVBXsQGIOOWjAP7Of58ubAbv/PBaI6GZi9
         VsYhDEkUWJ9ioCO0wQwYL2DU5in3Vd1e0WxR+DhXPNrxV5dBKkNfiowb6vKJc0ob6HPs
         iRmX/2AIYC7G5NGJkYEIugqQYrfOd89ScGYnwUkYI5t8l7NC+g9YttLrqh5jejQYDY/4
         ewuQ==
X-Gm-Message-State: AOJu0YwjlGk7a7Bnw5JfZGYQNJ6iOxOjtrPmrsag5owb2927uOocTEB9
        OoLcQBBSowDnsGa59lJ709MhiMvxtcD4sd25UeM1l6a8gr0=
X-Google-Smtp-Source: AGHT+IEgMr/Tt1FyAdgsdbISXPKZ7gGaYDHy4Huv/zaHy39yqdNDrnkZBwCK+WMWnL9ibolC4XSCXsFAikTz0iI8O0k=
X-Received: by 2002:a05:6102:7da:b0:447:46e7:1348 with SMTP id
 y26-20020a05610207da00b0044746e71348mr4010409vsg.5.1692373545463; Fri, 18 Aug
 2023 08:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230818092022.111054-1-mengferry@linux.alibaba.com>
In-Reply-To: <20230818092022.111054-1-mengferry@linux.alibaba.com>
From:   Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date:   Sat, 19 Aug 2023 00:45:29 +0900
Message-ID: <CAKFNMom=ZM+YBCr-5UcjxGZY9O75RpNM4O4UqDecZPOgMqtctg@mail.gmail.com>
Subject: Re: [PATCH] nilfs2: fix dereferencing freed memory
To:     Ferry Meng <mengferry@linux.alibaba.com>
Cc:     linux-nilfs@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 6:20=E2=80=AFPM Ferry Meng wrote:
>
> Fix smatch warning:
>
> fs/nilfs2/gcinode.c:103 nilfs_gccache_submit_read_data() error:
> dereferencing freed memory 'bh'
>
> Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
>
> diff --git a/fs/nilfs2/gcinode.c b/fs/nilfs2/gcinode.c
> index 48fe71d309cb..6319e825f317 100644
> --- a/fs/nilfs2/gcinode.c
> +++ b/fs/nilfs2/gcinode.c
> @@ -73,10 +73,8 @@ int nilfs_gccache_submit_read_data(struct inode *inode=
, sector_t blkoff,
>                 struct the_nilfs *nilfs =3D inode->i_sb->s_fs_info;
>
>                 err =3D nilfs_dat_translate(nilfs->ns_dat, vbn, &pbn);
> -               if (unlikely(err)) { /* -EIO, -ENOMEM, -ENOENT */
> -                       brelse(bh);
> +               if (unlikely(err)) /* -EIO, -ENOMEM, -ENOENT */
>                         goto failed;
> -               }
>         }
>
>         lock_buffer(bh);
> @@ -102,6 +100,8 @@ int nilfs_gccache_submit_read_data(struct inode *inod=
e, sector_t blkoff,
>   failed:
>         unlock_page(bh->b_page);
>         put_page(bh->b_page);
> +       if (err)
> +               brelse(bh);
>         return err;
>  }
>
> --
> 2.19.1.6.gb485710b
>

Ah, this is almost identical to the patch Pan Bian sent me earlier.
After a closer look, I'll pick up his patch instead with a
"Reported-by" tag of your name on it.

Anyway, thanks for your feedback.

Regards,
Ryusuke Konishi
