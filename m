Return-Path: <linux-kernel+bounces-101873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B6687AC54
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9899EB20C4C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F29A76C80;
	Wed, 13 Mar 2024 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tN43wBN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9E860DDD;
	Wed, 13 Mar 2024 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348006; cv=none; b=SYsjSZmQEfihmfePhuyLar7eljFTJsJleb8gYsMKdmKCNek85r+5a33gmXtLj0y1JGDWJ4Aju8MNEcq2GaerToTI3qw9hDlM7reMEzAq1NWdco2m1yT+kbLzYlOpFgU8YdIS/xcrXqRuz2cceRO5pOMarQC5RFXDSM7N83JVKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348006; c=relaxed/simple;
	bh=uiTw9ZYb71+WIC8/hPNZwLU1xBnR/3QhxDYiuhbbj2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpMGfEVxgaQObhamtZH/noDrDZJX/uGDWcx8ivj68rn2N+0Z4QRYeEpIs1QWcSxSJu/yPUs2WZfnyLHsHwlLOVeiyXRP2x0o4aWs6P8/M07AYhDajB9VZnv2nlfQQSrPy1SKrYAWYlkPBw9eJWEkQujqT/4p8AvsdelnBARBYAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tN43wBN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC995C43390;
	Wed, 13 Mar 2024 16:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348006;
	bh=uiTw9ZYb71+WIC8/hPNZwLU1xBnR/3QhxDYiuhbbj2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tN43wBN2Z1XKooubyzBvFNaIW+pZgAUQs1BTpSL+DL7QTu8IIcvPnRWCcScL0PPrQ
	 YiND2hKpfJ8gxME2so5Ns1R/EN2lHzTn29oDdmyzlLBlyr+sNjlJEzfoZbMt33b2Zb
	 pobZWSGdsRB6SEoHItQpwMuMgNopLLt6vS25JDVQfm2MvmouHVrTCM3JMbYfJe/Dsu
	 n2eoLHnRnsk9jQ1TU39Kvz0aOyCu/XIqyVfT7uMgSGwc4AcZz0Gx/wUDOpb/a4Uc4T
	 k6cyZsbvmKeP+U6WJNHliZA27yUM2hxfpgCA518CGBqSLJJSv1inegPriwTe2sj4+n
	 EIxdInWtfL9rA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 05/71] ice: reorder disabling IRQ and NAPI in ice_qp_dis
Date: Wed, 13 Mar 2024 12:38:51 -0400
Message-ID: <20240313163957.615276-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit 99099c6bc75a30b76bb5d6774a0509ab6f06af05 ]

ice_qp_dis() currently does things in very mixed way. Tx is stopped
before disabling IRQ on related queue vector, then it takes care of
disabling Rx and finally NAPI is disabled.

Let us start with disabling IRQs in the first place followed by turning
off NAPI. Then it is safe to handle queues.

One subtle change on top of that is that even though ice_qp_ena() looks
more sane, clear ICE_CFG_BUSY as the last thing there.

Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_xsk.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 41ee081eb8875..48cf24709fe32 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -171,6 +171,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
@@ -187,13 +191,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 		if (err)
 			return err;
 	}
-	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
-
 	err = ice_vsi_ctrl_one_rx_ring(vsi, false, q_idx, true);
 	if (err)
 		return err;
 
-	ice_qvec_toggle_napi(vsi, q_vector, false);
 	ice_qp_clean_rings(vsi, q_idx);
 	ice_qp_reset_stats(vsi, q_idx);
 
@@ -256,11 +257,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		goto free_buf;
 
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	clear_bit(ICE_CFG_BUSY, vsi->state);
 free_buf:
 	kfree(qg_buf);
 	return err;
-- 
2.43.0


