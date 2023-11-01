Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD777DE5D5
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345215AbjKASDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344951AbjKASDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:08 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDF1111
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:03:02 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da040c021aeso12091276.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:03:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861781; x=1699466581; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=YNne2uV93ckwMpGguK52oBZlOAZFXC7MfuI9180HtAk=;
        b=cbIJ2insncFswk6hAzuTTZwcesQ/J2lO0mj2Yq3IVqU15NJnrWwFq6pNS4pwajm9fn
         soPQkEZNwu7cViawUrtuASjbdF0ka6+eGU6wGdMaBRRwKo4pjt2vb+AJIWI8QmXdpvka
         L2X1836Hzh9UFykz6lwEzdBD3n9ZUoktUiyqOGG7rUfhdx1crqlOykXMopkc7m4cWoog
         1C1+KXP+O8kHBFfVcII3569eIN92pAk918twl8wu7FogOiTkk+zS2MCALiQZ1YvoLwoO
         ISvPaxawcXdbD3v+mzo3jzI/Gi/b8UMspyOjkEVORBcKwopmdEJKNfr7A45pZSHCGKGX
         v0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861781; x=1699466581;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YNne2uV93ckwMpGguK52oBZlOAZFXC7MfuI9180HtAk=;
        b=J0u/LksqUI1apF4AA3DO4KYeDOSbrOD4JU4vNHFemxnkw1Tk2LUFaigLseBdz/Cgn3
         ECaYjBh81MvTH/jvwIJ59Lnu2z9/i32z4pX6AVH1aKl0hYR50YheqlTBbGYUdsIR5eY7
         U3EaYrihFTGfG81fE7OAuZzzCydOJBxNjYYX/WY2nGuOR07QpXoXM8o79KsPRnEuW++v
         EGOtbVtsulJBms8t2DM01qTQAmbjtE2mDAyIOh1pgkNqfXS2FXaN9zg6WEP6rQux9sXN
         SOlNz3Pa4Ci30YC6zbxp3PiSxcB0RVveZrAJwxJrEIenbNjaMNvvvmqiOfLHsj6nqd/N
         lrRA==
X-Gm-Message-State: AOJu0YyEqmIgjvTv8T4nVZ+9+cAG403Ql7CNcVuT/1c2JxDZJe8HBQmm
        5CgZ9BBtxURqG/cep/jpmC4gI99u9kaCbGg=
X-Google-Smtp-Source: AGHT+IHOGqfCsl8HbDwvfwDfos1+NgmfjK4tR1zPs+FfFTz3kcrgfYuZozWyS14aVKmyXQfzEAVEM3lFdkaBc/U=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1083:b0:da0:567d:f819 with SMTP
 id v3-20020a056902108300b00da0567df819mr389361ybu.10.1698861781743; Wed, 01
 Nov 2023 11:03:01 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:48 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-18-08ba9197f637@google.com>
Subject: [PATCH RFC 18/20] rust_binder: add binder_logs/state
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

The binderfs directory has four files intended for debugging the driver.
This patch implements the state file so that you can use it to view the
current state of the driver.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/node.rs         | 37 ++++++++++++++++++++
 drivers/android/process.rs      | 75 +++++++++++++++++++++++++++++++++++++++++
 drivers/android/rust_binder.rs  | 23 ++++++++++++-
 drivers/android/thread.rs       | 68 +++++++++++++++++++++++++++++++++++++
 drivers/android/transaction.rs  | 25 ++++++++++++++
 rust/bindings/bindings_helper.h |  1 +
 rust/kernel/lib.rs              |  1 +
 rust/kernel/seq_file.rs         | 47 ++++++++++++++++++++++++++
 8 files changed, 276 insertions(+), 1 deletion(-)

diff --git a/drivers/android/node.rs b/drivers/android/node.rs
index 2c056bd7582e..3acad1c2b963 100644
--- a/drivers/android/node.rs
+++ b/drivers/android/node.rs
@@ -7,6 +7,8 @@
         TryNewListArc,
     },
     prelude::*,
+    seq_file::SeqFile,
+    seq_print,
     sync::lock::{spinlock::SpinLockBackend, Guard},
     sync::{Arc, LockedBy, SpinLock},
     user_ptr::UserSlicePtrWriter,
@@ -111,6 +113,41 @@ pub(crate) fn new(
         })
     }
 
