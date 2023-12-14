Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F93812BB8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443313AbjLNJaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjLNJaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:30:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD1F98
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:30:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DBDEC433C8;
        Thu, 14 Dec 2023 09:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702546209;
        bh=ipo+ZdgujIuYUNihC0cAJv7i7yV0o4BGfDbEHQMMYM4=;
        h=From:To:Cc:Subject:Date:From;
        b=M84UR9JobmlophVsPTfrhPKg3/gcYQfTFyxp07mocaf/j28m6UthKUTrv2cf9H6A0
         rScnPB++JgVb8gnF4G27phjNa5Il2LSsCUl1adEtj94aPWTyevlk4eRVFTDVG1L+VM
         IHK52kH7/AV8+HMV6+Wr1xMaQFnCF4xqJAWmIbv6wK32gBJYax/XY1hwVrtnwCFviz
         Y6hKF21oMOXjxYKO/Ld+2vNEfNe5cIOQrDLupcNgvLAku6TXst3IqgdC3DU3FYhp9r
         bkF7AZH0AVO441pfyrIvEAqQS/Ye0AvwpXD8g1c0qEQ38LBsnQGTpbWSG9Kd8iR+y2
         //HXbAt2UhrqA==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH] rust: upgrade to Rust 1.74.1
Date:   Thu, 14 Dec 2023 10:29:58 +0100
Message-ID: <20231214092958.377061-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the next upgrade to the Rust toolchain, from 1.73.0 to 1.74.1
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

No unstable features (that we use) were stabilized.

Therefore, the only unstable features allowed to be used outside the
`kernel` crate are still `new_uninit,offset_of`, though other code to
be upstreamed may increase the list (e.g. `offset_of` was added recently).

Please see [3] for details.

# Other improvements

Rust 1.74.0 allows to use `#[repr(Rust)]` explicitly [4], which can be
useful to be explicit about particular cases that would normally use
e.g. the C representation, such as silencing lints like the upcoming
additions we requested [5] to the `no_mangle_with_rust_abi` Clippy lint
(which in turn triggered the `#[repr(Rust)]` addition).

Rust 1.74.0 includes a fix for one of the false negative cases we reported
in Clippy's `disallowed_macros` lint [6] that we would like to use in
the future.

Rust 1.74.1 fixes an ICE that the Apple AGX GPU driver was hitting [7].

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

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1741-2023-12-07 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
Link: https://github.com/rust-lang/rust/pull/114201 [4]
Link: https://github.com/rust-lang/rust-clippy/issues/11219 [5]
Link: https://github.com/rust-lang/rust-clippy/issues/11431 [6]
Link: https://github.com/rust-lang/rust/issues/117976#issuecomment-1822225691 [7]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/changes.rst |  2 +-
 rust/alloc/alloc.rs               | 32 ++++++++----
 rust/alloc/lib.rs                 |  6 +--
 rust/alloc/slice.rs               |  2 +-
 rust/alloc/vec/mod.rs             | 87 ++++++++++++++++++++++++++++++-
 scripts/min-tool-version.sh       |  2 +-
 6 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index bb96ca0f774b..169f67773518 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.73.0           rustc --version
+Rust (optional)        1.74.1           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index 8cb4a31cf6e5..150e13750ff7 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -345,18 +345,31 @@ unsafe fn exchange_malloc(size: usize, align: usize) -> *mut u8 {
     fn __rust_alloc_error_handler(size: usize, align: usize) -> !;
 }
 
-/// Abort on memory allocation error or failure.
+/// Signal a memory allocation error.
 ///
-/// Callers of memory allocation APIs wishing to abort computation
+/// Callers of memory allocation APIs wishing to cease execution
 /// in response to an allocation error are encouraged to call this function,
-/// rather than directly invoking `panic!` or similar.
+/// rather than directly invoking [`panic!`] or similar.
 ///
-/// The default behavior of this function is to print a message to standard error
-/// and abort the process.
-/// It can be replaced with [`set_alloc_error_hook`] and [`take_alloc_error_hook`].
+/// This function is guaranteed to diverge (not return normally with a value), but depending on
+/// global configuration, it may either panic (resulting in unwinding or aborting as per
+/// configuration for all panics), or abort the process (with no unwinding).
+///
+/// The default behavior is:
+///
+///  * If the binary links against `std` (typically the case), then
+///   print a message to standard error and abort the process.
+///   This behavior can be replaced with [`set_alloc_error_hook`] and [`take_alloc_error_hook`].
+///   Future versions of Rust may panic by default instead.
+///
+/// * If the binary does not link against `std` (all of its crates are marked
+///   [`#![no_std]`][no_std]), then call [`panic!`] with a message.
+///   [The panic handler] applies as to any panic.
 ///
 /// [`set_alloc_error_hook`]: ../../std/alloc/fn.set_alloc_error_hook.html
 /// [`take_alloc_error_hook`]: ../../std/alloc/fn.take_alloc_error_hook.html
