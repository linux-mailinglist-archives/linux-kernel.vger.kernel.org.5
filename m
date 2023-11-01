Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2437DE5C5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344848AbjKASCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344758AbjKASCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:02:37 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D663511B
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:29 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9c7f0a33afbso3999566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861748; x=1699466548; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlkj7rWrD6B3SboM8qOndsSoFecqv93kKlDZWfC7+Co=;
        b=EKATHzTDHijaKPL+lc+y0nsq/Veiv+tpti1DA96nLQd0ot0dXeCiwBXqA/OO/wuvvr
         /vWVXuQYS7t0Wf2evb5+jsRzHtikV+spWQ4tAmvsZpTZfal8N/LzNumXt5WL3EVd436I
         CZJk+ChiPOpLjfC84MmelVtfaGYq3ogSyG3NIzUVU7NvqdfsObcfM6XC46Erurby8hGa
         iIF6PKAsUH1t8P2Jj6qUpja2NZYNhFD7FmSjwjRkh9mqgzKiLvsWiK5Bl5W9huXtRAw/
         xUtGrgJMvF90YY2iKqQlzxg/nLmHHITmS12bnnVGeWgdenCwOLo8wDf9NJ0TWZ6ZPhAm
         JFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861748; x=1699466548;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hlkj7rWrD6B3SboM8qOndsSoFecqv93kKlDZWfC7+Co=;
        b=N8IYOL12E1hf64jlJsQ5GnwpFFnZ5MjIFzDy93B5kkd1wPhQrlMnEQmeswf5gudVsX
         ctz0TsT6JObx0+ulcbxqwdA9ZF4weyAZqrDZAw1dwcOVUEuUeOcCd1vKygmxC8S7l27A
         CxAn2YogCRP0O9+EVr23A58AhmHC7hyLn0mLYeu0ttdgiHxmOr8cNuXhbW3vwyqaXePk
         9suARGc/qUV6RBel70Sjl1zudzdpZvb/JQE8rJRvtvdmf8cQYufNPknzAKw3tfn3OBHj
         T++VJMX51jj33BbD+Be9RTvAuoidAX9cOxu56m6M36yh+T2VK6JhGT/O0+RkD7Ira07a
         t8Xw==
X-Gm-Message-State: AOJu0YwxKM5FV5P868KViXSNsy9ITd7+Zma1NJ0v3wl8yGjAbmCgQ/Pc
        qfDmqcE6IXwgbb/tPBSn0NqRXwBMIbo5ibo=
X-Google-Smtp-Source: AGHT+IE6poj9TJGL38u8xiKe4yivQtylJN2BgIteLV3L37XM5yJqgQp+R0jnBX2pnCR45mYfzFPhiTyId25IACI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:b2cc:b0:9bd:ca2b:40fb with SMTP
 id cf12-20020a170906b2cc00b009bdca2b40fbmr29009ejb.1.1698861748309; Wed, 01
 Nov 2023 11:02:28 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:35 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-5-08ba9197f637@google.com>
Subject: [PATCH RFC 05/20] rust_binder: add nodes and context managers
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

An important concept for the binder driver is a "node", which is a type
of object defined by the binder driver that serves as a "binder server".
Whenever you send a transaction, the recipient will be a node.

Binder nodes can exist in many processes. The driver keeps track of this
using two fields in `Process`.

 * The `nodes` rbtree. This structure stores all nodes that this process
   is the primary owner of. The `process` field of the `Node` struct
   will point at the process that has it in its `nodes` rbtree.
 * The `node_refs` collection. This keeps track of the nodes from other
   processes that this process holds a reference to. A process can only
   send transactions to nodes in this collection.

From userspace, we also make a distinction between local nodes owned by
the process itself, and proxy nodes that are owned by a different
process. Generally, a process will refer to local nodes using the
address of the corresponding userspace object, and it will refer to
proxy nodes using a 32-bit id that the kernel assigns to the node. The
32-bit ids are local to each process and assigned consecutively (the
same node can have a different 32-bit id in each external process that
has a reference to it).

Additionally, a node can also be stored in the context as the "context
manager". There will only be one context manager for each context (that
is, for each file in `/dev/binderfs`). The context manager implicitly
has the id 0 in every other process, which means that all processes are
able to access it by default.

In a later patch, we will add the ability to send nodes from one process
to another as part of a transaction. When this happens, the node is
added to the `node_refs` collection of the target process, and the
process will be able to start using it from then on. Except for the
context manager node, sending nodes in this way is the *only* way for a
process to obtain a reference to a node defined by another process.
Generally, userspace processes are expected to send their nodes to the
context manager process so that the context manager can pass it on to
clients that want to connect to it.

Binder nodes are reference counted through the kernel. This generally
happens in the following manner:

 1. Process A owns a binder node, which it stores in an allocation in
    userspace. This allocation is reference counted.
 2. The kernel owns a `Node` object that holds a reference count to the
    userspace object in process A. Changes to this reference count are
    communicated to process A using the commands BR_ACQUIRE, BR_RELEASE,
    BR_INCREFS, and BR_DECREFS.
 3. Other parts of the kernel own a `NodeRef` object that holds a
    reference count to the `Node` object. Destroying a `NodeRef` will
    decrement the refcount of the associated `Node` in the appropriate
    way.
 4. Process B owns a proxy node, which is a userspace object. Using a
    32-bit id, this proxy node refers to a `NodeRef` object in the
    kernel. When the proxy node is destroyed, userspace will use the
    commands BC_ACQUIRE, BC_RELEASE, BC_INCREFS, and BC_DECREFS to tell
    the kernel to modify the refcount on the `NodeRef` object.

