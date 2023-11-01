Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E16717DE5C6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjKASDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344870AbjKASDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:02 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 009DA111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7bbe0a453so1706227b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861758; x=1699466558; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dDLIbYfXHuasXnwFeCXtVR7UAQw9kXfm6H29EVGLaPI=;
        b=2bAw7LBQR0BmITiaYlDtY8vfbx1z9BWfuy9uJrduek6ePnoIEXkcOCfWgvNYPc7DNH
         9vontYNZG8+No95hSNXxsAk7oq1nGFDWgvhsqybJ+LR2r6HvfJey/kgxH3CTkGtTyUP/
         bBcTzs2HgAFDuCrTvSdX3iSE2hsIAnuKkkmeomvvJfBaqfy6PCyXXMiYsYjIY7k4mRRG
         zAn5eg0hesENM5IBRAVhpzphqk5A9bx8D/aUvdWMQoECjS51/MV9nph/BMZjgsFcrdhu
         05sdllSSRGxcXFNn8PPtDlL5/UTNN3J9ofuTQ4v4LdMjOU2mysxlTwvGtKztG+QaRJBM
         Vm4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861758; x=1699466558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dDLIbYfXHuasXnwFeCXtVR7UAQw9kXfm6H29EVGLaPI=;
        b=Cn5dd+cgD9M1HChHUpzr5XkgxVIcPlNa7CMCmUJuPV1nCmYO19FZ9FNmWdppCnHwPP
         qh8mJGm2b/RmNkq8JMciLmkcwW3Ard6Bot8piO/AS747ROHC777vWQQqS8+npLVqGtyb
         V+lWNTZSu25ofRg7KMfkBthY89dMhGwweYQ2MiSPBlioQKaFQOuSeoCQVMILLslQeGmx
         FSinq8gdJg5z6JlPBQ6Z35QE0DbwUTMW4hXPTK929pPgXkcaanAwlBA9uY2+JMiTJvnT
         P3fgJjvtQVOippKznfTWTqSFbEJSNfovrC3AgvypqFFZzob7y/QA6lplfVmOgiSDbPXG
         34Wg==
X-Gm-Message-State: AOJu0YxWoFSwx2e2ivRn9T5D3P1FZj3mZQKT0kG3cLQqYRVEnPzw0SBB
        TfcRAjfYjLCBH6602+BOvQw0c8CqzvzCT8I=
X-Google-Smtp-Source: AGHT+IHyQRiD/+p/vZEH0TbYPJgPCCJR9dO3Vv3f1NLBzQ/xxyDnZ+MjbpGIOk462kDOf8s4clx+v4rh6ZpIGh0=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a0d:db97:0:b0:5a7:b15a:1a7d with SMTP id
 d145-20020a0ddb97000000b005a7b15a1a7dmr325916ywe.2.1698861758246; Wed, 01 Nov
 2023 11:02:38 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:39 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-9-08ba9197f637@google.com>
Subject: [PATCH RFC 09/20] rust_binder: serialize oneway transactions
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

The binder driver guarantees that oneway transactions sent to the same
node are serialized, that is, userspace will not be given the next one
until it has finished processing the previous oneway transaction. This
is done to avoid the case where two oneway transactions arrive in
opposite order from the order in which they were sent. (E.g., they could
be delivered to two different threads, which could appear as-if they
were sent in opposite order.)

To fix that, we store pending oneway transactions in a separate list in
the node, and don't deliver the next oneway transaction until userspace
signals that it has finished processing the previous oneway transaction
by calling the BC_FREE_BUFFER ioctl.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  | 19 +++++++++-
 drivers/android/node.rs        | 79 ++++++++++++++++++++++++++++++++++++++++--
 drivers/android/process.rs     | 25 ++++++++++---
 drivers/android/transaction.rs | 26 ++++++++++++--
 4 files changed, 138 insertions(+), 11 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index 1ab0f254fded..0fdef5425918 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -3,13 +3,22 @@
 
 use kernel::{bindings, pages::Pages, prelude::*, sync::Arc, user_ptr::UserSlicePtrReader};
 
