Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39CB87DE5D0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344905AbjKASDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344838AbjKASDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:01 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8E7123
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:32 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id 4fb4d7f45d1cf-53fa5cd4480so38820a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861751; x=1699466551; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp/lYPgceSFtl5mqvD/Fgl0DfL4AQ8R2jryIb+qcHAY=;
        b=vBMedMD2MPVD8k4enKCq6Sr+6/1vpW7Hswg8g48Dg8DBOVLjjBhnnfoJRL6UxXZHfu
         R1bN7r96R44QRljgfYMNJP48ooo2zD67e2Nkx2pppztEAMuL5Ekl23+DfkqPRV5SuvV4
         UHUMVGjKW/Lc8IKh3u5IZ0rARYPyyXuWBPdcmL+KD9g1Y27ONF2kiVJrCvsMhN4qHTTu
         FGH3FlKvXh81xgIjFL0mUXX8i4FZXMASDujKMHV5HFF+E0TaxpMMxodrW1yppnxuk0qg
         r/yTqZSuQY3nBEz70Vu/qcgfzdkxfoecmbUmvMC/e421AKaURiOZFAKFYpUVEb6/dsU6
         VWBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861751; x=1699466551;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp/lYPgceSFtl5mqvD/Fgl0DfL4AQ8R2jryIb+qcHAY=;
        b=NkFUTPqSghTHxuvrrcaoQTm/QztwzsR2PuyyXPw6ejmxDY5jq/FWtSRSzlxhUfrFlu
         eedJ8oZn6ijA25ccANd6aSZMWHPwYKo3IFMdlnZ48rdbwnEGF5z8K1rO+m42RY+V0u80
         WBz+VbfCuWpHfx8FPkVDu9T2nkH34uyJ5FrFKEh9nb2H8iBx7iAe6EsM2ak5bzzHUSqX
         MBOzKjKq06YHjvPNreaZi/BAW+ElwkY7oXMbNsff1Yag6NmDBBvhHyWKO4TAlSXMN5PY
         5czpZdgZutvQjHLSvvrpVvMzPc5Qgu0eycBI4HZeBZwqFYK/k8f6YMIMPR3fdo91ExIU
         nUaQ==
X-Gm-Message-State: AOJu0Yz0C29Aovg2lS0nOn0Dfj1iS3rtwie7Khe3biiVK7ldgTC9jd6O
        RQUVNmkU98Gp/Oi9k4Z7RY4uxr+2/7/gd4k=
X-Google-Smtp-Source: AGHT+IF96Pd4EB6Pg1V3nooK6OgNS9Rk5QtTxwE9+NXgv+ryEf/ll+SdWHRo6dwSbXONpXgP7ndYk3h8dDEWwUo=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:e84:b0:53d:bc68:51fc with SMTP
 id h4-20020a0564020e8400b0053dbc6851fcmr151990eda.2.1698861750910; Wed, 01
 Nov 2023 11:02:30 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:36 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-6-08ba9197f637@google.com>
Subject: [PATCH RFC 06/20] rust_binder: add oneway transactions
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
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for sending oneway transactions using the binder driver.

To receive transactions, the process must first use mmap to create a
memory region for holding the contents of incoming transactions. The
driver will manage the resulting memory using two files: `allocation.rs`
and `range_alloc.rs`.

The `allocation.rs` file is responsible for actually managing the
mmap'ed region of memory and has methods for writing to it.

The `range_alloc.rs` file contains a data structure for tracking where
in the mmap we are storing different things. It doesn't actually touch
the mmap itself. Basically, it's a data structure that stores a set of
non-overlapping intervals (the allocations) and it is able to find the
smallest offset where the next X bytes are free and allocate that
region.

Other than that, this patch introduces a `Transaction` struct that
stores the information related to a transaction, and adds the necessary
infrastructure to send and receive them. This uses the work lists
introduces in a previous patch to deliver incoming transactions.

There are several different possible implementations of the range
allocator, and we have implemented several of them. The simplest
possible implementation is to use a linked list to store the allocations
and free regions sorted by address. Another possibility is to store the
same thing using a red-black tree. The red-black tree is preferable to
the linked list because its accesses are logarithmic rather than linear.

This RFC implements the range allocator using a red-black tree.

We have also looked into replacing the red-black tree with an XArray.
However, this is challenging because it doesn't have a good way to look
up the smallest free region whose size is at least some lower bound. You
can use `xa_find`, but there could be many free regions of the same
size, which makes it a challenge to maintain this information correctly.
We also run into issues with having to allocate while holding a lock.
Finally, the XArray is not optimized for this use-case: all of the
indices are going to have gaps between them.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Matt Gilbride <mattgilbride@google.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  | 140 +++++++++++++++++
 drivers/android/defs.rs        |  39 +++++
 drivers/android/error.rs       |  10 ++
 drivers/android/node.rs        |   1 -
 drivers/android/process.rs     | 171 ++++++++++++++++++--
 drivers/android/range_alloc.rs | 344 +++++++++++++++++++++++++++++++++++++++++
 drivers/android/rust_binder.rs |  54 +++++++
 drivers/android/thread.rs      | 208 +++++++++++++++++++++++--
 drivers/android/transaction.rs | 163 +++++++++++++++++++
 rust/helpers.c                 |   7 +
 rust/kernel/security.rs        |   7 +
 11 files changed, 1123 insertions(+), 21 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
