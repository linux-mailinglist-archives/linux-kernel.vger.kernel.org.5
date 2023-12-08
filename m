Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5698280A194
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573760AbjLHKx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:53:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573683AbjLHKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:53:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8CCAC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:53:45 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B0DAB2118D;
        Fri,  8 Dec 2023 10:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FBiDaOFzP8RLJjbUw4tyCylAQX06GbRBT0ixmFvMiM=;
        b=Yrn/Ettdd2uAK4Hp3j7LSZxcFDmQ6BNHa8J/GRiW9YE5gt/NBdN81zY4G2n6HHdK/ndzqa
        JfwJANI7d3eR3ur3qsWD0KMtIGADyuUvU+JrIifB9YsHh6FQb19XqmECdxc9YWwuGZpVqm
        UDSOg1bGZKtdlvx9pdCdz3YvPCRUtpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FBiDaOFzP8RLJjbUw4tyCylAQX06GbRBT0ixmFvMiM=;
        b=ekL8eaKY1UUk+hYG/myghSVMWc+sSa/bBjv34/xBh5FZyr6sduBhrBcLKOirtteLdzCzq2
        wNv+JmXZzj3+LPDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1702032823; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FBiDaOFzP8RLJjbUw4tyCylAQX06GbRBT0ixmFvMiM=;
        b=Yrn/Ettdd2uAK4Hp3j7LSZxcFDmQ6BNHa8J/GRiW9YE5gt/NBdN81zY4G2n6HHdK/ndzqa
        JfwJANI7d3eR3ur3qsWD0KMtIGADyuUvU+JrIifB9YsHh6FQb19XqmECdxc9YWwuGZpVqm
        UDSOg1bGZKtdlvx9pdCdz3YvPCRUtpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1702032823;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4FBiDaOFzP8RLJjbUw4tyCylAQX06GbRBT0ixmFvMiM=;
        b=ekL8eaKY1UUk+hYG/myghSVMWc+sSa/bBjv34/xBh5FZyr6sduBhrBcLKOirtteLdzCzq2
        wNv+JmXZzj3+LPDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 94F6A138FF;
        Fri,  8 Dec 2023 10:53:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id DYfcIrf1cmU3VgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Fri, 08 Dec 2023 10:53:43 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 3/6] nvme: refactor ns info setup function
