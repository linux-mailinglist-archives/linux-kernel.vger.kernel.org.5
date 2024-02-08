Return-Path: <linux-kernel+bounces-58303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A561284E449
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CAA5288676
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B3937EEF3;
	Thu,  8 Feb 2024 15:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d86CKmSX"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0A7D41C
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407332; cv=none; b=SvYdKrvC6T751MQl3tPW0M7RkfYfMQq+DkCynz35+EWfceR/tAbMm7OUAYixCG8AO+Y7POWhBEcvhJxwfFoRn4WMrB9tGpJHg8WARe6MmHiUxykT+K3PensXjG+GCw5g8nH6JTlxNeiorll7zHF2ojlFiywXNyCQIv6JBUgbR3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407332; c=relaxed/simple;
	bh=0g42SIX3ikqPGex8zhN70IRWhPIkHg4UCYLIFxFrPfU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=K++eTKJW/gBp/jKvP0jus/mhyipTYDcT+FF+qEntDFcQzhAyl4BT9fYKj40rgN+psAN2pwJa3T5MFswJBUkZO78vGTbWzzM4VTb7Zq1cNozNbeEUMIkfsNg9GG3akSV99e8NTM7OnOppSKjsBIpHuIm5z6Xu/oauugir6bbpdug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d86CKmSX; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso3330566276.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707407328; x=1708012128; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=flngb/LA8uzIdl5igbJEwBtu/PZHJPBIGQxF8CY4PhE=;
        b=d86CKmSXMLMGUgnIQBGcw6GrfKSqp1/AoVlpRNQmakY/I3lwnBiJu09CCTPKS2c2Nn
         BYTnfFrCPHim7XpzxHH6nwmFwFP7orFH4NoPt3haSXpbRfRZS5+G6yaoNA7yCmwaVq9O
         4RC+Q1ieT6fHkp0WqcZBLKEdPbSL3Wuxq6dIf5lnybgGkBQCNnSM3B+VSq2ZSTRVov0n
         9JnExyda+TZxgQISJS0E3eD7N258qcPpvjKVCQ+a8FVDZ84Qt0OzexJt84fLEVIYunfI
         1mfUoIU+t0/8y5vpS+iA3OtkkHuASBfdqM1Eb86Y7Cvp+GXWwERHJiwxPCX4ufwq76BU
         TvgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407328; x=1708012128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=flngb/LA8uzIdl5igbJEwBtu/PZHJPBIGQxF8CY4PhE=;
        b=p3HgdUU3snERyy06QAuprbSQdxZfTSvmackMWNqdDlqvDho13JKnyRM0hrVuWVKv0I
         kJhI5phsq5OQ5LG9EcmmjJRh2LAd6RuACdE3XeVqbHuAGMyDzdCF6qRF6b90efnjcNZ/
         HU6m+vaYoKeyN9DA6N1VmbF1pmbgJaU+KXMQRL3haS4Yz53/KeEj8GbuwvVsc6/a68pu
         8ZPUNLifNUTq9l9mUDNi8G0xCM6KTT/9ARgcYoXrTIwlcTpccIFJ3oRXpCd0bMIs5Ade
         nukSNVafo3l7vbCQCdtZBr809Ze7VaQYYbnRVBQ2V6mgGAR/QGgsixeMvvQUyINc7OoH
         dDdA==
X-Forwarded-Encrypted: i=1; AJvYcCU8cGIZ3cUgfaKWdYzcDtJdfCOzXZ5v3uqIWbksYrBwI72NNiaIlfAutYNGHYiX8h8tqWUyoMI8kF6Hm1FexL7crfd7v7z9L2ANrKoT
X-Gm-Message-State: AOJu0YxhyXz6IQvzKLdBfgIO502fL2HLW8zlCtAjx8w/M7sjpEc9SrFa
	RrtrB59nc+2AtUbwyFeYPzyJw3PSgb7CEOHuNytVola1kGlZnc2cg3wffMn+jPESvYC40ZeU33S
	5adjQJlFDG8BsKA==
