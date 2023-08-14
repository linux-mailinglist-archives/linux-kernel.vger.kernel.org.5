Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786B977C1F6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjHNU7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232470AbjHNU6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:58:42 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90824C3;
        Mon, 14 Aug 2023 13:58:41 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fe32016bc8so43013665e9.1;
        Mon, 14 Aug 2023 13:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692046720; x=1692651520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p5RXxuNVpMkYfEUcjxq2KAVbIn0FhUfPyxgk0Iy6mPM=;
        b=P99gCw2W5DoJ/x8PRSHhXyxN1LNZEhdERUpXYSzY26P6tsEaTcQIQ7h1hXvSTBeL/1
         186zKih2x0POXyXNPuaIgCleVMDGUaCX2rEBG0VnJY2V665vHJkNffQBmhZTrsmh9nkD
         4AMVnX9KARBhx7WkXP3Qotr/0aSR8PWf2X7r7Gds28kP65hCrPRxSYIReMYH/WD5qM8q
         r1lkBEbpnQEx/8clBY57e8yQxEkx63gKfjImR6JRJkABDhy/nldNFRxiHuvUUL37mSAa
         SwO7DqWQ8AvslYZLKbMcmVSUW9w8zOX5OkfmFll1D3nKCsMX9dBIlFv+0zXoMue1GNcb
         2KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692046720; x=1692651520;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p5RXxuNVpMkYfEUcjxq2KAVbIn0FhUfPyxgk0Iy6mPM=;
        b=bRjvEvW+QtwzjqmCDu6wagJfoAGCdsDZ+EAu6FEDXsju0S6sb83YN5cqNqZbvXy/Mf
         BIsTCSp3qutxr/27Pcs9gYm1TnBygNkO50dikMhtfCidgkBNGOJti0kTN1Fiq9yTYvQb
         KRLoR13HEdIDauxHNcrTmbwCVQqBsR/Q3j/sBsAUu+2uylIIPGQ4iSb6VuavJS1vK4QL
         RdoNVg0cF35/bZtzbtSQUi9HEGZqHVSROgC5TtmYVcHnUqTLtq+4me5g8JImogWfsx5k
         Fy9TnyNKtoynyu/qjvnZwo0IigUZ1Epty9v04FNJ/gxsAsGldj74HZoBAfNKM4wv9doD
         c1VQ==
X-Gm-Message-State: AOJu0YwVTixLyCz3kaNwsVxI4ROFRk0ZTH5EI5YGweRsPpQ4TyNlzs3k
        4rhSc1BPRIQE0/50hViVa44=
X-Google-Smtp-Source: AGHT+IEtWpvukTZa7JbXKaVOmFRx5lmOrNNBYXtdWytmIQobbksX7oaJAH9Ws3IcsUujkvnhgGsa5g==
X-Received: by 2002:a5d:4ec1:0:b0:317:5e0a:545e with SMTP id s1-20020a5d4ec1000000b003175e0a545emr7080754wrv.58.1692046720023;
        Mon, 14 Aug 2023 13:58:40 -0700 (PDT)
Received: from prasmi.home ([2a00:23c8:2501:c701:20e9:baea:a4f7:d880])
        by smtp.gmail.com with ESMTPSA id h5-20020adffa85000000b003197efd1e7bsm2161806wrr.114.2023.08.14.13.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 13:58:39 -0700 (PDT)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Conor Dooley <conor.dooley@microchip.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Guo Ren <guoren@kernel.org>,
        Andrew Jones <ajones@ventanamicro.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Samuel Holland <samuel@sholland.org>,
        linux-riscv@lists.infradead.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v11 2/6] riscv: errata: Add Andes alternative ports
Date:   Mon, 14 Aug 2023 21:57:15 +0100
Message-Id: <20230814205719.79647-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20230814205719.79647-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add required ports of the Alternative scheme for Andes CPU cores.

I/O Coherence Port (IOCP) provides an AXI interface for connecting external
non-caching masters, such as DMA controllers. IOCP is a specification
option and is disabled on the Renesas RZ/Five SoC due to this reason cache
management needs a software workaround.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Conor Dooley <conor.dooley@microchip.com> # tyre-kicking on a d1
---
v10 -> v11
* No change

