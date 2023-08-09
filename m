Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2337477626D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 16:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231615AbjHIO11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 10:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjHIO1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 10:27:24 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C01FC2
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 07:27:22 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bdf08860dso212064766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Aug 2023 07:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1691591241; x=1692196041;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=g0tf3b81o/i4i891zt2ZuwmEYtGObIVT0rQr20cIgmM=;
        b=ka2t9rwhuAQFn95vz4kMDFZ3Q0eynbfttN8bDW66C67GMafoIikGXJ/U6LIv/FqASv
         8x76Ej9IXjNbiueHSKNX/n9CkGxHbuHmOydy//zzt6B2nHcfLaEXwrFZ7z/AGGxnyXj8
         d41x/u4f3HPrDeYk/ZcDzJQwSFFbBUyUb8OKOqVCShZ/j3I/+rZW0LIEsiyc2Z8U19Gz
         Qcuu4ta9WCYEJqaKhLAkax4wXHiRX4QJkr5LYmAfp/t3h2Ur5oe3dyGWKHQTYZYHj3nu
         JsV2FzwTRfcN8gu3BI9Q6KG3x82+AaGVKxWCu02OjnrF0AHTc9c7g1KjXUmM0ufeDmb2
         Ui6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691591241; x=1692196041;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g0tf3b81o/i4i891zt2ZuwmEYtGObIVT0rQr20cIgmM=;
        b=SpeVwZ9NiacRGqYELy5Xbk7YN1OAjAf5XKiXQ+jUHXBqBIUvNzW1XVcrrNaVhF6Xo+
         U6sT9yRMAAWw4+L3RWHjfD3rk3eb+6AM9nbaGDgX9k54HSbPLOYVwQcC/biXI+fubcV0
         JDKKS/SnwEN8roI4steog2l6GkSjfypmMiKHsllQHFlLBw8+S7X4K3xQ1PeTfbdFtu+e
         eD+deFcjWHWDAUxNW4VJGAAz6q8LYtZoBwdmQLdcJK7O65gs/7h274KCKZc24Gp0Vp1o
         Jv/N6VokSzAKrXpw1Ww6Mux35ejJeXWWUBHVizG8pp2FvgD/xW01TwoXuplfCnQQ6MAi
         tfBA==
X-Gm-Message-State: AOJu0YyQgR784SDbmoij1igih7ODI4MNlbopEX8rTzt85hiSbpvfYIiA
        FaLvO9Ip+Uc97yWlKlZT78XOTg==
X-Google-Smtp-Source: AGHT+IGtEaU2vZG7J/NZdgzh5skjfNjX0nguXNiqv05n6QVi+LMT+9D9Pw3d6uTPTxMnIXT31iEWaQ==
X-Received: by 2002:a17:906:d54a:b0:978:8979:c66c with SMTP id cr10-20020a170906d54a00b009788979c66cmr13470340ejc.18.1691591240937;
        Wed, 09 Aug 2023 07:27:20 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id h4-20020aa7c944000000b0052369aa9956sm733683edt.26.2023.08.09.07.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:27:20 -0700 (PDT)
References: <20230710074642.683831-1-aliceryhl@google.com>
User-agent: mu4e 1.10.5; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1] rust: add improved version of
 `ForeignOwnable::borrow_mut`
