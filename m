Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F3806933
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377161AbjLFIM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:12:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377078AbjLFIMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:12:49 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707681A4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:12:52 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E5FBA2206F;
        Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CCB57133DD;
        Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id clNbMAItcGUXHgAAn2gu4w
        (envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:50 +0000
From:   Daniel Wagner <dwagner@suse.de>
To:     linux-nvme@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 3/4] nvme: move ns id info to struct nvme_ns_head
Date:   Wed,  6 Dec 2023 09:12:43 +0100
Message-ID: <20231206081244.32733-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206081244.32733-1-dwagner@suse.de>
References: <20231206081244.32733-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: 1.98
X-Spamd-Result: default: False [1.98 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         R_SPF_SOFTFAIL(0.00)[~all:c];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-0.01)[-0.046];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Spamd-Bar: +
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
        spf=softfail (smtp-out1.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Queue-Id: E5FBA2206F
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the namesapce info to struct nvme_ns_head, because it's the same
for all associated namespaces.

The head pointer is accessible from the ns pointer so we could just
update all places with ns->x to ns->head->x. While this is okay for the
slow path, it's not for the fast path. Thus we store the head pointer as
private data into request_queue.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/apple.c      |   4 +-
 drivers/nvme/host/core.c       | 192 +++++++++++++++++----------------
 drivers/nvme/host/fc.c         |   4 +-
 drivers/nvme/host/ioctl.c      |  20 ++--
 drivers/nvme/host/multipath.c  |  31 +++---
 drivers/nvme/host/nvme.h       |  60 ++++++-----
 drivers/nvme/host/rdma.c       |  10 +-
 drivers/nvme/host/tcp.c        |   8 +-
 drivers/nvme/host/zns.c        |  34 +++---
 drivers/nvme/target/loop.c     |   4 +-
 drivers/nvme/target/passthru.c |   8 +-
 11 files changed, 197 insertions(+), 178 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 596bb11eeba5..04c1c5fbd4d1 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -732,7 +732,7 @@ static int apple_nvme_remove_sq(struct apple_nvme *anv)
 static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 					const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_ns_head *head = hctx->queue->queuedata;
 	struct apple_nvme_queue *q = hctx->driver_data;
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
 	struct request *req = bd->rq;
@@ -753,7 +753,7 @@ static blk_status_t apple_nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&anv->ctrl, req, true))
 		return nvme_fail_nonready_command(&anv->ctrl, req);
 
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(head, req);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1fabe1b81de0..caa52c2f57c8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -308,16 +308,16 @@ static void nvme_retry_req(struct request *req)
 
 static void nvme_log_error(struct request *req)
 {
-	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_ns_head *head = req->q->queuedata;
 	struct nvme_request *nr = nvme_req(req);
 
-	if (ns) {
-		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
-		       ns->disk ? ns->disk->disk_name : "?",
+	if (head) {
+		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %u blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
+		       head->disk ? head->disk->disk_name : "?",
 		       nvme_get_opcode_str(nr->cmd->common.opcode),
 		       nr->cmd->common.opcode,
-		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
-		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
+		       nvme_sect_to_lba(head, blk_rq_pos(req)),
+		       blk_rq_bytes(req) >> head->lba_shift,
 		       nvme_get_error_status_str(nr->status),
 		       nr->status >> 8 & 7,	/* Status Code Type */
 		       nr->status & 0xff,	/* Status Code */
@@ -757,16 +757,16 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(__nvme_check_ready);
 
-static inline void nvme_setup_flush(struct nvme_ns *ns,
+static inline void nvme_setup_flush(struct nvme_ns_head *head,
 		struct nvme_command *cmnd)
 {
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->common.opcode = nvme_cmd_flush;
-	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->common.nsid = cpu_to_le32(head->ns_id);
 }
 
-static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *cmnd)
+static blk_status_t nvme_setup_discard(struct nvme_ns_head *head,
+		struct request *req, struct nvme_command *cmnd)
 {
 	unsigned short segments = blk_rq_nr_discard_segments(req), n = 0;
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
@@ -794,8 +794,8 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	}
 
 	if (queue_max_discard_segments(req->q) == 1) {
-		u64 slba = nvme_sect_to_lba(ns, blk_rq_pos(req));
-		u32 nlb = blk_rq_sectors(req) >> (ns->lba_shift - 9);
+		u64 slba = nvme_sect_to_lba(head, blk_rq_pos(req));
+		u32 nlb = blk_rq_sectors(req) >> (head->lba_shift - 9);
 
 		range[0].cattr = cpu_to_le32(0);
 		range[0].nlb = cpu_to_le32(nlb);
@@ -803,8 +803,9 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		n = 1;
 	} else {
 		__rq_for_each_bio(bio, req) {
-			u64 slba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
-			u32 nlb = bio->bi_iter.bi_size >> ns->lba_shift;
+			u64 slba = nvme_sect_to_lba(head,
+						    bio->bi_iter.bi_sector);
+			u32 nlb = bio->bi_iter.bi_size >> head->lba_shift;
 
 			if (n < segments) {
 				range[n].cattr = cpu_to_le32(0);
@@ -825,7 +826,7 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 
 	memset(cmnd, 0, sizeof(*cmnd));
 	cmnd->dsm.opcode = nvme_cmd_dsm;
-	cmnd->dsm.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->dsm.nsid = cpu_to_le32(head->ns_id);
 	cmnd->dsm.nr = cpu_to_le32(segments - 1);
 	cmnd->dsm.attributes = cpu_to_le32(NVME_DSMGMT_AD);
 
@@ -835,14 +836,14 @@ static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 	return BLK_STS_OK;
 }
 
-static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
-			      struct request *req)
+static void nvme_set_ref_tag(struct nvme_ns_head *head,
+		struct nvme_command *cmnd, struct request *req)
 {
 	u32 upper, lower;
 	u64 ref48;
 
 	/* both rw and write zeroes share the same reftag format */
-	switch (ns->guard_type) {
+	switch (head->guard_type) {
 	case NVME_NVM_NS_16B_GUARD:
 		cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
 		break;
@@ -859,7 +860,7 @@ static void nvme_set_ref_tag(struct nvme_ns *ns, struct nvme_command *cmnd,
 	}
 }
 
-static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
+static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns_head *head,
 		struct request *req, struct nvme_command *cmnd)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
@@ -867,25 +868,25 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	memset(cmnd, 0, sizeof(*cmnd));
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
-		return nvme_setup_discard(ns, req, cmnd);
+		return nvme_setup_discard(head, req, cmnd);
 
 	cmnd->write_zeroes.opcode = nvme_cmd_write_zeroes;
-	cmnd->write_zeroes.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->write_zeroes.nsid = cpu_to_le32(head->ns_id);
 	cmnd->write_zeroes.slba =
-		cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+		cpu_to_le64(nvme_sect_to_lba(head, blk_rq_pos(req)));
 	cmnd->write_zeroes.length =
-		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+		cpu_to_le16((blk_rq_bytes(req) >> head->lba_shift) - 1);
 
-	if (!(req->cmd_flags & REQ_NOUNMAP) && (ns->features & NVME_NS_DEAC))
+	if (!(req->cmd_flags & REQ_NOUNMAP) && (head->features & NVME_NS_DEAC))
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
 
-	if (nvme_ns_has_pi(ns)) {
+	if (nvme_ns_has_pi(head)) {
 		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
-		switch (ns->pi_type) {
+		switch (head->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
 		case NVME_NS_DPS_PI_TYPE2:
-			nvme_set_ref_tag(ns, cmnd, req);
+			nvme_set_ref_tag(head, cmnd, req);
 			break;
 		}
 	}
@@ -893,7 +894,7 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	return BLK_STS_OK;
 }
 
-static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
+static inline blk_status_t nvme_setup_rw(struct nvme_ns_head *head,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
 {
@@ -910,17 +911,19 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 
 	cmnd->rw.opcode = op;
 	cmnd->rw.flags = 0;
-	cmnd->rw.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->rw.nsid = cpu_to_le32(head->ns_id);
 	cmnd->rw.cdw2 = 0;
 	cmnd->rw.cdw3 = 0;
 	cmnd->rw.metadata = 0;
-	cmnd->rw.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
-	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
+	cmnd->rw.slba =
+		cpu_to_le64(nvme_sect_to_lba(head, blk_rq_pos(req)));
+	cmnd->rw.length =
+		cpu_to_le16((blk_rq_bytes(req) >> head->lba_shift) - 1);
 	cmnd->rw.reftag = 0;
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
 
-	if (ns->ms) {
+	if (head->ms) {
 		/*
 		 * If formated with metadata, the block layer always provides a
 		 * metadata buffer if CONFIG_BLK_DEV_INTEGRITY is enabled.  Else
@@ -928,12 +931,12 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		 * namespace capacity to zero to prevent any I/O.
 		 */
 		if (!blk_integrity_rq(req)) {
-			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns)))
+			if (WARN_ON_ONCE(!nvme_ns_has_pi(head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
 		}
 
-		switch (ns->pi_type) {
+		switch (head->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
@@ -943,7 +946,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 					NVME_RW_PRINFO_PRCHK_REF;
 			if (op == nvme_cmd_zone_append)
 				control |= NVME_RW_APPEND_PIREMAP;
-			nvme_set_ref_tag(ns, cmnd, req);
+			nvme_set_ref_tag(head, cmnd, req);
 			break;
 		}
 	}
@@ -966,7 +969,7 @@ void nvme_cleanup_cmd(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_cleanup_cmd);
 
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
+blk_status_t nvme_setup_cmd(struct nvme_ns_head *head, struct request *req)
 {
 	struct nvme_command *cmd = nvme_req(req)->cmd;
 	blk_status_t ret = BLK_STS_OK;
@@ -980,35 +983,39 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		/* these are setup prior to execution in nvme_init_request() */
 		break;
 	case REQ_OP_FLUSH:
-		nvme_setup_flush(ns, cmd);
+		nvme_setup_flush(head, cmd);
 		break;
 	case REQ_OP_ZONE_RESET_ALL:
 	case REQ_OP_ZONE_RESET:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_RESET);
+		ret = nvme_setup_zone_mgmt_send(head, req,
+						cmd, NVME_ZONE_RESET);
 		break;
 	case REQ_OP_ZONE_OPEN:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OPEN);
+		ret = nvme_setup_zone_mgmt_send(head, req,
+						cmd, NVME_ZONE_OPEN);
 		break;
 	case REQ_OP_ZONE_CLOSE:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_CLOSE);
+		ret = nvme_setup_zone_mgmt_send(head, req,
+						cmd, NVME_ZONE_CLOSE);
 		break;
 	case REQ_OP_ZONE_FINISH:
-		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
+		ret = nvme_setup_zone_mgmt_send(head, req,
+						cmd, NVME_ZONE_FINISH);
 		break;
 	case REQ_OP_WRITE_ZEROES:
-		ret = nvme_setup_write_zeroes(ns, req, cmd);
+		ret = nvme_setup_write_zeroes(head, req, cmd);
 		break;
 	case REQ_OP_DISCARD:
-		ret = nvme_setup_discard(ns, req, cmd);
+		ret = nvme_setup_discard(head, req, cmd);
 		break;
 	case REQ_OP_READ:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
+		ret = nvme_setup_rw(head, req, cmd, nvme_cmd_read);
 		break;
 	case REQ_OP_WRITE:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		ret = nvme_setup_rw(head, req, cmd, nvme_cmd_write);
 		break;
 	case REQ_OP_ZONE_APPEND:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
+		ret = nvme_setup_rw(head, req, cmd, nvme_cmd_zone_append);
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -1084,12 +1091,13 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
-u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		u8 opcode)
 {
 	u32 effects = 0;
 
-	if (ns) {
-		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+	if (head) {
+		effects = le32_to_cpu(head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unusual effects:%08x\n",
@@ -1109,9 +1117,10 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
-u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		u8 opcode)
 {
-	u32 effects = nvme_command_effects(ctrl, ns, opcode);
+	u32 effects = nvme_command_effects(ctrl, head, opcode);
 
 	/*
 	 * For simplicity, IO to all namespaces is quiesced even if the command
@@ -1129,8 +1138,8 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
-		       struct nvme_command *cmd, int status)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		u32 effects, struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
 		nvme_unfreeze(ctrl);
@@ -1149,7 +1158,7 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
-	if (ns)
+	if (head)
 		return;
 
 	switch (cmd->common.opcode) {
@@ -1679,9 +1688,9 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 {
 	struct blk_integrity integrity = { };
 
-	switch (ns->pi_type) {
+	switch (ns->head->pi_type) {
 	case NVME_NS_DPS_PI_TYPE3:
-		switch (ns->guard_type) {
+		switch (ns->head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type3_crc;
 			integrity.tag_size = sizeof(u16) + sizeof(u32);
@@ -1699,7 +1708,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	case NVME_NS_DPS_PI_TYPE1:
 	case NVME_NS_DPS_PI_TYPE2:
-		switch (ns->guard_type) {
+		switch (ns->head->guard_type) {
 		case NVME_NVM_NS_16B_GUARD:
 			integrity.profile = &t10_pi_type1_crc;
 			integrity.tag_size = sizeof(u16);
@@ -1720,7 +1729,7 @@ static void nvme_init_integrity(struct gendisk *disk, struct nvme_ns *ns,
 		break;
 	}
 
-	integrity.tuple_size = ns->ms;
+	integrity.tuple_size = ns->head->ms;
 	blk_integrity_register(disk, &integrity);
 	blk_queue_max_integrity_segments(disk->queue, max_integrity_segments);
 }
@@ -1737,8 +1746,10 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 	struct request_queue *queue = disk->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (ctrl->dmrsl && ctrl->dmrsl <= nvme_sect_to_lba(ns, UINT_MAX))
-		ctrl->max_discard_sectors = nvme_lba_to_sect(ns, ctrl->dmrsl);
+	if (ctrl->dmrsl &&
+	    ctrl->dmrsl <= nvme_sect_to_lba(ns->head, UINT_MAX))
+		ctrl->max_discard_sectors =
+			nvme_lba_to_sect(ns->head, ctrl->dmrsl);
 
 	if (ctrl->max_discard_sectors == 0) {
 		blk_queue_max_discard_sectors(queue, 0);
@@ -1779,11 +1790,11 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	int ret = 0;
 	u32 elbaf;
 
-	ns->pi_size = 0;
-	ns->ms = le16_to_cpu(id->lbaf[lbaf].ms);
+	ns->head->pi_size = 0;
+	ns->head->ms = le16_to_cpu(id->lbaf[lbaf].ms);
 	if (!(ctrl->ctratt & NVME_CTRL_ATTR_ELBAS)) {
-		ns->pi_size = sizeof(struct t10_pi_tuple);
-		ns->guard_type = NVME_NVM_NS_16B_GUARD;
+		ns->head->pi_size = sizeof(struct t10_pi_tuple);
+		ns->head->guard_type = NVME_NVM_NS_16B_GUARD;
 		goto set_pi;
 	}
 
@@ -1806,13 +1817,13 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (nvme_elbaf_sts(elbaf))
 		goto free_data;
 
-	ns->guard_type = nvme_elbaf_guard_type(elbaf);
-	switch (ns->guard_type) {
+	ns->head->guard_type = nvme_elbaf_guard_type(elbaf);
+	switch (ns->head->guard_type) {
 	case NVME_NVM_NS_64B_GUARD:
-		ns->pi_size = sizeof(struct crc64_pi_tuple);
+		ns->head->pi_size = sizeof(struct crc64_pi_tuple);
 		break;
 	case NVME_NVM_NS_16B_GUARD:
-		ns->pi_size = sizeof(struct t10_pi_tuple);
+		ns->head->pi_size = sizeof(struct t10_pi_tuple);
 		break;
 	default:
 		break;
@@ -1821,10 +1832,10 @@ static int nvme_init_ms(struct nvme_ns *ns, struct nvme_id_ns *id)
 free_data:
 	kfree(nvm);
 set_pi:
-	if (ns->pi_size && (first || ns->ms == ns->pi_size))
-		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
+	if (ns->head->pi_size && (first || ns->head->ms == ns->head->pi_size))
+		ns->head->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
 	else
-		ns->pi_type = 0;
+		ns->head->pi_type = 0;
 
 	return ret;
 }
@@ -1838,8 +1849,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 	if (ret)
 		return ret;
 
-	ns->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
-	if (!ns->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
+	ns->head->features &= ~(NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS);
+	if (!ns->head->ms || !(ctrl->ops->flags & NVME_F_METADATA_SUPPORTED))
 		return 0;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
@@ -1851,7 +1862,7 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		if (WARN_ON_ONCE(!(id->flbas & NVME_NS_FLBAS_META_EXT)))
 			return 0;
 
-		ns->features |= NVME_NS_EXT_LBAS;
+		ns->head->features |= NVME_NS_EXT_LBAS;
 
 		/*
 		 * The current fabrics transport drivers support namespace
@@ -1862,8 +1873,8 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * Note, this check will need to be modified if any drivers
 		 * gain the ability to use other metadata formats.
 		 */
-		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns))
-			ns->features |= NVME_NS_METADATA_SUPPORTED;
+		if (ctrl->max_integrity_segments && nvme_ns_has_pi(ns->head))
+			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
 	} else {
 		/*
 		 * For PCIe controllers, we can't easily remap the separate
@@ -1872,9 +1883,9 @@ static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 		 * We allow extended LBAs for the passthrough interface, though.
 		 */
 		if (id->flbas & NVME_NS_FLBAS_META_EXT)
-			ns->features |= NVME_NS_EXT_LBAS;
+			ns->head->features |= NVME_NS_EXT_LBAS;
 		else
-			ns->features |= NVME_NS_METADATA_SUPPORTED;
+			ns->head->features |= NVME_NS_METADATA_SUPPORTED;
 	}
 	return 0;
 }
@@ -1900,8 +1911,8 @@ static void nvme_set_queue_limits(struct nvme_ctrl *ctrl,
 static void nvme_update_disk_info(struct gendisk *disk,
 		struct nvme_ns *ns, struct nvme_id_ns *id)
 {
-	sector_t capacity = nvme_lba_to_sect(ns, le64_to_cpu(id->nsze));
-	u32 bs = 1U << ns->lba_shift;
+	sector_t capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(id->nsze));
+	u32 bs = 1U << ns->head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 
 	/*
@@ -1909,7 +1920,8 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
 	 */
-	if (ns->lba_shift > PAGE_SHIFT || ns->lba_shift < SECTOR_SHIFT) {
+	if (ns->head->lba_shift > PAGE_SHIFT ||
+	    ns->head->lba_shift < SECTOR_SHIFT) {
 		capacity = 0;
 		bs = (1 << 9);
 	}
@@ -1952,12 +1964,12 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	 * I/O to namespaces with metadata except when the namespace supports
 	 * PI, as it can strip/insert in that case.
 	 */
-	if (ns->ms) {
+	if (ns->head->ms) {
 		if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
-		    (ns->features & NVME_NS_METADATA_SUPPORTED))
+		    (ns->head->features & NVME_NS_METADATA_SUPPORTED))
 			nvme_init_integrity(disk, ns,
 					    ns->ctrl->max_integrity_segments);
-		else if (!nvme_ns_has_pi(ns))
+		else if (!nvme_ns_has_pi(ns->head))
 			capacity = 0;
 	}
 
@@ -1988,7 +2000,7 @@ static void nvme_set_chunk_sectors(struct nvme_ns *ns, struct nvme_id_ns *id)
 	    is_power_of_2(ctrl->max_hw_sectors))
 		iob = ctrl->max_hw_sectors;
 	else
-		iob = nvme_lba_to_sect(ns, le16_to_cpu(id->noiob));
+		iob = nvme_lba_to_sect(ns->head, le16_to_cpu(id->noiob));
 
 	if (!iob)
 		return;
@@ -2021,7 +2033,7 @@ static int nvme_update_ns_info_generic(struct nvme_ns *ns,
 	if (nvme_ns_head_multipath(ns->head)) {
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
+		nvme_mpath_revalidate_paths(ns->head);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		ns->head->disk->flags |= GENHD_FL_HIDDEN;
@@ -2055,7 +2067,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	lbaf = nvme_lbaf_index(id->flbas);
-	ns->lba_shift = id->lbaf[lbaf].ds;
+	ns->head->lba_shift = id->lbaf[lbaf].ds;
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	ret = nvme_configure_metadata(ns, id);
@@ -2081,7 +2093,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	 * do not return zeroes.
 	 */
 	if ((id->dlfeat & 0x7) == 0x1 && (id->dlfeat & (1 << 3)))
-		ns->features |= NVME_NS_DEAC;
+		ns->head->features |= NVME_NS_DEAC;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
@@ -2096,7 +2108,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		blk_mq_freeze_queue(ns->head->disk->queue);
 		nvme_update_disk_info(ns->head->disk, ns, id);
 		set_disk_ro(ns->head->disk, nvme_ns_is_readonly(ns, info));
-		nvme_mpath_revalidate_paths(ns);
+		nvme_mpath_revalidate_paths(ns->head);
 		blk_stack_limits(&ns->head->disk->queue->limits,
 				 &ns->queue->limits, 0);
 		disk_update_readahead(ns->head->disk);
@@ -3618,7 +3630,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_init_ns_head(ctrl, info, &ns->head))
 		goto out_free_ns;
 
-	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
+	disk = blk_mq_alloc_disk(ctrl->tagset, ns->head);
 	if (IS_ERR(disk))
 		goto out_free_head;
 	disk->fops = &nvme_bdev_ops;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index fb22976a36a8..41f9bacae6f4 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2799,7 +2799,7 @@ static blk_status_t
 nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 			const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_ns_head *head = hctx->queue->queuedata;
 	struct nvme_fc_queue *queue = hctx->driver_data;
 	struct nvme_fc_ctrl *ctrl = queue->ctrl;
 	struct request *rq = bd->rq;
@@ -2813,7 +2813,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
-	ret = nvme_setup_cmd(ns, rq);
+	ret = nvme_setup_cmd(head, rq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 529b9954d2b8..29263009bb6e 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -61,7 +61,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
 	 * and marks this command as supported.  If not reject unprivileged
 	 * passthrough.
 	 */
-	effects = nvme_command_effects(ns->ctrl, ns, c->common.opcode);
+	effects = nvme_command_effects(ns->ctrl, ns->head, c->common.opcode);
 	if (!(effects & NVME_CMD_EFFECTS_CSUPP))
 		return false;
 
@@ -168,8 +168,8 @@ static int nvme_map_user_request(struct request *req, u64 ubuffer,
 		unsigned int flags)
 {
 	struct request_queue *q = req->q;
-	struct nvme_ns *ns = q->queuedata;
-	struct block_device *bdev = ns ? ns->disk->part0 : NULL;
+	struct nvme_ns_head *head = q->queuedata;
+	struct block_device *bdev = head ? head->disk->part0 : NULL;
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
@@ -222,7 +222,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 		void __user *meta_buffer, unsigned meta_len, u32 meta_seed,
 		u64 *result, unsigned timeout, unsigned int flags)
 {
-	struct nvme_ns *ns = q->queuedata;
+	struct nvme_ns_head *head = q->queuedata;
 	struct nvme_ctrl *ctrl;
 	struct request *req;
 	void *meta = NULL;
@@ -245,7 +245,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	bio = req->bio;
 	ctrl = nvme_req(req)->ctrl;
 
-	effects = nvme_passthru_start(ctrl, ns, cmd->common.opcode);
+	effects = nvme_passthru_start(ctrl, head, cmd->common.opcode);
 	ret = nvme_execute_rq(req, false);
 	if (result)
 		*result = le64_to_cpu(nvme_req(req)->result.u64);
@@ -257,7 +257,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
+		nvme_passthru_end(ctrl, head, effects, cmd, ret);
 
 	return ret;
 }
@@ -283,10 +283,10 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		return -EINVAL;
 	}
 
-	length = (io.nblocks + 1) << ns->lba_shift;
+	length = (io.nblocks + 1) << ns->head->lba_shift;
 
 	if ((io.control & NVME_RW_PRINFO_PRACT) &&
-	    ns->ms == sizeof(struct t10_pi_tuple)) {
+	    ns->head->ms == sizeof(struct t10_pi_tuple)) {
 		/*
 		 * Protection information is stripped/inserted by the
 		 * controller.
@@ -296,11 +296,11 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 		meta_len = 0;
 		metadata = NULL;
 	} else {
-		meta_len = (io.nblocks + 1) * ns->ms;
+		meta_len = (io.nblocks + 1) * ns->head->ms;
 		metadata = nvme_to_user_ptr(io.metadata);
 	}
 
-	if (ns->features & NVME_NS_EXT_LBAS) {
+	if (ns->head->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
 		meta_len = 0;
 	} else if (meta_len) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..24ccd5b9c350 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -82,11 +82,14 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 
 void nvme_failover_req(struct request *req)
 {
-	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_ns_head *head = req->q->queuedata;
+	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
+	struct nvme_ns *ns;
 	u16 status = nvme_req(req)->status & 0x7ff;
 	unsigned long flags;
 	struct bio *bio;
 
+	ns = nvme_find_get_ns(ctrl, head->ns_id);
 	nvme_mpath_clear_current_path(ns);
 
 	/*
@@ -94,14 +97,14 @@ void nvme_failover_req(struct request *req)
 	 * ready to serve this namespace.  Kick of a re-read of the ANA
 	 * information page, and just try any other available path for now.
 	 */
-	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
+	if (nvme_is_ana_error(status) && ctrl->ana_log_buf) {
 		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
-		queue_work(nvme_wq, &ns->ctrl->ana_work);
+		queue_work(nvme_wq, &ctrl->ana_work);
 	}
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	spin_lock_irqsave(&head->requeue_lock, flags);
 	for (bio = req->bio; bio; bio = bio->bi_next) {
-		bio_set_dev(bio, ns->head->disk->part0);
+		bio_set_dev(bio, head->disk->part0);
 		if (bio->bi_opf & REQ_POLLED) {
 			bio->bi_opf &= ~REQ_POLLED;
 			bio->bi_cookie = BLK_QC_T_NONE;
@@ -115,17 +118,17 @@ void nvme_failover_req(struct request *req)
 		 */
 		bio->bi_opf &= ~REQ_NOWAIT;
 	}
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&head->requeue_list, req);
+	spin_unlock_irqrestore(&head->requeue_lock, flags);
 
 	blk_mq_end_request(req, 0);
-	kblockd_schedule_work(&ns->head->requeue_work);
+	kblockd_schedule_work(&head->requeue_work);
 }
 
 void nvme_mpath_start_request(struct request *rq)
 {
-	struct nvme_ns *ns = rq->q->queuedata;
-	struct gendisk *disk = ns->head->disk;
+	struct nvme_ns_head *head = rq->q->queuedata;
+	struct gendisk *disk = head->disk;
 
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq))
 		return;
@@ -138,11 +141,11 @@ EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
 void nvme_mpath_end_request(struct request *rq)
 {
-	struct nvme_ns *ns = rq->q->queuedata;
+	struct nvme_ns_head *head = rq->q->queuedata;
 
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
-	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
+	bdev_end_io_acct(head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
 			 nvme_req(rq)->start_time);
 }
@@ -202,10 +205,10 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	up_read(&ctrl->namespaces_rwsem);
 }
 
-void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
+void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 {
-	struct nvme_ns_head *head = ns->head;
 	sector_t capacity = get_capacity(head->disk);
+	struct nvme_ns *ns;
 	int node;
 	int srcu_idx;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 578e6d311bc9..e6c7890b14c9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -451,6 +451,17 @@ struct nvme_ns_head {
 	bool			shared;
 	int			instance;
 	struct nvme_effects_log *effects;
+	int			lba_shift;
+	u16			ms;
+	u16			pi_size;
+	u16			sgs;
+	u32			sws;
+	u8			pi_type;
+	u8			guard_type;
+#ifdef CONFIG_BLK_DEV_ZONED
+	u64			zsze;
+#endif
+	unsigned long		features;
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -492,17 +503,6 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
-	int lba_shift;
-	u16 ms;
-	u16 pi_size;
-	u16 sgs;
-	u32 sws;
-	u8 pi_type;
-	u8 guard_type;
-#ifdef CONFIG_BLK_DEV_ZONED
-	u64 zsze;
-#endif
-	unsigned long features;
 	unsigned long flags;
 #define NVME_NS_REMOVING	0
 #define NVME_NS_ANA_PENDING	2
@@ -517,9 +517,9 @@ struct nvme_ns {
 };
 
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
-static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
+static inline bool nvme_ns_has_pi(struct nvme_ns_head *head)
 {
-	return ns->pi_type && ns->ms == ns->pi_size;
+	return head->pi_type && head->ms == head->pi_size;
 }
 
 struct nvme_ctrl_ops {
@@ -651,17 +651,17 @@ static inline int nvme_reset_subsystem(struct nvme_ctrl *ctrl)
 /*
  * Convert a 512B sector number to a device logical block number.
  */
-static inline u64 nvme_sect_to_lba(struct nvme_ns *ns, sector_t sector)
+static inline u64 nvme_sect_to_lba(struct nvme_ns_head *head, sector_t sector)
 {
-	return sector >> (ns->lba_shift - SECTOR_SHIFT);
+	return sector >> (head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
  * Convert a device logical block number to a 512B sector number.
  */
-static inline sector_t nvme_lba_to_sect(struct nvme_ns *ns, u64 lba)
+static inline sector_t nvme_lba_to_sect(struct nvme_ns_head *head, u64 lba)
 {
-	return lba << (ns->lba_shift - SECTOR_SHIFT);
+	return lba << (head->lba_shift - SECTOR_SHIFT);
 }
 
 /*
@@ -792,7 +792,7 @@ static inline enum req_op nvme_req_op(struct nvme_command *cmd)
 #define NVME_QID_ANY -1
 void nvme_init_request(struct request *req, struct nvme_command *cmd);
 void nvme_cleanup_cmd(struct request *req);
-blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req);
+blk_status_t nvme_setup_cmd(struct nvme_ns_head *head, struct request *req);
 blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 		struct request *req);
 bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
@@ -901,7 +901,7 @@ void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
-void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
+void nvme_mpath_revalidate_paths(struct nvme_ns_head *head);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_shutdown_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
@@ -909,10 +909,10 @@ void nvme_mpath_end_request(struct request *rq);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
-	struct nvme_ns *ns = req->q->queuedata;
+	struct nvme_ns_head *head = req->q->queuedata;
 
 	if ((req->cmd_flags & REQ_NVME_MPATH) && req->bio)
-		trace_block_bio_complete(ns->head->disk->queue, req->bio);
+		trace_block_bio_complete(head->disk->queue, req->bio);
 }
 
 extern bool multipath;
@@ -1004,13 +1004,14 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data);
 #ifdef CONFIG_BLK_DEV_ZONED
 int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf);
-blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
+blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns_head *head,
+				       struct request *req,
 				       struct nvme_command *cmnd,
 				       enum nvme_zone_mgmt_action action);
 #else
-static inline blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns,
-		struct request *req, struct nvme_command *cmnd,
-		enum nvme_zone_mgmt_action action)
+static inline blk_status_t nvme_setup_zone_mgmt_send(
+		struct nvme_ns_head *head, struct request *req,
+		struct nvme_command *cmnd, enum nvme_zone_mgmt_action action)
 {
 	return BLK_STS_NOTSUPP;
 }
@@ -1086,12 +1087,13 @@ static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 #endif
 
-u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
 			 u8 opcode);
-u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+			u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
-		       struct nvme_command *cmd, int status);
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns_head *head,
+		       u32 effects, struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
 void nvme_put_ns(struct nvme_ns *ns);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 81e2621169e5..0e967413ee43 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1407,7 +1407,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 	struct nvme_rdma_sgl *sgl = &req->data_sgl;
 	struct ib_reg_wr *wr = &req->reg_wr;
 	struct request *rq = blk_mq_rq_from_pdu(req);
-	struct nvme_ns *ns = rq->q->queuedata;
+	struct nvme_ns_head *head = rq->q->queuedata;
 	struct bio *bio = rq->bio;
 	struct nvme_keyed_sgl_desc *sg = &c->common.dptr.ksgl;
 	int nr;
@@ -1423,7 +1423,7 @@ static int nvme_rdma_map_sg_pi(struct nvme_rdma_queue *queue,
 		goto mr_put;
 
 	nvme_rdma_set_sig_attrs(blk_get_integrity(bio->bi_bdev->bd_disk), c,
-				req->mr->sig_attrs, ns->pi_type);
+				req->mr->sig_attrs, head->pi_type);
 	nvme_rdma_set_prot_checks(c, &req->mr->sig_attrs->check_mask);
 
 	ib_update_fast_reg_key(req->mr, ib_inc_rkey(req->mr->rkey));
@@ -1979,7 +1979,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_ns_head *head = hctx->queue->queuedata;
 	struct nvme_rdma_queue *queue = hctx->driver_data;
 	struct request *rq = bd->rq;
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -2007,7 +2007,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ib_dma_sync_single_for_cpu(dev, sqe->dma,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 
-	ret = nvme_setup_cmd(ns, rq);
+	ret = nvme_setup_cmd(head, rq);
 	if (ret)
 		goto unmap_qe;
 
@@ -2017,7 +2017,7 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
 	     c->common.opcode == nvme_cmd_read) &&
-	    nvme_ns_has_pi(ns))
+	    nvme_ns_has_pi(head))
 		req->use_sig_mr = true;
 	else
 		req->use_sig_mr = false;
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 08805f027810..169462faad47 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2483,7 +2483,7 @@ static blk_status_t nvme_tcp_map_data(struct nvme_tcp_queue *queue,
 	return 0;
 }
 
-static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
+static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns_head *head,
 		struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
@@ -2492,7 +2492,7 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	u8 hdgst = nvme_tcp_hdgst_len(queue), ddgst = 0;
 	blk_status_t ret;
 
-	ret = nvme_setup_cmd(ns, rq);
+	ret = nvme_setup_cmd(head, rq);
 	if (ret)
 		return ret;
 
@@ -2548,7 +2548,7 @@ static void nvme_tcp_commit_rqs(struct blk_mq_hw_ctx *hctx)
 static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_ns_head *head = hctx->queue->queuedata;
 	struct nvme_tcp_queue *queue = hctx->driver_data;
 	struct request *rq = bd->rq;
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
@@ -2558,7 +2558,7 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
-	ret = nvme_tcp_setup_cmd_pdu(ns, rq);
+	ret = nvme_tcp_setup_cmd_pdu(head, rq);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index ec8557810c21..51ac3a61ce3f 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -11,7 +11,7 @@ int nvme_revalidate_zones(struct nvme_ns *ns)
 {
 	struct request_queue *q = ns->queue;
 
-	blk_queue_chunk_sectors(q, ns->zsze);
+	blk_queue_chunk_sectors(q, ns->head->zsze);
 	blk_queue_max_zone_append_sectors(q, ns->ctrl->max_zone_append);
 
 	return blk_revalidate_disk_zones(ns->disk, NULL);
@@ -99,11 +99,12 @@ int nvme_update_zone_info(struct nvme_ns *ns, unsigned lbaf)
 		goto free_data;
 	}
 
-	ns->zsze = nvme_lba_to_sect(ns, le64_to_cpu(id->lbafe[lbaf].zsze));
-	if (!is_power_of_2(ns->zsze)) {
+	ns->head->zsze =
+		nvme_lba_to_sect(ns->head, le64_to_cpu(id->lbafe[lbaf].zsze));
+	if (!is_power_of_2(ns->head->zsze)) {
 		dev_warn(ns->ctrl->device,
 			"invalid zone size:%llu for namespace:%u\n",
-			ns->zsze, ns->head->ns_id);
+			ns->head->zsze, ns->head->ns_id);
 		status = -ENODEV;
 		goto free_data;
 	}
@@ -128,7 +129,7 @@ static void *nvme_zns_alloc_report_buffer(struct nvme_ns *ns,
 				   sizeof(struct nvme_zone_descriptor);
 
 	nr_zones = min_t(unsigned int, nr_zones,
-			 get_capacity(ns->disk) >> ilog2(ns->zsze));
+			 get_capacity(ns->head->disk) >> ilog2(ns->head->zsze));
 
 	bufsize = sizeof(struct nvme_zone_report) +
 		nr_zones * sizeof(struct nvme_zone_descriptor);
@@ -162,13 +163,13 @@ static int nvme_zone_parse_entry(struct nvme_ns *ns,
 
 	zone.type = BLK_ZONE_TYPE_SEQWRITE_REQ;
 	zone.cond = entry->zs >> 4;
-	zone.len = ns->zsze;
-	zone.capacity = nvme_lba_to_sect(ns, le64_to_cpu(entry->zcap));
-	zone.start = nvme_lba_to_sect(ns, le64_to_cpu(entry->zslba));
+	zone.len = ns->head->zsze;
+	zone.capacity = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zcap));
+	zone.start = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->zslba));
 	if (zone.cond == BLK_ZONE_COND_FULL)
 		zone.wp = zone.start + zone.len;
 	else
-		zone.wp = nvme_lba_to_sect(ns, le64_to_cpu(entry->wp));
+		zone.wp = nvme_lba_to_sect(ns->head, le64_to_cpu(entry->wp));
 
 	return cb(&zone, idx, data);
 }
@@ -196,11 +197,11 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	c.zmr.zrasf = NVME_ZRASF_ZONE_REPORT_ALL;
 	c.zmr.pr = NVME_REPORT_ZONE_PARTIAL;
 
-	sector &= ~(ns->zsze - 1);
+	sector &= ~(ns->head->zsze - 1);
 	while (zone_idx < nr_zones && sector < get_capacity(ns->disk)) {
 		memset(report, 0, buflen);
 
-		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns, sector));
+		c.zmr.slba = cpu_to_le64(nvme_sect_to_lba(ns->head, sector));
 		ret = nvme_submit_sync_cmd(ns->queue, &c, report, buflen);
 		if (ret) {
 			if (ret > 0)
@@ -220,7 +221,7 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 			zone_idx++;
 		}
 
-		sector += ns->zsze * nz;
+		sector += ns->head->zsze * nz;
 	}
 
 	if (zone_idx > 0)
@@ -232,14 +233,15 @@ int nvme_ns_report_zones(struct nvme_ns *ns, sector_t sector,
 	return ret;
 }
 
-blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns *ns, struct request *req,
-		struct nvme_command *c, enum nvme_zone_mgmt_action action)
+blk_status_t nvme_setup_zone_mgmt_send(struct nvme_ns_head *head,
+		struct request *req, struct nvme_command *c,
+		enum nvme_zone_mgmt_action action)
 {
 	memset(c, 0, sizeof(*c));
 
 	c->zms.opcode = nvme_cmd_zone_mgmt_send;
-	c->zms.nsid = cpu_to_le32(ns->head->ns_id);
-	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(ns, blk_rq_pos(req)));
+	c->zms.nsid = cpu_to_le32(head->ns_id);
+	c->zms.slba = cpu_to_le64(nvme_sect_to_lba(head, blk_rq_pos(req)));
 	c->zms.zsa = action;
 
 	if (req_op(req) == REQ_OP_ZONE_RESET_ALL)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 9cb434c58075..1c3abadecaa7 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -131,7 +131,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
-	struct nvme_ns *ns = hctx->queue->queuedata;
+	struct nvme_ns_head *head = hctx->queue->queuedata;
 	struct nvme_loop_queue *queue = hctx->driver_data;
 	struct request *req = bd->rq;
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(req);
@@ -141,7 +141,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (!nvme_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, req);
 
-	ret = nvme_setup_cmd(ns, req);
+	ret = nvme_setup_cmd(head, req);
 	if (ret)
 		return ret;
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 9fe07d7efa96..7c13084a8f87 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -216,11 +216,11 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
 	struct request *rq = req->p.rq;
 	struct nvme_ctrl *ctrl = nvme_req(rq)->ctrl;
-	struct nvme_ns *ns = rq->q->queuedata;
+	struct nvme_ns_head *head = rq->q->queuedata;
 	u32 effects;
 	int status;
 
-	effects = nvme_passthru_start(ctrl, ns, req->cmd->common.opcode);
+	effects = nvme_passthru_start(ctrl, head, req->cmd->common.opcode);
 	status = nvme_execute_rq(rq, false);
 	if (status == NVME_SC_SUCCESS &&
 	    req->cmd->common.opcode == nvme_admin_identify) {
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, head, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
@@ -339,7 +339,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	 * non-trivial effects, make sure to execute the command synchronously
 	 * in a workqueue so that nvme_passthru_end gets called.
 	 */
-	effects = nvme_command_effects(ctrl, ns, req->cmd->common.opcode);
+	effects = nvme_command_effects(ctrl, ns->head, req->cmd->common.opcode);
 	if (req->p.use_workqueue ||
 	    (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
-- 
2.43.0

