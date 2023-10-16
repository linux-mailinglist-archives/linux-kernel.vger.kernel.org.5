Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938E57C9D48
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 04:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjJPCDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 22:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJPCDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 22:03:39 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2ADC5;
        Sun, 15 Oct 2023 19:03:37 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S80g231KSzVlcN;
        Mon, 16 Oct 2023 09:59:58 +0800 (CST)
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
Subject: [PATCH v3 4/4] scsi: scsi_core: Fix IO hang when device removing
Date:   Mon, 16 Oct 2023 10:03:14 +0800
Message-ID: <20231016020314.1269636-5-haowenchao2@huawei.com>
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
removing, so scsi_run_queue() for these devices would be skipped in
scsi_run_host_queues() after blocking hosts' IO.

IO hang would be caused if return true when state is SDEV_CANCEL with
following order:

T1:					    T2:scsi_error_handler
__scsi_remove_device()
  scsi_device_set_state(sdev, SDEV_CANCEL)
  ...
  sd_remove()
  del_gendisk()
  blk_mq_freeze_queue_wait()
  					    scsi_eh_flush_done_q()
					      scsi_queue_insert(scmd,...)

scsi_queue_insert() would not kick device's queue since commit
8b566edbdbfb ("scsi: core: Only kick the requeue list if necessary")

After scsi_unjam_host(), the scsi error handler would call
scsi_run_host_queues() to trigger run queue for devices, while it
would not run queue for devices which is in progress of removing
because shost_for_each_device() would skip them.

So the requests added to these queues would not be handled any more,
and the removing device process would hang too.

Fix this issue by using shost_for_each_device_include_deleted() in
scsi_run_host_queues() to trigger a run queue for devices in removing.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 195ca80667d0..40f407ffd26f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -466,7 +466,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 {
 	struct scsi_device *sdev;
 
-	shost_for_each_device(sdev, shost)
+	shost_for_each_device_include_deleted(sdev, shost)
 		scsi_run_queue(sdev->request_queue);
 }
 
-- 
2.32.0

