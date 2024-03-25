Return-Path: <linux-kernel+bounces-117052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D54B788A66E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74EC61F61BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB84013A3E5;
	Mon, 25 Mar 2024 12:47:51 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509726FE2D;
	Mon, 25 Mar 2024 12:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711370871; cv=none; b=pCbIDMHTFiSCAR43gBUFEPbgyqQy0BdZtcF0kiRbqpAAVEMs2STBXynqhfCAu0+dXU09+PzFzK9lFk8v87xmUoHA/3BJTDxSzIp0liVzqRC7y012VHkk8Dayy/WZy6ENxmOFnSX15Ox3z6Mq8MhPyvjeCE6FB18818RkeyAOwwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711370871; c=relaxed/simple;
	bh=mBicbAa7DcKhcQvMOw8XzGlYsNKqsCpwlWVUsLePb4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCzk8QsHmFvuzcC77X2CvrPIoYLR7qsvY7PHk8duNOq+8yeokF54o05to0n5xptpQDmWmh/KOGHu7/68WgMsrXUPlN9X0cIFQcWMgZBpNvqgNLcQw9ndcDG5L/p2YIXG9TM2gxNe4ssR9BesRqd7U4SKyNHmLi3+iHSILFghAUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4V3CPG3jtWz1vxgV;
	Mon, 25 Mar 2024 20:46:58 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id F253C1A0188;
	Mon, 25 Mar 2024 20:47:46 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 25 Mar 2024 20:47:46 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>,
	<jiri@resnulli.us>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V4 net 2/3] net: hns3: fix kernel crash when devlink reload during pf initialization
Date: Mon, 25 Mar 2024 20:43:10 +0800
Message-ID: <20240325124311.1866197-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240325124311.1866197-1-shaojijie@huawei.com>
References: <20240325124311.1866197-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Yonglong Liu <liuyonglong@huawei.com>

The devlink reload process will access the hardware resources,
but the register operation is done before the hardware is initialized.
So, processing the devlink reload during initialization may lead to kernel
crash. This patch fixes this by taking devl_lock during initialization.

Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index b4afb66efe5c..ff6a2ed23ddb 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -11626,6 +11626,8 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 	if (ret)
 		goto err_pci_uninit;
 
+	devl_lock(hdev->devlink);
+
 	/* Firmware command queue initialize */
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
@@ -11805,6 +11807,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 
 	hclge_task_schedule(hdev, round_jiffies_relative(HZ));
 
+	devl_unlock(hdev->devlink);
 	return 0;
 
 err_mdiobus_unreg:
@@ -11817,6 +11820,7 @@ static int hclge_init_ae_dev(struct hnae3_ae_dev *ae_dev)
 err_cmd_uninit:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 err_devlink_uninit:
+	devl_unlock(hdev->devlink);
 	hclge_devlink_uninit(hdev);
 err_pci_uninit:
 	pcim_iounmap(pdev, hdev->hw.hw.io_base);
-- 
2.30.0