new file mode 100644
index 000000000000..1ab0f254fded
--- /dev/null
+++ b/drivers/android/allocation.rs
@@ -0,0 +1,140 @@
+// SPDX-License-Identifier: GPL-2.0
+use core::mem::size_of_val;
+
+use kernel::{bindings, pages::Pages, prelude::*, sync::Arc, user_ptr::UserSlicePtrReader};
+
+use crate::{node::NodeRef, process::Process};
+
+#[derive(Default)]
+pub(crate) struct AllocationInfo {
+    /// The target node of the transaction this allocation is associated to.
+    /// Not set for replies.
+    pub(crate) target_node: Option<NodeRef>,
+    /// Zero the data in the buffer on free.
+    pub(crate) clear_on_free: bool,
+}
+
+/// Represents an allocation that the kernel is currently using.
+///
+/// When allocations are idle, the range allocator holds the data related to them.
+pub(crate) struct Allocation {
+    pub(crate) offset: usize,
+    size: usize,
+    pub(crate) ptr: usize,
+    pages: Arc<Vec<Pages<0>>>,
+    pub(crate) process: Arc<Process>,
+    allocation_info: Option<AllocationInfo>,
+    free_on_drop: bool,
+}
+
+impl Allocation {
+    pub(crate) fn new(
+        process: Arc<Process>,
+        offset: usize,
+        size: usize,
+        ptr: usize,
+        pages: Arc<Vec<Pages<0>>>,
+    ) -> Self {
+        Self {
+            process,
+            offset,
+            size,
+            ptr,
+            pages,
+            allocation_info: None,
+            free_on_drop: true,
+        }
+    }
+
+    fn iterate<T>(&self, mut offset: usize, mut size: usize, mut cb: T) -> Result
+    where
+        T: FnMut(&Pages<0>, usize, usize) -> Result,
+    {
+        // Check that the request is within the buffer.
+        if offset.checked_add(size).ok_or(EINVAL)? > self.size {
+            return Err(EINVAL);
+        }
+        offset += self.offset;
+        let mut page_index = offset >> bindings::PAGE_SHIFT;
+        offset &= (1 << bindings::PAGE_SHIFT) - 1;
+        while size > 0 {
+            let available = core::cmp::min(size, (1 << bindings::PAGE_SHIFT) - offset);
+            cb(&self.pages[page_index], offset, available)?;
+            size -= available;
+            page_index += 1;
+            offset = 0;
+        }
+        Ok(())
+    }
+
+    pub(crate) fn copy_into(
+        &self,
+        reader: &mut UserSlicePtrReader,
+        offset: usize,
+        size: usize,
+    ) -> Result {
+        self.iterate(offset, size, |page, offset, to_copy| {
+            page.copy_into_page(reader, offset, to_copy)
+        })
+    }
+
+    pub(crate) fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
+        let mut obj_offset = 0;
+        self.iterate(offset, size_of_val(obj), |page, offset, to_copy| {
+            // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
+            let obj_ptr = unsafe { (obj as *const T as *const u8).add(obj_offset) };
+            // SAFETY: We have a reference to the object, so the pointer is valid.
+            unsafe { page.write(obj_ptr, offset, to_copy) }?;
+            obj_offset += to_copy;
+            Ok(())
+        })
+    }
+
+    pub(crate) fn fill_zero(&self) -> Result {
+        self.iterate(0, self.size, |page, offset, len| {
+            page.fill_zero(offset, len)
+        })
+    }
+
+    pub(crate) fn keep_alive(mut self) {
+        self.process
+            .buffer_make_freeable(self.offset, self.allocation_info.take());
+        self.free_on_drop = false;
+    }
+
+    pub(crate) fn set_info(&mut self, info: AllocationInfo) {
+        self.allocation_info = Some(info);
+    }
+
+    pub(crate) fn get_or_init_info(&mut self) -> &mut AllocationInfo {
+        self.allocation_info.get_or_insert_with(Default::default)
+    }
+
+    pub(crate) fn set_info_clear_on_drop(&mut self) {
+        self.get_or_init_info().clear_on_free = true;
+    }
+
+    pub(crate) fn set_info_target_node(&mut self, target_node: NodeRef) {
+        self.get_or_init_info().target_node = Some(target_node);
+    }
+}
+
+impl Drop for Allocation {
+    fn drop(&mut self) {
+        if !self.free_on_drop {
+            return;
+        }
+
+        if let Some(mut info) = self.allocation_info.take() {
+            info.target_node = None;
+
+            if info.clear_on_free {
+                if let Err(e) = self.fill_zero() {
+                    pr_warn!("Failed to clear data on free: {:?}", e);
+                }
+            }
+        }
+
+        self.process.buffer_raw_free(self.ptr);
+    }
+}
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 8a83df975e61..d0fc00fa5a57 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -14,6 +14,9 @@ macro_rules! pub_no_prefix {
 
 pub_no_prefix!(
     binder_driver_return_protocol_,
+    BR_TRANSACTION,
+    BR_TRANSACTION_SEC_CTX,
+    BR_REPLY,
     BR_DEAD_REPLY,
     BR_FAILED_REPLY,
     BR_NOOP,
@@ -28,6 +31,9 @@ macro_rules! pub_no_prefix {
 
 pub_no_prefix!(
     binder_driver_command_protocol_,
+    BC_TRANSACTION,
+    BC_TRANSACTION_SG,
+    BC_FREE_BUFFER,
     BC_ENTER_LOOPER,
     BC_EXIT_LOOPER,
     BC_REGISTER_LOOPER,
@@ -39,6 +45,10 @@ macro_rules! pub_no_prefix {
     BC_ACQUIRE_DONE
 );
 
+pub(crate) const FLAT_BINDER_FLAG_TXN_SECURITY_CTX: u32 =
+    kernel::bindings::FLAT_BINDER_FLAG_TXN_SECURITY_CTX;
+pub_no_prefix!(transaction_flags_, TF_ONE_WAY, TF_CLEAR_BUF);
+
 macro_rules! decl_wrapper {
     ($newname:ident, $wrapped:ty) => {
         #[derive(Copy, Clone, Default)]
@@ -67,6 +77,15 @@ fn deref_mut(&mut self) -> &mut Self::Target {
 decl_wrapper!(BinderNodeDebugInfo, bindings::binder_node_debug_info);
 decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
 decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
+decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
+decl_wrapper!(
+    BinderTransactionDataSecctx,
+    bindings::binder_transaction_data_secctx
+);
+decl_wrapper!(
+    BinderTransactionDataSg,
+    bindings::binder_transaction_data_sg
+);
 decl_wrapper!(BinderWriteRead, bindings::binder_write_read);
 decl_wrapper!(BinderVersion, bindings::binder_version);
 decl_wrapper!(ExtendedError, bindings::binder_extended_error);
@@ -79,6 +98,26 @@ pub(crate) fn current() -> Self {
     }
 }
 
+impl BinderTransactionData {
+    pub(crate) fn with_buffers_size(self, buffers_size: u64) -> BinderTransactionDataSg {
+        BinderTransactionDataSg(bindings::binder_transaction_data_sg {
+            transaction_data: self.0,
+            buffers_size,
+        })
+    }
+}
+
+impl BinderTransactionDataSecctx {
+    /// View the inner data as wrapped in `BinderTransactionData`.
+    pub(crate) fn tr_data(&mut self) -> &mut BinderTransactionData {
+        // SAFETY: Transparent wrapper is safe to transmute.
+        unsafe {
+            &mut *(&mut self.transaction_data as *mut bindings::binder_transaction_data
+                as *mut BinderTransactionData)
+        }
+    }
+}
+
 impl ExtendedError {
     pub(crate) fn new(id: u32, command: u32, param: i32) -> Self {
         Self(bindings::binder_extended_error { id, command, param })
diff --git a/drivers/android/error.rs b/drivers/android/error.rs
index a31b696efafc..430b0994affa 100644
--- a/drivers/android/error.rs
+++ b/drivers/android/error.rs
@@ -4,6 +4,8 @@
 
 use crate::defs::*;
 
+pub(crate) type BinderResult<T = ()> = core::result::Result<T, BinderError>;
+
 /// An error that will be returned to userspace via the `BINDER_WRITE_READ` ioctl rather than via
 /// errno.
 pub(crate) struct BinderError {
@@ -18,6 +20,14 @@ pub(crate) fn new_dead() -> Self {
             source: None,
         }
     }
+
+    pub(crate) fn is_dead(&self) -> bool {
+        self.reply == BR_DEAD_REPLY
+    }
+
+    pub(crate) fn as_errno(&self) -> core::ffi::c_int {
+        self.source.unwrap_or(EINVAL).to_errno()
+    }
 }
 
 /// Convert an errno into a `BinderError` and store the errno used to construct it. The errno
diff --git a/drivers/android/node.rs b/drivers/android/node.rs
index 0ca4b72b8710..c6c3d81e705d 100644
--- a/drivers/android/node.rs
+++ b/drivers/android/node.rs
@@ -49,7 +49,6 @@ pub(crate) struct Node {
     pub(crate) global_id: u64,
     ptr: usize,
     cookie: usize,
-    #[allow(dead_code)]
     pub(crate) flags: u32,
     pub(crate) owner: Arc<Process>,
     inner: LockedBy<NodeInner, ProcessInner>,
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 2d8aa29776a1..26dd9309fbee 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -17,6 +17,7 @@
     io_buffer::{IoBufferReader, IoBufferWriter},
     list::{HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks},
     mm,
+    pages::Pages,
     prelude::*,
     rbtree::RBTree,
     sync::{lock::Guard, Arc, ArcBorrow, Mutex, SpinLock},
@@ -27,16 +28,35 @@
 };
 
 use crate::{
+    allocation::{Allocation, AllocationInfo},
     context::Context,
     defs::*,
-    error::BinderError,
+    error::{BinderError, BinderResult},
     node::{Node, NodeRef},
+    range_alloc::{self, RangeAllocator},
     thread::{PushWorkRes, Thread},
     DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
 use core::mem::take;
 
+struct Mapping {
+    address: usize,
+    alloc: RangeAllocator<AllocationInfo>,
+    pages: Arc<Vec<Pages<0>>>,
+}
+
+impl Mapping {
+    fn new(address: usize, size: usize, pages: Arc<Vec<Pages<0>>>) -> Result<Self> {
+        let alloc = RangeAllocator::new(size)?;
+        Ok(Self {
+            address,
+            alloc,
+            pages,
+        })
+    }
+}
+
 const PROC_DEFER_FLUSH: u8 = 1;
 const PROC_DEFER_RELEASE: u8 = 2;
 
@@ -47,6 +67,7 @@ pub(crate) struct ProcessInner {
     threads: RBTree<i32, Arc<Thread>>,
     ready_threads: List<Thread>,
     nodes: RBTree<usize, DArc<Node>>,
+    mapping: Option<Mapping>,
     work: List<DTRWrap<dyn DeliverToRead>>,
 
     /// The number of requested threads that haven't registered yet.
@@ -67,6 +88,7 @@ fn new() -> Self {
             is_dead: false,
             threads: RBTree::new(),
             ready_threads: List::new(),
+            mapping: None,
             nodes: RBTree::new(),
             work: List::new(),
             requested_thread_count: 0,
@@ -459,6 +481,15 @@ pub(crate) fn insert_or_update_handle(
         Ok(target)
     }
 
+    pub(crate) fn get_transaction_node(&self, handle: u32) -> BinderResult<NodeRef> {
+        // When handle is zero, try to get the context manager.
+        if handle == 0 {
+            Ok(self.ctx.get_manager_node(true)?)
+        } else {
+            Ok(self.get_node_from_handle(handle, true)?)
+        }
+    }
+
     pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<NodeRef> {
         self.node_refs
             .lock()
@@ -511,6 +542,97 @@ pub(crate) fn inc_ref_done(&self, reader: &mut UserSlicePtrReader, strong: bool)
         Ok(())
     }
 
+    pub(crate) fn buffer_alloc(
+        self: &Arc<Self>,
+        size: usize,
+        is_oneway: bool,
+    ) -> BinderResult<Allocation> {
+        let alloc = range_alloc::ReserveNewBox::try_new()?;
+        let mut inner = self.inner.lock();
+        let mapping = inner.mapping.as_mut().ok_or_else(BinderError::new_dead)?;
+        let offset = mapping.alloc.reserve_new(size, is_oneway, alloc)?;
+        Ok(Allocation::new(
+            self.clone(),
+            offset,
+            size,
+            mapping.address + offset,
+            mapping.pages.clone(),
+        ))
+    }
+
+    pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
+        let mut inner = self.inner.lock();
+        let mapping = inner.mapping.as_mut()?;
+        let offset = ptr.checked_sub(mapping.address)?;
+        let (size, odata) = mapping.alloc.reserve_existing(offset).ok()?;
+        let mut alloc = Allocation::new(self.clone(), offset, size, ptr, mapping.pages.clone());
+        if let Some(data) = odata {
+            alloc.set_info(data);
+        }
+        Some(alloc)
+    }
+
+    pub(crate) fn buffer_raw_free(&self, ptr: usize) {
+        let mut inner = self.inner.lock();
+        if let Some(ref mut mapping) = &mut inner.mapping {
+            if ptr < mapping.address
+                || mapping
+                    .alloc
+                    .reservation_abort(ptr - mapping.address)
+                    .is_err()
+            {
+                pr_warn!(
+                    "Pointer {:x} failed to free, base = {:x}\n",
+                    ptr,
+                    mapping.address
+                );
+            }
+        }
+    }
+
+    pub(crate) fn buffer_make_freeable(&self, offset: usize, data: Option<AllocationInfo>) {
+        let mut inner = self.inner.lock();
+        if let Some(ref mut mapping) = &mut inner.mapping {
+            if mapping.alloc.reservation_commit(offset, data).is_err() {
+                pr_warn!("Offset {} failed to be marked freeable\n", offset);
+            }
+        }
+    }
+
+    fn create_mapping(&self, vma: &mut mm::virt::Area) -> Result {
+        use kernel::bindings::PAGE_SIZE;
+        let size = core::cmp::min(vma.end() - vma.start(), bindings::SZ_4M as usize);
+        let page_count = size / PAGE_SIZE;
+
+        // Allocate and map all pages.
+        //
+        // N.B. If we fail halfway through mapping these pages, the kernel will unmap them.
+        let mut pages = Vec::new();
+        pages.try_reserve_exact(page_count)?;
+        let mut address = vma.start();
+        for _ in 0..page_count {
+            let page = Pages::<0>::new()?;
+            vma.insert_page(address, &page)?;
+            pages.try_push(page)?;
+            address += PAGE_SIZE;
+        }
+
+        let ref_pages = Arc::try_new(pages)?;
+        let mapping = Mapping::new(vma.start(), size, ref_pages)?;
+
+        // Save pages for later.
+        let mut inner = self.inner.lock();
+        match &inner.mapping {
+            None => inner.mapping = Some(mapping),
+            Some(_) => {
+                drop(inner);
+                drop(mapping);
+                return Err(EBUSY);
+            }
+        }
+        Ok(())
+    }
+
     fn version(&self, data: UserSlicePtr) -> Result {
         data.writer().write(&BinderVersion::current())
     }
@@ -610,11 +732,6 @@ fn deferred_release(self: Arc<Self>) {
 
         self.ctx.deregister_process(&self);
 
-        // Cancel all pending work items.
-        while let Some(work) = self.get_work() {
-            work.into_arc().cancel();
-        }
-
         // Move the threads out of `inner` so that we can iterate over them without holding the
         // lock.
         let mut inner = self.inner.lock();
@@ -625,6 +742,26 @@ fn deferred_release(self: Arc<Self>) {
         for thread in threads.values() {
             thread.release();
         }
+
+        // Cancel all pending work items.
+        while let Some(work) = self.get_work() {
+            work.into_arc().cancel();
+        }
+
+        // Free any resources kept alive by allocated buffers.
+        let omapping = self.inner.lock().mapping.take();
+        if let Some(mut mapping) = omapping {
+            let address = mapping.address;
+            let pages = mapping.pages.clone();
+            mapping.alloc.take_for_each(|offset, size, odata| {
+                let ptr = offset + address;
+                let mut alloc = Allocation::new(self.clone(), offset, size, ptr, pages.clone());
+                if let Some(data) = odata {
+                    alloc.set_info(data);
+                }
+                drop(alloc)
+            });
+        }
     }
 
     pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
@@ -736,11 +873,27 @@ pub(crate) fn compat_ioctl(
     }
 
     pub(crate) fn mmap(
-        _this: ArcBorrow<'_, Process>,
+        this: ArcBorrow<'_, Process>,
         _file: &File,
-        _vma: &mut mm::virt::Area,
+        vma: &mut mm::virt::Area,
     ) -> Result {
-        Err(EINVAL)
+        // We don't allow mmap to be used in a different process.
+        if !core::ptr::eq(kernel::current!().group_leader(), &*this.task) {
+            return Err(EINVAL);
+        }
+        if vma.start() == 0 {
+            return Err(EINVAL);
+        }
+        let mut flags = vma.flags();
+        use mm::virt::flags::*;
+        if flags & WRITE != 0 {
+            return Err(EPERM);
+        }
+        flags |= DONTCOPY | MIXEDMAP;
+        flags &= !MAYWRITE;
+        vma.set_flags(flags);
+        // TODO: Set ops. We need to learn when the user unmaps so that we can stop using it.
+        this.create_mapping(vma)
     }
 
     pub(crate) fn poll(
diff --git a/drivers/android/range_alloc.rs b/drivers/android/range_alloc.rs
new file mode 100644
index 000000000000..e757129613cf
--- /dev/null
+++ b/drivers/android/range_alloc.rs
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    prelude::*,
+    rbtree::{RBTree, RBTreeNode, RBTreeNodeReservation},
+};
+
+/// Keeps track of allocations in a process' mmap.
+///
+/// Each process has an mmap where the data for incoming transactions will be placed. This struct
+/// keeps track of allocations made in the mmap. For each allocation, we store a descriptor that
+/// has metadata related to the allocation. We also keep track of available free space.
+pub(crate) struct RangeAllocator<T> {
+    tree: RBTree<usize, Descriptor<T>>,
+    free_tree: RBTree<FreeKey, ()>,
+    free_oneway_space: usize,
+}
+
+impl<T> RangeAllocator<T> {
+    pub(crate) fn new(size: usize) -> Result<Self> {
+        let mut tree = RBTree::new();
+        tree.try_create_and_insert(0, Descriptor::new(0, size))?;
+        let mut free_tree = RBTree::new();
+        free_tree.try_create_and_insert((size, 0), ())?;
+        Ok(Self {
+            free_oneway_space: size / 2,
+            tree,
+            free_tree,
+        })
+    }
+
+    fn find_best_match(&mut self, size: usize) -> Option<&mut Descriptor<T>> {
+        let free_cursor = self.free_tree.cursor_lower_bound(&(size, 0))?;
+        let ((_, offset), _) = free_cursor.current();
+        self.tree.get_mut(offset)
+    }
+
+    /// Try to reserve a new buffer, using the provided allocation if necessary.
+    pub(crate) fn reserve_new(
+        &mut self,
+        size: usize,
+        is_oneway: bool,
+        alloc: ReserveNewBox<T>,
+    ) -> Result<usize> {
+        // Compute new value of free_oneway_space, which is set only on success.
+        let new_oneway_space = if is_oneway {
+            match self.free_oneway_space.checked_sub(size) {
+                Some(new_oneway_space) => new_oneway_space,
+                None => return Err(ENOSPC),
+            }
+        } else {
+            self.free_oneway_space
+        };
+
+        let (found_size, found_off, tree_node, free_tree_node) = match self.find_best_match(size) {
+            None => {
+                pr_warn!("ENOSPC from range_alloc.reserve_new - size: {}", size);
+                return Err(ENOSPC);
+            }
+            Some(desc) => {
+                let found_size = desc.size;
+                let found_offset = desc.offset;
+
+                // In case we need to break up the descriptor
+                let new_desc = Descriptor::new(found_offset + size, found_size - size);
+                let (tree_node, free_tree_node, desc_node_res) = alloc.initialize(new_desc);
+
+                desc.state = Some(DescriptorState::new(is_oneway, desc_node_res));
+                desc.size = size;
+
+                (found_size, found_offset, tree_node, free_tree_node)
+            }
+        };
+        self.free_oneway_space = new_oneway_space;
+        self.free_tree.remove(&(found_size, found_off));
+
+        if found_size != size {
+            self.tree.insert(tree_node);
+            self.free_tree.insert(free_tree_node);
+        }
+
+        Ok(found_off)
+    }
+
+    pub(crate) fn reservation_abort(&mut self, offset: usize) -> Result {
+        let mut cursor = self.tree.cursor_lower_bound(&offset).ok_or_else(|| {
+            pr_warn!(
+                "EINVAL from range_alloc.reservation_abort - offset: {}",
+                offset
+            );
+            EINVAL
+        })?;
+
+        let (_, desc) = cursor.current_mut();
+
+        if desc.offset != offset {
+            pr_warn!(
+                "EINVAL from range_alloc.reservation_abort - offset: {}",
+                offset
+            );
+            return Err(EINVAL);
+        }
+
+        let reservation = desc.try_change_state(|state| match state {
+            Some(DescriptorState::Reserved(reservation)) => (None, Ok(reservation)),
+            None => {
+                pr_warn!(
+                    "EINVAL from range_alloc.reservation_abort - offset: {}",
+                    offset
+                );
+                (None, Err(EINVAL))
+            }
+            allocated => {
+                pr_warn!(
+                    "EPERM from range_alloc.reservation_abort - offset: {}",
+                    offset
+                );
+                (allocated, Err(EPERM))
+            }
+        })?;
+
+        let mut size = desc.size;
+        let mut offset = desc.offset;
+        let free_oneway_space_add = if reservation.is_oneway { size } else { 0 };
+
+        self.free_oneway_space += free_oneway_space_add;
+
+        // Merge next into current if next is free
+        let remove_next = match cursor.peek_next() {
+            Some((_, next)) if next.state.is_none() => {
+                self.free_tree.remove(&(next.size, next.offset));
+                size += next.size;
+                true
+            }
+            _ => false,
+        };
+
+        if remove_next {
+            let (_, desc) = cursor.current_mut();
+            desc.size = size;
+            cursor.remove_next();
+        }
+
+        // Merge current into prev if prev is free
+        match cursor.peek_prev_mut() {
+            Some((_, prev)) if prev.state.is_none() => {
+                // merge previous with current, remove current
+                self.free_tree.remove(&(prev.size, prev.offset));
+                offset = prev.offset;
+                size += prev.size;
+                prev.size = size;
+                cursor.remove_current();
+            }
+            _ => {}
+        };
+
+        self.free_tree
+            .insert(reservation.free_res.into_node((size, offset), ()));
+
+        Ok(())
+    }
+
+    pub(crate) fn reservation_commit(&mut self, offset: usize, data: Option<T>) -> Result {
+        let desc = self.tree.get_mut(&offset).ok_or_else(|| {
+            pr_warn!(
+                "ENOENT from range_alloc.reservation_commit - offset: {}",
+                offset
+            );
+            ENOENT
+        })?;
+
+        desc.try_change_state(|state| match state {
+            Some(DescriptorState::Reserved(reservation)) => (
+                Some(DescriptorState::Allocated(reservation.allocate(data))),
+                Ok(()),
+            ),
+            other => {
+                pr_warn!(
+                    "ENOENT from range_alloc.reservation_commit - offset: {}",
+                    offset
+                );
+                (other, Err(ENOENT))
+            }
+        })
+    }
+
+    /// Takes an entry at the given offset from [`DescriptorState::Allocated`] to
+    /// [`DescriptorState::Reserved`].
+    ///
+    /// Returns the size of the existing entry and the data associated with it.
+    pub(crate) fn reserve_existing(&mut self, offset: usize) -> Result<(usize, Option<T>)> {
+        let desc = self.tree.get_mut(&offset).ok_or_else(|| {
+            pr_warn!(
+                "ENOENT from range_alloc.reserve_existing - offset: {}",
+                offset
+            );
+            ENOENT
+        })?;
+
+        let data = desc.try_change_state(|state| match state {
+            Some(DescriptorState::Allocated(allocation)) => {
+                let (reservation, data) = allocation.deallocate();
+                (Some(DescriptorState::Reserved(reservation)), Ok(data))
+            }
+            other => {
+                pr_warn!(
+                    "ENOENT from range_alloc.reserve_existing - offset: {}",
+                    offset
+                );
+                (other, Err(ENOENT))
+            }
+        })?;
+
+        Ok((desc.size, data))
+    }
+
+    /// Call the provided callback at every allocated region.
+    ///
+    /// This destroys the range allocator. Used only during shutdown.
+    pub(crate) fn take_for_each<F: Fn(usize, usize, Option<T>)>(&mut self, callback: F) {
+        for (_, desc) in self.tree.iter_mut() {
+            if let Some(DescriptorState::Allocated(allocation)) = &mut desc.state {
+                callback(desc.offset, desc.size, allocation.take());
+            }
+        }
+    }
+}
+
+struct Descriptor<T> {
+    size: usize,
+    offset: usize,
+    state: Option<DescriptorState<T>>,
+}
+
+impl<T> Descriptor<T> {
+    fn new(offset: usize, size: usize) -> Self {
+        Self {
+            size,
+            offset,
+            state: None,
+        }
+    }
+
+    fn try_change_state<F, Data>(&mut self, f: F) -> Result<Data>
+    where
+        F: FnOnce(Option<DescriptorState<T>>) -> (Option<DescriptorState<T>>, Result<Data>),
+    {
+        let (new_state, result) = f(self.state.take());
+        self.state = new_state;
+        result
+    }
+}
+
+enum DescriptorState<T> {
+    Reserved(Reservation),
+    Allocated(Allocation<T>),
+}
+
+impl<T> DescriptorState<T> {
+    fn new(is_oneway: bool, free_res: FreeNodeRes) -> Self {
+        DescriptorState::Reserved(Reservation {
+            is_oneway,
+            free_res,
+        })
+    }
+}
+
+struct Reservation {
+    is_oneway: bool,
+    free_res: FreeNodeRes,
+}
+
+impl Reservation {
+    fn allocate<T>(self, data: Option<T>) -> Allocation<T> {
+        Allocation {
+            data,
+            is_oneway: self.is_oneway,
+            free_res: self.free_res,
+        }
+    }
+}
+
+struct Allocation<T> {
+    is_oneway: bool,
+    free_res: FreeNodeRes,
+    data: Option<T>,
+}
+
+impl<T> Allocation<T> {
+    fn deallocate(self) -> (Reservation, Option<T>) {
+        (
+            Reservation {
+                is_oneway: self.is_oneway,
+                free_res: self.free_res,
+            },
+            self.data,
+        )
+    }
+
+    fn take(&mut self) -> Option<T> {
+        self.data.take()
+    }
+}
+
+// (Descriptor.size, Descriptor.offset)
+type FreeKey = (usize, usize);
+type FreeNodeRes = RBTreeNodeReservation<FreeKey, ()>;
+
+/// An allocation for use by `reserve_new`.
+pub(crate) struct ReserveNewBox<T> {
+    tree_node_res: RBTreeNodeReservation<usize, Descriptor<T>>,
+    free_tree_node_res: FreeNodeRes,
+    desc_node_res: FreeNodeRes,
+}
+
+impl<T> ReserveNewBox<T> {
+    pub(crate) fn try_new() -> Result<Self> {
+        let tree_node_res = RBTree::try_reserve_node()?;
+        let free_tree_node_res = RBTree::try_reserve_node()?;
+        let desc_node_res = RBTree::try_reserve_node()?;
+        Ok(Self {
+            tree_node_res,
+            free_tree_node_res,
+            desc_node_res,
+        })
+    }
+
+    fn initialize(
+        self,
+        desc: Descriptor<T>,
+    ) -> (
+        RBTreeNode<usize, Descriptor<T>>,
+        RBTreeNode<FreeKey, ()>,
+        FreeNodeRes,
+    ) {
+        let size = desc.size;
+        let offset = desc.offset;
+        (
+            self.tree_node_res.into_node(offset, desc),
+            self.free_tree_node_res.into_node((size, offset), ()),
+            self.desc_node_res,
+        )
+    }
+}
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 2ef37cc2c556..218c2001e8cb 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -5,6 +5,7 @@
 use kernel::{
     bindings::{self, seq_file},
     file::{File, PollTable},
+    io_buffer::IoBufferWriter,
     list::{
         HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks, ListLinksSelfPtr, TryNewListArc,
     },
@@ -16,12 +17,17 @@
 
 use crate::{context::Context, process::Process, thread::Thread};
 
+use core::sync::atomic::{AtomicBool, Ordering};
+
+mod allocation;
 mod context;
 mod defs;
 mod error;
 mod node;
 mod process;
+mod range_alloc;
 mod thread;
+mod transaction;
 
 module! {
     type: BinderModule,
@@ -111,6 +117,54 @@ fn arc_pin_init(init: impl PinInit<T>) -> Result<DLArc<T>, kernel::error::Error>
     }
 }
 
+struct DeliverCode {
+    code: u32,
+    skip: AtomicBool,
+}
+
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for DeliverCode { untracked; }
+}
+
+impl DeliverCode {
+    fn new(code: u32) -> Self {
+        Self {
+            code,
+            skip: AtomicBool::new(false),
+        }
+    }
+
+    /// Disable this DeliverCode and make it do nothing.
+    ///
+    /// This is used instead of removing it from the work list, since `LinkedList::remove` is
+    /// unsafe, whereas this method is not.
+    fn skip(&self) {
+        self.skip.store(true, Ordering::Relaxed);
+    }
+}
+
+impl DeliverToRead for DeliverCode {
+    fn do_work(
+        self: DArc<Self>,
+        _thread: &Thread,
+        writer: &mut UserSlicePtrWriter,
+    ) -> Result<bool> {
+        if !self.skip.load(Ordering::Relaxed) {
+            writer.write(&self.code)?;
+        }
+        Ok(true)
+    }
+
+    fn should_sync_wakeup(&self) -> bool {
+        false
+    }
+}
+
+const fn ptr_align(value: usize) -> usize {
+    let size = core::mem::size_of::<usize>() - 1;
+    (value + size) & !size
+}
+
 struct BinderModule {}
 
 impl kernel::Module for BinderModule {
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index f7d62fc380e5..f34de7ad6e6f 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -9,17 +9,25 @@
     bindings,
     io_buffer::{IoBufferReader, IoBufferWriter},
     list::{
-        AtomicListArcTracker, HasListLinks, List, ListArcSafe, ListItem, ListLinks, TryNewListArc,
+        AtomicListArcTracker, HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks,
+        TryNewListArc,
     },
     prelude::*,
+    security,
     sync::{Arc, CondVar, SpinLock},
     types::Either,
-    user_ptr::UserSlicePtr,
+    user_ptr::{UserSlicePtr, UserSlicePtrWriter},
 };
 
-use crate::{defs::*, process::Process, DLArc, DTRWrap, DeliverToRead};
+use crate::{
+    allocation::Allocation, defs::*, error::BinderResult, process::Process, ptr_align,
+    transaction::Transaction, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
+};
 
-use core::mem::size_of;
+use core::{
+    mem::size_of,
+    sync::atomic::{AtomicU32, Ordering},
+};
 
 pub(crate) enum PushWorkRes {
     Ok,
@@ -47,6 +55,10 @@ struct InnerThread {
     /// Determines if thread is dead.
     is_dead: bool,
 
+    /// Work item used to deliver error codes to the current thread. Stored here so that it can be
+    /// reused.
+    return_work: DArc<ThreadError>,
+
     /// Determines whether the work list below should be processed. When set to false, `work_list`
     /// is treated as if it were empty.
     process_work_list: bool,
@@ -65,22 +77,21 @@ struct InnerThread {
 const LOOPER_WAITING_PROC: u32 = 0x20;
 
 impl InnerThread {
-    fn new() -> Self {
-        use core::sync::atomic::{AtomicU32, Ordering};
-
+    fn new() -> Result<Self> {
         fn next_err_id() -> u32 {
             static EE_ID: AtomicU32 = AtomicU32::new(0);
             EE_ID.fetch_add(1, Ordering::Relaxed)
         }
 
-        Self {
+        Ok(Self {
             looper_flags: 0,
             looper_need_return: false,
             is_dead: false,
             process_work_list: false,
+            return_work: ThreadError::try_new()?,
             work_list: List::new(),
             extended_error: ExtendedError::new(next_err_id(), BR_OK, 0),
-        }
+        })
     }
 
     fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
@@ -103,6 +114,15 @@ fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         }
     }
 
+    fn push_return_work(&mut self, reply: u32) {
+        if let Ok(work) = ListArc::try_from_arc(self.return_work.clone()) {
+            work.set_error_code(reply);
+            self.push_work(work);
+        } else {
+            pr_warn!("Thread return work is already in use.");
+        }
+    }
+
     /// Used to push work items that do not need to be processed immediately and can wait until the
     /// thread gets another work item.
     fn push_work_deferred(&mut self, work: DLArc<dyn DeliverToRead>) {
@@ -175,10 +195,12 @@ impl ListItem<0> for Thread {
 
 impl Thread {
     pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
+        let inner = InnerThread::new()?;
+
         Arc::pin_init(pin_init!(Thread {
             id,
             process,
-            inner <- kernel::new_spinlock!(InnerThread::new(), "Thread::inner"),
+            inner <- kernel::new_spinlock!(inner, "Thread::inner"),
             work_condvar <- kernel::new_condvar!("Thread::work_condvar"),
             links <- ListLinks::new(),
             links_track <- AtomicListArcTracker::new(),
@@ -312,15 +334,131 @@ pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
         self.inner.lock().push_work_deferred(work);
     }
 
+    pub(crate) fn copy_transaction_data(
+        &self,
+        to_process: Arc<Process>,
+        tr: &BinderTransactionDataSg,
+        txn_security_ctx_offset: Option<&mut usize>,
+    ) -> BinderResult<Allocation> {
+        let trd = &tr.transaction_data;
+        let is_oneway = trd.flags & TF_ONE_WAY != 0;
+        let mut secctx = if let Some(offset) = txn_security_ctx_offset {
+            let secid = self.process.cred.get_secid();
+            let ctx = match security::SecurityCtx::from_secid(secid) {
+                Ok(ctx) => ctx,
+                Err(err) => {
+                    pr_warn!("Failed to get security ctx for id {}: {:?}", secid, err);
+                    return Err(err.into());
+                }
+            };
+            Some((offset, ctx))
+        } else {
+            None
+        };
+
+        let data_size = trd.data_size.try_into().map_err(|_| EINVAL)?;
+        let adata_size = ptr_align(data_size);
+        let asecctx_size = secctx
+            .as_ref()
+            .map(|(_, ctx)| ptr_align(ctx.len()))
+            .unwrap_or(0);
+
+        // This guarantees that at least `sizeof(usize)` bytes will be allocated.
+        let len = usize::max(
+            adata_size.checked_add(asecctx_size).ok_or(ENOMEM)?,
+            size_of::<usize>(),
+        );
+        let secctx_off = adata_size;
+        let alloc = match to_process.buffer_alloc(len, is_oneway) {
+            Ok(alloc) => alloc,
+            Err(err) => {
+                pr_warn!(
+                    "Failed to allocate buffer. len:{}, is_oneway:{}",
+                    len,
+                    is_oneway
+                );
+                return Err(err);
+            }
+        };
+
+        let mut buffer_reader =
+            unsafe { UserSlicePtr::new(trd.data.ptr.buffer as _, data_size) }.reader();
+
+        alloc.copy_into(&mut buffer_reader, 0, data_size)?;
+
+        if let Some((off_out, secctx)) = secctx.as_mut() {
+            if let Err(err) = alloc.write(secctx_off, secctx.as_bytes()) {
+                pr_warn!("Failed to write security context: {:?}", err);
+                return Err(err.into());
+            }
+            **off_out = secctx_off;
+        }
+        Ok(alloc)
+    }
+
+    fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
+    where
+        T: FnOnce(&Arc<Self>, &BinderTransactionDataSg) -> BinderResult,
+    {
+        if let Err(err) = inner(self, tr) {
+            if err.reply != BR_TRANSACTION_COMPLETE {
+                let mut ee = self.inner.lock().extended_error;
+                ee.command = err.reply;
+                ee.param = err.as_errno();
+                pr_warn!(
+                    "Transaction failed: {:?} my_pid:{}",
+                    err,
+                    self.process.task.pid_in_current_ns()
+                );
+            }
+
+            self.inner.lock().push_return_work(err.reply);
+        }
+    }
+
+    fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
+        let handle = unsafe { tr.transaction_data.target.handle };
+        let node_ref = self.process.get_transaction_node(handle)?;
+        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
+        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+        let transaction = Transaction::new(node_ref, self, tr)?;
+        let completion = list_completion.clone_arc();
+        self.inner.lock().push_work(list_completion);
+        match transaction.submit() {
+            Ok(()) => Ok(()),
+            Err(err) => {
+                completion.skip();
+                Err(err)
+            }
+        }
+    }
+
     fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
         let write_start = req.write_buffer.wrapping_add(req.write_consumed);
         let write_len = req.write_size - req.write_consumed;
         let mut reader = UserSlicePtr::new(write_start as _, write_len as _).reader();
 
-        while reader.len() >= size_of::<u32>() {
+        while reader.len() >= size_of::<u32>() && self.inner.lock().return_work.is_unused() {
             let before = reader.len();
             let cmd = reader.read::<u32>()?;
             match cmd {
+                BC_TRANSACTION => {
+                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
+                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
+                        self.transaction(&tr, Self::oneway_transaction_inner);
+                    } else {
+                        return Err(EINVAL);
+                    }
+                }
+                BC_TRANSACTION_SG => {
+                    let tr = reader.read::<BinderTransactionDataSg>()?;
+                    if tr.transaction_data.flags & TF_ONE_WAY != 0 {
+                        self.transaction(&tr, Self::oneway_transaction_inner);
+                    } else {
+                        return Err(EINVAL);
+                    }
+                }
+                BC_FREE_BUFFER => drop(self.process.buffer_get(reader.read()?)),
                 BC_INCREFS => self.process.update_ref(reader.read()?, true, false)?,
                 BC_ACQUIRE => self.process.update_ref(reader.read()?, true, true)?,
                 BC_RELEASE => self.process.update_ref(reader.read()?, false, true)?,
@@ -475,3 +613,51 @@ pub(crate) fn release(self: &Arc<Self>) {
         }
     }
 }
+
+#[pin_data]
+struct ThreadError {
+    error_code: AtomicU32,
+    #[pin]
+    links_track: AtomicListArcTracker,
+}
+
+impl ThreadError {
+    fn try_new() -> Result<DArc<Self>> {
+        DTRWrap::arc_pin_init(pin_init!(Self {
+            error_code: AtomicU32::new(BR_OK),
+            links_track <- AtomicListArcTracker::new(),
+        }))
+        .map(ListArc::into_arc)
+    }
+
+    fn set_error_code(&self, code: u32) {
+        self.error_code.store(code, Ordering::Relaxed);
+    }
+
+    fn is_unused(&self) -> bool {
+        self.error_code.load(Ordering::Relaxed) == BR_OK
+    }
+}
+
+impl DeliverToRead for ThreadError {
+    fn do_work(
+        self: DArc<Self>,
+        _thread: &Thread,
+        writer: &mut UserSlicePtrWriter,
+    ) -> Result<bool> {
+        let code = self.error_code.load(Ordering::Relaxed);
+        self.error_code.store(BR_OK, Ordering::Relaxed);
+        writer.write(&code)?;
+        Ok(true)
+    }
+
+    fn should_sync_wakeup(&self) -> bool {
+        false
+    }
+}
+
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for ThreadError {
+        tracked_by links_track: AtomicListArcTracker;
+    }
+}
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
new file mode 100644
index 000000000000..8b4274ddc415
--- /dev/null
+++ b/drivers/android/transaction.rs
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    io_buffer::IoBufferWriter,
+    list::ListArcSafe,
+    prelude::*,
+    sync::{Arc, SpinLock},
+    task::Kuid,
+    user_ptr::UserSlicePtrWriter,
+};
+
+use crate::{
+    allocation::Allocation,
+    defs::*,
+    error::BinderResult,
+    node::{Node, NodeRef},
+    process::Process,
+    ptr_align,
+    thread::Thread,
+    DArc, DLArc, DTRWrap, DeliverToRead,
+};
+
+#[pin_data]
+pub(crate) struct Transaction {
+    target_node: Option<DArc<Node>>,
+    pub(crate) from: Arc<Thread>,
+    to: Arc<Process>,
+    #[pin]
+    allocation: SpinLock<Option<Allocation>>,
+    code: u32,
+    pub(crate) flags: u32,
+    data_size: usize,
+    data_address: usize,
+    sender_euid: Kuid,
+    txn_security_ctx_off: Option<usize>,
+}
+
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for Transaction { untracked; }
+}
+
+impl Transaction {
+    pub(crate) fn new(
+        node_ref: NodeRef,
+        from: &Arc<Thread>,
+        tr: &BinderTransactionDataSg,
+    ) -> BinderResult<DLArc<Self>> {
+        let trd = &tr.transaction_data;
+        let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
+        let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
+        let to = node_ref.node.owner.clone();
+        let mut alloc =
+            match from.copy_transaction_data(to.clone(), tr, txn_security_ctx_off.as_mut()) {
+                Ok(alloc) => alloc,
+                Err(err) => {
+                    if !err.is_dead() {
+                        pr_warn!("Failure in copy_transaction_data: {:?}", err);
+                    }
+                    return Err(err);
+                }
+            };
+        if trd.flags & TF_ONE_WAY == 0 {
+            pr_warn!("Non-oneway transactions are not yet supported.");
+            return Err(EINVAL.into());
+        }
+        if trd.flags & TF_CLEAR_BUF != 0 {
+            alloc.set_info_clear_on_drop();
+        }
+        let target_node = node_ref.node.clone();
+        alloc.set_info_target_node(node_ref);
+        let data_address = alloc.ptr;
+
+        Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
+            target_node: Some(target_node),
+            sender_euid: from.process.cred.euid(),
+            from: from.clone(),
+            to,
+            code: trd.code,
+            flags: trd.flags,
+            data_size: trd.data_size as _,
+            data_address,
+            allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
+            txn_security_ctx_off,
+        }))?)
+    }
+
+    /// Submits the transaction to a work queue.
+    pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
+        let process = self.to.clone();
+        let mut process_inner = process.inner.lock();
+        match process_inner.push_work(self) {
+            Ok(()) => Ok(()),
+            Err((err, work)) => {
+                // Drop work after releasing process lock.
+                drop(process_inner);
+                drop(work);
+                Err(err)
+            }
+        }
+    }
+}
+
+impl DeliverToRead for Transaction {
+    fn do_work(
+        self: DArc<Self>,
+        _thread: &Thread,
+        writer: &mut UserSlicePtrWriter,
+    ) -> Result<bool> {
+        let mut tr_sec = BinderTransactionDataSecctx::default();
+        let tr = tr_sec.tr_data();
+        if let Some(target_node) = &self.target_node {
+            let (ptr, cookie) = target_node.get_id();
+            tr.target.ptr = ptr as _;
+            tr.cookie = cookie as _;
+        };
+        tr.code = self.code;
+        tr.flags = self.flags;
+        tr.data_size = self.data_size as _;
+        tr.data.ptr.buffer = self.data_address as _;
+        tr.offsets_size = 0;
+        if tr.offsets_size > 0 {
+            tr.data.ptr.offsets = (self.data_address + ptr_align(self.data_size)) as _;
+        }
+        tr.sender_euid = self.sender_euid.into_uid_in_current_ns();
+        tr.sender_pid = 0;
+        if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
+            // Not a reply and not one-way.
+            tr.sender_pid = self.from.process.task.pid_in_current_ns();
+        }
+        let code = if self.target_node.is_none() {
+            BR_REPLY
+        } else if self.txn_security_ctx_off.is_some() {
+            BR_TRANSACTION_SEC_CTX
+        } else {
+            BR_TRANSACTION
+        };
+
+        // Write the transaction code and data to the user buffer.
+        writer.write(&code)?;
+        if let Some(off) = self.txn_security_ctx_off {
+            tr_sec.secctx = (self.data_address + off) as u64;
+            writer.write(&tr_sec)?;
+        } else {
+            writer.write(&*tr)?;
+        }
+
+        // It is now the user's responsibility to clear the allocation.
+        let alloc = self.allocation.lock().take();
+        if let Some(alloc) = alloc {
+            alloc.keep_alive();
+        }
+
+        Ok(false)
+    }
+
+    fn cancel(self: DArc<Self>) {
+        drop(self.allocation.lock().take());
+    }
+
+    fn should_sync_wakeup(&self) -> bool {
+        self.flags & TF_ONE_WAY == 0
+    }
+}
diff --git a/rust/helpers.c b/rust/helpers.c
index adb94ace2334..e70255f3774f 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -335,6 +335,13 @@ int rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
 	return security_binder_set_context_mgr(mgr);
 }
 EXPORT_SYMBOL_GPL(rust_helper_security_binder_set_context_mgr);
+
+int rust_helper_security_binder_transaction(const struct cred *from,
+					    const struct cred *to)
+{
+	return security_binder_transaction(from, to);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_binder_transaction);
 #endif
 
 /*
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index f94c3c37560d..9e3e4cf08ecb 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -17,6 +17,13 @@ pub fn binder_set_context_mgr(mgr: &Credential) -> Result {
     to_result(unsafe { bindings::security_binder_set_context_mgr(mgr.0.get()) })
 }
 
+/// Calls the security modules to determine if binder transactions are allowed from task `from` to
+/// task `to`.
+pub fn binder_transaction(from: &Credential, to: &Credential) -> Result {
+    // SAFETY: `from` and `to` are valid because the shared references guarantee nonzero refcounts.
+    to_result(unsafe { bindings::security_binder_transaction(from.0.get(), to.0.get()) })
+}
+
 /// A security context string.
 ///
 /// The struct has the invariant that it always contains a valid security context.

-- 
2.42.0.820.g83a721a137-goog

