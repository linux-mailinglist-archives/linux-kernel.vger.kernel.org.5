Return-Path: <linux-kernel+bounces-102216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F9987AF7F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:26:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E14291F24453
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EC081A1059;
	Wed, 13 Mar 2024 17:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6hg19du"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753E91A1040;
	Wed, 13 Mar 2024 17:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349510; cv=none; b=gEi8QByEvULHt+izJPCa4u6CIEwO2RCZxG/bL0wEvgALPEQq3ALTS4K1JgszG2G9Z60t+Gm6iucg+vmS/tijUWvYgA75sm5oVkC/x5UjZM8qT2Rl4rc0xyLLK4SbsB14eesQRYUVWV8zsFNCmXb5omgFHVbAcsWUfzk0pOl+67s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349510; c=relaxed/simple;
	bh=fmIVIIiO9vaCsapouNjn2huS07HhKqTleCE92uaJSbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYi3BFQTJSfsHpQojgck1me68ZhRBSYvVzObzGfy3I2l+73OL3mRRUiev/XHKodyNPnQE7hxHohKuF9Bj9kX5vX/gwBC/wkB8oH48BdbIn72hWBKw1pp90rBH6J0nvsBC9feKDbczVYw7VTi/RsC5vVkwovrfN6O9ZOA4Rf7Y8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6hg19du; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD46C433C7;
	Wed, 13 Mar 2024 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349510;
	bh=fmIVIIiO9vaCsapouNjn2huS07HhKqTleCE92uaJSbI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U6hg19duGsZ8BcVpNmzdoRXCq/JCxeGxcVUDn4wVtenFTRRrPTQX04jw86LYBmvRH
	 rKxLvJhFRGwn7iICingQQ4C0W9HqEuOT/Pxmw1HVmPU/mZIQcWDRcvqaB3+cjzEIfH
	 VbUOw0CEDY9Ejk04ENMcCMCZzoY69knswoU4d/Cf69mN94sYLChnFhVT5+X3Y33UdO
	 rwpq/ck+PM+7XnT7JICXfHMcyc3M5a54AAkY2cwobxSYfuDlypz93o3/0RHjp5nUuK
	 JCciHZ+1ICokE/zX9Xhhx9leFMfj2GFwXeTMaOBUvzrkD7Hf35ZJBGeApnOcRNxGvW
	 91FM5ZFvlOLNA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Shachar Raindel <shacharr@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 29/41] hv_netvsc: Make netvsc/VF binding check both MAC and serial number
Date: Wed, 13 Mar 2024 13:04:23 -0400
Message-ID: <20240313170435.616724-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
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
index ce17917b6f76f..fcf89ee5080f1 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2141,8 +2141,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
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


