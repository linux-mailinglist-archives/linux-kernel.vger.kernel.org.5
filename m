Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CEE3800316
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 06:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377506AbjLAFjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 00:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377518AbjLAFjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 00:39:33 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5DAD91729;
        Thu, 30 Nov 2023 21:39:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB95C1042;
        Thu, 30 Nov 2023 21:40:20 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4E6F93F73F;
        Thu, 30 Nov 2023 21:39:28 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Brown <broonie@kernel.org>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users@vger.kernel.org,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>, kvmarm@lists.linux.dev
Subject: [PATCH V15 2/8] KVM: arm64: Prevent guest accesses into BRBE system registers/instructions
Date:   Fri,  1 Dec 2023 11:09:00 +0530
Message-Id: <20231201053906.1261704-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231201053906.1261704-1-anshuman.khandual@arm.com>
References: <20231201053906.1261704-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently BRBE feature is not supported in a guest environment. This hides
BRBE feature availability via masking ID_AA64DFR0_EL1.BRBE field. This also
blocks guest accesses into BRBE system registers and instructions as if the
underlying hardware never implemented FEAT_BRBE feature.

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
---
 arch/arm64/kvm/sys_regs.c | 130 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 130 insertions(+)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 4735e1b37fb3..42701065b3cd 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1583,6 +1583,9 @@ static u64 read_sanitised_id_aa64dfr0_el1(struct kvm_vcpu *vcpu,
 	/* Hide SPE from guests */
 	val &= ~ID_AA64DFR0_EL1_PMSVer_MASK;
 
+	/* Hide BRBE from guests */
+	val &= ~ID_AA64DFR0_EL1_BRBE_MASK;
+
 	return val;
 }
 
@@ -2042,6 +2045,8 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_DC_CISW), access_dcsw },
 	{ SYS_DESC(SYS_DC_CIGSW), access_dcgsw },
 	{ SYS_DESC(SYS_DC_CIGDSW), access_dcgsw },
+	{ SYS_DESC(OP_BRB_IALL), undef_access },
+	{ SYS_DESC(OP_BRB_INJ), undef_access },
 
 	DBG_BCR_BVR_WCR_WVR_EL1(0),
 	DBG_BCR_BVR_WCR_WVR_EL1(1),
@@ -2072,6 +2077,131 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_DBGCLAIMCLR_EL1), trap_raz_wi },
 	{ SYS_DESC(SYS_DBGAUTHSTATUS_EL1), trap_dbgauthstatus_el1 },
 
+	/*
+	 * BRBE branch record sysreg address space is interleaved between
+	 * corresponding BRBINF<N>_EL1, BRBSRC<N>_EL1, and BRBTGT<N>_EL1.
+	 */
+	{ SYS_DESC(SYS_BRBINF0_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC0_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT0_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF16_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC16_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT16_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF1_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC1_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT1_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF17_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC17_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT17_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF2_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC2_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT2_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF18_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC18_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT18_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF3_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC3_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT3_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF19_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC19_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT19_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF4_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC4_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT4_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF20_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC20_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT20_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF5_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC5_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT5_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF21_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC21_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT21_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF6_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC6_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT6_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF22_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC22_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT22_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF7_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC7_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT7_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF23_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC23_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT23_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF8_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC8_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT8_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF24_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC24_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT24_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF9_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC9_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT9_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF25_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC25_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT25_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF10_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC10_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT10_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF26_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC26_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT26_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF11_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC11_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT11_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF27_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC27_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT27_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF12_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC12_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT12_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF28_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC28_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT28_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF13_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC13_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT13_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF29_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC29_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT29_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF14_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC14_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT14_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF30_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC30_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT30_EL1), undef_access },
+
+	{ SYS_DESC(SYS_BRBINF15_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC15_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT15_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBINF31_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBSRC31_EL1), undef_access },
+	{ SYS_DESC(SYS_BRBTGT31_EL1), undef_access },
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
-- 
2.25.1

