Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362267AAE07
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233259AbjIVJaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233243AbjIVJ3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:29:49 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE055CD1;
        Fri, 22 Sep 2023 02:29:35 -0700 (PDT)
Received: from kwepemm000012.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RsRhV1kxPzGpmW;
        Fri, 22 Sep 2023 17:25:46 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm000012.china.huawei.com (7.193.23.142) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Fri, 22 Sep 2023 17:29:32 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <louhongxiang@huawei.com>,
        Wenchao Hao <haowenchao2@huawei.com>
Subject: [PATCH v5 02/10] scsi: scsi_debug: Add interface to manage single device's error inject
Date:   Fri, 22 Sep 2023 17:28:58 +0800
Message-ID: <20230922092906.2645265-3-haowenchao2@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20230922092906.2645265-1-haowenchao2@huawei.com>
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

This new facility uses the debugfs pseudo file system which is typically
mounted under the /sys/kernel/debug directory and requires root permissions
to access.

The interface file is found at /sys/kernel/debug/scsi_debug/<h:c:t:l>/error
where <h:c:t:l> identifies the device (logical unit (LU)) to inject errors
on.

For the following description the ${error} environment variable is assumed
to be set to/sys/kernel/debug/scsi_debug/1:0:0:0/error where 1:0:0:0 is a
pseudo device (LU) owned by the scsi_debug driver. Rules are written to
${error} in the normal sysfs fashion (e.g. 'echo "0 -2 0x12" > ${error}').

More than one rule can be active on a device at a time and inactive rules
(i.e. those whose Error count is 0) remain in the rule listing. The
existing rules can be read with 'cat ${error}' with one line output for
each rule.

The interface format is line-by-line, each line is an error injection rule.
Each rule contains integers separated by spaces, the first three columns
correspond to "Error code", "Error count" and "SCSI command", other
columns depend on Error code.

General rule format:
  +--------+------+-------------------------------------------------------+
  | Column | Type | Description                                           |
  +--------+------+-------------------------------------------------------+
  |   1    |  u8  | Error code                                            |
  |        |      |  0: timeout SCSI command                              |
  |        |      |  1: fail queuecommand, make queuecommand return       |
  |        |      |     given value                                       |
  |        |      |  2: fail command, finish command with SCSI status,    |
  |        |      |     sense key and ASC/ASCQ values                     |
  |        |      |  3: make abort commands for specific command fail     |
  |        |      |  4: make reset lun for specific command fail          |
  +--------+------+-------------------------------------------------------+
  |   2    |  s32 | Error count                                           |
  |        |      |  0: this rule will be ignored                         |
  |        |      |  positive: the rule will always take effect           |
  |        |      |  negative: the rule takes effect n times where -n is  |
  |        |      |            the value given. Ignored after n times     |
  +--------+------+-------------------------------------------------------+
  |   3    |  x8  | SCSI command opcode, 0xff for all commands            |
  +--------+------+-------------------------------------------------------+
  |  ...   |  xxx | Error type specific fields                            |
  +--------+------+-------------------------------------------------------+
Notes:
- when multiple error inject rules are added for the same SCSI command, the
  one with smaller error code will take effect (and the others will be
  ignored).
- if an same error (i.e. same Error code and SCSI command) is added, the
  older one will be overwritten.
- Currently, the basic types are (u8/u16/u32/u64/s8/s16/s32/s64) and the
  hexadecimal types (x8/x16/x32/x64)
- where a hexadecimal value is expected (e.g. Column 3: SCSI command
  opcode) the "0x" prefix is optional on the value (e.g. the INQUIRY opcode
  can be given as '0x12' or '12')
- when the Error count is negative, reading ${error} will show that value
  incrementing, stopping when it gets to 0

Acked-by: Douglas Gilbert <dgilbert@interlog.com>
Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
---
 drivers/scsi/scsi_debug.c | 206 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 202 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 35c336271b13..ca1e2f4878bc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -286,6 +286,42 @@ struct sdeb_zone_state {	/* ZBC: per zone state */
 	sector_t z_wp;
 };
 
