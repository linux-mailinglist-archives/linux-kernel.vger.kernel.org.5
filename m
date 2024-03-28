Return-Path: <linux-kernel+bounces-122298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C3E788F4CE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 02:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 896A81F30EB6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA2139AE7;
	Thu, 28 Mar 2024 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+e0xgJA"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E21383A6;
	Thu, 28 Mar 2024 01:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711589832; cv=none; b=Nm3T6PqkACutPewTzyCFoMCbUExjo36Q1VdjUT0nbFXStGq244brfao3P4kJ2Y0CVEYjseQmOGiJO7YHEjgYj0p+y/oazRiLAdJJX2z7pMJ1LTOvXBYI3QD1dgtyOvenZNl/qAGVdAFQN5cPrmQeym9JtnyutWmPe+kAdKgf1qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711589832; c=relaxed/simple;
	bh=hecEdBwkH//T2DYQVV1L1p9nZO41Fk5GzpUzQIrdEe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BeHpzVPglT/wOfcLRV0p2c/fWqTs+pbTVJnXb4NZjYJo2z3nzAHcUriVR7paPWADwFOc0rGx40AW7kYZNjseDHaNVyR4HyLDM7GynEDbFRfaw2xqiAeyKmXNe626Hclk2CEHS4Tyxk0lk+PNOFej49DIdfXwxQvZpT4BJrgioro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+e0xgJA; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6e6b54a28d0so403905b3a.2;
        Wed, 27 Mar 2024 18:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711589829; x=1712194629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRq/DPtMtmFYTs0eCxCGxtVxSAGU8N1hSKxhmu5EXI0=;
        b=F+e0xgJAurWZfZSifj9kv7Mr7el5DtQvJVowMyla7+w5APqYIZ7vXjJl58SnrLIs7z
         eNpshThdRu32lJL9BohdnaQwCjiEhOUCs3MCaRaKSGa95PnMbzSihkGZE4bVhyehpyPq
         Jjx5PuBTd6mI6kAUQU7iHRTF0OVnIC9fiJIv8GzweXeWvKIDKX/wo1P8iJKY1M24eISQ
         DHJt4usYFPZDb7I8Cfc+imRw/9LWr0mVi7Ga/XqPqY/9MSvEtLxP75I5fC4MERZFm3Vr
         ToPLimh6Kz6g1lbCuTP54voRYNawIPCWR/D1OERHXYJLPKaTNIs9IQRsUns9j7r7rhk4
         DhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711589829; x=1712194629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tRq/DPtMtmFYTs0eCxCGxtVxSAGU8N1hSKxhmu5EXI0=;
        b=nH5mvpms7ZUY+bpk4GJPOhB5TpaeuaDciBvGVAZBmw7tfCpxpRa2/H+6Ous5Xnhoep
         sms75DEYoQRXR0KLJCkLf59H9ILk8mY/vdG6GdbfPsiztuANxKZQyoLAb1JFifsQIxLU
         ORXP8dJBDShKfH7A+Qvpq18C4YtCYlhIYZY77UDkn/Hy9dLFY+vCVfjfF/7sV6mCGHpJ
         TGYLLZDKSDklArtXFK6sHL7h19JOA3KgC41wPip9qajTbb9ZIY+dflbqquCxpieHPPe5
         +IXdhKYAJ60mBqBNjtxc1eTcPkh8As0i5+U0nvzBDRINROl9nw27HWfIQBrQmQPEm3Mq
         0ZNw==
X-Forwarded-Encrypted: i=1; AJvYcCUegIUprCDwUYhgopwg7RQvPRC6HFZb6WDkTElaKStv+bolCizu3f7AJ4FqRxiKY7xxlLxeRwuSDjrkHbmYy0N3XFZ7WJ01AteJqRdZ
X-Gm-Message-State: AOJu0Yyv3ZgO/C5xF1y0OilofMgXzJReJB/ipVjX5IFKBjdwVPWWo8tm
	j84OHe76UJKVaYkavGsX7r/U28hFy8dhFgtYdrlzjVWF87s05kBKrLvTpZgi
X-Google-Smtp-Source: AGHT+IHXWRPtsfXo2e/w22Acur0iDQucHQFC3vyTZzItCpiJpltcW5obal3AHcXgBGlJ6ShJqzVQbA==
X-Received: by 2002:a05:6a20:3942:b0:1a3:c58b:db13 with SMTP id r2-20020a056a20394200b001a3c58bdb13mr2229869pzg.49.1711589829506;
        Wed, 27 Mar 2024 18:37:09 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm189144plf.282.2024.03.27.18.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 18:37:09 -0700 (PDT)
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
Subject: [PATCH v3 10/10] rust: kernel: remove usage of `allocator_api` unstable feature
Date: Wed, 27 Mar 2024 22:36:03 -0300
Message-Id: <20240328013603.206764-11-wedsonaf@gmail.com>
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

With the adoption of `BoxExt` and `VecExt`, we don't need the functions
provided by this feature (namely the methods prefixed with `try_` and
different allocator per collection instance).

