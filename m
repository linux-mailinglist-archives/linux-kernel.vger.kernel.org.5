Return-Path: <linux-kernel+bounces-115994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D903F889904
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92F5829E92D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8CB171094;
	Mon, 25 Mar 2024 03:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTo+ApB1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0D1238F33;
	Sun, 24 Mar 2024 23:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322330; cv=none; b=VgvYPvurXak+rx41rv6xiED6E0zTXzTBvoiVDiewb+7z9XlaVUC54e9FjYqubnmCUOH8sd1BClr/1vEsXXq935B5X2DioratbisXIqm2BFQIdBLncRavQ6wIfrXvrs2U2Ht+g2bSkFzktyQbA8/wOgQFLgr3IG6DspBBLheIZY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322330; c=relaxed/simple;
	bh=YaxXO+APbwl4nCnzlyBk5Bmbwn9R3VJHyTw76sVBsMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJ0zr7hW6AhL23NeIizr2zE3Df3TNsY2NWWj9zQsQd9m8kHuBRzpr+Sp0Vvl+kDcjH1HyiamfY5QM+g5ky5ebdvrbqUCNz/J+Or64HTE9QJtZpT5jCi0YTS/eVow2vABSYmGsVGBb515UBBlG1mJJx4lVRAiQ+yLPXBLXNlpUIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTo+ApB1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7BE6C43399;
	Sun, 24 Mar 2024 23:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322329;
	bh=YaxXO+APbwl4nCnzlyBk5Bmbwn9R3VJHyTw76sVBsMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTo+ApB1CrhAtnGVP6y99CWhVymtJM1fpcooFIO8kF8FuInN5AGjez6xWkMgAic6q
	 lrH2kiNakPiCJlRgZ2NmI5PhPJydfa6H+BFfJiCNkJNTT1wJCEWTV/44qj/fPXdF54
	 9Wh9OtmJa65qTWW35ZVJPX3I2ZJ+Ba7nqGRciuw8k8AmijGQc9CZbuq7bIrYvvhE+A
	 h4P65uQq8G9pl0WZDHeRmpwQxwgZUjffNceWu+DFgDZ9V+fzOXMOk5p2T/hN3U+s2r
	 e6sV9XPQofl62+4O478gPh2n1rWpPv+AKoGXkLIeX2xf9vqB0CjKBTKHTMTAyRuFNH
	 jmhOqqvXsA99w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 412/451] nvme: fix reconnection fail due to reserved tag allocation
Date: Sun, 24 Mar 2024 19:11:28 -0400
Message-ID: <20240324231207.1351418-413-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Chunguang Xu <chunguang.xu@shopee.com>

[ Upstream commit de105068fead55ed5c07ade75e9c8e7f86a00d1d ]

We found a issue on production environment while using NVMe over RDMA,
admin_q reconnect failed forever while remote target and network is ok.
After dig into it, we found it may caused by a ABBA deadlock due to tag
allocation. In my case, the tag was hold by a keep alive request
waiting inside admin_q, as we quiesced admin_q while reset ctrl, so the
request maked as idle and will not process before reset success. As
fabric_q shares tagset with admin_q, while reconnect remote target, we
need a tag for connect command, but the only one reserved tag was held
by keep alive command which waiting inside admin_q. As a result, we
failed to reconnect admin_q forever. In order to fix this issue, I
think we should keep two reserved tags for admin queue.

Fixes: ed01fee283a0 ("nvme-fabrics: only reserve a single tag")
Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c    | 6 ++++--
 drivers/nvme/host/fabrics.h | 7 -------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 951c8946701aa..d7516e99275b6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4971,7 +4971,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -5036,7 +5037,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	if (ctrl->quirks & NVME_QUIRK_SHARED_TAGS)
 		set->reserved_tags = NVME_AQ_DEPTH;
 	else if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect */
+		set->reserved_tags = 1;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_SHOULD_MERGE;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
diff --git a/drivers/nvme/host/fabrics.h b/drivers/nvme/host/fabrics.h
index dcac3df8a5f76..60c238caf7a97 100644
--- a/drivers/nvme/host/fabrics.h
+++ b/drivers/nvme/host/fabrics.h
@@ -18,13 +18,6 @@
 /* default is -1: the fail fast mechanism is disabled  */
 #define NVMF_DEF_FAIL_FAST_TMO		-1
 
-/*
- * Reserved one command for internal usage.  This command is used for sending
- * the connect command, as well as for the keep alive command on the admin
- * queue once live.
- */
-#define NVMF_RESERVED_TAGS	1
-
 /*
  * Define a host as seen by the target.  We allocate one at boot, but also
  * allow the override it when creating controllers.  This is both to provide
-- 
2.43.0


