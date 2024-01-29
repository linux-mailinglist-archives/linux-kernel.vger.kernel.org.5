Return-Path: <linux-kernel+bounces-42948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4529E840926
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 15:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F145028B6C7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 14:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCD431534F6;
	Mon, 29 Jan 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3D23dSuT"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00968152DEC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 14:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706540325; cv=none; b=ajtc5qLJoW4ldvsCQjR4nA2O7lWQc86Wy4OCT+wt4GJ3cCr9eTs8dPYlr89wuBcYu8ZAdFIMuEh7k1tk+aYnf4qD6SbjwtmYbhO7xgtBRZES0MWCzDaoYL+94Wa7RkOmPvaRYllTHdwriyLLh4ijpuXtE3ZYARz/cN1D1InUZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706540325; c=relaxed/simple;
	bh=fGQMhAPfuC6Nz2GR1bvgST+yK0rGAgTz9JwInsVoAqM=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=qKwCqMmAMWSlH2etmYuRgup55M3Qw8Yg56cJ4x1QyTTDs7qRz5SUbpZYi3xDVUK2YP/CGzRByZjucW5HKkF4ZQINjr17FoIE9ojTssuf06NIu4RZ1d49/8hwHLlU8fP/N3nIBTAHe4JEtAve0kDAUvsnIlVgWj8fFNRGcHgDEA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3D23dSuT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc2284779caso3801748276.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 06:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706540322; x=1707145122; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oON07CtAvIpgcQwBJ+SMYQgiJf/aIowxCWbKV6XFaVo=;
        b=3D23dSuTfGxVkTy9c9esBSZ4IyDa6CzzNzbn7UgzH4UqnAYCH6Z5GJd9pv8LX3axKz
         tcTeJPabb962Ny4Jju/BBa08excaeTC5yMWHPK/mAPdwPD7BD/AGG25yktnRwXhetjYQ
         3Gz5Lk8QghIeUVl2aB14AQ3SXHt/pv0yFbXO9qlNPPyXCjskWJ0UMoGxUx4RNa6sY3Ld
         3Q6boGHD1F3St/4ckloWG5xwUksQhERScrUQqShh1ODsmk8jnBPJQJ50gM3ay2dti5rN
         K2V0LVQfuC7P10FqXzyefw2vGoYe+o28xECmnLrpqJ5AL8zMSwpnkTnx9oEim+NByus0
         6eyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706540322; x=1707145122;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oON07CtAvIpgcQwBJ+SMYQgiJf/aIowxCWbKV6XFaVo=;
        b=mwvEJGgZd5i0FRtD0sweBp2xbIsBXbpzK8gq2Zwtf/IijauEJivdcmt11f2tiBe711
         WKQNWcl5dXIPhlzKEJb52bn2AOWylHUkyQkxfcd02bc6TMAYIAy/YtesRfRJSDcUzuMw
         NBQYzzBksVQ6aGsoQT4ua2dksGKU1qCnkJS7FaR00FYfNCto8pOFYQe8CsyEwIVBaBKb
         wqIgnyKD23qLztM0CVPIrfv3+luXntiX25DUkKBSdmhcMsvowKieA+bASwveUzKcvrb5
         Hz47NiXsJTYKg92s0i8mMWYYyp/sGd38y/uER7cUp6+14+DKZjFJIz0dks5sslAgIhXH
         HasQ==
X-Gm-Message-State: AOJu0YydKG12nQnfP+vm44FX5Fe46DXrqZDp7DIyK37EGO3VJSEzXnHt
	tlZTu2i9vu5p0Bm2eOi4tWE3BCNcjwVQjrTBrcpl22sFJiPMoPeRXQuTg9rEM9ZZP/NYVA39fQd
	kdtWfOZAJnKN3vA==
X-Google-Smtp-Source: AGHT+IEHRcKBmwEwA5S06HDsIpC/pSONqjIOn1yrZCXeuHc0FNflO0RYZ0eG3EkJaB0LuOHd1LG56835qb6RlTk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:2503:b0:dc2:661d:11fc with SMTP
 id dt3-20020a056902250300b00dc2661d11fcmr325792ybb.8.1706540321973; Mon, 29
 Jan 2024 06:58:41 -0800 (PST)
