Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BEA7910BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 07:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352198AbjIDFG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 01:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352112AbjIDFGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 01:06:53 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C118138;
        Sun,  3 Sep 2023 22:06:48 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 383KMCsX024846;
        Sun, 3 Sep 2023 22:06:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=OlH1DH2wSd8cA5wQp3pwWvDyZc/am3VSh5u6DCHATV8=;
 b=Yt5z9/E0JhxybhwLxBHW4PPKdQ5AaQKtFvBlGHY2YBq1BtwQCGUaTJGeM95N/iCYJE/I
 WITDUZRjxQC7Ov2uhRIHQCsRWAq8WCA9rRn4eG3dtpSSScsQrIK4qjYLaOOSuCbQXl8z
 /TfDy3gqu9MshCN3Bucs2Ef02S7r+NaMQ+QbROyWRV6TiU4maEgn7IbrfeDMnDRJ0QQa
 /vH0TSduq+y6i2NFTC3jtQEQs6k2pXllTbb5fjS9lGL59pxK6VEhd/TCJ473VUOVE/Gq
 krJ/P46pIpu82bP35O05h382H/TCPCOAv/QJXOnk5/YrgMw8LIpO8Xc4uvCS2DH81ISx EQ== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sv4jk4b8t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Sun, 03 Sep 2023 22:06:40 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 3 Sep
 2023 22:06:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 3 Sep 2023 22:06:38 -0700
Received: from localhost.localdomain (unknown [10.28.34.196])
        by maili.marvell.com (Postfix) with ESMTP id 2270C3F7070;
        Sun,  3 Sep 2023 22:06:33 -0700 (PDT)
From:   Linu Cherian <lcherian@marvell.com>
To:     <suzuki.poulose@arm.com>, <mike.leach@linaro.org>,
        <james.clark@arm.com>, <leo.yan@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <sgoutham@marvell.com>, <gcherian@marvell.com>,
        Linu Cherian <lcherian@marvell.com>
Subject: [RFC PATCH v3 6/7] coresight: tmc: Stop trace capture on FlIn
Date:   Mon, 4 Sep 2023 10:35:46 +0530
Message-ID: <20230904050548.28047-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904050548.28047-1-lcherian@marvell.com>
References: <20230904050548.28047-1-lcherian@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: Nc_ZLAFaYfHyj0H4sofZlXvVu5QzCleU
X-Proofpoint-ORIG-GUID: Nc_ZLAFaYfHyj0H4sofZlXvVu5QzCleU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-04_02,2023-08-31_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index fd883e579141..9b4c208b6dc4 100644
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
index 7fe5d70a393a..323e503bcfa7 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -1098,7 +1098,7 @@ static int __tmc_etr_enable_hw(struct tmc_drvdata *drvdata)
 
 	writel_relaxed(TMC_FFCR_EN_FMT | TMC_FFCR_EN_TI |
 		       TMC_FFCR_FON_FLIN | TMC_FFCR_FON_TRIG_EVT |
-		       TMC_FFCR_TRIGON_TRIGIN,
+		       TMC_FFCR_TRIGON_TRIGIN | TMC_FFCR_STOP_ON_FLUSH,
 		       drvdata->base + TMC_FFCR);
 	writel_relaxed(drvdata->trigger_cntr, drvdata->base + TMC_TRG);
 	tmc_enable_hw(drvdata);
@@ -1829,7 +1829,13 @@ static int tmc_panic_sync_etr(struct coresight_device *csdev)
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
index a95ba0a8ed93..b08b649f1fd4 100644
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
2.41.0

