Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F447DE5C0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344831AbjKASCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344760AbjKASCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:02:32 -0400
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BFC109
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:27 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9ae0601d689so5311166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861746; x=1699466546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jcR4e9c2oSdeBUrhisVRNJ8oBwDdg+8SErGLxmSxrCU=;
        b=A5HgAVwolWkxDzqUBXti0Oql3sQEwyRgWjdhuCEzpT7tCW/NiikLFj6xtQF0F8Wgn1
         qGr1w4ciVZnVpEzgz9L8p7s1Fzj8R1NgRQcmw6GBC9MgyLIaTeFPG8tTVer6SkGWuNbE
         fNo3ANpSF263PIMBqdZlF9PBsWRAAhFxpkzLARfKpaq+SSYPBwvAEzBCzcwgJFA/mcIj
         7nenqWTpZ1wwQ//iIvDwQUhbVffJ7RJpTKFXXvGCKv/H6s9eaw9PfKL7px2wCnehIy4H
         45b9j0d9bUinr628zG6OML6YnvTGHJJZD4C0ajN+Xhe3vWYr7kRaWOUCU2rQXzrRB5eY
         +Omw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861746; x=1699466546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jcR4e9c2oSdeBUrhisVRNJ8oBwDdg+8SErGLxmSxrCU=;
        b=K9ThkUSpIE4Cs+3hoNynUZTtq6EKpCzjBSeQZK2VS9GKWQH508EaBtXxOOJiHOva0O
         +64jcMtDilYDiJTRYgPyrCUlkEEXUxMGtwRXTMw7m5l28SuErgX/Cla+Dj9Pq/xUkG/5
         WxxjE1/M7KkbeQdiXWgCbPX2BD4Gv8FK5N8sMDvLrpy4BzmcwwyBz+NPwjw6mP4mZ4zM
         3UfXxMRe2uetHVcDm6QAS25qyNOGaTS9mOGtXiI6ST9xe8vP9ET360MrCKH0j7ovxVJu
         i8/9W18nSu++j83Gs2oDX1oU8ycRoIlQejuUmkovJnQEvIly4WlS2gvDhl/SKILQ+IbX
         ctSw==
X-Gm-Message-State: AOJu0Yyek2aSltlOgRKYQKpwJpU/0+w2eKhI1VZ3dvLOe67quq8o5pxz
        L+EHoB5bICUdTRRqeCzPnwo94ew10nhyTOI=
X-Google-Smtp-Source: AGHT+IH7LEMOeO50NlAnRB5mcQmyX2EaY/SAdwrmMYp6miXQPKUVwtTEQLRT2gpiOCiI5OmvkriWjIQZqlR+8is=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:d93:b0:9be:46f7:7e28 with SMTP
 id m19-20020a1709060d9300b009be46f77e28mr25262eji.13.1698861745966; Wed, 01
 Nov 2023 11:02:25 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:34 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-4-08ba9197f637@google.com>
Subject: [PATCH RFC 04/20] rust_binder: add work lists
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

The binder driver uses linked lists of work items to store events that
need to be delivered to userspace. There are work lists on both the
process and threads.

Work items are expected to implement the `DeliverToRead` trait, whose
name signifies that this type is something that can be delivered to
userspace via the read part of the `BINDER_WRITE_READ` ioctl. The trait
defines what happens when a work item is executed, when it is cancelled,
how the thread should be notified (`wake_up_interruptible_sync` or
`wake_up_interruptible`?), and how it can be enqueued to a linked list.
For each type that implements the trait, Rust will generate a vtable
for the type. Pointers to the `dyn DeliverToRead` type will be fat
pointers where the metadata of the pointer is a pointer to the vtable.

We introduce the concept of a "ready thread". This is a thread that is
currently waiting for work items inside the `get_work` method. The
process will keep track of them and deliver new work items to one of the
ready threads directly. When there are no ready threads, work items are
stored in the process work list.

The work lists added in this patch are not used yet, so the `push_work`
methods are marked with `#[allow(dead_code)]` to silence the warnings
about unused methods. A user is added in the next patch of this patch
set.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/error.rs       |   9 ++
 drivers/android/process.rs     | 126 ++++++++++++++++--
 drivers/android/rust_binder.rs |  87 ++++++++++++-
 drivers/android/thread.rs      | 284 +++++++++++++++++++++++++++++++++++++++--
 scripts/Makefile.build         |   2 +-
 5 files changed, 488 insertions(+), 20 deletions(-)

