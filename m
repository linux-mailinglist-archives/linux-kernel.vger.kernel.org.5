Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0522F7DE5C9
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344779AbjKASDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbjKASDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F539135
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:49 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so875337b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861768; x=1699466568; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=psYJm8f56TM0xllYa3fp9wp+aSzbtAS//QrfAgDcVlw=;
        b=3xSPh+i3ZANmX7patSomJLhthYcdsVXgn0nK1v6T+1IH8ZvWlV7Tr8rCIxD+rchPAR
         jmcugb4F2XXr+MFozChimoh2R49JRwf2iwzYpbEdwBJy598mIGP64X/RWUEIEuBKHAvh
         arqw6qX8sqcADJkw43I2mBCQimBTP9e/lM2TKZr/NdkSBB44Z3etER+jW60Dp+b0CHu0
         /hldRxxozACuN5FoXgoxrPLn5fpVskvupjzi+oHbKsrizYy4MWVUh4SHDdJciWVPeemw
         TB8CF+QLCSh5VMgFjHNI1HO7/2hTfpoKYrSvZludxqseiMIlI4st1+AK9iXIJeTnEorU
         Y2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861768; x=1699466568;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=psYJm8f56TM0xllYa3fp9wp+aSzbtAS//QrfAgDcVlw=;
        b=IDAX/yeQCT466ejYDlKCaOOQE/AeqxnVA7kiczdUjCJ+L0A2ueoKWWU/gbILsX5/gp
         gIl1HTiFAS+onM9UxC7iuVX3TYzQ+mQulWvuHahWTAm/Nk3kra1s/COepZ81DMGwLtBE
         8XeauAxMqu1y7cszT+fHUCopB+eL4+gpQNcJtMA5scoOJQY+rq16onXhgGS4YWADWQUJ
         U4LqFYcdm893SjeYU56fwyD5Dld9ptumi/sJb2bYYLlKRGPzmKqaQRNbNxNUbASsr73g
         wNXXLEgqCzX3DY/XB9iUin7tgWopKHnhXbFRROXR1hgRsPg6Kq68PzhmaPPk1tRNjPcI
         0CtA==
X-Gm-Message-State: AOJu0Yx2WlfgvuEaFLAFVOUSdz5Qvqq7/hakVwFDiP7hFmp+4RT9DK0Q
        Zm9WxJzxMD6PQkdADYv98blvmW5vjE2SXlc=
X-Google-Smtp-Source: AGHT+IFVUwnbuRcmy4a+CwATvSQm/F3wnDaf5D+YVdhG4Eeh+iH3zRcmkZmF2wLkx3cCxbEQ2tcEzxNDBlh+0ow=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a0d:c001:0:b0:5a4:fd03:2516 with SMTP id
 b1-20020a0dc001000000b005a4fd032516mr180157ywd.1.1698861768386; Wed, 01 Nov
 2023 11:02:48 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:43 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-13-08ba9197f637@google.com>
Subject: [PATCH RFC 13/20] rust_binder: add BINDER_TYPE_FD support
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

Add support for sending fds over binder.

Unlike the other object types, file descriptors are not translated until
the transaction is actually received by the recipient. Until that
happens, we store `u32::MAX` as the fd.

Translating fds is done in a two-phase process. First, the file
descriptors are allocated and written to the allocation. Then, once we
have allocated all of them, we commit them to the files in question.
Using this strategy, we are able to guarantee that we either send all of
the fds, or none of them.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  | 71 ++++++++++++++++++++++++++++++++++++++++++
 drivers/android/defs.rs        |  4 ++-
 drivers/android/error.rs       |  6 ++++
 drivers/android/thread.rs      | 42 ++++++++++++++++++++++---
 drivers/android/transaction.rs | 53 ++++++++++++++++++++++++-------
 rust/helpers.c                 |  8 +++++
 rust/kernel/file.rs            |  2 +-
 rust/kernel/security.rs        | 11 +++++++
 8 files changed, 179 insertions(+), 18 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index 32bc268956f2..9d777ffb7176 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -4,10 +4,12 @@
 
 use kernel::{
     bindings,
+    file::{File, FileDescriptorReservation},
     io_buffer::{IoBufferReader, ReadableFromBytes, WritableToBytes},
     pages::Pages,
     prelude::*,
     sync::Arc,
+    types::ARef,
     user_ptr::UserSlicePtrReader,
 };
 
@@ -32,6 +34,8 @@ pub(crate) struct AllocationInfo {
     pub(crate) oneway_node: Option<DArc<Node>>,
     /// Zero the data in the buffer on free.
     pub(crate) clear_on_free: bool,
+    /// List of files embedded in this transaction.
+    file_list: FileList,
 }
 
 /// Represents an allocation that the kernel is currently using.