v9 -> v10
* Included TB tag from Conor

v8 -> v9
* Rebased to code on Palmer's for/next
* Dropped calling patch_text_nosync() as dont use
  patch_text_nosync() call

v7 -> v8
* Now patching the code using patch_text_nosync() and riscv_alternative_fix_offsets()

v6 -> v7
* Renamed RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND -> ANDES_SBI_EXT_IOCP_SW_WORKAROUND
* Dropped "depends on !XIP_KERNEL" for ERRATA_ANDES config

v5 -> v6
* Dropped patching alternative and now just probing IOCP

v4 -> v5
* Sorted the Kconfig/Makefile/Switch based on Core name
* Added a comments
* Introduced RZFIVE_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT ID to check if
  CMO needs to be applied. Is there a way we can access the DTB while patching
  as we can drop this SBI EXT ID and add a DT property instead for cmo?

RFC v3 -> v4
* New patch
---
 arch/riscv/Kconfig.errata            | 21 +++++++++
 arch/riscv/errata/Makefile           |  1 +
 arch/riscv/errata/andes/Makefile     |  1 +
 arch/riscv/errata/andes/errata.c     | 66 ++++++++++++++++++++++++++++
 arch/riscv/include/asm/alternative.h |  3 ++
 arch/riscv/include/asm/errata_list.h |  5 +++
 arch/riscv/kernel/alternative.c      |  5 +++
 7 files changed, 102 insertions(+)
 create mode 100644 arch/riscv/errata/andes/Makefile
 create mode 100644 arch/riscv/errata/andes/errata.c

diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 0c8f4652cd82..92c779764b27 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -1,5 +1,26 @@
 menu "CPU errata selection"
 
+config ERRATA_ANDES
+	bool "Andes AX45MP errata"
+	depends on RISCV_ALTERNATIVE
+	help
+	  All Andes errata Kconfig depend on this Kconfig. Disabling
+	  this Kconfig will disable all Andes errata. Please say "Y"
+	  here if your platform uses Andes CPU cores.
+
+	  Otherwise, please say "N" here to avoid unnecessary overhead.
+
+config ERRATA_ANDES_CMO
+	bool "Apply Andes cache management errata"
+	depends on ERRATA_ANDES && MMU && ARCH_R9A07G043
+	select RISCV_DMA_NONCOHERENT
+	default y
+	help
+	  This will apply the cache management errata to handle the
+	  non-standard handling on non-coherent operations on Andes cores.
+
+	  If you don't know what to do here, say "Y".
+
 config ERRATA_SIFIVE
 	bool "SiFive errata"
 	depends on RISCV_ALTERNATIVE
diff --git a/arch/riscv/errata/Makefile b/arch/riscv/errata/Makefile
index 7b2637c8c332..8a2739485123 100644
--- a/arch/riscv/errata/Makefile
+++ b/arch/riscv/errata/Makefile
@@ -2,5 +2,6 @@ ifdef CONFIG_RELOCATABLE
 KBUILD_CFLAGS += -fno-pie
 endif
 
+obj-$(CONFIG_ERRATA_ANDES) += andes/
 obj-$(CONFIG_ERRATA_SIFIVE) += sifive/
 obj-$(CONFIG_ERRATA_THEAD) += thead/
