Return-Path: <linux-kernel+bounces-74785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D1E85D9F5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74C101F23269
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DB237CF27;
	Wed, 21 Feb 2024 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W8WiOI7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8hIIRDyk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W8WiOI7W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8hIIRDyk"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB177B3F2
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521859; cv=none; b=qfOuZEj/KazbtOklG+IBR6vxnf0tSc75tLfGqreDurXzdjvKzgFKnAJUpGxvnAYFaWT8661bF4VW9IRQCkl2zpnBKoILppqOTFuv/rn+kAWBy3EMYnmQtWXKOHPstyRV83m/udjP/aADV6Tp3k7HjC/5CEKyuN2neu3A0Xhx9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521859; c=relaxed/simple;
	bh=IWoz41dwgZYx4gX+waj5+/RAvJibzAUNmHCQ/qaMQiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCN6jjBH5fgP5sbPYpU5dDJRidSmdYKth+N2gMnjSSSF0Mf+jTyBMeGInkZw4BKqnvnffNYQfm7Z/JySOaJHESyY7CXMDkbyzoQDO9UsqUXQrZMXDnqwTYNFtOne76dk7tM6XcWT0DoD5he0W/IjCfOC9Cmxy4BpoVC33vVCXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W8WiOI7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8hIIRDyk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W8WiOI7W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8hIIRDyk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B32601FB64;
	Wed, 21 Feb 2024 13:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2YZihmyeQWmTmVd8ag5SGtgD78nBWToo7HK+nc/Wtk=;
	b=W8WiOI7WAvoVgR4rmwzpFEmp515BbaPgQQUIBzTps4bbE4sv7N3Rmlpk7INcJ/q6hUmt9H
	cNIHihqRdmsTpgc9RrMtUulrZEnmThIE4NfyAQXBP6HemhFx+3fIUzxa2lgptF2HiJkzgO
	HuarIaN5tIAv0mXj+vbhxb5L8qhBA7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2YZihmyeQWmTmVd8ag5SGtgD78nBWToo7HK+nc/Wtk=;
	b=8hIIRDykijJV2kXhxsIBcOdZ7rEUYk9m3DI2tm/L6kK2WcJPq1iH404Y7GL+G57Ux9q7n1
	mqcI5yf4IDQiCUBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708521855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2YZihmyeQWmTmVd8ag5SGtgD78nBWToo7HK+nc/Wtk=;
	b=W8WiOI7WAvoVgR4rmwzpFEmp515BbaPgQQUIBzTps4bbE4sv7N3Rmlpk7INcJ/q6hUmt9H
	cNIHihqRdmsTpgc9RrMtUulrZEnmThIE4NfyAQXBP6HemhFx+3fIUzxa2lgptF2HiJkzgO
	HuarIaN5tIAv0mXj+vbhxb5L8qhBA7k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708521855;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G2YZihmyeQWmTmVd8ag5SGtgD78nBWToo7HK+nc/Wtk=;
	b=8hIIRDykijJV2kXhxsIBcOdZ7rEUYk9m3DI2tm/L6kK2WcJPq1iH404Y7GL+G57Ux9q7n1
	mqcI5yf4IDQiCUBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EDE913A25;
	Wed, 21 Feb 2024 13:24:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ct9BJX/51WUfPQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 21 Feb 2024 13:24:15 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v2 5/5] nvme-fc: wait for initial connect attempt to finish
Date: Wed, 21 Feb 2024 14:24:04 +0100
Message-ID: <20240221132404.6311-6-dwagner@suse.de>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240221132404.6311-1-dwagner@suse.de>
References: <20240221132404.6311-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: 0.70
X-Spamd-Result: default: False [0.70 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

The TCP and RDMA transport are doing a synchronous connects, that is the
syscal returns with the final result. The operation either fails or
succeeds. The FC transport offloads the connect attempt to a workqueue
and thus it's an asynchronous operation.

This async connect feature was introduced to mitigate problems with
transient connect errors and the task to coordinate retries with
userspace (nvme-cli).

Unfortunately, this makes the transports behave differently on the
initial attempt. Streamline nvme-fc to wait for the initial connection
attempt to succeed or fail.

In order to support also the async connection attempt introduce a new
flag for userspace. The default is a synchronous initial connect
attempt.

Link: https://lore.kernel.org/linux-nvme/0605ac36-16d5-2026-d3c6-62d346db6dfb@gmail.com/
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/fabrics.c | 17 ++++++++++++++++-
 drivers/nvme/host/fabrics.h |  3 +++
 drivers/nvme/host/fc.c      | 26 +++++++++++++++++++++++++-
 3 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 888285fe2289..52c95259debd 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -678,6 +678,7 @@ static const match_table_t opt_tokens = {
 #ifdef CONFIG_NVME_TCP_TLS
 	{ NVMF_OPT_TLS,			"tls"			},
 #endif
+	{ NVMF_OPT_CONNECT_ASYNC,	"connect_async=%d"	},
 	{ NVMF_OPT_ERR,			NULL			}
 };
 
@@ -706,6 +707,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	opts->tls = false;
 	opts->tls_key = NULL;
 	opts->keyring = NULL;
+	opts->connect_async = false;
 
 	options = o = kstrdup(buf, GFP_KERNEL);
 	if (!options)
@@ -1024,6 +1026,19 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 			}
 			opts->tls = true;
 			break;
