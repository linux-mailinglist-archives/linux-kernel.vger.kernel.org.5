Return-Path: <linux-kernel+bounces-101821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158CB87ABE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D26EB251F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA8995F848;
	Wed, 13 Mar 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="defZo1Oj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062516A341;
	Wed, 13 Mar 2024 16:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347853; cv=none; b=AtD2t/ntCXq2FlNwTWL6eU00HCqoHEDYdHqdvz9JzzATI0OHAZUkjrl83ZOD+LZ8P2LjH8FDBSOb7gdhBTHO5tcojAUJrmv1COJIFbc811/5eWQYnVNjV4Dz46mUanyhMRKxwdqfYOWpisu4fSAGNR4Hpr6fW74DxJEPlEUk3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347853; c=relaxed/simple;
	bh=YlWtToUlxKEnX2U2m3wijhUdlyteJt3Snj6b3vfiBoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jcF203ksKYbCnxWL8+13iAFPP+za7pqlPRmh18nmFf7WckwvaZCtSh3j/1JM3t4mrQUlqvCyxi34srg1HywPUGjfiCd6H+5rAjrWubLTzTtt+Nkw4AqYAfuvj0suNQCU4JDjYN+/AXhaKIf2TF0J5VVW8sQZFhi9/OUoSZyHhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=defZo1Oj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5497C43399;
	Wed, 13 Mar 2024 16:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347852;
	bh=YlWtToUlxKEnX2U2m3wijhUdlyteJt3Snj6b3vfiBoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=defZo1OjvfVZIQNnhdEITn5ZbyejT3T1qtYgxAxrBniSrcV+anRMvucdJ+3gcUWwD
	 d0lpza9+h/g1CveCnDThIKpcafwN9sLR7aUX/Hw7jDtX5g02nZUhLaRcLQDXQB2k3B
	 DH2sFJBh1hD4IM7wzJydb4pHokDzDFT+IJGHh1RTTxYcG1RiPKgCXRMqpym01LNaVh
	 HHEZrzAFIVtVRp1wZ9OTGflPDWIgnXlc5tybegC8dPUtunad9rAkDSMn9Mq4N2psqV
	 JlyB4wEsGiUFNnT4nRQN+8K/DOLrsoLbAYUuvurYQUuN8rv9n0uM49vxSvm4vatuxX
	 WmNfM3qyFsgXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>, Elliott@web.codeaurora.org,
	Robert <elliott@hpe.com>, Roi Dayan <roid@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 18/60] net/mlx5e: Change the warning when ignore_flow_level is not supported
Date: Wed, 13 Mar 2024 12:36:25 -0400
Message-ID: <20240313163707.615000-19-sashal@kernel.org>
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