Date: Mon, 29 Jan 2024 14:58:37 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=7158; i=aliceryhl@google.com;
 h=from:subject; bh=fGQMhAPfuC6Nz2GR1bvgST+yK0rGAgTz9JwInsVoAqM=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlt7zzldqivJRV/It/iKGglskR9DYue0XvSxmD8
 /eHTL9nMjCJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZbe88wAKCRAEWL7uWMY5
 RlB2EACrI9RnjPVwrWvGGLKfcfFto9Y9OSYR0/NhKb7ZTmg+lOWVAaAK3SBwmygrOVyJShz3GT8
 IKCSlXzGPHSP5zNA/DnzftQNKmKht6z70bF+FOWgpTjCup72KSE2MMu/gN/T3ihyZkzSrPRpNCR
 GNXb0+H2QTVk8XTJOqh5KFy7toD/UVDgkefAq5Y2tZEbAQOueNph6L2u6XGLjpH4OTmLhuT7Tth
 303X1yQlo8nbBBQ8IjzafFoGnFAbPTL43LrNllkq9ibg+vcing84GoIo0HvLYvUym3lThNXK5qb
 FMLiiaE5tgUgcfao3MNW4/lod7GbS5z6qDk/hI2pR/fDw3nWPTF/dQOzy75xH80PWOFDF1WbFmD
 DXIRJpLZGDK3ng/HopdmClqW3rL/0F1d76Go4KWLzSj8TyTl9E7ZW9rf4sykLeQpO45xdmsSkpc
 2cP00GNcWu11l/GGLiwAyIA+3KidgEo71ORX3JabCR71bh8kXVZIjy0gGVB+rQp70SK23h0NHNc
 KgFTxFjS53oGIqlasPiEfa5cNGwIes+tXJoCaCrOi9gDWI+vMEU8eFOoXBJRd7BIGCEf16MW0F7
 ZrmGlVD8W2BgMV0JLtUcUGjf2UseNMzMx/z0Snwc5DXeTCnhErS7amSdxRa0Q245zxPoBqySRjH 0WHyXW2r0707l4w==
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240129145837.1419880-1-aliceryhl@google.com>
Subject: [PATCH v1] rust: add reexports for macros
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Currently, all macros are reexported with #[macro_export] only, which
means that to access `new_work!` from the workqueue, you need to import
it from the path `kernel::new_work` instead of importing it from the
workqueue module like all other items in the workqueue. By adding
reexports of the macros, it becomes possible to import the macros from
the correct modules.

It's still possible to import the macros from the root, but I don't
think we can do anything about that.

There is no functional change. This is merely a code cleanliness
improvement.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
I hope that the KUnit examples still compile. I tried checking myself
and it seemed to work, but I'm not completely sure whether I used the
tool correctly. I would appreciate if someone is able to double-check
and give a Tested-by for that.

 rust/kernel/init.rs               |  8 +++++---
 rust/kernel/sync.rs               |  5 +++--
 rust/kernel/sync/condvar.rs       |  4 ++--
 rust/kernel/sync/lock/mutex.rs    |  4 +++-
 rust/kernel/sync/lock/spinlock.rs |  4 +++-
 rust/kernel/workqueue.rs          | 14 ++++++--------
 6 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index 65be9ae57b80..d7107db1d587 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -36,7 +36,8 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names)]
-//! use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! use kernel::prelude::*;
+//! use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
 //! #[pin_data]
 //! struct Foo {
@@ -56,7 +57,8 @@
 //!
 //! ```rust
 //! # #![allow(clippy::disallowed_names)]
-//! # use kernel::{prelude::*, sync::Mutex, new_mutex};
+//! # use kernel::prelude::*;
+//! # use kernel::sync::{new_mutex, Mutex};
 //! # use core::pin::Pin;
 //! # #[pin_data]
 //! # struct Foo {
@@ -79,7 +81,7 @@
 //! above method only works for types where you can access the fields.
 //!
 //! ```rust
-//! # use kernel::{new_mutex, sync::{Arc, Mutex}};
+//! # use kernel::sync::{new_mutex, Arc, Mutex};
 //! let mtx: Result<Arc<Mutex<usize>>> = Arc::pin_init(new_mutex!(42, "example::mtx"));
 //! ```
 //!
diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
index c1fb10fc64f4..c983f63fd56e 100644
--- a/rust/kernel/sync.rs
+++ b/rust/kernel/sync.rs
@@ -13,8 +13,9 @@
 mod locked_by;
 
 pub use arc::{Arc, ArcBorrow, UniqueArc};
-pub use condvar::{CondVar, CondVarTimeoutResult};
-pub use lock::{mutex::Mutex, spinlock::SpinLock};
+pub use condvar::{new_condvar, CondVar, CondVarTimeoutResult};
+pub use lock::mutex::{new_mutex, Mutex};
+pub use lock::spinlock::{new_spinlock, SpinLock};
 pub use locked_by::LockedBy;
 
 /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
