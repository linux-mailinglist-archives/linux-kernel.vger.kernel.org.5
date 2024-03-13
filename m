Return-Path: <linux-kernel+bounces-101760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8B187AB59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D641F21388
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6B85FDC6;
	Wed, 13 Mar 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IpjL9w0h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78FF5F874;
	Wed, 13 Mar 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347585; cv=none; b=mj3oA4uueCzix1KDk00BH3hmCuq9jdcfgOaaJbqbeoCaq/4saPRB3A4BbmOLe08Uy+wpNaOsBOE1rhEAa/P7hf5CCyzntZXD0KwWm7DLCXnJDP9qmmkxNzkVmgpxmLxcJidQcpmdIhpxr9HGHqqZbdX8r+wSPcXB7MD8xoyyM5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347585; c=relaxed/simple;
	bh=YlWtToUlxKEnX2U2m3wijhUdlyteJt3Snj6b3vfiBoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dxb0RKcxsbzjl/QvluDVN6kj4J83zDMk82+itV7Ncy2Uvq/Aslvrfzkp31o0Jb/n7A3Oey3rR3j+N1/sHfkN6Fwbt0ibJTAiYQApBNmGNOHKhxxXftiKVfVzdni+L4elv03mz66mUQa+A4r9awmVRTLPn5yaRobUbYMlV7YOhnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IpjL9w0h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F997C43390;
	Wed, 13 Mar 2024 16:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347584;
	bh=YlWtToUlxKEnX2U2m3wijhUdlyteJt3Snj6b3vfiBoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IpjL9w0hdEWSpWLH9IGQZs6HOc1IRmgAQGx0w/trKnhX+XXMieUHfc2HqY1qPvDha
	 XuH0070bBZwacPYo5CZk6uI1/UnHd8KHK3iH7MvK1zPYrrdfmwjt2pd4us4CcugpVj
	 fREv/9r5k7/7ZyHRYov6aZVaf5yrcZwkk03e6l2LRSpPX1kSRHUjrjOTv5IIrUWUl6
	 9vMdHeqtJ1HwR+tSQdSw5lqAFm1FwC1cFZI1NLroF/Xaukuqgg5h07iB6YTHYOnoKB
	 DwfLF7BgQ2UvlRdm3k7f8Xde9xjQSGH0hxAhdHL/5ApPi7R20LzA2TKnCE5ux6wyc7
	 6P+3E7kbtTU1Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>, Elliott@web.codeaurora.org,
	Robert <elliott@hpe.com>, Roi Dayan <roid@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 21/61] net/mlx5e: Change the warning when ignore_flow_level is not supported
Date: Wed, 13 Mar 2024 12:31:56 -0400
Message-ID: <20240313163236.613880-22-sashal@kernel.org>
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

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit dd238b702064b21d25b4fc39a19699319746d655 ]

Downgrade the print from mlx5_core_warn() to mlx5_core_dbg(), as it
is just a statement of fact that firmware doesn't support ignore flow
level.

And change the wording to "firmware flow level support is missing", to
make it more accurate.

Fixes: ae2ee3be99a8 ("net/mlx5: CT: Remove warning of ignore_flow_level support for VFs")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Suggested-by: Elliott, Robert (Servers) <elliott@hpe.com>
Reviewed-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
index 86bf007fd05b7..b500cc2c9689d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/post_act.c
@@ -37,7 +37,7 @@ mlx5e_tc_post_act_init(struct mlx5e_priv *priv, struct mlx5_fs_chains *chains,
 
 	if (!MLX5_CAP_FLOWTABLE_TYPE(priv->mdev, ignore_flow_level, table_type)) {
 		if (priv->mdev->coredev_type == MLX5_COREDEV_PF)
-			mlx5_core_warn(priv->mdev, "firmware level support is missing\n");
+			mlx5_core_dbg(priv->mdev, "firmware flow level support is missing\n");
 		err = -EOPNOTSUPP;
 		goto err_check;
 	}
-- 
2.43.0


