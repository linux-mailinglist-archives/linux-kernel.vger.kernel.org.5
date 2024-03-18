Return-Path: <linux-kernel+bounces-106171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 851D687EA2D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 14:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09AC2B21BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 13:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF84E1BD;
	Mon, 18 Mar 2024 13:35:01 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABB5481D8;
	Mon, 18 Mar 2024 13:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710768901; cv=none; b=Q6rcDUpjAmZrcHWkq7ewWxkIEdLIbRd4Gs51438NE4pw1KakmiQ9AK1JLaFL79XUOeMBITcv1SCsH9zrDANITbxQcGSgpMXNIi+BDFFQNeGcHpa408OsRVIx4D3qLAhBqtizU6ZRab/wamI6zxtoTNrH4DAbSl7/WXeqZDCXKVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710768901; c=relaxed/simple;
	bh=VQWDUdlil+D7s6UCO8MRlnhRfjmkde8Ho6aysmnW58g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQpr/cwoKQwAYBg3VMoy4K52rOWBfGTOUi49hoiYZv//w/Qxt7VyIlfNfEcelqb20MHwsmiWQPU6/dRN+Pzt/TrVJhx57cXjPtoiKgYk1uJ2oysz+RFcWJnvJKwxob9d+0iM1O1UuMy412qWivIbD2tBm/JhUnP+QwleNwMhY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Tywlb2PX4zNmDH;
	Mon, 18 Mar 2024 21:32:59 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 95584140259;
	Mon, 18 Mar 2024 21:34:50 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 18 Mar 2024 21:34:49 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.kubiak@intel.com>, <rkannoth@marvell.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V3 net 1/3] net: hns3: fix index limit to support all queue stats
Date: Mon, 18 Mar 2024 21:29:46 +0800
Message-ID: <20240318132948.3624333-2-shaojijie@huawei.com>
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

From: Jie Wang <wangjie125@huawei.com>

Currently, hns hardware supports more than 512 queues and the index limit
in hclge_comm_tqps_update_stats is wrong. So this patch removes it.

Fixes: 287db5c40d15 ("net: hns3: create new set of common tqp stats APIs for PF and VF reuse")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
index f3c9395d8351..618f66d9586b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_tqp_stats.c
@@ -85,7 +85,7 @@ int hclge_comm_tqps_update_stats(struct hnae3_handle *handle,
 		hclge_comm_cmd_setup_basic_desc(&desc, HCLGE_OPC_QUERY_TX_STATS,
 						true);
 
-		desc.data[0] = cpu_to_le32(tqp->index & 0x1ff);
+		desc.data[0] = cpu_to_le32(tqp->index);
 		ret = hclge_comm_cmd_send(hw, &desc, 1);
 		if (ret) {
 			dev_err(&hw->cmq.csq.pdev->dev,
-- 
2.30.0


