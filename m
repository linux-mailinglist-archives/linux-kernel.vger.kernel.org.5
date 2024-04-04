Return-Path: <linux-kernel+bounces-131746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90CF7898B64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08AE61F2A1CF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1917412AAD1;
	Thu,  4 Apr 2024 15:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="instcgC+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KfOq7kDH"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B33129A78
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245511; cv=none; b=rr1qF3tP5+urvGiH7uc8LzQS6eHkwkY+ECt6FdyBCUGNL5VjzdlSiF8RFcxeExeKd194BVPQupT+mNkTyGnig47LtY4OMKrKDVh+2Hd0QDMdQGhcvgr6i0VWUPZwkQDxuMXuUweWUxwA0R/zFiS6wq/5LIGeu39ZV5Rirv+kCqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245511; c=relaxed/simple;
	bh=tNlPyQF88QSNX+Tj/k0AVXYxdNBsZxnjN5oUI/u8sZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JTmi+TSK6ymi93VP2W2sbkzH3ZF3YmUbtr9BZwEb+qeeMkS5eRGP+NFLXtaJXzr354EyjuxAM02O6y6+tSxZ4E13IWdcmT8xxpTp3GpnmZ6lKGhBTlpoxMGqporz6l8SM5pzYUOLBwFeDfoX0VR8ulEaYEuVAZ2kg0QG1KbphEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=instcgC+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KfOq7kDH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F10A37B9A;
	Thu,  4 Apr 2024 15:45:07 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1712245507; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy41hneCF9B6A6GK/jkAhPh1ji1tqfMgrz6ELZgBYN8=;
	b=instcgC+jCtgKwbASYiv/zOsI5HlOhoSSwtX0h2AQdvRHGayQxIWYaig6/ypK+ZzeM1l5x
	evOg2085rGHDFrFoa3/9Jq9tv7g/ZZuLg8lEATu3ybLF/kPs8kaDzKW5rgJeBznXjZpRHq
	xK41eA3U/7C0PnNa/DRJRlElr0Ngefs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1712245507;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yy41hneCF9B6A6GK/jkAhPh1ji1tqfMgrz6ELZgBYN8=;
	b=KfOq7kDHKYBAK5B0b4HOysQ6hL7njrNVHXvlnye/2sxFyoyuLdA7w4BnR99nAERNi2XsuX
	e4ltWU6LbSaPyoDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C3F413A91;
	Thu,  4 Apr 2024 15:45:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id pqlHDQPLDmYEIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:07 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 1/5] nvme: authentication error are always non-retryable
Date: Thu,  4 Apr 2024 17:44:56 +0200
Message-ID: <20240404154500.2101-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240404154500.2101-1-dwagner@suse.de>
References: <20240404154500.2101-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 4F10A37B9A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

From: Hannes Reinecke <hare@suse.de>

Any authentication errors which are generated internally are always
non-retryable, so set the DNR bit to ensure they are not retried.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 29 +++++++++++++++++------------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 504dc352c458..66387bcca8ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -383,14 +383,14 @@ static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 	if (likely(nvme_req(req)->status == 0))
 		return COMPLETE;
 
-	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
-		return AUTHENTICATE;
-
 	if (blk_noretry_request(req) ||
 	    (nvme_req(req)->status & NVME_SC_DNR) ||
 	    nvme_req(req)->retries >= nvme_max_retries)
 		return COMPLETE;
 
+	if ((nvme_req(req)->status & 0x7ff) == NVME_SC_AUTH_REQUIRED)
+		return AUTHENTICATE;
+
 	if (req->cmd_flags & REQ_NVME_MPATH) {
 		if (nvme_is_path_error(nvme_req(req)->status) ||
 		    blk_queue_dying(req->q))
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 1f0ea1f32d22..309a69c24995 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,14 +475,16 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		ret = nvme_auth_wait(ctrl, 0);
-		if (ret)
+		if (ret) {
 			dev_warn(ctrl->device,
-				 "qid 0: authentication failed\n");
-		else
+				 "qid 0: authentication failed, error %d\n",
+				 ret);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+		} else
 			dev_info(ctrl->device,
 				 "qid 0: authenticated\n");
 	}
@@ -542,7 +544,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -550,12 +552,15 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
+			goto out_free_data;
+		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed, error %d\n",
+				 qid, ret);
+			ret = NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 		}
 	}
 out_free_data:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..882967365108 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1122,7 +1122,7 @@ static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 }
 static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
-	return NVME_SC_AUTH_REQUIRED;
+	return NVME_SC_AUTH_REQUIRED | NVME_SC_DNR;
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 #endif
-- 
2.44.0


