Return-Path: <linux-kernel+bounces-19721-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 352608271D8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:51:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC695283FDD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 14:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D14524AD;
	Mon,  8 Jan 2024 14:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f6SSQ91L"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E327E51C3D
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbeac1f5045so2322317276.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jan 2024 06:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704725415; x=1705330215; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6SZoYYqOOUlMq4hjr9gywH5xihJLOMWXAYIKnq88z+Q=;
        b=f6SSQ91L/S/HMh04Aa26IRBAwQY3cGZnnnSOx56sUricJIfUIDSszIFIEbqOQz7QoP
         UD91edN5stZe+EHlgSKFBH2bERVWNVPqzBHte9Sf2iV9sW6Qf5B4/QwxHIF6sevSwoe+
         L38pvWKK19WInT6JGnC3mdhughtWqfdn8jtOYWWploFB5W/htuLgI6/supJSBQdybPXS
         e/oRdlATG8JQwXZpETh4LTH22qlu0MKATv2Nk4cEKvwBffMfbSc5OVkJfpO9AoiYVKji
         q5kMhj9katkdJjTL7/yHBAw3JORWboBO+dh2+GvcdpQVMSeNeJ4cEx+PnkldAuCbKiwl
         t8IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704725415; x=1705330215;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6SZoYYqOOUlMq4hjr9gywH5xihJLOMWXAYIKnq88z+Q=;
        b=RaSCK+9+Agb3fS/Ar+wKcKrtqG9HF+tmfnPoHTf/jjQgMYYpFFV/a5Gx6K2bqsD7+d
         +j9GSUUDPk6dQKsVnQorxr5enwrzCbWiKOccqU2CqdBadR2u/k4R0ZIMSbVyeX3K6AWS
         vystzy359eOsXGIlXJogZ2Qwqdrxs2x+DM2gAlzz0yKaIsR4f4/+xWOsXg6UhHJ1Ekp/
         9LoaBgdysu8CpWvnTyJMR4FS+eOsWjG9j+FyRqQRMpoiBIvsHKUr1HjGZNugjqpcAa4Z
         2MK6n9/jNcl9/ODEwHKs+0l9yb9MD5HYZp1DArUSlo5Ki1ukL2CH5Cn32hiRjqIVjS/8
         XzXQ==
X-Gm-Message-State: AOJu0YyVvxhHQXEslZ6ohuD7BVPHzAWIv4P0qvO3Flq6GeX4/B1oyJ9w
	E50LJCVJ5V9t7tfd4RfvOU857bJ7B9G3k/WtLzQabw==
X-Google-Smtp-Source: AGHT+IGoF8enDRleCmZP7Dmc/qRxjrTw5VAhRL9E5ptEbQRiVTHdmIVTFFthzEjgA3zPSvy/xLgsVV/t1bikGlU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:1342:b0:dbd:ee44:8908 with SMTP
 id g2-20020a056902134200b00dbdee448908mr1432916ybu.0.1704725415044; Mon, 08
 Jan 2024 06:50:15 -0800 (PST)
