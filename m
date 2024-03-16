Return-Path: <linux-kernel+bounces-105163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE58287D9E4
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 12:16:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C4CC1F21BE5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 11:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0821B949;
	Sat, 16 Mar 2024 11:16:08 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4656A18059;
	Sat, 16 Mar 2024 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710587767; cv=none; b=q2MYK5q9vQ1t2f8xAgeFVcPusO/OQaiKJ88eF7FxdA5xMCJ8kE5uDDvwKEpv+lXT3Kdqq5hwmvoG/TBbohtxY40WUK6LFwKef+aKKfhE30Jj0ml5xc2PqssROkWIkrWF4ksDSnJmMu+eIuN8VzpV4usS4xk9jwlgxOEs3ZSquhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710587767; c=relaxed/simple;
	bh=+gy86Yn8QCly/y/fFE3PSy+Ai7Flz+Q1dHJYlJ24O6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jx11YaYfyw9ZQbWbPL51YOyUBc7RZ0gKp5s4Obe61vKMG3PcMgGfFWVKwEJ+sHCr80ygk2WZMV5mL03BYzH79lIqc5HxbSQ9gkncktJBnskiGevciHrv8lu4sis9OPSTkoKsreNKM8y4Dsy1+7XuS1785MTiXesOv19v3Mk5tq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TxdlV3YB1zXj7n;
	Sat, 16 Mar 2024 19:13:26 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 116851400CD;
	Sat, 16 Mar 2024 19:15:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 16 Mar 2024 19:15:56 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <michal.kubiak@intel.com>, <shenjian15@huawei.com>,
	<wangjie125@huawei.com>, <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 2/3] net: hns3: fix kernel crash when devlink reload during pf initialization
Date: Sat, 16 Mar 2024 19:10:56 +0800
Message-ID: <20240316111057.277591-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240316111057.277591-1-shaojijie@huawei.com>
References: <20240316111057.277591-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Yonglong Liu <liuyonglong@huawei.com>

The devlink reload process will access the hardware resources,
but the register operation is done before the hardware is initialized.
so, if process the devlink reload during initialization, may lead to kernel
crash. This patch fixes this by checkingwhether the NIC is initialized.

Fixes: b741269b2759 ("net: hns3: add support for registering devlink for PF")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
index 9a939c0b217f..80db4f7b05f6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_devlink.c
@@ -40,8 +40,9 @@ static int hclge_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	struct pci_dev *pdev = hdev->pdev;
 	int ret;
 
-	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state)) {
-		dev_err(&pdev->dev, "reset is handling\n");
+	if (test_bit(HCLGE_STATE_RST_HANDLING, &hdev->state) ||
+	    !test_bit(HCLGE_STATE_NIC_REGISTERED, &hdev->state)) {
+		dev_err(&pdev->dev, "reset is handling or driver removed\n");
 		return -EBUSY;
 	}
 
-- 
2.30.0