Date:   Wed, 09 Aug 2023 16:09:12 +0200
In-reply-to: <20230710074642.683831-1-aliceryhl@google.com>
Message-ID: <87r0octho8.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Previously, the `ForeignOwnable` trait had a method called `borrow_mut`
> that was intended to provide mutable access to the inner value. However,
> the method accidentally made it possible to change the address of the
> object being modified, which usually isn't what we want. (And when we
> want that, it can be done by calling `from_foreign` and `into_foreign`,
> like how the old `borrow_mut` was implemented.)
>
> In this patch, we introduce an alternate definition of `borrow_mut` that
> solves the previous problem. Conceptually, given a pointer type `P` that
> implements `ForeignOwnable`, the `borrow_mut` method gives you the same
> kind of access as an `&mut P` would, except that it does not let you
> change the pointer `P` itself.
>
> This is analogous to how the existing `borrow` method provides the same
> kind of access to the inner value as an `&P`.
>
> Note that for types like `Arc`, having an `&mut Arc<T>` only gives you
> immutable access to the inner `T`. This is because mutable references
> assume exclusive access, but there might be other handles to the same
> reference counted value, so the access isn't exclusive. The `Arc` type
> implements this by making `borrow_mut` return the same type as `borrow`.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>
> This patch depends on https://lore.kernel.org/all/20230706094615.3080784-1-aliceryhl@google.com/
>
>  rust/kernel/sync/arc.rs | 31 +++++++++-----
>  rust/kernel/types.rs    | 93 ++++++++++++++++++++++++++++++-----------
>  2 files changed, 89 insertions(+), 35 deletions(-)
>  
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index d479f8da8f38..1c2fb36906b6 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -20,66 +20,111 @@
>  /// This trait is meant to be used in cases when Rust objects are stored in C objects and
>  /// eventually "freed" back to Rust.
>  pub trait ForeignOwnable: Sized {
> -    /// Type of values borrowed between calls to [`ForeignOwnable::into_foreign`] and
> -    /// [`ForeignOwnable::from_foreign`].
> +    /// Type used to immutably borrow a value that is currently foreign-owned.
>      type Borrowed<'a>;
>  
> +    /// Type used to mutably borrow a value that is currently foreign-owned.
> +    type BorrowedMut<'a>;
> +
>      /// Converts a Rust-owned object to a foreign-owned one.
>      ///
>      /// The foreign representation is a pointer to void.
>      fn into_foreign(self) -> *const core::ffi::c_void;
>  
> -    /// Borrows a foreign-owned object.
> -    ///
> -    /// # Safety
> -    ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> -
>      /// Converts a foreign-owned object back to a Rust-owned one.
>      ///
>      /// # Safety
>      ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] for
> -    /// this object must have been dropped.
> +    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and it
> +    /// must not be passed to `from_foreign` more than once.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +
> +    /// Borrows a foreign-owned object immutably.
> +    ///
> +    /// This method provides a way to access a foreign-owned value from Rust immutably. It provides
> +    /// you with exactly the same abilities as an `&Self` when the value is Rust-owned.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
> +    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
> +    /// the lifetime 'a.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
> +    /// [`from_foreign`]: Self::from_foreign
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> +
> +    /// Borrows a foreign-owned object mutably.
> +    ///
> +    /// This method provides a way to access a foreign-owned value from Rust mutably. It provides
> +    /// you with exactly the same abilities as an `&mut Self` when the value is Rust-owned, except
> +    /// that this method does not let you swap the foreign-owned object for another. (That is, it
> +    /// does not let you change the address of the void pointer that the foreign code is storing.)

How about this:

"For a smart pointer P<T> this method provides mutable access to T if
&mut P<T> would allow mutable access to T. Otherwise it provides
immutable access to T."

The point is that the method provides access to the pointee, not the
smart pointer itself. In fact it is perfectly fine to do a mem::swawp()
for the pointee in the case of Box and depending on interpretation the
sentence "does not let you swap the foreign-owned object for another" is
confusing.

