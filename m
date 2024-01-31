Return-Path: <linux-kernel+bounces-46075-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7B38439FC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C461DB26799
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B477E573;
	Wed, 31 Jan 2024 08:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TU01xr0S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wAD2FZou";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TU01xr0S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wAD2FZou"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B1287A715
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691090; cv=none; b=MrpluA+qxMdIZpbRaUnbyXdBaUh0J6y2VakvfzX5oon8/7MJq8XbQlG+INxerQ27D6291Zl8x+7SJd5R5Kqzo5Mm31YsBi/NXUpAbwQqcqItw1cORzi702B0xiidocY7oN2Ok24DmmuIhv8sKuHrY3t7NRRUpfG523hGRoFatN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691090; c=relaxed/simple;
	bh=R+AipVdTTaELXWWbeaDSdfAnVcS7MO9phDeUl4CdJu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UGYgiubMu7zom9f5E1v1n9dX9v7PUu5lyBUvH2RMH5x7WW3t206kHHoa7tA7tSJvkmoxV7lUaXX98rEpPcF+LRuX8SDeH7/1B+9oaAbWC8cMWVhTSpbellBJ9lZe0MHqnc9b9C85LBG4bEuA9jj5A3rrfJnrPoftC15AYiqU7uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TU01xr0S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wAD2FZou; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TU01xr0S; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wAD2FZou; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5FC0522195;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=TU01xr0SmQvGHMHPEX7edpYR4lUK+Dhf/GB5BR+8Sj/8r9ozgHuNGNSN02+rRS1JfB9m37
	ljMpmWhhzAZuVAEV8g6YBo5U35NH2cgL+bjH86Gm27gPRR/cJMGcMCi9yjzdP9zoaw+WXd
	alKr5hWFUtpbNAYiAZluRonPM4Z/0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=wAD2FZou0247eB3mwCA5n9uPdQM8tsAEFX+OT11GoxaJtcPw2jgh+8Acys7vkidhNfsN+f
	ZpIbNTY2jRh6e3AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691086; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=TU01xr0SmQvGHMHPEX7edpYR4lUK+Dhf/GB5BR+8Sj/8r9ozgHuNGNSN02+rRS1JfB9m37
	ljMpmWhhzAZuVAEV8g6YBo5U35NH2cgL+bjH86Gm27gPRR/cJMGcMCi9yjzdP9zoaw+WXd
	alKr5hWFUtpbNAYiAZluRonPM4Z/0oQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691086;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3eB42jWbgjp3aLM+hqddiDWAfylZBSkEz+/P6B/bCA=;
	b=wAD2FZou0247eB3mwCA5n9uPdQM8tsAEFX+OT11GoxaJtcPw2jgh+8Acys7vkidhNfsN+f
	ZpIbNTY2jRh6e3AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D14E132FA;
	Wed, 31 Jan 2024 08:51:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id SJNZEQ4KumWVHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:26 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 08/12] nvmet-fc: do not tack refs on tgtports from assoc
Date: Wed, 31 Jan 2024 09:51:08 +0100
Message-ID: <20240131085112.21668-9-dwagner@suse.de>
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
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TU01xr0S;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wAD2FZou
X-Spamd-Result: default: False [-1.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DWL_DNSWL_HI(-3.50)[suse.de:dkim];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-2.99)[99.94%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5FC0522195
X-Spam-Level: 
X-Spam-Score: -1.80
X-Spam-Flag: NO

The association life time is tied to the life time of the target port.
That means we should not take extra a refcount when creating a
association.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/fc.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 849d9b17c60a..fe3246024836 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1107,12 +1107,9 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 	if (idx < 0)
 		goto out_free_assoc;
 
-	if (!nvmet_fc_tgtport_get(tgtport))
-		goto out_ida;
-
 	assoc->hostport = nvmet_fc_alloc_hostport(tgtport, hosthandle);
 	if (IS_ERR(assoc->hostport))
-		goto out_put;
+		goto out_ida;
 
 	assoc->tgtport = tgtport;
 	assoc->a_id = idx;
@@ -1142,8 +1139,6 @@ nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 
 	return assoc;
 
-out_put:
-	nvmet_fc_tgtport_put(tgtport);
 out_ida:
 	ida_free(&tgtport->assoc_cnt, idx);
 out_free_assoc:
@@ -1180,7 +1175,6 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	nvmet_fc_tgtport_put(tgtport);
 	kfree(assoc);
 }
 
-- 
2.43.0


