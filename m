Return-Path: <linux-kernel+bounces-138699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4601589F92A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:02:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A04A1C277C2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537FC16EBF0;
	Wed, 10 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IxwQ81DN"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9991116DEA8;
	Wed, 10 Apr 2024 13:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757593; cv=none; b=e+vRPZnsIulJ8m+3fw/YQQ8Z/iyCnQMnqdbBxV1/J7+YtlA3W+q8nY3lVIAE8ORj7rlAUwsiOTO00wAQAajM6UL1eHUxQrCwSfORSw8S8YmskkY+8bFhlZvwb0MEDsvbT1rPkI1w3hm+xEyE8e/QfllAV6eqGlh0XJpyLiTe2y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757593; c=relaxed/simple;
	bh=ejousKtG/J4bWfv/TAHJeC5ce3md9E9KIoGCUx65dPo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K6tpLA+aSSVSmgNfAQO0aSNMyLWhO4HmWF5pfM6ur7uNgX3mcu++CSpd7kr+AlDb9pYFvUahQIHO7iHZHkm4xD2zKa3ONPg3Mqj8sHOyQuItxq8MrLCy1HnrbpBe08iM9UJko1SW6xgPaGVF+pMLjDlYHaDxHQaj6xzK1shWuoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=IxwQ81DN; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxkOq056744;
	Wed, 10 Apr 2024 08:59:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712757586;
	bh=MvOKONwnd5euFZHq1likssHNvZKP9vx9fWTY5EZX/UI=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=IxwQ81DN1TPdFKs/4BB9j4yq7+OCt+dDkxHqJEGPRngaxmgxHlerAzTfFCG2+Z0Tg
	 cuZ4uJ4H4ztOo0c+anctQsCqIWNAKCY4YQOVj1lhpk5LGSnf7uoxsyjVZpdGzMXBjf
	 KU08WhGKJ+lgAbLiDZzEPDKIxrL9057OV+o7BMDA=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43ADxk7N011498
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 10 Apr 2024 08:59:46 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 10
 Apr 2024 08:59:45 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 10 Apr 2024 08:59:45 -0500
