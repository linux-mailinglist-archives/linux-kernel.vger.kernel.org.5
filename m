Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5133B7DE5D6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345063AbjKASDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344792AbjKASDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:03 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D02B812C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:44 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9d2606301eeso10965166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861763; x=1699466563; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kukThpDw1OlU2Qi41kPUcezUwH/dCviJIoImwIYtSdk=;
        b=dw/kZijCmsPpxOgiZ7gqxfe9KU4WKJXqee5Au8rd7OAOc8/9ane5peufyR4aLNbkB8
         MKjejCWximCo1G9Hk8EcmBaPAo9yxdW4YpvLtK72MO+p0eB8OLpfy017PJLhMGXTM9O7
         MWxeausv/53eNRvRgWdrTov05bukY2pPsTl9fs7ECTaWVc4dfT9JN4XmiWvLQ7z6xue0
         tfBUAaErgsze7ix/QGzP9lUbgRWefh6FZQy9cEfLPS15LcS/ff/Th+82X9+EFGN7Voru
         P7YC9XXhswPfJdKMgjQcG6I1q4YIH0BsILO7CZ7X3LK8447N5+O4M7ewdLjKGltBIQXv
         /Vog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861763; x=1699466563;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kukThpDw1OlU2Qi41kPUcezUwH/dCviJIoImwIYtSdk=;
        b=Ndyhm8YSp/CsR/BSCZq7UNpESXsrDriqlnZMv10ye4rilfPb2EMz3WsMMbeOp5o+N5
         7aQuB7vEVVqJeekEBvNFEaVGccAzBkMqBMDWuC7by+GadybxddM5FCkrY9O2kWAdFDR6
         DgEEFEBZKVDVc6ENHTAfZHGv7W1KpgtBTO8JWFFgOcjRPVkHhHOTPLPH5w3h/Fwmdgvb
         CFVjnKT3zu4A9Dy/Zx0t0b8beHnDoC6ZRCoWpV9LfNkVxaAB1z0rJQNxSdwfdpin2b0h
         ReqniXs8nTC4p5p+rGyzaF+GIAz3wQ942D5sIdpyxfyPQs3JJU8IRuTJxXa5IKFTrRJ8
         WW6w==
X-Gm-Message-State: AOJu0Yx1s130B+wq386YeRBS2jIXkIVVb1ZWNWGBymVQk1cLKa5RZnPa
        T39flGC/xDGy6zFSrObfx0tFyO4IaYwec7A=
X-Google-Smtp-Source: AGHT+IFT4hV65jNkYQHPs5YxsaM0BVC/laywsq0hKCQ2FXgBcACkzAb/k49Aw6hMBoaatJYWzfs5TC5MKR1j2S8=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:f247:b0:9c7:1cbb:3a71 with SMTP
 id gy7-20020a170906f24700b009c71cbb3a71mr30909ejb.1.1698861763349; Wed, 01
 Nov 2023 11:02:43 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:41 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-11-08ba9197f637@google.com>
Subject: [PATCH RFC 11/20] rust_binder: send nodes in transactions
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

To send a transaction to any process other than the context manager,
someone must first send you the binder node. Usually, you get it from
the context manager.

The transaction allocation now contains a list of offsets of objects in
the transaction that must be translated before they are passed to the
target process. In this patch, we only support translation of binder
nodes, but future patches will extend this to other object types.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  | 266 ++++++++++++++++++++++++++++++++++++++++-
 drivers/android/defs.rs        |  44 +++++--
 drivers/android/process.rs     |   8 ++
 drivers/android/thread.rs      | 118 +++++++++++++++++-
 drivers/android/transaction.rs |   5 +-
 rust/helpers.c                 |   7 ++
 rust/kernel/security.rs        |   7 ++
 7 files changed, 436 insertions(+), 19 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index 0fdef5425918..32bc268956f2 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -1,9 +1,18 @@
 // SPDX-License-Identifier: GPL-2.0
