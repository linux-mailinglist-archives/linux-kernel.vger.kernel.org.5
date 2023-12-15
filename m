Return-Path: <linux-kernel+bounces-1839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BFDE8154AA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36B1F1C24336
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169F94597E;
	Fri, 15 Dec 2023 23:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e+H1+RoN"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D24818ED4;
	Fri, 15 Dec 2023 23:54:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F32C433C7;
	Fri, 15 Dec 2023 23:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702684483;
	bh=5EwYYWA8F0fFdNa4JLidqy5d/b0oDQvF9+4yyxXbMQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=e+H1+RoNu20ySnrW/QcRqEgNPKscVc2hnDyrfmzdHfrt8dZDVf29ewaCQtP+NbkwG
	 yHNqfHSo1/Wyzc+8pEsszU0a2AxkI705LozazQvf04+8wVF5fkHtUbc+bSUJDMa7/6
	 +a/h5PauT625HrTbtxxu7ISmsmiJm7S78ElNPgqKh7dpJ7vVIXR4cLv8M6zxy4nWw7
	 zCs/ZamfNfbn9g4zkvFVGVOGZ4QKvY2m85f2RhW9RcuW3M7piTHb0Qt2jm4erZCjyl
	 ht1IIfpYJ2oOLsNmY21kAju+LATYcuQKnTRfqn2xj38eo3fPb3OfifqRnEgz62f05F
	 YYLDy7qXWdlTQ==
From: Miguel Ojeda <ojeda@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Alex Gaynor <alex.gaynor@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	FUJITA Tomonori <fujita.tomonori@gmail.com>
Subject: [PATCH] rust: support `srctree`-relative links
Date: Sat, 16 Dec 2023 00:54:28 +0100
Message-ID: <20231215235428.243211-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some of our links use relative paths in order to point to files in the
source tree, e.g.:

    //! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
    /// [`struct mutex`]: ../../../../include/linux/mutex.h

These are problematic because they are hard to maintain and do not support
`O=` builds.

Instead, provide support for `srctree`-relative links, e.g.:

    //! C header: [`include/linux/printk.h`](srctree/include/linux/printk.h)
    /// [`struct mutex`]: srctree/include/linux/mutex.h

The links are fixed after `rustdoc` generation to be based on the absolute
path to the source tree.

Essentially, this is the automatic version of Tomonori's fix [1],
suggested by Gary [2].

Suggested-by: Gary Guo <gary@garyguo.net>
Reported-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Closes: https://lore.kernel.org/r/20231026.204058.2167744626131849993.fujita.tomonori@gmail.com [1]
Fixes: 48fadf440075 ("docs: Move rustdoc output, cross-reference it")
Link: https://lore.kernel.org/rust-for-linux/20231026154525.6d14b495@eugeo/ [2]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/rust/coding-guidelines.rst | 13 +++++++++++++
 rust/Makefile                            |  3 ++-
 rust/kernel/error.rs                     |  2 +-
 rust/kernel/ioctl.rs                     |  2 +-
 rust/kernel/kunit.rs                     |  2 +-
 rust/kernel/print.rs                     |  8 ++++----
 rust/kernel/sync/condvar.rs              |  2 +-
 rust/kernel/sync/lock/mutex.rs           |  2 +-
 rust/kernel/sync/lock/spinlock.rs        |  2 +-
 rust/kernel/task.rs                      |  2 +-
 rust/kernel/workqueue.rs                 |  2 +-
 rust/macros/lib.rs                       |  2 +-
 12 files changed, 28 insertions(+), 14 deletions(-)

diff --git a/Documentation/rust/coding-guidelines.rst b/Documentation/rust/coding-guidelines.rst
index aa8ed082613e..05542840b16c 100644
--- a/Documentation/rust/coding-guidelines.rst
+++ b/Documentation/rust/coding-guidelines.rst
@@ -177,6 +177,19 @@ please take a look at the ``rustdoc`` book at:
 
 	https://doc.rust-lang.org/rustdoc/how-to-write-documentation.html
 
+In addition, the kernel supports creating links relative to the source tree by
+prefixing the link destination with ``srctree/``. For instance:
+
+.. code-block:: rust
+
+	//! C header: [`include/linux/printk.h`](srctree/include/linux/printk.h)
+
+or:
+
+.. code-block:: rust
+
+	/// [`struct mutex`]: srctree/include/linux/mutex.h
+
 
 Naming
 ------
diff --git a/rust/Makefile b/rust/Makefile
index 543b37f6c77f..73ea24117f07 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -98,7 +98,8 @@ rustdoc: rustdoc-core rustdoc-macros rustdoc-compiler_builtins \
 	$(Q)find $(rustdoc_output) -name '*.html' -type f -print0 | xargs -0 sed -Ei \
 		-e 's:rust-logo-[0-9a-f]+\.svg:logo.svg:g' \
 		-e 's:favicon-[0-9a-f]+\.svg:logo.svg:g' \
-		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g'
+		-e 's:<link rel="alternate icon" type="image/png" href="[/.]+/static\.files/favicon-(16x16|32x32)-[0-9a-f]+\.png">::g' \
+		-e 's:<a href="srctree/([^"]+)">:<a href="$(abs_srctree)/\1">:g'
 	$(Q)for f in $(rustdoc_output)/static.files/rustdoc-*.css; do \
 		echo ".logo-container > img { object-fit: contain; }" >> $$f; done
 
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 032b64543953..abd06afb2d76 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -2,7 +2,7 @@
 
 //! Kernel errors.
 //!
