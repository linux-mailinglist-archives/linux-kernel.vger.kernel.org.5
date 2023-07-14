Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E087B75368E
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjGNJbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234417AbjGNJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:40 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ACC53594;
        Fri, 14 Jul 2023 02:31:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 94E585BC46;
        Fri, 14 Jul 2023 09:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326077;
        bh=gnMMY1x9qq2PPTNUzBdxhYi7ww499CWLccQC4OWzTx0=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=mOUxHiDwZefAGEFyddpSP0C3sc+AGebB1164Sp4/WwaCwg0cMeyRLTWVxHoyF0dMy
         6+N56AQcfNwJoKzhJCuzDLTiVI1RMbCJsdEvhr8iV6JKWgYsI+boZ8p+fKDP0PuGJh
         tsYRCK3HQwJ12DomTTeRBaj0nYgsJiqMzWaiMR0dHldiGmR/Rr2/qTq47LgkBuG3EH
         Swzgk/2goIh/JslYbAOJeaZQnIIZQuXaYcw1wZ+mTM0pPv76jTMnK26cnAbJUFfQ5L
         mZjStDi/cxIswFfO9cWkjCnGUFXm9X0adKBYPRYOyMaZKOCl8t/i/qnWDN3Gz/4woW
         BvLg/oOhqISKA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:57 +0900
Subject: [PATCH RFC 05/11] rust: sync: Add dummy LockClassKey
 implementation for !CONFIG_LOCKDEP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-5-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=3940;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=gnMMY1x9qq2PPTNUzBdxhYi7ww499CWLccQC4OWzTx0=;
 b=bUWCrMNd7kHfIgvXiwbCtuSH/byuJpb+njsl0PfbHBCQxpRL9xMxqT8cQPBr35CdPxPspIQkK
 dII2uF6hA+OBRhfkDQOkW33pZImPKdLb45I4COXTwZnB1UFS/mveMtP
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

Lock classes aren't used without lockdep. The C side declares the key
as an empty struct in that case, but let's make it an explicit ZST in
Rust, implemented in a separate module. This allows us to more easily
guarantee that the lockdep code will be trivially optimized out without
CONFIG_LOCKDEP, including LockClassKey arguments that are passed around.

Depending on whether CONFIG_LOCKDEP is enabled or not, we then import
the real lockdep implementation or the dummy one.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync.rs            | 29 ++++++++---------------------
 rust/kernel/sync/lockdep.rs    | 27 +++++++++++++++++++++++++++
 rust/kernel/sync/no_lockdep.rs | 19 +++++++++++++++++++
 3 files changed, 54 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index d219ee518eff..352472c6b77a 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -5,37 +5,24 @@
 //! This module contains the kernel APIs related to synchronisation that have been ported or
 //! wrapped for usage by Rust code in the kernel.
 
-use crate::types::Opaque;
-
 mod arc;
 mod condvar;
 pub mod lock;
 mod locked_by;
 
+#[cfg(CONFIG_LOCKDEP)]
+mod lockdep;
+#[cfg(not(CONFIG_LOCKDEP))]
+mod no_lockdep;
+#[cfg(not(CONFIG_LOCKDEP))]
+use no_lockdep as lockdep;
+
 pub use arc::{Arc, ArcBorrow, UniqueArc};
 pub use condvar::CondVar;
 pub use lock::{mutex::Mutex, spinlock::SpinLock};
+pub use lockdep::LockClassKey;
 pub use locked_by::LockedBy;
 
-/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
-#[repr(transparent)]
-pub struct LockClassKey(Opaque<bindings::lock_class_key>);
-
-// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
-// provides its own synchronization.
-unsafe impl Sync for LockClassKey {}
-
-impl LockClassKey {
-    /// Creates a new lock class key.
-    pub const fn new() -> Self {
-        Self(Opaque::uninit())
-    }
-
-    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
-        self.0.get()
-    }
-}
-
 /// Defines a new static lock class and returns a pointer to it.
 #[doc(hidden)]
 #[macro_export]
diff --git a/rust/kernel/sync/lockdep.rs b/rust/kernel/sync/lockdep.rs
new file mode 100644
index 000000000000..cb68b18dc0ad
--- /dev/null
+++ b/rust/kernel/sync/lockdep.rs
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Lockdep utilities.
+//!
+//! This module abstracts the parts of the kernel lockdep API relevant to Rust
+//! modules, including lock classes.
+
+use crate::types::Opaque;
+
+/// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
+#[repr(transparent)]
+pub struct LockClassKey(Opaque<bindings::lock_class_key>);
+
+impl LockClassKey {
+    /// Creates a new lock class key.
+    pub const fn new() -> Self {
+        Self(Opaque::uninit())
+    }
+
+    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
+        self.0.get()
+    }
+}
+
+// SAFETY: `bindings::lock_class_key` is designed to be used concurrently from multiple threads and
+// provides its own synchronization.
+unsafe impl Sync for LockClassKey {}
diff --git a/rust/kernel/sync/no_lockdep.rs b/rust/kernel/sync/no_lockdep.rs
new file mode 100644
index 000000000000..69d42e8d9801
--- /dev/null
+++ b/rust/kernel/sync/no_lockdep.rs
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Dummy lockdep utilities.
+//!
+//! Takes the place of the `lockdep` module when lockdep is disabled.
+
+/// A dummy, zero-sized lock class.
+pub struct LockClassKey();
+
+impl LockClassKey {
+    /// Creates a new dummy lock class key.
+    pub const fn new() -> Self {
+        Self()
+    }
+
+    pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
+        core::ptr::null_mut()
+    }
+}

-- 
2.40.1

