Return-Path: <linux-kernel+bounces-139705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F63F8A06AF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:27:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 165CE2877EE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0368A13BC05;
	Thu, 11 Apr 2024 03:27:40 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C109413B7B2
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806059; cv=none; b=eemlK3P8tB2WnLlHq+MXLXpv4Pu4kaIL94omVl0fO/e5xmdB7sUTIyu00nRtWPLa+rPPGuOSe51/8CYEjQFye+6VN2On3nhnP9/Tw3F+uosTbsz/cBn6i2TAlbTvX4kN5/uOolGr7Y9S5aCtD43Zls2OoVOCIrnFCYwtMX1B2/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806059; c=relaxed/simple;
	bh=zCUBVZmIFA50KAFqtwpR62t5pnW7dubKEYLtAm2lWkg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaltXBBjvfrdajJtlhg4ZxLpcJrx6fwh8Z9tYeRGtxcQPUjLaKeveK0gl3hYyuigaSej77ZHalFk1Ck5CK0kkqigsqhiYEFkoTB4gQZKl+5kmxKxQWHNlxm8SsFQPTbqaxFMUF9XHnSCIntbL20sMvOOh1BwwteKJ2QMqouIEbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VFQ8r0LBrzShb4;
	Thu, 11 Apr 2024 11:26:36 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 7F64518007A;
	Thu, 11 Apr 2024 11:27:34 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:27:33 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <ben.hutchings@mind.be>,
	<daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] mtd: ubi: Ignore all debugfs initialisation failures
Date: Thu, 11 Apr 2024 11:19:02 +0800
Message-ID: <20240411031903.3050278-4-chengzhihao1@huawei.com>
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

From: Ben Hutchings <ben.hutchings@mind.be>

Drivers should never stop initialising or probing because of a failure
to create debugfs entries.  Such failures are harmless and could be
the intended result of setting the kernel parameter debugfs=off.

This was partially fixed in 2019, but some error checks were missed
and another one was been added since.

Signed-off-by: Ben Hutchings <ben.hutchings@mind.be>
Fixes: 2a734bb8d502 ("UBI: use debugfs for the extra checks knobs")
Fixes: c2d73ba892ea ("mtd: no need to check return value of ...")
Fixes: 6931fb44858c ("ubi: Use the fault injection framework to enhance ...")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 10 ++--------
 drivers/mtd/ubi/debug.c | 25 ++++++++++---------------
 drivers/mtd/ubi/debug.h |  4 ++--
 3 files changed, 14 insertions(+), 25 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index bc63fbf5e947..6d8212a51fec 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1018,9 +1018,7 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 	if (err)
 		goto out_detach;
 
-	err = ubi_debugfs_init_dev(ubi);
-	if (err)
-		goto out_uif;
+	ubi_debugfs_init_dev(ubi);
 
 	ubi->bgt_thread = kthread_create(ubi_thread, ubi, "%s", ubi->bgt_name);
 	if (IS_ERR(ubi->bgt_thread)) {
@@ -1064,7 +1062,6 @@ int ubi_attach_mtd_dev(struct mtd_info *mtd, int ubi_num,
 
 out_debugfs:
 	ubi_debugfs_exit_dev(ubi);
-out_uif:
 	uif_close(ubi);
 out_detach:
 	ubi_wl_close(ubi);
@@ -1369,9 +1366,7 @@ static int __init ubi_init(void)
 		goto out_dev_unreg;
 	}
 
-	err = ubi_debugfs_init();
-	if (err)
-		goto out_slab;
+	ubi_debugfs_init();
 
 	register_mtd_user(&ubi_mtd_notifier);
 
@@ -1397,7 +1392,6 @@ static int __init ubi_init(void)
 out_mtd_notifier:
 	unregister_mtd_user(&ubi_mtd_notifier);
 	ubi_debugfs_exit();
-out_slab:
 	kmem_cache_destroy(ubi_wl_entry_slab);
 out_dev_unreg:
 	misc_deregister(&ubi_ctrl_cdev);
diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index d57f52bd2ff3..989744eb85a5 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -291,28 +291,25 @@ static void dfs_create_fault_entry(struct dentry *parent)
 /**
  * ubi_debugfs_init - create UBI debugfs directory.
  *
- * Create UBI debugfs directory. Returns zero in case of success and a negative
- * error code in case of failure.
+ * Try to create UBI debugfs directory.
  */
-int ubi_debugfs_init(void)
+void ubi_debugfs_init(void)
 {
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
-		return 0;
+		return;
 
 	dfs_rootdir = debugfs_create_dir("ubi", NULL);
 	if (IS_ERR_OR_NULL(dfs_rootdir)) {
 		int err = dfs_rootdir ? PTR_ERR(dfs_rootdir) : -ENODEV;
 
-		pr_err("UBI error: cannot create \"ubi\" debugfs directory, error %d\n",
-		       err);
-		return err;
+		pr_warn("UBI error: cannot create \"ubi\" debugfs directory, error %d\n",
+			err);
+		return;
 	}
 
 #ifdef CONFIG_MTD_UBI_FAULT_INJECTION
 	dfs_create_fault_entry(dfs_rootdir);
 #endif
-
-	return 0;
 }
 
 /**
@@ -585,10 +582,9 @@ static const struct file_operations eraseblk_count_fops = {
  * ubi_debugfs_init_dev - initialize debugfs for an UBI device.
  * @ubi: UBI device description object
  *
- * This function creates all debugfs files for UBI device @ubi. Returns zero in
- * case of success and a negative error code in case of failure.
+ * This function tries to create all debugfs files for UBI device @ubi.
  */
-int ubi_debugfs_init_dev(struct ubi_device *ubi)
+void ubi_debugfs_init_dev(struct ubi_device *ubi)
 {
 	unsigned long ubi_num = ubi->ubi_num;
 	struct ubi_debug_info *d = &ubi->dbg;
@@ -596,13 +592,13 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 	int n;
 
 	if (!IS_ENABLED(CONFIG_DEBUG_FS))
-		return 0;
+		return;
 
 	n = snprintf(d->dfs_dir_name, UBI_DFS_DIR_LEN + 1, UBI_DFS_DIR_NAME,
 		     ubi->ubi_num);
 	if (n > UBI_DFS_DIR_LEN) {
 		/* The array size is too small */
-		return -EINVAL;
+		return;
 	}
 
 	d->dfs_dir = debugfs_create_dir(d->dfs_dir_name, dfs_rootdir);
@@ -653,7 +649,6 @@ int ubi_debugfs_init_dev(struct ubi_device *ubi)
 						       (void *)ubi_num,
 						       &dfs_fops);
 #endif
-	return 0;
 }
 
 /**
diff --git a/drivers/mtd/ubi/debug.h b/drivers/mtd/ubi/debug.h
index b2fd97548808..1dc430d3f482 100644
--- a/drivers/mtd/ubi/debug.h
+++ b/drivers/mtd/ubi/debug.h
@@ -47,9 +47,9 @@ void ubi_dump_aeb(const struct ubi_ainf_peb *aeb, int type);
 void ubi_dump_mkvol_req(const struct ubi_mkvol_req *req);
 int ubi_self_check_all_ff(struct ubi_device *ubi, int pnum, int offset,
 			  int len);
-int ubi_debugfs_init(void);
+void ubi_debugfs_init(void);
 void ubi_debugfs_exit(void);
-int ubi_debugfs_init_dev(struct ubi_device *ubi);
+void ubi_debugfs_init_dev(struct ubi_device *ubi);
 void ubi_debugfs_exit_dev(struct ubi_device *ubi);
 
 /**
-- 
2.39.2


