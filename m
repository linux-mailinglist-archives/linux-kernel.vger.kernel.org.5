Return-Path: <linux-kernel+bounces-57169-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5CA84D4B2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FDC28400B
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE5F15B4B5;
	Wed,  7 Feb 2024 21:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrFlKDzn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4B515B4A6;
	Wed,  7 Feb 2024 21:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341150; cv=none; b=uOgfR7a7xuqyILhxav1KK44lGBDhj3pLUWVNey0AcTAfpLOHS7/5Z22kH1zLidvZk5ukV4gP2nGacOMdx8Gzvhs/OpIFFV0+/L53F+FqKAV0Ecs9gkRYY2D18RQNk6ZiMJJQU2KL6Ev10krxV171m0UY+dHj2ZRDxj3lzYwBKEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341150; c=relaxed/simple;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=damoqDtSUxBfeOEaOgnRuH2H/Jxeho9uGR4Pti052n4WTH2U4GaupLVazerIFsz3y4laXtXET0pkMND56QntGGfiXmXmE96DJWc7aZtGTXo6pr4sSjw9FPdZGrpRa3Lc8UmVeojXev3r3aE8VO7/HIsSRYh5/Y1IcA9IBr74jSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrFlKDzn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 381E5C433A6;
	Wed,  7 Feb 2024 21:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341149;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrFlKDznJBcBO5p+vOlYqGSeJe+7m+5AfP1lg/y4CT+lL7l1Rn5E+ji3BrQf5yeUF
	 JoN11+s2538Onuh91+ceT8FXoKn4fNXrIl20Uap4SdsTnx4vKcV0Un9QGM99MdhgFJ
	 wN0sbrfmoCBELYPblUFXdYBBNtNqWa1+CJa1uZo+M6KBAPufhvnNWFjyn7d8MLdQHR
	 fZ/uUKjX2e+PNTlkuBdKdWFBwsl/SopiFZM2L5zp0TzhJAm2O/43Sj5qGoeIKJS8nK
	 DlOqxah76MNsPj6jxW3Jr3Ecb1cnL+ieys/yfOQE4A8jW54f3KMLVG2HWEt0sGUSb1
	 aJL0+Z2yXPaJg==
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
Subject: [PATCH AUTOSEL 6.1 21/29] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:24:46 -0500
Message-ID: <20240207212505.3169-21-sashal@kernel.org>
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
index 1ab6601fdd5c..0075d9636b06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -359,7 +359,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -372,6 +372,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


