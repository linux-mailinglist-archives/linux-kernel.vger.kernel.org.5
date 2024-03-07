Return-Path: <linux-kernel+bounces-94810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F38B87457E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:07:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50F3E283133
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DC417551;
	Thu,  7 Mar 2024 01:06:24 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DF4441F;
	Thu,  7 Mar 2024 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773584; cv=none; b=VmqfsdSXR841/ciSEsUtyFvV01dZU9g3cj5cSubzlpppTZgBRcVW8MKcxSNWGOn0BFV6+fyu0Hi0WLWvN1mtjS960Ox3m+o86xfkNgi9klBC9pufb982QCjutyQkduDMeSHrtnL3ivZ65/FO7kXBTpDxU4GtnTyoUPlZePEjcLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773584; c=relaxed/simple;
	bh=DX48RV47OzBnXclpfmlm6rGmKGY9E4cUG+76FGHaRAU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jxf2dVllO/WFu+I/BPtqIjQ4AjsWDVwzw1KrpqhELRt4cD/jNH/UYmvrsfDnPMPA9g/FrxzVWqZLnr5mGltEWAdgi0slBWA7oDTRojA/W9nasxkX3X+HrscSYvD5Z9UwIgq7InddDqSUf0LeRncafzQdXjIu/Ffs7plrocAPB30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TqrhH1Z57zbcnS;
	Thu,  7 Mar 2024 09:05:35 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id D8C9C18007B;
	Thu,  7 Mar 2024 09:06:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:17 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 6/8] net: hns3: fix reset timeout under full functions and queues
Date: Thu, 7 Mar 2024 09:01:13 +0800
Message-ID: <20240307010115.3054770-7-shaojijie@huawei.com>
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

The cmdq reset command times out when all VFs are enabled and the queue is
full. The hardware processing time exceeds the timeout set by the driver.
In order to avoid the above extreme situations, the driver extends the
reset timeout to 1 second.

Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c    | 2 +-
 .../net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
index d92ad6082d8e..652d71326231 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.c
@@ -351,7 +351,7 @@ static int hclge_comm_cmd_csq_done(struct hclge_comm_hw *hw)
 static u32 hclge_get_cmdq_tx_timeout(u16 opcode, u32 tx_timeout)
 {
 	static const struct hclge_cmdq_tx_timeout_map cmdq_tx_timeout_map[] = {
-		{HCLGE_OPC_CFG_RST_TRIGGER, HCLGE_COMM_CMDQ_TX_TIMEOUT_500MS},
+		{HCLGE_OPC_CFG_RST_TRIGGER, HCLGE_COMM_CMDQ_CFG_RST_TIMEOUT},
 	};
 	u32 i;
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
index 533c19d25e4f..552396518e08 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_common/hclge_comm_cmd.h
@@ -55,7 +55,7 @@
 #define HCLGE_COMM_NIC_CMQ_DESC_NUM_S		3
 #define HCLGE_COMM_NIC_CMQ_DESC_NUM		1024
 #define HCLGE_COMM_CMDQ_TX_TIMEOUT_DEFAULT	30000
-#define HCLGE_COMM_CMDQ_TX_TIMEOUT_500MS	500000
+#define HCLGE_COMM_CMDQ_CFG_RST_TIMEOUT		1000000
 
 enum hclge_opcode_type {
 	/* Generic commands */
-- 
2.30.0


