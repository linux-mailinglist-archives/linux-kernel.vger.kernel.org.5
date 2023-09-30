Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822F17B4206
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbjI3QQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjI3QQY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:16:24 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E2D0FBA;
        Sat, 30 Sep 2023 09:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=hOXob
        ZwzCwV2q4+KSYLgaCkiH/4ph/cOP7eBbXprNpI=; b=TqWuiTFpW32p10/UQTlwr
        oZF5xAf6r7iGuKcky299HBI1GNJvssXON+UFFpuALo0tItLK6VyFWpleqiXjF5OZ
        GRmKpE+xP9GJIpZsIIYG5meD4Eh4oFpbTgNpBbiohKJUUoOucxPZoxMFAn4tk7Ru
        Ua7FsRALdiDzTf9x/cVEy0=
Received: from localhost.localdomain (unknown [221.12.59.213])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wAXTT+rSRhlQrg8Dg--.48618S3;
        Sun, 01 Oct 2023 00:15:45 +0800 (CST)
From:   AllenX <xubo3006@163.com>
To:     rust-for-linux@vger.kernel.org, ojeda@kernel.org
Cc:     alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
        gary@garyguo.net, bjorn3_gh@protonmail.com,
        linux-kernel@vger.kernel.org, AllenX <xubo3006@163.com>
Subject: [PATCH 2/2] rust: add infiniband mlx4 driver basic structure
Date:   Sun,  1 Oct 2023 00:14:43 +0800
Message-Id: <20230930161443.58812-2-xubo3006@163.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230930161443.58812-1-xubo3006@163.com>
References: <20230930161443.58812-1-xubo3006@163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXTT+rSRhlQrg8Dg--.48618S3
X-Coremail-Antispam: 1Uf129KBjvJXoW3ZrWUArWftFyUuF47Xw4Dtwb_yoWkGF47pr
        4kG3yrK397tF4xXayjqFW8WFySgw4xWa13Crs7Aw4ftw4jgFWYgF48trW2yrWUArZ5X34a
        qFWq93yakws5Xw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRjNt3UUUUU=
X-Originating-IP: [221.12.59.213]
X-CM-SenderInfo: 50xe0jqqqwqiywtou0bp/1tbiWRb6rlWB07vPRQAAst
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add infiniband mlx4 device net driver basic structure and Rust security abstration interface

Signed-off-by: Allen Xu <xubo3006@163.com>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/lib.rs              |   1 +
 rust/kernel/mlx4.rs             | 288 ++++++++++++++++++++++++++++++++
 rust/kernel/workqueue.rs        |   9 +-
 samples/rust/Kconfig            |   7 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_mlx4.rs       |  49 ++++++
 7 files changed, 353 insertions(+), 3 deletions(-)
 create mode 100644 rust/kernel/mlx4.rs
 create mode 100644 samples/rust/rust_mlx4.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index cb63710af1..c9b794a3d3 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -39,6 +39,7 @@
 #include <net/udp_tunnel.h>
 #include <rdma/rdma_netlink.h>
 #include <rdma/ib_verbs.h>
+#include <linux/mlx4/driver.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 39e0b17778..60f83427d8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -80,6 +80,7 @@ mod raw_list;
 pub mod rbtree;
 pub mod unsafe_list;
 
+pub mod mlx4;
 pub mod rxe;
 
 #[doc(hidden)]
