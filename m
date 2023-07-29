Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A7F76826A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 00:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjG2WEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 18:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjG2WEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 18:04:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA67D19A9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 15:04:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42EDF60A78
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 22:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFFA9C433C7;
        Sat, 29 Jul 2023 22:04:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690668247;
        bh=96gR3nIadpZyNzD8iOhTux6qB93UXcrfImpEK47y4SU=;
        h=From:To:Cc:Subject:Date:From;
        b=C2aWC+9bJv6aw1xnk//fDP3tF6HVqlRp3Bnv23EhvIsidOUFU61faVq//fhxkxcwI
         dxKg8tlxdz/QvVPkNh6yOH86e6IsJxCsuaZuNvTDQ+L9uicYIAsiztAlu/zI3/UEvj
         Vd8YRPwUH6qhbK1eZjdcQs3WgKmKDuhFIq1CRXEEyxqT5HnX5LHHub1XDNF12HTZVs
         MaXPiaBQWhu5RT75jZOOOxyTWZd/b25HP0ydytGa6/cfT/i4xs0dfJsvW3RUuw+DP2
         oUOIA1ZvDp5D8r32WXg9EB+2RHMbfwNGgWwjbsN8giSHQJOvSPILapk72lIHrKfmAJ
         gxouf6dzEn0lQ==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: [PATCH 1/2] rust: upgrade to Rust 1.71.0
Date:   Sun, 30 Jul 2023 00:03:16 +0200
Message-ID: <20230729220317.416771-1-ojeda@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the second upgrade to the Rust toolchain, from 1.68.2 to 1.71.0
(i.e. the latest).

See the upgrade policy [1] and the comments on the first upgrade in
commit 3ed03f4da06e ("rust: upgrade to Rust 1.68.2").

# Unstable features

No unstable features (that we use) were stabilized.

Therefore, the only unstable feature allowed to be used outside
the `kernel` crate is still `new_uninit`, though other code to be
upstreamed may increase the list.

Please see [2] for details.

# Required changes

For the upgrade, this patch requires the following changes:

  - Removal of the `__rust_*` allocator functions, together with
    the addition of the `__rust_no_alloc_shim_is_unstable` static.
    See [3] for details.

  - Some more compiler builtins added due to `<f{32,64}>::midpoint()`
    that got added in Rust 1.71 [4].

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

Link: https://rust-for-linux.com/rust-version-policy [1]
Link: https://github.com/Rust-for-Linux/linux/issues/2 [2]
Link: https://github.com/rust-lang/rust/pull/86844 [3]
Link: https://github.com/rust-lang/rust/pull/92048 [4]
Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
---
Based on top of `rust-next`, since we want to be on top of commit
7c74839b2acc ("rust: alloc: Add realloc and alloc_zeroed to the
GlobalAlloc impl"), in order to be able to simply remove the `__rust_*`
functions here.

 Documentation/process/changes.rst |   2 +-
 rust/Makefile                     |   4 +-
 rust/alloc/alloc.rs               |  20 +++--
 rust/alloc/boxed.rs               | 131 +++++++++++++++---------------
 rust/alloc/lib.rs                 |  50 ++++++------
 rust/alloc/raw_vec.rs             |  18 ++--
 rust/alloc/slice.rs               |  43 +++++++---
 rust/alloc/vec/drain.rs           |   8 +-
 rust/alloc/vec/drain_filter.rs    |   8 +-
 rust/alloc/vec/into_iter.rs       |  35 +++++---
 rust/alloc/vec/mod.rs             |  84 +++++--------------
 rust/compiler_builtins.rs         |   7 ++
 rust/kernel/allocator.rs          |  37 +--------
 scripts/min-tool-version.sh       |   2 +-
 14 files changed, 209 insertions(+), 240 deletions(-)

diff --git a/Documentation/process/changes.rst b/Documentation/process/changes.rst
index 5561dae94f85..535bdd94a222 100644
--- a/Documentation/process/changes.rst
+++ b/Documentation/process/changes.rst
@@ -31,7 +31,7 @@ you probably needn't concern yourself with pcmciautils.
 ====================== ===============  ========================================
 GNU C                  5.1              gcc --version
 Clang/LLVM (optional)  11.0.0           clang --version
-Rust (optional)        1.68.2           rustc --version
+Rust (optional)        1.71.0           rustc --version
 bindgen (optional)     0.56.0           bindgen --version
 GNU make               3.82             make --version
 bash                   4.2              bash --version
diff --git a/rust/Makefile b/rust/Makefile
index 7c9d9f11aec5..e617930e5ef3 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -377,8 +377,8 @@ rust-analyzer:
 		$(RUST_LIB_SRC) > $(objtree)/rust-project.json
 
 redirect-intrinsics = \
-	__eqsf2 __gesf2 __lesf2 __nesf2 __unordsf2 \
-	__unorddf2 \
+	__addsf3 __eqsf2 __gesf2 __lesf2 __ltsf2 __mulsf3 __nesf2 __unordsf2 \
+	__adddf3 __ledf2 __ltdf2 __muldf3 __unorddf2 \
 	__muloti4 __multi3 \
 	__udivmodti4 __udivti3 __umodti3
 
diff --git a/rust/alloc/alloc.rs b/rust/alloc/alloc.rs
index acf22d45e6f2..0b6bf5b6da43 100644
--- a/rust/alloc/alloc.rs
+++ b/rust/alloc/alloc.rs
@@ -16,8 +16,6 @@
 #[doc(inline)]
 pub use core::alloc::*;
 
-use core::marker::Destruct;
-
 #[cfg(test)]
 mod tests;
 
@@ -41,6 +39,9 @@
     #[rustc_allocator_zeroed]
     #[rustc_nounwind]
     fn __rust_alloc_zeroed(size: usize, align: usize) -> *mut u8;
+
+    #[cfg(not(bootstrap))]
+    static __rust_no_alloc_shim_is_unstable: u8;
 }
 
 /// The global memory allocator.
@@ -94,7 +95,14 @@
 #[must_use = "losing the pointer will leak memory"]
 #[inline]
 pub unsafe fn alloc(layout: Layout) -> *mut u8 {
-    unsafe { __rust_alloc(layout.size(), layout.align()) }
+    unsafe {
+        // Make sure we don't accidentally allow omitting the allocator shim in
+        // stable code until it is actually stabilized.
+        #[cfg(not(bootstrap))]
+        core::ptr::read_volatile(&__rust_no_alloc_shim_is_unstable);
+
+        __rust_alloc(layout.size(), layout.align())
+    }
 }
 
 /// Deallocate memory with the global allocator.
