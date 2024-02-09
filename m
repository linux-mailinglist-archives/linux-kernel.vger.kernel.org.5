Return-Path: <linux-kernel+bounces-59766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8627184FB8A
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 053211F23B9E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 445A78289B;
	Fri,  9 Feb 2024 18:07:55 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5058287A;
	Fri,  9 Feb 2024 18:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502074; cv=none; b=QjmblAX+1NvFlzJB/HrmZFK9uzsQF2Q7XX4E6XGhJ7BRT+wsUKuvEykatMg3lu9hVdKS6QRL2R+SY6FviERNo3qvZMpFDD4A22t+QfPD/VYfOuf6e7DD2rgQwLWBb9+l6g0vh2C8ns9Yk7UZjbTG6Z9scwliRV4wM4YavH11pm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502074; c=relaxed/simple;
	bh=aljcQk4MQmpyKzAtV7ceY1hme0zd2kj7fNT+t/yE3Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IomoVoAKcGjc88EkwQY3CTfSI3rDgOsUGm4tiYN1VaS0tbB/KepUkxPASrReySp7HYi0g5UqEjapPCLJ5FysAHodQlWG90fSFsEVMFqTAd9pNNvp1Vw59VKadPJUgyvtr2AJO2a8kRTfdzIzJV6Ief/JBbXIaEYugiTg/P4vAOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2DA6421CF8;
	Fri,  9 Feb 2024 18:07:50 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5A401139E7;
	Fri,  9 Feb 2024 18:07:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uDRJC/RpxmVHNgAAD6G6ig
	(envelope-from <leeman.duncan@gmail.com>); Fri, 09 Feb 2024 18:07:48 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>,
	hare@suse.de,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH v4 2/2] fnic: move fnic_fnic_flush_tx() to a work queue
Date: Fri,  9 Feb 2024 10:07:35 -0800
Message-Id: <ce5ffa5d0ff82c2b2e283b3b4bff23291d49b05c.1707500786.git.lduncan@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1707500786.git.lduncan@suse.com>
References: <cover.1707500786.git.lduncan@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=none
X-Spamd-Result: default: False [3.59 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_TLS_ALL(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_FROM(0.50)[gmail.com];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmail.com,suse.de,cisco.com,suse.com];
	 TAGGED_FROM(0.00)[];
	 FREEMAIL_ENVFROM(0.00)[gmail.com]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 3.59
X-Rspamd-Queue-Id: 2DA6421CF8
X-Spam-Level: ***
X-Spam-Flag: NO
X-Spamd-Bar: +++

From: Lee Duncan <lduncan@suse.com>

Rather than call 'fnic_flush_tx()' from interrupt context we should
be moving it onto a work queue to avoid any locking issues.

Fixes: 1a1975551943 ("scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock")
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Lee Duncan <lduncan@suse.com>
---
 drivers/scsi/fnic/fnic.h      | 3 ++-
 drivers/scsi/fnic/fnic_fcs.c  | 5 +++--
 drivers/scsi/fnic/fnic_main.c | 1 +
 drivers/scsi/fnic/fnic_scsi.c | 4 ++--
 4 files changed, 8 insertions(+), 5 deletions(-)

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
+void fnic_flush_tx(struct work_struct *work);
 void fnic_eth_send(struct fcoe_ctlr *, struct sk_buff *skb);
 void fnic_set_port_id(struct fc_lport *, u32, struct fc_frame *);
 void fnic_update_mac(struct fc_lport *, u8 *new);
diff --git a/drivers/scsi/fnic/fnic_fcs.c b/drivers/scsi/fnic/fnic_fcs.c
index 5e312a55cc7d..a08293b2ad9f 100644
--- a/drivers/scsi/fnic/fnic_fcs.c
+++ b/drivers/scsi/fnic/fnic_fcs.c
@@ -1182,7 +1182,7 @@ int fnic_send(struct fc_lport *lp, struct fc_frame *fp)
 
 /**
  * fnic_flush_tx() - send queued frames.
- * @fnic: fnic device
+ * @work: pointer to work element
  *
  * Send frames that were waiting to go out in FC or Ethernet mode.
  * Whenever changing modes we purge queued frames, so these frames should
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
2.35.3


