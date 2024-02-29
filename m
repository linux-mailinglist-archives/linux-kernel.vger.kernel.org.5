Return-Path: <linux-kernel+bounces-86297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A1D86C391
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E75728710D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407A950A67;
	Thu, 29 Feb 2024 08:34:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B875025C
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 08:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709195684; cv=none; b=bP/hbScbOp1nx/CuaNzs0+PZmZ0fuEKckXrONvz0W8TXb+EWOMqNtIvvawMMnN8zp+ftMRhLxJ8uJeAl3FTQJqNmUKAOtLzaGq6Eu+TA04K3TsuxYC8bIGIPIDN9+JGeTSWwO48Z25WSenU21wPVfUFXybnUD5WJyjT9THkd/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709195684; c=relaxed/simple;
	bh=dAYAj7SZmUmbdaksmAoUcV11I0Mcv8AU0oakyneZ/M0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a0pQzCA3KuJU73hvr3jyfdc5c6lGbmdd1lC5dEPeZUbVBGSSSMBEErDXg6lGNM4VwSgNBEULj58qpOn/ZybDbuZTPxSJRpPYWAJICX6Jp+Hqq+C0in8wva9ZtnixXgra06uDQxIfXzFUszuYzLjZZ5rFHJX1PIrqHaomsXIvH5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 686681FB;
	Thu, 29 Feb 2024 00:35:19 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.47.238])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 005BF3F6C4;
	Thu, 29 Feb 2024 00:34:37 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	catalin.marinas@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH V2] arm64/hw_breakpoint: Directly use ESR_ELx_WNR for an watchpoint exception
Date: Thu, 29 Feb 2024 14:04:31 +0530
Message-Id: <20240229083431.356578-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Let's use existing ISS encoding for an watchpoint exception i.e ESR_ELx_WNR
This represents an instruction's either writing to or reading from a memory
location during an watchpoint exception. While here this drops non-standard
macro AARCH64_ESR_ACCESS_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

Changes in V2:

- Dropped new ISS encoding details ESR_ELx_WnR and ESR_ELx_WnR_SHIFT
- Directly used existing ESR_ELx_WNR per Catalin
- Updated the commit message as required

Changes in V1:

https://lore.kernel.org/all/20240223094615.3977323-1-anshuman.khandual@arm.com/ 

 arch/arm64/include/asm/hw_breakpoint.h | 1 -
 arch/arm64/kernel/hw_breakpoint.c      | 3 ++-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index 84055329cd8b..bd81cf17744a 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -59,7 +59,6 @@ static inline void decode_ctrl_reg(u32 reg,
 /* Watchpoints */
 #define ARM_BREAKPOINT_LOAD	1
 #define ARM_BREAKPOINT_STORE	2
-#define AARCH64_ESR_ACCESS_MASK	(1 << 6)
 
 /* Lengths */
 #define ARM_BREAKPOINT_LEN_1	0x1
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 35225632d70a..2f5755192c2b 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -21,6 +21,7 @@
 
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
+#include <asm/esr.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/cputype.h>
@@ -779,7 +780,7 @@ static int watchpoint_handler(unsigned long addr, unsigned long esr,
 		 * Check that the access type matches.
 		 * 0 => load, otherwise => store
 		 */
-		access = (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
+		access = (esr & ESR_ELx_WNR) ? HW_BREAKPOINT_W :
 			 HW_BREAKPOINT_R;
 		if (!(access & hw_breakpoint_type(wp)))
 			continue;
-- 
2.25.1


