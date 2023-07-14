Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69BF67536A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbjGNJc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbjGNJcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:07 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3704435A6;
        Fri, 14 Jul 2023 02:31:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id CB8C15BC8E;
        Fri, 14 Jul 2023 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326095;
        bh=qTjhfjiBkJU6f/AjrudTz4vasN/1yBaW+jjwT+W1pRI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=ghyYl6hi59GB1zxU9EMKMTlNPTziYGtruW4r5bUMuWNTtpjDGLU/XI/AT6a15Asla
         JtX/YknnFQoDmNi28BM1eFj1SnlUPdlO1/EsHBHVS/hklm1TzRjgATLpv4+BUenGuQ
         ssNCYPINuX8DnbxyGr5S7f7LyTLi+7c9cQ6XTUKxku4AB19CU3af1qfljwckOHhl+H
         kt1fiDElfFWCNNsDtnMfHkp8bCiRR3RgXUehiQfzdw94AfncR5aRC8EvNRtJov+ti5
         LdyWP/RD3w1XBlPUGjrWF7WgiWcJaiFIW9r6nbtkd64Id2m1WuFVjQhI/MoZkIid4e
         prYMHZDA4vqcQ==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:14:00 +0900
Subject: [PATCH RFC 08/11] rust: sync: Classless Lock::new() and pin_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-8-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=4989;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=qTjhfjiBkJU6f/AjrudTz4vasN/1yBaW+jjwT+W1pRI=;
 b=VSgLrpW0d/2c9lqEZuqEzHhPFcBQpRyst3tQBod3DJegwz60yvk/KCW+S7R7BF0NS1ztjhNlJ
 wbNq5gOaViABiSAPh+PUQmPAelov6UL1FovyDB/E6yGZEHhOXUUvmNx
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

Use the new automagic lock class code to remove the lock class and name
parameters from Lock::new() and Lock::pin_init(). The old functions
are renamed to new_with_class() and pin_init_with_class() respectively.

The new approach uses the caller tracking machinery in Rust, which means
it can be trivially wrapped by adding #[track_caller] to any functions
that should bubble up lock class creation to their caller. This, for
example, allows a type using multiple Mutexes to create separate lock
classes for every user of the type, simply by adding that attribute to
the mutex creation code paths.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/lock.rs          | 42 +++++++++++++++++++++++++++++++++++----
 rust/kernel/sync/lock/mutex.rs    |  4 ++--
 rust/kernel/sync/lock/spinlock.rs |  2 +-
 3 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 8e71e7aa2cc1..8849741c1d9a 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -5,7 +5,7 @@
 //! It contains a generic Rust lock and guard that allow for different backends (e.g., mutexes,
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
-use super::LockClassKey;
+use super::{lockdep::caller_lock_class, LockClassKey};
 use crate::{
     bindings, init::PinInit, pin_init, str::CStr, try_pin_init, types::Opaque, types::ScopeGuard,
 };
@@ -103,7 +103,40 @@ unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
 impl<T, B: Backend> Lock<T, B> {
     /// Constructs a new lock initialiser.
     #[allow(clippy::new_ret_no_self)]
-    pub fn new(t: T, name: &'static CStr, key: LockClassKey) -> impl PinInit<Self> {
+    #[track_caller]
+    pub fn new(t: T) -> impl PinInit<Self> {
+        let (key, name) = caller_lock_class();
+        Self::new_with_key(t, name, key)
+    }
+
+    /// Constructs a new lock initialiser taking an initialiser/
+    pub fn pin_init<E>(t: impl PinInit<T, E>) -> impl PinInit<Self, E>
+    where
+        E: core::convert::From<core::convert::Infallible>,
+    {
+        let (key, name) = caller_lock_class();
+        Self::pin_init_with_key(t, name, key)
+    }
+
+    /// Constructs a new lock initialiser.
+    #[allow(clippy::new_ret_no_self)]
+    #[track_caller]
+    pub fn new_named(t: T, name: &'static CStr) -> impl PinInit<Self> {
+        let (key, _) = caller_lock_class();
+        Self::new_with_key(t, name, key)
+    }
+
+    /// Constructs a new lock initialiser taking an initialiser/
+    pub fn pin_init_named<E>(t: impl PinInit<T, E>, name: &'static CStr) -> impl PinInit<Self, E>
+    where
+        E: core::convert::From<core::convert::Infallible>,
+    {
+        let (key, _) = caller_lock_class();
+        Self::pin_init_with_key(t, name, key)
+    }
+
+    /// Constructs a new lock initialiser given a particular name and lock class key.
+    pub fn new_with_key(t: T, name: &'static CStr, key: LockClassKey) -> impl PinInit<Self> {
         pin_init!(Self {
             data: UnsafeCell::new(t),
             _pin: PhantomPinned,
@@ -115,8 +148,9 @@ pub fn new(t: T, name: &'static CStr, key: LockClassKey) -> impl PinInit<Self> {
         })
     }
 
-    /// Constructs a new lock initialiser taking an initialiser.
-    pub fn pin_init<E>(
+    /// Constructs a new lock initialiser taking an initialiser given a particular
+    /// name and lock class key.
+    pub fn pin_init_with_key<E>(
         t: impl PinInit<T, E>,
         name: &'static CStr,
         key: LockClassKey,
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 06fe685501b4..15ea70fa3933 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -13,7 +13,7 @@
 #[macro_export]
 macro_rules! new_mutex {
     ($inner:expr $(, $name:literal)? $(,)?) => {
-        $crate::sync::Mutex::new(
+        $crate::sync::Mutex::new_with_key(
             $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
@@ -26,7 +26,7 @@ macro_rules! new_mutex {
 #[macro_export]
 macro_rules! new_mutex_pinned {
     ($inner:expr $(, $name:literal)? $(,)?) => {
-        $crate::sync::Mutex::pin_init(
+        $crate::sync::Mutex::pin_init_with_key(
             $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 979b56464a4e..9f6137f047ee 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -13,7 +13,7 @@
 #[macro_export]
 macro_rules! new_spinlock {
     ($inner:expr $(, $name:literal)? $(,)?) => {
-        $crate::sync::SpinLock::new(
+        $crate::sync::SpinLock::new_with_class(
             $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }

-- 
2.40.1

