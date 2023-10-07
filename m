Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB037BC363
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 02:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbjJGAle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 20:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233971AbjJGAl1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 20:41:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33127C2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 17:41:21 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1c5bf7871dcso22513065ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 17:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1696639280; x=1697244080; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=quPiij4Hl/2QN709N3Bb2iU2ZbtHkZ/YhK8HJoao894=;
        b=wBjGtJMS1p6aB8ewvpSLeWtiH4A+j2XjLmvFFQ+zcH4IPIJ9/i4gtBg/PyhCoI8yfI
         6AP2JEjNUrkK0tRDigkPjMqWXGyQW7MR6q21a2sW56UAQZbwiI9HNjo+cJ3pAMBgWQCN
         NFu5JscSQi9AuQo14a2EbsxB7hbsKqJ0buPQ1hpC/meoyAEYWXYcvQAjYjC+8k03IL/f
         owE/GT0pMPAGRJzTnmDUeuY/H1ucKnfySJrP7tRmSEjjPWE+Nt14xcSD3RPZMvuk482K
         xl5twldlsNGTcfGKRdHV8OT8tNMRHdDrPsWlIxU1AH2/cDt7663iaUtEQVuA/xYk0Z8g
         hMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696639280; x=1697244080;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quPiij4Hl/2QN709N3Bb2iU2ZbtHkZ/YhK8HJoao894=;
        b=jdv5IG5yDNwIsEizDSrhbWjs8x7QLjcHPu24ebZXHsFR/B7yozK5TR9Y9z9JT7aqPq
         6xzRfFWi3PHSBH6uycwlqmxMjP+4wrFhYs+pN+BdfL35PaoPxR8CcicCc7rmTRfFQHjz
         VwXUqGEVQjgq/vM2ElpPC+VtKwHYFAv6cFIsoz+OE/2uWCB/mQUiO6VWkJll+IPsaacv
         p6kU+xWyElh8glC+FuFWPuuTSbuoYiW24VOYpH9t6zWtkNteaJgyQbaYnzYsaCzBUnmA
         uPciZ26ADZ7W3GV5L97Zi9KqCLeOT8qETVP3Z5OY7MZKxB74iVWhfaqbN63sLeQRwwuL
         AZYw==
X-Gm-Message-State: AOJu0Yyv1Uzge1rfGU7TsXkABDaD0CYo6xAN7xDc3wWyAr+WxGKz7oni
        N7UivK84cHvyhJ4ajoGu2nHfZg==
X-Google-Smtp-Source: AGHT+IEEUABMKZY8ptm1CgPE5q3EicYYQrAkQEiO6mXlX1KJyrzOPhZei1nxELWEjkIlLANGsJfdgA==
X-Received: by 2002:a17:902:cecb:b0:1c3:411c:9b7d with SMTP id d11-20020a170902cecb00b001c3411c9b7dmr11238500plg.57.1696639280637;
        Fri, 06 Oct 2023 17:41:20 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id x16-20020a170902ec9000b001c582de968dsm4534540plg.72.2023.10.06.17.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 17:41:20 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Fri, 06 Oct 2023 17:41:07 -0700
Subject: [PATCH v2 2/2] riscv: Add tests for riscv module loading
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231006-module_relocations-v2-2-47566453fedc@rivosinc.com>
References: <20231006-module_relocations-v2-0-47566453fedc@rivosinc.com>
In-Reply-To: <20231006-module_relocations-v2-0-47566453fedc@rivosinc.com>
To:     linux-riscv@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 arch/riscv/kernel/tests/Kconfig.debug              | 32 ++++++++++
 arch/riscv/kernel/tests/Makefile                   |  1 +
 arch/riscv/kernel/tests/module_test/Makefile       | 15 +++++
 .../tests/module_test/test_module_linking_main.c   | 73 ++++++++++++++++++++++
 arch/riscv/kernel/tests/module_test/test_set16.S   | 23 +++++++
 arch/riscv/kernel/tests/module_test/test_set32.S   | 20 ++++++
 arch/riscv/kernel/tests/module_test/test_set6.S    | 23 +++++++
 arch/riscv/kernel/tests/module_test/test_set8.S    | 23 +++++++
 arch/riscv/kernel/tests/module_test/test_sub16.S   | 22 +++++++
 arch/riscv/kernel/tests/module_test/test_sub32.S   | 22 +++++++
 arch/riscv/kernel/tests/module_test/test_sub6.S    | 22 +++++++
 arch/riscv/kernel/tests/module_test/test_sub64.S   | 27 ++++++++
 arch/riscv/kernel/tests/module_test/test_sub8.S    | 22 +++++++
 arch/riscv/kernel/tests/module_test/test_uleb128.S | 20 ++++++
 16 files changed, 347 insertions(+)

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
index 000000000000..05ca55fb4645
--- /dev/null
+++ b/arch/riscv/kernel/tests/Kconfig.debug
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "arch/riscv/kernel Testing and Coverage"
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
index 000000000000..cacd50cd1127
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/Makefile
@@ -0,0 +1,15 @@
+obj-m += test_module_linking.o
+
+test_sub := test_sub6.o test_sub8.o test_sub16.o test_sub32.o test_sub64.o
+
+test_set := test_set6.o test_set8.o test_set16.o test_set32.o
+
+test_uleb := test_uleb128.o
+
+test_module_linking-objs += $(test_sub)
+
+test_module_linking-objs += $(test_set)
+
+test_module_linking-objs += $(test_uleb)
+
+test_module_linking-objs += test_module_linking_main.o
diff --git a/arch/riscv/kernel/tests/module_test/test_module_linking_main.c b/arch/riscv/kernel/tests/module_test/test_module_linking_main.c
new file mode 100644
index 000000000000..c142c2657d0c
--- /dev/null
+++ b/arch/riscv/kernel/tests/module_test/test_module_linking_main.c
@@ -0,0 +1,73 @@
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
+extern int test_uleb(void);
+
+#define CHECK_EQ(lhs, rhs) KUNIT_ASSERT_EQ(test, lhs, rhs)
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
+void run_test_uleb(struct kunit *test)
+{
+	int valuleb = test_uleb();
+
+	CHECK_EQ(valuleb, 0);
+}
+
+static struct kunit_case __refdata riscv_module_linking_test_cases[] = {
+	KUNIT_CASE(run_test_set),
+	KUNIT_CASE(run_test_sub),
+	KUNIT_CASE(run_test_uleb),
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
2.34.1

