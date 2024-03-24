Return-Path: <linux-kernel+bounces-115572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 031B0889C80
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23BA29F209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1D30B48B;
	Mon, 25 Mar 2024 02:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D5i50yAy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0364E1F30A1;
	Sun, 24 Mar 2024 22:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321118; cv=none; b=BctExuRT/XVQ4N/9oUhIfNqHk9hU9SV9PtbpdoWFw6WjF1QfHzKqM24TdzS2X3m7x5pmWU9aUoiLmVJHFoNr4N4FO5sbuRMAjcJ/Txa4Jl8q4qQLvxQFj1SrFMn/ZFTz3m6cCLhoO7DJ9jdU+q3JONBV+t4KMI1+tBQkbldxOIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321118; c=relaxed/simple;
	bh=8XzqLeiFcOKmwXfmSkRrnmW1w/T117hHKhhGH5WdNRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fZ4AAVKw8eGukpk0VWsMrpe2xB8JDJH5qCqPJrzEQKrTglhIVpfTGhX7gyuY7ZeZ8d6I0rmHmVCHz+WQOFtGLf9LhqEMa1mLopvhstAMBgHr11dnPsIQmaJXV4YxtkNFkn/1VuXjVudCP3hWZuQHUhpdvQBExjbn5f+hsTYK4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5i50yAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6F4C433F1;
	Sun, 24 Mar 2024 22:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321116;
	bh=8XzqLeiFcOKmwXfmSkRrnmW1w/T117hHKhhGH5WdNRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D5i50yAyrgMCZBhTl8ytIoWvav7nTrZG9F8A1OzMeM9NKX0K6TMpXj4C8y1mbGJsX
	 3745ZzQbdddIPAsARlSEbI/G0hEbEh3FMJhJ0/miQP4jOxYSGyzSqYSB9x/NBNs1pb
	 JArk3XxmTy3nPK0Y5srXQIapSMjOIO12kor2YvQvaRbz5zsMkKjy6ZGzBJVo1dW/G9
	 Th/6j4xNsZ11S0gPP38l75XCMmaFtQXZhPL4G83j0TgSIXDX9PVT6VznXAnZjpA75X
	 ly63ssBCGKWXh2zvd3QHrTA2QeyqcykoDxfCgxWa7mal7iMQVMJYY1aGDdyXfADKxx
	 IJLaRR5CE239g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jonah Palmer <jonah.palmer@oracle.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Lei Yang <leiyang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 678/713] vdpa/mlx5: Allow CVQ size changes
Date: Sun, 24 Mar 2024 18:46:44 -0400
Message-ID: <20240324224720.1345309-679-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index 26ba7da6b4106..7795d2b7fcd1c 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -145,8 +145,6 @@ static void teardown_driver(struct mlx5_vdpa_net *ndev);
 
 static bool mlx5_vdpa_debug;
 
-#define MLX5_CVQ_MAX_ENT 16
-
 #define MLX5_LOG_VIO_FLAG(_feature)                                                                \
 	do {                                                                                       \
 		if (features & BIT_ULL(_feature))                                                  \
@@ -2147,9 +2145,16 @@ static void mlx5_vdpa_set_vq_num(struct vdpa_device *vdev, u16 idx, u32 num)
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
@@ -2819,7 +2824,7 @@ static int setup_cvq_vring(struct mlx5_vdpa_dev *mvdev)
 		u16 idx = cvq->vring.last_avail_idx;
 
 		err = vringh_init_iotlb(&cvq->vring, mvdev->actual_features,
-					MLX5_CVQ_MAX_ENT, false,
+					cvq->vring.vring.num, false,
 					(struct vring_desc *)(uintptr_t)cvq->desc_addr,
 					(struct vring_avail *)(uintptr_t)cvq->driver_addr,
 					(struct vring_used *)(uintptr_t)cvq->device_addr);
-- 
2.43.0


