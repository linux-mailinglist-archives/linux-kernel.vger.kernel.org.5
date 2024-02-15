Return-Path: <linux-kernel+bounces-66342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 783EE855AC7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:55:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 296EA1F26742
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE87C15B;
	Thu, 15 Feb 2024 06:55:09 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC31CBA37
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707980108; cv=none; b=BDvWEQ2YhFmuFtHhpkKCgLzTyufV5O6DDOim/zHkOBqVqZGWLDWAMy+3PvkVx564XZ/U2sNECW48f/RjARESNiFGunNUguxCX2aULLRUKEQSx7GenS3ww9QSjGXB2A5LUncsrmwt7ZTVefxvE/EXHEhG9uZHU6R4COgxUgSzBlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707980108; c=relaxed/simple;
	bh=6ucnK+KnANvJK6sHQYtLI7YIxqDUoKlAb9AmMiKb4JI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=q1+UqDONK0CIf1ORgvXwHzGo0a3infoLInrZVHKt5iD5VvIMJ9BcIAq6n5rbM2f/kDwvRXByuht8cAIYLeqCZtcrfU5DjPhNi1dsSqf6LJQ+97Kl0+LOtDFprzvV1n9bDDQqlOIaWVWB6GTwQomWK5K1FDFKkRBjF8a9yel8Z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD5E51FB;
	Wed, 14 Feb 2024 22:55:46 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.45.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id BF1C03F766;
	Wed, 14 Feb 2024 22:55:03 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/sysreg: Add register fields for ID_AA64DFR1_EL1
Date: Thu, 15 Feb 2024 12:24:54 +0530
Message-Id: <20240215065454.2489075-1-anshuman.khandual@arm.com>
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
 arch/arm64/tools/sysreg | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index 94692abfeeb9..1cd06edfad3b 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -1253,7 +1253,33 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64DFR1_EL1	3	0	0	5	1
-Res0	63:0
+Field	63:56	ABL_CMPs
+Field	55:52	DPFZS
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


