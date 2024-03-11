Return-Path: <linux-kernel+bounces-98719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F1E877E5C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2F59B21806
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4370438DDB;
	Mon, 11 Mar 2024 10:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oGQ02Zvr"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC983C47B
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 10:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710154057; cv=none; b=PlxaB70Nhtg0JPJ3YPOQqFSGx5v0O226u0OQWebHHS9lu1kU5IihQBhbPFX8eZxSusVUhNOQkpGaBRuAlIZgB9qeZ59BrW4N5gcK+1VpXh5kp7PPZhv90tFWISS73NyfUiNb/5AkuE7pocEW0vdBmxx8/tAVAPqYTfi/Nvxikew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710154057; c=relaxed/simple;
	bh=RqqYo8Xwakoq53YPU2GZeGJPFs6BA+Ric3Um8ZRej8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ea2W4W8X0dFhqWOB4Gr+8XIRZCDbi370qMKJi4B+D5likCyluECJ2+i02E1t5AY13TXkwUrXCxcuiX4gMRKMcUCa6M/zLQD94JtDHOKJthK8WKjvitl8Dz8o26j4nm6fojl8QEbICE7tVykXtSzscO5/p17IoMAC5C/uR+yjH+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oGQ02Zvr; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcf22e5b70bso5036879276.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 03:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710154053; x=1710758853; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a3rgQ6OTM36YDirL+P3CRmpv1dVQxJgazAx/ZBhtsKE=;
        b=oGQ02ZvrfEECNYhgUBFXF3ktYQ0+KgW1Kf9Ry32dBALuRr4+o02QGdrsV9gHoeYYmQ
         MwPt48GGxRN49GXeWDMvVLIEVWelifYo1zkfsAXC2RlNVXtZ3CCuETmTSTWwOmhQxU7k
         7Hne8j1T+ASutLF9qS9xmEdkKKEFVucE4FQVhZryCCqumM5HHJeiI3Vsbk74mMXIeUFq
         L4aVb4PQKpNcgbfejghjdzX1+onrRa14u9cpcUy52ICwXs2j05BvIt7Cc9dC+AYLR3Nr
         +wdX9bgNEm/NKTknUONl5R16heXaIpQXufBEla3UIwfANqNNAvleLeOoNzJGbrO9GaDZ
         muXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710154053; x=1710758853;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a3rgQ6OTM36YDirL+P3CRmpv1dVQxJgazAx/ZBhtsKE=;
        b=jx5N9firLjTf7fPpPS6FVHkrnxDqFZEwplo+jzLIUSmkafwJKXW6WCoj1GMuUpsupU
         5PSNv5z7kGwM7QYJnck6MfKrYuu+jLUDsGkuHveY/csU61E/Rnmeqmrq6OOZyFjGfRf4
         hmNfOZ8E8rrisNZSTD7kdDRwOiy5c/BtjjhwpRhK9E0UUarMQaQRjrmzsC+8jwlIEcQP
         Pda7eG1WOLr+1twSW7CLq2fM1hPdOyWF4366KK6CoiUgG8ZHRTuoWKaFPv8iA3517dbh
         5TKu+k7Eu7PK+4ykbYU62iYlwkTPuV4VLoGBiS/JGYqTwY2cXGa+ySGrmUmM+a3iteRO
         BeuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfaNNguBBWuGwadN+6LdHeHyjz3ufP3VC4PJv+kxMi+TSpXpz+QeHJCvk8CkBrtWUf17qJaSuZi5zfgE04CyjLWL6hW8YfItKXL6Rj
X-Gm-Message-State: AOJu0YwS1LOP/eQeKIuV6rU+O09eFNDAd4ES9a+EkFiuG9YNJqzQasvE
	Ri6aTbJNemHJWpXwUcqUuthqs2Tj7pu26dOmFAV/M+a3vxT9yIL3PGz0IjFNWIzyqAKeevLPKhW
	owBqSoiSUahHGdw==
X-Google-Smtp-Source: AGHT+IGGexGpdfDtIhCShg6eUatPr5rS/mCdR8LuVUYXldx2rgtDy1e66KzQBWuleQC3NjqJS6NJkv3lPfTQxck=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:f07:b0:dcf:f526:4cc6 with SMTP
 id et7-20020a0569020f0700b00dcff5264cc6mr328765ybb.11.1710154053262; Mon, 11
 Mar 2024 03:47:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 10:47:16 +0000
