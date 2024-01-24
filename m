Return-Path: <linux-kernel+bounces-36848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7A6B83A7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 12:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87F17280FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E027547F4C;
	Wed, 24 Jan 2024 11:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="31S5Peun"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6A2C68F
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706095255; cv=none; b=KORzFfFGrh/U4lq18N+ygr+UzfGYKDOxAG16xsFFbnTdyT3MFZwSkWAhL0U49l/3v3/7vzkB3atp8lnzGQMenW9/WsbY3uuzHTwNOomtDaJWH6JiSrbha7ypBz4eH4LwhIOeEFY9KitHfzJ3vfRENYLEU6/plPb6WVRVOrLV3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706095255; c=relaxed/simple;
	bh=vymGv46wM2XordLIDJAiR3VCTZsi5VESqwv8kajL3uk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=og4hZtizjH9W/X8R1UnVrI2tIAwsE3Hg/9D8KqyWjtTDV1rPdDJfzZIHMN3DZNbnXZCiQFSlZLNcTvuQt/DlMNfXVBLp+O+Z/YuOztxNVGGERr1X7P4FPLP3OCUmbqJKHnL022t2VfmNHo6jLsIUiaQPbVKKU6IBgWa4fnLpqgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=31S5Peun; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5f53b4554b6so79549037b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706095251; x=1706700051; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yeYmyXZKazzZuN2hgbJgkgGVYq/XVAwngt0nzNHk5M8=;
        b=31S5PeunZtViVv/ShmkJLqdNi1RkaTIFn8O6t6XUWADrdUHQ1M3u3uAyfrz8KWety6
         WmNP/Lm9pQ7M9Ml5Qrs71BrOCqp38bDHvg53TGILL9s/99YmykkaKNAMII9JWehOxuFa
         m+UhAjXI1CZkGkanJIv0VjuIKKVHBLHLL5h1FgZc0K2oRKk/M8GnCnzDP0NgpZhH8Hsk
         pxxWP6eAYIbyLykTmR+6uZ/3thIHEstMPqO1H1jhpD1w3AdCK30kHQJJClw9ETrvkAtu
         3LHOAs7PUZMN9ENvbmaNT79zcgWRXI2voR+yZ16ur97SwP+31DWtLUyAegv8kQ6n2bhw
         TXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706095251; x=1706700051;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeYmyXZKazzZuN2hgbJgkgGVYq/XVAwngt0nzNHk5M8=;
        b=hBETjGpCwONM6D/Rv/u5RHcQ3PaqXO4qk+o2WHq1heRO7vvlzqYacbJTUqa5FOTcO5
         aXUX8uWpy4P/IEG3mGLvULyb/MFyOb5ZhpnD+LombK/7FDZCIY6mUoG+7p9KejMndChV
         9TwTDAJ6do1wytIVXKy9lkeNbjAgzPsNclFwhgv/1RA/Xf2FdozlXpkZvAUtzVN/qUTh
         iR4AhtK+19c71/Fiu1GDy8Y9UZz30hkpAPbznPp0o87rpJaRcN5xCaLu8KzZ26NDP1KB
         tdh1lq437kOJMZrb4eECaZgb6Ehk4XuKtlUf4bpkV0d5tLosARJX7+NTtOL+TZU9BF+P
         Yppw==
X-Gm-Message-State: AOJu0YyE3EXMIUhwjaoCfjmgHfupub1pQF5CXFo514bbps/vR9NZgC0Y
	1F+tGixexkyFh73nehpGalFGIRE9d7k6Z11ek2XwokKyR9BZB+3CVE2+x30PesgjI2c65yCKauU
	Jk3O9IXwnY6gAjA==
X-Google-Smtp-Source: AGHT+IGjH/Ff2xSwSbT5vioutXPHVy7bJJQ3zau2ipxnPdyw1mlt022gceufBKa+5P6ckJhvnWfDj7xA0hX24cM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a81:4ec3:0:b0:5ff:5135:ffcf with SMTP id
 c186-20020a814ec3000000b005ff5135ffcfmr211243ywb.4.1706095251533; Wed, 24 Jan
 2024 03:20:51 -0800 (PST)
