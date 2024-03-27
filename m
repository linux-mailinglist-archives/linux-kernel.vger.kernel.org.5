Return-Path: <linux-kernel+bounces-120226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 974CD88D49B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0F76B22F31
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7289621101;
	Wed, 27 Mar 2024 02:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AUwTWvFO"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB4A24B4A;
	Wed, 27 Mar 2024 02:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711506978; cv=none; b=B57IGDUKi5DhZeTQQodk/xJcWvSQOVOOiZy8QYFcZFDvJSj1K12k1ZkjcTrV/RmqyNmN5yFwDecDKW2rhdSuyDX2502Tj1J7Hphgmi72fdKjEitEI3Sf2PnNwnUklIYPkS+z3F5lHfR9fkxETXSwBbvpYfHtOvdz5R1rBKQqA5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711506978; c=relaxed/simple;
	bh=0fCsGNf1188vA6CAE01UEQquzZhM0FfzVV+EIiO8TSw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U78qXQktTaxoM4xyh92NXVgee88ZvbWEGZwjghpkr3ZuackfDz8w2ijTfZiYyIb9SmZG7xdQad6Nzayhwf1oYyodtWzcKYz5rLsMHMyWyqtFz2Y0HAAfcg+eRh1PsJxLphIRYus8cnqpoQf03zENBF11BeUKYE1flSGEIH/ykhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AUwTWvFO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29f93c4946cso4194993a91.1;
        Tue, 26 Mar 2024 19:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506976; x=1712111776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nOGf5fpM64u9bq6Y02DKyESI+dcDeLAOylIn1hPVDk=;
        b=AUwTWvFObc6H3SOcovV3oRkKroYCa/OovYPqu+jheqpTP876WkJ4sXU8S4Jq4QKPWJ
         /+8TGBH94qJN++57lq04FK5HKxP1acpCM2uT8q7Zln5MWHmaWYpMXqug7AQMw999M3Vk
         8vAO/c4IeLOM3P6H71ultmiZ5vhYUxZ5thIgkZrld2xJJ7AqjtyFQQTG/LJIiFXVaNMQ
         X08lCS7ITFwiHGSCrMO/Q+gVsuu/MKNK3p5feH8UJjfpm0RPCluZ+kEPrWbkeoZmh7X9
         s5ZdQrpiKXsdiuFkcimKK/G752oJ9WBZqzLuFXJKdKx0tQULewjr5rbpN1MMnK0gkopn
         SRzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506976; x=1712111776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1nOGf5fpM64u9bq6Y02DKyESI+dcDeLAOylIn1hPVDk=;
        b=qRdDlykf++C2gUreYvk3zYV1maDgGrVhiq5AQSDpNVl9pvw4gyrnrgVJQ67Gx+NRco
         icJX3m6GTsI1qUmj8g+fqbMej6pB4Hhtw2+fJE/mEYqdSQ+A1jbW5mnWlpQd95AgxTYh
         bqwUlX1WCP6wbPa1DFlYf9FfMdT94bUAWEdf1XfORz/PjbH6Ly8mrMU0jH3XIrW6fmmO
         8v5zx/5+MTVK9Az0MUgTxIrj4zKIcGYzjSrsWQfPRN2pweHf8a755SeDFVQ99BE1wdN8
         tjDcXbIDFOtgYwoTWY570VDH9jMnN2t6G52VBACCZszkYMPysK6D/DtvpU7aS6vmRth5
         aBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXViiolvJCmQIg+d7a0p2qfRJa1EOEh7KnOXorJdGjDjrom3kTQqhMJDJIXu188D3wGdO3s8AJJD9oTGRHeQ7H6lZrHC/8fgE0dyEvZ
X-Gm-Message-State: AOJu0Yw7O3fhNx6OltHPyN9FsK32wCDexf2b93K+SMtTNj/N0FGmnFKU
	CCdN9HVuiib+L2MGxJVTyfqPw/SCE+2tXnNBP1mungw7/EeJh5jYA1c4wB7j
X-Google-Smtp-Source: AGHT+IFmQvoPLIdrjBKDhCQTw0wXy6EPV4pLT8wSmz0VmoB7JynqXBk1OHP6LF8DHlR+cZ2rpcurHQ==
X-Received: by 2002:a17:90a:d3d6:b0:29b:9d98:5388 with SMTP id d22-20020a17090ad3d600b0029b9d985388mr1516802pjw.12.1711506976293;
        Tue, 26 Mar 2024 19:36:16 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:15 -0700 (PDT)
