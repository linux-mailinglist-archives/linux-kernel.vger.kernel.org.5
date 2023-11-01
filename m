Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B077DE5CC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345263AbjKASDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344994AbjKASDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:13 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC484123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:03:05 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-53db0df5b7cso30286a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861784; x=1699466584; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ETN5faJZgnbDmZG9tYXVRa1jPl93RJnYR+FwdTDHd8E=;
        b=qtICM3zHeabTYedb3wU9F0GouJn/EFyiMmwK2+dgJJmeDZAqTpBoLC8Z1j/GwKYezM
         GiVUhqWBhwmRHVaNiCHjJP9f6NysjA1S/ifKj2tPCMCF1pC57qWcj2WI3y+UUm1BywNa
         uT8uzM4AA6ezDC2NKfnK9C1mrCAs1/MzsvPFQqRpjV1LYJ3duX+RphJmRS+EvNHNWmgQ
         5FIfU5wUvIfSXtjmcgSJSD2P3y26qsKLhX3KdAHW/GxmLa/2v6tjIcGiwkw/T67iJd3a
         Oe0xX/fSDpIH1bLxJnDQJt2MmIRw7E9lRLzNLuBGOUvoaBdfCboj6ebqJ8vUwYW4u7fj
         719g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861784; x=1699466584;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETN5faJZgnbDmZG9tYXVRa1jPl93RJnYR+FwdTDHd8E=;
        b=ZAYyM2r9Pneib9SpOjF/rZhU968qd/XOCUqifz5SncEvAFCWIayDb+T+KeXc83Peez
         9Z6ZSEMm+SdrQEdQBYk6aO7slKrDvk7knKY2JZO9RjsjFsv7oB2U23UC6U6GdEjG16Ug
         7zrBaxAcGmNuZzD7pwnJTyofbLr6WydH+TfRzVR8taOwWe9gUm6qI6ReH704F0raJaE4
         vhyeI8ndqHEw6IeLOUKFrV8xRGpHFKm7CH7ryVk6YHZtZ+XqpdfZAzYRj/olg65gYfUf
         IwkNy7UJ/TVWsJ2XY7mLg+R/0tB8qUSdp/AqUq5WI81BYwNeSK8Hyk969fRlzvUTXcrE
         yEJg==
X-Gm-Message-State: AOJu0Yx5f/2gcovn3luxOdgqV2mldBStdTTWe7YDT6pfUTwH4FLva8Bz
        GT3X6QyBMk2iPB/04cDp7m9dAlZVflbMkNI=
X-Google-Smtp-Source: AGHT+IG06djsuAh0i25MKE6pHR1EGjsyG24cp9ms84ixgto/LVSvPFgFL3jfOunHoqtyr6XoxAz4LQ+XyoMZsW0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:12da:b0:543:87e1:a198 with SMTP
 id k26-20020a05640212da00b0054387e1a198mr49219edx.2.1698861784178; Wed, 01
 Nov 2023 11:03:04 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:49 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-19-08ba9197f637@google.com>
Subject: [PATCH RFC 19/20] rust_binder: add vma shrinker
From:   Alice Ryhl <aliceryhl@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Carlos Llamas <cmllamas@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matt Gilbride <mattgilbride@google.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Matthew Maurer <mmaurer@google.com>,
        Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is under memory pressure, we want the driver to release
unused pages. We do this by registering a memory shrinker with the
kernel.

The data for incoming transactions is stored in an mmap'ed region.
Previously in this patch series, we just allocated all of the pages in
that region immediately. With this patch series, we do not allocate the
pages until we need them.

Furthermore, when we no longer need a page, we mark it as "available"
using an lru list. If the system is under memory pressure, this allows
the shrinker to free that page by removing it from the lru list. If we
need to use the page again before the shrinker frees it, then we just
remove it from the lru list, and we don't need to reallocate the page.

The page range abstraction is split into a fast path and slow path. The
slow path is only used when a page is not allocated, which should only
happen on first use, and when the system is under memory pressure.

I'm not yet completely happy with this implementation. Specifically, I
would like to improve the robustness of the unsafe code found in
`allocation.rs`.

The slow-path/fast-path implementation in `page_range.rs` is different
from C Binder's current implementation, and was suggested to me by
Carlos.

Suggested-by: Carlos Llamas <cmllamas@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs     |  80 ++---
 drivers/android/process.rs        | 129 +++----
 drivers/android/range_alloc.rs    |  44 ++-
 drivers/android/rust_binder.rs    |   6 +
 rust/bindings/bindings_helper.h   |   2 +
 rust/helpers.c                    |  20 ++
 rust/kernel/lib.rs                |   1 +
 rust/kernel/page_range.rs         | 715 ++++++++++++++++++++++++++++++++++++++
 rust/kernel/sync/lock.rs          |  24 ++
 rust/kernel/sync/lock/mutex.rs    |  10 +
 rust/kernel/sync/lock/spinlock.rs |  10 +
 11 files changed, 931 insertions(+), 110 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index 7b64e7fcce4d..4a9f8e7f2de3 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -6,7 +6,6 @@
     bindings,
     file::{DeferredFdCloser, File, FileDescriptorReservation},
     io_buffer::{IoBufferReader, ReadableFromBytes, WritableToBytes},
-    pages::Pages,
     prelude::*,
     sync::Arc,
     types::ARef,
