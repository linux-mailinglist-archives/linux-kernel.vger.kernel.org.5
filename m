Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F8A78E00E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239583AbjH3TXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244628AbjH3Nfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:35:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB4611F;
        Wed, 30 Aug 2023 06:35:31 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68c3b9f85b7so2879473b3a.2;
        Wed, 30 Aug 2023 06:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693402530; x=1694007330; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RRQJInei7cgxScofMgcEQpUP1yaB1y4pGk98kCbHGEg=;
        b=Qf2TXvfZ/2UTrs/1ZP71pfvOlF00tGVZKUXd+FNl8eTJFO/huiNLhtwlsGfpnKc/yx
         dQ3vQH1K3Clv/4dmeHwH/5mRoDc9to/b9SRxnGIUZN5bvBE4LLZlWjOT19W8hMXBruuo
         jkEj8EuyTV+fUiPWkuW3PVHuqeiPfjfeT+7a8R7P4lF+nE9s7omoW4NzWGd1GZ8zI2/m
         up8Wek8laie3ddnvFndfesbveVVC+3DZkPFSJFq+3pQycoZLFdhX/65hRU9/6Drk3SRT
         eOCdb2vzQJ24Oa7NcYTA5dAZ8F/rTGBdL149lPjh35K3TnxqiRE/7f6OlOw1L6IJiXwn
         5jZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693402530; x=1694007330;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RRQJInei7cgxScofMgcEQpUP1yaB1y4pGk98kCbHGEg=;
        b=WqLq8nysyRqo5mQVzsDJh72MJu0jlLVrUxOTGrRHCrz5wrd7n3n+jawDcT4OMglDSc
         MYtIiG2EgtMCai/OKRVXrDFUPJxiu71nP6kCqxxnUczFW1DRdkACLJl1JYV5oMyziB8/
         2KUK22hP6Bn6BMcF83H8tY0vnH2cwQk1/il6537w1vO7NGz2fS1gTuqhAbfrTx36WuaI
         U/lF6+a0+8C0CyCxMNEIrya2FZtm70TKkSJI2EzI+7VM/kQeU5gbNzl7dyIq85bxRU0u
         682upF7lNDvjqmyG2MWPR+AfLxxS3ACOMcW49ZYogEpwUaMslaA2nO5FDv4dddFdbA+8
         s69Q==
X-Gm-Message-State: AOJu0Ywme44v6yk98nA+xu4yaJ6ifk2NHbLscV/NTNPw1jWtBQvP6Tn7
        7nEQ0jDMPK42Kc+zWsZMB+35DSWJi3M=
X-Google-Smtp-Source: AGHT+IFEEjj9Q//OZZUkaG1jeG65XoVhhmKQF4+mavHG7UF9ZMUEwyUOWQzMviw9xRgfWvEsVMpHnQ==
X-Received: by 2002:a05:6a00:1355:b0:68c:641a:8a32 with SMTP id k21-20020a056a00135500b0068c641a8a32mr2762731pfu.13.1693402530151;
        Wed, 30 Aug 2023 06:35:30 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.lan ([103.184.129.7])
        by smtp.gmail.com with ESMTPSA id h1-20020a056a00230100b0064f7c56d8b7sm6109298pfh.219.2023.08.30.06.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:35:29 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3] MIPS: loongson32: Remove dma.h and nand.h
