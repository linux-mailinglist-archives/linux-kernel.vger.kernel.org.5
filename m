Return-Path: <linux-kernel+bounces-101763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBCE87AB5F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330721C21C32
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03FC5604C0;
	Wed, 13 Mar 2024 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbjMOhnU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4777C604A4;
	Wed, 13 Mar 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347588; cv=none; b=citJ70vCfPmxCUbqksvYqLwSlBk6ksJJ0N1316SThjuBiBSYAdK5C+yOiaiDnMlmPoOfdKLCdltDGcu1Jcnv/p88z0e6dzA2bhBGIuLCpc8jbGoBiybO7omh3y6MjCvejlxjwghIie1PHJBM9SX6LNIWrGVm0hzUyCU8UvDr6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347588; c=relaxed/simple;
	bh=HgNeIMIUSl/ymCYFblU0oK2L6lUJ4nE4XJFe/wXIm+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HR7X2LqicOE72S6Iw6wnBIRHk2UqopG0XU3sW7EtYsuUoNepgLjeryEQhWxjcNY3F1+KCpWg7NdC2qAZprOlLbcpfq1jNSwgk8v/r4FwfhluNXSI1Mby7UQGgcjZGGWT2frF5cUobfR805q8aPWsPUdzzzB10VWGZbyiQmC4j9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbjMOhnU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EBA6C43390;
	Wed, 13 Mar 2024 16:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347588;
	bh=HgNeIMIUSl/ymCYFblU0oK2L6lUJ4nE4XJFe/wXIm+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NbjMOhnUsmnizjUL+WPsjmRzbGt29+A5RiRNy186UCGwrY0Afs0bxIM9IAhJKDry8
	 DL42KoB5DSmJ0kSciEXPrLv95ZluWfIz2IjR2Mz0oxviAVaU8jXWAuNiiZIeqluPRp
	 nm6mA/eMlot4Jf/B/+ll8vdJhLAMFSmK6dBXLWilCRM6CmOWyyqhPu67BirS52ecBg
	 CfNFyqVa1ojKcnyfByTGpBSOjvzhoAX1GvB8T18b+U3+EY4FoMOtrQ7TO+1/ySmT6y
	 LiOK8ba4+qpLvdYRGR8JI/5/+gahnOFxjHkde0ox/jKVD0/blWPu86B1qi3+lL8lfo
	 rOYGVmlcHIFDw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 24/61] net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context
Date: Wed, 13 Mar 2024 12:31:59 -0400
Message-ID: <20240313163236.613880-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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


