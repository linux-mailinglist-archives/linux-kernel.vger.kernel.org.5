Return-Path: <linux-kernel+bounces-145160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB9158A5042
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BDDC1F2154C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C9513280B;
	Mon, 15 Apr 2024 12:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJcAOVcv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F255D131E4B;
	Mon, 15 Apr 2024 12:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185458; cv=none; b=a2CePbm8oeZ8QHv0x7XgJYQ1rh23WKVUkMZxG2fD0EeUNB12pXPGKZzCIkgjFCepFFQHd9Rkb9VVArV5epqmk9WbUF7a98SZgf5C5j1XxF5EP1hBmdDOZPJaeo4Ae9eOcEkC1EBhuphMspQKHnTSxlZLYQZoYiJlDaKiejvA/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185458; c=relaxed/simple;
	bh=NFimtcqCHBH47CAO89mvCrvOX5tCHhZmL+296Wno5Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qBcbeb1nSy+AN2uxewe9owUeI/PEqDDp55yhkvBL/G7DgZdVHAVvrVprhY73OGbjDPtosJiEv88yd/y16XXLXqn7EJSE/e7wGDODkvmeiswUN2nf++2pYL7qGlhRbt4NygEDgLdjB+eX7d345TCjpflEqdxp6b3e1+ZkhMzucgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJcAOVcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F766C113CC;
	Mon, 15 Apr 2024 12:50:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185457;
	bh=NFimtcqCHBH47CAO89mvCrvOX5tCHhZmL+296Wno5Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fJcAOVcvL6Q9fcJM0OlII4wmhHIJoFtvo9kyRXBVF6HunCpuomu22s/J8Sxf+GZff
	 fvVORrz600vA3nQ0e31o7xZuomVCZDRQStdkaLyM9EpqcFPeATeZRb/cAqm41BEZnZ
	 EXG0v6IPFQwthh2LgwvS7Ht0DkadsaoFAwuPTmvZjtBGiTu2uCivASt8O3wZVrNtJ4
	 w0v3ZYV8S+us+7l8bvrMKIUx8y8sTMgeday7qQq+WfO6kaAIH8vYTC6cUgD5qi8nNg
	 tvmxrpHqmsEVQtjfza+0RQkyreL2V3ooafAQ2cXt5AhlmsBsQ+8G0o0y1tefXPhL3W
	 gASHiL+eE+Z/g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Phil Elwell <phil@raspberrypi.com>,
	Maarten Vanraes <maarten@rmail.be>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	opendmb@gmail.com,
	florian.fainelli@broadcom.com,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 2/4] net: bcmgenet: Reset RBUF on first open
Date: Mon, 15 Apr 2024 06:04:55 -0400
Message-ID: <20240415100459.3127671-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100459.3127671-1-sashal@kernel.org>
References: <20240415100459.3127671-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.215
Content-Transfer-Encoding: 8bit

From: Phil Elwell <phil@raspberrypi.com>

[ Upstream commit 0a6380cb4c6b5c1d6dad226ba3130f9090f0ccea ]

If the RBUF logic is not reset when the kernel starts then there
may be some data left over from any network boot loader. If the
64-byte packet headers are enabled then this can be fatal.

Extend bcmgenet_dma_disable to do perform the reset, but not when
called from bcmgenet_resume in order to preserve a wake packet.

N.B. This different handling of resume is just based on a hunch -
why else wouldn't one reset the RBUF as well as the TBUF? If this
isn't the case then it's easy to change the patch to make the RBUF
reset unconditional.

See: https://github.com/raspberrypi/linux/issues/3850
See: https://github.com/raspberrypi/firmware/issues/1882

Signed-off-by: Phil Elwell <phil@raspberrypi.com>
Signed-off-by: Maarten Vanraes <maarten@rmail.be>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/broadcom/genet/bcmgenet.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
index ed0589a1a00d8..b2309d2fbc2df 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
@@ -3252,7 +3252,7 @@ static void bcmgenet_get_hw_addr(struct bcmgenet_priv *priv,
 }
 
 /* Returns a reusable dma control register value */
-static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
+static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv, bool flush_rx)
 {
 	unsigned int i;
 	u32 reg;
@@ -3277,6 +3277,14 @@ static u32 bcmgenet_dma_disable(struct bcmgenet_priv *priv)
 	udelay(10);
 	bcmgenet_umac_writel(priv, 0, UMAC_TX_FLUSH);
 
+	if (flush_rx) {
+		reg = bcmgenet_rbuf_ctrl_get(priv);
+		bcmgenet_rbuf_ctrl_set(priv, reg | BIT(0));
+		udelay(10);
+		bcmgenet_rbuf_ctrl_set(priv, reg);
+		udelay(10);
+	}
+
 	return dma_ctrl;
 }
 
@@ -3340,8 +3348,8 @@ static int bcmgenet_open(struct net_device *dev)
 
 	bcmgenet_set_hw_addr(priv, dev->dev_addr);
 
-	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	/* Disable RX/TX DMA and flush TX and RX queues */
+	dma_ctrl = bcmgenet_dma_disable(priv, true);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
@@ -4199,7 +4207,7 @@ static int bcmgenet_resume(struct device *d)
 			bcmgenet_hfb_create_rxnfc_filter(priv, rule);
 
 	/* Disable RX/TX DMA and flush TX queues */
-	dma_ctrl = bcmgenet_dma_disable(priv);
+	dma_ctrl = bcmgenet_dma_disable(priv, false);
 
 	/* Reinitialize TDMA and RDMA and SW housekeeping */
 	ret = bcmgenet_init_dma(priv);
-- 
2.43.0


