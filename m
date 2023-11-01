Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED1A7DE5D1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345080AbjKASD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbjKASDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14D137
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:51 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7be940fe1so1062137b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861771; x=1699466571; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7OV6uaLlQsboEevkgmaMATEvLuiVaZeY7BNHWhRI4M=;
        b=tD0LgdpfbXEG+lDY2qY+s79bp5g4ekyYR4FS6rQKgW0hSnsFn+xVDpfpPmqCV6QVJs
         /NOE4paGLYVwRqYQgxG0zSUa1Zad5pIPosOUrgCph+40A3+IG6Os7xhXuK65mUxKTiCw
         MfcMD0Zn0CGVjS5cDooWKiY2ze1u79/8g+V6+SdHOCvHHD+BGsdYLv5Wgi1ZwcWBiFIC
         mXJp4MovqDYn2iz1SNaN1g9SH4B1xv1R/s7xjOctjgXBZDXu/+tPLs1UdqneX4BahKeQ
         uFrt862M8MmUihMhsJYDuXmM8l5dhLaXOPytf1n690OpwKD2oL5LvHYnDnaDu+w6J6P1
         RQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861771; x=1699466571;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B7OV6uaLlQsboEevkgmaMATEvLuiVaZeY7BNHWhRI4M=;
        b=P1bZDN1QDVvaALId3W5c3fQ5AuRNfZxo2tyBwMlqcA3UXUbmCNdB/yfJLYRyVkmqN7
         oLwa9hEVccMX+Vuy9ZldmIWkjS3PkFI80iiepc+Qql+BdRzyTLbOus7fT3GK/KbXXMn/
         KT5q3UZTfsYQ16FAsr/+iRyPndBmT4fx6dEQGphoUP3ifIbU3TI9K1k/ZeMXy9PrXGY0
         7C5Obyc3BvpmJPa9qgswZBjwFN15f/21H1b1O8UjQEqGyl/kX3zZHRWlY31zu38St9UP
         YQCBtQF9+QlQME11JlVZggDpK2TsGFJWYVIa6r7EXDOPFq0NI8zTJqL49IAerFjbHw8T
         Cv0A==
X-Gm-Message-State: AOJu0YwMqExtcbb0w5VxGk/0ofJRitHs+wwtPgDpwqexFU/fqg7iXXas
        v48TM6iAjiHX7NKHAVZF9orIu81o0pedSkQ=
X-Google-Smtp-Source: AGHT+IG1Aa3QotWzMkzsJYmcnoPcKtEssBTYYOJB9cl4Z1ymMvg3oCwSde7erMTObE3FyVLHN/HIoHfQNam2q9c=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a25:5c2:0:b0:d9a:68de:16a1 with SMTP id
 185-20020a2505c2000000b00d9a68de16a1mr318148ybf.0.1698861770944; Wed, 01 Nov
 2023 11:02:50 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:44 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-14-08ba9197f637@google.com>
Subject: [PATCH RFC 14/20] rust_binder: add BINDER_TYPE_FDA support
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

In the previous patch, we introduced support for `BINDER_TYPE_FD`
objects that let you send a single fd, and in this patch, we add support
for FD arrays. One important difference between `BINDER_TYPE_FD` and
`BINDER_TYPE_FDA` is that FD arrays will close the file descriptors when
the transaction allocation is freed, whereas FDs sent using
`BINDER_TYPE_FD` are not closed.

