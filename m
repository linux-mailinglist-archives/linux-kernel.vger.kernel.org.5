Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E250803159
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 12:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbjLDLPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 06:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLDLPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 06:15:42 -0500
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A814BD5;
        Mon,  4 Dec 2023 03:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=wdytburcmjh6jg34thzange6ou.protonmail; t=1701688543; x=1701947743;
        bh=vkp04PZwWHUkLIZ1OExVvH6dLTQjFbLCFc6Sin2elcA=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HDrnl0tyex7UpL+oWPgEhTI89lR54awUuNhLx3hfw3lUyx3NeYoOqTlQfaxbysOO1
         g3fgzPJv4geFCu9t2xAKsctEPDjGmXCAoyUZ/0zymh7iV08/GMZy1A2hIKDpe5Cpcx
         g5PrtK+cILUqz8RDhc+8bU0DszWHZAomVGxuXCgN9EZGtHBszLro7AYJdBrHSAc2nM
         OLw4/eWq01biCOHw9gB+7bS5dEm7zAfzugmE2ntL3JXTA5rAGGCeO5fhtLb/eFIQhp
         3qUgTkDaa9fnz3SxZqrcXW3VSu9f4sJzWxRpaY3CO6DAx4rwB5AGZA7iljZtWaYVYn
         D9Nkm+IWs+/ww==
Date:   Mon, 04 Dec 2023 11:15:26 +0000
To:     Jarkko Sakkinen <jarkko@kernel.org>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sumera Priyadarsini <sylphrenadin@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: macros: `parse_generics` add `decl_generics`
Message-ID: <lMMxxRYVTIl1RMW95hc58GoLGUdwLH-Uou4uZLtbstmEP2A19X-wX1tQ6VH8tvR8rVYzi-fOIBaWPV1Lzf-fcXo_27mf1cMk5m94wQYJGkA=@proton.me>
In-Reply-To: <CXE115I7V0YC.2AZ9KSVZP4NVS@kernel.org>
References: <20231125125024.1235933-1-benno.lossin@proton.me> <ce55240f74d4630fef8c7c3e7f47fe1b09636da1.camel@kernel.org> <84da128f-17b3-4193-8389-176a8c961d64@proton.me> <CXE115I7V0YC.2AZ9KSVZP4NVS@kernel.org>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/23 18:33, Jarkko Sakkinen wrote:
> On Sat Nov 25, 2023 at 5:39 PM EET, Benno Lossin wrote:
>> On 25.11.23 14:39, Jarkko Sakkinen wrote:
>>> On Sat, 2023-11-25 at 12:50 +0000, Benno Lossin wrote:
>>>> parameters. This patch also changes how `impl_generics` are made up,
>>>> as
>>>> these should be used with `impl<$impl_generics>`, they will omit the
>>>> default values.
>>>
>>> What is decl_generics and what are the other _generics variables?
>>> This lacks explanation what sort of change is implemented and why.
>>
>> The terms `impl_generics` and `ty_generics` are taken from [2]. This
>> patch adds a third kind which also contains any default values of const
>> generic parameters. I named them `decl_generics`, because they only
>> appear on type declarations.
>>
>> [2]: https://docs.rs/syn/latest/syn/struct.Generics.html#method.split_fo=
r_impl
>=20
> Thanks a lot of taking time for explaining all these concepts in a such
> a detail. Appreciate it! And I apologize for my a bit intrusive
> response.

No worries!

> I really think that "more vocal and verbose" than "legacy C" patches
> would be a great policy for Rust specific patches. This would help
> audience who understand kernel but are not as in Rust to give more
> feedback on the patches. I mean tech is still the same whatever we
> used to implement the code that enables it.

I agree. One thing that we are already doing is encouraging
documentation, see [1]. We also use `-Wmissing_docs` which makes the
compiler emit a warning when you have a public item (a function,
constant, type etc.) that has no documentation.
Rust documentation is placed directly next to the source code. This
helps keep it up to date and makes it easier to find documentation.

[1]: https://docs.kernel.org/rust/coding-guidelines.html#code-documentation


Additionally we can make commit messages more elaborate. Though we
probably need help with choosing the topics and depth of the
explanations. Since when you are already familiar with something, it
is often difficult to know what is hard to understand. This also holds
for documentation.

That being said, I think that we should not document common Rust
patterns and properties. I think you understand that we do not want
to write code like this over-the-top example:

    void init_foo(struct foo *foo)
    {
        // `foo->value` is short for `(*foo).value`
        foo->value =3D 42;
    }

I am of course open to help anyone understand the Rust code that
we upstream, by giving pointers to the relevant Rust resources (e.g.
the Rust book or std library documentation) or explaining our custom
code. We might even find something that should be documented better
and then I will be happy to do so.

--=20
Cheers,
Benno
