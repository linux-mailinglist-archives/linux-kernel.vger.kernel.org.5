Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C5478ADB2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjH1KuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbjH1Kte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB52D131
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:12 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-594e8207103so27372917b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693219747; x=1693824547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=AaqyLPzL5DfmrhwAzqi3/i2YCtejTjC09pg/QV+14WA=;
        b=U4MaVzwkZosewmXyZ3UYIlthrKUrCJUozk7U43qdxMkort93XeYnkkKoRVl7isRISs
         LEg67ep1ZhF52aC6Jj9g96aQ1zPkqyMA8j5ZjsTB/it64/5A3/1Z8r2mJL95yaDxx7e1
         cv79JGhr+eXXgX24qbAtiKGAdI5c5g06Ny61nUirdbDy7mWOyxQZwrJJdMw+3a81MfoZ
         SqMrrqZReqLdzF4q2nLWR+PQo5WD9dDfiPur5zgu91Lzns0GIB6GBkBZABNowPHZ/qVc
         a1HuKvP0BNfd0/uEz/hiWOzljI2BXTEIEY+K/yMTPNdDmzE2W0e6Zc3xLFG1qglDxN20
         aG3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219747; x=1693824547;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AaqyLPzL5DfmrhwAzqi3/i2YCtejTjC09pg/QV+14WA=;
        b=Pgc86QbVaUhu8SOB/VPv80idTKV3d7VZTdFM8VMCN0g3eJ8I2qACZIVkmGGjRvdlYx
         /pA1ADQd3oeEI+2h2znhwRMky43gEqlt4MMiC4f8mkB0MkO/G46zRJSEl9FO/Zhh2UY+
         HXJglegGtVnVQB9d/kAlWb6mtIQt2ZRtbDhDDIYCX2ygbl8k6jdn9cAEMC0ZAdIUQ8Il
         VTiNAJ96uAxAQaVa8jHaNaSd+mNfHMcL3TOOLqlfFuVWYAPPfC+n7yk4F+/XYoW0nKXK
         hfXZWTQ4jc8gcTro4cWlZ72M3L2Mpcvru/liyzzqEgz+vem9MjFN2dIp9h+FVYTl36+o
         eN6g==
X-Gm-Message-State: AOJu0YwOxgXwkxtSmsPtipAYkEh2W7avj+sizYEzO31fD/HDDOBy8P7L
        sdIgM/PNzX3hPIneLlN1edPn7UhE+JMgkEY=
X-Google-Smtp-Source: AGHT+IGCZXrcEJml/uFdu2lKN+b3E5c2vxmWIO3DGJceLMsq469NqNCWUWJz9ys0whWTlSmJ/Ji6FpUUxRoqt7M=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a81:ac08:0:b0:583:9ace:cf41 with SMTP id
 k8-20020a81ac08000000b005839acecf41mr759201ywh.0.1693219746901; Mon, 28 Aug
 2023 03:49:06 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:48:02 +0000
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230828104807.1581592-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828104807.1581592-3-aliceryhl@google.com>
Subject: [PATCH v4 2/7] rust: workqueue: add low-level workqueue bindings
From:   Alice Ryhl <aliceryhl@google.com>
To:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        "=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define basic low-level bindings to a kernel workqueue. The API defined
here can only be used unsafely. Later commits will provide safe
wrappers.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
---
v3 -> v4:
 * Update safety comment for Send and Sync impls.
 * Add Reviewed-by for Boqun.

 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/workqueue.rs        | 109 ++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 rust/kernel/workqueue.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 058954961bfc..ca8ac8d8decb 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -11,6 +11,7 @@
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/workqueue.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index abeef423d3a8..b56aaea3de7a 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -44,6 +44,7 @@
 pub mod sync;
 pub mod task;
 pub mod types;
