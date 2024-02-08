Return-Path: <linux-kernel+bounces-58413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC1784E639
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3FE290D38
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC412BEA6;
	Thu,  8 Feb 2024 17:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FFWITdHo"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B609382D84;
	Thu,  8 Feb 2024 17:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411879; cv=none; b=g7EkK//uuJZ8rRH1YnM1hR4MXDhBjQV6ZRYjxIbK+rnK02/sWibDhVYeEh4jgTWvnzgnekgAQmk63ZDd52Pvnb7VilRm74J/ubys7wzmIw601iQeYRzxuDyxYPTaFIttG5yl9VmBp7mqkpAZYHU00JiJhfH9+fsqCYB59QcO/fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411879; c=relaxed/simple;
	bh=HDoP9l78EFZDdW16hNeR9IATxUCA5uyr6j+jeh40ipg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dkt25HuXHVIXcWAVWKm2e/gSyp3LPgIvdEab2LH37B1NR6GR4WnOkIAC+2ib7CSYKUocRsVjLKR+dIIuS7W4wW0B8Pmr8gXHMgdtSH36H11GCum0Gzb84sem75CThTWYnr7A+2p/tM6aBw9fDT1p+FsQN3i5v8V8L6V3qBL9c0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FFWITdHo; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418H4N30018180;
	Thu, 8 Feb 2024 11:04:23 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411863;
	bh=WzOWw71XNiTDn9UhRVmQ1YL+kbl79QddxFr5AngwFzk=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FFWITdHo0BdV2CFmQNlXBS6gqu3VbRAgn1fajWZ9PxxNEPibvR/OJxfM2S6k68PVs
	 VVJZJnmF/uQ3T1GY251ts/5vNSx1oafnOj7q1cHgU40Ugzy4qd2FiW3DC/fCQD9J56
	 nrJaxDkkurkZW37mYcyy2dhOEHItXcIWsR7eDY/M=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418H4NgW042486
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 11:04:23 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 11:04:23 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 11:04:22 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418H4B6I091006;
	Thu, 8 Feb 2024 11:04:22 -0600
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
Subject: [PATCH v3 16/19] power: reset: gemini-poweroff: Use devm_register_sys_off_handler(POWER_OFF)
Date: Thu, 8 Feb 2024 11:04:07 -0600
Message-ID: <20240208170410.67975-17-afd@ti.com>
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


