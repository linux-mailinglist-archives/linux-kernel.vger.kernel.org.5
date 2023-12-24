Return-Path: <linux-kernel+bounces-10778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F1E81DBB1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 18:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A855C281FDA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 17:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CADAD30F;
	Sun, 24 Dec 2023 17:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CzeYvxnM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D394DD2E5;
	Sun, 24 Dec 2023 17:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88727C43391;
	Sun, 24 Dec 2023 17:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703438509;
	bh=Z6JQdqzQAYOKOqNraVD0SjhYq0w1FpX4Am3bB5s3xYc=;
	h=From:To:Cc:Subject:Date:From;
	b=CzeYvxnMC6/6KaUgc4EOdVuOFE1/jLFORmb5qjAVqTgd9hx4TP173Slz/ZY4Zkhw/
	 ZQAOC4hSV3LGkb9DHDpJ+BGslweJ+VAHVQr421g5Tp/9nelGyzygkp9VpFyJimTqJQ
	 xpU6tvrAHLWp6oufZy7DfhxvVEUUkdRt6EX1HHycUpoyWBZqjeq8d1OdjXfoCMGlHF
	 pQwDeWjCxm0oPoCHckjvDiqvMj5fTD8Umzl1HkkRtrIG4eQYEkw0Tp8MqtSln0ZZ3o
	 BVkSj+gLNJa0QbGrPvA/++TBiTRONt3jFfYOox0FsyaHRzTWibUry4i+78LloQKU7S
	 mIHrYxrYhBn4g==
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
	patches@lists.linux.dev
Subject: [PATCH] rust: upgrade to Rust 1.75.0
Date: Sun, 24 Dec 2023 18:21:28 +0100
Message-ID: <20231224172128.271447-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the next upgrade to the Rust toolchain, from 1.74.1 to 1.75.0
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

The `const_maybe_uninit_zeroed` unstable feature [3] was stabilized in
Rust 1.75.0, which we were using in the PHYLIB abstractions.

The only unstable features allowed to be used outside the `kernel` crate
are still `new_uninit,offset_of`, though other code to be upstreamed
may increase the list.

Please see [4] for details.

# Other improvements

Rust 1.75.0 stabilized `pointer_byte_offsets` [5] which we could
potentially use as an alternative for `ptr_metadata` in the future.

# Required changes

For this upgrade, no changes were required (i.e. on our side).

# `alloc` upgrade and reviewing

The vast majority of changes are due to our `alloc` fork being upgraded
at once.

There are two kinds of changes to be aware of: the ones coming from
upstream, which we should follow as closely as possible, and the updates
needed in our added fallible APIs to keep them matching the newer
infallible APIs coming from upstream.

Instead of taking a look at the diff of this patch, an alternative
approach is reviewing a diff of the changes between upstream `alloc` and
the kernel's. This allows to easily inspect the kernel additions only,
especially to check if the fallible methods we already have still match
the infallible ones in the new version coming from upstream.

Another approach is reviewing the changes introduced in the additions in
the kernel fork between the two versions. This is useful to spot
potentially unintended changes to our additions.

To apply these approaches, one may follow steps similar to the following
to generate a pair of patches that show the differences between upstream
Rust and the kernel (for the subset of `alloc` we use) before and after
applying this patch:

    # Get the difference with respect to the old version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > old.patch
    git -C linux restore rust/alloc

    # Apply this patch.
    git -C linux am rust-upgrade.patch

    # Get the difference with respect to the new version.
    git -C rust checkout $(linux/scripts/min-tool-version.sh rustc)
    git -C linux ls-tree -r --name-only HEAD -- rust/alloc |
        cut -d/ -f3- |
        grep -Fv README.md |
        xargs -IPATH cp rust/library/alloc/src/PATH linux/rust/alloc/PATH
    git -C linux diff --patch-with-stat --summary -R > new.patch
    git -C linux restore rust/alloc