-use crate::{node::NodeRef, process::Process};
+use crate::{
+    node::{Node, NodeRef},
+    process::Process,
+    DArc,
+};
 
 #[derive(Default)]
 pub(crate) struct AllocationInfo {
     /// The target node of the transaction this allocation is associated to.
     /// Not set for replies.
     pub(crate) target_node: Option<NodeRef>,
+    /// When this allocation is dropped, call `pending_oneway_finished` on the node.
+    ///
+    /// This is used to serialize oneway transaction on the same node. Binder guarantees that
+    /// oneway transactions to the same node are delivered sequentially in the order they are sent.
+    pub(crate) oneway_node: Option<DArc<Node>>,
     /// Zero the data in the buffer on free.
     pub(crate) clear_on_free: bool,
 }
@@ -110,6 +119,10 @@ pub(crate) fn get_or_init_info(&mut self) -> &mut AllocationInfo {
         self.allocation_info.get_or_insert_with(Default::default)
     }
 
+    pub(crate) fn set_info_oneway_node(&mut self, oneway_node: DArc<Node>) {
+        self.get_or_init_info().oneway_node = Some(oneway_node);
+    }
+
     pub(crate) fn set_info_clear_on_drop(&mut self) {
         self.get_or_init_info().clear_on_free = true;
     }