+    #[inline(never)]
+    pub(crate) fn debug_print(&self, m: &mut SeqFile) -> Result<()> {
+        let weak;
+        let strong;
+        let has_weak;
+        let has_strong;
+        let active_inc_refs;
+        {
+            let mut guard = self.owner.inner.lock();
+            let inner = self.inner.access_mut(&mut guard);
+            weak = inner.weak.count;
+            has_weak = inner.weak.has_count;
+            strong = inner.strong.count;
+            has_strong = inner.strong.has_count;
+            active_inc_refs = inner.active_inc_refs;
+        }
+
+        let has_weak = if has_weak { "Y" } else { "N" };
+        let has_strong = if has_strong { "Y" } else { "N" };
+
+        seq_print!(
+            m,
+            "node gid:{},ptr:{:#x},cookie:{:#x}: strong{}{} weak{}{} active{}\n",
+            self.global_id,
+            self.ptr,
+            self.cookie,
+            strong,
+            has_strong,
+            weak,
+            has_weak,
+            active_inc_refs
+        );
+        Ok(())
+    }
+
     pub(crate) fn get_id(&self) -> (usize, usize) {
         (self.ptr, self.cookie)
     }
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 4ac5d09041a4..b5e44f9f2a14 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -20,6 +20,8 @@
     pages::Pages,
     prelude::*,
     rbtree::RBTree,
+    seq_file::SeqFile,
+    seq_print,
     sync::{
         lock::Guard, Arc, ArcBorrow, CondVar, CondVarTimeoutResult, Mutex, SpinLock, UniqueArc,
     },
@@ -405,6 +407,79 @@ fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
         Ok(process)
     }
 
+    #[inline(never)]
+    pub(crate) fn debug_print(&self, m: &mut SeqFile) -> Result<()> {
+        seq_print!(m, "pid: {}\n", self.task.pid_in_current_ns());
+
+        let is_manager;
+        let started_threads;
+        let has_proc_work;
+        let mut ready_threads = Vec::new();
+        let mut all_threads = Vec::new();
+        let mut all_nodes = Vec::new();
+        loop {
+            let inner = self.inner.lock();
+            let ready_threads_len = inner.ready_threads.iter().count();
+            let all_threads_len = inner.threads.values().count();
+            let all_nodes_len = inner.nodes.values().count();
+
+            let resize_ready_threads = ready_threads_len > ready_threads.capacity();
+            let resize_all_threads = all_threads_len > all_threads.capacity();
+            let resize_all_nodes = all_nodes_len > all_nodes.capacity();
+            if resize_ready_threads || resize_all_threads || resize_all_nodes {
+                drop(inner);
+                ready_threads.try_reserve(ready_threads_len)?;
+                all_threads.try_reserve(all_threads_len)?;
+                all_nodes.try_reserve(all_nodes_len)?;
+                continue;
+            }
+
+            is_manager = inner.is_manager;
+            started_threads = inner.started_thread_count;
+            has_proc_work = !inner.work.is_empty();
+
+            for thread in &inner.ready_threads {
+                assert!(ready_threads.len() < ready_threads.capacity());
+                ready_threads.try_push(thread.id)?;
+            }
+
+            for thread in inner.threads.values() {
+                assert!(all_threads.len() < all_threads.capacity());
+                all_threads.try_push(thread.clone())?;
+            }
+
+            for node in inner.nodes.values() {
+                assert!(all_nodes.len() < all_nodes.capacity());
+                all_nodes.try_push(node.clone())?;
+            }
+
+            break;
+        }
+
+        seq_print!(m, "is_manager: {}\n", is_manager);
+        seq_print!(m, "started_threads: {}\n", started_threads);
+        seq_print!(m, "has_proc_work: {}\n", has_proc_work);
+        if ready_threads.is_empty() {
+            seq_print!(m, "ready_thread_ids: none\n");
+        } else {
+            seq_print!(m, "ready_thread_ids:");
+            for thread_id in ready_threads {
+                seq_print!(m, " {}", thread_id);
+            }
+            seq_print!(m, "\n");
+        }
+
+        for node in all_nodes {
+            node.debug_print(m)?;
+        }
+
+        seq_print!(m, "all threads:\n");
+        for thread in all_threads {
+            thread.debug_print(m);
+        }
+        Ok(())
+    }
+
     /// Attempts to fetch a work item from the process queue.
     pub(crate) fn get_work(&self) -> Option<DLArc<dyn DeliverToRead>> {
         self.inner.lock().work.pop_front()
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index adf542872f36..a1c95a1609d5 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -10,6 +10,8 @@
         HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks, ListLinksSelfPtr, TryNewListArc,
     },
     prelude::*,
