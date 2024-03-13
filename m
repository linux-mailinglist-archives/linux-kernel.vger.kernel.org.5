Return-Path: <linux-kernel+bounces-101762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A642887AB5D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61F6B28C54E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4164A5F874;
	Wed, 13 Mar 2024 16:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU2C+8bx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FF4D5A1;
	Wed, 13 Mar 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347587; cv=none; b=KvgAObJD8/Ogq4dY0IUI731uW2oD7xfhWNrlMiQyepzusyPkDOE1cFnrZe7T1ebBJv6LRiw0ah1PXNz5DYXe2LNKOH6jyD1dMZR64mXNPoUy0WQipYJnZ2ncM61fJyZY3bL+tjubRA0kaaur//f69FAol+lA69oGj8nVyL5Q890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347587; c=relaxed/simple;
	bh=rluNJOBW/oQ5by3CTxx7JlTMFlO/HxGIYjcgOs+lZXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmL47vESSzu5dZN7vsVvMgL2XABXDksJCnHJr+spJRk2gx/a/e5BPHJQL36XEh+MF/t/jArJym7kn+omdQj5h4goXQczlQAOyG28j9ujyLBxNWCrPaWu/O9xwOWsU3ShR39yfejM1oEGyUMKRNi73lExV1VyNfBm4bVFeGvTJ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU2C+8bx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2862BC43399;
	Wed, 13 Mar 2024 16:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347587;
	bh=rluNJOBW/oQ5by3CTxx7JlTMFlO/HxGIYjcgOs+lZXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RU2C+8bxWlbpgJUXm6LFx5jXLPXseECIcc7nRzAKqVNdja0M3eG5vQl2gUc/5pmXD
	 UjOcESO3O2Ld4O7sCyDQVlLfurBb1KNx7+rtt50QB4h6iVT/T83PB4QuN6sby+EBKa
	 cLWUb4yZ7EFwJ0mPfvpPAX5v5XCZ8hnxugAc7M/tEOf8zPJkZ41XWDUubVx/UNZ98t
	 XouXNnUglFO8tgJdLji7ej46I0pIRSQybUr/1jD8cbmzmkUkoBlLFatIkuUqmlIqJN
	 1LtgU+pwa35TeK/MhGSkqv9gMW+Xpv476U6QihFW5r7tuaNJ3FF9EgVKpFi1OH5Jyy
	 CDwdQoVsMuDRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Vadim Fedorenko <vadfed@meta.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 23/61] net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
Date: Wed, 13 Mar 2024 12:31:58 -0400
Message-ID: <20240313163236.613880-24-sashal@kernel.org>
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

[ Upstream commit b7cf07586c40f926063d4d09f7de28ff82f62b2a ]

Just simply reordering the functions mlx5e_ptp_metadata_map_put and
mlx5e_ptpsq_track_metadata in the mlx5e_txwqe_complete context is not good
enough since both the compiler and CPU are free to reorder these two
functions. If reordering does occur, the issue that was supposedly fixed by
7e3f3ba97e6c ("net/mlx5e: Track xmit submission to PTP WQ after populating
metadata map") will be seen. This will lead to NULL pointer dereferences in
mlx5e_ptpsq_mark_ts_cqes_undelivered in the NAPI polling context due to the
tracking list being populated before the metadata map.

Fixes: 7e3f3ba97e6c ("net/mlx5e: Track xmit submission to PTP WQ after populating metadata map")
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
CC: Vadim Fedorenko <vadfed@meta.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index f0b506e562df3..1ead69c5f5fa3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -401,6 +401,8 @@ mlx5e_txwqe_complete(struct mlx5e_txqsq *sq, struct sk_buff *skb,
 		mlx5e_skb_cb_hwtstamp_init(skb);
 		mlx5e_ptp_metadata_map_put(&sq->ptpsq->metadata_map, skb,
 					   metadata_index);
+		/* ensure skb is put on metadata_map before tracking the index */
+		wmb();
 		mlx5e_ptpsq_track_metadata(sq->ptpsq, metadata_index);
 		if (!netif_tx_queue_stopped(sq->txq) &&
 		    mlx5e_ptpsq_metadata_freelist_empty(sq->ptpsq)) {
-- 
2.43.0


