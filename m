Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70EB7AA46F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjIUWJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232946AbjIUWIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:08:52 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D4329794;
        Thu, 21 Sep 2023 14:35:06 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5c91bece9so12423485ad.3;
        Thu, 21 Sep 2023 14:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695332106; x=1695936906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaMXIYRdgSMU0GyDTGJxyylDd+HthrxvkGhhTMkKEDY=;
        b=RDG7jR7VxvJKGkh7G4iEvNDHLvwwjkzxce57DPRV2DWNSIx64KW79inq/zs7Og3EfR
         Qe/43M3RCqbhuGPldCs5+gc3WzR+Fcr83FBHraAmnW8ROs4ZyWNOqs20BabOv88rPxlU
         GyYHtTt572n45l2HNnd35EP2oSVx359va8QZCHe6QtcPFlYxRM/aVp8LZvdBucx0xEmD
         QEy0O71YdvkfdrMzwjkf67gKd21yOf3Sbn9bEsib5e8VWzvmlHNcq+iU1pAuleQsXZEg
         05Thg+dcTTTvlG3+pznr8RWghvIX4jAkXq/oq2j3mBbN0c9Y1jBH6BYzH0uKXfUyU3eb
         WazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695332106; x=1695936906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KaMXIYRdgSMU0GyDTGJxyylDd+HthrxvkGhhTMkKEDY=;
        b=wSOmwj4W5XtShFm0/NwuQQfha487A9OG6PchsQX5jFandGNgHTQLBAQL4Pa4UnwRB1
         yX6Os9JxT3cl5nyIPNjzBIpctftrZceqSz13mP+ueEFLwmfMrq+pgomDC1ckwmZbbA5f
         jns3XZYyBr1zWUpH1pffln8iDjU35Ck4A7zKUue2Q27NczplgTj9Uiozb4NLo8xsLMtQ
         dN9Okqrd3GJAan1Jk3OAYKPbzzZwKa6IX9BJj5CX0Phbm4rI6pU8yDAtJhqWAnXRoOIH
         1Yf2YKxfYu7Qt8ryw20n4mOau0DFx1/+OhrBXV5PLrcs20LOx2UWBapvNaP0io3a4vTx
         jZEw==
X-Gm-Message-State: AOJu0Yz/08QUh9B/v8q1X+sQXT+GWkMBeuT3P3SwPLWCvbjw3XUEHo1s
        Eaqtv1LwCeo2N3fxSlNkWzEMhcz+ELI=
X-Google-Smtp-Source: AGHT+IEM1wJisy9a51MpOgfudValE0o0NS1n5eEGCsuJHJwYmlSBoN/0Rn+QT28WWRxNTDMgK2GGmA==
X-Received: by 2002:a17:902:eccb:b0:1c4:62a:e4a with SMTP id a11-20020a170902eccb00b001c4062a0e4amr7503915plh.64.1695332106072;
        Thu, 21 Sep 2023 14:35:06 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id jc6-20020a17090325c600b001c567dcf22dsm2007981plb.281.2023.09.21.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 14:35:05 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Date:   Thu, 21 Sep 2023 18:34:40 -0300
Message-Id: <20230921213440.202017-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921213440.202017-1-wedsonaf@gmail.com>
References: <20230921213440.202017-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

With GATs, we don't need a separate type to represent a borrowed object
with a refcount, we can just use Rust's regular shared borrowing. In
this case, we use `&WithRef<T>` instead of `ArcBorrow<'_, T>`.

Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync.rs     |   2 +-
 rust/kernel/sync/arc.rs | 180 ++++++++++++++--------------------------
 2 files changed, 62 insertions(+), 120 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d219ee518eff..083494884500 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -12,7 +12,7 @@
 pub mod lock;
 mod locked_by;
 
-pub use arc::{Arc, ArcBorrow, UniqueArc};
+pub use arc::{Arc, UniqueArc, WithRef};
 pub use condvar::CondVar;
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
 pub use locked_by::LockedBy;
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 86bff1e0002c..5948e42b9c8f 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -105,14 +105,14 @@
 /// Coercion from `Arc<Example>` to `Arc<dyn MyTrait>`:
 ///
 /// ```
