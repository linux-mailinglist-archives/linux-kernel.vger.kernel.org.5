Return-Path: <linux-kernel+bounces-149766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0038A958C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4029C28290F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6C115D5D2;
	Thu, 18 Apr 2024 08:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jT4ig7/S"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5604715CD5A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430786; cv=none; b=npP59DWFBcv7SOiS4iAjOnipAoSwIkOLx4oho8v57DTCz1vKX8vX5cw4uZwfKny1uYmrjSSQE+8a8aqOM1hcwmFLXyPhipAq7ivcSw3uSuJW88ZqIEFyRMhhJrZVUGR9AXv9AAb2ozv4jKoYAw9KInNRaFSDIb2LMpa8nr5SvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430786; c=relaxed/simple;
	bh=af0xmkxz5WwJ2caWqC4SIR0mhucvRiEoxb05tr7yw14=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nNE/w+l3ecxrIouwzWnkzYP0+xgLTTKDw3VLkdZNUZ6DppNZPYQqTdsojqUPE6cOy+JlygRTzqT7PHMCeM+zQspqsaxhzXiFK0qjz4mgLQLaCmNEAoIx/pbPgoyHSMacb5DIUa7irD5WA9bHfImzIrQoQsXqNef6fwspaYK83r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jT4ig7/S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so939045276.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713430782; x=1714035582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2i7cIGrycSQYWPlCCdINwh9/UQnjF+IIqZAJpSGmhgU=;
        b=jT4ig7/SBcQGwiG/AHNFpUNlEaYF5aOmPfi7nYObQfHk5EEs2t+jZ0r3DJLUY80cXr
         iUyTc0qF/JAy8VyrG1VOp19j7R3pZeIoRqMqfPofLEU4ELAd/+2ejUK4NSfrbLJIIsqL
         AxZRh6cZBOILitDvNcXsrOuoXknarXBYbyZuq0zEXTULLfptccGbkmWMPmSEgYLp9YXH
         BBBOr9neEwotYBRUdNnSP38sWT7cJomXGwC2ApqtvLyaFziwt+zc5EoRAezVTBcMRDBj
         AVvb2TnTmrOOREF6Uib3zdL6UI4d0XDrLMOnqWMjxIwjG0T2NFBx9Dt7Okeu86rXOhdf
         CEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430782; x=1714035582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2i7cIGrycSQYWPlCCdINwh9/UQnjF+IIqZAJpSGmhgU=;
        b=QF2NYWAyKykdBoKiT07B8gad1IbIHNdVkYEI5hMLKhuyl7HQQs1CsnOUfp6S4NyJJO
         RDFCuKzktBQwaPK2L9HXv6g8i1k1+RlJrmUorhKGlsK1vObd2jN3wyGti6Gay8JYlsMu
         RddejokY8uO4xma0XbRf1vQDR0umLatrIlmUoUJyc/hKFc5/1/ZA7deWQVMEGS+N8eQo
         kkWQ8hC3VXPMax2sa0FFaMcBTNcTvXkwx5IRfdEb2A3oleP5cXO30DuI9Qfw5bk1TxG1
         QM8fdEPwG1BMXpZLtJceNfClqFb6lTEY3yNVzu8A3tf1hVEKMLFMt4luqziRDdYyfpBM
         J9IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWGbDbdcV0bn/UKa0fF7S09NIBMvqtnwy4jHcuF9QXnGizMeMSNXWC7+GfL9N1cSDk+m1Rm6KEbAhb2EVLVsbYA2qBwvwYrOJ5QapWA
X-Gm-Message-State: AOJu0Yx8t9d9+WHzYx/M+y7gbKq+gx5ar2rUbV3tbIqs0X6k9lCWZb/S
	1oJfHvLB3X7nDpg+BskEayXJvawif7nzPHUNoF33tajHVhRNtq4fCbh+NyzvaHi36Ylan/p6E88
	rbaetK1klVMXjJA==
