Return-Path: <linux-kernel+bounces-35662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 297E48394EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D75B428D78C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7500781213;
	Tue, 23 Jan 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ySRq0O9w"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5487FBCD;
	Tue, 23 Jan 2024 16:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027826; cv=none; b=bK694AXz9Lxp4XuM0YydFjbVkL2HROcxzO1XtrQTTy1mgErxelkNwesn6ZtfXSqPclKIX+WYWmosN2Gb/cno6vwYfLcSiL5eZ1TfOE5TB8a864weJBDV4gip4BSTro0jGCIOxnySmY9v535xnpHHD7FHikFDPo79/sg423VbUHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027826; c=relaxed/simple;
	bh=1/jYUyeGxOHiqO1t9Fn7Rz8hO0B1uSm3eptRNSnnwpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n4aahRFs4Iph+rp+VKA6saYv/CFMpd3OJaHHaO88+rh4Vg8pURuRCvu2Y/pEhGjMa82BGXmnqKVofTpCl65JPIkI6nO9YRBXRteZ4dgwsTQwgnJM1gOZaPmGZX/9qcNqnrdbuiw6yLdE3oD0+GEXwFY3MpRhwyaU+xa9adXIFLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ySRq0O9w; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NGatiq095559;
	Tue, 23 Jan 2024 10:36:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706027815;
	bh=flf2OlhoLXg5wbdQwQ0WLCNrY2rfsuebbogRln7SRDo=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ySRq0O9w+YTNjzg/jUq8KBOsl6qGh+T3xcZEQotkdUDsNnYalsuhaBNeqBShq6Dgt
	 FBzaaeo6FW2uY3AIvVvdkJ9AKoLxGAqB2esZkmPQ0cJK3Tnpge2847FiHfAB3ZaZa4
	 VmS50cbGm1/hQMFufKh+GvkpfNLgrTe2cFe9PxaQ=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NGatr7000549
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:36:55 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:36:54 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:36:55 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NGarro123403;
	Tue, 23 Jan 2024 10:36:54 -0600
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
Subject: [PATCH 02/21] power: supply: da9052: Use devm_power_supply_register() helper
Date: Tue, 23 Jan 2024 10:36:34 -0600
Message-ID: <20240123163653.384385-3-afd@ti.com>
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
 drivers/power/supply/da9052-battery.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/power/supply/da9052-battery.c b/drivers/power/supply/da9052-battery.c
index 6f7c58a41e918..0d84c42c624e0 100644
--- a/drivers/power/supply/da9052-battery.c
+++ b/drivers/power/supply/da9052-battery.c
@@ -622,7 +622,7 @@ static s32 da9052_bat_probe(struct platform_device *pdev)
 		}
 	}
 
-	bat->psy = power_supply_register(&pdev->dev, &psy_desc, &psy_cfg);
+	bat->psy = devm_power_supply_register(&pdev->dev, &psy_desc, &psy_cfg);
 	if (IS_ERR(bat->psy)) {
 		ret = PTR_ERR(bat->psy);
 		goto err;
@@ -644,8 +644,6 @@ static void da9052_bat_remove(struct platform_device *pdev)
 
 	for (i = 0; i < ARRAY_SIZE(da9052_bat_irqs); i++)
 		da9052_free_irq(bat->da9052, da9052_bat_irq_bits[i], bat);
-
-	power_supply_unregister(bat->psy);
 }
 
 static struct platform_driver da9052_bat_driver = {
-- 
2.39.2


