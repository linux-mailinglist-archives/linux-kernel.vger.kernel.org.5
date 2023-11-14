Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B6B7EB0F4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 14:33:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjKNNdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 08:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233256AbjKNNdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 08:33:42 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA001BC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 05:33:37 -0800 (PST)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4SV6b74kgmzPpHw;
        Tue, 14 Nov 2023 21:29:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 21:33:35 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>,
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH v3 3/4] coresight: ultrasoc-smb: Fix uninitialized before use buf_hw_base
Date:   Tue, 14 Nov 2023 21:33:45 +0800
Message-ID: <20231114133346.30489-4-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231114133346.30489-1-hejunhao3@huawei.com>
References: <20231114133346.30489-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In smb_reset_buffer, the sdb->buf_hw_base variable is uninitialized
before use, which initializes it in smb_init_data_buffer. And the SMB
regiester are set in smb_config_inport.
So move the call after smb_config_inport.

Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 2f2aba90a514..6e32d31a95fe 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -477,7 +477,6 @@ static int smb_init_data_buffer(struct platform_device *pdev,
 static void smb_init_hw(struct smb_drv_data *drvdata)
 {
 	smb_disable_hw(drvdata);
-	smb_reset_buffer(drvdata);
 
 	writel(SMB_LB_CFG_LO_DEFAULT, drvdata->base + SMB_LB_CFG_LO_REG);
 	writel(SMB_LB_CFG_HI_DEFAULT, drvdata->base + SMB_LB_CFG_HI_REG);
@@ -587,6 +586,7 @@ static int smb_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	smb_reset_buffer(drvdata);
 	platform_set_drvdata(pdev, drvdata);
 	spin_lock_init(&drvdata->spinlock);
 	drvdata->pid = -1;
-- 
2.33.0