diff --git a/arch/riscv/errata/andes/Makefile b/arch/riscv/errata/andes/Makefile
new file mode 100644
index 000000000000..2d644e19caef
--- /dev/null
+++ b/arch/riscv/errata/andes/Makefile
@@ -0,0 +1 @@
+obj-y += errata.o
diff --git a/arch/riscv/errata/andes/errata.c b/arch/riscv/errata/andes/errata.c
new file mode 100644
index 000000000000..197db68cc8da
--- /dev/null
+++ b/arch/riscv/errata/andes/errata.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Erratas to be applied for Andes CPU cores
+ *
+ *  Copyright (C) 2023 Renesas Electronics Corporation.
+ *
+ * Author: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
+ */
+
+#include <linux/memory.h>
+#include <linux/module.h>
+
+#include <asm/alternative.h>
+#include <asm/cacheflush.h>
+#include <asm/errata_list.h>
+#include <asm/patch.h>
+#include <asm/processor.h>
+#include <asm/sbi.h>
+#include <asm/vendorid_list.h>
+
+#define ANDESTECH_AX45MP_MARCHID	0x8000000000008a45UL
+#define ANDESTECH_AX45MP_MIMPID		0x500UL
+#define ANDESTECH_SBI_EXT_ANDES		0x0900031E
+
+#define ANDES_SBI_EXT_IOCP_SW_WORKAROUND	1
+
+static long ax45mp_iocp_sw_workaround(void)
+{
+	struct sbiret ret;
+
+	/*
+	 * ANDES_SBI_EXT_IOCP_SW_WORKAROUND SBI EXT checks if the IOCP is missing and
+	 * cache is controllable only then CMO will be applied to the platform.
+	 */
+	ret = sbi_ecall(ANDESTECH_SBI_EXT_ANDES, ANDES_SBI_EXT_IOCP_SW_WORKAROUND,
+			0, 0, 0, 0, 0, 0);
+
+	return ret.error ? 0 : ret.value;
+}
+
+static bool errata_probe_iocp(unsigned int stage, unsigned long arch_id, unsigned long impid)
+{
+	if (!IS_ENABLED(CONFIG_ERRATA_ANDES_CMO))
+		return false;
+
+	if (arch_id != ANDESTECH_AX45MP_MARCHID || impid != ANDESTECH_AX45MP_MIMPID)
+		return false;
+
+	if (!ax45mp_iocp_sw_workaround())
+		return false;
+
+	/* Set this just to make core cbo code happy */
+	riscv_cbom_block_size = 1;
+	riscv_noncoherent_supported();
+
+	return true;
+}
+
+void __init_or_module andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+					      unsigned long archid, unsigned long impid,
+					      unsigned int stage)
+{
+	errata_probe_iocp(stage, archid, impid);
+
+	/* we have nothing to patch here ATM so just return back */
+}
diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
index 6a41537826a7..f6cfca939c92 100644
--- a/arch/riscv/include/asm/alternative.h
+++ b/arch/riscv/include/asm/alternative.h
@@ -46,6 +46,9 @@ struct alt_entry {
 	u32 patch_id;		/* The patch ID (erratum ID or cpufeature ID) */
 };
 
+void andes_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
+			     unsigned long archid, unsigned long impid,
+			     unsigned int stage);
 void sifive_errata_patch_func(struct alt_entry *begin, struct alt_entry *end,
 			      unsigned long archid, unsigned long impid,
 			      unsigned int stage);
diff --git a/arch/riscv/include/asm/errata_list.h b/arch/riscv/include/asm/errata_list.h
index fb1a810f3d8c..e2ecd01bfac7 100644
--- a/arch/riscv/include/asm/errata_list.h
+++ b/arch/riscv/include/asm/errata_list.h
@@ -11,6 +11,11 @@
 #include <asm/hwcap.h>
 #include <asm/vendorid_list.h>
 
+#ifdef CONFIG_ERRATA_ANDES
+#define ERRATA_ANDESTECH_NO_IOCP	0
+#define ERRATA_ANDESTECH_NUMBER		1
+#endif
+
 #ifdef CONFIG_ERRATA_SIFIVE
 #define	ERRATA_SIFIVE_CIP_453 0
 #define	ERRATA_SIFIVE_CIP_1200 1
diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index 6b75788c18e6..b0345992a35e 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -45,6 +45,11 @@ static void riscv_fill_cpu_mfr_info(struct cpu_manufacturer_info_t *cpu_mfr_info
 
 	cpu_mfr_info->feature_probe_func = NULL;
 	switch (cpu_mfr_info->vendor_id) {
+#ifdef CONFIG_ERRATA_ANDES
+	case ANDESTECH_VENDOR_ID:
+		cpu_mfr_info->patch_func = andes_errata_patch_func;
+		break;
+#endif
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
 		cpu_mfr_info->patch_func = sifive_errata_patch_func;
-- 
2.34.1

