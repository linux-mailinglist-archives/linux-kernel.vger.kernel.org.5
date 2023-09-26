Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02747AF155
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235538AbjIZQwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbjIZQwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:41 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA07DCC8;
        Tue, 26 Sep 2023 09:52:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5237EC433CC;
        Tue, 26 Sep 2023 16:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695747149;
        bh=jZbXXpwO2YkG3T9wZrnoHzJGOBu0lJuRvun8uFcnm80=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oYeTi4U8bH1QgNPCJZfgga1Ep2Fw8dnKEc4zzysoAF/WId14gbXUq04eYGPcRBO7S
         FlQcf8Nf+p2nibebaTC8w/6Ed/QArZ/uzFAOrTxEjrRz/gHfCl+e9ojgGlP1d2Sdbr
         vVxN/bGTx3OQMuSrPbHgoeYC1Y+xyqt+AuiBbJSeJ4baDWlq7Ot29AeVSNds+guWkk
         l4+0XuqmFSlbmwCZeGBodUp4jF+ER0UjTkIKBElMi7zjjQ7AoBLJTZoZIoZAGB216J
         h/dA0bM8QDfTV2CGJIPt7hQusZhS7opBogPLS8fOvfum5eoCddyy00890+uYuCUi0L
         1vO3vWgNjJ4jg==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-1dd54aca17cso1754644fac.3;
        Tue, 26 Sep 2023 09:52:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YxGXmLAX8ESTdru+aGegIHe3BBLBAzwuoLnYDot0CVEk/+Omptg
        TB88zmJhTByumHCnOsLesnKmiefAcGUSEfWXXm8=
X-Google-Smtp-Source: AGHT+IGbDG6S94fbs66+E4Tj3DnXfB6VaDwQ0LhZUy+fsFfEeskapXLg2Vlht97zugGWE0UNsteaNj4DynwIk415vo8=
X-Received: by 2002:a05:6870:2d5:b0:1d5:b0b9:f6f1 with SMTP id
 r21-20020a05687002d500b001d5b0b9f6f1mr12460899oaf.8.1695747148628; Tue, 26
 Sep 2023 09:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230915172900.3784163-1-mmaurer@google.com> <9966E047-44E7-4665-9628-169F3EBE2F06@kloenk.dev>
 <SLZSYLg5E9OQKI546K87wxTYYLNlT1xM-LhC4W1JFhIate6PFsKq27RcBNhSjUkErYDlzsZB4F2Vc2KOP9tDThg58_tXycWn3K29mQXlFtU=@protonmail.com>
 <0561303E-2089-43FC-AA31-836C7BB844B7@kloenk.dev> <CAGSQo02p0LWZgV8oVidwvN6X__rv3-rj+ZVg9SaZ5Kx+zYahYQ@mail.gmail.com>
 <CAKwvOdnUdFjN+aCDrHKP6RzZCFB033ycN_KkB1WKucGd6VzUSg@mail.gmail.com>
 <CAGSQo00E1Wtg=f9SAcB2na69r4ASJ1L40ASPCyZV9FX+81uJCw@mail.gmail.com>
 <CAKwvOdnbbStoEeykYnx0jbnR=TAmmcdnOXbbA4Fx0BneFW8Fsg@mail.gmail.com> <CAGSQo01jMFVeqa=99Ne7tDXeOShcHWHBPgyiwZ+tm6x9qRJOfg@mail.gmail.com>
In-Reply-To: <CAGSQo01jMFVeqa=99Ne7tDXeOShcHWHBPgyiwZ+tm6x9qRJOfg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 27 Sep 2023 01:51:51 +0900
X-Gmail-Original-Message-ID: <CAK7LNATH59wQxaMRur9S5=HCi4bo9pREWK5LQjnNwZ5uOt7g=A@mail.gmail.com>
Message-ID: <CAK7LNATH59wQxaMRur9S5=HCi4bo9pREWK5LQjnNwZ5uOt7g=A@mail.gmail.com>
Subject: Re: [PATCH] rust: Respect HOSTCC when linking for host
To:     Matthew Maurer <mmaurer@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Finn Behrens <me@kloenk.dev>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
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

On Tue, Sep 19, 2023 at 3:55=E2=80=AFAM Matthew Maurer <mmaurer@google.com>=
 wrote:
