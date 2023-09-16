Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0CC17A318A
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 18:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbjIPQ73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 12:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbjIPQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 12:59:27 -0400
X-Greylist: delayed 371 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 16 Sep 2023 09:59:21 PDT
Received: from gimli.kloenk.dev (gimli.kloenk.dev [49.12.72.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C389FCE6;
        Sat, 16 Sep 2023 09:59:21 -0700 (PDT)
From:   Finn Behrens <me@kloenk.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kloenk.dev; s=mail;
        t=1694883185; bh=nWGwgmmnK3ZOQJK9jZxfBWhNPoPb5iXem0OHGBHZCnE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=WLkYm4EqB01idHH0krmlQZQtpP3lhhbbMXGaXsYrJ4C7RaQ5aUrLuE25GLGXKTVD3
         femeJ90yi22Dj2aHpOhNxqY7qZrg/CuMwLLnA3jQsiYthviMM1G+NgMLkJ1t1hxECL
         tWuvPQaaAYYNGI1pYR+0eLhw5uewYpesUG2caeWw=
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
Date:   Sat, 16 Sep 2023 18:52:51 +0200
Message-ID: <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
In-Reply-To: <20230915172900.3784163-1-mmaurer@google.com>
References: <20230915172900.3784163-1-mmaurer@google.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15 Sep 2023, at 19:28, Matthew Maurer wrote:

> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined=
,
> resulting in build failures in hermetic environments where `cc` does no=
t
> exist. This includes both hostprogs and proc-macros.
>
> Since we are setting the linker to `HOSTCC`, we set the linker flavor t=
o
> `gcc` explicitly.
But as `HOSTCC` could also be clang, the linker flavor would then be wron=
g, would that create a problem?
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  rust/Makefile         | 1 +
>  scripts/Makefile.host | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..2a2352638f11 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -383,6 +383,7 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o =
FORCE
>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro =3D \
>  	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> +		-C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
>  		--emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --extern proc_macr=
o \
>  		--crate-type proc-macro \
>  		--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 8f7f842b54f9..0aa95a3af1c4 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -91,6 +91,7 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
>  # current working directory, which may be not accessible in the out-of=
-tree
>  # modules case.
>  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) =
\
> +		 -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
>                   $(HOSTRUSTFLAGS_$(target-stem))
>
> -- =

> 2.42.0.459.ge4e396fd5e-goog
