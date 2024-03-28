Return-Path: <linux-kernel+bounces-122293-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A87D88F4CA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB6329D6FA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE972CCA0;
	Thu, 28 Mar 2024 01:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqVkGJRd"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BC9208D0;
	Thu, 28 Mar 2024 01:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589810; cv=none; b=nkZOTS+El8vdcB59X0lLPPWWZ9LFyjyKiCgxHPC4xxlBhAEvcnJHHK/bddKG/afLP8W3MhpHg1T1opLVSxd2kiNHNdZygy5pIXTWJv6+zNDi2kFTC/Yuf8PSL4SGNASgA3LKVEmPlQGGL/lY3h8SxhDn+j/lJON+iX5kCFf+5+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589810; c=relaxed/simple;
	bh=96bRq/+qJfQCIMZ0I8SiRs1nxmjTe0wZLS9tctyYJxQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Smhyem755a+F9HWtTmAjo/0dFCHogiSsC7nelVssCzbC+Q652/X4iH6npI4WNQnNAlZLlyTVYlGM/EFRLN+ozqGMzY5iAKoe2J6E3mn+dnSY9fH5QP22T1ii3qQLvwHppLDA6nYlPEbvIvApeT4T29worgFLzWaJf0LhAs/8AmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqVkGJRd; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6e709e0c123so463520b3a.1;
        Wed, 27 Mar 2024 18:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589808; x=1712194608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bc5LgahBmcqOc0n2YnlBGbVBMmrK+hqV/nQyf99B/aQ=;
        b=cqVkGJRd16m/3DEYDG96wRUK7M2URYuaqBkpfxnLxhmzu9JxkjErwV+1P/wFk8etp5
         U43ME11WbeTP3ANg643zXbSVcOu20NlxhugjB6A3GcoPHVXd9ozY8TxZGd6Trg9c4fol
         3UH5nToKinXwabOl44c1N1H9g5cM6RDr6CGiHuCJqvRLftwVtynlrsOWgwLfyi5xz4pO
         Ut0n4THcjXNX/7Uk1xg0MPIQvTPJ7tg8LqqqIViozETmGACeDLwiX9L069HQVS7smTLU
         E8CaJOjUmRBi0ys5kXQnOu9VzaSwAVgmgjCpPAGuseJecGNqKI11HwWlu9EVCm1Y88uO
         p+og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589808; x=1712194608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bc5LgahBmcqOc0n2YnlBGbVBMmrK+hqV/nQyf99B/aQ=;
        b=wl6/M4piGX8PbiZDAMzX9l6v2TRznJ4MYXSQ7kkgpo9wo+fbCLRl2Sdfotr5iJwCTW
         rtzDKqZnIyZF/iH7D4CiTWDbGAS1pJtyL3Tv4fHOp2KQjpbVRZA9TVkWWAGmqJUWrLUt
         YxEnN4Y6Iv6mSwU2tVPxFcY69tUNguAV9R3NaJiTYEvAl1xjNMRzdsat22VBmke1RQ8b
         4eaAlWoK7l+ENXhoo1zLzKgOI/Ak0kAN1hXQO6wUy6bQx2wUs498FYWyWTKY1AtuTcG+
         OugHbc4fAQsr7TWPL31H5CN4yFbp6t8f+vkcon/KuQvUmQ4/9x7bf2b2Elvjyq1RB3YZ
         OmyA==
X-Forwarded-Encrypted: i=1; AJvYcCWKAoE1g/pCE14kT4RmR23/7C1vxY0a+IT8uK/5ndeMtZIF+K4fSrnB+pjjFwEHPoNkBX5/5OoAiuP1cL7cs09Xux4q6hytjky//IRT
X-Gm-Message-State: AOJu0YxLcxew0s2PtHGsKgXDYXyFkD6ehcYEgDvimHmzryK5P8YUShEc
	zp3HzKsOh1wyYw/II6XUq/l28kYrZIyJg9Q1/ZyrZgnD6yaFoDQWzL1UWkdZ
