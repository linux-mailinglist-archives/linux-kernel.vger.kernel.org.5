Return-Path: <linux-kernel+bounces-115995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B964889917
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA9F729AFB4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C2B39A8DC;
	Mon, 25 Mar 2024 03:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxUsP55V"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC242398B5;
	Sun, 24 Mar 2024 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322337; cv=none; b=Fby+d1oNoxcDGHQV+14Uz3ps6XdoCkko2naRQbGgbmJHG+586mkoTevmjzac/xOK5UJ5r8VSZMmVtiQN1X423ULnmfJrvbunGPGauuz8iW4koLtJNghC0qn04U4tBZ9OA/z2P2IAHUpN35wpppMgh4qc76Vi7ZEIjaqsRcdgOec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322337; c=relaxed/simple;
	bh=CFci3iPnitWwKX7nQz0R6IUhFkGa3kYzyWMExaZ85mg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W+7iJIHRRAYn8qrGkoGA8ZeijhOf9vUVkQLSDfvkYX4mFrrA9Y2i8DLjXr5x8GW0a+3LTuljXcAwkDnRkx/P4HmxvFVmNR9yxA3VTGWrts6eC4NuGrEoNfiJqdSBsddV4UDHTraQfu//0/u3AXHXxmFER2YlE4qpKkqIJ0/A7JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxUsP55V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50CD3C433C7;
	Sun, 24 Mar 2024 23:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322337;
	bh=CFci3iPnitWwKX7nQz0R6IUhFkGa3kYzyWMExaZ85mg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxUsP55VU6L7uEAN8lQflJ1YehAIivjlWKuTbzVnFBaB+musgrxuU1upBzk5lAudV
	 rZuD6lhjtuuSEQBA1Em3kziLden6iB1CxK+iNDntL7oa0kgK4HGcWcHhpaS6bd9Q8d
	 0c4LxrMKtxVUEEjV0JqCrbY1FsKtEM9gyEgreR3KQKiTnwObZVli18FLoQLp8AXq/M
	 onwnaidDKXkgKp4uuvhOfWTMJxJLdfZ1d98rDtOCr/wut659L5R7hxVruM66YBgmk8
	 w6AkOc/S8Vcqld/WLVqAqMKc4YB5RHuG5gtDbdYVY0b6aEWtcjAw1asQ0IFFAzyxAE
	 uRuzvdAOfLeJQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 419/451] vdpa_sim: reset must not run
Date: Sun, 24 Mar 2024 19:11:35 -0400
Message-ID: <20240324231207.1351418-420-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 61bde476cf9c8..e7fc25bfdd237 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -120,7 +120,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim)
 	for (i = 0; i < vdpasim->dev_attr.nas; i++)
 		vhost_iotlb_reset(&vdpasim->iommu[i]);
 
-	vdpasim->running = true;
+	vdpasim->running = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
@@ -513,6 +513,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	spin_lock(&vdpasim->lock);
 	vdpasim->status = status;
+	vdpasim->running = (status & VIRTIO_CONFIG_S_DRIVER_OK) != 0;
 	spin_unlock(&vdpasim->lock);
 }
 
-- 
2.43.0