index 9f1d83589beb..72680ff57e67 100644
--- a/rust/kernel/sync/condvar.rs
+++ b/rust/kernel/sync/condvar.rs
@@ -27,6 +27,7 @@ macro_rules! new_condvar {
         $crate::sync::CondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
+pub use new_condvar;
 
 /// A conditional variable.
 ///
@@ -44,8 +45,7 @@ macro_rules! new_condvar {
 /// The following is an example of using a condvar with a mutex:
 ///
 /// ```
-/// use kernel::sync::{CondVar, Mutex};
-/// use kernel::{new_condvar, new_mutex};
+/// use kernel::sync::{new_condvar, new_mutex, CondVar, Mutex};
 ///
 /// #[pin_data]
 /// pub struct Example {
diff --git a/rust/kernel/sync/lock/mutex.rs b/rust/kernel/sync/lock/mutex.rs
index 8c524a3ec45a..38207f9ce78a 100644
--- a/rust/kernel/sync/lock/mutex.rs
+++ b/rust/kernel/sync/lock/mutex.rs
@@ -17,6 +17,7 @@ macro_rules! new_mutex {
             $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
+pub use new_mutex;
 
 /// A mutual exclusion primitive.
 ///
@@ -35,7 +36,8 @@ macro_rules! new_mutex {
 /// contains an inner struct (`Inner`) that is protected by a mutex.
 ///
 /// ```
-/// use kernel::{init::InPlaceInit, init::PinInit, new_mutex, pin_init, sync::Mutex};
+/// use kernel::prelude::*;
+/// use kernel::sync::{new_mutex, Mutex};
 ///
 /// struct Inner {
 ///     a: u32,
diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
index 068535ce1b29..cb2c6f71e80e 100644
--- a/rust/kernel/sync/lock/spinlock.rs
+++ b/rust/kernel/sync/lock/spinlock.rs
@@ -17,6 +17,7 @@ macro_rules! new_spinlock {
             $inner, $crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
+pub use new_spinlock;
 
 /// A spinlock.
 ///
@@ -33,7 +34,8 @@ macro_rules! new_spinlock {
 /// contains an inner struct (`Inner`) that is protected by a spinlock.
 ///
 /// ```
-/// use kernel::{init::InPlaceInit, init::PinInit, new_spinlock, pin_init, sync::SpinLock};
+/// use kernel::prelude::*;
+/// use kernel::sync::{new_spinlock, SpinLock};
 ///
 /// struct Inner {
 ///     a: u32,
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 498397877376..0ed17451b06e 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -35,8 +35,7 @@
 //! ```
 //! use kernel::prelude::*;
 //! use kernel::sync::Arc;
-//! use kernel::workqueue::{self, Work, WorkItem};
-//! use kernel::{impl_has_work, new_work};
+//! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
 //!
 //! #[pin_data]
 //! struct MyStruct {
@@ -78,8 +77,7 @@
 //! ```
 //! use kernel::prelude::*;
 //! use kernel::sync::Arc;
-//! use kernel::workqueue::{self, Work, WorkItem};
-//! use kernel::{impl_has_work, new_work};
+//! use kernel::workqueue::{self, impl_has_work, new_work, Work, WorkItem};
 //!
 //! #[pin_data]
 //! struct MyStruct {
@@ -147,6 +145,7 @@ macro_rules! new_work {
         $crate::workqueue::Work::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
     };
 }
+pub use new_work;
 
 /// A kernel work queue.
 ///
@@ -396,9 +395,8 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
 /// like this:
 ///
 /// ```no_run
-/// use kernel::impl_has_work;
 /// use kernel::prelude::*;
-/// use kernel::workqueue::Work;
+/// use kernel::workqueue::{impl_has_work, Work};
 ///
 /// struct MyWorkItem {
 ///     work_field: Work<MyWorkItem, 1>,
@@ -473,9 +471,8 @@ unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
 /// # Examples
 ///
 /// ```
-/// use kernel::impl_has_work;
 /// use kernel::sync::Arc;
-/// use kernel::workqueue::{self, Work};
+/// use kernel::workqueue::{self, impl_has_work, Work};
 ///
 /// struct MyStruct {
 ///     work_field: Work<MyStruct, 17>,
@@ -509,6 +506,7 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
         }
     )*};
 }
+pub use impl_has_work;
 
 impl_has_work! {
     impl<T> HasWork<Self> for ClosureWork<T> { self.work }

base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
-- 
2.43.0.429.g432eaa2c6b-goog


