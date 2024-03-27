Return-Path: <linux-kernel+bounces-121946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B0288EFC6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 21:04:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9A81C334B8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845D61552E1;
	Wed, 27 Mar 2024 20:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jOltWDy+"
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EC9154BE0
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 20:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569738; cv=none; b=CVNwHXFcb9vgbWbMX/L9iUoi48memYMtP9dfsSAJtEvS1Q6+hU4tLpwUXo4RCGhq6/gVRGw3fmTKc7T0AeI/PRAWEm8ZNJvvxqt96wSghWkXa59Q4HFsLnqq47Gok5Qh8RcXROcIphKixo82OLIB1exuXNZwg/u7caXarJf3sGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569738; c=relaxed/simple;
	bh=GLOA3AwKqg2OXJCgfGVxEWRiYujUlmeNO1fdj8ZA+Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMYOyQpOXal7yxQrkYeFs7bjO2YVsrAgGcvIocKSF02/i6gcvxJy3cK0Bby4t1ztuu/ymv21qD+KLp9WqhoqnsZZGfJvkeXM/dp9Jp9GxZICQ7t3PgoNFFNWb7eaBY8+xjYO/CDVcdW9C0gH+UwW+HTbzt9Z4S2Y8ujHFu1MA08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jOltWDy+; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e0d82d441bso2013075ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711569736; x=1712174536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WUVdv0rxxPa8lHoyIaYtKDRoPzXAvzEPK1q3j7PbRrc=;
        b=jOltWDy+Thxmmty2DIUbDSmP81TByO4nFyhc8IwxuXtFEX5AgHBKZ0y4Fak6Jh+R9w
         PJxsYnjLOrC4nlXDe68Z9GbbFPva4GmbFuHml5AGAh9mOyieSywkVsQi0VLvF7uObAAZ
         x199peNXPNVyZ7EVogcZhYaTGNxz3sSVYcjcDE7Y+q7/APhrIuE/s7rRPl6edttAcBln
         wVYA94a6aI2gbuL3OksGWQ8JFeS3Ueki8lwytu5rXyAc/47oxxpUf5DP61Xvt0+hsIQg
         wOPsJMlTFDba/hDZ8/Y4GtM83EO6uHVpIo6o8nxLymgora9VlVbE4pKNJVHo1/PHTXg1
         tNQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569736; x=1712174536;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WUVdv0rxxPa8lHoyIaYtKDRoPzXAvzEPK1q3j7PbRrc=;
        b=V1LlH5te4xwIpiHz6fkHeB4RirWZ67dwNAS7gcc8AK7zTLGlskSe6uWFaY6GxKkpOh
         gb/zIwlhLh+P2NjJTdaNCdkqf8rfGEGrh90VpDrR8HV0EQZQ1XWrH9E7Ne9EmOaUAZY7
         Dp1P+lJLquHhbKKgLHxHYCwfrI629PnACLm9iQ52Kij2QEyNFMOw3CZxKAdMHJ9rbPwZ
         PfRY5hTZEmTgtGGF7zOGfSXLuZd2tQeeeu4I15zSvSkrEYoYxEEOIrnDMO8Zwe5HN/IT
         5AglPikFlW/nEGxXG9IrszYKn0s+itD9rcbRCFbMOZVXWJa5tL2/S4JA68+33EEDy4ta
         lYYA==
X-Gm-Message-State: AOJu0YxeRyBv0E2gWRO3lomVFY47swvW9n17iohtlYKLD5x1V/5E6OnS
	4W8EpeAusxBcorTIpX2faS7S8wMbi80sOswpBlOD/V1GHIoFT2f9lCTaO0a5bP3XRtvkl0nmdZu
	V
X-Google-Smtp-Source: AGHT+IElWB3obfH3WLoSJnhNdDLs9puYhG8ITpGoTToOUpNvi6XoJmk6eGirKGJFaRPnDc33GdSn9w==
X-Received: by 2002:a17:902:b28c:b0:1e0:e85b:2d30 with SMTP id u12-20020a170902b28c00b001e0e85b2d30mr669199plr.42.1711569736542;
        Wed, 27 Mar 2024 13:02:16 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id u4-20020a170902e5c400b001dd0d0d26a4sm9446459plf.147.2024.03.27.13.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 13:02:16 -0700 (PDT)
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
Subject: [PATCH v3 13/14] selftests/fpu: Move FP code to a separate translation unit
Date: Wed, 27 Mar 2024 13:00:44 -0700
Message-ID: <20240327200157.1097089-14-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240327200157.1097089-1-samuel.holland@sifive.com>
References: <20240327200157.1097089-1-samuel.holland@sifive.com>
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
2.43.1


