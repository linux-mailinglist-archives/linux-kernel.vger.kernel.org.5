Return-Path: <linux-kernel+bounces-86980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE2686CDD4
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C101EB266C9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D10887A125;
	Thu, 29 Feb 2024 15:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCmBrg/P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB68D757E6;
	Thu, 29 Feb 2024 15:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709221797; cv=none; b=dB4XmXRuFQA69ScUkX412agUCibkQiSHJNFb0MzVo687mITmcfC7DFPTOdDdzxtf+R8wTtFrEJU01pyJKFOa0rzo4mfPurxDZaC01ic3vh0NM+dyuxuASMqAqnhUdA4zyrmUIzBBM4+gsDoP0JW3bCcxglxAaHFbaxdS1OV4mF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709221797; c=relaxed/simple;
	bh=hoUFVXBUc4PJkc2Bbi/RC+j7C+Z0Ys8ZxYU9GzypvvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d+IIDFuQ3tZ6vAW0AInfOOIhiUihPHEsheqdwMiiMgarwerRSbzwTbCQYWd1dHRNvKVa5YGRGo4GXomY+qfUm4ovuOkA31oQfsycqNIhNdytdDYVZjwA/xlGvxO7S1P3ct3Ncdz/yLhr1e0ioCfsXaS1oojvkXz3ELHP6P+UMNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCmBrg/P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60E9AC433F1;
	Thu, 29 Feb 2024 15:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709221796;
	bh=hoUFVXBUc4PJkc2Bbi/RC+j7C+Z0Ys8ZxYU9GzypvvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fCmBrg/PP/e6IRwRqT+r9nvc5iMgxMPxnlyCujdNvUTx/f63MOzIdn5mmoWsxCHRk
	 wC/dH6yCrCOgiSu+7lXvo1NkZvsM4j1ZCNT4h5OwEEI7GnW+1fWjMaYKV76u5iyxvY
	 p+zAIDgwBq8BH4XOOFNlTxvx7jlJs//xfqcNQM/xaGCo7mPLwBQdioPlyQUylV0SeZ
	 4p4Wtq5psd+wKYskckUx56/POszo5kDrXxTGDTfks5RAvBp5y2vLZoVixAEAYbNuwe
	 9/ggychTNKVWvEm8V+p0ADLYQWESMjAJplWDGHdANJI1VwQ9NKbR6DiiJ3T7Q/K6ki
	 wfl/Sp6xy33lQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Gabay <daniel.gabay@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	kvalo@kernel.org,
	gregory.greenman@intel.com,
	ilan.peer@intel.com,
	avraham.stern@intel.com,
	shaul.triebitz@intel.com,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/21] wifi: iwlwifi: mvm: use correct address 3 in A-MSDU
Date: Thu, 29 Feb 2024 10:49:25 -0500
Message-ID: <20240229154946.2850012-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240229154946.2850012-1-sashal@kernel.org>
References: <20240229154946.2850012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.18
Content-Transfer-Encoding: 8bit

From: Daniel Gabay <daniel.gabay@intel.com>

[ Upstream commit 2e57b77583ca34fdb6e14f253172636c52f81cf2 ]

As described in IEEE sta 802.11-2020, table 9-30 (Address
field contents), A-MSDU address 3 should contain the BSSID
address.

In TX_CMD we copy the MAC header from skb, and skb address 3
holds the destination address, but it may not be identical to
the BSSID.

Using the wrong destination address appears to work with (most)
receivers without MLO, but in MLO some devices are checking for
it carefully, perhaps as a consequence of link to MLD address
translation.

Replace address 3 in the TX_CMD MAC header with the correct
address while retaining the skb address 3 unchanged.
This ensures that skb address 3 will be utilized later for
constructing the A-MSDU subframes.

Note that we fill in the MLD address, but the firmware will do the
necessary translation to link address after encryption.

Signed-off-by: Daniel Gabay <daniel.gabay@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240204235836.4583a1bf9188.I3f8e7892bdf8f86b4daa28453771a8c9817b2416@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c | 69 ++++++++++++++++++---
 1 file changed, 59 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
index 6fdb2c38518e3..4ea3aabc64883 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/tx.c
@@ -500,13 +500,24 @@ static void iwl_mvm_set_tx_cmd_crypto(struct iwl_mvm *mvm,
 	}
 }
 
+static void iwl_mvm_copy_hdr(void *cmd, const void *hdr, int hdrlen,
+			     const u8 *addr3_override)
+{
+	struct ieee80211_hdr *out_hdr = cmd;
+
+	memcpy(cmd, hdr, hdrlen);
+	if (addr3_override)
+		memcpy(out_hdr->addr3, addr3_override, ETH_ALEN);
+}
+
 /*
  * Allocates and sets the Tx cmd the driver data pointers in the skb
  */
 static struct iwl_device_tx_cmd *
 iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 		      struct ieee80211_tx_info *info, int hdrlen,
-		      struct ieee80211_sta *sta, u8 sta_id)
+		      struct ieee80211_sta *sta, u8 sta_id,
+		      const u8 *addr3_override)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct iwl_device_tx_cmd *dev_cmd;
@@ -564,7 +575,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			cmd->len = cpu_to_le16((u16)skb->len);
 
 			/* Copy MAC header from skb into command buffer */
-			memcpy(cmd->hdr, hdr, hdrlen);
+			iwl_mvm_copy_hdr(cmd->hdr, hdr, hdrlen, addr3_override);
 
 			cmd->flags = cpu_to_le16(flags);
 			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
