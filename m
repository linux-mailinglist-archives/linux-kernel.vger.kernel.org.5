Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85C43757A8D
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbjGRLiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjGRLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:38:02 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11941AC;
        Tue, 18 Jul 2023 04:38:00 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-794cddcab71so1600879241.1;
        Tue, 18 Jul 2023 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689680280; x=1692272280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5jbeHfHwPHH+SDgR4pal5407gINcU5129rjy4niAm4I=;
        b=RLeELrML8LJOb/+BHNCEb+DOM8te0apNEn6BWKR7Kc6lnE8AlRdTHvVcnXNTLjEnCT
         I59oAhZ4l1OLRA3/fup63Ey/PEnUwB3RghAiXoRikz7pa+YMwkPzzEK7ZZy4bjVUoSpa
         CfAX9iLI2ORpTsdqQtyxuNtr+oKQnt9xh0xhvgZV+7PenpfuPEejNG0zFUy6HRCTjBmH
         lTfFr1jr2+PCz747zKg7Dt79sjqbTRjtOxxjyqz9IoUrNfUZ5EL/2HYPDglmuY9NxOyO
         1Y0Z7zdX/0iXLrNGLxyH/jy9Su9fpgvA3p0mQdFADU4jXRjQ6QIRWp+fpXXiDoPa65Tk
         pU8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689680280; x=1692272280;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5jbeHfHwPHH+SDgR4pal5407gINcU5129rjy4niAm4I=;
        b=b9qGnqbyZGXSk9NDNt+eJhLmsaQSS6p3sZ4L1XkL3MmPpoeZMXFEuKkY+bMNLi5eA5
         72yJP4PsKq6O3puVlLsRYp5teUCWchBMGvTYJ02jZXPcJ12XDO1MScXJJBBMLkDW5JJf
         r+w9l5cw+FZox6i6u+5y1zdLeQurKPg8TUXxLbcirt/lZ+DD3UhzaQ2YVQA16KXgIka6
         ouvCq4d67uHUOAFHUPXnqQwjnGKV15ZBqT3RqlFwFMJREijpjzAvCMISGrTT6WsZHyFM
         JuHjDARdq/1NjHHKOZYPTqLD/OgiwDFaYUEmEV9xnMe4QQ1gvnGRpPuvdOMgxEe8ERzV
         jH1g==
X-Gm-Message-State: ABy/qLaWrIcgv3A4qdiXvygx/h9hX2VYtMYCM4FOaQhChnmJG9d3iqjU
        5oStaCxMm++Av/XzlbYd5jSmaV1yV1Ry+EHsyQDALBiIJy4=
X-Google-Smtp-Source: APBJJlFAOB53TF5+0bD2ZrmeVuGZqsn/sVtaca+ZKsNLKO6TV1RuYVsQLukOUfVqkCHf58kZ95x9sqU332fjBsRdaJA=
X-Received: by 2002:a67:e3d1:0:b0:445:2154:746b with SMTP id
 k17-20020a67e3d1000000b004452154746bmr1094389vsm.4.1689680279701; Tue, 18 Jul
 2023 04:37:59 -0700 (PDT)
MIME-Version: 1.0
References: <1689669277-15291-1-git-send-email-yunlong.xing@unisoc.com>
In-Reply-To: <1689669277-15291-1-git-send-email-yunlong.xing@unisoc.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 18 Jul 2023 14:37:48 +0300
Message-ID: <CAOQ4uxgLhf8EyticTQUxtzUdVD=UEUTwQnTkujXE1KuaVxNQyQ@mail.gmail.com>
Subject: Re: [PATCH] ovl: fix mount fail because the upper doesn't have space
To:     Yunlong Xing <yunlong.xing@unisoc.com>
Cc:     miklos@szeredi.hu, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        gregkh@linuxfoundation.org, sashal@kernel.org,
        yunlongxing23@gmail.com, zhiguo.niu@unisoc.com,
        hongyu.jin@unisoc.com
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

On Tue, Jul 18, 2023 at 11:35=E2=80=AFAM Yunlong Xing <yunlong.xing@unisoc.=
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
> Signed-off-by: Yunlong Xing <yunlong.xing@unisoc.com>
> ---
>  fs/overlayfs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 5b069f1a1e44..2cf41e978cff 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -744,9 +744,12 @@ static int ovl_make_workdir(struct super_block *sb, =
struct ovl_fs *ofs,
>
>         /* Check if upper/work fs supports RENAME_WHITEOUT */
>         err =3D ovl_check_rename_whiteout(ofs);
> -       if (err < 0)
> -               goto out;
> -
> +       if (err < 0) {
> +               if (err =3D=3D -ENOSPC)
> +                       pr_warn("upper fs check RENAME_WHITEOUT fail due =
to no space.\n");
> +               else
> +                       goto out;
> +       }
>         rename_whiteout =3D err;
>         if (!rename_whiteout)
>                 pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
> --

This assumes that RENAME_WHITEOUT is supported.
I rather assume it is not supported if the check fails.
Like this is shorter (not tested):

--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -744,12 +744,13 @@ static int ovl_make_workdir(struct super_block
*sb, struct ovl_fs *ofs,

        /* Check if upper/work fs supports RENAME_WHITEOUT */
        err =3D ovl_check_rename_whiteout(ofs);
-       if (err < 0)
+       if (err < 0 && err !=3D -ENOSPC)
                goto out;

-       rename_whiteout =3D err;
+       rename_whiteout =3D err > 0;
        if (!rename_whiteout)
-               pr_warn("upper fs does not support RENAME_WHITEOUT.\n");
+               pr_warn("upper fs does not support RENAME_WHITEOUT (%i).\n"=
,
+                       err);

Thanks,
Amir.
