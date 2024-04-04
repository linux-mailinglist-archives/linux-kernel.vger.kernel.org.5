Return-Path: <linux-kernel+bounces-131750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2367B898B66
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD6C029008E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A7F12BEBF;
	Thu,  4 Apr 2024 15:45:13 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD3A129E7C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245512; cv=none; b=m5wJIOl3fEDtQ8p4oYY+LvQW+TlRgmDTEvHNVfoRwIALLltGCQywDPaRK2dwEvOzcieqnFMY2FQbtOVQ0q8DFHniE2dBS4SfadSEXNxJGNSNVzrRd5k3uTMhjgNSGRL4dNZ1PT+tj9kcxABIOVk8m7ePzKKaRvfUYjPJ+ghTTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245512; c=relaxed/simple;
	bh=lM7wFrltAB0q00VSvTFLfrMBVNppZ+T0rgs5C2HFTaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AFy4y7fxjT95w9fojJjy8J4MPfXc9fFHBSsT4D/OdUUiXquV0KqP+7ync0j6RNSciwyGvpyrUIC5re+1nKrgaHZV5yKUbEjnOfHSQIVMFSeMjtE3YZm8MSRaVAkx2eAD/yz2Qc/ktAr0RDxmcKaNJ9pQ9TF0ZPRS6GSduPYVpb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2F2FD37CFF;
	Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1DE1D139E8;
	Thu,  4 Apr 2024 15:45:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id HZrYBQXLDmYOIgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 04 Apr 2024 15:45:09 +0000
From: Daniel Wagner <dwagner@suse.de>
To: James Smart <james.smart@broadcom.com>
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 4/5] nvme-tcp: short-circuit reconnect retries
Date: Thu,  4 Apr 2024 17:44:59 +0200
Message-ID: <20240404154500.2101-5-dwagner@suse.de>
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
X-Rspamd-Queue-Id: 2F2FD37CFF

From: Hannes Reinecke <hare@suse.de>

Returning an nvme status from nvme_tcp_setup_ctrl() indicates that the
association was established and we have received a status from the
controller; consequently we should honour the DNR bit. If not any future
reconnect attempts will just return the same error, so we can
short-circuit the reconnect attempts and fail the connection directly.

Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/nvme.h | 17 +++++++++++++++++
 drivers/nvme/host/tcp.c  | 23 +++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 882967365108..654d8d1a4d29 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -701,6 +701,23 @@ static inline bool nvme_is_path_error(u16 status)
 	return (status & 0x700) == 0x300;
 }
 
+/*
+ * Evaluate the status information returned by the LLDD in order to
+ * decided if a reconnect attempt should be scheduled.
+ *
+ * There are two cases where no reconnect attempt should be attempted:
+ *
+ * 1) The LLDD reports an negative status. There was an error (e.g. no
+ *    memory) on the host side and thus abort the operation.
+ * 2) The DNR bit is set and the specification states no further
+ *    connect attempts with the same set of paramenters should be
+ *    attempted.
+ */
+static inline bool nvme_ctrl_reconnect(int status)
+{
+	return status > 0 && (status & NVME_SC_DNR) ? false : true;
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index fdbcdcedcee9..7e25a96e9870 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2155,9 +2155,11 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	nvme_tcp_destroy_io_queues(ctrl, remove);
 }
 
-static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
+static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl,
+		int status)
 {
 	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
+	bool recon = nvme_ctrl_reconnect(status);
 
 	/* If we are resetting/deleting then do nothing */
 	if (state != NVME_CTRL_CONNECTING) {
@@ -2165,13 +2167,14 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 		return;
 	}
 
-	if (nvmf_should_reconnect(ctrl)) {
+	if (recon && nvmf_should_reconnect(ctrl)) {
 		dev_info(ctrl->device, "Reconnecting in %d seconds...\n",
 			ctrl->opts->reconnect_delay);
 		queue_delayed_work(nvme_wq, &to_tcp_ctrl(ctrl)->connect_work,
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
-		dev_info(ctrl->device, "Removing controller...\n");
+		dev_info(ctrl->device, "Removing controller (%d)...\n",
+			 status);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2252,10 +2255,12 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 			struct nvme_tcp_ctrl, connect_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
 
 	++ctrl->nr_reconnects;
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto requeue;
 
 	dev_info(ctrl->device, "Successfully reconnected (%d attempt)\n",
@@ -2268,7 +2273,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 requeue:
 	dev_info(ctrl->device, "Failed reconnect attempt %d\n",
 			ctrl->nr_reconnects);
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
@@ -2295,7 +2300,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 		return;
 	}
 
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, -ENOTCONN);
 }
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
@@ -2315,6 +2320,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, reset_work);
+	int ret;
 
 	nvme_stop_ctrl(ctrl);
 	nvme_tcp_teardown_ctrl(ctrl, false);
@@ -2328,14 +2334,15 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	if (nvme_tcp_setup_ctrl(ctrl, false))
+	ret = nvme_tcp_setup_ctrl(ctrl, false);
+	if (ret)
 		goto out_fail;
 
 	return;
 
 out_fail:
 	++ctrl->nr_reconnects;
-	nvme_tcp_reconnect_or_remove(ctrl);
+	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
-- 
2.44.0


