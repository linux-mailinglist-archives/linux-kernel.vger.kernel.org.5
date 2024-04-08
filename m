Return-Path: <linux-kernel+bounces-135019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED63B89BA03
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A2BE1F21C90
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582082D796;
	Mon,  8 Apr 2024 08:17:00 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5624D28DDE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 08:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712564219; cv=none; b=HGKcYsMsOuQDignWGApJo6brBK68m5IDDbygxDO2QjZA5Lp/KmLuGfhjy5jigsr0HbrG4JNCLa3qINYVyuxr4Od6YQSlrtPz/Aap8CWz0zoZEBzfl3l2F+OseOxTpxEKp+Zj1ZVNwLyeksnkz4F1kct90IyoaAK4nJUM8NLGv2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712564219; c=relaxed/simple;
	bh=cPhgJR2bshKb+dPc9xJ0xovHcPH+z5sVjkaZ3ePwos0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kghfAzII0GCMWElljJW7HzpT/JN8i7/4c1sWsSqNsgkZTHxJfAiWnF4zI/43ZTbSc1S+Fu46nVDK59Cykbn9aVge8VFmuWQWk05cTsXaLXUy0tK9rXK2Lhz6gwIJT9M5cOEq66jePMIrJILwTg+d0BV08kvfW5eDiC+9dmpgyzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4VChk23Fttz21kdc;
	Mon,  8 Apr 2024 16:15:54 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id EE5AC1401E9;
	Mon,  8 Apr 2024 16:16:48 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 8 Apr 2024 16:16:48 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <will@kernel.org>, <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
	<broonie@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH] arm64: arm_pmuv3: Correctly extract and check the PMUVer
Date: Mon, 8 Apr 2024 16:11:58 +0800
Message-ID: <20240408081158.15291-1-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

Currently we're using "sbfx" to extract the PMUVer from ID_AA64DFR0_EL1
and skip the init/reset if no PMU present when the extracted PMUVer is
negative or is zero. However for PMUv3p8 the PMUVer will be 0b1000 and
PMUVer extracted by "sbfx" will always be negative and we'll skip the
init/reset in __init_el2_debug/reset_pmuserenr_el0 unexpectedly.

So this patch use "ubfx" instead of "sbfx" to extract the PMUVer. If
the PMUVer is implementation defined (0b1111) then reset it to zero
and skip the reset/init. Previously we'll also skip the init/reset
if the PMUVer is higher than the version we known (currently PMUv3p9),
with this patch we'll only skip if the PMU is not implemented or
implementation defined. This keeps consistence with how we probe
the PMU in the driver with pmuv3_implemented().

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/assembler.h | 5 ++++-
 arch/arm64/include/asm/el2_setup.h | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/assembler.h b/arch/arm64/include/asm/assembler.h
index ab8b396428da..3b7373d6c565 100644
--- a/arch/arm64/include/asm/assembler.h
+++ b/arch/arm64/include/asm/assembler.h
@@ -480,7 +480,10 @@ alternative_endif
  */
 	.macro	reset_pmuserenr_el0, tmpreg
 	mrs	\tmpreg, id_aa64dfr0_el1
-	sbfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	ubfx	\tmpreg, \tmpreg, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	cmp	\tmpreg, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
+	csel	\tmpreg, xzr, \tmpreg, eq	// If PMU's IMP_DEF, regard it
+						// as not implemented and skip
 	cmp	\tmpreg, #1			// Skip if no PMU present
 	b.lt	9000f
 	msr	pmuserenr_el0, xzr		// Disable PMU access from EL0
diff --git a/arch/arm64/include/asm/el2_setup.h b/arch/arm64/include/asm/el2_setup.h
index b7afaa026842..2438e12b60c5 100644
--- a/arch/arm64/include/asm/el2_setup.h
+++ b/arch/arm64/include/asm/el2_setup.h
@@ -59,7 +59,10 @@
 
 .macro __init_el2_debug
 	mrs	x1, id_aa64dfr0_el1
-	sbfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	ubfx	x0, x1, #ID_AA64DFR0_EL1_PMUVer_SHIFT, #4
+	cmp	x0, #ID_AA64DFR0_EL1_PMUVer_IMP_DEF
+	csel	x0, xzr, x0, eq			// If PMU's IMP_DEF, regard it
+						// as not implemented and skip
 	cmp	x0, #1
 	b.lt	.Lskip_pmu_\@			// Skip if no PMU present
 	mrs	x0, pmcr_el0			// Disable debug access traps
-- 
2.24.0