Via the above chain, process B can own a refcount that keeps a node in
process A alive.

There can also be other things than processes than own a `NodeRef`. For
example, the context holds a `NodeRef` to the context manager node. This
keeps the node alive, even if there are no other processes with a
reference to it. In a later patch, we will see other instances of this -
for example, a transaction's allocation will also own a `NodeRef` to any
nodes embedded in it so that they don't go away while the process is
handling the transaction.

There is a potential race condition where the kernel sends BR_ACQUIRE
immediately followed by BR_RELEASE. If these are delivered to two
different userspace threads, then userspace might see them in reverse
order, which could make the refcount drop to zero when it shouldn't. To
prevent this from happening, userspace will respond to BR_ACQUIRE
commands with a BC_ACQUIRE_DONE after incrementing the refcount. The
kernel will postpone BR_RELEASE commands until after userspace has
responded with BC_ACQUIRE_DONE, which ensures that this race cannot
happen.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/context.rs     |  44 ++++-
 drivers/android/defs.rs        |  17 +-
 drivers/android/node.rs        | 377 +++++++++++++++++++++++++++++++++++++++++
 drivers/android/process.rs     | 343 ++++++++++++++++++++++++++++++++++++-
 drivers/android/rust_binder.rs |   2 +-
 drivers/android/thread.rs      |  13 +-
 rust/helpers.c                 |   6 +
 rust/kernel/security.rs        |   8 +
 8 files changed, 799 insertions(+), 11 deletions(-)

diff --git a/drivers/android/context.rs b/drivers/android/context.rs
index 630cb575d3ac..b5de9d98a6b0 100644
--- a/drivers/android/context.rs
+++ b/drivers/android/context.rs
@@ -3,11 +3,13 @@
 use kernel::{
     list::{HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks},
     prelude::*,
+    security,
     str::{CStr, CString},
     sync::{Arc, Mutex},
+    task::Kuid,
 };
 
-use crate::process::Process;
+use crate::{error::BinderError, node::NodeRef, process::Process};
 
 // This module defines the global variable containing the list of contexts. Since the
 // `kernel::sync` bindings currently don't support mutexes in globals, we use a temporary
@@ -70,6 +72,8 @@ pub(crate) struct ContextList {
 /// This struct keeps track of the processes using this context, and which process is the context
 /// manager.
 struct Manager {
+    node: Option<NodeRef>,
+    uid: Option<Kuid>,
     all_procs: List<Process>,
 }
 
@@ -103,6 +107,8 @@ pub(crate) fn new(name: &CStr) -> Result<Arc<Self>> {
             links <- ListLinks::new(),
             manager <- kernel::new_mutex!(Manager {
                 all_procs: List::new(),
+                node: None,
+                uid: None,
             }, "Context::manager"),
         }))?;
 
@@ -141,4 +147,40 @@ pub(crate) fn deregister_process(self: &Arc<Self>, proc: &Process) {
             self.manager.lock().all_procs.remove(proc);
         }
     }
+
+    pub(crate) fn set_manager_node(&self, node_ref: NodeRef) -> Result {
+        let mut manager = self.manager.lock();
+        if manager.node.is_some() {
+            pr_warn!("BINDER_SET_CONTEXT_MGR already set");
+            return Err(EBUSY);
+        }
+        security::binder_set_context_mgr(&node_ref.node.owner.cred)?;
+
+        // If the context manager has been set before, ensure that we use the same euid.
+        let caller_uid = Kuid::current_euid();
+        if let Some(ref uid) = manager.uid {
+            if *uid != caller_uid {
+                return Err(EPERM);
+            }
+        }
+
+        manager.node = Some(node_ref);
+        manager.uid = Some(caller_uid);
+        Ok(())
+    }
+
+    pub(crate) fn unset_manager_node(&self) {
+        let node_ref = self.manager.lock().node.take();
+        drop(node_ref);
+    }
+
+    pub(crate) fn get_manager_node(&self, strong: bool) -> Result<NodeRef, BinderError> {
+        self.manager
+            .lock()
+            .node
+            .as_ref()
+            .ok_or_else(BinderError::new_dead)?
+            .clone(strong)
+            .map_err(BinderError::from)
+    }
 }
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 86173add2616..8a83df975e61 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -19,14 +19,24 @@ macro_rules! pub_no_prefix {
     BR_NOOP,
     BR_SPAWN_LOOPER,
     BR_TRANSACTION_COMPLETE,
-    BR_OK
+    BR_OK,
+    BR_INCREFS,
+    BR_ACQUIRE,
+    BR_RELEASE,
+    BR_DECREFS
 );
 
 pub_no_prefix!(
     binder_driver_command_protocol_,
     BC_ENTER_LOOPER,
     BC_EXIT_LOOPER,
-    BC_REGISTER_LOOPER
+    BC_REGISTER_LOOPER,
+    BC_INCREFS,
+    BC_ACQUIRE,
+    BC_RELEASE,
+    BC_DECREFS,
+    BC_INCREFS_DONE,
+    BC_ACQUIRE_DONE
 );
 
 macro_rules! decl_wrapper {
@@ -54,6 +64,9 @@ fn deref_mut(&mut self) -> &mut Self::Target {
     };
 }
 