@@ -41,11 +40,15 @@ pub(crate) struct AllocationInfo {
 /// Represents an allocation that the kernel is currently using.
 ///
 /// When allocations are idle, the range allocator holds the data related to them.
+///
+/// # Invariants
+///
+/// This allocation corresponds to an allocation in the range allocator, so the relevant pages are
+/// marked in use in the page range.
 pub(crate) struct Allocation {
     pub(crate) offset: usize,
     size: usize,
     pub(crate) ptr: usize,
-    pages: Arc<Vec<Pages<0>>>,
     pub(crate) process: Arc<Process>,
     allocation_info: Option<AllocationInfo>,
     free_on_drop: bool,
@@ -58,7 +61,6 @@ pub(crate) fn new(
         offset: usize,
         size: usize,
         ptr: usize,
-        pages: Arc<Vec<Pages<0>>>,
         oneway_spam_detected: bool,
     ) -> Self {
         Self {
@@ -66,30 +68,17 @@ pub(crate) fn new(
             offset,
             size,
             ptr,
-            pages,
             oneway_spam_detected,
             allocation_info: None,
             free_on_drop: true,
         }
     }
 
-    fn iterate<T>(&self, mut offset: usize, mut size: usize, mut cb: T) -> Result
-    where
-        T: FnMut(&Pages<0>, usize, usize) -> Result,
-    {
-        // Check that the request is within the buffer.
-        if offset.checked_add(size).ok_or(EINVAL)? > self.size {
-            return Err(EINVAL);
-        }
-        offset += self.offset;
-        let mut page_index = offset >> bindings::PAGE_SHIFT;
-        offset &= (1 << bindings::PAGE_SHIFT) - 1;
-        while size > 0 {
-            let available = core::cmp::min(size, (1 << bindings::PAGE_SHIFT) - offset);
-            cb(&self.pages[page_index], offset, available)?;
-            size -= available;
-            page_index += 1;
-            offset = 0;
+    fn size_check(&self, offset: usize, size: usize) -> Result {
+        let overflow_fail = offset.checked_add(size).is_none();
+        let cmp_size_fail = offset.wrapping_add(size) > self.size;
+        if overflow_fail || cmp_size_fail {
+            return Err(EFAULT);
         }
         Ok(())
     }
@@ -100,42 +89,37 @@ pub(crate) fn copy_into(
         offset: usize,
         size: usize,
     ) -> Result {
-        self.iterate(offset, size, |page, offset, to_copy| {
-            page.copy_into_page(reader, offset, to_copy)
-        })
+        self.size_check(offset, size)?;
+
+        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
+        // in turn, the pages will be marked as in use.
+        unsafe {
+            self.process
+                .pages
+                .copy_into(reader, self.offset + offset, size)
+        }
     }
 
     pub(crate) fn read<T: ReadableFromBytes>(&self, offset: usize) -> Result<T> {
-        let mut out = MaybeUninit::<T>::uninit();
-        let mut out_offset = 0;
-        self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
-            // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
-            let obj_ptr = unsafe { (out.as_mut_ptr() as *mut u8).add(out_offset) };
-            // SAFETY: The pointer points is in-bounds of the `out` variable, so it is valid.
-            unsafe { page.read(obj_ptr, offset, to_copy) }?;
-            out_offset += to_copy;
-            Ok(())
-        })?;
-        // SAFETY: We just initialised the data.
-        Ok(unsafe { out.assume_init() })
+        self.size_check(offset, size_of::<T>())?;
+
+        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
+        // in turn, the pages will be marked as in use.
+        unsafe { self.process.pages.read(self.offset + offset) }
     }
 
     pub(crate) fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
-        let mut obj_offset = 0;
-        self.iterate(offset, size_of_val(obj), |page, offset, to_copy| {
-            // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
-            let obj_ptr = unsafe { (obj as *const T as *const u8).add(obj_offset) };
-            // SAFETY: We have a reference to the object, so the pointer is valid.
-            unsafe { page.write(obj_ptr, offset, to_copy) }?;
-            obj_offset += to_copy;
-            Ok(())
-        })
+        self.size_check(offset, size_of_val::<T>(obj))?;
+
+        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
+        // in turn, the pages will be marked as in use.
+        unsafe { self.process.pages.write(self.offset + offset, obj) }
     }
 
     pub(crate) fn fill_zero(&self) -> Result {
-        self.iterate(0, self.size, |page, offset, len| {
-            page.fill_zero(offset, len)
-        })
+        // SAFETY: While this object exists, the range allocator will keep the range allocated, and
+        // in turn, the pages will be marked as in use.
+        unsafe { self.process.pages.fill_zero(self.offset, self.size) }
     }
 
     pub(crate) fn keep_alive(mut self) {
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index b5e44f9f2a14..61809e496a48 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -17,7 +17,7 @@
     io_buffer::{IoBufferReader, IoBufferWriter},
     list::{HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks},
     mm,
-    pages::Pages,
+    page_range::ShrinkablePageRange,
     prelude::*,
     rbtree::RBTree,
     seq_file::SeqFile,
@@ -47,17 +47,12 @@
 struct Mapping {
     address: usize,
     alloc: RangeAllocator<AllocationInfo>,
-    pages: Arc<Vec<Pages<0>>>,
 }
 
 impl Mapping {
-    fn new(address: usize, size: usize, pages: Arc<Vec<Pages<0>>>) -> Result<Self> {
+    fn new(address: usize, size: usize) -> Result<Self> {
         let alloc = RangeAllocator::new(size)?;
-        Ok(Self {
-            address,
-            alloc,
-            pages,
-        })
+        Ok(Self { address, alloc })
     }
 }
 
@@ -333,6 +328,9 @@ pub(crate) struct Process {
     #[pin]
     pub(crate) inner: SpinLock<ProcessInner>,
 
+    #[pin]
+    pub(crate) pages: ShrinkablePageRange,
+
     // Waitqueue of processes waiting for all outstanding transactions to be
     // processed.
     #[pin]
@@ -390,10 +388,11 @@ fn run(me: Arc<Self>) {
 
 impl Process {
     fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
-        let list_process = ListArc::pin_init(pin_init!(Process {
+        let list_process = ListArc::pin_init(try_pin_init!(Process {
             ctx,
             cred,
             inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
+            pages <- ShrinkablePageRange::new(&super::BINDER_SHRINKER),
             node_refs <- kernel::new_mutex!(ProcessNodeRefs::new(), "Process::node_refs"),
             freeze_wait <- kernel::new_condvar!("Process::freeze_wait"),
             task: kernel::current!().group_leader().into(),
@@ -738,20 +737,46 @@ pub(crate) fn buffer_alloc(
         is_oneway: bool,
         from_pid: i32,
     ) -> BinderResult<Allocation> {
+        use kernel::bindings::PAGE_SIZE;
+
         let alloc = range_alloc::ReserveNewBox::try_new()?;
         let mut inner = self.inner.lock();
         let mapping = inner.mapping.as_mut().ok_or_else(BinderError::new_dead)?;
         let offset = mapping
             .alloc
             .reserve_new(size, is_oneway, from_pid, alloc)?;
-        Ok(Allocation::new(
+
+        let res = Allocation::new(
             self.clone(),
             offset,
             size,
             mapping.address + offset,
-            mapping.pages.clone(),
             mapping.alloc.oneway_spam_detected,
-        ))
+        );
+        drop(inner);
+
+        // This allocation will be marked as in use until the `Allocation` is used to free it.
+        //
+        // This method can't be called while holding a lock, so we release the lock first. It's
+        // okay for several threads to use the method on the same index at the same time. In that
+        // case, one of the calls will allocate the given page (if missing), and the other call
+        // will wait for the other call to finish allocating the page.
+        //
+        // We will not call `stop_using_range` in parallel with this on the same page, because the
+        // allocation can only be removed via the destructor of the `Allocation` object that we
+        // currently own.
+        match self.pages.use_range(
+            offset / PAGE_SIZE,
+            (offset + size + (PAGE_SIZE - 1)) / PAGE_SIZE,
+        ) {
+            Ok(()) => {}
+            Err(err) => {
+                pr_warn!("use_range failure {:?}", err);
+                return Err(err.into());
+            }
+        }
+
+        Ok(res)
     }
 
     pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
@@ -764,7 +789,6 @@ pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
             offset,
             size,
             ptr,
-            mapping.pages.clone(),
             mapping.alloc.oneway_spam_detected,
         );
         if let Some(data) = odata {
@@ -776,18 +800,29 @@ pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
     pub(crate) fn buffer_raw_free(&self, ptr: usize) {
         let mut inner = self.inner.lock();
         if let Some(ref mut mapping) = &mut inner.mapping {
-            if ptr < mapping.address
-                || mapping
-                    .alloc
-                    .reservation_abort(ptr - mapping.address)
-                    .is_err()
-            {
-                pr_warn!(
-                    "Pointer {:x} failed to free, base = {:x}\n",
-                    ptr,
-                    mapping.address
-                );
-            }
+            let offset = match ptr.checked_sub(mapping.address) {
+                Some(offset) => offset,
+                None => return,
+            };
+
+            let freed_range = match mapping.alloc.reservation_abort(offset) {
+                Ok(freed_range) => freed_range,
+                Err(_) => {
+                    pr_warn!(
+                        "Pointer {:x} failed to free, base = {:x}\n",
+                        ptr,
+                        mapping.address
+                    );
+                    return;
+                }
+            };
+
+            // No more allocations in this range. Mark them as not in use.
+            //
+            // Must be done before we release the lock so that `use_range` is not used on these
+            // indices until `stop_using_range` returns.
+            self.pages
+                .stop_using_range(freed_range.start_page_idx, freed_range.end_page_idx);
         }
     }
 
@@ -802,35 +837,16 @@ pub(crate) fn buffer_make_freeable(&self, offset: usize, data: Option<Allocation
 
     fn create_mapping(&self, vma: &mut mm::virt::Area) -> Result {
         use kernel::bindings::PAGE_SIZE;
-        let size = core::cmp::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
-        let page_count = size / PAGE_SIZE;
-
-        // Allocate and map all pages.
-        //
-        // N.B. If we fail halfway through mapping these pages, the kernel will unmap them.
-        let mut pages = Vec::new();
-        pages.try_reserve_exact(page_count)?;
-        let mut address = vma.start();
-        for _ in 0..page_count {
-            let page = Pages::<0>::new()?;
-            vma.insert_page(address, &page)?;
-            pages.try_push(page)?;
-            address += PAGE_SIZE;
+        let size = usize::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
+        let mapping = Mapping::new(vma.start(), size)?;
+        let page_count = self.pages.register_with_vma(vma)?;
+        if page_count * PAGE_SIZE != size {
+            return Err(EINVAL);
         }
 
-        let ref_pages = Arc::try_new(pages)?;
-        let mapping = Mapping::new(vma.start(), size, ref_pages)?;
+        // Save range allocator for later.
+        self.inner.lock().mapping = Some(mapping);
 
-        // Save pages for later.
-        let mut inner = self.inner.lock();
-        match &inner.mapping {
-            None => inner.mapping = Some(mapping),
-            Some(_) => {
-                drop(inner);
-                drop(mapping);
-                return Err(EBUSY);
-            }
-        }
         Ok(())
     }
 
@@ -1044,18 +1060,11 @@ fn deferred_release(self: Arc<Self>) {
         let omapping = self.inner.lock().mapping.take();
         if let Some(mut mapping) = omapping {
             let address = mapping.address;
-            let pages = mapping.pages.clone();
             let oneway_spam_detected = mapping.alloc.oneway_spam_detected;
             mapping.alloc.take_for_each(|offset, size, odata| {
                 let ptr = offset + address;
-                let mut alloc = Allocation::new(
-                    self.clone(),
-                    offset,
-                    size,
-                    ptr,
-                    pages.clone(),
-                    oneway_spam_detected,
-                );
+                let mut alloc =
+                    Allocation::new(self.clone(), offset, size, ptr, oneway_spam_detected);
                 if let Some(data) = odata {
                     alloc.set_info(data);
                 }
diff --git a/drivers/android/range_alloc.rs b/drivers/android/range_alloc.rs
index c1d47115e54d..4aa1b5236bf5 100644
--- a/drivers/android/range_alloc.rs
+++ b/drivers/android/range_alloc.rs
@@ -19,6 +19,26 @@ pub(crate) struct RangeAllocator<T> {
     pub(crate) oneway_spam_detected: bool,
 }
 
+const PAGE_SIZE: usize = kernel::bindings::PAGE_SIZE;
+
+/// Represents a range of pages that have just become completely free.
+#[derive(Copy, Clone)]
+pub(crate) struct FreedRange {
+    pub(crate) start_page_idx: usize,
+    pub(crate) end_page_idx: usize,
+}
+
+impl FreedRange {
+    fn interior_pages(offset: usize, size: usize) -> FreedRange {
+        FreedRange {
+            // Divide round up
+            start_page_idx: (offset + (PAGE_SIZE - 1)) / PAGE_SIZE,
+            // Divide round down
+            end_page_idx: (offset + size) / PAGE_SIZE,
+        }
+    }
+}
+
 impl<T> RangeAllocator<T> {
     pub(crate) fn new(size: usize) -> Result<Self> {
         let mut tree = RBTree::new();
@@ -97,7 +117,7 @@ pub(crate) fn reserve_new(
         Ok(found_off)
     }
 
-    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
+    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result<FreedRange> {
         let mut cursor = self.tree.cursor_lower_bound(&offset).ok_or_else(|| {
             pr_warn!(
                 "EINVAL from range_alloc.reservation_abort - offset: {}",
@@ -140,9 +160,26 @@ pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
 
         self.free_oneway_space += free_oneway_space_add;
 
+        let mut freed_range = FreedRange::interior_pages(offset, size);
+        // Compute how large the next free region needs to be to include one more page in
+        // the newly freed range.
+        let add_next_page_needed = match (offset + size) % PAGE_SIZE {
+            0 => usize::MAX,
+            unalign => PAGE_SIZE - unalign,
+        };
+        // Compute how large the previous free region needs to be to include one more page
+        // in the newly freed range.
+        let add_prev_page_needed = match offset % PAGE_SIZE {
+            0 => usize::MAX,
+            unalign => unalign,
+        };
+
         // Merge next into current if next is free
         let remove_next = match cursor.peek_next() {
             Some((_, next)) if next.state.is_none() => {
+                if next.size >= add_next_page_needed {
+                    freed_range.end_page_idx += 1;
+                }
                 self.free_tree.remove(&(next.size, next.offset));
                 size += next.size;
                 true
@@ -159,6 +196,9 @@ pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
         // Merge current into prev if prev is free
         match cursor.peek_prev_mut() {
             Some((_, prev)) if prev.state.is_none() => {
+                if prev.size >= add_prev_page_needed {
+                    freed_range.start_page_idx -= 1;
+                }
                 // merge previous with current, remove current
                 self.free_tree.remove(&(prev.size, prev.offset));
                 offset = prev.offset;
@@ -172,7 +212,7 @@ pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
         self.free_tree
             .insert(reservation.free_res.into_node((size, offset), ()));
 
-        Ok(())
+        Ok(freed_range)
     }
 
     pub(crate) fn reservation_commit(&mut self, offset: usize, data: Option<T>) -> Result {
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index a1c95a1609d5..0e4033dc8e71 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -9,6 +9,7 @@
     list::{
         HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks, ListLinksSelfPtr, TryNewListArc,
     },
+    page_range::Shrinker,
     prelude::*,
     seq_file::SeqFile,
     seq_print,
@@ -173,12 +174,17 @@ const fn ptr_align(value: usize) -> usize {
     (value + size) & !size
 }
 
+// SAFETY: We call register in `init`.
+static BINDER_SHRINKER: Shrinker = unsafe { Shrinker::new() };
+
 struct BinderModule {}
 
 impl kernel::Module for BinderModule {
     fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
         crate::context::CONTEXTS.init();
 
+        BINDER_SHRINKER.register(kernel::c_str!("android-binder"))?;
+
         // SAFETY: The module is being loaded, so we can initialize binderfs.
         #[cfg(CONFIG_ANDROID_BINDERFS_RUST)]
         unsafe {
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index b2d60b4a9df6..2f37e5192ce4 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -12,6 +12,7 @@
 #include <linux/fdtable.h>
 #include <linux/file.h>
 #include <linux/fs.h>
+#include <linux/list_lru.h>
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
 #include <linux/security.h>
@@ -21,6 +22,7 @@
 #include <linux/rust_binder.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/shrinker.h>
 #include <linux/task_work.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/android/binder.h>
diff --git a/rust/helpers.c b/rust/helpers.c
index be295d8bdb46..3392d2d4ee2c 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -93,6 +93,12 @@ void rust_helper_spin_unlock(spinlock_t *lock)
 }
 EXPORT_SYMBOL_GPL(rust_helper_spin_unlock);
 
+int rust_helper_spin_trylock(spinlock_t *lock)
+{
+	return spin_trylock(lock);
+}
+EXPORT_SYMBOL_GPL(rust_helper_spin_trylock);
+
 void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
 {
 	init_wait(wq_entry);
@@ -310,6 +316,20 @@ struct vm_area_struct *rust_helper_vma_lookup(struct mm_struct *mm,
 }
 EXPORT_SYMBOL_GPL(rust_helper_vma_lookup);
 
+unsigned long rust_helper_list_lru_count(struct list_lru *lru)
+{
+	return list_lru_count(lru);
+}
+EXPORT_SYMBOL_GPL(rust_helper_list_lru_count);
+
+unsigned long rust_helper_list_lru_walk(struct list_lru *lru,
+					list_lru_walk_cb isolate, void *cb_arg,
+					unsigned long nr_to_walk)
+{
+	return list_lru_walk(lru, isolate, cb_arg, nr_to_walk);
+}
+EXPORT_SYMBOL_GPL(rust_helper_list_lru_walk);
+
 void rust_helper_rb_link_node(struct rb_node *node, struct rb_node *parent,
 			      struct rb_node **rb_link)
 {
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index d46187783464..02e670b92426 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -43,6 +43,7 @@
 pub mod kunit;
 pub mod list;
 pub mod mm;
+pub mod page_range;
 pub mod pages;
 pub mod prelude;
 pub mod print;
diff --git a/rust/kernel/page_range.rs b/rust/kernel/page_range.rs
new file mode 100644
index 000000000000..b13f8cd62b77
--- /dev/null
+++ b/rust/kernel/page_range.rs
@@ -0,0 +1,715 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module has utilities for managing a page range where unused pages may be reclaimed by a
+//! vma shrinker.
+
+// To avoid deadlocks, locks are taken in the order:
+//
+//  1. mmap lock
+//  2. spinlock
+//  3. lru spinlock
+//
+// The shrinker will use trylock methods because it locks them in a different order.
+
+use core::{
+    alloc::Layout,
+    ffi::{c_ulong, c_void},
+    marker::PhantomPinned,
+    mem::{size_of, size_of_val, MaybeUninit},
+    ptr,
+};
+
+use crate::{
+    bindings,
+    error::Result,
+    io_buffer::ReadableFromBytes,
+    mm::{virt, MmGrab},
+    new_spinlock,
+    pages::Pages,
+    prelude::*,
+    str::CStr,
+    sync::SpinLock,
+    types::Opaque,
+    user_ptr::UserSlicePtrReader,
+};
+
+const PAGE_SIZE: usize = bindings::PAGE_SIZE;
+const PAGE_SHIFT: usize = bindings::PAGE_SHIFT;
+const PAGE_MASK: usize = bindings::PAGE_MASK;
+
+/// Represents a shrinker that can be registered with the kernel.
+///
+/// Each shrinker can be used by many `ShrinkablePageRange` objects.
+#[repr(C)]
+pub struct Shrinker {
+    inner: Opaque<bindings::shrinker>,
+    list_lru: Opaque<bindings::list_lru>,
+}
+
+unsafe impl Send for Shrinker {}
+unsafe impl Sync for Shrinker {}
+
+impl Shrinker {
+    /// Create a new shrinker.
+    ///
+    /// # Safety
+    ///
+    /// Before using this shrinker with a `ShrinkablePageRange`, the `register` method must have
+    /// been called exactly once, and it must not have returned an error.
+    pub const unsafe fn new() -> Self {
+        Self {
+            inner: Opaque::uninit(),
+            list_lru: Opaque::uninit(),
+        }
+    }
+
+    /// Register this shrinker with the kernel.
+    pub fn register(&'static self, name: &CStr) -> Result<()> {
+        // SAFETY: These fields are not yet used, so it's okay to zero them.
+        unsafe {
+            self.inner.get().write_bytes(0, 1);
+            self.list_lru.get().write_bytes(0, 1);
+        }
+
+        // SAFETY: The field is not yet used, so we can initialize it.
+        let ret = unsafe {
+            bindings::__list_lru_init(self.list_lru.get(), false, ptr::null_mut(), ptr::null_mut())
+        };
+        if ret != 0 {
+            return Err(Error::from_errno(ret));
+        }
+
+        // SAFETY: We're about to register the shrinker, and these are the fields we need to
+        // initialize. (All other fields are already zeroed.)
+        unsafe {
+            let inner = self.inner.get();
+            ptr::addr_of_mut!((*inner).count_objects).write(Some(rust_shrink_count));
+            ptr::addr_of_mut!((*inner).scan_objects).write(Some(rust_shrink_scan));
+            ptr::addr_of_mut!((*inner).seeks).write(bindings::DEFAULT_SEEKS as _);
+        }
+
+        // SAFETY: We've initialized the shrinker fields we need to, so we can call this method.
+        let ret = unsafe { bindings::register_shrinker(self.inner.get(), name.as_char_ptr()) };
+        if ret != 0 {
+            // SAFETY: We initialized it, so its okay to destroy it.
+            unsafe { bindings::list_lru_destroy(self.list_lru.get()) };
+            return Err(Error::from_errno(ret));
+        }
+
+        Ok(())
+    }
+}
+
+/// A container that manages a page range in a vma.
+///
+/// The pages can be thought of as an array of booleans of whether the pages are usable. The
+/// methods `use_range` and `stop_using_range` set all booleans in a range to true or false
+/// respectively. Initially, no pages are allocated. When a page is not used, it is not freed
+/// immediately. Instead, it is made available to the memory shrinker to free it if the device is
+/// under memory pressure.
+///
+/// It's okay for `use_range` and `stop_using_range` to race with each other, although there's no
+/// way to know whether an index ends up with true or false if a call to `use_range` races with
+/// another call to `stop_using_range` on a given index.
+///
+/// It's also okay for the two methods to race with themselves, e.g. if two threads call
+/// `use_range` on the same index, then that's fine and neither call will return until the page is
+/// allocated and mapped.
+///
+/// The methods that read or write to a range require that the page is marked as in use. So it is
+/// _not_ okay to call `stop_using_range` on a page that is in use by the methods that read or
+/// write to the page.
+#[pin_data(PinnedDrop)]
+pub struct ShrinkablePageRange {
+    /// Shrinker object registered with the kernel.
+    shrinker: &'static Shrinker,
+    /// The mm for the relevant process.
+    mm: MmGrab,
+    /// Spinlock protecting changes to pages.
+    #[pin]
+    lock: SpinLock<Inner>,
+
+    /// Must not move, since page info has pointers back.
+    #[pin]
+    _pin: PhantomPinned,
+}
+
+struct Inner {
+    /// Array of pages.
+    ///
+    /// Since this is also accessed by the shrinker, we can't use a `Box`, which asserts exclusive
+    /// ownership. To deal with that, we manage it using raw pointers.
+    pages: *mut PageInfo,
+    /// Length of the `pages` array.
+    size: usize,
+    /// The address of the vma to insert the pages into.
+    vma_addr: usize,
+}
+
+unsafe impl Send for ShrinkablePageRange {}
+unsafe impl Sync for ShrinkablePageRange {}
+
+/// An array element that describes the current state of a page.
+///
+/// There are three states:
+///
+///  * Free. The page is None. The `lru` element is not queued.
+///  * Available. The page is Some. The `lru` element is queued to the shrinker's lru.
+///  * Used. The page is Some. The `lru` element is not queued.
+///
+/// When an element is available, the shrinker is able to free the page.
+#[repr(C)]
+struct PageInfo {
+    lru: bindings::list_head,
+    page: Option<Pages<0>>,
+    range: *const ShrinkablePageRange,
+}
+
+impl PageInfo {
+    /// # Safety
+    ///
+    /// The caller ensures that reading from `me.page` is ok.
+    unsafe fn has_page(me: *const PageInfo) -> bool {
+        // SAFETY: This pointer offset is in bounds.
+        let page = unsafe { ptr::addr_of!((*me).page) };
+
+        unsafe { (*page).is_some() }
+    }
+
+    /// # Safety
+    ///
+    /// The caller ensures that writing to `me.page` is ok, and that the page is not currently set.
+    unsafe fn set_page(me: *mut PageInfo, page: Pages<0>) {
+        // SAFETY: This pointer offset is in bounds.
+        let ptr = unsafe { ptr::addr_of_mut!((*me).page) };
+
+        // SAFETY: The pointer is valid for writing, so also valid for reading.
+        if unsafe { (*ptr).is_some() } {
+            pr_err!("set_page called when there is already a page");
+            // SAFETY: We will initialize the page again below.
+            unsafe { ptr::drop_in_place(ptr) };
+        }
+
+        // SAFETY: The pointer is valid for writing.
+        unsafe { ptr::write(ptr, Some(page)) };
+    }
+
+    /// # Safety
+    ///
+    /// The caller ensures that reading from `me.page` is ok for the duration of 'a.
+    unsafe fn get_page<'a>(me: *const PageInfo) -> Option<&'a Pages<0>> {
+        // SAFETY: This pointer offset is in bounds.
+        let ptr = unsafe { ptr::addr_of!((*me).page) };
+
+        // SAFETY: The pointer is valid for reading.
+        unsafe { (*ptr).as_ref() }
+    }
+
+    /// # Safety
+    ///
+    /// The caller ensures that writing to `me.page` is ok for the duration of 'a.
+    unsafe fn take_page(me: *mut PageInfo) -> Option<Pages<0>> {
+        // SAFETY: This pointer offset is in bounds.
+        let ptr = unsafe { ptr::addr_of_mut!((*me).page) };
+
+        // SAFETY: The pointer is valid for reading.
+        unsafe { (*ptr).take() }
+    }
+
+    /// Add this page to the lru list, if not already in the list.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid, and it must be the right shrinker.
+    unsafe fn list_lru_add(me: *mut PageInfo, shrinker: &'static Shrinker) {
+        // SAFETY: This pointer offset is in bounds.
+        let lru_ptr = unsafe { ptr::addr_of_mut!((*me).lru) };
+        // SAFETY: The lru pointer is valid, and we're not using it with any other lru list.
+        unsafe { bindings::list_lru_add(shrinker.list_lru.get(), lru_ptr) };
+    }
+
+    /// Remove this page from the lru list, if it is in the list.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must be valid, and it must be the right shrinker.
+    unsafe fn list_lru_del(me: *mut PageInfo, shrinker: &'static Shrinker) {
+        // SAFETY: This pointer offset is in bounds.
+        let lru_ptr = unsafe { ptr::addr_of_mut!((*me).lru) };
+        // SAFETY: The lru pointer is valid, and we're not using it with any other lru list.
+        unsafe { bindings::list_lru_del(shrinker.list_lru.get(), lru_ptr) };
+    }
+}
+
+impl ShrinkablePageRange {
+    /// Create a new `ShrinkablePageRange` using the given shrinker.
+    pub fn new(shrinker: &'static Shrinker) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            shrinker,
+            mm: MmGrab::mmgrab_current().ok_or(ESRCH)?,
+            lock <- new_spinlock!(Inner {
+                pages: ptr::null_mut(),
+                size: 0,
+                vma_addr: 0,
+            }, "ShrinkablePageRange"),
+            _pin: PhantomPinned,
+        })
+    }
+
+    /// Register a vma with this page range. Returns the size of the region.
+    pub fn register_with_vma(&self, vma: &virt::Area) -> Result<usize> {
+        let num_bytes = usize::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
+        let num_pages = num_bytes >> PAGE_SHIFT;
+
+        if !self.mm.is_same_mm(vma) {
+            pr_debug!("Failed to register with vma: invalid vma->vm_mm");
+            return Err(EINVAL);
+        }
+        if num_pages == 0 {
+            pr_debug!("Failed to register with vma: size zero");
+            return Err(EINVAL);
+        }
+
+        let layout = Layout::array::<PageInfo>(num_pages).map_err(|_| ENOMEM)?;
+        // SAFETY: The layout has non-zero size.
+        let pages = unsafe { alloc::alloc::alloc(layout) as *mut PageInfo };
+        if pages.is_null() {
+            return Err(ENOMEM);
+        }
+
+        // SAFETY: This just initializes the pages array.
+        unsafe {
+            let self_ptr = self as *const ShrinkablePageRange;
+            for i in 0..num_pages {
+                let info = pages.add(i);
+                ptr::addr_of_mut!((*info).range).write(self_ptr);
+                ptr::addr_of_mut!((*info).page).write(None);
+                let lru = ptr::addr_of_mut!((*info).lru);
+                ptr::addr_of_mut!((*lru).next).write(lru);
+                ptr::addr_of_mut!((*lru).prev).write(lru);
+            }
+        }
+
+        let mut inner = self.lock.lock();
+        if inner.size > 0 {
+            pr_debug!("Failed to register with vma: already registered");
+            drop(inner);
+            // SAFETY: The `pages` array was allocated with the same layout.
+            unsafe { alloc::alloc::dealloc(pages.cast(), layout) };
+            return Err(EBUSY);
+        }
+
+        inner.pages = pages;
+        inner.size = num_pages;
+        inner.vma_addr = vma.start();
+
+        Ok(num_pages)
+    }
+
+    /// Make sure that the given pages are allocated and mapped.
+    ///
+    /// Must not be called from an atomic context.
+    pub fn use_range(&self, start: usize, end: usize) -> Result<()> {
+        if start >= end {
+            return Ok(());
+        }
+        let mut inner = self.lock.lock();
+        assert!(end <= inner.size);
+
+        for i in start..end {
+            // SAFETY: This pointer offset is in bounds.
+            let page_info = unsafe { inner.pages.add(i) };
+
+            // SAFETY: The pointer is valid, and we hold the lock so reading from the page is okay.
+            if unsafe { PageInfo::has_page(page_info) } {
+                // Since we're going to use the page, we should remove it from the lru list so that
+                // the shrinker will not free it.
+                //
+                // SAFETY: The pointer is valid, and this is the right shrinker.
+                //
+                // The shrinker can't free the page between the check and this call to
+                // `list_lru_del` because we hold the lock.
+                unsafe { PageInfo::list_lru_del(page_info, self.shrinker) };
+            } else {
+                // We have to allocate a new page. Use the slow path.
+                drop(inner);
+                match self.use_page_slow(i) {
+                    Ok(()) => {}
+                    Err(err) => {
+                        pr_warn!("Error in use_page_slow: {:?}", err);
+                        return Err(err);
+                    }
+                }
+                inner = self.lock.lock();
+            }
+        }
+        Ok(())
+    }
+
+    /// Mark the given page as in use, slow path.
+    ///
+    /// Must not be called from an atomic context.
+    ///
+    /// # Safety
+    ///
+    /// Assumes that `i` is in bounds.
+    #[cold]
+    fn use_page_slow(&self, i: usize) -> Result<()> {
+        let new_page = Pages::new()?;
+        // We use `mmput_async` when dropping the `mm` because `use_page_slow` is usually used from
+        // a remote process. If the call to `mmput` races with the process shutting down, then the
+        // caller of `use_page_slow` becomes responsible for cleaning up the `mm`, which doesn't
+        // happen until it returns to userspace. However, the caller might instead go to sleep and
+        // wait for the owner of the `mm` to wake it up, which doesn't happen because it's in the
+        // middle of a shutdown process that wont complete until the `mm` is dropped. This can
+        // amount to a deadlock.
+        //
+        // Using `mmput_async` avoids this, because then the `mm` cleanup is instead queued to a
+        // workqueue.
+        let mm = self.mm.mmget_not_zero().ok_or(ESRCH)?.use_async_put();
+        let mut mmap_lock = mm.mmap_write_lock();
+        let inner = self.lock.lock();
+
+        // SAFETY: This pointer offset is in bounds.
+        let page_info = unsafe { inner.pages.add(i) };
+
+        // SAFETY: The pointer is valid, and we hold the lock so reading from the page is okay.
+        if unsafe { PageInfo::has_page(page_info) } {
+            // The page was already there, or someone else added the page while we didn't hold the
+            // spinlock.
+            //
+            // SAFETY: The pointer is valid, and this is the right shrinker.
+            //
+            // The shrinker can't free the page between the check and this call to
+            // `list_lru_del` because we hold the lock.
+            unsafe { PageInfo::list_lru_del(page_info, self.shrinker) };
+            return Ok(());
+        }
+
+        let vma_addr = inner.vma_addr;
+        // Release the spinlock while we insert the page into the vma.
+        drop(inner);
+
+        let vma = mmap_lock.vma_lookup(vma_addr).ok_or(ESRCH)?;
+
+        // No overflow since we stay in bounds of the vma.
+        let user_page_addr = vma_addr + (i << PAGE_SHIFT);
+        match vma.insert_page(user_page_addr, &new_page) {
+            Ok(()) => {}
+            Err(err) => {
+                pr_warn!(
+                    "Error in insert_page({}): vma_addr:{} i:{} err:{:?}",
+                    user_page_addr,
+                    vma_addr,
+                    i,
+                    err
+                );
+                return Err(err);
+            }
+        }
+
+        let inner = self.lock.lock();
+
+        // SAFETY: The `page_info` pointer is valid and currently does not have a page. The page
+        // can be written to since we hold the lock.
+        //
+        // We released and reacquired the spinlock since we checked that the page is null, but we
+        // always hold the mmap write lock when setting the page to a non-null value, so it's not
+        // possible for someone else to have changed it since our check.
+        unsafe { PageInfo::set_page(page_info, new_page) };
+
+        drop(inner);
+
+        Ok(())
+    }
+
+    /// If the given page is in use, then mark it as available so that the shrinker can free it.
+    ///
+    /// May be called from an atomic context.
+    pub fn stop_using_range(&self, start: usize, end: usize) {
+        if start >= end {
+            return;
+        }
+        let inner = self.lock.lock();
+        assert!(end <= inner.size);
+
+        for i in (start..end).rev() {
+            // SAFETY: The pointer is in bounds.
+            let page_info = unsafe { inner.pages.add(i) };
+
+            // SAFETY: Okay for reading since we have the lock.
+            if unsafe { PageInfo::has_page(page_info) } {
+                // SAFETY: The pointer is valid, and it's the right shrinker.
+                unsafe { PageInfo::list_lru_add(page_info, self.shrinker) };
+            }
+        }
+    }
+
+    /// Helper for reading or writing to a range of bytes that may overlap with several pages.
+    ///
+    /// # Safety
+    ///
+    /// All pages touched by this operation must be in use for the duration of this call.
+    unsafe fn iterate<T>(&self, mut offset: usize, mut size: usize, mut cb: T) -> Result
+    where
+        T: FnMut(&Pages<0>, usize, usize) -> Result,
+    {
+        if size == 0 {
+            return Ok(());
+        }
+
+        // SAFETY: The caller promises that the pages touched by this call are in use. It's only
+        // possible for a page to be in use if we have already been registered with a vma, and we
+        // only change the `pages` and `size` fields during registration with a vma, so there is no
+        // race when we read them here without taking the lock.
+        let (pages, num_pages) = unsafe {
+            let inner = self.lock.get_ptr();
+            (
+                ptr::addr_of!((*inner).pages).read(),
+                ptr::addr_of!((*inner).size).read(),
+            )
+        };
+        let num_bytes = num_pages << PAGE_SHIFT;
+
+        // Check that the request is within the buffer.
+        if offset.checked_add(size).ok_or(EFAULT)? > num_bytes {
+            return Err(EFAULT);
+        }
+
+        let mut page_index = offset >> PAGE_SHIFT;
+        offset &= PAGE_MASK;
+        while size > 0 {
+            let available = usize::min(size, PAGE_SIZE - offset);
+            // SAFETY: The pointer is in bounds.
+            let page_info = unsafe { pages.add(page_index) };
+            // SAFETY: The caller guarantees that this page is in the "in use" state for the
+            // duration of this call to `iterate`, so nobody will change the page.
+            let page = unsafe { PageInfo::get_page(page_info) };
+            if page.is_none() {
+                pr_warn!("Page is null!");
+            }
+            let page = page.ok_or(EFAULT)?;
+            cb(page, offset, available)?;
+            size -= available;
+            page_index += 1;
+            offset = 0;
+        }
+        Ok(())
+    }
+
+    /// Copy from userspace into this page range.
+    ///
+    /// # Safety
+    ///
+    /// All pages touched by this operation must be in use for the duration of this call.
+    pub unsafe fn copy_into(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        size: usize,
+    ) -> Result {
+        // SAFETY: `self.iterate` has the same safety requirements as `copy_into`.
+        unsafe {
+            self.iterate(offset, size, |page, offset, to_copy| {
+                page.copy_into_page(reader, offset, to_copy)
+            })
+        }
+    }
+
+    /// Copy from this page range into kernel space.
+    ///
+    /// # Safety
+    ///
+    /// All pages touched by this operation must be in use for the duration of this call.
+    pub unsafe fn read<T: ReadableFromBytes>(&self, offset: usize) -> Result<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        let mut out_offset = 0;
+        // SAFETY: `self.iterate` has the same safety requirements as `copy_into`.
+        unsafe {
+            self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
+                // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
+                let obj_ptr = (out.as_mut_ptr() as *mut u8).add(out_offset);
+                // SAFETY: The pointer points is in-bounds of the `out` variable, so it is valid.
+                page.read(obj_ptr, offset, to_copy)?;
+                out_offset += to_copy;
+                Ok(())
+            })?;
+        }
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+
+    /// Copy from kernel space into this page range.
+    ///
+    /// # Safety
+    ///
+    /// All pages touched by this operation must be in use for the duration of this call.
+    pub unsafe fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
+        let mut obj_offset = 0;
+        // SAFETY: `self.iterate` has the same safety requirements as `copy_into`.
+        unsafe {
+            self.iterate(offset, size_of_val(obj), |page, offset, to_copy| {
+                // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
+                let obj_ptr = (obj as *const T as *const u8).add(obj_offset);
+                // SAFETY: We have a reference to the object, so the pointer is valid.
+                page.write(obj_ptr, offset, to_copy)?;
+                obj_offset += to_copy;
+                Ok(())
+            })
+        }
+    }
+
+    /// Write zeroes to the given range.
+    ///
+    /// # Safety
+    ///
+    /// All pages touched by this operation must be in use for the duration of this call.
+    pub unsafe fn fill_zero(&self, offset: usize, size: usize) -> Result {
+        // SAFETY: `self.iterate` has the same safety requirements as `copy_into`.
+        unsafe {
+            self.iterate(offset, size, |page, offset, len| {
+                page.fill_zero(offset, len)
+            })
+        }
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for ShrinkablePageRange {
+    fn drop(self: Pin<&mut Self>) {
+        let (pages, size) = {
+            let lock = self.lock.lock();
+            (lock.pages, lock.size)
+        };
+
+        if size == 0 {
+            return;
+        }
+
+        // This is the destructor, so unlike the other methods, we only need to worry about races
+        // with the shrinker here.
+        for i in 0..size {
+            // SAFETY: The pointer is valid and it's the right shrinker.
+            unsafe { PageInfo::list_lru_del(pages.add(i), self.shrinker) };
+            // SAFETY: If the shrinker was going to free this page, then it would have taken it
+            // from the PageInfo before releasing the lru lock. Thus, the call to `list_lru_del`
+            // will either remove it before the shrinker can access it, or the shrinker will
+            // already have taken the page at this point.
+            unsafe { drop(PageInfo::take_page(pages.add(i))) };
+        }
+
+        // SAFETY: This computation did not overflow when allocating the pages array, so it will
+        // not overflow this time.
+        let layout = unsafe { Layout::array::<PageInfo>(size).unwrap_unchecked() };
+
+        // SAFETY: The `pages` array was allocated with the same layout.
+        unsafe { alloc::alloc::dealloc(pages.cast(), layout) };
+    }
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_shrink_count(
+    shrink: *mut bindings::shrinker,
+    _sc: *mut bindings::shrink_control,
+) -> c_ulong {
+    // SAFETY: This method is only used with the `Shrinker` type, and the cast is valid since
+    // `shrinker` is the first field of a #[repr(C)] struct.
+    let shrinker = unsafe { &*shrink.cast::<Shrinker>() };
+    // SAFETY: Accessing the lru list is okay. Just an FFI call.
+    unsafe { bindings::list_lru_count(shrinker.list_lru.get()) }
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_shrink_scan(
+    shrink: *mut bindings::shrinker,
+    sc: *mut bindings::shrink_control,
+) -> c_ulong {
+    // SAFETY: This method is only used with the `Shrinker` type, and the cast is valid since
+    // `shrinker` is the first field of a #[repr(C)] struct.
+    let shrinker = unsafe { &*shrink.cast::<Shrinker>() };
+    // SAFETY: Caller guarantees that it is safe to read this field.
+    let nr_to_scan = unsafe { (*sc).nr_to_scan };
+    // SAFETY: Accessing the lru list is okay. Just an FFI call.
+    unsafe {
+        bindings::list_lru_walk(
+            shrinker.list_lru.get(),
+            Some(rust_shrink_free_page),
+            ptr::null_mut(),
+            nr_to_scan,
+        )
+    }
+}
+
+const LRU_SKIP: bindings::lru_status = bindings::lru_status_LRU_SKIP;
+const LRU_REMOVED_ENTRY: bindings::lru_status = bindings::lru_status_LRU_REMOVED_RETRY;
+
+#[no_mangle]
+unsafe extern "C" fn rust_shrink_free_page(
+    item: *mut bindings::list_head,
+    lru: *mut bindings::list_lru_one,
+    lru_lock: *mut bindings::spinlock_t,
+    _cb_arg: *mut c_void,
+) -> bindings::lru_status {
+    // Fields that should survive after unlocking the lru lock.
+    let page;
+    let page_index;
+    let mm;
+    let mmap_read;
+    let vma_addr;
+
+    {
+        // SAFETY: The `list_head` field is first in `PageInfo`.
+        let info = item as *mut PageInfo;
+        let range = unsafe { &*((*info).range) };
+
+        mm = match range.mm.mmget_not_zero() {
+            Some(mm) => mm.use_async_put(),
+            None => return LRU_SKIP,
+        };
+
+        mmap_read = match mm.mmap_read_trylock() {
+            Some(guard) => guard,
+            None => return LRU_SKIP,
+        };
+
+        // We can't lock it normally here, since we hold the lru lock.
+        let inner = match range.lock.trylock() {
+            Some(inner) => inner,
+            None => return LRU_SKIP,
+        };
+
+        // SAFETY: The item is in this lru list, so it's okay to remove it.
+        unsafe { bindings::list_lru_isolate(lru, item) };
+
+        // SAFETY: Both pointers are in bounds of the same allocation.
+        page_index = unsafe { info.offset_from(inner.pages) } as usize;
+
+        // SAFETY: We hold the spinlock, so we can take the page.
+        //
+        // This sets the page pointer to zero before we unmap it from the vma. However, we call
+        // `zap_page_range` before we release the mmap lock, so `use_page_slow` will not be able to
+        // insert a new page until after our call to `zap_page_range`.
+        page = unsafe { PageInfo::take_page(info) };
+        vma_addr = inner.vma_addr;
+
+        // From this point on, we don't access this PageInfo or ShrinkablePageRange again, because
+        // they can be freed at any point after we unlock `lru_lock`.
+    }
+
+    // SAFETY: The lru lock is locked when this method is called.
+    unsafe { bindings::spin_unlock(lru_lock) };
+
+    if let Some(vma) = mmap_read.vma_lookup(vma_addr) {
+        let user_page_addr = vma_addr + (page_index << PAGE_SHIFT);
+        vma.zap_page_range(user_page_addr, PAGE_SIZE);
+    }
+
+    drop(mmap_read);
+    drop(mm);
+    drop(page);
+
+    // SAFETY: We just unlocked the lru lock, but it should be locked when we return.
+    unsafe { bindings::spin_lock(lru_lock) };
+
+    LRU_REMOVED_ENTRY
+}
diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
index 149a5259d431..8cf02edb6f4a 100644
--- a/rust/kernel/sync/lock.rs
+++ b/rust/kernel/sync/lock.rs
@@ -51,6 +51,14 @@ unsafe fn init(
     #[must_use]
     unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
 
+    /// Tries to acquire the lock, making the caller its owner.
+    ///
+    /// # Safety
+    ///
+    /// Callers must ensure that [`Backend::init`] has been previously called.
+    #[must_use]
+    unsafe fn trylock(ptr: *mut Self::State) -> Option<Self::GuardState>;
+
     /// Releases the lock, giving up its ownership.
     ///
     /// # Safety
@@ -121,6 +129,22 @@ pub fn lock(&self) -> Guard<'_, T, B> {
         // SAFETY: The lock was just acquired.
         unsafe { Guard::new(self, state) }
     }
+
+    /// Acquires the lock and gives the caller access to the data protected by it.
+    pub fn trylock(&self) -> Option<Guard<'_, T, B>> {
+        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
+        // that `init` was called.
+        let state = unsafe { B::trylock(self.state.get())? };
+        // SAFETY: The lock was just acquired.
+        unsafe { Some(Guard::new(self, state)) }
+    }
+
+    /// Get a raw pointer to the data without touching the lock.
+    ///
+    /// It is up to the user to make sure that the pointer is used correctly.
+    pub fn get_ptr(&self) -> *mut T {
+        self.data.get()
+    }
 }
 
 /// A lock guard.
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 09276fedc091..0871d0034174 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -111,6 +111,16 @@ unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         unsafe { bindings::mutex_lock(ptr) };
     }
 
+    unsafe fn trylock(ptr: *mut Self::State) -> Option<Self::GuardState> {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        if unsafe { bindings::mutex_trylock(ptr) } != 0 {
+            Some(())
+        } else {
+            None
+        }
+    }
+
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 91eb2c9e9123..64ff1fcf36c4 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -110,6 +110,16 @@ unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState {
         unsafe { bindings::spin_lock(ptr) }
     }
 
+    unsafe fn trylock(ptr: *mut Self::State) -> Option<Self::GuardState> {
+        // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
+        // memory, and that it has been initialised before.
+        if unsafe { bindings::spin_trylock(ptr) } != 0 {
+            Some(())
+        } else {
+            None
+        }
+    }
+
     unsafe fn unlock(ptr: *mut Self::State, _guard_state: &Self::GuardState) {
         // SAFETY: The safety requirements of this function ensure that `ptr` is valid and that the
         // caller is the owner of the mutex.

-- 
2.42.0.820.g83a721a137-goog

