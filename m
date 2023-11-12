Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA437E8EB9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:18:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbjKLGS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjKLGSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:18:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2784C1D
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:35 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F47BC433CC;
        Sun, 12 Nov 2023 06:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769855;
        bh=McvUmbn7ofR9ECIK1HzZvYjfVLwR/ntK8/66isIijtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cVixWE5BU3e4YiwTPApmxFvfwcQjyW4BCr6TG50g4zBwUphGarDaFwV04CbuzkNp8
         fcJ0yF57pqfwrYk17nBniNgJxa5HEYSLCYceCYpVlwmBs9t+j9Spx8D1/+UCxRCwZH
         WXJIGTd4x825tMD5ZBzWbl9DBr7XQEX7SIzW63zoNx0sU9rdFqMSxR2HmlOONiJA/E
         bFNhgrFJTCHEhWW1sLsfWksh5LGNylmxHUEhA94B/fhLu6Z516D55+XjtOpZ1t0rru
         EEqGkJ+xcrIaxrsLSz4Q6jxSDw6D/R6mP+p/Ftn3C/cHP9pQd8XP9GFq1R/+IeC50b
         gWTZeAfPCLuhw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 21/38] riscv: s64ilp32: Add MMU_SV32 mode support
Date:   Sun, 12 Nov 2023 01:14:57 -0500
Message-Id: <20231112061514.2306187-22-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This needs to add Sv32 mode in the SATP CSR of RV64 ISA, a novel
extension of 64-bit processors' MMU. It could save a bit of page
table footprint and improve the page table walk performance:

s64ilp32 with Sv39:
PageTables:          136 kB

s64ilp32 with Sv32:
PageTables:           60 kB

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig           | 11 ++++++++++-
 arch/riscv/Kconfig.errata    |  2 +-
 arch/riscv/include/asm/csr.h |  1 +
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5a3eb5e7d67a..1d3a236d2c45 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -481,7 +481,7 @@ config RISCV_ISA_SVNAPOT
 
 config RISCV_ISA_SVPBMT
 	bool "Svpbmt extension support for supervisor mode page-based memory types"
-	depends on 64BIT && MMU
+	depends on !MMU_SV32 && MMU
 	depends on RISCV_ALTERNATIVE
 	default y
 	help
@@ -638,6 +638,15 @@ config THREAD_SIZE_ORDER
 	  Specify the Pages of thread stack size (from 4KB to 64KB), which also
 	  affects irq stack size, which is equal to thread stack size.
 
+config MMU_SV32
+	bool "MMU Sv32"
+	depends on 32BIT && MMU
+	help
+	  ARCH_RV32I only supports MMU Sv32 mode, but ARCH_RV64ILP32 supports
+	  MMU Sv39 & Sv32 (MMU Sv32 is optional for RV64 hardware).
+
+	  If unsure, say N.
+
 endmenu # "Platform type"
 
 menu "Kernel features"
diff --git a/arch/riscv/Kconfig.errata b/arch/riscv/Kconfig.errata
index 0c8f4652cd82..1aa85a427ff3 100644
--- a/arch/riscv/Kconfig.errata
+++ b/arch/riscv/Kconfig.errata
@@ -44,7 +44,7 @@ config ERRATA_THEAD
 
 config ERRATA_THEAD_PBMT
 	bool "Apply T-Head memory type errata"
-	depends on ERRATA_THEAD && 64BIT && MMU
+	depends on ERRATA_THEAD && !MMU_SV32 && MMU
 	select RISCV_ALTERNATIVE_EARLY
 	default y
 	help
diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
index 03acdedc100d..aa78c5f20d75 100644
--- a/arch/riscv/include/asm/csr.h
+++ b/arch/riscv/include/asm/csr.h
@@ -65,6 +65,7 @@
 #define SATP_ASID_MASK	_AC(0x1FF, UXL)
 #else
 #define SATP_PPN	_AC(0x00000FFFFFFFFFFF, UXL)
+#define SATP_MODE_32	_AC(0x1000000000000000, UXL)
 #define SATP_MODE_39	_AC(0x8000000000000000, UXL)
 #define SATP_MODE_48	_AC(0x9000000000000000, UXL)
 #define SATP_MODE_57	_AC(0xa000000000000000, UXL)
-- 
2.36.1

