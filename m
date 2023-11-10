Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B97E8037
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343841AbjKJSHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234701AbjKJSFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:05:05 -0500
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574722F36F;
        Fri, 10 Nov 2023 03:26:31 -0800 (PST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA6P0Dl019227;
        Fri, 10 Nov 2023 03:26:23 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=IL+c4NizY3Wkc9lbA2nOSfTSap59UHQODV87iLSP6sQ=;
 b=Tg+p4akmAPzZA9FlB8uV+K09uxUc/XqDer4m7jGLu15kMmA2L4YVOPAyhhZZKz8DvSoC
 yQnRLyyA9DAVZlowboImqrT9qNs6mbTant5LGmDi9mU312pacC03jut+4t3OHNiTX5Xc
 g4tyGzxL1ewGrEggLGavQHkBwZ0JFx0zKasFbj2OQRnuPFSwruBq6jl3bh/8ckynczsT
 8EL/Ln93xAg8JM9whO4qZ2kfhzn8cXp6gAqb7ts6RMo2MsjI/8YZFKViZ9Dg0soWUdqY
 iKN/20oV4qta3tIC/l9Aeus35LaZdgxTY+e13svTOLWJU0mPuApSilurScggd5cBbtFT NQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3u9f7x0x9e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 10 Nov 2023 03:26:23 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 10 Nov
 2023 03:26:21 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Fri, 10 Nov 2023 03:26:21 -0800
Received: from virtx40.. (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 658893F7055;
        Fri, 10 Nov 2023 03:26:17 -0800 (PST)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v5 6/7] coresight: tmc: Stop trace capture on FlIn
Date:   Fri, 10 Nov 2023 16:55:32 +0530
Message-ID: <20231110112533.2499437-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231110112533.2499437-1-lcherian@marvell.com>
References: <20231110112533.2499437-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Zaep3BR7dGewr9K9NEPDSaOcnozgB1EE
X-Proofpoint-ORIG-GUID: Zaep3BR7dGewr9K9NEPDSaOcnozgB1EE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_07,2023-11-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
Changelog from v4:
* No changes

 drivers/hwtracing/coresight/coresight-tmc-etf.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h     |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index a6b6f2f9eaa5..01307cd063c1 100644
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
@@ -615,7 +615,13 @@ static int tmc_panic_sync_etf(struct coresight_device *csdev)
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
 	mdata->sts = csdev_access_relaxed_read32(csa, TMC_STS);
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 62a2ab667c57..5e86ae3dd1bf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1113,7 +1113,7 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
+		       TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
 		       drvdata->base + TMC_FFCR);
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -1846,7 +1846,13 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
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
 	mdata->size = csdev_access_relaxed_read32(csa, TMC_RSZ);
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 6e1e910d5ea4..cf9313b302c7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -77,6 +77,9 @@
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

