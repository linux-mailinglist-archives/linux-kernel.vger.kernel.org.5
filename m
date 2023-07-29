Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA78767E2D
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 12:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjG2KYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 06:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjG2KYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 06:24:35 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E9E4229;
        Sat, 29 Jul 2023 03:24:34 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RCgYn2hGFzVjDr;
        Sat, 29 Jul 2023 18:22:53 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sat, 29 Jul 2023 18:24:31 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     John Garry <john.g.garry@oracle.com>,
        Jason Yan <yanaijie@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH] scsi:libsas: Simplify sas_queue_reset and remove unused code
Date:   Sat, 29 Jul 2023 18:24:51 +0800
Message-ID: <20230729102451.2452826-1-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)
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

sas_queue_reset is always called with param "wait" set to 0, so
remove it from this function's param list. And remove unused
function sas_wait_eh.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/libsas/sas_scsi_host.c | 41 +++--------------------------
 1 file changed, 3 insertions(+), 38 deletions(-)

diff --git a/drivers/scsi/libsas/sas_scsi_host.c b/drivers/scsi/libsas/sas_scsi_host.c
index 94c5f14f3c16..3f01e77eaee3 100644
--- a/drivers/scsi/libsas/sas_scsi_host.c
+++ b/drivers/scsi/libsas/sas_scsi_host.c
@@ -387,37 +387,7 @@ struct sas_phy *sas_get_local_phy(struct domain_device *dev)
 }
 EXPORT_SYMBOL_GPL(sas_get_local_phy);
 
-static void sas_wait_eh(struct domain_device *dev)
-{
-	struct sas_ha_struct *ha = dev->port->ha;
-	DEFINE_WAIT(wait);
-
-	if (dev_is_sata(dev)) {
-		ata_port_wait_eh(dev->sata_dev.ap);
-		return;
-	}
- retry:
-	spin_lock_irq(&ha->lock);
-
-	while (test_bit(SAS_DEV_EH_PENDING, &dev->state)) {
-		prepare_to_wait(&ha->eh_wait_q, &wait, TASK_UNINTERRUPTIBLE);
-		spin_unlock_irq(&ha->lock);
-		schedule();
-		spin_lock_irq(&ha->lock);
-	}
-	finish_wait(&ha->eh_wait_q, &wait);
-
-	spin_unlock_irq(&ha->lock);
-
-	/* make sure SCSI EH is complete */
-	if (scsi_host_in_recovery(ha->core.shost)) {
-		msleep(10);
-		goto retry;
-	}
-}
-
-static int sas_queue_reset(struct domain_device *dev, int reset_type,
-			   u64 lun, int wait)
+static int sas_queue_reset(struct domain_device *dev, int reset_type, u64 lun)
 {
 	struct sas_ha_struct *ha = dev->port->ha;
 	int scheduled = 0, tries = 100;
@@ -425,8 +395,6 @@ static int sas_queue_reset(struct domain_device *dev, int reset_type,
 	/* ata: promote lun reset to bus reset */
 	if (dev_is_sata(dev)) {
 		sas_ata_schedule_reset(dev);
-		if (wait)
-			sas_ata_wait_eh(dev);
 		return SUCCESS;
 	}
 
@@ -444,9 +412,6 @@ static int sas_queue_reset(struct domain_device *dev, int reset_type,
 		}
 		spin_unlock_irq(&ha->lock);
 
-		if (wait)
-			sas_wait_eh(dev);
-
 		if (scheduled)
 			return SUCCESS;
 	}
@@ -499,7 +464,7 @@ int sas_eh_device_reset_handler(struct scsi_cmnd *cmd)
 	struct sas_internal *i = to_sas_internal(host->transportt);
 
 	if (current != host->ehandler)
-		return sas_queue_reset(dev, SAS_DEV_LU_RESET, cmd->device->lun, 0);
+		return sas_queue_reset(dev, SAS_DEV_LU_RESET, cmd->device->lun);
 
 	int_to_scsilun(cmd->device->lun, &lun);
 
@@ -522,7 +487,7 @@ int sas_eh_target_reset_handler(struct scsi_cmnd *cmd)
 	struct sas_internal *i = to_sas_internal(host->transportt);
 
 	if (current != host->ehandler)
-		return sas_queue_reset(dev, SAS_DEV_RESET, 0, 0);
+		return sas_queue_reset(dev, SAS_DEV_RESET, 0);
 
 	if (!i->dft->lldd_I_T_nexus_reset)
 		return FAILED;
-- 
2.32.0

