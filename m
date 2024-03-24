Return-Path: <linux-kernel+bounces-113551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91F988853B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB401C248B1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB841C42C1;
	Sun, 24 Mar 2024 22:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTbi8jmd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A4A1C3A3B;
	Sun, 24 Mar 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320353; cv=none; b=F/ST8D5webFsKvYhbifH9tSUWAyLtF25DutRTv1cBa8qeMrr0dEmzkOS3ORWD2UjGKpqptR3kWdVlosHhdZAnkSSeaPJy7TtuvtJv1lNzSDRrWOfYidBE+TZ1XsRGcKiDYYCbArjTtS25zH24+S4omKDPAAPmOARW5Al60MGuYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320353; c=relaxed/simple;
	bh=JpwvVIpZkwE2cb/Wp3divkSsIYGOFDTGKt9N5N2jBis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p25YUtuKarYiCnoUGfUjWN/6WVDv9YIcgug9GAT4N5/m+k9l9smYSSFyxtt/8zriUoSQfD1cDGVa31n3bzQCK0qVVGUYu7BrHwZtqD6W7Pz082xwnnVO0QhRGzZ3mhxLcJBgYtN9fBnveyWGMR7Nt4tP58vxl7UbClu/hIMVi/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTbi8jmd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C69E3C433B2;
	Sun, 24 Mar 2024 22:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320353;
	bh=JpwvVIpZkwE2cb/Wp3divkSsIYGOFDTGKt9N5N2jBis=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NTbi8jmdJdR008fezQR1pbIn9rEyWC6aqzAr12i7/ZsiMhEPkZNgJALCm+Znslv1B
	 aHptuIWU2ECxQgCilp3vB30xN7rBevLOMHVJvLsz6FWnWVVqgVgpLTeWVA94q4762i
	 AU+ZCeUKgKt8G0ipO4HsVhPu2Nx3Y7fVLwWJ+9ujdCZAaeQv57OKQ/XeLhDBEeD4hv
	 3YNYA7o8BGLcBqJ2Rvdugja8/bbNwJT+lVyrbgr6fbYFfsI1zgMOVVB62CZmNEwszi
	 tUhXSEKgzaXyuqeh/YwyKbHDpzjLgT9mci7AahKg0Rfwx5ESeA7Qi9s1Da2Lgww/eO
	 LPTivLSABPkBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 660/715] nvme: fix reconnection fail due to reserved tag allocation
Date: Sun, 24 Mar 2024 18:33:59 -0400
Message-ID: <20240324223455.1342824-661-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index 0a96362912ced..fe3627c5bdc99 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4359,7 +4359,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4428,7 +4429,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
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
index 06cc54851b1be..37c974c38dcb0 100644
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


