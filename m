Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 173DB753692
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjGNJbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235830AbjGNJbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:43 -0400
X-Greylist: delayed 1026 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 02:31:14 PDT
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A72C3590;
        Fri, 14 Jul 2023 02:31:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 108575BC98;
        Fri, 14 Jul 2023 09:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326113;
        bh=xFmFsNBqZRVhSlLGxOxfGwL4iDHemYFsL2oqYKGuVP4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=wK0ljBsFst8i0xkuxG7oq39DkGfVspC5HFRt2W633aBvgSzpi5qluTbuFVsPce9jh
         Mz2KmGoO56pQOvijBOMvAvifknWm2Ih/gfYXfMLVXmVpCWD89rpIgri0/ifWxcr4Z7
         SpRm+Kn6lAiSJ6vTsMixyc/5gju+Z0DGxC89fi2ItnTFRPCTDVbZRmLZvRXFloKrcF
         x53U4//VdgjZEhd5eidAQ/cBG3uv2Xu5W6FujgBOhBpLifHVZB20r6qcgry7uADMF6
         IQEsXiZSnf7CCF945+uZrOvtSyzFfBhb6ZQ4Y/0LZX/BCdmjCEsVnE0hC/lHiZ9kur
         9BYxeA68EVMlQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:14:03 +0900
Subject: [PATCH RFC 11/11] rust: sync: arc: Add lockdep integration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-11-229b9671ce31@asahilina.net>
References: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
In-Reply-To: <20230714-classless_lockdep-v1-0-229b9671ce31@asahilina.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        asahi@lists.linux.dev, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=9475;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=xFmFsNBqZRVhSlLGxOxfGwL4iDHemYFsL2oqYKGuVP4=;
 b=8TCIgQoDOtdlDTOQ1KYaZ8W1ZUNnhtcHdIS+D+qL5Te5R/4lrDe6FQbsX1YbKI9BxQYDYrMAb
 aKYIHM43XL5AVkNA2yxwidTkvKcj/2NQd8zidbM7/YKf3qfwueVPIE+
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have magic lock class support and a LockdepMap that can be
hooked up into arbitrary Rust types, we can integrate lockdep support
directly into the Rust Arc<T> type. This means we can catch potential
Drop codepaths that could result in a locking error, even if those
codepaths never actually execute due to the reference count being
nonzero at that point.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 lib/Kconfig.debug       |  8 ++++++
 rust/kernel/init.rs     |  6 +++++
 rust/kernel/sync/arc.rs | 71 ++++++++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 82 insertions(+), 3 deletions(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index fbc89baf7de6..ff4f06df88ee 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -3010,6 +3010,14 @@ config RUST_BUILD_ASSERT_ALLOW
 
 	  If unsure, say N.
 
+config RUST_EXTRA_LOCKDEP
+	bool "Extra lockdep checking"
+	depends on RUST && PROVE_LOCKING
+	help
+	  Enabled additional lockdep integration with certain Rust types.
+
+	  If unsure, say N.
+
 endmenu # "Rust"
 
 endmenu # Kernel hacking
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index f190bbd0bab1..b64a507f0a34 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -1208,6 +1208,7 @@ pub trait InPlaceInit<T>: Sized {
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
+    #[track_caller]
     fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>;
@@ -1216,6 +1217,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     /// type.
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
+    #[track_caller]
     fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
     where
         Error: From<E>,
@@ -1228,11 +1230,13 @@ fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Pin<Self>>
     }
 
     /// Use the given initializer to in-place initialize a `T`.
+    #[track_caller]
     fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>;
 
     /// Use the given initializer to in-place initialize a `T`.
+    #[track_caller]
     fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
     where
         Error: From<E>,
@@ -1277,6 +1281,7 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
 
 impl<T> InPlaceInit<T> for UniqueArc<T> {
     #[inline]
+    #[track_caller]
     fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
@@ -1291,6 +1296,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     }
 
     #[inline]
+    #[track_caller]
     fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>,
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a89843cacaad..3bb73b614fd1 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -34,6 +34,9 @@
 };
 use macros::pin_data;
 
+#[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+use crate::sync::lockdep::LockdepMap;
+
 mod std_vendor;
 
 /// A reference-counted pointer to an instance of `T`.
@@ -127,6 +130,17 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }
 
