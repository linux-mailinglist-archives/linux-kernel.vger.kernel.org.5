Return-Path: <linux-kernel+bounces-113012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029868880C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3379A1C20888
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57DEA134419;
	Sun, 24 Mar 2024 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0qqcDpb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8171513342A;
	Sun, 24 Mar 2024 22:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319823; cv=none; b=kkQQgYXdt7a3M8/K+YwaYhV76hiA7jOr3z/TNLl09KFEkLGBEcahRU2AIuY7eeifSdIVbIZx+DKsYlBgt8/3VIq9iHWgxRmWcxFhSLzAptY6d2+0fPng0VsStLr+eN95i6K039ep7Ntp1inkYZBcaHtaZqUoUA6H88B1osguGMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319823; c=relaxed/simple;
	bh=bTEChCyEJj/3Nl554eWTVKSB0lt5bi1igmaG3wMuy3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmOuinNr6ICVxjHf4GSMxkmGNCLIe9Xqb1wmXQoSvpZpPsZZvR2BGJGtEqGLVUlJVNBMvidv4V4ONho+BpHOe2h8ef4GByrONGOB5SjCB+iNri9Caj0rHIi+9kcxhth9jpH3m2nHu1cT6po8MWW/3ILiNXvHtL4NGUQS5cY0GLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0qqcDpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498C7C433C7;
	Sun, 24 Mar 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319823;
	bh=bTEChCyEJj/3Nl554eWTVKSB0lt5bi1igmaG3wMuy3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K0qqcDpb8eIF6FBe2D8XAs0JEQDjJ7zqjJvvqQ2d39gYvKOpKexWjfMkwgMLSbaK7
	 tNm1n2tCXCk5pts/BdRVx+j1nYT2wLf8Yi8jV2MAeGqEWFzXD6pt6aDsOhNqqdnGcE
	 Wf58Qrg1J+fcnZLHeZ4I3eRUGTJS8iUbb2h5PAuUHC2xpX9zHees4Vm0mKlz+StkyO
	 AwOmX1u+jQvZzGLY/+L4a3L7OtlkkElJX8LrlU9qMcmfjJXpfatIgqOWgUEn1X1jL1
	 2VplpHs788W9Sk2WK5yuU/Ot04hoXqSfQFIM4+or8YVwV/qTmCNt/UOYLBXpiR8nEA
	 IVVNOIbyChetQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 125/715] wifi: iwlwifi: mvm: report beacon protection failures
Date: Sun, 24 Mar 2024 18:25:04 -0400
Message-ID: <20240324223455.1342824-126-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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
index af15d470c69bd..7bf2a5947e5e9 100644
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


