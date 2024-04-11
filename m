Return-Path: <linux-kernel+bounces-139703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC05C8A06AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58AEE1F22DB9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 03:27:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38DB313BAD0;
	Thu, 11 Apr 2024 03:27:39 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454021F176
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 03:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712806058; cv=none; b=DLcTS5xO5tY03X0/xv+TdxFww8ALXkdJUn/7XtK/Y7pt6gs3+LkXq6NAAlAsYt55/NNKPXh/QKs860LIbHyelOaGxlLmcJYVUzb6PHKEsWM2mfl4P6bVfZvE962sY1J3znclTFGGEjYO5+UJmky4rWkkJZg9C74o8UVSxJqPGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712806058; c=relaxed/simple;
	bh=L7+yEMnAAQhrm90UXztYYYVX1BAD5yIkJu/9V9n1ex4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5AThAW9rMEYw6VI7j+EZeAGw3P9OtDQTsycG3crmZmNJwFwtrZoYFL9AFq0hLtqNPoK3JPEilUd8eU0hfsfgDUTdsouWkd6lEw/q6rEayHYF7T1zrHcBr4GoS5DraTTAHaL6P7TKeBN2gK9wFZYVxte80sX4DRMiUzvuenA7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VFQ923Rjpz1GGdb;
	Thu, 11 Apr 2024 11:26:46 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D2541A0172;
	Thu, 11 Apr 2024 11:27:33 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 11 Apr
 2024 11:27:32 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <miquel.raynal@bootlin.com>, <ben.hutchings@mind.be>,
	<daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] ubi: ubi_init: Fix missed debugfs cleanup in error handling path
Date: Thu, 11 Apr 2024 11:19:00 +0800
Message-ID: <20240411031903.3050278-2-chengzhihao1@huawei.com>
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

The debugfs dir is created in ubi_init, but it is not destroyed in error
handling path of ubi_init when ubi is loaded by inserting module (eg.
attaching failure), which leads to subsequent ubi_init calls failed.
Fix it by destroying debugfs dir in corresponding error handling path.

Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index a7e3a6246c0e..7f95fd7968a8 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1372,7 +1372,7 @@ static int __init ubi_init(void)
 
 		/* See comment above re-ubi_is_module(). */
 		if (ubi_is_module())
-			goto out_slab;
+			goto out_debugfs;
 	}
 
 	register_mtd_user(&ubi_mtd_notifier);
@@ -1387,6 +1387,8 @@ static int __init ubi_init(void)
 
 out_mtd_notifier:
 	unregister_mtd_user(&ubi_mtd_notifier);
+out_debugfs:
+	ubi_debugfs_exit();
 out_slab:
 	kmem_cache_destroy(ubi_wl_entry_slab);
 out_dev_unreg:
-- 
2.39.2


