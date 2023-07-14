Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAD17534F4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:21:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235007AbjGNIVN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbjGNIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:21:11 -0400
X-Greylist: delayed 900 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 14 Jul 2023 01:21:08 PDT
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903539B;
        Fri, 14 Jul 2023 01:21:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: linasend@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 269E95BAE8;
        Fri, 14 Jul 2023 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1689321319;
        bh=7J6No4Uq+18pRNDNsxGUwdq6k7ZetFTxJmVCqu0gelc=;
        h=From:Date:Subject:To:Cc;
        b=0XXctXa8kAUwqUR/n14lJzAp1QSwB4QVYeTBiOsv07KBbD6NvF6XF73BDiRjxaldA
         L2A7a62Y5JE8n4pAqEf4GGzbkejs/EuMTKpOIlxO6oMAxZ7d4mpT2x7jOZJXCxFb2S
         iIHDs92fj0sV4K48baDpfQdTTWaTKcLuQU7JwUN4uo34nWeLtCMMVxxOQeh0aouLg6
         zlaXXK8eVEREW+a1ZIF7LE93+fo/vVZa0iR367TjUSSOpeisKx5Y+gq7AD0m9d5Irj
         WExg0duPuLNEP3ehs0DOUCo890NEr5Ql1OsX7Q0Sk5uM1btsArfvz9I/Zafk2K5uNq
         c7tnSZxM5TxXA==
From:   Asahi Lina <lina@asahilina.net>
Date:   Fri, 14 Jul 2023 16:55:01 +0900
Subject: [PATCH v2] rust: time: New module for timekeeping functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230714-rust-time-v2-1-f5aed84218c4@asahilina.net>
X-B4-Tracking: v=1; b=H4sIAFT/sGQC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHQUlJIzE
 vPSU3UzU4B8JSMDI2MDc0MT3aLS4hLdkszcVF1Dg5QUy9QUI1NjY2MloPqCotS0zAqwWdGxtbU
 AYS2TUFsAAAA=
To:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Josh Stone <jistone@redhat.com>,
        Gaelan Steele <gbs@canishe.com>,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Cc:     linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        asahi@lists.linux.dev, Asahi Lina <lina@asahilina.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1689321314; l=8468;
 i=lina@asahilina.net; s=20230221; h=from:subject:message-id;
 bh=7J6No4Uq+18pRNDNsxGUwdq6k7ZetFTxJmVCqu0gelc=;
 b=HpiQKFG0rAdsT7ooEpKBQ1fhz3+0ARMyc8DgriWfRofBJbVXrK3y3rBG0HRIM0Ja4hnOFqG8e
 O6Bd+SjWBAZB2M8WGX8ZawAVdoKqD+hx6KCJhJjK/5HojC5Vm5BNgDD
X-Developer-Key: i=lina@asahilina.net; a=ed25519;
 pk=Qn8jZuOtR1m5GaiDfTrAoQ4NE1XoYVZ/wmt5YtXWFC4=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This module is intended to contain functions related to kernel
timekeeping and time.

Initially, this implements an abstraction for a time Instant (analogous
to the Rust std::time::Instant) that represents an opaque instant in
time. Unlike the std Instant, this is a generic type that is bound to a
specific clock source, so that only Instants from the same clock source
can be subtracted/compared.

Then we implement the relevant clocks available to the kernel:
KernelTime (CLOCK_MONOTONIC), BootTime (CLOCK_BOOTTIME),
RealTime (CLOCK_REALTIME), and TaiTime.

Co-developed-by: Heghedus Razvan <heghedus.razvan@protonmail.com>
Signed-off-by: Asahi Lina <lina@asahilina.net>
---

Based on the feedback to v1, now we have proper type checking for kernel
time. I decided to implement marker traits for monotonic vs. wallclock
time sources, since it's useful to be able to safely implement different
semantics conditional on that, but that left me with a name conflict of
the Monotonic trait with the CLOCK_MONOTONIC / "default ktime" clock
source. I ended up calling it KernelTime since it's the most fundamental
kernel timesource, but suggestions welcome!

Heghedus: I think I need a signoff on this since this is based on the
playground demo you wrote in the feedback to v1. Can you provide that? I
can fold it into v3 (if there is one, otherwise Miguel can probably just
add it when he applies it). Thanks!
---
 rust/bindings/bindings_helper.h |   2 +
 rust/helpers.c                  |  16 +++++
 rust/kernel/lib.rs              |   1 +
 rust/kernel/time.rs             | 150 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 169 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 3e601ce2548d..eddfdf887364 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -8,9 +8,11 @@
 
 #include <linux/errname.h>
 #include <linux/slab.h>
+#include <linux/ktime.h>
 #include <linux/refcount.h>
 #include <linux/wait.h>
 #include <linux/sched.h>
+#include <linux/timekeeping.h>
 
 /* `bindgen` gets confused at certain things. */
 const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
diff --git a/rust/helpers.c b/rust/helpers.c
index bb594da56137..eff092302e23 100644
--- a/rust/helpers.c
+++ b/rust/helpers.c
@@ -26,6 +26,7 @@
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/sched/signal.h>
+#include <linux/timekeeping.h>
 #include <linux/wait.h>
 
 __noreturn void rust_helper_BUG(void)
@@ -135,6 +136,21 @@ void rust_helper_put_task_struct(struct task_struct *t)
 }
 EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
 
