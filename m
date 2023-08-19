Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86B3D781880
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 10:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbjHSIkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 04:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHSIkS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 04:40:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 999459FC42;
        Sat, 19 Aug 2023 01:40:15 -0700 (PDT)
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RSXF722k6zVkJQ;
        Sat, 19 Aug 2023 16:38:03 +0800 (CST)
Received: from hulk-vt.huawei.com (10.67.174.21) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Sat, 19 Aug 2023 16:40:12 +0800
From:   Zhu Wang <wangzhu9@huawei.com>
To:     <kartilak@cisco.com>, <sebaddel@cisco.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <nmusini@cisco.com>,
        <bvanassche@acm.org>, <dan.carpenter@linaro.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <wangzhu9@huawei.com>
Subject: [PATCH -next] scsi: snic: fix double free in snic_tgt_create()
Date:   Sat, 19 Aug 2023 08:39:41 +0000
Message-ID: <20230819083941.164365-1-wangzhu9@huawei.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.21]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500025.china.huawei.com (7.185.36.35)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 41320b18a0e0 ("scsi: snic: Fix possible memory leak if
device_add() fails") fix the memory leak caused by dev_set_name() when
device_add() failed. While it did not consider that 'tgt' has already been
released when put_device(&tgt->dev) is called. We removed kfree(tgt) in
the error path to avoid double free 'tgt'. And we moved
put_device(&tgt->dev) after the removed kfree(tgt) to avoid UAF
(Use-After-Free).

Fixes: 41320b18a0e0 ("scsi: snic: Fix possible memory leak if device_add() fails")
Signed-off-by: Zhu Wang <wangzhu9@huawei.com>
---
 drivers/scsi/snic/snic_disc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/snic/snic_disc.c b/drivers/scsi/snic/snic_disc.c
index e429ad23c396..4db3ba62fcd3 100644
--- a/drivers/scsi/snic/snic_disc.c
+++ b/drivers/scsi/snic/snic_disc.c
@@ -303,12 +303,11 @@ snic_tgt_create(struct snic *snic, struct snic_tgt_id *tgtid)
 			      "Snic Tgt: device_add, with err = %d\n",
 			      ret);
 
-		put_device(&tgt->dev);
 		put_device(&snic->shost->shost_gendev);
 		spin_lock_irqsave(snic->shost->host_lock, flags);
 		list_del(&tgt->list);
 		spin_unlock_irqrestore(snic->shost->host_lock, flags);
-		kfree(tgt);
+		put_device(&tgt->dev);
 		tgt = NULL;
 
 		return tgt;
-- 
2.34.1

