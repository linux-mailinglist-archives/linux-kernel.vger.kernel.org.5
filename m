Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92DBE7AE1AB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 00:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjIYW1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 18:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjIYW1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 18:27:19 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78BA911C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 15:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695680829; x=1695940029;
        bh=rrnK3OSDwClGzB3c8mNy8RVWjhRIEk6JVQN4DEKT7ew=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=A2N+9JoQgHF1Dg2sz/h8G4clisRoTT/kpxURvqX2ko0uZt+4HDv5N1F0DfXzraO8/
         laJKhTeLRhbKqqXqM4AGHs/X6sWabMzHf0E47DAt0JgJXPuxrXfEIeyhOv4FNhysfu
         qW796QiK675CfYKiLEr+nEVN77gbE624qQiePVbZt7TglUt6+Og8lhf/uFnDKE2eNa
         hKenxHXleLLuagSy0IpWXNjYV1eIZqHT2U5tufvSzPjsHN9Ip6LmrxYJqi3vhHxMJm
         /erthkRfdlNXRg+EyAwWKbOqmJvsA3NtU44vbyakIK4h/rOT7dgFjPvlGrZM3HE90v
         f7MQ5IgtGXwoA==
Date:   Mon, 25 Sep 2023 22:26:56 +0000
To:     Boqun Feng <boqun.feng@gmail.com>, Alice Ryhl <alice@ryhl.io>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Alice Ryhl <aliceryhl@google.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me>
In-Reply-To: <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
References: <CAH5fLggxsewmtzXjehbawDCTHO0C7kteU_CLnh80eMNj=QyP9Q@mail.gmail.com> <14513589-cc31-8985-8ff6-a97d2882f593@proton.me> <ZRGyRQuBcWvgtdNR@Boquns-Mac-mini.home> <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me> <ZRHWqbvYlXBXEOh-@boqun-archlinux> <c5134a1a-a60d-73bb-9faa-aa1dfc3bc30d@proton.me> <ZRIB0hXNvmJtmyak@boqun-archlinux> <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io> <ZRIDc_x9Qh5EJNC8@boqun-archlinux>
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

On 26.09.23 00:02, Boqun Feng wrote:
> On Mon, Sep 25, 2023 at 11:58:46PM +0200, Alice Ryhl wrote:
>> On 9/25/23 23:55, Boqun Feng wrote:
>>> On Mon, Sep 25, 2023 at 09:03:52PM +0000, Benno Lossin wrote:
>>>> On 25.09.23 20:51, Boqun Feng wrote:
>>>>> On Mon, Sep 25, 2023 at 05:00:45PM +0000, Benno Lossin wrote:
>>>>>> On 25.09.23 18:16, Boqun Feng wrote:
>>>>>>> On Mon, Sep 25, 2023 at 03:07:44PM +0000, Benno Lossin wrote:
>>>>>>>> ```rust
>>>>>>>> struct MutatingDrop {
>>>>>>>>          value: i32,
>>>>>>>> }
>>>>>>>>
>>>>>>>> impl Drop for MutatingDrop {
>>>>>>>>          fn drop(&mut self) {
>>>>>>>>              self.value =3D 0;
>>>>>>>>          }
>>>>>>>> }
>>>>>>>>
>>>>>>>> let arc =3D Arc::new(MutatingDrop { value: 42 });
>>>>>>>> let wr =3D arc.as_with_ref(); // this creates a shared `&` referen=
ce to the MutatingDrop
>>>>>>>> let arc2: Arc<MutatingDrop> =3D wr.into(); // increments the refer=
ence count to 2
>>>>>>>
>>>>>>> More precisely, here we did a
>>>>>>>
>>>>>>> =09&WithRef<_> -> NonNull<WithRef<_>>
>>>>>>>
>>>>>>> conversion, and later on, we may use the `NonNull<WithRef<_>>` in
>>>>>>> `drop` to get a `Box<WithRef<_>>`.
>>>>>>
>>>>>> Indeed.
>>>>>>
>>>>>
>>>>> Can we workaround this issue by (ab)using the `UnsafeCell` inside
>>>>> `WithRef<T>`?
>>>>>
>>>>> impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
>>>>>        fn from(b: &WithRef<T>) -> Self {
>>>>>            // SAFETY: The existence of the references proves that
>>>>> =09// `b.refcount.get()` is a valid pointer to `WithRef<T>`.
>>>>> =09let ptr =3D unsafe { NonNull::new_unchecked(b.refcount.get().cast:=
:<WithRef<T>>()) };
>>>>>
>>>>> =09// SAFETY: see the SAFETY above `let ptr =3D ..` line.
>>>>>            ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
>>>>>                .deref()
>>>>>                .clone()
>>>>>        }
>>>>> }
>>>>>
>>>>> This way, the raw pointer in the new Arc no longer derives from the
>>>>> reference of `WithRef<T>`.
>>>>
>>>> No, the code above only obtains a pointer that has provenance valid
>>>> for a `bindings::refcount_t` (or type with the same layout, such as
>>>> `Opaque<bindings::refcount_t>`). But not the whole `WithRef<T>`, so ac=
cessing
>>>> it by reading/writing will still be UB.
>>>>
>>>
>>> Hmm... but we do the similar thing in `Arc::from_raw()`, right?
>>>
>>>       =09pub unsafe fn from_raw(ptr: *const T) -> Self {
>>> =09    ..
>>> =09}
>>>
>>> , what we have is a pointer to T, and we construct a pointer to
>>> `ArcInner<T>/WithRef<T>`, in that function. Because the `sub` on pointe=
r
>>> gets away from provenance? If so, we can also do a sub(0) in the above
>>> code.
>>
>> Not sure what you mean. Operations on raw pointers leave provenance
>> unchanged.
>=20
> Let's look at the function from_raw(), the input is a pointer to T,
> right? So you only have the provenance to T, but in that function, the
> pointer is casted to a pointer to WithRef<T>/ArcInner<T>, that means you
> have the provenance to the whole WithRef<T>/ArcInner<T>, right? My
> question is: why isn't that a UB?

The pointer was originally derived by a call to `into_raw`:
```
     pub fn into_raw(self) -> *const T {
         let ptr =3D self.ptr.as_ptr();
         core::mem::forget(self);
         // SAFETY: The pointer is valid.
         unsafe { core::ptr::addr_of!((*ptr).data) }
     }
```
So in this function the origin (also the origin of the provenance)
of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
Raw pointers do not lose this provenance information when you cast
it and when using `addr_of`/`addr_of_mut`. So provenance is something
that is not really represented in the type system for raw pointers.

When doing a round trip through a reference though, the provenance is
newly assigned and thus would only be valid for a `T`:
```
let raw =3D arc.into_raw();
let reference =3D unsafe { &*raw };
let raw: *const T =3D reference;
let arc =3D unsafe { Arc::from_raw(raw) };
```
Miri would complain about the above code.

--=20
Cheers,
Benno


