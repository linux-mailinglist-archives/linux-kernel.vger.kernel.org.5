Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF7767F87
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjG2NoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbjG2NoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:44:15 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3E8422B;
        Sat, 29 Jul 2023 06:43:54 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6862842a028so2196600b3a.0;
        Sat, 29 Jul 2023 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638233; x=1691243033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=medhLs0XZRiWC8Zht8a1BYUpIvs52iaGa4fXc9vbtfE=;
        b=CpLvcwDihCH4t/XhOuJLcNteaLjfNKha+6LCSO7fiCP0hmI92GS/DRt/SXLY6nAXkM
         CXYbl2MGjYxc+3hub3CSX08Zkw0QsVjJmN1BhPY4m5vGIk4PLAEk5e3wL9lDwSZC0QMS
         WoWsi0ynHsLqiDaO1i+HKmMd8Sib7t3A0/PepYmJudrrtpBLTRKOSH0jawJVqWVuuxvn
         t5IglBAIcMYWgYWF+QNQdhCQG6KzlQJV0nO4noa05Gd776XsYH0K2o+D23dLiHrVytde
         RAqAFsZswf5uQN42w8Apj2h3y2inIiCMrREGpEkLwJ3LgSHT08PqPmV+pdFvb8rRBiaj
         7rqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638233; x=1691243033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=medhLs0XZRiWC8Zht8a1BYUpIvs52iaGa4fXc9vbtfE=;
        b=AgqF1iutJY9QUT2mmsyugPVPqXs3OuNAfszejqDcNrE4WfYiG+34mNFR/9jPbEnwek
         Tg4+1orMP3iglQIRy2OpVzrlsQimPS1BAtO90/0JhCjpXE00QSsVNT9hRv0EtAr1+W7W
         olBlPyGWCdQQMG896dxeF75IQ/8KaGhY5Uyft67AIHhwPllZ5z2flDUijprZpAe+FNlg
         0xnsQdWaLvesNvGrpZ6wMfcUdYsvmbelUhmWkq989jT9kqnKg76Uf/ggDl5hMlK7c26d
         zw6rPMgPkKt1PKoDMq1k/e3hfIrJfaMQ4qB8xODdaf+H+mQTrNA2JdxfH5oHM5Gtbwog
         1Mew==
X-Gm-Message-State: ABy/qLbqwjLBHAassQZ+RXtvmqp65VPTrioeyff31l5Az7kpMf8sdSkc
        5jiWs1MRQEDstPI4nxetUMP45jxOwzDBDQ==
X-Google-Smtp-Source: APBJJlGgtErTHMieaqAxgvIm9CIbhnI92o0gQNkmBB5o5mFn/F0BebT0fuRCu7qWcCJ1HN2znnUifg==
X-Received: by 2002:a05:6a00:2e85:b0:668:8596:752f with SMTP id fd5-20020a056a002e8500b006688596752fmr5755964pfb.4.1690638232928;
        Sat, 29 Jul 2023 06:43:52 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:52 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 05/17] MIPS: loongson32: Adapt the common code to support DT
Date:   Sat, 29 Jul 2023 21:43:06 +0800
Message-Id: <20230729134318.1694467-6-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adapt the initial functions to support devicetree.
And introduce init.c to collect these initial functions.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/loongson32/Makefile        |  2 +-
 arch/mips/loongson32/common/Makefile |  2 +-
 arch/mips/loongson32/common/prom.c   | 42 ---------------
 arch/mips/loongson32/common/time.c   | 23 --------
 arch/mips/loongson32/init.c          | 78 ++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+), 67 deletions(-)
 delete mode 100644 arch/mips/loongson32/common/prom.c
 delete mode 100644 arch/mips/loongson32/common/time.c
 create mode 100644 arch/mips/loongson32/init.c

diff --git a/arch/mips/loongson32/Makefile b/arch/mips/loongson32/Makefile
index c3881af369e9..2d1b985dad71 100644
--- a/arch/mips/loongson32/Makefile
+++ b/arch/mips/loongson32/Makefile
@@ -3,7 +3,7 @@
 # Common code for all Loongson 1 based systems
 #
 
-obj-$(CONFIG_MACH_LOONGSON32) += proc.o
+obj-$(CONFIG_MACH_LOONGSON32) += init.o proc.o
 obj-$(CONFIG_MACH_LOONGSON32) += common/
 
 #
diff --git a/arch/mips/loongson32/common/Makefile b/arch/mips/loongson32/common/Makefile
index b44527b1a178..b5c2f4e0f4cc 100644
--- a/arch/mips/loongson32/common/Makefile
+++ b/arch/mips/loongson32/common/Makefile
@@ -3,4 +3,4 @@
 # Makefile for common code of loongson1 based machines.
 #
 
