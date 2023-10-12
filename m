Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81327C6FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378880AbjJLNv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344014AbjJLNvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:51:55 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD80B7;
        Thu, 12 Oct 2023 06:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1697118711; x=1697377911;
        bh=sZo92moLqUkqI0jI/dO0Y971ELJaGFGAmjX34V13s3M=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LGoqwnxGIuYi04S470BbjvsEpFTxGMwJcZodOcbmnhMjw0RlmUkpixCAFHjXnRnQC
         /1RAgIlquVemum5j+lEiTKz8/+dZy3RPostUAQ2jIF9V2qOGfgJ1ch1gqWpSmoeCpt
         03Wce6EiJ7hRQ2XeDfIWWnZLoKc8b0N0/NGe7sLXRdPwBf1xLbEEj/7z3fyO//xVoR
         GU/ZD9yfMk+1bHGqFTDVNcHpGYfx1SMgqfo8fjxGnMupHsrb7f38npJrmVRG8KsPTO
         AqYrHnhi/GGKVscoqlWDL2wwLUZ96ncz4ieOjAYO6o+eS1zUe6lLot17ajy9Mswxpi
         1U3GV4cUnoVCA==
Date:   Thu, 12 Oct 2023 13:51:39 +0000
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rust: macros: improve `#[vtable]` documentation
Message-ID: <64542ca3-180a-483d-9e86-bf03f0533254@proton.me>
In-Reply-To: <CANeycqqMsqHU1cUSSQh+W9435zjA+XZ=K3Yxi6mNn_d4yZOazg@mail.gmail.com>
References: <20231012132131.300014-1-benno.lossin@proton.me> <CANeycqqMsqHU1cUSSQh+W9435zjA+XZ=K3Yxi6mNn_d4yZOazg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.10.23 15:48, Wedson Almeida Filho wrote:
> On Thu, 12 Oct 2023 at 10:22, Benno Lossin <benno.lossin@proton.me> wrote=
:
>> +
>> +/// Error message for calling a default function of a [`#[vtable]`](mac=
ros::vtable) trait.
>> +pub const VTABLE_DEFAULT_ERROR: &str =3D
>> +    "This function must not be called, see the #[vtable] documentation.=
";
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index c42105c2ff96..dab9a1080b82 100644
>> --- a/rust/macros/lib.rs
>> +++ b/rust/macros/lib.rs
>> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>>   /// implementation could just return `Error::EINVAL`); Linux typically=
 use C
>>   /// `NULL` pointers to represent these functions.
>>   ///
>> -/// This attribute is intended to close the gap. Traits can be declared=
 and
>> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associate=
d constant
>> -/// will be generated for each method in the trait, indicating if the i=
mplementor
>> -/// has overridden a method.
>> +/// This attribute closes that gap. A trait can be annotated with the `=
#[vtable]` attribute.
>> +/// Implementers of the trait will then also have to annotate the trait=
 with `#[vtable]`. This
>> +/// attribute generates a `HAS_*` associated constant bool for each met=
hod in the trait that is set
>> +/// to true if the implementer has overridden the associated method.
>> +///
>> +/// If you want to make a function optional, you must provide a default=
 implementation. But this
>=20
> We should  standardise how we write our documentation. In the `rust`
> branch, we avoided using the imperative mood like you have here; the
> rationale was that the documentation was describing how things
> are/work, so we shouldn't be giving orders to readers (they may be
> authors of traits, implementers of some vtable trait, or neither, just
> someone learning about things, etc.).
>=20
> In the paragraph above, you'll find an example: "Implementers of the
> trait will then also have to...".
>=20
> For the specific case above, I'd suggest: 'For a function to be
> optional, it must have a default implementation.', or using the
> passive voice, 'To make a function optional, a default implementation
> must be provided'.

I agree, I also think we should just fix this now, so I will send a v2.

--=20
Cheers,
Benno


