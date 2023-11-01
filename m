Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5949C7DE5C1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345105AbjKASDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344924AbjKASDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:03 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708EE13E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:54 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a828bdcfbaso1470947b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861773; x=1699466573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CWakx9lTbzNwRej/JqTJ1fh/9TiorybtUYSDPZLWX0Q=;
        b=TTErfZPu9eWZt2qlwb3oiO/y/yGolOqKb36BDlzLdizonLcAfBst0Mbx4sm08ND4eE
         PegQon3micTEZGvLOg0eNy2S8LG0EBOl4Bzt2nF2KGKjKgV2n5wOSaOyVAtq64XWb/lx
         bLwlBLs0IUdhJ5TZf1aTLwBEneSkc5s2gMjQ+teoQ/KeCIU5H9VZPkTnZ/gAL/p9mUi7
         eWDNWMchg8bDAAY78bpzQgJ8N6RZ7W6U+IOTWSaSGw42oXBCRykthL/WVZ7wx34InSJT
         Rl6awkF0pBDsere4+i7cjafhDQ6QdZT8lYEqc7v5bwHI6krh0IUaeDRNpsQ5yfk4ZFK7
         iGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861773; x=1699466573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CWakx9lTbzNwRej/JqTJ1fh/9TiorybtUYSDPZLWX0Q=;
        b=XwQCaQ/se20YbnMCVW3KxQTnEradvKlCBWa3Mol7gju7OeZ5o2S/sifsNFWRqKPRyH
         XSk0lzcKhkaffaMDhhx+UFxNJi0mqINYUB6Wtn0HyJR45mlfsdwQyusXKHNJBNTm+ISe
         FBHZuNgNg9aDMqMyW0xRzWijkkfqR6wNH3K6kLEnFld/6PE8EcPgG5ZkZ6cPRDKG9G46
         qJCrQv4dnFTpjr3OeFl3x1ELfr+OQRflhhvDQe85olCKk6AhxHua8KBs6FnRHJhq1w5v
         z+Ml7u08yMH7Tk5AbeLEGWHPlGB9Mu4qDBxVcUhKGHCMcnwlYCmH8Wzpox1ynyTkpHgS
         B7JQ==
X-Gm-Message-State: AOJu0YxMG741ryUuyJYpNGz3wSyvm520YOTwP0pNvYQf4QDVqPewL54I
        NYPF6oNVJnrWafsJTQmTSI0Yg60Qe2V5KVA=
X-Google-Smtp-Source: AGHT+IEUjZvX/c9Sg1tm7F6FKGe82mtV5fzLF8Bt7upeEbdLrCwhEZXZMR0Rc5WnqF1LB41jHp0rShrs2f+nDyk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:6cc5:0:b0:5a7:ad67:b4b6 with SMTP id
 h188-20020a816cc5000000b005a7ad67b4b6mr318063ywc.2.1698861773653; Wed, 01 Nov
 2023 11:02:53 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:45 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-15-08ba9197f637@google.com>
Subject: [PATCH RFC 15/20] rust_binder: add process freezing
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

When you want to freeze a process, you should process all incoming
transactions before you freeze it. This patch helps with that. The idea
is that before you freeze the process, you mark it as frozen in the
binder driver. When this happens, all new incoming transactions are
rejected, which lets you empty the queue of incoming transactions that
were sent before you decided to freeze the process. Once you have
processed every transaction in that queue, you can perform the actual
freeze operation.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/context.rs     |  39 +++++++++++
 drivers/android/defs.rs        |   3 +
 drivers/android/error.rs       |   8 +++
 drivers/android/process.rs     | 155 ++++++++++++++++++++++++++++++++++++++++-
 drivers/android/thread.rs      |  12 +++-
 drivers/android/transaction.rs |  50 ++++++++++++-
 rust/kernel/sync/condvar.rs    |  10 +++
 7 files changed, 272 insertions(+), 5 deletions(-)

diff --git a/drivers/android/context.rs b/drivers/android/context.rs
index b5de9d98a6b0..925c368238db 100644
--- a/drivers/android/context.rs
+++ b/drivers/android/context.rs
@@ -69,6 +69,18 @@ pub(crate) struct ContextList {
     list: List<Context>,
 }
 
