Return-Path: <linux-kernel+bounces-44315-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F36D84202A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A45A28D222
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A726775F;
	Tue, 30 Jan 2024 09:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQ2Mz5KK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T6CtLH/W";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oQ2Mz5KK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="T6CtLH/W"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E19866B47
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608200; cv=none; b=MjmVi+jyTY6EpUH8mtRRsB1x7ffsHA9o3S/3CmSdg+51dG9IIuk/9hi7AKkxdaUDZyuOrTM8HakGhfijA8V+r6o+BbVaQWh1sC/GK1roy3JoiL1S16Zz3HNBs4z/z4zg9Xi/fzLSNtBoI1SEESRy0iHy9WltNWhm+bz3eBEyGWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608200; c=relaxed/simple;
	bh=L3d1pt2sdWH3XCLQ+uXhn01xc68tnmI7IKiuyc7FeiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kt8X8lnBaK9k4wxnDd3GiJAs8tJGedXOjM2ZLiT4dk4jii+DA3wMSbKy0kMYs/q46lRl3QAEXuL91ZJI5A3553AzJ/DPC5BULOfkRmsR5+uOH+vg8YINxaSMLy+Gf03WhtBWbUYfwFOciD/999s9HI1UTSL+6LiTqPYl7RIeh4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQ2Mz5KK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T6CtLH/W; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oQ2Mz5KK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=T6CtLH/W; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9BFC021FBC;
	Tue, 30 Jan 2024 09:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=oQ2Mz5KK8Hm8cTq6JIDP3ucb8DjETD2xzytgiDe0+mhMtTl3tZGBKJyn4zPyY81nsqyAnq
	8TMrh1PU+ZvrF7nAa7lqKlmM5aFvSH5SRLyWX0Y5/nDoSYEqVlo62rWXotUXLKMy4UYWHt
	XnjQOdi4XwIRnFe2GdSwk6I9uGKb9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=T6CtLH/WAgliFsMQtpfhv2UJDZSXhtvAFlotxenj46M29yJfI12gecosBHvCYBDs5dHpxT
	FOqhSL68x8BX5iCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608195; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=oQ2Mz5KK8Hm8cTq6JIDP3ucb8DjETD2xzytgiDe0+mhMtTl3tZGBKJyn4zPyY81nsqyAnq
	8TMrh1PU+ZvrF7nAa7lqKlmM5aFvSH5SRLyWX0Y5/nDoSYEqVlo62rWXotUXLKMy4UYWHt
	XnjQOdi4XwIRnFe2GdSwk6I9uGKb9kk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608195;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LBhSlwz3AB0ajCmtnMnq+5bz4kW5cELOvagoWwjrYtM=;
	b=T6CtLH/WAgliFsMQtpfhv2UJDZSXhtvAFlotxenj46M29yJfI12gecosBHvCYBDs5dHpxT
	FOqhSL68x8BX5iCw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 88DF913462;
	Tue, 30 Jan 2024 09:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Wqn3H0PGuGWlbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:55 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 12/12] nvmet-fc: use RCU list iterator for assoc_list
Date: Tue, 30 Jan 2024 10:49:38 +0100
Message-ID: <20240130094938.1575-13-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130094938.1575-1-dwagner@suse.de>
References: <20240130094938.1575-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[38.88%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.90

The assoc_list is a RCU protected list, thus use the RCU flavor of list
functions.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 671d096745a5..b8d3e30f2ddb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1151,7 +1151,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 		spin_lock_irqsave(&tgtport->lock, flags);
 		needrandom = false;
-		list_for_each_entry(tmpassoc, &tgtport->assoc_list, a_list) {
+		rcu_read_lock();
+		list_for_each_entry_rcu(tmpassoc, &tgtport->assoc_list, a_list) {
+
 			if (ran == tmpassoc->association_id) {
 				needrandom = true;
 				break;
@@ -1161,6 +1163,7 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 			assoc->association_id = ran;
 			list_add_tail_rcu(&assoc->a_list, &tgtport->assoc_list);
 		}
+		rcu_read_unlock();
 		spin_unlock_irqrestore(&tgtport->lock, flags);
 	}
 
-- 
2.43.0


