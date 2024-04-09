Return-Path: <linux-kernel+bounces-136572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EAE89D5A5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:35:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1767F1C22C67
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31ADC80025;
	Tue,  9 Apr 2024 09:35:19 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E4D7FBB8
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712655318; cv=none; b=HSt532ntaRs/z6kwrWYHfNsVuAJol0WzURcQfaJFamk1uip1mV1nJrAfperHlbt1gYNP+wi2ndbZkxfIS52Gwzb/hdp8OCYoejikBizp/fcs9S4SAgXOgmqSTXOwLhnMIgZhjAQBS3sCPsDXVCQXyuCf+Heb2oSrnjklKH65UB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712655318; c=relaxed/simple;
	bh=QzlnCxseX/o5D9srb9m9ye5Uko/lm9f1kh7giNxmBrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9cdlDR/oPVUTO3ntwyKdssr2xJyMpy7eXKkgBHaOwwI5et6CrHr74QX8O5xOYB21gQBFpWBMjOvEm1UEUC0wZo1Z3IzV2lmjiBGblRme+m5Mf+338/gIKxmtZaVlasz+Ip5n6Pspzly3yhVWjVyf6BIwTp5R1hT1y0ZjjA9i24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 79CE9338F1;
	Tue,  9 Apr 2024 09:35:15 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6616A1332F;
	Tue,  9 Apr 2024 09:35:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id psU+F9MLFWanRwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Tue, 09 Apr 2024 09:35:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v5 1/6] nvme: authentication error are always non-retryable
Date: Tue,  9 Apr 2024 11:35:05 +0200
Message-ID: <20240409093510.12321-2-dwagner@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409093510.12321-1-dwagner@suse.de>
References: <20240409093510.12321-1-dwagner@suse.de>
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
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 79CE9338F1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action

From: Hannes Reinecke <hare@suse.de>

Any authentication errors which are generated internally are always
non-retryable, so use negative error codes to ensure they are not
retried.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 25 +++++++++++++------------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 17 insertions(+), 16 deletions(-)

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
index 1f0ea1f32d22..0166f8a3a3eb 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -467,7 +467,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,14 +475,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid 0: authentication setup failed\n");
-			ret = NVME_SC_AUTH_REQUIRED;
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
+		} else
 			dev_info(ctrl->device,
 				 "qid 0: authenticated\n");
 	}
@@ -542,7 +542,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -550,12 +550,13 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (ret) {
 			dev_warn(ctrl->device,
 				 "qid %d: authentication setup failed\n", qid);
-			ret = NVME_SC_AUTH_REQUIRED;
-		} else {
-			ret = nvme_auth_wait(ctrl, qid);
-			if (ret)
-				dev_warn(ctrl->device,
-					 "qid %u: authentication failed\n", qid);
+			goto out_free_data;
+		}
+		ret = nvme_auth_wait(ctrl, qid);
+		if (ret) {
+			dev_warn(ctrl->device,
+				 "qid %u: authentication failed, error %d\n",
+				 qid, ret);
 		}
 	}
 out_free_data:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d0ed64dc7380..9b8904a476b8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1122,7 +1122,7 @@ static inline int nvme_auth_negotiate(struct nvme_ctrl *ctrl, int qid)
 }
 static inline int nvme_auth_wait(struct nvme_ctrl *ctrl, int qid)
 {
-	return NVME_SC_AUTH_REQUIRED;
+	return -EPROTONOSUPPORT;
 }
 static inline void nvme_auth_free(struct nvme_ctrl *ctrl) {};
 #endif
-- 
2.44.0


