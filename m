Return-Path: <linux-kernel+bounces-35661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F18A8394EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E1B0B23050
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40B2C81209;
	Tue, 23 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kTnhR/Yx"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C356D7F7E3;
	Tue, 23 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027826; cv=none; b=YOR/yxmMNPuWFvt67P4hI4mBHup90j2a7MhPW9LJUtBMEYlbm/IpGcnISEZ1x9gHNZYoTgUE4LKo4ObLIcIWyxpXyWHopYmsS/9sDk7ooei/HN4GyShQpzOkZtTuiPzTSwFDvHYmuDp2of1Zp/CvKZgH+Y1PCZn9pM+nHU6cnIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027826; c=relaxed/simple;
	bh=j03f6RirHCv9dDLa3rzJLikeTc7jyeColyXtSlKWQhU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VuMd8tR9mdwlMbQHPdTQ7hZfBdK3+MJS17vJH+WbPX9PIx5spX/z2aKFIePaLMvZEG1F7eAWD/RnnY6JG4X1acQ5C0pYnVdLy1CAiZNdF6O1lAgYd8CO5asgjz3IP51ppL8zpNL2GB2smPQfd6RNO+ykoSFL25FukkqmtEVFGw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kTnhR/Yx; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGavmm077083;
	Tue, 23 Jan 2024 10:36:57 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027817;
	bh=zX2Ey45x6SziOonwBIm+VHIBL+95dJLGekCQr6w7tY4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=kTnhR/YxtEPDkdBSY2sK+TB9g/rmNtnOnMNsmuKlkoD/6a1mvc9Nsunt9Ewcwxrxk
	 c//FGL7Itlk4b4FxNdmcqaLUXjoLInUh2q0mS+3/3KikuVO9wW0UXBUZT2sJkLPyzT
	 KxS5IsxSl55MXVchDSfr+xaMqAnwCfEF4BA1Qb/w=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGavgq000578
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:57 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:56 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:57 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarru123403;
	Tue, 23 Jan 2024 10:36:56 -0600
From: Andrew Davis <afd@ti.com>
To: Sebastian Reichel <sre@kernel.org>,
        Support Opensource
	<support.opensource@diasemi.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>,
        =?UTF-8?q?Pali=20Roh=C3=A1r?=
	<pali@kernel.org>
CC: <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew Davis
	<afd@ti.com>
Subject: [PATCH 08/21] power: supply: max77693: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:40 -0600
Message-ID: <20240123163653.384385-9-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123163653.384385-1-afd@ti.com>
References: <20240123163653.384385-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Use the device lifecycle managed register function. This helps prevent
mistakes like unregistering out of order in cleanup functions and
forgetting to unregister on error paths.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/power/supply/max77693_charger.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/power/supply/max77693_charger.c b/drivers/power/supply/max77693_charger.c
index d0157e63b8b50..9ad6cc6500fcc 100644
--- a/drivers/power/supply/max77693_charger.c
+++ b/drivers/power/supply/max77693_charger.c
@@ -709,9 +709,9 @@ static int max77693_charger_probe(struct platform_device *pdev)
 		goto err;
 	}
 
-	chg->charger = power_supply_register(&pdev->dev,
-						&max77693_charger_desc,
-						&psy_cfg);
+	chg->charger = devm_power_supply_register(&pdev->dev,
+						  &max77693_charger_desc,
+						  &psy_cfg);
 	if (IS_ERR(chg->charger)) {
 		dev_err(&pdev->dev, "failed: power supply register\n");
 		ret = PTR_ERR(chg->charger);
@@ -735,8 +735,6 @@ static void max77693_charger_remove(struct platform_device *pdev)
 	device_remove_file(&pdev->dev, &dev_attr_top_off_timer);
 	device_remove_file(&pdev->dev, &dev_attr_top_off_threshold_current);
 	device_remove_file(&pdev->dev, &dev_attr_fast_charge_timer);
-
-	power_supply_unregister(chg->charger);
 }
 
 static const struct platform_device_id max77693_charger_id[] = {
-- 
2.39.2


