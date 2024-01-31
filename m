Return-Path: <linux-kernel+bounces-46074-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 408408439FA
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F04FC28EC7D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566F37BB13;
	Wed, 31 Jan 2024 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NHAmMyQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W4sI37DX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NHAmMyQK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="W4sI37DX"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9815479DB6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691089; cv=none; b=TKVaCaNmFeH8UMLGjpOt+PwnfDtBE4x0M+Rk32URfyjuzmauu6Kk8MG8VNxgsX7Azjvz+ToBtGAx6xeSD9EDJ6Zy0dQe+c5PvsvWS9w1qtEUhzeywI4oYtTdzIagMeIiceMUTjRxx0jKdhe2MbLji0vpUFST0LlvMZq9cbLprG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691089; c=relaxed/simple;
	bh=rbtXDaL/qi89pWLOQtkFqNUvHWx0x9j5pGfN/TShjKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VfGy8EoLv1SXtiHaRDpWBFLi71AaJyfzorOLdAvcOf8jJMkdcoFRNmgp575UYLg0UV93wh6X3s+akSZOArAJdQ0otVpfnWaS6ag5/0QmhkV4XKmZ3YiKy6+Mf2efsZBuQRxyRNo9j3eeiP3IgaXlzuGRQLeC2R7XC7bvx/aX360=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NHAmMyQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W4sI37DX; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NHAmMyQK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=W4sI37DX; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BCDEF1FD0F;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=NHAmMyQKQYT5OEqL3RyqLj9MXbs0/dkRxZoDlthMh8/xGDGyc9yfDV0tzBHi9KgnMTQa6B
	tPfgD9MwDYZpcBd/rRgbORw+F43y3Mcggx35L3nsXKya784ZwD0EbQUAh9nVetA0fUEjJs
	AWLeMWpcjK5qE06w4/GBKpTqPSD/v6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=W4sI37DXQkm2VXmUdRbQC7iwR0RR33/atncmXWJHuDPRfr3cXvl3LPYnR24YReoL3YFZs/
	RJ3o/cdl7UlTr6Cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1706691085; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=NHAmMyQKQYT5OEqL3RyqLj9MXbs0/dkRxZoDlthMh8/xGDGyc9yfDV0tzBHi9KgnMTQa6B
	tPfgD9MwDYZpcBd/rRgbORw+F43y3Mcggx35L3nsXKya784ZwD0EbQUAh9nVetA0fUEjJs
	AWLeMWpcjK5qE06w4/GBKpTqPSD/v6E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1706691085;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MxNmhxKJEiZiWsKpthdX0fYbsMU3Gi9EApzBnVHkB7E=;
	b=W4sI37DXQkm2VXmUdRbQC7iwR0RR33/atncmXWJHuDPRfr3cXvl3LPYnR24YReoL3YFZs/
	RJ3o/cdl7UlTr6Cg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id AAD33132FA;
	Wed, 31 Jan 2024 08:51:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id jQA7KA0KumWRHAAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 31 Jan 2024 08:51:25 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 07/12] nvmet-fc: remove null hostport pointer check
Date: Wed, 31 Jan 2024 09:51:07 +0100
Message-ID: <20240131085112.21668-8-dwagner@suse.de>
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
X-Spamd-Result: default: False [2.14 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-2.76)[98.96%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: **
X-Spam-Score: 2.14
X-Spam-Flag: NO

An association has always a valid hostport pointer. Remove useless
null pointer check.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


