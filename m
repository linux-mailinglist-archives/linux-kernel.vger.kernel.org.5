Return-Path: <linux-kernel+bounces-85050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A7A86AFB4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6F7D289939
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AF414CACC;
	Wed, 28 Feb 2024 13:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lx9lCrXp"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B32A149E0B
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125249; cv=none; b=P0gEoX01hUFUmYVbvsWRlvj3vlSWncVgHRgj3N47M4uqo0sC0ux0tqUZbG7yFzTA8263IvVaIrMMwRctJUiyBMt51/uonyUNrqAs626fncYhELnCTAMcAD+l6tAUZwOI+5F/EQTgM5ob/0TSOr4Jty+b/8WGAkMZ7kIIZO0NetE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125249; c=relaxed/simple;
	bh=2qc0OjZbMyqS455P5x7XgjO6nV3ryL8hVj/+fIZPe98=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=At6fdQ57dpqU+j7ogGyki1FjxQrGurxedexgAzPe0FCw2Q7OcGs1xFsyDaa0y0oGUmGjn2w/gV2XJK24wPtHxaTNN/AcODo7Igt4tNtNhDnL/yOr+ssMqK5NAhITGI2Eu+dMCAQLhTQGVFBb7y1J13NEkd7BZ3XHAhPFA8XCe9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lx9lCrXp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so1857487276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709125246; x=1709730046; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3wB+zOphNyP6hUF4yf4aDnoGW0BiDCeUW7QkKdL2gU=;
        b=Lx9lCrXp2HTJ/34cO8hUgOhcQUwnNy+sJp/CwbA9uAzPmEMJkUnK3CaPxyL7g/6TI9
         MXxtV5tPWwbDnmBHD1KBMkd0TQHxiXe6bHfFiWvD+xnyl9QB1QGcSCelkcfCHLYKVCt0
         JPdLg9xXs6BtfmxYDRp7Cl2OJaYXFk9bwzlxeToPnQSgU7XC6neXeD1ntai4kzBq6CvX
         YYvG5KBshsIfOgSFTHEYeDsagRV9fPuQllfxcm5IAQkUWZc1ahcNG8DiOHl/G5eboMq5
         RnsyCPKjkbakFO+M0+VzJtW4EDSov9NmNwLnM74FET9QwWkM0FKkWQreEbJQEj8i4R2O
         +WAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125246; x=1709730046;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3wB+zOphNyP6hUF4yf4aDnoGW0BiDCeUW7QkKdL2gU=;
        b=btEIQoqeM9tGxSORI2yZiA5pHslt28si0cg0ZCyVo5mYlWr5gbdZMY9SijMa1gtuLS
         1RPRdoQJdtCbznqZxgrt2n7PHpME6GTOe+vWVjcyIlMsg4eabd29RMhKvodq6NOUUMZN
         V5VmFdxCNeF5gB7Qk00f3+RDJ6shKCBrBebuZbCm9r1lX1VuzxKojg3FsOwYi+xuXviM
         SRw+3LTnS/AYUXrlmLKzeFFsSZkxWqH5Sqq9NevswU+XIt/31pfHQkSjTz7GkLdV8I0m
         GhwV2bP/hJJnmiNr8T6mPnEGwP5bKk3nLYPreI01tAHChP3inoiEXN+Q1kwfInP2hgKH
         f+jQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/rNwgMwmxuMdQyIpO19H2sXADLBY6vR6KG3C7J1Qx0B4ROsf24BI9oZYoXu96y3LNWc4gbPNr6cWmrRpiXntLFfU7QgFLg38x89Qf
X-Gm-Message-State: AOJu0YwKarQ7yk3v08A5r/6vhtPFcN9W1AJRs5/d0fkciRDr8zWbvuy4
	5OZIw5CRVo/4y2S9WpFtrLnypnXi8pSkASR/6WYcproVcrk7lM/ZNEdlcrGKJ8e5MtMy+ycChg/
	dz5A/e6ooqTPqgQ==
X-Google-Smtp-Source: AGHT+IFiYyFQaewsKgwunqVgN/Q4+dzRP4xv9pcu+Nd9dtD4foHScKE6rWECzsn9S/zEpK+R9YUX8Wd/ckVSDAM=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6902:124b:b0:dc7:7655:46ce with SMTP
 id t11-20020a056902124b00b00dc7765546cemr717803ybu.2.1709125246533; Wed, 28
 Feb 2024 05:00:46 -0800 (PST)
Date: Wed, 28 Feb 2024 13:00:34 +0000
In-Reply-To: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228-arc-for-list-v2-0-ae93201426b4@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5861; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=2qc0OjZbMyqS455P5x7XgjO6nV3ryL8hVj/+fIZPe98=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl3y53emchCaCu7uFgmd7KKQwOA79SoPzWOeKWs
 41D6I+qk4yJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZd8udwAKCRAEWL7uWMY5
 RuEmD/sFXh4G73vd57SjB4S9hG1Y5Qj7hCC3LTdgCt3aM7beUA3bOnmMfmvlymQ++qSj+tirxrC
 vn1JM30JqLIJEIBbBCz5YUya1jjCHyDQY5GV1mzrxVo6kvtR1cK3/dHmf0rRBBbqDYFU3y7a94A
 n8KqlZ8BE6yME8/HUS5FBOQkhiU/X9tBbAL8RFo8afJfk5VyejmDzy2+3N7EORN38ltX9q9/Xgd
 IFw4SMU7OqOuGaPjKFTo0xin/RCvNQ9an3ZXDao3YbGGjSwPoZPnVoA+PXN07wRu/fuPrxkyWyI
 x9tFzTSNTmqj9O+JA4rbzywO1QV3ErEijzfJYAOolp7q2l5ztjqrMO5tddCoev2efz0TeYig5qk
 2suf3d8jmihvNdD4GeideyqmQMqx9ptn0tiSiI7CeB3lStg4CpVzCZ2ju4bJFK1/fetI1GD5Q1m
 iEwZnmTdyY95uYchdhYIO8Lnl3PtHuwnNtgFGZxb7FF5QXVzHvnMmwzegscDg0obq6lO6ROzSv5
 GSu0lWl5s1dA/mGRqK+rMoaeTVMwI3hqKbaZ8OjEJCKq/5Hhkhe51bMehjQwUsak1GJdRJBF46i
 nhbKIo8Rj4RF9dOZzvFyGUQu8cbYkw9rb/pWhoKW9MpLvcymZZeFQl+cF5RLnVMOefRYaC4Dw2Z i01fU9dvpVGvS1Q==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240228-arc-for-list-v2-1-ae93201426b4@google.com>
Subject: [PATCH v2 1/2] rust: sync: add `ArcBorrow::from_raw`
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
2.44.0.rc1.240.g4c46232300-goog


