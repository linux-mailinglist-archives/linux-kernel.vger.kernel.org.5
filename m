Return-Path: <linux-kernel+bounces-124241-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029A5891444
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23A21B24911
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3B069E0F;
	Fri, 29 Mar 2024 07:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="UWIwmaot"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107335D8FD
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711697108; cv=none; b=epi1PdHL5mby+NATWRSyui1s15EVQubRIKijB7i99tWkFIOaJPQwvh7lv8icptm8NVfOQ3xMROsYNwjGPk67RjFQDETMOFZPDd1oIVGZpE8cxbzlKEnf1SqymPGR27KQ294EaRAz31DHF+04U+pt+1hv3ZY1Fn7imjHohJPwI+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711697108; c=relaxed/simple;
	bh=sDSM8SzyTSBzvwgCVM/QtpZk9UVDm9MyzCcLceVlwvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBUpYlvYEuJ/r0zNXdOu2elQghAyqw2Juno+I2XpvDs7VPJoeJa7QQdxX4jojS3P8oluOqEWbw+hZX8hZfzo4N+USs85iiTGVIj84hRl1myuT3W+wLNDKpFlTpzCkSO7Ge2YiDB+YdOczdkYO4oIUyVIbdJIFAtiKzOJtPuwWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=UWIwmaot; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29fb12a22afso1334851a91.3
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711697106; x=1712301906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IERaZRfF/9oogZdizMupzfKIm+UO6QVYkIeFwIsamZU=;
        b=UWIwmaot0nXODV6lmi/3x88Uajdml4SyA9rrPah4N4ilELSLttuLO7mbY4ueV2UfOM
         2LlJrMCAtRE/ZDCH7Ae58GYDpez9Z2ZcuOHtupvDIUKJwvy/HNFiDI4HV3Lq39Adw4fK
         H+FkMOdVAnuctEgzQ8mTvAIrkyzVFAnZ9nX+e6pHswOK1DGS41B/7zYEgiucoXafsWsV
         EgA00nVMlqROx1eWCPQidkeGqlxbwB0u0iOjeMuJpYoVXm0bUIGOGvNcWUaIXEs3yaOn
         pwcmUC6Nkt5CsgVf+We/CMYTAb4UjNdITvnpLnYMPFFZ5mexQPiJsSIUPP8gYzILvfkR
         Z8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711697106; x=1712301906;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IERaZRfF/9oogZdizMupzfKIm+UO6QVYkIeFwIsamZU=;
        b=Xh29XcVpHiTe0iqNLh4I6PGcMj1QVsqyL8VNlOcO4HA5NPxu19CGvntInD5sl6sTH/
         XiYdyEgh8Dle1vm/8boIAMYQfp/ZSGx7u1bc0wqwLkBdCu0HqdlGM8rMGGsX1kGmxtPM
         THuPbTbw5pc67etnOfC6V0CrFhgsYkYQHQ6yTlmexHr+CvsBmAUovqDJHJjxXjT0CYv5
         yC6lDNNESNszjKT6D2mY36YHIBGjrYOq6fW4KDw3IbxP2wyijBLIaNA2e2FCDU4RZTqL
         j1JSMZln+GNbusTCGqLqbsg2kwpYM43sSw+W/d9wm2/Qpv4wccdoO+/A8e/XtU0tFnF4
         SadQ==
X-Gm-Message-State: AOJu0YzySe5M6+qYOcNpdLkfwyAjKCUi0sF1GjH0iAvECaRRSget/JJg
	Bxew7wwJq4SalalLw+QM9eWg5nx5Xpi1UTqFRNeQgTR0gi0/9Xmh+KGWjeeP2Qw=
X-Google-Smtp-Source: AGHT+IEgFbP2oHNJWaGrzpoC9/WKXB2wk7z5kOFJSRoINaDHcY2EGHO1B7+JnkXlN7mfRYkSUpJEAg==
X-Received: by 2002:a17:90a:3ee6:b0:2a0:3a16:7489 with SMTP id k93-20020a17090a3ee600b002a03a167489mr1460482pjc.44.1711697106489;
        Fri, 29 Mar 2024 00:25:06 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a010800b0029ddac03effsm4971798pjb.11.2024.03.29.00.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 00:25:06 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Andrew Morton <akpm@linux-foundation.org>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	loongarch@lists.linux.dev,
	amd-gfx@lists.freedesktop.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v4 14/15] selftests/fpu: Move FP code to a separate translation unit