We do need `AllocError`, but we define our own as it is a trivial empty
struct.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/alloc.rs         | 4 ++++
 rust/kernel/alloc/box_ext.rs | 3 +--
 rust/kernel/alloc/vec_ext.rs | 4 ++--
 rust/kernel/error.rs         | 4 ++--
 rust/kernel/init.rs          | 3 +--
 rust/kernel/lib.rs           | 1 -
 rust/kernel/str.rs           | 3 +--
 rust/kernel/sync/arc.rs      | 4 ++--
 rust/kernel/workqueue.rs     | 3 +--
 9 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/alloc.rs b/rust/kernel/alloc.rs
index 9bc1b48b5641..f1c2c4aa22d2 100644
--- a/rust/kernel/alloc.rs
+++ b/rust/kernel/alloc.rs
@@ -8,6 +8,10 @@
 pub mod box_ext;
 pub mod vec_ext;
 
+/// Indicates an allocation error.
+#[derive(Copy, Clone, PartialEq, Eq, Debug)]
+pub struct AllocError;
+
 /// Flags to be used when allocating memory.
 ///
 /// They can be combined with the operators `|`, `&`, and `!`.
diff --git a/rust/kernel/alloc/box_ext.rs b/rust/kernel/alloc/box_ext.rs
index c62db0aa4dd1..3b48cfc70deb 100644
--- a/rust/kernel/alloc/box_ext.rs
+++ b/rust/kernel/alloc/box_ext.rs
@@ -2,9 +2,8 @@
 
 //! Extensions to [`Box`] for fallible allocations.
 
-use super::Flags;
+use super::{AllocError, Flags};
 use alloc::boxed::Box;
-use core::alloc::AllocError;
 use core::mem::MaybeUninit;
 use core::result::Result;
 
diff --git a/rust/kernel/alloc/vec_ext.rs b/rust/kernel/alloc/vec_ext.rs
index e24d7c7675ca..6a916fcf8bf1 100644
--- a/rust/kernel/alloc/vec_ext.rs
+++ b/rust/kernel/alloc/vec_ext.rs
@@ -2,8 +2,8 @@
 
 //! Extensions to [`Vec`] for fallible allocations.
 
-use super::Flags;
-use alloc::{alloc::AllocError, vec::Vec};
+use super::{AllocError, Flags};
+use alloc::vec::Vec;
 use core::result::Result;
 
 /// Extensions to [`Vec`].
diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
index e53466937796..fc986bc24c6d 100644
--- a/rust/kernel/error.rs
+++ b/rust/kernel/error.rs
@@ -4,9 +4,9 @@
 //!
 //! C header: [`include/uapi/asm-generic/errno-base.h`](srctree/include/uapi/asm-generic/errno-base.h)
 
-use crate::str::CStr;
+use crate::{alloc::AllocError, str::CStr};
 
-use alloc::alloc::{AllocError, LayoutError};
+use alloc::alloc::LayoutError;
 
 use core::convert::From;
 use core::fmt;
diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
index fec47b274ec3..9608f2bd2211 100644
--- a/rust/kernel/init.rs
+++ b/rust/kernel/init.rs
@@ -211,14 +211,13 @@
 //! [`pin_init!`]: crate::pin_init!
 
 use crate::{
-    alloc::{box_ext::BoxExt, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Flags},
     error::{self, Error},
     sync::UniqueArc,
     types::{Opaque, ScopeGuard},
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::AllocError,
     cell::UnsafeCell,
     convert::Infallible,
     marker::PhantomData,
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 51f30e55bd00..5c641233e26d 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -12,7 +12,6 @@
 //! do so first instead of bypassing this crate.
 
 #![no_std]
-#![feature(allocator_api)]
 #![feature(coerce_unsized)]
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
index 58f2ddafb326..dfd1c40d46a2 100644
--- a/rust/kernel/str.rs
+++ b/rust/kernel/str.rs
@@ -2,8 +2,7 @@
 
 //! String representations.
 
-use crate::alloc::{flags::*, vec_ext::VecExt};
-use alloc::alloc::AllocError;
+use crate::alloc::{flags::*, vec_ext::VecExt, AllocError};
 use alloc::vec::Vec;
 use core::fmt::{self, Write};
 use core::ops::{self, Deref, Index};
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 0866378f1360..c2a3a2c7cbc5 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -16,7 +16,7 @@
 //! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
 
 use crate::{
-    alloc::{box_ext::BoxExt, Flags},
+    alloc::{box_ext::BoxExt, AllocError, Flags},
     bindings,
     error::{self, Error},
     init::{self, InPlaceInit, Init, PinInit},
@@ -25,7 +25,7 @@
 };
 use alloc::boxed::Box;
 use core::{
-    alloc::{AllocError, Layout},
+    alloc::Layout,
     fmt,
     marker::{PhantomData, Unsize},
     mem::{ManuallyDrop, MaybeUninit},
diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 4d1f5306497a..dfbf1080ccec 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -132,9 +132,8 @@
 //!
 //! C header: [`include/linux/workqueue.h`](srctree/include/linux/workqueue.h)
 
-use crate::alloc::Flags;
+use crate::alloc::{AllocError, Flags};
 use crate::{bindings, prelude::*, sync::Arc, sync::LockClassKey, types::Opaque};
-use alloc::alloc::AllocError;
 use alloc::boxed::Box;
 use core::marker::PhantomData;
 use core::pin::Pin;
-- 
2.34.1


