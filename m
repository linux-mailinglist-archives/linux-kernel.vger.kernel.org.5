Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A263793627
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbjIFHYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232192AbjIFHYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:24:00 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22CECCFF;
        Wed,  6 Sep 2023 00:23:56 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RgYhF4C9lzTlrD;
        Wed,  6 Sep 2023 15:21:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Wed, 6 Sep 2023 15:23:53 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <chenhao418@huawei.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/7] net: hns3: Support query tx timeout threshold by debugfs
Date:   Wed, 6 Sep 2023 15:20:13 +0800
Message-ID: <20230906072018.3020671-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230906072018.3020671-1-shaojijie@huawei.com>
References: <20230906072018.3020671-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

support query tx timeout threshold by debugfs

Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index f276b5ecb431..8086722a56c0 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1045,6 +1045,7 @@ hns3_dbg_dev_specs(struct hnae3_handle *h, char *buf, int len, int *pos)
 	struct hnae3_ae_dev *ae_dev = pci_get_drvdata(h->pdev);
 	struct hnae3_dev_specs *dev_specs = &ae_dev->dev_specs;
 	struct hnae3_knic_private_info *kinfo = &h->kinfo;
+	struct net_device *dev = kinfo->netdev;
 
 	*pos += scnprintf(buf + *pos, len - *pos, "dev_spec:\n");
 	*pos += scnprintf(buf + *pos, len - *pos, "MAC entry num: %u\n",
@@ -1087,6 +1088,9 @@ hns3_dbg_dev_specs(struct hnae3_handle *h, char *buf, int len, int *pos)
 			  dev_specs->mc_mac_size);
 	*pos += scnprintf(buf + *pos, len - *pos, "MAC statistics number: %u\n",
 			  dev_specs->mac_stats_num);
+	*pos += scnprintf(buf + *pos, len - *pos,
+			  "TX timeout threshold: %d seconds\n",
+			  dev->watchdog_timeo / HZ);
 }
 
 static int hns3_dbg_dev_info(struct hnae3_handle *h, char *buf, int len)
-- 
2.30.0