Date:   Fri,  8 Dec 2023 11:53:34 +0100
Message-ID: <20231208105337.23409-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231208105337.23409-1-dwagner@suse.de>
References: <20231208105337.23409-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 0.70
X-Spamd-Result: default: False [1.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
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
X-Spam-Flag: NO
X-Spam-Score: 1.90
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use nvme_ns_head instead of nvme_ns where possible. This reduces the
coupling between the different data structures.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 107 +++++++++++++++++++--------------------
 drivers/nvme/host/zns.c  |  16 +++---
 2 files changed, 62 insertions(+), 61 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f0fe41afc958..2468076d64c6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1678,14 +1678,14 @@ int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 }
 
 #ifdef CONFIG_BLK_DEV_INTEGRITY
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
-				u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk,
+		struct nvme_ns_head *head, u32 max_integrity_segments)
 {
 	struct blk_integrity integrity = { };
 
-	switch (ns->head->pi_type) {
+	switch (head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		switch (ns->head->guard_type) {
+		switch (head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type3_crc;
 			integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1703,7 +1703,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		switch (ns->head->guard_type) {
+		switch (head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type1_crc;
 			integrity.tag_size = sizeof(u16);
@@ -1724,26 +1724,26 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	}
 
-	integrity.tuple_size = ns->head->ms;
+	integrity.tuple_size = head->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
 #else
-static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
-				u32 max_integrity_segments)
+static void nvme_init_integrity(struct gendisk *disk,
+		struct nvme_ns_head *head, u32 max_integrity_segments)
 {
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
-static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
+static void nvme_config_discard(struct nvme_ctrl *ctrl, struct gendisk *disk,
+		struct nvme_ns_head *head)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(head, UINT_MAX))
 		ctrl->max_discard_sectors =
-			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
+			nvme_lba_to_sect(head, ctrl->dmrsl);
 
 	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_max_discard_sectors(queue, 0);
@@ -1774,21 +1774,21 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
-static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_init_ms(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		struct nvme_id_ns *id)
 {
 	bool first = id->dps & NVME_NS_DPS_PI_FIRST;
 	unsigned lbaf = nvme_lbaf_index(id->flbas);
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_command c = { };
 	struct nvme_id_ns_nvm *nvm;
 	int ret = 0;
 	u32 elbaf;
 
-	ns->head->pi_size = 0;
-	ns->head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	head->pi_size = 0;
+	head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		ns->head->pi_size = sizeof(struct t10_pi_tuple);
-		ns->head->guard_type = NVME_NVM_NS_16B_GUARD;
+		head->pi_size = sizeof(struct t10_pi_tuple);
+		head->guard_type = NVME_NVM_NS_16B_GUARD;
 		goto set_pi;
 	}
 
@@ -1797,11 +1797,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 		return -ENOMEM;
 
 	c.identify.opcode = nvme_admin_identify;
-	c.identify.nsid = cpu_to_le32(ns->head->ns_id);
+	c.identify.nsid = cpu_to_le32(head->ns_id);
 	c.identify.cns = NVME_ID_CNS_CS_NS;
 	c.identify.csi = NVME_CSI_NVM;
 
-	ret = nvme_submit_sync_cmd(ns->ctrl->admin_q, &c, nvm, sizeof(*nvm));
+	ret = nvme_submit_sync_cmd(ctrl->admin_q, &c, nvm, sizeof(*nvm));
 	if (ret)
 		goto free_data;
 
@@ -1811,13 +1811,13 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_elbaf_sts(elbaf))
 		goto free_data;
 
-	ns->head->guard_type = nvme_elbaf_guard_type(elbaf);
-	switch (ns->head->guard_type) {
+	head->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (head->guard_type) {
 	case NVME_NVM_NS_64B_GUARD:
-		ns->head->pi_size = sizeof(struct crc64_pi_tuple);
+		head->pi_size = sizeof(struct crc64_pi_tuple);
 		break;
 	case NVME_NVM_NS_16B_GUARD:
-		ns->head->pi_size = sizeof(struct t10_pi_tuple);
+		head->pi_size = sizeof(struct t10_pi_tuple);
 		break;
 	default:
 		break;
@@ -1826,25 +1826,25 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 free_data:
 	kfree(nvm);
 set_pi:
-	if (ns->head->pi_size && (first || ns->head->ms == ns->head->pi_size))
-		ns->head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	if (head->pi_size && (first || head->ms == head->pi_size))
+		head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
-		ns->head->pi_type = 0;
+		head->pi_type = 0;
 
 	return ret;
 }
 
-static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
+static int nvme_configure_metadata(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head, struct nvme_id_ns *id)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	int ret;
 
-	ret = nvme_init_ms(ns, id);
+	ret = nvme_init_ms(ctrl, head, id);
 	if (ret)
 		return ret;
 
-	ns->head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
-	if (!ns->head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
@@ -1856,7 +1856,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return 0;
 
-		ns->head->features |= NVME_NS_EXT_LBAS;
+		head->features |= NVME_NS_EXT_LBAS;
 
 		/*
 		 * The current fabrics transport drivers support namespace
@@ -1867,8 +1867,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns->head))
-			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(head))
+			head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
 		 * For PCIe controllers, we can't easily remap the separate
@@ -1877,9 +1877,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * We allow extended LBAs for the passthrough interface, though.
 		 */
 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			ns->head->features |= NVME_NS_EXT_LBAS;
+			head->features |= NVME_NS_EXT_LBAS;
 		else
-			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
+			head->features |= NVME_NS_METADATA_SUPPORTED;
 	}
 	return 0;
 }
@@ -1902,11 +1902,11 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 	blk_queue_write_cache(q, vwc, vwc);
 }
 
-static void nvme_update_disk_info(struct gendisk *disk,
-		struct nvme_ns *ns, struct nvme_id_ns *id)
+static void nvme_update_disk_info(struct nvme_ctrl *ctrl, struct gendisk *disk,
+		struct nvme_ns_head *head, struct nvme_id_ns *id)
 {
-	sector_t capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
-	u32 bs = 1U << ns->head->lba_shift;
+	sector_t capacity = nvme_lba_to_sect(head, le64_to_cpu(id->nsze));
+	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	/*
@@ -1914,8 +1914,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
 	 */
-	if (ns->head->lba_shift > PAGE_SHIFT ||
-	    ns->head->lba_shift < SECTOR_SHIFT) {
+	if (head->lba_shift > PAGE_SHIFT || head->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
@@ -1932,7 +1931,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		if (id->nsfeat & NVME_NS_FEAT_ATOMICS && id->nawupf)
 			atomic_bs = (1 + le16_to_cpu(id->nawupf)) * bs;
 		else
-			atomic_bs = (1 + ns->ctrl->subsys->awupf) * bs;
+			atomic_bs = (1 + ctrl->subsys->awupf) * bs;
 	}
 
 	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
@@ -1958,20 +1957,20 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (ns->head->ms) {
+	if (head->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-		    (ns->head->features & NVME_NS_METADATA_SUPPORTED))
-			nvme_init_integrity(disk, ns,
-					    ns->ctrl->max_integrity_segments);
-		else if (!nvme_ns_has_pi(ns->head))
+		    (head->features & NVME_NS_METADATA_SUPPORTED))
+			nvme_init_integrity(disk, head,
+					    ctrl->max_integrity_segments);
+		else if (!nvme_ns_has_pi(head))
 			capacity = 0;
 	}
 
 	set_capacity_and_notify(disk, capacity);
 
-	nvme_config_discard(disk, ns);
+	nvme_config_discard(ctrl, disk, head);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
-					   ns->ctrl->max_zeroes_sectors);
+					   ctrl->max_zeroes_sectors);
 }
 
 static bool nvme_ns_is_readonly(struct nvme_ns *ns, struct nvme_ns_info *info)
@@ -2064,13 +2063,13 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
-	ret = nvme_configure_metadata(ns, id);
+	ret = nvme_configure_metadata(ns->ctrl, ns->head, id);
 	if (ret < 0) {
 		blk_mq_unfreeze_queue(ns->disk->queue);
 		goto out;
 	}
 	nvme_set_chunk_sectors(ns, id);
-	nvme_update_disk_info(ns->disk, ns, id);
+	nvme_update_disk_info(ns->ctrl, ns->disk, ns->head, id);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
 		ret = nvme_update_zone_info(ns, lbaf);
@@ -2100,7 +2099,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
-		nvme_update_disk_info(ns->head->disk, ns, id);
+		nvme_update_disk_info(ns->ctrl, ns->head->disk, ns->head, id);
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
 		nvme_mpath_revalidate_paths(ns);
 		blk_stack_limits(&ns->head->disk->queue->limits,
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ded52ab05424..56b27aabcad9 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -148,7 +148,8 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 	return NULL;
 }
 
-static int nvme_zone_parse_entry(struct nvme_ns *ns,
+static int nvme_zone_parse_entry(struct nvme_ctrl *ctrl,
+				 struct nvme_ns_head *head,
 				 struct nvme_zone_descriptor *entry,
 				 unsigned int idx, report_zones_cb cb,
 				 void *data)
@@ -156,20 +157,20 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 	struct blk_zone zone = { };
 
 	if ((entry->zt & 0xf) != NVME_ZONE_TYPE_SEQWRITE_REQ) {
-		dev_err(ns->ctrl->device, "invalid zone type %#x\n",
+		dev_err(ctrl->device, "invalid zone type %#x\n",
 				entry->zt);
 		return -EINVAL;
 	}
 
 	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	zone.cond = entry->zs >> 4;
-	zone.len = ns->head->zsze;
-	zone.capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zcap));
-	zone.start = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zslba));
+	zone.len = head->zsze;
+	zone.capacity = nvme_lba_to_sect(head, le64_to_cpu(entry->zcap));
+	zone.start = nvme_lba_to_sect(head, le64_to_cpu(entry->zslba));
 	if (zone.cond == BLK_ZONE_COND_FULL)
 		zone.wp = zone.start + zone.len;
 	else
-		zone.wp = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->wp));
+		zone.wp = nvme_lba_to_sect(head, le64_to_cpu(entry->wp));
 
 	return cb(&zone, idx, data);
 }
@@ -214,7 +215,8 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			break;
 
 		for (i = 0; i < nz && zone_idx < nr_zones; i++) {
-			ret = nvme_zone_parse_entry(ns, &report->entries[i],
+			ret = nvme_zone_parse_entry(ns->ctrl, ns->head,
+						    &report->entries[i],
 						    zone_idx, cb, data);
 			if (ret)
 				goto out_free;
-- 
2.43.0

