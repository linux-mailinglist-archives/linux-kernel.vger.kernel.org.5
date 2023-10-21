Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94517D1D37
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 15:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjJUNRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 09:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbjJUNRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 09:17:12 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A657D63
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 06:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1697894224; x=1698153424;
        bh=sCSYxlsGEw/QK9x9M3aySq+pUCU4iIWD6t3o6q6q0a0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N6pMv6qsPg8lw9tQgNb5buHejJnDSOhFAgaZFFnRmDs3UpLYfqUl55aRSU4npHgj5
         dJMbU6qR9mB/JYlOt5Bd0E2UwB/xDty9IUQZXPmXOB9kTqEyPK5xOKG99nFaqiUckR
         HFqQvdJrVK7oddIYT9AH7bL7O8rSTJ9opFkjayfDRJ0jSGiDdxafy8KVbbSaERCBw4
         fETFnPhPVTVPBBB061Cf9ly60ZQxzzV/ztuRqhMf4ZkqJEvqDbHG+2QEDZO/lgQrvq
         1zbnLFS0FPUMVWb7qOyJU/8korZ+8TceYE0jQ40GuETYc1MHP6Go/R2IIwbwAFKXSm
         kbgfeA9dKlgew==
Date:   Sat, 21 Oct 2023 13:16:54 +0000
To:     "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rust: macros: improve `#[vtable]` documentation
Message-ID: <ba252f66-b204-43c1-9705-8ccd0cb12492@proton.me>
In-Reply-To: <87fs25irel.fsf@metaspace.dk>
References: <20231019171540.259173-1-benno.lossin@proton.me> <87fs25irel.fsf@metaspace.dk>
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

On 20.10.23 11:06, Andreas Hindborg (Samsung) wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> +/// Error message for calling a default function of a [`#[vtable]`](mac=
ros::vtable) trait.
>> +pub const VTABLE_DEFAULT_ERROR: &str =3D
>> +    "This function must not be called, see the #[vtable] documentation.=
";
>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>> index c42105c2ff96..daf1ef8baa62 100644
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
>> +/// For a function to be optional, it must have a default implementatio=
n. But this default
>> +/// implementation will never be executed, since these functions are ex=
clusively called from
>> +/// callbacks from the C side. This is because the vtable will have a `=
NULL` entry and the C side
>> +/// will execute the default behavior. Since it is not maintainable to =
replicate the default
>> +/// behavior in Rust, the default implementation should be:
>=20
> How about this?:
>=20
> For a Rust trait method to be optional, it must have a default
> implementation. For a trait marked with `#[vtable]`, the default
> implementation will not be executed, as the only way the trait methods
> should be called is through function pointers installed in C side
> vtables. When a trait implementation marked with `#[vtable]` is missing
> a method, a `NULL` pointer will be installed in the corresponding C side
> vtable, and thus the Rust default implementation can not be called. The
> default implementation should be:
>=20
> Not sure if it is more clear =F0=9F=A4=B7

I think it misses the following important point: why is it not
possible to just replicate the default behavior?

What do you think of this?:

For a trait method to be optional, it must have a default implementation.
This is also the case for traits annotated with `#[vtable]`, but in this
case the default implementation will never be executed. The reason for this
is that the functions will be called through function pointers installed in
C side vtables. When an optional method is not implemented on a `#[vtable]`
trait, a NULL entry is installed in the vtable. Thus the default
implementation is never called. Since these traits are not designed to be
used on the Rust side, it should not be possible to call the default
implementation. It is not possible to replicate the default behavior from C
in Rust, since that is not maintainable. The default implementaiton should
therefore call `kernel::build_error`, thus preventing calls to this
function at compile time:

--=20
Cheers,
Benno


