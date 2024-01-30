Return-Path: <linux-kernel+bounces-44309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2C842027
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:54:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11003B2FC90
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9DBB67E88;
	Tue, 30 Jan 2024 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LAo3fr/H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SsY7mb+x";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LAo3fr/H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SsY7mb+x"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E2666773A
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608195; cv=none; b=C+nLmI/mA3cJWrxxRbYZtL6qDwMbEGgwTYjzdBhKHSaMeXDaYsWhGmzNZwcFIf6eOSw9wW8/aaJpV9+ucpPe6ehg686iM/wTiPQaUAEUHC9kmN8Q8ggBxDHdbK9fWhxogG/KI17+rn2k2fTJVkAlfF3MThwCyetEiR1LDaE2ypY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608195; c=relaxed/simple;
	bh=KnGHv6BGSSns72ZX170xf4lIjWhBNOj4vGR9qmL7ZWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HFAOfRNO54Nnx4hxj7MCJMw21HSCzepuamRftzuhb4AQerLT6hIJ6MtWyt7eGsbTAJiH40Wahj5k9c+NqbI/HgW5fkxv+nQMMJod5HMtFyRUl5M1Lv5vmRzk35pk+vMeE15ThS031+03mQkUOU+PUfxqjis2n8B2SfB5w5UdcuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LAo3fr/H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SsY7mb+x; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LAo3fr/H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SsY7mb+x; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5DBE221225;
	Tue, 30 Jan 2024 09:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rH9cozVr92s6dsaGqRSsupXe8vdit9l8VVLc6Q0nkH4=;
	b=LAo3fr/HTB2gReRrea2ZyOe4LrT4H0zR1D2aPV9QIWnyHBMUEJimdxJRmN0D/4Z0HtQf1g
	yuGLO8ackrSjxYvP/NOjv/JqQv+X941W70b+WYCJl7WAtgukL1IvrUa4nWuFB/ZzPsYsh8
	yq5BhFf/FHP2p4Vqs/19HrYJ46hcS3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rH9cozVr92s6dsaGqRSsupXe8vdit9l8VVLc6Q0nkH4=;
	b=SsY7mb+x5pooMLDbVHFZDSD3jJL5vRnbWxHfTlo/WFfbi0TxJwEXkP+qp0RNgQtFu/mkAC
	dabT71Gxu3m3zvBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706608192; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rH9cozVr92s6dsaGqRSsupXe8vdit9l8VVLc6Q0nkH4=;
	b=LAo3fr/HTB2gReRrea2ZyOe4LrT4H0zR1D2aPV9QIWnyHBMUEJimdxJRmN0D/4Z0HtQf1g
	yuGLO8ackrSjxYvP/NOjv/JqQv+X941W70b+WYCJl7WAtgukL1IvrUa4nWuFB/ZzPsYsh8
	yq5BhFf/FHP2p4Vqs/19HrYJ46hcS3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706608192;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rH9cozVr92s6dsaGqRSsupXe8vdit9l8VVLc6Q0nkH4=;
	b=SsY7mb+x5pooMLDbVHFZDSD3jJL5vRnbWxHfTlo/WFfbi0TxJwEXkP+qp0RNgQtFu/mkAC
	dabT71Gxu3m3zvBg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B00513462;
	Tue, 30 Jan 2024 09:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id z3HfEEDGuGWUbwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 30 Jan 2024 09:49:52 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 07/12] nvmet-fc: remove null hostport pointer check
Date: Tue, 30 Jan 2024 10:49:33 +0100
Message-ID: <20240130094938.1575-8-dwagner@suse.de>
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
X-Spam-Level: 
X-Spam-Score: -0.34
X-Spamd-Result: default: False [-0.34 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
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
	 BAYES_HAM(-0.04)[58.94%]
X-Spam-Flag: NO

An association has always a valid hostport pointer. Remove useless
null pointer check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 205a12b1e841..849d9b17c60a 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -488,8 +488,7 @@ nvmet_fc_xmt_disconnect_assoc(struct nvmet_fc_tgt_assoc *assoc)
 	 * message is normal. Otherwise, send unless the hostport has
 	 * already been invalidated by the lldd.
 	 */
-	if (!tgtport->ops->ls_req || !assoc->hostport ||
-	    assoc->hostport->invalid)
+	if (!tgtport->ops->ls_req || assoc->hostport->invalid)
 		return;
 
 	lsop = kzalloc((sizeof(*lsop) +
@@ -1524,8 +1523,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 	spin_lock_irqsave(&tgtport->lock, flags);
 	list_for_each_entry_safe(assoc, next,
 				&tgtport->assoc_list, a_list) {
-		if (!assoc->hostport ||
-		    assoc->hostport->hosthandle != hosthandle)
+		if (assoc->hostport->hosthandle != hosthandle)
 			continue;
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-- 
2.43.0


