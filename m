Return-Path: <linux-kernel+bounces-69583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B02F858BDC
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5F7AB23430
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F5136139;
	Sat, 17 Feb 2024 00:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrzEucmV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9762E85B;
	Sat, 17 Feb 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708129623; cv=none; b=UPO/OGVOGu9cdPDts0T9lo6RPr5r/tTHkO2cgL/PwzpVMuG9vaisJrWQxDOCpPMEclQ6BeXgyCe5EF45DKTtZmjdqEFueJBtzlfj2ofWkrkGm7Q9EwfcWIlrRLIQrCBPcalO/zYA7QOaTVWeDSVriUyqhv7e9jdLEKWRd1quUf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708129623; c=relaxed/simple;
	bh=XUQnncslPMcyYwrowgjabnD19W3Y+bKU9oqTjfGQB+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XxVHS6z1g+umB+ASOvFN9AYZvLR9O33KjIr3QFsm5o403ZgiXYQYoV8F2BZja0NEPXRXHtPhxL6QZtUT0cBj/bVqByeO7jyGe80qG/+lWv7zWTuYrX/lD0s1x6hIootsZ32Y25qsHaAcBVmg8+b2xxfSWLakUn3VDFbyjAzbQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrzEucmV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2507BC433A6;
	Sat, 17 Feb 2024 00:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708129622;
	bh=XUQnncslPMcyYwrowgjabnD19W3Y+bKU9oqTjfGQB+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrzEucmV7INsHJytFL7unH58tVHANA0hGvvbLJT6kQGO29xFWw7OA8DjZA05CEh3+
	 yA1a7bmeuLJO0+iKnuetuoWqYK8Id5LcYm1ae6UKj9OH+y0XbUeleL4PPSm2yh+4/9
	 GWBgMgg0fb6qhFBa6qF++KMf97/4vz0m33+8Gy+dTFoiVwKr815wDBxolPQvDLF4gL
	 VhCVDyGvmDnbSBRnPmqdO5awCiHU0gvDLJt792zY8wA5lXsJmqhRyZBKQfTq9Ao095
	 2soDl3wh5q5FDsOd44Yr5iS3FNa1pvw8SzFu0iuMiU9s9nf4o4OmZPMoM87UWsxKYm
	 9NEhypiQgcFPg==
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
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kbuild@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev
Subject: [PATCH 2/2] rust: upgrade to Rust 1.76.0
Date: Sat, 17 Feb 2024 01:26:38 +0100
Message-ID: <20240217002638.57373-2-ojeda@kernel.org>
In-Reply-To: <20240217002638.57373-1-ojeda@kernel.org>
References: <20240217002638.57373-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is the next upgrade to the Rust toolchain, from 1.75.0 to 1.76.0
(i.e. the latest) [1].

See the upgrade policy [2] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

No unstable features that we use were stabilized in Rust 1.76.0.

The only unstable features allowed to be used outside the `kernel` crate
are still `new_uninit,offset_of`, though other code to be upstreamed
may increase the list.

Please see [3] for details.

# Required changes

`rustc` (and others) now warns when it cannot connect to the Make
jobserver, thus mark those invocations as recursive as needed. Please
see the previous commit for details.

# Other changes

Rust 1.76.0 does not emit the `.debug_pub{names,types}` sections anymore
for DWARFv4 [4][5]. For instance, in the uncompressed debug info case,
this debug information took:

    samples/rust/rust_minimal.o   ~64 KiB (~18% of total object size)
    rust/kernel.o                 ~92 KiB (~15%)
    rust/core.o                  ~114 KiB ( ~5%)

In the compressed debug info (zlib) case:

    samples/rust/rust_minimal.o   ~11 KiB (~6%)
    rust/kernel.o                 ~17 KiB (~5%)
    rust/core.o                   ~21 KiB (~1.5%)

In addition, the `rustc_codegen_gcc` backend now does not emit the
`.eh_frame` section when compiling under `-Cpanic=abort` [6], thus
removing the need for the patch in the CI to compile the kernel [7].
Moreover, it also now emits the `.comment` section too [6].

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

