Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9EC67A31B7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 19:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbjIPRyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 13:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236463AbjIPRxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 13:53:36 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4752418D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 10:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1694886803; x=1695146003;
        bh=Utb7hBOVxc/ZFn0MMOWNFNa55EwwLJ9JMnuohv777VQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cqrArCzhFcgQZsen0K2oFKA+zYxyuqficq4GoKKVywYLanUOBlxHyE5X5r283U3zX
         KkmwyWC4zr0ko5ulI/bemoo3G+7DVmFRxBySe4WRhOb8KoWaNJacuxkz38/n9vfYpy
         AxEWQGsdwM/dAAOgEzO5eiiWJEFW06e/vVd2chnaGyKOHXnjLyWvdsW+cOKEXym004
         swrKr/jupAqU3LA57t5HsMVmJkUvotKGEcaC6YhK4/1ivX43p7AAdpwVCWtVn6WMJy
         XSV3Rv+yyAfYu4sBI/Q+4KvchImHeS6OREB0ZbCw7e1Vt9Kd7+CeWRLHuZSW9JBbSz
         4MvkDo6rZF+kQ==
Date:   Sat, 16 Sep 2023 17:53:03 +0000
To:     Finn Behrens <me@kloenk.dev>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Matthew Maurer <mmaurer@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
Message-ID: <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
In-Reply-To: <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
References: <20230915172900.3784163-1-mmaurer@google.com> <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, September 16th, 2023 at 18:52, Finn Behrens <me@kloenk.dev> wr=
ote:

>=20
> On 15 Sep 2023, at 19:28, Matthew Maurer wrote:
>=20
> > Currently, rustc defaults to invoking `cc`, even if `HOSTCC` is defined=
,
> > resulting in build failures in hermetic environments where `cc` does no=
t
> > exist. This includes both hostprogs and proc-macros.
> >
> > Since we are setting the linker to `HOSTCC`, we set the linker flavor t=
o
> > `gcc` explicitly.
> But as `HOSTCC` could also be clang, the linker flavor would then be wron=
g, would that create a problem?

Rustc uses the gcc linker flavor for clang too. There has been a proposal t=
o split it up, but I'm not sure of the status of that. In any case clang's =
cli is similar enough to gcc that it works fine to use the gcc linker flavo=
r.

> >
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>
> > ---
> >  rust/Makefile         | 1 +
> >  scripts/Makefile.host | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 87958e864be0..2a2352638f11 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -383,6 +383,7 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o =
FORCE
> >  quiet_cmd_rustc_procmacro =3D $(RUSTC_OR_CLIPPY_QUIET) P $@
> >        cmd_rustc_procmacro =3D \
> >  =09$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> > +=09=09-C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
> >  =09=09--emit=3Ddep-info=3D$(depfile) --emit=3Dlink=3D$@ --extern proc_=
macro \
> >  =09=09--crate-type proc-macro \
> >  =09=09--crate-name $(patsubst lib%.so,%,$(notdir $@)) $<
> > diff --git a/scripts/Makefile.host b/scripts/Makefile.host
> > index 8f7f842b54f9..0aa95a3af1c4 100644
> > --- a/scripts/Makefile.host
> > +++ b/scripts/Makefile.host
> > @@ -91,6 +91,7 @@ hostcxx_flags  =3D -Wp,-MMD,$(depfile) \
> >  # current working directory, which may be not accessible in the out-of=
-tree
> >  # modules case.
> >  hostrust_flags =3D --out-dir $(dir $@) --emit=3Ddep-info=3D$(depfile) =
\
> > +=09=09 -C linker-flavor=3Dgcc -C linker=3D$(HOSTCC) \
> >                   $(KBUILD_HOSTRUSTFLAGS) $(HOST_EXTRARUSTFLAGS) \
> >                   $(HOSTRUSTFLAGS_$(target-stem))
> >
> > --
> > 2.42.0.459.ge4e396fd5e-goog
