Return-Path: <linux-kernel+bounces-123532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6392D890A65
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A6E21C2F0DE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4016813BC0C;
	Thu, 28 Mar 2024 19:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0sf9n78"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACAD13BAF9;
	Thu, 28 Mar 2024 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711655733; cv=none; b=HNWwr83j1Cj5xQxHNO2J8oXD9t9+ABelZWyOZJyCN9+UCNsIg6J+aNqlcil7G7ne5bxZk9ru2Bi3J9/I3Ox5A8ct9SnmOeisqGCbFxE2xHT+ctNC0Plnd3LChT/FZhJWpjgBQLYcG0kE/WS16PzzEGsFNOnMCzI1ElCW2Cn6PrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711655733; c=relaxed/simple;
	bh=9njTVxVVwgfiSjgHOUmEIu0P17Go2yCn58n6W0SP5Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DW76CF1BTvWWiGbG483kpBKGFiSt68O9X9WqthLa6X4mZ49oFQHWzkJJlW3ee7l3GvghTNEFfhEAamxDmK90ET89o+iXS0gGz3ApaNp2lLgPWejjYqbsLEU00BfnTM9kjRACjqNShRZafSQ6eozfvvyILkNqbe1kOfMGNMJ3+Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0sf9n78; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e0189323b4so9647925ad.1;
        Thu, 28 Mar 2024 12:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711655731; x=1712260531; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eFzgNfFcqYNPSbmQhYX6OGJpt5Y5nswpF3NJb6j2OdA=;
        b=X0sf9n78PRMly+zsDkFGk5+vfx/3k5TYkRJOUHAH+Ue4+PdlCN+Ves8y3Vp8yM8AhO
         TU5jKaCSOK6T2Avxlbt+BOVK0oXE+0p2DEH7L4g7GZxB/eirnloL2vE0cgKJdp+3NHky
         RU+7cBO+8+6QYj+H/UiOGzgdUAnPJ+B6kAUU0vZe86PlLRKcuqsJtzpnkXTgENv62IRy
         rQ7UGeZBsdy6OG92Ti9AAwBWlSLtZov4pDBCnEFmnpD7xRLDcgQR8XvXzhGP8osesg/n
         OEoTK4pRPQCEPFbdbd8mq8+HJeVkXEHipijm+PD4S7iVKXDo8GobJXcsorI8iHzIMc6f
         tqgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711655731; x=1712260531;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eFzgNfFcqYNPSbmQhYX6OGJpt5Y5nswpF3NJb6j2OdA=;
        b=DdvSGjE0EFHOq8gauYOlJKjrYK14LpFz+6/vHNjqu8aHtKDW0AhtocyAMYEDHLssUs
         2Nt90Gx4OghVhdjy+4VUgcGv6+gVzmxh+FkaYN04NGBbv9dseUG6N8LTKr+BsZwctxTU
         oERfhmlsYszuhdZVdH3sBglnOmZdKuLUbS9ue0oot6A+qdrOgszDW3ycx7kFSdKxajs4
         t0c8xCKK/ZOt9UXvJsyZhHCuDBGA8QbI+I4QthuJcn4c6HXHXSj3DKYwTbHUYYXEUOpa
         4WPxzV+d0QU9I0gVIfDeD/U9puT8Bg3HOzWGnF8md7TzbuLpuLeSJERrZfkGiZ3CWexy
         xc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc4NUEKuKlbymLa49I5Kuk6uwlnm1iYdAhvPnZGMnrR/UhfASeB+6M/AbStx2pZ+nRUcY6oDQ6V7g6Imz1ImNONMl82Cvh/pJcSuZN
X-Gm-Message-State: AOJu0Yy0LzsOf6dcyZIq1ikfSJ4BwhoA9nocd11I6Gmy8unsdq07Lf4T
	tbW3ajbEjvdqUNAUua8zPGHAmJ+m2qt1ze6JCZzdw+clPHznkfiR/oKJVkxQ
