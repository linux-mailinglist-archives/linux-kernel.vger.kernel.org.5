Return-Path: <linux-kernel+bounces-113113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2465888190
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED8B1C21B2B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78B115A483;
	Sun, 24 Mar 2024 22:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MNi9Duwq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E674415958B;
	Sun, 24 Mar 2024 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319921; cv=none; b=QJfBwRezDC1SrRnxoONPgOhIg3J2cSlc2EgtwxTpFw6bdAC2dfFwhzJE8xHyzXWrqWqGirS6Y+EUM9EimqjbzltTNVBrEbXGETemUMEeGtLsTHABxF4A1Wr3tSAggJUd6ZE+cBvRBG9ugC8M0wwgZ0GblAQUWNXctcYcJe1MoLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319921; c=relaxed/simple;
	bh=DrXP0gs68dleLeX1kuokUh6LqmywretmDJba3cfde2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qGtqGrhKaBPBQgactq52GCvGP4yJk7ZoutTty0dI6ykGd2bVAWXftiPjco+lJle1LUAbKXEdd4Q8qBldwsUbgPsSd8LDJfYq5l2uGC4Z/WKDT/2CLMVhV0rFz+Q4Ldae9X6t3DfIOFe0ZSAuXNc8za7r2d2n0UDGaOz1Ly0sPGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=MNi9Duwq reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A72FC43399;
	Sun, 24 Mar 2024 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319920;
	bh=DrXP0gs68dleLeX1kuokUh6LqmywretmDJba3cfde2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MNi9DuwqzQXb9Q8+sd33F7xjwxxha+BhOqzEfGKp6/HGPR3rk5gxW48deIbKRDJqn
	 v/9vH+YOYaeRTnIV7OHg5DCIp4XF2g6CPHlKNZ5KgosqhV/DJoFqp+O2Vsu3f8EzGq
	 TP/2LDVhMAe69hY5fHfLz+W42t/9//VT2eVLkXET+nxmmg3JwR6dpH1VESxOGCR3qZ
	 v9nlN5w6sxWRyGpsiP9fqsiueioao5grA+bc5ESS39PfsBIauYQ5LdyOVyr1rHYhYR
	 qwocEZH3cSmPsEdRZdp+Lanxnq6TKzReSIMdqM+bFQdxgXFBdBzZkuJJhGZo3SnlIo
	 863VUQmgq1FgQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 226/715] wifi: cfg80211: set correct param change count in ML element
Date: Sun, 24 Mar 2024 18:26:45 -0400
Message-ID: <20240324223455.1342824-227-sashal@kernel.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit f8599d634094b1257054a8d0815785d658cbdb74 ]

The ML element generation code to create a BSS entry from a per-STA
profile was not overwriting the BSS parameter change count. This meant
that the incorrect parameter change count would be reported within the
multi-link element.

Fix this by returning the BSS parameter change count from the function
and placing it into the ML element. The returned tbtt info was never
used, so just drop that to simplify the code.

Fixes: 5f478adf1f99 ("wifi: cfg80211: generate an ML element for per-STA profiles")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240216135047.f2a507634692.I06b122c7a319a38b4e970f5e0bd3d3ef9cac4cbe@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 7c9dc52ed783e..f138f88be9048 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2602,9 +2602,9 @@ cfg80211_defrag_mle(const struct element *mle, const u8 *ie, size_t ielen,
 }
 
 static u8
-cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
-			      const struct ieee80211_neighbor_ap_info **ap_info,
-			      const u8 **tbtt_info)
+cfg80211_rnr_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
+			     const struct ieee80211_neighbor_ap_info **ap_info,
+			     u8 *param_ch_count)
 {
 	const struct ieee80211_neighbor_ap_info *info;
 	const struct element *rnr;
@@ -2661,7 +2661,9 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 				if (mld_id == mld_params->mld_id &&
 				    link_id == lid) {
 					*ap_info = info;
-					*tbtt_info = pos;
+					*param_ch_count =
+						le16_get_bits(mld_params->params,
+							      IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
 
 					return use_for;
 				}
@@ -2871,8 +2873,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		enum nl80211_band band;
 		u32 freq;
 		const u8 *profile;
-		const u8 *tbtt_info;
 		ssize_t profile_len;
+		u8 param_ch_count;
 		u8 link_id, use_for;
 
 		if (!ieee80211_mle_basic_sta_prof_size_ok((u8 *)mle->sta_prof[i],
@@ -2915,10 +2917,11 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		profile_len -= 2;
 
 		/* Find in RNR to look up channel information */
-		use_for = cfg80211_tbtt_info_for_mld_ap(tx_data->ie,
-							tx_data->ielen,
-							mld_id, link_id,
-							&ap_info, &tbtt_info);
+		use_for = cfg80211_rnr_info_for_mld_ap(tx_data->ie,
+						       tx_data->ielen,
+						       mld_id, link_id,
+						       &ap_info,
+						       &param_ch_count);
 		if (!use_for)
 			continue;
 
@@ -2961,7 +2964,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 			continue;
 
 		/* Copy the Basic Multi-Link element including the common
-		 * information, and then fix up the link ID.
+		 * information, and then fix up the link ID and BSS param
+		 * change count.
 		 * Note that the ML element length has been verified and we
 		 * also checked that it contains the link ID.
 		 */
@@ -2972,6 +2976,8 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		       sizeof(*ml_elem) + ml_common_len);
 
 		new_ie[data.ielen + sizeof(*ml_elem) + 1 + ETH_ALEN] = link_id;
+		new_ie[data.ielen + sizeof(*ml_elem) + 1 + ETH_ALEN + 1] =
+			param_ch_count;
 
 		data.ielen += sizeof(*ml_elem) + ml_common_len;
 
-- 
2.43.0


