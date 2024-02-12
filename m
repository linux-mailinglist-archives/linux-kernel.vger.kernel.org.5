Return-Path: <linux-kernel+bounces-62539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B29585228C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCDA6281F92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A957451013;
	Mon, 12 Feb 2024 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AfVRxsxg"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972A51025;
	Mon, 12 Feb 2024 23:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707780568; cv=none; b=OGQjw4qryNziBYN4L1lkp3ogG/zPe3nNWX/y4KlPLZw2aKVKKaZmEftSPdPXpBmdBXxiVFiGldrn+EKyM+0HDVXSiLzqyQAtE+CvffYNqRvgw+eza13Tm0UNZ5hy8uNp47SsGbey5C11dTecXM3MQgkduKE8YHPNoDuYhlCRfWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707780568; c=relaxed/simple;
	bh=OlgJwJR7mtndOUI3dB214bznUl48qyp1IY7QPUcT5Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IIJXXZ4KDtInlVwt8wcR2dkD03FdFC3M09oWwFd0XqrEuubWrpsXNfppWY1FWD9t2MDemCciPSYE33SA7TSbY1ywbH8GrZexV6n0Wh2wm71zCmd1xQ5IAcr7V9HgpWFcmnHQUQMGwETwIBADtThaKbbXlzdhJZtSd+OuoccevZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AfVRxsxg; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from rrs24-12-35.corp.microsoft.com (unknown [131.107.147.51])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEC5820B2000;
	Mon, 12 Feb 2024 15:29:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEC5820B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1707780560;
	bh=Pus6ekEvBcHFMFdVrX0AsPS3od4PAAyDna4mLnwpX+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=AfVRxsxgLeTe1ATfXx56hbI3QdfOzJ9ZaAwqBnlz0dHepD9AubTSUK7z3ItCvmWa0
	 SOOPHJvKz7qQRrnuC+e/b9fdEtR3EnJTlkOvK5o+vhYlnw7I6YJhatTDr/vr8j9yER
	 20Pkmjzl27tMdRaEimwmtYZ4TIQNvZRe8Ls75GFQ=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)),
	linux-doc@vger.kernel.org (open list:DOCUMENTATION),
	linux-kernel@vger.kernel.org (open list)
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: Subscribe Microsoft Azure Cobalt 100 to ARM Neoverse N2 errata
Date: Mon, 12 Feb 2024 23:29:06 +0000
Message-Id: <20240212232909.2276378-1-eahariha@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the MIDR value of Microsoft Azure Cobalt 100, which is a Microsoft
implemented CPU based on r0p0 of the ARM Neoverse N2 CPU, and therefore
suffers from all the same errata.

CC: Mark Rutland <mark.rutland@arm.com>
CC: Marc Zyngier <maz@kernel.org>
CC: Anshuman Khandual <anshuman.khandual@arm.com>
CC: stable@vger.kernel.org # 5.15+
Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 Documentation/arch/arm64/silicon-errata.rst | 7 +++++++
 arch/arm64/include/asm/cputype.h            | 4 ++++
 arch/arm64/kernel/cpu_errata.c              | 3 +++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index e8c2ce1f9df6..45a7f4932fe0 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -243,3 +243,10 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ASR            | ASR8601         | #8601001        | N/A                         |
 +----------------+-----------------+-----------------+-----------------------------+
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2139208        | ARM64_ERRATUM_2139208       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2067961        | ARM64_ERRATUM_2067961       |
++----------------+-----------------+-----------------+-----------------------------+
+| Microsoft      | Azure Cobalt 100| #2253138        | ARM64_ERRATUM_2253138       |
++----------------+-----------------+-----------------+-----------------------------+
diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 7c7493cb571f..a632a7514e55 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -61,6 +61,7 @@
 #define ARM_CPU_IMP_HISI		0x48
 #define ARM_CPU_IMP_APPLE		0x61
 #define ARM_CPU_IMP_AMPERE		0xC0
+#define ARM_CPU_IMP_MICROSOFT		0x6D
 
 #define ARM_CPU_PART_AEM_V8		0xD0F
 #define ARM_CPU_PART_FOUNDATION		0xD00
@@ -135,6 +136,8 @@
 
 #define AMPERE_CPU_PART_AMPERE1		0xAC3
 
+#define MSFT_CPU_PART_AZURE_COBALT_100	0xD49 /* Based on r0p0 of ARM Neoverse N2 */
+
 #define MIDR_CORTEX_A53 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A53)
 #define MIDR_CORTEX_A57 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A57)
 #define MIDR_CORTEX_A72 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A72)
@@ -193,6 +196,7 @@
 #define MIDR_APPLE_M2_BLIZZARD_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_BLIZZARD_MAX)
 #define MIDR_APPLE_M2_AVALANCHE_MAX MIDR_CPU_MODEL(ARM_CPU_IMP_APPLE, APPLE_CPU_PART_M2_AVALANCHE_MAX)
 #define MIDR_AMPERE1 MIDR_CPU_MODEL(ARM_CPU_IMP_AMPERE, AMPERE_CPU_PART_AMPERE1)
+#define MIDR_MICROSOFT_AZURE_COBALT_100 MIDR_CPU_MODEL(ARM_CPU_IMP_MICROSOFT, MSFT_CPU_PART_AZURE_COBALT_100)
 
 /* Fujitsu Erratum 010001 affects A64FX 1.0 and 1.1, (v0r0 and v1r0) */
 #define MIDR_FUJITSU_ERRATUM_010001		MIDR_FUJITSU_A64FX
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index 967c7c7a4e7d..76b8dd37092a 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -374,6 +374,7 @@ static const struct midr_range erratum_1463225[] = {
 static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2139208
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2119858
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -387,6 +388,7 @@ static const struct midr_range trbe_overwrite_fill_mode_cpus[] = {
 static const struct midr_range tsb_flush_fail_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2067961
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2054223
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
@@ -399,6 +401,7 @@ static const struct midr_range tsb_flush_fail_cpus[] = {
 static struct midr_range trbe_write_out_of_range_cpus[] = {
 #ifdef CONFIG_ARM64_ERRATUM_2253138
 	MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N2),
+	MIDR_ALL_VERSIONS(MIDR_MICROSOFT_AZURE_COBALT_100),
 #endif
 #ifdef CONFIG_ARM64_ERRATUM_2224489
 	MIDR_ALL_VERSIONS(MIDR_CORTEX_A710),
-- 
2.34.1


