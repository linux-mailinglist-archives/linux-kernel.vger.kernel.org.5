Return-Path: <linux-kernel+bounces-57195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3117D84D4FA
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23AB1F236FF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9048E670E0;
	Wed,  7 Feb 2024 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0NxyJCW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472F535D5;
	Wed,  7 Feb 2024 21:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341202; cv=none; b=TtWGraKXl/+WjoopiQdngEfeToPm9IAWUCAdj9c8iIk4BhUnXQ2NoJQ751yw3hSOWWNE7m61jNUwBmavDwd8GaL5u3W1DbkIU3lGuzVE/TVywe43oarbj0OYA3khR3/PUDWYangVxMnN2Q3AObxhGUkkBSn7nKwO5nuqjxBcwWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341202; c=relaxed/simple;
	bh=zy0ANpmuI8RzlXDoNndPcX+tAIMjD+XJSRfIIm7dqtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/or/QGnW0yfuwsU30k1eqNfmX0y4EHFVDk/V+Mkc5tFyfxom3cVPRc+BCBXRvSflc6SkSCVD77NYcdTgOc0+rRDyQXbvR2mkszip1dKTXstqu+ouYQ9V/QRh/0nCFD7khmBb0WcVQkPBX0X1Y4vzG0OkdH15gbLpllJkzdpHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0NxyJCW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54769C433F1;
	Wed,  7 Feb 2024 21:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341202;
	bh=zy0ANpmuI8RzlXDoNndPcX+tAIMjD+XJSRfIIm7dqtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0NxyJCWll3krfD6XL5RUClVYwOSRGrejIi1zM1r9e7GxQ/pDcFUw3hrESJJPVm+E
	 OAnWPzky7v4KM48YVTQ3jlipbCCEFGbv48m/0zGtyvfSN28ff22ag/6IRYhTXu4SB6
	 T2CRcluixvbSO5iXCp32vD1OXo29LzIhwyZ/mUAkKlM5RbsYJ4pVgZu2WpWVLB5L5A
	 K4Vu2Blx1aCMY8MNbZZJQB7eufFT1VkuM97E6nWWuXsXN8PJzzIDpsskmZbYTmp63w
	 gSfFmfZRNv8HJ0PuvUIDJdUvqNobQPeKpeZqPhqF4pi141Ba+IfM/1fRMg0P9MVcyq
	 p3HWFWdYLQMgA==
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
Subject: [PATCH AUTOSEL 5.15 16/23] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:25:57 -0500
Message-ID: <20240207212611.3793-16-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 00a2a591f5c1..80df50ed7e3a 100644
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


