Return-Path: <linux-kernel+bounces-27947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB2782F830
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB3F3B25F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EDD574AF;
	Tue, 16 Jan 2024 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdUZBdD6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D305557499;
	Tue, 16 Jan 2024 19:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434638; cv=none; b=hp5dHZeukafFZsfHhhZEpIf2gOPxhNZv5xrehj9HitPKmvIxU9/Jn0fs8Ajq81SWiutJikUCwW+oM4L5HcyNGw5hsy8/xPLw4HzHFuccHCvhj6xRCHeCU6iOrkpZOsQRVuciVlQK7Ri4k3ZQMEeuL/Ik5lTp6OQY3I/Eldn84qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434638; c=relaxed/simple;
	bh=4L2Yg17nT3lf/kfB50S/iKIEs1fFgB85bWpYDUqTJls=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Mr03HSNfaBZfzrL2o2k4kdqSF6ToN7bz6yLtTku9cCM6CdcMXptIGBkQ2maBG85pHDwTMRLV6/AioKMfEVikMtBM9h7bWmmI/kGPFz6zA1HIa1phl+evcfoRZhFzFMIIsMjxxsurffXs7tkv65by3zX0F6+yohxhjaVUjCxGfiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdUZBdD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5CBC433C7;
	Tue, 16 Jan 2024 19:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434638;
	bh=4L2Yg17nT3lf/kfB50S/iKIEs1fFgB85bWpYDUqTJls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UdUZBdD67hr3jwwdgUB/5vscJB/LHWVAFlEgsnfdDkxt59CHvXF9x+eSaQ3XHAnnm
	 fo1Awug+pVsh7liOWB7eHbT+XtaSy4kEju7Up6KQudwRiHuZcp9KwqFYqGHTgpUgYY
	 GzP5VGARVRFli57H2JMdPuVtyqx9JlQ/z7VKEYQrKBoyhAarqdx7LzRRMh+gLT0eHi
	 6GsG2B/gusa1OQLnE2i9LvDK46Wlg1pTIVlfsqtxQhwOPwfMRGQhd4HZ0zNhH823X+
	 iFb5ce3qkV6WIZrYTpXaC4RkwRik41JUAg8iqK7AB8aEyk9p3ficEb2ALW7eQYTEzJ
	 u0cq5wOmsMztA==
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
Subject: [PATCH AUTOSEL 6.6 039/104] wifi: ath12k: fix and enable AP mode for WCN7850
Date: Tue, 16 Jan 2024 14:46:05 -0500
Message-ID: <20240116194908.253437-39-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index 5991cc91cd00..c1dcdd849f9d 100644
--- a/drivers/net/wireless/ath/ath12k/hw.c
+++ b/drivers/net/wireless/ath/ath12k/hw.c
@@ -942,7 +942,8 @@ static const struct ath12k_hw_params ath12k_hw_params[] = {
 		.rx_mac_buf_ring = true,
 		.vdev_start_delay = true,
 
-		.interface_modes = BIT(NL80211_IFTYPE_STATION),
+		.interface_modes = BIT(NL80211_IFTYPE_STATION) |
+				   BIT(NL80211_IFTYPE_AP),
 		.supports_monitor = false,
 
 		.idle_ps = true,
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 88346e66bb75..5434883eaf96 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -6196,8 +6196,8 @@ ath12k_mac_op_assign_vif_chanctx(struct ieee80211_hw *hw,
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


