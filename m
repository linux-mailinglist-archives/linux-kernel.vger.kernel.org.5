Return-Path: <linux-kernel+bounces-58304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CEF84E44A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 338BF1F281BF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CE637EF19;
	Thu,  8 Feb 2024 15:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AStFejWL"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D567E785
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707407334; cv=none; b=sS46yY7l/olQTMZwRglVLzStYQZcteKUOPpIwoILqFrk8cMePUjCPOxXw4Ll88uEBQMyRTp2uiyUXSFKELwWrN+YTTFpQP7B5xnl3FSLQkNN6i41XLAmbmFOTgEe/rQLtkFTumtYVBTtHtuKCMMJ7zwiX6SCNmhqm2kt16GD1Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707407334; c=relaxed/simple;
	bh=5kbsE/b/eSnVbSFqPFnEYkacZIQs8b+yemi8lEykeZw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KyBkllgd3PtNJw2yFhIwYCvCqs1B49+l52FriuUOtElbcPd1mUC+hxJV7BU6QlwjkqAYjQojcBEW85pAtQ7ZMs1FvA8ThfGAAfqOjmlYt6uQGKCTp1R7UGaxYWlczsvpqNGd1Dow6weorwUTVSqf7HhKd2m4cmFqaEzeIcbLgC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AStFejWL; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-604186a5775so11297107b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:48:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707407331; x=1708012131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GkurjLr2KJ06Z3QEBJTajcXp1Fe9o6FdUY3dEd+eNLc=;
        b=AStFejWLzvEXTdeiBhDnZtIhwDlzknZVEJJGyGyZGPB6NzhlyJC856QTOZixH2Y1Fg
         8HeWd54u5agJzvKUE3cQJfcOv6kGwMxibT/2M0ThGQE0Ykb/E0sih1IKVL4BaGhx+mtM
         B1fKCjhL0ig7S4R+cfroy1qT/yrAkHctiDXo3rNdPdUvHRaVJrreV7z9ezQBB2fKoorl
         yPNRCef5cTmOwxY2XEIPYd0eZ8XNTbSuU/cz2ql3hAyxiK8mXkDlR+4RcnM/yaMRK6xi
         D3FJYapVsvTGDeiStwG226TZHUEMlzkakPxP2aNT5RTw9uzFbnqTHGxrAZzvpVXaDesL
         EMZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707407331; x=1708012131;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkurjLr2KJ06Z3QEBJTajcXp1Fe9o6FdUY3dEd+eNLc=;
        b=euFjBMqAYqLZYOvzEsV0amS6RmQZ9e5AaDMeVjLNw+RZo+WhQDejUnsXShQUw8hcCd
         maEs7KdI+G4HhF7LV0GfbofHCfGq2vIsqc0po9gkW5fPRVXOxQNplJY0l7CSxkrwl51p
         9AMv7yoysel7yYXTqmMkcuji6KxUJtPnOSl6C2WBU7PnXcKbyV+J2C1nMRkX0gNDyS+G
         NTPoLY3G4cSosqV/ugInqgV6rhNN2DgXjvW6fmV3HHOxGtsCwD78pF1uAse4PNlh0iwS
         MijYswyp7QXD3LY0I5m6R3xp6PkOw7OYury5g5LbTw8vT+NUl2GezuUu3hAGAf15T+JS
         Gdpw==
X-Forwarded-Encrypted: i=1; AJvYcCXX6EJJqvrOfTWdR+i3dc6GcGL5kEc0NykKYuXYj6UYk5Z03Svf6eLZs6JbIREedvVfOskJz4slsJW+TPp++oCnyo5CH/soKDIqkUU5
X-Gm-Message-State: AOJu0YzUQ4ovaPQrXjZJIQ80NhtmhVV8hvAvX8+zqXrwJ1KlwpSmgrs5
	pxAe/GVfGd42vX1jIuJuNsW9phQj06KrWbm/GJuKjI4tQRXjsNOulRBSvpXNCZa/Eq66MChIPSt
	GtDzjtq34raVCwg==
X-Google-Smtp-Source: AGHT+IHZ8Dbrlx4mYSSqSheMjR9uVubqsUmkFF4PLNwGiatZwaa03r5iM1Rw5TJUkiKh9weUpG7CJqzo/gNibUU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:100b:b0:dc6:e884:2342 with SMTP
 id w11-20020a056902100b00b00dc6e8842342mr764942ybt.5.1707407331450; Thu, 08
 Feb 2024 07:48:51 -0800 (PST)
Date: Thu, 08 Feb 2024 15:47:54 +0000
In-Reply-To: <20240208-alice-mm-v2-0-d821250204a6@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240208-alice-mm-v2-0-d821250204a6@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=12755; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=5kbsE/b/eSnVbSFqPFnEYkacZIQs8b+yemi8lEykeZw=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlxPfU67tCAf96rUhr77wodzJbxjoBZvA+pKp54
 TdgXCe6UwyJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZcT31AAKCRAEWL7uWMY5
 RgZ3EACMa2s3PKNHIdyO26oX3t0dPYuDrEmv0G8WCEpnJsXaaYMUb7IEmcf8cM74d1xUs/tQWRI
 GDHB+GiwnDcEIkB+itkR2/WdykfPSUwtijCjJ7IVuaeYKTXe5y4S4bzUslEOUwxJGScFo+CpHBM
 XcLgq9ilImTzGR29npE+iqbTwErklrUA9JOn7yvI2l7Qq8zJ5wZ+8NGwHKYLfegy5lIvsajIqnL
 J1claGaD8NF+HlnSg+/Vw6rIndTyvNaOnI5eVGgPgOfpzi3tmer0/gopsjWSpLYksDsrwM5DgOd
 KZFb6ob+vBpSlbr0Wg5NEl9s+TLBj8mJlgAt5wFUg08GbKIy+oFsvAZwNGSuglAHu7FEN22u2uv
 ZWsSLCee6/Zvh8jHTh6KZHJLsCajnYSnc5BRW/iSkuH7dp5hF8ooBca9PoZVFW4Lnvy9DX++95h
 IH4z1nWm/dIqVGhZf3semETumlANLlHPnp/Eos2URF0jnhtI6ct4VH3kCZ82FeH9Ia320wfSKd5
 kNxx0BMOURevsseZTCpziAeiiSYh19gQFlT/JvkDsVR/mTzIEegLfpMdYvfipw+DuCseg86j3bM
 cBhoKYkgeqatoOGFECGxHZcXOKZDrefX5jylDTCJd844FstI3U8aCbLGToKO03HpbkiuSCTMROc qU/XnZ0uYKaEJng==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240208-alice-mm-v2-4-d821250204a6@google.com>
Subject: [PATCH v2 4/4] rust: add abstraction for `struct page`
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
support for higher-order pages, and by introducing the `with_*` helpers
to consolidate the bounds checking logic into a single place.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  20 ++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 209 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 936651110c39..b5b7fa7bd456 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -22,3 +22,4 @@
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
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
index 5a03aafcbb69..59ee6dd6f7c6 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -40,6 +40,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..ac253744f94b
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,209 @@
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
+pub const PAGE_SIZE: usize = 1 << PAGE_SHIFT;
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
+    pub fn new() -> Result<Self, AllocError> {
+        // SAFETY: These are the correct arguments to allocate a single page.
+        let page = unsafe {
+            bindings::alloc_pages(
+                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::__GFP_HIGHMEM,
+                0,
+            )
+        };
+
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
+            unsafe { ptr::copy(src, dst, len) };
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
+            unsafe { ptr::copy(src, dst, len) };
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
2.43.0.594.gd9cf4e227d-goog