Date: Mon, 08 Jan 2024 14:50:00 +0000
In-Reply-To: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240108-rb-new-condvar-methods-v4-0-88e0c871cc05@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7874; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=p4ziQv4KIkMhpCT+PoV/4ZeXHtEOSN15SNY70QjJ4kk=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlnAuYNVHmKC/whrgPlUF7M5/1PQ7D0IobbMcTZ
 G0XbqHAVBeJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZZwLmAAKCRAEWL7uWMY5
 RmZ/D/9wxhF2JuR645ZiU06XtSTBT7fKFn5jm6SHcWIrPs1lK/brMEZLknoDDugO0eNDeioMjTY
 hjO1ZOhWQmgGeKesSTDuolvXpqCbneXSBMAX932Fbk71jk75j1hXxVy/8pSLAKoqp+K/ayRV1vj
 gcPaVgxN3rFrKg8zI+bM3o9YTl2PSvY0/nugeeb2gEKj/vVD6gbpxm7bpl9nB69BjYJX8eNPskU
 edI/0ea6H9DEuX6d3Z8K9P4HfSQWYjt8D9r6b3jcdAKqy66TkYqPQHD16fFyYcQBwQBJaHt5gvf
 DLYDvQVfCf+tLHkN7ZWz4J51Ougi9vHyrOkZbQDvuRm3Wubs/vFUeRkG/CnG0PU0S06DhL3nox0
 si6ZAelzmH2u3gwjdH01kSQYEpzG/FjxVlaqc5oM13Rq0f+nYfpB1oYZ60UCVc86SAch6NZ0MVJ
 nEL6v/Tb1veTV8mdVrF6JTNmWg2zTvMmGrhm02IAN9v4sRWmg51571911mBMuKaiPhqGj7oQbSa
 9NqtZYNME1Nhx7Boom4phakBXG6+U3FJMOae4g50WTu7wkUjZ5dVTZjPFHJPgaNIbD5jmxlynQ1
 GXldTJ9N8kRiNrgY045lMsvpAt2g2cr28B0r421lIFRYwxWzI9VkD/4bvOrEhw2MaPAR2wPWCzA i1qQlcxdbCLvOHg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240108-rb-new-condvar-methods-v4-4-88e0c871cc05@google.com>
Subject: [PATCH v4 4/4] rust: sync: update integer types in CondVar
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, 
	Tiago Lam <tiagolam@gmail.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Reduce the chances of compilation failures due to integer type
mismatches in `CondVar`.

When an integer is defined using a #define in C, bindgen doesn't know
which integer type it is supposed to be, so it will just use `u32` by
default (if it fits in an u32). Whenever the right type is something
else, we insert a cast in Rust. However, this means that the code has a
lot of extra casts, and sometimes the code will be missing casts if u32
happens to be correct on the developer's machine, even though the type
might be something else on a different platform.

This patch updates all uses of such constants in
`rust/kernel/sync/condvar.rs` to use constants defined with the right
type. This allows us to remove various unnecessary casts, while also
future-proofing for the case where `unsigned int != u32`.

I wrote this patch at the suggestion of Benno in [1].

Link: https://lore.kernel.org/all/nAEg-6vbtX72ZY3oirDhrSEf06TBWmMiTt73EklMzEAzN4FD4mF3TPEyAOxBZgZtjzoiaBYtYr3s8sa9wp1uYH9vEWRf2M-Lf4I0BY9rAgk=@proton.me/ [1]
Suggested-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Tiago Lam <tiagolam@gmail.com>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/condvar.rs | 39 +++++++++++++++++++--------------------
 rust/kernel/task.rs         | 15 ++++++++++++++-
 2 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index fa38c095cbe0..7f2b78e4abc7 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -7,11 +7,17 @@
 
 use super::{lock::Backend, lock::Guard, LockClassKey};
 use crate::{
-    bindings, init::PinInit, pin_init, str::CStr, task::MAX_SCHEDULE_TIMEOUT, time::Jiffies,
+    bindings,
+    init::PinInit,
+    pin_init,
+    str::CStr,
+    task::{MAX_SCHEDULE_TIMEOUT, TASK_INTERRUPTIBLE, TASK_NORMAL, TASK_UNINTERRUPTIBLE},
+    time::Jiffies,
     types::Opaque,
 };
-use core::ffi::c_long;
+use core::ffi::{c_int, c_long};
 use core::marker::PhantomPinned;
+use core::ptr;
 use macros::pin_data;
 
 /// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
@@ -108,7 +114,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
 
     fn wait_internal<T: ?Sized, B: Backend>(
         &self,
-        wait_state: u32,
+        wait_state: c_int,
         guard: &mut Guard<'_, T, B>,
         timeout_in_jiffies: c_long,
     ) -> c_long {
@@ -119,7 +125,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
 
         // SAFETY: Both `wait` and `wait_list` point to valid memory.
         unsafe {
-            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state)
         };
 
         // SAFETY: Switches to another thread. The timeout can be any number.
