Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99657B4227
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234520AbjI3Qdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234498AbjI3Qda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:33:30 -0400
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 16244C6;
        Sat, 30 Sep 2023 09:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Gj0MA
        5aagPZFzD46nJUbswYyljTBp8VizZmvHaX2u6w=; b=kRqTdMAgow9JhbtlufvyK
        wxPRDJ5XxXxIXeEYRbiet2/R8N1xB0RDhVgSbxqo2pKCHWZQzPgi8Ij1yng+B7ee
        cxxqgcRnUbQEJha0BC3Ly4h98DfQAWuH7Uf/cXtOT20eeJtrZGuH/KpzjgJsYsFa
        pDovvX+tp9XMgYQMcxKUlw=
Received: from localhost.localdomain (unknown [221.12.59.213])
        by zwqz-smtp-mta-g2-1 (Coremail) with SMTP id _____wAXGWW9TRhli6s9Dg--.48336S2;
        Sun, 01 Oct 2023 00:33:02 +0800 (CST)
From:   AllenX <xubo3006@163.com>
To:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Cc:     Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, AllenX <xubo3006@163.com>
Subject: [PATCH 1/2] rust: add Soft-RoCE driver basic structure
Date:   Sun,  1 Oct 2023 00:32:56 +0800
Message-Id: <20230930163256.60779-1-xubo3006@163.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wAXGWW9TRhli6s9Dg--.48336S2
X-Coremail-Antispam: 1Uf129KBjvAXoWfJFy5uFW8Ary8tryxJw4DXFb_yoW8XF45Wo
        Zaqrs7Wwn5tr1xA34xJ343Gr43XrZ8GFs3Xrn5Kws8Crn7trWUC34fCw18XFWDGF18KFy5
        u343JFZYvan5XFn5n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4R0eHJUUUUU
X-Originating-IP: [221.12.59.213]
X-CM-SenderInfo: 50xe0jqqqwqiywtou0bp/1tbiWQD6rlWB07v09AAAsx
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add soft-Roce rxe device net driver basic structure and Rust security abstration interface

This patch add Rust abstration for rdma Soft-RoCE drrivers.
The basic architecture is completed, initialization is implemented and interfaces are set aside. Network driver-related support is currently not perfect, and the specific functions of data frame parsing need to be further implemented.
[PATCH 2/2] is the driver of rdma infiniband mlx4 and also completes a similar basic architecture.

Signed-off-by: Allen Xu <xubo3006@163.com>
---
 rust/bindings/bindings_helper.h |   3 +
 rust/kernel/lib.rs              |   2 +
 rust/kernel/rxe.rs              | 356 ++++++++++++++++++++++++++++++++
 samples/rust/Kconfig            |   7 +
 samples/rust/Makefile           |   1 +
 samples/rust/rust_rxe.rs        |  49 +++++
 6 files changed, 418 insertions(+)
 create mode 100644 rust/kernel/rxe.rs
 create mode 100644 samples/rust/rust_rxe.rs

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 7d9bef6f87..cb63710af1 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -36,6 +36,9 @@
 #include <linux/sysctl.h>
 #include <linux/uaccess.h>
 #include <linux/uio.h>
+#include <net/udp_tunnel.h>
+#include <rdma/rdma_netlink.h>
+#include <rdma/ib_verbs.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index c20b37e88a..39e0b17778 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -80,6 +80,8 @@ mod raw_list;
 pub mod rbtree;
 pub mod unsafe_list;
 
+pub mod rxe;
+
 #[doc(hidden)]
 pub mod module_param;
 
