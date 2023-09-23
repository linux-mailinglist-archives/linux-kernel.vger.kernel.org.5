Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B557AC2D5
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjIWOuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 10:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbjIWOuB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 10:50:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741C2180;
        Sat, 23 Sep 2023 07:49:55 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 41be03b00d2f7-578d78ffdbcso2383592a12.2;
        Sat, 23 Sep 2023 07:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695480595; x=1696085395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WM0ZLVHvV+NZ5kwdSJi8dtI3pr22k4r3qhjNO/EWTSA=;
        b=dmFulhyAqpyhfQ5adNZuxE6scb3rZTL3Nn5EAET3YmwhbF/xz2q9wehAb8pjhGxqoE
         Eh/JjYzcNMcXgTovgtLhhw/+9oQf1mA5dNm3OY4JX4m3ae9eO/ynicA/yD+q9YMrnuwF
         T7ampmiI3BZ9lRES/buWylqHAwriB5w1c7yF4GB3Pu3kYFsNotKCDm3hom79RDm4CwJE
         aGKn0IZkIjYVCYMuLQPKsXOnJvHXo5pwdwIXs9X6GAgys942wYx+x/rLCduaxcM+VgSW
         1sLw6Z+xwwFmibglsN39UENu07FV0gLMB8pmazF8K7fBFSTwlFMiMZB6TRfAxI3/rlQX
         L9Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695480595; x=1696085395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WM0ZLVHvV+NZ5kwdSJi8dtI3pr22k4r3qhjNO/EWTSA=;
        b=W3HyuCDsnmhrlEkkvkax0VwLDrQ1z3F1plOvbTtro2TnI8mf/Naz34TeSQ86YAW01i
         dmKm1DWM/Xi19/dG3TfRVXOl6B/aTyEeA4dw7s4N2On6Uh5TRR5s+MtutgJRHWyzZhMq
         6nyLExhaJ5bhMTGuIA45VAoKVA64lePG2ow9uLfrR5QySsEmbpoMwiB8qfsKbV/UJJEp
         zZZXwt8Ku0B8xKtZ7SfxR5OItffaqQvkX2AI/M0C9ta7fYRay82EME3DdWsYJEzkv6QE
         XYC84uzxtGHTIhk1U/ycL4NWYs0mBQeMiIUDmNd9YWgJf5CEpORzdVbQh+4qJg/CaWGM
         pPQw==
X-Gm-Message-State: AOJu0Yz/l8FsYvN8o949jjCfIL6psa4Yn81FeK1muf1pLp7M86iAPJhE
        80OsujksPMOWLfbN996uUNTRI55GTDc=
X-Google-Smtp-Source: AGHT+IFexJCxVn1mtVPRaVvPcIwE4lFmuylVOvYvmpXTEIC0dmwKZJSsZHFYYbwOjpd2i1vdEyJdrw==
X-Received: by 2002:a05:6a20:5482:b0:13a:fa9e:787b with SMTP id i2-20020a056a20548200b0013afa9e787bmr2611143pzk.12.1695480594833;
        Sat, 23 Sep 2023 07:49:54 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id s3-20020a170902ea0300b001c42d4b3675sm5392806plg.309.2023.09.23.07.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 07:49:54 -0700 (PDT)
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
Subject: [PATCH v2 1/2] rust: arc: rename `ArcInner` to `WithRef`
Date:   Sat, 23 Sep 2023 11:49:37 -0300
Message-Id: <20230923144938.219517-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923144938.219517-1-wedsonaf@gmail.com>
References: <20230923144938.219517-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is in preparation for removing `ArcBorrow` and making `WithRef`
public.

This is a pure name change with no functional changes intended.