X-Google-Smtp-Source: AGHT+IG+jY4+0ofbPAOxP4aGGV+IDNpzgvLMZWhsS1WIS60BQrHa6xxYtx5GVync8b3M5DHqH+EipzY/b+2qzBU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:18cd:b0:de4:67d9:a2c6 with SMTP
 id ck13-20020a05690218cd00b00de467d9a2c6mr89467ybb.2.1713430782225; Thu, 18
 Apr 2024 01:59:42 -0700 (PDT)
Date: Thu, 18 Apr 2024 08:59:20 +0000
In-Reply-To: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418-alice-mm-v6-0-cb8f3e5d688f@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=16029; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=af0xmkxz5WwJ2caWqC4SIR0mhucvRiEoxb05tr7yw14=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmIODvBTN1EJk4q9WLN6UPNG6sSesov6EsZDtRE
 MaqZfGehSuJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZiDg7wAKCRAEWL7uWMY5
 Rq/SD/9YqfoAjeuS9VklwHUSs1rn5vmzmFezb8JzHZ111jayAEZ1/AuITRgkAPPp+EY/GXWC9sR
 qSazhLjpMbJlQQVgAskubdzy63Ep6bsr/3Gwb9EnhVo+cZxg3JA7DP9y/dtrBBTcnwuSCxz9Q9N
 E4wScxVzeklnykkmwNHN4qiZ//mdG6b0FG3phZOIq+WAvWdhHxkQIxdODCWt6qPSvPntIj3+PPM
 8fekPfWDKPdRmER+eWXAPQBfsKHdzBrRhj7frTBdaUELnd6evJrnduAtglFnqu2znIaRwomBHsW
 hMvEDO63+If+0T7pkWfEzrj0i4DPn7n4YaIMQwDYWdoxOWGiS/TUI3sRHFxGSL+7ooBt9SG7BRg
 j4oYk88EmNiiNR0Jad2E5UJj7lX2yiP/T+JWhFjBEKpN5FMs8Nrt7KfN4x0JWKvE5XpnaQoRYla
 rcqp0woeAlAzyGbo02t9PIb4TDQUwxTzsGgeMSxVq7izTevsrCCuj4LI6wbHCiSM2KIoSugK42l
 Pu1NpgPsiw9Ys2RWtLhiZ99b38voiTCrUVSfeKbfDKUdsLsZisaPcs8OTQFOq0FoyOULZCYKDqT
 I3b8KMNX9i0EfWQFLFCC7OpsoJBPfOH3RBtrOcEEcQ48hlvPvzHQyqAyLw6sm+nme1Ul+CPeo+T 7G1JpJbpOBZnLEw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240418-alice-mm-v6-4-cb8f3e5d688f@google.com>
Subject: [PATCH v6 4/4] rust: add abstraction for `struct page`
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
`with_pointer_into_page` method.

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
to consolidate the bounds checking logic into a single place, and
various other changes.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |  20 ++++
 rust/kernel/alloc.rs            |   7 ++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/page.rs             | 250 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 279 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ddb5644d4fd9..0862261cfbed 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,6 +20,7 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const size_t RUST_CONST_HELPER_PAGE_SIZE = PAGE_SIZE;
 const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
