Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBF60809C0C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233327AbjLHFzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573237AbjLHFzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:55:18 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000791722
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 21:55:17 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1d04dba2781so14486915ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 21:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1702014916; x=1702619716; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jlkhIfYEZ3lvxXxXZeJnWgi8rztsMBcyR5bRnlna3ss=;
        b=AEao+vb1AvlKCIZJWmSxqBAoZQ2zLBQiff9us//NXqfNiWxT5xzE6uPZhc9It8sve3
         8EnnnmYC4H/51rhQd8qSg4DzVBrdvRBSQDUeodRh1Ihu73hxhKklJKAXANtJkiJq84mi
         WOEHhznz2WCEjTOH7IyC6Vs9FDPTxV+ll8wnMS+WZ3tDZ+nFF6f5BQhByzOHWOwjldRm
         V9avHASvOEafq/ltXFpavUtVMr7EQfoDO+tP9IhtEW89dF59ygk10LH4S/EJknTwjUJg
         MR5gsMOrcVWlE5WciXozIIqRuR6tabKbslZMqykkMx6Rx20twrpzeQmSLOVBuobZ09Nt
         /Deg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702014916; x=1702619716;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jlkhIfYEZ3lvxXxXZeJnWgi8rztsMBcyR5bRnlna3ss=;
        b=MSBtA+wSoW02/UAMJaByTIqVysNnmd+zcDW14nGodee8fqXg7hsqnVBi23acM+RTe4
         PxraPVQ9vCg3uRjD+n+6B6nFXJXBonaCPpgaQ1I1RSYwy8utKm3YQFAzA0MRY/tob/Ac
         s96Y41MntGAqghbNUgVMmbG3lxPXIsBlfreAKPgVxHXpeuxj76uDRUh6qINFwv0oysuo
         wxnOQz2MRe94bn4WHI7u5AIKEe6oVXL5rYRbuD9xAyJC7eRQDwbTDJqaEF0xuv8oxano
         AVI5hrK4rqb+8Q7GB8OT6Ee02+5o2WRNrWDvJ809IYQUAtaPRbUmBZcBDRUCB+jlGdK8
         yA/g==
X-Gm-Message-State: AOJu0Yzzbe6/zRAesaiFWaSRKrGHM6JLTIJqe8meyDxcKGPYhBpKMzM0
        ZVhyT6/pXx4fO/miwiC5/5Qxnbk9GJXHH5ruXZw=
X-Google-Smtp-Source: AGHT+IFq3S7FmJealx+s/zAc0NWuz2K3VM/cjjAkpGlz2K3tHlLviwkN/+BPcQyJZRioERW0JqTrBw==
X-Received: by 2002:a17:902:b60f:b0:1d0:c7e0:c82c with SMTP id b15-20020a170902b60f00b001d0c7e0c82cmr2930083pls.8.1702014916347;
        Thu, 07 Dec 2023 21:55:16 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id s22-20020a170902989600b001ce5b859a59sm786250plp.305.2023.12.07.21.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 21:55:16 -0800 (PST)
From:   Samuel Holland <samuel.holland@sifive.com>
To:     linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org, x86@kernel.org,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arch@vger.kernel.org,
        Samuel Holland <samuel.holland@sifive.com>
Subject: [RFC PATCH 11/12] selftests/fpu: Move FP code to a separate translation unit
Date:   Thu,  7 Dec 2023 21:54:41 -0800
Message-ID: <20231208055501.2916202-12-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231208055501.2916202-1-samuel.holland@sifive.com>
References: <20231208055501.2916202-1-samuel.holland@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This ensures no compiler-generated floating-point code can appear
outside kernel_fpu_{begin,end}() sections, and some architectures
enforce this separation.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 lib/Makefile                        |  3 ++-
 lib/{test_fpu.c => test_fpu_glue.c} | 32 +-------------------------
 lib/test_fpu_impl.c                 | 35 +++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 32 deletions(-)
 rename lib/{test_fpu.c => test_fpu_glue.c} (71%)
 create mode 100644 lib/test_fpu_impl.c

diff --git a/lib/Makefile b/lib/Makefile
index 6b09731d8e61..e7cbd54944a2 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -132,7 +132,8 @@ FPU_CFLAGS += $(call cc-option,-msse -mpreferred-stack-boundary=3,-mpreferred-st
 endif
 
 obj-$(CONFIG_TEST_FPU) += test_fpu.o
-CFLAGS_test_fpu.o += $(FPU_CFLAGS)
+test_fpu-y := test_fpu_glue.o test_fpu_impl.o
+CFLAGS_test_fpu_impl.o += $(FPU_CFLAGS)
 
 obj-$(CONFIG_TEST_LIVEPATCH) += livepatch/
 
diff --git a/lib/test_fpu.c b/lib/test_fpu_glue.c
similarity index 71%
rename from lib/test_fpu.c
rename to lib/test_fpu_glue.c
index e82db19fed84..2761b51117b0 100644
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
+int test_fpu(void);
 
 static int test_fpu_get(void *data, u64 *val)
 {
diff --git a/lib/test_fpu_impl.c b/lib/test_fpu_impl.c
new file mode 100644
index 000000000000..2ff01980bc22
--- /dev/null
+++ b/lib/test_fpu_impl.c
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/errno.h>
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
2.42.0

