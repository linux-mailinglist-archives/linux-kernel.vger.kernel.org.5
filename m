Return-Path: <linux-kernel+bounces-101817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA3087ABDA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B02E41C21008
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD665F554;
	Wed, 13 Mar 2024 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qR4e3LdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0D269D17;
	Wed, 13 Mar 2024 16:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347848; cv=none; b=aDdLFLVhTdGvvUx1Ky9eRBbq8bC+30ljoyKQR/RmBd3yvnduY8UnpHVAZu9ZselDIzb4fv6qCwIrx0lbdbfQuXfT3J9oCanxLsD5udOGEHdWja0XsttxIS9C6toMQ9VG+xxPRKd0H03/6aboQNw7P+nVLXRwmdM1k4BlUvmYqxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347848; c=relaxed/simple;
	bh=S44Bxf3H3YLvcP2MTqG0v13+jDgLG9ITI6aZKtwfMf0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LpIMCSP53iK0lxSLQsXVOMOGMdJANZNg1cN11wGF4jkO68lmMGYWeEsuNkeNpZx5pUVKPEZiuTWKoCaOPJ82a65czlkWVf6gF81VAaJi0LRQiiwxVgVOZc8KjRYWel4YiNsxB5iwyp6KpcPiX7SzOOsTz6Sw9hGOCjVmi3SRoLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qR4e3LdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D89C433F1;
	Wed, 13 Mar 2024 16:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347848;
	bh=S44Bxf3H3YLvcP2MTqG0v13+jDgLG9ITI6aZKtwfMf0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qR4e3LdNWjfN0riODJWtJoSinAoLKNixRuPstm+ETzyS/G7QERHvbIjg7mJ59n99Q
	 B6Aw1B9cV8poPQIQWYhg/sWl6UzVuOQaZGuqfh+1QI5HYQ9Ntl//KRo7hRzTb0Mcz5
	 CVu9HEd/a/IIjsp33jPUGxYTaLTBa1J0makZj82T4bB488XnU1gZtFLrRsa+0psZR4
	 6I6BYZqCNNpzY256qeM0SuZpHeMsJJ+mwpFNWmHVx7YmC4Wg0DgpeL2Ncip5R+0G/N
	 5nqHv5+IULfVQea+zTmzqVmk1exYGeWWb3LrcwIlIvpPd7pMii02fTU3dXzXuYwDgv
	 KGU4cdrdj8NTg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gavin Li <gavinl@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 14/60] Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"
Date: Wed, 13 Mar 2024 12:36:21 -0400
Message-ID: <20240313163707.615000-15-sashal@kernel.org>
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

From: Gavin Li <gavinl@nvidia.com>

[ Upstream commit 8deeefb24786ea7950b37bde4516b286c877db00 ]

This reverts commit 662404b24a4c4d839839ed25e3097571f5938b9b.
The revert is required due to the suspicion it is not good for anything
and cause crash.

Fixes: 662404b24a4c ("net/mlx5e: Block entering switchdev mode with ns inconsistency")
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 -------------------
 1 file changed, 23 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index b0455134c98ef..14b3bd3c5e2f7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3658,22 +3658,6 @@ static int esw_inline_mode_to_devlink(u8 mlx5_mode, u8 *mode)
 	return 0;
 }
 
-static bool esw_offloads_devlink_ns_eq_netdev_ns(struct devlink *devlink)
-{
-	struct mlx5_core_dev *dev = devlink_priv(devlink);
-	struct net *devl_net, *netdev_net;
-	bool ret = false;
-
-	mutex_lock(&dev->mlx5e_res.uplink_netdev_lock);
-	if (dev->mlx5e_res.uplink_netdev) {
-		netdev_net = dev_net(dev->mlx5e_res.uplink_netdev);
-		devl_net = devlink_net(devlink);
-		ret = net_eq(devl_net, netdev_net);
-	}
-	mutex_unlock(&dev->mlx5e_res.uplink_netdev_lock);
-	return ret;
-}
-
 int mlx5_eswitch_block_mode(struct mlx5_core_dev *dev)
 {
 	struct mlx5_eswitch *esw = dev->priv.eswitch;
@@ -3718,13 +3702,6 @@ int mlx5_devlink_eswitch_mode_set(struct devlink *devlink, u16 mode,
 	if (esw_mode_from_devlink(mode, &mlx5_mode))
 		return -EINVAL;
 
-	if (mode == DEVLINK_ESWITCH_MODE_SWITCHDEV &&
-	    !esw_offloads_devlink_ns_eq_netdev_ns(devlink)) {
-		NL_SET_ERR_MSG_MOD(extack,
-				   "Can't change E-Switch mode to switchdev when netdev net namespace has diverged from the devlink's.");
-		return -EPERM;
-	}
-
 	mlx5_lag_disable_change(esw->dev);
 	err = mlx5_esw_try_lock(esw);
 	if (err < 0) {
-- 
2.43.0


