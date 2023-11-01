Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8AFD7DE5CF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 19:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344812AbjKASCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344759AbjKASC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 14:02:29 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A55115
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 11:02:22 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-9d2946be350so4293666b.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 11:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698861741; x=1699466541; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QWHuDeEW+muTS4+d83vSpQZhUT21LbllHHwugGQQp2M=;
        b=nUASRUhmngM8h3y6mw/RT7KL+zBn6KCZhfcnq/2CUNPNMATUd6U/jM9mqprvBmjPzO
         5ts5l/20GVyjG6zn6/V6koYlKSt+OGt5EvfmErzXGkkcU/+u4XaFUmHclVilcum2G76W
         1ynkwy06rBtZ0UXDQxA2IHOS5hOJiPes9tsc2zd52XAeVSz+FbKk7LlVWar/Y/T5eUsu
         QyrvNLIg9WSG9jPPvCSzDZcu1o5XsR9AUxd7GEj+pRPRpsIuIWUzv/1hjb72wxOuxIsP
         tx1xyZ2yNobd3gd99E9H6x4JWbgsvf2Xqp0qHUfvhAxeWHCsWIxuHcYG0s+d2cO7AqIp
         m7kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698861741; x=1699466541;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QWHuDeEW+muTS4+d83vSpQZhUT21LbllHHwugGQQp2M=;
        b=BcLO+0UWeuKniwGuXjXL/PXsGBTmeUpz/AhjISZxXYF+vgnLFJiyay1euCSPfwnOzA
         zGhVaqwD3ApRAwawS5XpDhC6bYV/tXP2YiZbJo32J2nK4I4kI8rXD16imzN1//WpgyeC
         F8bN/0Dq3+pjVUOMyi1J1JP7kgd3hprRVVJvbdyIepv0KhsSLqZQ8xoJJjwWOcgSUdz5
         sZ4O+kBp9QZGr8iXvnICSwcHcheJesNmESeVUisoymdXCzscZMheGlCn/mDMgeDdKohH
         ge8bxgLivjg75baRfS94SCrWnr0wE8JhVT7uoaMhcLV3BmLCMM9Zb3Rena3VpX+R7d07
         bv5w==
X-Gm-Message-State: AOJu0YyMfeBY3wfkp1ymsjlzrmfRHSfJwvOqP2gNApIMM2PfysRhLINQ
        fDXLV4yZFKZ6J27+tlUbXXQUPcMUJHt9cfY=
X-Google-Smtp-Source: AGHT+IGUKOpDwIhNxWCjjBEeM7FIsWBdETxrku/TNKqh/wIH66ZN+46B+/bIkX8FX5Na5XsxXsIlBxnrf9dG3pw=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a17:906:e216:b0:9ad:ad95:4b90 with SMTP
 id gf22-20020a170906e21600b009adad954b90mr24091ejb.9.1698861740722; Wed, 01
 Nov 2023 11:02:20 -0700 (PDT)
Date:   Wed, 01 Nov 2023 18:01:32 +0000
In-Reply-To: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
Mime-Version: 1.0
References: <20231101-rust-binder-v1-0-08ba9197f637@google.com>
X-Mailer: b4 0.13-dev-26615
Message-ID: <20231101-rust-binder-v1-2-08ba9197f637@google.com>
Subject: [PATCH RFC 02/20] rust_binder: add binderfs support to Rust binder
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

Add support for accessing the Rust binder driver via binderfs. The
actual binderfs implementation is done entirely in C, and the
`rust_binderfs.c` file is a modified version of `binderfs.c` that is
adjusted to call into the Rust binder driver rather than the C driver.

We have left the binderfs filesystem component in C. Rewriting it in
Rust would be a large amount of work and requires a lot of bindings to
the file system interfaces. Binderfs has not historically had the same
challenges with security and complexity, so rewriting Binderfs seems to
have lower value than the rest of Binder.

We also add code on the Rust side for binderfs to call into. Most of
this is left as stub implementation, with the exception of closing the
file descriptor and the BINDER_VERSION ioctl.

Co-developed-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 drivers/android/Kconfig         |  24 ++
 drivers/android/Makefile        |   1 +
 drivers/android/context.rs      | 144 +++++++
 drivers/android/defs.rs         |  39 ++
 drivers/android/process.rs      | 251 ++++++++++++
 drivers/android/rust_binder.rs  | 196 ++++++++-
 drivers/android/rust_binderfs.c | 866 ++++++++++++++++++++++++++++++++++++++++
 include/linux/rust_binder.h     |  16 +
 include/uapi/linux/magic.h      |   1 +
 rust/bindings/bindings_helper.h |   2 +
 rust/kernel/lib.rs              |   7 +
 scripts/Makefile.build          |   2 +-
 12 files changed, 1547 insertions(+), 2 deletions(-)

diff --git a/drivers/android/Kconfig b/drivers/android/Kconfig
index fcfd25c9a016..82ed6ddabe1a 100644
--- a/drivers/android/Kconfig
+++ b/drivers/android/Kconfig
@@ -36,6 +36,18 @@ config ANDROID_BINDERFS
 	  It can be used to dynamically allocate new binder IPC devices via
 	  ioctls.
 
+config ANDROID_BINDERFS_RUST
+	bool "Android Binderfs filesystem in Rust"
+	depends on ANDROID_BINDER_IPC_RUST
+	default n
+	help
+	  Binderfs is a pseudo-filesystem for the Android Binder IPC driver
+	  which can be mounted per-ipc namespace allowing to run multiple
+	  instances of Android.
+	  Each binderfs mount initially only contains a binder-control device.
+	  It can be used to dynamically allocate new binder IPC devices via
+	  ioctls.
+
 config ANDROID_BINDER_DEVICES
 	string "Android Binder devices"
 	depends on ANDROID_BINDER_IPC
@@ -48,6 +60,18 @@ config ANDROID_BINDER_DEVICES
 	  created. Each binder device has its own context manager, and is
 	  therefore logically separated from the other devices.
 
+config ANDROID_BINDER_DEVICES_RUST
+	string "Android Binder devices in Rust"
+	depends on ANDROID_BINDER_IPC_RUST
+	default "binder,hwbinder,vndbinder"
+	help
+	  Default value for the binder.devices parameter.
+
+	  The binder.devices parameter is a comma-separated list of strings
+	  that specifies the names of the binder device nodes that will be
+	  created. Each binder device has its own context manager, and is
+	  therefore logically separated from the other devices.
+
 config ANDROID_BINDER_IPC_SELFTEST
 	bool "Android Binder IPC Driver Selftest"
 	depends on ANDROID_BINDER_IPC
diff --git a/drivers/android/Makefile b/drivers/android/Makefile
index 6348f75832ca..5c819011aa77 100644
--- a/drivers/android/Makefile
+++ b/drivers/android/Makefile
@@ -5,3 +5,4 @@ obj-$(CONFIG_ANDROID_BINDERFS)		+= binderfs.o
 obj-$(CONFIG_ANDROID_BINDER_IPC)	+= binder.o binder_alloc.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_SELFTEST) += binder_alloc_selftest.o
 obj-$(CONFIG_ANDROID_BINDER_IPC_RUST)	+= rust_binder.o