X-Google-Smtp-Source: AGHT+IHMYibPwpZ1RVGfZRX8AKyfUjB+V8DP1294a1PT4LdcHAG0vKr/hwfx2FdORpWP56VfcaTlftChXStJdqM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2186:b0:dc6:eea0:1578 with SMTP
 id dl6-20020a056902218600b00dc6eea01578mr2142900ybb.13.1707407328528; Thu, 08
 Feb 2024 07:48:48 -0800 (PST)
Date: Thu, 08 Feb 2024 15:47:53 +0000
In-Reply-To: <20240208-alice-mm-v2-0-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8719; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=0g42SIX3ikqPGex8zhN70IRWhPIkHg4UCYLIFxFrPfU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxPfTuOB96U/Lj40fHe9/xmDSElLomqfJO0cdJ
 oS0DmyNDKGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcT30wAKCRAEWL7uWMY5
 RhsAEACE9BLmNvDC79FcWLHl6NT6PpjTFGYzMx6E6caaaLeVuWDJ6hhRZ+WM5x1fY68NMh4jTze
 sSCcxDNl9i1VJtQx5DN5Dvxw8ZOheHmix6sYH2u6nzHLQB+ka5eT56u/j1JvtGhjDE+JN/FtLLi
 Ku7kHIhYAmrNWQ71Ccpdl9TmLyg9b+F3CewVZsPpMR8BiA7M8IMyElJgb2Qy8QK+2UyagQNkNck
 vUAOTl7XVhllYkzh7aNkH++irEYMD7l1Pzq6i0ark1Oh5QLENHbz6p9GrtKtibC8Y31d+5ahqGQ
 ofpIQmg4DLhYUbcdbSgHuvaSvA2aNvb3I4hI/CHF3ItH5GKHeZ1II37sZzwtQIDhW/jx3tI7cM7
 8fyu+b1eAvqo91GJyU9GKh6nyq+s/ft37vk5y7EsOCZVStX5wJkMW/fhvtHOQOQhIYU+yta/+3l
 gstUIDdyj8IP4sslt6FxHuMV/LEvQYzA/gw6mcz3plT02alcLP8CCjofOcmuw2A0U4BQkqvt4vf
 gdBiHa/nU9fHplEV10UtrZrwIchhpw29NoAzW9Log+xqOYBfvEJED/LBawfR0KQXivClAID7XvG
 9u9w6oeJ6ZDYHCsI/brqznI4Um6gkWFG6YsPqFD1HyYPlG6VCo28FcfELn8as/Nz5rkkkTm8zjW 7WgDIC5F4sLMOdA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240208-alice-mm-v2-3-d821250204a6@google.com>
Subject: [PATCH v2 3/4] rust: uaccess: add typed accessors for userspace pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Kees Cook <keescook@chromium.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>, Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="utf-8"

Add safe methods for reading and writing Rust values to and from
userspace pointers.

The C methods for copying to/from userspace use a function called
`check_object_size` to verify that the kernel pointer is not dangling.
However, this check is skipped when the length is a compile-time
constant, with the assumption that such cases trivially have a correct
kernel pointer.

In this patch, we apply the same optimization to the typed accessors.
For both methods, the size of the operation is known at compile time to
be size_of of the type being read or written. Since the C side doesn't
provide a variant that skips only this check, we create custom helpers
for this purpose.

