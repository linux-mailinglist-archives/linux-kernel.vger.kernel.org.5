Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B47DE5C4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345038AbjKASDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344795AbjKASDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:02 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535411C
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:42 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-543d2bc7d9dso30646a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861761; x=1699466561; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=azhVe2rhV1gDlFmhFwnbqw9ViDwuarkzu6YKI2xsrC4=;
        b=Zk2+K0Z8vnB/TazQEeQH1S6Jtp6THf67hyu4kJmXPCAZIIheuDk0g4GVm/AcGshhir
         Jns270pNIXEnM5eH0ZyKYJYVEHPMfjReVpZFmOcuxB2CnLqH+nsrfUuE/tt/S29LRUhe
         twgfG7fu74Enj8DRplKnoMLbgt6S8j5wAl9pNRl4uRUE836hZwuPNpJWwDewZU+j2MGu
         PIgHnkoMPmk+tyhT8lrqF46T3bJuy5Fe8cOVC3LBvxCqrJiegZN04sDzssfreg0ylLxk
         DgtsJ8w9jkQJBEjDqLiNlTzGujJRH2QdeZlS8vlKFznFFTfZDfhODQP0CTo1DBZPVM14
         vcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861761; x=1699466561;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=azhVe2rhV1gDlFmhFwnbqw9ViDwuarkzu6YKI2xsrC4=;
        b=Coi/KS1mPfUE0ofiFg1mMJ8LrwIIbP2BmN01k8DWWP04I72dMCyfh1j2EQfkOGDwem
         V+OnBhgDIjVQRTvLw0iYWgBKHy8igoPBWxP4FY6m89RHl/WDTJDSru6hoOhEDfkKDp+l
         YKHdmS/C/xi9t16uniTc2YdB/5IAaDS6ezijvTBdCsYodkhenInxbVp8fQ1EFw7FDhuh
         3PfLluJHvZbfOxO/dAioueGVLszAr883koMLRfucYUlKHPJDwv96seyhDEKcilkqQslM
         tvVn/4Mo8eYDEN2lt8tW8BlgZN6yNBbyI+ip/hgWvHdsPlZi6ULLQ6rMZaV41ClyMSH/
         Cffw==
X-Gm-Message-State: AOJu0YxfAca8nrFqzIOVKSSimKDE903tn/yaV7HDMlw6xMPS8Au81675
        ffdHgGCRgm/hO/uDz+5V9pPDY4RMGCuE5xo=
X-Google-Smtp-Source: AGHT+IGIafMa/L8kSErTNfhI7Uu0JoIHIZDKXT9un2aQ391U3nQog6Y6NHnAqAoTL2PWMaxfFHQQ7/C8WFyOVDk=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6402:500d:b0:543:6cf7:87db with SMTP
 id p13-20020a056402500d00b005436cf787dbmr61701eda.5.1698861760736; Wed, 01
 Nov 2023 11:02:40 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:40 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-10-08ba9197f637@google.com>
Subject: [PATCH RFC 10/20] rust_binder: add death notifications
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

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This adds death notifications that let one process be notified when
another process dies.

A process can request to be notified when a process dies using
`BC_REQUEST_DEATH_NOTIFICATION`. This will make the driver send a
`BR_DEAD_BINDER` to userspace when the process dies (or immediately if
it is already dead). Userspace is supposed to respond with
`BC_DEAD_BINDER_DONE` once it has processed the notification.

Userspace can unregister from death notifications using the
`BC_CLEAR_DEATH_NOTIFICATION` command. In this case, the kernel will
respond with `BR_CLEAR_DEATH_NOTIFICATION_DONE` once the notification
has been removed. Note that if the remote process dies before the kernel
has responded with `BR_CLEAR_DEATH_NOTIFICATION_DONE`, then the kernel
will still send a `BR_DEAD_BINDER`, which userspace must be able to
process. In this case, the kernel will wait for the
`BC_DEAD_BINDER_DONE` command before it sends
`BR_CLEAR_DEATH_NOTIFICATION_DONE`.

Note that even if the kernel sends a `BR_DEAD_BINDER`, this does not
remove the death notification. Userspace must still remove it manually
using `BC_CLEAR_DEATH_NOTIFICATION`.

