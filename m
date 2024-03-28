Return-Path: <linux-kernel+bounces-122295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9924488F4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:38:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5019A29CF00
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E452E651;
	Thu, 28 Mar 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIikscQ/"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD0B32C8C;
	Thu, 28 Mar 2024 01:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589816; cv=none; b=rBGz2/Qi08QYVqOxWfBGYJX/To9kFAJRn/+LLj4bL726FxQ1IbRlF9xOu5NNUbwEMOon9qFTNvw16EU/6s+dybH/zPKrlRSEojiAhGvBkR2qWha2kcbq/kyiNzLKLKe+7Uwik9kGEqI0q+tVFRfmv4XdwNzvoV2vRMcpkSQYGXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589816; c=relaxed/simple;
	bh=CS9j6u+xLxStSnrAH5l3Yw8UVWXk2/DGL0QR/V8Mi00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cru/4MRWZ38WAafxLhfguHcmB9/VgV/DhxzsqQoHEzi7AqYUFNNEX/L4wmf6t5ch7EhQNgTrSWp9aC6P9VyRhllcNVO5pB7guoeWe/vO95R9/JADkp+GtceCROv0j+TyOs3rnh/EtPVle3NuokYMmt9zTVIyqBYUzoaOT1e7GZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EIikscQ/; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6b6f86975so334988b3a.1;
        Wed, 27 Mar 2024 18:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589814; x=1712194614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lkJ9Sqgfo+1vz3RU51PT2IX+JbjMqsfy3OV4FD+xp3k=;
        b=EIikscQ/aL4rMcJPdZHG60GllUcB7ucauUx224J8hT5GK8O6gQurCUE22aNaMZ+Eyt
         IxK6iBXzdV8VNJ+Hs8ecdh0eus0o90Bs0hwmHwACM+umbktdSc5jGs6nJdCMwC6uhTU1
         7wOOf2/CdMSKB8EzzHVB1YhJ3m7i+fTxZL6Be/qYav7cYUCpfgqius+JwQUiJ3yH1V2Z
         pfbjNFlu2WTsoumgvq0IJFM4FQ8Zu19nCmamzq8VW5ITa8LunFW87R+Abk2QG+ASzm8P
         /dXYz+zlVh3PfyDjNgxnzx21KqgiHjuOHh1PbraEUkAP9eCPfgif3A8osSybFjhY1khj
         OuKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589814; x=1712194614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lkJ9Sqgfo+1vz3RU51PT2IX+JbjMqsfy3OV4FD+xp3k=;
        b=PocqjAkVq7BvjtkdzmfcS7ywApBSWvnzXpIyBwHAkTb8nfLCCUD2gKhtW/efuLb+5Q
         MvCVPeR5evr9ZtqfrOZXdBeRvEjEybR5DCDWnlNDUVQ2skECdFB3ziwWW6e6nFeCCCLr
         J+HxpLuPhE5Kw6ViT/2irlEbawfcps7HO1y7JK36u9WNuWjhP+wYIHrKrkzGimwWBFjQ
         cAx/pgxQeavVWuZUHZ3Kv8hOFEnsS9zurq8JhimLCZckh274NPCEloIIobs7Q1IbKAdX
         ope8R6PP/gMBZaq8RIdNkxZodH2qHg9Owdy5XfGmZby8Y5s0BsR3e6Ub/dQ+k1SbZA7W
         LETw==
X-Forwarded-Encrypted: i=1; AJvYcCVOLu+X3sriPdKG7ekfViIO7ig4XsbLnb3s2SQCAfD3diU6JtQL4Z5tnZg5i+w8s+aHuVOLXF//V6LZ2NXW4BK8suHHith1tuNX56Wh
X-Gm-Message-State: AOJu0Yy7l0XDZnEY69+YVZgEGGAzfBWyGCIqgkzccAgDQON8uMwpTobF
	0LWMjHxymI8q8BcnYmoN9oezdhpsKY+kOlcEU92SZrAozLJbXecIgQtnVVJX
X-Google-Smtp-Source: AGHT+IGf1jCcR8NIMIzE2dY3lhVFCX+R5IgpQBDlmc2UMYD9Z4Nmj3rgHzwXxkxyCZuWHuRlHzlz/w==
X-Received: by 2002:a05:6a20:2a10:b0:1a3:5581:1692 with SMTP id e16-20020a056a202a1000b001a355811692mr1738895pzh.30.1711589813625;
        Wed, 27 Mar 2024 18:36:53 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:53 -0700 (PDT)
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
Subject: [PATCH v3 07/10] rust: alloc: update `VecExt` to take allocation flags
Date: Wed, 27 Mar 2024 22:36:00 -0300
Message-Id: <20240328013603.206764-8-wedsonaf@gmail.com>
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

We also rename the methods by removing the `try_` prefix since the names
are available due to our usage of the `no_global_oom_handling` config
when building the `alloc` crate.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc/vec_ext.rs | 158 +++++++++++++++++++++++++++++++----
 rust/kernel/error.rs         |  11 +--
 rust/kernel/lib.rs           |   1 -
 rust/kernel/str.rs           |   6 +-
 rust/kernel/types.rs         |   4 +-
 samples/rust/rust_minimal.rs |   6 +-
 6 files changed, 152 insertions(+), 34 deletions(-)

diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index 311e62cc5784..e24d7c7675ca 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -2,47 +2,175 @@
 
 //! Extensions to [`Vec`] for fallible allocations.
 
-use alloc::{collections::TryReserveError, vec::Vec};
+use super::Flags;
+use alloc::{alloc::AllocError, vec::Vec};
 use core::result::Result;
 
 /// Extensions to [`Vec`].
 pub trait VecExt<T>: Sized {
     /// Creates a new [`Vec`] instance with at least the given capacity.
-    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let v = Vec::<u32>::with_capacity(20, GFP_KERNEL)?;
+    ///
+    /// assert!(v.capacity() >= 20);
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError>;
 
     /// Appends an element to the back of the [`Vec`] instance.
-    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = Vec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1]);
+    ///
+    /// v.push(2, GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 2]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError>;
 
     /// Pushes clones of the elements of slice into the [`Vec`] instance.
-    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = Vec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.extend_from_slice(&[20, 30, 40], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40]);
+    ///
+    /// v.extend_from_slice(&[50, 60], GFP_KERNEL)?;
+    /// assert_eq!(&v, &[1, 20, 30, 40, 50, 60]);
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
     where
         T: Clone;
+
+    /// Ensures that the capacity exceeds the length by at least `additional` elements.
+    ///
+    /// # Examples
+    ///
+    /// ```
+    /// let mut v = Vec::new();
+    /// v.push(1, GFP_KERNEL)?;
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let cap = v.capacity();
+    /// assert!(cap >= 10);
+    ///
+    /// v.reserve(10, GFP_KERNEL)?;
+    /// let new_cap = v.capacity();
+    /// assert_eq!(new_cap, cap);
+    ///
+    /// # Ok::<(), Error>(())
+    /// ```
+    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError>;
 }
 
 impl<T> VecExt<T> for Vec<T> {
-    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+    fn with_capacity(capacity: usize, flags: Flags) -> Result<Self, AllocError> {
         let mut v = Vec::new();
-        v.try_reserve(capacity)?;
+        <Self as VecExt<_>>::reserve(&mut v, capacity, flags)?;
         Ok(v)
     }
 
-    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
-        if let Err(retry) = self.push_within_capacity(v) {
-            self.try_reserve(1)?;
-            let _ = self.push_within_capacity(retry);
-        }
+    fn push(&mut self, v: T, flags: Flags) -> Result<(), AllocError> {
+        <Self as VecExt<_>>::reserve(self, 1, flags)?;
+        let s = self.spare_capacity_mut();
+        s[0].write(v);
+
+        // SAFETY: We just initialised the first spare entry, so it is safe to increase the length
+        // by 1. We also know that the new length is <= capacity because of the previous call to
+        // `reserve` above.
+        unsafe { self.set_len(self.len() + 1) };
         Ok(())
     }
 
-    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    fn extend_from_slice(&mut self, other: &[T], flags: Flags) -> Result<(), AllocError>
     where
         T: Clone,
     {
-        self.try_reserve(other.len())?;
-        for item in other {
-            self.try_push(item.clone())?;
+        <Self as VecExt<_>>::reserve(self, other.len(), flags)?;
+        for (slot, item) in core::iter::zip(self.spare_capacity_mut(), other) {
+            slot.write(item.clone());
         }
 
+        // SAFETY: We just initialised the `other.len()` spare entries, so it is safe to increase
+        // the length by the same amount. We also know that the new length is <= capacity because
+        // of the previous call to `reserve` above.
+        unsafe { self.set_len(self.len() + other.len()) };
+        Ok(())
+    }
+
+    #[cfg(any(test, testlib))]
+    fn reserve(&mut self, additional: usize, _flags: Flags) -> Result<(), AllocError> {
+        Vec::reserve(self, additional);
         Ok(())
     }
+
+    #[cfg(not(any(test, testlib)))]
+    fn reserve(&mut self, additional: usize, flags: Flags) -> Result<(), AllocError> {
+        let len = self.len();
+        let cap = self.capacity();
+
+        if cap - len >= additional {
+            return Ok(());
+        }
+
+        if core::mem::size_of::<T>() == 0 {
+            // The capacity is already `usize::MAX` for SZTs, we can't go higher.
+            return Err(AllocError);
+        }
+
+        // We know cap is <= `isize::MAX` because `Layout::array` fails if the resulting byte size
+        // is greater than `isize::MAX`. So the multiplication by two won't overflow.
+        let new_cap = core::cmp::max(cap * 2, len.checked_add(additional).ok_or(AllocError)?);
+        let layout = core::alloc::Layout::array::<T>(new_cap).map_err(|_| AllocError)?;
+
+        let (ptr, len, cap) = destructure(self);
+
+        // SAFETY: `ptr` is valid because it's either NULL or comes from a previous call to
+        // `krealloc_aligned`. We also verified that the type is not a ZST.
+        let new_ptr = unsafe { super::allocator::krealloc_aligned(ptr.cast(), layout, flags) };
+        if new_ptr.is_null() {
+            // SAFETY: We are just rebuilding the existing `Vec` with no changes.
+            unsafe { rebuild(self, ptr, len, cap) };
+            Err(AllocError)
+        } else {
+            // SAFETY: `ptr` has been reallocated with the layout for `new_cap` elements. New cap
+            // is greater than `cap`, so it continues to be >= `len`.
+            unsafe { rebuild(self, new_ptr.cast::<T>(), len, new_cap) };
+            Ok(())
+        }
+    }
+}
+
+#[cfg(not(any(test, testlib)))]
+fn destructure<T>(v: &mut Vec<T>) -> (*mut T, usize, usize) {
+    let mut tmp = Vec::new();
+    core::mem::swap(&mut tmp, v);
+    let mut tmp = core::mem::ManuallyDrop::new(tmp);
+    let len = tmp.len();
+    let cap = tmp.capacity();
+    (tmp.as_mut_ptr(), len, cap)
+}
+
+/// Rebuilds a `Vec` from a pointer, length, and capacity.
+///
+/// # Safety
+///
+/// The same as [`Vec::from_raw_parts`].
+#[cfg(not(any(test, testlib)))]
+unsafe fn rebuild<T>(v: &mut Vec<T>, ptr: *mut T, len: usize, cap: usize) {
+    // SAFETY: The safety requirements from this function satisfy those of `from_raw_parts`.
+    let mut tmp = unsafe { Vec::from_raw_parts(ptr, len, cap) };
+    core::mem::swap(&mut tmp, v);
 }
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index 4786d3ee1e92..e53466937796 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -6,10 +6,7 @@
 
 use crate::str::CStr;
 
-use alloc::{
-    alloc::{AllocError, LayoutError},
-    collections::TryReserveError,
-};
+use alloc::alloc::{AllocError, LayoutError};
 
 use core::convert::From;
 use core::fmt;
@@ -192,12 +189,6 @@ fn from(_: Utf8Error) -> Error {
     }
 }
 
