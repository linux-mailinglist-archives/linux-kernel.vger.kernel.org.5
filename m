Return-Path: <linux-kernel+bounces-61969-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE1385194C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED6F61F20FCA
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6E47772;
	Mon, 12 Feb 2024 16:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JOB2TDY7"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8E43FE2B;
	Mon, 12 Feb 2024 16:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707755334; cv=none; b=AATA74HOvilg7aHLn5pacndFiULtZK0IgEI/RNKefD2YktErxEvBJngmfDpniKFZBNfTS74rhr2CNdPyGfMVuvccYGCKJUQ0ScLYuSmcU7IRfAKTEBGViwYwDE/aJSlr6zOUuqOnyoyu4VK8/JLzx7bwBKiMDi0q+Re0g/yzfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707755334; c=relaxed/simple;
	bh=HDoP9l78EFZDdW16hNeR9IATxUCA5uyr6j+jeh40ipg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n6U++4cfp/Qm4RE+ohIXbPGAWop9wkppLNUh1A0TqJbA0B/po+Besb6HL2wzTS+EwS7nUrQebSsYx0PdH57/3zSaQP2rqU6RwgT/6/qNxEZE6AVD27f4kBLmDJpA9yy8rzkQP1htl2o0H9lWSmyfi5fxZTOkJtmO7DrSMCHM7dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=JOB2TDY7; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41CGShw5045223;
	Mon, 12 Feb 2024 10:28:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707755323;
	bh=WzOWw71XNiTDn9UhRVmQ1YL+kbl79QddxFr5AngwFzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=JOB2TDY7HOl6IEiw80vVvRT4OnSvgy0nPrwBER278hgGG/0obT74ZUI+REh9JUhHS
	 GUVb30qnQAdIUyCx+I9HAOt5n5m+d9RV4YUgG7F0lJImX+syZo+oF45ERwnhwcFkMB
	 b6gZpi3KuB3ahdIM0eShKATh0neKDuJsU82cFGHE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41CGShNB024937
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 12 Feb 2024 10:28:43 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 12
 Feb 2024 10:28:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 12 Feb 2024 10:28:42 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41CGSWRC090688;
	Mon, 12 Feb 2024 10:28:42 -0600
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
Subject: [PATCH v4 16/19] power: reset: gemini-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Mon, 12 Feb 2024 10:28:28 -0600
Message-ID: <20240212162831.67838-17-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240212162831.67838-1-afd@ti.com>
References: <20240212162831.67838-1-afd@ti.com>
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
 drivers/power/reset/gemini-poweroff.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/power/reset/gemini-poweroff.c b/drivers/power/reset/gemini-poweroff.c
index d309b610142ce..06d6992dec892 100644
--- a/drivers/power/reset/gemini-poweroff.c
+++ b/drivers/power/reset/gemini-poweroff.c
@@ -70,12 +70,9 @@ static irqreturn_t gemini_powerbutton_interrupt(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-/* This callback needs this static local as it has void as argument */
-static struct gemini_powercon *gpw_poweroff;
-
-static void gemini_poweroff(void)
+static int gemini_poweroff(struct sys_off_data *data)
 {
-	struct gemini_powercon *gpw = gpw_poweroff;
+	struct gemini_powercon *gpw = data->cb_data;
 	u32 val;
 
 	dev_crit(gpw->dev, "Gemini power off\n");
@@ -86,6 +83,8 @@ static void gemini_poweroff(void)
 	val &= ~GEMINI_CTRL_ENABLE;
 	val |= GEMINI_CTRL_SHUTDOWN;
 	writel(val, gpw->base + GEMINI_PWC_CTRLREG);
+
+	return NOTIFY_DONE;
 }
 
 static int gemini_poweroff_probe(struct platform_device *pdev)
@@ -148,8 +147,11 @@ static int gemini_poweroff_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	pm_power_off = gemini_poweroff;
-	gpw_poweroff = gpw;
+	ret = devm_register_sys_off_handler(dev, SYS_OFF_MODE_POWER_OFF,
+					    SYS_OFF_PRIO_DEFAULT,
+					    gemini_poweroff, gpw);
+	if (ret)
+		return ret;
 
 	dev_info(dev, "Gemini poweroff driver registered\n");
 
-- 
2.39.2