+pub mod workqueue;
 
 #[doc(hidden)]
 pub use bindings;
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
new file mode 100644
index 000000000000..19e5c50127af
--- /dev/null
+++ b/rust/kernel/workqueue.rs
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Work queues.
+//!
+//! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
+
+use crate::{bindings, types::Opaque};
+
+/// A kernel work queue.
+///
+/// Wraps the kernel's C `struct workqueue_struct`.
+///
+/// It allows work items to be queued to run on thread pools managed by the kernel. Several are
+/// always available, for example, `system`, `system_highpri`, `system_long`, etc.
+#[repr(transparent)]
+pub struct Queue(Opaque<bindings::workqueue_struct>);
+
+// SAFETY: Accesses to workqueues used by [`Queue`] are thread-safe.
+unsafe impl Send for Queue {}
+// SAFETY: Accesses to workqueues used by [`Queue`] are thread-safe.
+unsafe impl Sync for Queue {}
+
+impl Queue {
+    /// Use the provided `struct workqueue_struct` with Rust.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the provided raw pointer is not dangling, that it points at a
+    /// valid workqueue, and that it remains valid until the end of 'a.
+    pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
+        // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
+        // caller promises that the pointer is not dangling.
+        unsafe { &*(ptr as *const Queue) }
+    }
+
+    /// Enqueues a work item.
+    ///
+    /// This may fail if the work item is already enqueued in a workqueue.
+    ///
+    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
+    pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
+    where
+        W: RawWorkItem<ID> + Send + 'static,
+    {
+        let queue_ptr = self.0.get();
+
+        // SAFETY: We only return `false` if the `work_struct` is already in a workqueue. The other
+        // `__enqueue` requirements are not relevant since `W` is `Send` and static.
+        //
+        // The call to `bindings::queue_work_on` will dereference the provided raw pointer, which
+        // is ok because `__enqueue` guarantees that the pointer is valid for the duration of this
+        // closure.
+        //
+        // Furthermore, if the C workqueue code accesses the pointer after this call to
+        // `__enqueue`, then the work item was successfully enqueued, and `bindings::queue_work_on`
+        // will have returned true. In this case, `__enqueue` promises that the raw pointer will
+        // stay valid until we call the function pointer in the `work_struct`, so the access is ok.
+        unsafe {
+            w.__enqueue(move |work_ptr| {
+                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
+            })
+        }
+    }
+}
+
+/// A raw work item.
+///
+/// This is the low-level trait that is designed for being as general as possible.
+///
+/// The `ID` parameter to this trait exists so that a single type can provide multiple
+/// implementations of this trait. For example, if a struct has multiple `work_struct` fields, then
+/// you will implement this trait once for each field, using a different id for each field. The
+/// actual value of the id is not important as long as you use different ids for different fields
+/// of the same struct. (Fields of different structs need not use different ids.)
+///
+/// Note that the id is used only to select the right method to call during compilation. It wont be
+/// part of the final executable.
+///
+/// # Safety
+///
+/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by `__enqueue`
+/// remain valid for the duration specified in the guarantees section of the documentation for
+/// `__enqueue`.
+pub unsafe trait RawWorkItem<const ID: u64> {
+    /// The return type of [`Queue::enqueue`].
+    type EnqueueOutput;
+
+    /// Enqueues this work item on a queue using the provided `queue_work_on` method.
+    ///
+    /// # Guarantees
+    ///
+    /// If this method calls the provided closure, then the raw pointer is guaranteed to point at a
+    /// valid `work_struct` for the duration of the call to the closure. If the closure returns
+    /// true, then it is further guaranteed that the pointer remains valid until someone calls the
+    /// function pointer stored in the `work_struct`.
+    ///
+    /// # Safety
+    ///
+    /// The provided closure may only return `false` if the `work_struct` is already in a workqueue.
+    ///
+    /// If the work item type is annotated with any lifetimes, then you must not call the function
+    /// pointer after any such lifetime expires. (Never calling the function pointer is okay.)
+    ///
+    /// If the work item type is not [`Send`], then the function pointer must be called on the same
+    /// thread as the call to `__enqueue`.
+    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
+    where
+        F: FnOnce(*mut bindings::work_struct) -> bool;
+}
-- 
2.42.0.rc1.204.g551eb34607-goog