@@ -126,6 +139,10 @@ fn drop(&mut self) {
         }
 
         if let Some(mut info) = self.allocation_info.take() {
+            if let Some(oneway_node) = info.oneway_node.as_ref() {
+                oneway_node.pending_oneway_finished();
+            }
+
             info.target_node = None;
 
             if info.clear_on_free {
diff --git a/drivers/android/node.rs b/drivers/android/node.rs
index c6c3d81e705d..b8a08b16c06d 100644
--- a/drivers/android/node.rs
+++ b/drivers/android/node.rs
@@ -2,7 +2,9 @@
 
 use kernel::{
     io_buffer::IoBufferWriter,
-    list::{AtomicListArcTracker, ListArcSafe, TryNewListArc},
+    list::{
+        AtomicListArcTracker, HasListLinks, List, ListArcSafe, ListItem, ListLinks, TryNewListArc,
+    },
     prelude::*,
     sync::lock::{spinlock::SpinLockBackend, Guard},
     sync::{Arc, LockedBy},
@@ -11,9 +13,11 @@
 
 use crate::{
     defs::*,
+    error::BinderError,
     process::{Process, ProcessInner},
     thread::Thread,
-    DArc, DeliverToRead,
+    transaction::Transaction,
+    DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
 struct CountState {
@@ -36,6 +40,8 @@ fn new() -> Self {
 struct NodeInner {
     strong: CountState,
     weak: CountState,
+    oneway_todo: List<DTRWrap<Transaction>>,
+    has_pending_oneway_todo: bool,
     /// The number of active BR_INCREFS or BR_ACQUIRE operations. (should be maximum two)
     ///
     /// If this is non-zero, then we postpone any BR_RELEASE or BR_DECREFS notifications until the
@@ -62,6 +68,16 @@ impl ListArcSafe<0> for Node {
     }
 }
 
+// These make `oneway_todo` work.
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<0> for DTRWrap<Transaction> { self.links.inner }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<0> for DTRWrap<Transaction> {
+        using ListLinks;
+    }
+}
+
 impl Node {
     pub(crate) fn new(
         ptr: usize,
@@ -79,6 +95,8 @@ pub(crate) fn new(
                 NodeInner {
                     strong: CountState::new(),
                     weak: CountState::new(),
+                    oneway_todo: List::new(),
+                    has_pending_oneway_todo: false,
                     active_inc_refs: 0,
                 },
             ),
@@ -201,6 +219,63 @@ fn write(&self, writer: &mut UserSlicePtrWriter, code: u32) -> Result {
         writer.write(&self.cookie)?;
         Ok(())
     }
+
+    pub(crate) fn submit_oneway(
+        &self,
+        transaction: DLArc<Transaction>,
+        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
+    ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
+        if guard.is_dead {
+            return Err((BinderError::new_dead(), transaction));
+        }
+
+        let inner = self.inner.access_mut(guard);
+        if inner.has_pending_oneway_todo {
+            inner.oneway_todo.push_back(transaction);
+        } else {
+            inner.has_pending_oneway_todo = true;
+            guard.push_work(transaction)?;
+        }
+        Ok(())
+    }
+
+    pub(crate) fn release(&self, guard: &mut Guard<'_, ProcessInner, SpinLockBackend>) {
+        // Move every pending oneshot message to the process todolist. The process
+        // will cancel it later.
+        //
+        // New items can't be pushed after this call, since `submit_oneway` fails when the process
+        // is dead, which is set before `Node::release` is called.
+        //
+        // TODO: Give our linked list implementation the ability to move everything in one go.
+        while let Some(work) = self.inner.access_mut(guard).oneway_todo.pop_front() {
+            guard.push_work_for_release(work);
+        }
+    }
+
+    pub(crate) fn pending_oneway_finished(&self) {
+        let mut guard = self.owner.inner.lock();
+        if guard.is_dead {
+            // Cleanup will happen in `Process::deferred_release`.
+            return;
+        }
+
+        let inner = self.inner.access_mut(&mut guard);
+
+        let transaction = inner.oneway_todo.pop_front();
+        inner.has_pending_oneway_todo = transaction.is_some();
+        if let Some(transaction) = transaction {
+            match guard.push_work(transaction) {
+                Ok(()) => {}
+                Err((_err, work)) => {
+                    // Process is dead.
+                    // This shouldn't happen due to the `is_dead` check, but if it does, just drop
+                    // the transaction and return.
+                    drop(guard);
+                    drop(work);
+                }
+            }
+        }
+    }
 }
 
 impl DeliverToRead for Node {
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 2e8b0fc07756..d4e50c7f9a88 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -136,6 +136,11 @@ pub(crate) fn push_work(
         }
     }
 
+    /// Push work to be cancelled. Only used during process teardown.
+    pub(crate) fn push_work_for_release(&mut self, work: DLArc<dyn DeliverToRead>) {
+        self.work.push_back(work);
+    }
+
     pub(crate) fn remove_node(&mut self, ptr: usize) {
         self.nodes.remove(&ptr);
     }
@@ -740,6 +745,21 @@ fn deferred_release(self: Arc<Self>) {
 
         self.ctx.deregister_process(&self);
 
+        // Move oneway_todo into the process todolist.
+        {
+            let mut inner = self.inner.lock();
+            let nodes = take(&mut inner.nodes);
+            for node in nodes.values() {
+                node.release(&mut inner);
+            }
+            inner.nodes = nodes;
+        }
+
+        // Cancel all pending work items.
+        while let Some(work) = self.get_work() {
+            work.into_arc().cancel();
+        }
+
         // Move the threads out of `inner` so that we can iterate over them without holding the
         // lock.
         let mut inner = self.inner.lock();
@@ -751,11 +771,6 @@ fn deferred_release(self: Arc<Self>) {
             thread.release();
         }
 
-        // Cancel all pending work items.
-        while let Some(work) = self.get_work() {
-            work.into_arc().cancel();
-        }
-
         // Free any resources kept alive by allocated buffers.
         let omapping = self.inner.lock().mapping.take();
         if let Some(mut mapping) = omapping {
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index a6525a4253ea..a4ffe0a3878c 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -62,9 +62,12 @@ pub(crate) fn new(
                     return Err(err);
                 }
             };
-        if trd.flags & TF_ONE_WAY != 0 && stack_next.is_some() {
-            pr_warn!("Oneway transaction should not be in a transaction stack.");
-            return Err(EINVAL.into());
+        if trd.flags & TF_ONE_WAY != 0 {
+            if stack_next.is_some() {
+                pr_warn!("Oneway transaction should not be in a transaction stack.");
+                return Err(EINVAL.into());
+            }
+            alloc.set_info_oneway_node(node_ref.node.clone());
         }
         if trd.flags & TF_CLEAR_BUF != 0 {
             alloc.set_info_clear_on_drop();
@@ -165,9 +168,26 @@ pub(crate) fn find_from(&self, thread: &Thread) -> Option<DArc<Transaction>> {
     ///
     /// Not used for replies.
     pub(crate) fn submit(self: DLArc<Self>) -> BinderResult {
+        let oneway = self.flags & TF_ONE_WAY != 0;
         let process = self.to.clone();
         let mut process_inner = process.inner.lock();
 
+        if oneway {
+            if let Some(target_node) = self.target_node.clone() {
+                match target_node.submit_oneway(self, &mut process_inner) {
+                    Ok(()) => return Ok(()),
+                    Err((err, work)) => {
+                        drop(process_inner);
+                        // Drop work after releasing process lock.
+                        drop(work);
+                        return Err(err);
+                    }
+                }
+            } else {
+                pr_err!("Failed to submit oneway transaction to node.");
+            }
+        }
+
         let res = if let Some(thread) = self.find_target_thread() {
             match thread.push_work(self) {
                 PushWorkRes::Ok => Ok(()),

-- 
2.42.0.820.g83a721a137-goog