-use core::mem::size_of_val;
+use core::mem::{size_of, size_of_val, MaybeUninit};
+use core::ops::Range;
 
-use kernel::{bindings, pages::Pages, prelude::*, sync::Arc, user_ptr::UserSlicePtrReader};
+use kernel::{
+    bindings,
+    io_buffer::{IoBufferReader, ReadableFromBytes, WritableToBytes},
+    pages::Pages,
+    prelude::*,
+    sync::Arc,
+    user_ptr::UserSlicePtrReader,
+};
 
 use crate::{
+    defs::*,
     node::{Node, NodeRef},
     process::Process,
     DArc,
@@ -11,6 +20,8 @@
 
 #[derive(Default)]
 pub(crate) struct AllocationInfo {
+    /// Range within the allocation where we can find the offsets to the object descriptors.
+    pub(crate) offsets: Option<Range<usize>>,
     /// The target node of the transaction this allocation is associated to.
     /// Not set for replies.
     pub(crate) target_node: Option<NodeRef>,
@@ -87,6 +98,21 @@ pub(crate) fn copy_into(
         })
     }
 
+    pub(crate) fn read<T: ReadableFromBytes>(&self, offset: usize) -> Result<T> {
+        let mut out = MaybeUninit::<T>::uninit();
+        let mut out_offset = 0;
+        self.iterate(offset, size_of::<T>(), |page, offset, to_copy| {
+            // SAFETY: The sum of `offset` and `to_copy` is bounded by the size of T.
+            let obj_ptr = unsafe { (out.as_mut_ptr() as *mut u8).add(out_offset) };
+            // SAFETY: The pointer points is in-bounds of the `out` variable, so it is valid.
+            unsafe { page.read(obj_ptr, offset, to_copy) }?;
+            out_offset += to_copy;
+            Ok(())
+        })?;
+        // SAFETY: We just initialised the data.
+        Ok(unsafe { out.assume_init() })
+    }
+
     pub(crate) fn write<T: ?Sized>(&self, offset: usize, obj: &T) -> Result {
         let mut obj_offset = 0;
         self.iterate(offset, size_of_val(obj), |page, offset, to_copy| {
@@ -119,6 +145,10 @@ pub(crate) fn get_or_init_info(&mut self) -> &mut AllocationInfo {
         self.allocation_info.get_or_insert_with(Default::default)
     }
 
+    pub(crate) fn set_info_offsets(&mut self, offsets: Range<usize>) {
+        self.get_or_init_info().offsets = Some(offsets);
+    }
+
     pub(crate) fn set_info_oneway_node(&mut self, oneway_node: DArc<Node>) {
         self.get_or_init_info().oneway_node = Some(oneway_node);
     }
@@ -145,6 +175,15 @@ fn drop(&mut self) {
 
             info.target_node = None;
 
+            if let Some(offsets) = info.offsets.clone() {
+                let view = AllocationView::new(self, offsets.start);
+                for i in offsets.step_by(size_of::<usize>()) {
+                    if view.cleanup_object(i).is_err() {
+                        pr_warn!("Error cleaning up object at offset {}\n", i)
+                    }
+                }
+            }
+
             if info.clear_on_free {
                 if let Err(e) = self.fill_zero() {
                     pr_warn!("Failed to clear data on free: {:?}", e);
@@ -155,3 +194,226 @@ fn drop(&mut self) {
         self.process.buffer_raw_free(self.ptr);
     }
 }
+
+/// A view into the beginning of an allocation.
+///
+/// All attempts to read or write outside of the view will fail. To intentionally access outside of
+/// this view, use the `alloc` field of this struct directly.
+pub(crate) struct AllocationView<'a> {
+    pub(crate) alloc: &'a mut Allocation,
+    limit: usize,
+}
+
+impl<'a> AllocationView<'a> {
+    pub(crate) fn new(alloc: &'a mut Allocation, limit: usize) -> Self {
+        AllocationView { alloc, limit }
+    }
+
+    pub(crate) fn read<T: ReadableFromBytes>(&self, offset: usize) -> Result<T> {
+        if offset.checked_add(size_of::<T>()).ok_or(EINVAL)? > self.limit {
+            return Err(EINVAL);
+        }
+        self.alloc.read(offset)
+    }
+
+    pub(crate) fn write<T: WritableToBytes>(&self, offset: usize, obj: &T) -> Result {
+        if offset.checked_add(size_of::<T>()).ok_or(EINVAL)? > self.limit {
+            return Err(EINVAL);
+        }
+        self.alloc.write(offset, obj)
+    }
+
+    pub(crate) fn transfer_binder_object(
+        &self,
+        offset: usize,
+        obj: &bindings::flat_binder_object,
+        strong: bool,
+        node_ref: NodeRef,
+    ) -> Result {
+        if Arc::ptr_eq(&node_ref.node.owner, &self.alloc.process) {
+            // The receiving process is the owner of the node, so send it a binder object (instead
+            // of a handle).
+            let (ptr, cookie) = node_ref.node.get_id();
+            let mut newobj = FlatBinderObject::default();
+            newobj.hdr.type_ = if strong {
+                BINDER_TYPE_BINDER
+            } else {
+                BINDER_TYPE_WEAK_BINDER
+            };
+            newobj.flags = obj.flags;
+            newobj.__bindgen_anon_1.binder = ptr as _;
+            newobj.cookie = cookie as _;
+            self.write(offset, &newobj)?;
+            // Increment the user ref count on the node. It will be decremented as part of the
+            // destruction of the buffer, when we see a binder or weak-binder object.
+            node_ref.node.update_refcount(true, 1, strong);
+        } else {
+            // The receiving process is different from the owner, so we need to insert a handle to
+            // the binder object.
+            let handle = self
+                .alloc
+                .process
+                .insert_or_update_handle(node_ref, false)?;
+            let mut newobj = FlatBinderObject::default();
+            newobj.hdr.type_ = if strong {
+                BINDER_TYPE_HANDLE
+            } else {
+                BINDER_TYPE_WEAK_HANDLE
+            };
+            newobj.flags = obj.flags;
+            newobj.__bindgen_anon_1.handle = handle;
+            if self.write(offset, &newobj).is_err() {
+                // Decrement ref count on the handle we just created.
+                let _ = self.alloc.process.update_ref(handle, false, strong);
+                return Err(EINVAL);
+            }
+        }
+        Ok(())
+    }
+
+    fn cleanup_object(&self, index_offset: usize) -> Result {
+        let offset = self.alloc.read(index_offset)?;
+        let header = self.read::<BinderObjectHeader>(offset)?;
+        match header.type_ {
+            BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => {
+                let obj = self.read::<FlatBinderObject>(offset)?;
+                let strong = header.type_ == BINDER_TYPE_BINDER;
+                // SAFETY: The type is `BINDER_TYPE_{WEAK_}BINDER`, so the `binder` field is
+                // populated.
+                let ptr = unsafe { obj.__bindgen_anon_1.binder } as usize;
+                let cookie = obj.cookie as usize;
+                self.alloc.process.update_node(ptr, cookie, strong);
+                Ok(())
+            }
+            BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => {
+                let obj = self.read::<FlatBinderObject>(offset)?;
+                let strong = header.type_ == BINDER_TYPE_HANDLE;
+                // SAFETY: The type is `BINDER_TYPE_{WEAK_}HANDLE`, so the `handle` field is
+                // populated.
+                let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
+                self.alloc.process.update_ref(handle, false, strong)
+            }
+            _ => Ok(()),
+        }
+    }
+}
+
+/// A binder object as it is serialized.
+///
+/// # Invariants
+///
+/// All bytes must be initialized, and the value of `self.hdr.type_` must be one of the allowed
+/// types.
+#[repr(C)]
+pub(crate) union BinderObject {
+    hdr: bindings::binder_object_header,
+    fbo: bindings::flat_binder_object,
+    fdo: bindings::binder_fd_object,
+    bbo: bindings::binder_buffer_object,
+    fdao: bindings::binder_fd_array_object,
+}
+
+/// A view into a `BinderObject` that can be used in a match statement.
+pub(crate) enum BinderObjectRef<'a> {
+    Binder(&'a mut bindings::flat_binder_object),
+    Handle(&'a mut bindings::flat_binder_object),
+    Fd(&'a mut bindings::binder_fd_object),
+    Ptr(&'a mut bindings::binder_buffer_object),
+    Fda(&'a mut bindings::binder_fd_array_object),
+}
+
+impl BinderObject {
+    pub(crate) fn read_from(reader: &mut UserSlicePtrReader) -> Result<BinderObject> {
+        let object = Self::read_from_inner(|slice| {
+            let read_len = usize::min(slice.len(), reader.len());
+            // SAFETY: The length we pass to `read_raw` is at most the length of the slice.
+            unsafe {
+                reader
+                    .clone_reader()
+                    .read_raw(slice.as_mut_ptr(), read_len)?;
+            }
+            Ok(())
+        })?;
+
+        // If we used a object type smaller than the largest object size, then we've read more
+        // bytes than we needed to. However, we used `.clone_reader()` to avoid advancing the
+        // original reader. Now, we call `skip` so that the caller's reader is advanced by the
+        // right amount.
+        //
+        // The `skip` call fails if the reader doesn't have `size` bytes available. This could
+        // happen if the type header corresponds to an object type that is larger than the rest of
+        // the reader.
+        //
+        // Any extra bytes beyond the size of the object are inaccessible after this call, so
+        // reading them again from the `reader` later does not result in TOCTOU bugs.
+        reader.skip(object.size())?;
+
+        Ok(object)
+    }
+
+    /// Use the provided reader closure to construct a `BinderObject`.
+    ///
+    /// The closure should write the bytes for the object into the provided slice.
+    pub(crate) fn read_from_inner<R>(reader: R) -> Result<BinderObject>
+    where
+        R: FnOnce(&mut [u8; size_of::<BinderObject>()]) -> Result<()>,
+    {
+        let mut obj = MaybeUninit::<BinderObject>::zeroed();
+
+        // SAFETY: The lengths of `BinderObject` and `[u8; size_of::<BinderObject>()]` are equal,
+        // and the byte array has an alignment requirement of one, so the pointer cast is okay.
+        // Additionally, `obj` was initialized to zeros, so the byte array will not be
+        // uninitialized.
+        (reader)(unsafe { &mut *obj.as_mut_ptr().cast() })?;
+
+        // SAFETY: The entire object is initialized, so accessing this field is safe.
+        let type_ = unsafe { obj.assume_init_ref().hdr.type_ };
+        if Self::type_to_size(type_).is_none() {
+            // The value of `obj.hdr_type_` was invalid.
+            return Err(EINVAL);
+        }
+
+        // SAFETY: All bytes are initialized (since we zeroed them at the start) and we checked
+        // that `self.hdr.type_` is one of the allowed types, so the type invariants are satisfied.
+        unsafe { Ok(obj.assume_init()) }
+    }
+
+    pub(crate) fn as_ref(&mut self) -> BinderObjectRef<'_> {
+        use BinderObjectRef::*;
+        // SAFETY: The constructor ensures that all bytes of `self` are initialized, and all
+        // variants of this union accept all initialized bit patterns.
+        unsafe {
+            match self.hdr.type_ {
+                BINDER_TYPE_WEAK_BINDER | BINDER_TYPE_BINDER => Binder(&mut self.fbo),
+                BINDER_TYPE_WEAK_HANDLE | BINDER_TYPE_HANDLE => Handle(&mut self.fbo),
+                BINDER_TYPE_FD => Fd(&mut self.fdo),
+                BINDER_TYPE_PTR => Ptr(&mut self.bbo),
+                BINDER_TYPE_FDA => Fda(&mut self.fdao),
+                // SAFETY: By the type invariant, the value of `self.hdr.type_` cannot have any
+                // other value than the ones checked above.
+                _ => core::hint::unreachable_unchecked(),
+            }
+        }
+    }
+
+    pub(crate) fn size(&self) -> usize {
+        // SAFETY: The entire object is initialized, so accessing this field is safe.
+        let type_ = unsafe { self.hdr.type_ };
+
+        // SAFETY: The type invariants guarantee that the type field is correct.
+        unsafe { Self::type_to_size(type_).unwrap_unchecked() }
+    }
+
+    fn type_to_size(type_: u32) -> Option<usize> {
+        match type_ {
+            BINDER_TYPE_WEAK_BINDER => Some(size_of::<bindings::flat_binder_object>()),
+            BINDER_TYPE_BINDER => Some(size_of::<bindings::flat_binder_object>()),
+            BINDER_TYPE_WEAK_HANDLE => Some(size_of::<bindings::flat_binder_object>()),
+            BINDER_TYPE_HANDLE => Some(size_of::<bindings::flat_binder_object>()),
+            BINDER_TYPE_FD => Some(size_of::<bindings::binder_fd_object>()),
+            BINDER_TYPE_PTR => Some(size_of::<bindings::binder_buffer_object>()),
+            BINDER_TYPE_FDA => Some(size_of::<bindings::binder_fd_array_object>()),
+            _ => None,
+        }
+    }
+}
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 753f7e86c92d..68f32a779a3c 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::mem::MaybeUninit;
 use core::ops::{Deref, DerefMut};
 use kernel::{
     bindings::{self, *},
@@ -57,11 +58,18 @@ macro_rules! pub_no_prefix {
     kernel::bindings::FLAT_BINDER_FLAG_TXN_SECURITY_CTX;
 pub_no_prefix!(transaction_flags_, TF_ONE_WAY, TF_CLEAR_BUF);
 
+pub(crate) use bindings::{
+    BINDER_TYPE_BINDER, BINDER_TYPE_FD, BINDER_TYPE_FDA, BINDER_TYPE_HANDLE, BINDER_TYPE_PTR,
+    BINDER_TYPE_WEAK_BINDER, BINDER_TYPE_WEAK_HANDLE,
+};
+
 macro_rules! decl_wrapper {
     ($newname:ident, $wrapped:ty) => {
-        #[derive(Copy, Clone, Default)]
+        // Define a wrapper around the C type. Use `MaybeUninit` to enforce that the value of
+        // padding bytes must be preserved.
+        #[derive(Copy, Clone)]
         #[repr(transparent)]
-        pub(crate) struct $newname($wrapped);
+        pub(crate) struct $newname(MaybeUninit<$wrapped>);
 
         // SAFETY: This macro is only used with types where this is ok.
         unsafe impl ReadableFromBytes for $newname {}
@@ -70,13 +78,24 @@ unsafe impl WritableToBytes for $newname {}
         impl Deref for $newname {
             type Target = $wrapped;
             fn deref(&self) -> &Self::Target {
-                &self.0
+                // SAFETY: We use `MaybeUninit` only to preserve padding. The value must still
+                // always be valid.
+                unsafe { self.0.assume_init_ref() }
             }
         }
 
         impl DerefMut for $newname {
             fn deref_mut(&mut self) -> &mut Self::Target {
-                &mut self.0
+                // SAFETY: We use `MaybeUninit` only to preserve padding. The value must still
+                // always be valid.
+                unsafe { self.0.assume_init_mut() }
+            }
+        }
+
+        impl Default for $newname {
+            fn default() -> Self {
+                // Create a new value of this type where all bytes (including padding) are zeroed.
+                Self(MaybeUninit::zeroed())
             }
         }
     };
@@ -85,6 +104,7 @@ fn deref_mut(&mut self) -> &mut Self::Target {
 decl_wrapper!(BinderNodeDebugInfo, bindings::binder_node_debug_info);
 decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
 decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
+decl_wrapper!(BinderObjectHeader, bindings::binder_object_header);
 decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
 decl_wrapper!(
     BinderTransactionDataSecctx,
@@ -100,18 +120,18 @@ fn deref_mut(&mut self) -> &mut Self::Target {
 
 impl BinderVersion {
     pub(crate) fn current() -> Self {
-        Self(bindings::binder_version {
+        Self(MaybeUninit::new(bindings::binder_version {
             protocol_version: bindings::BINDER_CURRENT_PROTOCOL_VERSION as _,
-        })
+        }))
     }
 }
 
 impl BinderTransactionData {
     pub(crate) fn with_buffers_size(self, buffers_size: u64) -> BinderTransactionDataSg {
-        BinderTransactionDataSg(bindings::binder_transaction_data_sg {
-            transaction_data: self.0,
+        BinderTransactionDataSg(MaybeUninit::new(bindings::binder_transaction_data_sg {
+            transaction_data: *self,
             buffers_size,
-        })
+        }))
     }
 }
 
@@ -128,6 +148,10 @@ pub(crate) fn tr_data(&mut self) -> &mut BinderTransactionData {
 
 impl ExtendedError {
     pub(crate) fn new(id: u32, command: u32, param: i32) -> Self {
-        Self(bindings::binder_extended_error { id, command, param })
+        Self(MaybeUninit::new(bindings::binder_extended_error {
+            id,
+            command,
+            param,
+        }))
     }
 }
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 0b79fa59ffa5..944297b7403c 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -591,6 +591,14 @@ pub(crate) fn update_ref(&self, handle: u32, inc: bool, strong: bool) -> Result
         Ok(())
     }
 
+    /// Decrements the refcount of the given node, if one exists.
+    pub(crate) fn update_node(&self, ptr: usize, cookie: usize, strong: bool) {
+        let mut inner = self.inner.lock();
+        if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
+            inner.update_node_refcount(&node, false, strong, 1, None);
+        }
+    }
+
     pub(crate) fn inc_ref_done(&self, reader: &mut UserSlicePtrReader, strong: bool) -> Result {
         let ptr = reader.read::<usize>()?;
         let cookie = reader.read::<usize>()?;
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index b70a5e3c064b..a9afc7b706c6 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -21,8 +21,13 @@
 };
 
 use crate::{
-    allocation::Allocation, defs::*, error::BinderResult, process::Process, ptr_align,
-    transaction::Transaction, DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
+    allocation::{Allocation, AllocationView, BinderObject, BinderObjectRef},
+    defs::*,
+    error::BinderResult,
+    process::Process,
+    ptr_align,
+    transaction::Transaction,
+    DArc, DLArc, DTRWrap, DeliverCode, DeliverToRead,
 };
 
 use core::{
@@ -412,6 +417,54 @@ pub(crate) fn push_return_work(&self, reply: u32) {
         self.inner.lock().push_return_work(reply);
     }
 
+    fn translate_object(
+        &self,
+        offset: usize,
+        object: BinderObjectRef<'_>,
+        view: &mut AllocationView<'_>,
+    ) -> BinderResult {
+        match object {
+            BinderObjectRef::Binder(obj) => {
+                let strong = obj.hdr.type_ == BINDER_TYPE_BINDER;
+                // SAFETY: `binder` is a `binder_uintptr_t`; any bit pattern is a valid
+                // representation.
+                let ptr = unsafe { obj.__bindgen_anon_1.binder } as _;
+                let cookie = obj.cookie as _;
+                let flags = obj.flags as _;
+                let node = self.process.as_arc_borrow().get_node(
+                    ptr,
+                    cookie,
+                    flags,
+                    strong,
+                    Some(self),
+                )?;
+                security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
+                view.transfer_binder_object(offset, obj, strong, node)?;
+            }
+            BinderObjectRef::Handle(obj) => {
+                let strong = obj.hdr.type_ == BINDER_TYPE_HANDLE;
+                // SAFETY: `handle` is a `u32`; any bit pattern is a valid representation.
+                let handle = unsafe { obj.__bindgen_anon_1.handle } as _;
+                let node = self.process.get_node_from_handle(handle, strong)?;
+                security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
+                view.transfer_binder_object(offset, obj, strong, node)?;
+            }
+            BinderObjectRef::Fd(_obj) => {
+                pr_warn!("Using unsupported binder object type fd.");
+                return Err(EINVAL.into());
+            }
+            BinderObjectRef::Ptr(_obj) => {
+                pr_warn!("Using unsupported binder object type ptr.");
+                return Err(EINVAL.into());
+            }
+            BinderObjectRef::Fda(_obj) => {
+                pr_warn!("Using unsupported binder object type fda.");
+                return Err(EINVAL.into());
+            }
+        }
+        Ok(())
+    }
+
     pub(crate) fn copy_transaction_data(
         &self,
         to_process: Arc<Process>,
@@ -436,6 +489,8 @@ pub(crate) fn copy_transaction_data(
 
         let data_size = trd.data_size.try_into().map_err(|_| EINVAL)?;
         let adata_size = ptr_align(data_size);
+        let offsets_size = trd.offsets_size.try_into().map_err(|_| EINVAL)?;
+        let aoffsets_size = ptr_align(offsets_size);
         let asecctx_size = secctx
             .as_ref()
             .map(|(_, ctx)| ptr_align(ctx.len()))
@@ -443,11 +498,14 @@ pub(crate) fn copy_transaction_data(
 
         // This guarantees that at least `sizeof(usize)` bytes will be allocated.
         let len = usize::max(
-            adata_size.checked_add(asecctx_size).ok_or(ENOMEM)?,
+            adata_size
+                .checked_add(aoffsets_size)
+                .and_then(|sum| sum.checked_add(asecctx_size))
+                .ok_or(ENOMEM)?,
             size_of::<usize>(),
         );
-        let secctx_off = adata_size;
-        let alloc = match to_process.buffer_alloc(len, is_oneway) {
+        let secctx_off = adata_size + aoffsets_size;
+        let mut alloc = match to_process.buffer_alloc(len, is_oneway) {
             Ok(alloc) => alloc,
             Err(err) => {
                 pr_warn!(
@@ -461,8 +519,56 @@ pub(crate) fn copy_transaction_data(
 
         let mut buffer_reader =
             unsafe { UserSlicePtr::new(trd.data.ptr.buffer as _, data_size) }.reader();
+        let mut end_of_previous_object = 0;
+
+        // Copy offsets if there are any.
+        if offsets_size > 0 {
+            {
+                let mut reader =
+                    unsafe { UserSlicePtr::new(trd.data.ptr.offsets as _, offsets_size) }.reader();
+                alloc.copy_into(&mut reader, adata_size, offsets_size)?;
+            }
+
+            let offsets_start = adata_size;
+            let offsets_end = adata_size + aoffsets_size;
+
+            // Traverse the objects specified.
+            let mut view = AllocationView::new(&mut alloc, data_size);
+            for index_offset in (offsets_start..offsets_end).step_by(size_of::<usize>()) {
+                let offset = view.alloc.read(index_offset)?;
+
+                // Copy data between two objects.
+                if end_of_previous_object < offset {
+                    view.alloc.copy_into(
+                        &mut buffer_reader,
+                        end_of_previous_object,
+                        offset - end_of_previous_object,
+                    )?;
+                }
+
+                let mut object = BinderObject::read_from(&mut buffer_reader)?;
+
+                match self.translate_object(offset, object.as_ref(), &mut view) {
+                    Ok(()) => end_of_previous_object = offset + object.size(),
+                    Err(err) => {
+                        pr_warn!("Error while translating object.");
+                        return Err(err);
+                    }
+                }
+
+                // Update the indexes containing objects to clean up.
+                let offset_after_object = index_offset + size_of::<usize>();
+                view.alloc
+                    .set_info_offsets(offsets_start..offset_after_object);
+            }
+        }
 
-        alloc.copy_into(&mut buffer_reader, 0, data_size)?;
+        // Copy remaining raw data.
+        alloc.copy_into(
+            &mut buffer_reader,
+            end_of_previous_object,
+            data_size - end_of_previous_object,
+        )?;
 
         if let Some((off_out, secctx)) = secctx.as_mut() {
             if let Err(err) = alloc.write(secctx_off, secctx.as_bytes()) {
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index a4ffe0a3878c..2faba6e1f47f 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -32,6 +32,7 @@ pub(crate) struct Transaction {
     code: u32,
     pub(crate) flags: u32,
     data_size: usize,
+    offsets_size: usize,
     data_address: usize,
     sender_euid: Kuid,
     txn_security_ctx_off: Option<usize>,
@@ -85,6 +86,7 @@ pub(crate) fn new(
             code: trd.code,
             flags: trd.flags,
             data_size: trd.data_size as _,
+            offsets_size: trd.offsets_size as _,
             data_address,
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
             txn_security_ctx_off,
@@ -116,6 +118,7 @@ pub(crate) fn new_reply(
             code: trd.code,
             flags: trd.flags,
             data_size: trd.data_size as _,
+            offsets_size: trd.offsets_size as _,
             data_address: alloc.ptr,
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
             txn_security_ctx_off: None,
@@ -229,7 +232,7 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
         tr.flags = self.flags;
         tr.data_size = self.data_size as _;
         tr.data.ptr.buffer = self.data_address as _;
-        tr.offsets_size = 0;
+        tr.offsets_size = self.offsets_size as _;
         if tr.offsets_size > 0 {
             tr.data.ptr.offsets = (self.data_address + ptr_align(self.data_size)) as _;
         }
diff --git a/rust/helpers.c b/rust/helpers.c
index e70255f3774f..924c7a00f433 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -342,6 +342,13 @@ int rust_helper_security_binder_transaction(const struct cred *from,
 	return security_binder_transaction(from, to);
 }
 EXPORT_SYMBOL_GPL(rust_helper_security_binder_transaction);
+
+int rust_helper_security_binder_transfer_binder(const struct cred *from,
+						const struct cred *to)
+{
+	return security_binder_transfer_binder(from, to);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_binder_transfer_binder);
 #endif
 
 /*
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 9e3e4cf08ecb..9179fc225406 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -24,6 +24,13 @@ pub fn binder_transaction(from: &Credential, to: &Credential) -> Result {
     to_result(unsafe { bindings::security_binder_transaction(from.0.get(), to.0.get()) })
 }
 
+/// Calls the security modules to determine if task `from` is allowed to send binder objects
+/// (owned by itself or other processes) to task `to` through a binder transaction.
+pub fn binder_transfer_binder(from: &Credential, to: &Credential) -> Result {
+    // SAFETY: `from` and `to` are valid because the shared references guarantee nonzero refcounts.
+    to_result(unsafe { bindings::security_binder_transfer_binder(from.0.get(), to.0.get()) })
+}
+
 /// A security context string.
 ///
 /// The struct has the invariant that it always contains a valid security context.

-- 
2.42.0.820.g83a721a137-goog