Date: Fri, 29 Mar 2024 00:18:29 -0700
Message-ID: <20240329072441.591471-15-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329072441.591471-1-samuel.holland@sifive.com>
References: <20240329072441.591471-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This ensures no compiler-generated floating-point code can appear
outside kernel_fpu_{begin,end}() sections, and some architectures
enforce this separation.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

(no changes since v2)

Changes in v2:
 - Declare test_fpu() in a header

 lib/Makefile                        |  3 ++-
 lib/test_fpu.h                      |  8 +++++++
 lib/{test_fpu.c => test_fpu_glue.c} | 32 +------------------------
 lib/test_fpu_impl.c                 | 37 +++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+), 32 deletions(-)
 create mode 100644 lib/test_fpu.h
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

diff --git a/lib/Makefile b/lib/Makefile
index ffc6b2341b45..fcb35bf50979 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -133,7 +133,8 @@ FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-st
 endif
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
-CFLAGS_test_fpu.o += $(FPU_CFLAGS)
+test_fpu-y := test_fpu_glue.o test_fpu_impl.o
+CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
 
 # Some KUnit files (hooks.o) need to be built-in even when KUnit is a module,
 # so we can't just use obj-$(CONFIG_KUNIT).
diff --git a/lib/test_fpu.h b/lib/test_fpu.h
new file mode 100644
index 000000000000..4459807084bc
--- /dev/null
+++ b/lib/test_fpu.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+
+#ifndef _LIB_TEST_FPU_H
+#define _LIB_TEST_FPU_H
+
+int test_fpu(void);
+
+#endif
diff --git a/lib/test_fpu.c b/lib/test_fpu_glue.c
similarity index 71%
rename from lib/test_fpu.c
rename to lib/test_fpu_glue.c
index e82db19fed84..85963d7be826 100644
--- a/lib/test_fpu.c
+++ b/lib/test_fpu_glue.c
@@ -19,37 +19,7 @@
 #include <linux/debugfs.h>
 #include <asm/fpu/api.h>
 
-static int test_fpu(void)
-{
-	/*
-	 * This sequence of operations tests that rounding mode is
-	 * to nearest and that denormal numbers are supported.
-	 * Volatile variables are used to avoid compiler optimizing
-	 * the calculations away.
-	 */
-	volatile double a, b, c, d, e, f, g;
-
-	a = 4.0;
-	b = 1e-15;
-	c = 1e-310;
-
-	/* Sets precision flag */
-	d = a + b;
-
-	/* Result depends on rounding mode */
-	e = a + b / 2;
-
-	/* Denormal and very large values */
-	f = b / c;
-
-	/* Depends on denormal support */
-	g = a + c * f;
-
-	if (d > a && e > a && g > a)
-		return 0;
-	else
-		return -EINVAL;
-}
+#include "test_fpu.h"
 
 static int test_fpu_get(void *data, u64 *val)
 {
diff --git a/lib/test_fpu_impl.c b/lib/test_fpu_impl.c
new file mode 100644
index 000000000000..777894dbbe86
--- /dev/null
+++ b/lib/test_fpu_impl.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
+
+#include "test_fpu.h"
+
+int test_fpu(void)
+{
+	/*
+	 * This sequence of operations tests that rounding mode is
+	 * to nearest and that denormal numbers are supported.
+	 * Volatile variables are used to avoid compiler optimizing
+	 * the calculations away.
+	 */
+	volatile double a, b, c, d, e, f, g;
+
+	a = 4.0;
+	b = 1e-15;
+	c = 1e-310;
+
+	/* Sets precision flag */
+	d = a + b;
+
+	/* Result depends on rounding mode */
+	e = a + b / 2;
+
+	/* Denormal and very large values */
+	f = b / c;
+
+	/* Depends on denormal support */
+	g = a + c * f;
+
+	if (d > a && e > a && g > a)
+		return 0;
+	else
+		return -EINVAL;
+}
-- 
2.44.0