+decl_wrapper!(BinderNodeDebugInfo, bindings::binder_node_debug_info);
+decl_wrapper!(BinderNodeInfoForRef, bindings::binder_node_info_for_ref);
+decl_wrapper!(FlatBinderObject, bindings::flat_binder_object);
 decl_wrapper!(BinderWriteRead, bindings::binder_write_read);
 decl_wrapper!(BinderVersion, bindings::binder_version);
 decl_wrapper!(ExtendedError, bindings::binder_extended_error);
diff --git a/drivers/android/node.rs b/drivers/android/node.rs
new file mode 100644
index 000000000000..0ca4b72b8710
--- /dev/null
+++ b/drivers/android/node.rs
@@ -0,0 +1,377 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    io_buffer::IoBufferWriter,
+    list::{AtomicListArcTracker, ListArcSafe, TryNewListArc},
+    prelude::*,
+    sync::lock::{spinlock::SpinLockBackend, Guard},
+    sync::{Arc, LockedBy},
+    user_ptr::UserSlicePtrWriter,
+};
+
+use crate::{
+    defs::*,
+    process::{Process, ProcessInner},
+    thread::Thread,
+    DArc, DeliverToRead,
+};
+
+struct CountState {
+    /// The reference count.
+    count: usize,
+    /// Whether the process that owns this node thinks that we hold a refcount on it. (Note that
+    /// even if count is greater than one, we only increment it once in the owning process.)
+    has_count: bool,
+}
+
+impl CountState {
+    fn new() -> Self {
+        Self {
+            count: 0,
+            has_count: false,
+        }
+    }
+}
+
+struct NodeInner {
+    strong: CountState,
+    weak: CountState,
+    /// The number of active BR_INCREFS or BR_ACQUIRE operations. (should be maximum two)
+    ///
+    /// If this is non-zero, then we postpone any BR_RELEASE or BR_DECREFS notifications until the
+    /// active operations have ended. This avoids the situation an increment and decrement get
+    /// reordered from userspace's perspective.
+    active_inc_refs: u8,
+}
+
+#[pin_data]
+pub(crate) struct Node {
+    pub(crate) global_id: u64,
+    ptr: usize,
+    cookie: usize,
+    #[allow(dead_code)]
+    pub(crate) flags: u32,
+    pub(crate) owner: Arc<Process>,
+    inner: LockedBy<NodeInner, ProcessInner>,
+    #[pin]
+    links_track: AtomicListArcTracker,
+}
+
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for Node {
+        tracked_by links_track: AtomicListArcTracker;
+    }
+}
+
+impl Node {
+    pub(crate) fn new(
+        ptr: usize,
+        cookie: usize,
+        flags: u32,
+        owner: Arc<Process>,
+    ) -> impl PinInit<Self> {
+        use core::sync::atomic::{AtomicU64, Ordering};
+        static NEXT_ID: AtomicU64 = AtomicU64::new(1);
+
+        pin_init!(Self {
+            global_id: NEXT_ID.fetch_add(1, Ordering::Relaxed),
+            inner: LockedBy::new(
+                &owner.inner,
+                NodeInner {
+                    strong: CountState::new(),
+                    weak: CountState::new(),
+                    active_inc_refs: 0,
+                },
+            ),
+            ptr,
+            cookie,
+            flags,
+            owner,
+            links_track <- AtomicListArcTracker::new(),
+        })
+    }
+
+    pub(crate) fn get_id(&self) -> (usize, usize) {
+        (self.ptr, self.cookie)
+    }
+
+    pub(crate) fn inc_ref_done_locked(
+        &self,
+        _strong: bool,
+        owner_inner: &mut ProcessInner,
+    ) -> bool {
+        let inner = self.inner.access_mut(owner_inner);
+        if inner.active_inc_refs == 0 {
+            pr_err!("inc_ref_done called when no active inc_refs");
+            return false;
+        }
+
+        inner.active_inc_refs -= 1;
+        if inner.active_inc_refs == 0 {
+            // Having active inc_refs can inhibit dropping of ref-counts. Calculate whether we
+            // would send a refcount decrement, and if so, tell the caller to schedule us.
+            let strong = inner.strong.count > 0;
+            let has_strong = inner.strong.has_count;
+            let weak = strong || inner.weak.count > 0;
+            let has_weak = inner.weak.has_count;
+
+            let should_drop_weak = !weak && has_weak;
+            let should_drop_strong = !strong && has_strong;
+
+            // If we want to drop the ref-count again, tell the caller to schedule a work node for
+            // that.
+            should_drop_weak || should_drop_strong
+        } else {
+            false
+        }
+    }
+
+    pub(crate) fn update_refcount_locked(
+        &self,
+        inc: bool,
+        strong: bool,
+        count: usize,
+        owner_inner: &mut ProcessInner,
+    ) -> bool {
+        let is_dead = owner_inner.is_dead;
+        let inner = self.inner.access_mut(owner_inner);
+
+        // Get a reference to the state we'll update.
+        let state = if strong {
+            &mut inner.strong
+        } else {
+            &mut inner.weak
+        };
+
+        // Update the count and determine whether we need to push work.
+        if inc {
+            state.count += count;
+            !is_dead && !state.has_count
+        } else {
+            if state.count < count {
+                pr_err!("Failure: refcount underflow!");
+                return false;
+            }
+            state.count -= count;
+            !is_dead && state.count == 0 && state.has_count
+        }
+    }
+
+    pub(crate) fn update_refcount(self: &DArc<Self>, inc: bool, count: usize, strong: bool) {
+        self.owner
+            .inner
+            .lock()
+            .update_node_refcount(self, inc, strong, count, None);
+    }
+
+    pub(crate) fn populate_counts(
+        &self,
+        out: &mut BinderNodeInfoForRef,
+        guard: &Guard<'_, ProcessInner, SpinLockBackend>,
+    ) {
+        let inner = self.inner.access(guard);
+        out.strong_count = inner.strong.count as _;
+        out.weak_count = inner.weak.count as _;
+    }
+
+    pub(crate) fn populate_debug_info(
+        &self,
+        out: &mut BinderNodeDebugInfo,
+        guard: &Guard<'_, ProcessInner, SpinLockBackend>,
+    ) {
+        out.ptr = self.ptr as _;
+        out.cookie = self.cookie as _;
+        let inner = self.inner.access(guard);
+        if inner.strong.has_count {
+            out.has_strong_ref = 1;
+        }
+        if inner.weak.has_count {
+            out.has_weak_ref = 1;
+        }
+    }
+
+    pub(crate) fn force_has_count(&self, guard: &mut Guard<'_, ProcessInner, SpinLockBackend>) {
+        let inner = self.inner.access_mut(guard);
+        inner.strong.has_count = true;
+        inner.weak.has_count = true;
+    }
+
+    fn write(&self, writer: &mut UserSlicePtrWriter, code: u32) -> Result {
+        writer.write(&code)?;
+        writer.write(&self.ptr)?;
+        writer.write(&self.cookie)?;
+        Ok(())
+    }
+}
+
+impl DeliverToRead for Node {
+    fn do_work(
+        self: DArc<Self>,
+        _thread: &Thread,
+        writer: &mut UserSlicePtrWriter,
+    ) -> Result<bool> {
+        let mut owner_inner = self.owner.inner.lock();
+        let inner = self.inner.access_mut(&mut owner_inner);
+        let strong = inner.strong.count > 0;
+        let has_strong = inner.strong.has_count;
+        let weak = strong || inner.weak.count > 0;
+        let has_weak = inner.weak.has_count;
+
+        if weak && !has_weak {
+            inner.weak.has_count = true;
+            inner.active_inc_refs += 1;
+        }
+
+        if strong && !has_strong {
+            inner.strong.has_count = true;
+            inner.active_inc_refs += 1;
+        }
+
+        let no_active_inc_refs = inner.active_inc_refs == 0;
+        let should_drop_weak = no_active_inc_refs && (!weak && has_weak);
+        let should_drop_strong = no_active_inc_refs && (!strong && has_strong);
+        if should_drop_weak {
+            inner.weak.has_count = false;
+        }
+        if should_drop_strong {
+            inner.strong.has_count = false;
+        }
+        if no_active_inc_refs && !weak {
+            // Remove the node if there are no references to it.
+            owner_inner.remove_node(self.ptr);
+        }
+        drop(owner_inner);
+
+        if weak && !has_weak {
+            self.write(writer, BR_INCREFS)?;
+        }
+        if strong && !has_strong {
+            self.write(writer, BR_ACQUIRE)?;
+        }
+        if should_drop_strong {
+            self.write(writer, BR_RELEASE)?;
+        }
+        if should_drop_weak {
+            self.write(writer, BR_DECREFS)?;
+        }
+
+        Ok(true)
+    }
+
+    fn should_sync_wakeup(&self) -> bool {
+        false
+    }
+}
+
+/// Represents something that holds one or more ref-counts to a `Node`.
+///
+/// Whenever process A holds a refcount to a node owned by a different process B, then process A
+/// will store a `NodeRef` that refers to the `Node` in process B. When process A releases the
+/// refcount, we destroy the NodeRef, which decrements the ref-count in process A.
+///
+/// This type is also used for some other cases. For example, a transaction allocation holds a
+/// refcount on the target node, and this is implemented by storing a `NodeRef` in the allocation
+/// so that the destructor of the allocation will drop a refcount of the `Node`.
+pub(crate) struct NodeRef {
+    pub(crate) node: DArc<Node>,
+    /// How many times does this NodeRef hold a refcount on the Node?
+    strong_node_count: usize,
+    weak_node_count: usize,
+    /// How many times does userspace hold a refcount on this NodeRef?
+    strong_count: usize,
+    weak_count: usize,
+}
+
+impl NodeRef {
+    pub(crate) fn new(node: DArc<Node>, strong_count: usize, weak_count: usize) -> Self {
+        Self {
+            node,
+            strong_node_count: strong_count,
+            weak_node_count: weak_count,
+            strong_count,
+            weak_count,
+        }
+    }
+
+    pub(crate) fn absorb(&mut self, mut other: Self) {
+        assert!(
+            Arc::ptr_eq(&self.node, &other.node),
+            "absorb called with differing nodes"
+        );
+        self.strong_node_count += other.strong_node_count;
+        self.weak_node_count += other.weak_node_count;
+        self.strong_count += other.strong_count;
+        self.weak_count += other.weak_count;
+        other.strong_count = 0;
+        other.weak_count = 0;
+        other.strong_node_count = 0;
+        other.weak_node_count = 0;
+    }
+
+    pub(crate) fn clone(&self, strong: bool) -> Result<NodeRef> {
+        if strong && self.strong_count == 0 {
+            return Err(EINVAL);
+        }
+        Ok(self
+            .node
+            .owner
+            .inner
+            .lock()
+            .new_node_ref(self.node.clone(), strong, None))
+    }
+
+    /// Updates (increments or decrements) the number of references held against the node. If the
+    /// count being updated transitions from 0 to 1 or from 1 to 0, the node is notified by having
+    /// its `update_refcount` function called.
+    ///
+    /// Returns whether `self` should be removed (when both counts are zero).
+    pub(crate) fn update(&mut self, inc: bool, strong: bool) -> bool {
+        if strong && self.strong_count == 0 {
+            return false;
+        }
+        let (count, node_count, other_count) = if strong {
+            (
+                &mut self.strong_count,
+                &mut self.strong_node_count,
+                self.weak_count,
+            )
+        } else {
+            (
+                &mut self.weak_count,
+                &mut self.weak_node_count,
+                self.strong_count,
+            )
+        };
+        if inc {
+            if *count == 0 {
+                *node_count = 1;
+                self.node.update_refcount(true, 1, strong);
+            }
+            *count += 1;
+        } else {
+            *count -= 1;
+            if *count == 0 {
+                self.node.update_refcount(false, *node_count, strong);
+                *node_count = 0;
+                return other_count == 0;
+            }
+        }
+        false
+    }
+}
+
+impl Drop for NodeRef {
+    // This destructor is called conditionally from `Allocation::drop`. That branch is often
+    // mispredicted. Inlining this method call reduces the cost of those branch mispredictions.
+    #[inline(always)]
+    fn drop(&mut self) {
+        if self.strong_node_count > 0 {
+            self.node
+                .update_refcount(false, self.strong_node_count, true);
+        }
+        if self.weak_node_count > 0 {
+            self.node
+                .update_refcount(false, self.weak_node_count, false);
+        }
+    }
+}
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 22662c7d388a..2d8aa29776a1 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -19,7 +19,7 @@
     mm,
     prelude::*,
     rbtree::RBTree,
