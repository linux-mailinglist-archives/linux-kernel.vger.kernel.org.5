Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41770767F84
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbjG2Nn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjG2Nn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:43:57 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB11BEB;
        Sat, 29 Jul 2023 06:43:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-686f090310dso2968734b3a.0;
        Sat, 29 Jul 2023 06:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638230; x=1691243030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1DfhMFTMRww/HLVW5QnIluxyDYLwP5rV6zVBM2gGyI=;
        b=c2vMhhKZqFucbb5J14jS+EduFcSqW2S6ywpBcjOmfI0sVRy14wtS5AZQPMJAwR0jNI
         56ouvtKvlaXJ/06BFp6iMaE0XEtvIegnD7Vx+iITRGXMXZWgVvJn07e8gL1W0azxPYSH
         DWijcVvepls2YI7bW6SZFuL+AG4MUXQZzcsc83G8pVYk0mA8y5Qq++CqIPVboOx+Ma/v
         tReerG/6HTUR+oXSi3+/IEMl3pAXB9W9cRDNxDJbNbpaX6a2OLcrOtaKYR2/cTFVzU1m
         xHULjFhzPFcuGbzHj4ZqEKYKqlzUBx0bOdrslaEyMjCbh7S1uGPQo/pjvo12BUHWMVg7
         YIZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638230; x=1691243030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1DfhMFTMRww/HLVW5QnIluxyDYLwP5rV6zVBM2gGyI=;
        b=HGP4oOuuOqZ5mRm9Zm2cj7IdijsHuZBFE1LEo5s8anoRgMOb/odpetwQytOOZTB31o
         5iEqqdg75r1jhTcF+Qbc4RtHfOJQRayom3NP07mPhmbYwPx2licsBqIke2qkkhNhv/20
         kaZ1absz//6Mx24onZSL187RMfpSHly6c/YLNhH4mdPPiUjhiBHP/SE/Z+SGlrTyEAai
         O0/oTeVM6fkAe1UZb++lSgNxdZ34N9zz2yLE8QzyfFNggMgMOb8H+Qhtla0oQvFmZy3T
         U2W8VIu9rSH74u0Tfy82ZNc7CN1UEM+MkgZjIyTJ1lsY1/bt+m8ndp+Rhkx/MI3ksBi3
         wOfQ==
X-Gm-Message-State: ABy/qLbjDSdYbFMV+YpuGjGVyha30bw/vK64uV9jqGTvnag/jC76V0Ur
        Q0MpvFYF3+Gz7Rg0ru4h6jj3MKessftyrw==
X-Google-Smtp-Source: APBJJlEvPKp8+SzFeCQbsyNMGbqh0pc6iaKW8zqZxhtgFUBUKaiZp247xRJzxICIwTbGVu5xrulOmA==
X-Received: by 2002:a05:6a20:be13:b0:134:2b46:797f with SMTP id ge19-20020a056a20be1300b001342b46797fmr4927586pzb.18.1690638229960;
        Sat, 29 Jul 2023 06:43:49 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:43:49 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 04/17] MIPS: loongson32: Modify Loongson-1B/1C related Kconfig options
Date:   Sat, 29 Jul 2023 21:43:05 +0800
Message-Id: <20230729134318.1694467-5-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU_LOONGSON1B and CPU_LOONGSON1C have the same GS232 core,
so merge them into CPU_LOONGSON32.

The Kconfig options selected by LOONGSON1_LS1B and LOONGSON1_LS1C
is selected by MACH_LOONGSON32 now.
And LOONGSON1_LS1B and LOONGSON1_LS1C will be deleted
after all platform devices are converted to devicetree nodes.

Introduce MACH_LSGZ_1B_DEV and MACH_SMARTLOONG_1C
for the built-in DTS selection.

Partialy based on the patch by Jiaxun Yang.