X-Google-Smtp-Source: AGHT+IG+D0l6DfepneZctCx/VQQeOlx1YOgoyeQ+hN3YPoAaK0e9uIe53cdwNnhuxyCx3RQMpgPJXw==
X-Received: by 2002:a17:902:6541:b0:1de:e954:c0e4 with SMTP id d1-20020a170902654100b001dee954c0e4mr346476pln.63.1711655731409;
        Thu, 28 Mar 2024 12:55:31 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id p16-20020a170902e75000b001dd7a97a266sm2006520plf.282.2024.03.28.12.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 12:55:31 -0700 (PDT)
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
	Wedson Almeida Filho <walmeida@microsoft.com>,
	Valentin Obst <kernel@valentinobst.de>
Subject: [PATCH v2 4/5] rust: introduce `InPlaceModule`
Date: Thu, 28 Mar 2024 16:54:56 -0300
Message-Id: <20240328195457.225001-5-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195457.225001-1-wedsonaf@gmail.com>
References: <20240328195457.225001-1-wedsonaf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wedson Almeida Filho <walmeida@microsoft.com>

This allows modules to be initialised in-place in pinned memory, which
enables the usage of pinned types (e.g., mutexes, spinlocks, driver
registrations, etc.) in modules without any extra allocations.

Drivers that don't need this may continue to implement `Module` without
any changes.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>
Tested-by: Valentin Obst <kernel@valentinobst.de>
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/lib.rs    | 23 +++++++++++++++++++++++
 rust/macros/module.rs | 18 ++++++------------
 2 files changed, 29 insertions(+), 12 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 9141a95efb25..64aee4fbc53b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -72,6 +72,29 @@ pub trait Module: Sized + Sync + Send {
     fn init(module: &'static ThisModule) -> error::Result<Self>;
 }
 
+/// A module that is pinned and initialised in-place.
+pub trait InPlaceModule: Sync + Send {
+    /// Creates an initialiser for the module.
+    ///
+    /// It is called when the module is loaded.
+    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error>;
+}
+
+impl<T: Module> InPlaceModule for T {
+    fn init(module: &'static ThisModule) -> impl init::PinInit<Self, error::Error> {
+        let initer = move |slot: *mut Self| {
+            let m = <Self as Module>::init(module)?;
+
+            // SAFETY: `slot` is valid for write per the contract with `pin_init_from_closure`.
+            unsafe { slot.write(m) };
+            Ok(())
+        };
+
+        // SAFETY: On success, `initer` always fully initialises an instance of `Self`.
+        unsafe { init::pin_init_from_closure(initer) }
+    }
+}
+
 /// Equivalent to `THIS_MODULE` in the C API.
 ///
 /// C header: [`include/linux/export.h`](srctree/include/linux/export.h)
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 6da1246742a5..4e5b5a68c3af 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -208,7 +208,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[used]
             static __IS_RUST_MODULE: () = ();
 
-            static mut __MOD: Option<{type_}> = None;
+            static mut __MOD: ::core::mem::MaybeUninit<{type_}> = ::core::mem::MaybeUninit::uninit();
 
             // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
             // freed until the module is unloaded.
@@ -275,23 +275,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             }}
 
             fn __init() -> ::core::ffi::c_int {{
-                match <{type_} as ::kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) => {{
-                        unsafe {{
-                            __MOD = Some(m);
-                        }}
-                        return 0;
-                    }}
-                    Err(e) => {{
-                        return e.to_errno();
-                    }}
+                let initer = <{type_} as ::kernel::InPlaceModule>::init(&THIS_MODULE);
+                match unsafe {{ ::kernel::init::PinInit::__pinned_init(initer, __MOD.as_mut_ptr()) }} {{
+                    Ok(m) => 0,
+                    Err(e) => e.to_errno(),
                 }}
             }}
 
             fn __exit() {{
                 unsafe {{
                     // Invokes `drop()` on `__MOD`, which should be used for cleanup.
-                    __MOD = None;
+                    __MOD.assume_init_drop();
                 }}
             }}
 
-- 
2.34.1


