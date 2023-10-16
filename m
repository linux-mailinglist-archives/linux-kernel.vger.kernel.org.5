Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80DDA7C9D4D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbjJPCDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbjJPCDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:03:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64770C1;
        Sun, 15 Oct 2023 19:03:42 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S80fc1qVPzNnxT;
        Mon, 16 Oct 2023 09:59:36 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 16 Oct 2023 10:03:34 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v3 3/4] scsi: scsi_error: Fix device reset is not triggered
Date:   Mon, 16 Oct 2023 10:03:13 +0800
Message-ID: <20231016020314.1269636-4-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231016020314.1269636-1-haowenchao2@huawei.com>
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

shost_for_each_device() would skip devices which is in progress of
removing, so scsi_try_bus_device_reset() for these devices would be
skipped in scsi_eh_bus_device_reset() with following order:

T1:					T2:scsi_error_handle
__scsi_remove_device
  scsi_device_set_state(sdev, SDEV_DEL)
					// would skip device with SDEV_DEL state
  					shost_for_each_device()
					  scsi_try_bus_device_reset
					flush all commands
 ...
 releasing and free scsi_device

Some drivers like smartpqi only implement eh_device_reset_handler,
if device reset is skipped, the commands which had been sent to
firmware or devices hardware are not cleared. The error handle
would flush all these commands in scsi_unjam_host().

When the commands are finished by hardware, use after free issue is
triggered.

Fix this issue by using shost_for_each_device_include_deleted()
to iterate devices in scsi_eh_bus_device_reset().

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_error.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index 2550f8cd182a..57e3cc556549 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -1568,7 +1568,7 @@ static int scsi_eh_bus_device_reset(struct Scsi_Host *shost,
 	struct scsi_device *sdev;
 	enum scsi_disposition rtn;
 
-	shost_for_each_device(sdev, shost) {
+	shost_for_each_device_include_deleted(sdev, shost) {
 		if (scsi_host_eh_past_deadline(shost)) {
 			SCSI_LOG_ERROR_RECOVERY(3,
 				sdev_printk(KERN_INFO, sdev,
-- 
2.32.0

