Return-Path: <linux-kernel+bounces-120257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63CED88D4F9
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:24:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C89D01F2C560
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A029A22F17;
	Wed, 27 Mar 2024 03:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWbN2nOc"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753DC241E9;
	Wed, 27 Mar 2024 03:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711509844; cv=none; b=sHPbMUBk9R5xKJnMHpgBc6beYIPDvTuxxdvaQSRxm4LUNj263EQokL9KjmDbWx3JUm4fXH9ea/Ef72kR1mMv2sBNFCI2xhLrw4MN62PkwVkoYGc2ypGHtbCs5fYuIfMdexmfuc6O8L0o3BUF5VHrSLpdzMHhpNG70VsalbBWET4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711509844; c=relaxed/simple;
	bh=rXsZKc9VdNaDW2hlrhw/V/PAjFJZllDwToJz511SSzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nmDi7aQWQtOyS7c0/B+WoCp1MdWM5ocuci1Pi9jVds/ntA9XRcVxfi39yv5IZpq4PRt1AZITC0EmeG5Aa9QzvZD5J058DNRQp2VtdQjxAQXvwTXadB3AyhJoREh7TT3prHAk6+Mv+3h6e5Ryg5gPR4xAqBjM1HAIUWl7ktdi7pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWbN2nOc; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e0025ef1efso41045515ad.1;
        Tue, 26 Mar 2024 20:24:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711509843; x=1712114643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TdCnxy848WA8LUn6hf+mVOuOXAd6/0/8vKwia4QjL5k=;
        b=XWbN2nOcwh+foaCqPo855NmAt8923nR85WXLNcKkdjL8L28Ps5vOqYPq6W+Of6G4Yj
         DFiZVdrpO1JMzZ1RyBESWReHb9RynW80Qou7zeQHeP9USS4UwfjStnY2d1aIf6q1oTuO
         5a+uZb1vkXhFMg7yZH476erOJDO8HaDMkxx0PV+NBHngsk1oUmcEn6S/n/bevRO+rh8Z
         reIsZ5hM8w3hARxcPqyA17IIA/VyAzRyZS063Gvnxisr4yPdpLrYb2xI5CRl1PSY0uJI
         WYAUwBXFB36VyJY6CFOh3dXYBmz2TKBvlvmgjIF7pwHzN78spoj5yckG7fpv1emyCHUg
         ohkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711509843; x=1712114643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TdCnxy848WA8LUn6hf+mVOuOXAd6/0/8vKwia4QjL5k=;
        b=ThrsSnmqAmdupWirB2ksT+c9I8OTzH+RHnN0LI6wFqnzSya/+QpJbInr5xl+IFQtCz
         6rsX+GL/152wDXHOVvKwcHquuOvh3PCNINteeF8WpSwluj/Va/kJygrY23iUTumLvGpW
         LkCZwDUE75w5Iw+zFapoTf9HK0PEpErsEjOjKddhHBY2XE17o9OkO9wwYMR1zg0P5OR8
         L3AgN/7DZlECcubuwRgenksabfVZmfdGElm3Ocsud5tulkOd3cdE5v3oHhHQ1q2A1zuO
         HzDfz90LY8gA1YCGrt2DqbNNgWpUrAa/oND25pbR5l1g+1Ey7vHbbiJX6Y4Qy/UE4lZq
         xGVw==
X-Forwarded-Encrypted: i=1; AJvYcCUOO2PWNyIOxg0JpS91tnEaSIOaYxQvAN2yWmmo0IbvVFKNgJdOdQKPXnglPzrJpp0GdKST5yBxBKr2iAFx6SfMrfuifGkAxVDdQC0P
X-Gm-Message-State: AOJu0Yzi4BOOSVrqqWwxC+pqvFr38M+XBIB/3cm6Eog0igIFY+Kldyza
	1U0YYoSdcUrEqbS+6nthDHefnw/5kWgGMO1yJtFhx9zToZUAeU5NvI0gtqpN
