Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8227B33CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjI2NjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233441AbjI2Ni6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:38:58 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F3D2115;
        Fri, 29 Sep 2023 06:38:49 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38T27fDB021104;
        Fri, 29 Sep 2023 06:38:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=NByjmqhDn7cjvZxBL2CousB8PNAlV59A8D/N14Kb2s4=;
 b=fxeP2yGXdqDsORKFPIUh7fiCirysKYytmfRVkwInXR0hgTkjnP8nkxPiI/mvTf8tZ1cL
 WbB7/Um9XEiQKfFrdyZJZtDq2el1jrpU3fkiZ7rFSkIpgSr3J4IK3MCw54WEkzyUV7f+
 XnW1ZHpjM85DgyY2iY02zt548JJdvGw53h5ET9LJ+qNrGl7w/zN8Ck21r2jhq3VuQumo
 Oj6cqbJIHhPQy+aUkYCSa5AVmtulQaoKTNPvnlhFElXcqwllXXn7Pc05na31bbGlMvLN
 B52VErYifWRHIOBaz76asoBZdA3lJkfjKjQkAU4c9AU9Lx6J3sDvB1PE9/TD8KDHo2iG /A== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3tcrrs986n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 29 Sep 2023 06:38:37 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 29 Sep
 2023 06:38:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 29 Sep 2023 06:38:34 -0700
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id EB3A05B6923;
        Fri, 29 Sep 2023 06:38:30 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 6/7] coresight: tmc: Stop trace capture on FlIn
Date:   Fri, 29 Sep 2023 19:07:53 +0530
Message-ID: <20230929133754.857678-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929133754.857678-1-lcherian@marvell.com>
References: <20230929133754.857678-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: Y0r5B9J_lnH66d3b0nzLgs09zYKR9hFm
X-Proofpoint-GUID: Y0r5B9J_lnH66d3b0nzLgs09zYKR9hFm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-29_11,2023-09-28_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event. As a side effect, do manual flush only if
auto flush fails.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h     |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 496b44aad56d..cc73cd1f4d11 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -34,7 +34,7 @@ static int __tmc_etb_enable_hw(struct tmc_drvdata *drvdata)
 	writel_relaxed(TMC_MODE_CIRCULAR_BUFFER, drvdata->base + TMC_MODE);
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
+		       TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
 		       drvdata->base + TMC_FFCR);
 
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
@@ -613,7 +613,13 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
 	if (val != TMC_MODE_CIRCULAR_BUFFER)
 		goto out;
 
-	tmc_flush_and_stop(drvdata);
+	val = readl(drvdata->base + TMC_FFSR);
+	/* Do manual flush and stop only if its not auto-stopped */
+	if (!(val & TMC_FFSR_FT_STOPPED)) {
+		dev_info(&csdev->dev,
+			 "%s: Triggering manual flush\n", __func__);
+		tmc_flush_and_stop(drvdata);
+	}
 
 	/* Sync registers from hardware to metadata region */
 	tmc->sts = csdev_access_relaxed_read32(csa, TMC_STS);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index c31c71e02833..c84f24333ebc 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1112,7 +1112,7 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
+		       TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
 		       drvdata->base + TMC_FFCR);
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -1843,7 +1843,13 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
 	if (!(val & TMC_CTL_CAPT_EN))
 		goto out;
 
-	tmc_flush_and_stop(drvdata);
+	val = readl(drvdata->base + TMC_FFSR);
+	/* Do manual flush and stop only if its not auto-stopped */
+	if (!(val & TMC_FFSR_FT_STOPPED)) {
+		dev_info(&csdev->dev,
+			 "%s: Triggering manual flush\n", __func__);
+		tmc_flush_and_stop(drvdata);
+	}
 
 	/* Sync registers from hardware to metadata region */
 	tmc->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index f8b79eaac0bd..0975afca1f95 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -76,6 +76,9 @@
 #define TMC_AXICTL_AXCACHE_OS	(0xf << 2)
 #define TMC_AXICTL_ARCACHE_OS	(0xf << 16)
 
+/* TMC_FFSR - 0x300 */
+#define TMC_FFSR_FT_STOPPED	BIT(1)
+
 /* TMC_FFCR - 0x304 */
 #define TMC_FFCR_FLUSHMAN_BIT	6
 #define TMC_FFCR_EN_FMT		BIT(0)
-- 
2.34.1

