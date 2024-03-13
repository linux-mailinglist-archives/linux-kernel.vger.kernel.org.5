Return-Path: <linux-kernel+bounces-102081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C7A87AE3D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52554282638
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7CE160862;
	Wed, 13 Mar 2024 16:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="blsca1cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281D515F30A;
	Wed, 13 Mar 2024 16:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348464; cv=none; b=VnfuURmWIs3OkGU33rEaGvK0/UscNEy6/MBwDNhvoEyjFmzzX1swWNNap+3ajEyN97oBbhBHj08jojdkJKWYgva2m7exiVxeyhyOR/jmQM0p+PPwHyullHGXmLjEhDhZqifhlq07t82U1K58vE4vu1yCFFslTcjVlbcjyv/TCjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348464; c=relaxed/simple;
	bh=h/rVP4ZfvNZ4dNRYln8ZY9JBuriyDowmAoAa1SmtD9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pt2Zq5P7iMue0j3OpEJhpBG4+wB+6Ev2ulOp86bSGpRYF9Grpnl+P2EVP2QouOS88cCTsxMN1bvpxRqzgiwgy8rZdl/4ldGbazeGq5hueFYwK1zJkaG//ylPTztjJfX89Pcy20MRpgKjqvClUZJzokE0cd/RxWJQ8ZJ+UlOjuHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=blsca1cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99B99C433F1;
	Wed, 13 Mar 2024 16:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348463;
	bh=h/rVP4ZfvNZ4dNRYln8ZY9JBuriyDowmAoAa1SmtD9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=blsca1cvDHD+2OT6OseKfP0Ymh8+9UysdJivv5vivA1p9Uoap10uxg8ONH4YvBEyu
	 bOnJ96aG2GpCZGqYBdXj1tBVRcDV9ttaWNTMG6fvF3eg2U+HJ/vdZAI5JdSkgoZ0/U
	 z+TsDINK8wkKk6Xow69x5UeR+IjWZQ35b2t2NpNk/t2PoO030RfFmLcyyNLO1KUMs+
	 NTdrLwR8+51H/r8ccndgpTbENFicSNHGzxjAYBPhoi+Z6KMaNxXODX9RcGDmnkZ5ie
	 KWdQeOnJWKhKoaLX05BeObsUX3moOHztozJfI26rfytvYVA/pjS/W4xblyA28XqQAQ
	 RLnVYw3SG7Stg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Shachar Raindel <shacharr@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 55/73] hv_netvsc: Make netvsc/VF binding check both MAC and serial number
Date: Wed, 13 Mar 2024 12:46:22 -0400
Message-ID: <20240313164640.616049-56-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Dexuan Cui <decui@microsoft.com>

[ Upstream commit 64ff412ad41fe3a5bf759ff4844dc1382176485c ]

Currently the netvsc/VF binding logic only checks the PCI serial number.

The Microsoft Azure Network Adapter (MANA) supports multiple net_device
interfaces (each such interface is called a "vPort", and has its unique
MAC address) which are backed by the same VF PCI device, so the binding
logic should check both the MAC address and the PCI serial number.

The change should not break any other existing VF drivers, because
Hyper-V NIC SR-IOV implementation requires the netvsc network
interface and the VF network interface have the same MAC address.

Co-developed-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Co-developed-by: Shachar Raindel <shacharr@microsoft.com>
Signed-off-by: Shachar Raindel <shacharr@microsoft.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 9cae43da9867 ("hv_netvsc: Register VF in netvsc_probe if NET_DEVICE_REGISTER missed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/hyperv/netvsc_drv.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index 057b1a9dde153..9ec1633b89b48 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2310,8 +2310,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
 		if (!ndev_ctx->vf_alloc)
 			continue;
 
-		if (ndev_ctx->vf_serial == serial)
-			return hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev_ctx->vf_serial != serial)
+			continue;
+
+		ndev = hv_get_drvdata(ndev_ctx->device_ctx);
+		if (ndev->addr_len != vf_netdev->addr_len ||
+		    memcmp(ndev->perm_addr, vf_netdev->perm_addr,
+			   ndev->addr_len) != 0)
+			continue;
+
+		return ndev;
+
 	}
 
 	/* Fallback path to check synthetic vf with help of mac addr.
-- 
2.43.0


