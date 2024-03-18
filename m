Return-Path: <linux-kernel+bounces-106183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B287EA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9895D1C213C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE034AEDD;
	Mon, 18 Mar 2024 13:53:49 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE33B1AA;
	Mon, 18 Mar 2024 13:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710770029; cv=none; b=oAJ5gmoOkXd8VXCXiwcqFDORpWVNkx+wXOyLo+SVLBaPPXTNFrvVJ698hfkBmHnjtyuaLhP85vGeqY1aJ3NOIAMXDWTXNio/zBHbmvRIWRytXHWEnl3xOx/VJ6aS7AlLOABDuEhWdqgyGh6Yb33OqnSUsUcK4W+lsxN/biA4vtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710770029; c=relaxed/simple;
	bh=Vu96on3ELce8oj2lYXDb7Wwq/sWwPtuQ5VXawLVemTk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxiXZ6BcuEjYfkahmS7eN+5KlmaZYDJal4a12hB5lr0qn/eBlfYX/fbwvEDIFBuE36QW5tL/IsL4wSBBuSjYMqffFleEShBFzZsHS35K/2JlNQFUeGxJA9zyQ4RWoxQ0VsNh8yPUtzGrVkQwelTPWH5Y1dd4PvLZymXAL6fLmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Tywkq0z5Vz1QBtL;
	Mon, 18 Mar 2024 21:32:19 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A19C1400CB;
	Mon, 18 Mar 2024 21:34:51 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 21:34:50 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 2/3] net: hns3: fix kernel crash when devlink reload during pf initialization
Date: Mon, 18 Mar 2024 21:29:47 +0800
Message-ID: <20240318132948.3624333-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240318132948.3624333-1-shaojijie@huawei.com>
References: <20240318132948.3624333-1-shaojijie@huawei.com>
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
crash. This patch fixes this by checking whether the NIC is initialized.

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


