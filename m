Return-Path: <linux-kernel+bounces-59765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6A084FB88
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22911F23B43
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 18:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F5C823AA;
	Fri,  9 Feb 2024 18:07:52 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4D980BF5;
	Fri,  9 Feb 2024 18:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707502071; cv=none; b=IwymZB0jFO6TdduvkU5C14TtgL88OF7tfHffZEzOclwDejMwstbNOUlL//rDDC0IoO7K0oYat6T30YSClV4Nl5ebOWjIjQqhQoGUBvnBPNLDoU6Tpn0AzAxcohvIW8Qh9kOoiUVc0IeIQrg27iNmp6DyDqNWoMXatnJ39yqCp3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707502071; c=relaxed/simple;
	bh=jaCh4gKxi365pvMOS5CdGqtxgRcGDWeKVLC0cKY+Azo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b/3frR5yWK0bYAFqN3QQKGLdfV42mabZY7a+Gwv5BLQBXKjJFaA4fgXIg1h0oCw9fUwlWfXZNg68ULeWxeQGf3jyrt4b+cWt2OHQzkw1sJ4ztmpXZG9leiOHA0B+W8O+U4iB/uNLKVZuBgm8s4tiDT3anbMrf72Zdp0waTyujE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 05E4B1FD34;
	Fri,  9 Feb 2024 18:07:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3281E139E7;
	Fri,  9 Feb 2024 18:07:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0AS2AfJpxmVHNgAAD6G6ig
	(envelope-from <leeman.duncan@gmail.com>); Fri, 09 Feb 2024 18:07:46 +0000
From: Lee Duncan <leeman.duncan@gmail.com>
To: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Chengfeng Ye <dg573847474@gmail.com>,
	hare@suse.de,
	Satish Kharat <satishkh@cisco.com>,
	Sesidhar Baddela <sebaddel@cisco.com>,
	Karan Tilak Kumar <kartilak@cisco.com>,
	Lee Duncan <lduncan@suse.com>
Subject: [PATCH v4 1/2] Revert "scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock"
Date: Fri,  9 Feb 2024 10:07:34 -0800
Message-Id: <c578cdcd46b60470535c4c4a953e6a1feca0dffd.1707500786.git.lduncan@suse.com>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [9.50 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_SPAM(5.10)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_FROM(0.50)[gmail.com];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 MIME_GOOD(-0.10)[text/plain];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_ENVFROM(0.00)[gmail.com];
	 FREEMAIL_CC(0.00)[gmail.com,suse.de,cisco.com,suse.com];
	 TAGGED_FROM(0.00)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: *********
X-Spam-Score: 9.50
X-Spam-Flag: NO

From: Lee Duncan <lduncan@suse.com>

This reverts commit 1a1975551943f681772720f639ff42fbaa746212

This commit causes interrupts to be lost for FCoE devices,
since it changed sping locks from "bh" to "irqsave".

Instead, a work queue should be used, and will be addressed
in a separate patch.

Fixes: 1a1975551943 ("scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock")
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
2.35.3


