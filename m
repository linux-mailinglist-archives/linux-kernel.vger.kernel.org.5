Return-Path: <linux-kernel+bounces-3942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FEDD817565
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:36:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE173B2237B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A9F34238B;
	Mon, 18 Dec 2023 15:35:52 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20A13D563
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 35F5E1F37E;
	Mon, 18 Dec 2023 15:35:49 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 2455E13BC8;
	Mon, 18 Dec 2023 15:35:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id unYoCNVmgGUTfQAAn2gu4w
	(envelope-from <dwagner@suse.de>); Mon, 18 Dec 2023 15:35:49 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	James Smart <james.smart@broadcom.com>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 01/16] nvmet: report ioccsz and iorcsz for disc ctrl
Date: Mon, 18 Dec 2023 16:30:49 +0100
Message-ID: <20231218153105.12717-2-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218153105.12717-1-dwagner@suse.de>
References: <20231218153105.12717-1-dwagner@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 35F5E1F37E

The host started to verify the ioccsz and iorcsz values. I/O controllers
return valid values but not the discovery controllers. Use the same
values as for I/O controllers.

Fixes: 2fcd3ab39826 ("nvme-fabrics: check ioccsz and iorcsz")
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/target/discovery.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..e3c4d247dd23 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -249,6 +249,7 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
+	u32 cmd_capsule_size;
 	u16 status = 0;
 
 	if (!nvmet_check_transfer_len(req, NVME_IDENTIFY_DATA_SIZE))
@@ -294,6 +295,18 @@ static void nvmet_execute_disc_identify(struct nvmet_req *req)
 
 	strscpy(id->subnqn, ctrl->subsys->subsysnqn, sizeof(id->subnqn));
 
+	/*
+	 * Max command capsule size is sqe + in-capsule data size.
+	 * Disable in-capsule data for Metadata capable controllers.
+	 */
+	cmd_capsule_size = sizeof(struct nvme_command);
+	if (!ctrl->pi_support)
+		cmd_capsule_size += req->port->inline_data_size;
+	id->ioccsz = cpu_to_le32(cmd_capsule_size / 16);
+
+	/* Max response capsule size is cqe */
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-- 
2.43.0


