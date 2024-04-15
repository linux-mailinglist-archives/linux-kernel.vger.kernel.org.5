Return-Path: <linux-kernel+bounces-145086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 884A28A4F59
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB3261C20B9F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F846FE0A;
	Mon, 15 Apr 2024 12:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jnAvIARw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="D0Y3NL3b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xh5nqpx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="blzOp7YU"
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836466B5E
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 12:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713184948; cv=none; b=jksLONxglML21vmBa3y5Lijh1Aeu5vJiUEgtWD1v5BSUJf0skBxN48qUmMMob0wfqzsUA7gOdmwSr96TJ0+kLw312b3bYMDNYcvIjHCXKzDrqqF1ie9LN3ryUEcORiZB6RzGrNysWpNLWfIoWkj1/u9ZnoGHPykddikvhSn7PK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713184948; c=relaxed/simple;
	bh=Ifh6ApnL+yawazi13adk1In0Wqsy1DsDNCn55Kyl8vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXRk8+jn7twjbJOrDRHppJNAlw09Tp9VZKJvhwZvtRBZEwyEtWLuJ24yt+3WAOOBBnfVRPcqcxL4cjpIayJ+ZRg5BS1kx0qs6LVYC1wtwK8FcCaw/4DZxpM2xbc1gBnrZHA2HrlVNppM+qq72pkuBUxSVhUg9kIHIaBPAcmyf0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jnAvIARw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=D0Y3NL3b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xh5nqpx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=blzOp7YU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E053221B3D;
	Mon, 15 Apr 2024 12:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiviuq0yKAjKpIGK5/9DS+JPikG3jUsUkAzFD/WjfGI=;
	b=jnAvIARw23H9T6/9vZYq9mfsuVQavh5Nh7/yD9XuomOrM8EQn1Mk8ZK7QxaKJYbiWK2R9K
	jySZNVDKu8D16VkJf6cZ2sANMwnBwap2xNAmNScZDEhKTiwUiCuAzhC0B6/CsU4SPv2R6W
	UgkJuMfHILXZfipzFb29Nb9rGrETH3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184945;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiviuq0yKAjKpIGK5/9DS+JPikG3jUsUkAzFD/WjfGI=;
	b=D0Y3NL3bzJF6MtYGnoShIEQH9djLLPF92fUV2nDeO6Mtx5FWFsLEKyEhpI53dSxB9vNLyt
	9jEr2d55IpTbyECA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713184944; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiviuq0yKAjKpIGK5/9DS+JPikG3jUsUkAzFD/WjfGI=;
	b=xh5nqpx/PBEyTsOdy9JlKIUBBinwXZR/RUOAEKIv98LNLFQS8gauby0WmxiEkvTZWHwi8v
	WHA5WYCHuiGF44q6q8xdUVwvrk+urBTUUpJPTa/5NeaKA7afABRSdNmv8yterQn6G6lTi8
	X/a+6w/Z08PRdrYFh7l9gihjSOUfJnk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713184944;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Iiviuq0yKAjKpIGK5/9DS+JPikG3jUsUkAzFD/WjfGI=;
	b=blzOp7YUQVqR2R+t5eRAgh5l21xtlCzwwt9NXLVbrQsUQAcpa6eR5VDyt4QWw4lCCjSeK9
	wYy3aarTTZIPAzDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CB7D01386E;
	Mon, 15 Apr 2024 12:42:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U05aMLAgHWYxAwAAD6G6ig
	(envelope-from <dwagner@suse.de>); Mon, 15 Apr 2024 12:42:24 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v6 3/5] nvme: authentication error are always non-retryable
Date: Mon, 15 Apr 2024 14:42:18 +0200
Message-ID: <20240415124220.5433-4-dwagner@suse.de>
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
X-Spam-Flag: NO
X-Spam-Score: -6.80
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[]

From: Hannes Reinecke <hare@suse.de>

Any authentication errors are non-retryable, so use negative error codes
to ensure they are not retried.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c    |  6 +++---
 drivers/nvme/host/fabrics.c | 31 +++++++++++++------------------
 drivers/nvme/host/nvme.h    |  2 +-
 3 files changed, 17 insertions(+), 22 deletions(-)

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
index 1f0ea1f32d22..f7eaf9580b4f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -428,12 +428,6 @@ static void nvmf_connect_cmd_prep(struct nvme_ctrl *ctrl, u16 qid,
  * fabrics-protocol connection of the NVMe Admin queue between the
  * host system device and the allocated NVMe controller on the
  * target system via a NVMe Fabrics "Connect" command.
- *
- * Return:
- *	0: success
- *	> 0: NVMe error status code
- *	< 0: Linux errno error code
- *
  */
 int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 {
@@ -467,7 +461,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -475,14 +469,14 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
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
@@ -542,7 +536,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 		if (result & NVME_CONNECT_AUTHREQ_ASCR) {
 			dev_warn(ctrl->device,
 				 "qid 0: secure concatenation is not supported\n");
-			ret = NVME_SC_AUTH_REQUIRED;
+			ret = -EOPNOTSUPP;
 			goto out_free_data;
 		}
 		/* Authentication required */
@@ -550,12 +544,13 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
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


