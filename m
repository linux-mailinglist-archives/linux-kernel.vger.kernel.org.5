Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D4A7AF1A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:16:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjIZRQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjIZRQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:16:22 -0400
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B12E10E;
        Tue, 26 Sep 2023 10:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1695748571; x=1696007771;
        bh=xjSNMyPAuAuwyagMKncLEzGuE6Tzpt2miYsAvV5lTy8=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=QfwSXO66k/SidC0CzWOVITuFy9fJE92O6v9/y5G7JpwcFDem4QLYDnYY2ZJie2fe9
         ajVewlu9DBhkeGWa1SwyixfIKl1sDjwyZEthgmiL83gCAHXEwdbTe1gLG5do3OWlK8
         CNIcxlPETmPd1TBIT7bwl+xYNJKNSUDdtVq434pcaEsjnTNXHWvFoi32qMNIKzzV4m
         hMZssn64knpy2H3bAewtEQ0yLWP5e68qZe49qHaq5BL0NScPVQBqCk5qsVQawfLF6D
         yLd1ntcfKi94mR7KmczshVbbGhGoVs/c+bIb7EDArDnXUmLHquxA23WJSmm+WJWw+q
         VghYTEt6+5gNA==
Date:   Tue, 26 Sep 2023 17:15:52 +0000
To:     Boqun Feng <boqun.feng@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Gary Guo <gary@garyguo.net>, Alice Ryhl <alice@ryhl.io>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Message-ID: <a4090608-d352-742b-fe5e-054db3a8e4a5@proton.me>
In-Reply-To: <ZRMIOsi6-GjFaYLW@Boquns-Mac-mini.home>
References: <9d6d6c94-5da6-a56d-4e85-fbf8da26a0b0@proton.me> <ZRIB0hXNvmJtmyak@boqun-archlinux> <edc0b599-c5d1-4e9c-a51b-eb8ceaef7acc@ryhl.io> <ZRIDc_x9Qh5EJNC8@boqun-archlinux> <61ccfb87-54fd-3f1b-105c-253d0350cd56@proton.me> <20230926162659.6555bcdc@gary-lowrisc-laptop> <ZRL3mlWXqseER8xK@Boquns-Mac-mini.home> <CAH5fLggUPQtNjLg6BnYHcLmefuHdJpg0_eGVgX+dARUTRHexsA@mail.gmail.com> <ZRMIOsi6-GjFaYLW@Boquns-Mac-mini.home>
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

