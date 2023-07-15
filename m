Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42BA3754801
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:43:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjGOJmr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:42:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjGOJmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:42:45 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EA535A9
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 02:42:43 -0700 (PDT)
Date:   Sat, 15 Jul 2023 09:42:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1689414160; x=1689673360;
        bh=9DRWXTeWnC2fmfaUVbe8ysGGNq1WoLrTeIlaoIY6o2I=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=cf1XNQPdH0pWvSSWVwyK/G4iQhP7MORE9YH0Vf13uMgHoaxddm5t2Yo/0+G3BRmJA
         90ETS0sduZHJKFyjQn45viGDVclOZ55u7e4YLtQ2/COY0SMTin5AHUQzY2mifbydzH
         vZ0ZXfOfBoAtEfLlBo1TGQNiieIC7AJkeZR3S3FuMs5I0mLUhrSvS7PSf4vbNjaqjj
         Q+eQJorFmrD/wswEmmPajg2q9GMemC7xYU+a2uiihLwj4AvWOawveMwx7DKlELh4fs
         7og6GghY7b3UW/ANvV5ewp+4sCi66d+SvAVjTvNn4RDcKC+cQCxqvzV9LVKnrB4uoZ
         jTUkxKV5OJqCg==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH v3 2/9] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <CUqkSCKfZbSOwonbc1HECGB3ah_8k404uGJFaebLi2oD8GScDzqRxZ350YdmljslxqUC4mqdvqpbBhD1wFSmCvpA4MhklUGnN6RB0Y8YlFo=@proton.me>
In-Reply-To: <20230711093303.1433770-3-aliceryhl@google.com>
References: <20230711093303.1433770-1-aliceryhl@google.com> <20230711093303.1433770-3-aliceryhl@google.com>
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

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
>=20
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
>=20
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>

LGTM, two small documentation nits below, with them fixed you can add:

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> v2 -> v3:
>  * Use `transmute_copy` to convert metadata.
>  * Use `add` instead of `wrapping_add`.
>  * Dropped Reviewed-by from Martin and Benno due to changes.
>=20
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 49 +++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 48 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 788914fd935f..6963d11092c4 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>  #![feature(const_refs_to_cell)]
>  #![feature(dispatch_from_dyn)]
>  #![feature(new_uninit)]
> +#![feature(ptr_metadata)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..4046b534e53b 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -24,13 +24,13 @@
>  };
>  use alloc::boxed::Box;
>  use core::{
> -    alloc::AllocError,
> +    alloc::{AllocError, Layout},
>      fmt,
>      marker::{PhantomData, Unsize},
>      mem::{ManuallyDrop, MaybeUninit},
>      ops::{Deref, DerefMut},
>      pin::Pin,
> -    ptr::NonNull,
> +    ptr::{NonNull, Pointee},
>  };
>  use macros::pin_data;
>=20
> @@ -212,6 +212,51 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) ->=
 Self {
>          }
>      }
>=20
> +    /// Convert the [`Arc`] into a raw pointer.
> +    ///
> +    /// The raw pointer has ownership of the refcount that this Arc obje=
ct owned.
> +    pub fn into_raw(self) -> *const T {
> +        let ptr =3D self.ptr.as_ptr();
> +        core::mem::forget(self);
> +        // SAFETY: The pointer is valid.
> +        unsafe { core::ptr::addr_of!((*ptr).data) }
> +    }
> +
> +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc=
::into_raw`].
> +    ///
> +    /// This code relies on the `repr(C)` layout of structs as described=
 in
> +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-stru=
cts>.

Why is this in the documentation? I feel like it should be a normal code
comment at the very start of the function.

> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`Arc::into_=
raw`]. Additionally, it
> +    /// can only be called once for each previous call to [`Arc::into_ra=
w`].

"it can only" -> "it must only"

--
Cheers,
Benno

> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> +        // SAFETY: The caller guarantees that the pointer is valid.
> +        let val_layout =3D Layout::for_value(unsafe { &*ptr });
> +        // SAFETY: We're computing the layout of a real struct that exis=
ted when compiling this
> +        // binary, so its layout is not so large that it can trigger ari=
thmetic overflow.
> +        let val_offset =3D unsafe { refcount_layout.extend(val_layout).u=
nwrap_unchecked().1 };
> +
> +        let metadata: <T as Pointee>::Metadata =3D core::ptr::metadata(p=
tr);
> +        // SAFETY: The metadata of `T` and `ArcInner<T>` is the same bec=
ause `ArcInner` is a struct
> +        // with `T` as its last field.
> +        //
> +        // This is documented at:
> +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> +        let metadata: <ArcInner<T> as Pointee>::Metadata =3D
> +            unsafe { core::mem::transmute_copy(&metadata) };
> +        // SAFETY: The pointer is in-bounds of an allocation both before=
 and after offsetting the
> +        // pointer, since it originates from a previous call to `Arc::in=
to_raw` and is still valid.
> +        let ptr =3D unsafe { (ptr as *mut u8).sub(val_offset) as *mut ()=
 };
> +        let ptr =3D core::ptr::from_raw_parts_mut(ptr, metadata);
> +
> +        // SAFETY: By the safety requirements we know that `ptr` came fr=
om `Arc::into_raw`, so the
> +        // reference count held then will be owned by the new `Arc` obje=
ct.
> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr)) }
> +    }
> +
>      /// Returns an [`ArcBorrow`] from the given [`Arc`].
>      ///
>      /// This is useful when the argument of a function call is an [`ArcB=
orrow`] (e.g., in a method
> --
> 2.41.0.255.g8b1d071c50-goog
>=20

