Return-Path: <linux-kernel+bounces-58412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A3684E638
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7F41C20962
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6357312AAC7;
	Thu,  8 Feb 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nn2d1Jqb"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF77682D61;
	Thu,  8 Feb 2024 17:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411879; cv=none; b=XQWaqbP3ugVCiNSgfh+HTrABlUrhe9mzUvgjd3kvfUvfac9la/hoQ8IrgwFurHu7BDUq9jAW/0deYmEB3Ve5WGro6yZ6OKi+lGOPaxVY0goE9Q/vOTDMhGBUG7haDS9yhZSVU0wtDZhHNupHNtz5xTTsg8X6LFdKmLhJ7Ipu5Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411879; c=relaxed/simple;
	bh=TcZggvWPAiMNrDjTaYr88pR3WYNyYJDkk6qpMPNTC3Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3IY1w2mWIwORxnet9uPtV0R9awDzekdCEVQjcO7N2ZHAlw0D21s1NhEyApMEbhqeTp829rkE/S5rWNcBXSf7iCfuBc9AC297A2lPPh3UscMD15YJpGcq93WTacQTGIYceJBmQITaSr4j0jnNViLzDG4w0cEIyqhBcvTtHWirKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Nn2d1Jqb; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4LT3051777;
	Thu, 8 Feb 2024 11:04:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411861;
	bh=5a2BDxvry/mDEJhidMjtTRkucrmFZYMP54rfoZVMxFg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Nn2d1JqbkmwolD9eOlmJ4M35dV5MKx16BW64juGbDGBzox+jz/3tFBGxnbgSTI347
	 WzBCV+ccNDq6AEUwDc7dEVy4iSHkctSWeMUawVFVF9IY7mV0pbUC8fiO8ClwkzgS5p
	 Ita4IL7d/SmY/SbNqKgzvrfL89P0JKhNlCuE7gF8=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4L8M054137
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:21 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:20 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:20 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6F091006;
	Thu, 8 Feb 2024 11:04:20 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Cristian Ciocaltea
	<cristian.ciocaltea@gmail.com>,
        Florian Fainelli
	<florian.fainelli@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, Scott Branden
	<sbranden@broadcom.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad
 Dybcio <konrad.dybcio@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-actions@lists.infradead.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v3 13/19] power: reset: msm-poweroff: Use devm_register_sys_off_handler(RESTART)
Date: Thu, 8 Feb 2024 11:04:04 -0600
Message-ID: <20240208170410.67975-14-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208170410.67975-1-afd@ti.com>
References: <20240208170410.67975-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use device life-cycle managed register function to simplify probe.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/reset/msm-poweroff.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/drivers/power/reset/msm-poweroff.c b/drivers/power/reset/msm-poweroff.c
index bcf04491e7022..c5831c46f69e2 100644
--- a/drivers/power/reset/msm-poweroff.c
+++ b/drivers/power/reset/msm-poweroff.c
@@ -13,35 +13,24 @@
 #include <linux/reboot.h>
 #include <linux/pm.h>
 
-static void __iomem *msm_ps_hold;
-static int deassert_pshold(struct notifier_block *nb, unsigned long action,
-			   void *data)
+static int do_msm_poweroff(struct sys_off_data *data)
 {
+	void __iomem *msm_ps_hold = data->cb_data;
+
 	writel(0, msm_ps_hold);
 	mdelay(10000);
 
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block restart_nb = {
-	.notifier_call = deassert_pshold,
-	.priority = 128,
-};
-
-static int do_msm_poweroff(struct sys_off_data *data)
-{
-	deassert_pshold(&restart_nb, 0, NULL);
-
-	return NOTIFY_DONE;
-}
-
 static int msm_restart_probe(struct platform_device *pdev)
 {
-	msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
+	void __iomem *msm_ps_hold = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(msm_ps_hold))
 		return PTR_ERR(msm_ps_hold);
 
-	register_restart_handler(&restart_nb);
+	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+				      128, do_msm_poweroff, msm_ps_hold);
 
 	devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_POWER_OFF,
 				      SYS_OFF_PRIO_DEFAULT, do_msm_poweroff,
-- 
2.39.2


