Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAD97B3E8A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 07:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234015AbjI3F70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 01:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjI3F7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:59:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FB51AB;
        Fri, 29 Sep 2023 22:59:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A14C43395;
        Sat, 30 Sep 2023 05:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696053561;
        bh=fEN/S6mVsSDNV0g4PBlvUaE2VUJdNNjgVZ+Xtar4unE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jr7i7wgkNdL6Y8zEWyvi5nBrCFgRd7bSuk6cLgxK67kkorEKo48vijY4DenStKNc9
         pwG5cS56mxBLCh8ucvI8a1Mzidbx+V4E2jQahFgerDpxwNk2vfOsYpKDpqsbnO4F5s
         Z3OkmpQepD5VNw99P29rkUOriPTvtdRrW7pbWN+r6VirTBO+Qc3bB9Kai6EWixggKW
         qf6CyA1Nzqy3OO831ByicN9VkrFBzv/su7MdxK4cYLZyVAS6HDX7qLKfujLpoKdoCn
         Sx8ellEqDgmvSxdf6blQmCx5l6XA7V13adGOZUMnOdTxunY3IECNF5FzQreRYG11Hw
         HabW0qll/rgNg==
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1dce0c05171so6648989fac.3;
        Fri, 29 Sep 2023 22:59:21 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzd2TqML4IZCZRj6k5n2ENUh3AF/E1d35FRRqbSH/1/Qr1q7eNA
        73CttS6kUF4debVsepqNWuXs16rklq56ClWSLNk=
X-Google-Smtp-Source: AGHT+IFKcDm5fCe1sGczV8wBd4zz/FAmio9dMBK8EbaraHgpWebWUkbRDlLwZeet8rw3+QxNOAa9smfzO/vfW/H4jC8=
X-Received: by 2002:a05:6870:2216:b0:1c0:937:455d with SMTP id
 i22-20020a056870221600b001c00937455dmr6904202oaf.47.1696053560507; Fri, 29
 Sep 2023 22:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230928194801.2278999-1-mmaurer@google.com>
In-Reply-To: <20230928194801.2278999-1-mmaurer@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Sep 2023 14:58:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQP9FVCArnw=JDBbtbu-3bxx162kqT24bUbffPtwE18uA@mail.gmail.com>
Message-ID: <CAK7LNAQP9FVCArnw=JDBbtbu-3bxx162kqT24bUbffPtwE18uA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
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

On Fri, Sep 29, 2023 at 4:48=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
>
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly. The linker-flavor selects both which linker to search
> for if the linker is unset, and which kind of linker flags to pass.
> Without this flag, `rustc` would attempt to determine which flags to
> pass based on the name of the binary passed as `HOSTCC`. `gcc` is the
> name of the linker-flavor used by `rustc` for all C compilers, including
> both `gcc` and `clang`.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>  rust/Makefile         | 2 ++
>  scripts/Makefile.host | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..da664d7aed51 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -383,6 +383,8 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FO=
RCE
>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro =3D \
>         $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> +               -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> +               -Clink-args=3D'$(subst ','\'',$(KBUILD_HOSTLDFLAGS))' \



Why not consistently use the escsq macro here too ?






>                 --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --exter=
n proc_macro \
>                 --crate-type proc-macro \
>                 --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 8f7f842b54f9..08d83d9db31a 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -91,6 +91,8 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
>  # current working directory, which may be not accessible in the out-of-t=
ree
>  # modules case.
>  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) \
> +                -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> +                -Clink-args=3D'$(call escsq,$(KBUILD_HOSTLDFLAGS))' \
>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
>                   $(HOSTRUSTFLAGS_$(target-stem))
>
> --
> 2.42.0.582.g8ccd20d70d-goog
>


--
Best Regards
Masahiro Yamada
