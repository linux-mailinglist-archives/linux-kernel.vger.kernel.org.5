Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19627BC07B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 22:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJFUjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 16:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233452AbjJFUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 16:39:29 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EC8BE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 13:39:27 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3226b8de467so2429476f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 13:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696624766; x=1697229566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vBnY223+UcCK7rzFoc5ulYVlozys8xUWOd34LCUCsy4=;
        b=dc2v+PVJvVr0uoQ1UKJpUoQvg0hKyxhQJnGZOMO31fdSqSocFG5hozuNR+OPpAouoZ
         EslfSr5iHQagc1GQ/3slV9tHwSD4px1Ppk9fOInBW1Yg1uD0Oqoxn4SbEngrmMrupRfq
         8ARNyZh65P7T06uk7eFwWmPmhUq0EBtZq4PmHBDiMGcQm10jqFfHwJSl7H+fZcwPMqgo
         ST5jJO9mRJi8Pl/2L4iLOiPiRp9LihXWTtAD/kLam685elHMJoRbjoQHwxppRwAbwXdU
         NbTYOlzNwhgfpO4hIgNNKqmPZPYAZlxgXpqu/HfGWUJdV0DsWwXTY5SSfjZk6KNwGA0t
         bx+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696624766; x=1697229566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vBnY223+UcCK7rzFoc5ulYVlozys8xUWOd34LCUCsy4=;
        b=o5vGEnXkoH6NVwTZ2w/cQ+OziJL7S8JlxujSEFfRJ+VTxu2rve/RZDm2cDx00jXQOS
         O7CsjRfv9q6t0YhWg/2WnWdYPVz8k+HqKSjvZiJnvUlXF1VsfUhnfAv4yU7GgcDU5Fz6
         jXJsNN3s8vsR1herV1hAYyNYGq8JXGG9KR5Jlt4lMXpL5UTeCVklpUKG1omMqJrr0ZAF
         PDIPNpRANZxTuLrbFmNCSQTHV3hACEoj+atiTTLOa6VDyceGnG6Ke8XLuzDrjCDBd7J0
         1ZmDwARphTW6f70eINnhyGIBbsfQwagoITzwQbZ2XczAAVPFPd7FcAOqVCXaPjg3apDb
         +WIg==
X-Gm-Message-State: AOJu0YxiMc9TmSiHJuHzNI9YBZ8wOlaaPUeKbtqoNcoPYyDkG3TIOnjU
        o+sivLu5xgzaVBZeJHQ4S7yDj4E+cGl3WKF9KIMnHQ==
X-Google-Smtp-Source: AGHT+IHzDNuNkLetmngGytv8DBCjIwTFYkdYhI5xAmjMNGnAyOVLiTphU/0Zdm665xGK7Wdop5gObd6L4XgXt6BqlkA=
X-Received: by 2002:a5d:58f2:0:b0:31f:f326:766b with SMTP id
 f18-20020a5d58f2000000b0031ff326766bmr7910442wrd.6.1696624765796; Fri, 06 Oct
 2023 13:39:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231005214057.759089-1-mmaurer@google.com>
In-Reply-To: <20231005214057.759089-1-mmaurer@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 6 Oct 2023 13:39:11 -0700
Message-ID: <CAKwvOdnWc6b9-XwC56ADXx6K2XCzrUPc_VMsAt=syKsp_b6ZSg@mail.gmail.com>
Subject: Re: [PATCH v4] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Thu, Oct 5, 2023 at 2:41=E2=80=AFPM Matthew Maurer <mmaurer@google.com> =
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
>
> Edited to use escsq in both Makefiles, as per Masahiro Yamada's
> suggestion.

That looks better; thanks Matthew!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
>  rust/Makefile         | 2 ++
>  scripts/Makefile.host | 2 ++
>  2 files changed, 4 insertions(+)
>
> diff --git a/rust/Makefile b/rust/Makefile
> index 87958e864be0..2ddd821d9435 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -383,6 +383,8 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FO=
RCE
>  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
>        cmd_rustc_procmacro =3D \
>         $(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> +               -Clinker-flavor=3Dgcc -Clinker=3D$(HOSTCC) \
> +               -Clink-args=3D'$(call escsq,$(KBUILD_HOSTLDFLAGS))' \
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
> 2.42.0.609.gbb76f46606-goog
>


--=20
Thanks,
~Nick Desaulniers