+    seq_file::SeqFile,
+    seq_print,
     sync::Arc,
     types::ForeignOwnable,
     user_ptr::UserSlicePtrWriter,
@@ -347,7 +349,13 @@ unsafe impl<T> Sync for AssertSync<T> {}
 }
 
 #[no_mangle]
-unsafe extern "C" fn rust_binder_state_show(_: *mut seq_file) -> core::ffi::c_int {
+unsafe extern "C" fn rust_binder_state_show(ptr: *mut seq_file) -> core::ffi::c_int {
+    // SAFETY: The caller ensures that the pointer is valid and exclusive for the duration in which
+    // this method is called.
+    let m = unsafe { SeqFile::from_raw(ptr) };
+    if let Err(err) = rust_binder_state_show_impl(m) {
+        seq_print!(m, "failed to generate state: {:?}\n", err);
+    }
     0
 }
 
@@ -360,3 +368,16 @@ unsafe impl<T> Sync for AssertSync<T> {}
 unsafe extern "C" fn rust_binder_transaction_log_show(_: *mut seq_file) -> core::ffi::c_int {
     0
 }
+
+fn rust_binder_state_show_impl(m: &mut SeqFile) -> Result<()> {
+    let contexts = context::get_all_contexts()?;
+    for ctx in contexts {
+        let procs = ctx.get_all_procs()?;
+        seq_print!(m, "context {}: ({} processes)\n", &*ctx.name, procs.len());
+        for proc in procs {
+            proc.debug_print(m)?;
+            seq_print!(m, "\n");
+        }
+    }
+    Ok(())
+}
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 414ffb1387a0..d5a56119cc19 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -15,6 +15,8 @@
     },
     prelude::*,
     security,
+    seq_file::SeqFile,
+    seq_print,
     sync::{Arc, SpinLock},
     types::Either,
     user_ptr::{UserSlicePtr, UserSlicePtrWriter},
@@ -447,6 +449,72 @@ pub(crate) fn new(id: i32, process: Arc<Process>) -> Result<Arc<Self>> {
         }))
     }
 
+    #[inline(never)]
+    pub(crate) fn debug_print(&self, m: &mut SeqFile) {
+        let looper_flags;
+        let looper_need_return;
+        let is_dead;
+        let has_work;
+        let process_work_list;
+        let current_transaction;
+        {
+            let inner = self.inner.lock();
+            looper_flags = inner.looper_flags;
+            looper_need_return = inner.looper_need_return;
+            is_dead = inner.is_dead;
+            has_work = !inner.work_list.is_empty();
+            process_work_list = inner.process_work_list;
+            current_transaction = inner.current_transaction.clone();
+        }
+        seq_print!(m, "  tid: {}\n", self.id);
+        seq_print!(m, "  state:");
+        if is_dead {
+            seq_print!(m, " dead");
+        }
+        if looper_need_return {
+            seq_print!(m, " pending_flush_wakeup");
+        }
+        if has_work && process_work_list {
+            seq_print!(m, " has_work");
+        }
+        if has_work && !process_work_list {
+            seq_print!(m, " has_deferred_work");
+        }
+        if looper_flags & LOOPER_REGISTERED != 0 {
+            seq_print!(m, " registered");
+        }
+        if looper_flags & LOOPER_ENTERED != 0 {
+            seq_print!(m, " entered");
+        }
+        if looper_flags & LOOPER_EXITED != 0 {
+            seq_print!(m, " exited");
+        }
+        if looper_flags & LOOPER_INVALID != 0 {
+            seq_print!(m, " invalid");
+        }
+        if looper_flags & LOOPER_WAITING != 0 {
+            if looper_flags & LOOPER_WAITING_PROC != 0 {
+                seq_print!(m, " in_get_work");
+            } else {
+                seq_print!(m, " in_get_work_local");
+            }
+        }
+        if looper_flags & LOOPER_POLL != 0 {
+            seq_print!(m, " poll_is_initialized");
+        }
+        seq_print!(m, "\n");
+        if current_transaction.is_some() {
+            seq_print!(m, "  tstack:");
+            let mut t = current_transaction;
+            while let Some(tt) = t.as_ref() {
+                seq_print!(m, " ");
+                tt.debug_print(m);
+                t = tt.clone_next();
+            }
+            seq_print!(m, "\n");
+        }
+    }
+
     pub(crate) fn get_extended_error(&self, data: UserSlicePtr) -> Result {
         let mut writer = data.writer();
         let ee = self.inner.lock().extended_error;
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index 84b9fe58fe3e..30c411ab0778 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -5,6 +5,8 @@
     io_buffer::IoBufferWriter,
     list::ListArcSafe,
     prelude::*,
+    seq_file::SeqFile,
+    seq_print,
     sync::{Arc, SpinLock},
     task::Kuid,
     types::{Either, ScopeGuard},
@@ -140,6 +142,29 @@ pub(crate) fn new_reply(
         }))?)
     }
 