@@ -579,7 +590,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 			cmd->len = cpu_to_le16((u16)skb->len);
 
 			/* Copy MAC header from skb into command buffer */
-			memcpy(cmd->hdr, hdr, hdrlen);
+			iwl_mvm_copy_hdr(cmd->hdr, hdr, hdrlen, addr3_override);
 
 			cmd->flags = cpu_to_le32(flags);
 			cmd->rate_n_flags = cpu_to_le32(rate_n_flags);
@@ -597,7 +608,7 @@ iwl_mvm_set_tx_params(struct iwl_mvm *mvm, struct sk_buff *skb,
 	iwl_mvm_set_tx_cmd_rate(mvm, tx_cmd, info, sta, hdr->frame_control);
 
 	/* Copy MAC header from skb into command buffer */
-	memcpy(tx_cmd->hdr, hdr, hdrlen);
+	iwl_mvm_copy_hdr(tx_cmd->hdr, hdr, hdrlen, addr3_override);
 
 out:
 	return dev_cmd;
@@ -800,7 +811,8 @@ int iwl_mvm_tx_skb_non_sta(struct iwl_mvm *mvm, struct sk_buff *skb)
 
 	IWL_DEBUG_TX(mvm, "station Id %d, queue=%d\n", sta_id, queue);
 
-	dev_cmd = iwl_mvm_set_tx_params(mvm, skb, &info, hdrlen, NULL, sta_id);
+	dev_cmd = iwl_mvm_set_tx_params(mvm, skb, &info, hdrlen, NULL, sta_id,
+					NULL);
 	if (!dev_cmd)
 		return -1;
 
@@ -1120,7 +1132,8 @@ static int iwl_mvm_tx_pkt_queued(struct iwl_mvm *mvm,
  */
 static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 			   struct ieee80211_tx_info *info,
-			   struct ieee80211_sta *sta)
+			   struct ieee80211_sta *sta,
+			   const u8 *addr3_override)
 {
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct iwl_mvm_sta *mvmsta;
@@ -1152,7 +1165,8 @@ static int iwl_mvm_tx_mpdu(struct iwl_mvm *mvm, struct sk_buff *skb,
 		iwl_mvm_probe_resp_set_noa(mvm, skb);
 
 	dev_cmd = iwl_mvm_set_tx_params(mvm, skb, info, hdrlen,
-					sta, mvmsta->deflink.sta_id);
+					sta, mvmsta->deflink.sta_id,
+					addr3_override);
 	if (!dev_cmd)
 		goto drop;
 
@@ -1274,9 +1288,11 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	struct iwl_mvm_sta *mvmsta = iwl_mvm_sta_from_mac80211(sta);
 	struct ieee80211_tx_info info;
 	struct sk_buff_head mpdus_skbs;
+	struct ieee80211_vif *vif;
 	unsigned int payload_len;
 	int ret;
 	struct sk_buff *orig_skb = skb;
+	const u8 *addr3;
 
 	if (WARN_ON_ONCE(!mvmsta))
 		return -1;
@@ -1287,26 +1303,59 @@ int iwl_mvm_tx_skb_sta(struct iwl_mvm *mvm, struct sk_buff *skb,
 	memcpy(&info, skb->cb, sizeof(info));
 
 	if (!skb_is_gso(skb))
-		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
+		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta, NULL);
 
 	payload_len = skb_tail_pointer(skb) - skb_transport_header(skb) -
 		tcp_hdrlen(skb) + skb->data_len;
 
 	if (payload_len <= skb_shinfo(skb)->gso_size)
-		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
+		return iwl_mvm_tx_mpdu(mvm, skb, &info, sta, NULL);
 
 	__skb_queue_head_init(&mpdus_skbs);
 
+	vif = info.control.vif;
+	if (!vif)
+		return -1;
+
 	ret = iwl_mvm_tx_tso(mvm, skb, &info, sta, &mpdus_skbs);
 	if (ret)
 		return ret;
 
 	WARN_ON(skb_queue_empty(&mpdus_skbs));
 
+	/*
+	 * As described in IEEE sta 802.11-2020, table 9-30 (Address
+	 * field contents), A-MSDU address 3 should contain the BSSID
+	 * address.
+	 * Pass address 3 down to iwl_mvm_tx_mpdu() and further to set it
+	 * in the command header. We need to preserve the original
+	 * address 3 in the skb header to correctly create all the
+	 * A-MSDU subframe headers from it.
+	 */
+	switch (vif->type) {
+	case NL80211_IFTYPE_STATION:
+		addr3 = vif->cfg.ap_addr;
+		break;
+	case NL80211_IFTYPE_AP:
+		addr3 = vif->addr;
+		break;
+	default:
+		addr3 = NULL;
+		break;
+	}
+
 	while (!skb_queue_empty(&mpdus_skbs)) {
+		struct ieee80211_hdr *hdr;
+		bool amsdu;
+
 		skb = __skb_dequeue(&mpdus_skbs);
+		hdr = (void *)skb->data;
+		amsdu = ieee80211_is_data_qos(hdr->frame_control) &&
+			(*ieee80211_get_qos_ctl(hdr) &
+			 IEEE80211_QOS_CTL_A_MSDU_PRESENT);
 
-		ret = iwl_mvm_tx_mpdu(mvm, skb, &info, sta);
+		ret = iwl_mvm_tx_mpdu(mvm, skb, &info, sta,
+				      amsdu ? addr3 : NULL);
 		if (ret) {
 			/* Free skbs created as part of TSO logic that have not yet been dequeued */
 			__skb_queue_purge(&mpdus_skbs);
-- 
2.43.0