-//! C header: [`include/uapi/asm-generic/errno-base.h`](../../../include/uapi/asm-generic/errno-base.h)
+//! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
 use crate::str::CStr;
 
diff --git a/rust/kernel/ioctl.rs b/rust/kernel/ioctl.rs
index c49e1a8d3fd0..f1d42ab69972 100644
--- a/rust/kernel/ioctl.rs
+++ b/rust/kernel/ioctl.rs
@@ -2,7 +2,7 @@
 
 //! ioctl() number definitions
 //!
-//! C header: [`include/asm-generic/ioctl.h`](../../../../include/asm-generic/ioctl.h)
+//! C header: [`include/asm-generic/ioctl.h`](srctree/include/asm-generic/ioctl.h)
 
 #![allow(non_snake_case)]
 
diff --git a/rust/kernel/kunit.rs b/rust/kernel/kunit.rs
index 722655b2d62d..0ba77276ae7e 100644
--- a/rust/kernel/kunit.rs
+++ b/rust/kernel/kunit.rs
@@ -2,7 +2,7 @@
 
 //! KUnit-based macros for Rust unit tests.
 //!
-//! C header: [`include/kunit/test.h`](../../../../../include/kunit/test.h)
+//! C header: [`include/kunit/test.h`](srctree/include/kunit/test.h)
 //!
 //! Reference: <https://docs.kernel.org/dev-tools/kunit/index.html>
 
diff --git a/rust/kernel/print.rs b/rust/kernel/print.rs
index f48926e3e9fe..9b13aca832c2 100644
--- a/rust/kernel/print.rs
+++ b/rust/kernel/print.rs
@@ -2,7 +2,7 @@
 
 //! Printing facilities.
 //!
-//! C header: [`include/linux/printk.h`](../../../../include/linux/printk.h)
+//! C header: [`include/linux/printk.h`](srctree/include/linux/printk.h)
 //!
 //! Reference: <https://www.kernel.org/doc/html/latest/core-api/printk-basics.html>
 
@@ -48,7 +48,7 @@ pub mod format_strings {
     /// The format string is always the same for a given level, i.e. for a
     /// given `prefix`, which are the kernel's `KERN_*` constants.
     ///
-    /// [`_printk`]: ../../../../include/linux/printk.h
+    /// [`_printk`]: srctree/include/linux/printk.h
     const fn generate(is_cont: bool, prefix: &[u8; 3]) -> [u8; LENGTH] {
         // Ensure the `KERN_*` macros are what we expect.
         assert!(prefix[0] == b'\x01');
@@ -97,7 +97,7 @@ pub mod format_strings {
 /// The format string must be one of the ones in [`format_strings`], and
 /// the module name must be null-terminated.
 ///
-/// [`_printk`]: ../../../../include/linux/_printk.h
+/// [`_printk`]: srctree/include/linux/_printk.h
 #[doc(hidden)]
 #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
 pub unsafe fn call_printk(
@@ -120,7 +120,7 @@ pub unsafe fn call_printk(
 ///
 /// Public but hidden since it should only be used from public macros.
 ///
-/// [`_printk`]: ../../../../include/linux/printk.h
+/// [`_printk`]: srctree/include/linux/printk.h
 #[doc(hidden)]
 #[cfg_attr(not(CONFIG_PRINTK), allow(unused_variables))]
 pub fn call_printk_cont(args: fmt::Arguments<'_>) {
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b679b6f6dbeb..f568802d4f8a 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -69,7 +69,7 @@ macro_rules! new_condvar {
 /// }
 /// ```
 ///
-/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
+/// [`struct wait_queue_head`]: srctree/include/linux/wait.h
 #[pin_data]
 pub struct CondVar {
     #[pin]
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 09276fedc091..8c524a3ec45a 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -84,7 +84,7 @@ macro_rules! new_mutex {
 /// }
 /// ```
 ///
-/// [`struct mutex`]: ../../../../include/linux/mutex.h
+/// [`struct mutex`]: srctree/include/linux/mutex.h
 pub type Mutex<T> = super::Lock<T, MutexBackend>;
 
 /// A kernel `struct mutex` lock backend.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 91eb2c9e9123..068535ce1b29 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -82,7 +82,7 @@ macro_rules! new_spinlock {
 /// }
 /// ```
 ///
-/// [`spinlock_t`]: ../../../../include/linux/spinlock.h
+/// [`spinlock_t`]: srctree/include/linux/spinlock.h
 pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
 
 /// A kernel `spinlock_t` lock backend.
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index b2299bc7ac1f..9451932d5d86 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -2,7 +2,7 @@
 
 //! Tasks (threads and processes).
 //!
-//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
+//! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
 use core::{marker::PhantomData, ops::Deref, ptr};
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index b67fb1ba168e..498397877376 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -132,7 +132,7 @@
 //! }
 //! ```
 //!
-//! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
+//! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
 use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
 use alloc::alloc::AllocError;
diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
index c42105c2ff96..3e3cb7449e58 100644
--- a/rust/macros/lib.rs
+++ b/rust/macros/lib.rs
@@ -20,7 +20,7 @@
 /// The `type` argument should be a type which implements the [`Module`]
 /// trait. Also accepts various forms of kernel metadata.
 ///
-/// C header: [`include/linux/moduleparam.h`](../../../include/linux/moduleparam.h)
+/// C header: [`include/linux/moduleparam.h`](srctree/include/linux/moduleparam.h)
 ///
 /// [`Module`]: ../kernel/trait.Module.html
 ///

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.43.0


