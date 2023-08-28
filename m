Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0215A78ADA9
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbjH1KuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbjH1Kth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:49:37 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED8E191
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:15 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id 4fb4d7f45d1cf-5256fdb3e20so2313222a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693219752; x=1693824552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0XJdlnyIi47TCCt+KqTt48ehUlv6JLaTMbUL33NsVck=;
        b=YNvTVbM0tG6yKGAvcIsOwna9dAWZAPN9ErPdOEZYfV1AEpVv2CPQMzmcyfWIvNsZzr
         ZyKN3AeosmGkVhw+k+V0r7p6SwsemWRPQjjwwuMNI5uT7RV+wKWOcVstaI86fFaG0O7i
         Ibe21ZQNoyUlD/VlWo9cnNdWuOH25OY5P7lnTpSRbozEAQMWJE3QXaIO0BL9EvSxkUqJ
         fmq7xI6w3oY1Tnkgw11FD0gVC14PUO+AyzvVnbwxR+7/X1eLoUWqn4iVUI7/WGsKbXTc
         ipRx+AiL4tuDWKp90mkr49zKZfSLxSHZVT+9Ar5ccHUHzHFKwnxZSkiVJabnCeFkawgo
         +0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693219752; x=1693824552;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0XJdlnyIi47TCCt+KqTt48ehUlv6JLaTMbUL33NsVck=;
        b=LWl6Hs5kdGm1lKpBMUi+jzTzZ0Jbez2ZuOAEZVFd8q0mt53DQvmF++1Cy5cpMOv60H
         ZxJDCwc8yM8qcQmyg4Soiu+oEnfiTpYMZPKmyiwimvjHmxAv9hc1sWWZt1WdtA4Qn54p
         5hpBVAg7KbxLz+zrfuBMH+Ht2Xn/pbeN9yIF/UJ5R2GchYbmxJPRyeAUXV15KalX237U
         b2Jgr+dEXiqVuwUhhUI02MuLagZsq33nT3OfovqCeBTBw8o5FIkIhbtGMVw2nNOdNelu
         f2wfNEFxevtM0+GNHGHfL1EJBaO/EFSadvxW/p0GDT/RktjYDa+1NNUijQHlPWsqHAxP
         QLzQ==
X-Gm-Message-State: AOJu0YwY/cJMUZzgqmLiUnYfWU5HwBwTh+f0PMnXNYbSdixmGrK+VQ/p
        UphR+LuF5DdeD43XmJEXBmmGSBHN2eiVrjI=
X-Google-Smtp-Source: AGHT+IEWj/SM3lFZSJcEmgneHhzK3Sph7jjCA+NIh+h9N/GO8AMcitH7S3lViIuD67WtBwEqrZKWf1Mk9/GJveY=
X-Received: from aliceryhl.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:6c8])
 (user=aliceryhl job=sendgmr) by 2002:a50:d59d:0:b0:521:822e:2f34 with SMTP id
 v29-20020a50d59d000000b00521822e2f34mr471533edi.8.1693219752091; Mon, 28 Aug
 2023 03:49:12 -0700 (PDT)
Date:   Mon, 28 Aug 2023 10:48:04 +0000
In-Reply-To: <20230828104807.1581592-1-aliceryhl@google.com>
Mime-Version: 1.0
References: <20230828104807.1581592-1-aliceryhl@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
Message-ID: <20230828104807.1581592-5-aliceryhl@google.com>
Subject: [PATCH v4 4/7] rust: workqueue: add helper for defining work_struct fields
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
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

The main challenge with defining `work_struct` fields is making sure
that the function pointer stored in the `work_struct` is appropriate for
the work item type it is embedded in. It needs to know the offset of the
`work_struct` field being used (even if there are several!) so that it
can do a `container_of`, and it needs to know the type of the work item
so that it can call into the right user-provided code. All of this needs
to happen in a way that provides a safe API to the user, so that users
of the workqueue cannot mix up the function pointers.

