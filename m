Return-Path: <linux-kernel+bounces-57214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDC484D532
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C23E71C23ECA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43B7714364C;
	Wed,  7 Feb 2024 21:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c4pwVrk9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8624813956F;
	Wed,  7 Feb 2024 21:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341243; cv=none; b=Efftytd+jzSpB0PU7N/+zEQyoqLDfw7Ato2rweLk0dAaBeqrLuMoKu3n+W+Q2inQUCqmdqn43q/8wsRxIsqyWt0xwDwNqcmsQ24UiBQ12uutqlOnWa2erCyjMAkfwt4VxTh2z+Ur5/6sonK3Nx+0R8qXFyZAbyBsMNVwMPYRoO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341243; c=relaxed/simple;
	bh=ovyIZPVt+cgL+kVUOYvyu7Mw0Bomuy3ojy+orvTz3Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXC5Tv019bQnd+fUSYuPCzkK1xsGU3CQqokIFTjbEPzZFb98WwWuTI7zUnhFMbT6Bll32hM2Dj2o1JG2WDMjsIMf04xFZQqDpDUCcV1zjpyw5Ekzo7PPi0aaBIZlXuhzqJSYd1ouyRjrZwls5q++8LfbYXOsRgEfLGoGzqL//EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c4pwVrk9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D00C433C7;
	Wed,  7 Feb 2024 21:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341243;
	bh=ovyIZPVt+cgL+kVUOYvyu7Mw0Bomuy3ojy+orvTz3Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c4pwVrk9p6IbqavnMlFNKVPAE1ateAvRSN0uqzKTv3sP3D7L8Fyhj9a7Z44DyEPz0
	 /5yIZaWu1kLVVrAWSXkD6b3zwGdn30/IoWSBxsn+94ZGfEPTJJuEB+rnZqBwT3oyhy
	 u7OHovX2yTB2D46488SlPII5UrfX8uB0guuY6av2EymX3dsnOsC8Ua/MrNMWaTt/Aa
	 sgTkzkIk+5JLRhe5g5csCdygtVpE98/UFMCOoeq5xkYw5FQSG1vcI48jSotDVfRs7a
	 7iq9Kc42f98WyIIIXTwS/TKUzq4gzwglgGWcP8s7tiilBh2JdO2Ngp2Q6Qt4J5tGvG
	 rdWY+XG8zf0Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 12/16] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:26:52 -0500
Message-ID: <20240207212700.4287-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
Content-Transfer-Encoding: 8bit

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit c691e6d7e13dab81ac8c7489c83b5dea972522a5 ]

In case we return early out of __nvmet_fc_finish_ls_req() we still have
to release the reference on the target port.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 46fc44ce8671..18a64a4fd8da 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -357,7 +357,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -370,6 +370,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


