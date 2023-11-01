Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE74C7DE5C2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344958AbjKASDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344866AbjKASDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:01 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D362DB
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:37 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-54356d8ea43so24205a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861756; x=1699466556; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D1N1ayCOZ2IlywhoU6sO7hhv9VakR10Zh4aCkasI2mY=;
        b=mqZaHcKPL6/OxnQt3P5nyYKR3X4HscJs0T0A5x8EcX1LAI8gRT+Bckh3w9cy4JA6G0
         XJIy8EJ7dn7nnxuziZNP3xCGVLxfzE1jfnOdPvVwWw3dEIZgaxUXVCDibx9SchxvwlKe
         pNTiDeamdKrlcU4WKN1yF5UFZdKhhPxm6w60jX0UiOox2IOYdkb8aB6ivD1ClEy4mGKE
         EpNu6rdhagE7GZIHRdPX1RlEfnizwTufajK4jbZD4KARWUiH2jeVRYP43zl7RSGMPWjb
         jyK62CGJmZGjTmmInF6kEumw6CkDyrqXamqYgqV9rhoWH284DvKWYCDY1EGk5GQeHkYD
         w9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861756; x=1699466556;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D1N1ayCOZ2IlywhoU6sO7hhv9VakR10Zh4aCkasI2mY=;
        b=qEsAFG0YHVLBrUeOSTHbXwcil6Y0+J7Z8CrNcWy4PNxVXwMA2nScH/q1Dj66l4RVNQ
         0W+sybZ1fMlDvbFQZwp/l+gqD1Kw2KKd4PrZ4+8khrIs4qECXD73xp2cI3VXGJ9XiUma
         SSBPvg1tpsXpbqY9JJk3LJXTwzrCUoUc0vxhCAzv8o6ObiU1YUthbzaVcdLPfm1l6GV8
         WbyFS/jdmQJEcjbrnj14UKJJMbYUwmxcJc5eMYi1JY9vyc6dYhYjIdKav0kTOFUlLFiY
         YlI0r2RiFvbtpb1YcyuUwwQedOtIGFOfDfbwejOEIiXE96fZOG+6tRXhioo2RQSNZ1sO
         gBug==
X-Gm-Message-State: AOJu0YzVCFzY4hnbka6DvfTSTJpky7IqCPjmkLCUpeptkGXSH/VV2PPv
        7LCZdBRpX+/ixnyo7QjM32aetB+U2oz8M98=
X-Google-Smtp-Source: AGHT+IEcDv165SkPlNs17fVd9dc1leoc4vLe+2I7IXMPXPSRtAe8kNnlBC1OQgGQASDXUCqrc72zDB+irvl4YWg=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:3514:b0:543:92f2:216 with SMTP
 id b20-20020a056402351400b0054392f20216mr38865edd.7.1698861755870; Wed, 01
 Nov 2023 11:02:35 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:38 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-8-08ba9197f637@google.com>
Subject: [PATCH RFC 08/20] rust_binder: add non-oneway transactions
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

Make it possible to send transactions that are not oneway transactions,
that is, transactions that you need to reply to.

Generally, binder will try to look like a normal function call, where
the call blocks until the function returns. This is implemented by
allowing you to reply to incoming transactions, and having the sender
sleep until a reply arrives.

For each thread, binder will keep track of the current transaction.
Furthermore, if you send a transaction from a thread that already has a
current transaction, then binder will make that transaction into a
"sub-transaction". This mimicks a call stack with normal functions. If
you use subtransactions to send calls A->B->A with A and B being two
different processes, then binder will ensure that the incoming
sub-transaction is executed on the thread in A that sent the original
message to B (and that thread in A is not used for any other incoming
transactions). This feature is often referred to as "deadlock avoidance"
because it avoids the case where A's threadpool has run out of threads,
preventing the incoming subtransaction from being processed.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/defs.rs        |   2 +
 drivers/android/thread.rs      | 218 ++++++++++++++++++++++++++++++++++++++++-
 drivers/android/transaction.rs | 132 ++++++++++++++++++++++---
 3 files changed, 336 insertions(+), 16 deletions(-)

diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index d0fc00fa5a57..32178e8c5596 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -33,6 +33,8 @@ macro_rules! pub_no_prefix {
     binder_driver_command_protocol_,
     BC_TRANSACTION,
     BC_TRANSACTION_SG,
+    BC_REPLY,
+    BC_REPLY_SG,
     BC_FREE_BUFFER,
     BC_ENTER_LOOPER,
     BC_EXIT_LOOPER,
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 159beebbd23e..b583297cea91 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -56,6 +56,10 @@ struct InnerThread {
     /// Determines if thread is dead.
     is_dead: bool,
 
+    /// Work item used to deliver error codes to the thread that started a transaction. Stored here
+    /// so that it can be reused.
+    reply_work: DArc<ThreadError>,
+
     /// Work item used to deliver error codes to the current thread. Stored here so that it can be
     /// reused.
     return_work: DArc<ThreadError>,
@@ -65,6 +69,7 @@ struct InnerThread {
     process_work_list: bool,
     /// List of work items to deliver to userspace.
     work_list: List<DTRWrap<dyn DeliverToRead>>,
+    current_transaction: Option<DArc<Transaction>>,
 
     /// Extended error information for this thread.
     extended_error: ExtendedError,
@@ -90,8 +95,10 @@ fn next_err_id() -> u32 {
             looper_need_return: false,
             is_dead: false,
             process_work_list: false,
+            reply_work: ThreadError::try_new()?,
             return_work: ThreadError::try_new()?,
             work_list: List::new(),
+            current_transaction: None,
             extended_error: ExtendedError::new(next_err_id(), BR_OK, 0),
         })
     }
@@ -116,6 +123,15 @@ fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         }
     }
 
