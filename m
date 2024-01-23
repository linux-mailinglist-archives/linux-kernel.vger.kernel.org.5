Return-Path: <linux-kernel+bounces-35893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BDD83984C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30C5A1F24219
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3A786AED;
	Tue, 23 Jan 2024 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sq3qE0dV"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EAA85C4A;
	Tue, 23 Jan 2024 18:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706035617; cv=none; b=sFMPYuAfygWZXux4P3R6hoomVy1X3BGGkvDU/Sh8DkKm0R6rkFMAJzvVFB3IZpOGFNNTSiu8suJzCFZhYuOFGuLaO52jOBbtyAPzFJjxSS7akd5gT4C9OHof5nblY3plNGnBTRxudOAutqr3sViS7PBcamDJcyXnFw1CwasdIKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706035617; c=relaxed/simple;
	bh=N56mWfcnzmIQh2ql1P8TK4KuqLvv6Hr8DkMvlnHr83M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBiUUDF0u1O8N076xyEGCro6ooZD/wvVS/ZP+y7iTga4VhpzY+ADWJ/0fK9n699wry5V3p/IadypEudaVkdBL9frewVXZjp3v2vSc/ht0mEZKAuz3jE1/p4sv7vBs9I38+rk4SrKGg4Wkx5SnDrhFAwKrhbncMe74k5JtTOf08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Sq3qE0dV; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkcpk111741;
	Tue, 23 Jan 2024 12:46:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706035598;
	bh=Fnn4Eaec4WxtTkMHSfV5vv0vfLWjshQGib5zI9abKQ0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Sq3qE0dVG1l3ymQRVxyH6Us6tlr0iOZQpZd6SHgpBiEt56+5b1Zaa4Qn7YwmlRSc3
	 WTcn4xkFzLpeBN10kaEtLXTKUxid6POtkVaSxCzmOicbMrMafTSW9QK3wZdjVeLPVN
	 8XPr6doPbwFFklvwPD9OpnHp7aJQrHHUw32erGpo=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NIkcsn011094
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 12:46:38 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 12:46:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 12:46:38 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NIkX1x063265;
	Tue, 23 Jan 2024 12:46:37 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier
	<mathieu.poirier@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer
	<s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Patrice Chotard
	<patrice.chotard@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
CC: <linux-remoteproc@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Andrew Davis <afd@ti.com>
Subject: [PATCH 8/9] remoteproc: st: Use devm_rproc_alloc() helper
Date: Tue, 23 Jan 2024 12:46:31 -0600
Message-ID: <20240123184632.725054-8-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123184632.725054-1-afd@ti.com>
References: <20240123184632.725054-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed allocation function. This helps prevent
mistakes like freeing out of order in cleanup functions and forgetting to
free on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/remoteproc/st_remoteproc.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/remoteproc/st_remoteproc.c b/drivers/remoteproc/st_remoteproc.c
index cb163766c56d5..1340be9d01101 100644
--- a/drivers/remoteproc/st_remoteproc.c
+++ b/drivers/remoteproc/st_remoteproc.c
@@ -347,23 +347,21 @@ static int st_rproc_probe(struct platform_device *pdev)
 	int enabled;
 	int ret, i;
 
-	rproc = rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
+	rproc = devm_rproc_alloc(dev, np->name, &st_rproc_ops, NULL, sizeof(*ddata));
 	if (!rproc)
 		return -ENOMEM;
 
 	rproc->has_iommu = false;
 	ddata = rproc->priv;
 	ddata->config = (struct st_rproc_config *)device_get_match_data(dev);
-	if (!ddata->config) {
-		ret = -ENODEV;
-		goto free_rproc;
-	}
+	if (!ddata->config)
+		return -ENODEV;
 
 	platform_set_drvdata(pdev, rproc);
 
 	ret = st_rproc_parse_dt(pdev);
 	if (ret)
-		goto free_rproc;
+		return ret;
 
 	enabled = st_rproc_state(pdev);
 	if (enabled < 0) {
@@ -439,8 +437,7 @@ static int st_rproc_probe(struct platform_device *pdev)
 		mbox_free_channel(ddata->mbox_chan[i]);
 free_clk:
 	clk_unprepare(ddata->clk);
-free_rproc:
-	rproc_free(rproc);
+
 	return ret;
 }
 
@@ -456,8 +453,6 @@ static void st_rproc_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ST_RPROC_MAX_VRING * MBOX_MAX; i++)
 		mbox_free_channel(ddata->mbox_chan[i]);
-
-	rproc_free(rproc);
 }
 
 static struct platform_driver st_rproc_driver = {
-- 
2.39.2


