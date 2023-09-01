Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91C178FB33
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348953AbjIAJnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348994AbjIAJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BCE19BA;
        Fri,  1 Sep 2023 02:42:09 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RcY0B0VHtzVkS3;
        Fri,  1 Sep 2023 17:39:38 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:00 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 14/19] scsi: mpt3sas: Add param to control LUN based error handle
Date:   Fri, 1 Sep 2023 17:41:22 +0800
Message-ID: <20230901094127.2010873-15-haowenchao2@huawei.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new module param lun_eh to control if enable LUN based
error handler, since mpt3sas defined callback eh_host_reset
and eh_target_reset, so make it fallback to further recover
when LUN based recovery can not recover all error commands.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01..7a48e89c3e5d 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -174,6 +174,10 @@ module_param(host_tagset_enable, int, 0444);
 MODULE_PARM_DESC(host_tagset_enable,
 	"Shared host tagset enable/disable Default: enable(1)");
 
+static bool lun_eh;
+module_param(lun_eh, bool, 0444);
+MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
+
 /* raid transport support */
 static struct raid_template *mpt3sas_raid_template;
 static struct raid_template *mpt2sas_raid_template;
@@ -2044,6 +2048,13 @@ scsih_slave_alloc(struct scsi_device *sdev)
 	struct _sas_device *sas_device;
 	struct _pcie_device *pcie_device;
 	unsigned long flags;
+	int ret = 0;
+
+	if (lun_eh) {
+		ret = scsi_device_setup_eh(sdev, 1);
+		if (ret)
+			return ret;
+	}
 
 	sas_device_priv_data = kzalloc(sizeof(*sas_device_priv_data),
 				       GFP_KERNEL);
@@ -2122,6 +2133,9 @@ scsih_slave_destroy(struct scsi_device *sdev)
 	struct _pcie_device *pcie_device;
 	unsigned long flags;
 
+	if (lun_eh)
+		scsi_device_clear_eh(sdev);
+
 	if (!sdev->hostdata)
 		return;
 
-- 
2.35.3

