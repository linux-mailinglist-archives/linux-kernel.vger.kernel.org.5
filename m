Return-Path: <linux-kernel+bounces-22538-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33B19829F31
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9BDB1F2921D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414924D587;
	Wed, 10 Jan 2024 17:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pT9o55Ok"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6E54D13A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:29:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D72C43390;
	Wed, 10 Jan 2024 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704907793;
	bh=AJZkoacuvTqj7CsGQGGZ0bokVfCXFoFKdeLY3g2raZw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pT9o55Ok/y+vgFZ3idR8CFkBTvazmrJG+4G4EkiZa6IXF2apa7hrpA1GKpvlC8fkF
	 c5dGuGIAr/Z3SAfRcuhmTZtGzOVnwPo3gMWYYt2WjBseiU2qdSE9rp2tZCAxzqtoPa
	 mMAIU4MGBDSmi60Clv3AF+ed2V3Xit0Dnpn/SFvoa0uT6XnGULjB6qpdKtSdtfCPp3
	 DJfht+a2Qe0g+Qej5h5UxM7YKcGaLdvNBKMWH0GIHn8LBzjf84fv3ujp7iq/KI2cMI
	 v7dDDYErSNds+Y6ApSeWdHihdBR3Q4MyM9aKxyERo+B5mZjlHar/QOJBfOpyJJJFOM
	 5xRBV3TH7LAPA==
Received: (nullmailer pid 2134039 invoked by uid 1000);
	Wed, 10 Jan 2024 17:29:48 -0000
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jan 2024 11:29:21 -0600
Subject: [PATCH 2/2] arm64: errata: Add Cortex-A510 speculative
 unprivileged load workaround
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-arm-errata-a510-v1-2-d02bc51aeeee@kernel.org>
References: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
In-Reply-To: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

Implement the workaround for ARM Cortex-A510 erratum 3117295. On an
affected Cortex-A510 core, a speculatively executed unprivileged load
might leak data from a privileged load via a cache side channel. The
issue only exists for loads within a translation regime with the same
translation (e.g. same ASID and VMID). Therefore, the issue only affects
the return to EL0.

The erratum and workaround are the same as ARM Cortex-A520 erratum
2966298, so reuse the existing workaround.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 14 ++++++++++++++
 arch/arm64/kernel/cpu_errata.c              | 17 +++++++++++++++--
 3 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index f47f63bcf67c..7acd64c61f50 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -71,6 +71,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A510     | #3117295        | ARM64_ERRATUM_3117295       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ba9f6ceddbbe..456e8680e16e 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1054,6 +1054,20 @@ config ARM64_ERRATUM_2966298
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_3117295
+	bool "Cortex-A510: 3117295: workaround for speculatively executed unprivileged load"
+	select ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A510 erratum 3117295.
+
+	  On an affected Cortex-A510 core, a speculatively executed unprivileged
+	  load might leak data from a privileged level via a cache side channel.
+
+	  Work around this problem by executing a TLBI before returning to EL0.
+
+	  If unsure, say Y.
+
 config CAVIUM_ERRATUM_22375
 	bool "Cavium erratum 22375, 24313"
 	default y
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index cb5e0622168d..8b69fa296470 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -416,6 +416,19 @@ static struct midr_range broken_aarch32_aes[] = {
 };
 #endif /* CONFIG_ARM64_WORKAROUND_TRBE_WRITE_OUT_OF_RANGE */
 
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+static const struct midr_range erratum_spec_unpriv_load_list[] = {
+#ifdef CONFIG_ARM64_ERRATUM_3117295
+	MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
+#endif
+#ifdef CONFIG_ARM64_ERRATUM_2966298
+	/* Cortex-A520 r0p0 to r0p1 */
+	MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+#endif
+	{},
+};
+#endif
+
 const struct arm64_cpu_capabilities arm64_errata[] = {
 #ifdef CONFIG_ARM64_WORKAROUND_CLEAN_CACHE
 	{
@@ -715,10 +728,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 #endif
 #ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	{
-		.desc = "ARM erratum 2966298",
+		.desc = "ARM erratum 2966298 and 3117295",
 		.capability = ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD,
 		/* Cortex-A520 r0p0 - r0p1 */
-		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+		ERRATA_MIDR_RANGE_LIST(erratum_spec_unpriv_load_list),
 	},
 #endif
 #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38

-- 
2.43.0