Date:   Wed, 30 Aug 2023 21:35:05 +0800
Message-Id: <20230830133505.505597-1-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 7b3415f581c7 ("MIPS: Loongson32: Remove
unused platform devices"), struct plat_ls1x_dma and plat_ls1x_nand
are unused. Then, dma.h and nand.h are useless.
Therefore, remove these useless header files.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
V2 -> V3: Fix the build error
          Add Reviewed-by tag from Philippe Mathieu-Daudé
V1 -> V2: Remove include of dma.h and nand.h
          Update the commit message
---
 arch/mips/include/asm/mach-loongson32/dma.h   | 21 ---------------
 arch/mips/include/asm/mach-loongson32/nand.h  | 26 -------------------
 .../include/asm/mach-loongson32/platform.h    |  3 ---
 arch/mips/loongson32/common/platform.c        |  2 --
 arch/mips/loongson32/ls1b/board.c             |  2 --
 5 files changed, 54 deletions(-)
 delete mode 100644 arch/mips/include/asm/mach-loongson32/dma.h
 delete mode 100644 arch/mips/include/asm/mach-loongson32/nand.h

diff --git a/arch/mips/include/asm/mach-loongson32/dma.h b/arch/mips/include/asm/mach-loongson32/dma.h
deleted file mode 100644
index e917b3ccb2c2..000000000000
--- a/arch/mips/include/asm/mach-loongson32/dma.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_DMA_H
-#define __ASM_MACH_LOONGSON32_DMA_H
-
-#define LS1X_DMA_CHANNEL0	0
-#define LS1X_DMA_CHANNEL1	1
-#define LS1X_DMA_CHANNEL2	2
-
-struct plat_ls1x_dma {
-	int nr_channels;
-};
-
-extern struct plat_ls1x_dma ls1b_dma_pdata;
-
-#endif /* __ASM_MACH_LOONGSON32_DMA_H */
diff --git a/arch/mips/include/asm/mach-loongson32/nand.h b/arch/mips/include/asm/mach-loongson32/nand.h
deleted file mode 100644
index aaf5ed19d78d..000000000000
--- a/arch/mips/include/asm/mach-loongson32/nand.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * Copyright (c) 2015 Zhang, Keguang <keguang.zhang@gmail.com>
- *
- * Loongson 1 NAND platform support.
- */
-
-#ifndef __ASM_MACH_LOONGSON32_NAND_H
-#define __ASM_MACH_LOONGSON32_NAND_H
-
-#include <linux/dmaengine.h>
-#include <linux/mtd/partitions.h>
-
-struct plat_ls1x_nand {
-	struct mtd_partition *parts;
-	unsigned int nr_parts;
-
-	int hold_cycle;
-	int wait_cycle;
-};
-
-extern struct plat_ls1x_nand ls1b_nand_pdata;
-
-bool ls1x_dma_filter_fn(struct dma_chan *chan, void *param);
-
-#endif /* __ASM_MACH_LOONGSON32_NAND_H */
diff --git a/arch/mips/include/asm/mach-loongson32/platform.h b/arch/mips/include/asm/mach-loongson32/platform.h
index 2cdcfb5f6012..f74292b13bc3 100644
--- a/arch/mips/include/asm/mach-loongson32/platform.h
+++ b/arch/mips/include/asm/mach-loongson32/platform.h
@@ -8,9 +8,6 @@
 
 #include <linux/platform_device.h>
 
-#include <dma.h>
-#include <nand.h>
-
 extern struct platform_device ls1x_uart_pdev;
 extern struct platform_device ls1x_eth0_pdev;
 extern struct platform_device ls1x_eth1_pdev;
diff --git a/arch/mips/loongson32/common/platform.c b/arch/mips/loongson32/common/platform.c
index 8075590a9f83..623eb4bc7b41 100644
--- a/arch/mips/loongson32/common/platform.c
+++ b/arch/mips/loongson32/common/platform.c
@@ -15,8 +15,6 @@
 
 #include <platform.h>
 #include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
 
 /* 8250/16550 compatible UART */
 #define LS1X_UART(_id)						\
diff --git a/arch/mips/loongson32/ls1b/board.c b/arch/mips/loongson32/ls1b/board.c
index fed8d432ef20..fe115bdcb22c 100644
--- a/arch/mips/loongson32/ls1b/board.c
+++ b/arch/mips/loongson32/ls1b/board.c
@@ -8,8 +8,6 @@
 #include <linux/sizes.h>
 
 #include <loongson1.h>
-#include <dma.h>
-#include <nand.h>
 #include <platform.h>
 
 static const struct gpio_led ls1x_gpio_leds[] __initconst = {

base-commit: e7513eccb7d7f82e28f4730210b42da71edaa6a6
-- 
2.39.2

