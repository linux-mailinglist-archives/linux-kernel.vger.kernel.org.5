Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274DF7536A8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235542AbjGNJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbjGNJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8093935A4;
        Fri, 14 Jul 2023 02:31:44 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id B932F5BC4D;
        Fri, 14 Jul 2023 09:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326089;
        bh=h5ZcjRNP/lnOzM21gHn80STRsONkXYv0p7ZAO8pU3oM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=XnGfNCkqzklKe5FA35nMn5o1AnUb1N0/lrladszzUQmGAgYYGH2nEgPuuamr4o8SC
         0ZWc975OCW/Eb58iLv57fib/xyJ6hfjWnV0QGUe2BnxCgYwOFdScYzoZgc+uCm6h/n
         6wZIeptGIkHkK/PiEKgawTs+Pwj/83A6WCK7/l0ssjn9INPLEomAL5KpEHd9E+CcLZ
         3Pu/gXuUFgSZnHL9GU+SQS+2HYfAm8PiQxg53aQKe4HOQFXUQnUw+2E3PIJe9ja7W7
         Z4v0ho5J/1+9D9L9WhxV8QbwieJfhboe1oFMogZgaiPTUEJXJi0lV8+pnydeMvxaMs
         GgF6Tt74gxc0A==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:59 +0900
Subject: [PATCH RFC 07/11] rust: sync: Implement dynamic lockdep class
 creation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-7-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=7059;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=h5ZcjRNP/lnOzM21gHn80STRsONkXYv0p7ZAO8pU3oM=;
 b=7sJJXnqbnTBFivUGqqNlSAIdFBChLMnlE3/RL90rl5Nl++csZYeE1q2ObkdjRjEQTa3PqlYfr
 kRTJlpnLvuCC34gIfHsG2lO2nKkQB69ZxLBLKzOhnzzZ+Y/TP6sIKS5
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

Using macros to create lock classes all over the place is unergonomic,
and makes it impossible to add new features that require lock classes to
code such as Arc<> without changing all callers.

Rust has the ability to track the caller's identity by file/line/column
number, and we can use that to dynamically generate lock classes
instead.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/lockdep.rs    | 147 ++++++++++++++++++++++++++++++++++++++++-
 rust/kernel/sync/no_lockdep.rs |   8 +++
 2 files changed, 154 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lockdep.rs b/rust/kernel/sync/lockdep.rs
index d8328f4275fb..fbf9f6ed403d 100644
--- a/rust/kernel/sync/lockdep.rs
+++ b/rust/kernel/sync/lockdep.rs
@@ -5,7 +5,19 @@
 //! This module abstracts the parts of the kernel lockdep API relevant to Rust
 //! modules, including lock classes.
 
-use crate::types::Opaque;
+use crate::{
+    c_str, fmt,
+    init::InPlaceInit,
+    new_mutex,
+    prelude::{Box, Result, Vec},
+    str::{CStr, CString},
+    sync::Mutex,
+    types::Opaque,
+};
+
+use core::hash::{Hash, Hasher};
+use core::pin::Pin;
+use core::sync::atomic::{AtomicPtr, Ordering};
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
 #[repr(transparent)]
@@ -42,3 +54,136 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
 // actually dereferenced.
 unsafe impl Send for LockClassKey {}
 unsafe impl Sync for LockClassKey {}
