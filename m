Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F3737F8C19
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232177AbjKYPj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbjKYPjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:39:25 -0500
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 615B1FD;
        Sat, 25 Nov 2023 07:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=pf7ord5zsjfgpoi3hkrv27egte.protonmail; t=1700926768; x=1701185968;
        bh=Kz2T8+59cYjJd++rzjqYUDUtJC+blHipACJHnv+d/Qk=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=BTBwkG5vnt6MhOLd0vLxgWbJKacoreT0WcfZNBnO/0CszCR3s36clhfCLzhDGCBqD
         mKw6x4pctdXmkdWOf0CIHhZ5Os5fu5N9vYPgOyfMyyWr9I6N8OeO/66kyZNjYkhjtR
         jbObaAmBPRYIeLlncHbAELLhiiROpaHW+GJAvG1KzL7zsZYzqoT6+20KkGOQXkU7nw
         iTR7XGqFOum2H8aohVYeMHM1DOOBHjHXcRes8DajkP9bbKAtyvSKtSdWStkuxfdGjx
         Jl5RYpGKKmBxXyrQb70XtFfH7crcALCEs8KmDpo6ic/Xynintdy3GjorP1Lh4Lox7B
         3MdhXTeqelnIg==
Date:   Sat, 25 Nov 2023 15:39:09 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Sumera Priyadarsini <sylphrenadin@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: macros: `parse_generics` add `decl_generics`
Message-ID: <84da128f-17b3-4193-8389-176a8c961d64@proton.me>
In-Reply-To: <ce55240f74d4630fef8c7c3e7f47fe1b09636da1.camel@kernel.org>
References: <20231125125024.1235933-1-benno.lossin@proton.me> <ce55240f74d4630fef8c7c3e7f47fe1b09636da1.camel@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.11.23 14:39, Jarkko Sakkinen wrote:
> Sorry, just went through my eyes, hope you don't mind I nitpick
> a bit. And maybe learn a bit in the process.
>=20
> On Sat, 2023-11-25 at 12:50 +0000, Benno Lossin wrote:
>> When parsing generics of a type definition, default values can be
>> specified. This syntax is however only available on type definitions
>> and
>> not e.g. impl blocks.
>=20
> Is "impl block" equivalent to a trait implementation? Maybe then just
> write in better English "trait implementation? Would be IMHO better
> to use commonly know terminology here.

"impl block" refers to the syntactic item of Implementation [1]. It
might be a trait implementation, or an inherent implementation. To me
"impl block" is known terminology.

[1]: https://doc.rust-lang.org/stable/reference/items/implementations.html

> Also for any commit, including any Rust commit. "When parsing" does
> not map to anything concrete. There always should be a concrete
> scenario where the parser its used. Especially since Rust is a new
> thing in the kernel, these commits should really have more in-depth
> information of the context.

This commit is tagged `rust: macros:`, which means that it affects the
proc macros. So when I wrote "When parsing", I meant "When parsing Rust
code in proc macros". I will change this for v2.

> I neither really grasped why trait implementations (if that is meant
> by "impl block") not having this support connects to the code change.
> Maybe just say that this patch adds the support and drop the whole
> story about traits. It is sort of unnecessary context.

Rust does not syntactically support writing

     impl<const N: usize =3D 0> Foo<N> {
     }

This is because it does not make sense. The syntax `=3D 0` only makes
sense on type definitions:

     struct Foo<const N: usize =3D 0> {
     }

Because then you can just write `Foo` and it will be the same type as
`Foo<0>`.

> Finally, why this change is needed? Any commit should have existential
> reason why it exists. So what will happen if "decl_generics" is not
> taken to the upstream kernel? How does it make life more difficult?
> You should be able to answer to this (in the commit message).

Does this explain it?:

In order to allow `#[pin_data]` on structs with default values for const
generic parameters, the `#[pin_data]` macro needs to parse them and have
access to the generics as they are written on the type definition.
This commit adds support for parsing them to the already present generics
parsing code in the macros crate.

>> parameters. This patch also changes how `impl_generics` are made up,
>> as
>> these should be used with `impl<$impl_generics>`, they will omit the
>> default values.
>=20
> What is decl_generics and what are the other _generics variables?
> This lacks explanation what sort of change is implemented and why.

The terms `impl_generics` and `ty_generics` are taken from [2]. This
patch adds a third kind which also contains any default values of const
generic parameters. I named them `decl_generics`, because they only
appear on type declarations.

[2]: https://docs.rs/syn/latest/syn/struct.Generics.html#method.split_for_i=
mpl

--=20
Cheers,
Benno

