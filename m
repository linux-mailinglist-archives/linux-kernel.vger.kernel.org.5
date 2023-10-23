Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE0C7D3D45
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 19:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbjJWRTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 13:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjJWRT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 13:19:29 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD56EE;
        Mon, 23 Oct 2023 10:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1698081562; x=1698340762;
        bh=o/kXFPMyJifrFRkXdqNgBwO5a87jm2R3z9kVsG8BBZI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Lvy6KPbJhQll4AotxXYUAz1N/fFLkHQCcD994EtQU6QGK0N9SSOnHNSg1JGG7npF1
         nX+yM74MxptOB06C0KbNcGtpJ4MSXx1mBPh+Oh2v96dULoSvRabzNEGSIMf8LgoQJe
         zcDjhNTHqIkc+xPRkTZj5JsRADKCCtKSycz6vruUKz2dcBblYPMeuAeJnIPCbSTJTw
         wmxyV2RCluL+G0zJbT6jy5BfIsmgUPC6wcUPvm8pcJ4xEVCFj0/muUZUoDo4AqG8kW
         WjiYXk9k9IRtLQyu4H1qCitBXKWWdgVRgfrOojjn2u4SPkSStA/3SDNpYnt0dSvnpD
         vX4JG9ZW2FhjA==
Date:   Mon, 23 Oct 2023 17:19:12 +0000
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
Message-ID: <816030ec-32a7-4be0-816d-6764fd5dbb8e@proton.me>
In-Reply-To: <878r7thh3w.fsf@metaspace.dk>
References: <20231019171540.259173-1-benno.lossin@proton.me> <87fs25irel.fsf@metaspace.dk> <ba252f66-b204-43c1-9705-8ccd0cb12492@proton.me> <878r7thh3w.fsf@metaspace.dk>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.10.23 10:30, Andreas Hindborg (Samsung) wrote:
>=20
> Benno Lossin <benno.lossin@proton.me> writes:
>=20
>> On 20.10.23 11:06, Andreas Hindborg (Samsung) wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>> +/// Error message for calling a default function of a [`#[vtable]`](m=
acros::vtable) trait.
>>>> +pub const VTABLE_DEFAULT_ERROR: &str =3D
>>>> +    "This function must not be called, see the #[vtable] documentatio=
n.";
>>>> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
>>>> index c42105c2ff96..daf1ef8baa62 100644
>>>> --- a/rust/macros/lib.rs
>>>> +++ b/rust/macros/lib.rs
>>>> @@ -87,27 +87,41 @@ pub fn module(ts: TokenStream) -> TokenStream {
>>>>    /// implementation could just return `Error::EINVAL`); Linux typica=
lly use C
>>>>    /// `NULL` pointers to represent these functions.
>>>>    ///
>>>> -/// This attribute is intended to close the gap. Traits can be declar=
ed and
>>>> -/// implemented with the `#[vtable]` attribute, and a `HAS_*` associa=
ted constant
>>>> -/// will be generated for each method in the trait, indicating if the=
 implementor
>>>> -/// has overridden a method.
>>>> +/// This attribute closes that gap. A trait can be annotated with the=
 `#[vtable]` attribute.
>>>> +/// Implementers of the trait will then also have to annotate the tra=
it with `#[vtable]`. This
>>>> +/// attribute generates a `HAS_*` associated constant bool for each m=
ethod in the trait that is set
>>>> +/// to true if the implementer has overridden the associated method.
>>>> +///
>>>> +/// For a function to be optional, it must have a default implementat=
ion. But this default
>>>> +/// implementation will never be executed, since these functions are =
exclusively called from
>>>> +/// callbacks from the C side. This is because the vtable will have a=
 `NULL` entry and the C side
>>>> +/// will execute the default behavior. Since it is not maintainable t=
o replicate the default
>>>> +/// behavior in Rust, the default implementation should be:
>>>
>>> How about this?:
>>>
>>> For a Rust trait method to be optional, it must have a default
>>> implementation. For a trait marked with `#[vtable]`, the default
>>> implementation will not be executed, as the only way the trait methods
>>> should be called is through function pointers installed in C side
>>> vtables. When a trait implementation marked with `#[vtable]` is missing
>>> a method, a `NULL` pointer will be installed in the corresponding C sid=
e
>>> vtable, and thus the Rust default implementation can not be called. The
>>> default implementation should be:
>>>
>>> Not sure if it is more clear =F0=9F=A4=B7
>>
>> I think it misses the following important point: why is it not
>> possible to just replicate the default behavior?
>>
>> What do you think of this?:
>>
>> For a trait method to be optional, it must have a default implementation=
.
>> This is also the case for traits annotated with `#[vtable]`, but in this
>> case the default implementation will never be executed. The reason for t=
his
>> is that the functions will be called through function pointers installed=
 in
>> C side vtables. When an optional method is not implemented on a `#[vtabl=
e]`
>> trait, a NULL entry is installed in the vtable. Thus the default
>> implementation is never called. Since these traits are not designed to b=
e
>> used on the Rust side, it should not be possible to call the default
>> implementation.
>=20
>> It is not possible to replicate the default behavior from C
>> in Rust, since that is not maintainable.
>=20
> I don't feel that this bit should be included. It's not a matter of
> maintainability. Why would we reimplement something that is already
> present in a subsystem? The functionality is already present, so we use
> it.

But we don't use it on the Rust side. You cannot write this:

     fn foo<T: Operations>(t: &T) -> Result<usize> {
         t.seek(0)?
     }

if the `seek` function is optional.

--=20
Cheers,
Benno