Received: from fllvsmtp8.itg.ti.com ([10.249.42.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43ADxhaq067183;
	Wed, 10 Apr 2024 08:59:45 -0500
From: Andrew Davis <afd@ti.com>
To: Jassi Brar <jassisinghbrar@gmail.com>, Hari Nagalla <hnagalla@ti.com>,
        Nick Saulnier <nsaulnier@ti.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC: <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andrew
 Davis <afd@ti.com>
Subject: [PATCH v2 06/13] mailbox: omap: Remove device class
Date: Wed, 10 Apr 2024 08:59:35 -0500
Message-ID: <20240410135942.61667-7-afd@ti.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410135942.61667-1-afd@ti.com>
References: <20240410135942.61667-1-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The driver currently creates a new device class "mbox". Then for each
mailbox adds a device to that class. This class provides no file
operations provided for any userspace users of this device class.
It may have been extended to be functional in our vendor tree at
some point, but that is not the case anymore, nor does it matter
for the upstream tree.

Remove this device class and related functions and variables.
This also allows us to switch to module_platform_driver() as
there is nothing left to do in module_init().

Signed-off-by: Andrew Davis <afd@ti.com>
---
 drivers/mailbox/omap-mailbox.c | 89 +---------------------------------
 1 file changed, 2 insertions(+), 87 deletions(-)

diff --git a/drivers/mailbox/omap-mailbox.c b/drivers/mailbox/omap-mailbox.c
index 4c673cb732ed1..ea467931faf46 100644
--- a/drivers/mailbox/omap-mailbox.c
+++ b/drivers/mailbox/omap-mailbox.c
@@ -87,7 +87,6 @@ struct omap_mbox_device {
 	u32 intr_type;
 	struct omap_mbox **mboxes;
 	struct mbox_controller controller;
-	struct list_head elem;
 };
 
 struct omap_mbox_fifo_info {
@@ -107,7 +106,6 @@ struct omap_mbox {
 	const char		*name;
 	int			irq;
 	struct omap_mbox_queue	*rxq;
-	struct device		*dev;
 	struct omap_mbox_device *parent;
 	struct omap_mbox_fifo	tx_fifo;
 	struct omap_mbox_fifo	rx_fifo;
@@ -116,10 +114,6 @@ struct omap_mbox {
 	bool			send_no_irq;
 };
 
-/* global variables for the mailbox devices */
-static DEFINE_MUTEX(omap_mbox_devices_lock);
-static LIST_HEAD(omap_mbox_devices);
-
 static unsigned int mbox_kfifo_size = CONFIG_OMAP_MBOX_KFIFO_SIZE;
 module_param(mbox_kfifo_size, uint, S_IRUGO);
 MODULE_PARM_DESC(mbox_kfifo_size, "Size of omap's mailbox kfifo (bytes)");
@@ -395,61 +389,6 @@ static struct omap_mbox *omap_mbox_device_find(struct omap_mbox_device *mdev,
 	return mbox;
 }
 
-static struct class omap_mbox_class = { .name = "mbox", };
-
-static int omap_mbox_register(struct omap_mbox_device *mdev)
-{
-	int ret;
-	int i;
-	struct omap_mbox **mboxes;
-
-	if (!mdev || !mdev->mboxes)
-		return -EINVAL;
-
-	mboxes = mdev->mboxes;
-	for (i = 0; mboxes[i]; i++) {
-		struct omap_mbox *mbox = mboxes[i];
-
-		mbox->dev = device_create(&omap_mbox_class, mdev->dev,
-					0, mbox, "%s", mbox->name);
-		if (IS_ERR(mbox->dev)) {
-			ret = PTR_ERR(mbox->dev);
-			goto err_out;
-		}
-	}
-
-	mutex_lock(&omap_mbox_devices_lock);
-	list_add(&mdev->elem, &omap_mbox_devices);
-	mutex_unlock(&omap_mbox_devices_lock);
-
-	ret = devm_mbox_controller_register(mdev->dev, &mdev->controller);
-
-err_out:
-	if (ret) {
-		while (i--)
-			device_unregister(mboxes[i]->dev);
-	}
-	return ret;
-}
-
-static int omap_mbox_unregister(struct omap_mbox_device *mdev)
-{
-	int i;
-	struct omap_mbox **mboxes;
-
-	if (!mdev || !mdev->mboxes)
-		return -EINVAL;
-
-	mutex_lock(&omap_mbox_devices_lock);
-	list_del(&mdev->elem);
-	mutex_unlock(&omap_mbox_devices_lock);
-
-	mboxes = mdev->mboxes;
-	for (i = 0; mboxes[i]; i++)
-		device_unregister(mboxes[i]->dev);
-	return 0;
-}
-
 static int omap_mbox_chan_startup(struct mbox_chan *chan)
 {
 	struct omap_mbox *mbox = mbox_chan_to_omap_mbox(chan);
@@ -782,7 +721,7 @@ static int omap_mbox_probe(struct platform_device *pdev)
 	mdev->controller.chans = chnls;
 	mdev->controller.num_chans = info_count;
 	mdev->controller.of_xlate = omap_mbox_of_xlate;
-	ret = omap_mbox_register(mdev);
+	ret = devm_mbox_controller_register(mdev->dev, &mdev->controller);
 	if (ret)
 		return ret;
 
@@ -809,7 +748,6 @@ static int omap_mbox_probe(struct platform_device *pdev)
 
 unregister:
 	pm_runtime_disable(mdev->dev);
-	omap_mbox_unregister(mdev);
 	return ret;
 }
 
@@ -818,7 +756,6 @@ static void omap_mbox_remove(struct platform_device *pdev)
 	struct omap_mbox_device *mdev = platform_get_drvdata(pdev);
 
 	pm_runtime_disable(mdev->dev);
-	omap_mbox_unregister(mdev);
 }
 
 static struct platform_driver omap_mbox_driver = {
@@ -830,29 +767,7 @@ static struct platform_driver omap_mbox_driver = {
 		.of_match_table = of_match_ptr(omap_mailbox_of_match),
 	},
 };
-
-static int __init omap_mbox_init(void)
-{
-	int err;
-
-	err = class_register(&omap_mbox_class);
-	if (err)
-		return err;
-
-	err = platform_driver_register(&omap_mbox_driver);
-	if (err)
-		class_unregister(&omap_mbox_class);
-
-	return err;
-}
-subsys_initcall(omap_mbox_init);
-
-static void __exit omap_mbox_exit(void)
-{
-	platform_driver_unregister(&omap_mbox_driver);
-	class_unregister(&omap_mbox_class);
-}
-module_exit(omap_mbox_exit);
+module_platform_driver(omap_mbox_driver);
 
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("omap mailbox: interrupt driven messaging");
-- 
2.39.2


