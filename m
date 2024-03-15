Return-Path: <linux-kernel+bounces-104247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B4687CB31
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 11:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B269A283DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51771B5AD;
	Fri, 15 Mar 2024 10:12:27 +0000 (UTC)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2E718C31;
	Fri, 15 Mar 2024 10:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710497547; cv=none; b=hEmlxvy2bx4Sr68noqncMX0ksjx2aJJgKif/oLIzfStfm5JcOLUUGwGDrTugfppWNOi00SFEVI/NztYsrmU+tx0Nbd2eoqMN95DmRrSy6UNxZE+45TnTrfTfytZ2DO0vILaFCG7QmUExiWS9bQwdZ5Bkcm/98AB5CdVG8AiKOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710497547; c=relaxed/simple;
	bh=fFexEFvf3qY+UAxuDxDfmyzLxsCkJobefOmJN2deFBY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRIyUKI4JSD4aECbKqIiAujLZx32OgA4XNecv9RlBi0hQIR5RC5E7KSXEUa+7xsJc0DELm7z9iISioYtxtQRt0HmeGFbKiNOikc0BeiIogUrqSE001Aikoj45ZRPvCHzlWDk8Wqt9+oX/1on2K0r9z9vthJktq+v7DM9eRa6Kgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tx0NW1ydHz2Bg1G;
	Fri, 15 Mar 2024 18:09:47 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 44C1C180061;
	Fri, 15 Mar 2024 18:12:16 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 18:12:15 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/3] net: hns3: fix kernel crash when devlink reload during pf initialization
Date: Fri, 15 Mar 2024 18:07:47 +0800
Message-ID: <20240315100748.2913882-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240315100748.2913882-1-shaojijie@huawei.com>
References: <20240315100748.2913882-1-shaojijie@huawei.com>
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
but the register operation is before the hardware initialize
done, so, if process the devlink reload during initializetion,
may lead the kernel crash. This patch check whether the NIC is
initialized to fix the problem.

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


