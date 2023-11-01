Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9952B7DE5C8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345073AbjKASDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344883AbjKASDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:03 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366F6115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:47 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-53fa5cd4480so38958a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861765; x=1699466565; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JV3zrCLyeqQczhMfmNzMo9ruR8VdjWrgmPRKWC6d6dI=;
        b=wNQiFmRtQpc4qIM731WBr652K7jKpu5FdL5QOeDC3v4bjwZXS6VqXV7IxwzqWm3rCz
         IV7KrHV+rou2MAGOwzAYciVsZA1Q6jCPzZ0c85qsV4l+OANZvAK4bOWjvUv792knJY1I
         KRFkzRFDURvCO/UyCn3adPv4IYtvMlXUB159ajQ2DMtXl0LJRnUkG3+XMyDNb5WxHSNB
         FLVWcK4IZqsGCLxtjiEbGIkIPjWr+MQcLvdZYtEB2zV8GXTGqvQd6VliJtxNd0QVLlU9
         OW/VMd19Kg6vP2E3wyHbM8/pwNyTFIvfgG81R4dwwV7+71ClYllJUX/ScUET0lsczD+B
         pYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861765; x=1699466565;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JV3zrCLyeqQczhMfmNzMo9ruR8VdjWrgmPRKWC6d6dI=;
        b=j60AesYXVbEOZKfZNOHesx8JkgITZsRrm4Ihi5JJxufZJt5R+foByqDMsYthwYmm9J
         jHvuQl5JlUPc1LI/neGIjogpocM3WjxQv5TEOKbyRMCuOKq3tfQa6DAGfPnO/zP2Q8Us
         BOYqu8KYAYB1t6b54eiin/eJgAubU85Frjw3AON5cD4Q39sApbfajOzTHvWyxQ3FEAtu
         543C6Wo5XfNJHM71syzaRdJfbr6lhKzNlVOkAheaywPJcgd7QQ0yfIgOFVZhaHgIxaeP
         vthphFpKBDsRS7tSQxW3oD1Gf6p7cBVWk+AK0Fww26SntvZ6Ah8hVhI8flAzmP4NjWAF
         3wKg==
X-Gm-Message-State: AOJu0Yxm9xRENzTILnNdmzITbEKWu2pZ7GSaryztEIvGtwqtnYKUM44q
        J7oKZFVCO5LT+1mlTUhcemFC0OYi10w0pwY=
X-Google-Smtp-Source: AGHT+IFBkFcCuyTpC8ZugJvAlyPaAkxPD0TqFR/BCnOj9JZRZAZdvCpZPSEXt37ryWaNk8385siZn0wVreFw6LI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:540e:b0:543:78e5:e00d with SMTP
 id ev14-20020a056402540e00b0054378e5e00dmr50282edb.6.1698861765780; Wed, 01
 Nov 2023 11:02:45 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:42 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-12-08ba9197f637@google.com>
Subject: [PATCH RFC 12/20] rust_binder: add BINDER_TYPE_PTR support
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

Implement support for the scatter-gather feature of binder, which lets
you embed pointers in binder transactions and have them be translated
so that the recipient gets a pointer that also works for them.

This works by adding a second kind of object to the offset array, namely
the BINDER_TYPE_PTR object. This object has a pointer and length
embedded. The kernel will copy the data behind the pointer, and update
the address of the pointer so that the recipient will be able to follow
the pointer and see the same data.

These objects are supported recursively. Other than the pointer in the
main transaction buffer, each buffer may be pointed at by a pointer
in one of the other buffers. This can be used to build arbitrary trees
of buffers.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/defs.rs   |   1 +
 drivers/android/error.rs  |   9 ++
 drivers/android/thread.rs | 340 +++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 344 insertions(+), 6 deletions(-)

diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 68f32a779a3c..267266f3ad76 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -105,6 +105,7 @@ fn default() -> Self {
 decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
 decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
 decl_wrapper!(BinderObjectHeader, bindings::binder_object_header);
+decl_wrapper!(BinderBufferObject, bindings::binder_buffer_object);
 decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
 decl_wrapper!(
     BinderTransactionDataSecctx,
diff --git a/drivers/android/error.rs b/drivers/android/error.rs
index 430b0994affa..c9b991d133d9 100644
--- a/drivers/android/error.rs
+++ b/drivers/android/error.rs
@@ -50,6 +50,15 @@ fn from(_: core::alloc::AllocError) -> Self {
     }
 }
 
+impl From<alloc::collections::TryReserveError> for BinderError {
+    fn from(_: alloc::collections::TryReserveError) -> Self {
+        Self {
+            reply: BR_FAILED_REPLY,
+            source: Some(ENOMEM),
+        }
+    }
+}
+
 impl core::fmt::Debug for BinderError {
     fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
         match self.reply {
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index a9afc7b706c6..86bb32bbabd9 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -35,6 +35,184 @@
     sync::atomic::{AtomicU32, Ordering},
 };
 
+/// Stores the layout of the scatter-gather entries. This is used during the `translate_objects`
+/// call and is discarded when it returns.
+struct ScatterGatherState {
+    /// A struct that tracks the amount of unused buffer space.
+    unused_buffer_space: UnusedBufferSpace,
+    /// Scatter-gather entries to copy.
+    sg_entries: Vec<ScatterGatherEntry>,
+    /// Indexes into `sg_entries` corresponding to the last binder_buffer_object that
+    /// was processed and all of its ancestors. The array is in sorted order.
+    ancestors: Vec<usize>,
+}
+
+/// This entry specifies an additional buffer that should be copied using the scatter-gather
+/// mechanism.
+struct ScatterGatherEntry {
+    /// The index in the offset array of the BINDER_TYPE_PTR that this entry originates from.
+    obj_index: usize,
+    /// Offset in target buffer.
+    offset: usize,
+    /// User address in source buffer.
+    sender_uaddr: usize,
+    /// Number of bytes to copy.
+    length: usize,
+    /// The minimum offset of the next fixup in this buffer.
+    fixup_min_offset: usize,
+    /// The offsets within this buffer that contain pointers which should be translated.
+    pointer_fixups: Vec<PointerFixupEntry>,
+}
+
+/// This entry specifies that a fixup should happen at `target_offset` of the
+/// buffer. If `skip` is nonzero, then the fixup is a `binder_fd_array_object`
+/// and is applied later. Otherwise if `skip` is zero, then the size of the
+/// fixup is `sizeof::<u64>()` and `pointer_value` is written to the buffer.
+struct PointerFixupEntry {
+    /// The number of bytes to skip, or zero for a `binder_buffer_object` fixup.
+    skip: usize,
+    /// The translated pointer to write when `skip` is zero.
+    pointer_value: u64,
+    /// The offset at which the value should be written. The offset is relative
+    /// to the original buffer.
+    target_offset: usize,
+}
+
+/// Return type of `apply_and_validate_fixup_in_parent`.
+struct ParentFixupInfo {
+    /// The index of the parent buffer in `sg_entries`.
+    parent_sg_index: usize,
+    /// The number of ancestors of the buffer.
+    ///
+    /// The buffer is considered an ancestor of itself, so this is always at
+    /// least one.
+    num_ancestors: usize,
+    /// New value of `fixup_min_offset` if this fixup is applied.
+    new_min_offset: usize,
+    /// The offset of the fixup in the target buffer.
+    target_offset: usize,
+}
+
+impl ScatterGatherState {
+    /// Called when a `binder_buffer_object` or `binder_fd_array_object` tries
+    /// to access a region in its parent buffer. These accesses have various
+    /// restrictions, which this method verifies.
+    ///
+    /// The `parent_offset` and `length` arguments describe the offset and
+    /// length of the access in the parent buffer.
+    ///
+    /// # Detailed restrictions
+    ///
+    /// Obviously the fixup must be in-bounds for the parent buffer.
+    ///
+    /// For safety reasons, we only allow fixups inside a buffer to happen
+    /// at increasing offsets; additionally, we only allow fixup on the last
+    /// buffer object that was verified, or one of its parents.
+    ///
+    /// Example of what is allowed:
+    ///
+    /// A
+    ///   B (parent = A, offset = 0)
+    ///   C (parent = A, offset = 16)
+    ///     D (parent = C, offset = 0)
+    ///   E (parent = A, offset = 32) // min_offset is 16 (C.parent_offset)
+    ///
+    /// Examples of what is not allowed:
+    ///
+    /// Decreasing offsets within the same parent:
+    /// A
+    ///   C (parent = A, offset = 16)
+    ///   B (parent = A, offset = 0) // decreasing offset within A
+    ///
+    /// Arcerring to a parent that wasn't the last object or any of its parents:
+    /// A
+    ///   B (parent = A, offset = 0)
+    ///   C (parent = A, offset = 0)
+    ///   C (parent = A, offset = 16)
+    ///     D (parent = B, offset = 0) // B is not A or any of A's parents
+    fn validate_parent_fixup(
+        &self,
+        parent: usize,
+        parent_offset: usize,
+        length: usize,
+    ) -> Result<ParentFixupInfo> {
+        // Using `position` would also be correct, but `rposition` avoids
+        // quadratic running times.
+        let ancestors_i = self
+            .ancestors
+            .iter()
+            .copied()
+            .rposition(|sg_idx| self.sg_entries[sg_idx].obj_index == parent)
+            .ok_or(EINVAL)?;
+        let sg_idx = self.ancestors[ancestors_i];
+        let sg_entry = match self.sg_entries.get(sg_idx) {
+            Some(sg_entry) => sg_entry,
+            None => {
+                pr_err!(
+                    "self.ancestors[{}] is {}, but self.sg_entries.len() is {}",
+                    ancestors_i,
+                    sg_idx,
+                    self.sg_entries.len()
+                );
+                return Err(EINVAL);
+            }
+        };
+        if sg_entry.fixup_min_offset > parent_offset {
+            pr_warn!(
+                "validate_parent_fixup: fixup_min_offset={}, parent_offset={}",
+                sg_entry.fixup_min_offset,
+                parent_offset
+            );
+            return Err(EINVAL);
+        }
+        let new_min_offset = parent_offset.checked_add(length).ok_or(EINVAL)?;
+        if new_min_offset > sg_entry.length {
+            pr_warn!(
+                "validate_parent_fixup: new_min_offset={}, sg_entry.length={}",
+                new_min_offset,
+                sg_entry.length
+            );
+            return Err(EINVAL);
+        }
+        let target_offset = sg_entry.offset.checked_add(parent_offset).ok_or(EINVAL)?;
+        // The `ancestors_i + 1` operation can't overflow since the output of the addition is at
+        // most `self.ancestors.len()`, which also fits in a usize.
+        Ok(ParentFixupInfo {
+            parent_sg_index: sg_idx,
+            num_ancestors: ancestors_i + 1,
+            new_min_offset,
+            target_offset,
+        })
+    }
+}
+
+/// Keeps track of how much unused buffer space is left. The initial amount is the number of bytes
+/// requested by the user using the `buffers_size` field of `binder_transaction_data_sg`. Each time
+/// we translate an object of type `BINDER_TYPE_PTR`, some of the unused buffer space is consumed.
+struct UnusedBufferSpace {
+    /// The start of the remaining space.
+    offset: usize,
+    /// The end of the remaining space.
+    limit: usize,
+}
+impl UnusedBufferSpace {
+    /// Claim the next `size` bytes from the unused buffer space. The offset for the claimed chunk
+    /// into the buffer is returned.
+    fn claim_next(&mut self, size: usize) -> Result<usize> {
+        // We require every chunk to be aligned.
+        let size = ptr_align(size);
+        let new_offset = self.offset.checked_add(size).ok_or(EINVAL)?;
+
+        if new_offset <= self.limit {
+            let offset = self.offset;
+            self.offset = new_offset;
+            Ok(offset)
+        } else {
+            Err(EINVAL)
+        }
+    }
+}
+
 pub(crate) enum PushWorkRes {
     Ok,
     FailedDead(DLArc<dyn DeliverToRead>),
@@ -419,9 +597,11 @@ pub(crate) fn push_return_work(&self, reply: u32) {
 
     fn translate_object(
         &self,
+        obj_index: usize,
         offset: usize,
         object: BinderObjectRef<'_>,
         view: &mut AllocationView<'_>,
+        sg_state: &mut ScatterGatherState,
     ) -> BinderResult {
         match object {
             BinderObjectRef::Binder(obj) => {
@@ -453,9 +633,78 @@ fn translate_object(
                 pr_warn!("Using unsupported binder object type fd.");
                 return Err(EINVAL.into());
             }
-            BinderObjectRef::Ptr(_obj) => {
-                pr_warn!("Using unsupported binder object type ptr.");
-                return Err(EINVAL.into());
+            BinderObjectRef::Ptr(obj) => {
+                let obj_length = obj.length.try_into().map_err(|_| EINVAL)?;
+                let alloc_offset = match sg_state.unused_buffer_space.claim_next(obj_length) {
+                    Ok(alloc_offset) => alloc_offset,
+                    Err(err) => {
+                        pr_warn!(
+                            "Failed to claim space for a BINDER_TYPE_PTR. (offset: {}, limit: {}, size: {})",
+                            sg_state.unused_buffer_space.offset,
+                            sg_state.unused_buffer_space.limit,
+                            obj_length,
+                        );
+                        return Err(err.into());
+                    }
+                };
+
+                let sg_state_idx = sg_state.sg_entries.len();
+                sg_state.sg_entries.try_push(ScatterGatherEntry {
+                    obj_index,
+                    offset: alloc_offset,
+                    sender_uaddr: obj.buffer as _,
+                    length: obj_length,
+                    pointer_fixups: Vec::new(),
+                    fixup_min_offset: 0,
+                })?;
+
+                let buffer_ptr_in_user_space = (view.alloc.ptr + alloc_offset) as u64;
+
+                if obj.flags & bindings::BINDER_BUFFER_FLAG_HAS_PARENT == 0 {
+                    sg_state.ancestors.clear();
+                    sg_state.ancestors.try_push(sg_state_idx)?;
+                } else {
+                    // Another buffer also has a pointer to this buffer, and we need to fixup that
+                    // pointer too.
+
+                    let parent_index = usize::try_from(obj.parent).map_err(|_| EINVAL)?;
+                    let parent_offset = usize::try_from(obj.parent_offset).map_err(|_| EINVAL)?;
+
+                    let info = sg_state.validate_parent_fixup(
+                        parent_index,
+                        parent_offset,
+                        size_of::<u64>(),
+                    )?;
+
+                    sg_state.ancestors.truncate(info.num_ancestors);
+                    sg_state.ancestors.try_push(sg_state_idx)?;
+
+                    let parent_entry = match sg_state.sg_entries.get_mut(info.parent_sg_index) {
+                        Some(parent_entry) => parent_entry,
+                        None => {
+                            pr_err!(
+                                "validate_parent_fixup returned index out of bounds for sg.entries"
+                            );
+                            return Err(EINVAL.into());
+                        }
+                    };
+
+                    parent_entry.fixup_min_offset = info.new_min_offset;
+                    parent_entry.pointer_fixups.try_push(PointerFixupEntry {
+                        skip: 0,
+                        pointer_value: buffer_ptr_in_user_space,
+                        target_offset: info.target_offset,
+                    })?;
+                }
+
+                let mut obj_write = BinderBufferObject::default();
+                obj_write.hdr.type_ = BINDER_TYPE_PTR;
+                obj_write.flags = obj.flags;
+                obj_write.buffer = buffer_ptr_in_user_space;
+                obj_write.length = obj.length;
+                obj_write.parent = obj.parent;
+                obj_write.parent_offset = obj.parent_offset;
+                view.write::<BinderBufferObject>(offset, &obj_write)?;
             }
             BinderObjectRef::Fda(_obj) => {
                 pr_warn!("Using unsupported binder object type fda.");
@@ -465,6 +714,61 @@ fn translate_object(
         Ok(())
     }
 
+    fn apply_sg(&self, alloc: &mut Allocation, sg_state: &mut ScatterGatherState) -> BinderResult {
+        for sg_entry in &mut sg_state.sg_entries {
+            let mut end_of_previous_fixup = sg_entry.offset;
+            let offset_end = sg_entry.offset.checked_add(sg_entry.length).ok_or(EINVAL)?;
+
+            let mut reader =
+                UserSlicePtr::new(sg_entry.sender_uaddr as _, sg_entry.length).reader();
+            for fixup in &mut sg_entry.pointer_fixups {
+                let fixup_len = if fixup.skip == 0 {
+                    size_of::<u64>()
+                } else {
+                    fixup.skip
+                };
+
+                let target_offset_end = fixup.target_offset.checked_add(fixup_len).ok_or(EINVAL)?;
+                if fixup.target_offset < end_of_previous_fixup || offset_end < target_offset_end {
+                    pr_warn!(
+                        "Fixups oob {} {} {} {}",
+                        fixup.target_offset,
+                        end_of_previous_fixup,
+                        offset_end,
+                        target_offset_end
+                    );
+                    return Err(EINVAL.into());
+                }
+
+                let copy_off = end_of_previous_fixup;
+                let copy_len = fixup.target_offset - end_of_previous_fixup;
+                if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
+                    pr_warn!("Failed copying into alloc: {:?}", err);
+                    return Err(err.into());
+                }
+                if fixup.skip == 0 {
+                    let res = alloc.write::<u64>(fixup.target_offset, &fixup.pointer_value);
+                    if let Err(err) = res {
+                        pr_warn!("Failed copying ptr into alloc: {:?}", err);
+                        return Err(err.into());
+                    }
+                }
+                if let Err(err) = reader.skip(fixup_len) {
+                    pr_warn!("Failed skipping {} from reader: {:?}", fixup_len, err);
+                    return Err(err.into());
+                }
+                end_of_previous_fixup = target_offset_end;
+            }
+            let copy_off = end_of_previous_fixup;
+            let copy_len = offset_end - end_of_previous_fixup;
+            if let Err(err) = alloc.copy_into(&mut reader, copy_off, copy_len) {
+                pr_warn!("Failed copying remainder into alloc: {:?}", err);
+                return Err(err.into());
+            }
+        }
+        Ok(())
+    }
+
     pub(crate) fn copy_transaction_data(
         &self,
         to_process: Arc<Process>,
@@ -491,6 +795,8 @@ pub(crate) fn copy_transaction_data(
         let adata_size = ptr_align(data_size);
         let offsets_size = trd.offsets_size.try_into().map_err(|_| EINVAL)?;
         let aoffsets_size = ptr_align(offsets_size);
+        let buffers_size = tr.buffers_size.try_into().map_err(|_| EINVAL)?;
+        let abuffers_size = ptr_align(buffers_size);
         let asecctx_size = secctx
             .as_ref()
             .map(|(_, ctx)| ptr_align(ctx.len()))
@@ -500,11 +806,12 @@ pub(crate) fn copy_transaction_data(
         let len = usize::max(
             adata_size
                 .checked_add(aoffsets_size)
+                .and_then(|sum| sum.checked_add(abuffers_size))
                 .and_then(|sum| sum.checked_add(asecctx_size))
                 .ok_or(ENOMEM)?,
             size_of::<usize>(),
         );
-        let secctx_off = adata_size + aoffsets_size;
+        let secctx_off = adata_size + aoffsets_size + abuffers_size;
         let mut alloc = match to_process.buffer_alloc(len, is_oneway) {
             Ok(alloc) => alloc,
             Err(err) => {
@@ -520,6 +827,7 @@ pub(crate) fn copy_transaction_data(
         let mut buffer_reader =
             unsafe { UserSlicePtr::new(trd.data.ptr.buffer as _, data_size) }.reader();
         let mut end_of_previous_object = 0;
+        let mut sg_state = None;
 
         // Copy offsets if there are any.
         if offsets_size > 0 {
@@ -532,9 +840,22 @@ pub(crate) fn copy_transaction_data(
             let offsets_start = adata_size;
             let offsets_end = adata_size + aoffsets_size;
 
+            // This state is used for BINDER_TYPE_PTR objects.
+            let sg_state = sg_state.insert(ScatterGatherState {
+                unused_buffer_space: UnusedBufferSpace {
+                    offset: offsets_end,
+                    limit: len,
+                },
+                sg_entries: Vec::new(),
+                ancestors: Vec::new(),
+            });
+
             // Traverse the objects specified.
             let mut view = AllocationView::new(&mut alloc, data_size);
-            for index_offset in (offsets_start..offsets_end).step_by(size_of::<usize>()) {
+            for (index, index_offset) in (offsets_start..offsets_end)
+                .step_by(size_of::<usize>())
+                .enumerate()
+            {
                 let offset = view.alloc.read(index_offset)?;
 
                 // Copy data between two objects.
@@ -548,7 +869,7 @@ pub(crate) fn copy_transaction_data(
 
                 let mut object = BinderObject::read_from(&mut buffer_reader)?;
 
-                match self.translate_object(offset, object.as_ref(), &mut view) {
+                match self.translate_object(index, offset, object.as_ref(), &mut view, sg_state) {
                     Ok(()) => end_of_previous_object = offset + object.size(),
                     Err(err) => {
                         pr_warn!("Error while translating object.");
@@ -570,6 +891,13 @@ pub(crate) fn copy_transaction_data(
             data_size - end_of_previous_object,
         )?;
 
+        if let Some(sg_state) = sg_state.as_mut() {
+            if let Err(err) = self.apply_sg(&mut alloc, sg_state) {
+                pr_warn!("Failure in apply_sg: {:?}", err);
+                return Err(err);
+            }
+        }
+
         if let Some((off_out, secctx)) = secctx.as_mut() {
             if let Err(err) = alloc.write(secctx_off, secctx.as_bytes()) {
                 pr_warn!("Failed to write security context: {:?}", err);

-- 
2.42.0.820.g83a721a137-goog

