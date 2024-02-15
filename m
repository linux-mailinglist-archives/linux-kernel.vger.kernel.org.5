Return-Path: <linux-kernel+bounces-66707-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D83856073
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E1962822ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1856132C26;
	Thu, 15 Feb 2024 10:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wFlTZbAu"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FB212DD9B
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 10:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707993986; cv=none; b=Ty35SkfH+IJo7u5va7xYRhAVBlJN8n441Sv0vQvxyfb0YRc+BOKxgDZDmMaxsPV7kLASmoCiU0wYOdShS1xx84bn8IF2wBYZ3qxj9KHioNfih4ej4lxFn55oqULKvie6nRYJZHRtRxVdrZCbbP1tcwn4T2zfrI2bPfK2PBIzBu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707993986; c=relaxed/simple;
	bh=Wjpow9OdLAB7Tv+gTtRq4fdEi+a2MFCDQbMPfSnlgs4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Dq3OJkGTMhY4iK69fekA9McSGKStDOX/m005dHZ87+MIFF5Fd4XPa1CKxyC7pFymc3JEXS7Q+wN+RNzVz2nydB0LDpEKRUXBm8wlbbeo6t/Jen6HOeEyQ/Lyqf+wANieCHjkaJXq0QxmDYtXiX5ORD48kYo/tvgMWBteQon341A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wFlTZbAu; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-511a02e2094so560235e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 02:46:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707993983; x=1708598783; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uuf0w26zOY/ZYw+214pJM99jPH6tZMQ5JsKDNPkdddo=;
        b=wFlTZbAuj4mGxRER7NIF/dkONC45s0c2Bs+i1YP7dKhS7Lwv6M2Mqq46E/Y6AObTn3
         PUCLvdhlnmDt5RZjblaV4xpPmmU4QBILfSPIsjSK1RfcJfQRIPXAVQ7Ptp01WvK8MFzU
         zr6ismTStKvtssdxn68fwki5FlvSaaZEzYiOjZFjCZB7ylgp7z7IoCQtToH8YxsnG0w+
         lklLoUHKpFG7Dz0WZc1dNNCsH9r5Qz+X6o/p/lMMcP2Sx8JtSLXoqTR4AkV1es/jRGic
         8JCAf9MRJQ6zWEe2OzYTdH1OrbYZHlVvjVSiScAupO4HZgbw3gwCYdU0RX/voiIq8G7K
         Sxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707993983; x=1708598783;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uuf0w26zOY/ZYw+214pJM99jPH6tZMQ5JsKDNPkdddo=;
        b=nsekWHlbMG4xHEOGWe6twB6sXPbTV1n7ULu+ZWoV0n21pisoMcIybHOy4sbr1CEECE
         qKFl1dhvHvkBy43OmQ4IV828A9d54li1IOaT3sM7oNe6jWutEJaBjiJg6ZPiyesSPl6G
         IKLGqWnNn/3EgEebSWA1gAMOiSVczD+6uw2epnpA7oLezRF2G9FzUgqcnS5nYlHEiVig
         EARUsXcOSoK1g9oxLUHbcP+hgM6Oh1lEUJdUYjtvj4eIxU2loIUBU/27q2BCh0ofugRd
         GEEYYFR7stJbI5Ytha5+nXFa32OqeEgr9JQ39VANJuD7DoykI0s3H9m9vwFC9fT6VRan
         yKEg==
X-Forwarded-Encrypted: i=1; AJvYcCVqCrD9+2GTUCpG30erp4UxAapyDYQ6tGZuedg8koMwgC0ZmKsd3MoSJ01doQelKShDQurkrHAm4F7o7D5gqEt4hCVLLXUnCy7ddUOD
X-Gm-Message-State: AOJu0Yzhpv0iRg9PfYjcKVAIUs/8q1PIteGCWQIgEiRUy2xYSymsmXf1
	cFhCuUjEwQXyN8r8Atz8Vbp/jIDo+BeOvaXq7HlYm77Sf+LoLUv+iYkz6tz/3Kvm1NbwmTBbaTL
	Fr/icARybAU+UoQ==
X-Google-Smtp-Source: AGHT+IE9zG2u4vdtMqWFUcANs2kx7N8Qf7EJTWQ7H2i+KfsdbYhdQFfsxBZOUZ33yQE5Mqn8w3PW+3+N6KhH9bk=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:5f45:0:b0:511:7b36:b293 with SMTP id
 5-20020ac25f45000000b005117b36b293mr1491lfz.10.1707993982857; Thu, 15 Feb
 2024 02:46:22 -0800 (PST)
