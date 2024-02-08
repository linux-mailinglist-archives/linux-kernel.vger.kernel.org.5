Return-Path: <linux-kernel+bounces-58379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160F884E573
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 17:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 483151C22E80
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8932D823AB;
	Thu,  8 Feb 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lHTrH5qw"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8917FBCA;
	Thu,  8 Feb 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707411086; cv=none; b=hRNSvB2xL3DFn2W4SkgUE5hIH+VqduV2VqeYqdigWCxXcfpljP3nq0ZqJ/PHcraNGCJba5zJG6wLTgFz6Fde60lvitXwR9jkoS3zIsq+7+JJWfuWrR0gIww5zg09Dm1G74px5yEzPWhxqC4pliPRrhQjAm2P5n5G5edEyZiE2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707411086; c=relaxed/simple;
	bh=tIaW3xLuqH8lm17q2qqTiYMsh2SjIZu10Kn5Jet9CqY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UHJmx8Q7r6i+4KMwBB9i+sFwzXEAx5snrTI/nmR+1BHi23NZbdUMhom9nOKCUnXf9b1aiaeMx51LGgSIIl2yij3vnX7pyjfDiGvSxqUVnM+3cfhZuB2kweWTvld+vCGn6B2SVe1+nCss2Y/i6e9+V29kncxd/OEcQUBkoZQg8VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=lHTrH5qw; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 418GpGTA002555;
	Thu, 8 Feb 2024 10:51:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707411076;
	bh=djSA4+7Ibdz7Va5HFpgHql2bnc9z2IocCEFA1yBcywI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=lHTrH5qwf6zZcD9wa8FJDcRIJs39q2djIwnzu2/c+Z1iMyY9ez4a0jOE0uUyXHzcF
	 ysUjAs8xwz/C1/Bs+NrlWbXnDmB96OH23gSI41T+bNcjVlW1NPSUcayjr3NV+J1XzX
	 qz+3Jb4qCTPtQp+ikRgg4lOYbZD5UiSC9/Zgv2Qo=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 418GpGCC021887
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 8 Feb 2024 10:51:16 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 8
 Feb 2024 10:51:16 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 8 Feb 2024 10:51:16 -0600
Received: from lelvsmtp5.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 418GpFwE063394;
	Thu, 8 Feb 2024 10:51:16 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH v2 3/4] hwspinlock: omap: Use devm_hwspin_lock_register() helper
Date: Thu, 8 Feb 2024 10:51:13 -0600
Message-ID: <20240208165114.63148-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208165114.63148-1-afd@ti.com>
References: <20240208165114.63148-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This will unregister the HW spinlock on module exit automatically for us,
currently we manually unregister which can be error-prone if not done in
the right order. This also allows us to remove the remove callback.
Do that here.

Signed-off-by: Andrew Davis <afd@ti.com>
---

Changes for v2:
 - Clarify commit message

 drivers/hwspinlock/omap_hwspinlock.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 3bd3ffab92100..fe73da80018b1 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -117,27 +117,13 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, bank);
-
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	return hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
+	return devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
 						base_id, num_locks);
 }
 
-static void omap_hwspinlock_remove(struct platform_device *pdev)
-{
-	struct hwspinlock_device *bank = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = hwspin_lock_unregister(bank);
-	if (ret) {
-		dev_err(&pdev->dev, "%s failed: %d\n", __func__, ret);
-		return;
-	}
-}
-
 static const struct of_device_id omap_hwspinlock_of_match[] = {
 	{ .compatible = "ti,omap4-hwspinlock", },
 	{ .compatible = "ti,am64-hwspinlock", },
@@ -148,7 +134,6 @@ MODULE_DEVICE_TABLE(of, omap_hwspinlock_of_match);
 
 static struct platform_driver omap_hwspinlock_driver = {
 	.probe		= omap_hwspinlock_probe,
-	.remove_new	= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
 		.of_match_table = omap_hwspinlock_of_match,
-- 
2.39.2


