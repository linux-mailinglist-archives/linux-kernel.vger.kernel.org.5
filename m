Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41236774B2F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHHUmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234353AbjHHUmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:42:04 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FEE7A99
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:31:21 -0700 (PDT)
Received: from dggpemm100010.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RKt503fjbzNmtq;
        Tue,  8 Aug 2023 20:37:56 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm100010.china.huawei.com (7.185.36.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 20:41:24 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 20:41:24 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <zhang_shurong@foxmail.com>,
        <yangyingliang@huawei.com>
Subject: [PATCH -next] uio: pruss: fix missing iounmap() in pruss_probe()
Date:   Tue, 8 Aug 2023 20:38:27 +0800
Message-ID: <20230808123827.560603-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

platform_get_irq() is called after ioremap(), if it fails,
iounmap() needs be called in error the path.

Fixes: 2fd84b9b839c ("uio: pruss: fix to check return value of platform_get_irq() in pruss_probe()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/uio/uio_pruss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/uio/uio_pruss.c b/drivers/uio/uio_pruss.c
index 122c38e2fbbd..77e2dc404885 100644
--- a/drivers/uio/uio_pruss.c
+++ b/drivers/uio/uio_pruss.c
@@ -177,7 +177,7 @@ static int pruss_probe(struct platform_device *pdev)
 
 	ret = platform_get_irq(pdev, 0);
 	if (ret < 0)
-		goto err_free_ddr_vaddr;
+		goto err_unmap;
 
 	gdev->hostirq_start = ret;
 	gdev->pintc_base = pdata->pintc_base;
@@ -215,6 +215,7 @@ static int pruss_probe(struct platform_device *pdev)
 	for (i = 0, p = gdev->info; i < cnt; i++, p++) {
 		uio_unregister_device(p);
 	}
+err_unmap:
 	iounmap(gdev->prussio_vaddr);
 err_free_ddr_vaddr:
 	dma_free_coherent(dev, extram_pool_sz, gdev->ddr_vaddr,
-- 
2.25.1