+
+// Location is 'static but not really, since module unloads will
+// invalidate existing static Locations within that module.
+// To avoid breakage, we maintain our own location struct which is
+// dynamically allocated on first reference. We store a hash of the
+// whole location (including the filename string), as well as the
+// line and column separately. The assumption is that this whole
+// struct is highly unlikely to ever collide with a reasonable
+// hash (this saves us from having to check the filename string
+// itself).
+#[derive(PartialEq, Debug)]
+struct LocationKey {
+    hash: u64,
+    line: u32,
+    column: u32,
+}
+
+struct DynLockClassKey {
+    key: Opaque<bindings::lock_class_key>,
+    loc: LocationKey,
+    name: CString,
+}
+
+impl LocationKey {
+    fn new(loc: &'static core::panic::Location<'static>) -> Self {
+        let mut hasher = crate::siphash::SipHasher::new();
+        loc.hash(&mut hasher);
+
+        LocationKey {
+            hash: hasher.finish(),
+            line: loc.line(),
+            column: loc.column(),
+        }
+    }
+}
+
+impl DynLockClassKey {
+    fn key(&'static self) -> LockClassKey {
+        LockClassKey(self.key.get())
+    }
+
+    fn name(&'static self) -> &CStr {
+        &self.name
+    }
+}
+
+const LOCK_CLASS_BUCKETS: usize = 1024;
+
+#[track_caller]
+fn caller_lock_class_inner() -> Result<&'static DynLockClassKey> {
+    // This is just a hack to make the below static array initialization work.
+    #[allow(clippy::declare_interior_mutable_const)]
+    const ATOMIC_PTR: AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>> =
+        AtomicPtr::new(core::ptr::null_mut());
+
+    #[allow(clippy::complexity)]
+    static LOCK_CLASSES: [AtomicPtr<Mutex<Vec<&'static DynLockClassKey>>>; LOCK_CLASS_BUCKETS] =
+        [ATOMIC_PTR; LOCK_CLASS_BUCKETS];
+
+    let loc = core::panic::Location::caller();
+    let loc_key = LocationKey::new(loc);
+
+    let index = (loc_key.hash % (LOCK_CLASS_BUCKETS as u64)) as usize;
+    let slot = &LOCK_CLASSES[index];
+
+    let mut ptr = slot.load(Ordering::Relaxed);
+    if ptr.is_null() {
+        let new_element = Box::pin_init(new_mutex!(Vec::new()))?;
+
+        if let Err(e) = slot.compare_exchange(
+            core::ptr::null_mut(),
+            // SAFETY: We never move out of this Box
+            Box::into_raw(unsafe { Pin::into_inner_unchecked(new_element) }),
+            Ordering::Relaxed,
+            Ordering::Relaxed,
+        ) {
+            // SAFETY: We just got this pointer from `into_raw()`
+            unsafe { Box::from_raw(e) };
+        }
+
+        ptr = slot.load(Ordering::Relaxed);
+        assert!(!ptr.is_null());
+    }
+
+    // SAFETY: This mutex was either just created above or previously allocated,
+    // and we never free these objects so the pointer is guaranteed to be valid.
+    let mut guard = unsafe { (*ptr).lock() };
+
+    for i in guard.iter() {
+        if i.loc == loc_key {
+            return Ok(i);
+        }
+    }
+
+    // We immediately leak the class, so it becomes 'static
+    let new_class = Box::leak(Box::try_new(DynLockClassKey {
+        key: Opaque::zeroed(),
+        loc: loc_key,
+        name: CString::try_from_fmt(fmt!("{}:{}:{}", loc.file(), loc.line(), loc.column()))?,
+    })?);
+
+    // SAFETY: This is safe to call with a pointer to a dynamically allocated lockdep key,
+    // and we never free the objects so it is safe to never unregister the key.
+    unsafe { bindings::lockdep_register_key(new_class.key.get()) };
+
+    guard.try_push(new_class)?;
+
+    Ok(new_class)
+}
+
+#[track_caller]
+pub(crate) fn caller_lock_class() -> (LockClassKey, &'static CStr) {
+    match caller_lock_class_inner() {
+        Ok(a) => (a.key(), a.name()),
+        Err(_) => {
+            crate::pr_err!(
+                "Failed to dynamically allocate lock class, lockdep may be unreliable.\n"
+            );
+
+            let loc = core::panic::Location::caller();
+            // SAFETY: LockClassKey is opaque and the lockdep implementation only needs
+            // unique addresses for statically allocated keys, so it is safe to just cast
+            // the Location reference directly into a LockClassKey. However, this will
+            // result in multiple keys for the same callsite due to monomorphization,
+            // as well as spuriously destroyed keys when the static key is allocated in
+            // the wrong module, which is what makes this unreliable.
+            (
+                LockClassKey(loc as *const _ as *mut _),
+                c_str!("fallback_lock_class"),
+            )
+        }
+    }
+}
diff --git a/rust/kernel/sync/no_lockdep.rs b/rust/kernel/sync/no_lockdep.rs
index 518ec0bf9a7d..de53c4de7fbe 100644
--- a/rust/kernel/sync/no_lockdep.rs
+++ b/rust/kernel/sync/no_lockdep.rs
@@ -4,6 +4,8 @@
 //!
 //! Takes the place of the `lockdep` module when lockdep is disabled.
 
+use crate::{c_str, str::CStr};
+
 /// A dummy, zero-sized lock class.
 pub struct StaticLockClassKey();
 
@@ -28,3 +30,9 @@ pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
         core::ptr::null_mut()
     }
 }
+
+pub(crate) fn caller_lock_class() -> (LockClassKey, &'static CStr) {
+    static DUMMY_LOCK_CLASS: StaticLockClassKey = StaticLockClassKey::new();
+
+    (DUMMY_LOCK_CLASS.key(), c_str!("dummy"))
+}

-- 
2.40.1

