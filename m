Return-Path: <linux-kernel+bounces-94806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 38943874577
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:06:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4436AB23F95
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC024C98;
	Thu,  7 Mar 2024 01:06:21 +0000 (UTC)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36855223;
	Thu,  7 Mar 2024 01:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773581; cv=none; b=g5G9GVXaP0ErPlm9KO2sAz/9CDB1AZHy+tQnrz2zDzmufsC+DLfh6DG94tM53ESOBKcEhLhDsQsR+iWvxi/DffxeLT6LHyu+CPY1D9cY+qZD31iaXxHbPm9gCN/gpR4R3Xggog2I1Xh7q4udjboaXa/PVmzkLUjGVvQ0jjZDtBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773581; c=relaxed/simple;
	bh=zGD3CWzZVVO+oRO8tqjeyjC00p9kFE3lDj86aoJkXbY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c5ZGHCXTC25+QlEZhPG3FjzJu36d3xUTrQaLSgzlDhBbPsErR/WWoZ/5xUJr55BpaoW7PtMb31gIIc7fY0khzFIa5vkegxXfw31NNlOp2fD4uAZlfpfItvGMCPpsbMfawXKrL1xRzeIQPsq4kSMTH0qgfwXLK/c7i4rqWkpHunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4TqrhG4drvz27g30;
	Thu,  7 Mar 2024 09:05:34 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EC691A016C;
	Thu,  7 Mar 2024 09:06:15 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:14 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/8] net: hns3: fix wrong judgment condition issue
Date: Thu, 7 Mar 2024 09:01:08 +0800
Message-ID: <20240307010115.3054770-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240307010115.3054770-1-shaojijie@huawei.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600007.china.huawei.com (7.193.23.208)

In hns3_dcbnl_ieee_delapp, should check ieee_delapp not ieee_setapp.
This path fix the wrong judgment.

Fixes: 0ba22bcb222d ("net: hns3: add support config dscp map to tc")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
index 3b6dbf158b98..f72dc0cee30e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_dcbnl.c
@@ -76,7 +76,7 @@ static int hns3_dcbnl_ieee_delapp(struct net_device *ndev, struct dcb_app *app)
 	if (hns3_nic_resetting(ndev))
 		return -EBUSY;
 
-	if (h->kinfo.dcb_ops->ieee_setapp)
+	if (h->kinfo.dcb_ops->ieee_delapp)
 		return h->kinfo.dcb_ops->ieee_delapp(h, app);
 
 	return -EOPNOTSUPP;
-- 
2.30.0


