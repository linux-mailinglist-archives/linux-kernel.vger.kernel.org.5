Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376B7A439E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbjIRHyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240642AbjIRHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:54:26 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08CF3AB6;
        Mon, 18 Sep 2023 00:53:03 -0700 (PDT)
Received: from kwepemm600007.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rpxmx6XHKz15NRB;
        Mon, 18 Sep 2023 15:50:57 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 18 Sep 2023 15:53:00 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 5/5] net: hns3: add 5ms delay before clear firmware reset irq source
Date:   Mon, 18 Sep 2023 15:48:40 +0800
Message-ID: <20230918074840.2650978-6-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20230918074840.2650978-1-shaojijie@huawei.com>
References: <20230918074840.2650978-1-shaojijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jie Wang <wangjie125@huawei.com>

Currently the reset process in hns3 and firmware watchdog init process is
asynchronous. we think firmware watchdog initialization is completed
before hns3 clear the firmware interrupt source. However, firmware
initialization may not complete early.

so we add delay before hns3 clear firmware interrupt source and 5 ms delay
is enough to avoid second firmware reset interrupt.

Fixes: c1a81619d73a ("net: hns3: Add mailbox interrupt handling to PF driver")
Signed-off-by: Jie Wang <wangjie125@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
index 2bd77871f3bf..c42574e29747 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_main.c
@@ -3564,9 +3564,14 @@ static u32 hclge_check_event_cause(struct hclge_dev *hdev, u32 *clearval)
 static void hclge_clear_event_cause(struct hclge_dev *hdev, u32 event_type,
 				    u32 regclr)
 {
+#define HCLGE_IMP_RESET_DELAY		5
+
 	switch (event_type) {
 	case HCLGE_VECTOR0_EVENT_PTP:
 	case HCLGE_VECTOR0_EVENT_RST:
+		if (regclr == BIT(HCLGE_VECTOR0_IMPRESET_INT_B))
+			mdelay(HCLGE_IMP_RESET_DELAY);
+
 		hclge_write_dev(&hdev->hw, HCLGE_MISC_RESET_STS_REG, regclr);
 		break;
 	case HCLGE_VECTOR0_EVENT_MBX:
-- 
2.30.0

