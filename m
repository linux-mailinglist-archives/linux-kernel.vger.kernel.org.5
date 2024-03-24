Return-Path: <linux-kernel+bounces-113987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735A8887C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB211F26468
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DD33221938;
	Sun, 24 Mar 2024 23:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd9iOJD9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581C612D219;
	Sun, 24 Mar 2024 22:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321116; cv=none; b=gOVupQPydGQWWlXS5J7O5yk7CbPwFi9rRcMxZJJ39JaXjyQIuE+33wmx7G7mAINmujHjomOK93HLdhLoonpJrXBi92dgeMGDEYaNwPuEr9A8DPs/B67vMepOhvTdNCkW/Yl951shn6Phb2EoRErg6q5bKJdLkvLsvRXaJ5i0c7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321116; c=relaxed/simple;
	bh=+3gwlDMFRgQgCGds7eNxqdW02deBnkNTGEUfDpFo1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oH0EuU3jgYulXP6jtDdnvMMb38QbZjNErnleHp27qjQhlbxD+64Pd+25qox4eenxmBsPBuBOAe33rw8CCAPQYPQcLfuSWEGa43+wKVOOrfqvuwgBbH2DyMdccFcCFwG41qD/1v5wHdbcFzm0/SB/S9krJH6c7IePmkXkpmartVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd9iOJD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6757AC43394;
	Sun, 24 Mar 2024 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321115;
	bh=+3gwlDMFRgQgCGds7eNxqdW02deBnkNTGEUfDpFo1d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fd9iOJD9Qab1oaaPAUcISc76nMWxXB2AC63m+6PEcpjMstHrfPWsvgS3yuPuCCxe9
	 ZUu3r5tgeR9CNSvCLMG15JEv3NRGCry5R3uh04cwkn4Np6RFsa2+/M4tPbProOJc4o
	 5GYoBSk8wIAbYzQP0Iz6g71+xGGQnMtSY06H3GmJvBvDizhovu8Aq1Vluy/VPH21qd
	 U6lxMH8/rTV9TU0a9RKelvD2Fmh7HpPblA1MUzrDCFPQTSOfRoW4BF1hf1XrHbuVG7
	 UYNdnQolss9Z63Jio5jCCZcjOstHSQSffiOREQedvQJTEEIYJ1ls8JZzMuPd4tqIIC
	 ozk0fgQmI/viA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 677/713] vdpa_sim: reset must not run
Date: Sun, 24 Mar 2024 18:46:43 -0400
Message-ID: <20240324224720.1345309-678-sashal@kernel.org>
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
index be2925d0d2836..18584ce70bf07 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim.c
@@ -160,7 +160,7 @@ static void vdpasim_do_reset(struct vdpasim *vdpasim, u32 flags)
 		}
 	}
 
-	vdpasim->running = true;
+	vdpasim->running = false;
 	spin_unlock(&vdpasim->iommu_lock);
 
 	vdpasim->features = 0;
@@ -483,6 +483,7 @@ static void vdpasim_set_status(struct vdpa_device *vdpa, u8 status)
 
 	mutex_lock(&vdpasim->mutex);
 	vdpasim->status = status;
+	vdpasim->running = (status & VIRTIO_CONFIG_S_DRIVER_OK) != 0;
 	mutex_unlock(&vdpasim->mutex);
 }
 
-- 
2.43.0


