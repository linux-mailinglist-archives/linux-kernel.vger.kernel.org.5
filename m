Return-Path: <linux-kernel+bounces-115740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA90188956A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89B89B2A4D4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36BD16D31A;
	Mon, 25 Mar 2024 02:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J99GXm58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380671419A1;
	Sun, 24 Mar 2024 23:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321865; cv=none; b=Z5mEpqUx8HGHqR7GqrGcNMUuaByXfBzVlOyiNezFYZG8psKQ3IBHZD151Ux1g6xf7CkfSTI7SOaEg4oB7u+gC5nrRy6sW5nZKPn+po6o9HbB+w+85QZggVJxA4bHUwsYrmkBLN/6V2weceJO8BMo9GvE30Uaxd3UGmvqPOZpKRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321865; c=relaxed/simple;
	bh=9S5h8flYvGTiisaL/cn2+2XRFNuvfJFgKPwjKS6Qmk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jlskHByLOCQkD2TczysaiHCRLL0mMlGbO5tWvHee4SS9f+2pxF50mSLEOU6z6SEGVJsFBC5Z6TnAinUVhz3xNWKEiX8zGsMz6NHYUG1bIpx+kUOISfGI6slbfCMXNZTwiRornb9WVAUqxxpWSq7sGe0pYzbaoU9IIKYSrVh3Clg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J99GXm58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6ECC43390;
	Sun, 24 Mar 2024 23:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321865;
	bh=9S5h8flYvGTiisaL/cn2+2XRFNuvfJFgKPwjKS6Qmk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=J99GXm58B+Wp43+WhZzDH0GUGIonWs/w9dZhybZCX5Oy7bVpcXxCx4DgoP26F1bBN
	 ZL1ds4ZcLG3jftS9CDZFog060CwLakEkwVcC7t7qUMNfFPFPo2kYD5maTl7bps0i2M
	 nIpGQTcwjaCEW3Z1XvDvCz5bj2T1Qxh3cjGkTWeELk/WFMggsXahvi+3xezb1jlEfj
	 EYIYgtz0BDTYnYTfIwrs2jbj6NbqoE30Z0IXvqdRON76dvV0d8SyPz1qcrsqzVtzuf
	 YY1/3XooSg91WPGp8KQLDEKX479z8dZbzMTCD7+s1zu4HPdl0DYzh/AsT3maVqLF/r
	 VPKyOAJgPQ5XQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Chunguang Xu <chunguang.xu@shopee.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 593/638] nvme: fix reconnection fail due to reserved tag allocation
Date: Sun, 24 Mar 2024 19:00:30 -0400
Message-ID: <20240324230116.1348576-594-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index d4564a2517eb5..012c8b3f5f9c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4246,7 +4246,8 @@ int nvme_alloc_admin_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 	set->ops = ops;
 	set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	if (ctrl->ops->flags & NVME_F_FABRICS)
-		set->reserved_tags = NVMF_RESERVED_TAGS;
+		/* Reserved for fabric connect and keep alive */
+		set->reserved_tags = 2;
 	set->numa_node = ctrl->numa_node;
 	set->flags = BLK_MQ_F_NO_SCHED;
 	if (ctrl->ops->flags & NVME_F_BLOCKING)
@@ -4315,7 +4316,8 @@ int nvme_alloc_io_tag_set(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
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
index 82e7a27ffbde3..80e15ad3936f3 100644
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


