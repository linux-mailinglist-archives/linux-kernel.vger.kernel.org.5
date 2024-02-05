Return-Path: <linux-kernel+bounces-52949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 554F8849EC3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 16:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33C21F22934
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A214446B8;
	Mon,  5 Feb 2024 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPZ8etjv"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB8E3FB21
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148208; cv=none; b=CFTY0AUb2R924kFv5XCQgvlwCAd/mZsvwdumeIcxcpyLQFPz2alzYAoPmJ0QvVOTSASC5riJ6/pzUe5MpfLyR8R00lV5yG7poIOaDZYlPvOupY7Jm1erRLCyUWz9Hfy05XMPDdawyCUW/hkz2HKWFi1vuFe4o72ZUTEizudBz0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148208; c=relaxed/simple;
	bh=FR4T3Qjs2jKRsHMGwYv7pMd/5Tm8HyvFjH7AWhAgulg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iKCg1bv/ONpfwCYJp3k6BvipMQS/RlWey77rlBqYdeLVLM5w/XUpHvJ3CqtJY6Vx0sS9fLBYzDtjN5ByZDvjGVdGzWNXcqDIY0tyRvRIdrPi8Em6t3UgA5brDB2TQTIRti89zstw7s9IRWp91dQwebaxRza4+zsCrIGibyIi/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPZ8etjv; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60404b12af2so72290047b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 07:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707148205; x=1707753005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KixoytXQDGjoXAfvxRuyy14dtLsh1IkvCMs1kLMTxgU=;
        b=wPZ8etjvu/a0We6zybD5oAoPX7szcBceYVUEtMiWa3ZZrix76d58rDCkj7FojQPqdH
         ZmXPORLgWNqQWFWzdBV107HrPBpy1c6A1q5DQ1u9JNkVQwCuQlpScUulMKP6VyCuleJ0
         6dHcmeSwZEVGPfGT1D7jS+IB6RZrt6f2h2cLrGku+leR467FVVGe3vT213AA6N5XcWS0
         pa8RGs4idtdY2QEOyZyWoZilowaWZL+zqoh0ulBe0R8jHu1HKxVCoH2NOEQvKFHhkPDw
         aAPL5DKsWpmAz2R3dU4gHLZrV25PVdlMnaztzFDVtmXUN4/Ns7TRSNikrsJ0LIWWPr90
         3TWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148205; x=1707753005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KixoytXQDGjoXAfvxRuyy14dtLsh1IkvCMs1kLMTxgU=;
        b=fOOPwbgeGvGWL4kLY8doMMtNFB2Bi8mO5sVD6zyjEvdL28Hqs3RjrtUmbM2ahe4Owj
         6WAdEWShO+Gkr9jElqWUb8cwBz6Xln3kVbIve9RQGnRc/uA/EUxLuyd8aeZbVk3WT14m
         rCSGR+XDyQT1Vy7Zlp6J31XiuEk2dyfkO0YbsCtVH6dyXO0YhpmYScDcfurxhMzSMj8W
         S6gCS1rzhnOnxNGFXpahmw1s7JBWE9rtc8OvBV7jmNkoy7nEVfQ0zR8IoXw4e2kDFezM
         PPjQVFw0NtF5lG1uaq2LbS9czH/iiAQUqiavDfrf0YLbKC+S49Vp05T82Koo07yVXCOV
         GYIg==
X-Gm-Message-State: AOJu0Yw1FCp9vF4QTpuA982GtKa15cOndTtlgxe48DOo3rAreUp4yrqf
	smaLGZ8gKIfktT9r8cYrVOf83yaX/jc7m2VMYaYjhfzfbLHI3zNENtU0TcaBK3c6hP8u64Je3Wl
	tJ/+w+622p4Qn0p9FUIkpPmvEKA==
X-Google-Smtp-Source: AGHT+IEU6z6eWwsI2wrzuaRC8jm+CHnZ6wBunkVHRxWVayHsmL35Oo/zIT20NC39+nbywkp3VaDfFSfpxPdFXrAwlcw=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:138f:b0:dc6:dd74:de68 with
 SMTP id x15-20020a056902138f00b00dc6dd74de68mr440165ybu.12.1707148205361;
 Mon, 05 Feb 2024 07:50:05 -0800 (PST)
Date: Mon, 05 Feb 2024 15:50:01 +0000
In-Reply-To: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240205-b4-rbtree-v1-0-995e3eee38c0@google.com>
X-Mailer: b4 0.12.3
Message-ID: <20240205-b4-rbtree-v1-1-995e3eee38c0@google.com>
Subject: [PATCH 1/6] rust: add `container_of!` macro
From: mattgilbride@google.com
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"=?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>, Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>, 
	Joel Fernandes <joel@joelfernandes.org>, Carlos Llamas <cmllamas@google.com>, 
	Suren Baghdasaryan <surenb@google.com>, Christian Brauner <brauner@kernel.org>
Cc: Rob Landley <rob@landley.net>, Davidlohr Bueso <dave@stgolabs.net>, 
	Michel Lespinasse <michel@lespinasse.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Matt Gilbride <mattgilbride@google.com>
Content-Type: text/plain; charset="utf-8"

From: Wedson Almeida Filho <wedsonaf@gmail.com>

This macro is used to obtain a pointer to an entire struct
when given a pointer to a field in that struct.

Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Signed-off-by: Matt Gilbride <mattgilbride@google.com>
---
 rust/kernel/lib.rs | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 7ac39874aeac..c7963efd1318 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -102,3 +102,35 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
     // SAFETY: FFI call.
     unsafe { bindings::BUG() };
 }
+
+/// Produces a pointer to an object from a pointer to one of its fields.
+///
+/// # Safety
+///
+/// The pointer passed to this macro, and the pointer returned by this macro, must both be in
+/// bounds of the same allocation.
+///
+/// # Examples
+///
+/// ```
+/// # use kernel::container_of;
+/// struct Test {
+///     a: u64,
+///     b: u32,
+/// }
+///
+/// let test = Test { a: 10, b: 20 };
+/// let b_ptr = &test.b;
+/// // SAFETY: The pointer points at the `b` field of a `Test`, so the resulting pointer will be
+/// // in-bounds of the same allocation as `b_ptr`.
+/// let test_alias = unsafe { container_of!(b_ptr, Test, b) };
+/// assert!(core::ptr::eq(&test, test_alias));
+/// ```
+#[macro_export]
+macro_rules! container_of {
+    ($ptr:expr, $type:ty, $($f:tt)*) => {{
+        let ptr = $ptr as *const _ as *const u8;
+        let offset: usize = ::core::mem::offset_of!($type, $($f)*);
+        ptr.sub(offset) as *const $type
+    }}
+}

-- 
2.43.0.594.gd9cf4e227d-goog


