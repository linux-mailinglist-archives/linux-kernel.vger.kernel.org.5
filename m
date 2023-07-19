Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0626759131
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 11:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGSJJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGSJJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 05:09:11 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F5A19F;
        Wed, 19 Jul 2023 02:09:08 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-440b4b0147bso1447837137.1;
        Wed, 19 Jul 2023 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689757748; x=1692349748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8fT+DNDdqPeCsHA6TjEc6nVyJDv1yc5mQ8emGSQPENg=;
        b=FxxYv6Kio4HImvxczRigcO/VYjulUgXQCvNDtxO+FqOvF6GbWU4uslqUOT825dCRTf
         vV5LwAN98Bpi1tSFAefeVRC2iHHjxXIe6aPPZxIiBubUHpVbwEm7JouyPuwtFo57SAiC
         VlX96pF5JiCKogdYo4oExRgD/gSlQ2zfB4ttc7HRSW06gOkwmC4pqAewCiwISEdzhSbR
         qgA/OJNK7Ek49Cb82jtk6dIm458Kd6ZLmwGeCQAG4l7w/FtSfyYGozjxkoHGrWRlOE0b
         8zS94HsL399NHj0/6J/0wKXL1BZ87+TvF1tOxm++RqugmL9bms3bvWgoAJLqotkdzjI7
         4E8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689757748; x=1692349748;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fT+DNDdqPeCsHA6TjEc6nVyJDv1yc5mQ8emGSQPENg=;
        b=T2ymlpb+690vJfiRJO4waQEh6yOvKG9Xm8bfNR+6dryxSF196korAPn8gND9rFuf93
         RwgtqEke9c13jES0VqWvGMPS+u3OrEc8nP+0mgl8AWX/IN4mhOpFCwOugduttvI0/oPk
         nAayss+lFnc9cRHYJe2wErCrhCF8zKCYCW79hu9S5sBUEW1fMWaLbpFCk3vDQM7iX6cz
         h+vx00CWNDQbSgv3W78zQcpWltIf2RgCKsoTU0NW0Eg2foTUn+oQ8YoXiX08I6++B6vQ
         QuOZpbEv99SCywy+AB1LMmAoBtN78UAVLYiLASQUAT3n8q1VEb+YOJefvNtlipDGh7pG
         Z3yQ==
X-Gm-Message-State: ABy/qLbS+IIw+DIF9eG9QbdiI4kW5hlySdQk+KY2tWFcOmjxOy2byysT
        3YeqZtqtIszJRaYQaNfvUSCW1jh6rIiETWLU7LI=
X-Google-Smtp-Source: APBJJlGH+YsOaadmXcy97JvMmyhQwkCiSNei67C7NlIFW9T1/Om4oOGbrdqgSy3I8U7PcZZby11U/jtBJ4t4AiEkIp0=
X-Received: by 2002:a67:f918:0:b0:445:55a:7ca3 with SMTP id
 t24-20020a67f918000000b00445055a7ca3mr6252859vsq.22.1689757747851; Wed, 19
 Jul 2023 02:09:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230719085434.154834-1-yunlong.xing@unisoc.com>
In-Reply-To: <20230719085434.154834-1-yunlong.xing@unisoc.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 19 Jul 2023 12:08:56 +0300
Message-ID: <CAOQ4uxhkiJ5weS575TLF+Xr83ZekwpqRC683dTDv8zsRYoj9+A@mail.gmail.com>
Subject: Re: [PATCH V2] ovl: fix mount fail because the upper doesn't have space
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com, yunlongxing23@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 11:54=E2=80=AFAM Yunlong Xing <yunlong.xing@unisoc.=
com> wrote:
>
> The current ovlfs mount flow:
>
> ovl_fill_super
>  |_ovl_get_workdir
>     |_ovl_make_workdir
>        |_ovl_check_rename_whiteout
>
> In ovl_check_rename_whiteout(), a new file is attempted to create.But if
> the upper doesn't have space to do this, it will return error -ENOSPC,
> causing the mount fail. It means that if the upper is full, the overlayfs
> cannot be mounted.It is not reasonable, so this patch will omit this erro=
r
>  and continue mount flow.
>
> Fixes: cad218ab3320 ("ovl: check if upper fs supports RENAME_WHITEOUT")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
> ---
> changes of v2: Following Amir's suggestion, assuming it is not supported
> if the check fails because the upper does't have space
> ---

Reviewed-by: Amir Goldstein <amir73il@gmail.com>

>  fs/overlayfs/super.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 5b069f1a1e44..2b33c56fe4d7 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -744,12 +744,13 @@ static int ovl_make_workdir(struct super_block *sb,=
 struct ovl_fs *ofs,
>
>         /* Check if upper/work fs supports RENAME_WHITEOUT */
>         err =3D ovl_check_rename_whiteout(ofs);
> -       if (err < 0)
> +       if (err < 0 && err !=3D -ENOSPC)
>                 goto out;
>
> -       rename_whiteout =3D err;
> +       rename_whiteout =3D err > 0;
>         if (!rename_whiteout)
> -               pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
> +               pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\=
n,
> +                       err");
>
>         /*
>          * Check if upper/work fs supports (trusted|user).overlay.* xattr
> --
> 2.25.1
>