diff --git a/rust/kernel/mlx4.rs b/rust/kernel/mlx4.rs
new file mode 100644
index 0000000000..7f53e0e9e6
--- /dev/null
+++ b/rust/kernel/mlx4.rs
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Infiniband mlx4 devices.
+//!
+
+use alloc::boxed::Box;
+use core::pin::Pin;
+use core::{marker, ptr};
+use macros::vtable;
+
+use crate::bindings;
+use crate::error::{code::*, Result};
+use crate::str::CStr;
+use crate::workqueue::{BoxedQueue, Queue};
+
+/// Infiband mlx4 device registration.
+///
+pub struct Registration<T: Mlx4Operation> {
+    registered: bool,
+    #[allow(dead_code)]
+    name: &'static CStr,
+    wq: Mlx4WorkQueue,
+    cm_wq: CmWorkQueue,
+    qp_wq: QpWorkQueue,
+    mcg_wq: McgWorkQueue,
+    phantom: marker::PhantomData<T>,
+}
+
+impl<T: Mlx4Operation> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new(name: &'static CStr) -> Self {
+        // INVARIANT: `registered` is `false`
+        Self {
+            registered: false,
+            name,
+            wq: Mlx4WorkQueue::new(),
+            cm_wq: CmWorkQueue::new(),
+            qp_wq: QpWorkQueue::new(),
+            mcg_wq: McgWorkQueue::new(),
+            phantom: marker::PhantomData,
+        }
+    }
+
+    /// Registers a infiband mlx4 device.
+    ///
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned(name: &'static CStr) -> Result<Pin<Box<Self>>> {
+        let mut r = Pin::from(Box::try_new(Self::new(name))?);
+        r.as_mut().register()?;
+        Ok(r)
+    }
+
+    // Registers a infiband mlx4 device with the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential.
+    pub fn register(self: Pin<&mut Self>) -> Result {
+        // SAFETY: We must ensure that we never move out of `this`.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered.
+            return Err(EINVAL);
+        }
+
+        match this.wq.init() {
+            Ok(()) => {}
+            Err(e) => return Err(e),
+        }
+
+        match this.qp_wq.init() {
+            Ok(()) => {}
+            Err(e) => {
+                this.wq.clean();
+                return Err(e);
+            }
+        }
+
+        match this.cm_wq.init() {
+            Ok(()) => {}
+            Err(e) => {
+                this.wq.clean();
+                this.qp_wq.clean();
+                return Err(e);
+            }
+        }
+
+        match this.mcg_wq.init() {
+            Ok(()) => {}
+            Err(e) => {
+                this.wq.clean();
+                this.cm_wq.clean();
+                this.qp_wq.clean();
+                return Err(e);
+            }
+        }
+
+        // SAFETY: The adapter is compatible with the mlx4 register
+        unsafe {
+            bindings::mlx4_register_interface(Mlx4OperationTable::<T>::build());
+        }
+
+        this.registered = true;
+        Ok(())
+    }
+}
+
+impl<T: Mlx4Operation> Drop for Registration<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        if self.registered {
+            self.mcg_wq.clean();
+            self.cm_wq.clean();
+            self.qp_wq.clean();
+            self.wq.clean();
+        }
+    }
+}
+
+/// Build kernel's `struct mlx4_interface` type with mlx4 device operation.
+pub struct Mlx4OperationTable<T>(marker::PhantomData<T>);
+
+impl<T: Mlx4Operation> Mlx4OperationTable<T> {
+    /// Builds an instance of [`struct mlx4_interface`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub fn build() -> *mut bindings::mlx4_interface {
+        return &mut bindings::mlx4_interface {
+            add: Some(Self::add_callback),
+            remove: Some(Self::remove_callback),
+            event: Some(Self::event_callback),
+            get_dev: None,
+            activate: None,
+            list: bindings::list_head {
+                next: ptr::null_mut(),
+                prev: ptr::null_mut(),
+            },
+            // MLX4_PROT_IB_IPV6
+            protocol: 0,
+            // MLX4_INTFF_BONDING
+            flags: 1,
+        };
+    }
+
+    unsafe extern "C" fn add_callback(_dev: *mut bindings::mlx4_dev) -> *mut core::ffi::c_void {
+        let _ = T::add();
+        return ptr::null_mut();
+    }
+
+    unsafe extern "C" fn remove_callback(
+        _dev: *mut bindings::mlx4_dev,
+        _context: *mut core::ffi::c_void,
+    ) {
+        let _ = T::remove();
+    }
+
+    unsafe extern "C" fn event_callback(
+        _dev: *mut bindings::mlx4_dev,
+        _context: *mut core::ffi::c_void,
+        _event: bindings::mlx4_dev_event,
+        _param: core::ffi::c_ulong,
+    ) {
+        let _ = T::event();
+    }
+}
+
+/// Corresponds to the kernel's `struct mlx4_interface`.
+///
+/// You implement this trait whenever you would create a `struct mlx4_interface`.
+#[vtable]
+pub trait Mlx4Operation {
+    /// Add a new mlx4 ib device.
+    fn add() -> Result;
+    /// Remove mlx4 ib device.
+    fn remove() -> Result;
+    /// Respond to specific mlx4 ib device event
+    fn event() -> Result;
+}
+
+pub(crate) struct Mlx4WorkQueue {
+    wq: Option<BoxedQueue>,
+}
+
+impl Mlx4WorkQueue {
+    pub(crate) fn new() -> Self {
+        Self { wq: None }
+    }
+
+    pub(crate) fn init(&mut self) -> Result {
+        let wq_tmp = Queue::try_new(format_args!("mlx4_ib"), 655369, 1);
+        self.wq = match wq_tmp {
+            Ok(wq) => Some(wq),
+            Err(e) => return Err(e),
+        };
+
+        Ok(())
+    }
+
+    pub(crate) fn clean(&mut self) {
+        if self.wq.is_some() {
+            drop(self.wq.take().unwrap());
+        }
+    }
+}
+
+pub(crate) struct CmWorkQueue {
+    cm_wq: Option<BoxedQueue>,
+}
+
+impl CmWorkQueue {
+    pub(crate) fn new() -> Self {
+        Self { cm_wq: None }
+    }
+
+    pub(crate) fn init(&mut self) -> Result {
+        let cm_wq_tmp = Queue::try_new(format_args!("mlx4_ib_cm"), 0, 0);
+        self.cm_wq = match cm_wq_tmp {
+            Ok(cm_wq) => Some(cm_wq),
+            Err(e) => return Err(e),
+        };
+
+        Ok(())
+    }
+
+    pub(crate) fn clean(&mut self) {
+        if self.cm_wq.is_some() {
+            drop(self.cm_wq.take().unwrap());
+        }
+    }
+}
+
+pub(crate) struct McgWorkQueue {
+    clean_wq: Option<BoxedQueue>,
+}
+
+impl McgWorkQueue {
+    pub(crate) fn new() -> Self {
+        Self { clean_wq: None }
+    }
+
+    pub(crate) fn init(&mut self) -> Result {
+        let clean_wq_tmp = Queue::try_new(format_args!("mlx4_ib_mcg"), 655369, 1);
+        self.clean_wq = match clean_wq_tmp {
+            Ok(clean_wq) => Some(clean_wq),
+            Err(e) => return Err(e),
+        };
+
+        Ok(())
+    }
+
+    pub(crate) fn clean(&mut self) {
+        if self.clean_wq.is_some() {
+            drop(self.clean_wq.take().unwrap());
+        }
+    }
+}
+
+pub(crate) struct QpWorkQueue {
+    mlx4_ib_qp_event_wq: Option<BoxedQueue>,
+}
+
+impl QpWorkQueue {
+    pub(crate) fn new() -> Self {
+        Self {
+            mlx4_ib_qp_event_wq: None,
+        }
+    }
+
+    pub(crate) fn init(&mut self) -> Result {
+        let mlx4_ib_qp_event_wq_tmp =
+            Queue::try_new(format_args!("mlx4_ib_qp_event_wq"), 655361, 1);
+        self.mlx4_ib_qp_event_wq = match mlx4_ib_qp_event_wq_tmp {
+            Ok(mlx4_ib_qp_event_wq) => Some(mlx4_ib_qp_event_wq),
+            Err(e) => return Err(e),
+        };
+
+        Ok(())
+    }
+
+    pub(crate) fn clean(&mut self) {
+        if self.mlx4_ib_qp_event_wq.is_some() {
+            drop(self.mlx4_ib_qp_event_wq.take().unwrap());
+        }
+    }
+}
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index d87dfe4156..fa289af097 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -209,14 +209,14 @@ impl Queue {
     ///
     /// Callers should first consider using one of the existing ones (e.g. [`system`]) before
     /// deciding to create a new one.
-    pub fn try_new(name: fmt::Arguments<'_>) -> Result<BoxedQueue> {
+    pub fn try_new(name: fmt::Arguments<'_>, flags: u32, max_active: i32) -> Result<BoxedQueue> {
         // SAFETY: We use a format string that requires an `fmt::Arguments` pointer as the first
         // and only argument.
         let ptr = unsafe {
             bindings::alloc_workqueue(
                 c_str!("%pA").as_char_ptr(),
-                0,
-                0,
+                flags,
+                max_active,
                 &name as *const _ as *const core::ffi::c_void,
             )
         };
@@ -408,6 +408,9 @@ pub struct BoxedQueue {
     ptr: NonNull<Queue>,
 }
 
+// SAFETY: Kernel workqueues are usable from any thread.
+unsafe impl Sync for BoxedQueue {}
+
 impl BoxedQueue {
     /// Creates a new instance of [`BoxedQueue`].
     ///
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 84c68786d9..07b7e2e6e2 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -170,4 +170,11 @@ config SAMPLE_RUST_RXE
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_MLX4
+	tristate "infiniband mlx4"
+	help
+	  This option builds the infiniband mlx4 driver cases for Rust.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 56ec1dcee6..c6617394db 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -16,5 +16,6 @@ obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)		+= rust_echo_server.o
 obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
 obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
 obj-$(CONFIG_SAMPLE_RUST_RXE)		+= rust_rxe.o
+obj-$(CONFIG_SAMPLE_RUST_MLX4)			+= rust_mlx4.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_mlx4.rs b/samples/rust/rust_mlx4.rs
new file mode 100644
index 0000000000..280838071e
--- /dev/null
+++ b/samples/rust/rust_mlx4.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust infiniband mls4 device sample.
+
+use kernel::mlx4;
+use kernel::prelude::*;
+
+module! {
+    type: RustMlx4,
+    name: "rust_mlx4",
+    author: "Rust for Linux Contributors",
+    description: "Rust infiniband mlx4 device sample",
+    license: "GPL",
+}
+
+struct RustMlx4Ops;
+
+#[vtable]
+impl mlx4::Mlx4Operation for RustMlx4Ops {
+    fn add() -> Result {
+        Ok(())
+    }
+    fn remove() -> Result {
+        Ok(())
+    }
+    fn event() -> Result {
+        Ok(())
+    }
+}
+
+struct RustMlx4 {
+    _dev: Pin<Box<mlx4::Registration<RustMlx4Ops>>>,
+}
+
+impl kernel::Module for RustMlx4 {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust infiniband mlx4 driver sample (init)\n");
+
+        Ok(RustMlx4 {
+            _dev: mlx4::Registration::new_pinned(name)?,
+        })
+    }
+}
+
+impl Drop for RustMlx4 {
+    fn drop(&mut self) {
+        pr_info!("Rust infiniband mlx4 driver sample (exit)\n");
+    }
+}
-- 
2.39.3

