Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52178E0A4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbjH3U2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239114AbjH3U2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:28:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C8CA1FD6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:26:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50078eba7afso434484e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693427124; x=1694031924; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xGxGsSt4NIbvMer12GEtMD95qVZZXJT3njM8Rf3Knrg=;
        b=E0Uhq+unadQK4VCdjTvcB/iAMFGJUXe4zx9Vstv8BnvqAd5Lqwva54ccKgLOwMs/of
         m60fprPBZYZR+jSGDFlpGV0sWT4weZ08SDH0wY/Yzct5Dud9qkNBR9BXxbTLHHE+h96u
         wvAce5X982xuOZykNYBT1n+x+Cu/PNRvn4KWeB/oDTWEP22yxzetPF3rB6HkotdSDiPf
         nZLkwQiBJp+zdhHx3oVT/zfVx7BknOAduuTSRT7r7XS+90sjLSo+25hYow9g2WtsPf/k
         AvxY72yBzcolyzQoATih/pfs1dJSid2dSypXR/gJ6kon0K7s9m4yP/vHHaGMAWzXCIqI
         QZWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693427124; x=1694031924;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xGxGsSt4NIbvMer12GEtMD95qVZZXJT3njM8Rf3Knrg=;
        b=Y1aEWfREZC0csPmH5uqNk8Rk8/feVStxiiyb/coVgVCq9ZcsPpDMboNNdP1A78+AfB
         n4LnKxvLVjYOe/zPaFFH1H2YibLKpgUnm7wyoQweSYJ7OauQenCz3HvkEBNYkR5UHq4T
         3kI74ItEgaXP3N+9qaA04CXVETwwHb+mu5phRJhzOLi99rF03Ui339XV5+8e67ekQjCK
         X4s7kAOjUS6FVVA9Hj9b99aHAiFueGxdBPKhU+Ap4Y4n5FVeBSJyYmCLyfOI5Mi3R7Gp
         ZGIoVmv+9loccpzcYoPegcb5XnKl7F9AhIkWgbP3O7f0GH+OJYNPYREQmUljeiSovMMv
         TSag==
X-Gm-Message-State: AOJu0YycWT51t4PaJzR7Kw1SaKT0S0VH/mvmUTmm1i71qsbkYcaOAV4J
        oqc7x1KGcMAHXmYsSiPvp1ISCxuVEybxTLCPIecQaHxlPKgZ93ev6gidQQ==
X-Google-Smtp-Source: AGHT+IGvr8r7wcRDT1BESk7m579e6n9dy6u1pTfteN4ENqgGAendGDssO0IA1rpPNl/A0Cq/tJqaVjI3NhqNnSurerw=
X-Received: by 2002:aa7:d1c7:0:b0:523:c10d:1d5b with SMTP id
 g7-20020aa7d1c7000000b00523c10d1d5bmr2630745edp.37.1693426126942; Wed, 30 Aug
 2023 13:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
In-Reply-To: <20230830160806.3821893-1-azeemshaikh38@gmail.com>
From:   Justin Stitt <justinstitt@google.com>
Date:   Wed, 30 Aug 2023 13:08:35 -0700
Message-ID: <CAFhGd8q3CutOKOcJpny=-5SuMWvMy0EZOLQHLkLuu_BOAPOMig@mail.gmail.com>
Subject: Re: [PATCH] init/version.c: Replace strlcpy with strscpy
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-hardening@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
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

On Wed, Aug 30, 2023 at 12:29=E2=80=AFPM Azeem Shaikh <azeemshaikh38@gmail.=
com> wrote:
>
> strlcpy() reads the entire source buffer first.
> This read may exceed the destination size limit.
> This is both inefficient and can lead to linear read
> overflows if a source string is not NUL-terminated [1].
> In an effort to remove strlcpy() completely [2], replace
> strlcpy() here with strscpy().
>
> Direct replacement is safe here since return value of -errno
> is used to check for truncation instead of sizeof(dest).

Great patch! This is similar to [1] which aims to eradicate strncpy.

>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcp=
y
> [2] https://github.com/KSPP/linux/issues/89
>
> Signed-off-by: Azeem Shaikh <azeemshaikh38@gmail.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>

> ---
>  init/version.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/init/version.c b/init/version.c
> index f117921811b4..94c96f6fbfe6 100644
> --- a/init/version.c
> +++ b/init/version.c
> @@ -21,10 +21,10 @@ static int __init early_hostname(char *arg)
>  {
>         size_t bufsize =3D sizeof(init_uts_ns.name.nodename);
>         size_t maxlen  =3D bufsize - 1;
> -       size_t arglen;
> +       ssize_t arglen;
>
> -       arglen =3D strlcpy(init_uts_ns.name.nodename, arg, bufsize);
> -       if (arglen > maxlen) {
> +       arglen =3D strscpy(init_uts_ns.name.nodename, arg, bufsize);
> +       if (arglen < 0) {
>                 pr_warn("hostname parameter exceeds %zd characters and wi=
ll be truncated",
>                         maxlen);
>         }
> --
> 2.41.0.255.g8b1d071c50-goog
>
>

[1]: https://github.com/KSPP/linux/issues/90