X-Google-Smtp-Source: AGHT+IEBI+p0UdXZ5IlHlYpK076I9KOOinyonweyyapbDoeGuc0oYvlIAsGLRGMFWLgN1uQT8i8wwg==
X-Received: by 2002:a17:902:900a:b0:1dc:cbaa:f5dd with SMTP id a10-20020a170902900a00b001dccbaaf5ddmr2759536plp.39.1711509842651;
        Tue, 26 Mar 2024 20:24:02 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y1-20020a17090322c100b001e043df262dsm7729090plg.33.2024.03.26.20.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 20:24:02 -0700 (PDT)
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
Subject: [PATCH 2/2] samples: rust: add in-place initialisation sample
Date: Wed, 27 Mar 2024 00:23:37 -0300
Message-Id: <20240327032337.188938-3-wedsonaf@gmail.com>
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

This is a modified version of rust_minimal that is initialised in-place.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 samples/rust/Kconfig         | 11 ++++++++++
 samples/rust/Makefile        |  1 +
 samples/rust/rust_inplace.rs | 42 ++++++++++++++++++++++++++++++++++++
 3 files changed, 54 insertions(+)
 create mode 100644 samples/rust/rust_inplace.rs

diff --git a/samples/rust/Kconfig b/samples/rust/Kconfig
index b0f74a81c8f9..59f44a8b6958 100644
--- a/samples/rust/Kconfig
+++ b/samples/rust/Kconfig
@@ -20,6 +20,17 @@ config SAMPLE_RUST_MINIMAL
 
 	  If unsure, say N.
 
+config SAMPLE_RUST_INPLACE
+	tristate "Minimal in-place"
+	help
+	  This option builds the Rust minimal module with in-place
+	  initialisation.
+
+	  To compile this as a module, choose M here:
+	  the module will be called rust_inplace.
+
+	  If unsure, say N.
+
 config SAMPLE_RUST_PRINT
 	tristate "Printing macros"
 	help
diff --git a/samples/rust/Makefile b/samples/rust/Makefile
index 03086dabbea4..791fc18180e9 100644
--- a/samples/rust/Makefile
+++ b/samples/rust/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 obj-$(CONFIG_SAMPLE_RUST_MINIMAL)		+= rust_minimal.o
+obj-$(CONFIG_SAMPLE_RUST_INPLACE)		+= rust_inplace.o
 obj-$(CONFIG_SAMPLE_RUST_PRINT)			+= rust_print.o
 
 subdir-$(CONFIG_SAMPLE_RUST_HOSTPROGS)		+= hostprogs
diff --git a/samples/rust/rust_inplace.rs b/samples/rust/rust_inplace.rs
new file mode 100644
index 000000000000..ba8d051cac56
--- /dev/null
+++ b/samples/rust/rust_inplace.rs
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Rust minimal in-place sample.
+
+use kernel::prelude::*;
+
+module! {
+    type: RustInPlace,
+    name: "rust_inplace",
+    author: "Rust for Linux Contributors",
+    description: "Rust minimal in-place sample",
+    license: "GPL",
+}
+
+#[pin_data(PinnedDrop)]
+struct RustInPlace {
+    numbers: Vec<i32>,
+}
+
+impl kernel::InPlaceModule for RustInPlace {
+    fn init(_module: &'static ThisModule) -> impl PinInit<Self, Error> {
+        pr_info!("Rust minimal sample (init)\n");
+        pr_info!("Am I built-in? {}\n", !cfg!(MODULE));
+        try_pin_init!(Self {
+            numbers: {
+                let mut numbers = Vec::new();
+                numbers.push(72, GFP_KERNEL)?;
+                numbers.push(108, GFP_KERNEL)?;
+                numbers.push(200, GFP_KERNEL)?;
+                numbers
+            },
+        })
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for RustInPlace {
+    fn drop(self: Pin<&mut Self>) {
+        pr_info!("My numbers are {:?}\n", self.numbers);
+        pr_info!("Rust minimal inplace sample (exit)\n");
+    }
+}
-- 
2.34.1


