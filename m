Return-Path: <linux-kernel+bounces-99187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AEDA8784A2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DC4D1C21251
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 410124AEEB;
	Mon, 11 Mar 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1AeZNPo7"
Received: from mail-lf1-f74.google.com (mail-lf1-f74.google.com [209.85.167.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A585D482D8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173315; cv=none; b=YzzUmT2WP/HwB5Mm9gizSmX7KNfPhLCncVwLhVlmU75npoDv3BdjCVTlzWIwXVQQxTbi7bkC4kfr9cMcJ0aY3ZPMPBL2l8t0PhSB9Uh4gHV/YaxqSL2iPJu8GLNNBdqVKhjnuyYn/LTpNZC49zSMeXVIZfNqLXpAtniael+haNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173315; c=relaxed/simple;
	bh=ybA3FjhWRG2ya5jZUlRwyys2swjjPxYnMn1ICqlxh7I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=geT4sHkFWAxU+tge1N6ypgYsA5j0iEb30oMyfsP21KwEAmFApnh7GYC1snmtbq1uetrEjsyLylaq/hU6tR0H/j/wO0jFPIquXYfpVG0/YuL/gREaZKg5C1GtyN4IRCO7pcZMXMBYw8VXU3PFzDT5DQQj0zL0n9zHOVM/BtOxV1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1AeZNPo7; arc=none smtp.client-ip=209.85.167.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lf1-f74.google.com with SMTP id 2adb3069b0e04-5131aa087beso2687262e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710173311; x=1710778111; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFhOHi9YbCrBYkKkhUSEcENknoxhZ94xXZCXy/0AOz0=;
        b=1AeZNPo7FPxcqkn6TYNRG/ihfUavljJTOq17SmbDKj+6gqk+oIYUVZVGMJNwhbpSgK
         ck3r3YB7tpxSdsw6yHA6OlRR3WHUrmIHrLH/r2kDff9rkEACHlg6EcwqTLL7ZdmBZLMG
         +supYnLiXM8fMcO4OC+eGPJ5XrJnK33C9aPOXWpQAG9rYURBR2OyY1+WPDFzHjd4YOQK
         8SDTGcz3PULLHiZfKGy3cUiNPOmu1nyoj+1lydUnf93k+G3znFZp3PP1wXhSd4sJf22x
         wJvTg5mqJS7YUJGur3TBu6KFVYS068Oandouv7zdFhFerHlCGFgTpjzIteBg/eRBwf5I
         L3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173311; x=1710778111;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFhOHi9YbCrBYkKkhUSEcENknoxhZ94xXZCXy/0AOz0=;
        b=JylILaes4bAnORcEw8kroiTU7mzHdVH7983HgoDcDqOkEKnqswc5OeYDJHyL7Lh2m0
         DP96EIzlfJt3PcLD8FMQ5LYZnxCsveSwLiHdaWkJihYRx2doMiQLjOGHaJMphOzpJ/tZ
         Tty6MbJDfh4TEDrEzDobIhlDhHy0ui1rGwZu2iff9bo8qhKK3ukXtRU0BMdOqfB1Rm/1
         VheXSVt8nkyk7/voUsziMG8sqSWJEbBjegCItlR6K+TsXHmGjUVfbPdLUqWyIswLGdUg
         lPAVVfjfPeUGhWc9VvauS3CR/AXj8oDZ4eaHFpNtfquif598E1bpHMtwCdBd29M3GmmS
         PgdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXu7FZLBQvcRWe0a6F7Emf5QjN+DMrzvMHiLBPNd5Fv0/BmFBL2P74UdkNJ/yXDiRRY5JnwrKE+Z8ubJCmyd0ceGWYW9QOwQ3k7lR/q
X-Gm-Message-State: AOJu0Ywi2rLcheE66jxaTJRH48gOlZn1XPm4ftJH4Sy5uFRYRHhc4zuf
	Azg5Dr48TDX9O7rkIPkKeFp3pysCS1kHbUr6jMohWiGhzPo1IRlGeVj3zBeMh6K8zxrNT8pBkTU
	Hw/2xzCHMOlwBFg==
X-Google-Smtp-Source: AGHT+IGcDgFawbpWrrBjGYWqlnWAXrsjov+pfSEbwfdjCV216E2thxSNwmF6c6IrtVLGlqxKSsuc9RKcq1uS7FI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:ac2:4bd5:0:b0:513:b230:e774 with SMTP id
 o21-20020ac24bd5000000b00513b230e774mr1423lfq.8.1710173310685; Mon, 11 Mar
 2024 09:08:30 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:08:18 +0000
In-Reply-To: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5909; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=ybA3FjhWRG2ya5jZUlRwyys2swjjPxYnMn1ICqlxh7I=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7yx3gMm5R8xT/QFPz2PbANYf5w80xX5dYYrxT
 g+p894IqJOJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe8sdwAKCRAEWL7uWMY5
 RqBnD/9lqiT6PeQB9SLi7y4MtszT2eMPC30lbqZRgfhj93k+GNQS+jACVasQudD4EYUKKF6Y8Rl
 Lw4QMzqRKbo0w7SXwrXAipuh8iT7AhZhojf3LjhTP6FbqbN9r4kTa+oCK4YCgE8j9ndk2pIn/IT
 BM914Inc49LOI1OrgU0ES5ZNgLNjAY4pq8JJXHMDI/yJvo1e7WOBWqN+NctfnKeXv1VWUVKsjea
 VEj9iwwcFjqxY+atl1cGrnrOfpeOVRkP0rhM5hd69LvfLN+69sUh1wWyKpH0OwCT8REqGILPfDn
 SPvW/1JsiSwdHeFRsBTUmid25TF/5bTpJt9vgCMhKMzdECCy85EeT1mjZXChGl1V8tO977P17yM
 dEXI6hKuIdbNtjambKo33N4N+5mwCqTCX17vvzFtCDTeLiZ71w5zTDZmc8xLcjWPRt7GRAnCb0+
 OzzBQSC9I/4/eto8G6F+1PftrVWNvakSLt74Bnv5XPZF6LpMXiKuNwUNTb+0mIJRCkTmxxZbd48
 qK7l67tDfP6utSJIhAOQYpOM9OMBbD55PJvu4wAuhoi6YJCTGIjRGm15mdNsUrPz23jd8DW4/ND
 7fdOG3ppAWZ4swQjUDh6Dd07sq1TrZhbdljw4IEr1zfTs2bO72UJmgzm22kNbySSR4dzrS/jrPZ +GAxCXclUJOTcZg==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-arc-for-list-v3-1-cba1883c62eb@google.com>
Subject: [PATCH v3 1/2] rust: sync: add `ArcBorrow::from_raw`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Allows access to a value in an `Arc` that is currently held as a raw
pointer due to use of `Arc::into_raw`, without destroying or otherwise
consuming that raw pointer.

This is a dependency of the linked list that Rust Binder uses. The
linked list uses this method when iterating over the linked list.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 76 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 58 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7d4c4bf58388..53addb8876c2 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -137,6 +137,39 @@ struct ArcInner<T: ?Sized> {
     data: T,
 }
 
+impl<T: ?Sized> ArcInner<T> {
+    /// Converts a pointer to the contents of an [`Arc`] into a pointer to the [`ArcInner`].
+    ///
+    /// # Safety
+    ///
+    /// `ptr` must have been returned by a previous call to [`Arc::into_raw`], and the `Arc` must
+    /// not yet have been destroyed.
+    unsafe fn container_of(ptr: *const T) -> NonNull<ArcInner<T>> {
+        let refcount_layout = Layout::new::<bindings::refcount_t>();
+        // SAFETY: The caller guarantees that the pointer is valid.
+        let val_layout = Layout::for_value(unsafe { &*ptr });
+        // SAFETY: We're computing the layout of a real struct that existed when compiling this
+        // binary, so its layout is not so large that it can trigger arithmetic overflow.
+        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
+
+        // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
+        // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
+        //
+        // This is documented at:
+        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
+        let ptr = ptr as *const ArcInner<T>;
+
+        // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
+        // pointer, since it originates from a previous call to `Arc::into_raw` on an `Arc` that is
+        // still valid.
+        let ptr = unsafe { ptr.byte_sub(val_offset) };
+
+        // SAFETY: The pointer can't be null since you can't have an `ArcInner<T>` value at the null
+        // address.
+        unsafe { NonNull::new_unchecked(ptr.cast_mut()) }
+    }
+}
+
 // This is to allow [`Arc`] (and variants) to be used as the type of `self`.
 impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
 
@@ -232,27 +265,13 @@ pub fn into_raw(self) -> *const T {
     /// `ptr` must have been returned by a previous call to [`Arc::into_raw`]. Additionally, it
     /// must not be called more than once for each previous call to [`Arc::into_raw`].
     pub unsafe fn from_raw(ptr: *const T) -> Self {
-        let refcount_layout = Layout::new::<bindings::refcount_t>();
-        // SAFETY: The caller guarantees that the pointer is valid.
-        let val_layout = Layout::for_value(unsafe { &*ptr });
-        // SAFETY: We're computing the layout of a real struct that existed when compiling this
-        // binary, so its layout is not so large that it can trigger arithmetic overflow.
-        let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
-
-        // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
-        // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
-        //
-        // This is documented at:
-        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
-        let ptr = ptr as *const ArcInner<T>;
-
-        // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
-        // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
-        let ptr = unsafe { ptr.byte_sub(val_offset) };
+        // SAFETY: The caller promises that this pointer originates from a call to `into_raw` on an
+        // `Arc` that is still valid.
+        let ptr = unsafe { ArcInner::container_of(ptr) };
 
         // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
         // reference count held then will be owned by the new `Arc` object.
-        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut())) }
+        unsafe { Self::from_inner(ptr) }
     }
 
     /// Returns an [`ArcBorrow`] from the given [`Arc`].
@@ -453,6 +472,27 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
             _p: PhantomData,
         }
     }
+
+    /// Creates an [`ArcBorrow`] to an [`Arc`] that has previously been deconstructed with
+    /// [`Arc::into_raw`].
+    ///
+    /// # Safety
+    ///
+    /// * The provided pointer must originate from a call to [`Arc::into_raw`].
+    /// * For the duration of the lifetime annotated on this `ArcBorrow`, the reference count must
+    ///   not hit zero.
+    /// * For the duration of the lifetime annotated on this `ArcBorrow`, there must not be a
+    ///   [`UniqueArc`] reference to this value.
+    pub unsafe fn from_raw(ptr: *const T) -> Self {
+        // SAFETY: The caller promises that this pointer originates from a call to `into_raw` on an
+        // `Arc` that is still valid.
+        let ptr = unsafe { ArcInner::container_of(ptr) };
+
+        // SAFETY: The caller promises that the value remains valid since the reference count must
+        // not hit zero, and no mutable reference will be created since that would involve a
+        // `UniqueArc`.
+        unsafe { Self::new(ptr) }
+    }
 }
 
 impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {

-- 
2.44.0.278.ge034bb2e1d-goog


