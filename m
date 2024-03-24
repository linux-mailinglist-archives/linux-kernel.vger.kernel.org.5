Return-Path: <linux-kernel+bounces-114112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7324888874
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5066D1F26E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A9523CB9F;
	Sun, 24 Mar 2024 23:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M14VHoxP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2881E7E0C;
	Sun, 24 Mar 2024 23:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321417; cv=none; b=QUel5xtutiShfbm438CbvRmaWgk5AgQxNYqzh+DqSCONaaJ8VsUns33DyrbJiR4JhGszptcaaLLWKV8+WF4ujyWy92j3YB6kODPM89ic/G08OioBV0b4KWlANLsC6/vtL9fRcLKbEuMohmiiP3Hkv1qyfbpZBZ0kjDKSujnU/Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321417; c=relaxed/simple;
	bh=ucO1ROlYGDE8bFvsPrY8PYxu+AoZeDX3F6itb2/x/9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cnsHGHD6aBX5987J21xm8osopeqFzqMkR0fpbnUhHX70Qgnunm3MxViCGrmgWBqaxJliD0VSlP0opt4QDhe15baxfNuYovhOXK8QIrPTOYZzLRi/OvOHUME8jfPOYQq7UeZloG1+grD9+QiXelH529DWJ6Rx6jMmnpG25F/N5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M14VHoxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A68C433C7;
	Sun, 24 Mar 2024 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321416;
	bh=ucO1ROlYGDE8bFvsPrY8PYxu+AoZeDX3F6itb2/x/9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M14VHoxP29QrDRUgPOhXCZicRZsw5d+oPNBbZ7T8nZgAE+Xe3ioKJi3qz6crZ6t64
	 3Uy9F+sJUnlx7CBDGGKiuqaD2qS6THAmEi2flWx5HS2Hpb+gCCBTkETHu48dBQ+tO8
	 c2lPB/hj3ROXXtPpUgy9cK5ii1RmUmKrJa3x3CRiHW7dL5VaNsXehph3A68dekZf1s
	 E4dNObfHQrRhk/aPEgk5GVqvQNjLPnslfnGuXhf8/AC3nfp9KhwZkBKISJB73yzSR5
	 Mh8nm5L9dmq6vXQgHUQJHY/HEeNxFL/BBGSqrwdYfTv/pYgKbNpFP4HEXLWlGCBqJC
	 iwx951Tzew3qw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sriram R <quic_srirrama@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 140/638] wifi: ath12k: Fix issues in channel list update
Date: Sun, 24 Mar 2024 18:52:57 -0400
Message-ID: <20240324230116.1348576-141-sashal@kernel.org>
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
index d873b573dac66..c926952c956ef 100644
--- a/drivers/net/wireless/ath/ath12k/core.h
+++ b/drivers/net/wireless/ath/ath12k/core.h
@@ -400,7 +400,7 @@ struct ath12k_sta {
 };
 
 #define ATH12K_MIN_5G_FREQ 4150
-#define ATH12K_MIN_6G_FREQ 5945
+#define ATH12K_MIN_6G_FREQ 5925
 #define ATH12K_MAX_6G_FREQ 7115
 #define ATH12K_NUM_CHANS 100
 #define ATH12K_MAX_5G_CHAN 173
diff --git a/drivers/net/wireless/ath/ath12k/mac.c b/drivers/net/wireless/ath/ath12k/mac.c
index 5434883eaf962..6563772b84307 100644
--- a/drivers/net/wireless/ath/ath12k/mac.c
+++ b/drivers/net/wireless/ath/ath12k/mac.c
@@ -7004,7 +7004,7 @@ static int ath12k_mac_setup_channels_rates(struct ath12k *ar,
 	}
 
 	if (supported_bands & WMI_HOST_WLAN_5G_CAP) {
-		if (reg_cap->high_5ghz_chan >= ATH12K_MAX_6G_FREQ) {
+		if (reg_cap->high_5ghz_chan >= ATH12K_MIN_6G_FREQ) {
 			channels = kmemdup(ath12k_6ghz_channels,
 					   sizeof(ath12k_6ghz_channels), GFP_KERNEL);
 			if (!channels) {
diff --git a/drivers/net/wireless/ath/ath12k/reg.c b/drivers/net/wireless/ath/ath12k/reg.c
index 6ede91ebc8e16..a2645ccae94aa 100644
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


