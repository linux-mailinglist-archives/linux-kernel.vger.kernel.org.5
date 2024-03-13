Return-Path: <linux-kernel+bounces-101759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD7C87AB56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:37:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EA791F21562
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A185F548;
	Wed, 13 Mar 2024 16:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuK77dnf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B3065F46F;
	Wed, 13 Mar 2024 16:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347583; cv=none; b=ghw5oSj7YBzmUpTKycOmTztwffasTLiYNcscjnEvnqUCnD3PZ8oZPenQOuIZVhHMi50wYXuirO5O6RQSOoF1RbkpQMsoEke4Wbs6Q0l1VThnrxrrsu6K21kBLZjbB3D2P+brXpi1+QDUIvZAV+5S9PsNZq45L5z5kqfUXpAfU1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347583; c=relaxed/simple;
	bh=YxLfOxqWoZu1HZCDFjZG3zm3hmSaWH2+oX/3G87+5RE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hjabq4Bg6x205u/5VxSGORrtXsIKXIuZNzvH0aWiwBHeT9vwMs/EB+cB01i5OvMOO41zbujhyOVrYmVcuCTrupdEYVZ4MBeRFuScaN74LNh7tEEEdKZtFYjezbLb71EysPTniYeptpxY/0lMJ1yMpdqHvv+F4/Qe6D80WaHvnHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuK77dnf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4652BC433F1;
	Wed, 13 Mar 2024 16:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347583;
	bh=YxLfOxqWoZu1HZCDFjZG3zm3hmSaWH2+oX/3G87+5RE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UuK77dnfiQlSHTsBcjPc/KR4mHoCUIvbnnfFviHE2QyoaqzrP+cMsB7ll5Jf68wsJ
	 qU7c0BWjr4PH4p0ddC86rge0PrWeYgjQ1X+Qi2NyBBmIQAvhj+NGFvpVbXUDEy3UwG
	 SZgVylF7IStXoJkQ6IKTCmiBnSk1m5TuMOiZRxImIndxhuUmB1Whj1pb8BtKg+d9Ni
	 HLgMaRnXAbL2cTzkn46oSrENmIMKYVqM6hDp9OG5CdUbnCzADLHsXi4iG4pIl6X1Zy
	 dLedKlHbVZvNRNlChMHKXN3o5qiq/vJbjwCqED8ooFijk6BqJ5Tk1HDjM434x6HcpK
	 5lv9n5Tccb2Ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Moshe Shemesh <moshe@nvidia.com>,
	Aya Levin <ayal@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 20/61] net/mlx5: Check capability for fw_reset
Date: Wed, 13 Mar 2024 12:31:55 -0400
Message-ID: <20240313163236.613880-21-sashal@kernel.org>
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

From: Moshe Shemesh <moshe@nvidia.com>

[ Upstream commit 5e6107b499f3fc4748109e1d87fd9603b34f1e0d ]

Functions which can't access MFRL (Management Firmware Reset Level)
register, have no use of fw_reset structures or events. Remove fw_reset
structures allocation and registration for fw reset events notifications
for these functions.

Having the devlink param enable_remote_dev_reset on functions that don't
have this capability is misleading as these functions are not allowed to
influence the reset flow. Hence, this patch removes this parameter for
such functions.

In addition, return not supported on devlink reload action fw_activate
for these functions.

Fixes: 38b9f903f22b ("net/mlx5: Handle sync reset request event")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Aya Levin <ayal@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  6 +++++
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 22 +++++++++++++++++--
 include/linux/mlx5/mlx5_ifc.h                 |  4 +++-
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 3e064234f6fe9..98d4306929f3e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -157,6 +157,12 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
 		return -EOPNOTSUPP;
 	}
 
+	if (action == DEVLINK_RELOAD_ACTION_FW_ACTIVATE &&
+	    !dev->priv.fw_reset) {
+		NL_SET_ERR_MSG_MOD(extack, "FW activate is unsupported for this function");
+		return -EOPNOTSUPP;
+	}
+
 	if (mlx5_core_is_pf(dev) && pci_num_vf(pdev))
 		NL_SET_ERR_MSG_MOD(extack, "reload while VFs are present is unfavorable");
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index c4e19d627da21..3a9cdf79403ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -679,19 +679,30 @@ void mlx5_fw_reset_events_start(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	MLX5_NB_INIT(&fw_reset->nb, fw_reset_event_notifier, GENERAL_EVENT);
 	mlx5_eq_notifier_register(dev, &fw_reset->nb);
 }
 
 void mlx5_fw_reset_events_stop(struct mlx5_core_dev *dev)
 {
-	mlx5_eq_notifier_unregister(dev, &dev->priv.fw_reset->nb);
+	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
+
+	if (!fw_reset)
+		return;
+
+	mlx5_eq_notifier_unregister(dev, &fw_reset->nb);
 }
 
 void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	set_bit(MLX5_FW_RESET_FLAGS_DROP_NEW_REQUESTS, &fw_reset->reset_flags);
 	cancel_work_sync(&fw_reset->fw_live_patch_work);
 	cancel_work_sync(&fw_reset->reset_request_work);
@@ -709,9 +720,13 @@ static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
 
 int mlx5_fw_reset_init(struct mlx5_core_dev *dev)
 {
-	struct mlx5_fw_reset *fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
+	struct mlx5_fw_reset *fw_reset;
 	int err;
 
+	if (!MLX5_CAP_MCAM_REG(dev, mfrl))
+		return 0;
+
+	fw_reset = kzalloc(sizeof(*fw_reset), GFP_KERNEL);
 	if (!fw_reset)
 		return -ENOMEM;
 	fw_reset->wq = create_singlethread_workqueue("mlx5_fw_reset_events");
@@ -747,6 +762,9 @@ void mlx5_fw_reset_cleanup(struct mlx5_core_dev *dev)
 {
 	struct mlx5_fw_reset *fw_reset = dev->priv.fw_reset;
 
+	if (!fw_reset)
+		return;
+
 	devl_params_unregister(priv_to_devlink(dev),
 			       mlx5_fw_reset_devlink_params,
 			       ARRAY_SIZE(mlx5_fw_reset_devlink_params));
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 77cd2e13724e7..bfc8320fb46cb 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10215,7 +10215,9 @@ struct mlx5_ifc_mcam_access_reg_bits {
 
 	u8         regs_63_to_46[0x12];
 	u8         mrtc[0x1];
-	u8         regs_44_to_32[0xd];
+	u8         regs_44_to_41[0x4];
+	u8         mfrl[0x1];
+	u8         regs_39_to_32[0x8];
 
 	u8         regs_31_to_10[0x16];
 	u8         mtmp[0x1];
-- 
2.43.0


