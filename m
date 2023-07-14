Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC217536A7
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235983AbjGNJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbjGNJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:32:08 -0400
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672163589;
        Fri, 14 Jul 2023 02:31:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 824B45BC45;
        Fri, 14 Jul 2023 09:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689326071;
        bh=dW/rT+o9mD44f+fEVFzmzv8TPDsnFz4bOu43WWTzh9o=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc;
        b=k02ubK4xRgiiAfUm8flIXiwwdo9Q2O2aiDWeRfbWgEMqyf4r3gV9Xbpg6dXYeRJKG
         ewq0BW703FnpYiw+buBayTMUQKW+uUmnWAjP90Z0NRw8w+5ja5gWYC/Utmaz+89oxd
         UT3B7Nt0y3zHY62TlAIg/kl5bkGeHOuUUsQs4ZPX8143qH3/Df79rQSFjtbEU0B6fc
         E8rx7n5jQ4vmN4gHaFadtXBCmbUO2qCj69EGG7vjS+vU3qnF6IMMnFNCG4XbEMlzmE
         WlsEugFBfz65nvh9BA3WIB0Az7fcQYJvQd6bnZ9CPsgYZJU+cLX/FnA5dmtcSiDpq8
         RGINMdbp2NzEA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 18:13:56 +0900
Subject: [PATCH RFC 04/11] rust: siphash: Add a simple siphash abstraction
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-classless_lockdep-v1-4-229b9671ce31@asahilina.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689326040; l=3379;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=dW/rT+o9mD44f+fEVFzmzv8TPDsnFz4bOu43WWTzh9o=;
 b=sqRjyizmAnsE3KuVpoOYj9JEaF1Lt40BSJc0eRr0OzWS1fgeLhLqnSxXTZWi8NqLXLFazg3H7
 YPencTRLL5NBug0aYpj0Bw2qLlosSHju+JIyImsu9Uq9mSHfKPqeogn
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

This simple wrapper allows Rust code to use the Hasher interface with
the kernel siphash implementation. No fancy features supported for now,
just basic bag-of-bytes hashing. No guarantee that hash outputs will
remain stable in the future either.

Signed-off-by: Asahi Lina <lina@asahilina.net>
---
 rust/bindings/bindings_helper.h |  1 +
 rust/helpers.c                  |  8 ++++++++
 rust/kernel/lib.rs              |  1 +
 rust/kernel/siphash.rs          | 39 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 49 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..52f32e423b04 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -10,6 +10,7 @@
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
+#include <linux/siphash.h>
 #include <linux/sched.h>
 
 /* `bindgen` gets confused at certain things. */
diff --git a/rust/helpers.c b/rust/helpers.c
index bb594da56137..1ed71315d1eb 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -24,6 +24,7 @@
 #include <linux/errname.h>
 #include <linux/refcount.h>
 #include <linux/mutex.h>
+#include <linux/siphash.h>
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
 #include <linux/wait.h>
@@ -135,6 +136,13 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+u64 rust_helper_siphash(const void *data, size_t len,
+			const siphash_key_t *key)
+{
+	return siphash(data, len, key);
+}
+EXPORT_SYMBOL_GPL(rust_helper_siphash);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..8fb39078b85c 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -36,6 +36,7 @@
 pub mod ioctl;
 pub mod prelude;
 pub mod print;
+pub mod siphash;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/siphash.rs b/rust/kernel/siphash.rs
new file mode 100644
index 000000000000..e13a17cd5a93
--- /dev/null
+++ b/rust/kernel/siphash.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! A core::hash::Hasher wrapper for the kernel siphash implementation.
+//!
+//! This module allows Rust code to use the kernel's siphash implementation
+//! to hash Rust objects.
+
+use core::hash::Hasher;
+
+/// A Hasher implementation that uses the kernel siphash implementation.
+#[derive(Default)]
+pub struct SipHasher {
+    // SipHash state is 4xu64, but the Linux implementation
+    // doesn't expose incremental hashing so let's just chain
+    // individual SipHash calls for now, which return a u64
+    // hash.
+    state: u64,
+}
+
+impl SipHasher {
+    /// Create a new SipHasher with zeroed state.
+    pub fn new() -> Self {
+        SipHasher { state: 0 }
+    }
+}
+
+impl Hasher for SipHasher {
+    fn finish(&self) -> u64 {
+        self.state
+    }
+
+    fn write(&mut self, bytes: &[u8]) {
+        let key = bindings::siphash_key_t {
+            key: [self.state, 0],
+        };
+
+        self.state = unsafe { bindings::siphash(bytes.as_ptr() as *const _, bytes.len(), &key) };
+    }
+}

-- 
2.40.1

