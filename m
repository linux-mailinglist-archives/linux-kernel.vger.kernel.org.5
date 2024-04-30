Return-Path: <linux-kernel+bounces-163986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 884408B76D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E06B283256
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00371173345;
	Tue, 30 Apr 2024 13:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lYt3wGrT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YW3g6yvJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lYt3wGrT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YW3g6yvJ"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2E172BBF
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483183; cv=none; b=qZ45ce6rohJp6OQHGMF47VvgeauxaLCEimQw9YAGYacDRZMhMfsnEvRx/xAdR8OwKkDe0S4kuL173USfXEBQwJiOf5+lR9flSjhSfv+bfEvOUIdMaMnHAOQTFW7IMxROenL+LNc9iN5A2kiAoA3ptgA2ZkHenVttwHj7sWWJLT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483183; c=relaxed/simple;
	bh=C6Zn8VOHwXTgHLQaPeMnYxE2OulkefG+XkQTMoyYnpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmsTmPX+voc8u+oVTWik5EuZ5FVcLOtB8BPiazTH02BUz/1szX2Sna6exGIN72HSifcfcsASYRkKzZeqkLBDYOflrPNxuvmo9Eq2q3uNJdptIwA6l+1iUndiZc+5knaMN7G9xGUUAlHT+GVJTfZSKMdpQ/aW7oiQ1tWlshxqKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lYt3wGrT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YW3g6yvJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lYt3wGrT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YW3g6yvJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E68CC3406F;
	Tue, 30 Apr 2024 13:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5rUttiao1gfgHiNuULv3j0RH1kQuIhcL6vcbzvshaQ=;
	b=lYt3wGrT8Fgv/Byww9jQhKoS1wZ2QJUuruYZsLj+dh+S3PET2l47ijL/TujEB2mwRAdhOi
	6KFeAcGH6BYnqj9Xbi7HnBIAAdjTzgrjNrhK2HzBVDBqMBYCeZPlosAczMarh6RyZuJlP9
	ALs81uj2apNenS9ourAbKt8W7o8HMVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5rUttiao1gfgHiNuULv3j0RH1kQuIhcL6vcbzvshaQ=;
	b=YW3g6yvJEPm5Y3U3HAheci9Sv1O8U4Lz5jPkw7DtF88iByTsVA+5WqVRpKrzORicSv7SkZ
	SbmbBefnwTLf4nDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lYt3wGrT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YW3g6yvJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483178; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5rUttiao1gfgHiNuULv3j0RH1kQuIhcL6vcbzvshaQ=;
	b=lYt3wGrT8Fgv/Byww9jQhKoS1wZ2QJUuruYZsLj+dh+S3PET2l47ijL/TujEB2mwRAdhOi
	6KFeAcGH6BYnqj9Xbi7HnBIAAdjTzgrjNrhK2HzBVDBqMBYCeZPlosAczMarh6RyZuJlP9
	ALs81uj2apNenS9ourAbKt8W7o8HMVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483178;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5rUttiao1gfgHiNuULv3j0RH1kQuIhcL6vcbzvshaQ=;
	b=YW3g6yvJEPm5Y3U3HAheci9Sv1O8U4Lz5jPkw7DtF88iByTsVA+5WqVRpKrzORicSv7SkZ
	SbmbBefnwTLf4nDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D25D4133A7;
	Tue, 30 Apr 2024 13:19:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GObnMervMGZ7MAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 30 Apr 2024 13:19:38 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 5/5] nvme: do not retry authentication failures
Date: Tue, 30 Apr 2024 15:19:28 +0200
Message-ID: <20240430131928.29766-6-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240430131928.29766-1-dwagner@suse.de>
References: <20240430131928.29766-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E68CC3406F
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]

When the key is invalid there is no point in retrying. Because the auth
code returns kernel error codes only, we can't test on the DNR bit.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/auth.c    | 6 +++---
 drivers/nvme/host/fabrics.c | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index a264b3ae078b..371e14f0a203 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -730,7 +730,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_CHALLENGE);
 	if (ret) {
 		chap->status = ret;
-		chap->error = -ECONNREFUSED;
+		chap->error = -EKEYREJECTED;
 		return;
 	}
 
@@ -797,7 +797,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 					 NVME_AUTH_DHCHAP_MESSAGE_SUCCESS1);
 	if (ret) {
 		chap->status = ret;
-		chap->error = -ECONNREFUSED;
+		chap->error = -EKEYREJECTED;
 		return;
 	}
 
@@ -818,7 +818,7 @@ static void nvme_queue_auth_work(struct work_struct *work)
 	ret = nvme_auth_process_dhchap_success1(ctrl, chap);
 	if (ret) {
 		/* Controller authentication failed */
-		chap->error = -ECONNREFUSED;
+		chap->error = -EKEYREJECTED;
 		goto fail2;
 	}
 
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 36d3e2ff27f3..c6ad2148c2e0 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -567,12 +567,18 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
  *
  * - the DNR bit is set and the specification states no further connect
  *   attempts with the same set of paramenters should be attempted.
+ *
+ * - when the authentication attempt fails, because the key was invalid.
+ *   This error code is set on the host side.
  */
 bool nvmf_should_reconnect(struct nvme_ctrl *ctrl, int status)
 {
 	if (status > 0 && (status & NVME_SC_DNR))
 		return false;
 
+	if (status == -EKEYREJECTED)
+		return false;
+
 	if (ctrl->opts->max_reconnects == -1 ||
 	    ctrl->nr_reconnects < ctrl->opts->max_reconnects)
 		return true;
-- 
2.44.0


