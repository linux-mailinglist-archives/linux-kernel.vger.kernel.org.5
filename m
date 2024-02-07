Return-Path: <linux-kernel+bounces-57099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B95584D405
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4AF1C21D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6D013B2A8;
	Wed,  7 Feb 2024 21:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6j5fbet"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F8A13AA55;
	Wed,  7 Feb 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340984; cv=none; b=l4eg5tz0gIS/VmJy8lG3k8YcjVfD/Ahmr4IH2Sxk/ERv8uLwMsGCPVkDMC5zPTQQADC+Bqztwo3YZ0qn9dQIWe1br04DZVLkGr7PduaaJzjsoHmtGENW77LEpNoL/7zWySi9pDZra7LRZmPGIvV0TMiRS72XtZCghe4gBeYzo5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340984; c=relaxed/simple;
	bh=4xerkgodNjm+WwzFAZ5Ls578pEsR9iJgsdOpSlK56zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GAby6HleeEwSJM7FE1cgO1nU4DoGwTkgXw2IGkPnTbDYL55cBKNZihswviusjUjfDtLJ+8VBnsO9qGxUbOTLENnzzHbPMUmnSPQkofPlfIK4YPAM8HZgVkFq88XrzqCOdxYSB8gs59ed8ErRoQBMuN0OF/2tkVTNePRPwzvHOyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6j5fbet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3A3C43390;
	Wed,  7 Feb 2024 21:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340984;
	bh=4xerkgodNjm+WwzFAZ5Ls578pEsR9iJgsdOpSlK56zw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z6j5fbetExqQ48rkcQMFi4no3o/jdKELIJ1gyhFt2/y/ZvbpawkiH/+ny2wVkyW9B
	 YVgGaDdGfmz/RAQcHWs/SMWFRK111t8p8+ICXOZU7PCqHacHPEvkoz6XsjvRycd7Z/
	 fSIMCX+s4khSNcohJQjyBcCc38YCq47+JGOgRMbwkzi4ya4eJgXNZWhWGgp270zfMy
	 qJXvmo8qRrXkqe4OdUQJe1JI6UhVpszHY6nieDfL56KgogpGsM8fQ/5FY6WXTiMTEA
	 MaxxFxDUhvvqg+YLIRg/k69QkgcxOBB5vnUAiaHvFvLeo/Rt+PwwXAZFPq9uq+DkO/
	 F2c35NLxS6GEg==
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
Subject: [PATCH AUTOSEL 6.7 33/44] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:21:00 -0500
Message-ID: <20240207212142.1399-33-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index bd59990b5250..8cd1ef293769 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -360,7 +360,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 
 	if (!lsop->req_queued) {
 		spin_unlock_irqrestore(&tgtport->lock, flags);
-		return;
+		goto out_puttgtport;
 	}
 
 	list_del(&lsop->lsreq_list);
@@ -373,6 +373,7 @@ __nvmet_fc_finish_ls_req(struct nvmet_fc_ls_req_op *lsop)
 				  (lsreq->rqstlen + lsreq->rsplen),
 				  DMA_BIDIRECTIONAL);
 
+out_puttgtport:
 	nvmet_fc_tgtport_put(tgtport);
 }
 
-- 
2.43.0