-    sync::{lock::Guard, Arc, ArcBorrow, SpinLock},
+    sync::{lock::Guard, Arc, ArcBorrow, Mutex, SpinLock},
     task::Task,
     types::{ARef, Either},
     user_ptr::{UserSlicePtr, UserSlicePtrReader},
@@ -30,8 +30,9 @@
     context::Context,
     defs::*,
     error::BinderError,
+    node::{Node, NodeRef},
     thread::{PushWorkRes, Thread},
-    DLArc, DTRWrap, DeliverToRead,
+    DArc, DLArc, DTRWrap, DeliverToRead,
 };
 
 use core::mem::take;
@@ -41,9 +42,11 @@
 
 /// The fields of `Process` protected by the spinlock.
 pub(crate) struct ProcessInner {
+    is_manager: bool,
     pub(crate) is_dead: bool,
     threads: RBTree<i32, Arc<Thread>>,
     ready_threads: List<Thread>,
+    nodes: RBTree<usize, DArc<Node>>,
     work: List<DTRWrap<dyn DeliverToRead>>,
 
     /// The number of requested threads that haven't registered yet.
@@ -60,9 +63,11 @@ pub(crate) struct ProcessInner {
 impl ProcessInner {
     fn new() -> Self {
         Self {
+            is_manager: false,
             is_dead: false,
             threads: RBTree::new(),
             ready_threads: List::new(),
+            nodes: RBTree::new(),
             work: List::new(),
             requested_thread_count: 0,
             max_threads: 0,
@@ -80,7 +85,6 @@ fn new() -> Self {
     /// the caller so that the caller can drop it after releasing the inner process lock. This is
     /// necessary since the destructor of `Transaction` will take locks that can't necessarily be
     /// taken while holding the inner process lock.
-    #[allow(dead_code)]
     pub(crate) fn push_work(
         &mut self,
         work: DLArc<dyn DeliverToRead>,
@@ -102,6 +106,81 @@ pub(crate) fn push_work(
         }
     }
 
+    pub(crate) fn remove_node(&mut self, ptr: usize) {
+        self.nodes.remove(&ptr);
+    }
+
+    /// Updates the reference count on the given node.
+    pub(crate) fn update_node_refcount(
+        &mut self,
+        node: &DArc<Node>,
+        inc: bool,
+        strong: bool,
+        count: usize,
+        othread: Option<&Thread>,
+    ) {
+        let push = node.update_refcount_locked(inc, strong, count, self);
+
+        // If we decided that we need to push work, push either to the process or to a thread if
+        // one is specified.
+        if push {
+            // It's not a problem if creating the ListArc fails, because that just means that
+            // it is already queued to a worklist.
+            if let Some(node) = ListArc::try_from_arc_or_drop(node.clone()) {
+                if let Some(thread) = othread {
+                    thread.push_work_deferred(node);
+                } else {
+                    let _ = self.push_work(node);
+                    // Nothing to do: `push_work` may fail if the process is dead, but that's ok as in
+                    // that case, it doesn't care about the notification.
+                }
+            }
+        }
+    }
+
+    pub(crate) fn new_node_ref(
+        &mut self,
+        node: DArc<Node>,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> NodeRef {
+        self.update_node_refcount(&node, true, strong, 1, thread);
+        let strong_count = if strong { 1 } else { 0 };
+        NodeRef::new(node, strong_count, 1 - strong_count)
+    }
+
+    /// Returns an existing node with the given pointer and cookie, if one exists.
+    ///
+    /// Returns an error if a node with the given pointer but a different cookie exists.
+    fn get_existing_node(&self, ptr: usize, cookie: usize) -> Result<Option<DArc<Node>>> {
+        match self.nodes.get(&ptr) {
+            None => Ok(None),
+            Some(node) => {
+                let (_, node_cookie) = node.get_id();
+                if node_cookie == cookie {
+                    Ok(Some(node.clone()))
+                } else {
+                    Err(EINVAL)
+                }
+            }
+        }
+    }
+
+    /// Returns a reference to an existing node with the given pointer and cookie. It requires a
+    /// mutable reference because it needs to increment the ref count on the node, which may
+    /// require pushing work to the work queue (to notify userspace of 0 to 1 transitions).
+    fn get_existing_node_ref(
+        &mut self,
+        ptr: usize,
+        cookie: usize,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> Result<Option<NodeRef>> {
+        Ok(self
+            .get_existing_node(ptr, cookie)?
+            .map(|node| self.new_node_ref(node, strong, thread)))
+    }
+
     fn register_thread(&mut self) -> bool {
         if self.requested_thread_count == 0 {
             return false;
@@ -113,6 +192,30 @@ fn register_thread(&mut self) -> bool {
     }
 }
 
+struct NodeRefInfo {
+    node_ref: NodeRef,
+}
+
+impl NodeRefInfo {
+    fn new(node_ref: NodeRef) -> Self {
+        Self { node_ref }
+    }
+}
+
+struct ProcessNodeRefs {
+    by_handle: RBTree<u32, NodeRefInfo>,
+    by_global_id: RBTree<u64, u32>,
+}
+
+impl ProcessNodeRefs {
+    fn new() -> Self {
+        Self {
+            by_handle: RBTree::new(),
+            by_global_id: RBTree::new(),
+        }
+    }
+}
+
 /// A process using binder.
 ///
 /// Strictly speaking, there can be multiple of these per process. There is one for each binder fd
@@ -131,6 +234,11 @@ pub(crate) struct Process {
     #[pin]
     pub(crate) inner: SpinLock<ProcessInner>,
 
+    // Node references are in a different lock to avoid recursive acquisition when
+    // incrementing/decrementing a node in another process.
+    #[pin]
+    node_refs: Mutex<ProcessNodeRefs>,
+
     // Work node for deferred work item.
     #[pin]
     defer_work: Work<Process>,
@@ -182,6 +290,7 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
             ctx,
             cred,
             inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
+            node_refs <- kernel::new_mutex!(ProcessNodeRefs::new(), "Process::node_refs"),
             task: kernel::current!().group_leader().into(),
             defer_work <- kernel::new_work!("Process::defer_work"),
             links <- ListLinks::new(),
@@ -241,6 +350,167 @@ fn get_thread(self: ArcBorrow<'_, Self>, id: i32) -> Result<Arc<Thread>> {
         Ok(ta)
     }
 
+    fn set_as_manager(
+        self: ArcBorrow<'_, Self>,
+        info: Option<FlatBinderObject>,
+        thread: &Thread,
+    ) -> Result {
+        let (ptr, cookie, flags) = if let Some(obj) = info {
+            (
+                // SAFETY: The object type for this ioctl is implicitly `BINDER_TYPE_BINDER`, so it
+                // is safe to access the `binder` field.
+                unsafe { obj.__bindgen_anon_1.binder },
+                obj.cookie,
+                obj.flags,
+            )
+        } else {
+            (0, 0, 0)
+        };
+        let node_ref = self.get_node(ptr as _, cookie as _, flags as _, true, Some(thread))?;
+        let node = node_ref.node.clone();
+        self.ctx.set_manager_node(node_ref)?;
+        self.inner.lock().is_manager = true;
+
+        // Force the state of the node to prevent the delivery of acquire/increfs.
+        let mut owner_inner = node.owner.inner.lock();
+        node.force_has_count(&mut owner_inner);
+        Ok(())
+    }
+
+    pub(crate) fn get_node(
+        self: ArcBorrow<'_, Self>,
+        ptr: usize,
+        cookie: usize,
+        flags: u32,
+        strong: bool,
+        thread: Option<&Thread>,
+    ) -> Result<NodeRef> {
+        // Try to find an existing node.
+        {
+            let mut inner = self.inner.lock();
+            if let Some(node) = inner.get_existing_node_ref(ptr, cookie, strong, thread)? {
+                return Ok(node);
+            }
+        }
+
+        // Allocate the node before reacquiring the lock.
+        let node = DTRWrap::arc_pin_init(Node::new(ptr, cookie, flags, self.into()))?.into_arc();
+        let rbnode = RBTree::try_allocate_node(ptr, node.clone())?;
+        let mut inner = self.inner.lock();
+        if let Some(node) = inner.get_existing_node_ref(ptr, cookie, strong, thread)? {
+            return Ok(node);
+        }
+
+        inner.nodes.insert(rbnode);
+        Ok(inner.new_node_ref(node, strong, thread))
+    }
+
+    pub(crate) fn insert_or_update_handle(
+        &self,
+        node_ref: NodeRef,
+        is_mananger: bool,
+    ) -> Result<u32> {
+        {
+            let mut refs = self.node_refs.lock();
+
+            // Do a lookup before inserting.
+            if let Some(handle_ref) = refs.by_global_id.get(&node_ref.node.global_id) {
+                let handle = *handle_ref;
+                let info = refs.by_handle.get_mut(&handle).unwrap();
+                info.node_ref.absorb(node_ref);
+                return Ok(handle);
+            }
+        }
+
+        // Reserve memory for tree nodes.
+        let reserve1 = RBTree::try_reserve_node()?;
+        let reserve2 = RBTree::try_reserve_node()?;
+
+        let mut refs = self.node_refs.lock();
+
+        // Do a lookup again as node may have been inserted before the lock was reacquired.
+        if let Some(handle_ref) = refs.by_global_id.get(&node_ref.node.global_id) {
+            let handle = *handle_ref;
+            let info = refs.by_handle.get_mut(&handle).unwrap();
+            info.node_ref.absorb(node_ref);
+            return Ok(handle);
+        }
+
+        // Find id.
+        let mut target: u32 = if is_mananger { 0 } else { 1 };
+        for handle in refs.by_handle.keys() {
+            if *handle > target {
+                break;
+            }
+            if *handle == target {
+                target = target.checked_add(1).ok_or(ENOMEM)?;
+            }
+        }
+
+        // Ensure the process is still alive while we insert a new reference.
+        let inner = self.inner.lock();
+        if inner.is_dead {
+            return Err(ESRCH);
+        }
+        refs.by_global_id
+            .insert(reserve1.into_node(node_ref.node.global_id, target));
+        refs.by_handle
+            .insert(reserve2.into_node(target, NodeRefInfo::new(node_ref)));
+        Ok(target)
+    }
+
+    pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<NodeRef> {
+        self.node_refs
+            .lock()
+            .by_handle
+            .get(&handle)
+            .ok_or(ENOENT)?
+            .node_ref
+            .clone(strong)
+    }
+
+    pub(crate) fn update_ref(&self, handle: u32, inc: bool, strong: bool) -> Result {
+        if inc && handle == 0 {
+            if let Ok(node_ref) = self.ctx.get_manager_node(strong) {
+                if core::ptr::eq(self, &*node_ref.node.owner) {
+                    return Err(EINVAL);
+                }
+                let _ = self.insert_or_update_handle(node_ref, true);
+                return Ok(());
+            }
+        }
+
+        // To preserve original binder behaviour, we only fail requests where the manager tries to
+        // increment references on itself.
+        let mut refs = self.node_refs.lock();
+        if let Some(info) = refs.by_handle.get_mut(&handle) {
+            if info.node_ref.update(inc, strong) {
+                // Remove reference from process tables.
+                let id = info.node_ref.node.global_id;
+                refs.by_handle.remove(&handle);
+                refs.by_global_id.remove(&id);
+            }
+        }
+        Ok(())
+    }
+
+    pub(crate) fn inc_ref_done(&self, reader: &mut UserSlicePtrReader, strong: bool) -> Result {
+        let ptr = reader.read::<usize>()?;
+        let cookie = reader.read::<usize>()?;
+        let mut inner = self.inner.lock();
+        if let Ok(Some(node)) = inner.get_existing_node(ptr, cookie) {
+            if node.inc_ref_done_locked(strong, &mut inner) {
+                // It's not a problem if creating the ListArc fails, because that just means that
+                // it is already queued to a worklist.
+                if let Some(node) = ListArc::try_from_arc_or_drop(node) {
+                    // This only fails if the process is dead.
+                    let _ = inner.push_work(node);
+                }
+            }
+        }
+        Ok(())
+    }
+
     fn version(&self, data: UserSlicePtr) -> Result {
         data.writer().write(&BinderVersion::current())
     }
@@ -258,6 +528,57 @@ fn set_max_threads(&self, max: u32) {
         self.inner.lock().max_threads = max;
     }
 
+    fn get_node_debug_info(&self, data: UserSlicePtr) -> Result {
+        let (mut reader, mut writer) = data.reader_writer();
+
+        // Read the starting point.
+        let ptr = reader.read::<BinderNodeDebugInfo>()?.ptr as usize;
+        let mut out = BinderNodeDebugInfo::default();
+
+        {
+            let inner = self.inner.lock();
+            for (node_ptr, node) in &inner.nodes {
+                if *node_ptr > ptr {
+                    node.populate_debug_info(&mut out, &inner);
+                    break;
+                }
+            }
+        }
+
+        writer.write(&out)
+    }
+
+    fn get_node_info_from_ref(&self, data: UserSlicePtr) -> Result {
+        let (mut reader, mut writer) = data.reader_writer();
+        let mut out = reader.read::<BinderNodeInfoForRef>()?;
+
+        if out.strong_count != 0
+            || out.weak_count != 0
+            || out.reserved1 != 0
+            || out.reserved2 != 0
+            || out.reserved3 != 0
+        {
+            return Err(EINVAL);
+        }
+
+        // Only the context manager is allowed to use this ioctl.
+        if !self.inner.lock().is_manager {
+            return Err(EPERM);
+        }
+
+        let node_ref = self
+            .get_node_from_handle(out.handle, true)
+            .or(Err(EINVAL))?;
+        // Get the counts from the node.
+        {
+            let owner_inner = node_ref.node.owner.inner.lock();
+            node_ref.node.populate_counts(&mut out, &owner_inner);
+        }
+
+        // Write the result back.
+        writer.write(&out)
+    }
+
     pub(crate) fn needs_thread(&self) -> bool {
         let mut inner = self.inner.lock();
         let ret = inner.requested_thread_count == 0
@@ -277,7 +598,15 @@ fn deferred_flush(&self) {
     }
 
     fn deferred_release(self: Arc<Self>) {
-        self.inner.lock().is_dead = true;
+        let is_manager = {
+            let mut inner = self.inner.lock();
+            inner.is_dead = true;
+            inner.is_manager
+        };
+
+        if is_manager {
+            self.ctx.unset_manager_node();
+        }
 
         self.ctx.deregister_process(&self);
 
@@ -327,6 +656,10 @@ fn write(
         match cmd {
             bindings::BINDER_SET_MAX_THREADS => this.set_max_threads(reader.read()?),
             bindings::BINDER_THREAD_EXIT => this.remove_thread(thread),
+            bindings::BINDER_SET_CONTEXT_MGR => this.set_as_manager(None, &thread)?,
+            bindings::BINDER_SET_CONTEXT_MGR_EXT => {
+                this.set_as_manager(Some(reader.read()?), &thread)?
+            }
             _ => return Err(EINVAL),
         }
         Ok(0)
@@ -342,6 +675,8 @@ fn read_write(
         let blocking = (file.flags() & file::flags::O_NONBLOCK) == 0;
         match cmd {
             bindings::BINDER_WRITE_READ => thread.write_read(data, blocking)?,
+            bindings::BINDER_GET_NODE_DEBUG_INFO => this.get_node_debug_info(data)?,
+            bindings::BINDER_GET_NODE_INFO_FOR_REF => this.get_node_info_from_ref(data)?,
             bindings::BINDER_VERSION => this.version(data)?,
             bindings::BINDER_GET_EXTENDED_ERROR => thread.get_extended_error(data)?,
             _ => return Err(EINVAL),
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 55d475737cef..2ef37cc2c556 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -19,6 +19,7 @@
 mod context;
 mod defs;
 mod error;
+mod node;
 mod process;
 mod thread;
 
@@ -102,7 +103,6 @@ fn arc_try_new(val: T) -> Result<DLArc<T>, alloc::alloc::AllocError> {
         .map_err(|_| alloc::alloc::AllocError)
     }
 
-    #[allow(dead_code)]
     fn arc_pin_init(init: impl PinInit<T>) -> Result<DLArc<T>, kernel::error::Error> {
         ListArc::pin_init(pin_init!(Self {
             links <- ListLinksSelfPtr::new(),
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index a12c271a4e8f..f7d62fc380e5 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -93,7 +93,6 @@ fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
         ret
     }
 
-    #[allow(dead_code)]
     fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         if self.is_dead {
             PushWorkRes::FailedDead(work)
@@ -106,7 +105,6 @@ fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
 
     /// Used to push work items that do not need to be processed immediately and can wait until the
     /// thread gets another work item.
-    #[allow(dead_code)]
     fn push_work_deferred(&mut self, work: DLArc<dyn DeliverToRead>) {
         self.work_list.push_back(work);
     }
@@ -294,7 +292,6 @@ fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRe
     ///
     /// Returns whether the item was successfully pushed. This can only fail if the work item is
     /// already in a work list.
-    #[allow(dead_code)]
     pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         let sync = work.should_sync_wakeup();
 
@@ -311,6 +308,10 @@ pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         res
     }
 
+    pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
+        self.inner.lock().push_work_deferred(work);
+    }
+
     fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
         let write_start = req.write_buffer.wrapping_add(req.write_consumed);
         let write_len = req.write_size - req.write_consumed;
@@ -320,6 +321,12 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
             let before = reader.len();
             let cmd = reader.read::<u32>()?;
             match cmd {
+                BC_INCREFS => self.process.update_ref(reader.read()?, true, false)?,
+                BC_ACQUIRE => self.process.update_ref(reader.read()?, true, true)?,
+                BC_RELEASE => self.process.update_ref(reader.read()?, false, true)?,
+                BC_DECREFS => self.process.update_ref(reader.read()?, false, false)?,
+                BC_INCREFS_DONE => self.process.inc_ref_done(&mut reader, false)?,
+                BC_ACQUIRE_DONE => self.process.inc_ref_done(&mut reader, true)?,
                 BC_REGISTER_LOOPER => {
                     let valid = self.process.register_thread();
                     self.inner.lock().looper_register(valid);
diff --git a/rust/helpers.c b/rust/helpers.c
index 2b436a7199e9..adb94ace2334 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -329,6 +329,12 @@ void rust_helper_security_release_secctx(char *secdata, u32 seclen)
 	security_release_secctx(secdata, seclen);
 }
 EXPORT_SYMBOL_GPL(rust_helper_security_release_secctx);
+
+int rust_helper_security_binder_set_context_mgr(const struct cred *mgr)
+{
+	return security_binder_set_context_mgr(mgr);
+}
+EXPORT_SYMBOL_GPL(rust_helper_security_binder_set_context_mgr);
 #endif
 
 /*
diff --git a/rust/kernel/security.rs b/rust/kernel/security.rs
index 69c10ed89a57..f94c3c37560d 100644
--- a/rust/kernel/security.rs
+++ b/rust/kernel/security.rs
@@ -6,9 +6,17 @@
 
 use crate::{
     bindings,
+    cred::Credential,
     error::{to_result, Result},
 };
 
+/// Calls the security modules to determine if the given task can become the manager of a binder
+/// context.
+pub fn binder_set_context_mgr(mgr: &Credential) -> Result {
+    // SAFETY: `mrg.0` is valid because the shared reference guarantees a nonzero refcount.
+    to_result(unsafe { bindings::security_binder_set_context_mgr(mgr.0.get()) })
+}
+
 /// A security context string.
 ///
 /// The struct has the invariant that it always contains a valid security context.

-- 
2.42.0.820.g83a721a137-goog

