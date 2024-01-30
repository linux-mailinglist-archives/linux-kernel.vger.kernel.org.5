Return-Path: <linux-kernel+bounces-44975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B52F08429D7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:45:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E754A1C21AC2
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B11886AF4;
	Tue, 30 Jan 2024 16:45:20 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A1129A95;
	Tue, 30 Jan 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633119; cv=none; b=MBhszNOtD4BZq5LhCoVyH643pJTIaLyYIUnQVpuqu+dSx9tLtxdJsIfoXqVaQUmJTYrp9Xk11gEKtw+KPfzsPLLNZ15gqc5CPrL8570WMem1dEXpzOTTTU32G53PcCxOGrZZPib+fwPtwYGUeNPkz5fNWo/GJNR5Pdx/fZAm9zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633119; c=relaxed/simple;
	bh=Piwy79QW6cDC70P3Di3e058IJrU9THBDbC12+4N07Hg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GhW5WZx01recRFuC7GUbTTI7NU2jSLl9mClqT7hI6XhjvukgJ+Im7ilEUHsunpofkVj4Jv+wBrkZ/LILBVQVPAeIMpPqyLzGB3NxiRzdgkdh/A9UvsRVMXJg+TJPofWhkcBS2s/ixg3R6QXwr5sIk2WleYh7EcSdAgSOsqrOqkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E83D1F871;
	Tue, 30 Jan 2024 16:45:10 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 71CA413212;
	Tue, 30 Jan 2024 16:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2IxNEZUnuWXKWwAAn2gu4w
	(envelope-from <leeman.duncan@gmail.com>); Tue, 30 Jan 2024 16:45:09 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
Date: Tue, 30 Jan 2024 08:42:22 -0800
Message-Id: <9c51ef07a04413fb2f2bd20f1534f96e004e4e59.1706632031.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1706632031.git.lduncan@suse.com>
References: <cover.1706632031.git.lduncan@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ********
X-Spam-Score: 8.30
X-Spamd-Result: default: False [8.30 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 FREEMAIL_FROM(0.50)[gmail.com];
	 R_MISSING_CHARSET(2.50)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-0.999];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_ENVFROM(0.00)[gmail.com];
	 TAGGED_FROM(0.00)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

From: Hannes Reinecke <hare@suse.de>

Rather than call 'fnic_flush_tx()' from interrupt context we should
be moving it onto a work queue to avoid any locking issues.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Duncan <lduncan@suse.com>
---
 drivers/scsi/fnic/fnic.h      | 3 ++-
 drivers/scsi/fnic/fnic_fcs.c  | 3 ++-
 drivers/scsi/fnic/fnic_main.c | 1 +
 drivers/scsi/fnic/fnic_scsi.c | 4 ++--
 4 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/fnic/fnic.h b/drivers/scsi/fnic/fnic.h
index 2074937c05bc..3b8eb7dee500 100644
--- a/drivers/scsi/fnic/fnic.h
+++ b/drivers/scsi/fnic/fnic.h
@@ -305,6 +305,7 @@ struct fnic {
 	unsigned int copy_wq_base;
 	struct work_struct link_work;
 	struct work_struct frame_work;
+	struct work_struct flush_work;
 	struct sk_buff_head frame_queue;
 	struct sk_buff_head tx_queue;
 
@@ -363,7 +364,7 @@ void fnic_handle_event(struct work_struct *work);
 int fnic_rq_cmpl_handler(struct fnic *fnic, int);
 int fnic_alloc_rq_frame(struct vnic_rq *rq);
 void fnic_free_rq_buf(struct vnic_rq *rq, struct vnic_rq_buf *buf);
-void fnic_flush_tx(struct fnic *);
+void fnic_flush_tx(struct work_struct *);
 void fnic_eth_send(struct fcoe_ctlr *, struct sk_buff *skb);
 void fnic_set_port_id(struct fc_lport *, u32, struct fc_frame *);
 void fnic_update_mac(struct fc_lport *, u8 *new);
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 5e312a55cc7d..1bf1418bbde4 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -1190,8 +1190,9 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
  *
  * Called without fnic_lock held.
  */
-void fnic_flush_tx(struct fnic *fnic)
+void fnic_flush_tx(struct work_struct *work)
 {
+	struct fnic *fnic = container_of(work, struct fnic, flush_work);
 	struct sk_buff *skb;
 	struct fc_frame *fp;
 
diff --git a/drivers/scsi/fnic/fnic_main.c b/drivers/scsi/fnic/fnic_main.c
index 5ed1d897311a..29eead383eb9 100644
--- a/drivers/scsi/fnic/fnic_main.c
+++ b/drivers/scsi/fnic/fnic_main.c
@@ -830,6 +830,7 @@ static int fnic_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		spin_lock_init(&fnic->vlans_lock);
 		INIT_WORK(&fnic->fip_frame_work, fnic_handle_fip_frame);
 		INIT_WORK(&fnic->event_work, fnic_handle_event);
+		INIT_WORK(&fnic->flush_work, fnic_flush_tx);
 		skb_queue_head_init(&fnic->fip_frame_queue);
 		INIT_LIST_HEAD(&fnic->evlist);
 		INIT_LIST_HEAD(&fnic->vlans);
diff --git a/drivers/scsi/fnic/fnic_scsi.c b/drivers/scsi/fnic/fnic_scsi.c
index 8d7fc5284293..fc4cee91b175 100644
--- a/drivers/scsi/fnic/fnic_scsi.c
+++ b/drivers/scsi/fnic/fnic_scsi.c
@@ -680,7 +680,7 @@ static int fnic_fcpio_fw_reset_cmpl_handler(struct fnic *fnic,
 
 	spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-	fnic_flush_tx(fnic);
+	queue_work(fnic_event_queue, &fnic->flush_work);
 
  reset_cmpl_handler_end:
 	fnic_clear_state_flags(fnic, FNIC_FLAGS_FWRESET);
@@ -736,7 +736,7 @@ static int fnic_fcpio_flogi_reg_cmpl_handler(struct fnic *fnic,
 		}
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
 
-		fnic_flush_tx(fnic);
+		queue_work(fnic_event_queue, &fnic->flush_work);
 		queue_work(fnic_event_queue, &fnic->frame_work);
 	} else {
 		spin_unlock_irqrestore(&fnic->fnic_lock, flags);
-- 
2.43.0


