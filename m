Return-Path: <linux-kernel+bounces-101756-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC9E87AB50
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E3321C20A25
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6925DF3B;
	Wed, 13 Mar 2024 16:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it77i0Wq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D8F5D8EB;
	Wed, 13 Mar 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347580; cv=none; b=hHobxuDwkgCjm6NyyuUX935ZERlkA/TwkxR/Etd2+I5JFtUYfXxz/6aRt1Upn2nkm4LoJcBAOL9Mi+vy4evDZuPwqL2gxBdiDDaYkc/aQAawNDSrzYVJTw31O1uRwc4yWz2oPA5fDaJ/AQPJzFS35zWC/ne+vI0WPQEg9H1r0YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347580; c=relaxed/simple;
	bh=0KBB3f2hhInJvzMhFa30sFjA2n5SsFxuQOrLFjZFMD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i4fWGUAW9xL4HODbQSdAc0ycamsVuE7PdI89373ELweoWwX8n7rMkyJDZeAa3RvqMRJVKeS3FtZkbk84o14VOPl2yPSLMr2nO0TvXvFowlB3nNB8oCnWk4V4bdb2MBGTv/Qm/R3m6gcBGFrwvqba1WwiM6jCUsu3OYgrLAX5vNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it77i0Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120C4C433C7;
	Wed, 13 Mar 2024 16:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347579;
	bh=0KBB3f2hhInJvzMhFa30sFjA2n5SsFxuQOrLFjZFMD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=it77i0Wqofk8diV3p9hDy0StNPooAG9JtcR9DUtzQ5CDcqNtAy6UqFCHnZmAceCNw
	 tXAoDFKAY8BkW+m7QGoeX+DaZQ5qyQ1wiZJ2BovJLs3p2IrmWeo4U1fRE86EiaPAzC
	 PB7iJp+73vbnwwtqxMRAH8IAVv6yqGRLYmKTrUAK+6ts8szJrH9noap5AFX+i6ohpB
	 rF33Jja0skxihfQAu9LXJwn17FiBT90ieBLPz39ZG1bxYDFIlvCsGD/G38Yu/TmYaW
	 2R0f/Ok+PMz9AdV65ghGCHTS8zLT4et36+q37cb+ZB8B8p7NNkqqOEk29l8qjHNPM3
	 FnrwX6Z5bSNtA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 17/61] Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"
Date: Wed, 13 Mar 2024 12:31:52 -0400
Message-ID: <20240313163236.613880-18-sashal@kernel.org>
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

From: Saeed Mahameed <saeedm@nvidia.com>

[ Upstream commit b7bbd698c90591546d22093181e266785f08c18b ]

This reverts commit 4e25b661f484df54b6751b65f9ea2434a3b67539.

This Commit was mistakenly applied by pulling the wrong tag, remove it.

Fixes: 4e25b661f484 ("net/mlx5e: Check the number of elements before walk TC rhashtable")
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
index 190f10aba1702..5a0047bdcb510 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
@@ -152,7 +152,7 @@ void mlx5_esw_ipsec_restore_dest_uplink(struct mlx5_core_dev *mdev)
 
 	xa_for_each(&esw->offloads.vport_reps, i, rep) {
 		rpriv = rep->rep_data[REP_ETH].priv;
-		if (!rpriv || !rpriv->netdev || !atomic_read(&rpriv->tc_ht.nelems))
+		if (!rpriv || !rpriv->netdev)
 			continue;
 
 		rhashtable_walk_enter(&rpriv->tc_ht, &iter);
-- 
2.43.0


