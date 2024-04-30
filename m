Return-Path: <linux-kernel+bounces-163982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE028B76CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7AF1C225DE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3564A172767;
	Tue, 30 Apr 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HBwqzsO2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDvklSiT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HBwqzsO2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDvklSiT"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996F171664
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483179; cv=none; b=JCZse+BEQ6NAi+pcRr3q++mYiLA08DrMHvIi/1abgBqzBam/fsUchmAFATyNJhjCdMZUWQJeV6YEu1nIxrM5k7ZPbdX3SJBFUlBO2lqjKjlaY2jn1vna2wZqJRWH6vh1c3M4dXE4FAIZSxQcxyVwEcKdIWKC4Yu1Gvz8XcGmeaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483179; c=relaxed/simple;
	bh=2pEw6VivEu28Mo3DUny6NNh9kyZmW0ocFsTrPvhuHtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckID+RUToA8ksm4KPbbjUby3PqwV8irFG/dUDSuulOfiZB2uJkJGTSzQL4xnufKpSaAZwunfagYLLAL36NPrjyn0JQcq5u04D9AdyOcku1rLdjX0jvNOw0a4EmxwVQcqCZxxiITHsgCcCf2tYwNzjQ9VJrqiAXhg4GreyPZE8vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HBwqzsO2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDvklSiT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HBwqzsO2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDvklSiT; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 193313406B;
	Tue, 30 Apr 2024 13:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kHuZ0DDHSIPFjpB94qJZpVkKgyPiQEkg0Af+hvjw3M=;
	b=HBwqzsO2tvy7femgoknMrDBC+32vIVXELC0BJG9CmIEtwFhTm8JzQmmHYrEd1rgC47av4u
	ykss4v37J5MoT3DnO8iGLvP+Qw6rnveED52FaB8RG4bcId+NPZL1NqbmwnPJi/e5xsQM0U
	UpebAyhHHChvA64p8oYKhVfnd9p4voc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kHuZ0DDHSIPFjpB94qJZpVkKgyPiQEkg0Af+hvjw3M=;
	b=IDvklSiTmCd/cD2cNhR+fqaN0Zl+MF2LrqFiZIldbf8zqhV6kCSbF9/FwH1XjsrcSGTq1N
	jdBiEM6mQKEhqCDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714483176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kHuZ0DDHSIPFjpB94qJZpVkKgyPiQEkg0Af+hvjw3M=;
	b=HBwqzsO2tvy7femgoknMrDBC+32vIVXELC0BJG9CmIEtwFhTm8JzQmmHYrEd1rgC47av4u
	ykss4v37J5MoT3DnO8iGLvP+Qw6rnveED52FaB8RG4bcId+NPZL1NqbmwnPJi/e5xsQM0U
	UpebAyhHHChvA64p8oYKhVfnd9p4voc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714483176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8kHuZ0DDHSIPFjpB94qJZpVkKgyPiQEkg0Af+hvjw3M=;
	b=IDvklSiTmCd/cD2cNhR+fqaN0Zl+MF2LrqFiZIldbf8zqhV6kCSbF9/FwH1XjsrcSGTq1N
	jdBiEM6mQKEhqCDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 073CC133A7;
	Tue, 30 Apr 2024 13:19:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id urFMAOjvMGZwMAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Tue, 30 Apr 2024 13:19:36 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v7 1/5] nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
Date: Tue, 30 Apr 2024 15:19:24 +0200
Message-ID: <20240430131928.29766-2-dwagner@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -2.80
X-Spam-Flag: NO

From: Hannes Reinecke <hare@kernel.org>

When the DH-HMAC-CHAP key is accessed via configfs we need to take the
config semaphore as a reconnect might be running at the same time.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/auth.c     |  2 ++
 drivers/nvme/target/configfs.c | 22 +++++++++++++++++-----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/auth.c b/drivers/nvme/target/auth.c
index 3ddbc3880cac..9afc28f1ffac 100644
--- a/drivers/nvme/target/auth.c
+++ b/drivers/nvme/target/auth.c
@@ -44,6 +44,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 	dhchap_secret = kstrdup(secret, GFP_KERNEL);
 	if (!dhchap_secret)
 		return -ENOMEM;
+	down_write(&nvmet_config_sem);
 	if (set_ctrl) {
 		kfree(host->dhchap_ctrl_secret);
 		host->dhchap_ctrl_secret = strim(dhchap_secret);
@@ -53,6 +54,7 @@ int nvmet_auth_set_key(struct nvmet_host *host, const char *secret,
 		host->dhchap_secret = strim(dhchap_secret);
 		host->dhchap_key_hash = key_hash;
 	}
+	up_write(&nvmet_config_sem);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 77a6e817b315..7c28b9c0ee57 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1990,11 +1990,17 @@ static struct config_group nvmet_ports_group;
 static ssize_t nvmet_host_dhchap_key_show(struct config_item *item,
 		char *page)
 {
-	u8 *dhchap_secret = to_host(item)->dhchap_secret;
+	u8 *dhchap_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_key_store(struct config_item *item,
@@ -2018,10 +2024,16 @@ static ssize_t nvmet_host_dhchap_ctrl_key_show(struct config_item *item,
 		char *page)
 {
 	u8 *dhchap_secret = to_host(item)->dhchap_ctrl_secret;
+	ssize_t ret;
 
+	down_read(&nvmet_config_sem);
+	dhchap_secret = to_host(item)->dhchap_ctrl_secret;
 	if (!dhchap_secret)
-		return sprintf(page, "\n");
-	return sprintf(page, "%s\n", dhchap_secret);
+		ret = sprintf(page, "\n");
+	else
+		ret = sprintf(page, "%s\n", dhchap_secret);
+	up_read(&nvmet_config_sem);
+	return ret;
 }
 
 static ssize_t nvmet_host_dhchap_ctrl_key_store(struct config_item *item,
-- 
2.44.0