If a process uses `BC_RELEASE` to destroy its last refcount on a node
that has an active death registration, then the death registration is
immediately deleted. However, userspace is not supposed to delete a
node reference without first deregistering death notifications, so this
codepath is not executed under normal circumstances.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/defs.rs        |  10 +-
 drivers/android/node.rs        | 258 ++++++++++++++++++++++++++++++++++++++++-
 drivers/android/process.rs     | 193 +++++++++++++++++++++++++++---
 drivers/android/rust_binder.rs |   7 ++
 drivers/android/thread.rs      |  22 +++-
 5 files changed, 471 insertions(+), 19 deletions(-)

diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index 32178e8c5596..753f7e86c92d 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -23,10 +23,13 @@ macro_rules! pub_no_prefix {
     BR_SPAWN_LOOPER,
     BR_TRANSACTION_COMPLETE,
     BR_OK,
+    BR_ERROR,
     BR_INCREFS,
     BR_ACQUIRE,
     BR_RELEASE,
-    BR_DECREFS
+    BR_DECREFS,
+    BR_DEAD_BINDER,
+    BR_CLEAR_DEATH_NOTIFICATION_DONE
 );
 
 pub_no_prefix!(
@@ -44,7 +47,10 @@ macro_rules! pub_no_prefix {
     BC_RELEASE,
     BC_DECREFS,
     BC_INCREFS_DONE,
-    BC_ACQUIRE_DONE
+    BC_ACQUIRE_DONE,
+    BC_REQUEST_DEATH_NOTIFICATION,
+    BC_CLEAR_DEATH_NOTIFICATION,
+    BC_DEAD_BINDER_DONE
 );
 
 pub(crate) const FLAT_BINDER_FLAG_TXN_SECURITY_CTX: u32 =
diff --git a/drivers/android/node.rs b/drivers/android/node.rs
index b8a08b16c06d..7ed494bf9f7c 100644
--- a/drivers/android/node.rs
+++ b/drivers/android/node.rs
@@ -3,11 +3,12 @@
 use kernel::{
     io_buffer::IoBufferWriter,
     list::{
-        AtomicListArcTracker, HasListLinks, List, ListArcSafe, ListItem, ListLinks, TryNewListArc,
+        AtomicListArcTracker, HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks,
+        TryNewListArc,
     },
     prelude::*,
     sync::lock::{spinlock::SpinLockBackend, Guard},
-    sync::{Arc, LockedBy},
+    sync::{Arc, LockedBy, SpinLock},
     user_ptr::UserSlicePtrWriter,
 };
 
@@ -40,6 +41,7 @@ fn new() -> Self {
 struct NodeInner {
     strong: CountState,
     weak: CountState,
+    death_list: List<DTRWrap<NodeDeath>, 1>,
     oneway_todo: List<DTRWrap<Transaction>>,
     has_pending_oneway_todo: bool,
     /// The number of active BR_INCREFS or BR_ACQUIRE operations. (should be maximum two)
@@ -95,6 +97,7 @@ pub(crate) fn new(
                 NodeInner {
                     strong: CountState::new(),
                     weak: CountState::new(),
+                    death_list: List::new(),
                     oneway_todo: List::new(),
                     has_pending_oneway_todo: false,
                     active_inc_refs: 0,
@@ -112,6 +115,25 @@ pub(crate) fn get_id(&self) -> (usize, usize) {
         (self.ptr, self.cookie)
     }
 
+    pub(crate) fn next_death(
+        &self,
+        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
+    ) -> Option<DArc<NodeDeath>> {
+        self.inner
+            .access_mut(guard)
+            .death_list
+            .pop_front()
+            .map(|larc| larc.into_arc())
+    }
+
+    pub(crate) fn add_death(
+        &self,
+        death: ListArc<DTRWrap<NodeDeath>, 1>,
+        guard: &mut Guard<'_, ProcessInner, SpinLockBackend>,
+    ) {
+        self.inner.access_mut(guard).death_list.push_back(death);
+    }
+
     pub(crate) fn inc_ref_done_locked(
         &self,
         _strong: bool,
@@ -449,3 +471,235 @@ fn drop(&mut self) {
         }
     }
 }
+
+struct NodeDeathInner {
+    dead: bool,
+    cleared: bool,
+    notification_done: bool,
+    /// Indicates whether the normal flow was interrupted by removing the handle. In this case, we
+    /// need behave as if the death notification didn't exist (i.e., we don't deliver anything to
+    /// the user.
+    aborted: bool,
+}
+
+/// Used to deliver notifications when a process dies.
+///
+/// A process can request to be notified when a process dies using `BC_REQUEST_DEATH_NOTIFICATION`.
+/// This will make the driver send a `BR_DEAD_BINDER` to userspace when the process dies (or
+/// immediately if it is already dead). Userspace is supposed to respond with `BC_DEAD_BINDER_DONE`
+/// once it has processed the notification.
+///
+/// Userspace can unregister from death notifications using the `BC_CLEAR_DEATH_NOTIFICATION`
+/// command. In this case, the kernel will respond with `BR_CLEAR_DEATH_NOTIFICATION_DONE` once the
+/// notification has been removed. Note that if the remote process dies before the kernel has
+/// responded with `BR_CLEAR_DEATH_NOTIFICATION_DONE`, then the kernel will still send a
+/// `BR_DEAD_BINDER`, which userspace must be able to process. In this case, the kernel will wait
+/// for the `BC_DEAD_BINDER_DONE` command before it sends `BR_CLEAR_DEATH_NOTIFICATION_DONE`.
+///
+/// Note that even if the kernel sends a `BR_DEAD_BINDER`, this does not remove the death
+/// notification. Userspace must still remove it manually using `BC_CLEAR_DEATH_NOTIFICATION`.
+///
+/// If a process uses `BC_RELEASE` to destroy its last refcount on a node that has an active death
+/// registration, then the death registration is immediately deleted (we implement this using the
+/// `aborted` field). However, userspace is not supposed to delete a `NodeRef` without first
+/// deregistering death notifications, so this codepath is not executed under normal circumstances.
+#[pin_data]
+pub(crate) struct NodeDeath {
+    node: DArc<Node>,
+    process: Arc<Process>,
+    pub(crate) cookie: usize,
+    #[pin]
+    links_track: AtomicListArcTracker<0>,
+    /// Used by the owner `Node` to store a list of registered death notifications.
+    ///
+    /// # Invariants
+    ///
+    /// Only ever used with the `death_list` list of `self.node`.
+    #[pin]
+    death_links: ListLinks<1>,
+    /// Used by the process to keep track of the death notifications for which we have sent a
+    /// `BR_DEAD_BINDER` but not yet received a `BC_DEAD_BINDER_DONE`.
+    ///
+    /// # Invariants
+    ///
+    /// Only ever used with the `delivered_deaths` list of `self.process`.
+    #[pin]
+    delivered_links: ListLinks<2>,
+    #[pin]
+    delivered_links_track: AtomicListArcTracker<2>,
+    #[pin]
+    inner: SpinLock<NodeDeathInner>,
+}
+
+impl NodeDeath {
+    /// Constructs a new node death notification object.
+    pub(crate) fn new(
+        node: DArc<Node>,
+        process: Arc<Process>,
+        cookie: usize,
+    ) -> impl PinInit<DTRWrap<Self>> {
+        DTRWrap::new(pin_init!(
+            Self {
+                node,
+                process,
+                cookie,
+                links_track <- AtomicListArcTracker::new(),
+                death_links <- ListLinks::new(),
+                delivered_links <- ListLinks::new(),
+                delivered_links_track <- AtomicListArcTracker::new(),
+                inner <- kernel::new_spinlock!(NodeDeathInner {
+                    dead: false,
+                    cleared: false,
+                    notification_done: false,
+                    aborted: false,
+                }, "NodeDeath::inner"),
+            }
+        ))
+    }
+
+    /// Sets the cleared flag to `true`.
+    ///
+    /// It removes `self` from the node's death notification list if needed.
+    ///
+    /// Returns whether it needs to be queued.
+    pub(crate) fn set_cleared(self: &DArc<Self>, abort: bool) -> bool {
+        let (needs_removal, needs_queueing) = {
+            // Update state and determine if we need to queue a work item. We only need to do it
+            // when the node is not dead or if the user already completed the death notification.
+            let mut inner = self.inner.lock();
+            if abort {
+                inner.aborted = true;
+            }
+            if inner.cleared {
+                // Already cleared.
+                return false;
+            }
+            inner.cleared = true;
+            (!inner.dead, !inner.dead || inner.notification_done)
+        };
+
+        // Remove death notification from node.
+        if needs_removal {
+            let mut owner_inner = self.node.owner.inner.lock();
+            let node_inner = self.node.inner.access_mut(&mut owner_inner);
+            // SAFETY: A `NodeDeath` is never inserted into the death list of any node other than
+            // its owner, so it is either in this death list or in no death list.
+            unsafe { node_inner.death_list.remove(self) };
+        }
+        needs_queueing
+    }
+
+    /// Sets the 'notification done' flag to `true`.
+    pub(crate) fn set_notification_done(self: DArc<Self>, thread: &Thread) {
+        let needs_queueing = {
+            let mut inner = self.inner.lock();
+            inner.notification_done = true;
+            inner.cleared
+        };
+        if needs_queueing {
+            if let Some(death) = ListArc::try_from_arc_or_drop(self) {
+                let _ = thread.push_work_if_looper(death);
+            }
+        }
+    }
+
+    /// Sets the 'dead' flag to `true` and queues work item if needed.
+    pub(crate) fn set_dead(self: DArc<Self>) {
+        let needs_queueing = {
+            let mut inner = self.inner.lock();
+            if inner.cleared {
+                false
+            } else {
+                inner.dead = true;
+                true
+            }
+        };
+        if needs_queueing {
+            // Push the death notification to the target process. There is nothing else to do if
+            // it's already dead.
+            if let Some(death) = ListArc::try_from_arc_or_drop(self) {
+                let process = death.process.clone();
+                let _ = process.push_work(death);
+            }
+        }
+    }
+}
+
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for NodeDeath {
+        tracked_by links_track: AtomicListArcTracker;
+    }
+}
+
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<1> for DTRWrap<NodeDeath> { self.wrapped.death_links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<1> for DTRWrap<NodeDeath> { untracked; }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<1> for DTRWrap<NodeDeath> {
+        using ListLinks;
+    }
+}
+
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<2> for DTRWrap<NodeDeath> { self.wrapped.delivered_links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<2> for DTRWrap<NodeDeath> {
+        tracked_by wrapped: NodeDeath;
+    }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<2> for NodeDeath {
+        tracked_by delivered_links_track: AtomicListArcTracker<2>;
+    }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<2> for DTRWrap<NodeDeath> {
+        using ListLinks;
+    }
+}
+
+impl DeliverToRead for NodeDeath {
+    fn do_work(
+        self: DArc<Self>,
+        _thread: &Thread,
+        writer: &mut UserSlicePtrWriter,
+    ) -> Result<bool> {
+        let done = {
+            let inner = self.inner.lock();
+            if inner.aborted {
+                return Ok(true);
+            }
+            inner.cleared && (!inner.dead || inner.notification_done)
+        };
+
+        let cookie = self.cookie;
+        let cmd = if done {
+            BR_CLEAR_DEATH_NOTIFICATION_DONE
+        } else {
+            let process = self.process.clone();
+            let mut process_inner = process.inner.lock();
+            let inner = self.inner.lock();
+            if inner.aborted {
+                return Ok(true);
+            }
+            // We're still holding the inner lock, so it cannot be aborted while we insert it into
+            // the delivered list.
+            process_inner.death_delivered(self.clone());
+            BR_DEAD_BINDER
+        };
+
+        writer.write(&cmd)?;
+        writer.write(&cookie)?;
+        // Mimic the original code: we stop processing work items when we get to a death
+        // notification.
+        Ok(cmd != BR_DEAD_BINDER)
+    }
+
+    fn should_sync_wakeup(&self) -> bool {
+        false
+    }
+}
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index d4e50c7f9a88..0b79fa59ffa5 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -20,7 +20,7 @@
     pages::Pages,
     prelude::*,
     rbtree::RBTree,
-    sync::{lock::Guard, Arc, ArcBorrow, Mutex, SpinLock},
+    sync::{lock::Guard, Arc, ArcBorrow, Mutex, SpinLock, UniqueArc},
     task::Task,
     types::{ARef, Either},
     user_ptr::{UserSlicePtr, UserSlicePtrReader},
@@ -32,7 +32,7 @@
     context::Context,
     defs::*,
     error::{BinderError, BinderResult},
-    node::{Node, NodeRef},
+    node::{Node, NodeDeath, NodeRef},
     range_alloc::{self, RangeAllocator},
     thread::{PushWorkRes, Thread},
     DArc, DLArc, DTRWrap, DeliverToRead,
@@ -69,6 +69,7 @@ pub(crate) struct ProcessInner {
     nodes: RBTree<usize, DArc<Node>>,
     mapping: Option<Mapping>,
     work: List<DTRWrap<dyn DeliverToRead>>,
+    delivered_deaths: List<DTRWrap<NodeDeath>, 2>,
 
     /// The number of requested threads that haven't registered yet.
     requested_thread_count: u32,
@@ -91,6 +92,7 @@ fn new() -> Self {
             mapping: None,
             nodes: RBTree::new(),
             work: List::new(),
+            delivered_deaths: List::new(),
             requested_thread_count: 0,
             max_threads: 0,
             started_thread_count: 0,
@@ -225,15 +227,40 @@ fn register_thread(&mut self) -> bool {
         self.started_thread_count += 1;
         true
     }
+
+    /// Finds a delivered death notification with the given cookie, removes it from the thread's
+    /// delivered list, and returns it.
+    fn pull_delivered_death(&mut self, cookie: usize) -> Option<DArc<NodeDeath>> {
+        let mut cursor_opt = self.delivered_deaths.cursor_front();
+        while let Some(cursor) = cursor_opt {
+            if cursor.current().cookie == cookie {
+                return Some(cursor.remove().into_arc());
+            }
+            cursor_opt = cursor.next();
+        }
+        None
+    }
+
+    pub(crate) fn death_delivered(&mut self, death: DArc<NodeDeath>) {
+        if let Some(death) = ListArc::try_from_arc_or_drop(death) {
+            self.delivered_deaths.push_back(death);
+        } else {
+            pr_warn!("Notification added to `delivered_deaths` twice.");
+        }
+    }
 }
 
 struct NodeRefInfo {
     node_ref: NodeRef,
+    death: Option<DArc<NodeDeath>>,
 }
 
 impl NodeRefInfo {
     fn new(node_ref: NodeRef) -> Self {
-        Self { node_ref }
+        Self {
+            node_ref,
+            death: None,
+        }
     }
 }
 
@@ -385,6 +412,18 @@ fn get_thread(self: ArcBorrow<'_, Self>, id: i32) -> Result<Arc<Thread>> {
         Ok(ta)
     }
 
+    pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
+        // If push_work fails, drop the work item outside the lock.
+        let res = self.inner.lock().push_work(work);
+        match res {
+            Ok(()) => Ok(()),
+            Err((err, work)) => {
+                drop(work);
+                Err(err)
+            }
+        }
+    }
+
     fn set_as_manager(
         self: ArcBorrow<'_, Self>,
         info: Option<FlatBinderObject>,
@@ -513,6 +552,14 @@ pub(crate) fn get_node_from_handle(&self, handle: u32, strong: bool) -> Result<N
             .clone(strong)
     }
 
+    pub(crate) fn remove_from_delivered_deaths(&self, death: &DArc<NodeDeath>) {
+        let mut inner = self.inner.lock();
+        // SAFETY: By the invariant on the `delivered_links` field, this is the right linked list.
+        let removed = unsafe { inner.delivered_deaths.remove(death) };
+        drop(inner);
+        drop(removed);
+    }
+
     pub(crate) fn update_ref(&self, handle: u32, inc: bool, strong: bool) -> Result {
         if inc && handle == 0 {
             if let Ok(node_ref) = self.ctx.get_manager_node(strong) {
@@ -529,6 +576,12 @@ pub(crate) fn update_ref(&self, handle: u32, inc: bool, strong: bool) -> Result
         let mut refs = self.node_refs.lock();
         if let Some(info) = refs.by_handle.get_mut(&handle) {
             if info.node_ref.update(inc, strong) {
+                // Clean up death if there is one attached to this node reference.
+                if let Some(death) = info.death.take() {
+                    death.set_cleared(true);
+                    self.remove_from_delivered_deaths(&death);
+                }
+
                 // Remove reference from process tables.
                 let id = info.node_ref.node.global_id;
                 refs.by_handle.remove(&handle);
@@ -725,6 +778,87 @@ pub(crate) fn needs_thread(&self) -> bool {
         ret
     }
 
+    pub(crate) fn request_death(
+        self: &Arc<Self>,
+        reader: &mut UserSlicePtrReader,
+        thread: &Thread,
+    ) -> Result {
+        let handle: u32 = reader.read()?;
+        let cookie: usize = reader.read()?;
+
+        // TODO: First two should result in error, but not the others.
+
+        // TODO: Do we care about the context manager dying?
+
+        // Queue BR_ERROR if we can't allocate memory for the death notification.
+        let death = UniqueArc::try_new_uninit().map_err(|err| {
+            thread.push_return_work(BR_ERROR);
+            err
+        })?;
+        let mut refs = self.node_refs.lock();
+        let info = refs.by_handle.get_mut(&handle).ok_or(EINVAL)?;
+
+        // Nothing to do if there is already a death notification request for this handle.
+        if info.death.is_some() {
+            return Ok(());
+        }
+
+        let death = {
+            let death_init = NodeDeath::new(info.node_ref.node.clone(), self.clone(), cookie);
+            match death.pin_init_with(death_init) {
+                Ok(death) => death,
+                // error is infallible
+                Err(err) => match err {},
+            }
+        };
+
+        // Register the death notification.
+        {
+            let mut owner_inner = info.node_ref.node.owner.inner.lock();
+            if owner_inner.is_dead {
+                let death = ListArc::from_pin_unique(death);
+                info.death = Some(death.clone_arc());
+                drop(owner_inner);
+                let _ = self.push_work(death);
+            } else {
+                let death = ListArc::from_pin_unique(death);
+                info.death = Some(death.clone_arc());
+                info.node_ref.node.add_death(death, &mut owner_inner);
+            }
+        }
+        Ok(())
+    }
+
+    pub(crate) fn clear_death(&self, reader: &mut UserSlicePtrReader, thread: &Thread) -> Result {
+        let handle: u32 = reader.read()?;
+        let cookie: usize = reader.read()?;
+
+        let mut refs = self.node_refs.lock();
+        let info = refs.by_handle.get_mut(&handle).ok_or(EINVAL)?;
+
+        let death = info.death.take().ok_or(EINVAL)?;
+        if death.cookie != cookie {
+            info.death = Some(death);
+            return Err(EINVAL);
+        }
+
+        // Update state and determine if we need to queue a work item. We only need to do it when
+        // the node is not dead or if the user already completed the death notification.
+        if death.set_cleared(false) {
+            if let Some(death) = ListArc::try_from_arc_or_drop(death) {
+                let _ = thread.push_work_if_looper(death);
+            }
+        }
+
+        Ok(())
+    }
+
+    pub(crate) fn dead_binder_done(&self, cookie: usize, thread: &Thread) {
+        if let Some(death) = self.inner.lock().pull_delivered_death(cookie) {
+            death.set_notification_done(thread);
+        }
+    }
+
     fn deferred_flush(&self) {
         let inner = self.inner.lock();
         for thread in inner.threads.values() {
@@ -760,17 +894,6 @@ fn deferred_release(self: Arc<Self>) {
             work.into_arc().cancel();
         }
 
-        // Move the threads out of `inner` so that we can iterate over them without holding the
-        // lock.
-        let mut inner = self.inner.lock();
-        let threads = take(&mut inner.threads);
-        drop(inner);
-
-        // Release all threads.
-        for thread in threads.values() {
-            thread.release();
-        }
-
         // Free any resources kept alive by allocated buffers.
         let omapping = self.inner.lock().mapping.take();
         if let Some(mut mapping) = omapping {
@@ -785,6 +908,48 @@ fn deferred_release(self: Arc<Self>) {
                 drop(alloc)
             });
         }
+
+        // Drop all references. We do this dance with `swap` to avoid destroying the references
+        // while holding the lock.
+        let mut refs = self.node_refs.lock();
+        let mut node_refs = take(&mut refs.by_handle);
+        drop(refs);
+
+        // Remove all death notifications from the nodes (that belong to a different process).
+        for info in node_refs.values_mut() {
+            let death = if let Some(existing) = info.death.take() {
+                existing
+            } else {
+                continue;
+            };
+            death.set_cleared(false);
+        }
+
+        // Do similar dance for the state lock.
+        let mut inner = self.inner.lock();
+        let threads = take(&mut inner.threads);
+        let nodes = take(&mut inner.nodes);
+        drop(inner);
+
+        // Release all threads.
+        for thread in threads.values() {
+            thread.release();
+        }
+
+        // Deliver death notifications.
+        for node in nodes.values() {
+            loop {
+                let death = {
+                    let mut inner = self.inner.lock();
+                    if let Some(death) = node.next_death(&mut inner) {
+                        death
+                    } else {
+                        break;
+                    }
+                };
+                death.set_dead();
+            }
+        }
     }
 
     pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 218c2001e8cb..04477ff7e5a0 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -100,6 +100,13 @@ impl<T: ?Sized> core::ops::Receiver for DTRWrap<T> {}
 type DLArc<T> = kernel::list::ListArc<DTRWrap<T>>;
 
 impl<T: ListArcSafe> DTRWrap<T> {
+    fn new(val: impl PinInit<T>) -> impl PinInit<Self> {
+        pin_init!(Self {
+            links <- ListLinksSelfPtr::new(),
+            wrapped <- val,
+        })
+    }
+
     #[allow(dead_code)]
     fn arc_try_new(val: T) -> Result<DLArc<T>, alloc::alloc::AllocError> {
         ListArc::pin_init(pin_init!(Self {
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index b583297cea91..b70a5e3c064b 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -391,10 +391,27 @@ pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
         res
     }
 
+    /// Attempts to push to given work item to the thread if it's a looper thread (i.e., if it's
+    /// part of a thread pool) and is alive. Otherwise, push the work item to the process instead.
+    pub(crate) fn push_work_if_looper(&self, work: DLArc<dyn DeliverToRead>) -> BinderResult {
+        let mut inner = self.inner.lock();
+        if inner.is_looper() && !inner.is_dead {
+            inner.push_work(work);
+            Ok(())
+        } else {
+            drop(inner);
+            self.process.push_work(work)
+        }
+    }
+
     pub(crate) fn push_work_deferred(&self, work: DLArc<dyn DeliverToRead>) {
         self.inner.lock().push_work_deferred(work);
     }
 
+    pub(crate) fn push_return_work(&self, reply: u32) {
+        self.inner.lock().push_return_work(reply);
+    }
+
     pub(crate) fn copy_transaction_data(
         &self,
         to_process: Arc<Process>,
@@ -556,7 +573,7 @@ fn transaction<T>(self: &Arc<Self>, tr: &BinderTransactionDataSg, inner: T)
                 );
             }
 
-            self.inner.lock().push_return_work(err.reply);
+            self.push_return_work(err.reply);
         }
     }
 
@@ -684,6 +701,9 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
                 BC_DECREFS => self.process.update_ref(reader.read()?, false, false)?,
                 BC_INCREFS_DONE => self.process.inc_ref_done(&mut reader, false)?,
                 BC_ACQUIRE_DONE => self.process.inc_ref_done(&mut reader, true)?,
+                BC_REQUEST_DEATH_NOTIFICATION => self.process.request_death(&mut reader, self)?,
+                BC_CLEAR_DEATH_NOTIFICATION => self.process.clear_death(&mut reader, self)?,
+                BC_DEAD_BINDER_DONE => self.process.dead_binder_done(reader.read()?, self),
                 BC_REGISTER_LOOPER => {
                     let valid = self.process.register_thread();
                     self.inner.lock().looper_register(valid);

-- 
2.42.0.820.g83a721a137-goog

