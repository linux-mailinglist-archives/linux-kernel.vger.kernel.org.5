Return-Path: <linux-kernel+bounces-71241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5548685A267
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:48:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A4851C21934
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:48:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E344D2D059;
	Mon, 19 Feb 2024 11:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qtDFEN0+"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FF72C69E
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343317; cv=none; b=L5dfRy+r/QiSFNDJLY4vxTYAfpASaj0+p0g9utJ6iYbpKaQGpqKH2KykOmxa2fYPvN1pMnIfngedVdMlbFW8arXlWQMGZwvldfp5aVbbZT1jmuG4GcOrj11TDv+hIaFAYtHEduHg5gf5o0ruGgWQUkFdjFksb+p9JAsfzm+3jBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343317; c=relaxed/simple;
	bh=innSX49CwmZV7ZYVg2pc4oPmPaVu0uYAbVQ1SRQo7W0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G8TK2uOPRDcc37SaY8VfDAQKHQLwZmoM8zgsByKIJO3qTvLb1azs2XS99eIY0q5e0PgKXBsgi48DM8n8WUf1FjFZPxYMqurWu/CXwCu6Ll1/+HwcUdScYy6keGhUel6tBgKZiPEzupAFhEGslGlF3h2n8YkXzWwKzyNrpPMGJHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qtDFEN0+; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattgilbride.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so5875207276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708343314; x=1708948114; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQYC/9pHL/SpAUfLef4ziz+f1NtXPaV0zydD9EqqSTw=;
        b=qtDFEN0+epX1qOO3GYygJ39pJdj5Ny8r6NzpJLVSlMIEHfkXz/4jPaPXOaFZ8isRE6
         RUSEarDOJblEIExN0iwOxMpF0aBc2QSNiEPhGLHzhRTTfYRCCLX05dUrlcbM1OvlnEyw
         LVZyTftuKYD1XeKcqkoofr/ryhRHINwa84e0VVLED1T78gmu/og9XGYnP04Q9zTtAn8p
         Xb0Szzn6eLeeYlBkI1wVtpFZahMaZ0NcGpyp8vB7GP1XhXKp4PjGENa1uW0B3e1+T5J7
         AdqXGgLS4YdOQhOs0n0FYWMSB90FZvu4/YGfYhclP34XUGDmC2JeROjcldlUBXGvziq8
         StXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708343314; x=1708948114;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kQYC/9pHL/SpAUfLef4ziz+f1NtXPaV0zydD9EqqSTw=;
        b=GBM9gHr2/gkfjUz0P1Jh9qh7zczmkqjP7hxH9Zm01naW0ie6oBIFUSNPsGPNaoCIIa
         1VgDHANEfn9eMjspRrbxgSFK9W0rIkhWPoxnR3KgeVAb2JLy2ifIza4ggxQJygWHlgQB
         1psy6nB5bwOUUgbE926rDxJ0puLjrJYyfjH92nW1jKzllE0PV/AvR7ltwGyr/M6raNuT
         VW9+dFTZid9wQzDxF4ewx4pkG/ENSt5ehgWerLnYxR/bkOmcOv4oXDXbrx3oWyEiH2T4
         sO0Zdhxd+th1GcsyGY8+y9pTDFzqzwZ4Rh6NP5ViWXkZAYl6F7d+JkTAA4orTOh8PBsb
         koLw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9ST9vo2/9beBH7396dy9g6E9EgyMhMHO3AJBpfcPdVFyEZUiPud2TN7C8apYaIhPsCmbUzzTwoGUv7VEnxeaMvui+rMmcjgjPbBh
X-Gm-Message-State: AOJu0Yx5zHF4ZASX0gFfY0Fx+x9O0hiG0stg4XUbj3BcCpJffdLnyQsX
	YKM3vycx9URhP6yTt7WgQLyLqeCsr8x7xJHX213iX7A/BqedKAOes9K0sfs7wgh4H7O04YxQs7O
	zO4j9ulYx88rzihUttqKc0HHeKw==
X-Google-Smtp-Source: AGHT+IEas/WNgoqoMZV1uw6x3vMJGN/U6AYX0XX9NXg/aOY3Ge04I04GlwMyjOmccpi/WvuL0dggWNRBtTjL3qmY2Z4=
X-Received: from mattgilbride.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:2ac5])
 (user=mattgilbride job=sendgmr) by 2002:a05:6902:1b85:b0:dc2:26f6:fbc8 with
 SMTP id ei5-20020a0569021b8500b00dc226f6fbc8mr479735ybb.7.1708343314722; Mon,
 19 Feb 2024 03:48:34 -0800 (PST)
Date: Mon, 19 Feb 2024 11:48:08 +0000
In-Reply-To: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240219-b4-rbtree-v2-0-0b113aab330d@google.com>
X-Mailer: b4 0.12.4
Message-ID: <20240219-b4-rbtree-v2-1-0b113aab330d@google.com>
Subject: [PATCH v2 1/6] rust: add `container_of!` macro
From: Matt Gilbride <mattgilbride@google.com>
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
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Tested-by: Alice Ryhl <aliceryhl@google.com>
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
2.44.0.rc0.258.g7320e95886-goog