X-Google-Smtp-Source: AGHT+IGDMh8xY4DrMKkOdy1mASNPUDeXrrD3VAA58TMizFsUtMd2mRpf4gVOaRul9h+jDJbf0Gq7Mg==
X-Received: by 2002:a05:6a20:c530:b0:1a3:57b4:ed1c with SMTP id gm48-20020a056a20c53000b001a357b4ed1cmr1441310pzb.25.1711589807680;
        Wed, 27 Mar 2024 18:36:47 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:47 -0700 (PDT)
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
Subject: [PATCH v3 06/10] rust: alloc: introduce the `BoxExt` trait
Date: Wed, 27 Mar 2024 22:35:59 -0300
Message-Id: <20240328013603.206764-7-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
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
 rust/kernel/alloc/allocator.rs |  2 +-
 rust/kernel/alloc/box_ext.rs   | 60 ++++++++++++++++++++++++++++++++++
 rust/kernel/init.rs            | 13 ++++----
 rust/kernel/prelude.rs         |  2 +-
 rust/kernel/sync/arc.rs        |  3 +-
 6 files changed, 72 insertions(+), 9 deletions(-)
 create mode 100644 rust/kernel/alloc/box_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index fd5541991a22..9bc1b48b5641 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,6 +5,7 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod box_ext;
 pub mod vec_ext;
 
 /// Flags to be used when allocating memory.
diff --git a/rust/kernel/alloc/allocator.rs b/rust/kernel/alloc/allocator.rs
index 8cc7099d6ae1..ff88bce04fd4 100644
--- a/rust/kernel/alloc/allocator.rs
+++ b/rust/kernel/alloc/allocator.rs
@@ -16,7 +16,7 @@
 ///
 /// - `ptr` can be either null or a pointer which has been allocated by this allocator.
 /// - `new_layout` must have a non-zero size.
-unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
+pub(crate) unsafe fn krealloc_aligned(ptr: *mut u8, new_layout: Layout, flags: Flags) -> *mut u8 {
     // Customized layouts from `Layout::from_size_align()` can have size < align, so pad first.
     let layout = new_layout.pad_to_align();
 
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
new file mode 100644
index 000000000000..c62db0aa4dd1
--- /dev/null
+++ b/rust/kernel/alloc/box_ext.rs
@@ -0,0 +1,60 @@
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
+    fn new(x: T, flags: Flags) -> Result<Self, AllocError> {
+        let mut b = <Self as BoxExt<_>>::new_uninit(flags)?;
+        b.write(x);
+        // SAFETY: The contents were just initialised in the line above.
+        Ok(unsafe { b.assume_init() })
+    }
+
+    #[cfg(any(test, testlib))]
+    fn new_uninit(_flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
+        Ok(Box::new_uninit())
+    }
+
+    #[cfg(not(any(test, testlib)))]
+    fn new_uninit(flags: Flags) -> Result<Box<MaybeUninit<T>>, AllocError> {
+        let ptr = if core::mem::size_of::<MaybeUninit<T>>() == 0 {
+            core::ptr::NonNull::<_>::dangling().as_ptr()
+        } else {
+            let layout = core::alloc::Layout::new::<MaybeUninit<T>>();
+
+            // SAFETY: Memory is being allocated (first arg is null). The only other source of
+            // safety issues is sleeping on atomic context, which is addressed by klint. Lastly,
+            // the type is not a SZT (checked above).
+            let ptr =
+                unsafe { super::allocator::krealloc_aligned(core::ptr::null_mut(), layout, flags) };
+            if ptr.is_null() {
+                return Err(AllocError);
+            }
+
+            ptr.cast::<MaybeUninit<T>>()
+        };
+
+        // SAFETY: For non-zero-sized types, we allocate above using the global allocator. For
+        // zero-sized types, we use `NonNull::dangling`.
+        Ok(unsafe { Box::from_raw(ptr) })
+    }
+}
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 424257284d16..9c798cffc8e4 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -210,6 +210,7 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
+    alloc::{box_ext::BoxExt, flags::*},
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
index 827e4dfd77df..b37a0b3180fb 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::{flags::*, vec_ext::VecExt};
+pub use crate::alloc::{box_ext::BoxExt, flags::*, vec_ext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7d4c4bf58388..1252a1b630ed 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,6 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
+    alloc::{box_ext::BoxExt, flags::*},
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


