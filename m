Return-Path: <linux-kernel+bounces-99188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B10148784A3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50A5B1F2219B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7944CB2B;
	Mon, 11 Mar 2024 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IhD3P0vG"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BFDE4AEC9
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173316; cv=none; b=GPglrGl6rxI+7rb/co0yhptxrOl1UYPM2iMBDnUx3m5KMw1LhNFzoIsbcF3pfpsipVgC++5Twpie4Ly4TV3WB3M3cI6bAmrEFegxbLhz8dJYGwpru0YszqDxID1srqa+zlw+vvbgh+9WRZ1UayS+DvlElxT+u1NroKIexpvoft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173316; c=relaxed/simple;
	bh=dTDELu132/83Pc9WB78HCpiSQH+OEDNxB/Dz/kqP3EE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ui61fPZ8C2CuPs9E268kDRo679bpixk7cGtF2RSlLXT2bo8enpcWpJpEKjx/ms6O0n+17Vvfc9TlSgSLurXma3t5wtRPd1SsxokKELPywTSy1OhiRWNiNutfuae8JUuVQhiLYbyUyzRYnGq+jXTGv0GN7646QxnQF1ztJ3UB410=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IhD3P0vG; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60a0815e3f9so43432857b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 09:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710173313; x=1710778113; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9adI/6of+7s/Nl97N1SnFVT87VG5FRlJB2WqXNujaws=;
        b=IhD3P0vGZ09yXmlWGILPApF5DxaLVd5YhGycri+F8PrAATWU1J8R7OAP83wwXDPMOm
         tdj/D3WfqMeljVWmhrTubS5NB1NGWJs9uBSQ7TxV+j8Ai3nMXrNXGCt2PWQ9XTGs1FTh
         Xd3MYoDcoNLaAE9cjIzRir6UhRGIgU8jObxWMsN8OO/tyqksOi6EW6bHIrUMLJG2xnTR
         cdL2N4krejGbrDUWvwtpBKPdbbaIA+k0UDBUstfFyLipAbvR7BIizQznx/x5aOSwMFth
         vLMykL61baJlaLDMz/AoPVRZr05liwyMEBVCZrbPZcMG2qnfXpzmbkZ5z0aZEGvqkYr7
         aibQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710173313; x=1710778113;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9adI/6of+7s/Nl97N1SnFVT87VG5FRlJB2WqXNujaws=;
        b=RWcv0ZnyGKQ7hP8dlR14XjVpWIAKaT3yTuMmWLAGKyVuYJeRGKUHw48ohRjwQvdRN/
         LSvDDPt2kw8hxCyYjBXlilyDt3XgFR8ZebpxJ4q0LwkEH4CXof7ZZSsE6t9Sq732ra04
         CKTAMz93ltk8GXbZXKN7DkHfm8i0IqBm2P1lZTGyJuRd11Rlrf3WKuER1XpFTPZMVH76
         FPjxUEv6qJINMVVsPHt9lhlW/ysTWndHWc6VdikqP3riEW3gdCJCqD7WkC1mC9snkBwP
         YbzqHfzkV7mz+3UTJ7OMWeXs8HnxOrvhJrDdm7cnL+vzX6RegA1yquiOfyVC4fzitcBM
         /sXA==
X-Forwarded-Encrypted: i=1; AJvYcCWCXHopyZZgF041wHYBauVUfEJFsD4XHM6XaBU/U6nKyGRRp7fODDYGG8aLITyHA+DpKgi5MIALN9C1Wf6dXJWlCbBr0c8lMraT2dII
X-Gm-Message-State: AOJu0YwqLmxmbyplKip1y3mVD518zWDq704COJ/yKiIJyfXZLWLK3nZE
	fX5ykAaUeveLNg02YTQ2Worv8RPYIlssuMyPiLL+i+OfAwLs5fFDOSyghZPfvJE0Pu38ADia6+m
	vQvqv6Yyg+/vB5g==
X-Google-Smtp-Source: AGHT+IH2hwZr0/kJVCqZwby3h4TiRwSNTMIgyj2LYQsxATqZ3+UaW49B80uGXpdLy52ed1L0jMT3Fayby6VaSXY=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a0d:d5c6:0:b0:608:398c:33bf with SMTP id
 x189-20020a0dd5c6000000b00608398c33bfmr146783ywd.8.1710173313704; Mon, 11 Mar
 2024 09:08:33 -0700 (PDT)
