Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700C675DFF4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjGWFGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 01:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjGWFGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 01:06:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B9110D7;
        Sat, 22 Jul 2023 22:06:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 472F260C1F;
        Sun, 23 Jul 2023 05:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DDFC43391;
        Sun, 23 Jul 2023 05:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690088792;
        bh=RcmR2y8+8t1nMaDLo3EG2DyBfOGWDbEYicQEkeAfYL8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MMiO041S6v0e4pRkVWpsXAku5y8BstlIdJ9S9dDlSalUwoh60xSTIzlyPx9/dSRGi
         lA0A5RxT7oDHLZeii7tX7mHckcc8fP3Qte46jURM3H/AU4EJr/c6NyC0MpV23BWZ+p
         VcPIu+UM6QHBZvi70kJQktbFkV9ga1VvzjTHT3oFGlPv8k3vZHIemtHZQopFd+/hYw
         3JM3FFM6oEyOzGEa09pQZKHxYio4MlDyC7bnYfWapPqYnK1GWYKR85gKAeZvbejbde
         ReisEv5A/5xIhZKls1cdXpRDKOl5IZIi+F+dCxwgI0w9yzxW5dnoGIW/LHeoCrIt88
         2szKxw4G7cGJA==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-56344354e2cso2077680eaf.1;
        Sat, 22 Jul 2023 22:06:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLZVykwVbtnukLSCrc+d5c/o6z0XtJSd67GREMcG30qe8y9m8cI0
        KCSZsCxaUyqFdgMj5dKspUYTmnaDO0ziJhN0ukE=
X-Google-Smtp-Source: APBJJlEaBRLz1z4/yyBQEA47mU5zfWs0viX27L4DZi41LLNZIunKwGHLU39tghd5QO6NenF5flweuZukIFP9Xu723T4=
X-Received: by 2002:a4a:6f05:0:b0:566:f283:35ad with SMTP id
 h5-20020a4a6f05000000b00566f28335admr4448493ooc.8.1690088791870; Sat, 22 Jul
 2023 22:06:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org> <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
 <CANiq72kZjOGvRKoRxtgG=2DhJnMJK9TCQtTmeef_B=nLcLQD6g@mail.gmail.com>
 <CAK7LNASqumGb0xvSa8n4Heasz9BKxgk4mvzNXsfFhZE1G+Bxbg@mail.gmail.com> <CANiq72kD2wxXy2ri8sBhVJ4y-JJiq+kYt_MRZwuwB9uGkX-_jQ@mail.gmail.com>
In-Reply-To: <CANiq72kD2wxXy2ri8sBhVJ4y-JJiq+kYt_MRZwuwB9uGkX-_jQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 23 Jul 2023 14:05:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
Message-ID: <CAK7LNARm1LevTQVw1j5pQjp_gP=6-4CiwXLRDXbVH3bnC0OCxg@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Raphael Nestler <raphael.nestler@gmail.com>,
        Andrea Righi <andrea.righi@canonical.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 12:52=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Jul 20, 2023 at 8:35=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > Maybe, the following was a breakage.
> >
> > commit 295d8398c67e314d99bb070f38883f83fe94a97a
> > Author: Masahiro Yamada <masahiroy@kernel.org>
> > Date:   Sat Jan 7 18:18:15 2023 +0900
> >
> >     kbuild: specify output names separately for each emission type from=
 rustc
> >
> > Before that, rust_common_cmd had --out-dir.
>
> That's right, good catch!
>
> > BTW, do we also need to fix scripts/Makefile.host
> > in case the external module Makefile creates host programs?
>
> Indeed, we need it too. [1] would fix it (tested it with a trivial
> out-of-tree Rust hostprog).
>
> Do you want me to send it separately? i.e. to avoid losing the
> `Tested-by`s etc. that we already got for this one, which is the
> important one since that actually has users.
>
> The hostprogs fix is not really critical for stable, since it is
> unlikely there are users at all (we just got the first in-tree real
> user in the Rust+KUnit integration coming into 6.6), but I guess it
> does not hurt for the same reason.


Can you send v2 with the following squashed?


I think it makes sense to fix both if we add
Fixes: 295d8398c67e ("kbuild: specify output names separately for each
emission type from rustc")





> Thanks!
>
> Cheers,
> Miguel
>
> [1]
>
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 7aea9005e497..54adf2e2ec51 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -86,7 +86,7 @@ hostc_flags    =3D -Wp,-MMD,$(depfile) \
>  hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
>                   $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
>                   $(HOSTCXXFLAGS_$(target-stem).o)
> -hostrust_flags =3D --emit=3Ddep-info=3D$(depfile) \
> +hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) \
>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
>                   $(HOSTRUSTFLAGS_$(target-stem))



--=20
Best Regards
Masahiro Yamada