+enum sdebug_err_type {
+	ERR_TMOUT_CMD		= 0,	/* make specific scsi command timeout */
+	ERR_FAIL_QUEUE_CMD	= 1,	/* make specific scsi command's */
+					/* queuecmd return failed */
+	ERR_FAIL_CMD		= 2,	/* make specific scsi command's */
+					/* queuecmd return succeed but */
+					/* with errors set in scsi_cmnd */
+};
+
+struct sdebug_err_inject {
+	int type;
+	struct list_head list;
+	int cnt;
+	unsigned char cmd;
+	struct rcu_head rcu;
+
+	union {
+		/*
+		 * For ERR_FAIL_QUEUE_CMD
+		 */
+		int queuecmd_ret;
+
+		/*
+		 * For ERR_FAIL_CMD
+		 */
+		struct {
+			unsigned char host_byte;
+			unsigned char driver_byte;
+			unsigned char status_byte;
+			unsigned char sense_key;
+			unsigned char asc;
+			unsigned char asq;
+		};
+	};
+};
+
 struct sdebug_dev_info {
 	struct list_head dev_list;
 	unsigned int channel;
@@ -311,6 +347,10 @@ struct sdebug_dev_info {
 	unsigned int max_open;
 	ktime_t create_ts;	/* time since bootup that this device was created */
 	struct sdeb_zone_state *zstate;
+
+	struct dentry *debugfs_entry;
+	struct spinlock list_lock;
+	struct list_head inject_err_list;
 };
 
 struct sdebug_host_info {
@@ -865,6 +905,143 @@ static const int condition_met_result = SAM_STAT_CONDITION_MET;
 
 static struct dentry *sdebug_debugfs_root;
 
+static void sdebug_err_free(struct rcu_head *head)
+{
+	struct sdebug_err_inject *inject =
+		container_of(head, typeof(*inject), rcu);
+
+	kfree(inject);
+}
+
+static void sdebug_err_add(struct scsi_device *sdev, struct sdebug_err_inject *new)
+{
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *err;
+
+	spin_lock(&devip->list_lock);
+	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
+		if (err->type == new->type && err->cmd == new->cmd) {
+			list_del_rcu(&err->list);
+			call_rcu(&err->rcu, sdebug_err_free);
+		}
+	}
+
+	list_add_tail_rcu(&new->list, &devip->inject_err_list);
+	spin_unlock(&devip->list_lock);
+}
+
+static int sdebug_error_show(struct seq_file *m, void *p)
+{
+	struct scsi_device *sdev = (struct scsi_device *)m->private;
+	struct sdebug_dev_info *devip = (struct sdebug_dev_info *)sdev->hostdata;
+	struct sdebug_err_inject *err;
+
+	seq_puts(m, "Type\tCount\tCommand\n");
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
+		switch (err->type) {
+		case ERR_TMOUT_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\n", err->type, err->cnt,
+				err->cmd);
+		break;
+
+		case ERR_FAIL_QUEUE_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\t0x%x\n", err->type,
+				err->cnt, err->cmd, err->queuecmd_ret);
+		break;
+
+		case ERR_FAIL_CMD:
+			seq_printf(m, "%d\t%d\t0x%x\t0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
+				err->type, err->cnt, err->cmd,
+				err->host_byte, err->driver_byte,
+				err->status_byte, err->sense_key,
+				err->asc, err->asq);
+		break;
+		}
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int sdebug_error_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sdebug_error_show, inode->i_private);
+}
+
+static ssize_t sdebug_error_write(struct file *file, const char __user *ubuf,
+		size_t count, loff_t *ppos)
+{
+	char *buf;
+	unsigned int inject_type;
+	struct sdebug_err_inject *inject;
+	struct scsi_device *sdev = (struct scsi_device *)file->f_inode->i_private;
+
+	buf = kmalloc(count, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	if (copy_from_user(buf, ubuf, count)) {
+		kfree(buf);
+		return -EFAULT;
+	}
+
+	if (sscanf(buf, "%d", &inject_type) != 1) {
+		kfree(buf);
+		return -EINVAL;
+	}
+
+	inject = kzalloc(sizeof(struct sdebug_err_inject), GFP_KERNEL);
+	if (!inject) {
+		kfree(buf);
+		return -ENOMEM;
+	}
+
+	switch (inject_type) {
+	case ERR_TMOUT_CMD:
+		if (sscanf(buf, "%d %d %hhx", &inject->type, &inject->cnt,
+			   &inject->cmd) != 3)
+			goto out_error;
+	break;
+
+	case ERR_FAIL_QUEUE_CMD:
+		if (sscanf(buf, "%d %d %hhx %x", &inject->type, &inject->cnt,
+			   &inject->cmd, &inject->queuecmd_ret) != 4)
+			goto out_error;
+	break;
+
+	case ERR_FAIL_CMD:
+		if (sscanf(buf, "%d %d %hhx %hhx %hhx %hhx %hhx %hhx %hhx",
+			   &inject->type, &inject->cnt, &inject->cmd,
+			   &inject->host_byte, &inject->driver_byte,
+			   &inject->status_byte, &inject->sense_key,
+			   &inject->asc, &inject->asq) != 9)
+			goto out_error;
+	break;
+
+	default:
+		goto out_error;
+	break;
+	}
+
+	kfree(buf);
+	sdebug_err_add(sdev, inject);
+
+	return count;
+
+out_error:
+	kfree(buf);
+	kfree(inject);
+	return -EINVAL;
+}
+
+static const struct file_operations sdebug_error_fops = {
+	.open	= sdebug_error_open,
+	.read	= seq_read,
+	.write	= sdebug_error_write,
+	.release = single_release,
+};
 
 /* Only do the extra work involved in logical block provisioning if one or
  * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
@@ -5099,6 +5276,8 @@ static struct sdebug_dev_info *sdebug_device_create(
 		}
 		devip->create_ts = ktime_get_boottime();
 		atomic_set(&devip->stopped, (sdeb_tur_ms_to_ready > 0 ? 2 : 0));
+		spin_lock_init(&devip->list_lock);
+		INIT_LIST_HEAD(&devip->inject_err_list);
 		list_add_tail(&devip->dev_list, &sdbg_host->dev_info_list);
 	}
 	return devip;
@@ -5144,6 +5323,7 @@ static int scsi_debug_slave_alloc(struct scsi_device *sdp)
 	if (sdebug_verbose)
 		pr_info("slave_alloc <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
+
 	return 0;
 }
 
@@ -5166,6 +5346,12 @@ static int scsi_debug_slave_configure(struct scsi_device *sdp)
 	if (sdebug_no_uld)
 		sdp->no_uld_attach = 1;
 	config_cdb_len(sdp);
+
+	devip->debugfs_entry = debugfs_create_dir(dev_name(&sdp->sdev_dev),
+				sdebug_debugfs_root);
+	debugfs_create_file("error", 0600, devip->debugfs_entry, sdp,
+				&sdebug_error_fops);
+
 	return 0;
 }
 
@@ -5173,15 +5359,27 @@ static void scsi_debug_slave_destroy(struct scsi_device *sdp)
 {
 	struct sdebug_dev_info *devip =
 		(struct sdebug_dev_info *)sdp->hostdata;
+	struct sdebug_err_inject *err;
 
 	if (sdebug_verbose)
 		pr_info("slave_destroy <%u %u %u %llu>\n",
 		       sdp->host->host_no, sdp->channel, sdp->id, sdp->lun);
-	if (devip) {
-		/* make this slot available for re-use */
-		devip->used = false;
-		sdp->hostdata = NULL;
+
+	if (!devip)
+		return;
+
+	spin_lock(&devip->list_lock);
+	list_for_each_entry_rcu(err, &devip->inject_err_list, list) {
+		list_del_rcu(&err->list);
+		call_rcu(&err->rcu, sdebug_err_free);
 	}
+	spin_unlock(&devip->list_lock);
+
+	debugfs_remove(devip->debugfs_entry);
+
+	/* make this slot available for re-use */
+	devip->used = false;
+	sdp->hostdata = NULL;
 }
 
 /* Returns true if we require the queued memory to be freed by the caller. */
-- 
2.32.0

