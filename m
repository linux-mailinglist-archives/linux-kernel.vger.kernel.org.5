Return-Path: <linux-kernel+bounces-68263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DC8577F1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 903181F22113
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA041D54A;
	Fri, 16 Feb 2024 08:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oGmZ/pgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PlBPCkFL";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oGmZ/pgL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PlBPCkFL"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9771B95B
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073146; cv=none; b=Szh9dH5sn9hL5qfga4hoFPZPMO+qNxgc2OCwIzjLQ59Uwd13JbVpKeZQcuXf2hkr/SbNsms6RBVARyF42UaHG69SNIeUcpb3kiVEDXOnqtsYSGdNQC/m2jlG7/WtJZEptLPzl6gvSbAgi5j51u9WrRoIGloBDlCt5U9hIXJ4uCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073146; c=relaxed/simple;
	bh=AmBehZ5DjuPHaP/AQs1fixAgjbcdEg6oKvv5GCgMlqc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p+BvaA7TrG6Ve21BTfVUXWtlExBIqTO0mWZiP5YCgOreWI29n0r6SsYxBwOxOWKhg3oIe0UlqPHUATWoUS/jTbJGJE3vmGyqQuvJ6WIo569Tf4m5iM0KESp3BA8OV8+Y/K+3Htpb9JjwjxJ4hUHZ8gMzm8R3ePJXmArsu4u9tC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oGmZ/pgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PlBPCkFL; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oGmZ/pgL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=PlBPCkFL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ABAB2220C9;
	Fri, 16 Feb 2024 08:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=oGmZ/pgLPXXIqg5PJg5IICrS7lcXzZPrhgF5ZZaDAzecPsx3bHJimDJRZgkz14T4Z+YjjO
	qefg6v+g+wi72ALfCB+zcdcmMWgO7hYw85jR5iE/8FSlL044yNAzLRoyK+SJnOFVmu6hXS
	TEO9P5XgQeR/9NAnSRYHfg7sDuT4jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=PlBPCkFLZgBA+CGTDdAI4ZNYR2Nb2hvshPJQpjW0R+WpsDX9WSBTKtpt+EhlSxjHrq8eIv
	NMjX1osvgsJT0SDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=oGmZ/pgLPXXIqg5PJg5IICrS7lcXzZPrhgF5ZZaDAzecPsx3bHJimDJRZgkz14T4Z+YjjO
	qefg6v+g+wi72ALfCB+zcdcmMWgO7hYw85jR5iE/8FSlL044yNAzLRoyK+SJnOFVmu6hXS
	TEO9P5XgQeR/9NAnSRYHfg7sDuT4jq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1vZAwwN5v7M2QsLQcS5Sny5saf5uh8b6XoVupT450oA=;
	b=PlBPCkFLZgBA+CGTDdAI4ZNYR2Nb2hvshPJQpjW0R+WpsDX9WSBTKtpt+EhlSxjHrq8eIv
	NMjX1osvgsJT0SDQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 999BB13343;
	Fri, 16 Feb 2024 08:45:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id fGwHJLQgz2WccwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:40 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 3/6] nvme-fc: do not retry when auth fails or connection is refused
Date: Fri, 16 Feb 2024 09:45:23 +0100
Message-ID: <20240216084526.14133-4-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216084526.14133-1-dwagner@suse.de>
References: <20240216084526.14133-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.45 / 50.00];
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
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.45)[78.89%]
X-Spam-Level: ****
X-Spam-Score: 4.45
X-Spam-Flag: NO

The is no point in retrying to connect if the authentication fails.

Connection refused is also issued from the authentication path, thus
also do not retry.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a5b29e9ad342..b81046c9f171 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3312,6 +3312,8 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 			ctrl->cnum, status);
 		if (status > 0 && (status & NVME_SC_DNR))
 			recon = false;
+		if (status == NVME_SC_AUTH_REQUIRED || status == -ECONNREFUSED)
+			recon = false;
 	} else if (time_after_eq(jiffies, rport->dev_loss_end))
 		recon = false;
 
-- 
2.43.0


