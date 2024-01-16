Return-Path: <linux-kernel+bounces-27810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DEBD82F63B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3F0EB23428
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC352C846;
	Tue, 16 Jan 2024 19:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUnzjKmG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BE42C6B1;
	Tue, 16 Jan 2024 19:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434245; cv=none; b=JBZ5arT2MGHpFTHbbc4VTf00fHrhD4+blHaLLehRngEO4KIkpZe0X65+5vL7xI8cHHKgcA4bXupattR2PuHJ6VS0WY8libk8Wtq2/cxeq9tCjA6bSQfEm77S15jBysEpRyDTNuZpAuCJS+p9pZ9T0li8xEbuRmloVQJpFcICmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434245; c=relaxed/simple;
	bh=tb2mrvvH3u8Z9i2F+DENmnetOKkp98gyTkDoeWMA9J0=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=EGRnOj3tsPMPdrJnbUdWsJwIqJZh2wIyalRRO5cER1qxTKFRP+26ig3qAEOimtQGA4cSct0oh3kYxVWDl4wtM1+I/ocLbGaofQHZRb0lbSsO/s+mlbwlLxbEi+K8hMQLaEu550dfrEzgDdweZXzR3sm0tSVdWlOcfVaS3rF20bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUnzjKmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91248C433C7;
	Tue, 16 Jan 2024 19:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434244;
	bh=tb2mrvvH3u8Z9i2F+DENmnetOKkp98gyTkDoeWMA9J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUnzjKmGX5dCwsPvcx27j5uUrMdWInNCKw6+m5IwPDY96eYZ1EfZ2Td8mykdE/e0T
	 6rvH6+ByeZDcMeuKMR0iyuuXzq3CMGmrIb5okufykqMomRoMlSL0vXVg5mMjFWyW3W
	 mn0sKNwg6p7adtCJZw0b/uxhWrniRpuXfsX2BYgh1v/7/jsoeQqy4139dDctwYeJkg
	 wmdN8w6LurBtrWp2HxxGcp8k+eUHhYyjTAHGCvrGVClNoYBQ4U9VPL3SVUpLg3dpgE
	 KWQJqbRjVShV5z51iHXhWgFc5tmURdyXFFWZkzfCVdQfl9zVLCKk+JzUOsvJDhVpTr
	 BBG6K5LulNsHg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kang Yang <quic_kangyang@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	ath12k@lists.infradead.org,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 040/108] wifi: ath12k: fix and enable AP mode for WCN7850
Date: Tue, 16 Jan 2024 14:39:06 -0500
Message-ID: <20240116194225.250921-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Kang Yang <quic_kangyang@quicinc.com>

[ Upstream commit ed7e818a7b501012038d6bc6fedadaf7375a380a ]

For AP mode, the peer is created earlier in ath12k_mac_op_add_interface() but
ath12k_mac_op_assign_vif_chanctx() will try to create peer again.  Then an
error will return which makes AP mode startup fail.

Kernel log:

[ 5017.665006] ath12k_pci 0000:04:00.0: failed to create peer after vdev start delay: -22

wpa_supplicant log:

Failed to set beacon parameters
Interface initialization failed
wls1: interface state UNINITIALIZED->DISABLED
wls1: AP-DISABLED
wls1: Unable to setup interface.
Failed to initialize AP interface
wls1: interface state DISABLED->DISABLED
wls1: AP-DISABLED

So fix this check and enable AP mode for WCN7850, as now AP mode works normally.

Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4

Signed-off-by: Kang Yang <quic_kangyang@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://lore.kernel.org/r/20231121022459.17209-1-quic_kangyang@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/hw.c  | 3 ++-
 drivers/net/wireless/ath/ath12k/mac.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/hw.c b/drivers/net/wireless/ath/ath12k/hw.c
index 2245fb510ba2..b55cf33e37bd 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -949,7 +949,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 
-		.interface_modes = BIT(NL80211_IFTYPE_STATION),
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
 
 		.idle_ps = true,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index fc0d14ea328e..b698e55a5b7b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6380,8 +6380,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
 	}
 
 	if (ab->hw_params->vdev_start_delay &&
-	    (arvif->vdev_type == WMI_VDEV_TYPE_AP ||
-	    arvif->vdev_type == WMI_VDEV_TYPE_MONITOR)) {
+	    arvif->vdev_type != WMI_VDEV_TYPE_AP &&
+	    arvif->vdev_type != WMI_VDEV_TYPE_MONITOR) {
 		param.vdev_id = arvif->vdev_id;
 		param.peer_type = WMI_PEER_TYPE_DEFAULT;
 		param.peer_addr = ar->mac_addr;
-- 
2.43.0


