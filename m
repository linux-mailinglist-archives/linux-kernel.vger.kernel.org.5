Return-Path: <linux-kernel+bounces-16929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BEB182462A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 17:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E1F9B23E1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 16:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F483250F4;
	Thu,  4 Jan 2024 16:28:34 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B5425102
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 16:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8AFFC15;
	Thu,  4 Jan 2024 08:29:17 -0800 (PST)
Received: from e127643.. (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2A9BD3F5A1;
	Thu,  4 Jan 2024 08:28:23 -0800 (PST)
From: James Clark <james.clark@arm.com>
To: coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	broonie@kernel.org,
	maz@kernel.org,
	suzuki.poulose@arm.com,
	acme@kernel.org
Cc: James Clark <james.clark@arm.com>,
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
	Miguel Luis <miguel.luis@oracle.com>,
	Jintack Lim <jintack.lim@linaro.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Kalesh Singh <kaleshsingh@google.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Kristina Martsenko <kristina.martsenko@arm.com>,
	Akihiko Odaki <akihiko.odaki@daynix.com>,
	Fuad Tabba <tabba@google.com>,
	Joey Gouly <joey.gouly@arm.com>,
	Jing Zhang <jingzhangos@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/7] arm64: KVM: Add iflag for FEAT_TRF
Date: Thu,  4 Jan 2024 16:27:04 +0000
Message-Id: <20240104162714.1062610-5-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240104162714.1062610-1-james.clark@arm.com>
References: <20240104162714.1062610-1-james.clark@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an extra iflag to signify if the TRFCR register is accessible.
Because TRBE requires FEAT_TRF, DEBUG_STATE_SAVE_TRBE still has the same
behavior even though it's only set when FEAT_TRF is present.

The following holes are left in struct kvm_vcpu_arch, but there aren't
enough other 8 bit fields to rearrange it to leave any hole smaller than
7 bytes:

  u8                         cflags;               /*  2292     1 */
  /* XXX 1 byte hole, try to pack */
  u16                        iflags;               /*  2294     2 */
  u8                         sflags;               /*  2296     1 */
  bool                       pause;                /*  2297     1 */
  /* XXX 6 bytes hole, try to pack */

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm64/include/asm/kvm_host.h |  4 +++-
 arch/arm64/kvm/debug.c            | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index 93d38ad257ed..4864a1fcdf89 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -551,7 +551,7 @@ struct kvm_vcpu_arch {
 	u8 cflags;
 
 	/* Input flags to the hypervisor code, potentially cleared after use */
-	u8 iflags;
+	u16 iflags;
 
 	/* State flags for kernel bookkeeping, unused by the hypervisor code */
 	u8 sflags;
@@ -761,6 +761,8 @@ struct kvm_vcpu_arch {
 #define DEBUG_STATE_SAVE_TRBE	__vcpu_single_flag(iflags, BIT(6))
 /* vcpu running in HYP context */
 #define VCPU_HYP_CONTEXT	__vcpu_single_flag(iflags, BIT(7))
+/* Save trace filter controls */
+#define DEBUG_STATE_SAVE_TRFCR	__vcpu_single_flag(iflags, BIT(8))
 
 /* SVE enabled for host EL0 */
 #define HOST_SVE_ENABLED	__vcpu_single_flag(sflags, BIT(0))
diff --git a/arch/arm64/kvm/debug.c b/arch/arm64/kvm/debug.c
index 8725291cb00a..f86cbfae60f3 100644
--- a/arch/arm64/kvm/debug.c
+++ b/arch/arm64/kvm/debug.c
@@ -331,14 +331,30 @@ void kvm_arch_vcpu_load_debug_state_flags(struct kvm_vcpu *vcpu)
 	    !(read_sysreg_s(SYS_PMBIDR_EL1) & BIT(PMBIDR_EL1_P_SHIFT)))
 		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 
-	/* Check if we have TRBE implemented and available at the host */
-	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
-	    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
-		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	/*
+	 * Set SAVE_TRFCR flag if FEAT_TRF (TraceFilt) exists. This flag
+	 * signifies that the exclude_host/exclude_guest settings of any active
+	 * host Perf session on a core running a VCPU can be written into
+	 * TRFCR_EL1 on guest switch.
+	 */
+	if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceFilt_SHIFT)) {
+		vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
+		/*
+		 * Check if we have TRBE implemented and available at the host.
+		 * If it's in use at the time of guest switch then trace will
+		 * need to be completely disabled. The architecture mandates
+		 * FEAT_TRF with TRBE, so we only need to check for TRBE after
+		 * TRF.
+		 */
+		if (cpuid_feature_extract_unsigned_field(dfr0, ID_AA64DFR0_EL1_TraceBuffer_SHIFT) &&
+		    !(read_sysreg_s(SYS_TRBIDR_EL1) & TRBIDR_EL1_P))
+			vcpu_set_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	}
 }
 
 void kvm_arch_vcpu_put_debug_state_flags(struct kvm_vcpu *vcpu)
 {
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_SPE);
 	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRBE);
+	vcpu_clear_flag(vcpu, DEBUG_STATE_SAVE_TRFCR);
 }
-- 
2.34.1