+obj-$(CONFIG_ANDROID_BINDERFS_RUST)	+= rust_binderfs.o
diff --git a/drivers/android/context.rs b/drivers/android/context.rs
new file mode 100644
index 000000000000..630cb575d3ac
--- /dev/null
+++ b/drivers/android/context.rs
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use kernel::{
+    list::{HasListLinks, List, ListArc, ListArcSafe, ListItem, ListLinks},
+    prelude::*,
+    str::{CStr, CString},
+    sync::{Arc, Mutex},
+};
+
+use crate::process::Process;
+
+// This module defines the global variable containing the list of contexts. Since the
+// `kernel::sync` bindings currently don't support mutexes in globals, we use a temporary
+// workaround.
+//
+// TODO: Once `kernel::sync` has support for mutexes in globals, remove this module.
+mod context_global {
+    use super::ContextList;
+    use core::cell::UnsafeCell;
+    use core::mem::MaybeUninit;
+    use kernel::init::PinInit;
+    use kernel::list::List;
+    use kernel::sync::lock::mutex::{Mutex, MutexBackend};
+    use kernel::sync::lock::Guard;
+
+    /// A temporary wrapper used to define a mutex in a global.
+    pub(crate) struct Contexts {
+        inner: UnsafeCell<MaybeUninit<Mutex<ContextList>>>,
+    }
+
+    impl Contexts {
+        /// Called when the module is initialized.
+        pub(crate) fn init(&self) {
+            // SAFETY: This is only called during initialization of the binder module, so we know
+            // that the global is currently uninitialized and that nobody else is using it yet.
+            unsafe {
+                let ptr = self.inner.get() as *mut Mutex<ContextList>;
+                let init = kernel::new_mutex!(ContextList { list: List::new() }, "ContextList");
+                match init.__pinned_init(ptr) {
+                    Ok(()) => {}
+                    Err(e) => match e {},
+                }
+            }
+        }
+
+        pub(crate) fn lock(&self) -> Guard<'_, ContextList, MutexBackend> {
+            // SAFETY: The `init` method is called during initialization of the binder module, so the
+            // mutex is always initialized when this method is called.
+            unsafe {
+                let ptr = self.inner.get() as *const Mutex<ContextList>;
+                (*ptr).lock()
+            }
+        }
+    }
+
+    unsafe impl Send for Contexts {}
+    unsafe impl Sync for Contexts {}
+
+    pub(crate) static CONTEXTS: Contexts = Contexts {
+        inner: UnsafeCell::new(MaybeUninit::uninit()),
+    };
+}
+
+pub(crate) use self::context_global::CONTEXTS;
+
+pub(crate) struct ContextList {
+    list: List<Context>,
+}
+
+/// This struct keeps track of the processes using this context, and which process is the context
+/// manager.
+struct Manager {
+    all_procs: List<Process>,
+}
+
+/// There is one context per binder file (/dev/binder, /dev/hwbinder, etc)
+#[pin_data]
+pub(crate) struct Context {
+    #[pin]
+    manager: Mutex<Manager>,
+    pub(crate) name: CString,
+    #[pin]
+    links: ListLinks,
+}
+
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<0> for Context { self.links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for Context { untracked; }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<0> for Context {
+        using ListLinks;
+    }
+}
+
+impl Context {
+    pub(crate) fn new(name: &CStr) -> Result<Arc<Self>> {
+        let name = CString::try_from(name)?;
+        let list_ctx = ListArc::pin_init(pin_init!(Context {
+            name,
+            links <- ListLinks::new(),
+            manager <- kernel::new_mutex!(Manager {
+                all_procs: List::new(),
+            }, "Context::manager"),
+        }))?;
+
+        let ctx = list_ctx.clone_arc();
+        CONTEXTS.lock().list.push_back(list_ctx);
+
+        Ok(ctx)
+    }
+
+    /// Called when the file for this context is unlinked.
+    ///
+    /// No-op if called twice.
+    pub(crate) fn deregister(&self) {
+        // SAFETY: We never add the context to any other linked list than this one, so it is either
+        // in this list, or not in any list.
+        unsafe {
+            CONTEXTS.lock().list.remove(self);
+        }
+    }
+
+    pub(crate) fn register_process(self: &Arc<Self>, proc: ListArc<Process>) {
+        if !Arc::ptr_eq(self, &proc.ctx) {
+            pr_err!("Context::register_process called on the wrong context.");
+            return;
+        }
+        self.manager.lock().all_procs.push_back(proc);
+    }
+
+    pub(crate) fn deregister_process(self: &Arc<Self>, proc: &Process) {
+        if !Arc::ptr_eq(self, &proc.ctx) {
+            pr_err!("Context::deregister_process called on the wrong context.");
+            return;
+        }
+        // SAFETY: We just checked that this is the right list.
+        unsafe {
+            self.manager.lock().all_procs.remove(proc);
+        }
+    }
+}
diff --git a/drivers/android/defs.rs b/drivers/android/defs.rs
new file mode 100644
index 000000000000..8fdcb856ccad
--- /dev/null
+++ b/drivers/android/defs.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+use core::ops::{Deref, DerefMut};
+use kernel::{
+    bindings,
+    io_buffer::{ReadableFromBytes, WritableToBytes},
+};
+
+macro_rules! decl_wrapper {
+    ($newname:ident, $wrapped:ty) => {
+        #[derive(Copy, Clone, Default)]
+        #[repr(transparent)]
+        pub(crate) struct $newname($wrapped);
+        // SAFETY: This macro is only used with types where this is ok.
+        unsafe impl ReadableFromBytes for $newname {}
+        unsafe impl WritableToBytes for $newname {}
+        impl Deref for $newname {
+            type Target = $wrapped;
+            fn deref(&self) -> &Self::Target {
+                &self.0
+            }
+        }
+        impl DerefMut for $newname {
+            fn deref_mut(&mut self) -> &mut Self::Target {
+                &mut self.0
+            }
+        }
+    };
+}
+
+decl_wrapper!(BinderVersion, bindings::binder_version);
+
+impl BinderVersion {
+    pub(crate) fn current() -> Self {
+        Self(bindings::binder_version {
+            protocol_version: bindings::BINDER_CURRENT_PROTOCOL_VERSION as _,
+        })
+    }
+}
diff --git a/drivers/android/process.rs b/drivers/android/process.rs
new file mode 100644
index 000000000000..2f16e4cedbf1
--- /dev/null
+++ b/drivers/android/process.rs
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! This module defines the `Process` type, which represents a process using a particular binder
+//! context.
+//!
+//! The `Process` object keeps track of all of the resources that this process owns in the binder
+//! context.
+//!
+//! There is one `Process` object for each binder fd that a process has opened, so processes using
+//! several binder contexts have several `Process` objects. This ensures that the contexts are
+//! fully separated.
+
+use kernel::{
+    bindings,
+    cred::Credential,
+    file::{File, PollTable},
+    io_buffer::IoBufferWriter,
+    list::{HasListLinks, ListArc, ListArcSafe, ListItem, ListLinks},
+    mm,
+    prelude::*,
+    sync::{Arc, ArcBorrow, SpinLock},
+    task::Task,
+    types::ARef,
+    user_ptr::{UserSlicePtr, UserSlicePtrReader},
+    workqueue::{self, Work},
+};
+
+use crate::{context::Context, defs::*};
+
+const PROC_DEFER_FLUSH: u8 = 1;
+const PROC_DEFER_RELEASE: u8 = 2;
+
+/// The fields of `Process` protected by the spinlock.
+pub(crate) struct ProcessInner {
+    is_dead: bool,
+
+    /// Bitmap of deferred work to do.
+    defer_work: u8,
+}
+
+impl ProcessInner {
+    fn new() -> Self {
+        Self {
+            is_dead: false,
+            defer_work: 0,
+        }
+    }
+}
+
+/// A process using binder.
+///
+/// Strictly speaking, there can be multiple of these per process. There is one for each binder fd
+/// that a process has opened, so processes using several binder contexts have several `Process`
+/// objects. This ensures that the contexts are fully separated.
+#[pin_data]
+pub(crate) struct Process {
+    pub(crate) ctx: Arc<Context>,
+
+    // The task leader (process).
+    pub(crate) task: ARef<Task>,
+
+    // Credential associated with file when `Process` is created.
+    pub(crate) cred: ARef<Credential>,
+
+    #[pin]
+    pub(crate) inner: SpinLock<ProcessInner>,
+
+    // Work node for deferred work item.
+    #[pin]
+    defer_work: Work<Process>,
+
+    // Links for process list in Context.
+    #[pin]
+    links: ListLinks,
+}
+
+kernel::impl_has_work! {
+    impl HasWork<Process> for Process { self.defer_work }
+}
+
+kernel::list::impl_has_list_links! {
+    impl HasListLinks<0> for Process { self.links }
+}
+kernel::list::impl_list_arc_safe! {
+    impl ListArcSafe<0> for Process { untracked; }
+}
+kernel::list::impl_list_item! {
+    impl ListItem<0> for Process {
+        using ListLinks;
+    }
+}
+
+impl workqueue::WorkItem for Process {
+    type Pointer = Arc<Process>;
+
+    fn run(me: Arc<Self>) {
+        let defer;
+        {
+            let mut inner = me.inner.lock();
+            defer = inner.defer_work;
+            inner.defer_work = 0;
+        }
+
+        if defer & PROC_DEFER_FLUSH != 0 {
+            me.deferred_flush();
+        }
+        if defer & PROC_DEFER_RELEASE != 0 {
+            me.deferred_release();
+        }
+    }
+}
+
+impl Process {
+    fn new(ctx: Arc<Context>, cred: ARef<Credential>) -> Result<Arc<Self>> {
+        let list_process = ListArc::pin_init(pin_init!(Process {
+            ctx,
+            cred,
+            inner <- kernel::new_spinlock!(ProcessInner::new(), "Process::inner"),
+            task: kernel::current!().group_leader().into(),
+            defer_work <- kernel::new_work!("Process::defer_work"),
+            links <- ListLinks::new(),
+        }))?;
+
+        let process = list_process.clone_arc();
+        process.ctx.register_process(list_process);
+
+        Ok(process)
+    }
+
+    fn version(&self, data: UserSlicePtr) -> Result {
+        data.writer().write(&BinderVersion::current())
+    }
+
+    fn deferred_flush(&self) {
+        // NOOP for now.
+    }
+
+    fn deferred_release(self: Arc<Self>) {
+        self.inner.lock().is_dead = true;
+
+        self.ctx.deregister_process(&self);
+    }
+
+    pub(crate) fn flush(this: ArcBorrow<'_, Process>) -> Result {
+        let should_schedule;
+        {
+            let mut inner = this.inner.lock();
+            should_schedule = inner.defer_work == 0;
+            inner.defer_work |= PROC_DEFER_FLUSH;
+        }
+
+        if should_schedule {
+            // Ignore failures to schedule to the workqueue. Those just mean that we're already
+            // scheduled for execution.
+            let _ = workqueue::system().enqueue(Arc::from(this));
+        }
+        Ok(())
+    }
+}
+
+/// The ioctl handler.
+impl Process {
+    fn write(
+        _this: ArcBorrow<'_, Process>,
+        _file: &File,
+        _cmd: u32,
+        _reader: &mut UserSlicePtrReader,
+    ) -> Result<i32> {
+        Err(EINVAL)
+    }
+
+    fn read_write(
+        this: ArcBorrow<'_, Process>,
+        _file: &File,
+        cmd: u32,
+        data: UserSlicePtr,
+    ) -> Result<i32> {
+        match cmd {
+            bindings::BINDER_VERSION => this.version(data)?,
+            _ => return Err(EINVAL),
+        }
+        Ok(0)
+    }
+}
+
+/// The file operations supported by `Process`.
+impl Process {
+    pub(crate) fn open(ctx: ArcBorrow<'_, Context>, file: &File) -> Result<Arc<Process>> {
+        Self::new(ctx.into(), ARef::from(file.cred()))
+    }
+
+    pub(crate) fn release(this: Arc<Process>, _file: &File) {
+        let should_schedule;
+        {
+            let mut inner = this.inner.lock();
+            should_schedule = inner.defer_work == 0;
+            inner.defer_work |= PROC_DEFER_RELEASE;
+        }
+
+        if should_schedule {
+            // Ignore failures to schedule to the workqueue. Those just mean that we're already
+            // scheduled for execution.
+            let _ = workqueue::system().enqueue(this);
+        }
+    }
+
+    pub(crate) fn ioctl(
+        this: ArcBorrow<'_, Process>,
+        file: &File,
+        cmd: u32,
+        arg: *mut core::ffi::c_void,
+    ) -> Result<i32> {
+        use kernel::ioctl::{_IOC_DIR, _IOC_SIZE};
+        use kernel::uapi::{_IOC_READ, _IOC_WRITE};
+
+        let user_slice = UserSlicePtr::new(arg, _IOC_SIZE(cmd));
+
+        const _IOC_READ_WRITE: u32 = _IOC_READ | _IOC_WRITE;
+
+        match _IOC_DIR(cmd) {
+            _IOC_WRITE => Self::write(this, file, cmd, &mut user_slice.reader()),
+            _IOC_READ_WRITE => Self::read_write(this, file, cmd, user_slice),
+            _ => Err(EINVAL),
+        }
+    }
+
+    pub(crate) fn compat_ioctl(
+        this: ArcBorrow<'_, Process>,
+        file: &File,
+        cmd: u32,
+        arg: *mut core::ffi::c_void,
+    ) -> Result<i32> {
+        Self::ioctl(this, file, cmd, arg)
+    }
+
+    pub(crate) fn mmap(
+        _this: ArcBorrow<'_, Process>,
+        _file: &File,
+        _vma: &mut mm::virt::Area,
+    ) -> Result {
+        Err(EINVAL)
+    }
+
+    pub(crate) fn poll(
+        _this: ArcBorrow<'_, Process>,
+        _file: &File,
+        _table: &mut PollTable,
+    ) -> Result<u32> {
+        Err(EINVAL)
+    }
+}
diff --git a/drivers/android/rust_binder.rs b/drivers/android/rust_binder.rs
index 4b3d6676a9cf..6de2f40846fb 100644
--- a/drivers/android/rust_binder.rs
+++ b/drivers/android/rust_binder.rs
@@ -2,7 +2,19 @@
 
 //! Binder -- the Android IPC mechanism.
 