+		case NVMF_OPT_CONNECT_ASYNC:
+			if (match_int(args, &token)) {
+				ret = -EINVAL;
+				goto out;
+			}
+			if (token < 0 || token > 1) {
+				pr_err("Invalid connect_async %d value\n",
+				       token);
+				ret = -EINVAL;
+				goto out;
+			}
+			opts->connect_async = token;
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s' in ctrl creation request\n",
 				p);
@@ -1259,7 +1274,7 @@ EXPORT_SYMBOL_GPL(nvmf_ctrl_options_put);
 				 NVMF_OPT_HOST_ID | NVMF_OPT_DUP_CONNECT |\
 				 NVMF_OPT_DISABLE_SQFLOW | NVMF_OPT_DISCOVERY |\
 				 NVMF_OPT_FAIL_FAST_TMO | NVMF_OPT_DHCHAP_SECRET |\
-				 NVMF_OPT_DHCHAP_CTRL_SECRET)
+				 NVMF_OPT_DHCHAP_CTRL_SECRET | NVMF_OPT_CONNECT_ASYNC)
 
 static struct nvme_ctrl *
 nvmf_create_ctrl(struct device *dev, const char *buf)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index 8436533aed16..75bc61401e1b 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -73,6 +73,7 @@ enum {
 	NVMF_OPT_TLS		= 1 << 25,
 	NVMF_OPT_KEYRING	= 1 << 26,
 	NVMF_OPT_TLS_KEY	= 1 << 27,
+	NVMF_OPT_CONNECT_ASYNC	= 1 << 28,
 };
 
 /**
@@ -116,6 +117,7 @@ enum {
  * @nr_poll_queues: number of queues for polling I/O
  * @tos: type of service
  * @fast_io_fail_tmo: Fast I/O fail timeout in seconds
+ * @connect_async: Don't wait for the intial connect attempt to succeed or fail
  */
 struct nvmf_ctrl_options {
 	struct kref		ref;
@@ -146,6 +148,7 @@ struct nvmf_ctrl_options {
 	unsigned int		nr_poll_queues;
 	int			tos;
 	int			fast_io_fail_tmo;
+	bool			connect_async;
 };
 
 int nvmf_ctrl_options_get(struct nvmf_ctrl_options *opts);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7627d10a5812..ebc4ff6b3343 100644
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
@@ -3326,6 +3329,7 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 				ctrl->cnum, min_t(int, portptr->dev_loss_tmo,
 					(ctrl->ctrl.opts->max_reconnects *
 					 ctrl->ctrl.opts->reconnect_delay)));
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 }
@@ -3385,10 +3389,12 @@ nvme_fc_connect_ctrl_work(struct work_struct *work)
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
 
 
@@ -3494,6 +3500,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	init_completion(&ctrl->connect_completion);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
@@ -3541,6 +3548,9 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	list_add_tail(&ctrl->ctrl_list, &rport->ctrl_list);
 	spin_unlock_irqrestore(&rport->lock, flags);
 
+	if (!opts->connect_async)
+		nvme_fc_ctrl_get(ctrl);
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING) ||
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_err(ctrl->ctrl.device,
@@ -3557,6 +3567,19 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	flush_delayed_work(&ctrl->connect_work);
 
+	if (!opts->connect_async) {
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
@@ -3913,6 +3936,7 @@ nvme_fc_delete_controllers(struct nvme_fc_rport *rport)
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport unloading: deleting ctrl\n",
 			ctrl->cnum);
+		complete(&ctrl->connect_completion);
 		nvme_fc_ctrl_put(ctrl);
 	}
 	spin_unlock(&rport->lock);
-- 
2.43.1


