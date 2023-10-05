Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763097BA362
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjJEP5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236660AbjJEP4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:56:32 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E55155B7
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 06:53:18 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9BB131650;
        Thu,  5 Oct 2023 05:59:15 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D8B63F641;
        Thu,  5 Oct 2023 05:58:34 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.linux.dev, broonie@kernel.org, maz@kernel.org,
        suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Rob Herring <robh@kernel.org>,
        Jintack Lim <jintack.lim@linaro.org>,
        Akihiko Odaki <akihiko.odaki@daynix.com>,
        Fuad Tabba <tabba@google.com>, Joey Gouly <joey.gouly@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] arm64: KVM: Rename DEBUG_STATE_SAVE_TRBE to DEBUG_STATE_SAVE_TRFCR
Date:   Thu,  5 Oct 2023 13:57:50 +0100
Message-Id: <20231005125757.649345-3-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231005125757.649345-1-james.clark@arm.com>
References: <20231005125757.649345-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This flag actually causes the TRFCR register to be saved, so rename it
to that effect.

Currently it only happens when TRBE is used, but in a later commit
TRFCR will be saved and restored even if TRBE isn't used, so the new
name will be more accurate.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h  | 4 ++--
 arch/arm64/kvm/debug.c             | 4 ++--
 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 0ca4b34f8513..e36f7e8a76ce 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -741,8 +741,8 @@ struct kvm_vcpu_arch {
 #define DEBUG_DIRTY		__vcpu_single_flag(iflags, BIT(4))
 /* Save SPE context if active  */
 #define DEBUG_STATE_SAVE_SPE	__vcpu_single_flag(iflags, BIT(5))
-/* Save TRBE context if active  */
-#define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
+/* Save TRFCR and disable TRBE if necessary */
+#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(6))
 /* vcpu running in HYP context */
 #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
 
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..6a1bad1a921b 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -334,11 +334,11 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	/* Check if we have TRBE implemented and available at the host */
 	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
 	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
-	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 4558c02eb352..89c208112eb7 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -85,7 +85,7 @@ void __debug_save_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_save_spe(&vcpu->arch.host_debug_state.pmscr_el1);
 	/* Disable and flush Self-Hosted Trace generation */
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
 		__debug_save_trace(&vcpu->arch.host_debug_state.trfcr_el1);
 }
 
@@ -98,7 +98,7 @@ void __debug_restore_host_buffers_nvhe(struct kvm_vcpu *vcpu)
 {
 	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_SPE))
 		__debug_restore_spe(vcpu->arch.host_debug_state.pmscr_el1);
-	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRBE))
+	if (vcpu_get_flag(vcpu, DEBUG_STATE_SAVE_TRFCR))
 		__debug_restore_trace(vcpu->arch.host_debug_state.trfcr_el1);
 }
 
-- 
2.34.1

