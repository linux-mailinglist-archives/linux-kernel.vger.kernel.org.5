Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F8F7A9DFC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjIUTwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjIUTvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:51:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944AC6FEBB;
        Thu, 21 Sep 2023 12:42:35 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88870C433C8;
        Thu, 21 Sep 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695325355;
        bh=bObmmHWvGoY13yIgsUgxwWw+0bq9aSwE6jDnMp+s9X0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=s6mMtEmf/1QACJ7KcK+VEfYpibLW3rn9Aplu/8Gg5tI2fuweHgKfqjrtH4Ip+pPl0
         g1otlco2Ve1kuDAbSQODDOxRR/U+rBqKb/FFuyn6400zLqPIUCtSVQ9iIl2S97QfjV
         c5RVYN8jCVaDzqtIW9EHsjoVxkc/T8JP9eo28lvTYlGXx4lRxPA8O+N7SOkIa2g4PY
         4JGwPbe5NGOO5AV9OJPxeKIHtb66hyRZmgSvdMpbg5A36RbCf+LwMTrWr0FQC9bTpE
         p7x26p+S4LOdIxueXlGyERZOdnjTemrkXD54tpInfuaOri77vCzByl9TdIy8dsb2zt
         N4dC6aJCemnOg==
Received: (nullmailer pid 1050817 invoked by uid 1000);
        Thu, 21 Sep 2023 19:42:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: errata: Add Cortex-A520 speculative unprivileged load workaround
Date:   Thu, 21 Sep 2023 14:41:52 -0500
Message-Id: <20230921194156.1050055-2-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230921194156.1050055-1-robh@kernel.org>
References: <20230921194156.1050055-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the workaround for ARM Cortex-A520 erratum 2966298. On an
affected Cortex-A520 core, a speculatively executed unprivileged load
might leak data from a privileged load via a cache side channel. The
issue only exists for loads within a translation regime with the same
translation (e.g. same ASID and VMID). Therefore, the issue only affects
the return to EL0.

The workaround is to execute a TLBI before returning to EL0 after all
loads of privileged data. A non-shareable TLBI to any address is
sufficient.

The workaround isn't necessary if page table isolation (KPTI) is
enabled, but for simplicity it will be. Page table isolation should
normally be disabled for Cortex-A520 as it supports the CSV3 feature
and the E0PD feature (used when KASLR is enabled).

Cc: stable@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
v2:
- Add more details on conditions necessary for the errata to occur.
---
 Documentation/arch/arm64/silicon-errata.rst |  2 ++
 arch/arm64/Kconfig                          | 13 +++++++++++++
 arch/arm64/kernel/cpu_errata.c              |  8 ++++++++
 arch/arm64/kernel/entry.S                   |  4 ++++
 arch/arm64/tools/cpucaps                    |  1 +
 5 files changed, 28 insertions(+)

diff --git a/Documentation/arch/arm64/silicon-errata.rst b/Documentation/arch/arm64/silicon-errata.rst
index e96f057ea2a0..f47f63bcf67c 100644
--- a/Documentation/arch/arm64/silicon-errata.rst
+++ b/Documentation/arch/arm64/silicon-errata.rst
@@ -71,6 +71,8 @@ stable kernels.
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A510     | #2658417        | ARM64_ERRATUM_2658417       |
 +----------------+-----------------+-----------------+-----------------------------+
+| ARM            | Cortex-A520     | #2966298        | ARM64_ERRATUM_2966298       |
++----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #826319         | ARM64_ERRATUM_826319        |
 +----------------+-----------------+-----------------+-----------------------------+
 | ARM            | Cortex-A53      | #827319         | ARM64_ERRATUM_827319        |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b10515c0200b..78f20e632712 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1037,6 +1037,19 @@ config ARM64_ERRATUM_2645198
 
 	  If unsure, say Y.
 
+config ARM64_ERRATUM_2966298
+	bool "Cortex-A520: 2966298: workaround for speculatively executed unprivileged load"
+	default y
+	help
+	  This option adds the workaround for ARM Cortex-A520 erratum 2966298.
+
+	  On an affected Cortex-A520 core, a speculatively executed unprivileged
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
index be66e94a21bd..5706e74c5578 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -730,6 +730,14 @@ const struct arm64_cpu_capabilities arm64_errata[] = {
 		.cpu_enable = cpu_clear_bf16_from_user_emulation,
 	},
 #endif
+#ifdef CONFIG_ARM64_ERRATUM_2966298
+	{
+		.desc = "ARM erratum 2966298",
+		.capability = ARM64_WORKAROUND_2966298,
+		/* Cortex-A520 r0p0 - r0p1 */
+		ERRATA_MIDR_REV_RANGE(MIDR_CORTEX_A520, 0, 0, 1),
+	},
+#endif
 #ifdef CONFIG_AMPERE_ERRATUM_AC03_CPU_38
 	{
 		.desc = "AmpereOne erratum AC03_CPU_38",
diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index 6ad61de03d0a..a6030913cd58 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -428,6 +428,10 @@ alternative_else_nop_endif
 	ldp	x28, x29, [sp, #16 * 14]
 
 	.if	\el == 0
+alternative_if ARM64_WORKAROUND_2966298
+	tlbi	vale1, xzr
+	dsb	nsh
+alternative_else_nop_endif
 alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
 	ldr	lr, [sp, #S_LR]
 	add	sp, sp, #PT_REGS_SIZE		// restore sp
diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
index c3f06fdef609..dea3dc89234b 100644
--- a/arch/arm64/tools/cpucaps
+++ b/arch/arm64/tools/cpucaps
@@ -84,6 +84,7 @@ WORKAROUND_2077057
 WORKAROUND_2457168
 WORKAROUND_2645198
 WORKAROUND_2658417
+WORKAROUND_2966298
 WORKAROUND_AMPERE_AC03_CPU_38
 WORKAROUND_TRBE_OVERWRITE_FILL_MODE
 WORKAROUND_TSB_FLUSH_FAILURE
-- 
2.40.1

