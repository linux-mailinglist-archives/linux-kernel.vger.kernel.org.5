Return-Path: <linux-kernel+bounces-57101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C0784D409
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A7C41F22FC9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F01912BF35;
	Wed,  7 Feb 2024 21:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmorfrL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D90E13B78D;
	Wed,  7 Feb 2024 21:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340988; cv=none; b=Wt7c2hkVN+J0aHFdnX98Zyc5tin8pcIXFI3a5X/y3xh+JhA/G1KvrOCfCLFo/pufxYKyyyW54c44niA5bD4TZtCTau1zwLi5FZdjHX7cCTsS69+IneuVaA7HygLVwMcfKZLg3uDoih7OJ1kDxq/HowipC4yEhxJvhHlHygxJJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340988; c=relaxed/simple;
	bh=B51nWLS6ql3SkLV39cOPG21h/rGbV0rMuK6QnA/bR3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KvaRPv844J520b+gK4GtCVZJiMcnUHv10txsePhaaHullWkghPaSowNjrZ5fcbg1a9sqXAJJTeIAn5e1Q5XZ1QCyvZ2cFcQ0wNk1UJTlxan2GR7NGCLXVrcSAWTXqERRFQ8ODL6wX4mOuQD1pVBdLQrtecAYRnKpEEE9cCUBN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmorfrL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A60C6C43394;
	Wed,  7 Feb 2024 21:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340988;
	bh=B51nWLS6ql3SkLV39cOPG21h/rGbV0rMuK6QnA/bR3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmorfrL/XSrfoil/1vNq1Q8/4olDgiHztjRCWpQ6XsYSSWFhL1GvnaXNFWyZxP9I4
	 aAIxRsz6kdK3mXIGckWesiUrSDJhSukMjJucXTHxCAkRwUpQw2Kg40kIoEjVr1gCbB
	 HkxV0PlZ3Hb5IDqL9K4j7EhRMWYOlIqW0xD3LhHLHy5o2T4iiLsWVU/SONGPQJxuc5
	 kyql4hkw9/LV8vM+ynKp5nL2Pbg/7ChjLogW6SVpzyRL5psGowusW73zRhNesg8rSV
	 tlnhUKzQucBIK6X4JHe0ikn2pXao2mN+E14aczCaGH857n5D/gwNtWDCuAOBvU4SYU
	 yTrmAS8Yxrnew==
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
Subject: [PATCH AUTOSEL 6.7 35/44] nvmet-fc: free queue and assoc directly
Date: Wed,  7 Feb 2024 16:21:02 -0500
Message-ID: <20240207212142.1399-35-sashal@kernel.org>
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

[ Upstream commit c5e27b1a779ec25779d04c3af65aebaee6bd4304 ]

Neither struct nvmet_fc_tgt_queue nor struct nvmet_fc_tgt_assoc are data
structure which are used in a RCU context. So there is no reason to
delay the free operation.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index bb0791c9c0e3..5fd37e989106 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -145,7 +145,6 @@ struct nvmet_fc_tgt_queue {
 	struct list_head		avail_defer_list;
 	struct workqueue_struct		*work_q;
 	struct kref			ref;
-	struct rcu_head			rcu;
 	/* array of fcp_iods */
 	struct nvmet_fc_fcp_iod		fod[] __counted_by(sqsize);
 } __aligned(sizeof(unsigned long long));
@@ -169,7 +168,6 @@ struct nvmet_fc_tgt_assoc {
 	struct nvmet_fc_tgt_queue 	*queues[NVMET_NR_QUEUES + 1];
 	struct kref			ref;
 	struct work_struct		del_work;
-	struct rcu_head			rcu;
 };
 
 
@@ -852,7 +850,7 @@ nvmet_fc_tgt_queue_free(struct kref *ref)
 
 	destroy_workqueue(queue->work_q);
 
-	kfree_rcu(queue, rcu);
+	kfree(queue);
 }
 
 static void
@@ -1185,8 +1183,8 @@ nvmet_fc_target_assoc_free(struct kref *ref)
 	dev_info(tgtport->dev,
 		"{%d:%d} Association freed\n",
 		tgtport->fc_target_port.port_num, assoc->a_id);
-	kfree_rcu(assoc, rcu);
 	nvmet_fc_tgtport_put(tgtport);
+	kfree(assoc);
 }
 
 static void
-- 
2.43.0