On 26.09.23 18:35, Boqun Feng wrote:
> On Tue, Sep 26, 2023 at 05:41:17PM +0200, Alice Ryhl wrote:
>> On Tue, Sep 26, 2023 at 5:24=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>>>
>>> On Tue, Sep 26, 2023 at 04:26:59PM +0800, Gary Guo wrote:
>>>> On Mon, 25 Sep 2023 22:26:56 +0000
>>>> Benno Lossin <benno.lossin@proton.me> wrote:
>>>>
>>> [...]
>>>>>
>>>>> The pointer was originally derived by a call to `into_raw`:
>>>>> ```
>>>>>       pub fn into_raw(self) -> *const T {
>>>>>           let ptr =3D self.ptr.as_ptr();
>>>>>           core::mem::forget(self);
>>>>>           // SAFETY: The pointer is valid.
>>>>>           unsafe { core::ptr::addr_of!((*ptr).data) }
>>>>>       }
>>>>> ```
>>>>> So in this function the origin (also the origin of the provenance)
>>>>> of the pointer is `ptr` which is of type `NonNull<WithRef<T>>`.
>>>>> Raw pointers do not lose this provenance information when you cast
>>>>> it and when using `addr_of`/`addr_of_mut`. So provenance is something
>>>>> that is not really represented in the type system for raw pointers.
>>>>>
>>>>> When doing a round trip through a reference though, the provenance is
>>>>> newly assigned and thus would only be valid for a `T`:
>>>>> ```
>>>>> let raw =3D arc.into_raw();
>>>>> let reference =3D unsafe { &*raw };
>>>>> let raw: *const T =3D reference;
>>>>> let arc =3D unsafe { Arc::from_raw(raw) };
>>>>> ```
>>>>> Miri would complain about the above code.
>>>>>
>>>>
>>>> One thing we can do is to opt from strict provenance, so:
>>>>
>>>
>>> A few questions about strict provenance:
>>>
>>>> ```
>>>> let raw =3D arc.into_raw();
>>>> let _ =3D raw as usize; // expose the provenance of raw
>>>
>>> Should this be a expose_addr()?
>>
>> Pointer to integer cast is equivalent to expose_addr.
>>
>>>> let reference =3D unsafe { &*raw };
>>>> let raw =3D reference as *const T as usize as *const T;
>>>
>>> and this is a from_exposed_addr{_mut}(), right?
>>
>> Integer to pointer cast is equivalent to from_exposed_addr.
>>
>=20
> Got it, thanks!
>=20
>>>> let arc =3D unsafe { Arc::from_raw(raw) };
>>>> ```
>>>>
>>>
>>> One step back, If we were to use strict provenance API (i.e.
>>> expose_addr()/from_exposed_addr()), we could use it to "fix" the
>>> original problem? By:
>>>
>>> *       expose_addr() in as_with_ref()
>>> *       from_exposed_addr() in `impl From<&WithRef<T>> for Arc`
>>>
>>> right?
>>>
>>> More steps back, is the original issue only a real issue under strict
>>> provenance rules? Don't make me wrong, I like the ideas behind strict
>>> provenance, I just want to check, if we don't enable strict provenance
>>> (as a matter of fact, we don't do it today),
>>
>> Outside of miri, strict provenance is not really something you enable.
>> It's a set of rules that are stricter than the real rules, that are
>> designed such that when you follow them, your code will be correct
>> under any conceivable memory model we might end up with. They will
>> never be the rules that the compiler actually uses.
>>
>> I think by "opt out from strict provenance", Gary just meant "use
>> int2ptr and ptr2int casts to reset the provenance".
>>
>>> will the original issue found by Alice be a UB?
>>
>> Yes, it's UB under any ruleset that exists out there. There's no flag
>> to turn it off.
>>
>>> Or is there a way to disable Miri's check on
>>> strict provenance? IIUC, the cause of the original issue is that "you
>>> cannot reborrow a pointer derived from a `&` to get a `&mut`, even when
>>> there is no other alias to the same object". Maybe I'm still missing
>>> something, but without strict provenance, is this a problem? Or is ther=
e
>>> a provenance model of Rust without strict provenance?
>>
>> It's a problem under all of the memory models. The rule being violated
>> is exactly the same rule as the one behind this paragraph:
>>
>>> Transmuting an & to &mut is Undefined Behavior. While certain usages ma=
y appear safe, note that the Rust optimizer is free to assume that a shared=
 reference won't change through its lifetime and thus such transmutation wi=
ll run afoul of those assumptions. So:
>>>
>>> Transmuting an & to &mut is always Undefined Behavior.
>>> No you can't do it.
>>> No you're not special.
>> From: https://doc.rust-lang.org/nomicon/transmutes.html
>=20
> But here the difference it that we only derive a `*mut` from a `&`,
> rather than transmute to a `&mut`, right? We only use `&` to get a
> pointer value (a usize), so I don't think that rule applies here? Or in
> other words, does the following implemenation look good to you?
>=20
> =09impl<T: ?Sized> Arc<T> {
> =09    pub fn as_with_ref(&self) -> &WithRef<T> {
> =09=09// expose
> =09=09let _ =3D self.ptr.as_ptr() as usize;
> =09=09unsafe { self.ptr.as_ref() }
> =09    }
> =09}
>=20
> =09impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
> =09    fn from(b: &WithRef<T>) -> Self {
> =09=09// from exposed
> =09=09let ptr =3D unsafe { NonNull::new_unchecked(b as *const _ as usize =
as *mut _) };
> =09=09// SAFETY: The existence of `b` guarantees that the refcount is non=
-zero. `ManuallyDrop`
> =09=09// guarantees that `drop` isn't called, so it's ok that the tempora=
ry `Arc` doesn't own the
> =09=09// increment.
> =09=09ManuallyDrop::new(unsafe { Arc::from_inner(ptr) })
> =09=09    .deref()
> =09=09    .clone()
> =09    }
> =09}
>=20
>=20
> An equivalent code snippet is as below (in case anyone wants to try it
> in miri):
> ```rust
>      let raw =3D Box::into_raw(arc);
>=20
>      // as_with_ref()
>      let _ =3D raw as usize;
>      let reference =3D unsafe { &*raw };
>=20
>      // from()
>      let raw: *mut T =3D reference as *const _ as usize as  *mut _ ;
>=20
>      // drop()
>      let arc =3D unsafe { Box::from_raw(raw) };
> ```

I don't understand why we are trying to use ptr2int to fix this.
Simply wrapping the `T` field inside `WithRef` with `UnsafeCell`
should be enough.

--=20
Cheers,
Benno


