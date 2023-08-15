Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 631B977CC86
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbjHOMXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236533AbjHOMXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:23:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF284E52;
        Tue, 15 Aug 2023 05:23:18 -0700 (PDT)
Received: from kwepemm600012.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RQ9Ln6QwjzNmr3;
        Tue, 15 Aug 2023 20:19:45 +0800 (CST)
Received: from build.huawei.com (10.175.101.6) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 15 Aug 2023 20:23:16 +0800
From:   Wenchao Hao <haowenchao2@huawei.com>
To:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Douglas Gilbert <dgilbert@interlog.com>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <louhongxiang@huawei.com>, Wenchao Hao <haowenchao2@huawei.com>,
        kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v4 9/9] scsi:scsi_debug: Add debugfs interface to fail target reset
Date:   Tue, 15 Aug 2023 20:23:16 +0800
Message-ID: <20230815122316.4129333-10-haowenchao2@huawei.com>
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

The interface is found at
/sys/kernel/debug/scsi_debug/target<h:c:t>/fail_reset where <h:c:t>
identifies the target to inject errors on. It's a simple bool type
interface which would make this target's reset fail if set to 'Y'.

Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
Reported-by: kernel test robot <oliver.sang@intel.com>
---
 drivers/scsi/scsi_debug.c | 106 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
index 2c16e5f4ab28..d9a34119d6dc 100644
--- a/drivers/scsi/scsi_debug.c
+++ b/drivers/scsi/scsi_debug.c
@@ -42,6 +42,7 @@
 #include <linux/xarray.h>
 #include <linux/prefetch.h>
 #include <linux/debugfs.h>
+#include <linux/async.h>
 
 #include <net/checksum.h>
 
@@ -355,6 +356,11 @@ struct sdebug_dev_info {
 	struct list_head inject_err_list;
 };
 
+struct sdebug_target_info {
+	bool reset_fail;
+	struct dentry *debugfs_entry;
+};
+
 struct sdebug_host_info {
 	struct list_head host_list;
 	int si_idx;	/* sdeb_store_info (per host) xarray index */
@@ -1069,6 +1075,83 @@ static const struct file_operations sdebug_error_fops = {
 	.release = single_release,
 };
 
+static int sdebug_target_reset_fail_show(struct seq_file *m, void *p)
+{
+	struct scsi_target *starget = (struct scsi_target *)m->private;
+	struct sdebug_target_info *targetip =
+		(struct sdebug_target_info *)starget->hostdata;
+
+	if (targetip)
+		seq_printf(m, "%c\n", targetip->reset_fail ? 'Y' : 'N');
+
+	return 0;
+}
+
+static int sdebug_target_reset_fail_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, sdebug_target_reset_fail_show, inode->i_private);
+}
+
+static ssize_t sdebug_target_reset_fail_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	int ret;
+	struct scsi_target *starget =
+		(struct scsi_target *)file->f_inode->i_private;
+	struct sdebug_target_info *targetip =
+		(struct sdebug_target_info *)starget->hostdata;
+
+	if (targetip) {
+		ret = kstrtobool_from_user(ubuf, count, &targetip->reset_fail);
+		return ret < 0 ? ret : count;
+	}
+	return -ENODEV;
+}
+
+static const struct file_operations sdebug_target_reset_fail_fops = {
+	.open	= sdebug_target_reset_fail_open,
+	.read	= seq_read,
+	.write	= sdebug_target_reset_fail_write,
+	.release = single_release,
+};
+
+static int sdebug_target_alloc(struct scsi_target *starget)
+{
+	struct sdebug_target_info *targetip;
+
+	targetip = kzalloc(sizeof(struct sdebug_target_info), GFP_KERNEL);
+	if (!targetip)
+		return -ENOMEM;
+
+	targetip->debugfs_entry = debugfs_create_dir(dev_name(&starget->dev),
+				sdebug_debugfs_root);
+	debugfs_create_file("fail_reset", 0600, targetip->debugfs_entry, starget,
+				&sdebug_target_reset_fail_fops);
+
+	starget->hostdata = targetip;
+
+	return 0;
+}
+
+static void sdebug_tartget_cleanup_async(void *data, async_cookie_t cookie)
+{
+	struct sdebug_target_info *targetip = data;
+
+	debugfs_remove(targetip->debugfs_entry);
+	kfree(targetip);
+}
+
+static void sdebug_target_destroy(struct scsi_target *starget)
+{
+	struct sdebug_target_info *targetip;
+
+	targetip = (struct sdebug_target_info *)starget->hostdata;
+	if (targetip) {
+		starget->hostdata = NULL;
+		async_schedule(sdebug_tartget_cleanup_async, targetip);
+	}
+}
+
 /* Only do the extra work involved in logical block provisioning if one or
  * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
  * real reads and writes (i.e. not skipping them for speed).
@@ -5610,11 +5693,25 @@ static int scsi_debug_device_reset(struct scsi_cmnd *SCpnt)
 	return SUCCESS;
 }
 
+static int sdebug_fail_target_reset(struct scsi_cmnd *cmnd)
+{
+	struct scsi_target *starget = scsi_target(cmnd->device);
+	struct sdebug_target_info *targetip =
+		(struct sdebug_target_info *)starget->hostdata;
+
+	if (targetip)
+		return targetip->reset_fail;
+
+	return 0;
+}
+
 static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 {
 	struct scsi_device *sdp = SCpnt->device;
 	struct sdebug_host_info *sdbg_host = shost_to_sdebug_host(sdp->host);
 	struct sdebug_dev_info *devip;
+	u8 *cmd = SCpnt->cmnd;
+	u8 opcode = cmd[0];
 	int k = 0;
 
 	++num_target_resets;
@@ -5632,6 +5729,12 @@ static int scsi_debug_target_reset(struct scsi_cmnd *SCpnt)
 		sdev_printk(KERN_INFO, sdp,
 			    "%s: %d device(s) found in target\n", __func__, k);
 
+	if (sdebug_fail_target_reset(SCpnt)) {
+		scmd_printk(KERN_INFO, SCpnt, "fail target reset 0x%x\n",
+			    opcode);
+		return FAILED;
+	}
+
 	return SUCCESS;
 }
 
@@ -8070,7 +8173,6 @@ static int sdebug_init_cmd_priv(struct Scsi_Host *shost, struct scsi_cmnd *cmd)
 	return 0;
 }
 
-
 static struct scsi_host_template sdebug_driver_template = {
 	.show_info =		scsi_debug_show_info,
 	.write_info =		scsi_debug_write_info,
@@ -8100,6 +8202,8 @@ static struct scsi_host_template sdebug_driver_template = {
 	.track_queue_depth =	1,
 	.cmd_size = sizeof(struct sdebug_scsi_cmd),
 	.init_cmd_priv = sdebug_init_cmd_priv,
+	.target_alloc =		sdebug_target_alloc,
+	.target_destroy =	sdebug_target_destroy,
 };
 
 static int sdebug_driver_probe(struct device *dev)
-- 
2.35.3