+    fn push_reply_work(&mut self, code: u32) {
+        if let Ok(work) = ListArc::try_from_arc(self.reply_work.clone()) {
+            work.set_error_code(code);
+            self.push_work(work);
+        } else {
+            pr_warn!("Thread reply work is already in use.");
+        }
+    }
+
     fn push_return_work(&mut self, reply: u32) {
         if let Ok(work) = ListArc::try_from_arc(self.return_work.clone()) {
             work.set_error_code(reply);
@@ -131,6 +147,36 @@ fn push_work_deferred(&mut self, work: DLArc<dyn DeliverToRead>) {
         self.work_list.push_back(work);
     }
 
+    /// Fetches the transaction this thread can reply to. If the thread has a pending transaction
+    /// (that it could respond to) but it has also issued a transaction, it must first wait for the
+    /// previously-issued transaction to complete.
+    ///
+    /// The `thread` parameter should be the thread containing this `ThreadInner`.
+    fn pop_transaction_to_reply(&mut self, thread: &Thread) -> Result<DArc<Transaction>> {
+        let transaction = self.current_transaction.take().ok_or(EINVAL)?;
+        if core::ptr::eq(thread, transaction.from.as_ref()) {
+            self.current_transaction = Some(transaction);
+            return Err(EINVAL);
+        }
+        // Find a new current transaction for this thread.
+        self.current_transaction = transaction.find_from(thread);
+        Ok(transaction)
+    }
+
+    fn pop_transaction_replied(&mut self, transaction: &DArc<Transaction>) -> bool {
+        match self.current_transaction.take() {
+            None => false,
+            Some(old) => {
+                if !Arc::ptr_eq(transaction, &old) {
+                    self.current_transaction = Some(old);
+                    return false;
+                }
+                self.current_transaction = old.clone_next();
+                true
+            }
+        }
+    }
+
     fn looper_enter(&mut self) {
         self.looper_flags |= LOOPER_ENTERED;
         if self.looper_flags & LOOPER_REGISTERED != 0 {
@@ -159,7 +205,7 @@ fn is_looper(&self) -> bool {
     /// looper. Also, if there is local work, we want to return to userspace before we deliver any
     /// remote work.
     fn should_use_process_work_queue(&self) -> bool {
-        !self.process_work_list && self.is_looper()
+        self.current_transaction.is_none() && !self.process_work_list && self.is_looper()
     }
 
     fn poll(&mut self) -> u32 {
@@ -225,6 +271,10 @@ pub(crate) fn get_extended_error(&self, data: UserSlicePtr) -> Result {
         Ok(())
     }
 
+    pub(crate) fn set_current_transaction(&self, transaction: DArc<Transaction>) {
+        self.inner.lock().current_transaction = Some(transaction);
+    }
+
     /// Attempts to fetch a work item from the thread-local queue. The behaviour if the queue is
     /// empty depends on `wait`: if it is true, the function waits for some work to be queued (or a
     /// signal); otherwise it returns indicating that none is available.
@@ -407,6 +457,89 @@ pub(crate) fn copy_transaction_data(
         Ok(alloc)
     }
 
+    fn unwind_transaction_stack(self: &Arc<Self>) {
+        let mut thread = self.clone();
+        while let Ok(transaction) = {
+            let mut inner = thread.inner.lock();
+            inner.pop_transaction_to_reply(thread.as_ref())
+        } {
+            let reply = Either::Right(BR_DEAD_REPLY);
+            if !transaction.from.deliver_single_reply(reply, &transaction) {
+                break;
+            }
+
+            thread = transaction.from.clone();
+        }
+    }
+
+    pub(crate) fn deliver_reply(
+        &self,
+        reply: Either<DLArc<Transaction>, u32>,
+        transaction: &DArc<Transaction>,
+    ) {
+        if self.deliver_single_reply(reply, transaction) {
+            transaction.from.unwind_transaction_stack();
+        }
+    }
+
+    /// Delivers a reply to the thread that started a transaction. The reply can either be a
+    /// reply-transaction or an error code to be delivered instead.
+    ///
+    /// Returns whether the thread is dead. If it is, the caller is expected to unwind the
+    /// transaction stack by completing transactions for threads that are dead.
+    fn deliver_single_reply(
+        &self,
+        reply: Either<DLArc<Transaction>, u32>,
+        transaction: &DArc<Transaction>,
+    ) -> bool {
+        {
+            let mut inner = self.inner.lock();
+            if !inner.pop_transaction_replied(transaction) {
+                return false;
+            }
+
+            if inner.is_dead {
+                return true;
+            }
+
+            match reply {
+                Either::Left(work) => {
+                    inner.push_work(work);
+                }
+                Either::Right(code) => inner.push_reply_work(code),
+            }
+        }
+
+        // Notify the thread now that we've released the inner lock.
+        self.work_condvar.notify_sync();
+        false
+    }
+
+    /// Determines if the given transaction is the current transaction for this thread.
+    fn is_current_transaction(&self, transaction: &DArc<Transaction>) -> bool {
+        let inner = self.inner.lock();
+        match &inner.current_transaction {
+            None => false,
+            Some(current) => Arc::ptr_eq(current, transaction),
+        }
+    }
+
+    /// Determines the current top of the transaction stack. It fails if the top is in another
+    /// thread (i.e., this thread belongs to a stack but it has called another thread). The top is
+    /// [`None`] if the thread is not currently participating in a transaction stack.
+    fn top_of_transaction_stack(&self) -> Result<Option<DArc<Transaction>>> {
+        let inner = self.inner.lock();
+        if let Some(cur) = &inner.current_transaction {
+            if core::ptr::eq(self, cur.from.as_ref()) {
+                pr_warn!("got new transaction with bad transaction stack");
+                return Err(EINVAL);
+            }
+            Ok(Some(cur.clone()))
+        } else {
+            Ok(None)
+        }
+    }
+
     fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
     where
         T: FnOnce(&Arc<Self>, &BinderTransactionDataSg) -> BinderResult,
@@ -427,12 +560,79 @@ fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
         }
     }
 
+    fn transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
+        let handle = unsafe { tr.transaction_data.target.handle };
+        let node_ref = self.process.get_transaction_node(handle)?;
+        security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
+        // TODO: We need to ensure that there isn't a pending transaction in the work queue. How
+        // could this happen?
+        let top = self.top_of_transaction_stack()?;
+        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+        let completion = list_completion.clone_arc();
+        let transaction = Transaction::new(node_ref, top, self, tr)?;
+
+        // Check that the transaction stack hasn't changed while the lock was released, then update
+        // it with the new transaction.
+        {
+            let mut inner = self.inner.lock();
+            if !transaction.is_stacked_on(&inner.current_transaction) {
+                pr_warn!("Transaction stack changed during transaction!");
+                return Err(EINVAL.into());
+            }
+            inner.current_transaction = Some(transaction.clone_arc());
+            // We push the completion as a deferred work so that we wait for the reply before returning
+            // to userland.
+            inner.push_work_deferred(list_completion);
+        }
+
+        if let Err(e) = transaction.submit() {
+            completion.skip();
+            // Define `transaction` first to drop it after `inner`.
+            let transaction;
+            let mut inner = self.inner.lock();
+            transaction = inner.current_transaction.take().unwrap();
+            inner.current_transaction = transaction.clone_next();
+            Err(e)
+        } else {
+            Ok(())
+        }
+    }
+
+    fn reply_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
+        let orig = self.inner.lock().pop_transaction_to_reply(self)?;
+        if !orig.from.is_current_transaction(&orig) {
+            return Err(EINVAL.into());
+        }
+
+        // We need to complete the transaction even if we cannot complete building the reply.
+        (|| -> BinderResult<_> {
+            let completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
+            let process = orig.from.process.clone();
+            let reply = Transaction::new_reply(self, process, tr)?;
+            self.inner.lock().push_work(completion);
+            orig.from.deliver_reply(Either::Left(reply), &orig);
+            Ok(())
+        })()
+        .map_err(|mut err| {
+            // At this point we only return `BR_TRANSACTION_COMPLETE` to the caller, and we must let
+            // the sender know that the transaction has completed (with an error in this case).
+            pr_warn!(
+                "Failure {:?} during reply - delivering BR_FAILED_REPLY to sender.",
+                err
+            );
+            let reply = Either::Right(BR_FAILED_REPLY);
+            orig.from.deliver_reply(reply, &orig);
+            err.reply = BR_TRANSACTION_COMPLETE;
+            err
+        })
+    }
+
     fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> BinderResult {
         let handle = unsafe { tr.transaction_data.target.handle };
         let node_ref = self.process.get_transaction_node(handle)?;
         security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
         let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
-        let transaction = Transaction::new(node_ref, self, tr)?;
+        let transaction = Transaction::new(node_ref, None, self, tr)?;
         let completion = list_completion.clone_arc();
         self.inner.lock().push_work(list_completion);
         match transaction.submit() {
@@ -458,7 +658,7 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
                     if tr.transaction_data.flags & TF_ONE_WAY != 0 {
                         self.transaction(&tr, Self::oneway_transaction_inner);
                     } else {
-                        return Err(EINVAL);
+                        self.transaction(&tr, Self::transaction_inner);
                     }
                 }
                 BC_TRANSACTION_SG => {
@@ -466,9 +666,17 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
                     if tr.transaction_data.flags & TF_ONE_WAY != 0 {
                         self.transaction(&tr, Self::oneway_transaction_inner);
                     } else {
-                        return Err(EINVAL);
+                        self.transaction(&tr, Self::transaction_inner);
                     }
                 }
+                BC_REPLY => {
+                    let tr = reader.read::<BinderTransactionData>()?.with_buffers_size(0);
+                    self.transaction(&tr, Self::reply_inner)
+                }
+                BC_REPLY_SG => {
+                    let tr = reader.read::<BinderTransactionDataSg>()?;
+                    self.transaction(&tr, Self::reply_inner)
+                }
                 BC_FREE_BUFFER => drop(self.process.buffer_get(reader.read()?)),
                 BC_INCREFS => self.process.update_ref(reader.read()?, true, false)?,
                 BC_ACQUIRE => self.process.update_ref(reader.read()?, true, true)?,
@@ -644,6 +852,8 @@ pub(crate) fn release(self: &Arc<Self>) {
         while let Ok(Some(work)) = self.get_work_local(false) {
             work.into_arc().cancel();
         }
+
+        self.unwind_transaction_stack();
     }
 }
 
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index 8b4274ddc415..a6525a4253ea 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -6,23 +6,25 @@
     prelude::*,
     sync::{Arc, SpinLock},
     task::Kuid,
+    types::{Either, ScopeGuard},
     user_ptr::UserSlicePtrWriter,
 };
 
 use crate::{
     allocation::Allocation,
     defs::*,
-    error::BinderResult,
+    error::{BinderError, BinderResult},
     node::{Node, NodeRef},
     process::Process,
     ptr_align,
-    thread::Thread,
+    thread::{PushWorkRes, Thread},
     DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
 #[pin_data]
 pub(crate) struct Transaction {
     target_node: Option<DArc<Node>>,
+    stack_next: Option<DArc<Transaction>>,
     pub(crate) from: Arc<Thread>,
     to: Arc<Process>,
     #[pin]
@@ -42,6 +44,7 @@ pub(crate) struct Transaction {
 impl Transaction {
     pub(crate) fn new(
         node_ref: NodeRef,
+        stack_next: Option<DArc<Transaction>>,
         from: &Arc<Thread>,
         tr: &BinderTransactionDataSg,
     ) -> BinderResult<DLArc<Self>> {
@@ -59,8 +62,8 @@ pub(crate) fn new(
                     return Err(err);
                 }
             };
-        if trd.flags & TF_ONE_WAY == 0 {
-            pr_warn!("Non-oneway transactions are not yet supported.");
+        if trd.flags & TF_ONE_WAY != 0 && stack_next.is_some() {
+            pr_warn!("Oneway transaction should not be in a transaction stack.");
             return Err(EINVAL.into());
         }
         if trd.flags & TF_CLEAR_BUF != 0 {
@@ -72,6 +75,7 @@ pub(crate) fn new(
 
         Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
             target_node: Some(target_node),
+            stack_next,
             sender_euid: from.process.cred.euid(),
             from: from.clone(),
             to,
@@ -84,15 +88,100 @@ pub(crate) fn new(
         }))?)
     }
 
-    /// Submits the transaction to a work queue.
+    pub(crate) fn new_reply(
+        from: &Arc<Thread>,
+        to: Arc<Process>,
+        tr: &BinderTransactionDataSg,
+    ) -> BinderResult<DLArc<Self>> {
+        let trd = &tr.transaction_data;
+        let mut alloc = match from.copy_transaction_data(to.clone(), tr, None) {
+            Ok(alloc) => alloc,
+            Err(err) => {
+                pr_warn!("Failure in copy_transaction_data: {:?}", err);
+                return Err(err);
+            }
+        };
+        if trd.flags & TF_CLEAR_BUF != 0 {
+            alloc.set_info_clear_on_drop();
+        }
+        Ok(DTRWrap::arc_pin_init(pin_init!(Transaction {
+            target_node: None,
+            stack_next: None,
+            sender_euid: from.process.task.euid(),
+            from: from.clone(),
+            to,
+            code: trd.code,
+            flags: trd.flags,
+            data_size: trd.data_size as _,
+            data_address: alloc.ptr,
+            allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
+            txn_security_ctx_off: None,
+        }))?)
+    }
+
+    /// Determines if the transaction is stacked on top of the given transaction.
+    pub(crate) fn is_stacked_on(&self, onext: &Option<DArc<Self>>) -> bool {
+        match (&self.stack_next, onext) {
+            (None, None) => true,
+            (Some(stack_next), Some(next)) => Arc::ptr_eq(stack_next, next),
+            _ => false,
+        }
+    }
+
+    /// Returns a pointer to the next transaction on the transaction stack, if there is one.
+    pub(crate) fn clone_next(&self) -> Option<DArc<Self>> {
+        Some(self.stack_next.as_ref()?.clone())
+    }
+
+    /// Searches in the transaction stack for a thread that belongs to the target process. This is
+    /// useful when finding a target for a new transaction: if the node belongs to a process that
+    /// is already part of the transaction stack, we reuse the thread.
+    fn find_target_thread(&self) -> Option<Arc<Thread>> {
+        let mut it = &self.stack_next;
+        while let Some(transaction) = it {
+            if Arc::ptr_eq(&transaction.from.process, &self.to) {
+                return Some(transaction.from.clone());
+            }
+            it = &transaction.stack_next;
+        }
+        None
+    }
+
+    /// Searches in the transaction stack for a transaction originating at the given thread.
+    pub(crate) fn find_from(&self, thread: &Thread) -> Option<DArc<Transaction>> {
+        let mut it = &self.stack_next;
+        while let Some(transaction) = it {
+            if core::ptr::eq(thread, transaction.from.as_ref()) {
+                return Some(transaction.clone());
+            }
+
+            it = &transaction.stack_next;
+        }
+        None
+    }
+
+    /// Submits the transaction to a work queue. Uses a thread if there is one in the transaction
+    /// stack, otherwise uses the destination process.
+    ///
+    /// Not used for replies.
     pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
         let process = self.to.clone();
         let mut process_inner = process.inner.lock();
-        match process_inner.push_work(self) {
+
+        let res = if let Some(thread) = self.find_target_thread() {
+            match thread.push_work(self) {
+                PushWorkRes::Ok => Ok(()),
+                PushWorkRes::FailedDead(me) => Err((BinderError::new_dead(), me)),
+            }
+        } else {
+            process_inner.push_work(self)
+        };
+        drop(process_inner);
+
+        match res {
             Ok(()) => Ok(()),
             Err((err, work)) => {
                 // Drop work after releasing process lock.
-                drop(process_inner);
                 drop(work);
                 Err(err)
             }
@@ -101,11 +190,14 @@ pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
 }
 
 impl DeliverToRead for Transaction {
-    fn do_work(
-        self: DArc<Self>,
-        _thread: &Thread,
-        writer: &mut UserSlicePtrWriter,
-    ) -> Result<bool> {
+    fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool> {
+        let send_failed_reply = ScopeGuard::new(|| {
+            if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
+                let reply = Either::Right(BR_FAILED_REPLY);
+                self.from.deliver_reply(reply, &self);
+            }
+        });
+
         let mut tr_sec = BinderTransactionDataSecctx::default();
         let tr = tr_sec.tr_data();
         if let Some(target_node) = &self.target_node {
@@ -144,17 +236,33 @@ fn do_work(
             writer.write(&*tr)?;
         }
 
+        // Dismiss the completion of transaction with a failure. No failure paths are allowed from
+        // here on out.
+        send_failed_reply.dismiss();
+
         // It is now the user's responsibility to clear the allocation.
         let alloc = self.allocation.lock().take();
         if let Some(alloc) = alloc {
             alloc.keep_alive();
         }
 
+        // When this is not a reply and not a oneway transaction, update `current_transaction`. If
+        // it's a reply, `current_transaction` has already been updated appropriately.
+        if self.target_node.is_some() && tr_sec.transaction_data.flags & TF_ONE_WAY == 0 {
+            thread.set_current_transaction(self);
+        }
+
         Ok(false)
     }
 
     fn cancel(self: DArc<Self>) {
         drop(self.allocation.lock().take());
+
+        // If this is not a reply or oneway transaction, then send a dead reply.
+        if self.target_node.is_some() && self.flags & TF_ONE_WAY == 0 {
+            let reply = Either::Right(BR_DEAD_REPLY);
+            self.from.deliver_reply(reply, &self);
+        }
     }
 
     fn should_sync_wakeup(&self) -> bool {

-- 
2.42.0.820.g83a721a137-goog

