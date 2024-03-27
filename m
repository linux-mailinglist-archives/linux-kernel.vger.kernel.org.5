Return-Path: <linux-kernel+bounces-120256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE2D88D4F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60DC51F2697F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52AF822F19;
	Wed, 27 Mar 2024 03:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c32wpE/f"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182A422F0C;
	Wed, 27 Mar 2024 03:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509839; cv=none; b=ZBHohMqNqh9yaLwmOrj5ubXq+pQxcHhLZQdmUKYyAHGeM/6zuUcfz1VApI6TNxBDHjIiL8e2MTnxDWUy3DJeKg4UVQVV3Vuy4AybVyXqtBlPja1msL4bUyZrCWFDuA+8X+vtOehhAc0HqgwPqB11z+KaZK0Lmd1t9qnXZT2ZJio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509839; c=relaxed/simple;
	bh=QTK9veWJUtRznTILI+a1O2z5NnyQ+z2ao2Kllmxfot0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=B3etbvYZl8zCvdKFu37bFa4vFKR6YSZxde81N30uKLuA/Dp+lMJKEnw/nSLuQo+PIyAgW8DacgA/Yr9v2UXMb8kHDnhqBrBdrDQxhQALSaIASy767MhJlvZ2Eb8o6IAh9Ed0OCx8IQ8UzTGsJZK9PSfHGDTu9ymXg/z/IPLCVMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c32wpE/f; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0edd0340fso13719505ad.2;
        Tue, 26 Mar 2024 20:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711509837; x=1712114637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TZM67YqrrYTYU88w0uRIxXydOOVRW2pUGRjFBMCT9Y=;
        b=c32wpE/feZyfpem/Su1xzSxxaaBo/YrqJ/iq6pggj6Sp7dsHRCaJ8kC4PwtQW+9SXm
         LXkhWwXiuiUkimZ72fGEK5VlhcjDyySyTzQcsGSPGhT6dbcUSeZk9XwkZ90MTG/mQ7tk
         FDoz0g3WrjvAZN3XbLUo+DaIcUEOyoUd297ynjrpeQ2Se3WtVvgg+2l3qMXKV39PoY7R
         5s74EfgnzfEAcVbyqer0V8fG89Esa3TVOK2tbgG101afcaqV1DZ8y4e8mlIJ2Lcv7LAb
         LcN9mCCNgaJyCaQSd/D6mZQp9GmSdtb/mgGTFw9JbA+KtjO4ECi/FvbzVtJs+rhJJFyp
         sypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711509837; x=1712114637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TZM67YqrrYTYU88w0uRIxXydOOVRW2pUGRjFBMCT9Y=;
        b=HR475isaeTGEIj+6hnffmCLvx7EOKz2kRJBF2rUFyPdhYzGzJUvKsT/yyRThnxstmR
         ew46cVJvw/bortqCQZsSJVgFuJgCI1Kw5n7P5dJfr1Adu7nPJFzMWP+tb1iFcuy4hwAg
         qYh7Dz3OhFPEfipP+5X4yuaruWsbUwoS5UgDFDk6PRv0q/aF20GzGiOiGGv8+QAquSDF
         o2W6sGiisNBVu/qfPyWpgd7Us+HANm2/82PSS/18orUC6bnZ/ukKSd+2XCKy/urepTZX
         MfDxin9GwdRWQ7FJFvpRmPcGKijH9ffzjdi/5zXbqWe5VvY9pd4QHb1TaASq3nW2jeu2
         O/Yg==
X-Forwarded-Encrypted: i=1; AJvYcCUH1FMXmA8P8wGlnT1Ye6DW+1cVBAu+J+AjPUWVFrnNT5YsYS0DCumsbBiuNP/rk7VYNo8+7fSnIlx6ZLBl5KyOB0SpIwSe7AnzW6lq
X-Gm-Message-State: AOJu0YyznoH5dTYw5qbsRKJk2g+jb4Xn8pES6XPhbg8kdyvZtsnFRaEH
	PLJuI2kkgYjKQBtPVqWdFxOAT0TiGFgDLW0MrhLQPgiOsTDjVo/mz4QNMRsw
X-Google-Smtp-Source: AGHT+IF5TjjmmkQelBSUb8cwKGRSqbezeu6XU3TythM5GU20a2h+WVaKVaz17mbbcicF3S5qhGifng==
X-Received: by 2002:a17:903:2b0e:b0:1e0:b883:a122 with SMTP id mc14-20020a1709032b0e00b001e0b883a122mr89242plb.46.1711509837329;
        Tue, 26 Mar 2024 20:23:57 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090322c100b001e043df262dsm7729090plg.33.2024.03.26.20.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:23:57 -0700 (PDT)
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
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 1/2] rust: introduce `InPlaceModule`
Date: Wed, 27 Mar 2024 00:23:36 -0300
Message-Id: <20240327032337.188938-2-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327032337.188938-1-wedsonaf@gmail.com>
References: <20240327032337.188938-1-wedsonaf@gmail.com>
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

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 rust/kernel/lib.rs    | 25 ++++++++++++++++++++++++-
 rust/macros/module.rs | 18 ++++++------------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 5c641233e26d..64aee4fbc53b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -62,7 +62,7 @@
 /// The top level entrypoint to implementing a kernel module.
 ///
 /// For any teardown or cleanup operations, your type may implement [`Drop`].
-pub trait Module: Sized + Sync {
+pub trait Module: Sized + Sync + Send {
     /// Called at module initialization time.
     ///
     /// Use this method to perform whatever setup or registration your module
@@ -72,6 +72,29 @@ pub trait Module: Sized + Sync {
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
index 27979e582e4b..0b2bb4ec2fba 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -208,7 +208,7 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             #[used]
             static __IS_RUST_MODULE: () = ();
 
-            static mut __MOD: Option<{type_}> = None;
+            static mut __MOD: core::mem::MaybeUninit<{type_}> = core::mem::MaybeUninit::uninit();
 
             // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
             // freed until the module is unloaded.
@@ -275,23 +275,17 @@ pub(crate) fn module(ts: TokenStream) -> TokenStream {
             }}
 
             fn __init() -> core::ffi::c_int {{
-                match <{type_} as kernel::Module>::init(&THIS_MODULE) {{
-                    Ok(m) => {{
-                        unsafe {{
-                            __MOD = Some(m);
-                        }}
-                        return 0;
-                    }}
-                    Err(e) => {{
-                        return e.to_errno();
-                    }}
+                let initer = <{type_} as kernel::InPlaceModule>::init(&THIS_MODULE);
+                match unsafe {{ initer.__pinned_init(__MOD.as_mut_ptr()) }} {{
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


