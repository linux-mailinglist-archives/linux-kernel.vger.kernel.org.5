Return-Path: <linux-kernel+bounces-101824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9032D87ABE9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DBC3B2461A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB006BB4A;
	Wed, 13 Mar 2024 16:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQSnvrhv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0B16AFA9;
	Wed, 13 Mar 2024 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347856; cv=none; b=qHIaaB9nFbYlYFgYnUe6EfFihW+Dey/gBfxzphLrjM5CYbFltmO7sSPZoIIqu8Z23lHJpFSRZvsj/AwIK/cNU+06CNsKcaslDcR+RjIXfqUaOK+2trcCMBGrbpq2WHtlTe1ZtCXbgcQegf8dbfIKUmDFOspS4i03c/pp6jpCk3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347856; c=relaxed/simple;
	bh=HgNeIMIUSl/ymCYFblU0oK2L6lUJ4nE4XJFe/wXIm+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jT3U+iHH7zUyhzbXeJjO/zdXj7jbWrdn4H+NXt61m18nbEbneIWI6kyLvu8JOL6ZZ0BIptP8vAaBWlj5rwzDciXTOntUWS326ubr6ibtqWQTRhVcwWeWZARg9HMFblLl5simHrXUsyHNxatemxZ8kJgrS+qq+LRmXj+IJYsj0HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQSnvrhv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0A9C3277B;
	Wed, 13 Mar 2024 16:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347856;
	bh=HgNeIMIUSl/ymCYFblU0oK2L6lUJ4nE4XJFe/wXIm+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CQSnvrhvnSufQ1gxk81VAD6F/Os3oHhgWiopQbCQ02YclTnCNSxSNquDccXkovP/a
	 Nbq4+uAY+vLfPsajXI9l5Sfj6oCXReCNNpo5ZPnEvMyqG2IqR+X/p8KgXOQ4W4Cgse
	 KWYe50oC3QTvsnRX3AfUQHZktpsJFubPKUpFXOTyy0zu/kCtuJ2j+9KHGvAdFoebw+
	 XRABx3B1aeMNQNdNTnBzwR2xzQMSoScdFCyGwWdCIRUKHSDt+SixKTd5tM2q808rdb
	 SMXX7yTdfbYBxp2NPBlx/03Jl7C4bJG6qtsF7n9Uiv/AoGYPn/+H27SY0bkI+E2iuJ
	 gf+YsZ5alKWkw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 21/60] net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context
Date: Wed, 13 Mar 2024 12:36:28 -0400
Message-ID: <20240313163707.615000-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Rahul Rameshbabu <rrameshbabu@nvidia.com>

[ Upstream commit 90502d433c0e7e5483745a574cb719dd5d05b10c ]

The NAPI poll context is a softirq context. Do not use normal spinlock API
in this context to prevent concurrency issues.

Fixes: 3178308ad4ca ("net/mlx5e: Make tx_port_ts logic resilient to out-of-order CQEs")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
CC: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
index 803035d4e5976..15d97c685ad33 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c
@@ -42,9 +42,9 @@ mlx5e_ptp_port_ts_cqe_list_add(struct mlx5e_ptp_port_ts_cqe_list *list, u8 metad
 
 	WARN_ON_ONCE(tracker->inuse);
 	tracker->inuse = true;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_add_tail(&tracker->entry, &list->tracker_list_head);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 static void
@@ -54,9 +54,9 @@ mlx5e_ptp_port_ts_cqe_list_remove(struct mlx5e_ptp_port_ts_cqe_list *list, u8 me
 
 	WARN_ON_ONCE(!tracker->inuse);
 	tracker->inuse = false;
-	spin_lock(&list->tracker_list_lock);
+	spin_lock_bh(&list->tracker_list_lock);
 	list_del(&tracker->entry);
-	spin_unlock(&list->tracker_list_lock);
+	spin_unlock_bh(&list->tracker_list_lock);
 }
 
 void mlx5e_ptpsq_track_metadata(struct mlx5e_ptpsq *ptpsq, u8 metadata)
@@ -155,7 +155,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 	struct mlx5e_ptp_metadata_map *metadata_map = &ptpsq->metadata_map;
 	struct mlx5e_ptp_port_ts_cqe_tracker *pos, *n;
 
-	spin_lock(&cqe_list->tracker_list_lock);
+	spin_lock_bh(&cqe_list->tracker_list_lock);
 	list_for_each_entry_safe(pos, n, &cqe_list->tracker_list_head, entry) {
 		struct sk_buff *skb =
 			mlx5e_ptp_metadata_map_lookup(metadata_map, pos->metadata_id);
@@ -170,7 +170,7 @@ static void mlx5e_ptpsq_mark_ts_cqes_undelivered(struct mlx5e_ptpsq *ptpsq,
 		pos->inuse = false;
 		list_del(&pos->entry);
 	}
-	spin_unlock(&cqe_list->tracker_list_lock);
+	spin_unlock_bh(&cqe_list->tracker_list_lock);
 }
 
 #define PTP_WQE_CTR2IDX(val) ((val) & ptpsq->ts_cqe_ctr_mask)
-- 
2.43.0


