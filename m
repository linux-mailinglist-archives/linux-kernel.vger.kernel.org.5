Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE587DA4EF
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjJ1DCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjJ1DCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:02:41 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BB6112;
        Fri, 27 Oct 2023 20:02:38 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4SHPNs05w5zMmCT;
        Sat, 28 Oct 2023 10:58:20 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:36 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 2/7] net: hns3: add barrier in vf mailbox reply process
Date:   Sat, 28 Oct 2023 10:59:12 +0800
Message-ID: <20231028025917.314305-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20231028025917.314305-1-shaojijie@huawei.com>
References: <20231028025917.314305-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm000007.china.huawei.com (7.193.23.189)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yonglong Liu <liuyonglong@huawei.com>

In hclgevf_mbx_handler() and hclgevf_get_mbx_resp() functions,
there is a typical store-store and load-load scenario between
received_resp and additional_info. This patch adds barrier
to fix the problem.

Fixes: 4671042f1ef0 ("net: hns3: add match_id to check mailbox response from PF to VF")
Signed-off-by: Yonglong Liu <liuyonglong@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
index bbf7b14079de..85c2a634c8f9 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_mbx.c
@@ -63,6 +63,9 @@ static int hclgevf_get_mbx_resp(struct hclgevf_dev *hdev, u16 code0, u16 code1,
 		i++;
 	}
 
+	/* ensure additional_info will be seen after received_resp */
+	smp_rmb();
+
 	if (i >= HCLGEVF_MAX_TRY_TIMES) {
 		dev_err(&hdev->pdev->dev,
 			"VF could not get mbx(%u,%u) resp(=%d) from PF in %d tries\n",
@@ -178,6 +181,10 @@ static void hclgevf_handle_mbx_response(struct hclgevf_dev *hdev,
 	resp->resp_status = hclgevf_resp_to_errno(resp_status);
 	memcpy(resp->additional_info, req->msg.resp_data,
 	       HCLGE_MBX_MAX_RESP_DATA_SIZE * sizeof(u8));
+
+	/* ensure additional_info will be seen before setting received_resp */
+	smp_wmb();
+
 	if (match_id) {
 		/* If match_id is not zero, it means PF support match_id.
 		 * if the match_id is right, VF get the right response, or
-- 
2.30.0

