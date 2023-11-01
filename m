Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E6E7DE5BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344975AbjKASDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344895AbjKASDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:03:06 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D44D18E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:03:00 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5b0e9c78309so1216177b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861779; x=1699466579; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=nYW75oSrNQi79Zio08wfQNCgl+W4tz8r9dl1ZKyv6O4=;
        b=VhhTZgu3xoCVrmyn1AamR9fTEEa4P+z1B3WIF1mxz4WmGKRR0cVTghw4qzHgFKgp7R
         x9SwYKVB5juB3OVO1RAWIGznKpTRthfkhuWBP8OU9bla3Tive5OXQqVxqJbZnY3UuWb7
         LkouFMfgIvPZwyij8enPS0GJ2EpIG695O61iG3oSEu4+/7/9fLMbV47CArN53S6JmqWL
         uIdVeCM0ZRgAVgCNIflEjkLgCwP5K4EpPj/ObS8nPIPchxElKjRNVFZ/Fbdv2NNuAMuP
         hhdMBDcwl6CDfyP9Aqfo8XDDDh/+eDNeII/MpmXQI+5NXXk1Pda99gtSUwqEsvFlanPs
         J/sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861779; x=1699466579;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nYW75oSrNQi79Zio08wfQNCgl+W4tz8r9dl1ZKyv6O4=;
        b=oMRA304K6PSTavp+0gB14xPh+ofKbIynDnDLJ2ZPOX8lUaqlDIOjtBAvOPslg0Qdm2
         HsJNaBAuu51kNIQA1u43f4Xqt+118qFzH7KVUl9T0jy9j4N/+ryzRvmcwHvfxyK9ZuPa
         G4oP6UkV9VGiw2AeALQ5vhoL1rqV2g0Rxuu+9rmsdmbeD19sMi4SVVx3EXZDezGJm5QK
         sqFFROEI/2dcOjYwo5R6dOI+ceFRLEHkUmlD8eRr4h44vsnkmlrZaB+Ch+I0sNNFg7yz
         VKVqNcU1QfUbqt7Uz41VmI0KBAsMQo84UXUd/8Zbiyk08uw6ecgzm9vW1NbVR7xE+20i
         k/wA==
X-Gm-Message-State: AOJu0Yy18Oo1KikJr6HlIGzlY6/Mx4Mypk7LJnu/XZnrUgVhc5zajJHZ
        6FJY+dyWi+jPWxHPN0pVufg0tCDojh7bns0=
X-Google-Smtp-Source: AGHT+IHyI710R7AyGKPM/MfDFt1RmrovNIXnY76dQCzx4Z9GujvM5UIRNylCqNuAbAPVxTMMEtgQcPeoiKbQLLI=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:6e54:0:b0:595:5cf0:a9b0 with SMTP id
 j81-20020a816e54000000b005955cf0a9b0mr342967ywc.9.1698861779078; Wed, 01 Nov
 2023 11:02:59 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:47 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-17-08ba9197f637@google.com>
Subject: [PATCH RFC 17/20] rust_binder: add oneway spam detection
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

From: Matt Gilbride <mattgilbride@google.com>

The idea is that once we cross a certain threshold of free async space,
whoever is responsible for the low async space is likely to try to send
another async transaction.

This change allows servers to turn on oneway spam detection and return a
different binder reply when it is detected.

Signed-off-by: Matt Gilbride <mattgilbride@google.com>
Co-developed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/allocation.rs  |  3 ++
 drivers/android/defs.rs        |  1 +
 drivers/android/process.rs     | 39 ++++++++++++++++++++++++--
 drivers/android/range_alloc.rs | 62 ++++++++++++++++++++++++++++++++++++++++--
 drivers/android/rust_binder.rs |  1 -
 drivers/android/thread.rs      | 11 ++++++--
 drivers/android/transaction.rs |  5 ++++
 rust/kernel/task.rs            |  2 +-
 8 files changed, 115 insertions(+), 9 deletions(-)