diff --git a/rust/helpers.c b/rust/helpers.c
index 312b6fcb49d5..72361003ba91 100644
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
+	return alloc_pages(gfp_mask, order);
+}
+EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
+
+void *rust_helper_kmap_local_page(struct page *page)
+{
+	return kmap_local_page(page);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kmap_local_page);
+
+void rust_helper_kunmap_local(const void *addr)
+{
+	kunmap_local(addr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_kunmap_local);
+
 refcount_t rust_helper_REFCOUNT_INIT(int n)
 {
 	return (refcount_t)REFCOUNT_INIT(n);
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index f1c2c4aa22d2..7ab2b33f19d4 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -20,6 +20,13 @@
 #[derive(Clone, Copy)]
 pub struct Flags(u32);
 
+impl Flags {
+    /// Get the raw representation of this flag.
+    pub(crate) fn as_raw(self) -> u32 {
+        self.0
+    }
+}
+
 impl core::ops::BitOr for Flags {
     type Output = Self;
     fn bitor(self, rhs: Self) -> Self::Output {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7ee807ae4680..048e1662829a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -35,6 +35,7 @@
 pub mod kunit;
 #[cfg(CONFIG_NET)]
 pub mod net;
+pub mod page;
 pub mod prelude;
 pub mod print;
 mod static_assert;
diff --git a/rust/kernel/page.rs b/rust/kernel/page.rs
new file mode 100644
index 000000000000..121d20066645
--- /dev/null
+++ b/rust/kernel/page.rs
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Kernel page allocation and management.
+
+use crate::{
+    alloc::{AllocError, Flags},
+    bindings,
+    error::code::*,
+    error::Result,
+    uaccess::UserSliceReader,
+};
+use core::ptr::{self, NonNull};
+
+/// A bitwise shift for the page size.
+pub const PAGE_SHIFT: usize = bindings::PAGE_SHIFT as usize;
+
+/// The number of bytes in a page.
+pub const PAGE_SIZE: usize = bindings::PAGE_SIZE;
+
+/// A bitmask that gives the page containing a given address.
+pub const PAGE_MASK: usize = !(PAGE_SIZE - 1);
+
+/// A pointer to a page that owns the page allocation.
+///
+/// # Invariants
+///
+/// The pointer is valid, and has ownership over the page.
+pub struct Page {
+    page: NonNull<bindings::page>,
+}
+
+// SAFETY: Pages have no logic that relies on them staying on a given thread, so moving them across
+// threads is safe.
+unsafe impl Send for Page {}
+
+// SAFETY: Pages have no logic that relies on them not being accessed concurrently, so accessing
+// them concurrently is safe.
+unsafe impl Sync for Page {}
+
+impl Page {
+    /// Allocates a new page.
+    ///
+    /// # Examples
+    ///
+    /// Allocate memory for a page.
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// # fn dox() -> Result<(), kernel::alloc::AllocError> {
+    /// let page = Page::alloc_page(GFP_KERNEL)?;
+    /// # Ok(()) }
+    /// ```
+    ///
+    /// Allocate memory for a page and zero its contents.
+    ///
+    /// ```
+    /// use kernel::page::Page;
+    ///
+    /// # fn dox() -> Result<(), kernel::alloc::AllocError> {
+    /// let page = Page::alloc_page(GFP_KERNEL | __GFP_ZERO)?;
+    /// # Ok(()) }
+    /// ```
+    pub fn alloc_page(flags: Flags) -> Result<Self, AllocError> {
+        // SAFETY: Depending on the value of `gfp_flags`, this call may sleep. Other than that, it
+        // is always safe to call this method.
+        let page = unsafe { bindings::alloc_pages(flags.as_raw(), 0) };
+        let page = NonNull::new(page).ok_or(AllocError)?;
+        // INVARIANT: We just successfully allocated a page, so we now have ownership of the newly
+        // allocated page. We transfer that ownership to the new `Page` object.
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
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `PAGE_SIZE` bytes and for the duration in which the closure is called. The pointer might
+    /// only be mapped on the current thread, and when that is the case, dereferencing it on other
+    /// threads is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't
+    /// cause data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_page_mapped<T>(&self, f: impl FnOnce(*mut u8) -> T) -> T {
+        // SAFETY: `page` is valid due to the type invariants on `Page`.
+        let mapped_addr = unsafe { bindings::kmap_local_page(self.as_ptr()) };
+
+        let res = f(mapped_addr.cast());
+
+        // This unmaps the page mapped above.
+        //
+        // SAFETY: Since this API takes the user code as a closure, it can only be used in a manner
+        // where the pages are unmapped in reverse order. This is as required by `kunmap_local`.
+        //
+        // In other words, if this call to `kunmap_local` happens when a different page should be
+        // unmapped first, then there must necessarily be a call to `kmap_local_page` other than the
+        // call just above in `with_page_mapped` that made that possible. In this case, it is the
+        // unsafe block that wraps that other call that is incorrect.
+        unsafe { bindings::kunmap_local(mapped_addr) };
+
+        res
+    }
+
+    /// Runs a piece of code with a raw pointer to a slice of this page, with bounds checking.
+    ///
+    /// If `f` is called, then it will be called with a pointer that points at `off` bytes into the
+    /// page, and the pointer will be valid for at least `len` bytes. The pointer is only valid on
+    /// this task, as this method uses a local mapping.
+    ///
+    /// If `off` and `len` refers to a region outside of this page, then this method returns
+    /// `EINVAL` and does not call `f`.
+    ///
+    /// # Using the raw pointer
+    ///
+    /// It is up to the caller to use the provided raw pointer correctly. The pointer is valid for
+    /// `len` bytes and for the duration in which the closure is called. The pointer might only be
+    /// mapped on the current thread, and when that is the case, dereferencing it on other threads
+    /// is UB. Other than that, the usual rules for dereferencing a raw pointer apply: don't cause
+    /// data races, the memory may be uninitialized, and so on.
+    ///
+    /// If multiple threads map the same page at the same time, then they may reference with
+    /// different addresses. However, even if the addresses are different, the underlying memory is
+    /// still the same for these purposes (e.g., it's still a data race if they both write to the
+    /// same underlying byte at the same time).
+    fn with_pointer_into_page<T>(
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
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `dst` is valid for writing `len` bytes.
+    /// * Callers must ensure that this call does not race with a write to the same page that
+    ///   overlaps with this read.
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
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// * Callers must ensure that `src` is valid for reading `len` bytes.
+    /// * Callers must ensure that this call does not race with a read or write to the same page
+    ///   that overlaps with this write.
+    pub unsafe fn write_raw(&self, src: *const u8, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::copy_nonoverlapping(src, dst, len) };
+            Ok(())
+        })
+    }
+
+    /// Maps the page and zeroes the given slice.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn fill_zero_raw(&self, offset: usize, len: usize) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes.
+            //
+            // There caller guarantees that there is no data race.
+            unsafe { ptr::write_bytes(dst, 0u8, len) };
+            Ok(())
+        })
+    }
+
+    /// Copies data from userspace into this page.
+    ///
+    /// This method will perform bounds checks on the page offset. If `offset .. offset+len` goes
+    /// outside ot the page, then this call returns `EINVAL`.
+    ///
+    /// Like the other `UserSliceReader` methods, data races are allowed on the userspace address.
+    /// However, they are not allowed on the page you are copying into.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that this call does not race with a read or write to the same page that
+    /// overlaps with this write.
+    pub unsafe fn copy_from_user_slice_raw(
+        &self,
+        reader: &mut UserSliceReader,
+        offset: usize,
+        len: usize,
+    ) -> Result {
+        self.with_pointer_into_page(offset, len, move |dst| {
+            // SAFETY: If `with_pointer_into_page` calls into this closure, then it has performed a
+            // bounds check and guarantees that `dst` is valid for `len` bytes. Furthermore, we have
+            // exclusive access to the slice since the caller guarantees that there are no races.
+            reader.read_raw(unsafe { core::slice::from_raw_parts_mut(dst.cast(), len) })
+        })
+    }
+}
+
+impl Drop for Page {
+    fn drop(&mut self) {
+        // SAFETY: By the type invariants, we have ownership of the page and can free it.
+        unsafe { bindings::__free_pages(self.page.as_ptr(), 0) };
+    }
+}

-- 
2.44.0.683.g7961c838ac-goog