Now one may check the `new.patch` to take a look at the additions (first
approach) or at the difference between those two patches (second
approach). For the latter, a side-by-side tool is recommended.

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1750-2023-12-28 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://github.com/rust-lang/rust/issues/91850 [3]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [4]
Link: https://github.com/rust-lang/rust/issues/96283 [5]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Please note that Rust 1.75.0 will actually be released next week -- this
is based on linux-next since we will need to remove the `feature` line
for the unstable feature used by the to-be-merged PHYLIB abstractions.

 Documentation/process/changes.rst |  2 +-
 rust/alloc/alloc.rs               |  9 ++++++++-
 rust/alloc/boxed.rs               | 20 ++++++++++++--------
 rust/alloc/lib.rs                 |  7 ++++---
 rust/alloc/raw_vec.rs             | 19 +++++++++++++++----
 rust/alloc/vec/mod.rs             | 16 ++++++++++------
 rust/kernel/lib.rs                |  1 -
 scripts/min-tool-version.sh       |  2 +-
 8 files changed, 51 insertions(+), 25 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 2f7fe3e98a1b..4d1b19edc9c5 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.74.1           rustc --version
+Rust (optional)        1.75.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index 150e13750ff7..8a6be8c98173 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -379,13 +379,20 @@ const fn ct_error(_: Layout) -> ! {
         panic!("allocation failed");
     }

+    #[inline]
     fn rt_error(layout: Layout) -> ! {
         unsafe {
             __rust_alloc_error_handler(layout.size(), layout.align());
         }
     }

-    unsafe { core::intrinsics::const_eval_select((layout,), ct_error, rt_error) }
+    #[cfg(not(feature = "panic_immediate_abort"))]
+    unsafe {
+        core::intrinsics::const_eval_select((layout,), ct_error, rt_error)
+    }
+
+    #[cfg(feature = "panic_immediate_abort")]
+    ct_error(layout)
 }

 // For alloc test `std::alloc::handle_alloc_error` can be used directly.
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index 9620eba17268..f5f40778a193 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -161,7 +161,7 @@
 use core::marker::Unsize;
 use core::mem::{self, SizedTypeProperties};
 use core::ops::{
-    CoerceUnsized, Deref, DerefMut, DispatchFromDyn, Generator, GeneratorState, Receiver,
+    CoerceUnsized, Coroutine, CoroutineState, Deref, DerefMut, DispatchFromDyn, Receiver,
 };
 use core::pin::Pin;
 use core::ptr::{self, NonNull, Unique};
@@ -211,7 +211,7 @@ impl<T> Box<T> {
     /// ```
     /// let five = Box::new(5);
     /// ```
-    #[cfg(all(not(no_global_oom_handling)))]
+    #[cfg(not(no_global_oom_handling))]
     #[inline(always)]
     #[stable(feature = "rust1", since = "1.0.0")]
     #[must_use]
@@ -2110,28 +2110,28 @@ fn as_mut(&mut self) -> &mut T {
 #[stable(feature = "pin", since = "1.33.0")]
 impl<T: ?Sized, A: Allocator> Unpin for Box<T, A> where A: 'static {}

-#[unstable(feature = "generator_trait", issue = "43122")]
-impl<G: ?Sized + Generator<R> + Unpin, R, A: Allocator> Generator<R> for Box<G, A>
+#[unstable(feature = "coroutine_trait", issue = "43122")]
+impl<G: ?Sized + Coroutine<R> + Unpin, R, A: Allocator> Coroutine<R> for Box<G, A>
 where
     A: 'static,
 {
     type Yield = G::Yield;
     type Return = G::Return;

-    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> CoroutineState<Self::Yield, Self::Return> {
         G::resume(Pin::new(&mut *self), arg)
     }
 }

-#[unstable(feature = "generator_trait", issue = "43122")]
-impl<G: ?Sized + Generator<R>, R, A: Allocator> Generator<R> for Pin<Box<G, A>>
+#[unstable(feature = "coroutine_trait", issue = "43122")]
+impl<G: ?Sized + Coroutine<R>, R, A: Allocator> Coroutine<R> for Pin<Box<G, A>>
 where
     A: 'static,
 {
     type Yield = G::Yield;
     type Return = G::Return;

-    fn resume(mut self: Pin<&mut Self>, arg: R) -> GeneratorState<Self::Yield, Self::Return> {
+    fn resume(mut self: Pin<&mut Self>, arg: R) -> CoroutineState<Self::Yield, Self::Return> {
         G::resume((*self).as_mut(), arg)
     }
 }
@@ -2448,4 +2448,8 @@ fn cause(&self) -> Option<&dyn core::error::Error> {
     fn source(&self) -> Option<&(dyn core::error::Error + 'static)> {
         core::error::Error::source(&**self)
     }
+
+    fn provide<'b>(&'b self, request: &mut core::error::Request<'b>) {
+        core::error::Error::provide(&**self, request);
+    }
 }
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 9c7ea73da108..345cf5c9cf92 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -80,6 +80,8 @@
     not(no_sync),
     target_has_atomic = "ptr"
 ))]