Note that `BINDER_TYPE_FDA` is used only with hwbinder.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  | 74 ++++++++++++++++++++++++++++++++---
 drivers/android/defs.rs        |  1 +
 drivers/android/thread.rs      | 87 +++++++++++++++++++++++++++++++++++++++---
 drivers/android/transaction.rs | 13 ++++---
 4 files changed, 159 insertions(+), 16 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index 9d777ffb7176..c7f44a54b79b 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -4,7 +4,7 @@
 
 use kernel::{
     bindings,
-    file::{File, FileDescriptorReservation},
+    file::{DeferredFdCloser, File, FileDescriptorReservation},
     io_buffer::{IoBufferReader, ReadableFromBytes, WritableToBytes},
     pages::Pages,
     prelude::*,
@@ -165,18 +165,38 @@ pub(crate) fn set_info_target_node(&mut self, target_node: NodeRef) {
         self.get_or_init_info().target_node = Some(target_node);
     }
 
-    pub(crate) fn info_add_fd(&mut self, file: ARef<File>, buffer_offset: usize) -> Result {
+    /// Reserve enough space to push at least `num_fds` fds.
+    pub(crate) fn info_add_fd_reserve(&mut self, num_fds: usize) -> Result {
+        self.get_or_init_info()
+            .file_list
+            .files_to_translate
+            .try_reserve(num_fds)?;
+
+        Ok(())
+    }
+
+    pub(crate) fn info_add_fd(
+        &mut self,
+        file: ARef<File>,
+        buffer_offset: usize,
+        close_on_free: bool,
+    ) -> Result {
         self.get_or_init_info()
             .file_list
             .files_to_translate
             .try_push(FileEntry {
                 file,
                 buffer_offset,
+                close_on_free,
             })?;
 
         Ok(())
     }
 
+    pub(crate) fn set_info_close_on_free(&mut self, cof: FdsCloseOnFree) {
+        self.get_or_init_info().file_list.close_on_free = cof.0;
+    }
+
     pub(crate) fn translate_fds(&mut self) -> Result<TranslatedFds> {
         let file_list = match self.allocation_info.as_mut() {
             Some(info) => &mut info.file_list,
@@ -184,17 +204,38 @@ pub(crate) fn translate_fds(&mut self) -> Result<TranslatedFds> {
         };
 
         let files = core::mem::take(&mut file_list.files_to_translate);
+
+        let num_close_on_free = files.iter().filter(|entry| entry.close_on_free).count();
+        let mut close_on_free = Vec::try_with_capacity(num_close_on_free)?;
+
         let mut reservations = Vec::try_with_capacity(files.len())?;
         for file_info in files {
             let res = FileDescriptorReservation::new(bindings::O_CLOEXEC)?;
-            self.write::<u32>(file_info.buffer_offset, &res.reserved_fd())?;
+            let fd = res.reserved_fd();
+            self.write::<u32>(file_info.buffer_offset, &fd)?;
             reservations.try_push(Reservation {
                 res,
                 file: file_info.file,
             })?;
+            if file_info.close_on_free {
+                close_on_free.try_push(fd)?;
+            }
         }
 
-        Ok(TranslatedFds { reservations })
+        Ok(TranslatedFds {
+            reservations,
+            close_on_free: FdsCloseOnFree(close_on_free),
+        })
+    }
+
+    /// Should the looper return to userspace when freeing this allocation?
+    pub(crate) fn looper_need_return_on_free(&self) -> bool {
+        // Closing fds involves pushing task_work for execution when we return to userspace. Hence,
+        // we should return to userspace asap if we are closing fds.
+        match self.allocation_info {
+            Some(ref info) => !info.file_list.close_on_free.is_empty(),
+            None => false,
+        }
     }
 }
 
@@ -220,6 +261,18 @@ fn drop(&mut self) {
                 }
             }
 
+            for &fd in &info.file_list.close_on_free {
+                let closer = match DeferredFdCloser::new() {
+                    Ok(closer) => closer,
+                    Err(core::alloc::AllocError) => {
+                        // Ignore allocation failures.
+                        break;
+                    }
+                };
+
+                closer.close_fd(fd);
+            }
+
             if info.clear_on_free {
                 if let Err(e) = self.fill_zero() {
                     pr_warn!("Failed to clear data on free: {:?}", e);
@@ -457,6 +510,7 @@ fn type_to_size(type_: u32) -> Option<usize> {
 #[derive(Default)]
 struct FileList {
     files_to_translate: Vec<FileEntry>,
+    close_on_free: Vec<u32>,
 }
 
 struct FileEntry {
@@ -464,10 +518,15 @@ struct FileEntry {
     file: ARef<File>,
     /// The offset in the buffer where the file descriptor is stored.
     buffer_offset: usize,
+    /// Whether this fd should be closed when the allocation is freed.
+    close_on_free: bool,
 }
 
 pub(crate) struct TranslatedFds {
     reservations: Vec<Reservation>,
+    /// If commit is called, then these fds should be closed. (If commit is not called, then they
+    /// shouldn't be closed.)
+    close_on_free: FdsCloseOnFree,
 }
 
 struct Reservation {
@@ -479,12 +538,17 @@ impl TranslatedFds {
     pub(crate) fn new() -> Self {
         Self {
             reservations: Vec::new(),
+            close_on_free: FdsCloseOnFree(Vec::new()),
         }
     }
 
-    pub(crate) fn commit(self) {
+    pub(crate) fn commit(self) -> FdsCloseOnFree {
         for entry in self.reservations {
             entry.res.commit(entry.file);
         }
+
+        self.close_on_free
     }
 }
+
+pub(crate) struct FdsCloseOnFree(Vec<u32>);
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index fa4ec3eff424..8f9419d474de 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -106,6 +106,7 @@ fn default() -> Self {
 decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
 decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
 decl_wrapper!(BinderFdObject, bindings::binder_fd_object);
+decl_wrapper!(BinderFdArrayObject, bindings::binder_fd_array_object);
 decl_wrapper!(BinderObjectHeader, bindings::binder_object_header);
 decl_wrapper!(BinderBufferObject, bindings::binder_buffer_object);
 decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 56b36dc43bcc..2e86592fb61f 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -654,7 +654,8 @@ fn translate_object(
                 const FD_FIELD_OFFSET: usize =
                     ::core::mem::offset_of!(bindings::binder_fd_object, __bindgen_anon_1.fd)
                         as usize;
-                view.alloc.info_add_fd(file, offset + FD_FIELD_OFFSET)?;
+                view.alloc
+                    .info_add_fd(file, offset + FD_FIELD_OFFSET, false)?;
             }
             BinderObjectRef::Ptr(obj) => {
                 let obj_length = obj.length.try_into().map_err(|_| EINVAL)?;
@@ -729,9 +730,77 @@ fn translate_object(
                 obj_write.parent_offset = obj.parent_offset;
                 view.write::<BinderBufferObject>(offset, &obj_write)?;
             }
-            BinderObjectRef::Fda(_obj) => {
-                pr_warn!("Using unsupported binder object type fda.");
-                return Err(EINVAL.into());
+            BinderObjectRef::Fda(obj) => {
+                if !allow_fds {
+                    return Err(EPERM.into());
+                }
+                let parent_index = usize::try_from(obj.parent).map_err(|_| EINVAL)?;
+                let parent_offset = usize::try_from(obj.parent_offset).map_err(|_| EINVAL)?;
+                let num_fds = usize::try_from(obj.num_fds).map_err(|_| EINVAL)?;
+                let fds_len = num_fds.checked_mul(size_of::<u32>()).ok_or(EINVAL)?;
+
+                view.alloc.info_add_fd_reserve(num_fds)?;
+
+                let info = sg_state.validate_parent_fixup(parent_index, parent_offset, fds_len)?;
+
+                sg_state.ancestors.truncate(info.num_ancestors);
+                let parent_entry = match sg_state.sg_entries.get_mut(info.parent_sg_index) {
+                    Some(parent_entry) => parent_entry,
+                    None => {
+                        pr_err!(
+                            "validate_parent_fixup returned index out of bounds for sg.entries"
+                        );
+                        return Err(EINVAL.into());
+                    }
+                };
+
+                parent_entry.fixup_min_offset = info.new_min_offset;
+                parent_entry
+                    .pointer_fixups
+                    .try_push(PointerFixupEntry {
+                        skip: fds_len,
+                        pointer_value: 0,
+                        target_offset: info.target_offset,
+                    })
+                    .map_err(|_| ENOMEM)?;
+
+                let fda_uaddr = parent_entry
+                    .sender_uaddr
+                    .checked_add(parent_offset)
+                    .ok_or(EINVAL)?;
+                let fda_bytes = UserSlicePtr::new(fda_uaddr as _, fds_len).read_all()?;
+
+                if fds_len != fda_bytes.len() {
+                    pr_err!("UserSlicePtr::read_all returned wrong length in BINDER_TYPE_FDA");
+                    return Err(EINVAL.into());
+                }
+
+                for i in (0..fds_len).step_by(size_of::<u32>()) {
+                    let fd = {
+                        let mut fd_bytes = [0u8; size_of::<u32>()];
+                        fd_bytes.copy_from_slice(&fda_bytes[i..i + size_of::<u32>()]);
+                        u32::from_ne_bytes(fd_bytes)
+                    };
+
+                    let file = File::from_fd(fd)?;
+                    security::binder_transfer_file(
+                        &self.process.cred,
+                        &view.alloc.process.cred,
+                        &file,
+                    )?;
+
+                    // The `validate_parent_fixup` call ensuers that this addition will not
+                    // overflow.
+                    view.alloc.info_add_fd(file, info.target_offset + i, true)?;
+                }
+                drop(fda_bytes);
+
+                let mut obj_write = BinderFdArrayObject::default();
+                obj_write.hdr.type_ = BINDER_TYPE_FDA;
+                obj_write.num_fds = obj.num_fds;
+                obj_write.parent = obj.parent;
+                obj_write.parent_offset = obj.parent_offset;
+                view.write::<BinderFdArrayObject>(offset, &obj_write)?;
             }
         }
         Ok(())
@@ -1160,7 +1229,15 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
                     let tr = reader.read::<BinderTransactionDataSg>()?;
                     self.transaction(&tr, Self::reply_inner)
                 }
-                BC_FREE_BUFFER => drop(self.process.buffer_get(reader.read()?)),
+                BC_FREE_BUFFER => {
+                    let buffer = self.process.buffer_get(reader.read()?);
+                    if let Some(buffer) = &buffer {
+                        if buffer.looper_need_return_on_free() {
+                            self.inner.lock().looper_need_return = true;
+                        }
+                    }
+                    drop(buffer);
+                }
                 BC_INCREFS => self.process.update_ref(reader.read()?, true, false)?,
                 BC_ACQUIRE => self.process.update_ref(reader.read()?, true, true)?,
                 BC_RELEASE => self.process.update_ref(reader.read()?, false, true)?,
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index 3230ea490a5b..ec32a9fd0ff1 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -288,17 +288,18 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
             writer.write(&*tr)?;
         }
 
+        let mut alloc = self.allocation.lock().take().ok_or(ESRCH)?;
+
         // Dismiss the completion of transaction with a failure. No failure paths are allowed from
         // here on out.
         send_failed_reply.dismiss();
 
-        // It is now the user's responsibility to clear the allocation.
-        let alloc = self.allocation.lock().take();
-        if let Some(alloc) = alloc {
-            alloc.keep_alive();
-        }
+        // Commit files, and set FDs in FDA to be closed on buffer free.
+        let close_on_free = files.commit();
+        alloc.set_info_close_on_free(close_on_free);
 
-        files.commit();
+        // It is now the user's responsibility to clear the allocation.
+        alloc.keep_alive();
 
         // When this is not a reply and not a oneway transaction, update `current_transaction`. If
         // it's a reply, `current_transaction` has already been updated appropriately.

-- 
2.42.0.820.g83a721a137-goog