Date: Wed, 24 Jan 2024 11:20:22 +0000
In-Reply-To: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240124-alice-mm-v1-0-d1abcec83c44@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=9645; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=vymGv46wM2XordLIDJAiR3VCTZsi5VESqwv8kajL3uk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlsPKJ3p0VhgMk8AKpCRyFubtzOao8ccYGTzkG+
 +NZ+y3/eiCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbDyiQAKCRAEWL7uWMY5
 RokAD/0TXFTgaEHIwdd+VZdCdJ3hpjT/gV/L0H4iqM+pzhwCg2FAbC2zAQUnoY5eSMPfazzRrkR
 b7I/ZDPT0xZAd2e+TLeiKEJSenYcP0bpVFnQjP1H8QJV1Y53i7lXVV/q8dpAXQ6fbbZvB98Pv06
 Bky6MCWbbb8kgmCH14Jv5Vgxa3P83UrVdNlNE7XQu6dgORciRLcuuLi819gqMmRrVAUs1WMceGx
 t38dHV0F9KRYj2YIEebTN8BNvR+fxrT7RNu3SC6TAjA2p+V0TT4fl7thO2VlttP+UStglznTOL+
 jkjEwOGg3VN9XVEPGbnODkUE6L+Pzhgb469AoYErW9epYGP6Com15uAiEsOA9IUmx82YYAopg8N
 jbVf/P67GLvzss8LprRUNrVQy4veFRwaZhoxrpJ3q7c2QIuDOfVgIXd59tJ+0+pV2KOIyL8F1Is
 MYjacF8CeI1cKXEUEx0SigY3tSQogrXTPRTb0XFs0yiviDd/mFnWSxCgzobtlYKJNTTcO50saJp
 0uWo2Ni9PiyzXnZacb/bkx/GS1bE1V44v3tTlxbDTa2Djy2Cz6/TUEm2ntReBxDgepV4K/XgJnq
 2yu18Jm11EpkRMTkio2ISHW42srkLhYsD9yZRMARFPWHqrjuZVamQIWBYq/rhZDz0wL8t5qOVb9 hSf4DHbGeXA8Tfw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240124-alice-mm-v1-2-d1abcec83c44@google.com>
Subject: [PATCH 2/3] rust: add typed accessors for userspace pointers
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
 rust/helpers.c          |  34 +++++++++++++
 rust/kernel/user_ptr.rs | 125 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 159 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 312b6fcb49d5..187f445fbf19 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -52,6 +52,40 @@ unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
 }
 EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
 
+/*
+ * These methods skip the `check_object_size` check that `copy_[to|from]_user`
+ * normally performs. In C, these checks are skipped whenever the length is a
+ * compile-time constant, since when that is the case, the kernel pointer
+ * usually points at a local variable that is being initialized and the kernel
+ * pointer is trivially non-dangling.
+ *
+ * These helpers serve the same purpose in Rust. Whenever the length is known at
+ * compile-time, we call this helper to skip the check.
+ */
+unsigned long rust_helper_copy_from_user_unsafe_skip_check_object_size(void *to, const void __user *from, unsigned long n)
+{
+	unsigned long res;
+
+	might_fault();
+	instrument_copy_from_user_before(to, from, n);
+	if (should_fail_usercopy())
+		return n;
+	res = raw_copy_from_user(to, from, n);
+	instrument_copy_from_user_after(to, from, n, res);
+	return res;
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_from_user_unsafe_skip_check_object_size);
+
+unsigned long rust_helper_copy_to_user_unsafe_skip_check_object_size(void __user *to, const void *from, unsigned long n)
+{
+	might_fault();
+	if (should_fail_usercopy())
+		return n;
+	instrument_copy_to_user(to, from, n);
+	return raw_copy_to_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_to_user_unsafe_skip_check_object_size);
+
 void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
diff --git a/rust/kernel/user_ptr.rs b/rust/kernel/user_ptr.rs
index 00aa26aa6a83..daa46abe5525 100644
--- a/rust/kernel/user_ptr.rs
+++ b/rust/kernel/user_ptr.rs
@@ -11,6 +11,7 @@
 use crate::{bindings, error::code::*, error::Result};
 use alloc::vec::Vec;
 use core::ffi::{c_ulong, c_void};
+use core::mem::{size_of, MaybeUninit};
 
 /// The maximum length of a operation using `copy_[from|to]_user`.
 ///
@@ -151,6 +152,36 @@ pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
         Ok(())
     }
 
