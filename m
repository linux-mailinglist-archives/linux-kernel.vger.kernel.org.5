Return-Path: <linux-kernel+bounces-98716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A50B877E59
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CE2281038
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC18364BE;
	Mon, 11 Mar 2024 10:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wONdZGhL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF33A1A2
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154047; cv=none; b=fkVduSVK/Rt/e/hLCfu6tixBKJfMjdJHD4EooVpGGIG3JZRSyzB2UjLCfwHffc4kwlhDUOwPWhLBERzmeFVO6HrMejMps2YCnxkOsLru7admTat4lL/FM86CzwnZty6zWZ+AIelvgUs1Og4LViAp7Ip3jPFFfQL2SAr/0/tln3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154047; c=relaxed/simple;
	bh=CE8ogUjSBLipzOUypmZnpupnoyLg1zoMasivxy+Jnk4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NT9J72kCxSLXRTlM15cWSa3IP6oYftPpYyg/WLy4JDj+sirpILY4a6Ic0rYMNKfooUGexBemOWLMsldkS7nB+EjVXtSZN8Or5+VknqU/kcER1bhlMB/J0OuAc0p2+IL6F0zDGw4r9gdIHE2Ngj9gfGZygKok4oJAvYOQQnZRmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wONdZGhL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a04bc559fso42990557b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154044; x=1710758844; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=tJfDIazbJrMGOOKIBUcFFh1leBWm7kChWsW4aYpnkLE=;
        b=wONdZGhL+f0FlyOGBknjLiZ3cyadEs8fUQpqnA0HkX4D2ktXs2BcFTLec5J9YleO9+
         MdHGUqsFDSEnD2o6+O4dyS3UEV7FhGgMQENYSPNtvrbWE3NLJzb1vNmvrqJ/QKjdbTb2
         IFxoDAuGSDzq4Ocaqgepazpc/6ghUcgSr8TrufXrwMbsPfaxsk38u2ZFOt398qDxisVI
         XWBE3HTt+cJnXi3ah0liLbu7E2sRgDbyVIzshNcn+gQtPJ3/TQ25wy/we8hJo2ihXlq/
         VOoJuDzAVJz79C2/QsookY+lSWnJLPRiYPhO+JeZ7drh6BLodO6hS7S03Mt/wcHFWapF
         uneQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154044; x=1710758844;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tJfDIazbJrMGOOKIBUcFFh1leBWm7kChWsW4aYpnkLE=;
        b=CPla3mStxYorshT5xjR3k2qRO5Xes7LGbpIBsMPxr5fkw955t7+VEIE8AFd3z0UkJk
         zPXSFfxv/I88FJXPI76FvUiSDbevGimj8YTICSaQaFA6uW9IAGxH/T97PCJUm0txghAf
         TNshGbopJX+cH8LvcIoLU0UautKegGBdbZO+JPMeFseR4rKO+vFaQmeOdEbqCxKqRsBS
         amVeocTsNA1cTSkAHFXcFzpXlW5CVCrkpVAkBlHunENO/gB0QWemyW5ZHTDqEbx/wTe1
         BQhuKy2YGsKCcrMeNxyvy4i1T9EyKjVO6x8eS5xqgxhw7w9ceenix76pjgy//nTw9SAM
         qr4g==
X-Forwarded-Encrypted: i=1; AJvYcCW0lIlAMPZBDl9xcdL+EdnXuy948n/9nVKF3+1AJBitx8ysygskpAdrJhAvrNOGKP3rTLQ/hA6MXjoAz4TWrS1P2fwDRRk9gWNJqvSd
X-Gm-Message-State: AOJu0YxdDATaGfANMZI4IWre4YXAyxzrz3RIO23JPSJXexuYPMOjrUaP
	i3I7QNWvyfBrd3DZQaAgeeRphrmh5syt/xhe5WXhjO+ETKn9dyfzqwD43hYtvKkAbDo4a0ua+rP
	qfXpviPoRDECfbg==