Date: Mon, 11 Mar 2024 16:08:19 +0000
In-Reply-To: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240311-arc-for-list-v3-0-cba1883c62eb@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2578; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=dTDELu132/83Pc9WB78HCpiSQH+OEDNxB/Dz/kqP3EE=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl7yx4oLnnXqRdNuQvjnTuAOP/so9X0itV5HLJl
 I/VeRdBlgqJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZe8seAAKCRAEWL7uWMY5
 RgIWD/9X+MWLobKJpl8KfMnRimQ3J1q3W6wzBE14KOjhM34LNyL9dlkAm/gkD6shGT+FQcg+yko
 3Nnd8YYpR3smNN3GNNvi4baNHCOEi6Jzuf9vJXOSxkYxnP3xLwgVgwSL7L6z5dzpIBHjkKPMKYU
 FCYB55UlxmTiNemYtIMGjZaRX5K68VxTMmUZ34Ra2aOGelVynHFyQaxcoD4tSqD0dGxnt/p6L7d
 X9/i5lLEJ4hCLJY+gD3vLwmBMLAvmVg4LJwohpkRLle3xKmKlyeaG8vwlo5rAlH0rcRD6KRbbu1
 XZxiCwP5EAR9DkyVE0Bj2kaDqvA6YgIhWgxcVK6PBlqfTAHL5S9qdOEdKSg+k9t7SwaIFNBLtdQ
 duoYjplnNLrHdEkFHtfxZVQerD5M92rFHyERyCqUk6lnh2F8Gu/1rY4YNO1DSqvQay5dMB5fZef
 1yFxpgeBoz7X3rL5Ddod7rd87/53OB444EfVPQ33TUp6YnWMjWxVKD3JNr451zc0+pHoGuH3pSA
 2ouHu/53HSkcNOBJt0C461LD2A88FYAbL0h/6ucyjKGjCFOTcyNXISfT5p+j+ZexgAHarUUAK/t
 JH1b56hWiyf7sxpZuhUfUfHb8WGbKqQVtigtZEdcZ0okFtkzEBGfSnMvSKiYk7ds8QB68rGFVkh +ocS26/k/mz51ow==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240311-arc-for-list-v3-2-cba1883c62eb@google.com>
Subject: [PATCH v3 2/2] rust: sync: add `Arc::into_unique_or_drop`
From: Alice Ryhl <aliceryhl@google.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"

Decrement the refcount of an `Arc`, but handle the case where it hits
zero by taking ownership of the now-unique `Arc`, instead of destroying
and deallocating it.

This is a dependency of the linked list that Rust Binder uses. The
linked list uses this method as part of its `ListArc` abstraction.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/sync/arc.rs | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index 53addb8876c2..ef8b520f65a8 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -290,6 +290,36 @@ pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
     pub fn ptr_eq(this: &Self, other: &Self) -> bool {
         core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
     }
+
+    /// Converts this [`Arc`] into a [`UniqueArc`], or destroys it if it is not unique.
+    ///
+    /// When this destroys the `Arc`, it does so while properly avoiding races. This means that
+    /// this method will never call the destructor of the value.
+    pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
+        // We will manually manage the refcount in this method, so we disable the destructor.
+        let me = ManuallyDrop::new(self);
+        // SAFETY: We own a refcount, so the pointer is still valid.
+        let refcount = unsafe { me.ptr.as_ref() }.refcount.get();
+
+        // If the refcount reaches a non-zero value, then we have destroyed this `Arc` and will
+        // return without further touching the `Arc`. If the refcount reaches zero, then there are
+        // no other arcs, and we can create a `UniqueArc`.
+        //
+        // SAFETY: We own a refcount, so the pointer is not dangling.
+        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        if is_zero {
+            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
+            // accesses to the refcount.
+            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+
+            // INVARIANT: We own the only refcount to this arc, so we may create a `UniqueArc`. We
+            // must pin the `UniqueArc` because the values was previously in an `Arc`, and they pin
+            // their values.
+            Some(Pin::from(UniqueArc { inner: ManuallyDrop::into_inner(me) }))
+        } else {
+            None
+        }
+    }
 }
 
 impl<T: 'static> ForeignOwnable for Arc<T> {

-- 
2.44.0.278.ge034bb2e1d-goog


