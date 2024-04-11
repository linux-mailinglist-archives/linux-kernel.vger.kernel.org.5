Return-Path: <linux-kernel+bounces-139706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D690E8A06B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8FF01C223B0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3133913BC1B;
	Thu, 11 Apr 2024 03:27:40 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABFC13B7BC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806059; cv=none; b=i57b1P07soo8kWAyC+hzDFNK0ARxvOkf2CkCvINPlXLhJ5828J2rzuqEBc6hG4A+A9JTLlO0YUFdbcvqAkIrlx4ArAHVQ6X0eSrPJNGra0bMyQ8AEVACsp1IGjur2b0/TGA9lZmDfmoPnt5fHTVnaqgFOMj0pVdueiQ80jQb/1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806059; c=relaxed/simple;
	bh=MYfEYFO5p+lVlBUiv067qCyD2JDgfl3EUV51g9scmeo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bOMfWMmC5X5Lr9h8a1uV/7pwJAHOPwkU9B0u4goRjOOdzKOszipvT+a80US7a9Kjm1sB++4A5o8gaZ8leZ8pDs2QZRaRfK5SJ1hsE4uogXbeY0MZh9GYLuyTpVxx2LLlxt7bqYfO0UZrfSb9cuVtQf0h1P9dir9+M5MlOiNP6Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFQ6f5T02z2NW6b;
	Thu, 11 Apr 2024 11:24:42 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 1698B1400D9;
	Thu, 11 Apr 2024 11:27:35 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:27:34 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <ben.hutchings@mind.be>,
	<daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 4/4] ubi: debugfs: Replace IS_ERR_OR_NULL with IS_ERR in error checking path
Date: Thu, 11 Apr 2024 11:19:03 +0800
Message-ID: <20240411031903.3050278-5-chengzhihao1@huawei.com>
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

Function debugfs_create_dir will return error pointer rather than NULL
if it fails, replace IS_ERR_OR_NULL with IS_ERR just like other places
(eg. fault_create_debugfs_attr).

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/debug.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mtd/ubi/debug.c b/drivers/mtd/ubi/debug.c
index 989744eb85a5..3bcdf4e70a0a 100644
--- a/drivers/mtd/ubi/debug.c
+++ b/drivers/mtd/ubi/debug.c
@@ -248,11 +248,9 @@ static void dfs_create_fault_entry(struct dentry *parent)
 	struct dentry *dir;
 
 	dir = debugfs_create_dir("fault_inject", parent);
-	if (IS_ERR_OR_NULL(dir)) {
-		int err = dir ? PTR_ERR(dir) : -ENODEV;
-
+	if (IS_ERR(dir)) {
 		pr_warn("UBI error: cannot create \"fault_inject\" debugfs directory, error %d\n",
-			 err);
+			(int)PTR_ERR(dir));
 		return;
 	}
 
@@ -299,11 +297,9 @@ void ubi_debugfs_init(void)
 		return;
 
 	dfs_rootdir = debugfs_create_dir("ubi", NULL);
-	if (IS_ERR_OR_NULL(dfs_rootdir)) {
-		int err = dfs_rootdir ? PTR_ERR(dfs_rootdir) : -ENODEV;
-
+	if (IS_ERR(dfs_rootdir)) {
 		pr_warn("UBI error: cannot create \"ubi\" debugfs directory, error %d\n",
-			err);
+			(int)PTR_ERR(dfs_rootdir));
 		return;
 	}
 
-- 
2.39.2


