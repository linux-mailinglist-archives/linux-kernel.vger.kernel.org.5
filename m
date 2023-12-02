Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051F5801DF5
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 18:34:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjLBRdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 12:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBRdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 12:33:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D876111F
        for <linux-kernel@vger.kernel.org>; Sat,  2 Dec 2023 09:33:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1978C433C8;
        Sat,  2 Dec 2023 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701538430;
        bh=FyK3LZhs1D/WhL1Y2VzPXEFd97X8X85VHUVO563gFV4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u22mTRE54ONIsymebB7GokeLCL6ccI08BSH2y6cigWDXrNjZXCiIpwq3IpF2WrRSh
         tWw6SF/BsoEqk4CA/oOLYTARsUcxvUp7oU/zwzGrme+uK2XPGRQBKxgGaY3hIr8Ajv
         Vt/vDT/lfqO3xmkBvXEAvS7gNodEtUVg7Fwr/iUImiXIBWaMDknavyAKtrOqZdRH9j
         pG79ZeaSGsgr+NGUGuhjYRMg5EHPTrYvKOXf5iWd+gG6YBIN1iqQajDDI1CjGNEhlA
         yR51erH+9lNDj7033e4zcLzuDHQ2MWjO/7tqwkd3UgR25n/7cj8VY6UZ18Zc3eOyzY
         nJk7tkPugcpxA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 02 Dec 2023 19:33:45 +0200
Message-Id: <CXE115I7V0YC.2AZ9KSVZP4NVS@kernel.org>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Benno Lossin" <benno.lossin@proton.me>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Andreas Hindborg" <a.hindborg@samsung.com>,
        "Alice Ryhl" <aliceryhl@google.com>,
        "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Asahi Lina" <lina@asahilina.net>
Cc:     "Sumera Priyadarsini" <sylphrenadin@gmail.com>,
        <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] rust: macros: `parse_generics` add `decl_generics`
X-Mailer: aerc 0.15.2
References: <20231125125024.1235933-1-benno.lossin@proton.me>
 <ce55240f74d4630fef8c7c3e7f47fe1b09636da1.camel@kernel.org>
 <84da128f-17b3-4193-8389-176a8c961d64@proton.me>
In-Reply-To: <84da128f-17b3-4193-8389-176a8c961d64@proton.me>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Nov 25, 2023 at 5:39 PM EET, Benno Lossin wrote:
> On 25.11.23 14:39, Jarkko Sakkinen wrote:
> > Sorry, just went through my eyes, hope you don't mind I nitpick
> > a bit. And maybe learn a bit in the process.
> >=20
> > On Sat, 2023-11-25 at 12:50 +0000, Benno Lossin wrote:
> >> When parsing generics of a type definition, default values can be
> >> specified. This syntax is however only available on type definitions
> >> and
> >> not e.g. impl blocks.
> >=20
> > Is "impl block" equivalent to a trait implementation? Maybe then just
> > write in better English "trait implementation? Would be IMHO better
> > to use commonly know terminology here.
>
> "impl block" refers to the syntactic item of Implementation [1]. It
> might be a trait implementation, or an inherent implementation. To me
> "impl block" is known terminology.
>
> [1]: https://doc.rust-lang.org/stable/reference/items/implementations.htm=
l
>
> > Also for any commit, including any Rust commit. "When parsing" does
> > not map to anything concrete. There always should be a concrete
> > scenario where the parser its used. Especially since Rust is a new
> > thing in the kernel, these commits should really have more in-depth
> > information of the context.
>
> This commit is tagged `rust: macros:`, which means that it affects the
> proc macros. So when I wrote "When parsing", I meant "When parsing Rust
> code in proc macros". I will change this for v2.
>
> > I neither really grasped why trait implementations (if that is meant
> > by "impl block") not having this support connects to the code change.
> > Maybe just say that this patch adds the support and drop the whole
> > story about traits. It is sort of unnecessary context.
>
> Rust does not syntactically support writing
>
>      impl<const N: usize =3D 0> Foo<N> {
>      }
>
> This is because it does not make sense. The syntax `=3D 0` only makes
> sense on type definitions:
>
>      struct Foo<const N: usize =3D 0> {
>      }
>
> Because then you can just write `Foo` and it will be the same type as
> `Foo<0>`.

Right.

>
> > Finally, why this change is needed? Any commit should have existential
> > reason why it exists. So what will happen if "decl_generics" is not
> > taken to the upstream kernel? How does it make life more difficult?
> > You should be able to answer to this (in the commit message).
>
> Does this explain it?:
>
> In order to allow `#[pin_data]` on structs with default values for const
> generic parameters, the `#[pin_data]` macro needs to parse them and have
> access to the generics as they are written on the type definition.
> This commit adds support for parsing them to the already present generics
> parsing code in the macros crate.

Yes.

>
> >> parameters. This patch also changes how `impl_generics` are made up,
> >> as
> >> these should be used with `impl<$impl_generics>`, they will omit the
> >> default values.
> >=20
> > What is decl_generics and what are the other _generics variables?
> > This lacks explanation what sort of change is implemented and why.
>
> The terms `impl_generics` and `ty_generics` are taken from [2]. This
> patch adds a third kind which also contains any default values of const
> generic parameters. I named them `decl_generics`, because they only
> appear on type declarations.
>
> [2]: https://docs.rs/syn/latest/syn/struct.Generics.html#method.split_for=
_impl

Thanks a lot of taking time for explaining all these concepts in a such
a detail. Appreciate it! And I apologize for my a bit intrusive
response.

I really think that "more vocal and verbose" than "legacy C" patches
would be a great policy for Rust specific patches. This would help
audience who understand kernel but are not as in Rust to give more
feedback on the patches. I mean tech is still the same whatever we
used to implement the code that enables it.

By doing that I see that all benefit and it opens doors for deeper
Rust integration in the kernel.

BR, Jarkko