The majority of reads and writes to userspace pointers in the Rust
Binder driver uses these accessor methods. Benchmarking has found that
skipping the `check_object_size` check makes a big difference for the
cases being skipped here. (And that the check doesn't make a difference
for the cases that use the raw read/write methods.)

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice to skip the
`check_object_size` check, and to update various comments, including the
notes about kernel pointers in `WritableToBytes`.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 67 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 141 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index fdb778e65d79..33d175a3a6ed 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -387,3 +387,70 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either
+/// zero or one, so reading arbitrary bytes into something that contains a
+/// `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no
+/// effect.
+///
+/// # Safety
+///
+/// All bit-patterns must be valid for this type.
+pub unsafe trait FromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl FromBytes for u8 {}
+unsafe impl FromBytes for u16 {}
+unsafe impl FromBytes for u32 {}
+unsafe impl FromBytes for u64 {}
+unsafe impl FromBytes for usize {}
+unsafe impl FromBytes for i8 {}
+unsafe impl FromBytes for i16 {}
+unsafe impl FromBytes for i32 {}
+unsafe impl FromBytes for i64 {}
+unsafe impl FromBytes for isize {}
+// SAFETY: If all bit patterns are acceptable for individual values in an array,
+// then all bit patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {}
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+
+/// Types that can be viewed as an immutable slice of initialized bytes.
+///
+/// If a struct implements this trait, then it is okay to copy it byte-for-byte
+/// to userspace. This means that it should not have any padding, as padding
+/// bytes are uninitialized. Reading uninitialized memory is not just undefined
+/// behavior, it may even lead to leaking sensitive information on the stack to
+/// userspace.
+///
+/// The struct should also not hold kernel pointers, as kernel pointer addresses
+/// are also considered sensitive. However, leaking kernel pointers is not
+/// considered undefined behavior by Rust, so this is a correctness requirement,
+/// but not a safety requirement.
+///
+/// # Safety
+///
+/// Values of this type may not contain any uninitialized bytes.
+pub unsafe trait AsBytes {}
+
+// SAFETY: Instances of the following types have no uninitialized portions.
+unsafe impl AsBytes for u8 {}
+unsafe impl AsBytes for u16 {}
+unsafe impl AsBytes for u32 {}
+unsafe impl AsBytes for u64 {}
+unsafe impl AsBytes for usize {}
+unsafe impl AsBytes for i8 {}
+unsafe impl AsBytes for i16 {}
+unsafe impl AsBytes for i32 {}
+unsafe impl AsBytes for i64 {}
+unsafe impl AsBytes for isize {}
+unsafe impl AsBytes for bool {}
+unsafe impl AsBytes for char {}
+unsafe impl AsBytes for str {}
+// SAFETY: If individual values in an array have no uninitialized portions, then
+// the the array itself does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index f07821184bd6..71a00177a4b9 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,9 +4,15 @@
 //!
 //! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
 
-use crate::{bindings, error::code::*, error::Result};
+use crate::{
+    bindings,
+    error::code::*,
+    error::Result,
+    types::{AsBytes, FromBytes},
+};
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
+use core::mem::{size_of, MaybeUninit};
 
 /// A pointer to an area in userspace memory, which can be either read-only or
 /// read-write.
@@ -237,6 +243,41 @@ pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
         Ok(())
     }
 
+    /// Reads a value of the specified type.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read<T: FromBytes>(&mut self) -> Result<T> {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
+        // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
+        //
+        // By using the _copy_from_user variant, we skip the check_object_size
+        // check that verifies the kernel pointer. This mirrors the logic on the
+        // C side that skips the check when the length is a compile-time
+        // constant.
+        let res = unsafe {
+            bindings::_copy_from_user(out.as_mut_ptr().cast::<c_void>(), self.ptr, len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        // SAFETY: The read above has initialized all bytes in `out`, and since
+        // `T` implements `FromBytes`, any bit-pattern is a valid value for this
+        // type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads the entirety of the user slice, appending it to the end of the
     /// provided buffer.
     ///
@@ -311,4 +352,36 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         // `len`, so the pointer is valid for reading `len` bytes.
         unsafe { self.write_raw(ptr, len) }
     }
+
+    /// Writes the provided Rust value to this userspace pointer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The reference points to a value of type `T`, so it is valid
+        // for reading `size_of::<T>()` bytes.
+        //
+        // By using the _copy_to_user variant, we skip the check_object_size
+        // check that verifies the kernel pointer. This mirrors the logic on the
+        // C side that skips the check when the length is a compile-time
+        // constant.
+        let res = unsafe {
+            bindings::_copy_to_user(self.ptr, (value as *const T).cast::<c_void>(), len_ulong)
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
 }

-- 
2.43.0.594.gd9cf4e227d-goog