+/// [The panic handler]: https://doc.rust-lang.org/reference/runtime.html#the-panic_handler-attribute
+/// [no_std]: https://doc.rust-lang.org/reference/names/preludes.html#the-no_std-attribute
 #[stable(feature = "global_alloc", since = "1.28.0")]
 #[rustc_const_unstable(feature = "const_alloc_error", issue = "92523")]
 #[cfg(all(not(no_global_oom_handling), not(test)))]
@@ -397,9 +410,10 @@ pub unsafe fn __rdl_oom(size: usize, _align: usize) -> ! {
         if unsafe { __rust_alloc_error_handler_should_panic != 0 } {
             panic!("memory allocation of {size} bytes failed")
         } else {
-            core::panicking::panic_nounwind_fmt(format_args!(
-                "memory allocation of {size} bytes failed"
-            ))
+            core::panicking::panic_nounwind_fmt(
+                format_args!("memory allocation of {size} bytes failed"),
+                /* force_no_backtrace */ false,
+            )
         }
     }
 }
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 73b9ffd845d9..9c7ea73da108 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -90,8 +90,8 @@
 #![warn(missing_docs)]
 #![allow(explicit_outlives_requirements)]
 #![warn(multiple_supertrait_upcastable)]
-#![cfg_attr(not(bootstrap), allow(internal_features))]
-#![cfg_attr(not(bootstrap), allow(rustdoc::redundant_explicit_links))]
+#![allow(internal_features)]
+#![allow(rustdoc::redundant_explicit_links)]
 //
 // Library features:
 // tidy-alphabetical-start
@@ -122,6 +122,7 @@
 #![feature(const_waker)]
 #![feature(core_intrinsics)]
 #![feature(core_panic)]
+#![feature(deprecated_suggestion)]
 #![feature(dispatch_from_dyn)]
 #![feature(error_generic_member_access)]
 #![feature(error_in_core)]
@@ -145,7 +146,6 @@
 #![feature(ptr_metadata)]
 #![feature(ptr_sub_ptr)]
 #![feature(receiver_trait)]
-#![feature(saturating_int_impl)]
 #![feature(set_ptr_value)]
 #![feature(sized_type_properties)]
 #![feature(slice_from_ptr_range)]
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
index 6ac463bd3edc..1181836da5f4 100644
--- a/rust/alloc/slice.rs
+++ b/rust/alloc/slice.rs
@@ -594,7 +594,7 @@ pub fn join<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Outp
     /// ```
     #[rustc_allow_incoherent_impl]
     #[stable(feature = "rust1", since = "1.0.0")]