@@ -160,6 +164,38 @@ pub(crate) fn set_info_clear_on_drop(&mut self) {
     pub(crate) fn set_info_target_node(&mut self, target_node: NodeRef) {
         self.get_or_init_info().target_node = Some(target_node);
     }
+
+    pub(crate) fn info_add_fd(&mut self, file: ARef<File>, buffer_offset: usize) -> Result {
+        self.get_or_init_info()
+            .file_list
+            .files_to_translate
+            .try_push(FileEntry {
+                file,
+                buffer_offset,
+            })?;
+
+        Ok(())
+    }
+
+    pub(crate) fn translate_fds(&mut self) -> Result<TranslatedFds> {
+        let file_list = match self.allocation_info.as_mut() {
+            Some(info) => &mut info.file_list,
+            None => return Ok(TranslatedFds::new()),
+        };
+
+        let files = core::mem::take(&mut file_list.files_to_translate);
+        let mut reservations = Vec::try_with_capacity(files.len())?;
+        for file_info in files {
+            let res = FileDescriptorReservation::new(bindings::O_CLOEXEC)?;
+            self.write::<u32>(file_info.buffer_offset, &res.reserved_fd())?;
+            reservations.try_push(Reservation {
+                res,
+                file: file_info.file,
+            })?;
+        }
+
+        Ok(TranslatedFds { reservations })
+    }
 }
 
 impl Drop for Allocation {
@@ -417,3 +453,38 @@ fn type_to_size(type_: u32) -> Option<usize> {
         }
     }
 }
+
+#[derive(Default)]
+struct FileList {
+    files_to_translate: Vec<FileEntry>,
+}
+
+struct FileEntry {
+    /// The file for which a descriptor will be created in the recipient process.
+    file: ARef<File>,
+    /// The offset in the buffer where the file descriptor is stored.
+    buffer_offset: usize,
+}
+
+pub(crate) struct TranslatedFds {
+    reservations: Vec<Reservation>,
+}
+
+struct Reservation {
+    res: FileDescriptorReservation,
+    file: ARef<File>,
+}
+
+impl TranslatedFds {
+    pub(crate) fn new() -> Self {
+        Self {
+            reservations: Vec::new(),
+        }
+    }
+
+    pub(crate) fn commit(self) {
+        for entry in self.reservations {
+            entry.res.commit(entry.file);
+        }
+    }
+}
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 267266f3ad76..fa4ec3eff424 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -54,9 +54,10 @@ macro_rules! pub_no_prefix {
     BC_DEAD_BINDER_DONE
 );
 
+pub(crate) const FLAT_BINDER_FLAG_ACCEPTS_FDS: u32 = kernel::bindings::FLAT_BINDER_FLAG_ACCEPTS_FDS;
 pub(crate) const FLAT_BINDER_FLAG_TXN_SECURITY_CTX: u32 =
     kernel::bindings::FLAT_BINDER_FLAG_TXN_SECURITY_CTX;
