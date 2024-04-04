Return-Path: <linux-kernel+bounces-131439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7248987E9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BFDF1C21DFA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E542112AAC6;
	Thu,  4 Apr 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VvGOj/23"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0460129A8E
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712233933; cv=none; b=agosMnVkcugZq6ON9kqjJfaaU5WwGUNk1PGzpkztaHxVD0mhyM8dfVN8AKNmRuocD5oha0HJJGhAMMw+h23Th5cGSRsSnWx4bIyJpHCnuhXrATyW7HYiPQKeERcdYgmX4I7HRg80TNp9TmcIHzTeHDIpJdDT80hET6/YPBPCtAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712233933; c=relaxed/simple;
	bh=UiZpIf3BFNfRYXQgX1pbRbLKUYIHeSA1dkwNj3p46PY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Kwh+MWhqhy1+Kw9U8nfSq0PZz/lZ/fema4Y7mJk3jhCnpGGr/rWTp2pv4Ksex/ojs1jXsQ/hWo8Pk+A8ks0Wy1Fvij4A3tQ6DwkdXceCHoo9/a86Zau1IAhaInv+bzfXrkzHnR3MO0sa+tdEOa1gdjqzs4cBjFChNXcPXvt5eeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VvGOj/23; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6156b93c768so18007017b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 05:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712233931; x=1712838731; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=taakBWKWpiwoIIU3/+JYifQ+UJK0O86XOZIW+qgXD8k=;
        b=VvGOj/23CXrIcXEmqyWqV0urEh6JCB/lsw5PACiGjJfXaEUOI+UMDorG4plSZqe+8W
         XKSAiJNq2LTRKXAaTHaf2iC4Pd9ky2+0ROTfLAMGM115UKkZoyYtKFiB83dQwytlXW4M
         sqakXFLPLTcGLcf3AsNSzwLdtq0RZzngLsC12YunqQrnMPXuQx6/KYBUqCK4yGWl6DMF
         amHU8cFuz2iIHbDbkdkKHuvEeKYOxMFY1q8e4CnvczD9hO3lqOSfPBgrWyv/fjBjtlNn
         43oTgeaaUcteJjR5nJ2k5ud0a8L2haOXnMuiKYbTXd+U9zMteW/s2Mqde3XCjsdfq8+T
         9V9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712233931; x=1712838731;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=taakBWKWpiwoIIU3/+JYifQ+UJK0O86XOZIW+qgXD8k=;
        b=DDvuSDjFNtWVO21W3LbkuSWPDPhBbRayxk7ZJi2LAbw4Srmsq+3DGshewiKhKHtCTb
         WYkLK85uk5PdwtaKOBpb3XNRXsucz0dHKtjbk3bf8OgNGF/YzN8HEE/aUPd8qwqEjRaY
         Gyg7c7XrbxcVzy/C7ZugWpYZ0MmRXQKXnl9GUjrluDb0xPsI0AllFnDs7L26TC4vVXcZ
         Mtt9kyXY7EuW4LjQY+meN6CQXe4zyCMttVA09jMtVHLwiBflj7zpTqVNjUej+9sRJYbn
         eZvkjSIPtiGFTgWeMEiqXJD6ruPvvlA3jfRk4s/zR7aRxrORo9fCLXvOqQ5FlYU1vHzB
         P73g==
X-Forwarded-Encrypted: i=1; AJvYcCVeEc7ANo1ep1pGKi3iE9u4s62wFkjUVzrZzyYweG9G+OCiMyEJzi2p67JXu5f7amRpV9/c41xVpXUla4Z7T9kIV3xBuPG3x5bywFr8
X-Gm-Message-State: AOJu0Yxh7904BONGZ/qcI9QcIYmMcvll9sxX6O7EKRPxFxKp9uSHnmBg
	JamdnrvsTxKBUL5gOjpxBkpC9bnNNvgoqNpnUniiyM+2jvEPqd+CKBbUclcy1U5or2b+B4dD0u/
	c3SEXM76L0TfmrQ==
X-Google-Smtp-Source: AGHT+IFmI9GK0405EKKeFUihI1V2MMV978wCRRUD+IF2RG+iw2g50ENG8068UenBApb8aTochDt6fXyIgyqbaIU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:a0c6:0:b0:615:36af:1997 with SMTP id
 x189-20020a81a0c6000000b0061536af1997mr657526ywg.1.1712233930863; Thu, 04 Apr
 2024 05:32:10 -0700 (PDT)
Date: Thu, 04 Apr 2024 12:31:41 +0000
In-Reply-To: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240404-alice-mm-v4-0-49a84242cf02@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8776; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=UiZpIf3BFNfRYXQgX1pbRbLKUYIHeSA1dkwNj3p46PY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDp2+LY7YpSqabe2ORUZvWo4bVNMZVV5WG3R5Y
 mu1KHdru/OJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZg6dvgAKCRAEWL7uWMY5
 Rg/hD/9idXpq7JAUwrsPqCMHE5ebfdee6X+qjWYNVVMCWAAHPuysFc6BuRDOAS3ksrtD6I64Hdx
 0SzqKoLWlb5G84cPRR3FsBvS9LZFniXIOnGP89k0MzHz4LCLcgAzuSZR+8nWh1P8kikjfhh9XDM
 bIWO2k3E02cCC1VRTNmUWEv1dP7BrbQi6KTZWo9JrlqKuAaYH850u+ULTuThr4fL+Ht81FSKiw6
 Z4pBcshiar3zqMhPz1UUyMk/oFXv0nGcmfkp+hRKzAgoWf6dEvxs+2IB/x1i7lm1DrhhIqb2U3F
 kjheC6V5Y8QcshSdG7ezsMEsLByCbEgrq2jQ3Hk3Hd48w869oYE0COHGY6cMHt5S619qGi0TV3r
 xnKuoInK826bagIN4wbiDkFKzfImcdzZ0+3AwdKjoUfrX8rQdwtBZ7N0N2/OQdNJnjJiGIUiJx/
 q99e8A13V4pcSappEdzwx7wc6TzfPwDI95gpDV+6n4DF/I0WiPOVpdO8vYZhY3LQfoZqWopPS4N
 ruTmP8hGyabWfrAD0Ja82KS+WKqXuHFPQuuOnpqUQiYX+f68M4WJ/oTzC+Cpy+61hKIpC8Y0RVB
 ZCzUv+hAM1RIW280T6WS1qMu3Qj9oSrVLjpmlpGcavdbg3jbArrgOsMCpCFkVE3JRdu+mbqVW4S /wWNwuGpAnPGO1Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240404-alice-mm-v4-3-49a84242cf02@google.com>
Subject: [PATCH v4 3/4] rust: uaccess: add typed accessors for userspace pointers
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Kees Cook <keescook@chromium.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
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
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 67 ++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index aa77bad9bce4..f72b82efdbfa 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,70 @@ pub enum Either<L, R> {
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
+// the array itself does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index 3f8ad4dc13c4..6566b8cc2541 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,10 +4,15 @@
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
-use core::mem::MaybeUninit;
+use core::mem::{size_of, MaybeUninit};
 
 /// A pointer to an area in userspace memory, which can be either read-only or
 /// read-write.
@@ -246,6 +251,41 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
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
@@ -308,4 +348,36 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         self.length -= len;
         Ok(())
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
2.44.0.478.gd926399ef9-goog