@@ -138,7 +144,7 @@ fn wait_internal<T: ?Sized, B: Backend>(
     /// [`CondVar::notify_one`] or [`CondVar::notify_all`]. Note that it may also wake up
     /// spuriously.
     pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
-        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_UNINTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -149,7 +155,7 @@ pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
     /// Returns whether there is a signal pending.
     #[must_use = "wait_interruptible returns if a signal is pending, so the caller must check the return value"]
     pub fn wait_interruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
-        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
+        self.wait_internal(TASK_INTERRUPTIBLE, guard, MAX_SCHEDULE_TIMEOUT);
         crate::current!().signal_pending()
     }
 
@@ -165,7 +171,7 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         jiffies: Jiffies,
     ) -> CondVarTimeoutResult {
         let jiffies = jiffies.try_into().unwrap_or(MAX_SCHEDULE_TIMEOUT);
-        let res = self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard, jiffies);
+        let res = self.wait_internal(TASK_INTERRUPTIBLE, guard, jiffies);
 
         match (res as Jiffies, crate::current!().signal_pending()) {
             (jiffies, true) => CondVarTimeoutResult::Signal { jiffies },
@@ -174,17 +180,10 @@ pub fn wait_interruptible_timeout<T: ?Sized, B: Backend>(
         }
     }
 
-    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
-    fn notify(&self, count: i32, flags: u32) {
+    /// Calls the kernel function to notify the appropriate number of threads.
+    fn notify(&self, count: c_int) {
         // SAFETY: `wait_list` points to valid memory.
-        unsafe {
-            bindings::__wake_up(
-                self.wait_list.get(),
-                bindings::TASK_NORMAL,
-                count,
-                flags as _,
-            )
-        };
+        unsafe { bindings::__wake_up(self.wait_list.get(), TASK_NORMAL, count, ptr::null_mut()) };
     }
 
     /// Calls the kernel function to notify one thread synchronously.
@@ -194,7 +193,7 @@ fn notify(&self, count: i32, flags: u32) {
     /// CPU.
     pub fn notify_sync(&self) {
         // SAFETY: `wait_list` points to valid memory.
-        unsafe { bindings::__wake_up_sync(self.wait_list.get(), bindings::TASK_NORMAL) };
+        unsafe { bindings::__wake_up_sync(self.wait_list.get(), TASK_NORMAL) };
     }
 
     /// Wakes a single waiter up, if any.
@@ -202,7 +201,7 @@ pub fn notify_sync(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_one(&self) {
-        self.notify(1, 0);
+        self.notify(1);
     }
 
     /// Wakes all waiters up, if any.
@@ -210,7 +209,7 @@ pub fn notify_one(&self) {
     /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
     /// completely (as opposed to automatically waking up the next waiter).
     pub fn notify_all(&self) {
-        self.notify(0, 0);
+        self.notify(0);
     }
 }
 
diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
index 17f14ebb8f48..6072b0de4a3e 100644
--- a/rust/kernel/task.rs
+++ b/rust/kernel/task.rs
@@ -5,11 +5,24 @@
 //! C header: [`include/linux/sched.h`](srctree/include/linux/sched.h).
 
 use crate::{bindings, types::Opaque};
-use core::{ffi::c_long, marker::PhantomData, ops::Deref, ptr};
+use core::{
+    ffi::{c_int, c_long, c_uint},
+    marker::PhantomData,
+    ops::Deref,
+    ptr,
+};
 
 /// A sentinal value used for infinite timeouts.
 pub const MAX_SCHEDULE_TIMEOUT: c_long = c_long::MAX;
 
+/// Bitmask for tasks that are sleeping in an interruptible state.
+pub const TASK_INTERRUPTIBLE: c_int = bindings::TASK_INTERRUPTIBLE as c_int;
+/// Bitmask for tasks that are sleeping in an uninterruptible state.
+pub const TASK_UNINTERRUPTIBLE: c_int = bindings::TASK_UNINTERRUPTIBLE as c_int;
+/// Convenience constant for waking up tasks regardless of whether they are in interruptible or
+/// uninterruptible sleep.
+pub const TASK_NORMAL: c_uint = bindings::TASK_NORMAL as c_uint;
+
 /// Returns the currently running task.
 #[macro_export]
 macro_rules! current {

-- 
2.43.0.472.g3155946c3a-goog


