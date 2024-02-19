Return-Path: <linux-kernel+bounces-71520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7613785A693
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3147A280EA7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3D23A8CC;
	Mon, 19 Feb 2024 14:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hJBg+wEb"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E639AEB
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354494; cv=none; b=lcw629lGGSYBNc02sBNBDT6ANN6Cqiw0t6+whOJ3mjU2O9oSG6XOLQfO+RNkSOJv4HVOp/vDspXTUvaLq6n/845D0HEGKTzTT6TrezGy8PsUlasPblKFRb5o25Oz75mP0D2uergh2h+RFZrgnA498aMbt9+DeHNDzbD2rv4rWoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354494; c=relaxed/simple;
	bh=S72ioJgbkaD4L7vl4yVZ4OMPfS3ZG7tXAtCALVLTxFE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YG7uD3shsJOvjCXwXdAQt1Ym72QAdxoVeIn24peh4iQ5/rHSfHg1qz40GUeSgyPAlFOnH3AXF36SQsixoZYFekAclIuuvODkww47Z3WFT9tx1MWzlo3G2iVdsa2Vz5l+vhlAGe52Q7EG6Bge6BDRVHKyhOLdJoUQwlSDRU7T+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hJBg+wEb; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d230281e64so17960481fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708354490; x=1708959290; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TPILgL4hDn+wMGXHUt+tcrB6xFWeOAwWFkXrv8nrJio=;
        b=hJBg+wEbakQvAACfweFVJ2ux1CywJBfuNPQBVsT2Q6gcp88s3qnpJRtTNzgys13XxE
         ErhwfmBC95nR5mQTx4V3CkRWa40V2XpVMVQfTwFPIJc10yg1LMKrFTXphnhZ7dvsUb/a
         vf6Z6XHIUjrBFZXDbBCsEdkWcCgF6LeFadFikqOsTSIGFA4phmr8oGtu4hJg/oL7Drba
         cLPU5syjKlL7g30MCmYSiOLKlBJIieEJORXk2XUHzVOtYP4Wa1Yql5zFVhxp8KEY8uNk
         K1rZ45e9MWDzbO5sf6hGPnpB68GqU6D4Lv8yirdDY6IyKU/6l76zQRC+qkrne9LVrGl8
         vXEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354490; x=1708959290;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPILgL4hDn+wMGXHUt+tcrB6xFWeOAwWFkXrv8nrJio=;
        b=P+rrra0ioa4xKhObD86QHMNGVwFwXl9yTCNKKjcPT/08g/0eMgQAw/im4gNRMACl28
         Dclt1FVQAtuD6CzFNeLYP6F7Im3N8oMCRHGAjnNDNgPfTor+zDnDhQn0dxCn5J8i73RZ
         7t1e/vQfGP4xYvxVCACSXmDWb7+TGztNkUctWInVHne2Kt76IDxvITuqVXUAP6z2lKrF
         H2cW2IYWL33QglcYesgcdS5FQm3cCKqFbJ6FxyD7AwLbx9LsVaIld4FP+SFcZEzfemXv
         1DBJPxtovEkliF9VDg9WNH0jAuULKh78x6WzH6AO05BBlHy3YOHbDkUAf9AHThmF7o/T
         fRog==
X-Forwarded-Encrypted: i=1; AJvYcCXJC2StxA+uXDj2eXXUXhcQK2wsM7gMSVYeMcl/T0oQGlBE9+C9h30ShhfjwLW1rAOm1LrSt+9bQBzd1EjtMXtHMfX9JhXuHvEly+OA
X-Gm-Message-State: AOJu0Ywe0rDDELNYzdqDgFiNXZhvuqVs9k3j0WBkZp2Zmefk8dBtX7Bx
	4tQRLINmnss6bzTUyHkS1zEpQ4qYj2gRyMVAKexY17xqSRDz/O6AnfAO+n0Z2VT6Ipw5l5X+tb/
	S35snauDENZPiAQ==
X-Google-Smtp-Source: AGHT+IH6RV+2ssTNcboY9cNH7m51Xspkl9h1/AYQAf897emHGrfaYh18wSooGo5Y6iYAtFdkldBk9186MrnDKTU=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:651c:2129:b0:2d2:3808:cd7c with SMTP
 id a41-20020a05651c212900b002d23808cd7cmr3822ljq.0.1708354490284; Mon, 19 Feb
 2024 06:54:50 -0800 (PST)
