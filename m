Return-Path: <linux-kernel+bounces-145083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8A8A4F54
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C4A1F21793
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1880E70CC2;
	Mon, 15 Apr 2024 12:42:27 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239B76FE2A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184946; cv=none; b=rpUY6gdELWW2Tp1xbxIkROdrdJG5Gspgs/LQkXqP9Lr9gqhlXhe5pz9+Qer6buu//DM8mRpnmMi8VSlp2mWbPKKEgFboxg7YnKv3NdZGLpJFpXPbpAoFo5MmBMGPeww65VAeJFqAVByIHGu4+SPzpJqltkuNeuTaP/xLkueqQYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184946; c=relaxed/simple;
	bh=2pEw6VivEu28Mo3DUny6NNh9kyZmW0ocFsTrPvhuHtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FZKdjw68k8ePvuST/c7BANdGs0ROD5FjlyRLs7lO6oAYkcpNwJ+YwQD1Z0FEKmgsEMfp3LIS2qgcn/F4QdHY38T7IZtUWhiOPVnG81y2Vv3uzXw6YewpXHBt7xcztjx8J3H+q53E0EV5ybgIZIa8CNQYJPns+yO4cesF4p7MLLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6F75E21AF2;
	Mon, 15 Apr 2024 12:42:23 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5D36B1386E;
	Mon, 15 Apr 2024 12:42:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2KxQFa8gHWYtAwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:23 +0000
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
Subject: [PATCH v6 1/5] nvmet: lock config semaphore when accessing DH-HMAC-CHAP key
Date: Mon, 15 Apr 2024 14:42:16 +0200
Message-ID: <20240415124220.5433-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240415124220.5433-1-dwagner@suse.de>
References: <20240415124220.5433-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 6F75E21AF2

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