-obj-y	+= time.o irq.o platform.o prom.o
+obj-y	+= irq.o platform.o
diff --git a/arch/mips/loongson32/common/prom.c b/arch/mips/loongson32/common/prom.c
deleted file mode 100644
index fc580a22748e..000000000000
--- a/arch/mips/loongson32/common/prom.c
+++ /dev/null
@@ -1,42 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2011 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Modified from arch/mips/pnx833x/common/prom.c.
- */
-
-#include <linux/io.h>
-#include <linux/init.h>
-#include <linux/memblock.h>
-#include <linux/serial_reg.h>
-#include <asm/fw/fw.h>
-
-#include <loongson1.h>
-
-unsigned long memsize;
-
-void __init prom_init(void)
-{
-	void __iomem *uart_base;
-
-	fw_init_cmdline();
-
-	memsize = fw_getenvl("memsize");
-	if(!memsize)
-		memsize = DEFAULT_MEMSIZE;
-
-	if (strstr(arcs_cmdline, "console=ttyS3"))
-		uart_base = ioremap(LS1X_UART3_BASE, 0x0f);
-	else if (strstr(arcs_cmdline, "console=ttyS2"))
-		uart_base = ioremap(LS1X_UART2_BASE, 0x0f);
-	else if (strstr(arcs_cmdline, "console=ttyS1"))
-		uart_base = ioremap(LS1X_UART1_BASE, 0x0f);
-	else
-		uart_base = ioremap(LS1X_UART0_BASE, 0x0f);
-	setup_8250_early_printk_port((unsigned long)uart_base, 0, 0);
-}
-
-void __init plat_mem_setup(void)
-{
-	memblock_add(0x0, (memsize << 20));
-}
diff --git a/arch/mips/loongson32/common/time.c b/arch/mips/loongson32/common/time.c
deleted file mode 100644
index 74ad2b17918d..000000000000
--- a/arch/mips/loongson32/common/time.c
+++ /dev/null
@@ -1,23 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Copyright (c) 2014 Zhang, Keguang <keguang.zhang@gmail.com>
- */
-
-#include <linux/clk.h>
-#include <linux/of_clk.h>
-#include <asm/time.h>
-
-void __init plat_time_init(void)
-{
-	struct clk *clk = NULL;
-
-	/* initialize LS1X clocks */
-	of_clk_init(NULL);
-
-	/* setup mips r4k timer */
-	clk = clk_get(NULL, "cpu_clk");
-	if (IS_ERR(clk))
-		panic("unable to get cpu clock, err=%ld", PTR_ERR(clk));
-
-	mips_hpt_frequency = clk_get_rate(clk) / 2;
-}
diff --git a/arch/mips/loongson32/init.c b/arch/mips/loongson32/init.c
new file mode 100644
index 000000000000..1aada785a4a3
--- /dev/null
+++ b/arch/mips/loongson32/init.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2011-2023 Keguang Zhang <keguang.zhang@gmail.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clocksource.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/irqchip.h>
+#include <linux/of.h>
+#include <linux/of_clk.h>
+#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
+#include <asm/prom.h>
+#include <asm/time.h>
+
+#define LS1X_UART0_BASE		0x1fe40000
+#define LS1X_UART1_BASE		0x1fe44000
+#define LS1X_UART2_BASE		0x1fe48000
+#define LS1X_UART3_BASE		0x1fe4c000
+
+void __init prom_init(void)
+{
+	void __iomem *uart_base;
+
+	fw_init_cmdline();
+
+	if (strstr(arcs_cmdline, "console=ttyS3"))
+		uart_base = ioremap(LS1X_UART3_BASE, 0x0f);
+	else if (strstr(arcs_cmdline, "console=ttyS2"))
+		uart_base = ioremap(LS1X_UART2_BASE, 0x0f);
+	else if (strstr(arcs_cmdline, "console=ttyS1"))
+		uart_base = ioremap(LS1X_UART1_BASE, 0x0f);
+	else
+		uart_base = ioremap(LS1X_UART0_BASE, 0x0f);
+	setup_8250_early_printk_port((unsigned long)uart_base, 0, 0);
+}
+
+void __init plat_mem_setup(void)
+{
+	void *dtb;
+
+	dtb = get_fdt();
+	if (!dtb) {
+		pr_err("No DTB found\n");
+		return;
+	}
+
+	__dt_setup_arch(dtb);
+}
+
+void __init plat_time_init(void)
+{
+	struct clk *clk = NULL;
+	struct device_node *np;
+
+	/* Initialize LS1X clocks */
+	of_clk_init(NULL);
+
+	np = of_get_cpu_node(0, NULL);
+	if (!np) {
+		pr_err("Failed to get CPU node\n");
+		return;
+	}
+
+	/* Setup MIPS r4k timer */
+	clk = of_clk_get(np, 0);
+	if (IS_ERR(clk)) {
+		pr_err("Failed to get CPU clock: %ld\n", PTR_ERR(clk));
+		return;
+	}
+
+	mips_hpt_frequency = clk_get_rate(clk) / 2;
+	clk_put(clk);
+
+	timer_probe();
+}
-- 
2.39.2