There are three important pieces that are relevant when doing this:

 * The pointer type.
 * The work item struct. This is what the pointer points at.
 * The `work_struct` field. This is a field of the work item struct.

This patch introduces a separate trait for each piece. The pointer type
is given a `WorkItemPointer` trait, which pointer types need to
implement to be usable with the workqueue. This trait will be
implemented for `Arc` and `Box` in a later patch in this patchset.
Implementing this trait is unsafe because this is where the
`container_of` operation happens, but user-code will not need to
implement it themselves.

The work item struct should then implement the `WorkItem` trait. This
trait is where user-code specifies what they want to happen when a work
item is executed. It also specifies what the correct pointer type is.

Finally, to make the work item struct know the offset of its
`work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
implements this trait, then the type declares that, at the given offset,
there is a field of type `Work<T, ID>`. The trait is marked unsafe
because the OFFSET constant must be correct, but we provide an
`impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
The macro expands to something that only compiles if the specified field
really has the type `Work<T>`. It is used like this:

```
struct MyWorkItem {
    work_field: Work<MyWorkItem, 1>,
}

impl_has_work! {
    impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
}
```

Note that since the `Work` type is annotated with an id, you can have
several `work_struct` fields by using a different id for each one.

Co-developed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
v3 -> v4:
 * The helper was changed to take a name argument, and is implemented
   directly.
 * `Work::new` now takes a name argument, and a `new_work!` macro was
   introduced to help call it.
 * Use `core::mem::offset_of` rather than a custom implementation.
 * Fix imports in examples.
 * Dropped Reviewed-bys due to changes.

 rust/helpers.c           |  13 ++
 rust/kernel/lib.rs       |   1 +
 rust/kernel/workqueue.rs | 257 ++++++++++++++++++++++++++++++++++++++-
 scripts/Makefile.build   |   2 +-
 4 files changed, 271 insertions(+), 2 deletions(-)

