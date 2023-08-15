Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB15C77CC82
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237058AbjHOMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjHOMXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:23:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 172E8E52;
        Tue, 15 Aug 2023 05:23:17 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Ll6qvJzNmqw;
        Tue, 15 Aug 2023 20:19:43 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:23:14 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v4 6/9] scsi:scsi_debug: set command's result and sense data if the error is injected
Date:   Tue, 15 Aug 2023 20:23:13 +0800
Message-ID: <20230815122316.4129333-7-haowenchao2@huawei.com>
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

If a fail commnd error is injected, set the command's status and sense
data then finish this scsi command.

Set SCSI command's status and sense data format:
  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error type, fixed to 0x2                              |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error Count                                           |
  |        |      |  0: the rule will be ignored                          |
  |        |      |  positive: the rule will always take effect           |
  |        |      |  negative: the rule takes effect n times where -n is  |
  |        |      |            the value given. Ignored after n times     |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
  +--------+------+-------------------------------------------------------+
  |   4    |  x8  | Host byte in scsi_cmd::status                         |
  |        |      | [scsi_cmd::status has 32 bits holding these 3 bytes]  |
  +--------+------+-------------------------------------------------------+
  |   5    |  x8  | Driver byte in scsi_cmd::status                       |
  +--------+------+-------------------------------------------------------+
  |   6    |  x8  | SCSI Status byte in scsi_cmd::status                  |
  +--------+------+-------------------------------------------------------+
  |   7    |  x8  | SCSI Sense Key in scsi_cmnd                           |
  +--------+------+-------------------------------------------------------+
  |   8    |  x8  | SCSI ASC in scsi_cmnd                                 |
  +--------+------+-------------------------------------------------------+
  |   9    |  x8  | SCSI ASCQ in scsi_cmnd                                |
  +--------+------+-------------------------------------------------------+
Examples:
    error=/sys/kernel/debug/scsi_debug/0:0:0:1/error
    echo "2 -10 0x88 0 0 0x2 0x3 0x11 0x0" >${error}
will make device's read command return with media error with additional
sense of "Unrecovered read error" (UNC):

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Acked-by: Douglas Gilbert <dgilbert@interlog.com>
---
 drivers/scsi/scsi_debug.c | 46 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 1d28e7209f64..94c43b800694 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -7763,6 +7763,41 @@ static int sdebug_fail_queue_cmd(struct scsi_cmnd *cmnd)
 	return 0;
 }
 
+static int sdebug_fail_cmd(struct scsi_cmnd *cmnd, int *retval,
+			   struct sdebug_err_inject *info)
+{
+	struct scsi_device *sdp = cmnd->device;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdp->hostdata;
+	struct sdebug_err_inject *err;
+	unsigned char *cmd = cmnd->cmnd;
+	int ret = 0;
+	int result;
+
+	if (devip == NULL)
+		return 0;
+
+	list_for_each_entry(err, &devip->inject_err_list, list) {
+		if (err->type == ERR_FAIL_CMD &&
+		    (err->cmd == cmd[0] || err->cmd == 0xff)) {
+			if (!err->cnt)
+				return 0;
+			ret = !!err->cnt;
+			goto out_handle;
+		}
+	}
+	return 0;
+
+out_handle:
+	if (err->cnt < 0)
+		err->cnt++;
+	mk_sense_buffer(cmnd, err->sense_key, err->asc, err->asq);
+	result = err->status_byte | err->host_byte << 16 | err->driver_byte << 24;
+	*info = *err;
+	*retval = schedule_resp(cmnd, devip, result, NULL, 0, 0);
+
+	return ret;
+}
+
 static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 				   struct scsi_cmnd *scp)
 {
@@ -7783,6 +7818,7 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 	bool has_wlun_rl;
 	bool inject_now;
 	int ret = 0;
+	struct sdebug_err_inject err;
 
 	scsi_set_resid(scp, 0);
 	if (sdebug_statistics) {
@@ -7835,6 +7871,16 @@ static int scsi_debug_queuecommand(struct Scsi_Host *shost,
 		return ret;
 	}
 
+	if (sdebug_fail_cmd(scp, &ret, &err)) {
+		scmd_printk(KERN_INFO, scp,
+			"fail command 0x%x with hostbyte=0x%x, "
+			"driverbyte=0x%x, statusbyte=0x%x, "
+			"sense_key=0x%x, asc=0x%x, asq=0x%x\n",
+			opcode, err.host_byte, err.driver_byte,
+			err.status_byte, err.sense_key, err.asc, err.asq);
+		return ret;
+	}
+
 	if (unlikely(inject_now && !atomic_read(&sdeb_inject_pending)))
 		atomic_set(&sdeb_inject_pending, 1);
 
-- 
2.35.3

