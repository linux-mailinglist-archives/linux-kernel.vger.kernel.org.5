Return-Path: <linux-kernel+bounces-17496-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FF1824E5E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C49B71F20F26
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BC4221376;
	Fri,  5 Jan 2024 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="MCeSAryg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710D7566A;
	Fri,  5 Jan 2024 05:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4054bIio004588;
	Thu, 4 Jan 2024 21:59:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	pfpt0220; bh=baXDyzolEU1XhD3nj71BnVJyvVVY9rCyNXB2T01ERLE=; b=MCe
	SArygOthrCccvXmfLGkHznHsRCjXAbUUfETOZC8MldfmKMKuCQkwTHTZsZP6Qh9o
	vVPJ268R+bKTmtvaFd7bqyqOsmIflhFNlm8FUVnYF0xYQ9g//UEQ2vZgAKsX1AMG
	gCtkKUTfU18fU4A5f87kfYSA/Wo0gDMVR7vIj9sAGgD0xTaDX9/3TjFa6UJ9Sjqx
	aREuFWkbSURXSHxRduRPDuMd/3tvtyg32sHHGWE7HuruQ+ln0Q6aLlOAFrWV9dHG
	wgFBdqWGQsuH+EH6XznQc6f3MCznu+u46mQ1+pGsFZ7Or0bBi7HZ+CzOslPiG6CK
	zG1jshRirpdaCZVN4Kw==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3veaw0060b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 21:59:28 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 21:59:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 Jan 2024 21:59:25 -0800
Received: from virtx40.. (unknown [10.28.34.196])
	by maili.marvell.com (Postfix) with ESMTP id E3F433F704F;
	Thu,  4 Jan 2024 21:59:21 -0800 (PST)
From: Linu Cherian <lcherian@marvell.com>
To: <suzuki.poulose@arm.com>, <mike.leach@linaro.org>, <james.clark@arm.com>,
        <leo.yan@linaro.org>
CC: <linux-arm-kernel@lists.infradead.org>, <coresight@lists.linaro.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <sgoutham@marvell.com>,
        <gcherian@marvell.com>, Linu Cherian <lcherian@marvell.com>
Subject: [PATCH v6 6/7] coresight: tmc: Stop trace capture on FlIn
Date: Fri, 5 Jan 2024 11:28:39 +0530
Message-ID: <20240105055840.1977897-7-lcherian@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105055840.1977897-1-lcherian@marvell.com>
References: <20240105055840.1977897-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1kPcC4xzukVtz0oVF1wV1SqljHNTxHrj
X-Proofpoint-ORIG-GUID: 1kPcC4xzukVtz0oVF1wV1SqljHNTxHrj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Configure TMC ETR and ETF to flush and stop trace capture
on FlIn event. As a side effect, do manual flush only if
auto flush fails.

Signed-off-by: Linu Cherian <lcherian@marvell.com>
---
Changelog from v5:
* No changes

 drivers/hwtracing/coresight/coresight-tmc-etf.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 10 ++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h     |  3 +++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index 72c2315f4e23..57a9a9300d36 100644
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
index ab7521bbb2f5..4b3c7ec7f62b 100644
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