Date: Thu, 15 Feb 2024 10:46:01 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=3433; i=aliceryhl@google.com;
 h=from:subject; bh=Wjpow9OdLAB7Tv+gTtRq4fdEi+a2MFCDQbMPfSnlgs4=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBlzeqIUKpX/8JczXxuWtJZWfGOc5q5/Yw8LXTt8
 H+AO0fSVXKJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZc3qiAAKCRAEWL7uWMY5
 RgeiD/0fIaUn7Rk7askqJtujymGJW1OjLrC+ofrwiSTKw6Ug6sKA/N4UNLrhTazCtGC8mZzRzxZ
 qO2it4Posj+hFgba2Khi6wXiLXq3PTtS/oK2jx445JBzBYT/qUSdSP4NlgX8NcUZrynlnOg4bek
 2cYrUvE379rQ0Xa7ZTWDp8b3jrnD/esGFgkcbg8bn1nyl4fbJ1djLD/m7jFSV/5yBsysSq70dJy
 fGvXIiPXEm1hWv/BTCiknyTCt/koiFbodfR6svLIhBO4WMS7g6NH7IoA3L7EqXN3ko3WmghCUYp
 S3//21tc7oagChhHosUQsD2IjxAheQ4slYbULjdgGdrBiuAt162ONfuxvW4kj2Xoxos95KYjTng
 l3/fcnyFu96tYqQS3PPyTrBXrCePudJyUcFZabeulNOhSthJIONERJV28xL6p/lxUlvWqYdrxB+
 Y6+8sORRJMOxDP8pPo7kN9aQBhQvv92VhkMnY/LbLi6cQcdwUhDLT/TEtwtpzbb3zPhNiqto4tG
 eeMgHsmjKhpuXjhY1I+7IFp9zXFk1c/IFNzpyZaul9RGVTuRZSNdx82zaHtazPdSOeeZ99Yo1zq
 UPJopjCZZN/fHMzmvMQbw37m9B7R6NEZVnmxsjmqom6qhUCMW0ZN1lFYW03Dv/8CJPen01daNbz XwEVrlBhaPXZG4g==
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240215104601.1267763-1-aliceryhl@google.com>
Subject: [PATCH v2] rust: stop using ptr_metadata feature
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>
Cc: Martin Rodriguez Reboredo <yakoyoku@gmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The `byte_sub` method was stabilized in Rust 1.75.0. By using that
method, we no longer need the unstable `ptr_metadata` feature for
implementing `Arc::from_raw`.

This brings us one step closer towards not using unstable compiler
features.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Reviewed-by: Trevor Gross <tmgross@umich.edu>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
Changes since v1:
- Reword safety comments on metadata.
- Instead of casting directly to `*mut`, use `cast_mut` for changing the
  mutability of `ptr`.
- Added Reviewed-by tags.
- Link to v1: https://lore.kernel.org/rust-for-linux/20240205091842.2858516-1-aliceryhl@google.com/

 rust/kernel/lib.rs      |  1 -
 rust/kernel/sync/arc.rs | 16 +++++++---------
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b89ecf4e97a0..b8d4c8167a29 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -17,7 +17,6 @@
 #![feature(dispatch_from_dyn)]
 #![feature(new_uninit)]
 #![feature(offset_of)]
-#![feature(ptr_metadata)]
 #![feature(receiver_trait)]
 #![feature(unsize)]
 
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 77cdbcf7bd2e..a74e1963d89d 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -30,7 +30,7 @@
     mem::{ManuallyDrop, MaybeUninit},
     ops::{Deref, DerefMut},
     pin::Pin,
-    ptr::{NonNull, Pointee},
+    ptr::NonNull,
 };
 use macros::pin_data;
 
@@ -239,22 +239,20 @@ pub unsafe fn from_raw(ptr: *const T) -> Self {
         // binary, so its layout is not so large that it can trigger arithmetic overflow.
         let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
 
-        let metadata: <T as Pointee>::Metadata = core::ptr::metadata(ptr);
-        // SAFETY: The metadata of `T` and `ArcInner<T>` is the same because `ArcInner` is a struct
-        // with `T` as its last field.
+        // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
+        // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
         //
         // This is documented at:
         // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
-        let metadata: <ArcInner<T> as Pointee>::Metadata =
-            unsafe { core::mem::transmute_copy(&metadata) };
+        let ptr = ptr as *const ArcInner<T>;
+
         // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
         // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
-        let ptr = unsafe { (ptr as *mut u8).sub(val_offset) as *mut () };
-        let ptr = core::ptr::from_raw_parts_mut(ptr, metadata);
+        let ptr = unsafe { ptr.byte_sub(val_offset) };
 
         // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
         // reference count held then will be owned by the new `Arc` object.
-        unsafe { Self::from_inner(NonNull::new_unchecked(ptr)) }
+        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut())) }
     }
 
     /// Returns an [`ArcBorrow`] from the given [`Arc`].

base-commit: f090f0d0eea9666a96702b29bc9a64cbabee85c5
-- 
2.43.0.687.g38aa6559b0-goog


