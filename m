Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED045768F11
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjGaHkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjGaHjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:39:47 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5262210C1;
        Mon, 31 Jul 2023 00:39:38 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RDqnM1YFszLnyZ;
        Mon, 31 Jul 2023 15:36:55 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 31 Jul
 2023 15:39:35 +0800
From:   Ruan Jinjie <ruanjinjie@huawei.com>
To:     <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <ruanjinjie@huawei.com>
Subject: [PATCH -next] net: hisilicon: fix the return value handle and remove redundant netdev_err() for platform_get_irq()
Date:   Mon, 31 Jul 2023 15:38:58 +0800
Message-ID: <20230731073858.3633193-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no possible for platform_get_irq() to return 0
and the return value of platform_get_irq() is more sensible
to show the error reason.

And there is no need to call the netdev_err() function directly to print
a custom message when handling an error from platform_get_irq() function as
it is going to display an appropriate error message in case of a failure.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hip04_eth.c    | 4 ++--
 drivers/net/ethernet/hisilicon/hisi_femac.c   | 4 ++--
 drivers/net/ethernet/hisilicon/hix5hd2_gmac.c | 5 ++---
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hip04_eth.c b/drivers/net/ethernet/hisilicon/hip04_eth.c
index 50c3f5d6611f..ecf92a5d56bb 100644
--- a/drivers/net/ethernet/hisilicon/hip04_eth.c
+++ b/drivers/net/ethernet/hisilicon/hip04_eth.c
@@ -960,8 +960,8 @@ static int hip04_mac_probe(struct platform_device *pdev)
 	}
 
 	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0) {
-		ret = -EINVAL;
+	if (irq < 0) {
+		ret = irq;
 		goto init_fail;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hisi_femac.c b/drivers/net/ethernet/hisilicon/hisi_femac.c
index ce2571c16e43..cb7b0293fe85 100644
--- a/drivers/net/ethernet/hisilicon/hisi_femac.c
+++ b/drivers/net/ethernet/hisilicon/hisi_femac.c
@@ -862,8 +862,8 @@ static int hisi_femac_drv_probe(struct platform_device *pdev)
 		goto out_disconnect_phy;
 
 	ndev->irq = platform_get_irq(pdev, 0);
-	if (ndev->irq <= 0) {
-		ret = -ENODEV;
+	if (ndev->irq < 0) {
+		ret = ndev->irq;
 		goto out_disconnect_phy;
 	}
 
diff --git a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
index f867e9531117..26d22bb04b87 100644
--- a/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
+++ b/drivers/net/ethernet/hisilicon/hix5hd2_gmac.c
@@ -1206,9 +1206,8 @@ static int hix5hd2_dev_probe(struct platform_device *pdev)
 	}
 
 	ndev->irq = platform_get_irq(pdev, 0);
-	if (ndev->irq <= 0) {
-		netdev_err(ndev, "No irq resource\n");
-		ret = -EINVAL;
+	if (ndev->irq < 0) {
+		ret = ndev->irq;
 		goto out_phy_node;
 	}
 
-- 
2.34.1

