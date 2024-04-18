Return-Path: <linux-kernel+bounces-149529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA188A9280
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32967B222BE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA456B67;
	Thu, 18 Apr 2024 05:38:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDD21755B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418707; cv=none; b=EU4gfMsBvClWXXEWurAI6I8m7jKzHv0RmJxJzLx6HjwNoTTvuirb19sQ7HseYUpB8/xGx+zhPYXXHzuYvTGI7rYcKNry8glGX1roRMp05wUloe4+KTfEPI0S1SZmvMn1FJK5eInuU8Kwr7AmvIwgPunrKJQGKLEoMgZoCDUEYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418707; c=relaxed/simple;
	bh=p4ZBSPDbE2nW6K1Ts3TieiUCROkQrl5qpQuS3vATpi0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eLNwLZYU/seTCaOVwlDGZrjSzZ24Rjo9HOjZReT3tZxf7D5A/etroPS1MKTQQjhPvbHd8iAnXyH0bvR0aGjeys51WW2JwrQTy3Df0mos6IrPrxUORGGD2d1GkJ5uKiAqjdYrY6CNsjJrmvi2vppu8xxFv51qRr4pc5kEBG3S1Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57E18DA7;
	Wed, 17 Apr 2024 22:38:51 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.60.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 69B543F792;
	Wed, 17 Apr 2024 22:38:19 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Will Deacon <will@kernel.org>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: arm64: Replace custom macros with fields from ID_AA64PFR0_EL1
Date: Thu, 18 Apr 2024 11:08:03 +0530
Message-Id: <20240418053804.2573071-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418053804.2573071-1-anshuman.khandual@arm.com>
References: <20240418053804.2573071-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This replaces custom macros usage (i.e ID_AA64PFR0_EL1_ELx_64BIT_ONLY and
ID_AA64PFR0_EL1_ELx_32BIT_64BIT) and instead directly uses register fields
from ID_AA64PFR0_EL1 sysreg definition.

Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oliver.upton@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: kvmarm@lists.linux.dev
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/kvm/hyp/include/nvhe/fixed_config.h | 8 ++++----
 arch/arm64/kvm/hyp/nvhe/pkvm.c                 | 4 ++--
 arch/arm64/kvm/hyp/nvhe/sys_regs.c             | 2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
index 51f043649146..0034bfffced6 100644
--- a/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
+++ b/arch/arm64/kvm/hyp/include/nvhe/fixed_config.h
@@ -52,10 +52,10 @@
  *	Supported by KVM
  */
 #define PVM_ID_AA64PFR0_RESTRICT_UNSIGNED (\
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL2), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
-	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL3), ID_AA64PFR0_EL1_ELx_64BIT_ONLY) | \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0), ID_AA64PFR0_EL1_EL0_IMP) | \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1), ID_AA64PFR0_EL1_EL1_IMP) | \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL2), ID_AA64PFR0_EL1_EL2_IMP) | \
+	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL3), ID_AA64PFR0_EL1_EL3_IMP) | \
 	FIELD_PREP(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_RAS), ID_AA64PFR0_EL1_RAS_IMP) \
 	)
 
diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index 26dd9a20ad6e..58da2fec89b2 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -31,9 +31,9 @@ static void pvm_init_traps_aa64pfr0(struct kvm_vcpu *vcpu)
 
 	/* Protected KVM does not support AArch32 guests. */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL0),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_EL0_IMP);
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) != ID_AA64PFR0_EL1_EL1_IMP);
 
 	/*
 	 * Linux guests assume support for floating-point and Advanced SIMD. Do
diff --git a/arch/arm64/kvm/hyp/nvhe/sys_regs.c b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
index edd969a1f36b..2860548d4250 100644
--- a/arch/arm64/kvm/hyp/nvhe/sys_regs.c
+++ b/arch/arm64/kvm/hyp/nvhe/sys_regs.c
@@ -276,7 +276,7 @@ static bool pvm_access_id_aarch32(struct kvm_vcpu *vcpu,
 	 * of AArch32 feature id registers.
 	 */
 	BUILD_BUG_ON(FIELD_GET(ARM64_FEATURE_MASK(ID_AA64PFR0_EL1_EL1),
-		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_ELx_64BIT_ONLY);
+		     PVM_ID_AA64PFR0_RESTRICT_UNSIGNED) > ID_AA64PFR0_EL1_EL1_IMP);
 
 	return pvm_access_raz_wi(vcpu, p, r);
 }
-- 
2.25.1


