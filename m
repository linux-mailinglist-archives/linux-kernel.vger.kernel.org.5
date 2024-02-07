Return-Path: <linux-kernel+bounces-57139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8CD484D466
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DE5F1F20F41
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F2C152C08;
	Wed,  7 Feb 2024 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V7B5qa5s"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B64152DEE;
	Wed,  7 Feb 2024 21:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341078; cv=none; b=l7kgKXipA+UyxeULVZVZnwwDA9ZBD9tRXHBgNpUQQ03UvwnhRZ5Ra9PiQGWG2HCFRvahUx750i2HR6aJg8xlQVTVEkf1Z6g3lvhNcHOUGDhOXn+Lw4cAY/Fn6Ift8H9J21tPpFaFlWXlomX5RmmDDzIdIYE4O+c25aOVYQ040m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341078; c=relaxed/simple;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Olq1LC+UgpTfXMlzR5UGYt6j98nT9N4420lgdugdEqub83BoeoshO7aptsEzPVhRALGypNzsHWQRTJCGahMRJC0LSr2uOZ9W6f43ywIjPAlPwaMLP29b+2L0E6pOUC+8lZzuVKwbh8Eg7/Ed69yUNi71iyaM8ck3c2rUNNYYe0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V7B5qa5s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F7AC433A6;
	Wed,  7 Feb 2024 21:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341077;
	bh=+GnoAmLjJf9y4mh8pjDbiCEtXitfgMvU9ViSGPnHwsE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V7B5qa5sCj6szdr8eHcGyuT3yo+dGYVqELsiCWJbMm8kAqF9+agJoU1/HdrrP3WT0
	 vWCR9ITTQ0sHvgxS0XuRTBl8i1tHMLAby96RhsXLkEW1iSFo0QIKjwBjp/Zr6ByTCJ
	 7vTC4qgyDIb9JA/nHnq45ul79m3Gvfbk0mApKkQ9nXVlkqjUEVO/hTv1L6YgI3aKoT
	 gQ9x0lXVP6k8LVvhbLY6+Xwf3KmV/W2UFIQ/IBN4DMglP4UsH1Mgo/4POfN9Cpkepx
	 DN60yQYKzMbYuy3DaDEpQPkBlW90xCPhe8eG4yzWmspQa/9f2VTkzUH1t6J4Whhjkj
	 IetJjDxygL+QA==
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
Subject: [PATCH AUTOSEL 6.6 29/38] nvmet-fc: release reference on target port
Date: Wed,  7 Feb 2024 16:23:15 -0500
Message-ID: <20240207212337.2351-29-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
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


