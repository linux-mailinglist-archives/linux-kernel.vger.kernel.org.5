Return-Path: <linux-kernel+bounces-140442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE97D8A14BA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEDD1C22821
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650F66ABA;
	Thu, 11 Apr 2024 12:35:30 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A028633
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 12:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712838930; cv=none; b=gs5VciINSdkgsCwyun/R/kZeabwLZD278JdtABkuDZ2QCGm1ZWehpm8urSOL15AIRhxujZNLK/X/NurCa7a718/r1vW8wIqMXO/fbZ7EhNT5pRHnlSayhbSrLqtMSMXQ8cPWyYLl6R4yJzhBMDLhelSX9k1GoyZmzHdx5PGslVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712838930; c=relaxed/simple;
	bh=VlTsClRPNfbw4IUtVTteG6qNe/mvq7LDVS2fF6IA07c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=C/QfYnaZmrzh8bDj8AMnLoCr+Lc0j5EirIpipastRW21C/5SwyLF5tsquQvqakP5qlmkMbFVuKKeYea7qwrFN5VJxcdaeWrZT4Phr9zRustIghpspEgOEL+UAQgiBcId5kSYHI77CtmkAeaYedHA0Hsd3x+dGb+GXPMTXKCzciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4VFfGj5YYcz2CcCM;
	Thu, 11 Apr 2024 20:32:29 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 9BABB1400C9;
	Thu, 11 Apr 2024 20:35:22 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 11 Apr 2024 20:35:22 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH v2] arm64: arm_pmuv3: Correctly extract and check the PMUVer
Date: Thu, 11 Apr 2024 20:30:30 +0800
Message-ID: <20240411123030.7201-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we're using "sbfx" to extract the PMUVer from ID_AA64DFR0_EL1
and skip the init/reset if no PMU present when the extracted PMUVer is
negative or is zero. However for PMUv3p8 the PMUVer will be 0b1000 and
PMUVer extracted by "sbfx" will always be negative and we'll skip the
init/reset in __init_el2_debug/reset_pmuserenr_el0 unexpectedly.

So this patch use "ubfx" instead of "sbfx" to extract the PMUVer. If
the PMUVer is implementation defined (0b1111) or not implemented(0b0000)
then skip the reset/init. Previously we'll also skip the init/reset
if the PMUVer is higher than the version we known (currently PMUv3p9),
with this patch we'll only skip if the PMU is not implemented or
implementation defined. This keeps consistence with how we probe
the PMU in the driver with pmuv3_implemented().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
Change since v1:
- Use "ccmp" rather than "csel" to make it tidier, per Will
Link: https://lore.kernel.org/all/20240408081158.15291-1-yangyicong@huawei.com/

 arch/arm64/include/asm/assembler.h | 7 ++++---
 arch/arm64/include/asm/el2_setup.h | 9 +++++----
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ab8b396428da..9ecd076ba08f 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -480,9 +480,10 @@ alternative_endif
  */
 	.macro	reset_pmuserenr_el0, tmpreg
 	mrs	\tmpreg, id_aa64dfr0_el1
-	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
-	cmp	\tmpreg, #1			// Skip if no PMU present
-	b.lt	9000f
+	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	cmp	\tmpreg, #ID_AA64DFR0_EL1_PMUVer_NI
+	ccmp	\tmpreg, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF, #4, ne
+	b.eq	9000f				// Skip if no PMU present or IMP_DEF
 	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
 9000:
 	.endm
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..e4546b29dd0c 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -59,13 +59,14 @@
 
 .macro __init_el2_debug
 	mrs	x1, id_aa64dfr0_el1
-	sbfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
-	cmp	x0, #1
-	b.lt	.Lskip_pmu_\@			// Skip if no PMU present
+	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	cmp	x0, #ID_AA64DFR0_EL1_PMUVer_NI
+	ccmp	x0, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF, #4, ne
+	b.eq	.Lskip_pmu_\@			// Skip if no PMU present or IMP_DEF
 	mrs	x0, pmcr_el0			// Disable debug access traps
 	ubfx	x0, x0, #11, #5			// to EL2 and allow access to
 .Lskip_pmu_\@:
-	csel	x2, xzr, x0, lt			// all PMU counters from EL1
+	csel	x2, xzr, x0, eq			// all PMU counters from EL1
 
 	/* Statistical profiling */
 	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMSVer_SHIFT, #4
-- 
2.24.0