+pub(crate) fn get_all_contexts() -> Result<Vec<Arc<Context>>> {
+    let lock = CONTEXTS.lock();
+
+    let count = lock.list.iter().count();
+
+    let mut ctxs = Vec::try_with_capacity(count)?;
+    for ctx in &lock.list {
+        ctxs.try_push(Arc::from(ctx))?;
+    }
+    Ok(ctxs)
+}
+
 /// This struct keeps track of the processes using this context, and which process is the context
 /// manager.
 struct Manager {
@@ -183,4 +195,31 @@ pub(crate) fn get_manager_node(&self, strong: bool) -> Result<NodeRef, BinderErr
             .clone(strong)
             .map_err(BinderError::from)
     }
+
+    pub(crate) fn for_each_proc<F>(&self, mut func: F)
+    where
+        F: FnMut(&Process),
+    {
+        let lock = self.manager.lock();
+        for proc in &lock.all_procs {
+            func(&proc);
+        }
+    }
+
+    pub(crate) fn get_all_procs(&self) -> Result<Vec<Arc<Process>>> {
+        let lock = self.manager.lock();
+        let count = lock.all_procs.iter().count();
+
+        let mut procs = Vec::try_with_capacity(count)?;
+        for proc in &lock.all_procs {
+            procs.try_push(Arc::from(proc))?;
+        }
+        Ok(procs)
+    }
+
+    pub(crate) fn get_procs_with_pid(&self, pid: i32) -> Result<Vec<Arc<Process>>> {
+        let mut procs = self.get_all_procs()?;
+        procs.retain(|proc| proc.task.pid() == pid);
+        Ok(procs)
+    }
 }
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 8f9419d474de..30659bd26bff 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -20,6 +20,7 @@ macro_rules! pub_no_prefix {
     BR_REPLY,
     BR_DEAD_REPLY,
     BR_FAILED_REPLY,
+    BR_FROZEN_REPLY,
     BR_NOOP,
     BR_SPAWN_LOOPER,
     BR_TRANSACTION_COMPLETE,
@@ -120,6 +121,8 @@ fn default() -> Self {
 );
 decl_wrapper!(BinderWriteRead, bindings::binder_write_read);
 decl_wrapper!(BinderVersion, bindings::binder_version);
+decl_wrapper!(BinderFrozenStatusInfo, bindings::binder_frozen_status_info);
+decl_wrapper!(BinderFreezeInfo, bindings::binder_freeze_info);
 decl_wrapper!(ExtendedError, bindings::binder_extended_error);
 
 impl BinderVersion {
diff --git a/drivers/android/error.rs b/drivers/android/error.rs
index 6735636d2a1c..5cc724931bd3 100644
--- a/drivers/android/error.rs
+++ b/drivers/android/error.rs
@@ -21,6 +21,13 @@ pub(crate) fn new_dead() -> Self {
         }
     }
 
+    pub(crate) fn new_frozen() -> Self {
+        Self {
+            reply: BR_FROZEN_REPLY,
+            source: None,
+        }
+    }
+
     pub(crate) fn is_dead(&self) -> bool {
         self.reply == BR_DEAD_REPLY
     }
@@ -76,6 +83,7 @@ fn fmt(&self, f: &mut core::fmt::Formatter<'_>) -> core::fmt::Result {
                 None => f.pad("BR_FAILED_REPLY"),
             },
             BR_DEAD_REPLY => f.pad("BR_DEAD_REPLY"),
+            BR_FROZEN_REPLY => f.pad("BR_FROZEN_REPLY"),
             BR_TRANSACTION_COMPLETE => f.pad("BR_TRANSACTION_COMPLETE"),
             _ => f
                 .debug_struct("BinderError")
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 944297b7403c..44baf9e3f998 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -20,7 +20,9 @@
     pages::Pages,
     prelude::*,
     rbtree::RBTree,
-    sync::{lock::Guard, Arc, ArcBorrow, Mutex, SpinLock, UniqueArc},
+    sync::{
+        lock::Guard, Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
+    },
     task::Task,
     types::{ARef, Either},
     user_ptr::{UserSlicePtr, UserSlicePtrReader},
@@ -80,6 +82,16 @@ pub(crate) struct ProcessInner {
 
     /// Bitmap of deferred work to do.
     defer_work: u8,
+
+    /// Number of transactions to be transmitted before processes in freeze_wait
+    /// are woken up.
+    outstanding_txns: u32,
+    /// Process is frozen and unable to service binder transactions.
+    pub(crate) is_frozen: bool,
+    /// Process received sync transactions since last frozen.
+    pub(crate) sync_recv: bool,
+    /// Process received async transactions since last frozen.
+    pub(crate) async_recv: bool,
 }
 
 impl ProcessInner {
@@ -97,6 +109,10 @@ fn new() -> Self {
             max_threads: 0,
             started_thread_count: 0,
             defer_work: 0,
+            outstanding_txns: 0,
+            is_frozen: false,
+            sync_recv: false,
+            async_recv: false,
         }
     }
 
@@ -248,6 +264,22 @@ pub(crate) fn death_delivered(&mut self, death: DArc<NodeDeath>) {
             pr_warn!("Notification added to `delivered_deaths` twice.");
         }
     }
