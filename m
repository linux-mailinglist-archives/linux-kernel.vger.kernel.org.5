Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC35806931
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377131AbjLFIMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjLFIMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:12:46 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 203ADD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:12:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADB21FCFA;
        Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 378F1133DD;
        Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id EekhDAItcGUVHgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:50 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 2/4] nvme: initialize head before namespace
Date:   Wed,  6 Dec 2023 09:12:42 +0100
Message-ID: <20231206081244.32733-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206081244.32733-1-dwagner@suse.de>
References: <20231206081244.32733-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.76 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_SPAM_SHORT(2.97)[0.989];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(4.60)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
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
X-Spam-Score: 11.76
X-Rspamd-Queue-Id: 4ADB21FCFA
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to use struct nvme_ns_head pointers instead of a struct
nvme_ns pointers, initialize the head pointer before we create the disk.
This allows us to attach the head as private data to the disk object.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 900c045fcae0..1fabe1b81de0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3474,10 +3474,11 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
 	return ret;
 }
 
-static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
+static int nvme_init_ns_head(struct nvme_ctrl *ctrl,
+			     struct nvme_ns_info *info,
+			     struct nvme_ns_head **head)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_ns_head *head = NULL;
+	struct nvme_ns_head *h = NULL;
 	int ret;
 
 	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
@@ -3499,8 +3500,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		 * up at any time.
 		 */
 		nvme_print_device_info(ctrl);
-		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
-		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
+		if ((ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
+		    ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
 		     info->is_shared)) {
 			dev_err(ctrl->device,
 				"ignoring nsid %d because of duplicate IDs\n",
@@ -3519,8 +3520,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-	head = nvme_find_ns_head(ctrl, info->nsid);
-	if (!head) {
+	h = nvme_find_ns_head(ctrl, info->nsid);
+	if (!h) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
 		if (ret) {
 			dev_err(ctrl->device,
@@ -3528,20 +3529,20 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				info->nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, info);
-		if (IS_ERR(head)) {
-			ret = PTR_ERR(head);
+		h = nvme_alloc_ns_head(ctrl, info);
+		if (IS_ERR(h)) {
+			ret = PTR_ERR(h);
 			goto out_unlock;
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if (!info->is_shared || !h->shared) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
 			goto out_put_ns_head;
 		}
-		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
+		if (!nvme_ns_ids_equal(&h->ids, &info->ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
 					info->nsid);
@@ -3557,13 +3558,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	}
 
-	list_add_tail_rcu(&ns->siblings, &head->list);
-	ns->head = head;
+	*head = h;
 	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
 
 out_put_ns_head:
-	nvme_put_ns_head(head);
+	nvme_put_ns_head(h);
 out_unlock:
 	mutex_unlock(&ctrl->subsys->lock);
 	return ret;
@@ -3615,15 +3615,22 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (!ns)
 		return;
 
+	if (nvme_init_ns_head(ctrl, info, &ns->head))
+		goto out_free_ns;
+
 	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
 	if (IS_ERR(disk))
-		goto out_free_ns;
+		goto out_free_head;
 	disk->fops = &nvme_bdev_ops;
 	disk->private_data = ns;
 
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
+	mutex_lock(&ctrl->subsys->lock);
+	list_add_tail_rcu(&ns->siblings, &ns->head->list);
+	mutex_unlock(&ctrl->subsys->lock);
+
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
@@ -3635,9 +3642,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, info))
-		goto out_cleanup_disk;
-
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -3691,9 +3695,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
-	nvme_put_ns_head(ns->head);
- out_cleanup_disk:
 	put_disk(disk);
+ out_free_head:
+	nvme_put_ns_head(ns->head);
  out_free_ns:
 	kfree(ns);
 }
-- 
2.43.0

