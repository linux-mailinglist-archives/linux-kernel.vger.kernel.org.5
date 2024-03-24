Return-Path: <linux-kernel+bounces-114456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3149888A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B761F22A29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F362417A918;
	Sun, 24 Mar 2024 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bf2qnqtF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314A421F9F4;
	Sun, 24 Mar 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321879; cv=none; b=Anjk0xUr8mNFT7zpQUgBCjmGpVsaHYM/pyqCla4TaQHsT/96Gth5aXwHyAk8+TkN9D9ip/HXTLtVSpezrVqDjHmX3twfJVPAKQZ87Od3Fi75zqMbUC0gid4yQr+8ZaEuvrDmBbabdEVRw3WXOP1VVGedtzfVg3EiMsNG4wanbEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321879; c=relaxed/simple;
	bh=ncP4VVJXjWIqhc/CiV3uRRV6k6wbXfDl8IbLaEANtMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JZVfm0FBzXM3WvCuSsMZ1pev0EyqWrxO3P42xIISLw1Reeg2fupEz386TicvOjeq0kP95sQBAVrjgIIqDQHN+DGS1ureRl7eXt/gseM/yHQuB5zLmUJfLoyHB2Du0OddMe48PekQxJ6kuJPpDI7AcSHP8bAz303myHi9fDIZMkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bf2qnqtF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 463CBC433F1;
	Sun, 24 Mar 2024 23:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321878;
	bh=ncP4VVJXjWIqhc/CiV3uRRV6k6wbXfDl8IbLaEANtMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bf2qnqtFMCuhs+R4kYKE1z0SR8hBZ9IYULR5MMfB1dui6MFKTnh7y0Zhyq6Kxl7Fe
	 Z9c2RlTYcPdXkOBV6Q6i/zTmpt8m68Z9pErEU8j12A0Hxgl5XRhL6FslWuGjKPScwt
	 rxseRT456fOfSJtpGyUDXwWW56tCDp1oh8Xrv7y4PI/0MA4SMpfdEl8A1/XF8TjXeC
	 7ZMuA0/IEIOVO78kp4dXQM2vhWgl3f2D23KR5nkToqk3HbsOlIN2oOkXEqwau4qB/H
	 KmVf4UAqVPRswGHfLK3lAs0t7nO+qDdJBfLVdwvufJYfP4A7NF8Ej/9ZubYEvNBwLw
	 wsFRyGCZuKQHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 606/638] vdpa_sim: reset must not run
Date: Sun, 24 Mar 2024 19:00:43 -0400
Message-ID: <20240324230116.1348576-607-sashal@kernel.org>
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

From: Steve Sistare <steven.sistare@oracle.com>

[ Upstream commit 9588e7fc511f9c55b9835f14916e90ab940061b7 ]

vdpasim_do_reset sets running to true, which is wrong, as it allows
vdpasim_kick_vq to post work requests before the device has been
configured.  To fix, do not set running until VIRTIO_CONFIG_S_DRIVER_OK
is set.

Fixes: 0c89e2a3a9d0 ("vdpa_sim: Implement suspend vdpa op")
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Reviewed-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Message-Id: <1707517807-137331-1-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim.c b/drivers/vdpa/vdpa_sim/vdpa_sim.c
index 76d41058add9a..421ab01ef06ba 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -158,7 +158,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 		vdpasim->iommu_pt[i] = true;
 	}
 
-	vdpasim->running = true;
+	vdpasim->running = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
@@ -477,6 +477,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
+	vdpasim->running = (status & VIRTIO_CONFIG_S_DRIVER_OK) != 0;
 	mutex_unlock(&vdpasim->mutex);
 }
 
-- 
2.43.0