In-Reply-To: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-alice-mm-v3-0-cdf7b3a2049c@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=13889; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=RqqYo8Xwakoq53YPU2GZeGJPFs6BA+Ric3Um8ZRej8k=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7uE1v/lyWXqmRMi7zcm+0EN/VPFicekl+mqlB
 zgG2I528fGJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe7hNQAKCRAEWL7uWMY5
 RjuXD/4j6zTA/pUDR4mY4dMVnQrE7UQxfslBQujKYedFfxV8P8MB4VT9nBQlzTye8G1GF5oVQPo
 mhnmtK25dHQp4INUApVFhKLZTRJOsOSrAG396vsukMIL63SixlKwkJhCRPnGeC25zqvCMKoPQF8
 mJyjNnhA9Kexqv4l9RI6yD/yDX5EdWW7g1ireNoQdDGh8ZZK7QodL9MG9klwn9isq39jHwbdz0n
 3QwUqC/HpK+HY2g5R91mGWFrlwXxC9ha2sY3hY20P+PFUJqU3gb+Tdzp0koLxvBRSwHbxwqrvF6
 rHhKY9aJPd4PwBl87M3ptnxQZX+iO+ypaQRUch7fAqlt3QkPuEscr4k6skSY8czT2IODfTdjA1w
 7TIzzy87ruidKT9XIdMrzfJPzn+TFh7lhjzLWVF+LOEMes8tregbk4w1WJNH/bteXWMuvDJj9Hf
 7cLL2ldlFuhR43ikqEYjOCd/VcUaq/HfyvrcJ0dZawgUl/ka0OQwmiXk2T3r6TNOm6ypquziQ8K
 5zCrp/TC2oPurX03F6u/QqPNN/XK7F85opPnTA39ZZ0SUQlmC+3dmEwdcLZdfwawxW0wcfbluDT
 vE+XzWzGfiRCV//XocT3nuXQfZ6V7vQj6uea45c/qr9aLqbYmIU4aQBTfO0JSSUCo4KHiRcAbm4 WD4Go7lIqtG9USw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-alice-mm-v3-4-cdf7b3a2049c@google.com>
Subject: [PATCH v3 4/4] rust: add abstraction for `struct page`
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

Adds a new struct called `Page` that wraps a pointer to `struct page`.
This struct is assumed to hold ownership over the page, so that Rust
code can allocate and manage pages directly.

The page type has various methods for reading and writing into the page.
These methods will temporarily map the page to allow the operation. All
of these methods use a helper that takes an offset and length, performs
bounds checks, and returns a pointer to the given offset in the page.

This patch only adds support for pages of order zero, as that is all
Rust Binder needs. However, it is written to make it easy to add support
for higher-order pages in the future. To do that, you would add a const
generic parameter to `Page` that specifies the order. Most of the
methods do not need to be adjusted, as the logic for dealing with
mapping multiple pages at once can be isolated to just the
`with_pointer_into_page` method. Finally, the struct can be renamed to
`Pages<ORDER>`, and the type alias `Page = Pages<0>` can be introduced.

Rust Binder needs to manage pages directly as that is how transactions
are delivered: Each process has an mmap'd region for incoming
transactions. When an incoming transaction arrives, the Binder driver
will choose a region in the mmap, allocate and map the relevant pages
manually, and copy the incoming transaction directly into the page. This
architecture allows the driver to copy transactions directly from the
address space of one process to another, without an intermediate copy
to a kernel buffer.

This code is based on Wedson's page abstractions from the old rust
branch, but it has been modified by Alice by removing the incomplete
support for higher-order pages, by introducing the `with_*` helpers
to consolidate the bounds checking logic into a single place, and by
introducing gfp flags.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/helpers.c                  |  20 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 223 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 247 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..1073005ca449 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,5 +20,8 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
+const size_t RUST_CONST_HELPER_PAGE_MASK = PAGE_MASK;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
+const gfp_t RUST_CONST_HELPER___GFP_HIGHMEM = ___GFP_HIGHMEM;
diff --git a/rust/helpers.c b/rust/helpers.c
index 312b6fcb49d5..298d2ee16e61 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -25,6 +25,8 @@
 #include <linux/build_bug.h>
 #include <linux/err.h>
 #include <linux/errname.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
 #include <linux/sched/signal.h>
