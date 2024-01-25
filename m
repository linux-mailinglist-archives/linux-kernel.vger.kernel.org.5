Return-Path: <linux-kernel+bounces-38300-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9665D83BD99
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB2A41C2496B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0207F1BF5C;
	Thu, 25 Jan 2024 09:41:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD161BDCF;
	Thu, 25 Jan 2024 09:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175703; cv=none; b=p3DqkZtTnE3OHAlGNjkrcdWHS+cvJU6msJPSYErlSE8bfoJg8/7d317rJdHtu30QYfnKNRGER272EtTVzrwc++tfesLl2TgoaWUXr8E2Ev1J1vJX7Nqchh7QZy7L+wdCvYiQpC+An0WiWr0YPuJezw+013bNT2W1Drcms3ghzJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175703; c=relaxed/simple;
	bh=E/lYNKe8u5S2JH2JzQr7XYnJrREfiX+HQH1toamceio=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Veatm3eNqAszswRFznZsv1KbgKOTmnd9T6wvO5lxWdKa7m5xelrQNFe8lZptmI1uG+P/2IyOBMEOdCg88NygzBNFPXx7W9lRppbMZi7RU4pK5zyJ6I4JMszKkT758Bxom1fJMCZudPbfttTvS6S3ioqrCsjmgOK8WBM2bxk65fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF9A81477;
	Thu, 25 Jan 2024 01:42:24 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.116])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BE12F3F73F;
	Thu, 25 Jan 2024 01:41:35 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	will@kernel.org,
	catalin.marinas@arm.com,
	mark.rutland@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Mark Brown <broonie@kernel.org>,
	James Clark <james.clark@arm.com>,
	Rob Herring <robh@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Suzuki Poulose <suzuki.poulose@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH V16 1/8] arm64/sysreg: Add BRBE registers and fields
Date: Thu, 25 Jan 2024 15:11:12 +0530
Message-Id: <20240125094119.2542332-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-1-anshuman.khandual@arm.com>
References: <20240125094119.2542332-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds BRBE related register definitions and various other related field
macros there in. These will be used subsequently in a BRBE driver, which is
being added later on.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V16:

- Updated BRBINFx_EL1.TYPE = 0b110000 as field IMPDEF_TRAP_EL3
- Updated BRBCR_ELx[9] as field FZPSS
- Updated BRBINFINJ_EL1 to use sysreg field BRBINFx_EL1

 arch/arm64/include/asm/sysreg.h | 109 ++++++++++++++++++++++++++
 arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
 2 files changed, 240 insertions(+)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c3b19b376c86..72544b5c4951 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -272,6 +272,109 @@
 
 #define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
 