Link: https://github.com/rust-lang/rust/blob/stable/RELEASES.md#version-1760-2024-02-08 [1]
Link: https://rust-for-linux.com/rust-version-policy [2]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [3]
Link: https://github.com/rust-lang/compiler-team/issues/688 [4]
Link: https://github.com/rust-lang/rust/pull/117962 [5]
Link: https://github.com/rust-lang/rust/pull/118068 [6]
Link: https://github.com/Rust-for-Linux/ci-rustc_codegen_gcc [7]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
 Documentation/process/changes.rst |  2 +-
 rust/alloc/alloc.rs               |  3 ++
 rust/alloc/boxed.rs               | 14 +++++--
 rust/alloc/collections/mod.rs     |  1 +
 rust/alloc/lib.rs                 |  8 ++--
 rust/alloc/raw_vec.rs             | 58 +++++++++++++++++++--------
 rust/alloc/vec/into_iter.rs       | 16 +++++---
 rust/alloc/vec/mod.rs             | 65 ++++++++++++++++++++++++-------
 scripts/min-tool-version.sh       |  2 +-
 9 files changed, 125 insertions(+), 44 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index eab7e2f8c196..c78ecc1e176f 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.75.0           rustc --version
+Rust (optional)        1.76.0           rustc --version
 bindgen (optional)     0.65.1           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index 8a6be8c98173..abb791cc2371 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -425,12 +425,14 @@ pub unsafe fn __rdl_oom(size: usize, _align: usize) -> ! {
     }
 }

+#[cfg(not(no_global_oom_handling))]
 /// Specialize clones into pre-allocated, uninitialized memory.
 /// Used by `Box::clone` and `Rc`/`Arc::make_mut`.
 pub(crate) trait WriteCloneIntoRaw: Sized {
     unsafe fn write_clone_into_raw(&self, target: *mut Self);
 }

