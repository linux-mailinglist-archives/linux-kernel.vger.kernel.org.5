Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14970767C0A
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 06:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjG2EL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 00:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjG2EL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 00:11:26 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C248949D5;
        Fri, 28 Jul 2023 21:11:23 -0700 (PDT)
Date:   Sat, 29 Jul 2023 04:11:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1690603880; x=1690863080;
        bh=EBpMQWlTo21HVtOIF3xmBwvt2Rt/ADgtf1OJ1f2tpVg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=N3MrYlJz9wYFE7YG5NrpA58ljxcqa6gggTj2YGlG5y5Mr4EqZsyKYo8O3BLvYDQOC
         WRtkAeDjZfNJ6zWrryreYnWkawFLJRh/KCZ5S6j9Pj7kqYvf2U5LF7x0bDnUmL29F/
         7nRktJM4/jfo+fwBIO9itbZEcLTgWTJF+jRzwrybfoP4uuzPbUUtPK/Tmbba4celtH
         Ve77EnvLlgAu7i7gbhPbhUBlcl51keh5qVKDkKe1gQIVhspbfBEBJHbQcYmz/l57pN
         xTFgvatFdaxPHp845uXSsnbIe04gT8OEfzOGyMynAsNb1G69Z5h8/Ow9b1GpiVTYru
         v2WCYWea+mTVg==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, nmi@metaspace.dk, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org, wedsonaf@gmail.com
Subject: Re: [PATCH v2 09/12] rust: init: implement Zeroable for Opaque<T>
Message-ID: <18653bf6-c177-ab14-d026-2d2b5c2bbac3@proton.me>
In-Reply-To: <20230725115759.424300-1-aliceryhl@google.com>
References: <16fb9977-2efc-2412-e906-3d320e37c45c@proton.me> <20230725115759.424300-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.07.23 13:57, Alice Ryhl wrote:
> Benno Lossin <benno.lossin@proton.me> writes:
>> On 20.07.23 15:34, Alice Ryhl wrote:
>>> Benno Lossin <benno.lossin@proton.me> writes:
>>>> Since `Opaque<T>` contains a `MaybeUninit<T>`, all bytes zero is a val=
id
>>>> bit pattern for that type.
>>>>
>>>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>>>> ---
>>>>    ///
>>>>    /// This is meant to be used with FFI objects that are never interp=
reted by Rust code.
>>>>    #[repr(transparent)]
>>>> +#[derive(Zeroable)]
>>>>    pub struct Opaque<T> {
>>>>        value: UnsafeCell<MaybeUninit<T>>,
>>>>        _pin: PhantomPinned,
>>>>    }
>>>
>>> Does this actually work? I don't think we implement Zeroable for
>>> UnsafeCell.
>>
>> Good catch, this does compile, but only because the current
>> implementation of the derive expands to (modulo correct paths):
>> ```
>> impl<T> Zeroable for Opaque<T>
>> where
>>       UnsafeCell<MaybeUninit<T>>: Zeroable,
>>       PhantomPinned: Zeroable,
>> {}
>> ```
>> This implementation is of course useless, since `UnsafeCell` is never
>> `Zeroable` at the moment. We could of course implement that and then thi=
s
>> should work, but the question is if this is actually the desired output =
in
>> general. I thought before that this would be a good idea, but I forgot t=
hat
>> if the bounds are never satisfied it would silently compile.
>>
>> Do you think that we should have this expanded output instead?
>> ```
>> impl<T: Zeroable> Zeroable for Foo<T> {}
>> const _: () =3D {
>>       fn assert_zeroable<T: Zeroable>() {}
>>       fn ensure_zeroable<T: Zeroable>() {
>>           assert_zeroable::<Field1>();
>>           assert_zeroable::<Field2>();
>>       }
>> };
>> ```
>> If the input was
>> ```
>> #[derive(Zeroable)]
>> struct Foo<T> {
>>       field1: Field1,
>>       field2: Field2,
>> }
>> ```
>=20
> Yeah. The way that these macros usually expand is by adding `where T:
> Zeroable` to the impl for each generic parameter, and failing
> compilation if that is not enough to ensure that all of the fields are
> `Zeroable`.
>=20
> You might want to consider this expansion instead:
> ```
> impl<T: Zeroable> Zeroable for Foo<T> {}
> const _: () =3D {
>       fn assert_zeroable<T: Zeroable>(arg: &T) {}
>       fn ensure_zeroable<T: Zeroable>(arg: &Foo<T>) {
>           assert_zeroable(&arg.field1);
>           assert_zeroable(&arg.field2);
>       }
> };
> ```

Is there a specific reason you think that I should us references here
instead of the expansion from above (where I just use the types and
not the fields themselves)?

--=20
Cheers,
Benno

