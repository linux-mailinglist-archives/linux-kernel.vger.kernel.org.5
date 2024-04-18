Return-Path: <linux-kernel+bounces-149765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670D58A958B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:01:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AB9A1C20CAF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC0E15CD40;
	Thu, 18 Apr 2024 08:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pKT1lB/h"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E682515A4B8
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430782; cv=none; b=H2nrmajA++TPzH+DncLVYtLIXKU2ZCRam9wyXaV03E6ZBAmWAS0K6AD5TyCQsOfiOw9h6nqnHDxmaJuOujyF7cOljmYOZXs5LKJreajnse41kf9TBUTs6MjFQdATvvx4NCOt3THGj0HwWjlbObXir6uAFFiCEz99QR/m/VNjZLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430782; c=relaxed/simple;
	bh=nI8Gb6Ut6mQQFRyrF/IoMMXllmm0f2L2teM9nYy0pQk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YP16J5IRdS5bkmpjmbOwuOBzyK1QUzgI81m5DvuTn8g7IfvE+CnIY32NVyCPorQAGi/1efRbhgRA5iSfG4Js4XEtmOHtEW4SR8qaozqC1adJS6TneMKfbJYNoEhUs8HCw1KjoKtKVa0O2o+zjuyCeYskau5L9JZ7dAEC10ZomhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pKT1lB/h; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d8a7bb09afso5655421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713430779; x=1714035579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HgZdNi+a47HOfHsTxDpJlGILwCywia5g2y3UnrPe+eU=;
        b=pKT1lB/h1ceYRvXCxJ6fyVp+CUEA53mKc6suFUBMtQZ87Z01CxL4Zx+btMHFUSs+i2
         sVLkrhk7L/KWGAMI1DGJ4hn2K6j4XenlMKNkld/7b4WF26uroAOlqAFFh1m6rErlhaeQ
         9X0jEfy7LRbzhxku48OYmn5EVDwFU6Kj8dRCUmuTfH1bSKxfRi9Yxo+ciM6NE7t43tHN
         4/t+RtVo13G62V/eaeNr8nFYeqDTqWMnjnGaJE3WBDng4CKQd3IgXyhELTKjD5JrsVLb
         CANpU1rHpqrERqi0Y3q2JDvfbbOl+nTrZyoL7sdcJ/5B0JOqn+94bxs9l2fn8Nbsq1Oq
         zHEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430779; x=1714035579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HgZdNi+a47HOfHsTxDpJlGILwCywia5g2y3UnrPe+eU=;
        b=D2dJwq7z+Fg1OaQh5U5PL5WQXzYF6R40NqWPKFalA//qtQlGXs1qnXRFZLEbkA8auV
         IweK0rEz/IWl7Gr3Ml1Zf8YVrGSIbgip7aU+8FNdNw04qCt5m/OJcv+eN4jdFCn0TM5Q
         Rix4owXRBa7nCgYGznBdBOWf6AGkMOTDZ3kzFmBHhf9HfbNCvIiXcg8zERDDp6l7XOJ1
         Y3cN+pTMFebTX6a5NsihIr8kYsFbwYO9dr2P6ecTPGn6qDtCp2gog+9K5poz7Lw67lT3
         nGGKm3gFzN9qnKNnFFvZyPylabRtGGFYisqrTRUfEsTNRsF3Xm4abcwIfeLI0GBMqggl
         4qVQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgJ5jVLEm1Wodw37rxZMipRTqkojKHbuCQRxNKg6eimM6UN/Sn8/5zd+GI6ywrZE2o91Aljr/byZqoa5zJ56eteB4SRjZBZnwU+C27
X-Gm-Message-State: AOJu0Yw0ZlOr3FP3eh3X8uGFb2sp5jwTzGP/r2p/CpfpRdXNX0l+tgPA
	9NUMsoMh68JULAgS4DtM4zBfdekFHH2Js77ZeXPNpP6Qbh2sFP0lJqy2VONi6yNOQJOCwkoCvdl
	d7U0W/iuxb0Q6XQ==
X-Google-Smtp-Source: AGHT+IH6ScDtDrgw+IgQwpvtBZKJlRmNiyvFjb4gONlBnfX6IBw590w36dZkN+MXAX42+StYgo9t80UV0fKV/JE=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:512:b0:518:bd37:87f2 with SMTP
 id o18-20020a056512051200b00518bd3787f2mr1938lfb.4.1713430779142; Thu, 18 Apr
 2024 01:59:39 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:59:19 +0000
In-Reply-To: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=8978; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=nI8Gb6Ut6mQQFRyrF/IoMMXllmm0f2L2teM9nYy0pQk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmIODvS6oNsms6X0YHcmuKs7EizEym1tAEymjog
 Q30/NA20CSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZiDg7wAKCRAEWL7uWMY5
 RncsEACrSjtg5WqYkwrxGPaVxe3pCJO44xelyaMAJzezxUveUUN5hRIaFILfZELJj21aJsGBbVu
 l5N9yhyek7O3RPzQFGOzyapoR0QkuNWswj8JdEFq34/xHTp02Dy0WRmgxYUeIyQo+CkH+epFXbA
 yLxSgdLPnaqwYLFkJL6W5fwIbas8WiKJyS7u/Udsd+14bj2lHYAYCKosI5sSyJbIaRX4ODOrp9F
 BNHlogeI0A9yixFtpGGvN8z+kLxbDNafpriT58EFMWb5WmrXUjW6w+nxdvj3byMBWWqo3FxHHmt
 O80OQrBHRpoM5az1Xz7ctWqayHAL1Q8VsbQCu87jrGxP8BFwhvnYpHS1G9LtlkuBXeKLEKmlx+U
 D+fcJj9z/3j1P8biVsbOFvv/64U8re5ZdjqRyOqBygddDFvMEVkY9jW7n7Z3NtPyMuw8vQn8Prz
 DEAp2pVwpkf7Luo7EZhM431ixMB1xM1F0M9590356xT26n8/qycKA8X6ApHtnC30MoQLF8PXEte
 4eMs4UvJmDodAIddQUXiz+Kj0FhmLVKyq85a2LEXuJuocTEzIoW7G1ytgOSkfmWFxmzjfa241x8
 MrruNrGto/mokKkTJkN9fr0Yr5NZeVs2OmcAPCWihtjiUChNskjqHNalBFknaZUrbLknfBkVYee XKo2SmbVJZgp8vg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240418-alice-mm-v6-3-cb8f3e5d688f@google.com>
