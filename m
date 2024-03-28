Return-Path: <linux-kernel+bounces-122289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC1388F4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:36:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F1B1C311C7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:36:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452A122092;
	Thu, 28 Mar 2024 01:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BK+fOvGB"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FD028383;
	Thu, 28 Mar 2024 01:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589788; cv=none; b=HkGBcWuyoLqh6tUxSKW7QSzUoNJZruVqK3lSwndX5txi033y4q+C+1c3CMKnbesXqY6+uk5bZBVHaRHjjqmMf8whqU8/OHLtqMipr2TEzzTRrSPNvJcqZPs3ugAogBdiCG4LFSILmDFa9xjag2LBg9KcbZBE+Znt3cWfq0VUlNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589788; c=relaxed/simple;
	bh=9bY/01nQfujhnAw6vfZnReH+IS6tLJy+9q2+XvoORMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hdrrEdrf/+iIso3gY+LQhuekXtMAYuLV8DVt0D7CpH5D/w5kTVR/HAcsevoFCp43ZEvLJKKqGS/xg1WjtEJjGBnTi5DESjysXeJ+4st6iFfhd+sTLuVlHT4U+FG2w7Co+2xmuMqhduatbXzFl33tds1IBJSclEzLCbC0AClYdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BK+fOvGB; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5dca1efad59so273079a12.2;
        Wed, 27 Mar 2024 18:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589785; x=1712194585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDegCott8ZWfk5B0pwuSaRcFQkCebYjnesGjrc5E3fo=;
        b=BK+fOvGB4N1osEzAnwfNj99y+3yNQ3gA5AwjA2ZhraNF3iARWFi+f8h2dL/DQYPrgA
         c+aM5gBd5FmUbXxcvHrd389rfjvjIreJiPKSMxdYdsI8QraoGGDM92CvY4DlQtkKPe64
         61xBovhuA9JQy1SgTUo5hdEtDUGx7KzXMG0bLoBkpjITm403GKDCJl8vRZXi1iF1mXI0
         fQN5W5yxPt/ruwXHVjv24TikEItjUVFJ8SYtr6wk4lDZd7ZBGdlknaRk6Ph8kSbqy3fF
         tLVjGsEVWaT7wODh2BfvUI0AXpyRNSR9lDP5zFStsKWwGTMcvGoM1pGpqFQi5mfV8gyY
         u+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589785; x=1712194585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDegCott8ZWfk5B0pwuSaRcFQkCebYjnesGjrc5E3fo=;
        b=clRHmYaSZ8XAecFyYdNhGqv5+Z+N7+qAVartLZyOPAWZB83Kf+2Pg3tBL1cfK/H4u6
         0XpSBtmY4K2hgS754nN/zr4VCxah7MnwGahmSd90K/tf2K4voVErz0PRrjx8BsWVT1aC
         LiveDx1CCYahKcc/H/xxA25NoqDsvLPKv3KI9AyiZ3mBrL3qleCsE/Yhn3+Hw3E4eMyL
         DVTSdCgsz90TNP9bjM8xxVg22CxY8IpWR0jfUMcG7RbElJfou86FS65DR1MBOnkCPGtU
         Atdp+S5lgxjsW3QkD7KWEabYXhHPy43sj0LOz28PXBaQeLJrtdERj67O0E3mTXbksHDF
         r+oQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXPsldttfXKR94TH4ETQdhtB1AWusrrPONrnEwR3eHlgAuS96Ma7HMGMx4CzxQGOENQzYQCqwko8CBWbVPy7bv5OvLTOGxPpp8Lpys
X-Gm-Message-State: AOJu0YxlpX2iMs9SG3dVCi/8K2QdVg/FPCUJ4ZjMwrwDP7M+wLQ2eF7H
	PLX/ifkJbRFl5Mq7HvXsGWawsnOQtqG2gz4dhmMZ6PijUVLko0PD8EbE7qnX
X-Google-Smtp-Source: AGHT+IGd6zq9Pu+z9klnJTs/yi/Jf50lCX4vDpWvAlY4ITK5iPH9FVD+wv4Vq9LasjatG2e13J9QcA==
X-Received: by 2002:a17:902:e751:b0:1e0:b60e:1a33 with SMTP id p17-20020a170902e75100b001e0b60e1a33mr1483092plf.31.1711589785290;
        Wed, 27 Mar 2024 18:36:25 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:36:25 -0700 (PDT)
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
Subject: [PATCH v3 02/10] rust: alloc: introduce the `VecExt` trait
Date: Wed, 27 Mar 2024 22:35:55 -0300
Message-Id: <20240328013603.206764-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328013603.206764-1-wedsonaf@gmail.com>
References: <20240328013603.206764-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

Make `try_with_capacity`, `try_push`, and `try_extend_from_slice`
methods available in `Vec` even though it doesn't implement them. It is
implemented with `try_reserve` and `push_within_capacity`.

This is in preparation for switching to the upstream `alloc` crate.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Suggested-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs         |  1 +
 rust/kernel/alloc/vec_ext.rs | 48 ++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs           |  1 +
 rust/kernel/prelude.rs       |  2 ++
 4 files changed, 52 insertions(+)
 create mode 100644 rust/kernel/alloc/vec_ext.rs

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 9aa5077d4a4c..2c99635f9fd3 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -5,3 +5,4 @@
 #[cfg(not(test))]
 #[cfg(not(testlib))]
 mod allocator;
+pub mod vec_ext;
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
new file mode 100644
index 000000000000..311e62cc5784
--- /dev/null
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Extensions to [`Vec`] for fallible allocations.
+
+use alloc::{collections::TryReserveError, vec::Vec};
+use core::result::Result;
+
+/// Extensions to [`Vec`].
+pub trait VecExt<T>: Sized {
+    /// Creates a new [`Vec`] instance with at least the given capacity.
+    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError>;
+
+    /// Appends an element to the back of the [`Vec`] instance.
+    fn try_push(&mut self, v: T) -> Result<(), TryReserveError>;
+
+    /// Pushes clones of the elements of slice into the [`Vec`] instance.
+    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    where
+        T: Clone;
+}
+
+impl<T> VecExt<T> for Vec<T> {
+    fn try_with_capacity(capacity: usize) -> Result<Self, TryReserveError> {
+        let mut v = Vec::new();
+        v.try_reserve(capacity)?;
+        Ok(v)
+    }
+
+    fn try_push(&mut self, v: T) -> Result<(), TryReserveError> {
+        if let Err(retry) = self.push_within_capacity(v) {
+            self.try_reserve(1)?;
+            let _ = self.push_within_capacity(retry);
+        }
+        Ok(())
+    }
+
+    fn try_extend_from_slice(&mut self, other: &[T]) -> Result<(), TryReserveError>
+    where
+        T: Clone,
+    {
+        self.try_reserve(other.len())?;
+        for item in other {
+            self.try_push(item.clone())?;
+        }
+
+        Ok(())
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 51f30e55bd00..7f2841a18d05 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -19,6 +19,7 @@
 #![feature(offset_of)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
+#![feature(vec_push_within_capacity)]
 
 // Ensure conditional compilation based on the kernel configuration works;
 // otherwise we may silently break things like initcall handling.
diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
index ae21600970b3..c85b5972c0d3 100644
--- a/rust/kernel/prelude.rs
+++ b/rust/kernel/prelude.rs
@@ -14,6 +14,8 @@
 #[doc(no_inline)]
 pub use core::pin::Pin;
 
+pub use crate::alloc::vec_ext::VecExt;
+
 #[doc(no_inline)]
 pub use alloc::{boxed::Box, vec::Vec};
 
-- 
2.34.1


