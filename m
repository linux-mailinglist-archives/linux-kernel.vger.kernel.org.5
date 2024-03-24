Return-Path: <linux-kernel+bounces-115417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CAC88A290
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B418CB25771
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14427206CA5;
	Mon, 25 Mar 2024 02:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X7pa3we+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80182D8B;
	Sun, 24 Mar 2024 22:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320597; cv=none; b=ACAx2E5wMTdWBRmU0/ikxIwp4xNy/Sg1CZjdwCIfhUH8Y3np/2lIHcsy4xVcu6YJA38yOuJZjvBltPXkQCC+H0VO0BeFoYBIMQ7ZV221I3Ximh6Q43QHIV1KKEkpNOLfiRbsHUS7BAbhRQ2hNz8RiRbEtePEVnLvtlQ8TSgsrjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320597; c=relaxed/simple;
	bh=dXhu3Gxj9j/STkTusaqz4bh9YSL4l8LOfPOtBesofQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFNrluHlEnaHvwF1TmF/B/IfgXWMRkf/xCzFNFp23NZgfjgj9PIXZ7cTZioXROCER5dQx6EHxyrzQJgvR/VforgDdNQuM31w8+zUxNSxtxdnt40wVoeyESRo/Rn+CuuaOna90iplDh00VgYhQwscxLp+/QEOXZcg/XjZ43KXkfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X7pa3we+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E8FC433A6;
	Sun, 24 Mar 2024 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320597;
	bh=dXhu3Gxj9j/STkTusaqz4bh9YSL4l8LOfPOtBesofQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X7pa3we+AXGlM23N7t/7HOIxiVJjXiwFRn3llMPs3yB0GY2NaDv24A+onNe7m5QBf
	 NPnTgTDoL3SrDXUEqq1ZBx1foich/0b4s8b377MjB8CYzUm3UtPJfeGcIraa8DrXlS
	 25YqX+wvudmJOJwXF2pym0PpW3JSJzr8D6cZgpK1fhmVSs65nxR4pMX5C3LLjJdxIM
	 aAmv+yi5n4XSQQzC2lkHxp2AZsOm4eEnaS/+GOfqmKb2yroizfNOto1rXJXTcoV7jF
	 rOWoJnuytCl9VUffgwgUf2fFXhXmbwPMynXFWu0JiBNQtgOw0KVVXNi36wduaMXrgf
	 cYUg1N1CdkA5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 158/713] wifi: ath12k: Fix issues in channel list update
Date: Sun, 24 Mar 2024 18:38:04 -0400
Message-ID: <20240324224720.1345309-159-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Sriram R <quic_srirrama@quicinc.com>

[ Upstream commit 67a48d937fac917947540c9f89630d472cd61fcb ]

Currently, the logic used to select the 6 GHz band is incorrect,
which may cause 6 GHz supported channels to not be updated properly.
This is because the 6 GHz Max frequency supported by the driver is
being compared to the Max frequency supported on the board. If in
some cases, the 6 GHz Max frequency supported on the board is less
than the defined 6 GHz Max frequency, all 6 GHz channels are disabled.
To address this, compare the max frequency supported by the board to
the defined 6 GHz Minimum frequency by the driver.

Similarly, when a dual mac card supports both 6 GHz and 5 GHz radios,
if the 5 GHz radio gets enumerated first before 6 GHz, the checks in
ath12k_mac_setup_channels_rates() can cause the 5 GHz channels which
were enabled earlier to get disabled when the 6 GHz channel list is
updated. This is because the Min 6 GHz frequency defined in the driver
is 5945 MHz, which should be 5925 MHz since channel 2 is not considered
currently, but the firmware can pass 5925 MHz as the minimum.
Hence, update the Min frequency supported by the driver to 5925 MHz.

In addition, ensure that the channel list update to firmware updates
only the channels that the current radio (ar) supports rather than
considering the wiphy support. This would be required when multiple pdevs
are supported in a wiphy and they support different ranges of frequencies
or bands as in single wiphy support.

Fixes: d889913205cf ("wifi: ath12k: driver for Qualcomm Wi-Fi 7 devices")

Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.0.1-00029-QCAHKSWPL_SILICONZ-1
Tested-on: QCN9274 hw2.0 PCI WLAN.WBE.1.1.1-00188-QCAHKSWPL_SILICONZ-1
Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3

Signed-off-by: Sriram R <quic_srirrama@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20240117062628.8260-1-quic_srirrama@quicinc.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath12k/core.h | 2 +-
 drivers/net/wireless/ath/ath12k/mac.c  | 2 +-
 drivers/net/wireless/ath/ath12k/reg.c  | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/core.h b/drivers/net/wireless/ath/ath12k/core.h
index 68c42ca44fcb5..d67494de44920 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -418,7 +418,7 @@ struct ath12k_sta {
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
-#define ATH12K_MIN_6G_FREQ 5945
+#define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
 #define ATH12K_NUM_CHANS 100
 #define ATH12K_MAX_5G_CHAN 173
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index b698e55a5b7bf..075ca1c34986b 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7188,7 +7188,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH12K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH12K_MIN_6G_FREQ) {
 			channels = kmemdup(ath12k_6ghz_channels,
 					   sizeof(ath12k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 5c006256c82ad..fcb76f92a7dec 100644
--- a/drivers/net/wireless/ath/ath12k/reg.c
+++ b/drivers/net/wireless/ath/ath12k/reg.c
@@ -103,7 +103,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 
 	bands = hw->wiphy->bands;
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
-		if (!bands[band])
+		if (!(ar->mac.sbands[band].channels && bands[band]))
 			continue;
 
 		for (i = 0; i < bands[band]->n_channels; i++) {
@@ -129,7 +129,7 @@ int ath12k_reg_update_chan_list(struct ath12k *ar)
 	ch = arg->channel;
 
 	for (band = 0; band < NUM_NL80211_BANDS; band++) {
-		if (!bands[band])
+		if (!(ar->mac.sbands[band].channels && bands[band]))
 			continue;
 
 		for (i = 0; i < bands[band]->n_channels; i++) {
-- 
2.43.0


