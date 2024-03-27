Return-Path: <linux-kernel+bounces-120232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC9388D4A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2163E28425A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 02:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44722C6B0;
	Wed, 27 Mar 2024 02:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="loBNYcQA"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2D22C68B;
	Wed, 27 Mar 2024 02:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711507000; cv=none; b=czEY8rCxTsR6QsezsfZg46Y70DTMjvJ1LP4bpWjKpnm4GyvVZ6f5P2ESFMrol3MHMmcG/qgSsbnA7z1CIfQ3I7iNV2BS+tIcPsfv5dW4ytleg184TqzS6LhzrTQV6Y6rw6PTLulaf326iaF1+COeDVqwBaslV2oRqL4k9q2JILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711507000; c=relaxed/simple;
	bh=b9alF6sEGnAWF3DsTbS3LyfyRWGhyBPjFkyJBWiDY+U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h1rJExApjP7O85t6xkSlvhKiJUx06KYBD7cs2X9/7yU3NkHKtsDL2qFDYmObwbnmZgcTNPsGm34OIr3owaxgI9pNMjVJSH+8cW1ezMbzz5HcmeIRbAkCoDRqwrw45VmpizLO1ypBO9cL/+LlcVgTg1t/OwwhG4PwMXzn2nnRhGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=loBNYcQA; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso4439627a12.0;
        Tue, 26 Mar 2024 19:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711506998; x=1712111798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQoBOKp3EwJBmRTdBR9tFZY4h3sKJNPj+YlazUqopAk=;
        b=loBNYcQAthazen8uJ/UfQrjk5FXJ8ykUZQ7ecNaRRs4SJgHJIxk23mD8wiCCSUgLeB
         1Yehl1XjAM+ZkGv4gj6d1y/yqYVZhfBBYnAQ21+3gb4uWIXnucJScVfhkB89p3HkXWZj
         /bGj3HQjIT/mXD7o+C2ojqIcIgZKb65aueMiQOPPSp97WFnJyRw0Ef+rOrkyUjVGZMmV
         VmEmTmoKBLXSnLHZVd/N12WD8ql+EoiETeyhP/wsFfXBEaI/IhJ2VAJ9JgeCpeQh0bxz
         TA3oeffEAq/ROVp0nbrZNhuSfdkKRQnEFc0vEHi3K8ebu2zLPJC92M+eS+71U300Tpoy
         mzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711506998; x=1712111798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vQoBOKp3EwJBmRTdBR9tFZY4h3sKJNPj+YlazUqopAk=;
        b=mjOo4tM6rhfU78uGuSENM1oL0MSHIukIppLYnz1mhiYmYPVaxhxfFg8i1pvF0JRKjP
         7u0d0Nuz1tht2d4WQW1kl/QLRT1cfq3gWLPq+6mgNgM1m1U0ZcGxXsJE2IcGszsfHqcS
         bSkxDxLSxLNvJEW7n8fNRXpjYjPWLiQaPaMHHvW3yuscp9D/IsCN94qzqNcwhJg2rP3k
         IBe3F01NbrCPzTNii0WYF4B/ZMbN5DB5R0ljKNhLiluK29W+Ki0WkF4VgR8Y9d/fAD2M
         IbVZV41VPbxdOKQqdkJEsppNvyHe9B1Sym4hxcdcDOd186yz2GDpLQHn5hUfJGufjI0N
         J83A==
X-Forwarded-Encrypted: i=1; AJvYcCVu/zyjqAashgCBHMPvTDJ7Y8c+bbcB7rCmLaeRO79bXkviHvLwywz+IPljNSqoAOJRC4apLSOM1d6aNh6q8b/uuQIkTeTOHlMHAWyb
X-Gm-Message-State: AOJu0YwJaomUSRZXfU6ouw36rkAZUwg7ewHSFog035XE3QAv7Q1jjYCp
	QSgl5yyO8Hh0cSGlIeG4tGkBpQuoO0OVZffwwdOWNmTXCXhLJ6LZdKrRnQqO
X-Google-Smtp-Source: AGHT+IFWY2mh0CdivaeSNw4Td6JCtleJ4YJWfrzPeRqtVxSTyTnVsH8BTJXRS8fp1B4JFwtj2CsSQg==
X-Received: by 2002:a17:90a:6d61:b0:29c:b540:706b with SMTP id z88-20020a17090a6d6100b0029cb540706bmr10445973pjj.17.1711506998404;
        Tue, 26 Mar 2024 19:36:38 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id l20-20020a17090a409400b0029b2e5bc1b9sm347441pjg.23.2024.03.26.19.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 19:36:38 -0700 (PDT)
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
Subject: [PATCH v2 10/10] rust: kernel: remove usage of `allocator_api` unstable feature
Date: Tue, 26 Mar 2024 23:35:31 -0300
Message-Id: <20240327023531.187880-11-wedsonaf@gmail.com>
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

With the adoption of `BoxExt` and `VecExt`, we don't need the functions
provided by this feature (namely the methods prefixed with `try_` and
different allocator per collection instance).

We do need `AllocError`, but we define our own as it is a trivial empty
struct.

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
index a4c4b1f79bc9..5b35786b6279 100644
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
index aaa6a20d12b6..8dad58f23b11 100644
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
index bb6cb1c4ea67..25305ff2fac4 100644
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
index 09a0f158ff1b..50837e56efc7 100644
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


