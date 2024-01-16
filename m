Return-Path: <linux-kernel+bounces-28180-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0EC82FB3B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:51:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88A3A1C265C1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAAE016277C;
	Tue, 16 Jan 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQ2QXEaS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03205162769;
	Tue, 16 Jan 2024 20:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435359; cv=none; b=ib1IeR8rlU7bMveAIMK5jSz3LhqTYRYNpNeIxwNXjHu+I7yrng9oRcUnzWXRTHeX3rBnyS45QbJQkIWoveQ5uUDJM8BUwbz+3n6PxFu8/zKQVFCQ9zjdFLNbb4ZGy6pytFqnHeZQfYzLuXF92P+gzwzDvNS730iXP4D1Po6hYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435359; c=relaxed/simple;
	bh=gJKiIBBbDy53AjLvncnJKbuQ+GetRLTkRmFZqpRLLdY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HqMTG2t0FC9l7mrpxg1cQ6xZU4ZifDyAL2kiKom1Oek0Lb0+2Bb7csfzoSrqHOKTtIkV7rRSyGipl1a46ptQSSEby/YmhgzgRdASfFofZ/Scf4Ve0TrSkpkOptcmykNjBYTPfdnGnYify4cVtNqpIk3Cosw2DgkFf1wxPUTCffY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQ2QXEaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35AAC433C7;
	Tue, 16 Jan 2024 20:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435358;
	bh=gJKiIBBbDy53AjLvncnJKbuQ+GetRLTkRmFZqpRLLdY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pQ2QXEaSm1qsOFRzziFk+eI9icNbTH0w2xlJbpnLCVUwlPo7kWq59hZUG9yi+Gjhu
	 0AsBJsMC9Wx/lRDzGys3CWJSfrc2MCo0AezH25XlncT8mSlPnB+KoGTX0T5F+PUit8
	 EALPff/eJQcv1w/mRppUOZHNCJeBhiRxGHUeclj8CH8aTuuXUpMy8l3goHAebevBWq
	 0VHHVYWur+bzP4fjqmZSoYSjvFWsOYoPIU7kh6temPsmOVwP5KK6H0YTKGz6V02hnu
	 4XzFPzoWZUSJ7Q1AvW3yaEO4ecHTIHh7FeixZ3uVQlb2axq5B0ltQZJHb82AoOCzje
	 UxPQNkd2A8yQw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andrii Staikov <andrii.staikov@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	jesse.brandeburg@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 44/44] i40e: Fix VF disable behavior to block all traffic
Date: Tue, 16 Jan 2024 15:00:13 -0500
Message-ID: <20240116200044.258335-44-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Andrii Staikov <andrii.staikov@intel.com>

[ Upstream commit 31deb12e85c35ddd2c037f0107d05d8674cab2c0 ]

Currently, if a VF is disabled using the
'ip link set dev $ETHX vf $VF_NUM state disable' command, the VF is still
able to receive traffic.

Fix the behavior of the 'ip link set dev $ETHX vf $VF_NUM state disable'
to completely shutdown the VF's queues making it entirely disabled and
not able to receive or send any traffic.

Modify the behavior of the 'ip link set $ETHX vf $VF_NUM state enable'
command to make a VF do reinitialization bringing the queues back up.

Co-developed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Andrii Staikov <andrii.staikov@intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 32 +++++++++++++++++++
 .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |  1 +
 2 files changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index dfaa34f2473a..91892d07124f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -2519,6 +2519,14 @@ static int i40e_vc_enable_queues_msg(struct i40e_vf *vf, u8 *msg)
 	i40e_status aq_ret = 0;
 	int i;
 
+	if (vf->is_disabled_from_host) {
+		aq_ret = -EPERM;
+		dev_info(&pf->pdev->dev,
+			 "Admin has disabled VF %d, will not enable queues\n",
+			 vf->vf_id);
+		goto error_param;
+	}
+
 	if (!test_bit(I40E_VF_STATE_ACTIVE, &vf->vf_states)) {
 		aq_ret = I40E_ERR_PARAM;
 		goto error_param;
@@ -4561,9 +4569,12 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	struct i40e_pf *pf = np->vsi->back;
 	struct virtchnl_pf_event pfe;
 	struct i40e_hw *hw = &pf->hw;
+	struct i40e_vsi *vsi;
+	unsigned long q_map;
 	struct i40e_vf *vf;
 	int abs_vf_id;
 	int ret = 0;
+	int tmp;
 
 	if (test_and_set_bit(__I40E_VIRTCHNL_OP_PENDING, pf->state)) {
 		dev_warn(&pf->pdev->dev, "Unable to configure VFs, other operation is pending.\n");
@@ -4586,6 +4597,9 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	switch (link) {
 	case IFLA_VF_LINK_STATE_AUTO:
 		vf->link_forced = false;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		pfe.event_data.link_event.link_status =
 			pf->hw.phy.link_info.link_info & I40E_AQ_LINK_UP;
 		pfe.event_data.link_event.link_speed =
@@ -4595,6 +4609,9 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 	case IFLA_VF_LINK_STATE_ENABLE:
 		vf->link_forced = true;
 		vf->link_up = true;
+		vf->is_disabled_from_host = false;
+		/* reset needed to reinit VF resources */
+		i40e_vc_reset_vf(vf, true);
 		pfe.event_data.link_event.link_status = true;
 		pfe.event_data.link_event.link_speed = VIRTCHNL_LINK_SPEED_40GB;
 		break;
@@ -4603,6 +4620,21 @@ int i40e_ndo_set_vf_link_state(struct net_device *netdev, int vf_id, int link)
 		vf->link_up = false;
 		pfe.event_data.link_event.link_status = false;
 		pfe.event_data.link_event.link_speed = 0;
+
+		vsi = pf->vsi[vf->lan_vsi_idx];
+		q_map = BIT(vsi->num_queue_pairs) - 1;
+
+		vf->is_disabled_from_host = true;
+
+		/* Try to stop both Tx&Rx rings even if one of the calls fails
+		 * to ensure we stop the rings even in case of errors.
+		 * If any of them returns with an error then the first
+		 * error that occurred will be returned.
+		 */
+		tmp = i40e_ctrl_vf_tx_rings(vsi, q_map, false);
+		ret = i40e_ctrl_vf_rx_rings(vsi, q_map, false);
+
+		ret = tmp ? tmp : ret;
 		break;
 	default:
 		ret = -EINVAL;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
index 358bbdb58795..010e5730465e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.h
@@ -98,6 +98,7 @@ struct i40e_vf {
 	bool link_forced;
 	bool link_up;		/* only valid if VF link is forced */
 	bool spoofchk;
+	bool is_disabled_from_host; /* PF ctrl of VF enable/disable */
 	u16 num_vlan;
 
 	/* ADq related variables */
-- 
2.43.0