Link: https://lore.kernel.org/all/20190411121915.8040-4-jiaxun.yang@flygoat.com/
Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/Kconfig                    | 62 ++++++++++++++--------------
 arch/mips/boot/dts/loongson/Makefile |  4 +-
 arch/mips/include/asm/cpu-type.h     |  3 +-
 arch/mips/loongson32/Kconfig         | 47 ++++++++-------------
 4 files changed, 50 insertions(+), 66 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fc6fba925aea..754316523b24 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -466,6 +466,21 @@ config LANTIQ
 
 config MACH_LOONGSON32
 	bool "Loongson 32-bit family of machines"
+	select USE_OF
+	select BUILTIN_DTB
+	select BOOT_ELF32
+	select CEVT_R4K
+	select CSRC_R4K
+	select COMMON_CLK
+	select DMA_NONCOHERENT
+	select IRQ_MIPS_CPU
+	select LS1X_IRQ
+	select SYS_HAS_CPU_LOONGSON32
+	select SYS_HAS_EARLY_PRINTK
+	select USE_GENERIC_EARLY_PRINTK_8250
+	select SYS_SUPPORTS_32BIT_KERNEL
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_HIGHMEM
 	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables support for the Loongson-1 family of machines.
@@ -1350,25 +1365,20 @@ config CPU_LOONGSON2F
 	  have a similar programming interface with FPGA northbridge used in
 	  Loongson2E.
 
-config CPU_LOONGSON1B
-	bool "Loongson 1B"
-	depends on SYS_HAS_CPU_LOONGSON1B
-	select CPU_LOONGSON32
-	select LEDS_GPIO_REGISTER
-	help
-	  The Loongson 1B is a 32-bit SoC, which implements the MIPS32
-	  Release 1 instruction set and part of the MIPS32 Release 2
-	  instruction set.
-
-config CPU_LOONGSON1C
-	bool "Loongson 1C"
-	depends on SYS_HAS_CPU_LOONGSON1C
-	select CPU_LOONGSON32
+config CPU_LOONGSON32
+	bool "Loongson 32-bit CPU"
+	depends on SYS_HAS_CPU_LOONGSON32
+	select CPU_MIPS32
+	select CPU_MIPSR2
+	select CPU_HAS_PREFETCH
+	select CPU_HAS_LOAD_STORE_LR
+	select CPU_SUPPORTS_32BIT_KERNEL
+	select CPU_SUPPORTS_HIGHMEM
+	select CPU_SUPPORTS_CPUFREQ
 	select LEDS_GPIO_REGISTER
 	help
-	  The Loongson 1C is a 32-bit SoC, which implements the MIPS32
-	  Release 1 instruction set and part of the MIPS32 Release 2
-	  instruction set.
+	  The Loongson GS232 microarchitecture implements the MIPS32 Release 1
+	  instruction set and part of the MIPS32 Release 2 instruction set.
 
 config CPU_MIPS32_R1
 	bool "MIPS32 Release 1"
@@ -1764,15 +1774,6 @@ config CPU_LOONGSON2EF
 	select CPU_SUPPORTS_HIGHMEM
 	select CPU_SUPPORTS_HUGEPAGES
 
-config CPU_LOONGSON32
-	bool
-	select CPU_MIPS32
-	select CPU_MIPSR2
-	select CPU_HAS_PREFETCH
-	select CPU_SUPPORTS_32BIT_KERNEL
-	select CPU_SUPPORTS_HIGHMEM
-	select CPU_SUPPORTS_CPUFREQ
-
 config CPU_BMIPS32_3300
 	select SMP_UP if SMP
 	bool
@@ -1810,10 +1811,7 @@ config SYS_HAS_CPU_LOONGSON2F
 	select CPU_SUPPORTS_CPUFREQ
 	select CPU_SUPPORTS_ADDRWINCFG if 64BIT
 
-config SYS_HAS_CPU_LOONGSON1B
-	bool
-
-config SYS_HAS_CPU_LOONGSON1C
+config SYS_HAS_CPU_LOONGSON32
 	bool
 
 config SYS_HAS_CPU_MIPS32_R1
@@ -2996,8 +2994,8 @@ endchoice
 choice
 	prompt "Kernel command line type" if !CMDLINE_OVERRIDE
 	default MIPS_CMDLINE_FROM_DTB if USE_OF && !ATH79 && !MACH_INGENIC && \