+#define __SYS_BRBINF(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 0))
+#define __SYS_BRBSRC(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 1))
+#define __SYS_BRBTGT(n)			sys_reg(2, 1, 8, ((n) & 0xf), ((((n) & 0x10) >> 2) + 2))
+
+#define SYS_BRBINF0_EL1			__SYS_BRBINF(0)
+#define SYS_BRBINF1_EL1			__SYS_BRBINF(1)
+#define SYS_BRBINF2_EL1			__SYS_BRBINF(2)
+#define SYS_BRBINF3_EL1			__SYS_BRBINF(3)
+#define SYS_BRBINF4_EL1			__SYS_BRBINF(4)
+#define SYS_BRBINF5_EL1			__SYS_BRBINF(5)
+#define SYS_BRBINF6_EL1			__SYS_BRBINF(6)
+#define SYS_BRBINF7_EL1			__SYS_BRBINF(7)
+#define SYS_BRBINF8_EL1			__SYS_BRBINF(8)
+#define SYS_BRBINF9_EL1			__SYS_BRBINF(9)
+#define SYS_BRBINF10_EL1		__SYS_BRBINF(10)
+#define SYS_BRBINF11_EL1		__SYS_BRBINF(11)
+#define SYS_BRBINF12_EL1		__SYS_BRBINF(12)
+#define SYS_BRBINF13_EL1		__SYS_BRBINF(13)
+#define SYS_BRBINF14_EL1		__SYS_BRBINF(14)
+#define SYS_BRBINF15_EL1		__SYS_BRBINF(15)
+#define SYS_BRBINF16_EL1		__SYS_BRBINF(16)
+#define SYS_BRBINF17_EL1		__SYS_BRBINF(17)
+#define SYS_BRBINF18_EL1		__SYS_BRBINF(18)
+#define SYS_BRBINF19_EL1		__SYS_BRBINF(19)
+#define SYS_BRBINF20_EL1		__SYS_BRBINF(20)
+#define SYS_BRBINF21_EL1		__SYS_BRBINF(21)
+#define SYS_BRBINF22_EL1		__SYS_BRBINF(22)
+#define SYS_BRBINF23_EL1		__SYS_BRBINF(23)
+#define SYS_BRBINF24_EL1		__SYS_BRBINF(24)
+#define SYS_BRBINF25_EL1		__SYS_BRBINF(25)
+#define SYS_BRBINF26_EL1		__SYS_BRBINF(26)
+#define SYS_BRBINF27_EL1		__SYS_BRBINF(27)
+#define SYS_BRBINF28_EL1		__SYS_BRBINF(28)
+#define SYS_BRBINF29_EL1		__SYS_BRBINF(29)
+#define SYS_BRBINF30_EL1		__SYS_BRBINF(30)
+#define SYS_BRBINF31_EL1		__SYS_BRBINF(31)
+
+#define SYS_BRBSRC0_EL1			__SYS_BRBSRC(0)
+#define SYS_BRBSRC1_EL1			__SYS_BRBSRC(1)
+#define SYS_BRBSRC2_EL1			__SYS_BRBSRC(2)
+#define SYS_BRBSRC3_EL1			__SYS_BRBSRC(3)
+#define SYS_BRBSRC4_EL1			__SYS_BRBSRC(4)
+#define SYS_BRBSRC5_EL1			__SYS_BRBSRC(5)
+#define SYS_BRBSRC6_EL1			__SYS_BRBSRC(6)
+#define SYS_BRBSRC7_EL1			__SYS_BRBSRC(7)
+#define SYS_BRBSRC8_EL1			__SYS_BRBSRC(8)
+#define SYS_BRBSRC9_EL1			__SYS_BRBSRC(9)
+#define SYS_BRBSRC10_EL1		__SYS_BRBSRC(10)
+#define SYS_BRBSRC11_EL1		__SYS_BRBSRC(11)
+#define SYS_BRBSRC12_EL1		__SYS_BRBSRC(12)
+#define SYS_BRBSRC13_EL1		__SYS_BRBSRC(13)
+#define SYS_BRBSRC14_EL1		__SYS_BRBSRC(14)
+#define SYS_BRBSRC15_EL1		__SYS_BRBSRC(15)
+#define SYS_BRBSRC16_EL1		__SYS_BRBSRC(16)
+#define SYS_BRBSRC17_EL1		__SYS_BRBSRC(17)
+#define SYS_BRBSRC18_EL1		__SYS_BRBSRC(18)
+#define SYS_BRBSRC19_EL1		__SYS_BRBSRC(19)
+#define SYS_BRBSRC20_EL1		__SYS_BRBSRC(20)
+#define SYS_BRBSRC21_EL1		__SYS_BRBSRC(21)
+#define SYS_BRBSRC22_EL1		__SYS_BRBSRC(22)
+#define SYS_BRBSRC23_EL1		__SYS_BRBSRC(23)
+#define SYS_BRBSRC24_EL1		__SYS_BRBSRC(24)
+#define SYS_BRBSRC25_EL1		__SYS_BRBSRC(25)
+#define SYS_BRBSRC26_EL1		__SYS_BRBSRC(26)
+#define SYS_BRBSRC27_EL1		__SYS_BRBSRC(27)
+#define SYS_BRBSRC28_EL1		__SYS_BRBSRC(28)
+#define SYS_BRBSRC29_EL1		__SYS_BRBSRC(29)
+#define SYS_BRBSRC30_EL1		__SYS_BRBSRC(30)
+#define SYS_BRBSRC31_EL1		__SYS_BRBSRC(31)
+
+#define SYS_BRBTGT0_EL1			__SYS_BRBTGT(0)
+#define SYS_BRBTGT1_EL1			__SYS_BRBTGT(1)
+#define SYS_BRBTGT2_EL1			__SYS_BRBTGT(2)
+#define SYS_BRBTGT3_EL1			__SYS_BRBTGT(3)
+#define SYS_BRBTGT4_EL1			__SYS_BRBTGT(4)
+#define SYS_BRBTGT5_EL1			__SYS_BRBTGT(5)
+#define SYS_BRBTGT6_EL1			__SYS_BRBTGT(6)
+#define SYS_BRBTGT7_EL1			__SYS_BRBTGT(7)
+#define SYS_BRBTGT8_EL1			__SYS_BRBTGT(8)
+#define SYS_BRBTGT9_EL1			__SYS_BRBTGT(9)
+#define SYS_BRBTGT10_EL1		__SYS_BRBTGT(10)
+#define SYS_BRBTGT11_EL1		__SYS_BRBTGT(11)
+#define SYS_BRBTGT12_EL1		__SYS_BRBTGT(12)
+#define SYS_BRBTGT13_EL1		__SYS_BRBTGT(13)
+#define SYS_BRBTGT14_EL1		__SYS_BRBTGT(14)
+#define SYS_BRBTGT15_EL1		__SYS_BRBTGT(15)
+#define SYS_BRBTGT16_EL1		__SYS_BRBTGT(16)
+#define SYS_BRBTGT17_EL1		__SYS_BRBTGT(17)
+#define SYS_BRBTGT18_EL1		__SYS_BRBTGT(18)
+#define SYS_BRBTGT19_EL1		__SYS_BRBTGT(19)
+#define SYS_BRBTGT20_EL1		__SYS_BRBTGT(20)
+#define SYS_BRBTGT21_EL1		__SYS_BRBTGT(21)
+#define SYS_BRBTGT22_EL1		__SYS_BRBTGT(22)
+#define SYS_BRBTGT23_EL1		__SYS_BRBTGT(23)
+#define SYS_BRBTGT24_EL1		__SYS_BRBTGT(24)
+#define SYS_BRBTGT25_EL1		__SYS_BRBTGT(25)
+#define SYS_BRBTGT26_EL1		__SYS_BRBTGT(26)
+#define SYS_BRBTGT27_EL1		__SYS_BRBTGT(27)
+#define SYS_BRBTGT28_EL1		__SYS_BRBTGT(28)
+#define SYS_BRBTGT29_EL1		__SYS_BRBTGT(29)
+#define SYS_BRBTGT30_EL1		__SYS_BRBTGT(30)
+#define SYS_BRBTGT31_EL1		__SYS_BRBTGT(31)
+
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -794,6 +897,12 @@
 #define OP_COSP_RCTX			sys_insn(1, 3, 7, 3, 6)
 #define OP_CPP_RCTX			sys_insn(1, 3, 7, 3, 7)
 
