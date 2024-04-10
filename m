Return-Path: <linux-kernel+bounces-138101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4598489ECA2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2381F21449
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 07:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758D513D2BC;
	Wed, 10 Apr 2024 07:49:11 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA0613CFB3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 07:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712735351; cv=none; b=SUraNKzXcTgfy1SRT8xeOprhEhYHoQS8y1t5jIqGDG8zSOOg9nL62YSvqzLMAJEkRBtrRjo1gw6tz4YzpmUXxeS/3ZBOyu+FbP6KyHLRzL12tXIfDfDCnTOO0Z9Xz5qXkG2f7L9qYaeZfYUatB48lKAL2vUDMi9JmBSPybhoVvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712735351; c=relaxed/simple;
	bh=A5OJ5xcBefBzmfHqZgZLP9M0J2J7ENMi/66Dyfj/opI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FY+Pjjs5hh+hGc4ugRnpLrV+MGtFejsC6zUACkGfZ5ul0lTBNjA59g2se6gCFduqML63x2WWEV6jCzn5ThJzDhCLBosvybGMvSNgV9QJEdeAzUlwXbDUfTEsRSGjBosgSHxE7bYotkrgXfVB4dBZmFUXOUDnB1fOZrUiZcWsxFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VDvyp4kMszwRt4;
	Wed, 10 Apr 2024 15:46:10 +0800 (CST)
Received: from kwepemm600013.china.huawei.com (unknown [7.193.23.68])
	by mail.maildlp.com (Postfix) with ESMTPS id 01296180072;
	Wed, 10 Apr 2024 15:49:06 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 10 Apr
 2024 15:49:05 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <richard@nod.at>, <daniel@makrotopia.org>
CC: <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ubi: ubi_init: Fix missed ubiblock cleanup in error handling path
Date: Wed, 10 Apr 2024 15:40:33 +0800
Message-ID: <20240410074033.2523399-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410074033.2523399-1-chengzhihao1@huawei.com>
References: <20240410074033.2523399-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)

The ubiblock_init called by ubi_init will register device number, but
device number is not released in error handling path of ubi_init when
ubi is loaded by inserting module (eg. attaching failure), which leads
to subsequent ubi_init calls failed by running out of device number
(dmesg shows that "__register_blkdev: failed to get major for ubiblock").
Fix it by invoking ubiblock_exit() in corresponding error handling path.

Fixes: 927c145208b0 ("mtd: ubi: attach from device tree")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 drivers/mtd/ubi/build.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 7f95fd7968a8..354517194099 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1380,12 +1380,13 @@ static int __init ubi_init(void)
 	if (ubi_is_module()) {
 		err = ubi_init_attach();
 		if (err)
-			goto out_mtd_notifier;
+			goto out_block_exit;
 	}
 
 	return 0;
 
-out_mtd_notifier:
+out_block_exit:
+	ubiblock_exit();
 	unregister_mtd_user(&ubi_mtd_notifier);
 out_debugfs:
 	ubi_debugfs_exit();
-- 
2.39.2


