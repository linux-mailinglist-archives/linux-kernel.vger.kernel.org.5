Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF147AC2D6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231330AbjIWOuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231831AbjIWOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:50:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB31B2;
        Sat, 23 Sep 2023 07:49:59 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c451541f23so29926235ad.2;
        Sat, 23 Sep 2023 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695480599; x=1696085399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsfSTO1+ET/8ylN5Kt9YqyfDUerwnIWDWqcWtfepBcc=;
        b=Jy1XWIruO0qByZarEt84oOuEeatgnpyCEQ/aNZBKWfzybdurVzhnQKbx1Z78ODRy4C
         nrc/n06tkFNsPC6YOCdGzpoQ0z/lWeglJUcyzUpSq5PP58jKcsORwEsFkXeAn+03EBLp
         K60k8C4SSr6sLDMiARBCW+h/175LxcGw75ZIPGNDI4/cEA0NXQnEoivpHO4S+NvgMEdd
         mB/6TNc4CqlgcEDohmhCvREzBRAs5zdMJu9aGYNs6qgsg/gkPFJwodLmseYnsE8/RU6L
         6+CyB2ahJDg/KD56fN6APdpFc+Bj5cX5WdlQCqDEcoryU+efqrVFHaQoQ8XgINZzP3xT
         eHBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695480599; x=1696085399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsfSTO1+ET/8ylN5Kt9YqyfDUerwnIWDWqcWtfepBcc=;
        b=mEU4lxHFeb7tP/h/1aCoEqRF1pbEQ+qsXa981kWoAKdrIpvAcHWUialEQTvW0Ywjwq
         WCIMj3iuEIKcY82+J1Y639izmVom7a/C0Z5sMjuDF+fquiWlTX/ze2NRN9A5igS6zWww
         YvZnu5ASTcmyzgHcL9ZH2Ts0Zpwxz4DMSJ5MbYE4OFppo+Est4sAUa1I/KJBXdV6E9hw
         lLiywzTCaezMd8kYBAYEdxxf+1C+JDxexAPz3nRGAhr4b8eBIHRgog3fru90IS/cDYgY
         XK+bKv/OT47TxrgGfriT0O9A4UhR6RLIWhaNM7yUDKcI8dhSvMlKuPkr3FMAIrBm3sY+
         E/ww==
X-Gm-Message-State: AOJu0Yy+xnyv7BWzdg4kADU807stYHCwxFXXTkKDnLXsZtcXHR57JnM3
        2R8OR4kFvZNmVpOHje1D2zjFvo6bPBM=
X-Google-Smtp-Source: AGHT+IEmoL7mzUmPG1muY18OmtRDlc/SVru6EsLSmoTOWdFwiBNvzA0YXb3ZJcSzKyhQ6bsJ1SpSxQ==
X-Received: by 2002:a17:902:ed8f:b0:1c5:7470:5658 with SMTP id e15-20020a170902ed8f00b001c574705658mr1502288plj.13.1695480598631;
        Sat, 23 Sep 2023 07:49:58 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id s3-20020a170902ea0300b001c42d4b3675sm5392806plg.309.2023.09.23.07.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:49:58 -0700 (PDT)
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
Subject: [PATCH v2 2/2] rust: arc: remove `ArcBorrow` in favour of `WithRef`
Date:   Sat, 23 Sep 2023 11:49:38 -0300
Message-Id: <20230923144938.219517-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923144938.219517-1-wedsonaf@gmail.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 rust/kernel/sync/arc.rs | 134 ++++++++++++----------------------------
 2 files changed, 39 insertions(+), 97 deletions(-)

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
index 86bff1e0002c..a1806e38c37f 100644
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
@@ -130,13 +130,6 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<WithRef<T>>,
 }
 
-#[pin_data]
-#[repr(C)]
-struct WithRef<T: ?Sized> {
-    refcount: Opaque<bindings::refcount_t>,
-    data: T,
-}
-
 // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
 
@@ -215,16 +208,16 @@ unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
         }
     }
 
-    /// Returns an [`ArcBorrow`] from the given [`Arc`].
+    /// Returns a shared reference to a [`WithRef`] the given [`Arc`].
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
@@ -234,20 +227,17 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
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
@@ -320,119 +310,71 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
     }
 }
 
-/// A borrowed reference to an [`Arc`] instance.
-///
-/// For cases when one doesn't ever need to increment the refcount on the allocation, it is simpler
-/// to use just `&T`, which we can trivially get from an `Arc<T>` instance.
+/// An instance of `T` with an attached reference count.
 ///
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
+/// # Examples
 ///
 /// ```
-/// use kernel::sync::{Arc, ArcBorrow};
+/// use kernel::sync::{Arc, WithRef};
 ///
 /// struct Example;
 ///
-/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
+/// fn do_something(e: &WithRef<Example>) -> Arc<Example> {
 ///     e.into()
 /// }
 ///
 /// let obj = Arc::try_new(Example)?;
-/// let cloned = do_something(obj.as_arc_borrow());
+/// let cloned = do_something(obj.as_with_ref());
 ///
 /// // Assert that both `obj` and `cloned` point to the same underlying object.
 /// assert!(core::ptr::eq(&*obj, &*cloned));
-/// # Ok::<(), Error>(())
 /// ```
 ///
-/// Using `ArcBorrow<T>` as the type of `self`:
+/// Using `WithRef<T>` as the type of `self`:
 ///
 /// ```
-/// use kernel::sync::{Arc, ArcBorrow};
+/// use kernel::sync::{Arc, WithRef};
 ///
 /// struct Example {
-///     a: u32,
-///     b: u32,
+///     _a: u32,
+///     _b: u32,
 /// }
 ///
 /// impl Example {
-///     fn use_reference(self: ArcBorrow<'_, Self>) {
+///     fn use_reference(self: &WithRef<Self>) {
 ///         // ...
 ///     }
 /// }
 ///
-/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
-/// obj.as_arc_borrow().use_reference();
-/// # Ok::<(), Error>(())
+/// let obj = Arc::try_new(Example { _a: 10, _b: 20 })?;
+/// obj.as_with_ref().use_reference();
 /// ```
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
+#[pin_data]
+#[repr(C)]
+pub struct WithRef<T: ?Sized> {
+    refcount: Opaque<bindings::refcount_t>,
+    data: T,
 }
 
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

