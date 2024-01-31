Return-Path: <linux-kernel+bounces-46079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FAB843A00
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:01:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 034E41F2F27A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A2781ACB;
	Wed, 31 Jan 2024 08:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBXC8oQP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6obWJHvi";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OBXC8oQP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6obWJHvi"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B72287D3EE
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691092; cv=none; b=qi1uvE7FRCApFsneBTSqfLsPXhNw4PtC7xDCA2r72yl/1nhpFEaPsm7v1u51zzs7DnkEWRjCECBfutEri1SB8MLggSk/ydR8Tp+ihcqfPXF5uNVA+0y5wHKQBu1qYB+ITHPvnyTxTZVR3jOxJSgmrjRP0BKskJcLZYRDfmTev3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691092; c=relaxed/simple;
	bh=Z9gWC2G25hCWGCl47+YRayYU2N/Ai94DE14vEa8Sbcs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kSXEXmraJjcGVeMosz8dp///MQsv8fFlH/l3Qkbs70Zyp1SuV10JaG5Q0FrmoGA/5/yYp2diBTijr/r9Y9Fdz9YynB6DcJkiuXzG/jzPnyFSj9S5/KbTAKni+SmBYWvJWzlCbtUk97cD5/K4KYxwqx313Z43Ws6/jhKAztuvBDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OBXC8oQP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6obWJHvi; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OBXC8oQP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6obWJHvi; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DB16C1FD0B;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=OBXC8oQPr6ZF0lYYOWW6O0jhMCGW57QX750Z990q/UulyRcUaIKSe40O09i53JAPsYJ77u
	Z2r/MqGPjzBDi7FGkkdEEstlGHwxATon3cPcFRtRKNvvPH0OrovLIdI4pRiZg/an4Sr+Cm
	ERoozcOyGvyKLvucAuvDktLqKIEA/Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=6obWJHviNgPTc5jV/mxydkQyiR4M9kuwUWGO7nG1tgF5cy5rF5tFgg0TOvx9WYmza1mE9N
	vgUnqp0mQaL5wKCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=OBXC8oQPr6ZF0lYYOWW6O0jhMCGW57QX750Z990q/UulyRcUaIKSe40O09i53JAPsYJ77u
	Z2r/MqGPjzBDi7FGkkdEEstlGHwxATon3cPcFRtRKNvvPH0OrovLIdI4pRiZg/an4Sr+Cm
	ERoozcOyGvyKLvucAuvDktLqKIEA/Lk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WJCIq9El8S03OfhOtOXy9wpk3gzPO/oiT1fajRv6tE=;
	b=6obWJHviNgPTc5jV/mxydkQyiR4M9kuwUWGO7nG1tgF5cy5rF5tFgg0TOvx9WYmza1mE9N
	vgUnqp0mQaL5wKCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C90DA132FA;
	Wed, 31 Jan 2024 08:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id dtunLxAKumWfHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:28 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 12/12] nvmet-fc: use RCU list iterator for assoc_list
Date: Wed, 31 Jan 2024 09:51:12 +0100
Message-ID: <20240131085112.21668-13-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.26
X-Spamd-Result: default: False [2.26 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-1.44)[91.26%]
X-Spam-Flag: NO

The assoc_list is a RCU protected list, thus use the RCU flavor of list
functions.

Let's use this opportunity and refactor this code and move the lookup
into a helper and give it a descriptive name.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 671d096745a5..fd229f310c93 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1114,14 +1114,27 @@ nvmet_fc_schedule_delete_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	queue_work(nvmet_wq, &assoc->del_work);
 }
 
+static bool
+nvmet_fc_assoc_exits(struct nvmet_fc_tgtport *tgtport, u64 association_id)
+{
+	struct nvmet_fc_tgt_assoc *a;
+
+	list_for_each_entry_rcu(a, &tgtport->assoc_list, a_list) {
+		if (association_id == a->association_id)
+			return true;
+	}
+
+	return false;
+}
+
 static struct nvmet_fc_tgt_assoc *
 nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 {
-	struct nvmet_fc_tgt_assoc *assoc, *tmpassoc;
+	struct nvmet_fc_tgt_assoc *assoc;
 	unsigned long flags;
+	bool done;
 	u64 ran;
 	int idx;
-	bool needrandom = true;
 
 	if (!tgtport->pe)
 		return NULL;
@@ -1145,24 +1158,21 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	INIT_WORK(&assoc->del_work, nvmet_fc_delete_assoc_work);
 	atomic_set(&assoc->terminating, 0);
 
-	while (needrandom) {
+	done = false;
+	do {
 		get_random_bytes(&ran, sizeof(ran) - BYTES_FOR_QID);
 		ran = ran << BYTES_FOR_QID_SHIFT;
 
 		spin_lock_irqsave(&tgtport->lock, flags);
-		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
-			if (ran == tmpassoc->association_id) {
-				needrandom = true;
-				break;
-			}
-		}
-		if (!needrandom) {
+		rcu_read_lock();
+		if (!nvmet_fc_assoc_exits(tgtport, ran)) {
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
+			done = true;
 		}
+		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-	}
+	} while (!done);
 
 	return assoc;
 
-- 
2.43.0