+    #[inline(never)]
+    pub(crate) fn debug_print(&self, m: &mut SeqFile) {
+        let from_pid = self.from.process.task.pid_in_current_ns();
+        let to_pid = self.to.task.pid_in_current_ns();
+        let from_tid = self.from.id;
+        match self.target_node.as_ref() {
+            Some(target_node) => {
+                let node_id = target_node.global_id;
+                seq_print!(
+                    m,
+                    "{}(tid:{})->{}(nid:{})",
+                    from_pid,
+                    from_tid,
+                    to_pid,
+                    node_id
+                );
+            }
+            None => {
+                seq_print!(m, "{}(tid:{})->{}(nid:_)", from_pid, from_tid, to_pid);
+            }
+        }
+    }
+
     /// Determines if the transaction is stacked on top of the given transaction.
     pub(crate) fn is_stacked_on(&self, onext: &Option<DArc<Self>>) -> bool {
         match (&self.stack_next, onext) {
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index ffeea312f2fd..b2d60b4a9df6 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -15,6 +15,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/poll.h>
 #include <linux/security.h>
+#include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
 #include <linux/rust_binder.h>
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index f4d58da9202e..d46187783464 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -48,6 +48,7 @@
 pub mod print;
 pub mod rbtree;
 pub mod security;
+pub mod seq_file;
 mod static_assert;
 #[doc(hidden)]
 pub mod std_vendor;
diff --git a/rust/kernel/seq_file.rs b/rust/kernel/seq_file.rs
new file mode 100644
index 000000000000..997d527b2e9e
--- /dev/null
+++ b/rust/kernel/seq_file.rs
@@ -0,0 +1,47 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Seq file bindings.
+//!
+//! C header: [`include/linux/seq_file.h`](../../../../include/linux/seq_file.h)
+
+use crate::{bindings, c_str, types::Opaque};
+
+/// A helper for implementing special files, where the complete contents can be generated on each
+/// access.
+pub struct SeqFile(Opaque<bindings::seq_file>);
+
+impl SeqFile {
+    /// Creates a new [`SeqFile`] from a raw pointer.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that, for the duration of 'a, the pointer must point at a valid
+    /// `seq_file` and that it will not be accessed via anything other than the returned reference.
+    pub unsafe fn from_raw<'a>(ptr: *mut bindings::seq_file) -> &'a mut SeqFile {
+        // SAFETY: The safety requirements guarantee the validity of the dereference, while the
+        // `Credential` type being transparent makes the cast ok.
+        unsafe { &mut *ptr.cast() }
+    }
+
+    /// Used by the [`seq_print`] macro.
+    ///
+    /// [`seq_print`]: crate::seq_print
+    pub fn call_printf(&mut self, args: core::fmt::Arguments<'_>) {
+        // SAFETY: Passing a void pointer to `Arguments` is valid for `%pA`.
+        unsafe {
+            bindings::seq_printf(
+                self.0.get(),
+                c_str!("%pA").as_char_ptr(),
+                &args as *const _ as *const core::ffi::c_void,
+            );
+        }
+    }
+}
+
+/// Use for writing to a [`SeqFile`] with the ordinary Rust formatting syntax.
+#[macro_export]
+macro_rules! seq_print {
+    ($m:expr, $($arg:tt)+) => (
+        $m.call_printf(format_args!($($arg)+))
+    );
+}

-- 
2.42.0.820.g83a721a137-goog

