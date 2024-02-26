Return-Path: <linux-kernel+bounces-80548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CC866958
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 562B6281DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 720F11AACC;
	Mon, 26 Feb 2024 04:24:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B41BC37
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921493; cv=none; b=emAVgZ0AYrqu70RVyZfR5QtlFNbazUADicsl+HbeunsguQNs1TDz3IPLuNlzgQUV5bffaR4HU8YnannH+9P01r6rZ/tU5tJjDGc1HP1fsgVIOs96g3Dw2vrwBG+HwO6579h0iJUZjGFMVspCNTeH8gCIAb6geKf7UsK1VyBzjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921493; c=relaxed/simple;
	bh=pz08OpPZftYgWwyybR8NsVdJ6Umld9QuXg1gEDEj9tk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HefvboszyK9w6+JAAAv2CUPqzdHDLMEWcob8APRKOx8/FXRzd+/8MUAGW23cRUlNsU2qZ/Tdguf0pktDSea2obfB4QdPhRVCxMYrAK6KXTOQPy6QkZKybofW+DlzoXNJO9uJ7vv5sOWcd9fLDYoSnKquTgODclw6dCEEIFs2/ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 06C4E1FB;
	Sun, 25 Feb 2024 20:25:29 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1D31F3F6C4;
	Sun, 25 Feb 2024 20:24:46 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	mark.rutland@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sysreg: Add BRBE registers and fields
Date: Mon, 26 Feb 2024 09:54:41 +0530
Message-Id: <20240226042441.4098806-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240125094119.2542332-2-anshuman.khandual@arm.com>
References: <20240125094119.2542332-2-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds BRBE related register definitions and various other related field
macros there in. These will be used subsequently in a BRBE driver, which is
being added later on. While here, this drops redundant register definitions
from the header i.e (arch/arm64/include/asm/sysreg.h).

BRBINFx_EL1_TYPE_IMPDEF_TRAP_EL3 register field value has been derived from
latest ARM DDI 0601 ID121123, AKA 2023-12 instead of latest ARM ARM i.e ARM
DDI 0487J.a. Please find the definition here.

https://developer.arm.com/documentation/ddi0601/2023-12/

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Please find the modified patch here for a quick review and do let me know
if this looks good for the next version i.e V17. BRBCR_EL1/12/2 organized
per their encoding. Thanks !

 arch/arm64/include/asm/sysreg.h |  17 ++---
 arch/arm64/tools/sysreg         | 131 ++++++++++++++++++++++++++++++++
 2 files changed, 137 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index c3b19b376c86..481c7d186dfa 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -195,16 +195,8 @@
 #define SYS_DBGVCR32_EL2		sys_reg(2, 4, 0, 7, 0)
 
 #define SYS_BRBINF_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 0))
-#define SYS_BRBINFINJ_EL1		sys_reg(2, 1, 9, 1, 0)
 #define SYS_BRBSRC_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 1))
-#define SYS_BRBSRCINJ_EL1		sys_reg(2, 1, 9, 1, 1)
 #define SYS_BRBTGT_EL1(n)		sys_reg(2, 1, 8, (n & 15), (((n & 16) >> 2) | 2))
-#define SYS_BRBTGTINJ_EL1		sys_reg(2, 1, 9, 1, 2)
-#define SYS_BRBTS_EL1			sys_reg(2, 1, 9, 0, 2)
-
-#define SYS_BRBCR_EL1			sys_reg(2, 1, 9, 0, 0)
-#define SYS_BRBFCR_EL1			sys_reg(2, 1, 9, 0, 1)
-#define SYS_BRBIDR0_EL1			sys_reg(2, 1, 9, 2, 0)
 
 #define SYS_TRCITECR_EL1		sys_reg(3, 0, 1, 2, 3)
 #define SYS_TRCACATR(m)			sys_reg(2, 1, 2, ((m & 7) << 1), (2 | (m >> 3)))
@@ -270,8 +262,6 @@
 /* ETM */
 #define SYS_TRCOSLAR			sys_reg(2, 1, 1, 0, 4)
 
-#define SYS_BRBCR_EL2			sys_reg(2, 4, 9, 0, 0)
-
 #define SYS_MIDR_EL1			sys_reg(3, 0, 0, 0, 0)
 #define SYS_MPIDR_EL1			sys_reg(3, 0, 0, 0, 5)
 #define SYS_REVIDR_EL1			sys_reg(3, 0, 0, 0, 6)
@@ -601,7 +591,6 @@
 #define SYS_CNTHV_CVAL_EL2		sys_reg(3, 4, 14, 3, 2)
 
 /* VHE encodings for architectural EL0/1 system registers */
-#define SYS_BRBCR_EL12			sys_reg(2, 5, 9, 0, 0)
 #define SYS_SCTLR_EL12			sys_reg(3, 5, 1, 0, 0)
 #define SYS_CPACR_EL12			sys_reg(3, 5, 1, 0, 2)
 #define SYS_SCTLR2_EL12			sys_reg(3, 5, 1, 0, 3)
@@ -794,6 +783,12 @@
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
index 4c9b67934367..60d288cbd5eb 100644
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
+	0b000000	DIRECT_UNCOND
+	0b000001	INDIRECT
+	0b000010	DIRECT_LINK
+	0b000011	INDIRECT_LINK
+	0b000101	RET
+	0b000111	ERET
+	0b001000	DIRECT_COND
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
+Sysreg	BRBCR_EL1	2	1	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
+Sysreg	BRBFCR_EL1	2	1	9	0	1
+Res0	63:30
+Enum	29:28	BANK
+	0b00	BANK_0
+	0b01	BANK_1
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
+	0b00001000	8
+	0b00010000	16
+	0b00100000	32
+	0b01000000	64
+EndEnum
+EndSysreg
+
+Sysreg	BRBCR_EL2	2	4	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
+Sysreg	BRBCR_EL12	2	5	9	0	0
+Fields	BRBCR_ELx
+EndSysreg
+
 Sysreg	ID_AA64ZFR0_EL1	3	0	0	4	4
 Res0	63:60
 UnsignedEnum	59:56	F64MM
-- 
2.25.1


