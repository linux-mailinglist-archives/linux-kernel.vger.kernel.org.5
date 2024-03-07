Return-Path: <linux-kernel+bounces-94814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F27874586
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C997B2209A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382B61DA3A;
	Thu,  7 Mar 2024 01:06:28 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34301CAB2;
	Thu,  7 Mar 2024 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709773587; cv=none; b=iqs1mcqy42YcteGjV9minspMkeaBE05v4AW6+RKupOHLeEnoZT2TtGk8t/U4f2Q1sxcmYC7MzAvHv+Gy7smQ95QzYZPziZPz2f4+RYsGZmw+EIwy1u1ftMKFKqQs2/M4nv4yvH4zM7HsUAztdC/b8UMSCqqAypxykPG4dqP5xws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709773587; c=relaxed/simple;
	bh=kYiGk89IVVniFRgisHtaQEupMRy11dssY0gIj7UDyZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQjOB4a3PansBLBBmLoMUV3/mjp80I6uIJoWK0d5opIASEaibHVlOCS4yQcvZQHrtxjatF5dzTqcmiaOmcAqRt4dIrYwBjClU5E/X5xtGDbaaTmg5NZtFZ58Z4SRDP7w5OnR7ypN1sBB8SKCp1ulbSxDrOVLs1hg9LLXw5W49GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Tqrfp4rcGzsWqP;
	Thu,  7 Mar 2024 09:04:18 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 52367140794;
	Thu,  7 Mar 2024 09:06:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 09:06:16 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net 5/8] net: hns3: fix delete tc fail issue
Date: Thu, 7 Mar 2024 09:01:12 +0800
Message-ID: <20240307010115.3054770-6-shaojijie@huawei.com>
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

When the tc is removed during reset, hns3 driver will return a errcode.
But kernel ignores this errcode, As a result,
the driver status is inconsistent with the kernel status.

This patch retains the deletion status when the deletion fails
and continues to delete after the reset to ensure that
the status of the driver is consistent with that of kernel.

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h      |  1 +
 .../ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c   |  2 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c  |  2 ++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.c    | 16 ++++++++++++++++
 .../ethernet/hisilicon/hns3/hns3pf/hclge_tm.h    |  1 +
 5 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hnae3.h b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
index a72caaf05475..f19f1e1d1f9f 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hnae3.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hnae3.h
@@ -820,6 +820,7 @@ struct hnae3_tc_info {
 	u8 max_tc; /* Total number of TCs */
 	u8 num_tc; /* Total number of enabled TCs */
 	bool mqprio_active;
+	bool mqprio_destroy;
 	bool dcb_ets_active;
 };
 
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index b98301e205f7..eabbacb1c714 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -619,6 +619,8 @@ static int hclge_setup_tc(struct hnae3_handle *h,
 		return ret;
 	}
 
+	kinfo->tc_info.mqprio_destroy = !tc;
+
 	ret = hclge_notify_down_uinit(hdev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 16860eea9800..349e4a1946ab 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -12105,6 +12105,8 @@ static int hclge_reset_ae_dev(struct hnae3_ae_dev *ae_dev)
 		return ret;
 	}
 
+	hclge_reset_tc_config(hdev);
+
 	ret = hclge_tm_init_hw(hdev, true);
 	if (ret) {
 		dev_err(&pdev->dev, "tm init hw fail, ret =%d\n", ret);
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
index c58c31221762..00c3f2548bf6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.c
@@ -2143,3 +2143,19 @@ int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable)
 
 	return ret;
 }
+
+void hclge_reset_tc_config(struct hclge_dev *hdev)
+{
+	struct hclge_vport *vport = &hdev->vport[0];
+	struct hnae3_knic_private_info *kinfo;
+
+	kinfo = &vport->nic.kinfo;
+
+	if (!kinfo->tc_info.mqprio_destroy)
+		return;
+
+	/* clear tc info, including mqprio_destroy and mqprio_active */
+	memset(&kinfo->tc_info, 0, sizeof(kinfo->tc_info));
+	hclge_tm_schd_info_update(hdev, 0);
+	hclge_comm_rss_indir_init_cfg(hdev->ae_dev, &hdev->rss_cfg);
+}
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
index 53eec6df5194..0985916629d3 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_tm.h
@@ -277,4 +277,5 @@ int hclge_tm_get_port_shaper(struct hclge_dev *hdev,
 int hclge_up_to_tc_map(struct hclge_dev *hdev);
 int hclge_dscp_to_tc_map(struct hclge_dev *hdev);
 int hclge_tm_flush_cfg(struct hclge_dev *hdev, bool enable);
+void hclge_reset_tc_config(struct hclge_dev *hdev);
 #endif
-- 
2.30.0


