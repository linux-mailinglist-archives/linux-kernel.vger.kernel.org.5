Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FA17536A9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbjGNJcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbjGNJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBF163599;
        Fri, 14 Jul 2023 02:31:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id A6D035BC4B;
        Fri, 14 Jul 2023 09:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326083;
        bh=YQMECCDF0tMPqG41YW5GqgPmtn/MWGEIPI5Q1NaQYSY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=Phm4cOQp7dNly6KdM+1WaFltuLRCCccAdmrNa2mW1HaP5xISZ8QVF9w5oH4EHsF29
         nBxlu8nN92foqpEy/Cqv9V+Z0UGM5pwEJjyWj1AD56aOJGcMUuhaPldP1A2JDaALE7
         dux48++7nyiMgJ45pEG9vtiIG7qKSCHawDzfhorMgjmbMApa6ydxNSWmBV/ldFv5T8
         d8tQdycNmmNXKi/iBFjfT2Or5qtatxPOK2ZTOz+Q3o5CN0Z8Z3rUOqFHKepPBgcyVZ
         bG27LPWiYfpBp4XRcdTNwbPU85BHVPyqxXrRlYa9QOTsyn2R5VJHIShiaQIVkFfp40
         0l8klm95ruhRQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:58 +0900
Subject: [PATCH RFC 06/11] rust: sync: Replace static LockClassKey refs
 with a pointer wrapper
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-6-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=6618;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=YQMECCDF0tMPqG41YW5GqgPmtn/MWGEIPI5Q1NaQYSY=;
 b=DHnofK17mNqOsVKbC7EuDKWPrgQt8WOHKWeRP7sUdWZGE9Ed0qlD+ubbbZ1HJJjrCebrQ8Ru5
 qfpFd+NvfkgBrKIeVDgO1ojTXJ3jFyt0CJxGcsLXh5mTChXqp5XtkUM
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

We want to be able to handle dynamic lock class creation and using
pointers to things that aren't a real lock_class_key as lock classes.
Doing this by casting around Rust references is difficult without
accidentally invoking UB.

Instead, switch LockClassKey to being a raw pointer wrapper around a
lock_class_key, which means there is no UB possible on the Rust side
just by creating and consuming these objects. The C code also should
never actually dereference lock classes, only use their address
(possibly with an offset).

We still provide a dummy ZST version of this wrapper, to be used when
lockdep is disabled.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync.rs            |  6 +++---
 rust/kernel/sync/condvar.rs    |  2 +-
 rust/kernel/sync/lock.rs       |  4 ++--
 rust/kernel/sync/lockdep.rs    | 27 ++++++++++++++++++++++-----
 rust/kernel/sync/no_lockdep.rs | 15 +++++++++++++--
 rust/kernel/types.rs           |  2 +-
 6 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index 352472c6b77a..49286c3e0ff3 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -20,7 +20,7 @@
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::CondVar;
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
-pub use lockdep::LockClassKey;
+pub use lockdep::{LockClassKey, StaticLockClassKey};
 pub use locked_by::LockedBy;
 
 /// Defines a new static lock class and returns a pointer to it.
@@ -28,8 +28,8 @@
 #[macro_export]
 macro_rules! static_lock_class {
     () => {{
-        static CLASS: $crate::sync::LockClassKey = $crate::sync::LockClassKey::new();
-        &CLASS
+        static CLASS: $crate::sync::StaticLockClassKey = $crate::sync::StaticLockClassKey::new();
+        CLASS.key()
     }};
 }
 
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index ed353399c4e5..3bccb2c6ef84 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -92,7 +92,7 @@ unsafe impl Sync for CondVar {}
 impl CondVar {
     /// Constructs a new condvar initialiser.
     #[allow(clippy::new_ret_no_self)]
-    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(name: &'static CStr, key: LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index d493c5d19104..8e71e7aa2cc1 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -103,7 +103,7 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
     #[allow(clippy::new_ret_no_self)]
-    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
+    pub fn new(t: T, name: &'static CStr, key: LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
@@ -119,7 +119,7 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
     pub fn pin_init<E>(
         t: impl PinInit<T, E>,
         name: &'static CStr,
-        key: &'static LockClassKey,
+        key: LockClassKey,
     ) -> impl PinInit<Self, E>
     where
         E: core::convert::From<core::convert::Infallible>,
diff --git a/rust/kernel/sync/lockdep.rs b/rust/kernel/sync/lockdep.rs
index cb68b18dc0ad..d8328f4275fb 100644
--- a/rust/kernel/sync/lockdep.rs
+++ b/rust/kernel/sync/lockdep.rs
@@ -9,19 +9,36 @@
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
-pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+pub struct StaticLockClassKey(Opaque<bindings::lock_class_key>);
 
-impl LockClassKey {
+impl StaticLockClassKey {
     /// Creates a new lock class key.
     pub const fn new() -> Self {
         Self(Opaque::uninit())
     }
 
+    /// Returns the lock class key reference for this static lock class.
+    pub const fn key(&self) -> LockClassKey {
+        LockClassKey(self.0.get())
+    }
+}
+
+// SAFETY: `bindings::lock_class_key` just represents an opaque memory location, and is never
+// actually dereferenced.
+unsafe impl Sync for StaticLockClassKey {}
+
+/// A reference to a lock class key. This is a raw pointer to a lock_class_key,
+/// which is required to have a static lifetime.
+#[derive(Copy, Clone)]
+pub struct LockClassKey(*mut bindings::lock_class_key);
+
+impl LockClassKey {
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
+        self.0
     }
 }
 
-// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
-// provides its own synchronization.
+// SAFETY: `bindings::lock_class_key` just represents an opaque memory location, and is never
+// actually dereferenced.
+unsafe impl Send for LockClassKey {}
 unsafe impl Sync for LockClassKey {}
diff --git a/rust/kernel/sync/no_lockdep.rs b/rust/kernel/sync/no_lockdep.rs
index 69d42e8d9801..518ec0bf9a7d 100644
--- a/rust/kernel/sync/no_lockdep.rs
+++ b/rust/kernel/sync/no_lockdep.rs
@@ -5,14 +5,25 @@
 //! Takes the place of the `lockdep` module when lockdep is disabled.
 
 /// A dummy, zero-sized lock class.
-pub struct LockClassKey();
+pub struct StaticLockClassKey();
 
-impl LockClassKey {
+impl StaticLockClassKey {
     /// Creates a new dummy lock class key.
     pub const fn new() -> Self {
         Self()
     }
 
+    /// Returns the lock class key reference for this static lock class.
+    pub const fn key(&self) -> LockClassKey {
+        LockClassKey()
+    }
+}
+
+/// A dummy reference to a lock class key.
+#[derive(Copy, Clone)]
+pub struct LockClassKey();
+
+impl LockClassKey {
     pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         core::ptr::null_mut()
     }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 185d3493857e..91739bf71cc3 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -262,7 +262,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
     }
 
     /// Returns a raw pointer to the opaque data.
-    pub fn get(&self) -> *mut T {
+    pub const fn get(&self) -> *mut T {
         UnsafeCell::raw_get(self.0.as_ptr())
     }
 

-- 
2.40.1

