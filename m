Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D96D17AF185
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjIZRDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIZRDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:03:24 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048A3E5;
        Tue, 26 Sep 2023 10:03:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B072C433C8;
        Tue, 26 Sep 2023 17:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695747796;
        bh=9mED4eKpjj9Ur/PRuc7rWRlqyOXRaHWAX1hUU0+idIU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QsvWBg2Qg19IjleOTBaFPabO854Zm8nRsbavEKImofml1Am9jaKk+r4Wo7KtJVuQH
         II2CzL6fTXLhu7E0iSpDMgwFIF/gFy+ixfvjihZK6115TmJWA2769Op3c9BYAHl7iS
         u9C8Rpu1G8TkJOVsuuKtuWmBsWnNG9qMqJMIkbKTZLL/n1oMCxZF4eI1XpNNsMnZYG
         We375T4Fa/hH6R2ZPzlDNC+d67g8TegHruArCnAEFySuWz+gdx4HGnc9WFvfwg5+73
         zO9+pYp2W+K3m8JlfFXDPb9scUYaQ6eaOmgKzQz0wHTyVY48eSJjWa5AWnl6GqQ5tk
         wvd8LSElf4j8A==
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-1dce01b6f2eso3811266fac.1;
        Tue, 26 Sep 2023 10:03:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywo7uiiMZwngvKueu2n5VW1nlh4Bp72efj5teEXF09DEaRm19z+
        251wuaMcHSCSt8OhPA8k/cywnWFGTCRncK3VeEE=
X-Google-Smtp-Source: AGHT+IG+sT59maIGuNwoFZzYMqgI+S6gDycz3usM1ScV1MgM9a8oIP9swU2ktS554Ry8Hxb/WwjaOqBVOxK/uZEYOIk=
X-Received: by 2002:a05:6870:ac91:b0:1dd:7f3a:ad11 with SMTP id
 ns17-20020a056870ac9100b001dd7f3aad11mr1645598oab.17.1695747795976; Tue, 26
 Sep 2023 10:03:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230918234412.363087-2-mmaurer@google.com>
In-Reply-To: <20230918234412.363087-2-mmaurer@google.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 27 Sep 2023 02:02:39 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQNwHPR7nPjLff2Gos2tTgDz6m_NYwBOB8U0tq+odZufQ@mail.gmail.com>
Message-ID: <CAK7LNAQNwHPR7nPjLff2Gos2tTgDz6m_NYwBOB8U0tq+odZufQ@mail.gmail.com>
Subject: Re: [PATCH v2] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
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

On Tue, Sep 19, 2023 at 8:44=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined,
> resulting in build failures in hermetic environments where `cc` does not
> exist. This includes both hostprogs and proc-macros.
>
> Since we are setting the linker to `HOSTCC`, we set the linker flavor to
> `gcc` explicitly.


This sentence is unclear to me because it does not explain
why we need both despite the spec mentions
'linker-flavor' is inferred from the value of 'linker'.



The answer exists in this thread.
"
As mentioned earlier, we could pass $HOSTLD, but if the linker isn't
named something accurate (e.g. if the linker is not named lld, but is
lld), we need to know how to pass a flavor:
"

Maybe it is worthing menting that HOSTCC may not be properly named.







>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>
> Updated the patch to reflect Nick's comment that KBUILD_HOSTLDFLAGS
> should be respected as well.
>
> I did not switch it to use HOSTLD for two reasons:
> * That variable is not globally defined - it is only available in two
>   subdirectories of tools/
> * C host scripts are linked by HOSTCC as well, even when linking a
>   collection of object files. It *prints* HOSTLD, but invokes HOSTCC.
>   See scripts/Makefile.host cmd_host-cmulti for an example.
>
>  rust/Makefile         | 4 ++++
>  scripts/Makefile.host | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..b60b7eb8c5a0 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -380,9 +380,13 @@ $(obj)/exports_bindings_generated.h: $(obj)/bindings=
.o FORCE
>  $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
>         $(call if_changed,exports)
>
> +KBUILD_HOSTLDFLAGS_SQ =3D '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'



This is equivalent to a macro in scripts/Kbuild.include

  escsq =3D $(subst $(squote),'\$(squote)',$1)





I would write it directly in cmd_rustc_procmacro.





> +
>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro =3D \
>         $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> +               -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> +               -Clink-args=3D$(KBUILD_HOSTLDFLAGS_SQ) \
>                 --emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --exter=
n proc_macro \
>                 --crate-type proc-macro \
>                 --crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> index 8f7f842b54f9..dc0410cae5ca 100644
> --- a/scripts/Makefile.host
> +++ b/scripts/Makefile.host
> @@ -87,10 +87,14 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
>                   $(KBUILD_HOSTCXXFLAGS) $(HOST_EXTRACXXFLAGS) \
>                   $(HOSTCXXFLAGS_$(target-stem).o)
>
> +KBUILD_HOSTLDFLAGS_SQ =3D '$(subst ','\'',$(KBUILD_HOSTLDFLAGS))'
> +
>  # `--out-dir` is required to avoid temporaries being created by `rustc` =
in the
>  # current working directory, which may be not accessible in the out-of-t=
ree
>  # modules case.
>  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) \
> +                -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> +                -Clink-args=3D$(KBUILD_HOSTLDFLAGS_SQ) \
>                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
>                   $(HOSTRUSTFLAGS_$(target-stem))
>
> --
> 2.42.0.459.ge4e396fd5e-goog
>


--=20
Best Regards
Masahiro Yamada