Suggested-by: Björn Roy Baron <bjorn3_gh@protonmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/sync/arc.rs            | 20 ++++++++++----------
 rust/kernel/sync/arc/std_vendor.rs |  4 ++--
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 3d496391a9bd..86bff1e0002c 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -126,13 +126,13 @@
 /// # Ok::<(), Error>(())
 /// ```
 pub struct Arc<T: ?Sized> {
-    ptr: NonNull<ArcInner<T>>,
-    _p: PhantomData<ArcInner<T>>,
+    ptr: NonNull<WithRef<T>>,
+    _p: PhantomData<WithRef<T>>,
 }
 
 #[pin_data]
 #[repr(C)]
-struct ArcInner<T: ?Sized> {
+struct WithRef<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -164,7 +164,7 @@ impl<T> Arc<T> {
     /// Constructs a new reference counted instance of `T`.
     pub fn try_new(contents: T) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let value = ArcInner {
+        let value = WithRef {
             // SAFETY: There are no safety requirements for this FFI call.
             refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
             data: contents,
@@ -201,13 +201,13 @@ pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
 }
 
 impl<T: ?Sized> Arc<T> {
-    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
+    /// Constructs a new [`Arc`] from an existing [`WithRef`].
     ///
     /// # Safety
     ///
     /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
     /// count, one of which will be owned by the new [`Arc`] instance.
-    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
+    unsafe fn from_inner(inner: NonNull<WithRef<T>>) -> Self {
         // INVARIANT: By the safety requirements, the invariants hold.
         Arc {
             ptr: inner,
@@ -243,7 +243,7 @@ fn into_foreign(self) -> *const core::ffi::c_void {
     unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`.
-        let inner = NonNull::new(ptr as *mut ArcInner<T>).unwrap();
+        let inner = NonNull::new(ptr as *mut WithRef<T>).unwrap();
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
@@ -376,7 +376,7 @@ fn from(item: Pin<UniqueArc<T>>) -> Self {
 /// # Ok::<(), Error>(())
 /// ```
 pub struct ArcBorrow<'a, T: ?Sized + 'a> {
-    inner: NonNull<ArcInner<T>>,
+    inner: NonNull<WithRef<T>>,
     _p: PhantomData<&'a ()>,
 }
 
@@ -406,7 +406,7 @@ impl<T: ?Sized> ArcBorrow<'_, T> {
     /// Callers must ensure the following for the lifetime of the returned [`ArcBorrow`] instance:
     /// 1. That `inner` remains valid;
     /// 2. That no mutable references to `inner` are created.
-    unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
+    unsafe fn new(inner: NonNull<WithRef<T>>) -> Self {
         // INVARIANT: The safety requirements guarantee the invariants.
         Self {
             inner,
@@ -526,7 +526,7 @@ pub fn try_new(value: T) -> Result<Self, AllocError> {
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
     pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
-        let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
+        let inner = Box::try_init::<AllocError>(try_init!(WithRef {
             // SAFETY: There are no safety requirements for this FFI call.
             refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
             data <- init::uninit::<T, AllocError>(),
diff --git a/rust/kernel/sync/arc/std_vendor.rs b/rust/kernel/sync/arc/std_vendor.rs
index a66a0c2831b3..4b30e5597ba5 100644
--- a/rust/kernel/sync/arc/std_vendor.rs
+++ b/rust/kernel/sync/arc/std_vendor.rs
@@ -5,7 +5,7 @@
 //! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
 //! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
 
-use crate::sync::{arc::ArcInner, Arc};
+use crate::sync::{arc::WithRef, Arc};
 use core::any::Any;
 
 impl Arc<dyn Any + Send + Sync> {
@@ -17,7 +17,7 @@ pub fn downcast<T>(self) -> core::result::Result<Arc<T>, Self>
         if (*self).is::<T>() {
             // SAFETY: We have just checked that the type is correct, so we can cast the pointer.
             unsafe {
-                let ptr = self.ptr.cast::<ArcInner<T>>();
+                let ptr = self.ptr.cast::<WithRef<T>>();
                 core::mem::forget(self);
                 Ok(Arc::from_inner(ptr))
             }
-- 
2.34.1

