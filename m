Return-Path: <linux-kernel+bounces-113977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 543BC8887B2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DA2628A3BF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5DD21F9F1;
	Sun, 24 Mar 2024 23:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJqEEWOc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268DA1F23E2;
	Sun, 24 Mar 2024 22:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321103; cv=none; b=jzTsrplI4c6X5fAs88o9YboERtm4gVTJLXg1MOBjhs90Mlhan1jzWgF/6kyF1QKzGisSYK8Boul3j1FCGVDV1cYzGWjRwTE4QPMPdx8YeiWb/nVg5jN5iIdxtQtHuPzE10K5AN2Y5GVSgtxIGpJ3Odo5rpIyOsDXNd3TH9nGcEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321103; c=relaxed/simple;
	bh=POaKdfmor0NY4YSUCWCOe5t3Q6ZXFcgf7ehO2+D6GTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ln9ARLjG/WmO7m75VBnvMZOR8pb5UoWayHIA9eMa8OodZharV+GK28nU6xY4268rAnIbuQGebCFG+43NQH5UC9YPq7pa/7byMtza0AK3nFlhxRhMYLjgWGGMulb+SNgqGfFgaK72K/BQAEO2tvbPD4p9AJK5vs/Qc2lXpTBy3UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJqEEWOc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6C9C43394;
	Sun, 24 Mar 2024 22:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321102;
	bh=POaKdfmor0NY4YSUCWCOe5t3Q6ZXFcgf7ehO2+D6GTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJqEEWOccZvsNr1eOLCak8WtDpW76xAD02liMHfkTXNTgUXyaU886qiN5jjI2DUdy
	 ilwZv1D7AILElJzqLANXR9zHtaVSZOTl3GZBlCNbolpR9q9u3T/c7VvFRY8r9Rv9WB
	 aW3saI7iH5KiphwdfMHnYwDU3CjNk4WGPDAMWD9TPL2R4XvaXar4Wz3BUZAjT4BSCA
	 kjT6hos2qcYx+YqGiSHcoqqHJafimnDQhvkma7Yp6pokKFI2Ska9eG68wTmLQx5O/a
	 JDit5oZJx2Sm+eOyiVlwHl8jdea2GMs3YnzliJ8YiQ2X7t7eDcF9mJ6lT1LA6Es9vq
	 iLLF4fm76K0Dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 664/713] nvme: fix reconnection fail due to reserved tag allocation
Date: Sun, 24 Mar 2024 18:46:30 -0400
Message-ID: <20240324224720.1345309-665-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 86149275ccb8e..771eac141298c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4272,7 +4272,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4341,7 +4342,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
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
index fbaee5a7be196..e4acccc315bd9 100644
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