diff --git a/rust/helpers.c b/rust/helpers.c
index ebd69490127b..45cf9702d4e4 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -29,6 +29,7 @@
 #include <linux/sched/signal.h>
 #include <linux/spinlock.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 __noreturn void rust_helper_BUG(void)
 {
@@ -137,6 +138,18 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+void rust_helper_init_work_with_key(struct work_struct *work, work_func_t func,
+				    bool onstack, const char *name,
+				    struct lock_class_key *key)
+{
+	__init_work(work, onstack);
+	work->data = (atomic_long_t)WORK_DATA_INIT();
+	lockdep_init_map(&work->lockdep_map, name, key, 0);
+	INIT_LIST_HEAD(&work->entry);
+	work->func = func;
+}
+EXPORT_SYMBOL_GPL(rust_helper_init_work_with_key);
+
 /*
  * `bindgen` binds the C `size_t` type as the Rust `usize` type, so we can
  * use it in contexts where Rust expects a `usize` like slice (array) indices.
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b56aaea3de7a..c537d2edb4c8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -16,6 +16,7 @@
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
+#![feature(offset_of)]
 #![feature(ptr_metadata)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 82e3fb19fdaf..da37bfa97211 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -262,7 +262,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
 # Compile Rust sources (.rs)
 # ---------------------------------------------------------------------------
 
-rust_allowed_features := new_uninit
+rust_allowed_features := new_uninit,offset_of
 
 # `--out-dir` is required to avoid temporaries being created by `rustc` in the
 # current working directory, which may be not accessible in the out-of-tree
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 6dbc5b9b3da9..251541f1cd68 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -2,9 +2,42 @@
 
 //! Work queues.
 //!
+//! This file has two components: The raw work item API, and the safe work item API.
+//!
+//! One pattern that is used in both APIs is the `ID` const generic, which exists to allow a single
+//! type to define multiple `work_struct` fields. This is done by choosing an id for each field,
+//! and using that id to specify which field you wish to use. (The actual value doesn't matter, as
+//! long as you use different values for different fields of the same struct.) Since these IDs are
+//! generic, they are used only at compile-time, so they shouldn't exist in the final binary.
+//!
+//! # The raw API
+//!
+//! The raw API consists of the `RawWorkItem` trait, where the work item needs to provide an
+//! arbitrary function that knows how to enqueue the work item. It should usually not be used
+//! directly, but if you want to, you can use it without using the pieces from the safe API.
+//!
+//! # The safe API
+//!
+//! The safe API is used via the `Work` struct and `WorkItem` traits. Furthermore, it also includes
+//! a trait called `WorkItemPointer`, which is usually not used directly by the user.
+//!
+//!  * The `Work` struct is the Rust wrapper for the C `work_struct` type.
+//!  * The `WorkItem` trait is implemented for structs that can be enqueued to a workqueue.
+//!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
+//!    that implements `WorkItem`.
+//!
 //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
 
-use crate::{bindings, types::Opaque};
+use crate::{bindings, prelude::*, sync::LockClassKey, types::Opaque};
+use core::marker::PhantomData;
+
+/// Creates a [`Work`] initialiser with the given name and a newly-created lock class.
+#[macro_export]
+macro_rules! new_work {
+    ($($name:literal)?) => {
+        $crate::workqueue::Work::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
+    };
+}
 
 /// A kernel work queue.
 ///
@@ -108,6 +141,228 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
         F: FnOnce(*mut bindings::work_struct) -> bool;
 }
 
+/// Defines the method that should be called directly when a work item is executed.
+///
+/// This trait is implemented by `Pin<Box<T>>` and `Arc<T>`, and is mainly intended to be
+/// implemented for smart pointer types. For your own structs, you would implement [`WorkItem`]
+/// instead. The `run` method on this trait will usually just perform the appropriate
+/// `container_of` translation and then call into the `run` method from the [`WorkItem`] trait.
+///
+/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
+///
+/// # Safety
+///
+/// Implementers must ensure that [`__enqueue`] uses a `work_struct` initialized with the [`run`]
+/// method of this trait as the function pointer.
+///
+/// [`__enqueue`]: RawWorkItem::__enqueue
+/// [`run`]: WorkItemPointer::run
+pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
+    /// Run this work item.
+    ///
+    /// # Safety
+    ///
+    /// The provided `work_struct` pointer must originate from a previous call to `__enqueue` where
+    /// the `queue_work_on` closure returned true, and the pointer must still be valid.
+    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
+}
+
+/// Defines the method that should be called when this work item is executed.
+///
+/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
+pub trait WorkItem<const ID: u64 = 0> {
+    /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
+    /// `Pin<Box<Self>>`.
+    type Pointer: WorkItemPointer<ID>;
+
+    /// The method that should be called when this work item is executed.
+    fn run(this: Self::Pointer);
+}
+
+/// Links for a work item.
+///
+/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
+/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
+///
+/// Wraps the kernel's C `struct work_struct`.
+///
+/// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
+#[repr(transparent)]
+pub struct Work<T: ?Sized, const ID: u64 = 0> {
+    work: Opaque<bindings::work_struct>,
+    _inner: PhantomData<T>,
+}
+
+// SAFETY: Kernel work items are usable from any thread.
+//
+// We do not need to constrain `T` since the work item does not actually contain a `T`.
+unsafe impl<T: ?Sized, const ID: u64> Send for Work<T, ID> {}
+// SAFETY: Kernel work items are usable from any thread.
+//
+// We do not need to constrain `T` since the work item does not actually contain a `T`.
+unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
+
+impl<T: ?Sized, const ID: u64> Work<T, ID> {
+    /// Creates a new instance of [`Work`].
+    #[inline]
+    #[allow(clippy::new_ret_no_self)]
+    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self>
+    where
+        T: WorkItem<ID>,
+    {
+        // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the work
+        // item function.
+        unsafe {
+            kernel::init::pin_init_from_closure(move |slot| {
+                let slot = Self::raw_get(slot);
+                bindings::init_work_with_key(
+                    slot,
+                    Some(T::Pointer::run),
+                    false,
+                    name.as_char_ptr(),
+                    key.as_ptr(),
+                );
+                Ok(())
+            })
+        }
+    }
+
+    /// Get a pointer to the inner `work_struct`.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must not be dangling and must be properly aligned. (But the memory
+    /// need not be initialized.)
+    #[inline]
+    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
+        // SAFETY: The caller promises that the pointer is aligned and not dangling.
+        //
+        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
+        // the compiler does not complain that the `work` field is unused.
+        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
+    }
+}
+
+/// Declares that a type has a [`Work<T, ID>`] field.
+///
+/// The intended way of using this trait is via the [`impl_has_work!`] macro. You can use the macro
+/// like this:
+///
+/// ```no_run
+/// use kernel::impl_has_work;
+/// use kernel::prelude::*;
+/// use kernel::workqueue::Work;
+///
+/// struct MyWorkItem {
+///     work_field: Work<MyWorkItem, 1>,
+/// }
+///
+/// impl_has_work! {
+///     impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
+/// }
+/// ```
+///
+/// Note that since the `Work` type is annotated with an id, you can have several `work_struct`
+/// fields by using a different id for each one.
+///
+/// # Safety
+///
+/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T, ID>`]. The methods on
+/// this trait must have exactly the behavior that the definitions given below have.
+///
+/// [`Work<T, ID>`]: Work
+/// [`impl_has_work!`]: crate::impl_has_work
+/// [`OFFSET`]: HasWork::OFFSET
+pub unsafe trait HasWork<T, const ID: u64 = 0> {
+    /// The offset of the [`Work<T, ID>`] field.
+    ///
+    /// [`Work<T, ID>`]: Work
+    const OFFSET: usize;
+
+    /// Returns the offset of the [`Work<T, ID>`] field.
+    ///
+    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not Sized.
+    ///
+    /// [`Work<T, ID>`]: Work
+    /// [`OFFSET`]: HasWork::OFFSET
+    #[inline]
+    fn get_work_offset(&self) -> usize {
+        Self::OFFSET
+    }
+
+    /// Returns a pointer to the [`Work<T, ID>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    ///
+    /// [`Work<T, ID>`]: Work
+    #[inline]
+    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
+    }
+
+    /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
+    ///
+    /// # Safety
+    ///
+    /// The pointer must point at a [`Work<T, ID>`] field in a struct of type `Self`.
+    ///
+    /// [`Work<T, ID>`]: Work
+    #[inline]
+    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
+    where
+        Self: Sized,
+    {
+        // SAFETY: The caller promises that the pointer points at a field of the right type in the
+        // right kind of struct.
+        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
+    }
+}
+
+/// Used to safely implement the [`HasWork<T, ID>`] trait.
+///
+/// # Examples
+///
+/// ```
+/// use kernel::impl_has_work;
+/// use kernel::sync::Arc;
+/// use kernel::workqueue::{self, Work};
+///
+/// struct MyStruct {
+///     work_field: Work<MyStruct, 17>,
+/// }
+///
+/// impl_has_work! {
+///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
+/// }
+/// ```
+///
+/// [`HasWork<T, ID>`]: HasWork
+#[macro_export]
+macro_rules! impl_has_work {
+    ($(impl$(<$($implarg:ident),*>)?
+       HasWork<$work_type:ty $(, $id:tt)?>
+       for $self:ident $(<$($selfarg:ident),*>)?
+       { self.$field:ident }
+    )*) => {$(
+        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
+        // type.
+        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self $(<$($selfarg),*>)? {
+            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
+
+            #[inline]
+            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
+                // SAFETY: The caller promises that the pointer is not dangling.
+                unsafe {
+                    ::core::ptr::addr_of_mut!((*ptr).$field)
+                }
+            }
+        }
+    )*};
+}
+
 /// Returns the system work queue (`system_wq`).
 ///
 /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
-- 
2.42.0.rc1.204.g551eb34607-goog

