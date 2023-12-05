Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845E1804DC2
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235008AbjLEJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:26:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbjLEJ0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:26:43 -0500
Received: from mta-04.yadro.com (mta-04.yadro.com [89.207.88.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD379A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 01:26:47 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-04.yadro.com 75E16C0012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
        s=mta-04; t=1701768404;
        bh=Wgc4vYFwTTdezw2Dt8TSID9zE3MCqMpQeygs8Zvspe0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=zN/h/XMoQYSY7nfRQm8shoI9ddMjtR8PeFr8EJIP0M00CmdpJzwPhdbbwqBsmpVHK
         XnJEMQalKr7/GBHSDeacQGFu5ArCPjZIKEjT1sXmDsyw+ZEV44CWIWsKejCaiAE5Zh
         2zZvVhUqYJ79+dCKZSs57wnIgb04JP2LL1pYkkwSPkCkfjb1g8/0px/C1Lva31Ms+y
         Doya5P1nbRNqbi0VudRyre+BZRVDDoVCEg70cTibPVytW7hmWiqyfklhN5k5T+iDoE
         HG5g9ag97xWmN/rlLU9ZAq7neuHluGuI/g1bJ/0e6ziEAsKf3SWSXelziR1vkrsjkD
         cjhWtJJhA50Pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com;
        s=mta-03; t=1701768404;
        bh=Wgc4vYFwTTdezw2Dt8TSID9zE3MCqMpQeygs8Zvspe0=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=N12l5OmukPDm3zwWXUVZMXn9SCW137JY6MNjsk/xf2nDzmeErxl37dta/ZvWUbXe3
         UkHs22KUc162ix0thm2cYDE8Mj3fjXjeIuFSgk2psMc+QUJ2UtilA6+iufMStEVYIT
         ftlqly5CQwH3R80Ct0It2Mwrjs454P8APJtKyCafGA86HCU0egaQNSti1aIp4jVIJY
         g9TWqF43+0rfbwBxyo4I/l4mdJQOk6QpVpDr4jmursJhINS2ofC3kctTmaiSjvSI2n
         lvWfikFxdmbuYWxA3ZqeyGmg853AiZYQIQSX+X8STl6aBdagZGsStfBRbadK5JScBF
         DouAR+A9EUpQA==
From:   Vadim Shakirov <vadim.shakirov@syntacore.com>
To:     Atish Patra <atishp@atishpatra.org>
CC:     Vadim Shakirov <vadim.shakirov@syntacore.com>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        "Palmer Dabbelt" <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Alexandre Ghiti" <alexghiti@rivosinc.com>,
        Andrew Jones <ajones@ventanamicro.com>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] drivers: perf: ctr_get_width function for legacy is not defined
Date:   Tue, 5 Dec 2023 12:25:54 +0300
Message-ID: <20231205092555.35617-1-vadim.shakirov@syntacore.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: T-EXCH-07.corp.yadro.com (172.17.11.57) To
 S-Exch-02.corp.yadro.com (10.78.5.239)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With parameters CONFIG_RISCV_PMU_LEGACY=y and CONFIG_RISCV_PMU_SBI=n
linux kernel crashes when you try perf record:

$ perf record ls
[   46.749286] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
[   46.750199] Oops [#1]
[   46.750342] Modules linked in:
[   46.750608] CPU: 0 PID: 107 Comm: perf-exec Not tainted 6.6.0 #2
[   46.750906] Hardware name: riscv-virtio,qemu (DT)
[   46.751184] epc : 0x0
[   46.751430]  ra : arch_perf_update_userpage+0x54/0x13e
[   46.751680] epc : 0000000000000000 ra : ffffffff8072ee52 sp : ff2000000022b8f0
[   46.751958]  gp : ffffffff81505988 tp : ff6000000290d400 t0 : ff2000000022b9c0
[   46.752229]  t1 : 0000000000000001 t2 : 0000000000000003 s0 : ff2000000022b930
[   46.752451]  s1 : ff600000028fb000 a0 : 0000000000000000 a1 : ff600000028fb000
[   46.752673]  a2 : 0000000ae2751268 a3 : 00000000004fb708 a4 : 0000000000000004
[   46.752895]  a5 : 0000000000000000 a6 : 000000000017ffe3 a7 : 00000000000000d2
[   46.753117]  s2 : ff600000028fb000 s3 : 0000000ae2751268 s4 : 0000000000000000
[   46.753338]  s5 : ffffffff8153e290 s6 : ff600000863b9000 s7 : ff60000002961078
[   46.753562]  s8 : ff60000002961048 s9 : ff60000002961058 s10: 0000000000000001
[   46.753783]  s11: 0000000000000018 t3 : ffffffffffffffff t4 : ffffffffffffffff
[   46.754005]  t5 : ff6000000292270c t6 : ff2000000022bb30
[   46.754179] status: 0000000200000100 badaddr: 0000000000000000 cause: 000000000000000c
[   46.754653] Code: Unable to access instruction at 0xffffffffffffffec.
[   46.754939] ---[ end trace 0000000000000000 ]---
[   46.755131] note: perf-exec[107] exited with irqs disabled
[   46.755546] note: perf-exec[107] exited with preempt_count 4

This happens because in the legacy case the ctr_get_width function was not
defined, but it is used in arch_perf_update_userpage.

Also remove extra check in riscv_pmu_ctr_get_width_mask

Fixes: cc4c07c89aad ("drivers: perf: Implement perf event mmap support in the SBI backend")
Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>
---
 drivers/perf/riscv_pmu.c        | 18 +++++-------------
 drivers/perf/riscv_pmu_legacy.c |  8 +++++++-
 2 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/perf/riscv_pmu.c b/drivers/perf/riscv_pmu.c
index 0dda70e1ef90..c78a6fd6c57f 100644
--- a/drivers/perf/riscv_pmu.c
+++ b/drivers/perf/riscv_pmu.c
@@ -150,19 +150,11 @@ u64 riscv_pmu_ctr_get_width_mask(struct perf_event *event)
 	struct riscv_pmu *rvpmu = to_riscv_pmu(event->pmu);
 	struct hw_perf_event *hwc = &event->hw;
 
-	if (!rvpmu->ctr_get_width)
-	/**
-	 * If the pmu driver doesn't support counter width, set it to default
-	 * maximum allowed by the specification.
-	 */
-		cwidth = 63;
-	else {
-		if (hwc->idx == -1)
-			/* Handle init case where idx is not initialized yet */
-			cwidth = rvpmu->ctr_get_width(0);
-		else
-			cwidth = rvpmu->ctr_get_width(hwc->idx);
-	}
+	if (hwc->idx == -1)
+		/* Handle init case where idx is not initialized yet */
+		cwidth = rvpmu->ctr_get_width(0);
+	else
+		cwidth = rvpmu->ctr_get_width(hwc->idx);
 
 	return GENMASK_ULL(cwidth, 0);
 }
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
index 79fdd667922e..a179ed6ac980 100644
--- a/drivers/perf/riscv_pmu_legacy.c
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -37,6 +37,12 @@ static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
 	return pmu_legacy_ctr_get_idx(event);
 }
 
+/* cycle & instret are always 64 bit, one bit less according to SBI spec */
+static int pmu_legacy_ctr_get_width(int idx)
+{
+	return 63;
+}
+
 static u64 pmu_legacy_read_ctr(struct perf_event *event)
 {
 	struct hw_perf_event *hwc = &event->hw;
@@ -111,7 +117,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
 	pmu->ctr_stop = NULL;
 	pmu->event_map = pmu_legacy_event_map;
 	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
-	pmu->ctr_get_width = NULL;
+	pmu->ctr_get_width = pmu_legacy_ctr_get_width;
 	pmu->ctr_clear_idx = NULL;
 	pmu->ctr_read = pmu_legacy_read_ctr;
 	pmu->event_mapped = pmu_legacy_event_mapped;
-- 
2.34.1