-					 !MACH_LOONGSON64 && !MIPS_MALTA && \
-					 !CAVIUM_OCTEON_SOC
+					 !MACH_LOONGSON64 && !MACH_LOONGSON32 && \
+					 !MIPS_MALTA && !CAVIUM_OCTEON_SOC
 	default MIPS_CMDLINE_FROM_BOOTLOADER
 
 	config MIPS_CMDLINE_FROM_DTB
diff --git a/arch/mips/boot/dts/loongson/Makefile b/arch/mips/boot/dts/loongson/Makefile
index 9d95f1351d5f..5bdeb59a6323 100644
--- a/arch/mips/boot/dts/loongson/Makefile
+++ b/arch/mips/boot/dts/loongson/Makefile
@@ -6,7 +6,7 @@ dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64c_8core_rs780e.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64g_4core_ls7a.dtb
 dtb-$(CONFIG_MACH_LOONGSON64)	+= loongson64v_4core_virtio.dtb
 
-dtb-$(CONFIG_LOONGSON1B_LSGZ_DEV)	+= lsgz_1b_dev.dtb
-dtb-$(CONFIG_LOONGSON1C_SMARTLOONG)	+= smartloong_1c.dtb
+dtb-$(CONFIG_MACH_LSGZ_1B_DEV)		+= lsgz_1b_dev.dtb
+dtb-$(CONFIG_MACH_SMARTLOONG_1C)	+= smartloong_1c.dtb
 
 obj-$(CONFIG_BUILTIN_DTB)	+= $(addsuffix .o, $(dtb-y))
diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index a4a66bd93748..fd37a44a2f19 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -24,8 +24,7 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_LOONGSON64:
 #endif
 
-#if defined(CONFIG_SYS_HAS_CPU_LOONGSON1B) || \
-    defined(CONFIG_SYS_HAS_CPU_LOONGSON1C)
+#ifdef CONFIG_SYS_HAS_CPU_LOONGSON32
 	case CPU_LOONGSON32:
 #endif
 
diff --git a/arch/mips/loongson32/Kconfig b/arch/mips/loongson32/Kconfig
index a7c500959577..75c1f4061700 100644
--- a/arch/mips/loongson32/Kconfig
+++ b/arch/mips/loongson32/Kconfig
@@ -1,38 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
-if MACH_LOONGSON32
 
 choice
 	prompt "Machine Type"
+	depends on MACH_LOONGSON32
 
-config LOONGSON1_LS1B
-	bool "Loongson LS1B board"
-	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
-	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
-	select SYS_HAS_CPU_LOONGSON1B
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select IRQ_MIPS_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_HAS_EARLY_PRINTK
-	select USE_GENERIC_EARLY_PRINTK_8250
-	select COMMON_CLK
+config MACH_LSGZ_1B_DEV
+	bool "LSGZ 1B DEV board"
+	select LOONGSON1_LS1B
+	help
+	  Enable this to include the FDT for the LSGZ 1B DEV board.
+
+config MACH_SMARTLOONG_1C
+	bool "Smartloong 1C board"
+	select LOONGSON1_LS1C
+	help
+	  Enable this to include the FDT for the Smartloong 1C board.
 
-config LOONGSON1_LS1C
-	bool "Loongson LS1C board"
-	select CEVT_R4K if !MIPS_EXTERNAL_TIMER
-	select CSRC_R4K if !MIPS_EXTERNAL_TIMER
-	select SYS_HAS_CPU_LOONGSON1C
-	select DMA_NONCOHERENT
-	select BOOT_ELF32
-	select IRQ_MIPS_CPU
-	select SYS_SUPPORTS_32BIT_KERNEL
-	select SYS_SUPPORTS_LITTLE_ENDIAN
-	select SYS_SUPPORTS_HIGHMEM
-	select SYS_HAS_EARLY_PRINTK
-	select USE_GENERIC_EARLY_PRINTK_8250
-	select COMMON_CLK
 endchoice
 
-endif # MACH_LOONGSON32
+config LOONGSON1_LS1B
+	bool
+
+config LOONGSON1_LS1C
+	bool
-- 
2.39.2

