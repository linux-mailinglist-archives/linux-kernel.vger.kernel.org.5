Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2C978FB32
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349054AbjIAJnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 05:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbjIAJmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 05:42:44 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB72A10FB;
        Fri,  1 Sep 2023 02:42:10 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RcY163FHTzrSKP;
        Fri,  1 Sep 2023 17:40:26 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 1 Sep 2023 17:42:07 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     Hannes Reinecke <hare@suse.de>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, <lixiaokeng@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [RFC PATCH v2 15/19] scsi: mpt3sas: Add param to control target based error handle
Date:   Fri, 1 Sep 2023 17:41:23 +0800
Message-ID: <20230901094127.2010873-16-haowenchao2@huawei.com>
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

Add new module param target_eh to control if enable target based
error handle, since mpt3sas defined callback eh_host_reset, so make
it fallback to further recover when target based recovery can not
recover all error commands.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 7a48e89c3e5d..6170d8a772d4 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -178,6 +178,10 @@ static bool lun_eh;
 module_param(lun_eh, bool, 0444);
 MODULE_PARM_DESC(lun_eh, "LUN based error handle (def=0)");
 
+static bool target_eh;
+module_param(target_eh, bool, 0444);
+MODULE_PARM_DESC(target_eh, "target based error handle (def=0)");
+
 /* raid transport support */
 static struct raid_template *mpt3sas_raid_template;
 static struct raid_template *mpt2sas_raid_template;
@@ -1879,6 +1883,13 @@ scsih_target_alloc(struct scsi_target *starget)
 	struct _pcie_device *pcie_device;
 	unsigned long flags;
 	struct sas_rphy *rphy;
+	int ret = 0;
+
+	if (target_eh) {
+		ret = scsi_target_setup_eh(starget, 1);
+		if (ret)
+			return ret;
+	}
 
 	sas_target_priv_data = kzalloc(sizeof(*sas_target_priv_data),
 				       GFP_KERNEL);
@@ -1969,6 +1980,9 @@ scsih_target_destroy(struct scsi_target *starget)
 	struct _pcie_device *pcie_device;
 	unsigned long flags;
 
+	if (target_eh)
+		scsi_target_clear_eh(starget);
+
 	sas_target_priv_data = starget->hostdata;
 	if (!sas_target_priv_data)
 		return;
-- 
2.35.3