-    #[deprecated(since = "1.3.0", note = "renamed to join")]
+    #[deprecated(since = "1.3.0", note = "renamed to join", suggestion = "join")]
     pub fn connect<Separator>(&self, sep: Separator) -> <Self as Join<Separator>>::Output
     where
         Self: Join<Separator>,
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 209a88cfe598..41ca71805ef0 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -1228,8 +1228,8 @@ pub fn into_boxed_slice(mut self) -> Box<[T], A> {
     /// Shortens the vector, keeping the first `len` elements and dropping
     /// the rest.
     ///
-    /// If `len` is greater than the vector's current length, this has no
-    /// effect.
+    /// If `len` is greater or equal to the vector's current length, this has
+    /// no effect.
     ///
     /// The [`drain`] method can emulate `truncate`, but causes the excess
     /// elements to be returned instead of dropped.
@@ -1336,6 +1336,15 @@ pub fn as_mut_slice(&mut self) -> &mut [T] {
     /// is never written to (except inside an `UnsafeCell`) using this pointer or any pointer
     /// derived from it. If you need to mutate the contents of the slice, use [`as_mut_ptr`].
     ///
+    /// This method guarantees that for the purpose of the aliasing model, this method
+    /// does not materialize a reference to the underlying slice, and thus the returned pointer
+    /// will remain valid when mixed with other calls to [`as_ptr`] and [`as_mut_ptr`].
+    /// Note that calling other methods that materialize mutable references to the slice,
+    /// or mutable references to specific elements you are planning on accessing through this pointer,
+    /// as well as writing to those elements, may still invalidate this pointer.
+    /// See the second example below for how this guarantee can be used.
+    ///
+    ///
     /// # Examples
     ///
     /// ```
@@ -1349,8 +1358,25 @@ pub fn as_mut_slice(&mut self) -> &mut [T] {
     /// }
     /// ```
     ///
+    /// Due to the aliasing guarantee, the following code is legal:
+    ///
+    /// ```rust
+    /// unsafe {
+    ///     let mut v = vec![0, 1, 2];
+    ///     let ptr1 = v.as_ptr();
+    ///     let _ = ptr1.read();
+    ///     let ptr2 = v.as_mut_ptr().offset(2);
+    ///     ptr2.write(2);
+    ///     // Notably, the write to `ptr2` did *not* invalidate `ptr1`
+    ///     // because it mutated a different element:
+    ///     let _ = ptr1.read();
+    /// }
+    /// ```
+    ///
     /// [`as_mut_ptr`]: Vec::as_mut_ptr
+    /// [`as_ptr`]: Vec::as_ptr
     #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[cfg_attr(not(bootstrap), rustc_never_returns_null_ptr)]
     #[inline]
     pub fn as_ptr(&self) -> *const T {
         // We shadow the slice method of the same name to avoid going through
@@ -1366,6 +1392,15 @@ pub fn as_ptr(&self) -> *const T {
     /// Modifying the vector may cause its buffer to be reallocated,
     /// which would also make any pointers to it invalid.
     ///
+    /// This method guarantees that for the purpose of the aliasing model, this method
+    /// does not materialize a reference to the underlying slice, and thus the returned pointer
+    /// will remain valid when mixed with other calls to [`as_ptr`] and [`as_mut_ptr`].
+    /// Note that calling other methods that materialize references to the slice,
+    /// or references to specific elements you are planning on accessing through this pointer,
+    /// may still invalidate this pointer.
+    /// See the second example below for how this guarantee can be used.
+    ///
+    ///
     /// # Examples
     ///
     /// ```
@@ -1383,7 +1418,25 @@ pub fn as_ptr(&self) -> *const T {
     /// }
     /// assert_eq!(&*x, &[0, 1, 2, 3]);
     /// ```
+    ///
+    /// Due to the aliasing guarantee, the following code is legal:
+    ///
+    /// ```rust
+    /// unsafe {
+    ///     let mut v = vec![0];
+    ///     let ptr1 = v.as_mut_ptr();
+    ///     ptr1.write(1);
+    ///     let ptr2 = v.as_mut_ptr();
+    ///     ptr2.write(2);
+    ///     // Notably, the write to `ptr2` did *not* invalidate `ptr1`:
+    ///     ptr1.write(3);
+    /// }
+    /// ```
+    ///
+    /// [`as_mut_ptr`]: Vec::as_mut_ptr
+    /// [`as_ptr`]: Vec::as_ptr
     #[stable(feature = "vec_as_ptr", since = "1.37.0")]
+    #[cfg_attr(not(bootstrap), rustc_never_returns_null_ptr)]
     #[inline]
     pub fn as_mut_ptr(&mut self) -> *mut T {
         // We shadow the slice method of the same name to avoid going through
@@ -3403,6 +3456,36 @@ fn from(s: &mut [T]) -> Vec<T> {
     }
 }
 
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_array_ref", since = "1.74.0")]
+impl<T: Clone, const N: usize> From<&[T; N]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&[1, 2, 3]), vec![1, 2, 3]);
+    /// ```
+    fn from(s: &[T; N]) -> Vec<T> {
+        Self::from(s.as_slice())
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+#[stable(feature = "vec_from_array_ref", since = "1.74.0")]
+impl<T: Clone, const N: usize> From<&mut [T; N]> for Vec<T> {
+    /// Allocate a `Vec<T>` and fill it by cloning `s`'s items.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// assert_eq!(Vec::from(&mut [1, 2, 3]), vec![1, 2, 3]);
+    /// ```
+    fn from(s: &mut [T; N]) -> Vec<T> {
+        Self::from(s.as_mut_slice())
+    }
+}
+
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "vec_from_array", since = "1.44.0")]
 impl<T, const N: usize> From<[T; N]> for Vec<T> {
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index fd5ffdb81bab..c62066825f53 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.73.0
+	echo 1.74.1
 	;;
 bindgen)
 	echo 0.65.1

base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
-- 
2.43.0

