Return-Path: <linux-kernel+bounces-101944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CFC787ACF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A2B81C20DE7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDEE8629FA;
	Wed, 13 Mar 2024 16:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6LMPOsB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1ED6280A;
	Wed, 13 Mar 2024 16:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348152; cv=none; b=UjJb0BtmqKIA8IyIXB8KKef3TGwBeBvHfsRZ9s4Yp7pKof4dtRzwyYpGQl56gBVe3qOHELws4V08Ar4/mv3KUG0G4YyOtQGKHTuf7WtpDdTZmTZL66egKY9wd1hcDy6gEkYv0EMWRIfu8mGHFELEnAXDcWILyV73Jhtgowsn+bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348152; c=relaxed/simple;
	bh=tDLapTrYVVfBn92f5DQJ5rKP0LhQm5cgNKUSlLYd3iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmLxpNpCqEisPqEqlTcsm+cFK4vs0CaRzku7X7Vr2w7YakB/SEoPjbx8K/JikKgp/bY0KCOkZBSlBKYUtWESsuX3GloT5pvkM0J7CBGJS0spyTbL/kKM+osDJdD6w6ONDF3aRiKAw6CYOic9ezUY6q4yVyO8gPRyBKkyHhpOUjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6LMPOsB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C842C43390;
	Wed, 13 Mar 2024 16:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348151;
	bh=tDLapTrYVVfBn92f5DQJ5rKP0LhQm5cgNKUSlLYd3iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r6LMPOsBJ+qptjWCiw5gNr5XtEz3QSKAKMP//cjFh+DIO0iMscGtYHIsXkKk9zkpg
	 +kZiFbzLD6/KWqfkeio8sDP17WvMEtytcvaZwI7BIca/GOsDxrlocdkSOlYPaFhSOf
	 fdC5JhD5sWM3t7gH7d477T/WPd1PdVh8/JfbU5GNJjpw/Cy4NBBdAiXXP3RLIPunAP
	 piShabUAyc5HzTsa7c+8AyvThpSgFXiDzelp1G/3nF9gQkyLs8z3eKii/Bks/prDX9
	 5KuRvNcpT03SmrWTb6y0+hKn0O+4+0Kz+tRqeCh6ZpierBB9+wfiLE5YfHs/F+DVrK
	 8XSrsOKDovOXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Pavel Vazharov <pavel@x3me.net>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 04/76] ixgbe: {dis, en}able irqs in ixgbe_txrx_ring_{dis, en}able
Date: Wed, 13 Mar 2024 12:41:11 -0400
Message-ID: <20240313164223.615640-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit cbf996f52c4e658b3fb4349a869a62fd2d4c3c1c ]

Currently routines that are supposed to toggle state of ring pair do not
take care of associated interrupt with queue vector that these rings
belong to. This causes funky issues such as dead interface due to irq
misconfiguration, as per Pavel's report from Closes: tag.

Add a function responsible for disabling single IRQ in EIMC register and
call this as a very first thing when disabling ring pair during xsk_pool
setup. For enable let's reuse ixgbe_irq_enable_queues(). Besides this,
disable/enable NAPI as first/last thing when dealing with closing or
opening ring pair that xsk_pool is being configured on.

Reported-by: Pavel Vazharov <pavel@x3me.net>
Closes: https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com/
Fixes: 024aa5800f32 ("ixgbe: added Rx/Tx ring disable/enable functions")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
 1 file changed, 49 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index cb9e9d70b338c..d7eabc526f782 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2941,8 +2941,8 @@ static void ixgbe_check_lsc(struct ixgbe_adapter *adapter)
 static inline void ixgbe_irq_enable_queues(struct ixgbe_adapter *adapter,
 					   u64 qmask)
 {
-	u32 mask;
 	struct ixgbe_hw *hw = &adapter->hw;
+	u32 mask;
 
 	switch (hw->mac.type) {
 	case ixgbe_mac_82598EB:
@@ -10380,6 +10380,44 @@ static void ixgbe_reset_rxr_stats(struct ixgbe_ring *rx_ring)
 	memset(&rx_ring->rx_stats, 0, sizeof(rx_ring->rx_stats));
 }
 
+/**
+ * ixgbe_irq_disable_single - Disable single IRQ vector
+ * @adapter: adapter structure
+ * @ring: ring index
+ **/
+static void ixgbe_irq_disable_single(struct ixgbe_adapter *adapter, u32 ring)
+{
+	struct ixgbe_hw *hw = &adapter->hw;
+	u64 qmask = BIT_ULL(ring);
+	u32 mask;
+
+	switch (adapter->hw.mac.type) {
+	case ixgbe_mac_82598EB:
+		mask = qmask & IXGBE_EIMC_RTX_QUEUE;
+		IXGBE_WRITE_REG(&adapter->hw, IXGBE_EIMC, mask);
+		break;
+	case ixgbe_mac_82599EB:
+	case ixgbe_mac_X540:
+	case ixgbe_mac_X550:
+	case ixgbe_mac_X550EM_x:
+	case ixgbe_mac_x550em_a:
+		mask = (qmask & 0xFFFFFFFF);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(0), mask);
+		mask = (qmask >> 32);
+		if (mask)
+			IXGBE_WRITE_REG(hw, IXGBE_EIMS_EX(1), mask);
+		break;
+	default:
+		break;
+	}
+	IXGBE_WRITE_FLUSH(&adapter->hw);
+	if (adapter->flags & IXGBE_FLAG_MSIX_ENABLED)
+		synchronize_irq(adapter->msix_entries[ring].vector);
+	else
+		synchronize_irq(adapter->pdev->irq);
+}
+
 /**
  * ixgbe_txrx_ring_disable - Disable Rx/Tx/XDP Tx rings
  * @adapter: adapter structure
@@ -10396,6 +10434,11 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
+	ixgbe_irq_disable_single(adapter, ring);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_disable(&rx_ring->q_vector->napi);
+
 	ixgbe_disable_txr(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_disable_txr(adapter, xdp_ring);
@@ -10404,9 +10447,6 @@ void ixgbe_txrx_ring_disable(struct ixgbe_adapter *adapter, int ring)
 	if (xdp_ring)
 		synchronize_rcu();
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_disable(&rx_ring->q_vector->napi);
-
 	ixgbe_clean_tx_ring(tx_ring);
 	if (xdp_ring)
 		ixgbe_clean_tx_ring(xdp_ring);
@@ -10434,9 +10474,6 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	tx_ring = adapter->tx_ring[ring];
 	xdp_ring = adapter->xdp_ring[ring];
 
-	/* Rx/Tx/XDP Tx share the same napi context. */
-	napi_enable(&rx_ring->q_vector->napi);
-
 	ixgbe_configure_tx_ring(adapter, tx_ring);
 	if (xdp_ring)
 		ixgbe_configure_tx_ring(adapter, xdp_ring);
@@ -10445,6 +10482,11 @@ void ixgbe_txrx_ring_enable(struct ixgbe_adapter *adapter, int ring)
 	clear_bit(__IXGBE_TX_DISABLED, &tx_ring->state);
 	if (xdp_ring)
 		clear_bit(__IXGBE_TX_DISABLED, &xdp_ring->state);
+
+	/* Rx/Tx/XDP Tx share the same napi context. */
+	napi_enable(&rx_ring->q_vector->napi);
+	ixgbe_irq_enable_queues(adapter, BIT_ULL(ring));
+	IXGBE_WRITE_FLUSH(&adapter->hw);
 }
 
 /**
-- 
2.43.0


