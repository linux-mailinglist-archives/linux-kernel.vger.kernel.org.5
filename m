Return-Path: <linux-kernel+bounces-114132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 592888888A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DB021F28C53
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF44B24108A;
	Sun, 24 Mar 2024 23:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9aSDrcF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A9202BB6;
	Sun, 24 Mar 2024 23:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321442; cv=none; b=fugFT06HqNQgzUo1aoE8xKVzIWPnvKbM820ODi/bA/Z7aldIZgKblzLqMx/XMkrnmlqlQ0nl1dOOvkexJDuq6dJgS3mXY8PoTYyb2FRtbxvDPRhH3rpaLC5Ta9G0+Jmefc64wneXcK9yLM8KFcmhyv7vtuxeZtc68vTygRA1n08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321442; c=relaxed/simple;
	bh=diwww3yRGtKv8GCOYdOkOJ6EPrgpc01Gl8QRa7q3drY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qycd1wVk+8eECyts8fAGtyEvrDeIYsWDqpmF6+AvyWEdAQ9Uc1dedIu0ueA7b642Zwwqcyvf1bKdgLLqgzYaVInrJ3X4cFeRhYld06FoWLiVLSnibYIMhQnsj5Vd0dZbly2IUXaMOmOs2ZAZ7eqnfRey7z1kt2iEDi0h0/nWBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9aSDrcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4385FC433C7;
	Sun, 24 Mar 2024 23:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321441;
	bh=diwww3yRGtKv8GCOYdOkOJ6EPrgpc01Gl8QRa7q3drY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9aSDrcFd/6tOqyj1TkFjFKP5MWLgid49h5BHIpPPNaSsyDis30AbSjU0svQFX9Qt
	 oyfv55ZcJa1zlVRSUnWO3SgxB538G2jFvd6WtmW+y+3mjNF+CAqwXquZbCmRsGfpeb
	 qxKuXoNXqU84ra8WyEITIXQePgRunDbP/YZgFPoEyTEmmCF1kKrWy3fagWWAv9uWZb
	 fFI5w5DDv+A2GMHOxw8igkfgV90v569wemUY9LR6PAniHcIjd/tOnQmDTRb6dNBHkj
	 2C9hq2odPV8ajIX7f9dxq8cr7VDZ4Ig/P/wqkfDXR2fKVWefA99xAKJrBliL48aPQO
	 SUSIx+ptncdXQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wen Gong <quic_wgong@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 165/638] wifi: ath11k: change to move WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID
Date: Sun, 24 Mar 2024 18:53:22 -0400
Message-ID: <20240324230116.1348576-166-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit 413e20e82ee78f142cb5194fd317db514f012602 ]

Currently when connecting to an AP with 11AX-HE phy mode, host sends
WMI_VDEV_PARAM_SET_HEMU_MODE parameter to firmware after
WMI_PEER_ASSOC_CMDID command. This results in TXBF not working, because
firmware calculates TXBF values while handling WMI_PEER_ASSOC_CMDID,
however at that time WMI_VDEV_PARAM_SET_HEMU_MODE has not been sent yet.
See below log:

AP sends "VHT/HE/EHT NDP Announcement" to station, and station sends
"Action no Ack" of category code HE to AP, the "Nc Index" and
"Codebook Information" are wrong:

Issued action:
IEEE 802.11 Action No Ack, Flags: ........
IEEE 802.11 wireless LAN
    Fixed parameters
        Category code: HE (30)
        HE Action: HE Compressed Beamforming And CQI (0)
            Total length: 152
            HE MIMO Control: 0x0004008018
                .... .... .... .... .... .... .... .... .... .000 = Nc Index: 1 Column (0)
                .... .... .... .... .... .... .... ..0. .... .... = Codebook Information: 0

Change to send WMI_VDEV_PARAM_SET_HEMU_MODE before WMI_PEER_ASSOC_CMDID,
then firmware will calculate the TXBF values with valid parameters
instead of empty values. TXBF works well and throughput performance is
improved from 80 Mbps to 130 Mbps with this patch.

Good action after this patch:
IEEE 802.11 Action No Ack, Flags: ........
IEEE 802.11 wireless LAN
    Fixed parameters
        Category code: HE (30)
        HE Action: HE Compressed Beamforming And CQI (0)
            Total length: 409
            HE MIMO Control: 0x0004008219
                .... .... .... .... .... .... .... .... .... .001 = Nc Index: 2 Columns (1)
                .... .... .... .... .... .... .... ..1. .... .... = Codebook Information: 1

This change applies to all chipsets.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Fixes: 38dfe775d0ab ("wifi: ath11k: push MU-MIMO params from hostapd to hardware")
Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240131021832.17298-1-quic_bqiang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b328a0599818b..8880462549b7f 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -3025,7 +3025,14 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 
 	rcu_read_unlock();
 
+	if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
+		ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM\n",
+			    arvif->vdev_id, bss_conf->bssid);
+		return;
+	}
+
 	peer_arg.is_assoc = true;
+
 	ret = ath11k_wmi_send_peer_assoc_cmd(ar, &peer_arg);
 	if (ret) {
 		ath11k_warn(ar->ab, "failed to run peer assoc for %pM vdev %i: %d\n",
@@ -3048,12 +3055,6 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 		return;
 	}
 
-	if (!ath11k_mac_vif_recalc_sta_he_txbf(ar, vif, &he_cap)) {
-		ath11k_warn(ar->ab, "failed to recalc he txbf for vdev %i on bss %pM\n",
-			    arvif->vdev_id, bss_conf->bssid);
-		return;
-	}
-
 	WARN_ON(arvif->is_up);
 
 	arvif->aid = vif->cfg.aid;
-- 
2.43.0


