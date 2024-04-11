Return-Path: <linux-kernel+bounces-139704-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA718A06AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78EAF1F21D87
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B41913BADC;
	Thu, 11 Apr 2024 03:27:39 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA2113B789
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806059; cv=none; b=dH18ORbdqb+X61FAghnvN2K0CkKBFFs2nYCOPSmo4JRjgCfIpCmKfyv0M8XZhsG+yUUrQu1PxLKqQ14uozNqGKg4Uf8qaKtOwf/U0ByBcSwZq+8XdKMdYDvzZUnOUo2w225gSDHFWElPoQO7GTH3hQD9kUMFNWUrWJ8YPdTOGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806059; c=relaxed/simple;
	bh=93K9yPJ/OkrmBfeRLTnPWDgnrK6oTCBJ88EOvPqTRp4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLMJ2yX+64UliFPD8ICx+hiCzW4VqJzwD7szr0FYg6mSsZmYisXs5GRiP9390loeSdyvUQVMBhtb42OWuEWAYFxN29WWSejY85rHTArfrGxE4Z98gEgaBFD/vT0OmyS4CVOkXUKBgKejAJ9MytvluTxq9tomsMrMRvpdHdFqYpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VFQ7K08L2zNnZn;
	Thu, 11 Apr 2024 11:25:17 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id DA6661403D2;
	Thu, 11 Apr 2024 11:27:33 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:27:33 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <ben.hutchings@mind.be>,
	<daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/4] ubi: ubi_init: Fix missed ubiblock cleanup in error handling path
Date: Thu, 11 Apr 2024 11:19:01 +0800
Message-ID: <20240411031903.3050278-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240411031903.3050278-1-chengzhihao1@huawei.com>
References: <20240411031903.3050278-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600013.china.huawei.com (7.193.23.68)

The ubiblock_init called by ubi_init will register device number, but
device number is not released in error handling path of ubi_init when
ubi is loaded by inserting module (eg. attaching failure), which leads
to subsequent ubi_init calls failed by running out of device number
(dmesg shows that "__register_blkdev: failed to get major for ubiblock").
Since ubiblock_init() registers notifier and invokes notification
functions, so we can move it after ubi_init_attach() to fix the problem.

Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 51 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 7f95fd7968a8..bc63fbf5e947 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1263,9 +1263,21 @@ static struct mtd_notifier ubi_mtd_notifier = {
 	.remove = ubi_notify_remove,
 };
 
+static void detach_mtd_devs(int count)
+{
+	int i;
+
+	for (i = 0; i < count; i++)
+		if (ubi_devices[i]) {
+			mutex_lock(&ubi_devices_mutex);
+			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
+			mutex_unlock(&ubi_devices_mutex);
+		}
+}
+
 static int __init ubi_init_attach(void)
 {
-	int err, i, k;
+	int err, i;
 
 	/* Attach MTD devices */
 	for (i = 0; i < mtd_devs; i++) {
@@ -1317,12 +1329,7 @@ static int __init ubi_init_attach(void)
 	return 0;
 
 out_detach:
-	for (k = 0; k < i; k++)
-		if (ubi_devices[k]) {
-			mutex_lock(&ubi_devices_mutex);
-			ubi_detach_mtd_dev(ubi_devices[k]->ubi_num, 1);
-			mutex_unlock(&ubi_devices_mutex);
-		}
+	detach_mtd_devs(i);
 	return err;
 }
 #ifndef CONFIG_MTD_UBI_MODULE
@@ -1366,15 +1373,6 @@ static int __init ubi_init(void)
 	if (err)
 		goto out_slab;
 
-	err = ubiblock_init();
-	if (err) {
-		pr_err("UBI error: block: cannot initialize, error %d\n", err);
-
-		/* See comment above re-ubi_is_module(). */
-		if (ubi_is_module())
-			goto out_debugfs;
-	}
-
 	register_mtd_user(&ubi_mtd_notifier);
 
 	if (ubi_is_module()) {
@@ -1383,11 +1381,21 @@ static int __init ubi_init(void)
 			goto out_mtd_notifier;
 	}
 
+	err = ubiblock_init();
+	if (err) {
+		pr_err("UBI error: block: cannot initialize, error %d\n", err);
+
+		/* See comment above re-ubi_is_module(). */
+		if (ubi_is_module())
+			goto out_detach;
+	}
+
 	return 0;
 
+out_detach:
+	detach_mtd_devs(mtd_devs);
 out_mtd_notifier:
 	unregister_mtd_user(&ubi_mtd_notifier);
-out_debugfs:
 	ubi_debugfs_exit();
 out_slab:
 	kmem_cache_destroy(ubi_wl_entry_slab);
@@ -1403,17 +1411,10 @@ device_initcall(ubi_init);
 
 static void __exit ubi_exit(void)
 {
-	int i;
-
 	ubiblock_exit();
 	unregister_mtd_user(&ubi_mtd_notifier);
 
-	for (i = 0; i < UBI_MAX_DEVICES; i++)
-		if (ubi_devices[i]) {
-			mutex_lock(&ubi_devices_mutex);
-			ubi_detach_mtd_dev(ubi_devices[i]->ubi_num, 1);
-			mutex_unlock(&ubi_devices_mutex);
-		}
+	detach_mtd_devs(UBI_MAX_DEVICES);
 	ubi_debugfs_exit();
 	kmem_cache_destroy(ubi_wl_entry_slab);
 	misc_deregister(&ubi_ctrl_cdev);
-- 
2.39.2