Subject: [PATCH v6 3/4] rust: uaccess: add typed accessors for userspace pointers
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
	Suren Baghdasaryan <surenb@google.com>, Arnd Bergmann <arnd@arndb.de>, Trevor Gross <tmgross@umich.edu>, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>, 
	Christian Brauner <brauner@kernel.org>
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
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/types.rs   | 64 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/uaccess.rs | 79 ++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 141 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 8fad61268465..9c57c6c75553 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -409,3 +409,67 @@ pub enum Either<L, R> {
     /// Constructs an instance of [`Either`] containing a value of type `R`.
     Right(R),
 }
+
+/// Types for which any bit pattern is valid.
+///
+/// Not all types are valid for all values. For example, a `bool` must be either zero or one, so
+/// reading arbitrary bytes into something that contains a `bool` is not okay.
+///
+/// It's okay for the type to have padding, as initializing those bytes has no effect.
+///
+/// # Safety
+///
+/// All bit-patterns must be valid for this type. This type must not have interior mutability.
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
+// SAFETY: If all bit patterns are acceptable for individual values in an array, then all bit
+// patterns are also acceptable for arrays of that type.
+unsafe impl<T: FromBytes> FromBytes for [T] {}
+unsafe impl<T: FromBytes, const N: usize> FromBytes for [T; N] {}
+
+/// Types that can be viewed as an immutable slice of initialized bytes.
+///
+/// If a struct implements this trait, then it is okay to copy it byte-for-byte to userspace. This
+/// means that it should not have any padding, as padding bytes are uninitialized. Reading
+/// uninitialized memory is not just undefined behavior, it may even lead to leaking sensitive
+/// information on the stack to userspace.
+///
+/// The struct should also not hold kernel pointers, as kernel pointer addresses are also considered
+/// sensitive. However, leaking kernel pointers is not considered undefined behavior by Rust, so
+/// this is a correctness requirement, but not a safety requirement.
+///
+/// # Safety
+///
+/// Values of this type may not contain any uninitialized bytes. This type must not have interior
+/// mutability.
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
+// SAFETY: If individual values in an array have no uninitialized portions, then the array itself
+// does not have any uninitialized portions either.
+unsafe impl<T: AsBytes> AsBytes for [T] {}
+unsafe impl<T: AsBytes, const N: usize> AsBytes for [T; N] {}
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
index ee5623d7b98f..39481e374c40 100644
--- a/rust/kernel/uaccess.rs
+++ b/rust/kernel/uaccess.rs
@@ -4,10 +4,16 @@
 //!
 //! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
 
-use crate::{alloc::Flags, bindings, error::Result, prelude::*};
+use crate::{
+    alloc::Flags,
+    bindings,
+    error::Result,
+    prelude::*,
+    types::{AsBytes, FromBytes},
+};
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
-use core::mem::MaybeUninit;
+use core::mem::{size_of, MaybeUninit};
 
 /// The type used for userspace addresses.
 pub type UserPtr = usize;
@@ -247,6 +253,41 @@ pub fn read_slice(&mut self, out: &mut [u8]) -> Result {
         self.read_raw(out)
     }
 
+    /// Reads a value of the specified type.
+    ///
+    /// Fails with `EFAULT` if the read happens on a bad address, or if the read goes out of bounds
+    /// of this [`UserSliceReader`].
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
+        // By using the _copy_from_user variant, we skip the check_object_size check that verifies
+        // the kernel pointer. This mirrors the logic on the C side that skips the check when the
+        // length is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_from_user(
+                out.as_mut_ptr().cast::<c_void>(),
+                self.ptr as *const c_void,
+                len_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        // SAFETY: The read above has initialized all bytes in `out`, and since `T` implements
+        // `FromBytes`, any bit-pattern is a valid value for this type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads the entirety of the user slice, appending it to the end of the provided buffer.
     ///
     /// Fails with `EFAULT` if the read happens on a bad address.
@@ -310,4 +351,38 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         self.length -= len;
         Ok(())
     }
+
+    /// Writes the provided Rust value to this userspace pointer.
+    ///
+    /// Fails with `EFAULT` if the write happens on a bad address, or if the write goes out of bounds
+    /// of this [`UserSliceWriter`]. This call may modify the associated userspace slice even if it
+    /// returns an error.
+    pub fn write<T: AsBytes>(&mut self, value: &T) -> Result {
+        let len = size_of::<T>();
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The reference points to a value of type `T`, so it is valid for reading
+        // `size_of::<T>()` bytes.
+        //
+        // By using the _copy_to_user variant, we skip the check_object_size check that verifies the
+        // kernel pointer. This mirrors the logic on the C side that skips the check when the length
+        // is a compile-time constant.
+        let res = unsafe {
+            bindings::_copy_to_user(
+                self.ptr as *mut c_void,
+                (value as *const T).cast::<c_void>(),
+                len_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        self.ptr = self.ptr.wrapping_add(len);
+        self.length -= len;
+        Ok(())
+    }
 }

-- 
2.44.0.683.g7961c838ac-goog