>
> On Mon, Sep 18, 2023 at 11:43=E2=80=AFAM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > On Mon, Sep 18, 2023 at 9:38=E2=80=AFAM Matthew Maurer <mmaurer@google.=
com> wrote:
> > >
> > > On Mon, Sep 18, 2023 at 8:25=E2=80=AFAM Nick Desaulniers
> > > <ndesaulniers@google.com> wrote:
> > > >
> > > > What happens if you invoke the linker directly?
> > > Rust unfortunately currently doesn't support invoking the linker
> > > directly: https://github.com/rust-lang/rust/issues/73632
> >
> > Wait; does Rust have its own linker? It doesn't use the system linker?
> >  Perhaps that's necessary for the rust module format? If so, TIL.
> It does use the system linker (this is what -C linker is controlling),
> but the command line passed to the linker may change, extra object
> files may be added to the command line, etc.
> >
> > > > Generally, the kernel either invokes the compiler or the linker
> > > > directly. (For assembler, it is typically preprocessed, as are link=
er
> > > > scripts!)  So invoking the linker directly is a common pattern in
> > > > kbuild.  It also makes me slightly sad if the rust compiler ends up
> > > > invoking a c compiler, even if it's simply to drive the linker.
> > > As mentioned earlier, we could pass $HOSTLD, but if the linker isn't
> > > named something accurate (e.g. if the linker is not named lld, but is
> > > lld), we need to know how to pass a flavor:
> > > https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-fla=
vor
> > > Would it be appropriate to just assume the linker is named correctly?
> >
> > If it were not, what does failure look like?
> That depends. I think it will usually look like "unrecognized flag:
> blah blah", but that's not guaranteed.
> >
> > command not found: asdfadfasdf
> This isn't about command-not-found, it's about "I set
> HOSTLD=3Dfoo/bar/weirdname, and it is an lld-like linker. rustc invoked
> it assuming it is an ld-like linker."
> >
> > Seems fine to me. If the user mis-specifies HOSTLD=3D, then they will
> > get a similar error, which should be prescriptive enough for them to
> > figure out how exactly they're "holding it wrong."
> >
> > > > For example, Android carries a downstream patch to set `-fuse-ld=3D=
lld`
> > > > for $KBUILD_HOSTCFLAGS, because its build environment doesn't conta=
in
> > > > GNU binutils ("guilty, officer").
> > > Oddly, the Android kernel environment (Kleaf) is the one that I neede=
d
> > > this patch to build in, but it seemed to be working without a manual
> > > KBUILD_HOSTCFLAGS forwarding.
> >
> > Surprising that worked.
> >
> > > Overall, it sounds like you'd prefer if I set this to use
> > > `KBUILD_HOSTLD` and `KBUILD_HOSTLDFLAGS`, and leave the linker flavor
> > > to autodetect?
> >
> > Yes for the first two.
> >
> > Dunno, what precisely is a linker flavor?  Is that like a flavor of ice=
 cream?
> > Oh, right looking at your link:
> > https://doc.rust-lang.org/rustc/codegen-options/index.html#linker-flavo=
r
> > Seems like if `LLVM=3D1` is set, or `LD=3Dld.lld`, or CONFIG_LD_IS_LLD,=
 then
> > the flavor should be set to ld.lld, else ld.  Then the
> > KBUILD_HOSTLDFLAGS need to be passed, probably.
> >
> > But how are there "linker flavors" like ld or ld.lld if you just said
> > "Rust unfortunately currently doesn't support invoking the linker
> > directly: https://github.com/rust-lang/rust/issues/73632".  I'm having
> > trouble reconciling the two.
> Yes, what I meant by that is that *rustc* wants to invoke the linker,
> rather than having the surrounding build system invoke the linker. The
> exact command line passed to the linker in the final link, including
> potential synthetic objects, is considered an internal detail.
> >
> > Can we do something more like the below?
> >
> > ifdef CONFIG_LD_IS_LLD
> > hostrust_flags +=3D -C linker-flavor=3Dld.lld
> > else
> > hostrust_flags +=3D -C linker-flavor=3Dld
> > endif
> > hostrust_flags +=3D -C linker=3D$(HOSTLD) <todo: figure out how to pass
> > KBUILD_HOSTLDFLAGS>
> Yes, I can make host linking use `$(HOSTLD)` and pass the flavor based
> on CONFIG_LD_IS_LLD. I'll send a variant that does that this
> afternoon.


CONFIG_LD_IS_LLD=3Dy states that the linker for the
kernel space is LLD.

Host programs should not be affected.



--=20
Best Regards
Masahiro Yamada
