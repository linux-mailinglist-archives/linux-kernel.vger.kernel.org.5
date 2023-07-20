Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D434775B56E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjGTRSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjGTRSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0457CC;
        Thu, 20 Jul 2023 10:18:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4FE9F61BA7;
        Thu, 20 Jul 2023 17:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE71C43397;
        Thu, 20 Jul 2023 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689873512;
        bh=F/C+gSA5qZQ2B3LD6hPsWWKc+LdUI/ORd3hYIi+2pCk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=G/aM/MIVcGavKF4lp/Kw/NvJHOYMkWcPmqmnfq2tTt4jUPEyUOqXto8dOZeP+Kmz4
         jH9qq3XHoJhEIQqvmC91ylyW+5FNi3VT70Xb3Zn9eAVdiPdOzf8HTdjjy4JNTXOmW3
         w6qIiXQnCzDYjOWHgZB+kSa60j+gYbHNoeIiA2zA/0pX+HuYmgPQ3ubl04UMDWM2fn
         96JpcgohHgYDHdgG0sbjWO6GZy6BNpoWIZ+fKAXb4A0OoY7EtjtRc28JH0UxNvP4qc
         VzQL3libBcNrfP7AcOUbYSEmpHgT2WdfhQ0pba5M3olycbtAVB8Sk8aTE2vIBO8NBN
         PfztX40rKq2wQ==
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5634808e16eso727417eaf.2;
        Thu, 20 Jul 2023 10:18:32 -0700 (PDT)
X-Gm-Message-State: ABy/qLaUf4PgHtmhGJMx106rt4nOeVa5pA3NVtQjzUnjJ100twXgRJwi
        NE3RdGhU65lTqaoYhBPSZQiIvjGKXtnoQS0Z8P0=
X-Google-Smtp-Source: APBJJlEcVFHNbYhoO24bj9DeyyO+DlNSschkMud5gv9dgwfJtxiGAo0mniIt2fy3hzGZOCnveB++u9BFc+HyVXcQPbQ=
X-Received: by 2002:a4a:5541:0:b0:566:efc4:e4fb with SMTP id
 e62-20020a4a5541000000b00566efc4e4fbmr554052oob.4.1689873511842; Thu, 20 Jul
 2023 10:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230718055235.1050223-1-ojeda@kernel.org>
In-Reply-To: <20230718055235.1050223-1-ojeda@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 21 Jul 2023 02:17:55 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
Message-ID: <CAK7LNAQ-hjW_19fjA+E-bQCrXcVPdN4-GvzAnEnYzna5KRVXew@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: avoid creating temporary files
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
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

On Tue, Jul 18, 2023 at 2:52=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> `rustc` outputs by default the temporary files (i.e. the ones saved
> by `-Csave-temps`, such as `*.rcgu*` files) in the current working
> directory when `-o` and `--out-dir` are not given (even if
> `--emit=3Dx=3Dpath` is given, i.e. it does not use those for temporaries)=
.
>
> Since out-of-tree modules are compiled from the `linux` tree,
> `rustc` then tries to create them there, which may not be accessible.
>
> Thus pass `--out-dir` explicitly, even if it is just for the temporary
> files.
>
> Reported-by: Raphael Nestler <raphael.nestler@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1015
> Reported-by: Andrea Righi <andrea.righi@canonical.com>
> Tested-by: Raphael Nestler <raphael.nestler@gmail.com>
> Tested-by: Andrea Righi <andrea.righi@canonical.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---



Applied to linux-kbuild/fixes. Thanks.

I believe this is a fix, so I will include it
in my next pull request.





>  scripts/Makefile.build | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6413342a03f4..82e3fb19fdaf 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -264,6 +264,9 @@ $(obj)/%.lst: $(src)/%.c FORCE
>
>  rust_allowed_features :=3D new_uninit
>
> +# `--out-dir` is required to avoid temporaries being created by `rustc` =
in the
> +# current working directory, which may be not accessible in the out-of-t=
ree
> +# modules case.
>  rust_common_cmd =3D \
>         RUST_MODFILE=3D$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
>         -Zallow-features=3D$(rust_allowed_features) \
> @@ -272,7 +275,7 @@ rust_common_cmd =3D \
>         --extern alloc --extern kernel \
>         --crate-type rlib -L $(objtree)/rust/ \
>         --crate-name $(basename $(notdir $@)) \
> -       --emit=3Ddep-info=3D$(depfile)
> +       --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile)
>
>  # `--emit=3Dobj`, `--emit=3Dasm` and `--emit=3Dllvm-ir` imply a single c=
odegen unit
>  # will be used. We explicitly request `-Ccodegen-units=3D1` in any case,=
 and
>
> base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
> --
> 2.41.0
>


--=20
Best Regards
Masahiro Yamada