-/// use kernel::sync::{Arc, ArcBorrow};
+/// use kernel::sync::{Arc, WithRef};
 ///
 /// trait MyTrait {
 ///     // Trait has a function whose `self` type is `Arc<Self>`.
 ///     fn example1(self: Arc<Self>) {}
 ///
-///     // Trait has a function whose `self` type is `ArcBorrow<'_, Self>`.
-///     fn example2(self: ArcBorrow<'_, Self>) {}
+///     // Trait has a function whose `self` type is `&WithRef<Self>`.
+///     fn example2(self: &WithRef<Self>) {}
 /// }
 ///
 /// struct Example;
@@ -130,9 +130,48 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<WithRef<T>>,
 }
 
+/// An instance of `T` with an attached reference count.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::sync::{Arc, WithRef};
+///
+/// struct Example;
+///
+/// fn do_something(e: &WithRef<Example>) -> Arc<Example> {
+///     e.into()
+/// }
+///
+/// let obj = Arc::try_new(Example)?;
+/// let cloned = do_something(obj.as_with_ref());
+///
+/// // Assert that both `obj` and `cloned` point to the same underlying object.
+/// assert!(core::ptr::eq(&*obj, &*cloned));
+/// ```
+///
+/// Using `WithRef<T>` as the type of `self`:
+///
+/// ```
+/// use kernel::sync::{Arc, WithRef};
+///
+/// struct Example {
+///     _a: u32,
+///     _b: u32,
+/// }
+///
+/// impl Example {
+///     fn use_reference(self: &WithRef<Self>) {
+///         // ...
+///     }
+/// }
+///
+/// let obj = Arc::try_new(Example { _a: 10, _b: 20 })?;
+/// obj.as_with_ref().use_reference();
+/// ```
 #[pin_data]
 #[repr(C)]
-struct WithRef<T: ?Sized> {
+pub struct WithRef<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -215,16 +254,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
         }
     }
 
-    /// Returns an [`ArcBorrow`] from the given [`Arc`].
+    /// Returns a [`WithRef`] from the given [`Arc`].
     ///