+
+    pub(crate) fn add_outstanding_txn(&mut self) {
+        self.outstanding_txns += 1;
+    }
+
+    fn txns_pending_locked(&self) -> bool {
+        if self.outstanding_txns > 0 {
+            return true;
+        }
+        for thread in self.threads.values() {
+            if thread.has_current_transaction() {
+                return true;
+            }
+        }
+        false
+    }
 }
 
 struct NodeRefInfo {
@@ -296,6 +328,11 @@ pub(crate) struct Process {
     #[pin]
     pub(crate) inner: SpinLock<ProcessInner>,
 
+    // Waitqueue of processes waiting for all outstanding transactions to be
+    // processed.
+    #[pin]
+    freeze_wait: CondVar,
+
     // Node references are in a different lock to avoid recursive acquisition when
     // incrementing/decrementing a node in another process.
     #[pin]
@@ -353,6 +390,7 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
             cred,
             inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
             node_refs <- kernel::new_mutex!(ProcessNodeRefs::new(), "Process::node_refs"),
+            freeze_wait <- kernel::new_condvar!("Process::freeze_wait"),
             task: kernel::current!().group_leader().into(),
             defer_work <- kernel::new_work!("Process::defer_work"),
             links <- ListLinks::new(),
@@ -878,6 +916,9 @@ fn deferred_release(self: Arc<Self>) {
         let is_manager = {
             let mut inner = self.inner.lock();
             inner.is_dead = true;
+            inner.is_frozen = false;
+            inner.sync_recv = false;
+            inner.async_recv = false;
             inner.is_manager
         };
 
@@ -975,6 +1016,116 @@ pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
         }
         Ok(())
     }
+
+    pub(crate) fn drop_outstanding_txn(&self) {
+        let wake = {
+            let mut inner = self.inner.lock();
+            if inner.outstanding_txns == 0 {
+                pr_err!("outstanding_txns underflow");
+                return;
+            }
+            inner.outstanding_txns -= 1;
+            inner.is_frozen && inner.outstanding_txns == 0
+        };
+
+        if wake {
+            self.freeze_wait.notify_all();
+        }
+    }
+
+    pub(crate) fn ioctl_freeze(&self, info: &BinderFreezeInfo) -> Result {
+        if info.enable != 0 {
+            let mut inner = self.inner.lock();
+            inner.sync_recv = false;
+            inner.async_recv = false;
+            inner.is_frozen = false;
+            return Ok(());
+        }
+
+        let mut inner = self.inner.lock();
+        inner.sync_recv = false;
+        inner.async_recv = false;
+        inner.is_frozen = true;
+
+        if info.timeout_ms > 0 {
+            // Safety: Just an FFI call.
+            let mut jiffies = unsafe { bindings::__msecs_to_jiffies(info.timeout_ms) };
+            while jiffies > 0 {
+                if inner.outstanding_txns == 0 {
+                    break;
+                }
+
+                match self.freeze_wait.wait_timeout(&mut inner, jiffies) {
+                    CondVarTimeoutResult::Signal { .. } => {
+                        inner.is_frozen = false;
+                        return Err(ERESTARTSYS);
+                    }
+                    CondVarTimeoutResult::Woken { jiffies: remaining } => {
+                        jiffies = remaining;
+                    }
+                    CondVarTimeoutResult::Timeout => {
+                        jiffies = 0;
+                    }
+                }
+            }
+        }
+
+        if inner.txns_pending_locked() {
+            inner.is_frozen = false;
+            Err(EAGAIN)
+        } else {
+            Ok(())
+        }
+    }
+}
+
+fn get_frozen_status(data: UserSlicePtr) -> Result {
+    let (mut reader, mut writer) = data.reader_writer();
+
+    let mut info = reader.read::<BinderFrozenStatusInfo>()?;
+    info.sync_recv = 0;
+    info.async_recv = 0;
+    let mut found = false;
+
+    for ctx in crate::context::get_all_contexts()? {
+        ctx.for_each_proc(|proc| {
+            if proc.task.pid() == info.pid as _ {
+                found = true;
+                let inner = proc.inner.lock();
+                let txns_pending = inner.txns_pending_locked();
+                info.async_recv |= inner.async_recv as u32;
+                info.sync_recv |= inner.sync_recv as u32;
+                info.sync_recv |= (txns_pending as u32) << 1;
+            }
+        });
+    }
+
+    if found {
+        writer.write(&info)?;
+        Ok(())
+    } else {
+        Err(EINVAL)
+    }
+}
+
+fn ioctl_freeze(reader: &mut UserSlicePtrReader) -> Result {
+    let info = reader.read::<BinderFreezeInfo>()?;
+
+    // Very unlikely for there to be more than 3, since a process normally uses at most binder and
+    // hwbinder.
+    let mut procs = Vec::try_with_capacity(3)?;
+
+    let ctxs = crate::context::get_all_contexts()?;
+    for ctx in ctxs {
+        for proc in ctx.get_procs_with_pid(info.pid as i32)? {
+            procs.try_push(proc)?;
+        }
+    }
+
+    for proc in procs {
+        proc.ioctl_freeze(&info)?;
+    }
+    Ok(())
 }
 
 /// The ioctl handler.
