Return-Path: <linux-kernel+bounces-115626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3006D889CF3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1DC7B4400A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF5D254F71;
	Mon, 25 Mar 2024 02:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gAUlauPc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CEF132489;
	Sun, 24 Mar 2024 23:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321444; cv=none; b=D68HuepMNMRHhWOsIZtT1Q+XpWzT5E9iEJYg/3uQN/sO7XbHDY1JI/vLkM94aoqUB/+nmm7Iqc/v/MQv+GYSEsPqNw6FGJus9UZtPvtHd9befG5FCOFrNNetsmwk53VPr85y35Q2zH6N61yHONbUihUHJJj/AD/FUZxdZPs4V7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321444; c=relaxed/simple;
	bh=KsprVximj/NVPgVKqZ5LbfOUeQ0+9cSinKnpOFwlChA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3Xk7y0Z5WfYWvDeoZhPc7mkPbg8ITbaiEu7B+xcacV4UZ5ACh/+je2wBFLNTynKW4kAc4VkGrRgJHUGPk2dx5Mo6Musbi7MIpeOi1JTG45frsIBG7im0TdFVWlPnpxQM5hbDv8Pch3L+Ta2DUq+oGIrfM1fUo2NcGjjZKPA8Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gAUlauPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4048BC433C7;
	Sun, 24 Mar 2024 23:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321444;
	bh=KsprVximj/NVPgVKqZ5LbfOUeQ0+9cSinKnpOFwlChA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gAUlauPcOOu25UoewHj1kq7zm1qmXVhyzx6/Myip0thFsaa/KK5HK1krMbkfGfRLA
	 oZ1hNBmX+dmC0ceONl9ZOtYiY+QoM3bE0Bte2Z3qwEpieA8tyMzQ5LQawsQ+5VvB9r
	 8niIkafk3LzyuDvM15qQXTOR8ywPDY44+XF+vJvAY4TAFU+CK5dWBjsh3OhOibBwrL
	 XAweLhnEDznhNhxbNAvM1t9LTPK6jM1ur/5MCA0I4kscvsm/jOAYzPIIxACtfN6W6q
	 JnIHjYbBAjzLDMGw8lpV1XHLts4RNw3dlu10d4omV8fE5Ni/a43xLmQN+XM0yTNn8i
	 8r4YPlX250xBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 168/638] wifi: iwlwifi: mvm: report beacon protection failures
Date: Sun, 24 Mar 2024 18:53:25 -0400
Message-ID: <20240324230116.1348576-169-sashal@kernel.org>
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 91380f768d7f6e3d003755defa792e9a00a1444a ]

Andrei reports that we just silently drop beacons after we
report the key counters, but never report to userspace, so
wpa_supplicant cannot send the WNM action frame. Fix that.

Fixes: b1fdc2505abc ("iwlwifi: mvm: advertise BIGTK client support if available")
Reported-by: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Reviewed-by: Gregory Greenman <gregory.greenman@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240128084842.7d855442cdce.Iba90b26f893dc8c49bfb8be65373cd0a138af12c@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c | 26 +++++++++++--------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 82b4d4d01097a..bac0228b8c866 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -282,6 +282,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				u32 status,
 				struct ieee80211_rx_status *stats)
 {
+	struct wireless_dev *wdev;
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
 	u8 keyid;
@@ -303,9 +304,15 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!ieee80211_is_beacon(hdr->frame_control))
 		return 0;
 
+	if (!sta)
+		return -1;
+
+	mvmsta = iwl_mvm_sta_from_mac80211(sta);
+	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
+
 	/* key mismatch - will also report !MIC_OK but we shouldn't count it */
 	if (!(status & IWL_RX_MPDU_STATUS_KEY_VALID))
-		return -1;
+		goto report;
 
 	/* good cases */
 	if (likely(status & IWL_RX_MPDU_STATUS_MIC_OK &&
@@ -314,13 +321,6 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 		return 0;
 	}
 
-	if (!sta)
-		return -1;
-
-	mvmsta = iwl_mvm_sta_from_mac80211(sta);
-
-	mvmvif = iwl_mvm_vif_from_mac80211(mvmsta->vif);
-
 	/*
 	 * both keys will have the same cipher and MIC length, use
 	 * whichever one is available
@@ -329,11 +329,11 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 	if (!key) {
 		key = rcu_dereference(mvmvif->bcn_prot.keys[1]);
 		if (!key)
-			return -1;
+			goto report;
 	}
 
 	if (len < key->icv_len + IEEE80211_GMAC_PN_LEN + 2)
-		return -1;
+		goto report;
 
 	/* get the real key ID */
 	keyid = frame[len - key->icv_len - IEEE80211_GMAC_PN_LEN - 2];
@@ -347,7 +347,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 			return -1;
 		key = rcu_dereference(mvmvif->bcn_prot.keys[keyid - 6]);
 		if (!key)
-			return -1;
+			goto report;
 	}
 
 	/* Report status to mac80211 */
@@ -355,6 +355,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 		ieee80211_key_mic_failure(key);
 	else if (status & IWL_RX_MPDU_STATUS_REPLAY_ERROR)
 		ieee80211_key_replay(key);
+report:
+	wdev = ieee80211_vif_to_wdev(mvmsta->vif);
+	if (wdev->netdev)
+		cfg80211_rx_unprot_mlme_mgmt(wdev->netdev, (void *)hdr, len);
 
 	return -1;
 }
-- 
2.43.0


