Return-Path: <linux-kernel+bounces-68266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CE68577F6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A067B207D9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9A21BC36;
	Fri, 16 Feb 2024 08:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qsGDjjR6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6vfR1zgl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qsGDjjR6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6vfR1zgl"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2281804F
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 08:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708073192; cv=none; b=HGzpqLIw+4T8rV8t4texIshOeuAAkyiU0PLPTAir7YKhp8P48HtmJMze6rsIaVNGcM03rTDoPC2iYRnuEpn6Cy807y7k9VYxmdE1dwIU4rgUBo0D7tDBwLn/fHVgWYUj3IQNLx4zTR48IB2lyZHF/Vx41zjY+bc0+qffgI2vKlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708073192; c=relaxed/simple;
	bh=YagyPAfDnoFU77qHOmhwEj7+kuL7vzLXYFYM63g5bUg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BJDVh2G+aUbxuPYgx+wZ8k5v3I7VDumYEL3l1MZ6q9LHscBgPh44DRt10vCcjpe20WXFQKAKKIiJrmmcc+D1O2zG8preqSx87W3SR0LlOIOIEmjpSxy/FasgzGoN1r7fdYexcLi+ZtCCQIIRQIh0pXBB3vp3KePGR33hSPEDod8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qsGDjjR6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6vfR1zgl; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qsGDjjR6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=6vfR1zgl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 986D41FB5E;
	Fri, 16 Feb 2024 08:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ln0/p56v08h7XC7KQd0rPI4W6I85T5TW2n6DbRALBw=;
	b=qsGDjjR6RWHS6wvVHRy06j9OsYh09g6Z/FVGZHA7+cYTIBBXYC8jJbgX06z+rS+gWaK2JP
	zaPZKLVhB84ra17WipVmELeKkr85O/KJXavnpsHZ+Z05R1ey+mqyvawFl3qFsrYgLDbFQE
	eHB4z4rN1+/gLIynmuQUvDkYV2UMGHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ln0/p56v08h7XC7KQd0rPI4W6I85T5TW2n6DbRALBw=;
	b=6vfR1zglVmifiPJVIi0wbOhF3PlsP/jyRfkbREnJHBJXe9Wo9glBJodyyUJ3vhauzqlzEh
	5jAxCPIqWribJaDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708073142; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ln0/p56v08h7XC7KQd0rPI4W6I85T5TW2n6DbRALBw=;
	b=qsGDjjR6RWHS6wvVHRy06j9OsYh09g6Z/FVGZHA7+cYTIBBXYC8jJbgX06z+rS+gWaK2JP
	zaPZKLVhB84ra17WipVmELeKkr85O/KJXavnpsHZ+Z05R1ey+mqyvawFl3qFsrYgLDbFQE
	eHB4z4rN1+/gLIynmuQUvDkYV2UMGHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708073142;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+ln0/p56v08h7XC7KQd0rPI4W6I85T5TW2n6DbRALBw=;
	b=6vfR1zglVmifiPJVIi0wbOhF3PlsP/jyRfkbREnJHBJXe9Wo9glBJodyyUJ3vhauzqlzEh
	5jAxCPIqWribJaDA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 8510E13343;
	Fri, 16 Feb 2024 08:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id VzkHH7Ygz2WlcwAAn2gu4w
	(envelope-from <dwagner@suse.de>); Fri, 16 Feb 2024 08:45:42 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v0 6/6] nvme-fc: wait for connect attempt to finish
Date: Fri, 16 Feb 2024 09:45:26 +0100
Message-ID: <20240216084526.14133-7-dwagner@suse.de>
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
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: ***
X-Spam-Score: 3.70
X-Spamd-Result: default: False [3.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7u6ok1g4a6hhe6aduz96x8er)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[14.81%]
X-Spam-Flag: NO

The FC transport offloads the connect attempt to a workqueue. Thus
userspace is not able to wait on the result.

Thus, allow userspace to wait on the connect result by honnering the
'connect_sync' connect option.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fc.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7f9edab57550..5f1d0165de40 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -169,6 +169,7 @@ struct nvme_fc_ctrl {
 
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
+	struct completion	connect_completion;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -803,6 +804,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: Couldn't schedule reset.\n",
 				ctrl->cnum);
+			complete(&ctrl->connect_completion);
 			nvme_fc_ctrl_put(ctrl);
 		}
 		break;
@@ -871,6 +873,7 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
 			dev_warn(ctrl->ctrl.device,
 				"NVME-FC{%d}: controller connectivity lost.\n",
 				ctrl->cnum);
+			complete(&ctrl->connect_completion);
 			nvme_fc_ctrl_put(ctrl);
 		} else
 			nvme_fc_ctrl_connectivity_loss(ctrl);
@@ -3308,6 +3311,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 }
@@ -3367,10 +3371,12 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
 	ret = nvme_fc_create_association(ctrl);
 	if (ret)
 		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
+	else {
 		dev_info(ctrl->ctrl.device,
 			"NVME-FC{%d}: controller connect complete\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
+	}
 }
 
 
@@ -3477,6 +3483,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	init_completion(&ctrl->connect_completion);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
@@ -3524,6 +3531,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	if (opts->connect_sync)
+		nvme_fc_ctrl_get(ctrl);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
@@ -3540,6 +3550,19 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	flush_delayed_work(&ctrl->connect_work);
 
+	if (opts->connect_sync) {
+		enum nvme_ctrl_state state;
+
+		wait_for_completion(&ctrl->connect_completion);
+		state = nvme_ctrl_state(&ctrl->ctrl);
+		nvme_fc_ctrl_put(ctrl);
+
+		if (state != NVME_CTRL_LIVE) {
+			/* Cleanup is handled by the connect state machine */
+			return ERR_PTR(-EIO);
+		}
+	}
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\", hostnqn: %s\n",
 		ctrl->cnum, nvmf_ctrl_subsysnqn(&ctrl->ctrl), opts->host->nqn);
@@ -3896,6 +3919,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
-- 
2.43.0


