Return-Path: <linux-kernel+bounces-108733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16B4880F51
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9ACAC1C21FD4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5C03C466;
	Wed, 20 Mar 2024 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TSNvI2A6"
Received: from mail-lj1-f201.google.com (mail-lj1-f201.google.com [209.85.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F33BB36
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710929334; cv=none; b=QUKt0/Us6FYGIVLQNWmmRmO4wzw0rn013kXjUOppewnvAu9MHAFM0OtSNyjl+aA8boAScoAQTII0txZbbvo9n3bXmGDKYpUse9sspvS869VVZR1Ee94LNrJVhYzZS1KFtM8yscYqFZG++RyZWKlvngB+GKvQ1ZXqOlorMct6/XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710929334; c=relaxed/simple;
	bh=dsikV6HHaefXhxzLYHXv5UeUFSgszQgEUBeMyO6ZNdQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aNPkcZu6tWPQ5NlFx4GCqe17kkt2VMJQuMFAAZd/hj+CYQHQ/15zhbue+UL+LgPRarP9QmUlYvD+/6/TyIVNpBgKCQxzuHXm16NBaIfsZCRgt0LxMzGMvIMkgx3lGmvUcGFoJLPHLKway9KzzqHzNgUk5UWhvzGPr6BBPLIaJso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TSNvI2A6; arc=none smtp.client-ip=209.85.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f201.google.com with SMTP id 38308e7fff4ca-2d499513d62so34959121fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 03:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710929331; x=1711534131; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8FtFKTpG+fJZqrpFDR60HPuFRsB2Dp3iCYSe7eAKvzg=;
        b=TSNvI2A6AUVh1y3ESB0Fj24Gu2gZsayRWXU7Xi2WRWPLpn30UN3bWCeJ5in8x5pYH7
         rS+Bw8H/56iyDuaBVEVpG+jKBvJh5hJQ37/fskG9Nm75TgMymr3Vz2vqxHzyiuob5auH
         SNjMTuRmOyHmTwSddtw70/Np7JZrosEeFzZn8O/ywJt+V/qrAZE5k3y8tFTUxSAFEeKr
         rwnKetjFjLseIZvYpb+YVB7YVLw/CoCYEUXJH9bQOhTYamppgfLpThMoxqyO8EvC8vyY
         pSyNoQrp5NB8bj6H/mVke7HqSpB5F6rucW4lncPWGxzchm2E1i9Rxvy4cSToyM1yvdE4
         SrLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710929331; x=1711534131;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8FtFKTpG+fJZqrpFDR60HPuFRsB2Dp3iCYSe7eAKvzg=;
        b=vdKN2/JgyN2wOVS7g+sdvd9kJsMTNwq9dOac95KqeDd1EBJflHRTYRmVwkxPOR0u2K
         cfB9t5MtI+6IrQcL40/Lx97doPoprCVOBbehvmLAyol0KQjnX+gh/X2ZHBk5NoBeC+ng
         W2jmis79kglC9WKSVQKMYn83LHwIrF2kuX+9IilL1BXRqGoqa5cb9SLxWroR7u315DbV
         e8hduxGzavr++15FOn6nZ2DdAzd/V/ETJx/cCV9qNSobUD2VcJSczbhXhPOuUSOxRoG9
         EVhF2diqKMRPfilLHSGfbiMfqPgiinWSL9B8sZpkMjOKvqOUjFg5viElZq5qYW3wyUaf
         LRag==
X-Forwarded-Encrypted: i=1; AJvYcCVtIsTAW63frIzZTrO9hbB29crA/62YfnHzVdgok6Mb51zCQcM/NsZ/CJMeNy8CYETZQnl5m8HVpLxHmTg2EFdZ8Xo40H48VkBTtwQU
X-Gm-Message-State: AOJu0YyoHm4Ur/wRR64vlp0UhiIVo7FcCiuMc/2tJHKhGuseSoeILnj/
	Q+qiO1F/8Aqtz1K5vXJVZsb9YJPRARuK4PU/MEx8VibzcJQNiPNk8JeZZi2vIwoloLcCgdiLFOD
	exDDdkfAh+i6vNA==
X-Google-Smtp-Source: AGHT+IEw+6fkLpG9/sHjTwt0dVYYUXys5WdUg2chf3xXBucDE7JuRZYpka2H9ZWYkbxdIIUsrZewbA4OIecFIto=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3c8e:b0:515:8856:121 with SMTP
 id h14-20020a0565123c8e00b0051588560121mr2109lfv.9.1710929330802; Wed, 20 Mar
 2024 03:08:50 -0700 (PDT)
Date: Wed, 20 Mar 2024 10:08:45 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKy1+mUC/x3MSQqAMAxA0atI1hZiFRyuIlKqRg2ONFUE8e4Wl
 2/x/wNCjkmgih5wdLHwvgUkcQTdZLeRFPfBoFFnmGpU7hSvZs8rmVVMT4u3Ks9axK60bZFrCOX haOD7v9bN+36sRy7NZQAAAA==
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dsikV6HHaefXhxzLYHXv5UeUFSgszQgEUBeMyO6ZNdQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl+rWvsv3i51cmcXwxFaAJMqx26XB5MxEAJRqIm
 CFdHV9AhwWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZfq1rwAKCRAEWL7uWMY5
 RvZED/9sOln6QF5b9/9VtU9m4v51vVAyULZtziciiZryljVVj9tzSGN6cGylE8hM82k81887ggu
 hQSGjlzgFYudz/rTX4AXnkxLo7A2RUpF43cRcJm9KDZMlV0c15rgKK38Q/woYOeKQxQfGH5dMvB
 yIRs2u8FXDGvquY7ouLUQjBrTe3pINWrKVeMkSAbYJrSt+ziUxTY0HJ69Md5vTXhNbWiNwI2yRw
 wYxeci83RIrYd1HEOQC0m6m3n1EFyL6/M6V87zzlegkLn5WQkWzDPUUwuGB7fGxxrSVdpUlBZ1C
 zvqw1D0EirGX7KHYFg/9LzsKr8YxZQp1EBpPcYiyhSQFvs599F72xeST5orVQ7kwhKzTRitRvtc
 Q2h5dg0y0wzHLqrf39IIXDaKsfhoeDVO8u2GIaf1PwMQ/phHcD+GVCM25P8A0PyrXMnNxgMbFCb
 ki4Ch44dsEKF/63yjAZBANXR5SR8/C8MC3j5hknR1Hi9P+be4KjE4AaxggHdrDaQd9LvTB5Eu0X
 KqbgiT8nzZY4OCPfjoMQ8c0No0ZP1Po8p88KraYv1q6EqhxCIlwL9LHQduNOpkLqzzxaosP2Dg8
 Inp+mTHs24mzeDf7NUg5nVVMAfZ9T7vBNqm2ltGGNLPQy6SUZUUUbtPSsWRq+VP7uyPu7r08v9e I0aunXke90cEBww==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240320-rust-ktime_ms_delta-v1-1-ccb8672a0941@google.com>
Subject: [PATCH] rust: time: add Ktime
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

For a usage example, see [2].

Link: https://lore.kernel.org/lkml/5ac8c0d09392290be789423f0dd78a520b830fab.1682333709.git.zhangchuang3@xiaomi.com/ [1]
Link: https://r.android.com/3004103
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/time.rs | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/rust/kernel/time.rs b/rust/kernel/time.rs
index 25a896eed468..ac8b35f662af 100644
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
+        // SAFETY: It is always safe to call `ktime_get`.
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