@@ -93,6 +95,24 @@ int rust_helper_signal_pending(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
 
+struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
+{
+       return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap_local_page(struct page *page)
+{
+       return kmap_local_page(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
+
+void rust_helper_kunmap_local(const void *addr)
+{
+       kunmap_local(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 37f84223b83f..667fc67fa24f 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -39,6 +39,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..02d25b142fc8
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+
+use crate::{bindings, error::code::*, error::Result, uaccess::UserSliceReader};
+use core::{
+    alloc::AllocError,
+    ptr::{self, NonNull},
+};
+
+/// A bitwise shift for the page size.
+pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
+/// The number of bytes in a page.
+pub const PAGE_SIZE: usize = bindings::PAGE_SIZE as usize;
+/// A bitmask that can be used to get the page containing a given address by masking away the lower
+/// bits.
+pub const PAGE_MASK: usize = bindings::PAGE_MASK as usize;
+
+/// Flags for the "get free page" function that underlies all memory allocations.
+pub mod flags {
+    pub type gfp_t = bindings::gfp_t;
+
+    /// `GFP_KERNEL` is typical for kernel-internal allocations. The caller requires `ZONE_NORMAL`
+    /// or a lower zone for direct access but can direct reclaim.
+    pub const GFP_KERNEL: gfp_t = bindings::GFP_KERNEL;
+    /// `GFP_ZERO` returns a zeroed page on success.
+    pub const __GFP_ZERO: gfp_t = bindings::__GFP_ZERO;
+    /// `GFP_HIGHMEM` indicates that the allocated memory may be located in high memory.
+    pub const __GFP_HIGHMEM: gfp_t = bindings::__GFP_HIGHMEM;
+}
+
+/// A pointer to a page that owns the page allocation.
+///
+/// # Invariants
+///
+/// The pointer points at a page, and has ownership over the page.
+pub struct Page {
+    page: NonNull<bindings::page>,
+}
+
+// SAFETY: It is safe to transfer page allocations between threads.
+unsafe impl Send for Page {}
+
+// SAFETY: As long as the safety requirements for `&self` methods on this type
+// are followed, there is no problem with calling them in parallel.
+unsafe impl Sync for Page {}
+
+impl Page {
+    /// Allocates a new page.
+    pub fn alloc_page(gfp_flags: flags::gfp_t) -> Result<Self, AllocError> {
+        // SAFETY: The specified order is zero and we want one page.
+        let page = unsafe { bindings::alloc_pages(gfp_flags, 0) };
+        let page = NonNull::new(page).ok_or(AllocError)?;
+        // INVARIANT: We checked that the allocation succeeded.
+        Ok(Self { page })
+    }
+
+    /// Returns a raw pointer to the page.
+    pub fn as_ptr(&self) -> *mut bindings::page {
+        self.page.as_ptr()
+    }
+
+    /// Runs a piece of code with this page mapped to an address.
+    ///
+    /// The page is unmapped when this call returns.
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly.
+    pub fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
+        // SAFETY: `page` is valid due to the type invariants on `Page`.
+        let mapped_addr = unsafe { bindings::kmap_local_page(self.as_ptr()) };
+
+        let res = f(mapped_addr.cast());
+
+        // SAFETY: This unmaps the page mapped above.
+        //
+        // Since this API takes the user code as a closure, it can only be used
+        // in a manner where the pages are unmapped in reverse order. This is as
+        // required by `kunmap_local`.
+        //
+        // In other words, if this call to `kunmap_local` happens when a
+        // different page should be unmapped first, then there must necessarily
+        // be a call to `kmap_local_page` other than the call just above in
+        // `with_page_mapped` that made that possible. In this case, it is the
+        // unsafe block that wraps that other call that is incorrect.
+        unsafe { bindings::kunmap_local(mapped_addr) };
+
+        res
+    }
+
+    /// Runs a piece of code with a raw pointer to a slice of this page, with
+    /// bounds checking.
+    ///
+    /// If `f` is called, then it will be called with a pointer that points at
+    /// `off` bytes into the page, and the pointer will be valid for at least
+    /// `len` bytes. The pointer is only valid on this task, as this method uses
+    /// a local mapping.
+    ///
+    /// If `off` and `len` refers to a region outside of this page, then this
+    /// method returns `EINVAL` and does not call `f`.
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly.
+    pub fn with_pointer_into_page<T>(
+        &self,
+        off: usize,
+        len: usize,
+        f: impl FnOnce(*mut u8) -> Result<T>,
+    ) -> Result<T> {
+        let bounds_ok = off <= PAGE_SIZE && len <= PAGE_SIZE && (off + len) <= PAGE_SIZE;
+
+        if bounds_ok {
+            self.with_page_mapped(move |page_addr| {
+                // SAFETY: The `off` integer is at most `PAGE_SIZE`, so this pointer offset will
+                // result in a pointer that is in bounds or one off the end of the page.
+                f(unsafe { page_addr.add(off) })
+            })
+        } else {
+            Err(EINVAL)
+        }
+    }
+
+    /// Maps the page and reads from it into the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset ..
+    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
+    /// * Callers must ensure that this call does not race with a write to the
+    ///   same page that overlaps with this read.
+    pub unsafe fn read_raw(&self, dst: *mut u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |src| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `src` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and writes into it from the given buffer.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset ..
+    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `src` is valid for reading `len` bytes.
+    /// * Callers must ensure that this call does not race with a read or write
+    ///   to the same page that overlaps with this write.
+    pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `dst` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and zeroes the given slice.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset ..
+    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to
+    /// the same page that overlaps with this write.
+    pub unsafe fn fill_zero(&self, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `dst` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::write_bytes(dst, 0u8, len) };
+            Ok(())
+        })
+    }
+
+    /// Copies data from userspace into this page.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset ..
+    /// offset+len` goes outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// Like the other `UserSliceReader` methods, data races are allowed on the
+    /// userspace address. However, they are not allowed on the page you are
+    /// copying into.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to
+    /// the same page that overlaps with this write.
+    pub unsafe fn copy_from_user_slice(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then
+            // it has performed a bounds check and guarantees that `dst` is
+            // valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race when writing
+            // to `dst`.
+            unsafe { reader.read_raw(dst, len) }
+        })
+    }
+}
+
+impl Drop for Page {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we have ownership of the page and can
+        // free it.
+        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+    }
+}

-- 
2.44.0.278.ge034bb2e1d-goog