+#[cfg(not(no_global_oom_handling))]
 impl<T: Clone> WriteCloneIntoRaw for T {
     #[inline]
     default unsafe fn write_clone_into_raw(&self, target: *mut Self) {
@@ -440,6 +442,7 @@ impl<T: Clone> WriteCloneIntoRaw for T {
     }
 }

+#[cfg(not(no_global_oom_handling))]
 impl<T: Copy> WriteCloneIntoRaw for T {
     #[inline]
     unsafe fn write_clone_into_raw(&self, target: *mut Self) {
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index f5f40778a193..c93a22a5c97f 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -1042,10 +1042,18 @@ impl<T: ?Sized, A: Allocator> Box<T, A> {
     /// use std::ptr;
     ///
     /// let x = Box::new(String::from("Hello"));
-    /// let p = Box::into_raw(x);
+    /// let ptr = Box::into_raw(x);
     /// unsafe {
-    ///     ptr::drop_in_place(p);
-    ///     dealloc(p as *mut u8, Layout::new::<String>());
+    ///     ptr::drop_in_place(ptr);
+    ///     dealloc(ptr as *mut u8, Layout::new::<String>());
+    /// }
+    /// ```
+    /// Note: This is equivalent to the following:
+    /// ```
+    /// let x = Box::new(String::from("Hello"));
+    /// let ptr = Box::into_raw(x);
+    /// unsafe {
+    ///     drop(Box::from_raw(ptr));
     /// }
     /// ```
     ///
diff --git a/rust/alloc/collections/mod.rs b/rust/alloc/collections/mod.rs
index 2506065d158a..00ffb3b97365 100644
--- a/rust/alloc/collections/mod.rs
+++ b/rust/alloc/collections/mod.rs
@@ -150,6 +150,7 @@ fn fmt(

 /// An intermediate trait for specialization of `Extend`.
 #[doc(hidden)]
+#[cfg(not(no_global_oom_handling))]
 trait SpecExtend<I: IntoIterator> {
     /// Extends `self` with the contents of the given iterator.
     fn spec_extend(&mut self, iter: I);
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 345cf5c9cf92..36f79c075593 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -80,8 +80,8 @@
     not(no_sync),
     target_has_atomic = "ptr"
 ))]
-#![cfg_attr(not(bootstrap), doc(rust_logo))]
-#![cfg_attr(not(bootstrap), feature(rustdoc_internals))]
+#![doc(rust_logo)]
+#![feature(rustdoc_internals)]
 #![no_std]
 #![needs_allocator]
 // Lints:
@@ -142,7 +142,6 @@
 #![feature(maybe_uninit_uninit_array)]
 #![feature(maybe_uninit_uninit_array_transpose)]
 #![feature(pattern)]
-#![feature(ptr_addr_eq)]
 #![feature(ptr_internals)]
 #![feature(ptr_metadata)]
 #![feature(ptr_sub_ptr)]
@@ -157,6 +156,7 @@
 #![feature(std_internals)]
 #![feature(str_internals)]
 #![feature(strict_provenance)]
+#![feature(trusted_fused)]
 #![feature(trusted_len)]
 #![feature(trusted_random_access)]
 #![feature(try_trait_v2)]
@@ -277,7 +277,7 @@ pub(crate) mod test_helpers {
     /// seed not being the same for every RNG invocation too.
     pub(crate) fn test_rng() -> rand_xorshift::XorShiftRng {
         use std::hash::{BuildHasher, Hash, Hasher};
-        let mut hasher = std::collections::hash_map::RandomState::new().build_hasher();
+        let mut hasher = std::hash::RandomState::new().build_hasher();
         std::panic::Location::caller().hash(&mut hasher);
         let hc64 = hasher.finish();
         let seed_vec =
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index f1b8cec8cc62..98b6abf30af6 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -27,6 +27,16 @@ enum AllocInit {
     Zeroed,
 }

+#[repr(transparent)]
+#[cfg_attr(target_pointer_width = "16", rustc_layout_scalar_valid_range_end(0x7fff))]
+#[cfg_attr(target_pointer_width = "32", rustc_layout_scalar_valid_range_end(0x7fff_ffff))]
+#[cfg_attr(target_pointer_width = "64", rustc_layout_scalar_valid_range_end(0x7fff_ffff_ffff_ffff))]
+struct Cap(usize);
+
+impl Cap {
+    const ZERO: Cap = unsafe { Cap(0) };
+}
+
 /// A low-level utility for more ergonomically allocating, reallocating, and deallocating
 /// a buffer of memory on the heap without having to worry about all the corner cases
 /// involved. This type is excellent for building your own data structures like Vec and VecDeque.
@@ -52,7 +62,12 @@ enum AllocInit {
 #[allow(missing_debug_implementations)]
 pub(crate) struct RawVec<T, A: Allocator = Global> {
     ptr: Unique<T>,
-    cap: usize,
+    /// Never used for ZSTs; it's `capacity()`'s responsibility to return usize::MAX in that case.
+    ///
+    /// # Safety
+    ///
+    /// `cap` must be in the `0..=isize::MAX` range.
+    cap: Cap,
     alloc: A,
 }

@@ -121,7 +136,7 @@ impl<T, A: Allocator> RawVec<T, A> {
     /// the returned `RawVec`.
     pub const fn new_in(alloc: A) -> Self {
         // `cap: 0` means "unallocated". zero-sized types are ignored.
-        Self { ptr: Unique::dangling(), cap: 0, alloc }
+        Self { ptr: Unique::dangling(), cap: Cap::ZERO, alloc }
     }

     /// Like `with_capacity`, but parameterized over the choice of
@@ -203,7 +218,7 @@ fn allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Self {
             // here should change to `ptr.len() / mem::size_of::<T>()`.
             Self {
                 ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
-                cap: capacity,
+                cap: unsafe { Cap(capacity) },
                 alloc,
             }
         }
@@ -228,7 +243,7 @@ fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, T
         // here should change to `ptr.len() / mem::size_of::<T>()`.
         Ok(Self {
             ptr: unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) },
-            cap: capacity,
+            cap: unsafe { Cap(capacity) },
             alloc,
         })
     }
@@ -240,12 +255,13 @@ fn try_allocate_in(capacity: usize, init: AllocInit, alloc: A) -> Result<Self, T
     /// The `ptr` must be allocated (via the given allocator `alloc`), and with the given
     /// `capacity`.
     /// The `capacity` cannot exceed `isize::MAX` for sized types. (only a concern on 32-bit
-    /// systems). ZST vectors may have a capacity up to `usize::MAX`.
+    /// systems). For ZSTs capacity is ignored.
     /// If the `ptr` and `capacity` come from a `RawVec` created via `alloc`, then this is
     /// guaranteed.
     #[inline]
     pub unsafe fn from_raw_parts_in(ptr: *mut T, capacity: usize, alloc: A) -> Self {
-        Self { ptr: unsafe { Unique::new_unchecked(ptr) }, cap: capacity, alloc }
+        let cap = if T::IS_ZST { Cap::ZERO } else { unsafe { Cap(capacity) } };
+        Self { ptr: unsafe { Unique::new_unchecked(ptr) }, cap, alloc }
     }

     /// Gets a raw pointer to the start of the allocation. Note that this is
@@ -261,7 +277,7 @@ pub fn ptr(&self) -> *mut T {
     /// This will always be `usize::MAX` if `T` is zero-sized.
     #[inline(always)]
     pub fn capacity(&self) -> usize {
-        if T::IS_ZST { usize::MAX } else { self.cap }
+        if T::IS_ZST { usize::MAX } else { self.cap.0 }
     }

     /// Returns a shared reference to the allocator backing this `RawVec`.
@@ -270,7 +286,7 @@ pub fn allocator(&self) -> &A {
     }

     fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
-        if T::IS_ZST || self.cap == 0 {
+        if T::IS_ZST || self.cap.0 == 0 {
             None
         } else {
             // We could use Layout::array here which ensures the absence of isize and usize overflows
@@ -280,7 +296,7 @@ fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
             let _: () = const { assert!(mem::size_of::<T>() % mem::align_of::<T>() == 0) };
             unsafe {
                 let align = mem::align_of::<T>();
-                let size = mem::size_of::<T>().unchecked_mul(self.cap);
+                let size = mem::size_of::<T>().unchecked_mul(self.cap.0);
                 let layout = Layout::from_size_align_unchecked(size, align);
                 Some((self.ptr.cast().into(), layout))
             }
@@ -414,12 +430,15 @@ fn needs_to_grow(&self, len: usize, additional: usize) -> bool {
         additional > self.capacity().wrapping_sub(len)
     }

-    fn set_ptr_and_cap(&mut self, ptr: NonNull<[u8]>, cap: usize) {
+    /// # Safety:
+    ///
+    /// `cap` must not exceed `isize::MAX`.
+    unsafe fn set_ptr_and_cap(&mut self, ptr: NonNull<[u8]>, cap: usize) {
         // Allocators currently return a `NonNull<[u8]>` whose length matches
         // the size requested. If that ever changes, the capacity here should
         // change to `ptr.len() / mem::size_of::<T>()`.
         self.ptr = unsafe { Unique::new_unchecked(ptr.cast().as_ptr()) };
-        self.cap = cap;
+        self.cap = unsafe { Cap(cap) };
     }

     // This method is usually instantiated many times. So we want it to be as
@@ -444,14 +463,15 @@ fn grow_amortized(&mut self, len: usize, additional: usize) -> Result<(), TryRes

         // This guarantees exponential growth. The doubling cannot overflow
         // because `cap <= isize::MAX` and the type of `cap` is `usize`.
-        let cap = cmp::max(self.cap * 2, required_cap);
+        let cap = cmp::max(self.cap.0 * 2, required_cap);
         let cap = cmp::max(Self::MIN_NON_ZERO_CAP, cap);

         let new_layout = Layout::array::<T>(cap);

         // `finish_grow` is non-generic over `T`.
         let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
-        self.set_ptr_and_cap(ptr, cap);
+        // SAFETY: finish_grow would have resulted in a capacity overflow if we tried to allocate more than isize::MAX items
+        unsafe { self.set_ptr_and_cap(ptr, cap) };
         Ok(())
     }

@@ -470,7 +490,10 @@ fn grow_exact(&mut self, len: usize, additional: usize) -> Result<(), TryReserve

         // `finish_grow` is non-generic over `T`.
         let ptr = finish_grow(new_layout, self.current_memory(), &mut self.alloc)?;
-        self.set_ptr_and_cap(ptr, cap);
+        // SAFETY: finish_grow would have resulted in a capacity overflow if we tried to allocate more than isize::MAX items
+        unsafe {
+            self.set_ptr_and_cap(ptr, cap);
+        }
         Ok(())
     }

@@ -488,7 +511,7 @@ fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
         if cap == 0 {
             unsafe { self.alloc.deallocate(ptr, layout) };
             self.ptr = Unique::dangling();
-            self.cap = 0;
+            self.cap = Cap::ZERO;
         } else {
             let ptr = unsafe {
                 // `Layout::array` cannot overflow here because it would have
@@ -499,7 +522,10 @@ fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
                     .shrink(ptr, layout, new_layout)
                     .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
             };
-            self.set_ptr_and_cap(ptr, cap);
+            // SAFETY: if the allocation is valid, then the capacity is too
+            unsafe {
+                self.set_ptr_and_cap(ptr, cap);
+            }
         }
         Ok(())
     }
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
index aac0ec16aef1..136bfe94af6c 100644
--- a/rust/alloc/vec/into_iter.rs
+++ b/rust/alloc/vec/into_iter.rs
@@ -9,7 +9,8 @@
 use core::array;
 use core::fmt;
 use core::iter::{
-    FusedIterator, InPlaceIterable, SourceIter, TrustedLen, TrustedRandomAccessNoCoerce,
+    FusedIterator, InPlaceIterable, SourceIter, TrustedFused, TrustedLen,
+    TrustedRandomAccessNoCoerce,
 };
 use core::marker::PhantomData;
 use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
@@ -287,9 +288,7 @@ unsafe fn __iterator_get_unchecked(&mut self, i: usize) -> Self::Item
         // Also note the implementation of `Self: TrustedRandomAccess` requires
         // that `T: Copy` so reading elements from the buffer doesn't invalidate
         // them for `Drop`.
-        unsafe {
-            if T::IS_ZST { mem::zeroed() } else { ptr::read(self.ptr.add(i)) }
-        }
+        unsafe { if T::IS_ZST { mem::zeroed() } else { ptr::read(self.ptr.add(i)) } }
     }
 }

@@ -341,6 +340,10 @@ fn is_empty(&self) -> bool {
 #[stable(feature = "fused", since = "1.26.0")]
 impl<T, A: Allocator> FusedIterator for IntoIter<T, A> {}

+#[doc(hidden)]
+#[unstable(issue = "none", feature = "trusted_fused")]
+unsafe impl<T, A: Allocator> TrustedFused for IntoIter<T, A> {}
+
 #[unstable(feature = "trusted_len", issue = "37572")]
 unsafe impl<T, A: Allocator> TrustedLen for IntoIter<T, A> {}

@@ -425,7 +428,10 @@ fn drop(&mut self) {
 // also refer to the vec::in_place_collect module documentation to get an overview
 #[unstable(issue = "none", feature = "inplace_iteration")]
 #[doc(hidden)]
-unsafe impl<T, A: Allocator> InPlaceIterable for IntoIter<T, A> {}
+unsafe impl<T, A: Allocator> InPlaceIterable for IntoIter<T, A> {
+    const EXPAND_BY: Option<NonZeroUsize> = NonZeroUsize::new(1);
+    const MERGE_BY: Option<NonZeroUsize> = NonZeroUsize::new(1);
+}

 #[unstable(issue = "none", feature = "inplace_iteration")]
 #[doc(hidden)]
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 0d95fd7ef337..220fb9d6f45b 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -105,6 +105,7 @@
 #[cfg(not(no_global_oom_handling))]
 use self::is_zero::IsZero;

+#[cfg(not(no_global_oom_handling))]
 mod is_zero;

 #[cfg(not(no_global_oom_handling))]
@@ -123,7 +124,7 @@
 mod set_len_on_drop;

 #[cfg(not(no_global_oom_handling))]
-use self::in_place_drop::{InPlaceDrop, InPlaceDstBufDrop};
+use self::in_place_drop::{InPlaceDrop, InPlaceDstDataSrcBufDrop};

 #[cfg(not(no_global_oom_handling))]
 mod in_place_drop;
@@ -1893,7 +1894,32 @@ pub fn dedup_by<F>(&mut self, mut same_bucket: F)
             return;
         }

-        /* INVARIANT: vec.len() > read >= write > write-1 >= 0 */
+        // Check if we ever want to remove anything.
+        // This allows to use copy_non_overlapping in next cycle.
+        // And avoids any memory writes if we don't need to remove anything.
+        let mut first_duplicate_idx: usize = 1;
+        let start = self.as_mut_ptr();
+        while first_duplicate_idx != len {
+            let found_duplicate = unsafe {
+                // SAFETY: first_duplicate always in range [1..len)
+                // Note that we start iteration from 1 so we never overflow.
+                let prev = start.add(first_duplicate_idx.wrapping_sub(1));
+                let current = start.add(first_duplicate_idx);
+                // We explicitly say in docs that references are reversed.
+                same_bucket(&mut *current, &mut *prev)
+            };
+            if found_duplicate {
+                break;
+            }
+            first_duplicate_idx += 1;
+        }
+        // Don't need to remove anything.
+        // We cannot get bigger than len.
+        if first_duplicate_idx == len {
+            return;
+        }
+
+        /* INVARIANT: vec.len() > read > write > write-1 >= 0 */
         struct FillGapOnDrop<'a, T, A: core::alloc::Allocator> {
             /* Offset of the element we want to check if it is duplicate */
             read: usize,
@@ -1939,31 +1965,39 @@ fn drop(&mut self) {
             }
         }

-        let mut gap = FillGapOnDrop { read: 1, write: 1, vec: self };
-        let ptr = gap.vec.as_mut_ptr();
-
         /* Drop items while going through Vec, it should be more efficient than
          * doing slice partition_dedup + truncate */

+        // Construct gap first and then drop item to avoid memory corruption if `T::drop` panics.
+        let mut gap =
+            FillGapOnDrop { read: first_duplicate_idx + 1, write: first_duplicate_idx, vec: self };
+        unsafe {
+            // SAFETY: we checked that first_duplicate_idx in bounds before.
+            // If drop panics, `gap` would remove this item without drop.
+            ptr::drop_in_place(start.add(first_duplicate_idx));
+        }
+
         /* SAFETY: Because of the invariant, read_ptr, prev_ptr and write_ptr
          * are always in-bounds and read_ptr never aliases prev_ptr */
         unsafe {
             while gap.read < len {
-                let read_ptr = ptr.add(gap.read);
-                let prev_ptr = ptr.add(gap.write.wrapping_sub(1));
+                let read_ptr = start.add(gap.read);
+                let prev_ptr = start.add(gap.write.wrapping_sub(1));

-                if same_bucket(&mut *read_ptr, &mut *prev_ptr) {
+                // We explicitly say in docs that references are reversed.
+                let found_duplicate = same_bucket(&mut *read_ptr, &mut *prev_ptr);
+                if found_duplicate {
                     // Increase `gap.read` now since the drop may panic.
                     gap.read += 1;
                     /* We have found duplicate, drop it in-place */
                     ptr::drop_in_place(read_ptr);
                 } else {
-                    let write_ptr = ptr.add(gap.write);
+                    let write_ptr = start.add(gap.write);

-                    /* Because `read_ptr` can be equal to `write_ptr`, we either
-                     * have to use `copy` or conditional `copy_nonoverlapping`.
-                     * Looks like the first option is faster. */
-                    ptr::copy(read_ptr, write_ptr, 1);
+                    /* read_ptr cannot be equal to write_ptr because at this point
+                     * we guaranteed to skip at least one element (before loop starts).
+                     */
+                    ptr::copy_nonoverlapping(read_ptr, write_ptr, 1);

                     /* We have filled that place, so go further */
                     gap.write += 1;
@@ -2844,6 +2878,7 @@ pub fn from_elem_in<T: Clone, A: Allocator>(elem: T, n: usize, alloc: A) -> Vec<
     <T as SpecFromElem>::from_elem(elem, n, alloc)
 }

+#[cfg(not(no_global_oom_handling))]
 trait ExtendFromWithinSpec {
     /// # Safety
     ///
@@ -2852,6 +2887,7 @@ trait ExtendFromWithinSpec {
     unsafe fn spec_extend_from_within(&mut self, src: Range<usize>);
 }

+#[cfg(not(no_global_oom_handling))]
 impl<T: Clone, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
     default unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
         // SAFETY:
@@ -2871,6 +2907,7 @@ impl<T: Clone, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
     }
 }

+#[cfg(not(no_global_oom_handling))]
 impl<T: Copy, A: Allocator> ExtendFromWithinSpec for Vec<T, A> {
     unsafe fn spec_extend_from_within(&mut self, src: Range<usize>) {
         let count = src.len();
@@ -2951,7 +2988,7 @@ fn clone_from(&mut self, other: &Self) {
 /// ```
 /// use std::hash::BuildHasher;
 ///
-/// let b = std::collections::hash_map::RandomState::new();
+/// let b = std::hash::RandomState::new();
 /// let v: Vec<u8> = vec![0xa8, 0x3c, 0x09];
 /// let s: &[u8] = &[0xa8, 0x3c, 0x09];
 /// assert_eq!(b.hash_one(v), b.hash_one(s));
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index ef6f286a4d47..e217683b10d6 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -33,7 +33,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.75.0
+	echo 1.76.0
 	;;
 bindgen)
 	echo 0.65.1
--
2.43.0

