Return-Path: <linux-kernel+bounces-117867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ADE88B297
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:22:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6058B36D69
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D673854BF5;
	Mon, 25 Mar 2024 19:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDhCTOtT"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398865788E;
	Mon, 25 Mar 2024 19:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396524; cv=none; b=aR00wJq/mqwlPJBB2JqI9m+YNwQwM5H86cLo4zHvbSupnfFLIJTtRHipzaSq+2yD7fdwkTzg7mhXqnqmv76HbIWgeuvIwbZqoCwUfdUZ+WPkI5lh5FQn6eSHr83oSNcM4rfe2KW9Xyfg4QedbD9E4CTTHax9tvS1BStsPqqhC6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396524; c=relaxed/simple;
	bh=5c1OHxin4/klr0kFkKwyl3BJAKrHOhaaG5eCuQeeRE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lBv9Clrh2bvnTMU6yv+fGYcONNK/OneNTp7QEpB35RIXcFULjmSe4Ox3GTHXZ8n8e9X3dvfLgKIPpn3KIKLEyybSW2pV3Px61bgbGubbaBcqIuXGq2tYt3fdDCSPNf2gLqG496XRb1HwLWu07F2cIJlMPBQV1w5oH2IsK1QUvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDhCTOtT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5cedfc32250so2951279a12.0;
        Mon, 25 Mar 2024 12:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711396522; x=1712001322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uBDbRz37TkRcRSJyBSRF/sgBR8GvLq/W4xTazgq3Yls=;
        b=fDhCTOtT+aC/eppMnE4C4LrHx6Mj76tl9w64LMJYH7FikKFF4YRAPbTEzuF/SKJzqj
         D0rLtHTdC5sY5ekh5MdBBFWR2KzDECrReVcPxrUN+gBky55SawpvlAsWVIzucwRYBYxD
         XdnDWpERUQzKPcFXBWjlTzpfQji66psIP/NkHXiwBihwcm3tgD1VeIcCEkynDTIPwuDQ
         kXGq8kD3eCH/IvNPlMg4SVfxTS9fK2QaPDYyhs5cDE/HeubccnF2Tx3dat3Q8+4GRkge
         moHjOMuQsXa8q/Egjdys3Rkgz89s7nsebfgZh+xKDAhwjxaE6A1yChssVF9pWgB+rYT8
         qFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711396522; x=1712001322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uBDbRz37TkRcRSJyBSRF/sgBR8GvLq/W4xTazgq3Yls=;
        b=uDnpBkTBJs4xtIrqegPlFEC49yq3GonkmgyMuewfG+GJuHBI0P4v5bmcFNNy0WPU9X
         bCTRhvCwjIdbgojtWkgVEi7fnqpjH+RFBwWh9estXf+aww1vOrEZ9ZuIVlSqcthlTc5j
         L52gsvpPWoj2uAqzD3SEeA6WhFoSnCcNyx0spTCy9VZVMSR4chKaDgeYxoY6dyWodA8l
         IjUZk6UT/s6pk+uK23oqow2721xjADeasJJpnIS7J099rPxz2RAX91byk8hYp6IcXYH0
         0DwmqMgYYbuZEjEjvr3icVincKMz4CfQpAw3WBduMaVBJOEdc7qnuYB/3XDcJojfIj6B
         +F4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXd+dLzV7/+6GjXxl366mrHPyiKZimvodEdsP70IZUgFzx3NrdIHyZ6zSASt7to90JmfATNhf4i5ckm200z/Nt/aSccu1YiixNXAil2
X-Gm-Message-State: AOJu0YxC2HI2tcgM6c3831YrBsRuK0vo4sldGMwdDQOMULah2njhoOM7
	xEnjSuqG6dT20+yiiF99LozeJQuhhho2zoyHYmtfJQcRnLCqe/yoiCS3LavH
X-Google-Smtp-Source: AGHT+IEY6CEsEXpdkEA4B8TakQeUYaHjL+FzJhz9uff3INk9XTP5GxKQaXlIqU3TFE7ka/3qeFWq1w==
X-Received: by 2002:a17:903:11c5:b0:1e0:c54c:2260 with SMTP id q5-20020a17090311c500b001e0c54c2260mr3676889plh.62.1711396522412;
        Mon, 25 Mar 2024 12:55:22 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id q1-20020a170902dac100b001e06c1eee22sm5099585plx.74.2024.03.25.12.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:55:22 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 06/10] rust: alloc: introduce the `BoxExt` trait
Date: Mon, 25 Mar 2024 16:54:14 -0300
Message-Id: <20240325195418.166013-7-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240325195418.166013-1-wedsonaf@gmail.com>
References: <20240325195418.166013-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Make fallible versions of `new` and `new_uninit` methods available in
`Box` even though it doesn't implement them because we build `alloc`
with the `no_global_oom_handling` config.

