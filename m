Return-Path: <linux-kernel+bounces-44974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5266A8429D5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 848C11C257E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0476712839A;
	Tue, 30 Jan 2024 16:45:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDA0F86ADC;
	Tue, 30 Jan 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706633112; cv=none; b=PMu9yD1NLzaYguym+jF8ONB9tDtVwfrdxLQoizU/CA8DcAXWjFnDq6qDBslS151kyiT6/TonBPFr6y1jb8bNTN+yYwDShD1TVCnVDk1tNP58l3Shd6pHE0lrdFtKO/YCRhXQN1xWn0+o3O9fQ2i9ySmlFPgNOETNKbnPV3PDELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706633112; c=relaxed/simple;
	bh=8H2VnuMaz3Xoq20OuLRAk9EMdZrV2vRbiGyNk64FNV0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G4gARPUvDdEaCvaFStyZTDdtjuCrd/XD10ey4uGGFXJsl2b5HVFZqxXurtGfsu3ZLKSM+mhZOhWzKHuyqVn18jYeJd85cVAXaRsFlGvePBTARsp6Siq3qKAwDdrY60KWNlVLALFv8H70RI2WwEUHugw7L+TuP66hkGJfqJnzxqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2039221F77;
	Tue, 30 Jan 2024 16:45:09 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B0F113212;
	Tue, 30 Jan 2024 16:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id wB2jM5MnuWXKWwAAn2gu4w
	(envelope-from <leeman.duncan@gmail.com>); Tue, 30 Jan 2024 16:45:07 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	hare@suse.de,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH 1/2] Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
Date: Tue, 30 Jan 2024 08:42:21 -0800
Message-Id: <83489c47c973bdf7c47e4bf3acbc57dfca1e5dd7.1706632031.git.lduncan@suse.com>
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
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.20
X-Spamd-Result: default: False [3.20 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_ENVFROM(0.00)[gmail.com];
	 TAGGED_FROM(0.00)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

From: Lee Duncan <lduncan@suse.com>

This reverts commit 1a1975551943f681772720f639ff42fbaa746212

This commit causes interrupts to be lost for FCoE devices,
since it changed sping locks from "bh" to "irqsave".

Instead, a work queue should be used, and will be addressed
in a separate patch.

Fixes: 1a1975551943f681772720f639ff42fbaa746212
Signed-off-by: Lee Duncan <lduncan@suse.com>
---
 drivers/scsi/fcoe/fcoe_ctlr.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/fcoe/fcoe_ctlr.c b/drivers/scsi/fcoe/fcoe_ctlr.c
index 19eee108db02..5c8d1ba3f8f3 100644
--- a/drivers/scsi/fcoe/fcoe_ctlr.c
+++ b/drivers/scsi/fcoe/fcoe_ctlr.c
@@ -319,17 +319,16 @@ static void fcoe_ctlr_announce(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *sel;
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 
 	kfree_skb(fip->flogi_req);
 	fip->flogi_req = NULL;
 	list_for_each_entry(fcf, &fip->fcfs, list)
 		fcf->flogi_sent = 0;
 
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	sel = fip->sel_fcf;
 
 	if (sel && ether_addr_equal(sel->fcf_mac, fip->dest_addr))
@@ -700,7 +699,6 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 {
 	struct fc_frame *fp;
 	struct fc_frame_header *fh;
-	unsigned long flags;
 	u16 old_xid;
 	u8 op;
 	u8 mac[ETH_ALEN];
@@ -734,11 +732,11 @@ int fcoe_ctlr_els_send(struct fcoe_ctlr *fip, struct fc_lport *lport,
 		op = FIP_DT_FLOGI;
 		if (fip->mode == FIP_MODE_VN2VN)
 			break;
-		spin_lock_irqsave(&fip->ctlr_lock, flags);
+		spin_lock_bh(&fip->ctlr_lock);
 		kfree_skb(fip->flogi_req);
 		fip->flogi_req = skb;
 		fip->flogi_req_send = 1;
-		spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+		spin_unlock_bh(&fip->ctlr_lock);
 		schedule_work(&fip->timer_work);
 		return -EINPROGRESS;
 	case ELS_FDISC:
@@ -1707,11 +1705,10 @@ static int fcoe_ctlr_flogi_send_locked(struct fcoe_ctlr *fip)
 static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 	int error;
 
 	mutex_lock(&fip->ctlr_mutex);
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	LIBFCOE_FIP_DBG(fip, "re-sending FLOGI - reselect\n");
 	fcf = fcoe_ctlr_select(fip);
 	if (!fcf || fcf->flogi_sent) {
@@ -1722,7 +1719,7 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 		fcoe_ctlr_solicit(fip, NULL);
 		error = fcoe_ctlr_flogi_send_locked(fip);
 	}
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 	mutex_unlock(&fip->ctlr_mutex);
 	return error;
 }
@@ -1739,9 +1736,8 @@ static int fcoe_ctlr_flogi_retry(struct fcoe_ctlr *fip)
 static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 {
 	struct fcoe_fcf *fcf;
-	unsigned long flags;
 
-	spin_lock_irqsave(&fip->ctlr_lock, flags);
+	spin_lock_bh(&fip->ctlr_lock);
 	fcf = fip->sel_fcf;
 	if (!fcf || !fip->flogi_req_send)
 		goto unlock;
@@ -1768,7 +1764,7 @@ static void fcoe_ctlr_flogi_send(struct fcoe_ctlr *fip)
 	} else /* XXX */
 		LIBFCOE_FIP_DBG(fip, "No FCF selected - defer send\n");
 unlock:
-	spin_unlock_irqrestore(&fip->ctlr_lock, flags);
+	spin_unlock_bh(&fip->ctlr_lock);
 }
 
 /**
-- 
2.43.0


