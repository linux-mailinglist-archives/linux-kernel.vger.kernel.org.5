Return-Path: <linux-kernel+bounces-127999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2BF8954B8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:11:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32B98B28C6D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E2B132C3F;
	Tue,  2 Apr 2024 13:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TOVUduO5"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A0784FAB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 13:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712063275; cv=none; b=NYpce2fkcQ9141Ze2U3JiOJzj4L52lmXuN/6RaMD6zZL8nKwaIafK2ba9sigGID7uDYv3Sx+2ciLYkIuO2LqXjv98Rcl3bPO63Cbasv6fMymue8glpyS0xj76a+xh+L1j/WSm24a5/SWDgG74bTmQdGOlHVcwNnmRMl7Qb5GTYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712063275; c=relaxed/simple;
	bh=/9JDOXGk30s1zhUrSl6X9Tci1HrlBOvd/yZB9RRxUxQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HA6Yf771PR3JyoC3gql8bQupSsDko1B5+vistSnxOBZnpal26hQSox8nOSpUOs5UTdyvkMGQ1ahsA1OHZRd6cFpy2QbHVuV2W+2KFhZ9TFpJS0roah5TqMJjyDSuPRtpFR+dXXO/sl6vne/YrCYbapAGxwLTWjoUFstifczL+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TOVUduO5; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-615272125c6so9364767b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 06:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712063273; x=1712668073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uCfbKJeKL+mMpegNJFQm0U53hM3icUzLYitSMM1i5xQ=;
        b=TOVUduO5YcfmYimBFM4IFFkMvkfiwemchLAw+Q9M/sfO6KssGbySco295j8yd5UmKm
         69BlPHrr2SnZTe9UIFdl8NvnD6YQdcr5YVm4PCdIzYJS8LEhDrHePgdDb+t+9vXG+YX+
         zQr0aB0e+/sUZ8B+nVUsn6ZWlcceHIt/LyiYKniWdS+Nij65lpsizUGugmWhiIKsM6Ky
         OOclTovscbv7lmDEKeTmBnHnDyAVURiIaKA7MCmD5Ei3U+q0I0IbiMX0iMfWHdwADILE
         9UalMvVZNsfIJClEgLbtJU+VxSkfCI67alsfYb3f7huls/c+HRsYCMjcN1lswRi3/f0d
         eNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712063273; x=1712668073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uCfbKJeKL+mMpegNJFQm0U53hM3icUzLYitSMM1i5xQ=;
        b=DoOQxeFb/3ZVGm0BVQWsvyU93lQ+4jkPfT+V2SzKoZ2PSgGs6kNVZ0gOkscKBzJqel
         gDOMA6R4PhtRMd0vWmTpMb6Q3NfOv2+HGqf+2iKeQQ6740hnZnRt4BAEQ2xCqzN4/5Gz
         UAxfuvEV46ZFW6B+hFGKA2dMNkYF6IKHQzqm14qNn07wI2BQK6Q+HnXQz/mGbYKvBuci
         A212IZKGxWa7UpFXOHcrNBKAPqPhSmbBu7BOAjoULq3zAld5BnpqjKqtzDplwB9QYFzl
         kvkiaCR96YiuLsAaLdm6uuVIyI+i+TxKEYs5BHN/4Mk0TZIxdEMK4rlGoza+ug6pu0E6
         j7dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTmwl5D+UfAbIcDB4F5CYDw6TYKuPPgxEo6cM297hMcHDsawhVLo1qpgOV06OHYuLCezuWiVq/XlrIZ1+Pp3nx1wC1pCEsZ/jRd8zE
X-Gm-Message-State: AOJu0YxBEtxvVCy8puys6N+tI00/M9CwfNFA0io1Gc59rJkb0wFaE74k
	MYi6f/ISwVdikF+yMKcrdfm2RAMnyWfTYJU9PbJYCmYpMndc8lU0Nz01hD1lMqtr8PCiWP98eXW
	MentrZ7O8GNC/rA==
X-Google-Smtp-Source: AGHT+IFTNtTzq05jAqkEcUoOP2m9NmtC712kZNLdleaPaLZtBNZULhvOTJfmsV+6eF5xRaLa6BWYI+zX2UdVKTI=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:690c:b9c:b0:611:747a:daac with SMTP
 id ck28-20020a05690c0b9c00b00611747adaacmr3425087ywb.0.1712063273111; Tue, 02
 Apr 2024 06:07:53 -0700 (PDT)
Date: Tue, 02 Apr 2024 13:07:42 +0000
In-Reply-To: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240402-arc-for-list-v4-0-54db6440a9a9@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6048; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=/9JDOXGk30s1zhUrSl6X9Tci1HrlBOvd/yZB9RRxUxQ=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBmDAMixpuDE0siAIZuQRVnjCVfT7h2isQxSwP93
 P0Hsav0ZYaJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZgwDIgAKCRAEWL7uWMY5
 RlVgD/wI7HslZbYDfwDmdp5pDS8YLnfCI5YgZIepsCEoJG3+rSkjRUfjPeq1XrKtCTBDuS+/jP5
 IsGATvF0Lvb+spKZo3r0XV0P93mseg7xVDm7xhtkbfCU0rI4zmHRhBrRPQrjzCLWQi9a55jTRf5
 gqhBCVtDg/DJ8zkUvt8IaqWRFl7q/MZj3PdV+KyzT1OyqoS8+fAjYsPBBXWzAsLUbWpu18GYHQA
 xJMY+MOGcJrOof3oH32lq9rwt4Qmswqx9gxvm6+Pysuzp/Gfatq70s09uTND++mrxmLEU+qfRKx
 radkwXbP4+2Z8Uljh1wfVlT6yJaBKej3daVOIFyAyKiXJsxNgDJYFW/C2uY5XbZqSx2IF4aISTz
 tNO6slIj6ue43Gmonmra5ceI6dQX8ZzXEEuQMJF0k4LmsCSpG67SNx5xjKoSuD2HL5svccQmDtG
 d1xDV0gAliDr0EwVvCxJjdYXdRFuixUSfUyuzhGyIUbUHkB6v8vVullP65xlxazHATn2XIJvxKb
 ReI0NLruA+OEsAJfpNlhfHUlE+f4PcbBMu1S4tAQCxPhgM/N9XXNUcuY9rM9Ec5BNvVSEgNyzF4
 2HXvsEs2BiMVka2rzwWadP93jhGvcb2eJ96RheqS3A5vs2vc8gL11cvY7RhxIjlvUooKq6hGbzd Rqpa2UosUJT0K3g==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240402-arc-for-list-v4-1-54db6440a9a9@google.com>
Subject: [PATCH v4 1/2] rust: sync: add `ArcBorrow::from_raw`
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
linked list uses this method when iterating over the linked list [1].

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://lore.kernel.org/r/20240402-linked-list-v1-6-b1c59ba7ae3b@google.com [1]
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
2.44.0.478.gd926399ef9-goog


