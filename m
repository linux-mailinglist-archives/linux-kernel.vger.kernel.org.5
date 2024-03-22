Return-Path: <linux-kernel+bounces-111173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B71448868B3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D5E288E96
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2521B7EF;
	Fri, 22 Mar 2024 08:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b0477ugn"
Received: from mail-lf1-f73.google.com (mail-lf1-f73.google.com [209.85.167.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EF11863B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 08:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711097985; cv=none; b=aKTAZ1/16o5HYmxg1BeHZ3PSETKTXXivJshBhxjOPAV2Wf+csXBLdCyvqlz3IpcaBtsu6mu5UQl4eDxrBEywtJImy5OUxuNG+H3lreRFa5TpmzR86DNYul+Em6MgJSYoJSAgOrT7ImmJuXz+XW+HgzcBJ7lZvLfS0Vd3hygQfG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711097985; c=relaxed/simple;
	bh=EC4OG1J56rAOP/dclUHSBcvaNyKVH+2tWa8+xjWuNdU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=G0J8GjbF1msm6jLtkHzcZBNq+Z+ngQT9yg5h7RPRuC6aT6titrWB4RZyWZ0uYZwrlA+l7MHydwMKmnSBeyro97BN4rI6tVbwTUDDrn8dBT9IIf7tYC2n8daVeOd1D9FycD6ve8mgjzQTCwvU7GTXj09CvySG06n/8otUMZ6ErQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b0477ugn; arc=none smtp.client-ip=209.85.167.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f73.google.com with SMTP id 2adb3069b0e04-515297de3fdso1930950e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 01:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711097982; x=1711702782; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z0nwcoCASNsrcCHsydtItlcFcATzcVkuAXr1ugapHoA=;
        b=b0477ugnqxPKvJv0rdx0GG4NdRwYCzVGdkaOUSrs8GOOC8226F9IZDSLjllfWSOOvX
         zYtZzFLQjOZjwc3FabvI3FUw9SwuomdskMFdZuWBwtZaNadbA7w7v2IODqiB4+BI/Vcr
         7GO36KgAGCyGHnW5QWYetdzdXsnGODf17yVQmQaWCi0Fi/zemvjwy1WEnVo6GNjZyRlN
         cojFkkAtb/NziJf/RXtFy2HbNJfLBMQmXtYsnCuXjaq132P78zFcdKnKUyFOu2sg5xnq
         z18Y0U0l1oE7VfAEDnBUryTqvGYO02eVB7tNYoJmIVVAsy9jrLJeMoRJmzv/9VXkGXfR
         a54w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711097982; x=1711702782;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0nwcoCASNsrcCHsydtItlcFcATzcVkuAXr1ugapHoA=;
        b=fBq+YPU9zPkSFUampCjZNJYtNDU7S7D9xn5PjSeNgUgsM0u1jdBSivVvr6yBDSjbAY
         bwRgYr/FZYT1KnBS3VftUTImlA5DcheCwrXzGVusSsBlDnduHURkJr9nbMqWU9KsGmv+
         9n/aZS8r64L5BzVNFb2Ebs9XdIWjFgsJRxJkQ8GpBHrwrf3IO2Y/GNo9nseneij96RgY
         uZVfSm+0eKT1dWtRWDLBz4ook6ylhP4dDm7EpRgSmNsOzsGmScjcgnW2SU74ENGXkHm+
         Ee0MgvPtq7Tj9T1jo8YX9lA6/j9g8SK/f+khLFyeEQeWCPL0DsjvzZt4CjvGO2k/M5H9
         waHw==
X-Forwarded-Encrypted: i=1; AJvYcCUaUmymZHq4cWoDmxGC+djh7LDF1JbFVZFiDxc4ltc1FuC9lCWocp0sPhBzi5fLEMAKHThoueMmT2jTjd+pD+dogFjNoyP/PlNZW+P7
X-Gm-Message-State: AOJu0Yzs4P1c1sv6ajSRDrPODh3RMYI4Qf2XLBR9/2eCTjlGVQLS0x4X
	vR4byyg2rD8lR+u+i/ZZ/WCUkHVRK4GFYpopar0TYg5c4BO6cG23/WoH5E7lqk9kU8FzOcPVe4+
	IHyEunhVZMP6Leg==
X-Google-Smtp-Source: AGHT+IEBeYpkLvKwmAKsIS8F3yzqU4L1I52NjuAxHnnNPGau9BD2wkeJfZw9Hxkg2ZQH/JPZUJHYVkC05GSSPuU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a19:6a13:0:b0:513:ce43:4849 with SMTP id
 u19-20020a196a13000000b00513ce434849mr2261lfu.4.1711097981311; Fri, 22 Mar
 2024 01:59:41 -0700 (PDT)
Date: Fri, 22 Mar 2024 08:59:38 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAHlI/WUC/32NQQ7CIBBFr9LMWgwgkdaV9zBNQ+lIJ7bFABJN0
 7uLPYDL95L//goRA2GES7VCwEyR/FJAHiqwo1kcMhoKg+RS8ZPkLLxiYo9EM3Zz7AackmFa9Zz
 bxvS1llCWz4B3eu/VW1t4pJh8+OwnWfzs/14WTDBr+/qspeGNElfnvZvwaP0M7bZtXxu0QgS3A AAA
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3439; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=EC4OG1J56rAOP/dclUHSBcvaNyKVH+2tWa8+xjWuNdU=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl/Uh691rlHmXrjapD1+4GGflU0Qbw2bFa/Y8ul
 arF3fybA+WJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZf1IegAKCRAEWL7uWMY5
 RtMTD/425XZgE3xHBXSlbVRbvaLP5I5ZkC1Be7uFwfnkWo5FbPNxcPiGP41nK03GOlPXtlf3PDq
 nk4V0s57zB+yTu6KAmq6zg4bc2Sa0PGEBNVlS8LcIH+O+m9cUcbXkC7w+2Xcx0lL6Q7PIE5brJ7
 dIonPga9eJ8kyptLorY44ARU4jT83nEL0XuHdS5ZgjO64VZhIMlC7ZhFkdCLHruB/z98OtBn/rq
 6LlBCSl/mTDJpdY4yzBzmK5iyPEQfcT6q2lIi70qtXkUrnL615kXg98buMvAYiz2psvmgGOsy1t
 +Mu2gjjLktMSQH+OQ9LKoZMQcxWQNr4R1KATketMz8NpbTCjJ36cqE6CU2IlJ2YMlouSwi2ilzw
 4iz3CGyT74BGbfVzDToaC+guBzAMBJO21Iqtxn31X7wgzV1WqsW01Z8Vubo8vG9bYYXWi89HLph
 fb12+HQha2WLDHKfDOn1gqmhH/667Gu9ET4nKTe9h4aWpolt8u+1FSWWticXDxseoT4aCvFoehT
 1UbFcW62+518VxQl7iWhQDy/l3Fh9rpEUacTipxQIKCuVOiLlLDBD+Rl4ZGTizcqxmvd9cI0wRv
 RNCqAEttrTBPU5bFf2DFgTRe8wlkWC78suqVbtVGA9onLLBJZQmWVDNu0P2xcqNbX2gg4KUD/k6 lCiob4blI65rcsA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240322-rust-ktime_ms_delta-v2-1-d98de1f7c282@google.com>
Subject: [PATCH v2] rust: time: add Ktime
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, John Stultz <jstultz@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Stephen Boyd <sboyd@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Introduce a wrapper around `ktime_t` with a few different useful
methods.

Rust Binder will use these bindings to compute how many milliseconds a
transaction has been active for when dumping the current state of the
Binder driver. This replicates the logic in C Binder [1].

For a usage example in Rust Binder, see [2].

The `ktime_get` method cannot be safely called in NMI context. This
requirement is not checked by these abstractions, but it is intended
that klint [3] or a similar tool will be used to check it in the future.

Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
Link: https://r.android.com/3004103 [2]
Link: https://rust-for-linux.com/klint [3]
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes in v2:
- Mention that ktime_get cannot be safely called in NMI context.
- Link to v1: https://lore.kernel.org/r/20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com
---
 rust/kernel/time.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896eed468..6811d5cadbd4 100644
--- a/rust/kernel/time.rs
+++ b/rust/kernel/time.rs
@@ -5,6 +5,9 @@
 //! This module contains the kernel APIs related to time and timers that
 //! have been ported or wrapped for usage by Rust code in the kernel.
 
+/// The number of nanoseconds per millisecond.
+pub const NSEC_PER_MSEC: i64 = bindings::NSEC_PER_MSEC as i64;
+
 /// The time unit of Linux kernel. One jiffy equals (1/HZ) second.
 pub type Jiffies = core::ffi::c_ulong;
 
@@ -18,3 +21,60 @@ pub fn msecs_to_jiffies(msecs: Msecs) -> Jiffies {
     // matter what the argument is.
     unsafe { bindings::__msecs_to_jiffies(msecs) }
 }
+
+/// A Rust wrapper around a `ktime_t`.
+#[repr(transparent)]
+#[derive(Copy, Clone)]
+pub struct Ktime {
+    inner: bindings::ktime_t,
+}
+
+impl Ktime {
+    /// Create a `Ktime` from a raw `ktime_t`.
+    #[inline]
+    pub fn from_raw(inner: bindings::ktime_t) -> Self {
+        Self { inner }
+    }
+
+    /// Get the current time using `CLOCK_MONOTONIC`.
+    #[inline]
+    pub fn ktime_get() -> Self {
+        // SAFETY: It is always safe to call `ktime_get` outside of NMI context.
+        Self::from_raw(unsafe { bindings::ktime_get() })
+    }
+
+    /// Divide the number of nanoseconds by a compile-time constant.
+    #[inline]
+    fn divns_constant<const DIV: i64>(self) -> i64 {
+        self.to_ns() / DIV
+    }
+
+    /// Returns the number of nanoseconds.
+    #[inline]
+    pub fn to_ns(self) -> i64 {
+        self.inner
+    }
+
+    /// Returns the number of milliseconds.
+    #[inline]
+    pub fn to_ms(self) -> i64 {
+        self.divns_constant::<NSEC_PER_MSEC>()
+    }
+}
+
+/// Returns the number of milliseconds between two ktimes.
+#[inline]
+pub fn ktime_ms_delta(later: Ktime, earlier: Ktime) -> i64 {
+    (later - earlier).to_ms()
+}
+
+impl core::ops::Sub for Ktime {
+    type Output = Ktime;
+
+    #[inline]
+    fn sub(self, other: Ktime) -> Ktime {
+        Self {
+            inner: self.inner - other.inner,
+        }
+    }
+}

---
base-commit: 768409cff6cc89fe1194da880537a09857b6e4db
change-id: 20240320-rust-ktime_ms_delta-74b00c9ab872

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>


