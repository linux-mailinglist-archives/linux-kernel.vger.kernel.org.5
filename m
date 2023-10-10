Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC18C7BF731
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjJJJVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbjJJJV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:21:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A50DA7;
        Tue, 10 Oct 2023 02:21:23 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4S4VfY434qzNp5d;
        Tue, 10 Oct 2023 17:17:25 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 17:21:20 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v6 05/10] scsi: scsi_debug: Return failed value if the error is injected
Date:   Tue, 10 Oct 2023 17:20:46 +0800
Message-ID: <20231010092051.608007-6-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20231010092051.608007-1-haowenchao2@huawei.com>
References: <20231010092051.608007-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm000012.china.huawei.com (7.193.23.142)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a fail queuecommand error is injected, return the failed value defined
in the rule from queuecommand.

Make queuecommand return format:
  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x1                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error count                                           |
  |        |      |  0: this rule will be ignored                         |
  |        |      |  positive: the rule will always take effect           |
  |        |      |  negative: the rule takes effect n times where -n is  |
  |        |      |            the value given. Ignored after n times     |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
  +--------+------+-------------------------------------------------------+
  |   4    |  x32 | The queuecommand() return value we want               |
  +--------+------+-------------------------------------------------------+

Examples:
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "1 1 0x12 0x1055" > ${error}
will make each INQUIRY command sent to that device return
0x1055 (SCSI_MLQUEUE_HOST_BUSY).

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9081c9d22882..efdd63dd6d25 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7769,6 +7769,34 @@ static int sdebug_timeout_cmd(struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+static int sdebug_fail_queue_cmd(struct scsi_cmnd *cmnd)
+{
+	struct scsi_device *sdp = cmnd->device;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
+	struct sdebug_err_inject *err;
+	unsigned char *cmd = cmnd->cmnd;
+	int ret = 0;
+
+	if (devip == NULL)
+		return 0;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
+		if (err->type == ERR_FAIL_QUEUE_CMD &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			ret = err->cnt ? err->queuecmd_ret : 0;
+			if (err->cnt < 0)
+				err->cnt++;
+
+			rcu_read_unlock();
+			return ret;
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7788,6 +7816,7 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	u8 opcode = cmd[0];
 	bool has_wlun_rl;
 	bool inject_now;
+	int ret = 0;
 
 	scsi_set_resid(scp, 0);
 	if (sdebug_statistics) {
@@ -7833,6 +7862,13 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 		return 0;
 	}
 
+	ret = sdebug_fail_queue_cmd(scp);
+	if (ret) {
+		scmd_printk(KERN_INFO, scp, "fail queue command 0x%x with 0x%x\n",
+				opcode, ret);
+		return ret;
+	}
+
 	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
 		atomic_set(&sdeb_inject_pending, 1);
 
-- 
2.32.0

