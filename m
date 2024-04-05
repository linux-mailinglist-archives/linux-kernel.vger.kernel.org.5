Return-Path: <linux-kernel+bounces-132339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B60899359
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E19DB2529D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82AD91D53C;
	Fri,  5 Apr 2024 02:47:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3171E1CD35;
	Fri,  5 Apr 2024 02:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712285230; cv=none; b=GFMAr2kKVZ1xuSDBX5kIl0vjUuiWSyt6AXNqcsAPLo2ySf0R19icGGkwVydf/6CYnBPwLXo/O4AuW0XjsPax6H+X8RnPC6NBqEx1+NbXzKs5Ri5ndZqmOUQEQ/X707e+RaynKiH4naYP9gDgxH19pUzJW/P3Izv6aDFjaV29Ejk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712285230; c=relaxed/simple;
	bh=6vvI6hOuobBDdHS5Iy4QavnhfJGHpfR5o8reRq3TQ3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sIb3jrHQInwmdJLlnHp2c4nGBhnw7eQLqUncJhinIuIy+kHrNBOxH2k5xuZa6lYVeZv4bJbyRZI7mpfVvjKycUE/GwM0PHfYlRpuzrpMz/SAeTE/YBp1SzSatZg/17dsmS6zpOo2oEXvji3O4ya3BO3WC5KWfhNgS0gT+C0+MQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12FE7FEC;
	Thu,  4 Apr 2024 19:47:38 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BD77C3F766;
	Thu,  4 Apr 2024 19:47:01 -0700 (PDT)
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
	linux-perf-users@vger.kernel.org,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	kvmarm@lists.linux.dev
Subject: [PATCH V17 2/9] KVM: arm64: Explicitly handle BRBE traps as UNDEFINED
Date: Fri,  5 Apr 2024 08:16:32 +0530
Message-Id: <20240405024639.1179064-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405024639.1179064-1-anshuman.khandual@arm.com>
References: <20240405024639.1179064-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Branch Record Buffer Extension (BRBE) adds a number of system registers
and instructions, which we don't currently intend to expose to guests. Our
existing logic handles this safely, but this could be improved with some
explicit handling of BRBE.

The presence of BRBE is currently hidden from guests as the cpufeature
code's ftr_id_aa64dfr0[] table doesn't have an entry for the BRBE field,
and so this will be zero in the sanitised value of ID_AA64DFR0 exposed to
guests via read_sanitised_id_aa64dfr0_el1(). As the ftr_id_aa64dfr0[] table
may gain an entry for the BRBE field in future, for robustness we should
explicitly mask out the BRBE field in read_sanitised_id_aa64dfr0_el1().

The BRBE system registers and instructions are currently trapped by the
existing configuration of the fine-grained traps. As neither the registers
are not described in the sys_reg_descs[] nor the instructions are described
in the sys_insn_descs[] table, emulate_sys_reg() will warn that these are
unknown before injecting an UNDEFINED exception into the guest.
Well-behaved guests shouldn't try to use the registers or instructions, but
badly-behaved guests could use these, resulting in unnecessary warnings. To
avoid those warnings, we should explicitly handle the BRBE registers, and
instructions as UNDEFINED.

Address the above by having read_sanitised_id_aa64dfr0_el1() mask out the
ID_AA64DFR0.BRBE field, and by adding sys_reg_descs entries for all of the
BRBE system registers, also by adding sys_insn_descs entries for all of the
BRBE instructions, treating these all as UNDEFINED.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: James Morse <james.morse@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: kvmarm@lists.linux.dev
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
----
Changes in V17:

- Updated the commit message including about sys_insn_descs[]
- Changed KVM to use existing SYS_BRBSRC/TGT/INF_EL1(n) format
- Moved the BRBE instructions into sys_insn_descs[] array

 arch/arm64/kvm/sys_regs.c | 56 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index c9f4f387155f..3981aa32c5a3 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1304,6 +1304,11 @@ static int set_pmcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r,
 	return 0;
 }
 
+#define BRB_INF_SRC_TGT_EL1(n)				\
+	{ SYS_DESC(SYS_BRBINF_EL1(n)), undef_access },	\
+	{ SYS_DESC(SYS_BRBSRC_EL1(n)), undef_access },	\
+	{ SYS_DESC(SYS_BRBTGT_EL1(n)), undef_access }	\
+
 /* Silly macro to expand the DBG{BCR,BVR,WVR,WCR}n_EL1 registers in one go */
 #define DBG_BCR_BVR_WCR_WVR_EL1(n)					\
 	{ SYS_DESC(SYS_DBGBVRn_EL1(n)),					\
@@ -1708,6 +1713,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 	/* Hide SPE from guests */
 	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
 
+	/* Hide BRBE from guests */
+	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
+
 	return val;
 }
 
@@ -2226,6 +2234,52 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
 
+	/*
+	 * BRBE branch record sysreg address space is interleaved between
+	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
+	 */
+	BRB_INF_SRC_TGT_EL1(0),
+	BRB_INF_SRC_TGT_EL1(16),
+	BRB_INF_SRC_TGT_EL1(1),
+	BRB_INF_SRC_TGT_EL1(17),
+	BRB_INF_SRC_TGT_EL1(2),
+	BRB_INF_SRC_TGT_EL1(18),
+	BRB_INF_SRC_TGT_EL1(3),
+	BRB_INF_SRC_TGT_EL1(19),
+	BRB_INF_SRC_TGT_EL1(4),
+	BRB_INF_SRC_TGT_EL1(20),
+	BRB_INF_SRC_TGT_EL1(5),
+	BRB_INF_SRC_TGT_EL1(21),
+	BRB_INF_SRC_TGT_EL1(6),
+	BRB_INF_SRC_TGT_EL1(22),
+	BRB_INF_SRC_TGT_EL1(7),
+	BRB_INF_SRC_TGT_EL1(23),
+	BRB_INF_SRC_TGT_EL1(8),
+	BRB_INF_SRC_TGT_EL1(24),
+	BRB_INF_SRC_TGT_EL1(9),
+	BRB_INF_SRC_TGT_EL1(25),
+	BRB_INF_SRC_TGT_EL1(10),
+	BRB_INF_SRC_TGT_EL1(26),
+	BRB_INF_SRC_TGT_EL1(11),
+	BRB_INF_SRC_TGT_EL1(27),
+	BRB_INF_SRC_TGT_EL1(12),
+	BRB_INF_SRC_TGT_EL1(28),
+	BRB_INF_SRC_TGT_EL1(13),
+	BRB_INF_SRC_TGT_EL1(29),
+	BRB_INF_SRC_TGT_EL1(14),
+	BRB_INF_SRC_TGT_EL1(30),
+	BRB_INF_SRC_TGT_EL1(15),
+	BRB_INF_SRC_TGT_EL1(31),
+
+	/* Remaining BRBE sysreg addresses space */
+	{ SYS_DESC(SYS_BRBCR_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBFCR_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTS_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINFINJ_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRCINJ_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGTINJ_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBIDR0_EL1), undef_access },
+
 	{ SYS_DESC(SYS_MDCCSR_EL0), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGDTR_EL0), trap_raz_wi },
 	// DBGDTR[TR]X_EL0 share the same encoding
@@ -2738,6 +2792,8 @@ static struct sys_reg_desc sys_insn_descs[] = {
 	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
 	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
 	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
+	{ SYS_DESC(OP_BRB_IALL), undef_access },
+	{ SYS_DESC(OP_BRB_INJ), undef_access },
 };
 
 static const struct sys_reg_desc *first_idreg;
-- 
2.25.1


