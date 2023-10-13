Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C3697C7BB0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 04:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjJMCo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 22:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjJMCo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 22:44:27 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18E8083
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 19:44:25 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 267A611FB;
        Thu, 12 Oct 2023 19:45:05 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 52BE93F7A6;
        Thu, 12 Oct 2023 19:44:22 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, James Clark <james.clark@arm.com>
Subject: [PATCH V2] drivers: perf: arm_pmuv3: Read PMMIR_EL1 unconditionally
Date:   Fri, 13 Oct 2023 08:13:54 +0530
Message-Id: <20231013024354.1289070-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the PMUv3 driver only reads PMMIR_EL1 if the PMU implements
FEAT_PMUv3p4 and the STALL_SLOT event, but the check for STALL_SLOT event
isn't necessary and can be removed.

The check for STALL_SLOT event was introduced with the read of PMMIR_EL1 in
commit f5be3a61fdb5dd11 ("arm64: perf: Add support caps under sysfs")

When this logic was written, the ARM ARM said:

| If STALL_SLOT is not implemented, it is IMPLEMENTATION DEFINED whether
| the PMMIR System registers are implemented.

... and thus the driver had to check for STALL_SLOT event to verify that
PMMIR_EL1 was implemented and accesses to PMMIR_EL1 would not be UNDEFINED.

Subsequently, the architecture was retrospectively tightened to require
that any FEAT_PMUv3p4 implementation implements PMMIR_EL1. Since the G.b
release of the ARM ARM, the wording regarding STALL_SLOT event has been
removed, and the description of PMMIR_EL1 says:

| This register is present only when FEAT_PMUv3p4 is implemented.

Drop the unnecessary check for STALL_SLOT event when reading PMMIR_EL1.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
This applies on v6.6-rc5

Changes in V2:

- Updated commit message to include previous context about STALL_SLOT check

Changes in V1:

https://lore.kernel.org/all/20231009075631.193208-1-anshuman.khandual@arm.com/

 drivers/perf/arm_pmuv3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/arm_pmuv3.c b/drivers/perf/arm_pmuv3.c
index 144593092727..92fefc1bc7f6 100644
--- a/drivers/perf/arm_pmuv3.c
+++ b/drivers/perf/arm_pmuv3.c
@@ -1126,7 +1126,7 @@ static void __armv8pmu_probe_pmu(void *info)
 			     pmceid, ARMV8_PMUV3_MAX_COMMON_EVENTS);
 
 	/* store PMMIR register for sysfs */
-	if (is_pmuv3p4(pmuver) && (pmceid_raw[1] & BIT(31)))
+	if (is_pmuv3p4(pmuver))
 		cpu_pmu->reg_pmmir = read_pmmir();
 	else
 		cpu_pmu->reg_pmmir = 0;
-- 
2.25.1