diff --git a/drivers/android/allocation.rs b/drivers/android/allocation.rs
index c7f44a54b79b..7b64e7fcce4d 100644
--- a/drivers/android/allocation.rs
+++ b/drivers/android/allocation.rs
@@ -49,6 +49,7 @@ pub(crate) struct Allocation {
     pub(crate) process: Arc<Process>,
     allocation_info: Option<AllocationInfo>,
     free_on_drop: bool,
+    pub(crate) oneway_spam_detected: bool,
 }
 
 impl Allocation {
@@ -58,6 +59,7 @@ pub(crate) fn new(
         size: usize,
         ptr: usize,
         pages: Arc<Vec<Pages<0>>>,
+        oneway_spam_detected: bool,
     ) -> Self {
         Self {
             process,
@@ -65,6 +67,7 @@ pub(crate) fn new(
             size,
             ptr,
             pages,
+            oneway_spam_detected,
             allocation_info: None,
             free_on_drop: true,
         }
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
index b1a54f85b365..e345b6ea45cc 100644
--- a/drivers/android/defs.rs
+++ b/drivers/android/defs.rs
@@ -24,6 +24,7 @@ macro_rules! pub_no_prefix {
     BR_NOOP,
     BR_SPAWN_LOOPER,
     BR_TRANSACTION_COMPLETE,
+    BR_ONEWAY_SPAM_SUSPECT,
     BR_OK,
     BR_ERROR,
     BR_INCREFS,
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
index 44baf9e3f998..4ac5d09041a4 100644
--- a/drivers/android/process.rs
+++ b/drivers/android/process.rs
@@ -92,6 +92,8 @@ pub(crate) struct ProcessInner {
     pub(crate) sync_recv: bool,
     /// Process received async transactions since last frozen.
     pub(crate) async_recv: bool,
+    /// Check for oneway spam
+    oneway_spam_detection_enabled: bool,
 }
 
 impl ProcessInner {
@@ -113,6 +115,7 @@ fn new() -> Self {
             is_frozen: false,
             sync_recv: false,
             async_recv: false,
+            oneway_spam_detection_enabled: false,
         }
     }
 
@@ -658,17 +661,21 @@ pub(crate) fn buffer_alloc(
         self: &Arc<Self>,
         size: usize,
         is_oneway: bool,
+        from_pid: i32,
     ) -> BinderResult<Allocation> {
         let alloc = range_alloc::ReserveNewBox::try_new()?;
         let mut inner = self.inner.lock();
         let mapping = inner.mapping.as_mut().ok_or_else(BinderError::new_dead)?;
-        let offset = mapping.alloc.reserve_new(size, is_oneway, alloc)?;
+        let offset = mapping
+            .alloc
+            .reserve_new(size, is_oneway, from_pid, alloc)?;
         Ok(Allocation::new(
             self.clone(),
             offset,
             size,
             mapping.address + offset,
             mapping.pages.clone(),
+            mapping.alloc.oneway_spam_detected,
         ))
     }
 
@@ -677,7 +684,14 @@ pub(crate) fn buffer_get(self: &Arc<Self>, ptr: usize) -> Option<Allocation> {
         let mapping = inner.mapping.as_mut()?;
         let offset = ptr.checked_sub(mapping.address)?;
         let (size, odata) = mapping.alloc.reserve_existing(offset).ok()?;
-        let mut alloc = Allocation::new(self.clone(), offset, size, ptr, mapping.pages.clone());
+        let mut alloc = Allocation::new(
+            self.clone(),
+            offset,
+            size,
+            ptr,
+            mapping.pages.clone(),
+            mapping.alloc.oneway_spam_detected,
+        );
         if let Some(data) = odata {
             alloc.set_info(data);
         }
@@ -762,6 +776,14 @@ fn set_max_threads(&self, max: u32) {
         self.inner.lock().max_threads = max;
     }
 
+    fn set_oneway_spam_detection_enabled(&self, enabled: u32) {
+        self.inner.lock().oneway_spam_detection_enabled = enabled != 0;
+    }
+
+    pub(crate) fn is_oneway_spam_detection_enabled(&self) -> bool {
+        self.inner.lock().oneway_spam_detection_enabled
+    }
+
     fn get_node_debug_info(&self, data: UserSlicePtr) -> Result {
         let (mut reader, mut writer) = data.reader_writer();
 
@@ -948,9 +970,17 @@ fn deferred_release(self: Arc<Self>) {
         if let Some(mut mapping) = omapping {
             let address = mapping.address;
             let pages = mapping.pages.clone();
+            let oneway_spam_detected = mapping.alloc.oneway_spam_detected;
             mapping.alloc.take_for_each(|offset, size, odata| {
                 let ptr = offset + address;
-                let mut alloc = Allocation::new(self.clone(), offset, size, ptr, pages.clone());
+                let mut alloc = Allocation::new(
+                    self.clone(),
+                    offset,
+                    size,
+                    ptr,
+                    pages.clone(),
+                    oneway_spam_detected,
+                );
                 if let Some(data) = odata {
                     alloc.set_info(data);
                 }
@@ -1144,6 +1174,9 @@ fn write(
             bindings::BINDER_SET_CONTEXT_MGR_EXT => {
                 this.set_as_manager(Some(reader.read()?), &thread)?
             }
+            bindings::BINDER_ENABLE_ONEWAY_SPAM_DETECTION => {
+                this.set_oneway_spam_detection_enabled(reader.read()?)
+            }
             bindings::BINDER_FREEZE => ioctl_freeze(reader)?,
             _ => return Err(EINVAL),
         }
diff --git a/drivers/android/range_alloc.rs b/drivers/android/range_alloc.rs
index e757129613cf..c1d47115e54d 100644
--- a/drivers/android/range_alloc.rs
+++ b/drivers/android/range_alloc.rs
@@ -3,6 +3,7 @@
 use kernel::{
     prelude::*,
     rbtree::{RBTree, RBTreeNode, RBTreeNodeReservation},
+    task::Pid,
 };
 
 /// Keeps track of allocations in a process' mmap.
@@ -13,7 +14,9 @@
 pub(crate) struct RangeAllocator<T> {
     tree: RBTree<usize, Descriptor<T>>,
     free_tree: RBTree<FreeKey, ()>,
+    size: usize,
     free_oneway_space: usize,
+    pub(crate) oneway_spam_detected: bool,
 }
 
 impl<T> RangeAllocator<T> {
@@ -26,6 +29,8 @@ pub(crate) fn new(size: usize) -> Result<Self> {
             free_oneway_space: size / 2,
             tree,
             free_tree,
+            oneway_spam_detected: false,
+            size,
         })
     }
 
@@ -40,6 +45,7 @@ pub(crate) fn reserve_new(
         &mut self,
         size: usize,
         is_oneway: bool,
+        pid: Pid,
         alloc: ReserveNewBox<T>,
     ) -> Result<usize> {
         // Compute new value of free_oneway_space, which is set only on success.
@@ -52,6 +58,15 @@ pub(crate) fn reserve_new(
             self.free_oneway_space
         };
 
+        // Start detecting spammers once we have less than 20%
+        // of async space left (which is less than 10% of total
+        // buffer size).
+        //
+        // (This will short-circut, so `low_oneway_space` is
+        // only called when necessary.)
+        self.oneway_spam_detected =
+            is_oneway && new_oneway_space < self.size / 10 && self.low_oneway_space(pid);
+
         let (found_size, found_off, tree_node, free_tree_node) = match self.find_best_match(size) {
             None => {
                 pr_warn!("ENOSPC from range_alloc.reserve_new - size: {}", size);
@@ -65,7 +80,7 @@ pub(crate) fn reserve_new(
                 let new_desc = Descriptor::new(found_offset + size, found_size - size);
                 let (tree_node, free_tree_node, desc_node_res) = alloc.initialize(new_desc);
 
-                desc.state = Some(DescriptorState::new(is_oneway, desc_node_res));
+                desc.state = Some(DescriptorState::new(is_oneway, pid, desc_node_res));
                 desc.size = size;
 
                 (found_size, found_offset, tree_node, free_tree_node)
@@ -224,6 +239,30 @@ pub(crate) fn take_for_each<F: Fn(usize, usize, Option<T>)>(&mut self, callback:
             }
         }
     }
+
+    /// Find the amount and size of buffers allocated by the current caller.
+    ///
+    /// The idea is that once we cross the threshold, whoever is responsible
+    /// for the low async space is likely to try to send another async transaction,
+    /// and at some point we'll catch them in the act.  This is more efficient
+    /// than keeping a map per pid.
+    fn low_oneway_space(&self, calling_pid: Pid) -> bool {
+        let mut total_alloc_size = 0;
+        let mut num_buffers = 0;
+        for (_, desc) in self.tree.iter() {
+            if let Some(state) = &desc.state {
+                if state.is_oneway() && state.pid() == calling_pid {
+                    total_alloc_size += desc.size;
+                    num_buffers += 1;
+                }
+            }
+        }
+
+        // Warn if this pid has more than 50 transactions, or more than 50% of
+        // async space (which is 25% of total buffer size). Oneway spam is only
+        // detected when the threshold is exceeded.
+        num_buffers > 50 || total_alloc_size > self.size / 4
+    }
 }
 
 struct Descriptor<T> {
@@ -257,16 +296,32 @@ enum DescriptorState<T> {
 }
 
 impl<T> DescriptorState<T> {
-    fn new(is_oneway: bool, free_res: FreeNodeRes) -> Self {
+    fn new(is_oneway: bool, pid: Pid, free_res: FreeNodeRes) -> Self {
         DescriptorState::Reserved(Reservation {
             is_oneway,
+            pid,
             free_res,
         })
     }
+
+    fn pid(&self) -> Pid {
+        match self {
+            DescriptorState::Reserved(inner) => inner.pid,
+            DescriptorState::Allocated(inner) => inner.pid,
+        }
+    }
+
+    fn is_oneway(&self) -> bool {
+        match self {
+            DescriptorState::Reserved(inner) => inner.is_oneway,
+            DescriptorState::Allocated(inner) => inner.is_oneway,
+        }
+    }
 }
 
 struct Reservation {
     is_oneway: bool,
+    pid: Pid,
     free_res: FreeNodeRes,
 }
 
@@ -275,6 +330,7 @@ fn allocate<T>(self, data: Option<T>) -> Allocation<T> {
         Allocation {
             data,
             is_oneway: self.is_oneway,
+            pid: self.pid,
             free_res: self.free_res,
         }
     }
@@ -282,6 +338,7 @@ fn allocate<T>(self, data: Option<T>) -> Allocation<T> {
 
 struct Allocation<T> {
     is_oneway: bool,
+    pid: Pid,
     free_res: FreeNodeRes,
     data: Option<T>,
 }
@@ -291,6 +348,7 @@ fn deallocate(self) -> (Reservation, Option<T>) {
         (
             Reservation {
                 is_oneway: self.is_oneway,
+                pid: self.pid,
                 free_res: self.free_res,
             },
             self.data,
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 04477ff7e5a0..adf542872f36 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -107,7 +107,6 @@ fn new(val: impl PinInit<T>) -> impl PinInit<Self> {
         })
     }
 
-    #[allow(dead_code)]
     fn arc_try_new(val: T) -> Result<DLArc<T>, alloc::alloc::AllocError> {
         ListArc::pin_init(pin_init!(Self {
             links <- ListLinksSelfPtr::new(),
diff --git a/drivers/android/thread.rs b/drivers/android/thread.rs
index 0238c15604f6..414ffb1387a0 100644
--- a/drivers/android/thread.rs
+++ b/drivers/android/thread.rs
@@ -909,7 +909,7 @@ pub(crate) fn copy_transaction_data(
             size_of::<usize>(),
         );
         let secctx_off = adata_size + aoffsets_size + abuffers_size;
-        let mut alloc = match to_process.buffer_alloc(len, is_oneway) {
+        let mut alloc = match to_process.buffer_alloc(len, is_oneway, self.process.task.pid()) {
             Ok(alloc) => alloc,
             Err(err) => {
                 pr_warn!(
@@ -1191,8 +1191,15 @@ fn oneway_transaction_inner(self: &Arc<Self>, tr: &BinderTransactionDataSg) -> B
         let handle = unsafe { tr.transaction_data.target.handle };
         let node_ref = self.process.get_transaction_node(handle)?;
         security::binder_transaction(&self.process.cred, &node_ref.node.owner.cred)?;
-        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(BR_TRANSACTION_COMPLETE))?;
         let transaction = Transaction::new(node_ref, None, self, tr)?;
+        let code = if self.process.is_oneway_spam_detection_enabled()
+            && transaction.oneway_spam_detected
+        {
+            BR_ONEWAY_SPAM_SUSPECT
+        } else {
+            BR_TRANSACTION_COMPLETE
+        };
+        let list_completion = DTRWrap::arc_try_new(DeliverCode::new(code))?;
         let completion = list_completion.clone_arc();
         self.inner.lock().push_work(list_completion);
         match transaction.submit() {
diff --git a/drivers/android/transaction.rs b/drivers/android/transaction.rs
index 7028c504ef8c..84b9fe58fe3e 100644
--- a/drivers/android/transaction.rs
+++ b/drivers/android/transaction.rs
@@ -38,6 +38,7 @@ pub(crate) struct Transaction {
     data_address: usize,
     sender_euid: Kuid,
     txn_security_ctx_off: Option<usize>,
+    pub(crate) oneway_spam_detected: bool,
 }
 
 kernel::list::impl_list_arc_safe! {
@@ -70,6 +71,7 @@ pub(crate) fn new(
                 return Err(err);
             }
         };
+        let oneway_spam_detected = alloc.oneway_spam_detected;
         if trd.flags & TF_ONE_WAY != 0 {
             if stack_next.is_some() {
                 pr_warn!("Oneway transaction should not be in a transaction stack.");
@@ -98,6 +100,7 @@ pub(crate) fn new(
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
             is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off,
+            oneway_spam_detected,
         }))?)
     }
 
@@ -115,6 +118,7 @@ pub(crate) fn new_reply(
                 return Err(err);
             }
         };
+        let oneway_spam_detected = alloc.oneway_spam_detected;
         if trd.flags & TF_CLEAR_BUF != 0 {
             alloc.set_info_clear_on_drop();
         }
@@ -132,6 +136,7 @@ pub(crate) fn new_reply(
             allocation <- kernel::new_spinlock!(Some(alloc), "Transaction::new"),
             is_outstanding: AtomicBool::new(false),
             txn_security_ctx_off: None,
+            oneway_spam_detected,
         }))?)
     }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 1a27b968a907..81649f12758b 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -81,7 +81,7 @@ unsafe impl Send for Task {}
 unsafe impl Sync for Task {}
 
 /// The type of process identifiers (PIDs).
-type Pid = bindings::pid_t;
+pub type Pid = bindings::pid_t;
 
 /// The type of user identifiers (UIDs).
 #[derive(Copy, Clone)]

-- 
2.42.0.820.g83a721a137-goog

