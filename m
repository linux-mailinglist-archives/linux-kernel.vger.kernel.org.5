Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE777C9EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 07:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjJPFZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 01:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbjJPFYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 01:24:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E493F3;
        Sun, 15 Oct 2023 22:24:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA122DA7;
        Sun, 15 Oct 2023 22:25:27 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E53193F762;
        Sun, 15 Oct 2023 22:24:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC 2/2] drivers: perf: arm_pmu: Drop 'pmu_lock' element from 'struct pmu_hw_events'
Date:   Mon, 16 Oct 2023 10:54:31 +0530
Message-Id: <20231016052431.1390269-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231016052431.1390269-1-anshuman.khandual@arm.com>
References: <20231016052431.1390269-1-anshuman.khandual@arm.com>
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

As 'pmu_lock' element is not being used in any ARM PMU implementation, just
drop this from 'struct pmu_hw_events'.

Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/perf/arm_pmu.c       | 1 -
 include/linux/perf/arm_pmu.h | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index d712a19e47ac..379479b50bdd 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -893,7 +893,6 @@ struct arm_pmu *armpmu_alloc(void)
 		struct pmu_hw_events *events;
 
 		events = per_cpu_ptr(pmu->hw_events, cpu);
-		raw_spin_lock_init(&events->pmu_lock);
 		events->percpu_pmu = pmu;
 	}
 
diff --git a/include/linux/perf/arm_pmu.h b/include/linux/perf/arm_pmu.h
index 143fbc10ecfe..e2503d48ddee 100644
--- a/include/linux/perf/arm_pmu.h
+++ b/include/linux/perf/arm_pmu.h
@@ -59,12 +59,6 @@ struct pmu_hw_events {
 	 */
 	DECLARE_BITMAP(used_mask, ARMPMU_MAX_HWEVENTS);
 
-	/*
-	 * Hardware lock to serialize accesses to PMU registers. Needed for the
-	 * read/modify/write sequences.
-	 */
-	raw_spinlock_t		pmu_lock;
-
 	/*
 	 * When using percpu IRQs, we need a percpu dev_id. Place it here as we
 	 * already have to allocate this struct per cpu.
-- 
2.25.1

