Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D239771057
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 17:29:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbjHEP0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 11:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHEP0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 11:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1693E139
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 08:26:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6CEC60BD3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151B5C433C7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 15:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691249211;
        bh=DJdW++qM5N/9Flw9MG0voqRtfYxSzi3VkHbg0FX+mmk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nv8JY5I+Mdwi6IJQdOWBwU159Dc8AUX6vfvzh2EC8Kc/ZLlMuUivTQPbN+rfshfNX
         d2WfDFqu3G5VE+kYjSwX4gxnMXMr5PUEOqT+6kMsJHDrHqdUk3jyR8s5vAoCNjieMK
         rARh/u1JaqxDBSY9bKl6qKJS/GNObr5Ke6u3+GZnXUwhdJPyeieSIkNOz7gm0uHorb
         xD78CTMhNF+a11a1Z/ipV08RLUk6oHx8ekEmPPYduDHnCh7sttCfp1A0pN5OE8WcB6
         4mFipEM0yff68KnrkITVg+MIUPVAqAUQrc+bDNdmh0uMPt0nX3G3abbnlfqb9a1TWz
         MdqqYMM9oRruQ==
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6bcade59b24so2636343a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 08:26:51 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzfw2GTD10mLklwpMpoltvUdZDJI1BeCXFZTpFjMaWTR2up92Sv
        Wn8cKnHBoN8xhmRrg1+cdMgrXQJ/SJ2gM8nb82U=
X-Google-Smtp-Source: AGHT+IEWA/0IZKHptHM+X4NhlA2BaOsWA1FG37/E1dHbuwp97Gq9QZM/HXUJOsl/7cx2wbXzHwwvp42Cenkf7FFLPhs=
X-Received: by 2002:a05:6870:41d2:b0:1b0:649f:e68a with SMTP id
 z18-20020a05687041d200b001b0649fe68amr5891104oac.25.1691249210228; Sat, 05
 Aug 2023 08:26:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
In-Reply-To: <20230804120536.2339722-1-linux@rasmusvillemoes.dk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 6 Aug 2023 00:26:14 +0900
X-Gmail-Original-Message-ID: <CAK7LNASs6TBUP5+OsO1KaU7s-Sd3rkP=XR_b+aGufL5vpFGY6A@mail.gmail.com>
Message-ID: <CAK7LNASs6TBUP5+OsO1KaU7s-Sd3rkP=XR_b+aGufL5vpFGY6A@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/setlocalversion: also consider annotated tags
 of the form vx.y.z-${file_localversion}
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 4, 2023 at 9:05=E2=80=AFPM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> Commit 6ab7e1f95e96 ("setlocalversion: use only the correct release
> tag for git-describe") was absolutely correct to limit which annotated
> tags would be used to compute the -01234-gabcdef suffix. Otherwise, if
> some random annotated tag exists closer to HEAD than the vX.Y.Z one,
> the commit count would be too low.
>
> However, since the version string always includes the
> ${file_localversion} part, now the problem is that the count can be
> too high. For example, building an 6.4.6-rt8 kernel with a few patches
> on top, I currently get
>
> $ make -s kernelrelease
> 6.4.6-rt8-00128-gd78b7f406397
>
> But those 128 commits include the 100 commits that are in
> v6.4.6..v6.4.6-rt8, so this is somewhat misleading.
>
> Amend the logic so that, in addition to the linux-next consideration,
> the script also looks for a tag corresponding to the 6.4.6-rt8 part of
> what will become the `uname -r` string. With this patch (so 29 patches
> on top of v6.4.6-rt8), one instead gets
>
> $ make -s kernelrelease
> 6.4.6-rt8-00029-gd533209291a2
>
> While there, note that the line
>
>   git describe --exact-match --match=3D$tag $tag 2>/dev/null
>
> obviously asks if $tag is an annotated tag, but it does not actually
> tell if the commit pointed to has any relation to HEAD. So remove both
> uses of --exact-match, and instead just ask if the description
> generated is identical to the tag we provided. Since we then already
> have the result of
>
>   git describe --match=3D$tag
>
> we also end up reducing the number of times we invoke "git describe".
>
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> ---
> v2: explicitly initialize desc to empty [Masahiro]

Applied to linux-kbuild.
Thanks.



>
>  scripts/setlocalversion | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
>
> diff --git a/scripts/setlocalversion b/scripts/setlocalversion
> index 3d3babac8298..e2f49e237565 100755
> --- a/scripts/setlocalversion
> +++ b/scripts/setlocalversion
> @@ -57,21 +57,37 @@ scm_version()
>                 return
>         fi
>
> -       # If a localversion*' file and the corresponding annotated tag ex=
ist,
> -       # use it. This is the case in linux-next.
> +       # mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
> +       # stable kernel:    6.1.7      ->  v6.1.7
> +       version_tag=3Dv$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0=
-9]+)\.0(.*)$/\1\2/')
> +
> +       # If a localversion* file exists, and the corresponding
> +       # annotated tag exists and is an ancestor of HEAD, use
> +       # it. This is the case in linux-next.
>         tag=3D${file_localversion#-}
> -       tag=3D$(git describe --exact-match --match=3D$tag $tag 2>/dev/nul=
l)
> +       desc=3D
> +       if [ -n "${tag}" ]; then
> +               desc=3D$(git describe --match=3D$tag 2>/dev/null)
> +       fi
> +
> +       # Otherwise, if a localversion* file exists, and the tag
> +       # obtained by appending it to the tag derived from
> +       # KERNELVERSION exists and is an ancestor of HEAD, use
> +       # it. This is e.g. the case in linux-rt.
> +       if [ -z "${desc}" ] && [ -n "${file_localversion}" ]; then
> +               tag=3D"${version_tag}${file_localversion}"
> +               desc=3D$(git describe --match=3D$tag 2>/dev/null)
> +       fi
>
>         # Otherwise, default to the annotated tag derived from KERNELVERS=
ION.
> -       #   mainline kernel:  6.2.0-rc5  ->  v6.2-rc5
> -       #   stable kernel:    6.1.7      ->  v6.1.7
> -       if [ -z "${tag}" ]; then
> -               tag=3Dv$(echo "${KERNELVERSION}" | sed -E 's/^([0-9]+\.[0=
-9]+)\.0(.*)$/\1\2/')
> +       if [ -z "${desc}" ]; then
> +               tag=3D"${version_tag}"
> +               desc=3D$(git describe --match=3D$tag 2>/dev/null)
>         fi
>
>         # If we are at the tagged commit, we ignore it because the versio=
n is
>         # well-defined.
> -       if [ -z "$(git describe --exact-match --match=3D$tag 2>/dev/null)=
" ]; then
> +       if [ "${tag}" !=3D "${desc}" ]; then
>
>                 # If only the short version is requested, don't bother
>                 # running further git commands
> @@ -81,8 +97,8 @@ scm_version()
>                 fi
>                 # If we are past the tagged commit, we pretty print it.
>                 # (like 6.1.0-14595-g292a089d78d3)
> -               if atag=3D"$(git describe --match=3D$tag 2>/dev/null)"; t=
hen
> -                       echo "$atag" | awk -F- '{printf("-%05d", $(NF-1))=
}'
> +               if [ -n "${desc}" ]; then
> +                       echo "${desc}" | awk -F- '{printf("-%05d", $(NF-1=
))}'
>                 fi
>
>                 # Add -g and exactly 12 hex chars.
> --
> 2.37.2
>


--=20
Best Regards
Masahiro Yamada
