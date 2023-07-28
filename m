Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E292766644
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbjG1IE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234620AbjG1IDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:03:51 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B638B3C01;
        Fri, 28 Jul 2023 01:01:51 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RC0PY1gKpzNmbb;
        Fri, 28 Jul 2023 15:58:25 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 28 Jul 2023 16:01:48 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <wangpeiyang1@huawei.com>,
        <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
        <stable@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 1/6] net: hns3: fix side effects passed to min_t()
Date:   Fri, 28 Jul 2023 15:58:35 +0800
Message-ID: <20230728075840.4022760-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230728075840.4022760-1-shaojijie@huawei.com>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

num_online_cpus() may call more than once when passing to min_t(),
between calls, it may return different values, so move num_online_cpus()
out of min_t().

Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3_enet.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index 9f6890059666..823e6d2e85f5 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -4757,6 +4757,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 {
 	struct hnae3_handle *h = priv->ae_handle;
 	struct hns3_enet_tqp_vector *tqp_vector;
+	u32 online_cpus = num_online_cpus();
 	struct hnae3_vector_info *vector;
 	struct pci_dev *pdev = h->pdev;
 	u16 tqp_num = h->kinfo.num_tqps;
@@ -4766,7 +4767,7 @@ static int hns3_nic_alloc_vector_data(struct hns3_nic_priv *priv)
 
 	/* RSS size, cpu online and vector_num should be the same */
 	/* Should consider 2p/4p later */
-	vector_num = min_t(u16, num_online_cpus(), tqp_num);
+	vector_num = min_t(u16, online_cpus, tqp_num);
 
 	vector = devm_kcalloc(&pdev->dev, vector_num, sizeof(*vector),
 			      GFP_KERNEL);
-- 
2.30.0