-impl From<TryReserveError> for Error {
-    fn from(_: TryReserveError) -> Error {
-        code::ENOMEM
-    }
-}
-
 impl From<LayoutError> for Error {
     fn from(_: LayoutError) -> Error {
         code::ENOMEM
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7f2841a18d05..51f30e55bd00 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,7 +19,6 @@
 #![feature(offset_of)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
-#![feature(vec_push_within_capacity)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index e1be6c5e72a9..58f2ddafb326 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,7 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::vec_ext::VecExt;
+use crate::alloc::{flags::*, vec_ext::VecExt};
 use alloc::alloc::AllocError;
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
@@ -730,7 +730,7 @@ pub fn try_from_fmt(args: fmt::Arguments<'_>) -> Result<Self, Error> {
         let size = f.bytes_written();
 
         // Allocate a vector with the required number of bytes, and write to it.
-        let mut buf = Vec::try_with_capacity(size)?;
+        let mut buf = <Vec<_> as VecExt<_>>::with_capacity(size, GFP_KERNEL)?;
         // SAFETY: The buffer stored in `buf` is at least of size `size` and is valid for writes.
         let mut f = unsafe { Formatter::from_buffer(buf.as_mut_ptr(), size) };
         f.write_fmt(args)?;
@@ -771,7 +771,7 @@ impl<'a> TryFrom<&'a CStr> for CString {
     fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
         let mut buf = Vec::new();
 
-        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
+        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_KERNEL)
             .map_err(|_| AllocError)?;
 
         // INVARIANT: The `CStr` and `CString` types have the same invariants for
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index aa77bad9bce4..8fad61268465 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -157,11 +157,11 @@ unsafe fn from_foreign(_: *const core::ffi::c_void) -> Self {}
 ///     let mut vec =
 ///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
 ///
-///     vec.try_push(10u8)?;
+///     vec.push(10u8, GFP_KERNEL)?;
 ///     if arg {
 ///         return Ok(());
 ///     }
-///     vec.try_push(20u8)?;
+///     vec.push(20u8, GFP_KERNEL)?;
 ///     Ok(())
 /// }
 ///
diff --git a/samples/rust/rust_minimal.rs b/samples/rust/rust_minimal.rs
index dc05f4bbe27e..2a9eaab62d1c 100644
--- a/samples/rust/rust_minimal.rs
+++ b/samples/rust/rust_minimal.rs
@@ -22,9 +22,9 @@ fn init(_module: &'static ThisModule) -> Result<Self> {
         pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
 
         let mut numbers = Vec::new();
-        numbers.try_push(72)?;
-        numbers.try_push(108)?;
-        numbers.try_push(200)?;
+        numbers.push(72, GFP_KERNEL)?;
+        numbers.push(108, GFP_KERNEL)?;
+        numbers.push(200, GFP_KERNEL)?;
 
         Ok(RustMinimal { numbers })
     }
-- 
2.34.1


