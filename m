Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A09D7D1BC8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 10:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjJUIiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 04:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjJUIiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 04:38:01 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3E11A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 01:37:59 -0700 (PDT)
Received: from dggpeml500002.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4SCFBg1mhfz15NTT;
        Sat, 21 Oct 2023 16:35:07 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500002.china.huawei.com (7.185.36.158) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 21 Oct 2023 16:37:53 +0800
From:   Junhao He <hejunhao3@huawei.com>
To:     <suzuki.poulose@arm.com>, <james.clark@arm.com>
CC:     <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <yangyicong@huawei.com>,
        <prime.zeng@hisilicon.com>, <hejunhao3@huawei.com>
Subject: [PATCH v2 2/4] coresight: ultrasoc-smb: Config SMB buffer before register sink
Date:   Sat, 21 Oct 2023 16:38:20 +0800
Message-ID: <20231021083822.18239-3-hejunhao3@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20231021083822.18239-1-hejunhao3@huawei.com>
References: <20231021083822.18239-1-hejunhao3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500002.china.huawei.com (7.185.36.158)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMB dirver register the enable/disable sysfs interface in function
smb_register_sink(), however the buffer depends on the following
configuration to work well. So it'll be possible for user to access an
unreset one.

Move the config buffer operation to before register_sink().

Fixes: 06f5c2926aaa ("drivers/coresight: Add UltraSoc System Memory Buffer driver")
Signed-off-by: Junhao He <hejunhao3@huawei.com>
---
 drivers/hwtracing/coresight/ultrasoc-smb.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/ultrasoc-smb.c b/drivers/hwtracing/coresight/ultrasoc-smb.c
index 0a0fe9fcc57f..c61450f74cb1 100644
--- a/drivers/hwtracing/coresight/ultrasoc-smb.c
+++ b/drivers/hwtracing/coresight/ultrasoc-smb.c
@@ -583,38 +583,31 @@ static int smb_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = smb_config_inport(dev, true);
+	if (ret)
+		return ret;
+
+	platform_set_drvdata(pdev, drvdata);
 	spin_lock_init(&drvdata->spinlock);
 	drvdata->pid = -1;
 
 	ret = smb_register_sink(pdev, drvdata);
 	if (ret) {
+		smb_config_inport(&pdev->dev, false);
 		dev_err(dev, "Failed to register SMB sink\n");
 		return ret;
 	}
 
-	ret = smb_config_inport(dev, true);
-	if (ret) {
-		smb_unregister_sink(drvdata);
-		return ret;
-	}
-
-	platform_set_drvdata(pdev, drvdata);
-
 	return 0;
 }
 
 static int smb_remove(struct platform_device *pdev)
 {
 	struct smb_drv_data *drvdata = platform_get_drvdata(pdev);
-	int ret;
-
-	ret = smb_config_inport(&pdev->dev, false);
-	if (ret)
-		return ret;
 
 	smb_unregister_sink(drvdata);
 
-	return 0;
+	return smb_config_inport(&pdev->dev, false);
 }
 
 #ifdef CONFIG_ACPI
-- 
2.33.0