+#[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+#[pin_data]
+#[repr(C)]
+struct ArcInner<T: ?Sized> {
+    refcount: Opaque<bindings::refcount_t>,
+    lockdep_map: LockdepMap,
+    data: T,
+}
+
+// FIXME: pin_data does not work well with cfg attributes within the struct definition.
+#[cfg(not(CONFIG_RUST_EXTRA_LOCKDEP))]
 #[pin_data]
 #[repr(C)]
 struct ArcInner<T: ?Sized> {
@@ -159,11 +173,14 @@ unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
 
 impl<T> Arc<T> {
     /// Constructs a new reference counted instance of `T`.
+    #[track_caller]
     pub fn try_new(contents: T) -> Result<Self, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
         let value = ArcInner {
             // SAFETY: There are no safety requirements for this FFI call.
             refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+            lockdep_map: LockdepMap::new(),
             data: contents,
         };
 
@@ -178,6 +195,7 @@ pub fn try_new(contents: T) -> Result<Self, AllocError> {
     ///
     /// If `T: !Unpin` it will not be able to move afterwards.
     #[inline]
+    #[track_caller]
     pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
     where
         Error: From<E>,
@@ -189,6 +207,7 @@ pub fn pin_init<E>(init: impl PinInit<T, E>) -> error::Result<Self>
     ///
     /// This is equivalent to [`Arc<T>::pin_init`], since an [`Arc`] is always pinned.
     #[inline]
+    #[track_caller]
     pub fn init<E>(init: impl Init<T, E>) -> error::Result<Self>
     where
         Error: From<E>,
@@ -292,15 +311,46 @@ fn drop(&mut self) {
         // freed/invalid memory as long as it is never dereferenced.
         let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
 
+        // SAFETY: By the type invariant, there is necessarily a reference to the object.
+        // We cannot hold the map lock across the reference decrement, as we might race
+        // another thread. Therefore, we lock and immediately drop the guard here. This
+        // only serves to inform lockdep of the dependency up the call stack.
+        #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+        unsafe { self.ptr.as_ref() }.lockdep_map.lock();
+
         // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
         // this instance is being dropped, so the broken invariant is not observable.
         // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
         let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+
         if is_zero {
             // The count reached zero, we must free the memory.
-            //
-            // SAFETY: The pointer was initialised from the result of `Box::leak`.
-            unsafe { Box::from_raw(self.ptr.as_ptr()) };
+
+            // SAFETY: If we get this far, we had the last reference to the object.
+            // That means we are responsible for freeing it, so we can safely lock
+            // the fake lock again. This wraps dropping the inner object, which
+            // informs lockdep of the dependencies down the call stack.
+            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+            let guard = unsafe { self.ptr.as_ref() }.lockdep_map.lock();
+
+            // SAFETY: The pointer was initialised from the result of `Box::leak`,
+            // and the value is valid.
+            unsafe { core::ptr::drop_in_place(&mut self.ptr.as_mut().data) };
+
+            // We need to drop the lock guard before freeing the LockdepMap itself
+            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+            core::mem::drop(guard);
+
+            // SAFETY: The pointer was initialised from the result of `Box::leak`,
+            // and the lockdep map is valid.
+            #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+            unsafe {
+                core::ptr::drop_in_place(&mut self.ptr.as_mut().lockdep_map)
+            };
+
+            // SAFETY: The pointer was initialised from the result of `Box::leak`, and
+            // a ManuallyDrop<T> is compatible. We already dropped the contents above.
+            unsafe { Box::from_raw(self.ptr.as_ptr() as *mut ManuallyDrop<ArcInner<T>>) };
         }
     }
 }
@@ -512,6 +562,7 @@ pub struct UniqueArc<T: ?Sized> {
 
 impl<T> UniqueArc<T> {
     /// Tries to allocate a new [`UniqueArc`] instance.
+    #[track_caller]
     pub fn try_new(value: T) -> Result<Self, AllocError> {
         Ok(Self {
             // INVARIANT: The newly-created object has a ref-count of 1.
@@ -520,13 +571,27 @@ pub fn try_new(value: T) -> Result<Self, AllocError> {
     }
 
     /// Tries to allocate a new [`UniqueArc`] instance whose contents are not initialised yet.
+    #[track_caller]
     pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> {
         // INVARIANT: The refcount is initialised to a non-zero value.
+        #[cfg(CONFIG_RUST_EXTRA_LOCKDEP)]
+        let inner = {
+            let map = LockdepMap::new();
+            Box::try_init::<AllocError>(try_init!(ArcInner {
+                // SAFETY: There are no safety requirements for this FFI call.
+                refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
+                lockdep_map: map,
+                data <- init::uninit::<T, AllocError>(),
+            }? AllocError))?
+        };
+        // FIXME: try_init!() does not work with cfg attributes.
+        #[cfg(not(CONFIG_RUST_EXTRA_LOCKDEP))]
         let inner = Box::try_init::<AllocError>(try_init!(ArcInner {
             // SAFETY: There are no safety requirements for this FFI call.
             refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
             data <- init::uninit::<T, AllocError>(),
         }? AllocError))?;
+
         Ok(UniqueArc {
             // INVARIANT: The newly-created object has a ref-count of 1.
             // SAFETY: The pointer from the `Box` is valid.

-- 
2.40.1

