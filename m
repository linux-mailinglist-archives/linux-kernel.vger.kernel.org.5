Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFF176FCB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbjHDI6c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:58:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjHDI6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:58:00 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E9A8C49DA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:53:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E90921007;
        Fri,  4 Aug 2023 01:53:24 -0700 (PDT)
Received: from e127643.arm.com (unknown [10.57.3.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3C4D23F6C4;
        Fri,  4 Aug 2023 01:52:39 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        James Morse <james.morse@arm.com>,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Joey Gouly <joey.gouly@arm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64/sysreg: Move TRFCR definitions to sysreg
Date:   Fri,  4 Aug 2023 09:52:16 +0100
Message-Id: <20230804085219.260790-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804085219.260790-1-james.clark@arm.com>
References: <20230804085219.260790-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TRFCR_EL2_CX needs to become TRFCR_ELx_CX to avoid unnecessary
duplication and make the SysregFields block re-usable.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/sysreg.h               | 12 ----------
 arch/arm64/tools/sysreg                       | 22 +++++++++++++++++++
 .../coresight/coresight-etm4x-core.c          |  2 +-
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index b481935e9314..fc9a5a09fa04 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -171,8 +171,6 @@
 #define SYS_RGSR_EL1			sys_reg(3, 0, 1, 0, 5)
 #define SYS_GCR_EL1			sys_reg(3, 0, 1, 0, 6)
 
-#define SYS_TRFCR_EL1			sys_reg(3, 0, 1, 2, 1)
-
 #define SYS_TCR_EL1			sys_reg(3, 0, 2, 0, 2)
 
 #define SYS_APIAKEYLO_EL1		sys_reg(3, 0, 2, 1, 0)
@@ -382,7 +380,6 @@
 #define SYS_VTTBR_EL2			sys_reg(3, 4, 2, 1, 0)
 #define SYS_VTCR_EL2			sys_reg(3, 4, 2, 1, 2)
 
-#define SYS_TRFCR_EL2			sys_reg(3, 4, 1, 2, 1)
 #define SYS_HDFGRTR_EL2			sys_reg(3, 4, 3, 1, 4)
 #define SYS_HDFGWTR_EL2			sys_reg(3, 4, 3, 1, 5)
 #define SYS_HAFGRTR_EL2			sys_reg(3, 4, 3, 1, 6)
@@ -640,15 +637,6 @@
 /* Safe value for MPIDR_EL1: Bit31:RES1, Bit30:U:0, Bit24:MT:0 */
 #define SYS_MPIDR_SAFE_VAL	(BIT(31))
 
-#define TRFCR_ELx_TS_SHIFT		5
-#define TRFCR_ELx_TS_MASK		((0x3UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_VIRTUAL		((0x1UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_GUEST_PHYSICAL	((0x2UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_ELx_TS_PHYSICAL		((0x3UL) << TRFCR_ELx_TS_SHIFT)
-#define TRFCR_EL2_CX			BIT(3)
-#define TRFCR_ELx_ExTRE			BIT(1)
-#define TRFCR_ELx_E0TRE			BIT(0)
-
 /* GIC Hypervisor interface registers */
 /* ICH_MISR_EL2 bit definitions */
 #define ICH_MISR_EOI		(1 << 0)
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 65866bf819c3..fe1f824977d9 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -2495,3 +2495,25 @@ Field	5	F
 Field	4	P
 Field	3:0	Align
 EndSysreg
+
+SysregFields TRFCR_ELx
+Res0	63:7
+UnsignedEnum	6:5	TS
+	0b0001	VIRTUAL
+	0b0010	GUEST_PHYSICAL
+	0b0011	PHYSICAL
+EndEnum
+Res0	4
+Field	3	CX
+Res0	2
+Field	1	ExTRE
+Field	0	E0TRE
+EndSysregFields
+
+Sysreg	TRFCR_EL1	3	0	1	2	1
+Fields	TRFCR_ELx
+EndSysreg
+
+Sysreg	TRFCR_EL2	3	4	1	2	1
+Fields	TRFCR_ELx
+EndSysreg
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 703b6fcbb6a5..257e5c1a4b52 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -1145,7 +1145,7 @@ static void cpu_detect_trace_filtering(struct etmv4_drvdata *drvdata)
 
 	/* If we are running at EL2, allow tracing the CONTEXTIDR_EL2. */
 	if (is_kernel_in_hyp_mode())
-		trfcr |= TRFCR_EL2_CX;
+		trfcr |= TRFCR_ELx_CX;
 
 	drvdata->trfcr = trfcr;
 }
-- 
2.34.1

