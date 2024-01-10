Return-Path: <linux-kernel+bounces-22537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA1829F2F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 134D11C217A6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 663534D11D;
	Wed, 10 Jan 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jqsKVvY6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B468C4D107
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 17:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221ACC43399;
	Wed, 10 Jan 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704907791;
	bh=7wbCjMM7tjumNzK49XR6Y/BSBSyJJnYiOaEyOvr+9gs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jqsKVvY6TAox8wLuIntNXB+DGU9AJBF/cBVBK9ErMZqAggEfYeZKFW5jQ2BLMU3QH
	 9LicJocbmgS90Jtww5IXQWt7iUmEnDQJIQul2uKxgNNXO3T3Ikl1/wf5t7RAlA4JfA
	 4ZORrA9D6xj5cd+0r9HwNdQtRkiYwNblmg+W50AJ29aFG5Yr11DNbnFQaI9VQfKr2r
	 TiSCnURh8Tdur0KavaCN7Q5AIvo117S9/OHOHc518dPhKlrVLroZX5d1SBJ/vyLOB4
	 +Ocu5ah2Qtr5Uek7bltuR6mjBFhbXL1mBwH95GKUL4yrfOAM381dygWRlY9ljpwaLB
	 F1iYvqYzg4wlg==
Received: (nullmailer pid 2134037 invoked by uid 1000);
	Wed, 10 Jan 2024 17:29:48 -0000
From: Rob Herring <robh@kernel.org>
Date: Wed, 10 Jan 2024 11:29:20 -0600
Subject: [PATCH 1/2] arm64: Rename ARM64_WORKAROUND_2966298
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240110-arm-errata-a510-v1-1-d02bc51aeeee@kernel.org>
References: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
In-Reply-To: <20240110-arm-errata-a510-v1-0-d02bc51aeeee@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev

In preparation to apply ARM64_WORKAROUND_2966298 for multiple errata,
rename the kconfig and capability. No functional change.

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/Kconfig             | 4 ++++
 arch/arm64/kernel/cpu_errata.c | 4 ++--
 arch/arm64/kernel/entry.S      | 2 +-
 arch/arm64/tools/cpucaps       | 2 +-
 4 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 7b071a00425d..ba9f6ceddbbe 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1037,8 +1037,12 @@ config ARM64_ERRATUM_2645198
 
 	  If unsure, say Y.
 
+config ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
+	bool
+
 config ARM64_ERRATUM_2966298
 	bool "Cortex-A520: 2966298: workaround for speculatively executed unprivileged load"
+	select ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	default y
 	help
 	  This option adds the workaround for ARM Cortex-A520 erratum 2966298.
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index e29e0fea63fb..cb5e0622168d 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -713,10 +713,10 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
 	},
 #endif
-#ifdef CONFIG_ARM64_ERRATUM_2966298
+#ifdef CONFIG_ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	{
 		.desc = "ARM erratum 2966298",
-		.capability = ARM64_WORKAROUND_2966298,
+		.capability = ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD,
 		/* Cortex-A520 r0p0 - r0p1 */
 		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
 	},
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index a6030913cd58..544ab46649f3 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -428,7 +428,7 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
-alternative_if ARM64_WORKAROUND_2966298
+alternative_if ARM64_WORKAROUND_SPECULATIVE_UNPRIV_LOAD
 	tlbi	vale1, xzr
 	dsb	nsh
 alternative_else_nop_endif
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index b98c38288a9d..3781ad1d0b26 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -84,7 +84,6 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
-WORKAROUND_2966298
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
@@ -100,3 +99,4 @@ WORKAROUND_NVIDIA_CARMEL_CNP
 WORKAROUND_QCOM_FALKOR_E1003
 WORKAROUND_REPEAT_TLBI
 WORKAROUND_SPECULATIVE_AT
+WORKAROUND_SPECULATIVE_UNPRIV_LOAD

-- 
2.43.0