+/*
+ * BRBE Instructions
+ */
+#define BRB_IALL_INSN	__emit_inst(0xd5000000 | OP_BRB_IALL | (0x1f))
+#define BRB_INJ_INSN	__emit_inst(0xd5000000 | OP_BRB_INJ  | (0x1f))
+
 /* Common SCTLR_ELx flags. */
 #define SCTLR_ELx_ENTP2	(BIT(60))
 #define SCTLR_ELx_DSSBS	(BIT(44))
diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4c9b67934367..caf851ba5dc0 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1023,6 +1023,137 @@ UnsignedEnum	3:0	MTEPERM
 EndEnum
 EndSysreg
 
+
+SysregFields BRBINFx_EL1
+Res0	63:47
+Field	46	CCU
+Field	45:32	CC
+Res0	31:18
+Field	17	LASTFAILED
+Field	16	T
+Res0	15:14
+Enum	13:8		TYPE
+	0b000000	UNCOND_DIRECT
+	0b000001	INDIRECT
+	0b000010	DIRECT_LINK
+	0b000011	INDIRECT_LINK
+	0b000101	RET
+	0b000111	ERET
+	0b001000	COND_DIRECT
+	0b100001	DEBUG_HALT
+	0b100010	CALL
+	0b100011	TRAP
+	0b100100	SERROR
+	0b100110	INSN_DEBUG
+	0b100111	DATA_DEBUG
+	0b101010	ALIGN_FAULT
+	0b101011	INSN_FAULT
+	0b101100	DATA_FAULT
+	0b101110	IRQ
+	0b101111	FIQ
+	0b110000	IMPDEF_TRAP_EL3
+	0b111001	DEBUG_EXIT
+EndEnum
+Enum	7:6	EL
+	0b00	EL0
+	0b01	EL1
+	0b10	EL2
+	0b11	EL3
+EndEnum
+Field	5	MPRED
+Res0	4:2
+Enum	1:0	VALID
+	0b00	NONE
+	0b01	TARGET
+	0b10	SOURCE
+	0b11	FULL
+EndEnum
+EndSysregFields
+
+SysregFields	BRBCR_ELx
+Res0	63:24
+Field	23 	EXCEPTION
+Field	22 	ERTN
+Res0	21:10
+Field	9	FZPSS
+Field	8 	FZP
+Res0	7
+Enum	6:5	TS
+	0b01	VIRTUAL
+	0b10	GUEST_PHYSICAL
+	0b11	PHYSICAL
+EndEnum
+Field	4	MPRED
+Field	3	CC
+Res0	2
+Field	1	ExBRE
+Field	0	E0BRE
+EndSysregFields
+
+Sysreg	BRBCR_EL2	2	4	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
+Sysreg	BRBCR_EL1	2	1	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
+Sysreg	BRBCR_EL12	2	5	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
+Sysreg	BRBFCR_EL1	2	1	9	0	1
+Res0	63:30
+Enum	29:28	BANK
+	0b0	FIRST
+	0b1	SECOND
+EndEnum
+Res0	27:23
+Field	22	CONDDIR
+Field	21	DIRCALL
+Field	20	INDCALL
+Field	19	RTN
+Field	18	INDIRECT
+Field	17	DIRECT
+Field	16	EnI
+Res0	15:8
+Field	7	PAUSED
+Field	6	LASTFAILED
+Res0	5:0
+EndSysreg
+
+Sysreg	BRBTS_EL1	2	1	9	0	2
+Field	63:0	TS
+EndSysreg
+
+Sysreg	BRBINFINJ_EL1	2	1	9	1	0
+Fields BRBINFx_EL1
+EndSysreg
+
+Sysreg	BRBSRCINJ_EL1	2	1	9	1	1
+Field	63:0 ADDRESS
+EndSysreg
+
+Sysreg	BRBTGTINJ_EL1	2	1	9	1	2
+Field	63:0 ADDRESS
+EndSysreg
+
+Sysreg	BRBIDR0_EL1	2	1	9	2	0
+Res0	63:16
+Enum	15:12	CC
+	0b101	20_BIT
+EndEnum
+Enum	11:8	FORMAT
+	0b0	0
+EndEnum
+Enum	7:0		NUMREC
+	0b0001000	8
+	0b0010000	16
+	0b0100000	32
+	0b1000000	64
+EndEnum
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 UnsignedEnum	59:56	F64MM
-- 
2.25.1


