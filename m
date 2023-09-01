Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C9A78FB37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348973AbjIAJnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbjIAJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38061BC6;
        Fri,  1 Sep 2023 02:42:14 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcY171GZlzrS0g;
        Fri,  1 Sep 2023 17:40:27 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:08 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 16/19] scsi: smartpqi: Add param to control LUN based error handle
Date:   Fri, 1 Sep 2023 17:41:24 +0800
Message-ID: <20230901094127.2010873-17-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230901094127.2010873-1-haowenchao2@huawei.com>
References: <20230901094127.2010873-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new param lun_eh to control if enable LUN based error handler, since
smartpqi did not define other further reset callbacks, it is not
necessary to fallback to further recover any more, so set the LUN
error handler with fallback set to 0.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 6aaaa7ebca37..107156d85d85 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -187,6 +187,10 @@ module_param_named(ctrl_ready_timeout,
 MODULE_PARM_DESC(ctrl_ready_timeout,
 	"Timeout in seconds for driver to wait for controller ready.");
 
+static bool pqi_lun_eh;
+module_param_named(lun_eh, pqi_lun_eh, bool, 0444);
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
+
 static char *raid_levels[] = {
 	"RAID-0",
 	"RAID-4",
@@ -6356,6 +6360,13 @@ static int pqi_slave_alloc(struct scsi_device *sdev)
 	struct pqi_ctrl_info *ctrl_info;
 	struct scsi_target *starget;
 	struct sas_rphy *rphy;
+	int ret = 0;
+
+	if (pqi_lun_eh) {
+		ret = scsi_device_setup_eh(sdev, 0);
+		if (ret)
+			return ret;
+	}
 
 	ctrl_info = shost_to_hba(sdev->host);
 
@@ -6439,6 +6450,9 @@ static void pqi_slave_destroy(struct scsi_device *sdev)
 
 	ctrl_info = shost_to_hba(sdev->host);
 
+	if (pqi_lun_eh)
+		scsi_device_clear_eh(sdev);
+
 	mutex_acquired = mutex_trylock(&ctrl_info->scan_mutex);
 	if (!mutex_acquired)
 		return;
-- 
2.35.3

