Return-Path: <linux-kernel+bounces-153495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5518ACEB8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A14FD281A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B718F152517;
	Mon, 22 Apr 2024 13:50:03 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAB1150980;
	Mon, 22 Apr 2024 13:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793803; cv=none; b=eVLCZWvcF+wOn1qq2MPdXJRdK8NRg/j52aUn3bjFoWIcatm2AwuIgt4aJ7pIX4ciDt9EddM8jERIgy0WpVdfeSgIj/slUWBWwdithGX2KdmsTsCFflKOIf5kyZMXgJu5a1U/IOGaWKilx2gJ2UmWSCRbb8YU2QJZM3FHj4jglOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793803; c=relaxed/simple;
	bh=yXo5+Apf42eIyYCkZPbdtCzXh/8stbdaBFZASXo2YQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ummHGtFuIkfAC3uDIed/5+iOGtB5z5b4r9jmDYOumsrCZr5YfH2ZSZDyW5gGnMzIqB6XB8pOuLE0jRb6EfUihlGl2/qxv7Bau54YpZKiWVUmJefuOR6aj6ZSfxbQcBRFFzKqdsNCdUmGTrK3GG/IkAUa3Z/R69Cc/+u4JW+vLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4VNRNx68VfzXlf6;
	Mon, 22 Apr 2024 21:46:25 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 7795214035F;
	Mon, 22 Apr 2024 21:49:52 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 21:49:51 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 5/7] net: hns3: using user configure after hardware reset
Date: Mon, 22 Apr 2024 21:43:25 +0800
Message-ID: <20240422134327.3160587-6-shaojijie@huawei.com>
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

From: Peiyang Wang <wangpeiyang1@huawei.com>

When a reset occurring, it's supposed to recover user's configuration.
Currently, the port info(speed, duplex and autoneg) is stored in hclge_mac
and will be scheduled updated. Consider the case that reset was happened
consecutively. During the first reset, the port info is configured with
a temporary value cause the PHY is reset and looking for best link config.
Second reset start and use pervious configuration which is not the user's.
The specific process is as follows:

+------+               +----+                +----+
| USER |               | PF |                | HW |
+---+--+               +-+--+                +-+--+
    |  ethtool --reset   |                     |
    +------------------->|    reset command    |
    |  ethtool --reset   +-------------------->|
    +------------------->|                     +---+
    |                    +---+                 |   |
    |                    |   |reset currently  |   | HW RESET
    |                    |   |and wait to do   |   |
    |                    |<--+                 |   |
    |                    | send pervious cfg   |<--+
    |                    | (1000M FULL AN_ON)  |
    |                    +-------------------->|
    |                    | read cfg(time task) |
    |                    | (10M HALF AN_OFF)   +---+
    |                    |<--------------------+   | cfg take effect
    |                    |    reset command    |<--+
    |                    +-------------------->|
    |                    |                     +---+
    |                    | send pervious cfg   |   | HW RESET
    |                    | (10M HALF AN_OFF)   |<--+
    |                    +-------------------->|
    |                    | read cfg(time task) |
    |                    |  (10M HALF AN_OFF)  +---+
    |                    |<--------------------+   | cfg take effect
    |                    |                     |   |
    |                    | read cfg(time task) |<--+
    |                    |  (10M HALF AN_OFF)  |
    |                    |<--------------------+
    |                    |                     |
    v                    v                     v

To avoid aboved situation, this patch introduced req_speed, req_duplex,
req_autoneg to store user's configuration and it only be used after
hardware reset and to recover user's configuration

Fixes: f5f2b3e4dcc0 ("net: hns3: add support for imp-controlled PHYs")
Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c   | 15 +++++++++------
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.h   |  3 +++
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 6eda73f1e6ad..5dc8593c97be 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -1537,6 +1537,9 @@ static int hclge_configure(struct hclge_dev *hdev)
 			cfg.default_speed, ret);
 		return ret;
 	}
+	hdev->hw.mac.req_speed = hdev->hw.mac.speed;
+	hdev->hw.mac.req_autoneg = AUTONEG_ENABLE;
+	hdev->hw.mac.req_duplex = DUPLEX_FULL;
 
 	hclge_parse_link_mode(hdev, cfg.speed_ability);
 
@@ -3344,9 +3347,9 @@ hclge_set_phy_link_ksettings(struct hnae3_handle *handle,
 		return ret;
 	}
 
-	hdev->hw.mac.autoneg = cmd->base.autoneg;
-	hdev->hw.mac.speed = cmd->base.speed;
-	hdev->hw.mac.duplex = cmd->base.duplex;
+	hdev->hw.mac.req_autoneg = cmd->base.autoneg;
+	hdev->hw.mac.req_speed = cmd->base.speed;
+	hdev->hw.mac.req_duplex = cmd->base.duplex;
 	linkmode_copy(hdev->hw.mac.advertising, cmd->link_modes.advertising);
 
 	return 0;
@@ -3364,9 +3367,9 @@ static int hclge_update_tp_port_info(struct hclge_dev *hdev)
 	if (ret)
 		return ret;
 
-	hdev->hw.mac.autoneg = cmd.base.autoneg;
-	hdev->hw.mac.speed = cmd.base.speed;
-	hdev->hw.mac.duplex = cmd.base.duplex;
+	cmd.base.autoneg = hdev->hw.mac.req_autoneg;
+	cmd.base.speed = hdev->hw.mac.req_speed;
+	cmd.base.duplex = hdev->hw.mac.req_duplex;
 	linkmode_copy(hdev->hw.mac.advertising, cmd.link_modes.advertising);
 
 	return 0;
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
index 37527b847f2f..3a9186457ad8 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.h
@@ -279,11 +279,14 @@ struct hclge_mac {
 	u8 media_type;	/* port media type, e.g. fibre/copper/backplane */
 	u8 mac_addr[ETH_ALEN];
 	u8 autoneg;
+	u8 req_autoneg;
 	u8 duplex;
+	u8 req_duplex;
 	u8 support_autoneg;
 	u8 speed_type;	/* 0: sfp speed, 1: active speed */
 	u8 lane_num;
 	u32 speed;
+	u32 req_speed;
 	u32 max_speed;
 	u32 speed_ability; /* speed ability supported by current media */
 	u32 module_type; /* sub media type, e.g. kr/cr/sr/lr */
-- 
2.30.0