diff --git a/rust/kernel/rxe.rs b/rust/kernel/rxe.rs
new file mode 100644
index 0000000000..4dce98adeb
--- /dev/null
+++ b/rust/kernel/rxe.rs
@@ -0,0 +1,356 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Infiniband soft-Roce devices.
+use alloc::boxed::Box;
+use core::pin::Pin;
+use core::{marker, ptr};
+use macros::vtable;
+
+use crate::error::{code::*, Error, Result};
+use crate::str::CStr;
+use crate::{bindings, pr_err, pr_info};
+
+/// Soft-Roce transport registration.
+///
+pub struct Registration<T: RxeOperation> {
+    registered: bool,
+    #[allow(dead_code)]
+    name: &'static CStr,
+    net_socket: RxeRecvSockets<T>,
+    rxe_link_ops: bindings::rdma_link_ops,
+    phantom: marker::PhantomData<T>,
+}
+
+impl<T: RxeOperation> Registration<T> {
+    /// Creates a new [`Registration`] but does not register it yet.
+    ///
+    /// It is allowed to move.
+    pub fn new(name: &'static CStr) -> Self {
+        // INVARIANT: `registered` is `false`
+        Self {
+            registered: false,
+            name,
+            net_socket: RxeRecvSockets::new(),
+            rxe_link_ops: bindings::rdma_link_ops::default(),
+            phantom: marker::PhantomData,
+        }
+    }
+
+    /// Registers a infiniband soft-Roce device
+    /// Returns a pinned heap-allocated representation of the registration.
+    pub fn new_pinned(name: &'static CStr) -> Result<Pin<Box<Self>>> {
+        let mut r = Pin::from(Box::try_new(Self::new(name))?);
+        r.as_mut().register()?;
+        Ok(r)
+    }
+
+    /// Registers a infiband soft-Roce device with the rest of the kernel.
+    ///
+    /// It must be pinned because the memory block that represents the registration is
+    /// self-referential.
+    pub fn register(self: Pin<&mut Self>) -> Result {
+        // SAFETY: We must ensure that we never move out of 'this'.
+        let this = unsafe { self.get_unchecked_mut() };
+        if this.registered {
+            // Already registered
+            return Err(EINVAL);
+        }
+
+        match this.net_socket.alloc() {
+            Ok(()) => {}
+            Err(e) => return Err(e),
+        }
+
+        this.rxe_link_ops = RxeRdmaLinkTable::<T>::build();
+
+        // SAFETY: The adapter is compatible with the rdma_link_register
+        unsafe {
+            bindings::rdma_link_register(&mut this.rxe_link_ops);
+        }
+
+        this.registered = true;
+        pr_info!("loaded");
+        Ok(())
+    }
+}
+
+impl<T: RxeOperation> Drop for Registration<T> {
+    fn drop(&mut self) {
+        if self.registered {
+            // SAFETY: [`self.rxe_link_ops`] was previously created using RxeRdmaLinkTable::<T>::build()
+            unsafe { bindings::rdma_link_unregister(&mut self.rxe_link_ops) };
+            // SAFETY: unregister ib driver with driver_id bindings::rdma_driver_id_RDMA_DRIVER_RXE
+            unsafe { bindings::ib_unregister_driver(bindings::rdma_driver_id_RDMA_DRIVER_RXE) };
+        }
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl<T: RxeOperation> Sync for Registration<T> {}
+
+/// soft-Roce register net sockets
+pub struct RxeRecvSockets<T: RxeOperation> {
+    sk4: Option<*mut bindings::socket>,
+    sk6: Option<*mut bindings::socket>,
+    rxe_net_notifier: Option<bindings::notifier_block>,
+    phantom: marker::PhantomData<T>,
+}
+
+impl<T: RxeOperation> RxeRecvSockets<T> {
+    /// Create net socket but not init it yet.
+    pub fn new() -> Self {
+        Self {
+            sk4: None,
+            sk6: None,
+            rxe_net_notifier: None,
+            phantom: marker::PhantomData,
+        }
+    }
+
+    /// Init rxe net socket
+    pub fn alloc(&mut self) -> Result<()> {
+        match self.ipv4_init() {
+            Ok(_tmp) => {}
+            Err(e) => return Err(e),
+        }
+
+        match self.ipv6_init() {
+            Ok(_tmp) => {}
+            Err(e) => {
+                self.rxe_net_release();
+                return Err(e);
+            }
+        }
+
+        match self.net_notifier_register() {
+            Ok(_tmp) => {}
+            Err(e) => {
+                self.rxe_net_release();
+                return Err(e);
+            }
+        }
+        Ok(())
+    }
+
+    /// Init ipv4 socket
+    fn ipv4_init(&mut self) -> Result<()> {
+        let mut udp_cfg = bindings::udp_port_cfg::default();
+        let mut tnl_cfg = bindings::udp_tunnel_sock_cfg::default();
+        let mut sock: *mut bindings::socket = ptr::null_mut();
+
+        udp_cfg.family = bindings::AF_INET as u8;
+        udp_cfg.local_udp_port = 46866;
+        // SAFETY: [`bindings::init_net`] and [`udp_cfg`] can be safely passed to [`bindings::udp_sock_create4`]
+        // [`sock`] will be pass to [`self.sk4`] later, it will live at least as long as the module, which is an implicit requirement
+        let err =
+            unsafe { bindings::udp_sock_create4(&mut bindings::init_net, &mut udp_cfg, &mut sock) };
+
+        if err < 0 {
+            pr_err!("Failed to create IPv4 UDP tunnel\n");
+            return Err(Error::from_kernel_errno(err));
+        }
+
+        tnl_cfg.encap_type = 1;
+        tnl_cfg.encap_rcv = RxeUdpEncapRecvFuncTable::<T>::build_func();
+
+        // SAFETY: [`bindings::init_net`] and [`tnl_cfg`] can be safely passed to [`bindings::setup_udp_tunnel_sock`]
+        // [`sock`] will be pass to [`self.sk4`] later, it will live at least as long as the module, which is an implicit requirement
+        unsafe { bindings::setup_udp_tunnel_sock(&mut bindings::init_net, sock, &mut tnl_cfg) }
+        self.sk4 = Some(sock);
+        Ok(())
+    }
+
+    /// if CONFIG_IPV6=y, init ipv6 socket
+    fn ipv6_init(&mut self) -> Result<()> {
+        #[cfg(CONFIG_IPV6)]
+        {
+            let mut udp_cfg = bindings::udp_port_cfg::default();
+            let mut tnl_cfg = bindings::udp_tunnel_sock_cfg::default();
+            let mut sock: *mut bindings::socket = ptr::null_mut();
+
+            udp_cfg.family = bindings::AF_INET6 as u8;
+            udp_cfg.set_ipv6_v6only(1);
+            udp_cfg.local_udp_port = 46866;
+            // SAFETY: [`bindings::init_net`] and [`udp_cfg`] can be safely passed to [`bindings::udp_sock_create4`]
+            // [`sock`] will be pass to [`self.sk6`] later, it will live at least as long as the module, which is an implicit requirement
+            let err = unsafe {
+                bindings::udp_sock_create6(&mut bindings::init_net, &mut udp_cfg, &mut sock)
+            };
+
+            if err < 0 {
+                // EAFNOSUPPORT
+                if err == -97 {
+                    pr_err!("IPv6 is not supported, can not create a UDPv6 socket\n");
+                    return Ok(());
+                } else {
+                    pr_err!("Failed to create IPv6 UDP tunnel\n");
+                    return Err(Error::from_kernel_errno(err));
+                }
+            }
+
+            tnl_cfg.encap_type = 1;
+            tnl_cfg.encap_rcv = RxeUdpEncapRecvFuncTable::<T>::build_func();
+
+            // SAFETY: [`bindings::init_net`] and [`tnl_cfg`] can be safely passed to [`bindings::setup_udp_tunnel_sock`]
+            // [`sock`] will be pass to [`self.sk6`] later, it will live at least as long as the module, which is an implicit requirement
+            unsafe { bindings::setup_udp_tunnel_sock(&mut bindings::init_net, sock, &mut tnl_cfg) }
+            self.sk6 = Some(sock);
+        }
+        Ok(())
+    }
+
+    /// Rxe receive notifier info and handle func
+    fn net_notifier_register(&mut self) -> Result<()> {
+        let err: i32;
+        self.rxe_net_notifier = Some(RxeNotifyFuncTable::<T>::build());
+        // SAFETY: [`self.rxe_net_notifier`] is Some, it was previously created by
+        // RxeNotifyFuncTable::<T>::build().
+        unsafe {
+            err = bindings::register_netdevice_notifier(self.rxe_net_notifier.as_mut().unwrap());
+        }
+        if err != 0 {
+            pr_err!("Failed to register netdev notifier\n");
+            if self.rxe_net_notifier.is_some() {
+                // SAFETY: [`self.rxe_net_notifier`] is Some, it was previously created by
+                // RxeNotifyFuncTable::<T>::build().
+                unsafe {
+                    bindings::unregister_netdevice_notifier(
+                        &mut self.rxe_net_notifier.take().unwrap(),
+                    )
+                };
+            }
+            return Err(Error::from_kernel_errno(err));
+        }
+        Ok(())
+    }
+
+    /// release registered socket when error occur
+    fn rxe_net_release(&mut self) {
+        if self.sk4.is_some() {
+            // SAFETY: [`self.sk4`] is Some, it was previously created in ipv4_init(&mut self).
+            unsafe {
+                bindings::udp_tunnel_sock_release(self.sk4.take().unwrap());
+            }
+        }
+        if self.sk6.is_some() {
+            // SAFETY: [`self.sk6`] is Some, it was previously created in ipv6_init(&mut self).
+            unsafe {
+                bindings::udp_tunnel_sock_release(self.sk6.take().unwrap());
+            }
+        }
+    }
+}
+
+impl<T: RxeOperation> Drop for RxeRecvSockets<T> {
+    /// Removes the registration from the kernel if it has completed successfully before.
+    fn drop(&mut self) {
+        self.rxe_net_release();
+        if self.rxe_net_notifier.is_some() {
+            // SAFETY: [`self.rxe_net_notifier`] is Some, it was previously created by
+            // RxeNotifyFuncTable::<T>::build().
+            unsafe {
+                bindings::unregister_netdevice_notifier(&mut self.rxe_net_notifier.take().unwrap());
+            };
+        }
+    }
+}
+
+// SAFETY: `Registration` does not expose any of its state across threads
+// (it is fine for multiple threads to have a shared reference to it).
+unsafe impl<T: RxeOperation> Sync for RxeRecvSockets<T> {}
+
+/// Implement this trait to complete the function.
+#[vtable]
+pub trait RxeOperation {
+    /// notify() corresponds to the kernel's rxe_notify.
+    fn notify() -> Result;
+    /// newlink() corresponds to the kernel's rxe_newlink.
+    fn newlink() -> Result;
+    /// udp_recv() implement skb reception processing.
+    fn udp_recv() -> Result;
+}
+
+///Build kernel's 'struct notifier_block' type with rxe device operation
+struct RxeNotifyFuncTable<T>(marker::PhantomData<T>);
+
+impl<T: RxeOperation> RxeNotifyFuncTable<T> {
+    /// Builds an instance of [`struct notifier_block`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) fn build() -> bindings::notifier_block {
+        Self::NOTIFYFUNC
+    }
+
+    const NOTIFYFUNC: bindings::notifier_block = bindings::notifier_block {
+        notifier_call: Some(Self::rxe_notify),
+        next: ptr::null_mut(),
+        priority: 0,
+    };
+
+    unsafe extern "C" fn rxe_notify(
+        _not_blk: *mut bindings::notifier_block,
+        _event: core::ffi::c_ulong,
+        _arg: *mut core::ffi::c_void,
+    ) -> core::ffi::c_int {
+        let _ = T::notify();
+        return 0;
+    }
+}
+
+/// Build kernel's 'struct rxe_link_ops' type with rxe device operation
+struct RxeRdmaLinkTable<T>(marker::PhantomData<T>);
+
+impl<T: RxeOperation> RxeRdmaLinkTable<T> {
+    /// Builds an instance of [`struct rxe_link_ops`].
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) fn build() -> bindings::rdma_link_ops {
+        Self::RXELINKFUNC
+    }
+
+    const RXELINKFUNC: bindings::rdma_link_ops = bindings::rdma_link_ops {
+        type_: "rxe".as_ptr() as *const i8,
+        newlink: Some(Self::rxe_newlink),
+        list: bindings::list_head {
+            next: ptr::null_mut(),
+            prev: ptr::null_mut(),
+        },
+    };
+
+    unsafe extern "C" fn rxe_newlink(
+        _ibdev_name: *const core::ffi::c_char,
+        _ndev: *mut bindings::net_device,
+    ) -> core::ffi::c_int {
+        let _ = T::newlink();
+        return 0;
+    }
+}
+
+/// Build kernel's rxe_udp_encap_recv function  
+struct RxeUdpEncapRecvFuncTable<T>(marker::PhantomData<T>);
+
+impl<T: RxeOperation> RxeUdpEncapRecvFuncTable<T> {
+    /// # Safety
+    ///
+    /// The caller must ensure that the adapter is compatible with the way the device is registered.
+    pub(crate) fn build_func() -> Option<
+        unsafe extern "C" fn(
+            sk: *mut bindings::sock,
+            skb: *mut bindings::sk_buff,
+        ) -> core::ffi::c_int,
+    > {
+        Some(Self::rxe_udp_encap_recv)
+    }
+    unsafe extern "C" fn rxe_udp_encap_recv(
+        _sk: *mut bindings::sock,
+        _skb: *mut bindings::sk_buff,
+    ) -> core::ffi::c_int {
+        let _ = T::udp_recv();
+        return 0;
+    }
+}
diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index 189c10ced6..84c68786d9 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -163,4 +163,11 @@ config SAMPLE_RUST_SELFTESTS
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_RXE
+	tristate "Soft-Roce"
+	help
+	  This option builds the self test cases for Rust.
+
+	  If unsure, say N.
+
 endif # SAMPLES_RUST
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 420bcefeb0..56ec1dcee6 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -15,5 +15,6 @@ obj-$(CONFIG_SAMPLE_RUST_NETFILTER)		+= rust_netfilter.o
 obj-$(CONFIG_SAMPLE_RUST_ECHO_SERVER)		+= rust_echo_server.o
 obj-$(CONFIG_SAMPLE_RUST_FS)			+= rust_fs.o
 obj-$(CONFIG_SAMPLE_RUST_SELFTESTS)		+= rust_selftests.o
