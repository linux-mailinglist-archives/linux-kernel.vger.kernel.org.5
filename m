Return-Path: <linux-kernel+bounces-137997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E230E89EAF2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AF4D1C20BFA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 06:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B04D2AF12;
	Wed, 10 Apr 2024 06:36:08 +0000 (UTC)
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022C62A8D0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712730967; cv=none; b=Uw/2RgUzkKaN46twoH7CNWLG4kDSGw8dVAYdLPPX4/BcTat9fCdz9Vt9/fEfxJH/37Lgy7LbG2DwqZ0FDyppNkebsSiPp2YHE/2iDgi/8h0XCP/n53NlL2LFMMyFHUbT4yCOkSx7cBAwbkqieKgljHZIII16K4V4ByqkRgNJN/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712730967; c=relaxed/simple;
	bh=5a+hJQQnLHHlog8fcMeQ0f8merXIfj/GMH3ul0Vfc20=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rz8Nw+0pSuq+tVKljvWvnl8A5qcdlvY9eVp9Eiu/RnD7incYYR70MXQ8/LQkL829IiZ16lQFFSpVdEW9sgHhb02UJDOahagQACPl2sGPCZcX5xb31m23aCcWA3RP5eBpned3vqyNDZIGLkEzBCI4cXMhsuvoAuCWP3Z93rWbdec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn; spf=pass smtp.mailfrom=shingroup.cn; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shingroup.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shingroup.cn
X-QQ-mid: bizesmtp86t1712730886thpdkm0m
X-QQ-Originating-IP: qpU6BkNfrlioxOZjNw8VTqRLhm3mvtT81kiLaWcj8Pg=
Received: from HX01040082.powercore.com.cn ( [14.19.197.107])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 10 Apr 2024 14:34:40 +0800 (CST)
X-QQ-SSF: 01400000000000B09000000A0000000
X-QQ-FEAT: D5krnlQGVfJp7iXspNT0lTkPO8Udu5eTrn+UALAwa/e8Lqb/4MhOd1lEyMSHy
	N2wPq8W5p30FX8llAgW8imG47we+3g3Fo1yo5HgyW8M96H3F3ssWJkxTcy0OXRdB/vr9gmr
	mS0DLqFxtycu0CCFDmzd5ebDVl8a7Q/j4+H7qkanPQtPljkyYqK7Rfoe0tc0PQ4i3poBSLX
	d6ZPK9kUkqa4lwD0ThclcQOYw3TLid8PukXqye3Q9I2G4NPG6w3PCTcmc/QDw5Nx4hWAZPz
	gwxcP4Ww3uFikpG15UjY+P1A/xSBCNBueYSVr3c05t7kWDIYAu/nbf/M7azDrA6nDB0Y3Xx
	0vSeCMGyTj0JTmqcRfzfp4NgTMcr2A/b/wNEmF8kB3hf8jcbfOdK5dz0eZcQ6Uy6dm7eTj4
	pdGl7diJ0kTw42z4sOHctFwwmw/MCakR
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17986055640822494182
From: Jinglin Wen <jinglin.wen@shingroup.cn>
To: palmer@dabbelt.com
Cc: paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	gregkh@linuxfoundation.org,
	atishp@rivosinc.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Jinglin Wen <jinglin.wen@shingroup.cn>
Subject: [PATCH 1/3] riscv: Support for early console.
Date: Wed, 10 Apr 2024 14:34:30 +0800
Message-Id: <20240410063432.23058-2-jinglin.wen@shingroup.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
References: <20240410063432.23058-1-jinglin.wen@shingroup.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:shingroup.cn:qybglogicsvrgz:qybglogicsvrgz5a-2

This feature is mainly used for debugging during the early startup
process. Currently, the implementation of this function is based
on the sbi interface.

By setting the CONFIG_RISCV_EARLY_CONSOLE option, this
function can be enabled, which subsequently sets the log level
to CONSOLE_LOGLEVEL_MOTORMOUT.

Signed-off-by: Jinglin Wen <jinglin.wen@shingroup.cn>
---
 arch/riscv/include/asm/early_console.h |  23 ++++++
 arch/riscv/kernel/Makefile             |   1 +
 arch/riscv/kernel/early_console.c      | 108 +++++++++++++++++++++++++
 arch/riscv/kernel/setup.c              |   2 +
 4 files changed, 134 insertions(+)
 create mode 100644 arch/riscv/include/asm/early_console.h
 create mode 100644 arch/riscv/kernel/early_console.c