X-Google-Smtp-Source: AGHT+IHWo2hgJA7I1lNAM1JPrCNFP1QQdhP0LJwepyeKAlj3ZSU3zDEzBuTeLwcWuteFPzrx1jYm/DJnQnRxrBo=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:df4d:0:b0:60a:2982:be4f with SMTP id
 i74-20020a0ddf4d000000b0060a2982be4fmr1097144ywe.10.1710154043825; Mon, 11
 Mar 2024 03:47:23 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:13 +0000
In-Reply-To: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=14937; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=KUEfeRFB2gsk7rV7sWNNsK0aetNlvTWIuKGWTuilxTY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7uEznbz8dzSVFC/Ua7dl1QZWxxfEhJAN6hOKT
 /ZPLc3xO5+JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe7hMwAKCRAEWL7uWMY5
 RtBYD/4ndbs8ieFY1Zgqjuwjac1GlVu8jE5ozgkt8/X+pVx3RCo2KzAVVBcZaUKp090CEbopiT+
 13YgGxnS2ZBt8xQy9fkwpnwypkUZIVFh7mh+djoZ3c1PTAngnYTKU73/6G9MeW3/412odUUNdXJ
 fIQY6ULbDbSJ2HTVXUYX+YAAcyw9LQ1S5b9lezeyb1UwZl4mF6ubS9MYMIA5BYATHzWw5Kp7e6V
 1/rb3ST/RsqEZrN2cMdNT7gmusUwmYqujS75affiPbZPx6fvsN2rcyxv5eRVJILF7G4DXe/ne6t
 ciONZdIFqp71ZH30bKsL9jBNErsDWC0OqYccLCTguZaQpusIO8/Ox+Ka+N4nvy6vWup742gZWmR
 OdTkMa0Cj5wchUYaF0y6hjDZEa/swOYM/QOMNPWAH/ZsR7ZbUJVbPyPqVmjrJ9AK9VuG8PV5yNF
 JOPq0BY2BoAFRE70Fq1fMYufhOfotepxwad8TLiLmQewZ5LDA7tdLIOpbMhReNL9b9l3kfssSX2
 CzmQekoQ3mL0Tjww5kE0AiKyJu0u1HNdo0hSNtXNBO3Qu/pB1xdUBZxxjETS0iBSNERy/shQVPy
 IxYkVpqWNR/EMRQLvd4ESlSx+MNOC9RA4qZ3+wyYpVyDPPNxCcyKbHXGS7K3FpbOH+iTW2OaVhP XrRF3MJCbKvcGDw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-alice-mm-v3-1-cdf7b3a2049c@google.com>
Subject: [PATCH v3 1/4] rust: uaccess: add userspace pointers
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

A pointer to an area in userspace memory, which can be either read-only
or read-write.

All methods on this struct are safe: invalid pointers return `EFAULT`.
Concurrent access, *including data races to/from userspace memory*, is
permitted, because fundamentally another userspace thread/process could
always be modifying memory at the same time (in the same way that
userspace Rust's `std::io` permits data races with the contents of
files on disk). In the presence of a race, the exact byte values
read/written are unspecified but the operation is well-defined.
Kernelspace code should validate its copy of data after completing a
read, and not expect that multiple reads of the same address will return
the same value.

These APIs are designed to make it difficult to accidentally write
TOCTOU bugs. Every time you read from a memory location, the pointer is
advanced by the length so that you cannot use that reader to read the
same memory location twice. Preventing double-fetches avoids TOCTOU
bugs. This is accomplished by taking `self` by value to prevent
obtaining multiple readers on a given `UserSlicePtr`, and the readers
only permitting forward reads. If double-fetching a memory location is
necessary for some reason, then that is done by creating multiple
readers to the same memory location.

