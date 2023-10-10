Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 041247BF72D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJJJVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjJJJVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:21:25 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1366393;
        Tue, 10 Oct 2023 02:21:24 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4Vh944P8zrSj2;
        Tue, 10 Oct 2023 17:18:49 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 17:21:21 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v6 07/10] scsi: scsi_debug: Add new error injection abort failed
Date:   Tue, 10 Oct 2023 17:20:48 +0800
Message-ID: <20231010092051.608007-8-haowenchao2@huawei.com>
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

Add error injection type 3 to make scsi_debug_abort() return FAILED.
Fail abort command format:

  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x3                              |
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
    echo "3 -10 0x12" > ${error}
will make the device return FAILED when abort inquiry command 10 times.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Tested-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index d15d007f1317..89f47ded1e23 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -293,6 +293,8 @@ enum sdebug_err_type {
 	ERR_FAIL_CMD		= 2,	/* make specific scsi command's */
 					/* queuecmd return succeed but */
 					/* with errors set in scsi_cmnd */
+	ERR_ABORT_CMD_FAILED	= 3,	/* control return FAILED from */
+					/* scsi_debug_abort() */
 };
 
 struct sdebug_err_inject {
@@ -970,6 +972,7 @@ static int sdebug_error_show(struct seq_file *m, void *p)
 	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
 		switch (err->type) {
 		case ERR_TMOUT_CMD:
+		case ERR_ABORT_CMD_FAILED:
 			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
 				err->cmd);
 		break;
@@ -1031,6 +1034,7 @@ static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
 
 	switch (inject_type) {
 	case ERR_TMOUT_CMD:
+	case ERR_ABORT_CMD_FAILED:
 		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
 			   &inject->cmd) != 3)
 			goto out_error;
@@ -5512,9 +5516,39 @@ static void stop_all_queued(void)
 	mutex_unlock(&sdebug_host_list_mutex);
 }
 
+static int sdebug_fail_abort(struct scsi_cmnd *cmnd)
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
+		if (err->type == ERR_ABORT_CMD_FAILED &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			ret = !!err->cnt;
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
 static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 {
 	bool ok = scsi_debug_abort_cmnd(SCpnt);
+	u8 *cmd = SCpnt->cmnd;
+	u8 opcode = cmd[0];
 
 	++num_aborts;
 
@@ -5523,6 +5557,12 @@ static int scsi_debug_abort(struct scsi_cmnd *SCpnt)
 			    "%s: command%s found\n", __func__,
 			    ok ? "" : " not");
 
+	if (sdebug_fail_abort(SCpnt)) {
+		scmd_printk(KERN_INFO, SCpnt, "fail abort command 0x%x\n",
+			    opcode);
+		return FAILED;
+	}
+
 	return SUCCESS;
 }
 
-- 
2.32.0

