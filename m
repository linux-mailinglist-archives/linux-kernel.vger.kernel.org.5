Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026E77E1C9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 09:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjKFIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 03:47:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjKFIrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 03:47:39 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C00C9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 00:47:36 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40837124e1cso83655e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 00:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699260455; x=1699865255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nSdh9aVbvYJU/GlJs9OpXtR3as1eL/wmBH+XlHFyTXE=;
        b=dy62QEtqpJVO2ztNFZX4EAFPPHWQa3/P+9cwiDUdhDyPizttWHGQ9MzRD67V/NMhv8
         0g/AQda9YUva8f3WXjwS3Smd3sbWSeOHADxIo1QbFP4Kaq+hb76lLdl8LYiM6r4vaeWe
         Xiig033d2KC8h/sz+t9fUmudF3bsLEy8rTny8k1iscauI8zyUa3T64nEVMHv8VtUcwsQ
         Z9kHOgafbq60CQvbBBigMaploeWsBrg8fp4YBeov1+5g13q+RqTnlmxtFiTSrQ5JpklS
         hCpj4C2tqhwGbH9JYM+GJnN6Y8cEoRqTNtbvI/QZcmEqbGreguQVJ9GFLmPOLBD9ZKea
         RwMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699260455; x=1699865255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nSdh9aVbvYJU/GlJs9OpXtR3as1eL/wmBH+XlHFyTXE=;
        b=ZVmJNhU6nlCgkcZZIsLGHrAhGeliXiGiUS/Vx+gbRI4zUJ+b2wTeHWjpRr3U0koKkZ
         HhXdMIlXO/CBgO0O5/clfq97l7KY/FoyNSqegdH7RWqyVwd8UkvtNSBaRTOsabn1qDCE
         gPmlSMpGz6ZLauyW0W/F5I2QPgFiToruAdh03J0JKZemyuWIbjOSvO5D1d/yLAmLbJ4J
         jTd15Miyrqa5h8YzWYNKgSpO4mbORpmoq3IdFISOzD66zt+nFo0qqGDo2mRFFx4rlx3y
         KUH2fYFWjlqbZGJL/IOjGX7ypf4qjz3e+oxIkfLcaTfQpa467pPt8pk4PYSnjHOMT3WT
         SelA==
X-Gm-Message-State: AOJu0YxsToAOH74/uT4ZKlyOqq5jHSOTMiU/GHVO3ddvrwiWTLZVrd79
        cRUx1W743C4GI4fyOFRsrkmxiFizEWKzA4U+6Eyu
X-Google-Smtp-Source: AGHT+IFjXQo0PLW9gw8Q2YKPL+L1TqM4JvXj1Ok6lDJPEm3xegSNCTzZfYeZeWcdkpno4hNdNMtanwweUdv6h/AUNC8=
X-Received: by 2002:a05:600c:3b06:b0:400:c6de:6a20 with SMTP id
 m6-20020a05600c3b0600b00400c6de6a20mr94311wms.3.1699260455014; Mon, 06 Nov
 2023 00:47:35 -0800 (PST)
MIME-Version: 1.0
References: <20231104204334.work.160-kees@kernel.org>
In-Reply-To: <20231104204334.work.160-kees@kernel.org>
From:   Bill Wendling <morbo@google.com>
Date:   Mon, 6 Nov 2023 00:47:16 -0800
Message-ID: <CAGG=3QWX0Koj3xNHiRHdiYupy4bFsJ6nNWWcCJkqbu8-GnmfZA@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: randstruct: Only warn about true flexible arrays
To:     Kees Cook <keescook@chromium.org>
Cc:     KP Singh <kpsingh@kernel.org>, linux-hardening@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
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

On Sat, Nov 4, 2023 at 1:43=E2=80=AFPM Kees Cook <keescook@chromium.org> wr=
ote:
>
> The randstruct GCC plugin tried to discover "fake" flexible arrays
> to issue warnings about them in randomized structs. In the future
> LSM overhead reduction series, it would be legal to have a randomized
> struct with a 1-element array, and this should _not_ be treated as a
> flexible array, especially since commit df8fc4e934c1 ("kbuild: Enable
> -fstrict-flex-arrays=3D3"). Disable the 0-sized and 1-element array
> discovery logic in the plugin, but keep the "true" flexible array check.
>
> Cc: KP Singh <kpsingh@kernel.org>
> Cc: linux-hardening@vger.kernel.org
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311021532.iBwuZUZ0-lkp@i=
ntel.com/
> Fixes: df8fc4e934c1 ("kbuild: Enable -fstrict-flex-arrays=3D3")
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Bill Wendling <morbo@google.com>

> ---
>  scripts/gcc-plugins/randomize_layout_plugin.c | 10 ----------
>  1 file changed, 10 deletions(-)
>
> diff --git a/scripts/gcc-plugins/randomize_layout_plugin.c b/scripts/gcc-=
plugins/randomize_layout_plugin.c
> index 366395cab490..910bd21d08f4 100644
> --- a/scripts/gcc-plugins/randomize_layout_plugin.c
> +++ b/scripts/gcc-plugins/randomize_layout_plugin.c
> @@ -278,8 +278,6 @@ static bool is_flexible_array(const_tree field)
>  {
>         const_tree fieldtype;
>         const_tree typesize;
> -       const_tree elemtype;
> -       const_tree elemsize;
>
>         fieldtype =3D TREE_TYPE(field);
>         typesize =3D TYPE_SIZE(fieldtype);
> @@ -287,20 +285,12 @@ static bool is_flexible_array(const_tree field)
>         if (TREE_CODE(fieldtype) !=3D ARRAY_TYPE)
>                 return false;
>
> -       elemtype =3D TREE_TYPE(fieldtype);
> -       elemsize =3D TYPE_SIZE(elemtype);
> -
>         /* size of type is represented in bits */
>
>         if (typesize =3D=3D NULL_TREE && TYPE_DOMAIN(fieldtype) !=3D NULL=
_TREE &&
>             TYPE_MAX_VALUE(TYPE_DOMAIN(fieldtype)) =3D=3D NULL_TREE)
>                 return true;
>
> -       if (typesize !=3D NULL_TREE &&
> -           (TREE_CONSTANT(typesize) && (!tree_to_uhwi(typesize) ||
> -            tree_to_uhwi(typesize) =3D=3D tree_to_uhwi(elemsize))))
> -               return true;
> -
>         return false;
>  }
>
> --
> 2.34.1
>
>
