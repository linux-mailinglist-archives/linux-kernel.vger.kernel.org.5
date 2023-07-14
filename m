Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11CFD75369F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235959AbjGNJcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235873AbjGNJcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:06 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E413594;
        Fri, 14 Jul 2023 02:31:42 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 5C0EA5BC40;
        Fri, 14 Jul 2023 09:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326058;
        bh=y9j+fmO9oWE2TupvVpaaD80X7pDQKCp9sdvtdWdP4zM=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=y84e2wXTjy0hzmtrX37Fvo6re+l/TXA0Bs5Kqc1RccJ2w8WblDu9BBWxmI8KYN6LL
         7Hyq6eJjmnUvRTpLA4aXoIYlc1haDLCjd2dxkJpGyDwe8b4QRiMjNJdJUZseGW49Rb
         iA8HP0D7u811zX8VDaFJgS11NguIUSnEnDszRH4HCZoVRAZIHhmysFsYsNM4Yt5C86
         8PO0TP7/92gQybYXNgpEMxLGZX6LF97opbpfzb08ps5Y6KZhoYHucRMXk5jlMy61Ht
         xe84AHM+oAuc5F3FnZBmfUUdgCaM3DOuixY90ZzdIyLh20o9uyeERVzb+7u2eVmwTn
         WiIE1mlb/BQGg==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:54 +0900
Subject: [PATCH RFC 02/11] rust: lock: Add Lock::pin_init()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-2-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=3329;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=y9j+fmO9oWE2TupvVpaaD80X7pDQKCp9sdvtdWdP4zM=;
 b=HldwayEzarn12NZLBONXhBl2dK70OLqVEoWxGybMgF5VMQyfeDLVYNVFYC4aOjRpascoC/fA3
 nN73G79SFLMD34bCpycjN0Re4OpiEh4nng1Q4gG2YqIe/f7m9yKlLsZ
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

Allow initializing a lock using pin_init!(), instead of requiring
the inner data to be passed through the stack.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/kernel/sync/lock.rs       | 30 +++++++++++++++++++++++++++++-
 rust/kernel/sync/lock/mutex.rs | 13 +++++++++++++
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index a2216325632d..d493c5d19104 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -6,7 +6,9 @@
 //! spinlocks, raw spinlocks) to be provided with minimal effort.
 
 use super::LockClassKey;
-use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque, types::ScopeGuard};
+use crate::{
+    bindings, init::PinInit, pin_init, str::CStr, try_pin_init, types::Opaque, types::ScopeGuard,
+};
 use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
 use macros::pin_data;
 
@@ -87,6 +89,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
     _pin: PhantomPinned,
 
     /// The data protected by the lock.
+    #[pin]
     pub(crate) data: UnsafeCell<T>,
 }
 
@@ -111,6 +114,31 @@ pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinIni
             }),
         })
     }
+
+    /// Constructs a new lock initialiser taking an initialiser.
+    pub fn pin_init<E>(
+        t: impl PinInit<T, E>,
+        name: &'static CStr,
+        key: &'static LockClassKey,
+    ) -> impl PinInit<Self, E>
+    where
+        E: core::convert::From<core::convert::Infallible>,
+    {
+        try_pin_init!(Self {
+            // SAFETY: We are just forwarding the initialization across a
+            // cast away from UnsafeCell, so the pin_init_from_closure and
+            // __pinned_init() requirements are in sync.
+            data <- unsafe { crate::init::pin_init_from_closure(move |slot: *mut UnsafeCell<T>| {
+                t.__pinned_init(slot as *mut T)
+            })},
+            _pin: PhantomPinned,
+            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
+            // static lifetimes so they live indefinitely.
+            state <- Opaque::ffi_init(|slot| unsafe {
+                B::init(slot, name.as_char_ptr(), key.as_ptr())
+            }),
+        }? E)
+    }
 }
 
 impl<T: ?Sized, B: Backend> Lock<T, B> {
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 923472f04af4..06fe685501b4 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -18,6 +18,19 @@ macro_rules! new_mutex {
     };
 }
 
+/// Creates a [`Mutex`] initialiser with the given name and a newly-created lock class,
+/// given an initialiser for the inner type.
+///
+/// It uses the name if one is given, otherwise it generates one based on the file name and line
+/// number.
+#[macro_export]
+macro_rules! new_mutex_pinned {
+    ($inner:expr $(, $name:literal)? $(,)?) => {
+        $crate::sync::Mutex::pin_init(
+            $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
+
 /// A mutual exclusion primitive.
 ///
 /// Exposes the kernel's [`struct mutex`]. When multiple threads attempt to lock the same mutex,

-- 
2.40.1

