Return-Path: <linux-kernel+bounces-113569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA2688855F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BBFA1C24BB0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B391C7B9D;
	Sun, 24 Mar 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Nfvk7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C741C7B85;
	Sun, 24 Mar 2024 22:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320372; cv=none; b=SZWcxOZ0SP5fGw1nDoi27eY1zfPlBI6LcjN1qX269MU9MTrA/vX7wXI3J5VJs4tIlQBXZdgG5vgJHJ9Fj6K1G5/6F0tSEm07W37RCnPWGJ6GesF8s0Tq1/3lSLZYXoCeapuhdFFH0IgKUbxFjdqv5JjlrHws5pcezJ2u6Rp9hdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320372; c=relaxed/simple;
	bh=+3gwlDMFRgQgCGds7eNxqdW02deBnkNTGEUfDpFo1d4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KM/ILXkHOzqp9x0yj/VRFvpLdvKJTEgl5l3tH/5yuprBB0eBlCcRtB9GRMYj863wW3HtOAsJjw/XI5+5Grvjkgi0wYUMT+y/4hQAFPo5dyFx/HkSGg2Wm+307f+L7qKvo1PPm2jFRm4OWIfHW9WupCi5+gpeWupYUlL6A2rGn6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Nfvk7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D2AC433F1;
	Sun, 24 Mar 2024 22:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320372;
	bh=+3gwlDMFRgQgCGds7eNxqdW02deBnkNTGEUfDpFo1d4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k3Nfvk7lZr5jGwfsiY/dK4n+OtaCD90bFsoFtHpYA8R0FbxlnM2JzoPruBLsnXucc
	 qHSV9FeoMk/jOqJpp53iULtLGpEOBCOxgx0Xu2Ks9OUTMA2Kk4tRO3C6Y+jBR3+Poz
	 +mDiBlImoziR1oU8mwBeKuHGS/ED1lo0vHRAT5rBtRoz4d1b9ieEDCejCz+5c9BqfL
	 RcyhJlyyRGiX8fYE2vMd6GZkcS53HWR05SGEXFUyt71k6Xo7Amd+pe64+fN04XwPIb
	 nb8f/wBqtshfaeZ6tV37kxbpNWCEY3EJVvkMziS/5T9Wbrv4Ih9ZMy4wPrs74INtFw
	 tLARuuFJw99sQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve Sistare <steven.sistare@oracle.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 678/715] vdpa_sim: reset must not run
Date: Sun, 24 Mar 2024 18:34:17 -0400
Message-ID: <20240324223455.1342824-679-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


