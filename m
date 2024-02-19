Return-Path: <linux-kernel+bounces-71521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063BA85A694
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 881FC1F21A77
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C027381CE;
	Mon, 19 Feb 2024 14:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DDY7wwfb"
Received: from mail-lj1-f202.google.com (mail-lj1-f202.google.com [209.85.208.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E2F3A297
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 14:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354496; cv=none; b=ZHMF9qrtByXgog8U9JeQprA0XRuvytWaAD47X5izbOQutzhgDJVCPKPTo48yhpBrOVlDPXI1vrjTiY5ODvCKsBQzDvTZhUf0OQ0eiRgPKdtiO1Sk08Za+xB6vaK0394ag0PPDXk0ryKWdo/L3vMIaB8Y9VNoCHcQ5zXsahmSfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354496; c=relaxed/simple;
	bh=H78itDIc8VobbgvqUncR/4LUaVbwf24ofNxGwj3s3bY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0R1IT+g1C0rAAuakg88fo/PbsdMjjreFTTA0qRQNUzuXgKmgaq1IfqsOQ5hHVf4109yxypp9rJqRKV/IKJc12WEWkHfgfapj3hh2SdowsvvCp90Ya5qAUvxMgEXMypHNpFjh0La/9kF2bVnRU9RtOMj1PYRTENmTdK38mjBRLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DDY7wwfb; arc=none smtp.client-ip=209.85.208.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-lj1-f202.google.com with SMTP id 38308e7fff4ca-2d0a4fbc9e4so35694361fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 06:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708354493; x=1708959293; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv/eR2vzxC66AOIjt19/H/aIIbsgUZxT1xI4hCpbrGw=;
        b=DDY7wwfbjdT54J2PjbyEarzpEVUWujOYXjcVRcLKvqe1wiXkV6gQYQtoIM3EgkCnHr
         NP82gsFga4yopT5qo8yGPtXwa9zk/V9/8MfzbtjmjocSd06L1UiNd0WpnJfTdVcYgYNQ
         1x0ztBnt45WDXnonAHM7LUPRCBm5tn8XYhcAaqaOlvDYwUCZTn4wGsyKd/FKoToIVLFm
         qiqHB3hRz5fTrUrs5p89fe1zyAyeSJ9A8h9k3BjgluV7F9usLr1GfKi5rXhLQQdThC33
         AwnwLjJoIfRg2DCPkIXQGGaXzcLOL/xKpjD2Rje0Xkaxxrzetf3/dxQ0Ph0WDnbz8Kn6
         KcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708354493; x=1708959293;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pv/eR2vzxC66AOIjt19/H/aIIbsgUZxT1xI4hCpbrGw=;
        b=smFv/VVQ/aC2ihAP/Si8YnXtCUJFUZlYIdOSrsb4WHh1Lf2WRyb225sh4xdiwRlFub
         1btJVU1wixx1J2gVcvxGLqBy4BIsib6lXgaiHg6BHT8RGvV2SS6zyHDDyUkw2yS8LH71
         L5Z7JB3yCoKdU6o4dZS6QnaR5O+4lmTiATsLXAa6MNjd/x/9ybTovHBTIXX7NhRcd9xS
         bpZHN+ef1sqR8ZX9Rs8WXrniCHu90m+FYdoUdGBuAnQ3WEgd3u6vW98oPkCPHyvHwxIe
         Wo4R3Hd3n/r8MdE6QNGDRCkhTD/Bi3KzFxskUbyRGyWgUHAmlwWQl8DdEij3YZ/vRfin
         qu8w==
X-Forwarded-Encrypted: i=1; AJvYcCVxAVEy7LoNATcEXUJ9JjHBUjmUT9EuKx4ypfVessTwAtcL7owJtGEOLcTF8KdrPxtOln0sUSN4LoVuPmcgZO4g7SciKK5Sb4jR9lCI
X-Gm-Message-State: AOJu0YzJqEWbNsc29nQ4l3wVzWJilH/vTTX+PUnA24cD13q/4/SWTnR3
	dVCqtUD9efghFJ+mAchdQnwffjS9G+AXOQoIlF+SdAVw7p+qfyJxeejaAj4rxpuv3N8C4tb5Ktg
	n2vfUcbtOpICP9A==
X-Google-Smtp-Source: AGHT+IGjW4Q4Rb97w/B448FcDx+ghsGf+LAEMY+jXFv5/eOCUG5fioWr2s4aIwxa2pth6WbEMThACBvtZO4zK5A=
X-Received: from aliceryhl2.c.googlers.com ([fda3:e722:ac3:cc00:68:949d:c0a8:572])
 (user=aliceryhl job=sendgmr) by 2002:a05:6512:3146:b0:512:bd62:31d with SMTP
 id s6-20020a056512314600b00512bd62031dmr1193lfi.9.1708354493248; Mon, 19 Feb
 2024 06:54:53 -0800 (PST)
Date: Mon, 19 Feb 2024 14:54:12 +0000
In-Reply-To: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-arc-for-list-v1-0-d98cd92c760b@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp; fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2548; i=aliceryhl@google.com;
 h=from:subject:message-id; bh=H78itDIc8VobbgvqUncR/4LUaVbwf24ofNxGwj3s3bY=;
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBl02uzvfvCJymYto6LmbbKL+XEjPPEvgR6DzYJG
 6EzZcrvZSWJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCZdNrswAKCRAEWL7uWMY5
 RqoED/9WsxuHgg5NeUnzEXW5H40hIfV0sDyjbRWrVtgdCjMGeULnrS+Sz8M25E5oiC/cVADLVeJ
 KJZQPk3sDFlr46hPN+td9TChPowGzhj3NLSkAC1ZdDsq9DnZ+pexSfwBfsZHT3NcBnBQgnqiMfF
 UsvSOEZCbH0GRNUaKNXwonvlmVC9v+bimItELbj4YLkFrHATxJzulVoZMMh5OZRGf0KPQALN4s1
 hVKJbQxF2LuCSmFHTKT2dcF2YJmp3NN0dNTH6I0ikLF/RPkedjJWLe0O/24y2hwxQNdvrUM1Yz8
 g174y+EraOzRcKjgpks7SCs1Qskfilm+N5D8TvqLj2bguPV5trMnhNdj3sZWUrgdw/kBQP1OKZv
 LyPbTh3vwJ9m6Lpi5w6c9Xiw+33zBY4EuE6hfBV2L5X3Exc+zb4MBzcak3Obr2COxBCAz22jfel
 G2OsGFRvAsbrtsOh3wKO0k2GLw6MkOxwky2zEQe6+U5Nw22Uq31EaFtr7UwSvJYTrjv4KfmUH7v
 bV3pF1Fu6GtFRdyZ3GNkvHR1tFLlrrPhvFYpC6OJ7hzFrZchWgDjLXkQW5bCHx2a4nNVp0q9bcv
 RHvf07MQjmQWZX4Hlf0fZfBKjQSlVXIN4kKHRU5ocB4FuPNsI8GdOzudtCcoQnxG9YgktDq+XEH yu9wVLLNvqGyQzA==
X-Mailer: b4 0.13-dev-26615
Message-ID: <20240219-arc-for-list-v1-2-d98cd92c760b@google.com>
Subject: [PATCH 2/2] rust: sync: add `Arc::into_unique_or_drop`
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
 rust/kernel/sync/arc.rs | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index a5314df409e7..a7e7f7ccace4 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -257,6 +257,37 @@ pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
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
+        // SAFETY: If the refcount reaches a non-zero value, then we have destroyed this `Arc` and
+        // will return without further touching the `Arc`. If the refcount reaches zero, then there
+        // are no other arcs, and we can create a `UniqueArc`.
+        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
+        if is_zero {
+            // SAFETY: We have exclusive access to the arc, so we can perform unsynchronized
+            // accesses to the refcount.
+            unsafe { core::ptr::write(refcount, bindings::REFCOUNT_INIT(1)) };
+
+            // SAFETY: We own one refcount, so we can create a `UniqueArc`. It needs to be pinned,
+            // since an `Arc` is pinned.
+            unsafe {
+                Some(Pin::new_unchecked(UniqueArc {
+                    inner: Arc::from_inner(me.ptr),
+                }))
+            }
+        } else {
+            None
+        }
+    }
 }
 
 /// Converts a pointer to the contents of an [`Arc`] into a pointer to the [`ArcInner`].

-- 
2.44.0.rc0.258.g7320e95886-goog