@@ -993,6 +1144,7 @@ fn write(
             bindings::BINDER_SET_CONTEXT_MGR_EXT => {
                 this.set_as_manager(Some(reader.read()?), &thread)?
             }
+            bindings::BINDER_FREEZE => ioctl_freeze(reader)?,
             _ => return Err(EINVAL),
         }
         Ok(0)
@@ -1011,6 +1163,7 @@ fn read_write(
             bindings::BINDER_GET_NODE_DEBUG_INFO => this.get_node_debug_info(data)?,
             bindings::BINDER_GET_NODE_INFO_FOR_REF => this.get_node_info_from_ref(data)?,
             bindings::BINDER_VERSION => this.version(data)?,
+            bindings::BINDER_GET_FROZEN_INFO => get_frozen_status(data)?,
             bindings::BINDER_GET_EXTENDED_ERROR => thread.get_extended_error(data)?,
             _ => return Err(EINVAL),
         }
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 2e86592fb61f..0238c15604f6 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -458,6 +458,10 @@ pub(crate) fn set_current_transaction(&self, transaction: DArc<Transaction>) {
         self.inner.lock().current_transaction = Some(transaction);
     }
 
+    pub(crate) fn has_current_transaction(&self) -> bool {
+        self.inner.lock().current_transaction.is_some()
+    }
+
     /// Attempts to fetch a work item from the thread-local queue. The behaviour if the queue is
     /// empty depends on `wait`: if it is true, the function waits for some work to be queued (or a
     /// signal); otherwise it returns indicating that none is available.
@@ -482,7 +486,7 @@ fn get_work_local(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn Deliv
             }
 
             inner.looper_flags |= LOOPER_WAITING;
-            let signal_pending = self.work_condvar.wait(&mut inner);
+            let signal_pending = self.work_condvar.wait_freezable(&mut inner);
             inner.looper_flags &= !LOOPER_WAITING;
 
             if signal_pending {
@@ -533,7 +537,7 @@ fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRe
             }
 
             inner.looper_flags |= LOOPER_WAITING | LOOPER_WAITING_PROC;
-            let signal_pending = self.work_condvar.wait(&mut inner);
+            let signal_pending = self.work_condvar.wait_freezable(&mut inner);
             inner.looper_flags &= !(LOOPER_WAITING | LOOPER_WAITING_PROC);
 
             if signal_pending || inner.looper_need_return {
@@ -1043,6 +1047,10 @@ fn deliver_single_reply(
         reply: Either<DLArc<Transaction>, u32>,
         transaction: &DArc<Transaction>,
     ) -> bool {
+        if let Either::Left(transaction) = &reply {
+            transaction.set_outstanding(&mut self.process.inner.lock());
+        }
+
         {
             let mut inner = self.inner.lock();
             if !inner.pop_transaction_replied(transaction) {
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index ec32a9fd0ff1..96f63684b1a3 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+use core::sync::atomic::{AtomicBool, Ordering};
 use kernel::{
     io_buffer::IoBufferWriter,
     list::ListArcSafe,
@@ -15,13 +16,13 @@
     defs::*,
     error::{BinderError, BinderResult},
     node::{Node, NodeRef},
-    process::Process,
+    process::{Process, ProcessInner},
     ptr_align,
     thread::{PushWorkRes, Thread},
     DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
-#[pin_data]
+#[pin_data(PinnedDrop)]
 pub(crate) struct Transaction {
     target_node: Option<DArc<Node>>,
     stack_next: Option<DArc<Transaction>>,
@@ -29,6 +30,7 @@ pub(crate) struct Transaction {
     to: Arc<Process>,
     #[pin]
     allocation: SpinLock<Option<Allocation>>,
+    is_outstanding: AtomicBool,
     code: u32,
     pub(crate) flags: u32,
     data_size: usize,
@@ -94,6 +96,7 @@ pub(crate) fn new(
             offsets_size: trd.offsets_size as _,
             data_address,
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
+            is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off,
         }))?)
     }
@@ -127,6 +130,7 @@ pub(crate) fn new_reply(
             offsets_size: trd.offsets_size as _,
             data_address: alloc.ptr,
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
+            is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off: None,
         }))?)
     }