+    /// Reads a value of the specified type.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read<T: ReadableFromBytes>(&mut self) -> Result<T> {
+        if size_of::<T>() > self.1 || size_of::<T>() > MAX_USER_OP_LEN {
+            return Err(EFAULT);
+        }
+        let mut out: MaybeUninit<T> = MaybeUninit::uninit();
+        // SAFETY: The local variable `out` is valid for writing `size_of::<T>()` bytes.
+        let res = unsafe {
+            bindings::copy_from_user_unsafe_skip_check_object_size(
+                out.as_mut_ptr().cast::<c_void>(),
+                self.0,
+                size_of::<T>() as c_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(size_of::<T>());
+        self.1 -= size_of::<T>();
+        // SAFETY: The read above has initialized all bytes in `out`, and since
+        // `T` implements `ReadableFromBytes`, any bit-pattern is a valid value
+        // for this type.
+        Ok(unsafe { out.assume_init() })
+    }
+
     /// Reads all remaining data in the buffer into a vector.
     ///
     /// Fails with `EFAULT` if the read encounters a page fault.
@@ -219,4 +250,98 @@ pub fn write_slice(&mut self, data: &[u8]) -> Result {
         // `len`, so the pointer is valid for reading `len` bytes.
         unsafe { self.write_raw(ptr, len) }
     }
+
+    /// Writes the provided Rust value to this userspace pointer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    pub fn write<T: WritableToBytes>(&mut self, value: &T) -> Result {
+        if size_of::<T>() > self.1 || size_of::<T>() > MAX_USER_OP_LEN {
+            return Err(EFAULT);
+        }
+        // SAFETY: The reference points to a value of type `T`, so it is valid
+        // for reading `size_of::<T>()` bytes.
+        let res = unsafe {
+            bindings::copy_to_user_unsafe_skip_check_object_size(
+                self.0,
+                (value as *const T).cast::<c_void>(),
+                size_of::<T>() as c_ulong,
+            )
+        };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Since this is not a pointer to a valid object in our program,
+        // we cannot use `add`, which has C-style rules for defined
+        // behavior.
+        self.0 = self.0.wrapping_add(size_of::<T>());
+        self.1 -= size_of::<T>();
+        Ok(())
+    }
 }
+
+/// Specifies that a type is safely readable from bytes.
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
+pub unsafe trait ReadableFromBytes {}
+
+// SAFETY: All bit patterns are acceptable values of the types below.
+unsafe impl ReadableFromBytes for u8 {}
+unsafe impl ReadableFromBytes for u16 {}
+unsafe impl ReadableFromBytes for u32 {}
+unsafe impl ReadableFromBytes for u64 {}
+unsafe impl ReadableFromBytes for usize {}
+unsafe impl ReadableFromBytes for i8 {}
+unsafe impl ReadableFromBytes for i16 {}
+unsafe impl ReadableFromBytes for i32 {}
+unsafe impl ReadableFromBytes for i64 {}
+unsafe impl ReadableFromBytes for isize {}
+// SAFETY: If all bit patterns are acceptable for individual values in an array,
+// then all bit patterns are also acceptable for arrays of that type.
+unsafe impl<T: ReadableFromBytes> ReadableFromBytes for [T] {}
+unsafe impl<T: ReadableFromBytes, const N: usize> ReadableFromBytes for [T; N] {}
+
+/// Specifies that a type is safely writable to bytes.
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
+pub unsafe trait WritableToBytes {}
+
+// SAFETY: Instances of the following types have no uninitialized portions.
+unsafe impl WritableToBytes for u8 {}
+unsafe impl WritableToBytes for u16 {}
+unsafe impl WritableToBytes for u32 {}
+unsafe impl WritableToBytes for u64 {}
+unsafe impl WritableToBytes for usize {}
+unsafe impl WritableToBytes for i8 {}
+unsafe impl WritableToBytes for i16 {}
+unsafe impl WritableToBytes for i32 {}
+unsafe impl WritableToBytes for i64 {}
+unsafe impl WritableToBytes for isize {}
+unsafe impl WritableToBytes for bool {}
+unsafe impl WritableToBytes for char {}
+unsafe impl WritableToBytes for str {}
+// SAFETY: If individual values in an array have no uninitialized portions, then
+// the the array itself does not have any uninitialized portions either.
+unsafe impl<T: WritableToBytes> WritableToBytes for [T] {}
+unsafe impl<T: WritableToBytes, const N: usize> WritableToBytes for [T; N] {}

-- 
2.43.0.429.g432eaa2c6b-goog