> +    ///
> +    /// Note that for types like [`Arc`], an `&mut Arc<T>` only gives you immutable access to the
> +    /// inner value, so this method also only provides immutable access in that case.
> +    ///
> +    /// In the case of `Box<T>`, this method gives you the ability to modify the inner `T`, but it
> +    /// does not let you change the box itself. That is, you cannot change which allocation the box
> +    /// points at.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must have been returned by a previous call to [`into_foreign`], and if
> +    /// the pointer is ever passed to [`from_foreign`], then that call must happen after the end of
> +    /// the lifetime 'a.
> +    ///
> +    /// The lifetime 'a must not overlap with the lifetime of any other call to [`borrow`] or
> +    /// `borrow_mut` on the same object.
> +    ///
> +    /// [`into_foreign`]: Self::into_foreign
> +    /// [`from_foreign`]: Self::from_foreign
> +    /// [`borrow`]: Self::borrow
> +    /// [`Arc`]: crate::sync::Arc
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> Self::BorrowedMut<'a>;
>  }
>  
>  impl<T: 'static> ForeignOwnable for Box<T> {
>      type Borrowed<'a> = &'a T;
> +    type BorrowedMut<'a> = &'a mut T;
>  
>      fn into_foreign(self) -> *const core::ffi::c_void {
>          Box::into_raw(self) as _
>      }
>  
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> -        // SAFETY: The safety requirements for this function ensure that the object is still alive,
> -        // so it is safe to dereference the raw pointer.
> -        // The safety requirements of `from_foreign` also ensure that the object remains alive for
> -        // the lifetime of the returned value.
> -        unsafe { &*ptr.cast() }
> -    }
> -
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>          // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
>          // call to `Self::into_foreign`.
>          unsafe { Box::from_raw(ptr as _) }
>      }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a T {
> +        // SAFETY: The safety requirements of this method ensure that the object remains alive and
> +        // immutable for the duration of 'a.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> &'a mut T {
> +        // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
> +        // nothing else will access the value for the duration of 'a.
> +        unsafe { &mut *ptr.cast_mut().cast() }
> +    }
>  }
>  
>  impl ForeignOwnable for () {
>      type Borrowed<'a> = ();
> +    type BorrowedMut<'a> = ();
>  
>      fn into_foreign(self) -> *const core::ffi::c_void {
>          core::ptr::NonNull::dangling().as_ptr()
>      }
>  
> -    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> -
>      unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
> +
> +    unsafe fn borrow<'a>(_: *const core::ffi::c_void) -> Self::Borrowed<'a> {}
> +    unsafe fn borrow_mut<'a>(_: *const core::ffi::c_void) -> Self::BorrowedMut<'a> {}
>  }
>  
>  /// Runs a cleanup function/closure when dropped.
>
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 172f563976a9..f152a562c9c3 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -232,26 +232,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
>  
>  impl<T: 'static> ForeignOwnable for Arc<T> {
>      type Borrowed<'a> = ArcBorrow<'a, T>;
> +    // Mutable access to the `Arc` does not give any extra abilities over
> +    // immutable access.
> +    type BorrowedMut<'a> = ArcBorrow<'a, T>;
>  
>      fn into_foreign(self) -> *const core::ffi::c_void {
>          ManuallyDrop::new(self).ptr.as_ptr() as _
>      }
>  
> -    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> -        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> -        // a previous call to `Arc::into_foreign`.
> -        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
> -
> -        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
> -        // for the lifetime of the returned value.
> -        unsafe { ArcBorrow::new(inner) }
> -    }
> -
>      unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
>          // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>          // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
>          // holds a reference count increment that is transferrable to us.
> -        unsafe { Self::from_inner(NonNull::new(ptr as _).unwrap()) }
> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr as _)) }
>      }
> +
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> +        // SAFETY: By the safety requirement of this function, we know that `ptr` came from
> +        // a previous call to `Arc::into_foreign`.
> +        let inner = unsafe { NonNull::new_unchecked(ptr as *mut ArcInner<T>) };
> +
> +        // SAFETY: The safety requirements ensure that we will not give up our
> +        // foreign-owned refcount while the `ArcBorrow` is still live.
> +        unsafe { ArcBorrow::new(inner) }
> +    }
> +
> +    unsafe fn borrow_mut<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
> +        // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
> +        // requirements for `borrow`.
> +        unsafe { Self::borrow(ptr) }
> +    }

I am not sure this makes sense. How about splitting the trait in two,
immutable and mutable and only implementing the immutable one or Arc?

Best regards,
Andreas

