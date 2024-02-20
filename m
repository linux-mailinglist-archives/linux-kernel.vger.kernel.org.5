Return-Path: <linux-kernel+bounces-72218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FC785B0E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 03:32:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A881C21CC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2236B22618;
	Tue, 20 Feb 2024 02:32:17 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A391C2E
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708396336; cv=none; b=XcYwjNUGNxgEE5NAErYjthpHiQ13b9WB4ZECdGv7Nm4U3QdqFwZzzDU4dGzElhXriKJmcTWKZjmYCyBRpO8EU/ZT5l4hGkKQZ/tzsD+HFlV63khCB43AZPQ96Pds4jj5wiBXix5Urfu6Bb8yn0DUA1a1uBKaCvsxEqcYwpKbBa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708396336; c=relaxed/simple;
	bh=7l0KOIoY4Yi6fIjPsjvA6brSgh7MGw5p9m1W6eT8ziE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZAHfZneg09HGso7cmfi2CYi/ts0tXCGsrmQ8w7R3hmleSaJRG2dI+LAcb1tZAi7hewPSNZ3qT5ZQnFGhdiEa2OGB+M8dU5vPxvzgLHUUShdGP2Mbf6ATSPt63JReRB3EM92Vd7GfEH398xj5JBiFKdqudurS1j7vHSnerSkobzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A3B0FEC;
	Mon, 19 Feb 2024 18:32:52 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E8FEB3F766;
	Mon, 19 Feb 2024 18:32:10 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Date: Tue, 20 Feb 2024 08:02:03 +0530
Message-Id: <20240220023203.3091229-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for ID_AA64DFR1_EL1 as per the definitions based
on DDI0601 2023-12.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

Changes in V2:

- Added enumerated values for DPFZS field per Mark

Changes in V1:

https://lore.kernel.org/all/20240215065454.2489075-1-anshuman.khandual@arm.com/

 arch/arm64/tools/sysreg | 31 ++++++++++++++++++++++++++++++-
 1 file changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 4c9b67934367..dd693f992832 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1251,7 +1251,36 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64DFR1_EL1	3	0	0	5	1
-Res0	63:0
+Field	63:56	ABL_CMPs
+UnsignedEnum	55:52	DPFZS
+	0b0000	IGNR
+	0b0001	FRZN
+EndEnum
+UnsignedEnum	51:48	EBEP
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	47:44	ITE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	43:40	ABLE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	39:36	PMICNTR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	35:32	SPMU
+	0b0000	NI
+	0b0001	IMP
+	0b0010	IMP_SPMZR
+EndEnum
+Field	31:24	CTX_CMPs
+Field	23:16	WRPs
+Field	15:8	BRPs
+Field	7:0	SYSPMUID
 EndSysreg
 
 Sysreg	ID_AA64AFR0_EL1	3	0	0	5	4
-- 
2.25.1


