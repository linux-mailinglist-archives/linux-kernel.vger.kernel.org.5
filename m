Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E80777F9D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbjK0KaA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:30:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjK0K36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:29:58 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54A3EA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:30:04 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 20A1F202AC;
        Mon, 27 Nov 2023 10:30:03 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CB66132A6;
        Mon, 27 Nov 2023 10:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id N8CeAatvZGXgfwAAn2gu4w
        (envelope-from <dwagner@suse.de>); Mon, 27 Nov 2023 10:30:03 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Date:   Mon, 27 Nov 2023 11:32:08 +0100
Message-ID: <20231127103208.25748-1-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: ++++++++
X-Spam-Score: 8.27
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 20A1F202AC
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Spamd-Result: default: False [8.27 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         NEURAL_HAM_LONG(-0.32)[-0.317];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.20)[-0.998];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---

As discussed during ALPPS, these here are the missing attribures which libnvme
is still looking up via commands. I've tested this with a modified libnvme and
didn't observe any ioctls anymore.

I'm pretty sure the naming is a bit off for the variables. Not really sure if we
want to stick to the spec naming sceme or have our own one, e.g. 'nsze' vs
'capacity'.

Also getting a pointer to the nvme_ns data structure is a bit strange
(dev_to_nvme_ns). This stip is necessary as many of the ns attributes are in
nvme_ns. Shouldn't these per path values not all be the same and thus couldn't
these be in nvme_ns_head? Anyway, just not sure who to deal with this. So any
pointers highly welcomed!

Cheers,
Daniel

 drivers/nvme/host/core.c  |  2 ++
 drivers/nvme/host/nvme.h  |  2 ++
 drivers/nvme/host/sysfs.c | 72 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 80673ea63fea..f100ee241bd7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2029,6 +2029,8 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->nsze = le64_to_cpu(id->nsze);
+	ns->nuse = le64_to_cpu(id->nuse);
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	nvme_configure_metadata(ns, id);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470af..97652bf2c787 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -487,6 +487,8 @@ struct nvme_ns {
 	struct nvme_ns_head *head;
 
 	int lba_shift;
+	u64 nsze;
+	u64 nuse;
 	u16 ms;
 	u16 pi_size;
 	u16 sgs;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 212e1b05d298..b46faee50361 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,12 +114,84 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static struct nvme_ns *dev_to_nvme_ns(struct device *dev)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+
+	if (disk->fops == &nvme_bdev_ops)
+		return nvme_get_ns_from_dev(dev);
+	else {
+		struct nvme_ns_head *head = disk->private_data;
+		struct nvme_subsystem *subsys = head->subsys;
+		struct nvme_ctrl *ctrl;
+		struct nvme_ns *ns, *ret = NULL;
+
+		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+			down_read(&ctrl->namespaces_rwsem);
+			list_for_each_entry(ns, &ctrl->namespaces, list) {
+				ret = ns;
+				break;
+			}
+			up_read(&ctrl->namespaces_rwsem);
+		}
+		return ret;
+	}
+}
+
+static ssize_t csi_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sysfs_emit(buf, "%d\n", dev_to_ns_head(dev)->ids.csi);
+}
+static DEVICE_ATTR_RO(csi);
+
+static ssize_t lba_ds_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%d\n", ns->lba_shift);
+}
+static DEVICE_ATTR_RO(lba_ds);
+
+static ssize_t lba_ms_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%d\n", ns->ms);
+}
+static DEVICE_ATTR_RO(lba_ms);
+
+static ssize_t nsze_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->nsze);
+}
+static DEVICE_ATTR_RO(nsze);
+
+static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = dev_to_nvme_ns(dev);
+
+	return sysfs_emit(buf, "%llu\n", ns->nuse);
+}
+static DEVICE_ATTR_RO(nuse);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
+	&dev_attr_csi.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_lba_ds.attr,
+	&dev_attr_lba_ms.attr,
+	&dev_attr_nsze.attr,
+	&dev_attr_nuse.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
-- 
2.43.0

