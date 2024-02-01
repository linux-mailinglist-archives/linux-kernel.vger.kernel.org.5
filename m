Return-Path: <linux-kernel+bounces-48637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C81845F1F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:02:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A75284BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2930185630;
	Thu,  1 Feb 2024 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BhjY8BID"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A8084FA8;
	Thu,  1 Feb 2024 18:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810488; cv=none; b=urEAeRyAz3hBhsYcdbjutL0vErzbzxOnl7TTD5b2hBvu2AYgzgpADRo4CEOFWuTLLKXaiIlO0cNIdkgsTmO4wG/fN7H4HUxQFmdW9eOWl8FiJytILRlbkpHgoxWgQ265gRVCRsw8gC7wCpsds3+Xx1oOjEs/HEDcdcJh0ITv8YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810488; c=relaxed/simple;
	bh=bDDsP6FtSJ5wVZ0CYHdodnlun3i/+w7VsSjbcJGnQeI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q26H5LTxg+JrFHDkcXX6+q3U6aGj/66sdzsK0cEV4FPUdoJYj0HyriSG3rBNTDqm5SzoaWnUaiOFRdEraaV7QJ75xs0Y0uLSujd08tahqHBgBAm8L5KTyn6ZufQFOR78FCuPSi7La3+Lhptx+7H5tWr+5efbRt3ko4K22rszqtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BhjY8BID; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 411I17wO049584;
	Thu, 1 Feb 2024 12:01:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706810467;
	bh=b1ggeAlqOeW6cDM2I0g1Lrz7ya2O6mo0S8OfUg915BU=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BhjY8BIDCh34TqTsuxsNCp59BD1rh4Iiu3NvrhnJGpkouoZ0xzRgSAoNY4vAPZdPZ
	 gs+ymMss+pkmQL/x6MLDYhVTdPO2FLT5r0jJqXPVt4NO3l0ep76M+kHielPchllER4
	 fMTgVca4uiNbwX7Om2ggWGKxfTBw0mKtGGw4C28g=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 411I17n2029189
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Feb 2024 12:01:07 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 1
 Feb 2024 12:01:07 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 1 Feb 2024 12:01:07 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 411I12Gk117221;
	Thu, 1 Feb 2024 12:01:06 -0600
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
Subject: [PATCH 06/18] power: reset: brcm-kona-reset: Use devm_register_sys_off_handler(RESTART)
Date: Thu, 1 Feb 2024 12:00:50 -0600
Message-ID: <20240201180102.70395-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240201180102.70395-1-afd@ti.com>
References: <20240201180102.70395-1-afd@ti.com>
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
 drivers/power/reset/brcm-kona-reset.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/power/reset/brcm-kona-reset.c b/drivers/power/reset/brcm-kona-reset.c
index d05728b1db097..4bb956c8f24f8 100644
--- a/drivers/power/reset/brcm-kona-reset.c
+++ b/drivers/power/reset/brcm-kona-reset.c
@@ -13,11 +13,10 @@
 #define RSTMGR_WR_PASSWORD_SHIFT	8
 #define RSTMGR_WR_ACCESS_ENABLE		1
 
-static void __iomem *kona_reset_base;
-
-static int kona_reset_handler(struct notifier_block *this,
-				unsigned long mode, void *cmd)
+static int kona_reset_handler(struct sys_off_data *data)
 {
+	void __iomem *kona_reset_base = data->cb_data;
+
 	/*
 	 * A soft reset is triggered by writing a 0 to bit 0 of the soft reset
 	 * register. To write to that register we must first write the password
@@ -31,18 +30,17 @@ static int kona_reset_handler(struct notifier_block *this,
 	return NOTIFY_DONE;
 }
 
-static struct notifier_block kona_reset_nb = {
-	.notifier_call = kona_reset_handler,
-	.priority = 128,
-};
-
 static int kona_reset_probe(struct platform_device *pdev)
 {
+	void __iomem *kona_reset_base;
+
 	kona_reset_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(kona_reset_base))
 		return PTR_ERR(kona_reset_base);
 
-	return register_restart_handler(&kona_reset_nb);
+	return devm_register_sys_off_handler(&pdev->dev, SYS_OFF_MODE_RESTART,
+					     128, kona_reset_handler,
+					     kona_reset_base);
 }
 
 static const struct of_device_id of_match[] = {
-- 
2.39.2


