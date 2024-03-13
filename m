Return-Path: <linux-kernel+bounces-101752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05C887AB48
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB82728A1A4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2D5B5DD;
	Wed, 13 Mar 2024 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qbSFt1RR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3595D5A7BB;
	Wed, 13 Mar 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347575; cv=none; b=f7PhkJV/NWtt5ni/P4wVMmOBMN/l6qKyVrmbLtsa0txjdfqf2wZyJ9X71qKghY9mBcdR4kGL7T9VD+YfrWETcr+YVEk/S0G7eERGKzlANK0WSBA3B2LBkCrcyocvH/1ngroErmt+hkh58urKrb0tUefwE8jGOSyqrPC1YKeSxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347575; c=relaxed/simple;
	bh=3byDPYlkwxVV+C00ILl4INWk3sLQb2R+fROVXIniFyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QFT0hMMCzmOP0hux6tCALpgz7QjHHPkvrwqXVamXkms+BxN7GB5bZM56BJ9b1572F0ebEgmLQ5fNcJ4AMuXfUda6z3o0S3dX4mZydl53GfdiRN4jxWk+CLAeYYZB95sl60c1i2QobLUTS3fzkwjHyzn6A0rh8Hzn3NHGculrbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qbSFt1RR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F95C43394;
	Wed, 13 Mar 2024 16:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347574;
	bh=3byDPYlkwxVV+C00ILl4INWk3sLQb2R+fROVXIniFyk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qbSFt1RR7UjDQPWRVJpeqrT+x/QeAW0KmX4UOHaWQdqxkfWTc/3fmKsttDh41kdnQ
	 JdqwxNNM3SzPGDoovm8dXHVq2bsFPLrr5awgjW7nabboNAmyObC7vI6H4shcTnNYlt
	 2Dgb1zeoTCWET75Z3GqtMfNEvBN70csB/KQjIBPKct5x1Ceu9ay25U1KnlOo83oSqd
	 v7nstUQD35PKrh0WF74HtoEyu/3ZZYj3avCB18VVLruYEO7IpOlnK6Lp7QJikNDyM1
	 7Nn70JUE3iuOqQ2ImrQsPxwGPOmrJ2f1vJLH+XkXz6QCxOEvcU7Ow6VLVRO1WRp77g
	 f6vJgCXqVVg+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 13/61] ice: reorder disabling IRQ and NAPI in ice_qp_dis
Date: Wed, 13 Mar 2024 12:31:48 -0400
Message-ID: <20240313163236.613880-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index f3663b3f6390e..0fd5551b108ce 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -179,6 +179,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
 			return -EBUSY;
 		usleep_range(1000, 2000);
 	}
+
+	ice_qvec_dis_irq(vsi, rx_ring, q_vector);
+	ice_qvec_toggle_napi(vsi, q_vector, false);
+
 	netif_tx_stop_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
 
 	ice_fill_txq_meta(vsi, tx_ring, &txq_meta);
@@ -195,13 +199,10 @@ static int ice_qp_dis(struct ice_vsi *vsi, u16 q_idx)
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
 
@@ -259,11 +260,11 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 	if (err)
 		return err;
 
-	clear_bit(ICE_CFG_BUSY, vsi->state);
 	ice_qvec_toggle_napi(vsi, q_vector, true);
 	ice_qvec_ena_irq(vsi, q_vector);
 
 	netif_tx_start_queue(netdev_get_tx_queue(vsi->netdev, q_idx));
+	clear_bit(ICE_CFG_BUSY, vsi->state);
 
 	return 0;
 }
-- 
2.43.0


