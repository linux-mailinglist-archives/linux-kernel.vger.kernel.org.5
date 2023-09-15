Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373F37A1F2D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235187AbjIOMuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235139AbjIOMt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:49:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6B061FDF
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 05:49:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CDABE1FB;
        Fri, 15 Sep 2023 05:50:28 -0700 (PDT)
Received: from e126864.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D56003F5A1;
        Fri, 15 Sep 2023 05:49:48 -0700 (PDT)
From:   Kristina Martsenko <kristina.martsenko@arm.com>
To:     kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Colton Lewis <coltonlewis@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] KVM: arm64: Expose MOPS instructions to guests
Date:   Fri, 15 Sep 2023 13:48:40 +0100
Message-Id: <20230915124840.474888-4-kristina.martsenko@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230915124840.474888-1-kristina.martsenko@arm.com>
References: <20230915124840.474888-1-kristina.martsenko@arm.com>
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

Expose the Armv8.8 FEAT_MOPS feature to guests in the ID register and
allow the MOPS instructions to be run in a guest. Only expose MOPS if
the whole system supports it.

Note, it is expected that guests do not use these instructions on MMIO,
similarly to other instructions where ESR_EL2.ISV==0 such as LDP/STP.

Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>
---
 arch/arm64/include/asm/kvm_emulate.h           | 5 +++++
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 3 ++-
 arch/arm64/kvm/sys_regs.c                      | 1 -
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 64ea27e6deb1..ba46004be0e8 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -137,6 +137,11 @@ static inline void vcpu_ptrauth_disable(struct kvm_vcpu *vcpu)
 static inline void vcpu_reset_hcrx(struct kvm_vcpu *vcpu)
 {
 	vcpu->arch.hcrx_el2 = HCRX_GUEST_FLAGS;
+
+	if (cpus_have_final_cap(ARM64_HAS_MOPS)) {
+		vcpu->arch.hcrx_el2 |= HCRX_EL2_MSCEn;
+		vcpu->arch.hcrx_el2 |= HCRX_EL2_MCE2;
+	}
 }
 
 static inline unsigned long vcpu_get_vsesr(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 37440e1dda93..e91922daa8ca 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -197,7 +197,8 @@
 
 #define PVM_ID_AA64ISAR2_ALLOW (\
 	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_GPA3) | \
-	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_APA3) \
+	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_APA3) | \
+	ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_MOPS) \
 	)
 
 u64 pvm_read_id_reg(const struct kvm_vcpu *vcpu, u32 id);
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e92ec810d449..153baf2f72cb 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1338,7 +1338,6 @@ static u64 __kvm_read_sanitised_id_reg(const struct kvm_vcpu *vcpu,
 				 ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_GPA3));
 		if (!cpus_have_final_cap(ARM64_HAS_WFXT))
 			val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_WFxT);
-		val &= ~ARM64_FEATURE_MASK(ID_AA64ISAR2_EL1_MOPS);
 		break;
 	case SYS_ID_AA64MMFR2_EL1:
 		val &= ~ID_AA64MMFR2_EL1_CCIDX_MASK;
-- 
2.25.1