Date: Mon, 19 Feb 2024 14:54:11 +0000
In-Reply-To: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=5601; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=S72ioJgbkaD4L7vl4yVZ4OMPfS3ZG7tXAtCALVLTxFE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl02uzNwi5MDO+9qNLtPnK8z+XUZBFg6e01c3TV
 jYm+bsVS32JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZdNrswAKCRAEWL7uWMY5
 RvjdD/9bPQMu+uvJl1tr6pW4UGP5XyFJ4OJFYBeiXsBOQVxO7UKGgNFsSoxg+2oDARMZmKvjoem
 D5LTdT+f31lc8vQBKOXHAPUuXZ9BaY+p1mIeEN2hGjQZkQeZiSndkkynYmOnhZ0kSn06LT6eL/O
 +p1PHhkj95RHD/Ig73ihPKwgJh+k6sn4gKNkODOdAhKJMQG32kklyPZSwvEWiLb7/oCGHo+K62E
 kj8xArD243qyZeuqBHPycCcwcDyNgfv0jtk5iA4toyQE80KyEMdsFDIbyuhBZq/f9ZIM6UsYxIE
 T/juJMRirrS6pkuvDar2WD/SeTRuSHYU57mgmz6qylmC+rnYGcAhubwZu5sSYHFs0UolrqERSYQ
 WpmiJ/fl3w/xibRKZqer8ontXTvNbXadlgaocKTtgRUM8f1P6RtiuTDnoR5ds/fu4iZadMcU5sM
 0IhNEUc9hhUePX820cQ1Nv+BDgGUJryMWC4pYkbMgQgpaXT7rMoV5osyxCNZKtv1/b8Pn7kpIkx
 8wjWHza4QeqjBA7Ke6Wkd+COHH6/OrbySxIOBfsVo1mcn50XdTAUjGLqk6z4jyagb63spBv/wdK
 /qIW1PYO25NQ11ZEvYgVu33ola6xfadS67agB6Y5KfINaiQiMgrLFbcfdS/0djSOWrxgtGlUZoJ PiBBlZZp5b7Fbdw==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240219-arc-for-list-v1-1-d98cd92c760b@google.com>
Subject: [PATCH 1/2] rust: sync: add `ArcBorrow::from_raw`
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
 rust/kernel/sync/arc.rs | 72 ++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 54 insertions(+), 18 deletions(-)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 7d4c4bf58388..a5314df409e7 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -232,27 +232,13 @@ pub fn into_raw(self) -> *const T {
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
+        // SAFETY: The pointer returned by `into_raw` points at the `data` field of an
+        // `ArcInner<T>`, as promised by the caller.
+        let ptr = unsafe { raw_to_inner_ptr(ptr) };
 
         // SAFETY: By the safety requirements we know that `ptr` came from `Arc::into_raw`, so the
         // reference count held then will be owned by the new `Arc` object.
-        unsafe { Self::from_inner(NonNull::new_unchecked(ptr.cast_mut())) }
+        unsafe { Self::from_inner(ptr) }
     }
 
     /// Returns an [`ArcBorrow`] from the given [`Arc`].
@@ -273,6 +259,35 @@ pub fn ptr_eq(this: &Self, other: &Self) -> bool {
     }
 }
 
+/// Converts a pointer to the contents of an [`Arc`] into a pointer to the [`ArcInner`].
+///
+/// # Safety
+///
+/// The provided pointer must point the `data` field of an `ArcInner<T>` value.
+unsafe fn raw_to_inner_ptr<T: ?Sized>(ptr: *const T) -> NonNull<ArcInner<T>> {
+    let refcount_layout = Layout::new::<bindings::refcount_t>();
+    // SAFETY: The caller guarantees that the pointer is valid.
+    let val_layout = Layout::for_value(unsafe { &*ptr });
+    // SAFETY: We're computing the layout of a real struct that existed when compiling this
+    // binary, so its layout is not so large that it can trigger arithmetic overflow.
+    let val_offset = unsafe { refcount_layout.extend(val_layout).unwrap_unchecked().1 };
+
+    // Pointer casts leave the metadata unchanged. This is okay because the metadata of `T` and
+    // `ArcInner<T>` is the same since `ArcInner` is a struct with `T` as its last field.
+    //
+    // This is documented at:
+    // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
+    let ptr = ptr as *const ArcInner<T>;
+
+    // SAFETY: The pointer is in-bounds of an allocation both before and after offsetting the
+    // pointer, since it originates from a previous call to `Arc::into_raw` and is still valid.
+    let ptr = unsafe { ptr.byte_sub(val_offset) };
+
+    // SAFETY: The pointer can't be null since you can't have an `ArcInner<T>` value at the null
+    // address.
+    unsafe { NonNull::new_unchecked(ptr.cast_mut()) }
+}
+
 impl<T: 'static> ForeignOwnable for Arc<T> {
     type Borrowed<'a> = ArcBorrow<'a, T>;
 
@@ -453,6 +468,27 @@ unsafe fn new(inner: NonNull<ArcInner<T>>) -> Self {
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
+        // SAFETY: The pointer returned by `into_raw` points at the `data` field of an
+        // `ArcInner<T>`.
+        let ptr = unsafe { raw_to_inner_ptr(ptr) };
+
+        // SAFETY: The caller promises that the value remains valid since the reference count must
+        // not hit zero, and no mutable reference will be created since that would involve a
+        // `UniqueArc`.
+        unsafe { Self::new(ptr) }
+    }
 }
 
 impl<T: ?Sized> From<ArcBorrow<'_, T>> for Arc<T> {

-- 
2.44.0.rc0.258.g7320e95886-goog