From: Wedson Almeida Filho <wedsonaf@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>,
	linux-kernel@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH v2 05/10] rust: alloc: introduce allocation flags
Date: Tue, 26 Mar 2024 23:35:26 -0300
Message-Id: <20240327023531.187880-6-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327023531.187880-1-wedsonaf@gmail.com>
References: <20240327023531.187880-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

We'll use them when allocating `Box`, `Arc`, and `UniqueArc` instances,
as well as when allocating memory for `Vec` elements. These changes will
come in subsequent patches.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/bindings/bindings_helper.h |  3 ++
 rust/kernel/alloc.rs            | 56 +++++++++++++++++++++++++++++++++
 rust/kernel/prelude.rs          |  2 +-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 65b98831b975..ddb5644d4fd9 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -20,5 +20,8 @@
 
 /* `bindgen` gets confused at certain things. */
 const size_t RUST_CONST_HELPER_ARCH_SLAB_MINALIGN = ARCH_SLAB_MINALIGN;
+const gfp_t RUST_CONST_HELPER_GFP_ATOMIC = GFP_ATOMIC;
 const gfp_t RUST_CONST_HELPER_GFP_KERNEL = GFP_KERNEL;
+const gfp_t RUST_CONST_HELPER_GFP_KERNEL_ACCOUNT = GFP_KERNEL_ACCOUNT;
+const gfp_t RUST_CONST_HELPER_GFP_NOWAIT = GFP_NOWAIT;
 const gfp_t RUST_CONST_HELPER___GFP_ZERO = __GFP_ZERO;
diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 2c99635f9fd3..0502bcf00bce 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -6,3 +6,59 @@
 #[cfg(not(testlib))]
 mod allocator;
 pub mod vec_ext;
+
+/// Flags to be used when allocating memory.
+///
+/// They can be combined with the operators `|`, `&`, and `!`.
+///
+/// Values can be used from the [`flags`] module.
+#[derive(Clone, Copy)]
+pub struct Flags(u32);
+
+impl core::ops::BitOr for Flags {
+    type Output = Self;
+    fn bitor(self, rhs: Self) -> Self::Output {
+        Self(self.0 | rhs.0)
+    }
+}
+
+impl core::ops::BitAnd for Flags {
+    type Output = Self;
+    fn bitand(self, rhs: Self) -> Self::Output {
+        Self(self.0 & rhs.0)
+    }
+}
+
+impl core::ops::Not for Flags {
+    type Output = Self;
+    fn not(self) -> Self::Output {
+        Self(!self.0)
+    }
+}
+
+/// Allocation flags.
+///
+/// These are meant to be used in functions that can allocate memory.
+pub mod flags {
+    use super::Flags;
+    use crate::bindings;
+
+    /// Users can not sleep and need the allocation to succeed.
+    ///
+    /// A lower watermark is applied to allow access to "atomic reserves". The current
+    /// implementation doesn't support NMI and few other strict non-preemptive contexts (e.g.
+    /// raw_spin_lock). The same applies to [`GFP_NOWAIT`].
+    pub const GFP_ATOMIC: Flags = Flags(bindings::GFP_ATOMIC);
+
+    /// Typical for kernel-internal allocations. The caller requires ZONE_NORMAL or a lower zone
+    /// for direct access but can direct reclaim.
+    pub const GFP_KERNEL: Flags = Flags(bindings::GFP_KERNEL);
+
+    /// The same as [`GFP_KERNEL`], except the allocation is accounted to kmemcg.
+    pub const GFP_KERNEL_ACCOUNT: Flags = Flags(bindings::GFP_KERNEL_ACCOUNT);
+
+    /// Ror kernel allocations that should not stall for direct reclaim, start physical IO or
+    /// use any filesystem callback.  It is very likely to fail to allocate memory, even for very
+    /// small allocations.
+    pub const GFP_NOWAIT: Flags = Flags(bindings::GFP_NOWAIT);
+}
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index c85b5972c0d3..827e4dfd77df 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,7 +14,7 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
-pub use crate::alloc::vec_ext::VecExt;
+pub use crate::alloc::{flags::*, vec_ext::VecExt};
 
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
-- 
2.34.1