-use kernel::prelude::*;
+use kernel::{
+    bindings::{self, seq_file},
+    file::{File, PollTable},
+    prelude::*,
+    sync::Arc,
+    types::ForeignOwnable,
+};
+
+use crate::{context::Context, process::Process};
+
+mod context;
+mod defs;
+mod process;
 
 module! {
     type: BinderModule,
@@ -16,6 +28,188 @@ struct BinderModule {}
 
 impl kernel::Module for BinderModule {
     fn init(_module: &'static kernel::ThisModule) -> Result<Self> {
+        crate::context::CONTEXTS.init();
+
+        // SAFETY: The module is being loaded, so we can initialize binderfs.
+        #[cfg(CONFIG_ANDROID_BINDERFS_RUST)]
+        unsafe {
+            kernel::error::to_result(bindings::init_rust_binderfs())?;
+        }
+
         Ok(Self {})
     }
 }
+
+/// Makes the inner type Sync.
+#[repr(transparent)]
+pub struct AssertSync<T>(T);
+// SAFETY: Used only to insert `file_operations` into a global, which is safe.
+unsafe impl<T> Sync for AssertSync<T> {}
+
+/// File operations that rust_binderfs.c can use.
+#[no_mangle]
+#[used]
+pub static rust_binder_fops: AssertSync<kernel::bindings::file_operations> = {
+    // SAFETY: All zeroes is safe for the `file_operations` type.
+    let zeroed_ops = unsafe { core::mem::MaybeUninit::zeroed().assume_init() };
+
+    let ops = kernel::bindings::file_operations {
+        owner: THIS_MODULE.as_ptr(),
+        poll: Some(rust_binder_poll),
+        unlocked_ioctl: Some(rust_binder_unlocked_ioctl),
+        compat_ioctl: Some(rust_binder_compat_ioctl),
+        mmap: Some(rust_binder_mmap),
+        open: Some(rust_binder_open),
+        release: Some(rust_binder_release),
+        mmap_supported_flags: 0,
+        flush: Some(rust_binder_flush),
+        ..zeroed_ops
+    };
+    AssertSync(ops)
+};
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_new_device(
+    name: *const core::ffi::c_char,
+) -> *mut core::ffi::c_void {
+    // SAFETY: The caller will always provide a valid c string here.
+    let name = unsafe { kernel::str::CStr::from_char_ptr(name) };
+    match Context::new(name) {
+        Ok(ctx) => Arc::into_foreign(ctx).cast_mut(),
+        Err(_err) => core::ptr::null_mut(),
+    }
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_remove_device(device: *mut core::ffi::c_void) {
+    if !device.is_null() {
+        // SAFETY: The caller ensures that the `device` pointer came from a previous call to
+        // `rust_binder_new_device`.
+        let ctx = unsafe { Arc::<Context>::from_foreign(device) };
+        ctx.deregister();
+        drop(ctx);
+    }
+}
+
+unsafe extern "C" fn rust_binder_open(
+    inode: *mut bindings::inode,
+    file_ptr: *mut bindings::file,
+) -> core::ffi::c_int {
+    // SAFETY: The `rust_binderfs.c` file ensures that `i_private` is set to the return value of a
+    // successful call to `rust_binder_new_device`.
+    let ctx = unsafe { Arc::<Context>::borrow((*inode).i_private) };
+
+    // SAFETY: The caller provides a valid file pointer to a new `struct file`.
+    let file = unsafe { File::from_ptr(file_ptr) };
+    let process = match Process::open(ctx, file) {
+        Ok(process) => process,
+        Err(err) => return err.to_errno(),
+    };
+    // SAFETY: This file is associated with Rust binder, so we own the `private_data` field.
+    unsafe {
+        (*file_ptr).private_data = process.into_foreign().cast_mut();
+    }
+    0
+}
+
+unsafe extern "C" fn rust_binder_release(
+    _inode: *mut bindings::inode,
+    file: *mut bindings::file,
+) -> core::ffi::c_int {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let process = unsafe { Arc::<Process>::from_foreign((*file).private_data) };
+    // SAFETY: The caller ensures that the file is valid.
+    let file = unsafe { File::from_ptr(file) };
+    Process::release(process, file);
+    0
+}
+
+unsafe extern "C" fn rust_binder_compat_ioctl(
+    file: *mut bindings::file,
+    cmd: core::ffi::c_uint,
+    arg: core::ffi::c_ulong,
+) -> core::ffi::c_long {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
+    // SAFETY: The caller ensures that the file is valid.
+    match Process::compat_ioctl(f, unsafe { File::from_ptr(file) }, cmd as _, arg as _) {
+        Ok(ret) => ret.into(),
+        Err(err) => err.to_errno().into(),
+    }
+}
+
+unsafe extern "C" fn rust_binder_unlocked_ioctl(
+    file: *mut bindings::file,
+    cmd: core::ffi::c_uint,
+    arg: core::ffi::c_ulong,
+) -> core::ffi::c_long {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
+    // SAFETY: The caller ensures that the file is valid.
+    match Process::ioctl(f, unsafe { File::from_ptr(file) }, cmd as _, arg as _) {
+        Ok(ret) => ret.into(),
+        Err(err) => err.to_errno().into(),
+    }
+}
+
+unsafe extern "C" fn rust_binder_mmap(
+    file: *mut bindings::file,
+    vma: *mut bindings::vm_area_struct,
+) -> core::ffi::c_int {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
+    // SAFETY: The caller ensures that the vma is valid.
+    let area = unsafe { kernel::mm::virt::Area::from_ptr_mut(vma) };
+    // SAFETY: The caller ensures that the file is valid.
+    match Process::mmap(f, unsafe { File::from_ptr(file) }, area) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno(),
+    }
+}
+
+unsafe extern "C" fn rust_binder_poll(
+    file: *mut bindings::file,
+    wait: *mut bindings::poll_table_struct,
+) -> bindings::__poll_t {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
+    // SAFETY: The caller ensures that the file is valid.
+    let fileref = unsafe { File::from_ptr(file) };
+    // SAFETY: The caller ensures that the `PollTable` is valid.
+    match Process::poll(f, fileref, unsafe { PollTable::from_ptr(wait) }) {
+        Ok(v) => v,
+        Err(_) => bindings::POLLERR,
+    }
+}
+
+unsafe extern "C" fn rust_binder_flush(
+    file: *mut bindings::file,
+    _id: bindings::fl_owner_t,
+) -> core::ffi::c_int {
+    // SAFETY: We previously set `private_data` in `rust_binder_open`.
+    let f = unsafe { Arc::<Process>::borrow((*file).private_data) };
+    match Process::flush(f) {
+        Ok(()) => 0,
+        Err(err) => err.to_errno(),
+    }
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_stats_show(_: *mut seq_file) -> core::ffi::c_int {
+    0
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_state_show(_: *mut seq_file) -> core::ffi::c_int {
+    0
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_transactions_show(_: *mut seq_file) -> core::ffi::c_int {
+    0
+}
+
+#[no_mangle]
+unsafe extern "C" fn rust_binder_transaction_log_show(_: *mut seq_file) -> core::ffi::c_int {
+    0
+}
diff --git a/drivers/android/rust_binderfs.c b/drivers/android/rust_binderfs.c
new file mode 100644
index 000000000000..2c011e26752c
--- /dev/null
+++ b/drivers/android/rust_binderfs.c
@@ -0,0 +1,866 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/compiler_types.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/fsnotify.h>
+#include <linux/gfp.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/ipc_namespace.h>
+#include <linux/kdev_t.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/namei.h>
+#include <linux/magic.h>
+#include <linux/major.h>
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/mount.h>
+#include <linux/fs_parser.h>
+#include <linux/rust_binder.h>
+#include <linux/sched.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
+#include <linux/spinlock_types.h>
+#include <linux/stddef.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/uaccess.h>
+#include <linux/user_namespace.h>
+#include <linux/xarray.h>
+#include <uapi/asm-generic/errno-base.h>
+#include <uapi/linux/android/binder.h>
+#include <uapi/linux/android/binderfs.h>
+
+#include "binder_internal.h"
+
+#define FIRST_INODE 1
+#define SECOND_INODE 2
+#define INODE_OFFSET 3
+#define BINDERFS_MAX_MINOR (1U << MINORBITS)
+/* Ensure that the initial ipc namespace always has devices available. */
+#define BINDERFS_MAX_MINOR_CAPPED (BINDERFS_MAX_MINOR - 4)
+
+/* === DEFINED IN RUST === */
+extern int rust_binder_stats_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(rust_binder_stats);
+
+extern int rust_binder_state_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(rust_binder_state);
+
+extern int rust_binder_transactions_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(rust_binder_transactions);
+
+extern int rust_binder_transaction_log_show(struct seq_file *m, void *unused);
+DEFINE_SHOW_ATTRIBUTE(rust_binder_transaction_log);
+
+extern const struct file_operations rust_binder_fops;
+extern rust_binder_device rust_binder_new_device(char *name);
+extern void rust_binder_remove_device(rust_binder_device device);
+/* === END DEFINED IN RUST === */
+
+char *rust_binder_devices_param = CONFIG_ANDROID_BINDER_DEVICES_RUST;
+module_param_named(rust_devices, rust_binder_devices_param, charp, 0444);
+
+static dev_t binderfs_dev;
+static DEFINE_MUTEX(binderfs_minors_mutex);
+static DEFINE_IDA(binderfs_minors);
+
+enum binderfs_param {
+	Opt_max,
+	Opt_stats_mode,
+};
+
+enum binderfs_stats_mode {
+	binderfs_stats_mode_unset,
+	binderfs_stats_mode_global,
+};
+
+struct binder_features {
+	bool oneway_spam_detection;
+	bool extended_error;
+};
+
+static const struct constant_table binderfs_param_stats[] = {
+	{ "global", binderfs_stats_mode_global },
+	{}
+};
+
+static const struct fs_parameter_spec binderfs_fs_parameters[] = {
+	fsparam_u32("max",	Opt_max),
+	fsparam_enum("stats",	Opt_stats_mode, binderfs_param_stats),
+	{}
+};
+
+static struct binder_features binder_features = {
+	.oneway_spam_detection = true,
+	.extended_error = true,
+};
+
+static inline struct binderfs_info *BINDERFS_SB(const struct super_block *sb)
+{
+	return sb->s_fs_info;
+}
+
+bool is_rust_binderfs_device(const struct inode *inode)
+{
+	if (inode->i_sb->s_magic == RUST_BINDERFS_SUPER_MAGIC)
+		return true;
+
+	return false;
+}
+
+/**
+ * binderfs_binder_device_create - allocate inode from super block of a
+ *                                 binderfs mount
+ * @ref_inode: inode from wich the super block will be taken
+ * @userp:     buffer to copy information about new device for userspace to
+ * @req:       struct binderfs_device as copied from userspace
+ *
+ * This function allocates a new binder_device and reserves a new minor
+ * number for it.
+ * Minor numbers are limited and tracked globally in binderfs_minors. The
+ * function will stash a struct binder_device for the specific binder
+ * device in i_private of the inode.
+ * It will go on to allocate a new inode from the super block of the
+ * filesystem mount, stash a struct binder_device in its i_private field
+ * and attach a dentry to that inode.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int binderfs_binder_device_create(struct inode *ref_inode,
+					 struct binderfs_device __user *userp,
+					 struct binderfs_device *req)
+{
+	int minor, ret;
+	struct dentry *dentry, *root;
+	rust_binder_device device = NULL;
+	char *name = NULL;
+	size_t name_len;
+	struct inode *inode = NULL;
+	struct super_block *sb = ref_inode->i_sb;
+	struct binderfs_info *info = sb->s_fs_info;
+#if defined(CONFIG_IPC_NS)
+	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
+#else
+	bool use_reserve = true;
+#endif
+
+	/* Reserve new minor number for the new device. */
+	mutex_lock(&binderfs_minors_mutex);
+	if (++info->device_count <= info->mount_opts.max)
+		minor = ida_alloc_max(&binderfs_minors,
+				      use_reserve ? BINDERFS_MAX_MINOR :
+						    BINDERFS_MAX_MINOR_CAPPED,
+				      GFP_KERNEL);
+	else
+		minor = -ENOSPC;
+	if (minor < 0) {
+		--info->device_count;
+		mutex_unlock(&binderfs_minors_mutex);
+		return minor;
+	}
+	mutex_unlock(&binderfs_minors_mutex);
+
+	ret = -ENOMEM;
+	req->name[BINDERFS_MAX_NAME] = '\0'; /* NUL-terminate */
+	name_len = strlen(req->name);
+	/* Make sure to include terminating NUL byte */
+	name = kmemdup(req->name, name_len + 1, GFP_KERNEL);
+	if (!name)
+		goto err;
+
+	device = rust_binder_new_device(name);
+	if (!device)
+		goto err;
+
+	inode = new_inode(sb);
+	if (!inode)
+		goto err;
+
+	inode->i_ino = minor + INODE_OFFSET;
+	simple_inode_init_ts(inode);
+	init_special_inode(inode, S_IFCHR | 0600,
+			   MKDEV(MAJOR(binderfs_dev), minor));
+	inode->i_fop = &rust_binder_fops;
+	inode->i_uid = info->root_uid;
+	inode->i_gid = info->root_gid;
+
+	req->major = MAJOR(binderfs_dev);
+	req->minor = minor;
+
+	if (userp && copy_to_user(userp, req, sizeof(*req))) {
+		ret = -EFAULT;
+		goto err;
+	}
+
+	root = sb->s_root;
+	inode_lock(d_inode(root));
+
+	/* look it up */
+	dentry = lookup_one_len(name, root, name_len);
+	if (IS_ERR(dentry)) {
+		inode_unlock(d_inode(root));
+		ret = PTR_ERR(dentry);
+		goto err;
+	}
+
+	if (d_really_is_positive(dentry)) {
+		/* already exists */
+		dput(dentry);
+		inode_unlock(d_inode(root));
+		ret = -EEXIST;
+		goto err;
+	}
+
+	inode->i_private = device;
+	d_instantiate(dentry, inode);
+	fsnotify_create(root->d_inode, dentry);
+	inode_unlock(d_inode(root));
+
+	return 0;
+
+err:
+	kfree(name);
+	rust_binder_remove_device(device);
+	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
+	ida_free(&binderfs_minors, minor);
+	mutex_unlock(&binderfs_minors_mutex);
+	iput(inode);
+
+	return ret;
+}
+
+/**
+ * binder_ctl_ioctl - handle binder device node allocation requests
+ *
+ * The request handler for the binder-control device. All requests operate on
+ * the binderfs mount the binder-control device resides in:
+ * - BINDER_CTL_ADD
+ *   Allocate a new binder device.
+ *
+ * Return: %0 on success, negative errno on failure.
+ */
+static long binder_ctl_ioctl(struct file *file, unsigned int cmd,
+			     unsigned long arg)
+{
+	int ret = -EINVAL;
+	struct inode *inode = file_inode(file);
+	struct binderfs_device __user *device = (struct binderfs_device __user *)arg;
+	struct binderfs_device device_req;
+
+	switch (cmd) {
+	case BINDER_CTL_ADD:
+		ret = copy_from_user(&device_req, device, sizeof(device_req));
+		if (ret) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = binderfs_binder_device_create(inode, device, &device_req);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void binderfs_evict_inode(struct inode *inode)
+{
+	rust_binder_device device = inode->i_private;
+	struct binderfs_info *info = BINDERFS_SB(inode->i_sb);
+	int minor = inode->i_ino - INODE_OFFSET;
+
+	clear_inode(inode);
+
+	if (!S_ISCHR(inode->i_mode) || !device)
+		return;
+
+	mutex_lock(&binderfs_minors_mutex);
+	--info->device_count;
+	ida_free(&binderfs_minors, minor);
+	mutex_unlock(&binderfs_minors_mutex);
+
+	rust_binder_remove_device(device);
+}
+
+static int binderfs_fs_context_parse_param(struct fs_context *fc,
+					   struct fs_parameter *param)
+{
+	int opt;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct fs_parse_result result;
+
+	opt = fs_parse(fc, binderfs_fs_parameters, param, &result);
+	if (opt < 0)
+		return opt;
+
+	switch (opt) {
+	case Opt_max:
+		if (result.uint_32 > BINDERFS_MAX_MINOR)
+			return invalfc(fc, "Bad value for '%s'", param->key);
+
+		ctx->max = result.uint_32;
+		break;
+	case Opt_stats_mode:
+		if (!capable(CAP_SYS_ADMIN))
+			return -EPERM;
+
+		ctx->stats_mode = result.uint_32;
+		break;
+	default:
+		return invalfc(fc, "Unsupported parameter '%s'", param->key);
+	}
+
+	return 0;
+}
+
+static int binderfs_fs_context_reconfigure(struct fs_context *fc)
+{
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct binderfs_info *info = BINDERFS_SB(fc->root->d_sb);
+
+	if (info->mount_opts.stats_mode != ctx->stats_mode)
+		return invalfc(fc, "Binderfs stats mode cannot be changed during a remount");
+
+	info->mount_opts.stats_mode = ctx->stats_mode;
+	info->mount_opts.max = ctx->max;
+	return 0;
+}
+
+static int binderfs_show_options(struct seq_file *seq, struct dentry *root)
+{
+	struct binderfs_info *info = BINDERFS_SB(root->d_sb);
+
+	if (info->mount_opts.max <= BINDERFS_MAX_MINOR)
+		seq_printf(seq, ",max=%d", info->mount_opts.max);
+
+	switch (info->mount_opts.stats_mode) {
+	case binderfs_stats_mode_unset:
+		break;
+	case binderfs_stats_mode_global:
+		seq_printf(seq, ",stats=global");
+		break;
+	}
+
+	return 0;
+}
+
+static const struct super_operations binderfs_super_ops = {
+	.evict_inode    = binderfs_evict_inode,
+	.show_options	= binderfs_show_options,
+	.statfs         = simple_statfs,
+};
+
+static inline bool is_binderfs_control_device(const struct dentry *dentry)
+{
+	struct binderfs_info *info = dentry->d_sb->s_fs_info;
+
+	return info->control_dentry == dentry;
+}
+
+static int binderfs_rename(struct mnt_idmap *idmap,
+			   struct inode *old_dir, struct dentry *old_dentry,
+			   struct inode *new_dir, struct dentry *new_dentry,
+			   unsigned int flags)
+{
+	if (is_binderfs_control_device(old_dentry) ||
+	    is_binderfs_control_device(new_dentry))
+		return -EPERM;
+
+	return simple_rename(idmap, old_dir, old_dentry, new_dir,
+			     new_dentry, flags);
+}
+
+static int binderfs_unlink(struct inode *dir, struct dentry *dentry)
+{
+	if (is_binderfs_control_device(dentry))
+		return -EPERM;
+
+	return simple_unlink(dir, dentry);
+}
+
+static const struct file_operations binder_ctl_fops = {
+	.owner		= THIS_MODULE,
+	.open		= nonseekable_open,
+	.unlocked_ioctl	= binder_ctl_ioctl,
+	.compat_ioctl	= binder_ctl_ioctl,
+	.llseek		= noop_llseek,
+};
+
+/**
+ * binderfs_binder_ctl_create - create a new binder-control device
+ * @sb: super block of the binderfs mount
+ *
+ * This function creates a new binder-control device node in the binderfs mount
+ * referred to by @sb.
+ *
+ * Return: 0 on success, negative errno on failure
+ */
+static int binderfs_binder_ctl_create(struct super_block *sb)
+{
+	int minor, ret;
+	struct dentry *dentry;
+	struct binder_device *device;
+	struct inode *inode = NULL;
+	struct dentry *root = sb->s_root;
+	struct binderfs_info *info = sb->s_fs_info;
+#if defined(CONFIG_IPC_NS)
+	bool use_reserve = (info->ipc_ns == &init_ipc_ns);
+#else
+	bool use_reserve = true;
+#endif
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device)
+		return -ENOMEM;
+
+	/* If we have already created a binder-control node, return. */
+	if (info->control_dentry) {
+		ret = 0;
+		goto out;
+	}
+
+	ret = -ENOMEM;
+	inode = new_inode(sb);
+	if (!inode)
+		goto out;
+
+	/* Reserve a new minor number for the new device. */
+	mutex_lock(&binderfs_minors_mutex);
+	minor = ida_alloc_max(&binderfs_minors,
+			      use_reserve ? BINDERFS_MAX_MINOR :
+					    BINDERFS_MAX_MINOR_CAPPED,
+			      GFP_KERNEL);
+	mutex_unlock(&binderfs_minors_mutex);
+	if (minor < 0) {
+		ret = minor;
+		goto out;
+	}
+
+	inode->i_ino = SECOND_INODE;
+	simple_inode_init_ts(inode);
+	init_special_inode(inode, S_IFCHR | 0600,
+			   MKDEV(MAJOR(binderfs_dev), minor));
+	inode->i_fop = &binder_ctl_fops;
+	inode->i_uid = info->root_uid;
+	inode->i_gid = info->root_gid;
+
+	refcount_set(&device->ref, 1);
+	device->binderfs_inode = inode;
+	device->miscdev.minor = minor;
+
+	dentry = d_alloc_name(root, "binder-control");
+	if (!dentry)
+		goto out;
+
+	inode->i_private = device;
+	info->control_dentry = dentry;
+	d_add(dentry, inode);
+
+	return 0;
+
+out:
+	kfree(device);
+	iput(inode);
+
+	return ret;
+}
+
+static const struct inode_operations binderfs_dir_inode_operations = {
+	.lookup = simple_lookup,
+	.rename = binderfs_rename,
+	.unlink = binderfs_unlink,
+};
+
+static struct inode *binderfs_make_inode(struct super_block *sb, int mode)
+{
+	struct inode *ret;
+
+	ret = new_inode(sb);
+	if (ret) {
+		ret->i_ino = iunique(sb, BINDERFS_MAX_MINOR + INODE_OFFSET);
+		ret->i_mode = mode;
+		simple_inode_init_ts(ret);
+	}
+	return ret;
+}
+
+static struct dentry *binderfs_create_dentry(struct dentry *parent,
+					     const char *name)
+{
+	struct dentry *dentry;
+
+	dentry = lookup_one_len(name, parent, strlen(name));
+	if (IS_ERR(dentry))
+		return dentry;
+
+	/* Return error if the file/dir already exists. */
+	if (d_really_is_positive(dentry)) {
+		dput(dentry);
+		return ERR_PTR(-EEXIST);
+	}
+
+	return dentry;
+}
+
+void rust_binderfs_remove_file(struct dentry *dentry)
+{
+	struct inode *parent_inode;
+
+	parent_inode = d_inode(dentry->d_parent);
+	inode_lock(parent_inode);
+	if (simple_positive(dentry)) {
+		dget(dentry);
+		simple_unlink(parent_inode, dentry);
+		d_delete(dentry);
+		dput(dentry);
+	}
+	inode_unlock(parent_inode);
+}
+
+struct dentry *rust_binderfs_create_file(struct dentry *parent, const char *name,
+					 const struct file_operations *fops,
+					 void *data)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = d_inode(parent);
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFREG | 0444);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = fops;
+	new_inode->i_private = data;
+	d_instantiate(dentry, new_inode);
+	fsnotify_create(parent_inode, dentry);
+
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static struct dentry *binderfs_create_dir(struct dentry *parent,
+					  const char *name)
+{
+	struct dentry *dentry;
+	struct inode *new_inode, *parent_inode;
+	struct super_block *sb;
+
+	parent_inode = d_inode(parent);
+	inode_lock(parent_inode);
+
+	dentry = binderfs_create_dentry(parent, name);
+	if (IS_ERR(dentry))
+		goto out;
+
+	sb = parent_inode->i_sb;
+	new_inode = binderfs_make_inode(sb, S_IFDIR | 0755);
+	if (!new_inode) {
+		dput(dentry);
+		dentry = ERR_PTR(-ENOMEM);
+		goto out;
+	}
+
+	new_inode->i_fop = &simple_dir_operations;
+	new_inode->i_op = &simple_dir_inode_operations;
+
+	set_nlink(new_inode, 2);
+	d_instantiate(dentry, new_inode);
+	inc_nlink(parent_inode);
+	fsnotify_mkdir(parent_inode, dentry);
+
+out:
+	inode_unlock(parent_inode);
+	return dentry;
+}
+
+static int binder_features_show(struct seq_file *m, void *unused)
+{
+	bool *feature = m->private;
+
+	seq_printf(m, "%d\n", *feature);
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(binder_features);
+
+static int init_binder_features(struct super_block *sb)
+{
+	struct dentry *dentry, *dir;
+
+	dir = binderfs_create_dir(sb->s_root, "features");
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	dentry = rust_binderfs_create_file(dir, "oneway_spam_detection",
+				      &binder_features_fops,
+				      &binder_features.oneway_spam_detection);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	dentry = rust_binderfs_create_file(dir, "extended_error",
+				      &binder_features_fops,
+				      &binder_features.extended_error);
+	if (IS_ERR(dentry))
+		return PTR_ERR(dentry);
+
+	return 0;
+}
+
+static int init_binder_logs(struct super_block *sb)
+{
+	struct dentry *binder_logs_root_dir, *dentry, *proc_log_dir;
+	struct binderfs_info *info;
+	int ret = 0;
+
+	binder_logs_root_dir = binderfs_create_dir(sb->s_root,
+						   "binder_logs");
+	if (IS_ERR(binder_logs_root_dir)) {
+		ret = PTR_ERR(binder_logs_root_dir);
+		goto out;
+	}
+
+	dentry = rust_binderfs_create_file(binder_logs_root_dir, "stats",
+				      &rust_binder_stats_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = rust_binderfs_create_file(binder_logs_root_dir, "state",
+				      &rust_binder_state_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = rust_binderfs_create_file(binder_logs_root_dir, "transactions",
+				      &rust_binder_transactions_fops, NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = rust_binderfs_create_file(binder_logs_root_dir,
+				      "transaction_log",
+				      &rust_binder_transaction_log_fops,
+				      NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	dentry = rust_binderfs_create_file(binder_logs_root_dir,
+				      "failed_transaction_log",
+				      &rust_binder_transaction_log_fops,
+				      NULL);
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto out;
+	}
+
+	proc_log_dir = binderfs_create_dir(binder_logs_root_dir, "proc");
+	if (IS_ERR(proc_log_dir)) {
+		ret = PTR_ERR(proc_log_dir);
+		goto out;
+	}
+	info = sb->s_fs_info;
+	info->proc_log_dir = proc_log_dir;
+
+out:
+	return ret;
+}
+
+static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
+{
+	int ret;
+	struct binderfs_info *info;
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+	struct inode *inode = NULL;
+	struct binderfs_device device_info = {};
+	const char *name;
+	size_t len;
+
+	sb->s_blocksize = PAGE_SIZE;
+	sb->s_blocksize_bits = PAGE_SHIFT;
+
+	/*
+	 * The binderfs filesystem can be mounted by userns root in a
+	 * non-initial userns. By default such mounts have the SB_I_NODEV flag
+	 * set in s_iflags to prevent security issues where userns root can
+	 * just create random device nodes via mknod() since it owns the
+	 * filesystem mount. But binderfs does not allow to create any files
+	 * including devices nodes. The only way to create binder devices nodes
+	 * is through the binder-control device which userns root is explicitly
+	 * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
+	 * necessary and safe.
+	 */
+	sb->s_iflags &= ~SB_I_NODEV;
+	sb->s_iflags |= SB_I_NOEXEC;
+	sb->s_magic = RUST_BINDERFS_SUPER_MAGIC;
+	sb->s_op = &binderfs_super_ops;
+	sb->s_time_gran = 1;
+
+	sb->s_fs_info = kzalloc(sizeof(struct binderfs_info), GFP_KERNEL);
+	if (!sb->s_fs_info)
+		return -ENOMEM;
+	info = sb->s_fs_info;
+
+	info->ipc_ns = get_ipc_ns(current->nsproxy->ipc_ns);
+
+	info->root_gid = make_kgid(sb->s_user_ns, 0);
+	if (!gid_valid(info->root_gid))
+		info->root_gid = GLOBAL_ROOT_GID;
+	info->root_uid = make_kuid(sb->s_user_ns, 0);
+	if (!uid_valid(info->root_uid))
+		info->root_uid = GLOBAL_ROOT_UID;
+	info->mount_opts.max = ctx->max;
+	info->mount_opts.stats_mode = ctx->stats_mode;
+
+	inode = new_inode(sb);
+	if (!inode)
+		return -ENOMEM;
+
+	inode->i_ino = FIRST_INODE;
+	inode->i_fop = &simple_dir_operations;
+	inode->i_mode = S_IFDIR | 0755;
+	simple_inode_init_ts(inode);
+	inode->i_op = &binderfs_dir_inode_operations;
+	set_nlink(inode, 2);
+
+	sb->s_root = d_make_root(inode);
+	if (!sb->s_root)
+		return -ENOMEM;
+
+	ret = binderfs_binder_ctl_create(sb);
+	if (ret)
+		return ret;
+
+	name = rust_binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		strscpy(device_info.name, name, len + 1);
+		ret = binderfs_binder_device_create(inode, NULL, &device_info);
+		if (ret)
+			return ret;
+		name += len;
+		if (*name == ',')
+			name++;
+	}
+
+	ret = init_binder_features(sb);
+	if (ret)
+		return ret;
+
+	if (info->mount_opts.stats_mode == binderfs_stats_mode_global)
+		return init_binder_logs(sb);
+
+	return 0;
+}
+
+static int binderfs_fs_context_get_tree(struct fs_context *fc)
+{
+	return get_tree_nodev(fc, binderfs_fill_super);
+}
+
+static void binderfs_fs_context_free(struct fs_context *fc)
+{
+	struct binderfs_mount_opts *ctx = fc->fs_private;
+
+	kfree(ctx);
+}
+
+static const struct fs_context_operations binderfs_fs_context_ops = {
+	.free		= binderfs_fs_context_free,
+	.get_tree	= binderfs_fs_context_get_tree,
+	.parse_param	= binderfs_fs_context_parse_param,
+	.reconfigure	= binderfs_fs_context_reconfigure,
+};
+
+static int binderfs_init_fs_context(struct fs_context *fc)
+{
+	struct binderfs_mount_opts *ctx;
+
+	ctx = kzalloc(sizeof(struct binderfs_mount_opts), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->max = BINDERFS_MAX_MINOR;
+	ctx->stats_mode = binderfs_stats_mode_unset;
+
+	fc->fs_private = ctx;
+	fc->ops = &binderfs_fs_context_ops;
+
+	return 0;
+}
+
+static void binderfs_kill_super(struct super_block *sb)
+{
+	struct binderfs_info *info = sb->s_fs_info;
+
+	/*
+	 * During inode eviction struct binderfs_info is needed.
+	 * So first wipe the super_block then free struct binderfs_info.
+	 */
+	kill_litter_super(sb);
+
+	if (info && info->ipc_ns)
+		put_ipc_ns(info->ipc_ns);
+
+	kfree(info);
+}
+
+static struct file_system_type binder_fs_type = {
+	.name			= "binder",
+	.init_fs_context	= binderfs_init_fs_context,
+	.parameters		= binderfs_fs_parameters,
+	.kill_sb		= binderfs_kill_super,
+	.fs_flags		= FS_USERNS_MOUNT,
+};
+
+int init_rust_binderfs(void)
+{
+	int ret;
+	const char *name;
+	size_t len;
+
+	/* Verify that the default binderfs device names are valid. */
+	name = rust_binder_devices_param;
+	for (len = strcspn(name, ","); len > 0; len = strcspn(name, ",")) {
+		if (len > BINDERFS_MAX_NAME)
+			return -E2BIG;
+		name += len;
+		if (*name == ',')
+			name++;
+	}
+
+	/* Allocate new major number for binderfs. */
+	ret = alloc_chrdev_region(&binderfs_dev, 0, BINDERFS_MAX_MINOR,
+				  "rust_binder");
+	if (ret)
+		return ret;
+
+	ret = register_filesystem(&binder_fs_type);
+	if (ret) {
+		unregister_chrdev_region(binderfs_dev, BINDERFS_MAX_MINOR);
+		return ret;
+	}
+
+	return ret;
+}
diff --git a/include/linux/rust_binder.h b/include/linux/rust_binder.h
new file mode 100644
index 000000000000..1e44a0a5f6a1
--- /dev/null
+++ b/include/linux/rust_binder.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_RUST_BINDER_H
+#define _LINUX_RUST_BINDER_H
+
+#include <uapi/linux/android/binderfs.h>
+
+/*
+ * This typedef is used for Rust binder driver instances. The driver object is
+ * completely opaque from C and can only be accessed via calls into Rust, so we
+ * use a typedef.
+ */
+typedef void *rust_binder_device;
+
+int init_rust_binderfs(void);
+
+#endif
diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h
index 6325d1d0e90f..e5a20c1498af 100644
--- a/include/uapi/linux/magic.h
+++ b/include/uapi/linux/magic.h
@@ -82,6 +82,7 @@
 #define BINFMTFS_MAGIC          0x42494e4d
 #define DEVPTS_SUPER_MAGIC	0x1cd1
 #define BINDERFS_SUPER_MAGIC	0x6c6f6f70
+#define RUST_BINDERFS_SUPER_MAGIC	0x6c6f6f71
 #define FUTEXFS_SUPER_MAGIC	0xBAD1DEA
 #define PIPEFS_MAGIC            0x50495045
 #define PROC_SUPER_MAGIC	0x9fa0
diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 00a66666f00a..ffeea312f2fd 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -17,11 +17,13 @@
 #include <linux/security.h>
 #include <linux/slab.h>
 #include <linux/refcount.h>
+#include <linux/rust_binder.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
 #include <linux/task_work.h>
 #include <linux/workqueue.h>
 #include <uapi/linux/android/binder.h>
+#include <uapi/linux/android/binderfs.h>
 
 /* `bindgen` gets confused at certain things. */
 const size_t BINDINGS_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 435d4c2ac5fc..f4d58da9202e 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -99,6 +99,13 @@ impl ThisModule {
     pub const unsafe fn from_ptr(ptr: *mut bindings::module) -> ThisModule {
         ThisModule(ptr)
     }
+
+    /// Access the raw pointer for this module.
+    ///
+    /// It is up to the user to use it correctly.
+    pub const fn as_ptr(&self) -> *mut bindings::module {
+        self.0
+    }
 }
 
 #[cfg(not(any(testlib, test)))]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index da37bfa97211..f78d2e75a795 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -262,7 +262,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit,offset_of
+rust_allowed_features := const_maybe_uninit_zeroed,new_uninit,offset_of
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree

-- 
2.42.0.820.g83a721a137-goog