Constructing a `UserSlicePtr` performs no checks on the provided
address and length, it can safely be constructed inside a kernel thread
with no current userspace process. Reads and writes wrap the kernel APIs
`copy_from_user` and `copy_to_user`, which check the memory map of the
current process and enforce that the address range is within the user
range (no additional calls to `access_ok` are needed).

This code is based on something that was originally written by Wedson on
the old rust branch. It was modified by Alice by removing the
`IoBufferReader` and `IoBufferWriter` traits, and various other changes.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/helpers.c         |  14 +++
 rust/kernel/lib.rs     |   1 +
 rust/kernel/uaccess.rs | 315 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 330 insertions(+)

diff --git a/rust/helpers.c b/rust/helpers.c
index 70e59efd92bc..312b6fcb49d5 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -38,6 +38,20 @@ __noreturn void rust_helper_BUG(void)
 }
 EXPORT_SYMBOL_GPL(rust_helper_BUG);
 
+unsigned long rust_helper_copy_from_user(void *to, const void __user *from,
+					 unsigned long n)
+{
+	return copy_from_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_from_user);
+
+unsigned long rust_helper_copy_to_user(void __user *to, const void *from,
+				       unsigned long n)
+{
+	return copy_to_user(to, from, n);
+}
+EXPORT_SYMBOL_GPL(rust_helper_copy_to_user);
+
 void rust_helper_mutex_lock(struct mutex *lock)
 {
 	mutex_lock(lock);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index be68d5e567b1..37f84223b83f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -49,6 +49,7 @@
 pub mod task;
 pub mod time;
 pub mod types;
+pub mod uaccess;
 pub mod workqueue;
 
 #[doc(hidden)]
diff --git a/rust/kernel/uaccess.rs b/rust/kernel/uaccess.rs
new file mode 100644
index 000000000000..020f3847683f
--- /dev/null
+++ b/rust/kernel/uaccess.rs
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! User pointers.
+//!
+//! C header: [`include/linux/uaccess.h`](srctree/include/linux/uaccess.h)
+
+use crate::{bindings, error::code::*, error::Result};
+use alloc::vec::Vec;
+use core::ffi::{c_ulong, c_void};
+
+/// A pointer to an area in userspace memory, which can be either read-only or
+/// read-write.
+///
+/// All methods on this struct are safe: attempting to read or write invalid
+/// pointers will return `EFAULT`. Concurrent access, *including data races
+/// to/from userspace memory*, is permitted, because fundamentally another
+/// userspace thread/process could always be modifying memory at the same time
+/// (in the same way that userspace Rust's [`std::io`] permits data races with
+/// the contents of files on disk). In the presence of a race, the exact byte
+/// values read/written are unspecified but the operation is well-defined.
+/// Kernelspace code should validate its copy of data after completing a read,
+/// and not expect that multiple reads of the same address will return the same
+/// value.
+///
+/// These APIs are designed to make it difficult to accidentally write TOCTOU
+/// (time-of-check to time-of-use) bugs. Every time a memory location is read,
+/// the reader's position is advanced by the read length and the next read will
+/// start from there. This helps prevent accidentally reading the same location
+/// twice and causing a TOCTOU bug.
+///
+/// Creating a [`UserSliceReader`] and/or [`UserSliceWriter`] consumes the
+/// `UserSlice`, helping ensure that there aren't multiple readers or writers to
+/// the same location.
+///
+/// If double-fetching a memory location is necessary for some reason, then that
+/// is done by creating multiple readers to the same memory location, e.g. using
+/// [`clone_reader`].
+///
+/// # Examples
+///
+/// Takes a region of userspace memory from the current process, and modify it
+/// by adding one to every byte in the region.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::Result;
+/// use kernel::uaccess::UserSlice;
+///
+/// pub fn bytes_add_one(uptr: *mut c_void, len: usize) -> Result<()> {
+///     let (read, mut write) = UserSlice::new(uptr, len).reader_writer();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     for b in &mut buf {
+///         *b = b.wrapping_add(1);
+///     }
+///
+///     write.write_slice(&buf)?;
+///     Ok(())
+/// }
+/// ```
+///
+/// Example illustrating a TOCTOU (time-of-check to time-of-use) bug.
+///
+/// ```no_run
+/// use alloc::vec::Vec;
+/// use core::ffi::c_void;
+/// use kernel::error::{code::EINVAL, Result};
+/// use kernel::uaccess::UserSlice;
+///
+/// /// Returns whether the data in this region is valid.
+/// fn is_valid(uptr: *mut c_void, len: usize) -> Result<bool> {
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     todo!()
+/// }
+///
+/// /// Returns the bytes behind this user pointer if they are valid.
+/// pub fn get_bytes_if_valid(uptr: *mut c_void, len: usize) -> Result<Vec<u8>> {
+///     if !is_valid(uptr, len)? {
+///         return Err(EINVAL);
+///     }
+///
+///     let read = UserSlice::new(uptr, len).reader();
+///
+///     let mut buf = Vec::new();
+///     read.read_all(&mut buf)?;
+///
+///     // THIS IS A BUG! The bytes could have changed since we checked them.
+///     //
+///     // To avoid this kind of bug, don't call `UserSlice::new` multiple
+///     // times with the same address.
+///     Ok(buf)
+/// }
+/// ```
+///
+/// [`std::io`]: https://doc.rust-lang.org/std/io/index.html
+/// [`clone_reader`]: UserSliceReader::clone_reader
+pub struct UserSlice {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSlice {
+    /// Constructs a user slice from a raw pointer and a length in bytes.
+    ///
+    /// Constructing a [`UserSlice`] performs no checks on the provided address
+    /// and length, it can safely be constructed inside a kernel thread with no
+    /// current userspace process. Reads and writes wrap the kernel APIs
+    /// `copy_from_user` and `copy_to_user`, which check the memory map of the
+    /// current process and enforce that the address range is within the user
+    /// range (no additional calls to `access_ok` are needed).
+    ///
+    /// Callers must be careful to avoid time-of-check-time-of-use
+    /// (TOCTOU) issues. The simplest way is to create a single instance of
+    /// [`UserSlice`] per user memory block as it reads each byte at
+    /// most once.
+    pub fn new(ptr: *mut c_void, length: usize) -> Self {
+        UserSlice { ptr, length }
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the
+    /// provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read_all(self, buf: &mut Vec<u8>) -> Result {
+        self.reader().read_all(buf)
+    }
+
+    /// Constructs a [`UserSliceReader`].
+    pub fn reader(self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs a [`UserSliceWriter`].
+    pub fn writer(self) -> UserSliceWriter {
+        UserSliceWriter {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Constructs both a [`UserSliceReader`] and a [`UserSliceWriter`].
+    ///
+    /// Usually when this is used, you will first read the data, and then
+    /// overwrite it afterwards.
+    pub fn reader_writer(self) -> (UserSliceReader, UserSliceWriter) {
+        (
+            UserSliceReader {
+                ptr: self.ptr,
+                length: self.length,
+            },
+            UserSliceWriter {
+                ptr: self.ptr,
+                length: self.length,
+            },
+        )
+    }
+}
+
+/// A reader for [`UserSlice`].
+///
+/// Used to incrementally read from the user slice.
+pub struct UserSliceReader {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSliceReader {
+    /// Skip the provided number of bytes.
+    ///
+    /// Returns an error if skipping more than the length of the buffer.
+    pub fn skip(&mut self, num_skip: usize) -> Result {
+        // Update `self.length` first since that's the fallible part of this
+        // operation.
+        self.length = self.length.checked_sub(num_skip).ok_or(EFAULT)?;
+        self.ptr = self.ptr.wrapping_byte_add(num_skip);
+        Ok(())
+    }
+
+    /// Create a reader that can access the same range of data.
+    ///
+    /// Reading from the clone does not advance the current reader.
+    ///
+    /// The caller should take care to not introduce TOCTOU issues, as described
+    /// in the documentation for [`UserSlice`].
+    pub fn clone_reader(&self) -> UserSliceReader {
+        UserSliceReader {
+            ptr: self.ptr,
+            length: self.length,
+        }
+    }
+
+    /// Returns the number of bytes left to be read from this reader.
+    ///
+    /// Note that even reading less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no data is available in the io buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
+    }
+
+    /// Reads raw data from the user slice into a raw kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    ///
+    /// # Safety
+    ///
+    /// The `out` pointer must be valid for writing `len` bytes.
+    pub unsafe fn read_raw(&mut self, out: *mut u8, len: usize) -> Result {
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        // SAFETY: The caller promises that `out` is valid for writing `len` bytes.
+        let res = unsafe { bindings::copy_from_user(out.cast::<c_void>(), self.ptr, len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so
+        // we cannot use `add`, which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
+
+    /// Reads the entirety of the user slice, appending it to the end of the
+    /// provided buffer.
+    ///
+    /// Fails with `EFAULT` if the read encounters a page fault.
+    pub fn read_all(mut self, buf: &mut Vec<u8>) -> Result {
+        let len = self.length;
+        buf.try_reserve(len)?;
+
+        // SAFETY: The call to `try_reserve` was successful, so the spare
+        // capacity is at least `len` bytes long.
+        unsafe { self.read_raw(buf.spare_capacity_mut().as_mut_ptr().cast(), len)? };
+
+        // SAFETY: Since the call to `read_raw` was successful, so the next
+        // `len` bytes of the vector have been initialized.
+        unsafe { buf.set_len(buf.len() + len) };
+        Ok(())
+    }
+}
+
+/// A writer for [`UserSlice`].
+///
+/// Used to incrementally write into the user slice.
+pub struct UserSliceWriter {
+    ptr: *mut c_void,
+    length: usize,
+}
+
+impl UserSliceWriter {
+    /// Returns the amount of space remaining in this buffer.
+    ///
+    /// Note that even writing less than this number of bytes may fail.
+    pub fn len(&self) -> usize {
+        self.length
+    }
+
+    /// Returns `true` if no more data can be written to this buffer.
+    pub fn is_empty(&self) -> bool {
+        self.length == 0
+    }
+
+    /// Writes raw data to this user pointer from a raw kernel buffer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    ///
+    /// # Safety
+    ///
+    /// The `data` pointer must be valid for reading `len` bytes.
+    pub unsafe fn write_raw(&mut self, data: *const u8, len: usize) -> Result {
+        if len > self.length {
+            return Err(EFAULT);
+        }
+        let Ok(len_ulong) = c_ulong::try_from(len) else {
+            return Err(EFAULT);
+        };
+        let res = unsafe { bindings::copy_to_user(self.ptr, data.cast::<c_void>(), len_ulong) };
+        if res != 0 {
+            return Err(EFAULT);
+        }
+        // Userspace pointers are not directly dereferencable by the kernel, so
+        // we cannot use `add`, which has C-style rules for defined behavior.
+        self.ptr = self.ptr.wrapping_byte_add(len);
+        self.length -= len;
+        Ok(())
+    }
+
+    /// Writes the provided slice to this user pointer.
+    ///
+    /// Fails with `EFAULT` if the write encounters a page fault.
+    pub fn write_slice(&mut self, data: &[u8]) -> Result {
+        let len = data.len();
+        let ptr = data.as_ptr();
+        // SAFETY: The pointer originates from a reference to a slice of length
+        // `len`, so the pointer is valid for reading `len` bytes.
+        unsafe { self.write_raw(ptr, len) }
+    }
+}

-- 
2.44.0.278.ge034bb2e1d-goog


