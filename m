Return-Path: <linux-kernel+bounces-102156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B9987AEE3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC5D1F27577
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F123976900;
	Wed, 13 Mar 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ap92/qfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E333768E0;
	Wed, 13 Mar 2024 17:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349373; cv=none; b=BycUUhxaghIjJUYRmMHT3v9SRIiRHFB3S5o1wCJ+JUhOWQSl3VHH4ZWEw80Ci9REs3r4LTmFdZiYPDPOoz/w207LlzG3RgRZcAvZzFRLgoAIJEVre50qQBntmIgw0eoV20F1HIxwhqs6REyQ9jj1rSr84BA2xYOgIaOb2Dmr5lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349373; c=relaxed/simple;
	bh=pFkNXq75aGO0DaHF7gFlIG78xlK6rzQ0KMOvTyjapYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFiCMDKMVUfxDuG+cpMlnBq90S/BbXCWRT0no2+KjRuRB3VU09mgLlaAoE+iu37FfW01HPPf+STsDermDGkCOTfyPygf8sekHcil+v8URQB/bNxs5GHweAMDNHW/jWfv/7bso7AACc2PPEqBXnCpPQUigw1dpao4y1cQtY8Ap84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ap92/qfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE3FC433A6;
	Wed, 13 Mar 2024 17:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349373;
	bh=pFkNXq75aGO0DaHF7gFlIG78xlK6rzQ0KMOvTyjapYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ap92/qfk0FqZIOtYRQ3RHrxFwQUYa0e8dMoVwXPwak6P8i+Lf3MrZP9FYjxjenhDG
	 xDAN+epdC2jYl1qXsV2nBDbhW9SzVGRqwOl9P4UMuRn+6hxIZdtJeX7jahOOLhGScm
	 uT3aZt3mjMbUot6YvRfWCdyYPOgFutQcxbNkjkdK84HQMlp55jGpzU1IYJtv4J/hJV
	 O4cxpVOYF2GkAfafk1WHFMOd8YHNof1lpp9I4o2D0bd/EAylo8K9jsmSKmeWS8cpGC
	 ZA1zUSSLR+yySVUth5XBKgFx9I76u0Ew4/5+xFUq8xqWc8sCUA/Id93/gg356mj8Dn
	 ElMnzU1OXuOMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Shachar Raindel <shacharr@microsoft.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 35/51] hv_netvsc: Make netvsc/VF binding check both MAC and serial number
Date: Wed, 13 Mar 2024 13:01:56 -0400
Message-ID: <20240313170212.616443-36-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 31301cd242076..5697fe709f687 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2153,8 +2153,17 @@ static struct net_device *get_netvsc_byslot(const struct net_device *vf_netdev)
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


