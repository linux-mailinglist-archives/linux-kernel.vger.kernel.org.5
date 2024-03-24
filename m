Return-Path: <linux-kernel+bounces-115803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCBB8897F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62C0C29D0AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3083736E4;
	Mon, 25 Mar 2024 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC5UmFtf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C3145FEA;
	Sun, 24 Mar 2024 23:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322045; cv=none; b=uc6urG5ZGRkmfQmgSSz+WrVK6bMlYJ37NIs0rRhcChhKuIjUV2zWa72aMi+ZOUuGu1U6LCHIRpO7MK327rD50wF/NdsGM2mMr2YRpKmehPW44h5fFK4KqpB0uEt3yDj7KjqT8mtyBpCXk5Q7Zii4a39z3lgS8/500lC6MmNLiBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322045; c=relaxed/simple;
	bh=0gpEjk4YZQFCV1DSJKnqukAGxncbpdcnwebr9pyXTSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vD3od4dZavstQT8VQ25vp+JKr9NCzmGt305NYABih4gAuMnQINM687qn3NXtcoSr0dVvi09krRGTi7l02cdjWrjAQlNL0QD3kkkuzNcoJr2Zr1dyN6opS6poD3sqbF4GfgFqDM/kjI5paKT4TW+ZrdI4N9Ajdc6S82jpRHhJ0WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC5UmFtf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DEBC43390;
	Sun, 24 Mar 2024 23:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322044;
	bh=0gpEjk4YZQFCV1DSJKnqukAGxncbpdcnwebr9pyXTSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cC5UmFtfVQkjPcNdTfCUd5Cv3YkOsSwVkWrF05IoYK1cuAQKAPsMcez8rjOicgoHn
	 3YY0JrsmVpAIZwwT0/gTuvEdZozmTzqsfc6BylkIH/o7BvlBPc+XNeQmhL+EKyfTFU
	 8z/URSaq+ySQhSp+jqyHZNFWUf9BYW/70igLOOO3UzJDpa7mRTtwYFS0pu1460oDCx
	 9CXoEvWPUicQmBvtyXUk/89bkIyp3mu3V61yieR+jF9J3/DE7jcdcDKbkmD8u5q7ap
	 Pyw+35dnI+pT/JuIqsLdOTnThL1DM/GiQ1zFQidRU+SPCwF8IIqhbBmNZxQzsl+A7F
	 CdzmFLsfpci4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/451] wifi: iwlwifi: mvm: report beacon protection failures
Date: Sun, 24 Mar 2024 19:06:32 -0400
Message-ID: <20240324231207.1351418-117-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index f268a31ce26d9..105f283b777d2 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -299,6 +299,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 				u32 status,
 				struct ieee80211_rx_status *stats)
 {
+	struct wireless_dev *wdev;
 	struct iwl_mvm_sta *mvmsta;
 	struct iwl_mvm_vif *mvmvif;
 	u8 keyid;
@@ -320,9 +321,15 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
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
@@ -331,13 +338,6 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
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
@@ -346,11 +346,11 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
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
@@ -364,7 +364,7 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
 			return -1;
 		key = rcu_dereference(mvmvif->bcn_prot.keys[keyid - 6]);
 		if (!key)
-			return -1;
+			goto report;
 	}
 
 	/* Report status to mac80211 */
@@ -372,6 +372,10 @@ static int iwl_mvm_rx_mgmt_prot(struct ieee80211_sta *sta,
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


