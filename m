Return-Path: <linux-kernel+bounces-35617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DC839420
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14B8CB24232
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB79861694;
	Tue, 23 Jan 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G8qj7J2R"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7498A6166B;
	Tue, 23 Jan 2024 16:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025862; cv=none; b=e0r/4qVdiTlOFXDpubSkpYWxKadmnQj8q/2lSiY2Rihncs1yBaMGaHG9ATSJM0oS3yb75Oa/UWGQckD8Hxyi3vlklmoco0C1RFqCwFzwXTbagnxqqBkGeIFKbHeSZxxx5v3tqM2LfTIs6MPoXHkfHqjp1jk4k8EqWzjAXBdU7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025862; c=relaxed/simple;
	bh=Q/SZS6GhaE6ELyIwNwypREOPbsnP8QkcslPGuA4/nj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X4kkj6iOxiAD32FO2dHydfcgqAReTH2mPMkI6N/rxgFCGJ9N4NIoesa0ejUxNppTwgQrQHO5J2oi9IaYagieSUI4odmPFvJeUlprIjhtupiH8aOLH/vRUhLlTxYgc9ElNQHu8Eh+Fmu0kw+nS98Ba8EfGvsVUDgnkssWlornVN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G8qj7J2R; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 40NG47CJ063310;
	Tue, 23 Jan 2024 10:04:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1706025847;
	bh=kBACR/xATS3KvpVHmVOi88JdMi5JfchMS/X6cMxpBi0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=G8qj7J2RJ57l7P1uxl1jSScoU+yW9YCfq0txp2ptW9MhHo5n7Y/oCp+c4aKYCuwm/
	 OKTNZUhZ8LNRDwRC/qdM8m+c+wpKJAeBnakRKfE6otqXtW3c+ir+Mng8Ys5aKAlqdV
	 hhnNIGMY+r4M9Xrn4ZwHxhQXvhBOskqU+MJxDQE8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 40NG47M0101666
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 23 Jan 2024 10:04:07 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 23
 Jan 2024 10:04:06 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 23 Jan 2024 10:04:06 -0600
Received: from lelvsmtp6.itg.ti.com ([10.249.42.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 40NG45he078075;
	Tue, 23 Jan 2024 10:04:06 -0600
From: Andrew Davis <afd@ti.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Baolin Wang
	<baolin.wang@linux.alibaba.com>
CC: <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Andrew Davis <afd@ti.com>
Subject: [PATCH 3/4] hwspinlock: omap: Use devm_hwspin_lock_register() helper
Date: Tue, 23 Jan 2024 10:04:04 -0600
Message-ID: <20240123160405.360437-3-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240123160405.360437-1-afd@ti.com>
References: <20240123160405.360437-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This unregister the HW spinlock on module exit, allowing us to
remove the remove callback. Do this here.

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/hwspinlock/omap_hwspinlock.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/hwspinlock/omap_hwspinlock.c b/drivers/hwspinlock/omap_hwspinlock.c
index 2f18ea6c05e3f..1b0a1bea2b24a 100644
--- a/drivers/hwspinlock/omap_hwspinlock.c
+++ b/drivers/hwspinlock/omap_hwspinlock.c
@@ -117,12 +117,10 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	if (!bank)
 		return -ENOMEM;
 
-	platform_set_drvdata(pdev, bank);
-
 	for (i = 0, hwlock = &bank->lock[0]; i < num_locks; i++, hwlock++)
 		hwlock->priv = io_base + LOCK_BASE_OFFSET + sizeof(u32) * i;
 
-	ret = hwspin_lock_register(bank, &pdev->dev, &omap_hwspinlock_ops,
+	ret = devm_hwspin_lock_register(&pdev->dev, bank, &omap_hwspinlock_ops,
 						base_id, num_locks);
 	if (ret)
 		return ret;
@@ -133,18 +131,6 @@ static int omap_hwspinlock_probe(struct platform_device *pdev)
 	return 0;
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
@@ -155,7 +141,6 @@ MODULE_DEVICE_TABLE(of, omap_hwspinlock_of_match);
 
 static struct platform_driver omap_hwspinlock_driver = {
 	.probe		= omap_hwspinlock_probe,
-	.remove_new	= omap_hwspinlock_remove,
 	.driver		= {
 		.name	= "omap_hwspinlock",
 		.of_match_table = omap_hwspinlock_of_match,
-- 
2.39.2


