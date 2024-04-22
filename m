Return-Path: <linux-kernel+bounces-153494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A518ACEB6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:51:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26427280F19
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D4815218E;
	Mon, 22 Apr 2024 13:50:03 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E125E1514E1;
	Mon, 22 Apr 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793802; cv=none; b=a+lSBWGqCoi+k5s2cqvRrfWURWtO6J4bKtXftJY+h+yvKfQ9lNAwTdfI5FOybAwMxQVJDm4FLqJVjLMq7Br9NkpT/lX5Kba/mdZc8MvpsptHg9NDW8v05N30bxl1zpbT0AxFXK15iIiMvoafAUSz/cC2cnhwzDyxJf5YzNT375w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793802; c=relaxed/simple;
	bh=G3Wwdo3FPiA96PnLKat2NQ9X0yHFlG8SloyDTzFTpOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f/doWm0RdIG1lwE4zfCSUq6O78vvqf8dScwFkwd8x+/YTFDjYOzW+fgw6KBd50tBWxDZNoY+cyV3OQZrozZC8X/ax1SELytO9XdEclTBhYRJPwxxkpdlywBKeYE1hBN+0VdOvo0UcHK00zG+DAGPSW3hc2znkFbzUzQ/GXU9d7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNRNy2DfMzXm77;
	Mon, 22 Apr 2024 21:46:26 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id E73711402CD;
	Mon, 22 Apr 2024 21:49:52 +0800 (CST)
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
Subject: [PATCH net 6/7] net: hns3: fix port vlan filter not disabled issue
Date: Mon, 22 Apr 2024 21:43:26 +0800
Message-ID: <20240422134327.3160587-7-shaojijie@huawei.com>
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

According to hardware limitation, for device support modify
VLAN filter state but not support bypass port VLAN filter,
it should always disable the port VLAN filter. but the driver
enables port VLAN filter when initializing, if there is no
VLAN(except VLAN 0) id added, the driver will disable it
in service task. In most time, it works fine. But there is
a time window before the service task shceduled and net device
being registered. So if user adds VLAN at this time, the driver
will not update the VLAN filter state,  and the port VLAN filter
remains enabled.

To fix the problem, if support modify VLAN filter state but not
support bypass port VLAN filter, set the port vlan filter to "off".

Fixes: 184cd221a863 ("net: hns3: disable port VLAN filter when support function level VLAN filter control")
Fixes: 2ba306627f59 ("net: hns3: add support for modify VLAN filter state")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5dc8593c97be..018069b12de6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -9910,6 +9910,7 @@ static int hclge_set_vlan_protocol_type(struct hclge_dev *hdev)
 static int hclge_init_vlan_filter(struct hclge_dev *hdev)
 {
 	struct hclge_vport *vport;
+	bool enable = true;
 	int ret;
 	int i;
 
@@ -9929,8 +9930,12 @@ static int hclge_init_vlan_filter(struct hclge_dev *hdev)
 		vport->cur_vlan_fltr_en = true;
 	}
 
+	if (test_bit(HNAE3_DEV_SUPPORT_VLAN_FLTR_MDF_B, hdev->ae_dev->caps) &&
+	    !test_bit(HNAE3_DEV_SUPPORT_PORT_VLAN_BYPASS_B, hdev->ae_dev->caps))
+		enable = false;
+
 	return hclge_set_vlan_filter_ctrl(hdev, HCLGE_FILTER_TYPE_PORT,
-					  HCLGE_FILTER_FE_INGRESS, true, 0);
+					  HCLGE_FILTER_FE_INGRESS, enable, 0);
 }
 
 static int hclge_init_vlan_type(struct hclge_dev *hdev)
-- 
2.30.0


