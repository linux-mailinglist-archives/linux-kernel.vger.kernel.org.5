Return-Path: <linux-kernel+bounces-46077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00598439FE
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49451C20EA7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340257F48D;
	Wed, 31 Jan 2024 08:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F4ls8Pzs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nFBuAX1k";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F4ls8Pzs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nFBuAX1k"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306087AE73
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691091; cv=none; b=DR8eqkv2LLghlk9o2dkCQeXbRU9FOTTXGlZqYHq024BDSkzpI+QhEA6HXHT3iA0h8sKzVjA5G4M6xV1V1fy+B7LuKYXKb92i2Do9fwGoPrLyN116FKV07cyuuQ0BJOvbVxeRB6SPfo1HbrdwL/tlIagnBUdfayTOgdStx0cpiOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691091; c=relaxed/simple;
	bh=Xmqcw6mQjBwq1kAAoPhA0A+6YrUm6EiMG1QwvIgOy/8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G9XUzLujgUht7uLQYu2Doa/7F6x5Cp0lrsA9QEh5ub4+jy+ED8E8G/nOdL5oEB8OYIe+VUmCXjJPnZTiRT6IyC2p+8j1cR0OMI4ZHhlIx8zpYH22T8m8aGCser8a7tbIqtguePCykpMXR+sFCKNjy3wCn22Zyv/cRVEMPUpITic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F4ls8Pzs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nFBuAX1k; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F4ls8Pzs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nFBuAX1k; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9C80721FDD;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL27gd6DGt9Vl4ZzO/TXW5HIdjKpYLX1mMg66OftysM=;
	b=F4ls8PzsAVqNmD2rN5KZC/qhkGMcj0GmU1/sgf7itY7ojfY9Lq5q/6QglJvwPRKiYm1S7p
	BDmlB52pJS2/+HiEUArV3KaClZPWHSqd1twClA4RSahSUSD/aqtwC7Tv6n7GJW9rrXRrsz
	vYnQ8NB942ZyO5YESNXUQY1ZekXrMro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL27gd6DGt9Vl4ZzO/TXW5HIdjKpYLX1mMg66OftysM=;
	b=nFBuAX1kzm3wpfeGapQPi6szPKsUDFJpkdD46vsGYhmdOKv9yfxDrEmxeTQdvNJCTnXb7c
	+VEz0WHk+A+pP2CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL27gd6DGt9Vl4ZzO/TXW5HIdjKpYLX1mMg66OftysM=;
	b=F4ls8PzsAVqNmD2rN5KZC/qhkGMcj0GmU1/sgf7itY7ojfY9Lq5q/6QglJvwPRKiYm1S7p
	BDmlB52pJS2/+HiEUArV3KaClZPWHSqd1twClA4RSahSUSD/aqtwC7Tv6n7GJW9rrXRrsz
	vYnQ8NB942ZyO5YESNXUQY1ZekXrMro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691087;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nL27gd6DGt9Vl4ZzO/TXW5HIdjKpYLX1mMg66OftysM=;
	b=nFBuAX1kzm3wpfeGapQPi6szPKsUDFJpkdD46vsGYhmdOKv9yfxDrEmxeTQdvNJCTnXb7c
	+VEz0WHk+A+pP2CQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 89A2B132FA;
	Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Bu0mIA8KumWaHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:27 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 10/12] nvmet-fc: avoid deadlock on delete association path
Date: Wed, 31 Jan 2024 09:51:10 +0100
Message-ID: <20240131085112.21668-11-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131085112.21668-1-dwagner@suse.de>
References: <20240131085112.21668-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [3.07 / 50.00];
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
	 BAYES_HAM(-1.83)[94.03%]
X-Spam-Level: ***
X-Spam-Score: 3.07
X-Spam-Flag: NO

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index c80b8a066fd1..3e0d391e631b 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -247,6 +249,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -358,7 +367,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		goto out_puttgtport;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -371,8 +380,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1396,6 +1405,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