-pub_no_prefix!(transaction_flags_, TF_ONE_WAY, TF_CLEAR_BUF);
+pub_no_prefix!(transaction_flags_, TF_ONE_WAY, TF_ACCEPT_FDS, TF_CLEAR_BUF);
 
 pub(crate) use bindings::{
     BINDER_TYPE_BINDER, BINDER_TYPE_FD, BINDER_TYPE_FDA, BINDER_TYPE_HANDLE, BINDER_TYPE_PTR,
@@ -104,6 +105,7 @@ fn default() -> Self {
 decl_wrapper!(BinderNodeDebugInfo, bindings::binder_node_debug_info);
 decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
 decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
+decl_wrapper!(BinderFdObject, bindings::binder_fd_object);
 decl_wrapper!(BinderObjectHeader, bindings::binder_object_header);
 decl_wrapper!(BinderBufferObject, bindings::binder_buffer_object);
 decl_wrapper!(BinderTransactionData, bindings::binder_transaction_data);
diff --git a/drivers/android/error.rs b/drivers/android/error.rs
index c9b991d133d9..6735636d2a1c 100644
--- a/drivers/android/error.rs
+++ b/drivers/android/error.rs
@@ -41,6 +41,12 @@ fn from(source: Error) -> Self {
     }
 }
 
+impl From<kernel::file::BadFdError> for BinderError {
+    fn from(source: kernel::file::BadFdError) -> Self {
+        BinderError::from(Error::from(source))
+    }
+}
+
 impl From<core::alloc::AllocError> for BinderError {
     fn from(_: core::alloc::AllocError) -> Self {
         Self {
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 86bb32bbabd9..56b36dc43bcc 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -601,6 +601,7 @@ fn translate_object(
         offset: usize,
         object: BinderObjectRef<'_>,
         view: &mut AllocationView<'_>,
+        allow_fds: bool,
         sg_state: &mut ScatterGatherState,
     ) -> BinderResult {
         match object {
@@ -629,9 +630,31 @@ fn translate_object(
                 security::binder_transfer_binder(&self.process.cred, &view.alloc.process.cred)?;
                 view.transfer_binder_object(offset, obj, strong, node)?;
             }
-            BinderObjectRef::Fd(_obj) => {
-                pr_warn!("Using unsupported binder object type fd.");
-                return Err(EINVAL.into());
+            BinderObjectRef::Fd(obj) => {
+                if !allow_fds {
+                    return Err(EPERM.into());
+                }
+
+                // SAFETY: `fd` is a `u32`; any bit pattern is a valid representation.
+                let fd = unsafe { obj.__bindgen_anon_1.fd };
+                let file = File::from_fd(fd)?;
+                security::binder_transfer_file(
+                    &self.process.cred,
+                    &view.alloc.process.cred,
+                    &file,
+                )?;
+
+                let mut obj_write = BinderFdObject::default();
+                obj_write.hdr.type_ = BINDER_TYPE_FD;
+                // This will be overwritten with the actual fd when the transaction is received.
+                obj_write.__bindgen_anon_1.fd = u32::MAX;
+                obj_write.cookie = obj.cookie;
+                view.write::<BinderFdObject>(offset, &obj_write)?;
+
+                const FD_FIELD_OFFSET: usize =
+                    ::core::mem::offset_of!(bindings::binder_fd_object, __bindgen_anon_1.fd)
+                        as usize;
+                view.alloc.info_add_fd(file, offset + FD_FIELD_OFFSET)?;
             }
             BinderObjectRef::Ptr(obj) => {
                 let obj_length = obj.length.try_into().map_err(|_| EINVAL)?;
@@ -773,6 +796,7 @@ pub(crate) fn copy_transaction_data(
         &self,
         to_process: Arc<Process>,
         tr: &BinderTransactionDataSg,
+        allow_fds: bool,
         txn_security_ctx_offset: Option<&mut usize>,
     ) -> BinderResult<Allocation> {
         let trd = &tr.transaction_data;
@@ -869,7 +893,14 @@ pub(crate) fn copy_transaction_data(
 
                 let mut object = BinderObject::read_from(&mut buffer_reader)?;
 
-                match self.translate_object(index, offset, object.as_ref(), &mut view, sg_state) {
+                match self.translate_object(
+                    index,
+                    offset,
+                    object.as_ref(),
+                    &mut view,
+                    allow_fds,
+                    sg_state,
+                ) {
                     Ok(()) => end_of_previous_object = offset + object.size(),
                     Err(err) => {
                         pr_warn!("Error while translating object.");
@@ -1059,7 +1090,8 @@ fn reply_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
         (|| -> BinderResult<_> {
             let completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
             let process = orig.from.process.clone();
-            let reply = Transaction::new_reply(self, process, tr)?;
+            let allow_fds = orig.flags & TF_ACCEPT_FDS != 0;
+            let reply = Transaction::new_reply(self, process, tr, allow_fds)?;
             self.inner.lock().push_work(completion);
             orig.from.deliver_reply(Either::Left(reply), &orig);
             Ok(())
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index 2faba6e1f47f..3230ea490a5b 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -11,7 +11,7 @@
 };
 
 use crate::{
-    allocation::Allocation,
+    allocation::{Allocation, TranslatedFds},
     defs::*,
     error::{BinderError, BinderResult},
     node::{Node, NodeRef},
@@ -50,19 +50,24 @@ pub(crate) fn new(
         tr: &BinderTransactionDataSg,
     ) -> BinderResult<DLArc<Self>> {
         let trd = &tr.transaction_data;
+        let allow_fds = node_ref.node.flags & FLAT_BINDER_FLAG_ACCEPTS_FDS != 0;
         let txn_security_ctx = node_ref.node.flags & FLAT_BINDER_FLAG_TXN_SECURITY_CTX != 0;
         let mut txn_security_ctx_off = if txn_security_ctx { Some(0) } else { None };
         let to = node_ref.node.owner.clone();
-        let mut alloc =
-            match from.copy_transaction_data(to.clone(), tr, txn_security_ctx_off.as_mut()) {
-                Ok(alloc) => alloc,
-                Err(err) => {
-                    if !err.is_dead() {
-                        pr_warn!("Failure in copy_transaction_data: {:?}", err);
-                    }
-                    return Err(err);
+        let mut alloc = match from.copy_transaction_data(
+            to.clone(),
+            tr,
+            allow_fds,
+            txn_security_ctx_off.as_mut(),
+        ) {
+            Ok(alloc) => alloc,
+            Err(err) => {
+                if !err.is_dead() {
+                    pr_warn!("Failure in copy_transaction_data: {:?}", err);
                 }
-            };
+                return Err(err);
+            }
+        };
         if trd.flags & TF_ONE_WAY != 0 {
             if stack_next.is_some() {
                 pr_warn!("Oneway transaction should not be in a transaction stack.");
@@ -97,9 +102,10 @@ pub(crate) fn new_reply(
         from: &Arc<Thread>,
         to: Arc<Process>,
         tr: &BinderTransactionDataSg,
+        allow_fds: bool,
     ) -> BinderResult<DLArc<Self>> {
         let trd = &tr.transaction_data;
-        let mut alloc = match from.copy_transaction_data(to.clone(), tr, None) {
+        let mut alloc = match from.copy_transaction_data(to.clone(), tr, allow_fds, None) {
             Ok(alloc) => alloc,
             Err(err) => {
                 pr_warn!("Failure in copy_transaction_data: {:?}", err);
@@ -210,6 +216,22 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
             }
         }
     }
+
+    fn prepare_file_list(&self) -> Result<TranslatedFds> {
+        let mut alloc = self.allocation.lock().take().ok_or(ESRCH)?;
+
+        match alloc.translate_fds() {
+            Ok(translated) => {
+                *self.allocation.lock() = Some(alloc);
+                Ok(translated)
+            }
+            Err(err) => {
+                // Free the allocation eagerly.
+                drop(alloc);
+                Err(err)
+            }
+        }
+    }
 }
 
 impl DeliverToRead for Transaction {
@@ -220,6 +242,13 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
                 self.from.deliver_reply(reply, &self);
             }
         });
+        let files = if let Ok(list) = self.prepare_file_list() {
+            list
+        } else {
+            // On failure to process the list, we send a reply back to the sender and ignore the
+            // transaction on the recipient.
+            return Ok(true);
+        };
 
         let mut tr_sec = BinderTransactionDataSecctx::default();
         let tr = tr_sec.tr_data();
@@ -269,6 +298,8 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
             alloc.keep_alive();
         }
 
+        files.commit();
+
         // When this is not a reply and not a oneway transaction, update `current_transaction`. If
         // it's a reply, `current_transaction` has already been updated appropriately.
         if self.target_node.is_some() && tr_sec.transaction_data.flags & TF_ONE_WAY == 0 {
diff --git a/rust/helpers.c b/rust/helpers.c
index 924c7a00f433..be295d8bdb46 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -349,6 +349,14 @@ int rust_helper_security_binder_transfer_binder(const struct cred *from,
 	return security_binder_transfer_binder(from, to);
 }
 EXPORT_SYMBOL_GPL(rust_helper_security_binder_transfer_binder);
+
+int rust_helper_security_binder_transfer_file(const struct cred *from,
+					      const struct cred *to,
+					      struct file *file)
+{
+	return security_binder_transfer_file(from, to, file);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_binder_transfer_file);
 #endif
 
 /*
diff --git a/rust/kernel/file.rs b/rust/kernel/file.rs
index 2e983285cc16..a0319c93f367 100644
--- a/rust/kernel/file.rs
+++ b/rust/kernel/file.rs
@@ -107,7 +107,7 @@ pub mod flags {
 /// Instances of this type are always ref-counted, that is, a call to `get_file` ensures that the
 /// allocation remains valid at least until the matching call to `fput`.
 #[repr(transparent)]
-pub struct File(Opaque<bindings::file>);
+pub struct File(pub(crate) Opaque<bindings::file>);
 
 // SAFETY: By design, the only way to access a `File` is via an immutable reference or an `ARef`.
 // This means that the only situation in which a `File` can be accessed mutably is when the
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 9179fc225406..d308b8183c59 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -8,6 +8,7 @@
     bindings,
     cred::Credential,
     error::{to_result, Result},
+    file::File,
 };
 
 /// Calls the security modules to determine if the given task can become the manager of a binder
@@ -31,6 +32,16 @@ pub fn binder_transfer_binder(from: &Credential, to: &Credential) -> Result {
     to_result(unsafe { bindings::security_binder_transfer_binder(from.0.get(), to.0.get()) })
 }
 
+/// Calls the security modules to determine if task `from` is allowed to send the given file to
+/// task `to` (which would get its own file descriptor) through a binder transaction.
+pub fn binder_transfer_file(from: &Credential, to: &Credential, file: &File) -> Result {
+    // SAFETY: `from`, `to` and `file` are valid because the shared references guarantee nonzero
+    // refcounts.
+    to_result(unsafe {
+        bindings::security_binder_transfer_file(from.0.get(), to.0.get(), file.0.get())
+    })
+}
+
 /// A security context string.
 ///
 /// The struct has the invariant that it always contains a valid security context.

-- 
2.42.0.820.g83a721a137-goog

