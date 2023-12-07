Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83BA8087F1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379434AbjLGMgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 07:36:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjLGMg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 07:36:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2219E10C4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 04:36:33 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A24BF220B3;
        Thu,  7 Dec 2023 12:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1701952591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTi7lqJSUFoSh21NMSNYr2N3Q4MDL6rTclp0k5Q3gx0=;
        b=dnGwrUWLQiUF4g0v1R6NR46vPYGiaIrIYPdMGiAOEtsYQvXN3znriC8JTyP1jux7fcGPmb
        WGrWay7n77Lgf8iQtcdtfGKP8M3bkcUxsag2k6XCSXFLZTF+O5bKyTF+JfhhuuNrHLDUEo
        KeBAUORERR4Lu401kPWgBz1PjWMKIGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1701952591;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TTi7lqJSUFoSh21NMSNYr2N3Q4MDL6rTclp0k5Q3gx0=;
        b=hhARkDQ/eRZgvYNuQW1fRARZVrrP/wyteBuHlgrMDuOtD4P12Qu+Yq5GvZiZrwnvjw/LPI
        De9G/tN3z/iLR5CA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 86161139E3;
        Thu,  7 Dec 2023 12:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id othKH0+8cWUAAwAAn2gu4w
        (envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:36:31 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 3/4] nvme: add csi, ms and nuse to sysfs
Date:   Thu,  7 Dec 2023 13:36:23 +0100
Message-ID: <20231207123624.29959-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207123624.29959-1-dwagner@suse.de>
References: <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         REPLY(-4.00)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -2.10
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

libnvme is using the sysfs for enumarating the nvme resources. Though
there are few missing attritbutes in the sysfs. For these libnvme issues
commands during discovering.

As the kernel already knows all these attributes and we would like to
avoid libnvme to issue commands all the time, expose these missing
attributes.

The nuse value is updated on request because the nuse is a volatile
value. Since any user can read the sysfs attribute, a very simple rate
limit is added (update once every 5 seconds). A more sophisticated
update strategy can be added later if there is actually a need for it.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c  |  4 +-
 drivers/nvme/host/nvme.h  |  6 +++
 drivers/nvme/host/sysfs.c | 89 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3270818fa0d..82c6faf424d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1454,7 +1454,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl,
 	return status;
 }
 
-static int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 			struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
@@ -2056,6 +2056,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->nuse = le64_to_cpu(id->nuse);
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns, id);
@@ -3418,6 +3419,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	head->ns_id = info->nsid;
 	head->ids = info->ids;
 	head->shared = info->is_shared;
+	ratelimit_state_init(&head->rs_nuse, 5 * HZ, 1);
 	kref_init(&head->ref);
 
 	if (head->ids.csi) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 32ec7ca30d7c..2b31641a97b9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -16,6 +16,7 @@
 #include <linux/rcupdate.h>
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
+#include <linux/ratelimit_types.h>
 
 #include <trace/events/block.h>
 
@@ -456,6 +457,7 @@ struct nvme_ns_head {
 	u16			pi_size;
 	u16			sgs;
 	u32			sws;
+	u64			nuse;
 	u8			pi_type;
 	u8			guard_type;
 #ifdef CONFIG_BLK_DEV_ZONED
@@ -463,6 +465,8 @@ struct nvme_ns_head {
 #endif
 	unsigned long		features;
 
+	struct ratelimit_state	rs_nuse;
+
 	struct cdev		cdev;
 	struct device		cdev_device;
 
@@ -867,6 +871,8 @@ int nvme_ns_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags);
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
+		struct nvme_id_ns **id);
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index d682d0a667a0..79e362e0ac47 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,12 +114,101 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
+}
+static DEVICE_ATTR_RO(csi);
+
+static ssize_t metadata_bytes_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ms);
+}
+static DEVICE_ATTR_RO(metadata_bytes);
+
+static int ns_head_update_nuse(struct nvme_ns_head *head)
+{
+	struct nvme_id_ns *id;
+	struct nvme_ns *ns;
+	int srcu_idx, ret = -EWOULDBLOCK;
+
+	/* Avoid issuing commands too often by rate limiting the update */
+	if (!__ratelimit(&head->rs_nuse))
+		return 0;
+
+	pr_info("%s: head %p\n", __func__, head);
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (!ns)
+		goto out_unlock;
+
+	ret = nvme_identify_ns(ns->ctrl, head->ns_id, &id);
+	if (ret)
+		goto out_unlock;
+
+	head->nuse = le64_to_cpu(id->nuse);
+	kfree(id);
+
+out_unlock:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
+static int ns_update_nuse(struct nvme_ns *ns)
+{
+	struct nvme_id_ns *id;
+	int ret;
+
+	/* Avoid issuing commands too often by rate limiting the update. */
+	if (!__ratelimit(&ns->head->rs_nuse))
+		return 0;
+
+	pr_info("%s: ns %p\n", __func__, ns);
+
+	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
+	if (ret)
+		goto out_free_id;
+
+	ns->head->nuse = le64_to_cpu(id->nuse);
+
+out_free_id:
+	kfree(id);
+
+	return ret;
+}
+
+static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct gendisk *disk = dev_to_disk(dev);
+	struct block_device *bdev = disk->part0;
+	int ret;
+
+	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
+	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+		ret = ns_head_update_nuse(head);
+	else
+		ret = ns_update_nuse(bdev->bd_disk->private_data);
+	if (ret)
+		return ret;
+
+	return sysfs_emit(buf, "%llu\n", head->nuse);
+}
+static DEVICE_ATTR_RO(nuse);
+
 static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
+	&dev_attr_csi.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_metadata_bytes.attr,
+	&dev_attr_nuse.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-- 
2.43.0