+ktime_t rust_helper_ktime_get_real(void) {
+	return ktime_get_real();
+}
+EXPORT_SYMBOL_GPL(rust_helper_ktime_get_real);
+
+ktime_t rust_helper_ktime_get_boottime(void) {
+	return ktime_get_boottime();
+}
+EXPORT_SYMBOL_GPL(rust_helper_ktime_get_boottime);
+
+ktime_t rust_helper_ktime_get_clocktai(void) {
+	return ktime_get_clocktai();
+}
+EXPORT_SYMBOL_GPL(rust_helper_ktime_get_clocktai);
+
 /*
  * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
  * as the Rust `usize` type, so we can use it in contexts where Rust
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 85b261209977..52c91484c5d8 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -42,6 +42,7 @@
 pub mod str;
 pub mod sync;
 pub mod task;
+pub mod time;
 pub mod types;
 
 #[doc(hidden)]
diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
new file mode 100644
index 000000000000..f3bfeed20145
--- /dev/null
+++ b/rust/kernel/time.rs
@@ -0,0 +1,150 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Timekeeping functions.
+//!
+//! C header: [`include/linux/ktime.h`](../../../../include/linux/ktime.h)
+//! C header: [`include/linux/timekeeping.h`](../../../../include/linux/timekeeping.h)
+
+use crate::{bindings, pr_err};
+use core::marker::PhantomData;
+use core::time::Duration;
+
+/// Represents a clock, that is, a unique time source.
+pub trait Clock: Sized {}
+
+/// A time source that can be queried for the current time.
+pub trait Now: Clock {
+    /// Returns the current time for this clock.
+    fn now() -> Instant<Self>;
+}
+
+/// Marker trait for clock sources that are guaranteed to be monotonic.
+pub trait Monotonic {}
+
+/// Marker trait for clock sources that represent a calendar (wall clock)
+/// relative to the UNIX epoch.
+pub trait WallTime {}
+
+/// An instant in time associated with a given clock source.
+#[derive(Debug)]
+pub struct Instant<T: Clock> {
+    nanoseconds: i64,
+    _type: PhantomData<T>,
+}
+
+impl<T: Clock> Clone for Instant<T> {
+    fn clone(&self) -> Self {
+        *self
+    }
+}
+
+impl<T: Clock> Copy for Instant<T> {}
+
+impl<T: Clock> Instant<T> {
+    fn new(nanoseconds: i64) -> Self {
+        Instant {
+            nanoseconds,
+            _type: PhantomData,
+        }
+    }
+
+    /// Returns the time elapsed since an earlier Instant<t>, or
+    /// None if the argument is a later Instant.
+    pub fn since(&self, earlier: Instant<T>) -> Option<Duration> {
+        if earlier.nanoseconds > self.nanoseconds {
+            None
+        } else {
+            // Casting to u64 and subtracting is guaranteed to give the right
+            // result for all inputs, as long as the condition we checked above
+            // holds.
+            Some(Duration::from_nanos(
+                self.nanoseconds as u64 - earlier.nanoseconds as u64,
+            ))
+        }
+    }
+}
+
+impl<T: Clock + Now + Monotonic> Instant<T> {
+    /// Returns the time elapsed since this Instant<T>.
+    ///
+    /// This is guaranteed to return a positive result, since
+    /// it is only implemented for monotonic clocks.
+    pub fn elapsed(&self) -> Duration {
+        T::now().since(*self).unwrap_or_else(|| {
+            pr_err!(
+                "Monotonic clock {} went backwards!",
+                core::any::type_name::<T>()
+            );
+            Duration::ZERO
+        })
+    }
+}
+
+/// Contains the various clock source types available to the kernel.
+pub mod clock {
+    use super::*;
+
+    /// A clock representing the default kernel time source.
+    ///
+    /// This is `CLOCK_MONOTONIC` (though it is not the only
+    /// monotonic clock) and also the default clock used by
+    /// `ktime_get()` in the C API.
+    ///
+    /// This is like `BootTime`, but does not include time
+    /// spent sleeping.
+
+    pub struct KernelTime;
+
+    impl Clock for KernelTime {}
+    impl Monotonic for KernelTime {}
+    impl Now for KernelTime {
+        fn now() -> Instant<Self> {
+            Instant::<Self>::new(unsafe { bindings::ktime_get() })
+        }
+    }
+
+    /// A clock representing the time elapsed since boot.
+    ///
+    /// This is `CLOCK_MONOTONIC` (though it is not the only
+    /// monotonic clock) and also the default clock used by
+    /// `ktime_get()` in the C API.
+    ///
+    /// This is like `KernelTime`, but does include time
+    /// spent sleeping.
+    pub struct BootTime;
+
+    impl Clock for BootTime {}
+    impl Monotonic for BootTime {}
+    impl Now for BootTime {
+        fn now() -> Instant<Self> {
+            Instant::<Self>::new(unsafe { bindings::ktime_get_boottime() })
+        }
+    }
+
+    /// A clock representing TAI time.
+    ///
+    /// This clock is not monotonic and can be changed from userspace.
+    /// However, it is not affected by leap seconds.
+    pub struct TaiTime;
+
+    impl Clock for TaiTime {}
+    impl WallTime for TaiTime {}
+    impl Now for TaiTime {
+        fn now() -> Instant<Self> {
+            Instant::<Self>::new(unsafe { bindings::ktime_get_clocktai() })
+        }
+    }
+
+    /// A clock representing wall clock time.
+    ///
+    /// This clock is not monotonic and can be changed from userspace.
+    pub struct RealTime;
+
+    impl Clock for RealTime {}
+    impl WallTime for RealTime {}
+    impl Now for RealTime {
+        fn now() -> Instant<Self> {
+            Instant::<Self>::new(unsafe { bindings::ktime_get_real() })
+        }
+    }
+}

---
base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
change-id: 20230714-rust-time-10dd9ed25333

Thank you,
~~ Lina

