Return-Path: <linux-kernel+bounces-78071-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 817B5860E98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A8C2283333
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F01E5DF0B;
	Fri, 23 Feb 2024 09:46:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99D0A5DF01
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 09:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681587; cv=none; b=VIZMnSZlpUP/eLERx7KRdYgxmOtxlVdyf8uByY3UQjP6AXbRItSlsoJSxCMKVHpsFsibQixYt7SPMq+37XhF4Pv+9z7VPl/955Ak4LT0XzTKKltoGFbaGvUnneI5ZoZxAnq1jrTwuLaoS2JSSoB+mRmF7/+oZonGRcvnWsHHGM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681587; c=relaxed/simple;
	bh=uowSVM2SjzNXmtHjgIgF2ExRHxtW4sAgUT7RZkJdK9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SXoLPmvMCdSfcnW1iz3br3NjhSM0wEVTfGxFhkDiuLKYfJc0CWxKqvyUts47eLoHpxABqweV9kCK7rwZ/5V9NeM9NZ1PaPIOCNbjUkp6iuB42eadmPnR5AhUfr66IQy6f8WCitRH6et4D0gKDr5D/X2ALbmnBBKbKtNHixNxaC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 240221596;
	Fri, 23 Feb 2024 01:47:02 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.46.223])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E9F2F3F766;
	Fri, 23 Feb 2024 01:46:20 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: broonie@kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] arm64/hw_breakpoint: Define an ISS code for watchpoint exception
Date: Fri, 23 Feb 2024 15:16:15 +0530
Message-Id: <20240223094615.3977323-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This defines a new ISS code macro i.e ESR_ELx_WnR for watchpoint exception.
This represents an instruction's either writing to or reading from a memory
location during an watchpoint exception, and also moves this macro into the
ESR header as required. This drops non-standard AARCH64_ESR_ACCESS_MASK.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.8-rc5

 arch/arm64/include/asm/esr.h           | 4 ++++
 arch/arm64/include/asm/hw_breakpoint.h | 1 -
 arch/arm64/kernel/hw_breakpoint.c      | 3 ++-
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index 353fe08546cf..6c0a0b77fd2c 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -143,6 +143,10 @@
 #define ESR_ELx_CM_SHIFT	(8)
 #define ESR_ELx_CM 		(UL(1) << ESR_ELx_CM_SHIFT)
 
+/* ISS field definitions for Watchpoint exception */
+#define ESR_ELx_WnR_SHIFT	(6)
+#define ESR_ELx_WnR		(UL(1) << ESR_ELx_WnR_SHIFT)
+
 /* ISS2 field definitions for Data Aborts */
 #define ESR_ELx_TnD_SHIFT	(10)
 #define ESR_ELx_TnD 		(UL(1) << ESR_ELx_TnD_SHIFT)
diff --git a/arch/arm64/include/asm/hw_breakpoint.h b/arch/arm64/include/asm/hw_breakpoint.h
index d67c02e53a4a..6e4862e3d238 100644
--- a/arch/arm64/include/asm/hw_breakpoint.h
+++ b/arch/arm64/include/asm/hw_breakpoint.h
@@ -67,7 +67,6 @@ static inline void decode_ctrl_reg(u32 reg,
 /* Watchpoints */
 #define ARM_BREAKPOINT_LOAD	1
 #define ARM_BREAKPOINT_STORE	2
-#define AARCH64_ESR_ACCESS_MASK	(1 << 6)
 
 /* Lengths */
 #define ARM_BREAKPOINT_LEN_1	0x1
diff --git a/arch/arm64/kernel/hw_breakpoint.c b/arch/arm64/kernel/hw_breakpoint.c
index 86bdb2d68732..a73364a18c69 100644
--- a/arch/arm64/kernel/hw_breakpoint.c
+++ b/arch/arm64/kernel/hw_breakpoint.c
@@ -21,6 +21,7 @@
 
 #include <asm/current.h>
 #include <asm/debug-monitors.h>
+#include <asm/esr.h>
 #include <asm/hw_breakpoint.h>
 #include <asm/traps.h>
 #include <asm/cputype.h>
@@ -792,7 +793,7 @@ static int watchpoint_handler(unsigned long addr, unsigned long esr,
 		 * Check that the access type matches.
 		 * 0 => load, otherwise => store
 		 */
-		access = (esr & AARCH64_ESR_ACCESS_MASK) ? HW_BREAKPOINT_W :
+		access = (esr & ESR_ELx_WnR) ? HW_BREAKPOINT_W :
 			 HW_BREAKPOINT_R;
 		if (!(access & hw_breakpoint_type(wp)))
 			continue;
-- 
2.25.1


