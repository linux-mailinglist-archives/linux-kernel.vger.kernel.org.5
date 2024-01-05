Return-Path: <linux-kernel+bounces-17396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBAAA824CA1
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EDEBB238F0
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 01:38:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8B01FC8;
	Fri,  5 Jan 2024 01:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="PoaUFHLO"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE6A1FA3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 01:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id E88AB24002B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 02:29:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1704418174; bh=oAoNUgdOzVQyPdIoTkmvZg6pLTo+MPwqhbIwlJ+mDsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:
	 Content-Transfer-Encoding:From;
	b=PoaUFHLO4ggfYDOsm28CktkHfOMXkkmHb0FdJC2irtJEUAjRqwlhd60lTiXJjdGrg
	 HLmeG3CxLNnbOO8hfR2CGqfkWvpei3bKL1dOMb9y1k75MLiv7oSpp458twAWGj3O9T
	 B9aIbRKjQAnAWWm1sHqv2Petl003wePCEj3vrKNJVj9M2cKJn+4MHhIDqMkxqbCgCc
	 /7vLkCcQQgegOnkTIK/xDMARnH+589Mk9a+Qgc/811gNgCRzQX20kI+lcEHFA9aphX
	 D+3psfjMu6ZxypgnZ2y9WngQbplGCuaSec+1Njk+ogJfB+HULCdH4I8LNU7ZWUQBwz
	 VBf2+ZpwHRsCg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4T5m8X48yrz6tv5;
	Fri,  5 Jan 2024 02:29:32 +0100 (CET)
From: Charalampos Mitrodimas <charmitro@posteo.net>
To: ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	aliceryhl@google.com,
	a.hindborg@samsung.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Charalampos Mitrodimas <charmitro@posteo.net>
Subject: [PATCH] rust: sync: `CondVar` rename "wait_list" to "wait_queue_head"
Date: Fri,  5 Jan 2024 01:29:30 +0000
Message-Id: <20240105012930.1426214-1-charmitro@posteo.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fields named "wait_list" usually are of type "struct list_head". To
avoid confusion and because it is of type
"Opaque<bindings::wait_queue_head>" we are renaming "wait_list" to
"wait_queue_head".

Signed-off-by: Charalampos Mitrodimas <charmitro@posteo.net>
---
 rust/kernel/sync/condvar.rs | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index b679b6f6dbeb..ea0d559fbde5 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -73,7 +73,7 @@ macro_rules! new_condvar {
 #[pin_data]
 pub struct CondVar {
     #[pin]
-    pub(crate) wait_list: Opaque<bindings::wait_queue_head>,
+    pub(crate) wait_queue_head: Opaque<bindings::wait_queue_head>,
 
     /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
     /// self-referential, so it cannot be safely moved once it is initialised.
@@ -96,7 +96,7 @@ pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self
             _pin: PhantomPinned,
             // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
             // static lifetimes so they live indefinitely.
-            wait_list <- Opaque::ffi_init(|slot| unsafe {
+            wait_queue_head <- Opaque::ffi_init(|slot| unsafe {
                 bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
             }),
         })
@@ -108,16 +108,20 @@ fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guar
         // SAFETY: `wait` points to valid memory.
         unsafe { bindings::init_wait(wait.get()) };
 
-        // SAFETY: Both `wait` and `wait_list` point to valid memory.
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
         unsafe {
-            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
+            bindings::prepare_to_wait_exclusive(
+                self.wait_queue_head.get(),
+                wait.get(),
+                wait_state as _,
+            )
         };
 
         // SAFETY: No arguments, switches to another thread.
         guard.do_unlocked(|| unsafe { bindings::schedule() });
 
-        // SAFETY: Both `wait` and `wait_list` point to valid memory.
-        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
+        // SAFETY: Both `wait` and `wait_queue_head` point to valid memory.
+        unsafe { bindings::finish_wait(self.wait_queue_head.get(), wait.get()) };
     }
 
     /// Releases the lock and waits for a notification in interruptible mode.
@@ -144,10 +148,10 @@ pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_,
 
     /// Calls the kernel function to notify the appropriate number of threads with the given flags.
     fn notify(&self, count: i32, flags: u32) {
-        // SAFETY: `wait_list` points to valid memory.
+        // SAFETY: `wait_queue_head` points to valid memory.
         unsafe {
             bindings::__wake_up(
-                self.wait_list.get(),
+                self.wait_queue_head.get(),
                 bindings::TASK_NORMAL,
                 count,
                 flags as _,
-- 
2.39.2