@@ -172,6 +176,26 @@ pub(crate) fn find_from(&self, thread: &Thread) -> Option<DArc<Transaction>> {
         None
     }
 
+    pub(crate) fn set_outstanding(&self, to_process: &mut ProcessInner) {
+        // No race because this method is only called once.
+        if !self.is_outstanding.load(Ordering::Relaxed) {
+            self.is_outstanding.store(true, Ordering::Relaxed);
+            to_process.add_outstanding_txn();
+        }
+    }
+
+    /// Decrement `outstanding_txns` in `to` if it hasn't already been decremented.
+    fn drop_outstanding_txn(&self) {
+        // No race because this is called at most twice, and one of the calls are in the
+        // destructor, which is guaranteed to not race with any other operations on the
+        // transaction. It also cannot race with `set_outstanding`, since submission happens
+        // before delivery.
+        if self.is_outstanding.load(Ordering::Relaxed) {
+            self.is_outstanding.store(false, Ordering::Relaxed);
+            self.to.drop_outstanding_txn();
+        }
+    }
+
     /// Submits the transaction to a work queue. Uses a thread if there is one in the transaction
     /// stack, otherwise uses the destination process.
     ///
@@ -181,8 +205,13 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
         let process = self.to.clone();
         let mut process_inner = process.inner.lock();
 
+        self.set_outstanding(&mut process_inner);
+
         if oneway {
             if let Some(target_node) = self.target_node.clone() {
+                if process_inner.is_frozen {
+                    process_inner.async_recv = true;
+                }
                 match target_node.submit_oneway(self, &mut process_inner) {
                     Ok(()) => return Ok(()),
                     Err((err, work)) => {
@@ -197,6 +226,11 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
             }
         }
 
+        if process_inner.is_frozen {
+            process_inner.sync_recv = true;
+            return Err(BinderError::new_frozen());
+        }
+
         let res = if let Some(thread) = self.find_target_thread() {
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),
@@ -241,6 +275,7 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
                 let reply = Either::Right(BR_FAILED_REPLY);
                 self.from.deliver_reply(reply, &self);
             }
+            self.drop_outstanding_txn();
         });
         let files = if let Ok(list) = self.prepare_file_list() {
             list
@@ -301,6 +336,8 @@ fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -
         // It is now the user's responsibility to clear the allocation.
         alloc.keep_alive();
 
+        self.drop_outstanding_txn();
+
         // When this is not a reply and not a oneway transaction, update `current_transaction`. If
         // it's a reply, `current_transaction` has already been updated appropriately.
         if self.target_node.is_some() && tr_sec.transaction_data.flags & TF_ONE_WAY == 0 {
@@ -318,9 +355,18 @@ fn cancel(self: DArc<Self>) {
             let reply = Either::Right(BR_DEAD_REPLY);
             self.from.deliver_reply(reply, &self);
         }
+
+        self.drop_outstanding_txn();
     }
 
     fn should_sync_wakeup(&self) -> bool {
         self.flags & TF_ONE_WAY == 0
     }
 }
+
+#[pinned_drop]
+impl PinnedDrop for Transaction {
+    fn drop(self: Pin<&mut Self>) {
+        self.drop_outstanding_txn();
+    }
+}
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 07cf6ba2e757..490fdf378e42 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -191,6 +191,16 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
         crate::current!().signal_pending()
     }
 
+    /// Releases the lock and waits for a notification in interruptible and freezable mode.
+    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
+    pub fn wait_freezable<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
+        self.wait_internal(
+            bindings::TASK_INTERRUPTIBLE | bindings::TASK_FREEZABLE,
+            guard,
+        );
+        crate::current!().signal_pending()
+    }
+
     /// Releases the lock and waits for a notification in uninterruptible mode.
     ///
     /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the

-- 
2.42.0.820.g83a721a137-goog

