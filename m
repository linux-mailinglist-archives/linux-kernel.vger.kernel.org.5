Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4D7BFEE5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 16:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjJJOQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 10:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjJJOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 10:16:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFEA0A9;
        Tue, 10 Oct 2023 07:16:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29D20C15;
        Tue, 10 Oct 2023 07:17:00 -0700 (PDT)
Received: from localhost.localdomain (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3C763F762;
        Tue, 10 Oct 2023 07:16:16 -0700 (PDT)
From:   James Clark <james.clark@arm.com>
To:     linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, suzuki.poulose@arm.com
Cc:     James Clark <james.clark@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Russell King <linux@armlinux.org.uk>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Zaid Al-Bassam <zalbassam@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev
Subject: [PATCH v3 1/3] arm: perf: Include threshold control fields valid in PMEVTYPER mask
Date:   Tue, 10 Oct 2023 15:15:41 +0100
Message-Id: <20231010141551.2262059-2-james.clark@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010141551.2262059-1-james.clark@arm.com>
References: <20231010141551.2262059-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FEAT_PMUv3_TH (Armv8.8) adds two new fields to PMEVTYPER, so include
them in the mask. These aren't writable on 32 bit kernels as they are in
the high part of the register, so split the mask definition to the asm
files for each platform.

Now where the value is used in some parts of KVM, include the asm file.
There is no impact on guest PMUs emulated with KVM because the new
fields are ignored when constructing the attributes for opening the
event. But if threshold support is added to KVM at a later time no
change to the mask will be needed.

Despite not being used on aarch32, TH and TC macros are added to the
shared header file, because they are used in arm_pmuv3.c which is
compiled for both platforms.

Signed-off-by: James Clark <james.clark@arm.com>
---
 arch/arm/include/asm/arm_pmuv3.h   | 3 +++
 arch/arm64/include/asm/arm_pmuv3.h | 4 ++++
 arch/arm64/kvm/pmu-emul.c          | 1 +
 arch/arm64/kvm/sys_regs.c          | 1 +
 include/linux/perf/arm_pmuv3.h     | 3 ++-
 5 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm/include/asm/arm_pmuv3.h b/arch/arm/include/asm/arm_pmuv3.h
index 72529f5e2bed..491310133d09 100644
--- a/arch/arm/include/asm/arm_pmuv3.h
+++ b/arch/arm/include/asm/arm_pmuv3.h
@@ -9,6 +9,9 @@
 #include <asm/cp15.h>
 #include <asm/cputype.h>
 
+/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff
+
 #define PMCCNTR			__ACCESS_CP15_64(0, c9)
 
 #define PMCR			__ACCESS_CP15(c9,  0, c12, 0)
diff --git a/arch/arm64/include/asm/arm_pmuv3.h b/arch/arm64/include/asm/arm_pmuv3.h
index 18dc2fb3d7b7..4faf4f7385a5 100644
--- a/arch/arm64/include/asm/arm_pmuv3.h
+++ b/arch/arm64/include/asm/arm_pmuv3.h
@@ -11,6 +11,10 @@
 #include <asm/cpufeature.h>
 #include <asm/sysreg.h>
 
+/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_MASK	(0xc800ffffUL | ARMV8_PMU_EVTYPE_TH | \
+				ARMV8_PMU_EVTYPE_TC)
+
 #define RETURN_READ_PMEVCNTRN(n) \
 	return read_sysreg(pmevcntr##n##_el0)
 static inline unsigned long read_pmevcntrn(int n)
diff --git a/arch/arm64/kvm/pmu-emul.c b/arch/arm64/kvm/pmu-emul.c
index 6b066e04dc5d..0666212c0c15 100644
--- a/arch/arm64/kvm/pmu-emul.c
+++ b/arch/arm64/kvm/pmu-emul.c
@@ -11,6 +11,7 @@
 #include <linux/perf_event.h>
 #include <linux/perf/arm_pmu.h>
 #include <linux/uaccess.h>
+#include <asm/arm_pmuv3.h>
 #include <asm/kvm_emulate.h>
 #include <kvm/arm_pmu.h>
 #include <kvm/arm_vgic.h>
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index e92ec810d449..d0e11e684f07 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -17,6 +17,7 @@
 #include <linux/printk.h>
 #include <linux/uaccess.h>
 
+#include <asm/arm_pmuv3.h>
 #include <asm/cacheflush.h>
 #include <asm/cputype.h>
 #include <asm/debug-monitors.h>
diff --git a/include/linux/perf/arm_pmuv3.h b/include/linux/perf/arm_pmuv3.h
index e3899bd77f5c..ec3a01502e7c 100644
--- a/include/linux/perf/arm_pmuv3.h
+++ b/include/linux/perf/arm_pmuv3.h
@@ -228,7 +228,8 @@
 /*
  * PMXEVTYPER: Event selection reg
  */
-#define ARMV8_PMU_EVTYPE_MASK	0xc800ffff	/* Mask for writable bits */
+#define ARMV8_PMU_EVTYPE_TH	GENMASK(43, 32)
+#define ARMV8_PMU_EVTYPE_TC	GENMASK(63, 61)
 #define ARMV8_PMU_EVTYPE_EVENT	0xffff		/* Mask for EVENT bits */
 
 /*
-- 
2.34.1

