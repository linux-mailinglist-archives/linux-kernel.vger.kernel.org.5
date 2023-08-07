Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86F77722F1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 13:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjHGLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 07:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbjHGLnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 07:43:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B2744213E;
        Mon,  7 Aug 2023 04:41:31 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4RKDph6HGmz1KCLT;
        Mon,  7 Aug 2023 19:38:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 7 Aug 2023 19:39:28 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
        <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 2/4] net: hns3: refactor hclge_mac_link_status_wait for interface reuse
Date:   Mon, 7 Aug 2023 19:34:50 +0800
Message-ID: <20230807113452.474224-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230807113452.474224-1-shaojijie@huawei.com>
References: <20230807113452.474224-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

Some nic configurations could only be performed after link is down. So this
patch refactor this API for reuse.

Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_main.c    | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 5594b8dd1e1d..b440e42e1d9c 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -72,6 +72,8 @@ static void hclge_restore_hw_table(struct hclge_dev *hdev);
 static void hclge_sync_promisc_mode(struct hclge_dev *hdev);
 static void hclge_sync_fd_table(struct hclge_dev *hdev);
 static void hclge_update_fec_stats(struct hclge_dev *hdev);
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt);
 
 static struct hnae3_ae_algo ae_algo;
 
@@ -7647,10 +7649,9 @@ static void hclge_phy_link_status_wait(struct hclge_dev *hdev,
 	} while (++i < HCLGE_PHY_LINK_STATUS_NUM);
 }
 
-static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
+static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret,
+				      int wait_cnt)
 {
-#define HCLGE_MAC_LINK_STATUS_NUM  100
-
 	int link_status;
 	int i = 0;
 	int ret;
@@ -7663,13 +7664,15 @@ static int hclge_mac_link_status_wait(struct hclge_dev *hdev, int link_ret)
 			return 0;
 
 		msleep(HCLGE_LINK_STATUS_MS);
-	} while (++i < HCLGE_MAC_LINK_STATUS_NUM);
+	} while (++i < wait_cnt);
 	return -EBUSY;
 }
 
 static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 					  bool is_phy)
 {
+#define HCLGE_MAC_LINK_STATUS_NUM  100
+
 	int link_ret;
 
 	link_ret = en ? HCLGE_LINK_STATUS_UP : HCLGE_LINK_STATUS_DOWN;
@@ -7677,7 +7680,8 @@ static int hclge_mac_phy_link_status_wait(struct hclge_dev *hdev, bool en,
 	if (is_phy)
 		hclge_phy_link_status_wait(hdev, link_ret);
 
-	return hclge_mac_link_status_wait(hdev, link_ret);
+	return hclge_mac_link_status_wait(hdev, link_ret,
+					  HCLGE_MAC_LINK_STATUS_NUM);
 }
 
 static int hclge_set_app_loopback(struct hclge_dev *hdev, bool en)
-- 
2.30.0