diff --git a/drivers/android/error.rs b/drivers/android/error.rs
index 41fc4347ab55..a31b696efafc 100644
--- a/drivers/android/error.rs
+++ b/drivers/android/error.rs
@@ -11,6 +11,15 @@ pub(crate) struct BinderError {
     source: Option<Error>,
 }
 
+impl BinderError {
+    pub(crate) fn new_dead() -> Self {
+        Self {
+            reply: BR_DEAD_REPLY,
+            source: None,
+        }
+    }
+}
+
 /// Convert an errno into a `BinderError` and store the errno used to construct it. The errno
 /// should be stored as the thread's extended error when given to userspace.
 impl From<Error> for BinderError {
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 47d074dd8465..22662c7d388a 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -15,18 +15,24 @@
     cred::Credential,
     file::{self, File, PollTable},
     io_buffer::{IoBufferReader, IoBufferWriter},
-    list::{HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks},
+    list::{HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks},
     mm,
     prelude::*,
     rbtree::RBTree,
-    sync::{Arc, ArcBorrow, SpinLock},
+    sync::{lock::Guard, Arc, ArcBorrow, SpinLock},
     task::Task,
-    types::ARef,
+    types::{ARef, Either},
     user_ptr::{UserSlicePtr, UserSlicePtrReader},
     workqueue::{self, Work},
 };
 
-use crate::{context::Context, defs::*, thread::Thread};
+use crate::{
+    context::Context,
+    defs::*,
+    error::BinderError,
+    thread::{PushWorkRes, Thread},
+    DLArc, DTRWrap, DeliverToRead,
+};
 
 use core::mem::take;
 