+#![cfg_attr(not(bootstrap), doc(rust_logo))]
+#![cfg_attr(not(bootstrap), feature(rustdoc_internals))]
 #![no_std]
 #![needs_allocator]
 // Lints:
@@ -115,7 +117,6 @@
 #![feature(const_eval_select)]
 #![feature(const_maybe_uninit_as_mut_ptr)]
 #![feature(const_maybe_uninit_write)]
-#![feature(const_maybe_uninit_zeroed)]
 #![feature(const_pin)]
 #![feature(const_refs_to_cell)]
 #![feature(const_size_of_val)]
@@ -141,7 +142,7 @@
 #![feature(maybe_uninit_uninit_array)]
 #![feature(maybe_uninit_uninit_array_transpose)]
 #![feature(pattern)]
-#![feature(pointer_byte_offsets)]
+#![feature(ptr_addr_eq)]
 #![feature(ptr_internals)]
 #![feature(ptr_metadata)]
 #![feature(ptr_sub_ptr)]
@@ -168,7 +169,7 @@
 //
 // Language features:
 // tidy-alphabetical-start
-#![cfg_attr(not(test), feature(generator_trait))]
+#![cfg_attr(not(test), feature(coroutine_trait))]
 #![cfg_attr(test, feature(panic_update_hook))]
 #![cfg_attr(test, feature(test))]
 #![feature(allocator_internals)]
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index a7425582a323..f1b8cec8cc62 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -338,10 +338,13 @@ pub fn reserve_for_push(&mut self, len: usize) {
     /// The same as `reserve`, but returns on errors instead of panicking or aborting.
     pub fn try_reserve(&mut self, len: usize, additional: usize) -> Result<(), TryReserveError> {
         if self.needs_to_grow(len, additional) {
-            self.grow_amortized(len, additional)
-        } else {
-            Ok(())
+            self.grow_amortized(len, additional)?;
         }
+        unsafe {
+            // Inform the optimizer that the reservation has succeeded or wasn't needed
+            core::intrinsics::assume(!self.needs_to_grow(len, additional));
+        }
+        Ok(())
     }

     /// The same as `reserve_for_push`, but returns on errors instead of panicking or aborting.
@@ -378,7 +381,14 @@ pub fn try_reserve_exact(
         len: usize,
         additional: usize,
     ) -> Result<(), TryReserveError> {
-        if self.needs_to_grow(len, additional) { self.grow_exact(len, additional) } else { Ok(()) }
+        if self.needs_to_grow(len, additional) {
+            self.grow_exact(len, additional)?;
+        }
+        unsafe {
+            // Inform the optimizer that the reservation has succeeded or wasn't needed
+            core::intrinsics::assume(!self.needs_to_grow(len, additional));
+        }
+        Ok(())
     }

     /// Shrinks the buffer down to the specified capacity. If the given amount
@@ -569,6 +579,7 @@ fn alloc_guard(alloc_size: usize) -> Result<(), TryReserveError> {
 // ensure that the code generation related to these panics is minimal as there's
 // only one location which panics rather than a bunch throughout the module.
 #[cfg(not(no_global_oom_handling))]
+#[cfg_attr(not(feature = "panic_immediate_abort"), inline(never))]
 fn capacity_overflow() -> ! {
     panic!("capacity overflow");
 }
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 41ca71805ef0..0d95fd7ef337 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -1376,7 +1376,7 @@ pub fn as_mut_slice(&mut self) -> &mut [T] {
     /// [`as_mut_ptr`]: Vec::as_mut_ptr
     /// [`as_ptr`]: Vec::as_ptr
     #[stable(feature = "vec_as_ptr", since = "1.37.0")]
-    #[cfg_attr(not(bootstrap), rustc_never_returns_null_ptr)]
+    #[rustc_never_returns_null_ptr]
     #[inline]
     pub fn as_ptr(&self) -> *const T {
         // We shadow the slice method of the same name to avoid going through
@@ -1436,7 +1436,7 @@ pub fn as_ptr(&self) -> *const T {
     /// [`as_mut_ptr`]: Vec::as_mut_ptr
     /// [`as_ptr`]: Vec::as_ptr
     #[stable(feature = "vec_as_ptr", since = "1.37.0")]
-    #[cfg_attr(not(bootstrap), rustc_never_returns_null_ptr)]
+    #[rustc_never_returns_null_ptr]
     #[inline]
     pub fn as_mut_ptr(&mut self) -> *mut T {
         // We shadow the slice method of the same name to avoid going through
@@ -1565,7 +1565,8 @@ pub unsafe fn set_len(&mut self, new_len: usize) {
     #[stable(feature = "rust1", since = "1.0.0")]
     pub fn swap_remove(&mut self, index: usize) -> T {
         #[cold]
-        #[inline(never)]
+        #[cfg_attr(not(feature = "panic_immediate_abort"), inline(never))]
+        #[track_caller]
         fn assert_failed(index: usize, len: usize) -> ! {
             panic!("swap_remove index (is {index}) should be < len (is {len})");
         }
@@ -1606,7 +1607,8 @@ fn assert_failed(index: usize, len: usize) -> ! {
     #[stable(feature = "rust1", since = "1.0.0")]
     pub fn insert(&mut self, index: usize, element: T) {
         #[cold]
-        #[inline(never)]
+        #[cfg_attr(not(feature = "panic_immediate_abort"), inline(never))]
+        #[track_caller]
         fn assert_failed(index: usize, len: usize) -> ! {
             panic!("insertion index (is {index}) should be <= len (is {len})");
         }
@@ -1667,7 +1669,7 @@ fn assert_failed(index: usize, len: usize) -> ! {
     #[track_caller]
     pub fn remove(&mut self, index: usize) -> T {
         #[cold]
-        #[inline(never)]
+        #[cfg_attr(not(feature = "panic_immediate_abort"), inline(never))]
         #[track_caller]
         fn assert_failed(index: usize, len: usize) -> ! {
             panic!("removal index (is {index}) should be < len (is {len})");
@@ -2097,6 +2099,7 @@ pub fn pop(&mut self) -> Option<T> {
         } else {
             unsafe {
                 self.len -= 1;
+                core::intrinsics::assume(self.len < self.capacity());
                 Some(ptr::read(self.as_ptr().add(self.len())))
             }
         }
@@ -2299,7 +2302,8 @@ pub fn split_off(&mut self, at: usize) -> Self
         A: Clone,
     {
         #[cold]
-        #[inline(never)]
+        #[cfg_attr(not(feature = "panic_immediate_abort"), inline(never))]
+        #[track_caller]
         fn assert_failed(at: usize, len: usize) -> ! {
             panic!("`at` split index (is {at}) should be <= len (is {len})");
         }
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7ac39874aeac..cb2d024db51f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -14,7 +14,6 @@
 #![no_std]
 #![feature(allocator_api)]
 #![feature(coerce_unsized)]
-#![feature(const_maybe_uninit_zeroed)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(offset_of)]
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index c62066825f53..bcc7d4247290 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.74.1
+	echo 1.75.0
 	;;
 bindgen)
 	echo 0.65.1

base-commit: 39676dfe52331dba909c617f213fdb21015c8d10
--
2.43.0