They also have an extra `flags` parameter that allows callers to pass
flags to the allocator.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs           |  1 +
 rust/kernel/alloc/allocator.rs |  6 +++-
 rust/kernel/alloc/boxext.rs    | 61 ++++++++++++++++++++++++++++++++++
 rust/kernel/init.rs            | 13 ++++----
 rust/kernel/prelude.rs         |  2 +-
 rust/kernel/sync/arc.rs        |  3 +-
 6 files changed, 77 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/alloc/boxext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index ad48ac8dc13d..5712c81b1308 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod boxext;
 pub mod vecext;
 
 /// Flags to be used when allocating memory.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 01ad139e19bc..fc0439455faa 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -15,7 +15,11 @@
 ///
 /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
 /// - `new_layout` must have a non-zero size.
-unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: bindings::gfp_t) -> *mut u8 {
+pub(crate) unsafe fn krealloc_aligned(
+    ptr: *mut u8,
+    new_layout: Layout,
+    flags: bindings::gfp_t,
+) -> *mut u8 {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
diff --git a/rust/kernel/alloc/boxext.rs b/rust/kernel/alloc/boxext.rs
new file mode 100644
index 000000000000..26a918df7acf
--- /dev/null
+++ b/rust/kernel/alloc/boxext.rs
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to [`Box`] for fallible allocations.
+
+use super::Flags;
+use alloc::boxed::Box;
+use core::alloc::AllocError;
+use core::mem::MaybeUninit;
+use core::result::Result;
+
+/// Extensions to [`Box`].
+pub trait BoxExt<T>: Sized {
+    /// Allocates a new box.
+    ///
+    /// The allocation may fail, in which case an error is returned.
+    fn new(x: T, flags: Flags) -> Result<Self, AllocError>;
+
+    /// Allocates a new uninitialised box.
+    ///
+    /// The allocation may fail, in which case an error is returned.
+    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError>;
+}
+
+impl<T> BoxExt<T> for Box<T> {
+    #[cfg(any(test, testlib))]
+    fn new(x: T, _flags: Flags) -> Result<Self, AllocError> {
+        Ok(Box::new(x))
+    }
+
+    #[cfg(not(any(test, testlib)))]
+    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let ptr = if core::mem::size_of::<T>() == 0 {
+            core::ptr::NonNull::<T>::dangling().as_ptr()
+        } else {
+            let layout = core::alloc::Layout::new::<T>();
+
+            // SAFETY: Memory is being allocated (first arg is null). The only other source of
+            // safety issues is sleeping on atomic context, which is addressed by klint.
+            let ptr = unsafe {
+                super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags.0)
+            };
+            if ptr.is_null() {
+                return Err(AllocError);
+            }
+
+            let ptr = ptr.cast::<T>();
+
+            // SAFETY: We just allocated the memory above, it is valid for write.
+            unsafe { ptr.write(x) };
+            ptr
+        };
+
+        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
+        // zero-sized types, we use `NonNull::dangling`.
+        Ok(unsafe { Box::from_raw(ptr) })
+    }
+
+    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
+        <Box<_> as BoxExt<_>>::new(MaybeUninit::<T>::uninit(), flags)
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..0d956934eaa4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -210,6 +210,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
+    alloc::{boxext::BoxExt, flags::*},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
@@ -305,9 +306,9 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Result<Pin<&mut Foo>, AllocError> = pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::try_new(Bar {
+///     b: Box::new(Bar {
 ///         x: 64,
-///     })?,
+///     }, GFP_KERNEL)?,
 /// }));
 /// let foo = foo.unwrap();
 /// pr_info!("a: {}", &*foo.a.lock());
@@ -331,9 +332,9 @@ macro_rules! stack_pin_init {
 ///
 /// stack_try_pin_init!(let foo: Pin<&mut Foo> =? pin_init!(Foo {
 ///     a <- new_mutex!(42),
-///     b: Box::try_new(Bar {
+///     b: Box::new(Bar {
 ///         x: 64,
-///     })?,
+///     }, GFP_KERNEL)?,
 /// }));
 /// pr_info!("a: {}", &*foo.a.lock());
 /// # Ok::<_, AllocError>(())
@@ -1158,7 +1159,7 @@ fn try_pin_init<E>(init: impl PinInit<T, E>) -> Result<Pin<Self>, E>
     where
         E: From<AllocError>,
     {
-        let mut this = Box::try_new_uninit()?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid and will not be moved, because we pin it later.
@@ -1172,7 +1173,7 @@ fn try_init<E>(init: impl Init<T, E>) -> Result<Self, E>
     where
         E: From<AllocError>,
     {
-        let mut this = Box::try_new_uninit()?;
+        let mut this = <Box<_> as BoxExt<_>>::new_uninit(GFP_KERNEL)?;
         let slot = this.as_mut_ptr();
         // SAFETY: When init errors/panics, slot will get deallocated but not dropped,
         // slot is valid.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index a7b203f87aa1..f73b4285168c 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vecext::VecExt};
+pub use crate::alloc::{boxext::BoxExt, flags::*, vecext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7d4c4bf58388..f0a5aed69693 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,6 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
+    alloc::{boxext::BoxExt, flags::*},
     bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
@@ -170,7 +171,7 @@ pub fn try_new(contents: T) -> Result<Self, AllocError> {
             data: contents,
         };
 
-        let inner = Box::try_new(value)?;
+        let inner = <Box<_> as BoxExt<_>>::new(value, GFP_KERNEL)?;
 
         // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
         // `Arc` object.
-- 
2.34.1


