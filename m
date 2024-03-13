Return-Path: <linux-kernel+bounces-101819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F287ABDE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:51:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3680B1F219EC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:51:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A3E06A01A;
	Wed, 13 Mar 2024 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwg0pLkw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FBD69E0A;
	Wed, 13 Mar 2024 16:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347850; cv=none; b=Gp7F3x6awzX1dqXbb9Rp/clb7+o2Gc0RlNsrttYKL7CglAaNfNMxKWdhWb/JVKYRpfhRt7mtMNgHrRQgsx+aw/0UvpK0eK3pfM77UkCKALA21meUHEGOqxwuDMfrnxYbk67x9GURy7PrCBXkhQ2jWnDxjpTPesAES0kTp37kgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347850; c=relaxed/simple;
	bh=BTDWC0OO27JZwD2AgNmBq4kpj5Z1Fx6E2ug8jwUS5Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sVozRTyA19M7PrjmPyuSXLvSDc2LzWbCbpr5W5bRbDmvIxx6/NrGkq6xmE38izJ0+bJJV6Zkb/tI8vesKYM0aKojylfRkOA9JuETtph1MePtF9vaivQgKdCsFVGW2H9+cUL+2YfHHykuu1uzAiP/M0JaUyjrBoWpZWZwkMpqJZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwg0pLkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B510C433F1;
	Wed, 13 Mar 2024 16:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347850;
	bh=BTDWC0OO27JZwD2AgNmBq4kpj5Z1Fx6E2ug8jwUS5Zg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bwg0pLkwk2FReaVRwsuv9ay4QdxSPdTlXTdda6nFCrVnFDiAD5RrrcoFkDBnkJU4D
	 bHw0tVY2xtO3oraAsfgByxGDth7US87UkFq+u6/0cmOfz/SCtpQueH5nuaItABwtQI
	 rMC7KzEzs//0k5296san9vMH87pBNsktpepRDNsdK9xgezFI32RPLTmzbAU1u62Pbe
	 sRskJo8M5JWceMejdW4Idb1TiR43JEjC8m6dHnj4h70H83UmYuM9BH2QlkcBwhkwVO
	 zi6yNVweQ323oMgThukPhE/+dFX+PQdaJsps/rDXx+48mdcSGw71EjDTzseYyekZWE
	 SEyhG7+i0CUqA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 16/60] net/mlx5: E-switch, Change flow rule destination checking
Date: Wed, 13 Mar 2024 12:36:23 -0400
Message-ID: <20240313163707.615000-17-sashal@kernel.org>
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

[ Upstream commit 85ea2c5c5ef5f24fe6e6e7028ddd90be1cb5d27e ]

The checking in the cited commit is not accurate. In the common case,
VF destination is internal, and uplink destination is external.
However, uplink destination with packet reformat is considered as
internal because firmware uses LB+hairpin to support it. Update the
checking so header rewrite rules with both internal and external
destinations are not allowed.

Fixes: e0e22d59b47a ("net/mlx5: E-switch, Add checking for flow rule destinations")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../mellanox/mlx5/core/eswitch_offloads.c     | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 14b3bd3c5e2f7..baaae628b0a0f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -535,21 +535,26 @@ esw_src_port_rewrite_supported(struct mlx5_eswitch *esw)
 }
 
 static bool
-esw_dests_to_vf_pf_vports(struct mlx5_flow_destination *dests, int max_dest)
+esw_dests_to_int_external(struct mlx5_flow_destination *dests, int max_dest)
 {
-	bool vf_dest = false, pf_dest = false;
+	bool internal_dest = false, external_dest = false;
 	int i;
 
 	for (i = 0; i < max_dest; i++) {
-		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT)
+		if (dests[i].type != MLX5_FLOW_DESTINATION_TYPE_VPORT &&
+		    dests[i].type != MLX5_FLOW_DESTINATION_TYPE_UPLINK)
 			continue;
 
-		if (dests[i].vport.num == MLX5_VPORT_UPLINK)
-			pf_dest = true;
+		/* Uplink dest is external, but considered as internal
+		 * if there is reformat because firmware uses LB+hairpin to support it.
+		 */
+		if (dests[i].vport.num == MLX5_VPORT_UPLINK &&
+		    !(dests[i].vport.flags & MLX5_FLOW_DEST_VPORT_REFORMAT_ID))
+			external_dest = true;
 		else
-			vf_dest = true;
+			internal_dest = true;
 
-		if (vf_dest && pf_dest)
+		if (internal_dest && external_dest)
 			return true;
 	}
 
@@ -695,9 +700,9 @@ mlx5_eswitch_add_offloaded_rule(struct mlx5_eswitch *esw,
 
 		/* Header rewrite with combined wire+loopback in FDB is not allowed */
 		if ((flow_act.action & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR) &&
-		    esw_dests_to_vf_pf_vports(dest, i)) {
+		    esw_dests_to_int_external(dest, i)) {
 			esw_warn(esw->dev,
-				 "FDB: Header rewrite with forwarding to both PF and VF is not allowed\n");
+				 "FDB: Header rewrite with forwarding to both internal and external dests is not allowed\n");
 			rule = ERR_PTR(-EINVAL);
 			goto err_esw_get;
 		}
-- 
2.43.0


