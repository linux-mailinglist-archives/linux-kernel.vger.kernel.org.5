Return-Path: <linux-kernel+bounces-153493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 789E48ACEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECE6BB255D3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD2BB152175;
	Mon, 22 Apr 2024 13:50:02 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12B21514E2;
	Mon, 22 Apr 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793802; cv=none; b=tCYjc/e1oDSIVwGEoU1msrXCWLb4x5p72aeeFkGmbTFuGRbAc7MeqR6aQ8xuU0dV3YZKAFzUjfOpnd6OIsUsY3E/QYrT1M9A2CHNl+k/H5gL5qeZi4EL9naYQjDKXI6pqw+UevFBSlDaTPfrbZRtWRXDVxv75JDZLv4Yep3IM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793802; c=relaxed/simple;
	bh=5yvgi9mrQAF3qOurmIWeU5dX0slS7fJ6ldV2mGba9Lc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JzU4BxWJr2Xsk/4KtjelO975nY3TXsDDD5hk82jQb39wwckjmIsbGqJiASlemakL/KbLfm40RL0Hw+rDQfg/UXbwcxHTMeK/cKCXVLimvDzVtET6rTMy8eCfuQgK+sjOmQkQl1pj94EK977IIcP8MrT01gbVrJatluJLjNns5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNRNy5vlqzXmCw;
	Mon, 22 Apr 2024 21:46:26 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 6D5F318007D;
	Mon, 22 Apr 2024 21:49:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:49:52 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 7/7] net: hns3: fix kernel crash when devlink reload during vf initialization
Date: Mon, 22 Apr 2024 21:43:27 +0800
Message-ID: <20240422134327.3160587-8-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240422134327.3160587-1-shaojijie@huawei.com>
References: <20240422134327.3160587-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Yonglong Liu <liuyonglong@huawei.com>

The devlink reload process will access the hardware resources,
but the register operation is done before the hardware is initialized.
So, processing the devlink reload during initialization may lead to kernel
crash. This patch fixes this by taking devl_lock during initialization.

Fixes: cd6242991d2e ("net: hns3: add support for registering devlink for VF")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 08db8e84be4e..3ee41943d15f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -2849,6 +2849,8 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	if (ret)
 		goto err_devlink_init;
 
+	devl_lock(hdev->devlink);
+
 	ret = hclge_comm_cmd_queue_init(hdev->pdev, &hdev->hw.hw);
 	if (ret)
 		goto err_cmd_queue_init;
@@ -2950,6 +2952,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 	hclgevf_task_schedule(hdev, round_jiffies_relative(HZ));
 	timer_setup(&hdev->reset_timer, hclgevf_reset_timer, 0);
 
+	devl_unlock(hdev->devlink);
 	return 0;
 
 err_config:
@@ -2960,6 +2963,7 @@ static int hclgevf_init_hdev(struct hclgevf_dev *hdev)
 err_cmd_init:
 	hclge_comm_cmd_uninit(hdev->ae_dev, &hdev->hw.hw);
 err_cmd_queue_init:
+	devl_unlock(hdev->devlink);
 	hclgevf_devlink_uninit(hdev);
 err_devlink_init:
 	hclgevf_pci_uninit(hdev);
-- 
2.30.0