-    /// This is useful when the argument of a function call is an [`ArcBorrow`] (e.g., in a method
-    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcBorrow`] is free when optimised.
+    /// This is useful when the argument of a function call is a [`WithRef`] (e.g., in a method
+    /// receiver), but we have an [`Arc`] instead. Getting a [`WithRef`] is free when optimised.
     #[inline]
-    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
+    pub fn as_with_ref(&self) -> &WithRef<T> {
         // SAFETY: The constraint that the lifetime of the shared reference must outlive that of
-        // the returned `ArcBorrow` ensures that the object remains alive and that no mutable
+        // the returned `WithRef` ensures that the object remains alive and that no mutable
         // reference can be created.
-        unsafe { ArcBorrow::new(self.ptr) }
+        unsafe { self.ptr.as_ref() }
     }
 
     /// Compare whether two [`Arc`] pointers reference the same underlying object.
@@ -234,20 +273,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
 }
 
 impl<T: 'static> ForeignOwnable for Arc<T> {
-    type Borrowed<'a> = ArcBorrow<'a, T>;
+    type Borrowed<'a> = &'a WithRef<T>;
 
     fn into_foreign(self) -> *const core::ffi::c_void {
         ManuallyDrop::new(self).ptr.as_ptr() as _
     }
 
-    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> &'a WithRef<T> {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
-        // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut WithRef<T>).unwrap();
-
-        // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
-        // for the lifetime of the returned value.
-        unsafe { ArcBorrow::new(inner) }
+        // a previous call to `Arc::into_foreign`. The safety requirements of `from_foreign` ensure
+        // that the object remains alive for the lifetime of the returned value.
+        unsafe { &*(ptr.cast::<WithRef<T>>()) }
     }
 
     unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self {
@@ -320,119 +356,25 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
     }
 }
 
-/// A borrowed reference to an [`Arc`] instance.
-///
-/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
-/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
-///
-/// However, when one may need to increment the refcount, it is preferable to use an `ArcBorrow<T>`
-/// over `&Arc<T>` because the latter results in a double-indirection: a pointer (shared reference)
-/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] eliminates this double
-/// indirection while still allowing one to increment the refcount and getting an `Arc<T>` when/if
-/// needed.
-///
-/// # Invariants
-///
-/// There are no mutable references to the underlying [`Arc`], and it remains valid for the
-/// lifetime of the [`ArcBorrow`] instance.
-///
-/// # Example
-///
-/// ```
-/// use kernel::sync::{Arc, ArcBorrow};
-///
-/// struct Example;
-///
-/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
-///     e.into()
-/// }
-///
-/// let obj = Arc::try_new(Example)?;
-/// let cloned = do_something(obj.as_arc_borrow());
-///
-/// // Assert that both `obj` and `cloned` point to the same underlying object.
-/// assert!(core::ptr::eq(&*obj, &*cloned));
-/// # Ok::<(), Error>(())
-/// ```
-///
-/// Using `ArcBorrow<T>` as the type of `self`:
-///
-/// ```
-/// use kernel::sync::{Arc, ArcBorrow};
-///
-/// struct Example {
-///     a: u32,
-///     b: u32,
-/// }
-///
-/// impl Example {
-///     fn use_reference(self: ArcBorrow<'_, Self>) {
-///         // ...
-///     }
-/// }
-///
-/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
-/// obj.as_arc_borrow().use_reference();
-/// # Ok::<(), Error>(())
-/// ```
-pub struct ArcBorrow<'a, T: ?Sized + 'a> {
-    inner: NonNull<WithRef<T>>,
-    _p: PhantomData<&'a ()>,
-}
-
-// This is to allow [`ArcBorrow`] (and variants) to be used as the type of `self`.
-impl<T: ?Sized> core::ops::Receiver for ArcBorrow<'_, T> {}
-
-// This is to allow `ArcBorrow<U>` to be dispatched on when `ArcBorrow<T>` can be coerced into
-// `ArcBorrow<U>`.
-impl<T: ?Sized + Unsize<U>, U: ?Sized> core::ops::DispatchFromDyn<ArcBorrow<'_, U>>
-    for ArcBorrow<'_, T>
-{
-}
-
-impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
-    fn clone(&self) -> Self {
-        *self
-    }
-}
-
-impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
-
-impl<T: ?Sized> ArcBorrow<'_, T> {
-    /// Creates a new [`ArcBorrow`] instance.
-    ///
-    /// # Safety
-    ///
-    /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
-    /// 1. That `inner` remains valid;
-    /// 2. That no mutable references to `inner` are created.
-    unsafe fn new(inner: NonNull<WithRef<T>>) -> Self {
-        // INVARIANT: The safety requirements guarantee the invariants.
-        Self {
-            inner,
-            _p: PhantomData,
-        }
-    }
-}
+// This is to allow [`WithRef`] (and variants) to be used as the type of `self`.
+impl<T: ?Sized> core::ops::Receiver for WithRef<T> {}
 
-impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {
-    fn from(b: ArcBorrow<'_, T>) -> Self {
+impl<T: ?Sized> From<&WithRef<T>> for Arc<T> {
+    fn from(b: &WithRef<T>) -> Self {
         // SAFETY: The existence of `b` guarantees that the refcount is non-zero. `ManuallyDrop`
         // guarantees that `drop` isn't called, so it's ok that the temporary `Arc` doesn't own the
         // increment.
-        ManuallyDrop::new(unsafe { Arc::from_inner(b.inner) })
+        ManuallyDrop::new(unsafe { Arc::from_inner(b.into()) })
             .deref()
             .clone()
     }
 }
 
-impl<T: ?Sized> Deref for ArcBorrow<'_, T> {
+impl<T: ?Sized> Deref for WithRef<T> {
     type Target = T;
 
     fn deref(&self) -> &Self::Target {
-        // SAFETY: By the type invariant, the underlying object is still alive with no mutable
-        // references to it, so it is safe to create a shared reference.
-        unsafe { &self.inner.as_ref().data }
+        &self.data
     }
 }
 
-- 
2.34.1