diff --git a/arch/riscv/include/asm/early_console.h b/arch/riscv/include/asm/early_console.h
new file mode 100644
index 000000000000..0683a42e9207
--- /dev/null
+++ b/arch/riscv/include/asm/early_console.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _ASM_EARLY_CONSOLE_H
+#define _ASM_EARLY_CONSOLE_H
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/init.h>
+
+void __init early_console_init(void);
+
+/* early_console libs */
+void early_console_puts(const char *s);
+int early_console_write(const char *s, int n);
+void early_console_printf(const char *fmt, ...);
+void early_console_progress(char *s, unsigned short hex);
+
+#ifdef CONFIG_RISCV_EARLY_CONSOLE_SBI
+void __init hvc_sbi_early_init(void (**putc)(char c));
+#endif /* CONFIG_HVC_RISCV_SBI */
+
+#endif /* __KERNEL__ */
+#endif /* _ASM_EARLY_CONSOLE_H */
diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 81d94a8ee10f..ef037e3762f1 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -48,6 +48,7 @@ obj-y	+= ptrace.o
 obj-y	+= reset.o
 obj-y	+= return_address.o
 obj-y	+= setup.o
+obj-y	+= early_console.o
 obj-y	+= signal.o
 obj-y	+= syscall_table.o
 obj-y	+= sys_riscv.o
diff --git a/arch/riscv/kernel/early_console.c b/arch/riscv/kernel/early_console.c
new file mode 100644
index 000000000000..64f3a5705413
--- /dev/null
+++ b/arch/riscv/kernel/early_console.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Early console support for RISCV
+ */
+
+#include <linux/stdarg.h>
+#include <linux/types.h>
+#include <linux/console.h>
+#include <asm/sbi.h>
+#include <asm/early_console.h>
+
+/* interface for early console output characters */
+void (*riscv_early_console_putc)(char c);
+
+void early_console_puts(const char *s)
+{
+	if (riscv_early_console_putc) {
+		char c;
+
+		if (s && *s != '\0') {
+			while ((c = *s++) != '\0')
+				riscv_early_console_putc(c);
+		}
+	}
+}
+
+int early_console_write(const char *s, int n)
+{
+	int remain = n;
+	char c;
+
+	if (!riscv_early_console_putc)
+		return 0;
+
+	if (s && *s != '\0') {
+		while (((c = *s++) != '\0') && (remain-- > 0))
+			riscv_early_console_putc(c);
+	}
+
+	return n - remain;
+}
+
+#define EARLY_CONSOLE_BUFSIZE 256
+void early_console_printf(const char *fmt, ...)
+{
+	if (riscv_early_console_putc) {
+		char buf[EARLY_CONSOLE_BUFSIZE];
+		va_list args;
+
+		va_start(args, fmt);
+		vsnprintf(buf, EARLY_CONSOLE_BUFSIZE, fmt, args);
+		early_console_puts(buf);
+		va_end(args);
+	}
+}
+
+void __init early_console_progress(char *s, unsigned short hex)
+{
+	early_console_puts(s);
+	early_console_puts("\n");
+}
+
+/*
+ * Console based on early console
+ */
+static void riscv_early_console_write(struct console *con, const char *s,
+		unsigned int n)
+{
+	early_console_write(s, n);
+}
+
+static struct console riscv_early_console = {
+	.name	= "riscv_early_con",
+	.write	= riscv_early_console_write,
+	.flags	= CON_PRINTBUFFER | CON_ENABLED | CON_BOOT | CON_ANYTIME,
+	.index	= 0,
+};
+
+static void __init register_early_console(void)
+{
+	if (!riscv_early_console_putc)
+		return;
+
+	add_preferred_console("riscv_early_con", 0, NULL);
+	register_console(&riscv_early_console);
+}
+
+/*
+ * This is called after sbi_init.
+ */
+void __init early_console_init(void)
+{
+	/*
+	 * Set riscv_early_console_putc.
+	 * If there are other output interfaces, you can add corresponding code
+	 * to initialize riscv_early_console_putc.
+	 */
+#if defined(CONFIG_RISCV_EARLY_CONSOLE_SBI)
+	/* using the sbi */
+	hvc_sbi_early_init(&riscv_early_console_putc);
+#else
+	/* using other */
+#endif
+
+	console_loglevel = CONSOLE_LOGLEVEL_MOTORMOUTH;
+	register_early_console();
+}
+
diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index 4f73c0ae44b2..1b48630f0861 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -36,6 +36,7 @@
 #include <asm/thread_info.h>
 #include <asm/kasan.h>
 #include <asm/efi.h>
+#include <asm/early_console.h>
 
 #include "head.h"
 
@@ -255,6 +256,7 @@ void __init setup_arch(char **cmdline_p)
 
 	early_ioremap_setup();
 	sbi_init();
+	early_console_init();
 	jump_label_init();
 	parse_early_param();
 
-- 
2.25.1