@@ -35,8 +41,10 @@
 
 /// The fields of `Process` protected by the spinlock.
 pub(crate) struct ProcessInner {
-    is_dead: bool,
+    pub(crate) is_dead: bool,
     threads: RBTree<i32, Arc<Thread>>,
+    ready_threads: List<Thread>,
+    work: List<DTRWrap<dyn DeliverToRead>>,
 
     /// The number of requested threads that haven't registered yet.
     requested_thread_count: u32,
@@ -54,6 +62,8 @@ fn new() -> Self {
         Self {
             is_dead: false,
             threads: RBTree::new(),
+            ready_threads: List::new(),
+            work: List::new(),
             requested_thread_count: 0,
             max_threads: 0,
             started_thread_count: 0,
@@ -61,6 +71,37 @@ fn new() -> Self {
         }
     }
 
+    /// Schedule the work item for execution on this process.
+    ///
+    /// If any threads are ready for work, then the work item is given directly to that thread and
+    /// it is woken up. Otherwise, it is pushed to the process work list.
+    ///
+    /// This call can fail only if the process is dead. In this case, the work item is returned to
+    /// the caller so that the caller can drop it after releasing the inner process lock. This is
+    /// necessary since the destructor of `Transaction` will take locks that can't necessarily be
+    /// taken while holding the inner process lock.
+    #[allow(dead_code)]
+    pub(crate) fn push_work(
+        &mut self,
+        work: DLArc<dyn DeliverToRead>,
+    ) -> Result<(), (BinderError, DLArc<dyn DeliverToRead>)> {
+        // Try to find a ready thread to which to push the work.
+        if let Some(thread) = self.ready_threads.pop_front() {
+            // Push to thread while holding state lock. This prevents the thread from giving up
+            // (for example, because of a signal) when we're about to deliver work.
+            match thread.push_work(work) {
+                PushWorkRes::Ok => Ok(()),
+                PushWorkRes::FailedDead(work) => Err((BinderError::new_dead(), work)),
+            }
+        } else if self.is_dead {
+            Err((BinderError::new_dead(), work))
+        } else {
+            // There are no ready threads. Push work to process queue.
+            self.work.push_back(work);
+            Ok(())
+        }
+    }
+
     fn register_thread(&mut self) -> bool {
         if self.requested_thread_count == 0 {
             return false;
@@ -152,6 +193,31 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
         Ok(process)
     }
 
+    /// Attempts to fetch a work item from the process queue.
+    pub(crate) fn get_work(&self) -> Option<DLArc<dyn DeliverToRead>> {
+        self.inner.lock().work.pop_front()
+    }
+
+    /// Attempts to fetch a work item from the process queue. If none is available, it registers the
+    /// given thread as ready to receive work directly.
+    ///
+    /// This must only be called when the thread is not participating in a transaction chain; when
+    /// it is, work will always be delivered directly to the thread (and not through the process
+    /// queue).
+    pub(crate) fn get_work_or_register<'a>(
+        &'a self,
+        thread: &'a Arc<Thread>,
+    ) -> Either<DLArc<dyn DeliverToRead>, Registration<'a>> {
+        let mut inner = self.inner.lock();
+        // Try to get work from the process queue.
+        if let Some(work) = inner.work.pop_front() {
+            return Either::Left(work);
+        }
+
+        // Register the thread as ready.
+        Either::Right(Registration::new(self, thread, &mut inner))
+    }
+
     fn get_thread(self: ArcBorrow<'_, Self>, id: i32) -> Result<Arc<Thread>> {
         {
             let inner = self.inner.lock();
@@ -194,8 +260,9 @@ fn set_max_threads(&self, max: u32) {
 
     pub(crate) fn needs_thread(&self) -> bool {
         let mut inner = self.inner.lock();
-        let ret =
-            inner.requested_thread_count == 0 && inner.started_thread_count < inner.max_threads;
+        let ret = inner.requested_thread_count == 0
+            && inner.ready_threads.is_empty()
+            && inner.started_thread_count < inner.max_threads;
         if ret {
             inner.requested_thread_count += 1
         }
@@ -203,7 +270,10 @@ pub(crate) fn needs_thread(&self) -> bool {
     }
 
     fn deferred_flush(&self) {
-        // NOOP for now.
+        let inner = self.inner.lock();
+        for thread in inner.threads.values() {
+            thread.exit_looper();
+        }
     }
 
     fn deferred_release(self: Arc<Self>) {
@@ -211,6 +281,11 @@ fn deferred_release(self: Arc<Self>) {
 
         self.ctx.deregister_process(&self);
 
+        // Cancel all pending work items.
+        while let Some(work) = self.get_work() {
+            work.into_arc().cancel();
+        }
+
         // Move the threads out of `inner` so that we can iterate over them without holding the
         // lock.
         let mut inner = self.inner.lock();
@@ -341,3 +416,38 @@ pub(crate) fn poll(
         Err(EINVAL)
     }
 }
+
+/// Represents that a thread has registered with the `ready_threads` list of its process.
+///
+/// The destructor of this type will unregister the thread from the list of ready threads.
+pub(crate) struct Registration<'a> {
+    process: &'a Process,
+    thread: &'a Arc<Thread>,
+}
+
+impl<'a> Registration<'a> {
+    fn new(
+        process: &'a Process,
+        thread: &'a Arc<Thread>,
+        guard: &mut Guard<'_, ProcessInner, kernel::sync::lock::spinlock::SpinLockBackend>,
+    ) -> Self {
+        assert!(core::ptr::eq(process, &*thread.process));
+        // INVARIANT: We are pushing this thread to the right `ready_threads` list.
+        if let Ok(list_arc) = ListArc::try_from_arc(thread.clone()) {
+            guard.ready_threads.push_front(list_arc);
+        } else {
+            pr_warn!("Same thread registered with `ready_threads` twice.");
+        }
+        Self { process, thread }
+    }
+}
+
+impl Drop for Registration<'_> {
+    fn drop(&mut self) {
+        let mut inner = self.process.inner.lock();
+        // SAFETY: The thread has the invariant that we never push it to any other linked list than
+        // the `ready_threads` list of its parent process. Therefore, the thread is either in that
+        // list, or in no list.
+        unsafe { inner.ready_threads.remove(self.thread) };
+    }
+}
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 64fd24ea8be1..55d475737cef 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -5,12 +5,16 @@
 use kernel::{
     bindings::{self, seq_file},
     file::{File, PollTable},
+    list::{
+        HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks, ListLinksSelfPtr, TryNewListArc,
+    },
     prelude::*,
     sync::Arc,
     types::ForeignOwnable,
+    user_ptr::UserSlicePtrWriter,
 };
 
-use crate::{context::Context, process::Process};
+use crate::{context::Context, process::Process, thread::Thread};
 
 mod context;
 mod defs;
@@ -26,6 +30,87 @@
     license: "GPL",
 }
 
+/// Specifies how a type should be delivered to the read part of a BINDER_WRITE_READ ioctl.
+///
+/// When a value is pushed to the todo list for a process or thread, it is stored as a trait object
+/// with the type `Arc<dyn DeliverToRead>`. Trait objects are a Rust feature that lets you
+/// implement dynamic dispatch over many different types. This lets us store many different types
+/// in the todo list.
+trait DeliverToRead: ListArcSafe + Send + Sync {
+    /// Performs work. Returns true if remaining work items in the queue should be processed
+    /// immediately, or false if it should return to caller before processing additional work
+    /// items.
+    fn do_work(self: DArc<Self>, thread: &Thread, writer: &mut UserSlicePtrWriter) -> Result<bool>;
+
+    /// Cancels the given work item. This is called instead of [`DeliverToRead::do_work`] when work
+    /// won't be delivered.
+    fn cancel(self: DArc<Self>) {}
+
+    /// Should we use `wake_up_interruptible_sync` or `wake_up_interruptible` when scheduling this
+    /// work item?
+    ///
+    /// Generally only set to true for non-oneway transactions.
+    fn should_sync_wakeup(&self) -> bool;
+
+    /// Get the debug name of this type.
+    fn debug_name(&self) -> &'static str {
+        core::any::type_name::<Self>()
+    }
+}
+
+// Wrapper around a `DeliverToRead` with linked list links.
+#[pin_data]
+struct DTRWrap<T: ?Sized> {
+    #[pin]
+    links: ListLinksSelfPtr<DTRWrap<dyn DeliverToRead>>,
+    #[pin]
+    wrapped: T,
+}
+kernel::list::impl_has_list_links_self_ptr! {
+    impl HasSelfPtr<DTRWrap<dyn DeliverToRead>> for DTRWrap<dyn DeliverToRead> { self.links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl{T: ListArcSafe + ?Sized} ListArcSafe<0> for DTRWrap<T> {
+        tracked_by wrapped: T;
+    }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<0> for DTRWrap<dyn DeliverToRead> {
+        using ListLinksSelfPtr;
+    }
+}
+
+impl<T: ?Sized> core::ops::Deref for DTRWrap<T> {
+    type Target = T;
+    fn deref(&self) -> &T {
+        &self.wrapped
+    }
+}
+
+impl<T: ?Sized> core::ops::Receiver for DTRWrap<T> {}
+
+type DArc<T> = kernel::sync::Arc<DTRWrap<T>>;
+type DLArc<T> = kernel::list::ListArc<DTRWrap<T>>;
+
+impl<T: ListArcSafe> DTRWrap<T> {
+    #[allow(dead_code)]
+    fn arc_try_new(val: T) -> Result<DLArc<T>, alloc::alloc::AllocError> {
+        ListArc::pin_init(pin_init!(Self {
+            links <- ListLinksSelfPtr::new(),
+            wrapped: val,
+        }))
+        .map_err(|_| alloc::alloc::AllocError)
+    }
+
+    #[allow(dead_code)]
+    fn arc_pin_init(init: impl PinInit<T>) -> Result<DLArc<T>, kernel::error::Error> {
+        ListArc::pin_init(pin_init!(Self {
+            links <- ListLinksSelfPtr::new(),
+            wrapped <- init,
+        }))
+    }
+}
+
 struct BinderModule {}
 
 impl kernel::Module for BinderModule {
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 593c8e4f184e..a12c271a4e8f 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -8,24 +8,51 @@
 use kernel::{
     bindings,
     io_buffer::{IoBufferReader, IoBufferWriter},
+    list::{
+        AtomicListArcTracker, HasListLinks, List, ListArcSafe, ListItem, ListLinks, TryNewListArc,
+    },
     prelude::*,
-    sync::{Arc, SpinLock},
+    sync::{Arc, CondVar, SpinLock},
+    types::Either,
     user_ptr::UserSlicePtr,
 };
 
-use crate::{defs::*, process::Process};
+use crate::{defs::*, process::Process, DLArc, DTRWrap, DeliverToRead};
 
 use core::mem::size_of;
 
+pub(crate) enum PushWorkRes {
+    Ok,
+    FailedDead(DLArc<dyn DeliverToRead>),
+}
+
+impl PushWorkRes {
+    fn is_ok(&self) -> bool {
+        match self {
+            PushWorkRes::Ok => true,
+            PushWorkRes::FailedDead(_) => false,
+        }
+    }
+}
+
 /// The fields of `Thread` protected by the spinlock.
 struct InnerThread {
     /// Determines the looper state of the thread. It is a bit-wise combination of the constants
     /// prefixed with `LOOPER_`.
     looper_flags: u32,
 
+    /// Determines whether the looper should return.
+    looper_need_return: bool,
+
     /// Determines if thread is dead.
     is_dead: bool,
 
+    /// Determines whether the work list below should be processed. When set to false, `work_list`
+    /// is treated as if it were empty.
+    process_work_list: bool,
+    /// List of work items to deliver to userspace.
+    work_list: List<DTRWrap<dyn DeliverToRead>>,
+
     /// Extended error information for this thread.
     extended_error: ExtendedError,
 }
@@ -34,6 +61,8 @@ struct InnerThread {
 const LOOPER_ENTERED: u32 = 0x02;
 const LOOPER_EXITED: u32 = 0x04;
 const LOOPER_INVALID: u32 = 0x08;
+const LOOPER_WAITING: u32 = 0x10;
+const LOOPER_WAITING_PROC: u32 = 0x20;
 
 impl InnerThread {
     fn new() -> Self {
@@ -46,11 +75,42 @@ fn next_err_id() -> u32 {
 
         Self {
             looper_flags: 0,
+            looper_need_return: false,
             is_dead: false,
+            process_work_list: false,
+            work_list: List::new(),
             extended_error: ExtendedError::new(next_err_id(), BR_OK, 0),
         }
     }
 
+    fn pop_work(&mut self) -> Option<DLArc<dyn DeliverToRead>> {
+        if !self.process_work_list {
+            return None;
+        }
+
+        let ret = self.work_list.pop_front();
+        self.process_work_list = !self.work_list.is_empty();
+        ret
+    }
+
+    #[allow(dead_code)]
+    fn push_work(&mut self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
+        if self.is_dead {
+            PushWorkRes::FailedDead(work)
+        } else {
+            self.work_list.push_back(work);
+            self.process_work_list = true;
+            PushWorkRes::Ok
+        }
+    }
+
+    /// Used to push work items that do not need to be processed immediately and can wait until the
+    /// thread gets another work item.
+    #[allow(dead_code)]
+    fn push_work_deferred(&mut self, work: DLArc<dyn DeliverToRead>) {
+        self.work_list.push_back(work);
+    }
+
     fn looper_enter(&mut self) {
         self.looper_flags |= LOOPER_ENTERED;
         if self.looper_flags & LOOPER_REGISTERED != 0 {
@@ -73,6 +133,14 @@ fn looper_exit(&mut self) {
     fn is_looper(&self) -> bool {
         self.looper_flags & (LOOPER_ENTERED | LOOPER_REGISTERED) != 0
     }
+
+    /// Determines whether the thread should attempt to fetch work items from the process queue.
+    /// This is case when the thread is not part of a transaction stack and it is registered as a
+    /// looper. Also, if there is local work, we want to return to userspace before we deliver any
+    /// remote work.
+    fn should_use_process_work_queue(&self) -> bool {
+        !self.process_work_list && self.is_looper()
+    }
 }
 
 /// This represents a thread that's used with binder.
@@ -82,6 +150,29 @@ pub(crate) struct Thread {
     pub(crate) process: Arc<Process>,
     #[pin]
     inner: SpinLock<InnerThread>,
+    #[pin]
+    work_condvar: CondVar,
+    /// Used to insert this thread into the process' `ready_threads` list.
+    ///
+    /// INVARIANT: May never be used for any other list than the `self.process.ready_threads`.
+    #[pin]
+    links: ListLinks,
+    #[pin]
+    links_track: AtomicListArcTracker,
+}
+
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<0> for Thread { self.links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for Thread {
+        tracked_by links_track: AtomicListArcTracker;
+    }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<0> for Thread {
+        using ListLinks;
+    }
 }
 
 impl Thread {
@@ -90,6 +181,9 @@ pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
             id,
             process,
             inner <- kernel::new_spinlock!(InnerThread::new(), "Thread::inner"),
+            work_condvar <- kernel::new_condvar!("Thread::work_condvar"),
+            links <- ListLinks::new(),
+            links_track <- AtomicListArcTracker::new(),
         }))
     }
 
@@ -100,6 +194,123 @@ pub(crate) fn get_extended_error(&self, data: UserSlicePtr) -> Result {
         Ok(())
     }
 
+    /// Attempts to fetch a work item from the thread-local queue. The behaviour if the queue is
+    /// empty depends on `wait`: if it is true, the function waits for some work to be queued (or a
+    /// signal); otherwise it returns indicating that none is available.
+    fn get_work_local(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRead>>> {
+        {
+            let mut inner = self.inner.lock();
+            if inner.looper_need_return {
+                return Ok(inner.pop_work());
+            }
+        }
+
+        // Try once if the caller does not want to wait.
+        if !wait {
+            return self.inner.lock().pop_work().ok_or(EAGAIN).map(Some);
+        }
+
+        // Loop waiting only on the local queue (i.e., not registering with the process queue).
+        let mut inner = self.inner.lock();
+        loop {
+            if let Some(work) = inner.pop_work() {
+                return Ok(Some(work));
+            }
+
+            inner.looper_flags |= LOOPER_WAITING;
+            let signal_pending = self.work_condvar.wait(&mut inner);
+            inner.looper_flags &= !LOOPER_WAITING;
+
+            if signal_pending {
+                return Err(EINTR);
+            }
+            if inner.looper_need_return {
+                return Ok(None);
+            }
+        }
+    }
+
+    /// Attempts to fetch a work item from the thread-local queue, falling back to the process-wide
+    /// queue if none is available locally.
+    ///
+    /// This must only be called when the thread is not participating in a transaction chain. If it
+    /// is, the local version (`get_work_local`) should be used instead.
+    fn get_work(self: &Arc<Self>, wait: bool) -> Result<Option<DLArc<dyn DeliverToRead>>> {
+        // Try to get work from the thread's work queue, using only a local lock.
+        {
+            let mut inner = self.inner.lock();
+            if let Some(work) = inner.pop_work() {
+                return Ok(Some(work));
+            }
+            if inner.looper_need_return {
+                drop(inner);
+                return Ok(self.process.get_work());
+            }
+        }
+
+        // If the caller doesn't want to wait, try to grab work from the process queue.
+        //
+        // We know nothing will have been queued directly to the thread queue because it is not in
+        // a transaction and it is not in the process' ready list.
+        if !wait {
+            return self.process.get_work().ok_or(EAGAIN).map(Some);
+        }
+
+        // Get work from the process queue. If none is available, atomically register as ready.
+        let reg = match self.process.get_work_or_register(self) {
+            Either::Left(work) => return Ok(Some(work)),
+            Either::Right(reg) => reg,
+        };
+
+        let mut inner = self.inner.lock();
+        loop {
+            if let Some(work) = inner.pop_work() {
+                return Ok(Some(work));
+            }
+
+            inner.looper_flags |= LOOPER_WAITING | LOOPER_WAITING_PROC;
+            let signal_pending = self.work_condvar.wait(&mut inner);
+            inner.looper_flags &= !(LOOPER_WAITING | LOOPER_WAITING_PROC);
+
+            if signal_pending || inner.looper_need_return {
+                // We need to return now. We need to pull the thread off the list of ready threads
+                // (by dropping `reg`), then check the state again after it's off the list to
+                // ensure that something was not queued in the meantime. If something has been
+                // queued, we just return it (instead of the error).
+                drop(inner);
+                drop(reg);
+
+                let res = match self.inner.lock().pop_work() {
+                    Some(work) => Ok(Some(work)),
+                    None if signal_pending => Err(EINTR),
+                    None => Ok(None),
+                };
+                return res;
+            }
+        }
+    }
+
+    /// Push the provided work item to be delivered to user space via this thread.
+    ///
+    /// Returns whether the item was successfully pushed. This can only fail if the work item is
+    /// already in a work list.
+    #[allow(dead_code)]
+    pub(crate) fn push_work(&self, work: DLArc<dyn DeliverToRead>) -> PushWorkRes {
+        let sync = work.should_sync_wakeup();
+
+        let res = self.inner.lock().push_work(work);
+
+        if res.is_ok() {
+            if sync {
+                self.work_condvar.notify_sync();
+            } else {
+                self.work_condvar.notify_one();
+            }
+        }
+
+        res
+    }
+
     fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
         let write_start = req.write_buffer.wrapping_add(req.write_consumed);
         let write_len = req.write_size - req.write_consumed;
@@ -127,11 +338,19 @@ fn write(self: &Arc<Self>, req: &mut BinderWriteRead) -> Result {
         Ok(())
     }
 
-    fn read(self: &Arc<Self>, req: &mut BinderWriteRead, _wait: bool) -> Result {
+    fn read(self: &Arc<Self>, req: &mut BinderWriteRead, wait: bool) -> Result {
         let read_start = req.read_buffer.wrapping_add(req.read_consumed);
         let read_len = req.read_size - req.read_consumed;
         let mut writer = UserSlicePtr::new(read_start as _, read_len as _).writer();
-        let in_pool = self.inner.lock().is_looper();
+        let (in_pool, use_proc_queue) = {
+            let inner = self.inner.lock();
+            (inner.is_looper(), inner.should_use_process_work_queue())
+        };
+        let getter = if use_proc_queue {
+            Self::get_work
+        } else {
+            Self::get_work_local
+        };
 
         // Reserve some room at the beginning of the read buffer so that we can send a
         // BR_SPAWN_LOOPER if we need to.
@@ -145,13 +364,35 @@ fn read(self: &Arc<Self>, req: &mut BinderWriteRead, _wait: bool) -> Result {
         }
 
         // Loop doing work while there is room in the buffer.
-        #[allow(clippy::never_loop)]
+        let initial_len = writer.len();
         while writer.len() >= size_of::<bindings::binder_transaction_data_secctx>() + 4 {
-            // There is enough space in the output buffer to process another work item.
-            //
-            // However, we have not yet added work items to the driver, so we immediately break
-            // from the loop.
-            break;
+            match getter(self, wait && initial_len == writer.len()) {
+                Ok(Some(work)) => {
+                    let work_ty = work.debug_name();
+                    match work.into_arc().do_work(self, &mut writer) {
+                        Ok(true) => {}
+                        Ok(false) => break,
+                        Err(err) => {
+                            pr_warn!("Failure inside do_work of type {}.", work_ty);
+                            return Err(err);
+                        }
+                    }
+                }
+                Ok(None) => {
+                    break;
+                }
+                Err(err) => {
+                    // Propagate the error if we haven't written anything else.
+                    if err != EINTR && err != EAGAIN {
+                        pr_warn!("Failure in work getter: {:?}", err);
+                    }
+                    if initial_len == writer.len() {
+                        return Err(err);
+                    } else {
+                        break;
+                    }
+                }
+            }
         }
 
         req.read_consumed += read_len - writer.len() as u64;
@@ -178,6 +419,7 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlicePtr, wait: bool) -> Re
                 );
                 req.read_consumed = 0;
                 writer.write(&req)?;
+                self.inner.lock().looper_need_return = false;
                 return Err(err);
             }
         }
@@ -197,10 +439,32 @@ pub(crate) fn write_read(self: &Arc<Self>, data: UserSlicePtr, wait: bool) -> Re
 
         // Write the request back so that the consumed fields are visible to the caller.
         writer.write(&req)?;
+
+        self.inner.lock().looper_need_return = false;
+
         ret
     }
 
+    /// Make the call to `get_work` or `get_work_local` return immediately, if any.
+    pub(crate) fn exit_looper(&self) {
+        let mut inner = self.inner.lock();
+        let should_notify = inner.looper_flags & LOOPER_WAITING != 0;
+        if should_notify {
+            inner.looper_need_return = true;
+        }
+        drop(inner);
+
+        if should_notify {
+            self.work_condvar.notify_one();
+        }
+    }
+
     pub(crate) fn release(self: &Arc<Self>) {
         self.inner.lock().is_dead = true;
+
+        // Cancel all pending work items.
+        while let Ok(Some(work)) = self.get_work_local(false) {
+            work.into_arc().cancel();
+        }
     }
 }
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index b388f3d75d49..29108cd3377c 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -262,7 +262,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := const_maybe_uninit_zeroed,new_uninit,offset_of,allocator_api
+rust_allowed_features := const_maybe_uninit_zeroed,new_uninit,offset_of,allocator_api,receiver_trait
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree

-- 
2.42.0.820.g83a721a137-goog