+obj-$(CONFIG_SAMPLE_RUST_RXE)		+= rust_rxe.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_rxe.rs b/samples/rust/rust_rxe.rs
new file mode 100644
index 0000000000..714d569704
--- /dev/null
+++ b/samples/rust/rust_rxe.rs
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust infiniband Soft-RoCE driver sample.
+
+use kernel::prelude::*;
+use kernel::rxe;
+
+module! {
+    type: RustRxe,
+    name: "rust_rxe",
+    author: "Rust for Linux Contributors",
+    description: "Rust infiniband soft-Roce driver sample",
+    license: "GPL",
+}
+
+struct RustRxeOps;
+
+#[vtable]
+impl rxe::RxeOperation for RustRxeOps {
+    fn notify() -> Result {
+        Ok(())
+    }
+    fn newlink() -> Result {
+        Ok(())
+    }
+    fn udp_recv() -> Result {
+        Ok(())
+    }
+}
+
+struct RustRxe {
+    _dev: Pin<Box<rxe::Registration<RustRxeOps>>>,
+}
+
+impl kernel::Module for RustRxe {
+    fn init(name: &'static CStr, _module: &'static ThisModule) -> Result<Self> {
+        pr_info!("Rust Soft-RoCE driver sample (init)\n");
+
+        Ok(RustRxe {
+            _dev: rxe::Registration::<RustRxeOps>::new_pinned(name)?,
+        })
+    }
+}
+
+impl Drop for RustRxe {
+    fn drop(&mut self) {
+        pr_info!("Rust Soft-RoCE driver sample (exit)\n");
+    }
+}
-- 
2.39.3

