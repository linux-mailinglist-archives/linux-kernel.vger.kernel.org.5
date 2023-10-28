Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5DC7DA4F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 05:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjJ1DDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 23:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbjJ1DCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 23:02:42 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB4211F;
        Fri, 27 Oct 2023 20:02:40 -0700 (PDT)
Received: from kwepemm000007.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SHPN75JP2zpWWt;
        Sat, 28 Oct 2023 10:57:43 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm000007.china.huawei.com (7.193.23.189) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 28 Oct 2023 11:02:38 +0800
From:   Jijie Shao <shaojijie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>
CC:     <shenjian15@huawei.com>, <wangjie125@huawei.com>,
        <liuyonglong@huawei.com>, <shaojijie@huawei.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net 6/7] net: hns3: fix VF reset fail issue
Date:   Sat, 28 Oct 2023 10:59:16 +0800
Message-ID: <20231028025917.314305-7-shaojijie@huawei.com>
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

Currently the reset process in hns3 and firmware watchdog init process is
asynchronous. We think firmware watchdog initialization is completed
before VF clear the interrupt source. However, firmware initialization
may not complete early. So VF will receive multiple reset interrupts
and fail to reset.

So we add delay before VF interrupt source and 5 ms delay
is enough to avoid second reset interrupt.

Fixes: 427900d27d86 ("net: hns3: fix the timing issue of VF clearing interrupt sources")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 .../ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c   | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
index 1c62e58ff6d8..7b87da031be6 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3vf/hclgevf_main.c
@@ -1924,8 +1924,14 @@ static void hclgevf_service_task(struct work_struct *work)
 	hclgevf_mailbox_service_task(hdev);
 }
 
-static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr)
+static void hclgevf_clear_event_cause(struct hclgevf_dev *hdev, u32 regclr,
+				      bool need_dalay)
 {
+#define HCLGEVF_RESET_DELAY		5
+
+	if (need_dalay)
+		mdelay(HCLGEVF_RESET_DELAY);
+
 	hclgevf_write_dev(&hdev->hw, HCLGE_COMM_VECTOR0_CMDQ_SRC_REG, regclr);
 }
 
@@ -1990,7 +1996,8 @@ static irqreturn_t hclgevf_misc_irq_handle(int irq, void *data)
 	hclgevf_enable_vector(&hdev->misc_vector, false);
 	event_cause = hclgevf_check_evt_cause(hdev, &clearval);
 	if (event_cause != HCLGEVF_VECTOR0_EVENT_OTHER)
-		hclgevf_clear_event_cause(hdev, clearval);
+		hclgevf_clear_event_cause(hdev, clearval,
+					  event_cause == HCLGEVF_VECTOR0_EVENT_RST);
 
 	switch (event_cause) {
 	case HCLGEVF_VECTOR0_EVENT_RST:
@@ -2340,7 +2347,7 @@ static int hclgevf_misc_irq_init(struct hclgevf_dev *hdev)
 		return ret;
 	}
 
-	hclgevf_clear_event_cause(hdev, 0);
+	hclgevf_clear_event_cause(hdev, 0, false);
 
 	/* enable misc. vector(vector 0) */
 	hclgevf_enable_vector(&hdev->misc_vector, true);
-- 
2.30.0

