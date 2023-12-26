Return-Path: <linux-kernel+bounces-11223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6D481E361
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:28:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A32E2861D4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1890C54BE3;
	Tue, 26 Dec 2023 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWm5BxYt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C6854BD6;
	Tue, 26 Dec 2023 00:21:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B2DC433C9;
	Tue, 26 Dec 2023 00:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550098;
	bh=nYmEkAs12jIRLgDMVUMexCZznbi+4av/VlmrmLmPRr8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWm5BxYttsgGLy5HA6Vp/0rXWe6wLj7Eb0R7BKaetAw3lN2+1l9ELEFBvu4C9hW9q
	 8a08uBmMvBTAInpFnR5lCOnBEcYbb2CTCkbNDs175l959YoIVgnRB6bfzgz8Nn5itX
	 iVC0eMItGGTdy3TaqXj8Upf40nhZGw+P8zkwBxkSbS3a4xwpL+UY6LA3Ny9dnV6Uu3
	 El3qzmUd119QBHxssmopTdTUyOt8G/nCFZgI0lbL6SQpE846N1BYCg08cc0wm+S1Ie
	 ayufcaI9M+tGUXaEVVBA9eN+kTQ+XGSNA+QIe0UiS3B7AkEBEivMD+kIfTLCm4kGU9
	 q753+BjGuliDQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Daniel Wagner <dwagner@suse.de>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Michael Liang <mliang@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 30/39] Revert "nvme-fc: fix race between error recovery and creating association"
Date: Mon, 25 Dec 2023 19:19:20 -0500
Message-ID: <20231226002021.4776-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231226002021.4776-1-sashal@kernel.org>
References: <20231226002021.4776-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.8
Content-Transfer-Encoding: 8bit

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit d3e8b1858734bf46cda495be4165787b9a3981a6 ]

The commit was identified to might sleep in invalid context and is
blocking regression testing.

This reverts commit ee6fdc5055e916b1dd497f11260d4901c4c1e55e.

Link: https://lore.kernel.org/linux-nvme/hkhl56n665uvc6t5d6h3wtx7utkcorw4xlwi7d2t2bnonavhe6@xaan6pu43ap6/
Link: https://lists.infradead.org/pipermail/linux-nvme/2023-December/043756.html
Reported-by: Daniel Wagner <dwagner@suse.de>
Reported-by: Maurizio Lombardi <mlombard@redhat.com>
Cc: Michael Liang <mliang@purestorage.com>
Tested-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/fc.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a15b37750d6e9..206f1b4e5eb1c 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2548,24 +2548,17 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * the controller.  Abort any ios on the association and let the
 	 * create_association error path resolve things.
 	 */
-	enum nvme_ctrl_state state;
-	unsigned long flags;
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	state = ctrl->ctrl.state;
-	if (state == NVME_CTRL_CONNECTING) {
-		set_bit(ASSOC_FAILED, &ctrl->flags);
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		set_bit(ASSOC_FAILED, &ctrl->flags);
 		dev_warn(ctrl->ctrl.device,
 			"NVME-FC{%d}: transport error during (re)connect\n",
 			ctrl->cnum);
 		return;
 	}
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state != NVME_CTRL_LIVE)
+	if (ctrl->ctrl.state != NVME_CTRL_LIVE)
 		return;
 
 	dev_warn(ctrl->ctrl.device,
@@ -3179,16 +3172,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
 	}
-
-	spin_lock_irqsave(&ctrl->lock, flags);
 	if (!ret && test_bit(ASSOC_FAILED, &ctrl->flags))
 		ret = -EIO;
-	if (ret) {
-		spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (ret)
 		goto out_term_aen_ops;
-	}
+
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
-	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-- 
2.43.0


