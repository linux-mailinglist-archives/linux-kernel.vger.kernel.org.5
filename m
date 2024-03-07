Return-Path: <linux-kernel+bounces-94809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC0987457C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDFB21C218B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119F411CAF;
	Thu,  7 Mar 2024 01:06:24 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669C54689;
	Thu,  7 Mar 2024 01:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773583; cv=none; b=mZNgo4Dlha8vQEpzzaTYlJU+qE3gDjIvbSyfYJUhCyGmoQmiSZT7jbCm3sPiKgnklCqsEPmqKlt6b3to/B0J71oUtDnBgO4JlW+ic/w1gCP3LfsHzlONAS0SLOworzAVgtAxico3w+xfVa59zUYL1AZ0ApdK22OSHtqNV6UlqEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773583; c=relaxed/simple;
	bh=asqUl2zK5gi5IDYq3bhuT50zBVPJICKW9k0bXYg8Jak=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uZMvMoX+VY5brQ59ym+DZKVMdsi4RuqdVtbt1A3GMn+i3eEQRKWAek4iD/r1gp/2U/m6MXKVAwS5oRbKtwsqhHBfLR11M9uP/nXQ34x6NW0zTSG2YEKsZbLVuALz3n+R+RoK8tXhlaki3VFSKv2Cp0nolZDvTFBcGmBlWOwTTT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TqrgD1XC9zNlsk;
	Thu,  7 Mar 2024 09:04:40 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 015CA18007D;
	Thu,  7 Mar 2024 09:06:19 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:18 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 8/8] net: hns3: add checking for vf id of mailbox
Date: Thu, 7 Mar 2024 09:01:15 +0800
Message-ID: <20240307010115.3054770-9-shaojijie@huawei.com>
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

From: Jian Shen <shenjian15@huawei.com>

Add checking for vf id of mailbox, in order to avoid array
out-of-bounds risk.

Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index 4b0d07ca2505..d4a0e0be7a72 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -1123,10 +1123,11 @@ void hclge_mbx_handler(struct hclge_dev *hdev)
 		req = (struct hclge_mbx_vf_to_pf_cmd *)desc->data;
 
 		flag = le16_to_cpu(crq->desc[crq->next_to_use].flag);
-		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B))) {
+		if (unlikely(!hnae3_get_bit(flag, HCLGE_CMDQ_RX_OUTVLD_B) ||
+			     req->mbx_src_vfid > hdev->num_req_vfs)) {
 			dev_warn(&hdev->pdev->dev,
-				 "dropped invalid mailbox message, code = %u\n",
-				 req->msg.code);
+				 "dropped invalid mailbox message, code = %u, vfid = %u\n",
+				 req->msg.code, req->mbx_src_vfid);
 
 			/* dropping/not processing this invalid message */
 			crq->desc[crq->next_to_use].flag = 0;
-- 
2.30.0


