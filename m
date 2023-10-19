Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844B7D041F
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346632AbjJSVlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 17:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346618AbjJSVlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 17:41:35 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A39BE
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:41:32 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3af64a4c97eso136696b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 14:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1697751692; x=1698356492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ozAkGUmu/g2vPdjYsuI5geKJqXaONTU37MWQT8rh8Io=;
        b=OPGtHXUb8Ixjv/Vv/Fes8/oObHpEDrLyW2gDVNW/xtHrt7yMEs43CCtdk08qV4MPZF
         aLgTY4DzgCgWbrh9cW5kWDJEoJZn34dBHuRAkvXi1+jLAa64pgVdnvcI8zs0Uv6Zzm4H
         MfzBGSacIG+MpPhht7Nuj2H7xOkhGpNu+IWg82sm47ifXWONK/Wo0bMSRR9Ok0hRB2Pr
         /X8pt8DI+jJI0r302ssFHFYyYPz719q74r0TRnGRtWppIVryPapXfZZyNFRfpFh6efy4
         cGzc4NhWzMGxZMSIO6twXOwORGABKg0gZbnnBoWNMHSI5nwlfx911w5yBUBZ1CwStupv
         3kHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697751692; x=1698356492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ozAkGUmu/g2vPdjYsuI5geKJqXaONTU37MWQT8rh8Io=;
        b=NOG9xGuDaz4MOk7c/UEPvC5k+74ghFLoSliVcMyPqUYNdCnpPZP5TikRrXNakLwh2G
         xPHmFb9fez1w4Sy6OMpREhYh3m1HLGlgaYOBH9SrclkM6H/DoG7rlK/hTG7C+/wLwKiD
         rqTE9seZzX3xL+67O1RzAHTabfac4UfZq45cm3DiyIr1xhhmmw9IuOv99CymHErLKWLj
         ctbFmr6NdBcCzJKo2jqhfA9Q7knZW734Vp5OXE+Zukzbs6MHcODREaaT7JCqk4NkyTYN
         Ez4jTPcCDuLtiWqoVOYZScSpq5hjzxqjqCTpclpzrqcUY/HLtalgSZupqK9E1j60MKOk
         rxQw==
X-Gm-Message-State: AOJu0YzWXwQcu7TPzZfrjpWTALdmpUy5TbO8y19mMomrauDGVAcXiB05
        Ehh8WscSkqv37jPHwImYQslT3A==
X-Google-Smtp-Source: AGHT+IEljrofNoN94x7na4QLki2sG4viIyrDKY/ruvd88QfcKlJJu1SSapq9pzvq0HL+u6r60tnkjQ==
X-Received: by 2002:a05:6808:1983:b0:3b2:f5be:4fd5 with SMTP id bj3-20020a056808198300b003b2f5be4fd5mr76801oib.14.1697751691691;
        Thu, 19 Oct 2023 14:41:31 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id x19-20020a9d6293000000b006ce2c785ac7sm81812otk.8.2023.10.19.14.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 14:41:31 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Thu, 19 Oct 2023 14:41:26 -0700
Subject: [PATCH v6 3/3] riscv: Add tests for riscv module loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231019-module_relocations-v6-3-94726e644321@rivosinc.com>
References: <20231019-module_relocations-v6-0-94726e644321@rivosinc.com>
In-Reply-To: <20231019-module_relocations-v6-0-94726e644321@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Samuel Holland <samuel.holland@sifive.com>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add test cases for the two main groups of relocations added: SUB and
SET, along with uleb128 which is a bit different because SUB and SET are
required to happen together.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/Kconfig.debug                           |  1 +
 arch/riscv/kernel/Makefile                         |  1 +
 arch/riscv/kernel/tests/Kconfig.debug              | 35 +++++++++
 arch/riscv/kernel/tests/Makefile                   |  1 +
 arch/riscv/kernel/tests/module_test/Makefile       | 15 ++++
 .../tests/module_test/test_module_linking_main.c   | 85 ++++++++++++++++++++++
 arch/riscv/kernel/tests/module_test/test_set16.S   | 23 ++++++
 arch/riscv/kernel/tests/module_test/test_set32.S   | 20 +++++
 arch/riscv/kernel/tests/module_test/test_set6.S    | 23 ++++++
 arch/riscv/kernel/tests/module_test/test_set8.S    | 23 ++++++
 arch/riscv/kernel/tests/module_test/test_sub16.S   | 22 ++++++
 arch/riscv/kernel/tests/module_test/test_sub32.S   | 22 ++++++
 arch/riscv/kernel/tests/module_test/test_sub6.S    | 22 ++++++
 arch/riscv/kernel/tests/module_test/test_sub64.S   | 27 +++++++
 arch/riscv/kernel/tests/module_test/test_sub8.S    | 22 ++++++
 arch/riscv/kernel/tests/module_test/test_uleb128.S | 20 +++++
 16 files changed, 362 insertions(+)