@@ -333,16 +341,12 @@ unsafe fn exchange_malloc(size: usize, align: usize) -> *mut u8 {
 
 #[cfg_attr(not(test), lang = "box_free")]
 #[inline]
-#[rustc_const_unstable(feature = "const_box", issue = "92521")]
 // This signature has to be the same as `Box`, otherwise an ICE will happen.
 // When an additional parameter to `Box` is added (like `A: Allocator`), this has to be added here as
 // well.
 // For example if `Box` is changed to  `struct Box<T: ?Sized, A: Allocator>(Unique<T>, A)`,
 // this function has to be changed to `fn box_free<T: ?Sized, A: Allocator>(Unique<T>, A)` as well.
-pub(crate) const unsafe fn box_free<T: ?Sized, A: ~const Allocator + ~const Destruct>(
-    ptr: Unique<T>,
-    alloc: A,
-) {
+pub(crate) unsafe fn box_free<T: ?Sized, A: Allocator>(ptr: Unique<T>, alloc: A) {
     unsafe {
         let size = size_of_val(ptr.as_ref());
         let align = min_align_of_val(ptr.as_ref());
diff --git a/rust/alloc/boxed.rs b/rust/alloc/boxed.rs
index 14af9860c36c..c8173cea8317 100644
--- a/rust/alloc/boxed.rs
+++ b/rust/alloc/boxed.rs
@@ -152,16 +152,13 @@
 use core::async_iter::AsyncIterator;
 use core::borrow;
 use core::cmp::Ordering;
-use core::convert::{From, TryFrom};
 use core::error::Error;
 use core::fmt;
 use core::future::Future;
 use core::hash::{Hash, Hasher};
-#[cfg(not(no_global_oom_handling))]
-use core::iter::FromIterator;
-use core::iter::{FusedIterator, Iterator};
+use core::iter::FusedIterator;
 use core::marker::Tuple;
-use core::marker::{Destruct, Unpin, Unsize};
+use core::marker::Unsize;
 use core::mem;
 use core::ops::{
     CoerceUnsized, Deref, DerefMut, DispatchFromDyn, Generator, GeneratorState, Receiver,
@@ -218,6 +215,7 @@ impl<T> Box<T> {
     #[inline(always)]
     #[stable(feature = "rust1", since = "1.0.0")]
     #[must_use]
+    #[rustc_diagnostic_item = "box_new"]
     pub fn new(x: T) -> Self {
         #[rustc_box]
         Box::new(x)
@@ -287,9 +285,7 @@ pub fn new_zeroed() -> Box<mem::MaybeUninit<T>> {
     #[must_use]
     #[inline(always)]
     pub fn pin(x: T) -> Pin<Box<T>> {
-        (#[rustc_box]
-        Box::new(x))
-        .into()
+        Box::new(x).into()
     }
 
     /// Allocates memory on the heap then places `x` into it,
@@ -381,12 +377,11 @@ impl<T, A: Allocator> Box<T, A> {
     /// ```
     #[cfg(not(no_global_oom_handling))]
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[must_use]
     #[inline]
-    pub const fn new_in(x: T, alloc: A) -> Self
+    pub fn new_in(x: T, alloc: A) -> Self
     where
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let mut boxed = Self::new_uninit_in(alloc);
         unsafe {
@@ -411,12 +406,10 @@ pub const fn new_in(x: T, alloc: A) -> Self
     /// # Ok::<(), std::alloc::AllocError>(())
     /// ```
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const fn try_new_in(x: T, alloc: A) -> Result<Self, AllocError>
+    pub fn try_new_in(x: T, alloc: A) -> Result<Self, AllocError>
     where
-        T: ~const Destruct,
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let mut boxed = Self::try_new_uninit_in(alloc)?;
         unsafe {
@@ -446,13 +439,12 @@ pub const fn try_new_in(x: T, alloc: A) -> Result<Self, AllocError>
     /// assert_eq!(*five, 5)
     /// ```
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[cfg(not(no_global_oom_handling))]
     #[must_use]
     // #[unstable(feature = "new_uninit", issue = "63291")]
-    pub const fn new_uninit_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
+    pub fn new_uninit_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
     where
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let layout = Layout::new::<mem::MaybeUninit<T>>();
         // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
@@ -487,10 +479,9 @@ pub const fn new_uninit_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
     /// ```
     #[unstable(feature = "allocator_api", issue = "32838")]
     // #[unstable(feature = "new_uninit", issue = "63291")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
-    pub const fn try_new_uninit_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
+    pub fn try_new_uninit_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
     where
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let layout = Layout::new::<mem::MaybeUninit<T>>();
         let ptr = alloc.allocate(layout)?.cast();
@@ -518,13 +509,12 @@ pub const fn try_new_uninit_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>,
     ///
     /// [zeroed]: mem::MaybeUninit::zeroed
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[cfg(not(no_global_oom_handling))]
     // #[unstable(feature = "new_uninit", issue = "63291")]
     #[must_use]
-    pub const fn new_zeroed_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
+    pub fn new_zeroed_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
     where
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let layout = Layout::new::<mem::MaybeUninit<T>>();
         // NOTE: Prefer match over unwrap_or_else since closure sometimes not inlineable.
@@ -559,10 +549,9 @@ pub const fn new_zeroed_in(alloc: A) -> Box<mem::MaybeUninit<T>, A>
     /// [zeroed]: mem::MaybeUninit::zeroed
     #[unstable(feature = "allocator_api", issue = "32838")]
     // #[unstable(feature = "new_uninit", issue = "63291")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
-    pub const fn try_new_zeroed_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
+    pub fn try_new_zeroed_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>, AllocError>
     where
-        A: ~const Allocator + ~const Destruct,
+        A: Allocator,
     {
         let layout = Layout::new::<mem::MaybeUninit<T>>();
         let ptr = alloc.allocate_zeroed(layout)?.cast();
@@ -578,12 +567,11 @@ pub const fn try_new_zeroed_in(alloc: A) -> Result<Box<mem::MaybeUninit<T>, A>,
     /// construct a (pinned) `Box` in a different way than with [`Box::new_in`].
     #[cfg(not(no_global_oom_handling))]
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[must_use]
     #[inline(always)]
-    pub const fn pin_in(x: T, alloc: A) -> Pin<Self>
+    pub fn pin_in(x: T, alloc: A) -> Pin<Self>
     where
-        A: 'static + ~const Allocator + ~const Destruct,
+        A: 'static + Allocator,
     {
         Self::into_pin(Self::new_in(x, alloc))
     }
@@ -592,8 +580,7 @@ pub const fn pin_in(x: T, alloc: A) -> Pin<Self>
     ///
     /// This conversion does not allocate on the heap and happens in place.
     #[unstable(feature = "box_into_boxed_slice", issue = "71582")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
-    pub const fn into_boxed_slice(boxed: Self) -> Box<[T], A> {
+    pub fn into_boxed_slice(boxed: Self) -> Box<[T], A> {
         let (raw, alloc) = Box::into_raw_with_allocator(boxed);
         unsafe { Box::from_raw_in(raw as *mut [T; 1], alloc) }
     }
@@ -610,12 +597,8 @@ pub const fn into_boxed_slice(boxed: Self) -> Box<[T], A> {
     /// assert_eq!(Box::into_inner(c), 5);
     /// ```
     #[unstable(feature = "box_into_inner", issue = "80437")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const fn into_inner(boxed: Self) -> T
-    where
-        Self: ~const Destruct,
-    {
+    pub fn into_inner(boxed: Self) -> T {
         *boxed
     }
 }
@@ -829,9 +812,8 @@ impl<T, A: Allocator> Box<mem::MaybeUninit<T>, A> {
     /// assert_eq!(*five, 5)
     /// ```
     #[unstable(feature = "new_uninit", issue = "63291")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const unsafe fn assume_init(self) -> Box<T, A> {
+    pub unsafe fn assume_init(self) -> Box<T, A> {
         let (raw, alloc) = Box::into_raw_with_allocator(self);
         unsafe { Box::from_raw_in(raw as *mut T, alloc) }
     }
@@ -864,9 +846,8 @@ impl<T, A: Allocator> Box<mem::MaybeUninit<T>, A> {
     /// }
     /// ```
     #[unstable(feature = "new_uninit", issue = "63291")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const fn write(mut boxed: Self, value: T) -> Box<T, A> {
+    pub fn write(mut boxed: Self, value: T) -> Box<T, A> {
         unsafe {
             (*boxed).write(value);
             boxed.assume_init()
@@ -1110,9 +1091,8 @@ pub fn into_raw(b: Self) -> *mut T {
     ///
     /// [memory layout]: self#memory-layout
     #[unstable(feature = "allocator_api", issue = "32838")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const fn into_raw_with_allocator(b: Self) -> (*mut T, A) {
+    pub fn into_raw_with_allocator(b: Self) -> (*mut T, A) {
         let (leaked, alloc) = Box::into_unique(b);
         (leaked.as_ptr(), alloc)
     }
@@ -1122,10 +1102,9 @@ pub const fn into_raw_with_allocator(b: Self) -> (*mut T, A) {
         issue = "none",
         reason = "use `Box::leak(b).into()` or `Unique::from(Box::leak(b))` instead"
     )]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
     #[doc(hidden)]
-    pub const fn into_unique(b: Self) -> (Unique<T>, A) {
+    pub fn into_unique(b: Self) -> (Unique<T>, A) {
         // Box is recognized as a "unique pointer" by Stacked Borrows, but internally it is a
         // raw pointer for the type system. Turning it directly into a raw pointer would not be
         // recognized as "releasing" the unique pointer to permit aliased raw accesses,
@@ -1183,9 +1162,8 @@ pub const fn allocator(b: &Self) -> &A {
     /// assert_eq!(*static_ref, [4, 2, 3]);
     /// ```
     #[stable(feature = "box_leak", since = "1.26.0")]
-    #[rustc_const_unstable(feature = "const_box", issue = "92521")]
     #[inline]
-    pub const fn leak<'a>(b: Self) -> &'a mut T
+    pub fn leak<'a>(b: Self) -> &'a mut T
     where
         A: 'a,
     {
@@ -1246,16 +1224,16 @@ fn drop(&mut self) {
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: Default> Default for Box<T> {
     /// Creates a `Box<T>`, with the `Default` value for T.
+    #[inline]
     fn default() -> Self {
-        #[rustc_box]
         Box::new(T::default())
     }
 }
 
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "rust1", since = "1.0.0")]
-#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
-impl<T> const Default for Box<[T]> {
+impl<T> Default for Box<[T]> {
+    #[inline]
     fn default() -> Self {
         let ptr: Unique<[T]> = Unique::<[T; 0]>::dangling();
         Box(ptr, Global)
@@ -1264,8 +1242,8 @@ fn default() -> Self {
 
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "default_box_extra", since = "1.17.0")]
-#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
-impl const Default for Box<str> {
+impl Default for Box<str> {
+    #[inline]
     fn default() -> Self {
         // SAFETY: This is the same as `Unique::cast<U>` but with an unsized `U = str`.
         let ptr: Unique<str> = unsafe {
@@ -1461,8 +1439,7 @@ fn from(t: T) -> Self {
 }
 
 #[stable(feature = "pin", since = "1.33.0")]
-#[rustc_const_unstable(feature = "const_box", issue = "92521")]
-impl<T: ?Sized, A: Allocator> const From<Box<T, A>> for Pin<Box<T, A>>
+impl<T: ?Sized, A: Allocator> From<Box<T, A>> for Pin<Box<T, A>>
 where
     A: 'static,
 {
@@ -1482,9 +1459,36 @@ fn from(boxed: Box<T, A>) -> Self {
     }
 }
 
+/// Specialization trait used for `From<&[T]>`.
+#[cfg(not(no_global_oom_handling))]
+trait BoxFromSlice<T> {
+    fn from_slice(slice: &[T]) -> Self;
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Clone> BoxFromSlice<T> for Box<[T]> {
+    #[inline]
+    default fn from_slice(slice: &[T]) -> Self {
+        slice.to_vec().into_boxed_slice()
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Copy> BoxFromSlice<T> for Box<[T]> {
+    #[inline]
+    fn from_slice(slice: &[T]) -> Self {
+        let len = slice.len();
+        let buf = RawVec::with_capacity(len);
+        unsafe {
+            ptr::copy_nonoverlapping(slice.as_ptr(), buf.ptr(), len);
+            buf.into_box(slice.len()).assume_init()
+        }
+    }
+}
+
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "box_from_slice", since = "1.17.0")]
-impl<T: Copy> From<&[T]> for Box<[T]> {
+impl<T: Clone> From<&[T]> for Box<[T]> {
     /// Converts a `&[T]` into a `Box<[T]>`
     ///
     /// This conversion allocates on the heap
@@ -1498,19 +1502,15 @@ impl<T: Copy> From<&[T]> for Box<[T]> {
     ///
     /// println!("{boxed_slice:?}");
     /// ```
+    #[inline]
     fn from(slice: &[T]) -> Box<[T]> {
-        let len = slice.len();
-        let buf = RawVec::with_capacity(len);
-        unsafe {
-            ptr::copy_nonoverlapping(slice.as_ptr(), buf.ptr(), len);
-            buf.into_box(slice.len()).assume_init()
-        }
+        <Self as BoxFromSlice<T>>::from_slice(slice)
     }
 }
 
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "box_from_cow", since = "1.45.0")]
-impl<T: Copy> From<Cow<'_, [T]>> for Box<[T]> {
+impl<T: Clone> From<Cow<'_, [T]>> for Box<[T]> {
     /// Converts a `Cow<'_, [T]>` into a `Box<[T]>`
     ///
     /// When `cow` is the `Cow::Borrowed` variant, this
@@ -1620,7 +1620,6 @@ fn from(s: Box<str, A>) -> Self {
     /// println!("{boxed:?}");
     /// ```
     fn from(array: [T; N]) -> Box<[T]> {
-        #[rustc_box]
         Box::new(array)
     }
 }
@@ -1899,8 +1898,7 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
 }
 
 #[stable(feature = "rust1", since = "1.0.0")]
-#[rustc_const_unstable(feature = "const_box", issue = "92521")]
-impl<T: ?Sized, A: Allocator> const Deref for Box<T, A> {
+impl<T: ?Sized, A: Allocator> Deref for Box<T, A> {
     type Target = T;
 
     fn deref(&self) -> &T {
@@ -1909,8 +1907,7 @@ fn deref(&self) -> &T {
 }
 
 #[stable(feature = "rust1", since = "1.0.0")]
-#[rustc_const_unstable(feature = "const_box", issue = "92521")]
-impl<T: ?Sized, A: Allocator> const DerefMut for Box<T, A> {
+impl<T: ?Sized, A: Allocator> DerefMut for Box<T, A> {
     fn deref_mut(&mut self) -> &mut T {
         &mut **self
     }
diff --git a/rust/alloc/lib.rs b/rust/alloc/lib.rs
index 5f374378b0d4..85e91356ecb3 100644
--- a/rust/alloc/lib.rs
+++ b/rust/alloc/lib.rs
@@ -89,35 +89,37 @@
 #![warn(missing_debug_implementations)]
 #![warn(missing_docs)]
 #![allow(explicit_outlives_requirements)]
+#![warn(multiple_supertrait_upcastable)]
 //
 // Library features:
+// tidy-alphabetical-start
+#![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
+#![cfg_attr(not(no_global_oom_handling), feature(const_btree_len))]
+#![cfg_attr(test, feature(is_sorted))]
+#![cfg_attr(test, feature(new_uninit))]
 #![feature(alloc_layout_extra)]
 #![feature(allocator_api)]
 #![feature(array_chunks)]
 #![feature(array_into_iter_constructors)]
 #![feature(array_methods)]
 #![feature(array_windows)]
+#![feature(ascii_char)]
 #![feature(assert_matches)]
 #![feature(async_iterator)]
 #![feature(coerce_unsized)]
-#![cfg_attr(not(no_global_oom_handling), feature(const_alloc_error))]
-#![feature(const_box)]
-#![cfg_attr(not(no_global_oom_handling), feature(const_btree_len))]
-#![cfg_attr(not(no_borrow), feature(const_cow_is_borrowed))]
-#![feature(const_convert)]
-#![feature(const_size_of_val)]
 #![feature(const_align_of_val)]
-#![feature(const_ptr_read)]
-#![feature(const_maybe_uninit_zeroed)]
-#![feature(const_maybe_uninit_write)]
+#![feature(const_box)]
+#![cfg_attr(not(no_borrow), feature(const_cow_is_borrowed))]
+#![feature(const_eval_select)]
 #![feature(const_maybe_uninit_as_mut_ptr)]
+#![feature(const_maybe_uninit_write)]
+#![feature(const_maybe_uninit_zeroed)]
+#![feature(const_pin)]
 #![feature(const_refs_to_cell)]
+#![feature(const_size_of_val)]
+#![feature(const_waker)]
 #![feature(core_intrinsics)]
 #![feature(core_panic)]
-#![feature(const_eval_select)]
-#![feature(const_pin)]
-#![feature(const_waker)]
-#![feature(cstr_from_bytes_until_nul)]
 #![feature(dispatch_from_dyn)]
 #![feature(error_generic_member_access)]
 #![feature(error_in_core)]
@@ -128,7 +130,6 @@
 #![feature(hasher_prefixfree_extras)]
 #![feature(inline_const)]
 #![feature(inplace_iteration)]
-#![cfg_attr(test, feature(is_sorted))]
 #![feature(iter_advance_by)]
 #![feature(iter_next_chunk)]
 #![feature(iter_repeat_n)]
@@ -136,8 +137,6 @@
 #![feature(maybe_uninit_slice)]
 #![feature(maybe_uninit_uninit_array)]
 #![feature(maybe_uninit_uninit_array_transpose)]
-#![cfg_attr(test, feature(new_uninit))]
-#![feature(nonnull_slice_from_raw_parts)]
 #![feature(pattern)]
 #![feature(pointer_byte_offsets)]
 #![feature(provide_any)]
@@ -153,6 +152,7 @@
 #![feature(slice_ptr_get)]
 #![feature(slice_ptr_len)]
 #![feature(slice_range)]
+#![feature(std_internals)]
 #![feature(str_internals)]
 #![feature(strict_provenance)]
 #![feature(trusted_len)]
@@ -163,40 +163,42 @@
 #![feature(unicode_internals)]
 #![feature(unsize)]
 #![feature(utf8_chunks)]
-#![feature(std_internals)]
+// tidy-alphabetical-end
 //
 // Language features:
+// tidy-alphabetical-start
+#![cfg_attr(not(test), feature(generator_trait))]
+#![cfg_attr(test, feature(panic_update_hook))]
+#![cfg_attr(test, feature(test))]
 #![feature(allocator_internals)]
 #![feature(allow_internal_unstable)]
 #![feature(associated_type_bounds)]
+#![feature(c_unwind)]
 #![feature(cfg_sanitize)]
-#![feature(const_deref)]
 #![feature(const_mut_refs)]
-#![feature(const_ptr_write)]
 #![feature(const_precise_live_drops)]
+#![feature(const_ptr_write)]
 #![feature(const_trait_impl)]
 #![feature(const_try)]
 #![feature(dropck_eyepatch)]
 #![feature(exclusive_range_pattern)]
 #![feature(fundamental)]
-#![cfg_attr(not(test), feature(generator_trait))]
 #![feature(hashmap_internals)]
 #![feature(lang_items)]
 #![feature(min_specialization)]
+#![feature(multiple_supertrait_upcastable)]
 #![feature(negative_impls)]
 #![feature(never_type)]
+#![feature(pointer_is_aligned)]
 #![feature(rustc_allow_const_fn_unstable)]
 #![feature(rustc_attrs)]
-#![feature(pointer_is_aligned)]
 #![feature(slice_internals)]
 #![feature(staged_api)]
 #![feature(stmt_expr_attributes)]
-#![cfg_attr(test, feature(test))]
 #![feature(unboxed_closures)]
 #![feature(unsized_fn_params)]
-#![feature(c_unwind)]
 #![feature(with_negative_coherence)]
-#![cfg_attr(test, feature(panic_update_hook))]
+// tidy-alphabetical-end
 //
 // Rustdoc features:
 #![feature(doc_cfg)]
diff --git a/rust/alloc/raw_vec.rs b/rust/alloc/raw_vec.rs
index 5db87eac53b7..65d5ce15828e 100644
--- a/rust/alloc/raw_vec.rs
+++ b/rust/alloc/raw_vec.rs
@@ -6,7 +6,6 @@
 use core::cmp;
 use core::intrinsics;
 use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
-use core::ops::Drop;
 use core::ptr::{self, NonNull, Unique};
 use core::slice;
 
@@ -274,10 +273,15 @@ fn current_memory(&self) -> Option<(NonNull<u8>, Layout)> {
         if T::IS_ZST || self.cap == 0 {
             None
         } else {
-            // We have an allocated chunk of memory, so we can bypass runtime
-            // checks to get our current layout.
+            // We could use Layout::array here which ensures the absence of isize and usize overflows
+            // and could hypothetically handle differences between stride and size, but this memory
+            // has already been allocated so we know it can't overflow and currently rust does not
+            // support such types. So we can do better by skipping some checks and avoid an unwrap.
+            let _: () = const { assert!(mem::size_of::<T>() % mem::align_of::<T>() == 0) };
             unsafe {
-                let layout = Layout::array::<T>(self.cap).unwrap_unchecked();
+                let align = mem::align_of::<T>();
+                let size = mem::size_of::<T>().unchecked_mul(self.cap);
+                let layout = Layout::from_size_align_unchecked(size, align);
                 Some((self.ptr.cast().into(), layout))
             }
         }
@@ -465,11 +469,13 @@ fn shrink(&mut self, cap: usize) -> Result<(), TryReserveError> {
         assert!(cap <= self.capacity(), "Tried to shrink to a larger capacity");
 
         let (ptr, layout) = if let Some(mem) = self.current_memory() { mem } else { return Ok(()) };
-
+        // See current_memory() why this assert is here
+        let _: () = const { assert!(mem::size_of::<T>() % mem::align_of::<T>() == 0) };
         let ptr = unsafe {
             // `Layout::array` cannot overflow here because it would have
             // overflowed earlier when capacity was larger.
-            let new_layout = Layout::array::<T>(cap).unwrap_unchecked();
+            let new_size = mem::size_of::<T>().unchecked_mul(cap);
+            let new_layout = Layout::from_size_align_unchecked(new_size, layout.align());
             self.alloc
                 .shrink(ptr, layout, new_layout)
                 .map_err(|_| AllocError { layout: new_layout, non_exhaustive: () })?
diff --git a/rust/alloc/slice.rs b/rust/alloc/slice.rs
index 245e01590df7..6ac463bd3edc 100644
--- a/rust/alloc/slice.rs
+++ b/rust/alloc/slice.rs
@@ -784,6 +784,38 @@ fn borrow_mut(&mut self) -> &mut [T] {
     }
 }
 
+// Specializable trait for implementing ToOwned::clone_into. This is
+// public in the crate and has the Allocator parameter so that
+// vec::clone_from use it too.
+#[cfg(not(no_global_oom_handling))]
+pub(crate) trait SpecCloneIntoVec<T, A: Allocator> {
+    fn clone_into(&self, target: &mut Vec<T, A>);
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Clone, A: Allocator> SpecCloneIntoVec<T, A> for [T] {
+    default fn clone_into(&self, target: &mut Vec<T, A>) {
+        // drop anything in target that will not be overwritten
+        target.truncate(self.len());
+
+        // target.len <= self.len due to the truncate above, so the
+        // slices here are always in-bounds.
+        let (init, tail) = self.split_at(target.len());
+
+        // reuse the contained values' allocations/resources.
+        target.clone_from_slice(init);
+        target.extend_from_slice(tail);
+    }
+}
+
+#[cfg(not(no_global_oom_handling))]
+impl<T: Copy, A: Allocator> SpecCloneIntoVec<T, A> for [T] {
+    fn clone_into(&self, target: &mut Vec<T, A>) {
+        target.clear();
+        target.extend_from_slice(self);
+    }
+}
+
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: Clone> ToOwned for [T] {
@@ -799,16 +831,7 @@ fn to_owned(&self) -> Vec<T> {
     }
 
     fn clone_into(&self, target: &mut Vec<T>) {
-        // drop anything in target that will not be overwritten
-        target.truncate(self.len());
-
-        // target.len <= self.len due to the truncate above, so the
-        // slices here are always in-bounds.
-        let (init, tail) = self.split_at(target.len());
-
-        // reuse the contained values' allocations/resources.
-        target.clone_from_slice(init);
-        target.extend_from_slice(tail);
+        SpecCloneIntoVec::clone_into(self, target);
     }
 }
 
diff --git a/rust/alloc/vec/drain.rs b/rust/alloc/vec/drain.rs
index d503d2f478ce..78177a9e2ad0 100644
--- a/rust/alloc/vec/drain.rs
+++ b/rust/alloc/vec/drain.rs
@@ -18,7 +18,7 @@
 ///
 /// ```
 /// let mut v = vec![0, 1, 2];
-/// let iter: std::vec::Drain<_> = v.drain(..);
+/// let iter: std::vec::Drain<'_, _> = v.drain(..);
 /// ```
 #[stable(feature = "drain", since = "1.6.0")]
 pub struct Drain<
@@ -114,9 +114,7 @@ pub fn keep_rest(self) {
             let unyielded_ptr = this.iter.as_slice().as_ptr();
 
             // ZSTs have no identity, so we don't need to move them around.
-            let needs_move = mem::size_of::<T>() != 0;
-
-            if needs_move {
+            if !T::IS_ZST {
                 let start_ptr = source_vec.as_mut_ptr().add(start);
 
                 // memmove back unyielded elements
@@ -199,7 +197,7 @@ fn drop(&mut self) {
             }
         }
 
-        let iter = mem::replace(&mut self.iter, (&mut []).iter());
+        let iter = mem::take(&mut self.iter);
         let drop_len = iter.len();
 
         let mut vec = self.vec;
diff --git a/rust/alloc/vec/drain_filter.rs b/rust/alloc/vec/drain_filter.rs
index 4b019220657d..09efff090e42 100644
--- a/rust/alloc/vec/drain_filter.rs
+++ b/rust/alloc/vec/drain_filter.rs
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: Apache-2.0 OR MIT
 
 use crate::alloc::{Allocator, Global};
-use core::mem::{self, ManuallyDrop};
+use core::mem::{ManuallyDrop, SizedTypeProperties};
 use core::ptr;
 use core::slice;
 
@@ -18,7 +18,7 @@
 /// #![feature(drain_filter)]
 ///
 /// let mut v = vec![0, 1, 2];
-/// let iter: std::vec::DrainFilter<_, _> = v.drain_filter(|x| *x % 2 == 0);
+/// let iter: std::vec::DrainFilter<'_, _, _> = v.drain_filter(|x| *x % 2 == 0);
 /// ```
 #[unstable(feature = "drain_filter", reason = "recently added", issue = "43244")]
 #[derive(Debug)]
@@ -98,9 +98,7 @@ pub fn keep_rest(self) {
 
         unsafe {
             // ZSTs have no identity, so we don't need to move them around.
-            let needs_move = mem::size_of::<T>() != 0;
-
-            if needs_move && this.idx < this.old_len && this.del > 0 {
+            if !T::IS_ZST && this.idx < this.old_len && this.del > 0 {
                 let ptr = this.vec.as_mut_ptr();
                 let src = ptr.add(this.idx);
                 let dst = src.sub(this.del);
diff --git a/rust/alloc/vec/into_iter.rs b/rust/alloc/vec/into_iter.rs
index 34a2a70d6ded..aac0ec16aef1 100644
--- a/rust/alloc/vec/into_iter.rs
+++ b/rust/alloc/vec/into_iter.rs
@@ -13,6 +13,7 @@
 };
 use core::marker::PhantomData;
 use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
+use core::num::NonZeroUsize;
 #[cfg(not(no_global_oom_handling))]
 use core::ops::Deref;
 use core::ptr::{self, NonNull};
@@ -109,7 +110,7 @@ fn as_raw_mut_slice(&mut self) -> *mut [T] {
     /// ```
     /// # let mut into_iter = Vec::<u8>::with_capacity(10).into_iter();
     /// let mut into_iter = std::mem::replace(&mut into_iter, Vec::new().into_iter());
-    /// (&mut into_iter).for_each(core::mem::drop);
+    /// (&mut into_iter).for_each(drop);
     /// std::mem::forget(into_iter);
     /// ```
     ///
@@ -215,7 +216,7 @@ fn size_hint(&self) -> (usize, Option<usize>) {
     }
 
     #[inline]
-    fn advance_by(&mut self, n: usize) -> Result<(), usize> {
+    fn advance_by(&mut self, n: usize) -> Result<(), NonZeroUsize> {
         let step_size = self.len().min(n);
         let to_drop = ptr::slice_from_raw_parts_mut(self.ptr as *mut T, step_size);
         if T::IS_ZST {
@@ -229,10 +230,7 @@ fn advance_by(&mut self, n: usize) -> Result<(), usize> {
         unsafe {
             ptr::drop_in_place(to_drop);
         }
-        if step_size < n {
-            return Err(step_size);
-        }
-        Ok(())
+        NonZeroUsize::new(n - step_size).map_or(Ok(()), Err)
     }
 
     #[inline]
@@ -315,7 +313,7 @@ fn next_back(&mut self) -> Option<T> {
     }
 
     #[inline]
-    fn advance_back_by(&mut self, n: usize) -> Result<(), usize> {
+    fn advance_back_by(&mut self, n: usize) -> Result<(), NonZeroUsize> {
         let step_size = self.len().min(n);
         if T::IS_ZST {
             // SAFETY: same as for advance_by()
@@ -329,10 +327,7 @@ fn advance_back_by(&mut self, n: usize) -> Result<(), usize> {
         unsafe {
             ptr::drop_in_place(to_drop);
         }
-        if step_size < n {
-            return Err(step_size);
-        }
-        Ok(())
+        NonZeroUsize::new(n - step_size).map_or(Ok(()), Err)
     }
 }
 
@@ -349,6 +344,24 @@ impl<T, A: Allocator> FusedIterator for IntoIter<T, A> {}
 #[unstable(feature = "trusted_len", issue = "37572")]
 unsafe impl<T, A: Allocator> TrustedLen for IntoIter<T, A> {}
 
+#[stable(feature = "default_iters", since = "1.70.0")]
+impl<T, A> Default for IntoIter<T, A>
+where
+    A: Allocator + Default,
+{
+    /// Creates an empty `vec::IntoIter`.
+    ///
+    /// ```
+    /// # use std::vec;
+    /// let iter: vec::IntoIter<u8> = Default::default();
+    /// assert_eq!(iter.len(), 0);
+    /// assert_eq!(iter.as_slice(), &[]);
+    /// ```
+    fn default() -> Self {
+        super::Vec::new_in(Default::default()).into_iter()
+    }
+}
+
 #[doc(hidden)]
 #[unstable(issue = "none", feature = "std_internals")]
 #[rustc_unsafe_specialization_marker]
diff --git a/rust/alloc/vec/mod.rs b/rust/alloc/vec/mod.rs
index 94995913566b..05c70de0227e 100644
--- a/rust/alloc/vec/mod.rs
+++ b/rust/alloc/vec/mod.rs
@@ -58,13 +58,9 @@
 #[cfg(not(no_global_oom_handling))]
 use core::cmp;
 use core::cmp::Ordering;
-use core::convert::TryFrom;
 use core::fmt;
 use core::hash::{Hash, Hasher};
-use core::intrinsics::assume;
 use core::iter;
-#[cfg(not(no_global_oom_handling))]
-use core::iter::FromIterator;
 use core::marker::PhantomData;
 use core::mem::{self, ManuallyDrop, MaybeUninit, SizedTypeProperties};
 use core::ops::{self, Index, IndexMut, Range, RangeBounds};
@@ -381,8 +377,8 @@
 /// Currently, `Vec` does not guarantee the order in which elements are dropped.
 /// The order has changed in the past and may change again.
 ///
-/// [`get`]: ../../std/vec/struct.Vec.html#method.get
-/// [`get_mut`]: ../../std/vec/struct.Vec.html#method.get_mut
+/// [`get`]: slice::get
+/// [`get_mut`]: slice::get_mut
 /// [`String`]: crate::string::String
 /// [`&str`]: type@str
 /// [`shrink_to_fit`]: Vec::shrink_to_fit
@@ -708,14 +704,14 @@ pub const fn new_in(alloc: A) -> Self {
     ///
     /// // The vector contains no items, even though it has capacity for more
     /// assert_eq!(vec.len(), 0);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // These are all done without reallocating...
     /// for i in 0..10 {
     ///     vec.push(i);
     /// }
     /// assert_eq!(vec.len(), 10);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // ...but this may make the vector reallocate
     /// vec.push(11);
@@ -766,14 +762,14 @@ pub fn with_capacity_in(capacity: usize, alloc: A) -> Self {
     ///
     /// // The vector contains no items, even though it has capacity for more
     /// assert_eq!(vec.len(), 0);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // These are all done without reallocating...
     /// for i in 0..10 {
     ///     vec.push(i);
     /// }
     /// assert_eq!(vec.len(), 10);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     ///
     /// // ...but this may make the vector reallocate
     /// vec.push(11);
@@ -999,7 +995,7 @@ pub fn into_raw_parts_with_alloc(self) -> (*mut T, usize, usize, A) {
     /// ```
     /// let mut vec: Vec<i32> = Vec::with_capacity(10);
     /// vec.push(42);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     /// ```
     #[inline]
     #[stable(feature = "rust1", since = "1.0.0")]
@@ -1150,7 +1146,7 @@ pub fn try_reserve_exact(&mut self, additional: usize) -> Result<(), TryReserveE
     /// ```
     /// let mut vec = Vec::with_capacity(10);
     /// vec.extend([1, 2, 3]);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     /// vec.shrink_to_fit();
     /// assert!(vec.capacity() >= 3);
     /// ```
@@ -1177,7 +1173,7 @@ pub fn shrink_to_fit(&mut self) {
     /// ```
     /// let mut vec = Vec::with_capacity(10);
     /// vec.extend([1, 2, 3]);
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     /// vec.shrink_to(4);
     /// assert!(vec.capacity() >= 4);
     /// vec.shrink_to(0);
@@ -1212,7 +1208,7 @@ pub fn shrink_to(&mut self, min_capacity: usize) {
     /// let mut vec = Vec::with_capacity(10);
     /// vec.extend([1, 2, 3]);
     ///
-    /// assert_eq!(vec.capacity(), 10);
+    /// assert!(vec.capacity() >= 10);
     /// let slice = vec.into_boxed_slice();
     /// assert_eq!(slice.into_vec().capacity(), 3);
     /// ```
@@ -1358,11 +1354,7 @@ pub fn as_mut_slice(&mut self) -> &mut [T] {
     pub fn as_ptr(&self) -> *const T {
         // We shadow the slice method of the same name to avoid going through
         // `deref`, which creates an intermediate reference.
-        let ptr = self.buf.ptr();
-        unsafe {
-            assume(!ptr.is_null());
-        }
-        ptr
+        self.buf.ptr()
     }
 
     /// Returns an unsafe mutable pointer to the vector's buffer, or a dangling
@@ -1395,11 +1387,7 @@ pub fn as_ptr(&self) -> *const T {
     pub fn as_mut_ptr(&mut self) -> *mut T {
         // We shadow the slice method of the same name to avoid going through
         // `deref_mut`, which creates an intermediate reference.
-        let ptr = self.buf.ptr();
-        unsafe {
-            assume(!ptr.is_null());
-        }
-        ptr
+        self.buf.ptr()
     }
 
     /// Returns a reference to the underlying allocator.
@@ -2891,35 +2879,6 @@ fn deref_mut(&mut self) -> &mut [T] {
     }
 }
 
-#[cfg(not(no_global_oom_handling))]
-trait SpecCloneFrom {
-    fn clone_from(this: &mut Self, other: &Self);
-}
-
-#[cfg(not(no_global_oom_handling))]
-impl<T: Clone, A: Allocator> SpecCloneFrom for Vec<T, A> {
-    default fn clone_from(this: &mut Self, other: &Self) {
-        // drop anything that will not be overwritten
-        this.truncate(other.len());
-
-        // self.len <= other.len due to the truncate above, so the
-        // slices here are always in-bounds.
-        let (init, tail) = other.split_at(this.len());
-
-        // reuse the contained values' allocations/resources.
-        this.clone_from_slice(init);
-        this.extend_from_slice(tail);
-    }
-}
-
-#[cfg(not(no_global_oom_handling))]
-impl<T: Copy, A: Allocator> SpecCloneFrom for Vec<T, A> {
-    fn clone_from(this: &mut Self, other: &Self) {
-        this.clear();
-        this.extend_from_slice(other);
-    }
-}
-
 #[cfg(not(no_global_oom_handling))]
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: Clone, A: Allocator + Clone> Clone for Vec<T, A> {
@@ -2940,7 +2899,7 @@ fn clone(&self) -> Self {
     }
 
     fn clone_from(&mut self, other: &Self) {
-        SpecCloneFrom::clone_from(self, other)
+        crate::slice::SpecCloneIntoVec::clone_into(other.as_slice(), self);
     }
 }
 
@@ -2948,7 +2907,6 @@ fn clone_from(&mut self, other: &Self) {
 /// as required by the `core::borrow::Borrow` implementation.
 ///
 /// ```
-/// #![feature(build_hasher_simple_hash_one)]
 /// use std::hash::BuildHasher;
 ///
 /// let b = std::collections::hash_map::RandomState::new();
@@ -3330,7 +3288,7 @@ fn extend_reserve(&mut self, additional: usize) {
     }
 }
 
-/// Implements comparison of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+/// Implements comparison of vectors, [lexicographically](Ord#lexicographical-comparison).
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: PartialOrd, A: Allocator> PartialOrd for Vec<T, A> {
     #[inline]
@@ -3342,7 +3300,7 @@ fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: Eq, A: Allocator> Eq for Vec<T, A> {}
 
-/// Implements ordering of vectors, [lexicographically](core::cmp::Ord#lexicographical-comparison).
+/// Implements ordering of vectors, [lexicographically](Ord#lexicographical-comparison).
 #[stable(feature = "rust1", since = "1.0.0")]
 impl<T: Ord, A: Allocator> Ord for Vec<T, A> {
     #[inline]
@@ -3365,8 +3323,7 @@ fn drop(&mut self) {
 }
 
 #[stable(feature = "rust1", since = "1.0.0")]
-#[rustc_const_unstable(feature = "const_default_impls", issue = "87864")]
-impl<T> const Default for Vec<T> {
+impl<T> Default for Vec<T> {
     /// Creates an empty `Vec<T>`.
     ///
     /// The vector will not allocate until elements are pushed onto it.
@@ -3462,10 +3419,7 @@ fn from(s: &mut [T]) -> Vec<T> {
     /// ```
     #[cfg(not(test))]
     fn from(s: [T; N]) -> Vec<T> {
-        <[T]>::into_vec(
-            #[rustc_box]
-            Box::new(s),
-        )
+        <[T]>::into_vec(Box::new(s))
     }
 
     #[cfg(test)]
@@ -3490,8 +3444,8 @@ impl<'a, T> From<Cow<'a, [T]>> for Vec<T>
     ///
     /// ```
     /// # use std::borrow::Cow;
-    /// let o: Cow<[i32]> = Cow::Owned(vec![1, 2, 3]);
-    /// let b: Cow<[i32]> = Cow::Borrowed(&[1, 2, 3]);
+    /// let o: Cow<'_, [i32]> = Cow::Owned(vec![1, 2, 3]);
+    /// let b: Cow<'_, [i32]> = Cow::Borrowed(&[1, 2, 3]);
     /// assert_eq!(Vec::from(o), Vec::from(b));
     /// ```
     fn from(s: Cow<'a, [T]>) -> Vec<T> {
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index 43378357ece9..fb8ac3f211de 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -37,14 +37,21 @@ pub extern "C" fn $ident() {
 );
 
 define_panicking_intrinsics!("`f32` should not be used", {
+    __addsf3,
     __eqsf2,
     __gesf2,
     __lesf2,
+    __ltsf2,
+    __mulsf3,
     __nesf2,
     __unordsf2,
 });
 
 define_panicking_intrinsics!("`f64` should not be used", {
+    __adddf3,
+    __ledf2,
+    __ltdf2,
+    __muldf3,
     __unorddf2,
 });
 
diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
index 99b58b52e8c8..9ad5d4419678 100644
--- a/rust/kernel/allocator.rs
+++ b/rust/kernel/allocator.rs
@@ -88,39 +88,6 @@ unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
 #[global_allocator]
 static ALLOCATOR: KernelAllocator = KernelAllocator;
 
-// `rustc` only generates these for some crate types. Even then, we would need
-// to extract the object file that has them from the archive. For the moment,
-// let's generate them ourselves instead.
-//
-// Note that `#[no_mangle]` implies exported too, nowadays.
+// See <https://github.com/rust-lang/rust/pull/86844>.
 #[no_mangle]
-fn __rust_alloc(size: usize, _align: usize) -> *mut u8 {
-    unsafe { bindings::krealloc(core::ptr::null(), size, bindings::GFP_KERNEL) as *mut u8 }
-}
-
-#[no_mangle]
-fn __rust_dealloc(ptr: *mut u8, _size: usize, _align: usize) {
-    unsafe { bindings::kfree(ptr as *const core::ffi::c_void) };
-}
-
-#[no_mangle]
-fn __rust_realloc(ptr: *mut u8, _old_size: usize, _align: usize, new_size: usize) -> *mut u8 {
-    unsafe {
-        bindings::krealloc(
-            ptr as *const core::ffi::c_void,
-            new_size,
-            bindings::GFP_KERNEL,
-        ) as *mut u8
-    }
-}
-
-#[no_mangle]
-fn __rust_alloc_zeroed(size: usize, _align: usize) -> *mut u8 {
-    unsafe {
-        bindings::krealloc(
-            core::ptr::null(),
-            size,
-            bindings::GFP_KERNEL | bindings::__GFP_ZERO,
-        ) as *mut u8
-    }
-}
+static __rust_no_alloc_shim_is_unstable: u8 = 0;
diff --git a/scripts/min-tool-version.sh b/scripts/min-tool-version.sh
index 2ade63149466..73715794e7f8 100755
--- a/scripts/min-tool-version.sh
+++ b/scripts/min-tool-version.sh
@@ -31,7 +31,7 @@ llvm)
 	fi
 	;;
 rustc)
-	echo 1.68.2
+	echo 1.71.0
 	;;
 bindgen)
 	echo 0.56.0

base-commit: 7c74839b2acc9b5a5d16d3a1737741dd64e1804b
-- 
2.41.0

