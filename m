Return-Path: <linux-kernel+bounces-57174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E27A84D4BD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:52:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B15391C2282C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16F615DEEB;
	Wed,  7 Feb 2024 21:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3leUQdq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D531015CD62;
	Wed,  7 Feb 2024 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341156; cv=none; b=rZjGA2VlTzb02a2mkateiNIucjBdpBo0obi1Ebi5XbO5B2SNidpvTUfAhlDEKv10+RpOBte+u3GCyMkf8zs8SNzsfMH9pN2bjOvKZYwEKTrhXaf2p3upWxDgEOBVsfo8IrsTk3s4Js6AnDysOKQqpTRZJtdadnKqAimL+5+9t9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341156; c=relaxed/simple;
	bh=EVJw3/SXfuBf5v9qJgE4yM7WLbNBIMe7pkiV9lhnVaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SINVq84nbudo8sdZLqrUNDQeqbpK9YpgvGLw19chN5Fo5xNIWocmjHmelsqKtUMawJT75KSHUpKghSFrUc81g7pvYU4hqLMfbh4DaUlHybOhWCFvKDhsKeVPwSN/CBD+Kl1PQiLPpiH0H+u6Q4YFSWHYowmRXHoTov2TQelqtdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3leUQdq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DFC43399;
	Wed,  7 Feb 2024 21:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341156;
	bh=EVJw3/SXfuBf5v9qJgE4yM7WLbNBIMe7pkiV9lhnVaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K3leUQdqB0Eu0jDo8v6f86rKd8z4N4CDGhwmhkmcSiauifKUZTAP0/jQBm/xEi3w2
	 lDri0bv/GbmQU7WxI0MIaylOGEGh8xpfSt8rZwSFP9ISZzHSLNuDuQ3Q1DefvD2SbT
	 Yk8Q6IC3u8NKveFKJSHo+k6eCG6WZLv+ZYKhYEr29SAo41VFxNvBjJCkCEwTfiyLLJ
	 sLtjbR22lg2XYrNYueKXw/sSezaQCkUz6Ygl1sUXC8F9FhVARQvPrJE64usjj4Cm1j
	 7Qvm4qAIK5qIY62ASOyjIRbafJkNtKaS6sVH/4fDv3dQEipS54w1X0LIfuIOLNodmY
	 ma5AJBMU+3uWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 25/29] nvmet-fc: avoid deadlock on delete association path
Date: Wed,  7 Feb 2024 16:24:50 -0500
Message-ID: <20240207212505.3169-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit 710c69dbaccdac312e32931abcb8499c1525d397 ]

When deleting an association the shutdown path is deadlocking because we
try to flush the nvmet_wq nested. Avoid this by deadlock by deferring
the put work into its own work item.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index b4b2631eb530..36cae038eb04 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -111,6 +111,8 @@ struct nvmet_fc_tgtport {
 	struct nvmet_fc_port_entry	*pe;
 	struct kref			ref;
 	u32				max_sg_cnt;
+
+	struct work_struct		put_work;
 };
 
 struct nvmet_fc_port_entry {
@@ -248,6 +250,13 @@ static int nvmet_fc_tgt_a_get(struct nvmet_fc_tgt_assoc *assoc);
 static void nvmet_fc_tgt_q_put(struct nvmet_fc_tgt_queue *queue);
 static int nvmet_fc_tgt_q_get(struct nvmet_fc_tgt_queue *queue);
 static void nvmet_fc_tgtport_put(struct nvmet_fc_tgtport *tgtport);
+static void nvmet_fc_put_tgtport_work(struct work_struct *work)
+{
+	struct nvmet_fc_tgtport *tgtport =
+		container_of(work, struct nvmet_fc_tgtport, put_work);
+
+	nvmet_fc_tgtport_put(tgtport);
+}
 static int nvmet_fc_tgtport_get(struct nvmet_fc_tgtport *tgtport);
 static void nvmet_fc_handle_fcp_rqst(struct nvmet_fc_tgtport *tgtport,
 					struct nvmet_fc_fcp_iod *fod);
@@ -359,7 +368,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		goto out_puttgtport;
+		goto out_putwork;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,8 +381,8 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
-out_puttgtport:
-	nvmet_fc_tgtport_put(tgtport);
+out_putwork:
+	queue_work(nvmet_wq, &tgtport->put_work);
 }
 
 static int
@@ -1404,6 +1413,7 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 	kref_init(&newrec->ref);
 	ida_init(&newrec->assoc_cnt);
 	newrec->max_sg_cnt = template->max_sgl_segments;
+	INIT_WORK(&newrec->put_work, nvmet_fc_put_tgtport_work);
 
 	ret = nvmet_fc_alloc_ls_iodlist(newrec);
 	if (ret) {
-- 
2.43.0


