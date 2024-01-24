Return-Path: <linux-kernel+bounces-36802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B084783A6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AAD628E426
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE2C18627;
	Wed, 24 Jan 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="SaW/7DRX"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1415EB0
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 10:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706092735; cv=none; b=flI/0I2M25bw/g3NmMMzZOdwI2lIyYOFYUW1IHKZGdFHYGDLOu9bu1CeBgClvHDtd6k8wtIsEUPtXK86PbOCniAG6sJP5haDDezhPd3Wo3y/wL9CS8smdYQVfboNXc1usZLNced6tFqE/IwltmH1e/NI/jMfmPD0dQOUULYIPgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706092735; c=relaxed/simple;
	bh=hRK3Ghni/2xQovMkagRkxRaEHsmob4cVksHfnDrX0mI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pqWsbVXNAqhRxiDxxm68xTsucb3AZiObPlsEVuBhzHCJP41b0oCIjF1K5X9dl1R7sxW7/RinONX0/+V+VLJ1WRoBnnvy73TROiOPFpyP+qbAuavzYQ2zGIDDzsuP5JpUSBPCyvg2DMk0k0KnR8In8ugn4qu9o+WdNMtP6LSdELY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=SaW/7DRX; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1706092732; x=1737628732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZHAby7cD7PMq0P+q1/GjggviwD+0cQAXXFSp7X8XpCU=;
  b=SaW/7DRX6guI1BPm3ffOw0jvu4zAc8jMRzdyGstiwvkv46LzyPzMe1Pq
   3tZFglK+nys1cO/ansa8RJ722wa5pRue9kljo5IZpgHL4FFUPw+zDpcNB
   YLBlSOzCTov43YXPpk8DM40Q9KHP44hIxtZBPITDDnA88emdiHNeHFypi
   qSyDgMpZNTx9kq9+6kZi3yurKlM6XvD11At+y3tLaNfR5qRVgu/1WBb1Q
   b82lToJfR6Uf2OfOaebpFc5htr2NY8PzUxL5Td3x3uQuOEuAt/4gUdBtC
   lLoHEPiMp0HAggLWI1fB+xlwoKuJFfoGnxOJvXufc14nGD8YHM6gx2an1
   Q==;
X-IronPort-AV: E=Sophos;i="6.05,216,1701126000"; 
   d="scan'208";a="35052514"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 24 Jan 2024 11:38:49 +0100
Received: from schifferm-ubuntu.tq-net.de (SCHIFFERM-M3.tq-net.de [10.121.49.135])
	by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 159E2280075;
	Wed, 24 Jan 2024 11:38:49 +0100 (CET)
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Nicholas Piggin <npiggin@gmail.com>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH v2] powerpc/6xx: set High BAT Enable flag on G2_LE cores
Date: Wed, 24 Jan 2024 11:38:38 +0100
Message-ID: <20240124103838.43675-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MMU_FTR_USE_HIGH_BATS is set for G2_LE cores and derivatives like e300cX,
but the high BATs need to be enabled in HID2 to work. Add register
definitions and add the needed setup to __setup_cpu_603.

This fixes boot on CPUs like the MPC5200B with STRICT_KERNEL_RWX enabled
on systems where the flag has not been set by the bootloader already.

Fixes: e4d6654ebe6e ("powerpc/mm/32s: rework mmu_mapin_ram()")
Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
---

v2:
- Use the G2_LE name for cores that have this HID2 register
- Extend __setup_cpu_603 instead of introducing a new setup function


 arch/powerpc/include/asm/reg.h      |  2 ++
 arch/powerpc/kernel/cpu_setup_6xx.S | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 4ae4ab9090a2..ade5f094dbd2 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -617,6 +617,8 @@
 #endif
 #define SPRN_HID2	0x3F8		/* Hardware Implementation Register 2 */
 #define SPRN_HID2_GEKKO	0x398		/* Gekko HID2 Register */
+#define SPRN_HID2_G2_LE	0x3F3		/* G2_LE HID2 Register */
+#define  HID2_G2_LE_HBE	(1<<18)		/* High BAT Enable (G2_LE) */
 #define SPRN_IABR	0x3F2	/* Instruction Address Breakpoint Register */
 #define SPRN_IABR2	0x3FA		/* 83xx */
 #define SPRN_IBCR	0x135		/* 83xx Insn Breakpoint Control Reg */
diff --git a/arch/powerpc/kernel/cpu_setup_6xx.S b/arch/powerpc/kernel/cpu_setup_6xx.S
index f29ce3dd6140..bfd3f442e5eb 100644
--- a/arch/powerpc/kernel/cpu_setup_6xx.S
+++ b/arch/powerpc/kernel/cpu_setup_6xx.S
@@ -26,6 +26,15 @@ BEGIN_FTR_SECTION
 	bl	__init_fpu_registers
 END_FTR_SECTION_IFCLR(CPU_FTR_FPU_UNAVAILABLE)
 	bl	setup_common_caches
+
+	/*
+	 * This assumes that all cores using __setup_cpu_603 with
+	 * MMU_FTR_USE_HIGH_BATS are G2_LE compatible
+	 */
+BEGIN_MMU_FTR_SECTION
+	bl      setup_g2_le_hid2
+END_MMU_FTR_SECTION_IFSET(MMU_FTR_USE_HIGH_BATS)
+
 	mtlr	r5
 	blr
 _GLOBAL(__setup_cpu_604)
@@ -115,6 +124,16 @@ SYM_FUNC_START_LOCAL(setup_604_hid0)
 	blr
 SYM_FUNC_END(setup_604_hid0)
 
+/* Enable high BATs for G2_LE and derivatives like e300cX */
+SYM_FUNC_START_LOCAL(setup_g2_le_hid2)
+	mfspr	r11,SPRN_HID2_G2_LE
+	oris	r11,r11,HID2_G2_LE_HBE@h
+	mtspr	SPRN_HID2_G2_LE,r11
+	sync
+	isync
+	blr
+SYM_FUNC_END(setup_g2_le_hid2)
+
 /* 7400 <= rev 2.7 and 7410 rev = 1.0 suffer from some
  * erratas we work around here.
  * Moto MPC710CE.pdf describes them, those are errata
@@ -495,4 +514,3 @@ _GLOBAL(__restore_cpu_setup)
 	mtcr	r7
 	blr
 _ASM_NOKPROBE_SYMBOL(__restore_cpu_setup)
-
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/


