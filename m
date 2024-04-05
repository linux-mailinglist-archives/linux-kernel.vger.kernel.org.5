Return-Path: <linux-kernel+bounces-132619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8EF899762
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 10:01:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFB3AB212A5
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929111448E2;
	Fri,  5 Apr 2024 08:00:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEBF2143C64
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 08:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712304025; cv=none; b=QG0b/IpZlYZK+epesuoYjcuDY6f+sQgoKuAFPnkexq517o12QZ7K2PuqJHLwawax9/xHwFujPED+xmpV/GmzX21vC9r2KRecZdO9hbgHDUVaIp2aEAxPibCSK+O0M3fyfQEhBc6Ix5Pgfg1OblZUXOlWbOPNUYMJdTC4KQM+LDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712304025; c=relaxed/simple;
	bh=k9DsP+wTogXiq02Ur9V/CNgu2qs7Sc4qPL+MpAclWYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OgiL1iG9bokPdy578LSYwjRGH+fxpaIukWlbjf5W+xNHaKGiKXRUv4e4XY/vEg2PP5Yd0ZyxB8POoP4hjHQ58K1R+68VAwgXCSmOargNd3rSKnl33JzB3A7b5SE6zWETwFuBPgH84XfG6/GX5Z/V8G9VBIxloaEWUe+glURKrp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B30041007;
	Fri,  5 Apr 2024 01:00:53 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.6])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id EA6C63F64C;
	Fri,  5 Apr 2024 01:00:18 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [RFC 1/8] arm64/sysreg: Add register fields for MDSELR_EL1
Date: Fri,  5 Apr 2024 13:30:01 +0530
Message-Id: <20240405080008.1225223-2-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240405080008.1225223-1-anshuman.khandual@arm.com>
References: <20240405080008.1225223-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds register fields for MDSELR_EL1 as per the definitions based
on DDI0601 2023-12.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Brown <broonie@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/tools/sysreg | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index a4c1dd4741a4..4c58fd7a70e6 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -93,6 +93,17 @@ Res0	63:32
 Field	31:0	DTRTX
 EndSysreg
 
+Sysreg	MDSELR_EL1	2	0	0	4	2
+Res0	63:6
+Enum	5:4	BANK
+	0b00	BANK_0
+	0b01	BANK_1
+	0b10	BANK_2
+	0b11	BANK_3
+EndEnum
+Res0	3:0
+EndSysreg
+
 Sysreg	OSECCR_EL1	2	0	0	6	2
 Res0	63:32
 Field	31:0	EDECCR
-- 
2.25.1


