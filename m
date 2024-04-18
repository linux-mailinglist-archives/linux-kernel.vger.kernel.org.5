Return-Path: <linux-kernel+bounces-149531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F78A9281
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 07:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E1CB2227A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 05:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EC36EB5D;
	Thu, 18 Apr 2024 05:38:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27690651B1
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713418709; cv=none; b=q5kqpzYFmtAKJITK2glCuBSt29nhckkjIflo6ac2z1KF0gLGWeVTmb+3aog43NOKldO3c7pOH5j2KozQvBEKFSsERuCnOjwkgCGm2qoaplJ4b59bLaCh8lfxqPdFzLsklIJx5+s6PpqL8hrBZUEE+U9ntArCP3EpE7sJUEzWNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713418709; c=relaxed/simple;
	bh=08xBy7dc0BzZNfQcbjK/DU3Z+lbw9+VGvRhCjd0Te58=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KnjLSup4mQXFWvqVr1Hbp1DOJDZjrmhKs2TQxhbx6k2Qgl2iE5SwSoT36vcFwHK+VOR/gWk5FU9WbVUIdyiQPfQP7Irf7iQhp5niOR5u//pzFAAki6x16Uh8xhcpynetaiUfZ0cDxQmIq7SMz3W9IPLlzDDRKJdkwgm3KpBU9Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E333153B;
	Wed, 17 Apr 2024 22:38:55 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.60.115])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 550583F792;
	Wed, 17 Apr 2024 22:38:23 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64/cpufeature: Replace custom macros with fields from ID_AA64PFR0_EL1
Date: Thu, 18 Apr 2024 11:08:04 +0530
Message-Id: <20240418053804.2573071-3-anshuman.khandual@arm.com>
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
from ID_AA64PFR0_EL1 sysreg definition. Finally let's drop off both these
custom macros as they are now redundant.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/include/asm/cpufeature.h | 4 ++--
 arch/arm64/include/asm/sysreg.h     | 4 ----
 arch/arm64/kernel/cpufeature.c      | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
index 8b904a757bd3..558434267271 100644
--- a/arch/arm64/include/asm/cpufeature.h
+++ b/arch/arm64/include/asm/cpufeature.h
@@ -588,14 +588,14 @@ static inline bool id_aa64pfr0_32bit_el1(u64 pfr0)
 {
 	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL1_EL1_SHIFT);
 
-	return val == ID_AA64PFR0_EL1_ELx_32BIT_64BIT;
+	return val == ID_AA64PFR0_EL1_EL1_AARCH32;
 }
 
 static inline bool id_aa64pfr0_32bit_el0(u64 pfr0)
 {
 	u32 val = cpuid_feature_extract_unsigned_field(pfr0, ID_AA64PFR0_EL1_EL0_SHIFT);
 
-	return val == ID_AA64PFR0_EL1_ELx_32BIT_64BIT;
+	return val == ID_AA64PFR0_EL1_EL0_AARCH32;
 }
 
 static inline bool id_aa64pfr0_sve(u64 pfr0)
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e8999592f3a..1199185a3da9 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -872,10 +872,6 @@
 /* Position the attr at the correct index */
 #define MAIR_ATTRIDX(attr, idx)		((attr) << ((idx) * 8))
 
-/* id_aa64pfr0 */
-#define ID_AA64PFR0_EL1_ELx_64BIT_ONLY		0x1
-#define ID_AA64PFR0_EL1_ELx_32BIT_64BIT		0x2
-
 /* id_aa64mmfr0 */
 #define ID_AA64MMFR0_EL1_TGRAN4_SUPPORTED_MIN	0x0
 #define ID_AA64MMFR0_EL1_TGRAN4_LPA2		ID_AA64MMFR0_EL1_TGRAN4_52_BIT
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 56583677c1f2..c041b0958f53 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -285,8 +285,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
 	S_ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_FP_SHIFT, 4, ID_AA64PFR0_EL1_FP_NI),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL3_SHIFT, 4, 0),
 	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL2_SHIFT, 4, 0),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL1_SHIFT, 4, ID_AA64PFR0_EL1_ELx_64BIT_ONLY),
-	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL0_SHIFT, 4, ID_AA64PFR0_EL1_ELx_64BIT_ONLY),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL1_SHIFT, 4, ID_AA64PFR0_EL1_EL1_IMP),
+	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64PFR0_EL1_EL0_SHIFT, 4, ID_AA64PFR0_EL1_EL0_IMP),
 	ARM64_FTR_END,
 };
 
-- 
2.25.1


