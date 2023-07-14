Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CE6753691
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235101AbjGNJbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbjGNJbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:31:41 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA7435A3;
        Fri, 14 Jul 2023 02:31:14 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F34395BC96;
        Fri, 14 Jul 2023 09:15:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326107;
        bh=iunu/MEktIfyC9aBXASL3Y+DNDi/HoqbZYswDE31qjY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=fGwsQoHqMFsrJDlFFDPR0k3MaE5WXRU8RB0KWzOUSDcHpsn22IQyGC3HN2lCwncyK
         wAuqBSwsU1wpop8HxHZZxntrScSS3ywoUW/fICNk8UmtKb6muutZNMoWZ+UcszLYHQ
         M+MSrjQttyZZqxSDaex5VDxabG/Ko11qdgQZOCoFPbKhO+Vjs9pYmCrlIlGj7ggUsr
         BvO2xfMlOB9+4V01CgzNjQgUzvvmG7Sld8Qn/tdtTxtZuPu/XThvbbVBE0MUoxrHM/
         bX5ZWLPWUJJi1j1mSbgEirahVhQ5ap9KDWfGVt536mxdO/c9hzyPFZPJ2SUBaK+FOX
         g+Pc+qui1Bz3w==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:14:02 +0900
Subject: [PATCH RFC 10/11] rust: sync: Add LockdepMap abstraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-10-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=3708;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=iunu/MEktIfyC9aBXASL3Y+DNDi/HoqbZYswDE31qjY=;
 b=04lyCEBPyQa9PMDV9CRJ+d48EyVHc5I664n8RdVhvo5ioHbmWbeIlQUoXCgobM9ilIo2P40ht
 W2v4aU2ydo8CA+EolWeYDtyrdSPo3/F+5Rv8SBH/RL8TWwoGEWLzZtg
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

Add a simple abstraction for creating new lockdep maps. This allows
Rust code to explicitly integrate types with lockdep.

There's some voodoo compiler intrinsic magic to get the caller return
address on the C side. I have no idea how to plumb that through in Rust
if that's even possible, so let's just wrap it in a C helper for now.
That gives us the callsite from the Rust abstraction instead of its
user, but that's probably okay for now.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  | 16 ++++++++++++++++
 rust/kernel/sync/lockdep.rs     | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 57 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 52f32e423b04..5c28de44e528 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,6 +8,7 @@
 
 #include <linux/errname.h>
 #include <linux/slab.h>
+#include <linux/lockdep.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/siphash.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index 1ed71315d1eb..392f5359677a 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -22,6 +22,8 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/instruction_pointer.h>
+#include <linux/lockdep.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
 #include <linux/siphash.h>
@@ -143,6 +145,20 @@ u64 rust_helper_siphash(const void *data, size_t len,
 }
 EXPORT_SYMBOL_GPL(rust_helper_siphash);
 
+void rust_helper_lock_acquire_ret(struct lockdep_map *lock, unsigned int subclass,
+				  int trylock, int read, int check,
+				  struct lockdep_map *nest_lock)
+{
+	lock_acquire(lock, subclass, trylock, read, check, nest_lock, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(rust_helper_lock_acquire_ret);
+
+void rust_helper_lock_release_ret(struct lockdep_map *lock)
+{
+	lock_release(lock, _RET_IP_);
+}
+EXPORT_SYMBOL_GPL(rust_helper_lock_release_ret);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/sync/lockdep.rs b/rust/kernel/sync/lockdep.rs
index fbf9f6ed403d..ca32aa833e10 100644
--- a/rust/kernel/sync/lockdep.rs
+++ b/rust/kernel/sync/lockdep.rs
@@ -187,3 +187,43 @@ pub(crate) fn caller_lock_class() -> (LockClassKey, &'static CStr) {
         }
     }
 }
+
+pub(crate) struct LockdepMap(Opaque<bindings::lockdep_map>);
+pub(crate) struct LockdepGuard<'a>(&'a LockdepMap);
+
+#[allow(dead_code)]
+impl LockdepMap {
+    #[track_caller]
+    pub(crate) fn new() -> Self {
+        let map = Opaque::uninit();
+        let (key, name) = caller_lock_class();
+
+        unsafe {
+            bindings::lockdep_init_map_type(
+                map.get(),
+                name.as_char_ptr(),
+                key.as_ptr(),
+                0,
+                bindings::lockdep_wait_type_LD_WAIT_INV as _,
+                bindings::lockdep_wait_type_LD_WAIT_INV as _,
+                bindings::lockdep_lock_type_LD_LOCK_NORMAL as _,
+            )
+        };
+
+        LockdepMap(map)
+    }
+
+    #[inline(always)]
+    pub(crate) fn lock(&self) -> LockdepGuard<'_> {
+        unsafe { bindings::lock_acquire_ret(self.0.get(), 0, 0, 1, 1, core::ptr::null_mut()) };
+
+        LockdepGuard(self)
+    }
+}
+
+impl<'a> Drop for LockdepGuard<'a> {
+    #[inline(always)]
+    fn drop(&mut self) {
+        unsafe { bindings::lock_release_ret(self.0 .0.get()) };
+    }
+}

-- 
2.40.1

