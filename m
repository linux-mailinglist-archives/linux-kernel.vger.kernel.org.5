Return-Path: <linux-kernel+bounces-115744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBF988958B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A378B31A63
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:03:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6889215E5BE;
	Mon, 25 Mar 2024 02:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoGiMvW6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F26A15686A;
	Sun, 24 Mar 2024 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321880; cv=none; b=YmDaISWztc9UhVxIzlgMuhU2vNaBZEoa9DisuFAd3E3fsNATdG5vGChyhxRFEnpYbjfUl5qQuD8cr94EFEB/osoWjtkdrehR4JxP3hkEWtoKZPf8ps7VqczllPD1zXH6Ay1IVan5BBzhpajxUKFATNwV+lJT/+YMcYxB64mWSks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321880; c=relaxed/simple;
	bh=o1Y2zRgX0DFu7YOCp+422qUaOZvAXTGpdtDvPYu8O00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JS5UtBt4pkKw7JFbo7CfMTT1xtGiJD/3+Cc6geM8434iKf+2D5WBuETedDDljpJXWO5gCW19wKUkqm7j0FJNwPBOxJSuS8ipyQ7PVFC1v/fL+wXTTi1jYjHeND7+a8yXqmjJJs1jU4UIknrsSl/QSBSriaCCufUc6Pg4Tajj6b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoGiMvW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5526DC43394;
	Sun, 24 Mar 2024 23:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321879;
	bh=o1Y2zRgX0DFu7YOCp+422qUaOZvAXTGpdtDvPYu8O00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YoGiMvW61GRAKxFJK1GRFLSf/uuRpNSNYdlCdYBlyqr6o+Q5Y+3mQ74Zlp67hFF67
	 XxFl5csH1oKlQUgkMU/yvJv4s2tZ8sxoM04P5UudUP1YqQCjJMTnHeq8u/AXBVq/zj
	 0ievN6qlWAafWebQ+QF4ExIKp9kal0uR3pk/fEx/YPeDY869KKBUPhbJvGDiIX9rs6
	 4SLqheeWE7QqvSTI4ALC/K4EDdVT1HTZiVnAZ0Tbif/ZcBWd4OsUw5qv3rcET9Zgvc
	 uQ4AzIUsjLmH8Hgap6nR+CKnIb4cV6locj7HyXcqC/1w2DcWwJqtigznxbLLNyRDJJ
	 DVonnsNCytAlQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonah Palmer <jonah.palmer@oracle.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 607/638] vdpa/mlx5: Allow CVQ size changes
Date: Sun, 24 Mar 2024 19:00:44 -0400
Message-ID: <20240324230116.1348576-608-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jonah Palmer <jonah.palmer@oracle.com>

[ Upstream commit 749a4016839270163efc36ecddddd01de491a16b ]

The MLX driver was not updating its control virtqueue size at set_vq_num
and instead always initialized to MLX5_CVQ_MAX_ENT (16) at
setup_cvq_vring.

Qemu would try to set the size to 64 by default, however, because the
CVQ size always was initialized to 16, an error would be thrown when
sending >16 control messages (as used-ring entry 17 is initialized to 0).
For example, starting a guest with x-svq=on and then executing the
following command would produce the error below:

 # for i in {1..20}; do ifconfig eth0 hw ether XX:xx:XX:xx:XX:XX; done

 qemu-system-x86_64: Insufficient written data (0)
 [  435.331223] virtio_net virtio0: Failed to set mac address by vq command.
 SIOCSIFHWADDR: Invalid argument

Acked-by: Dragos Tatulea <dtatulea@nvidia.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Signed-off-by: Jonah Palmer <jonah.palmer@oracle.com>
Message-Id: <20240216142502.78095-1-jonah.palmer@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Tested-by: Lei Yang <leiyang@redhat.com>
Fixes: 5262912ef3cf ("vdpa/mlx5: Add support for control VQ and MAC setting")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index ca972af3c89a2..b56aae3f7be37 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -144,8 +144,6 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
 
-#define MLX5_CVQ_MAX_ENT 16
-
 #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
 	do {                                                                                       \
 		if (features & BIT_ULL(_feature))                                                  \
@@ -2136,9 +2134,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 	struct mlx5_vdpa_virtqueue *mvq;
 
-	if (!is_index_valid(mvdev, idx) || is_ctrl_vq_idx(mvdev, idx))
+	if (!is_index_valid(mvdev, idx))
 		return;
 
+        if (is_ctrl_vq_idx(mvdev, idx)) {
+                struct mlx5_control_vq *cvq = &mvdev->cvq;
+
+                cvq->vring.vring.num = num;
+                return;
+        }
+
 	mvq = &ndev->vqs[idx];
 	mvq->num_ent = num;
 }
@@ -2799,7 +2804,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 		u16 idx = cvq->vring.last_avail_idx;
 
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					cvq->vring.vring.num, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
-- 
2.43.0