diff --git a/arch/riscv/Kconfig.debug b/arch/riscv/Kconfig.debug
index e69de29bb2d1..eafe17ebf710 100644
--- a/arch/riscv/Kconfig.debug
+++ b/arch/riscv/Kconfig.debug
@@ -0,0 +1 @@
+source "arch/riscv/kernel/tests/Kconfig.debug"
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 95cf25d48405..bb99657252f4 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -57,6 +57,7 @@ obj-y	+= stacktrace.o
 obj-y	+= cacheinfo.o
 obj-y	+= patch.o
 obj-y	+= probes/
+obj-y	+= tests/
 obj-$(CONFIG_MMU) += vdso.o vdso/
 
 obj-$(CONFIG_RISCV_M_MODE)	+= traps_misaligned.o
diff --git a/arch/riscv/kernel/tests/Kconfig.debug b/arch/riscv/kernel/tests/Kconfig.debug
new file mode 100644
index 000000000000..5dba64e8e977
--- /dev/null
+++ b/arch/riscv/kernel/tests/Kconfig.debug
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "arch/riscv/kernel Testing and Coverage"
+
+config AS_HAS_ULEB128
+	def_bool $(as-instr,.reloc label$(comma) R_RISCV_SET_ULEB128$(comma) 127\n.reloc label$(comma) R_RISCV_SUB_ULEB128$(comma) 127\nlabel:\n.word 0)
+
+menuconfig RUNTIME_KERNEL_TESTING_MENU
+       bool "arch/riscv/kernel runtime Testing"
+       def_bool y
+       help
+         Enable riscv kernel runtime testing.
+
+if RUNTIME_KERNEL_TESTING_MENU
+
+config RISCV_MODULE_LINKING_KUNIT
+       bool "KUnit test riscv module linking at runtime" if !KUNIT_ALL_TESTS
+       depends on KUNIT
+       default KUNIT_ALL_TESTS
+       help
+         Enable this option to test riscv module linking at boot. This will
+	 enable a module called "test_module_linking".
+
+         KUnit tests run during boot and output the results to the debug log
+         in TAP format (http://testanything.org/). Only useful for kernel devs
+         running the KUnit test harness, and not intended for inclusion into a
+         production build.
+
+         For more information on KUnit and unit tests in general please refer
+         to the KUnit documentation in Documentation/dev-tools/kunit/.
+
+         If unsure, say N.
+
+endif # RUNTIME_TESTING_MENU
+
+endmenu # "arch/riscv/kernel runtime Testing"
diff --git a/arch/riscv/kernel/tests/Makefile b/arch/riscv/kernel/tests/Makefile
new file mode 100644
index 000000000000..7d6c76cffe20
--- /dev/null
+++ b/arch/riscv/kernel/tests/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_RISCV_MODULE_LINKING_KUNIT)	+= module_test/
diff --git a/arch/riscv/kernel/tests/module_test/Makefile b/arch/riscv/kernel/tests/module_test/Makefile
new file mode 100644
index 000000000000..d7a6fd8943de
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/Makefile
@@ -0,0 +1,15 @@
+obj-m += test_module_linking.o
+
+test_sub := test_sub6.o test_sub8.o test_sub16.o test_sub32.o test_sub64.o
+
+test_set := test_set6.o test_set8.o test_set16.o test_set32.o
+
+test_module_linking-objs += $(test_sub)
+
+test_module_linking-objs += $(test_set)
+
+ifeq ($(CONFIG_AS_HAS_ULEB128),y)
+test_module_linking-objs += test_uleb128.o
+endif
+
+test_module_linking-objs += test_module_linking_main.o
diff --git a/arch/riscv/kernel/tests/module_test/test_module_linking_main.c b/arch/riscv/kernel/tests/module_test/test_module_linking_main.c
new file mode 100644
index 000000000000..49820352f1df
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_module_linking_main.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <kunit/test.h>
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Test module linking");
+
+extern int test_set32(void);
+extern int test_set16(void);
+extern int test_set8(void);
+extern int test_set6(void);
+extern long test_sub64(void);
+extern int test_sub32(void);
+extern int test_sub16(void);
+extern int test_sub8(void);
+extern int test_sub6(void);
+
+#ifdef CONFIG_AS_HAS_ULEB128
+extern int test_uleb(void);
+#endif
+
+#define CHECK_EQ(lhs, rhs) KUNIT_ASSERT_EQ(test, lhs, rhs)
+
+void run_test_set(struct kunit *test);
+void run_test_sub(struct kunit *test);
+void run_test_uleb(struct kunit *test);
+
+void run_test_set(struct kunit *test)
+{
+	int val32 = test_set32();
+	int val16 = test_set16();
+	int val8 = test_set8();
+	int val6 = test_set6();
+
+	CHECK_EQ(val32, 0);
+	CHECK_EQ(val16, 0);
+	CHECK_EQ(val8, 0);
+	CHECK_EQ(val6, 0);
+}
+
+void run_test_sub(struct kunit *test)
+{
+	int val64 = test_sub64();
+	int val32 = test_sub32();
+	int val16 = test_sub16();
+	int val8 = test_sub8();
+	int val6 = test_sub6();
+
+	CHECK_EQ(val64, 0);
+	CHECK_EQ(val32, 0);
+	CHECK_EQ(val16, 0);
+	CHECK_EQ(val8, 0);
+	CHECK_EQ(val6, 0);
+}
+
+#ifdef CONFIG_AS_HAS_ULEB128
+void run_test_uleb(struct kunit *test)
+{
+	int valuleb = test_uleb();
+
+	CHECK_EQ(valuleb, 0);
+}
+#endif
+
+static struct kunit_case __refdata riscv_module_linking_test_cases[] = {
+	KUNIT_CASE(run_test_set),
+	KUNIT_CASE(run_test_sub),
+#ifdef CONFIG_AS_HAS_ULEB128
+	KUNIT_CASE(run_test_uleb),
+#endif
+	{}
+};
+
+static struct kunit_suite riscv_module_linking_test_suite = {
+	.name = "riscv_checksum",
+	.test_cases = riscv_module_linking_test_cases,
+};
+
+kunit_test_suites(&riscv_module_linking_test_suite);
diff --git a/arch/riscv/kernel/tests/module_test/test_set16.S b/arch/riscv/kernel/tests/module_test/test_set16.S
new file mode 100644
index 000000000000..2be0e441a12e
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_set16.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_set16
+test_set16:
+	lw	a0, set16
+	la	t0, set16
+#ifdef CONFIG_32BIT
+	slli	t0, t0, 16
+	srli	t0, t0, 16
+#else
+	slli	t0, t0, 48
+	srli	t0, t0, 48
+#endif
+	sub	a0, a0, t0
+	ret
+.data
+set16:
+	.reloc set16, R_RISCV_SET16, set16
+	.word 0
diff --git a/arch/riscv/kernel/tests/module_test/test_set32.S b/arch/riscv/kernel/tests/module_test/test_set32.S
new file mode 100644
index 000000000000..de0444537e67
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_set32.S
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_set32
+test_set32:
+	lw	a0, set32
+	la	t0, set32
+#ifndef CONFIG_32BIT
+	slli	t0, t0, 32
+	srli	t0, t0, 32
+#endif
+	sub	a0, a0, t0
+	ret
+.data
+set32:
+	.reloc set32, R_RISCV_SET32, set32
+	.word 0
diff --git a/arch/riscv/kernel/tests/module_test/test_set6.S b/arch/riscv/kernel/tests/module_test/test_set6.S
new file mode 100644
index 000000000000..c39ce4c219eb
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_set6.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_set6
+test_set6:
+	lw	a0, set6
+	la	t0, set6
+#ifdef CONFIG_32BIT
+	slli	t0, t0, 26
+	srli	t0, t0, 26
+#else
+	slli	t0, t0, 58
+	srli	t0, t0, 58
+#endif
+	sub	a0, a0, t0
+	ret
+.data
+set6:
+	.reloc set6, R_RISCV_SET6, set6
+	.word 0
diff --git a/arch/riscv/kernel/tests/module_test/test_set8.S b/arch/riscv/kernel/tests/module_test/test_set8.S
new file mode 100644
index 000000000000..a656173f6f99
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_set8.S
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_set8
+test_set8:
+	lw	a0, set8
+	la	t0, set8
+#ifdef CONFIG_32BIT
+	slli	t0, t0, 24
+	srli	t0, t0, 24
+#else
+	slli	t0, t0, 56
+	srli	t0, t0, 56
+#endif
+	sub	a0, a0, t0
+	ret
+.data
+set8:
+	.reloc set8, R_RISCV_SET8, set8
+	.word 0
diff --git a/arch/riscv/kernel/tests/module_test/test_sub16.S b/arch/riscv/kernel/tests/module_test/test_sub16.S
new file mode 100644
index 000000000000..c561e155d1db
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_sub16.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_sub16
+test_sub16:
+	lh	a0, sub16
+	addi	a0, a0, -32
+	ret
+first:
+	.rept 8
+	.word 0
+	.endr
+second:
+
+.data
+sub16:
+	.reloc		sub16, R_RISCV_ADD16, second
+	.reloc		sub16, R_RISCV_SUB16, first
+	.half		0
diff --git a/arch/riscv/kernel/tests/module_test/test_sub32.S b/arch/riscv/kernel/tests/module_test/test_sub32.S
new file mode 100644
index 000000000000..93232c70cae6
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_sub32.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_sub32
+test_sub32:
+	lw	a0, sub32
+	addi	a0, a0, -32
+	ret
+first:
+	.rept 8
+	.word 0
+	.endr
+second:
+
+.data
+sub32:
+	.reloc		sub32, R_RISCV_ADD32, second
+	.reloc		sub32, R_RISCV_SUB32, first
+	.word		0
diff --git a/arch/riscv/kernel/tests/module_test/test_sub6.S b/arch/riscv/kernel/tests/module_test/test_sub6.S
new file mode 100644
index 000000000000..d9c9526ceb62
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_sub6.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_sub6
+test_sub6:
+	lb	a0, sub6
+	addi	a0, a0, -32
+	ret
+first:
+	.rept 8
+	.word 0
+	.endr
+second:
+
+.data
+sub6:
+	.reloc		sub6, R_RISCV_SET6, second
+	.reloc		sub6, R_RISCV_SUB6, first
+	.byte		0
diff --git a/arch/riscv/kernel/tests/module_test/test_sub64.S b/arch/riscv/kernel/tests/module_test/test_sub64.S
new file mode 100644
index 000000000000..6d260e2a5d98
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_sub64.S
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_sub64
+test_sub64:
+#ifdef CONFIG_32BIT
+	lw	a0, sub64
+#else
+	ld	a0, sub64
+#endif
+	addi	a0, a0, -32
+	ret
+first:
+	.rept 8
+	.word 0
+	.endr
+second:
+
+.data
+sub64:
+	.reloc		sub64, R_RISCV_ADD64, second
+	.reloc		sub64, R_RISCV_SUB64, first
+	.word		0
+	.word		0
diff --git a/arch/riscv/kernel/tests/module_test/test_sub8.S b/arch/riscv/kernel/tests/module_test/test_sub8.S
new file mode 100644
index 000000000000..af7849115d4d
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_sub8.S
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_sub8
+test_sub8:
+	lb	a0, sub8
+	addi	a0, a0, -32
+	ret
+first:
+	.rept 8
+	.word 0
+	.endr
+second:
+
+.data
+sub8:
+	.reloc		sub8, R_RISCV_ADD8, second
+	.reloc		sub8, R_RISCV_SUB8, first
+	.byte		0
diff --git a/arch/riscv/kernel/tests/module_test/test_uleb128.S b/arch/riscv/kernel/tests/module_test/test_uleb128.S
new file mode 100644
index 000000000000..db9f301092d0
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_uleb128.S
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2023 Rivos Inc.
+ */
+
+.text
+.global test_uleb
+test_uleb:
+	ld	a0, second
+	addi	a0, a0, -127
+	ret
+.data
+first:
+	.rept 127
+	.byte 0
+	.endr
+second:
+	.reloc second, R_RISCV_SET_ULEB128, second
+	.reloc second, R_RISCV_SUB_ULEB128, first
+	.dword 0

-- 
2.42.0

