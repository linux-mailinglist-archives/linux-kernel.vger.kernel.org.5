Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20E177CC8A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbjHOMXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjHOMXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:23:19 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D4FADF;
        Tue, 15 Aug 2023 05:23:18 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Lh52RxztSD3;
        Tue, 15 Aug 2023 20:19:40 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:23:15 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v4 8/9] scsi:scsi_debug: Add new error injection reset lun failed
Date:   Tue, 15 Aug 2023 20:23:15 +0800
Message-ID: <20230815122316.4129333-9-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230815122316.4129333-1-haowenchao2@huawei.com>
References: <20230815122316.4129333-1-haowenchao2@huawei.com>
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

Add error injection type 3 to make scsi_debug_device_reset() return FAILED.
Fail abort command foramt:

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x4                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error count                                           |
  |        |      |  0: this rule will be ignored                         |
  |        |      |  positive: the rule will always take effect           |
  |        |      |  negative: the rule takes effect n times where -n is  |
  |        |      |            the value given. Ignored after n times     |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
  +--------+------+-------------------------------------------------------+

Examples:
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "0 -10 0x12" > ${error}
will make the device return FAILED when try to reset lun with inquiry
command 10 times.
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "0 -10 0xff" > ${error}
will make the device return FAILED when try to reset lun 10 times.

Usually we do not care about what command it is when trying to perform
reset LUN, so 0xff could be applied.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 9e4ea3b38cd0..2c16e5f4ab28 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -295,6 +295,8 @@ enum sdebug_err_type {
 					/* with errors set in scsi_cmnd */
 	ERR_ABORT_CMD_FAILED	= 3,	/* control return FAILED from */
 					/* scsi_debug_abort() */
+	ERR_LUN_RESET_FAILED	= 4,	/* control return FAILED from */
+					/* scsi_debug_device_reseLUN_RESET_FAILEDt() */
 };
 
 struct sdebug_err_inject {
@@ -961,6 +963,7 @@ static int sdebug_error_show(struct seq_file *m, void *p)
 		switch (err->type) {
 		case ERR_TMOUT_CMD:
 		case ERR_ABORT_CMD_FAILED:
+		case ERR_LUN_RESET_FAILED:
 			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
 				err->cmd);
 		break;
@@ -1022,6 +1025,7 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 	switch (inject_type) {
 	case ERR_TMOUT_CMD:
 	case ERR_ABORT_CMD_FAILED:
+	case ERR_LUN_RESET_FAILED:
 		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
 			   &inject->cmd) != 3)
 			goto out_error;
@@ -5558,10 +5562,36 @@ static void scsi_debug_stop_all_queued(struct scsi_device *sdp)
 				scsi_debug_stop_all_queued_iter, sdp);
 }
 
+static int sdebug_fail_lun_reset(struct scsi_cmnd *cmnd)
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
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		if (err->type == ERR_LUN_RESET_FAILED &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			ret = !!err->cnt;
+			if (err->cnt < 0)
+				err->cnt++;
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 {
 	struct scsi_device *sdp = SCpnt->device;
 	struct sdebug_dev_info *devip = sdp->hostdata;
+	u8 *cmd = SCpnt->cmnd;
+	u8 opcode = cmd[0];
 
 	++num_dev_resets;
 
@@ -5572,6 +5602,11 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 	if (devip)
 		set_bit(SDEBUG_UA_POR, devip->uas_bm);
 
+	if (sdebug_fail_lun_reset(SCpnt)) {
+		scmd_printk(KERN_INFO, SCpnt, "fail lun reset 0x%x\n", opcode);
+		return FAILED;
+	}
+
 	return SUCCESS;
 }
 
-- 
2.35.3

