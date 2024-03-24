Return-Path: <linux-kernel+bounces-112978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3928A888038
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1A3A281412
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF1EB12BF0C;
	Sun, 24 Mar 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxe0SgyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7C12BEAA;
	Sun, 24 Mar 2024 22:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319790; cv=none; b=Z3fGXzSW+vig+KAvMgpYt2RFQzLi0bz0A+rxeHytrw1u0BTSBaKe1E8qyhoPq7V75VsyW1LULMGpaKd1eGfHQsZ5r0mdXX1Q7YejOwjwzPA02iD5gWgsJW9Kkh2wrp0OvbLXaOjNNeBy3840y/suw2HwyQmo3jRns3R0efP4PNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319790; c=relaxed/simple;
	bh=tdPXBerBXov0spvfnNiuYzMsfFi3OFvV7DejymwhKRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDc7wjfvvsZBMeOPaB50rLtvMz89olEWV7p+ssjxbsWzyNf782fXTrupGLvirC9ncYxy/uwyo+0NDe9eVMzYqS9aZj4J80luLIuiHg3WCN47NrlOTRX7tBeLWPomGHsr1eKpOyVmOPt8ONEiApLK22a11O8w7YmyWp7MlE2w8og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxe0SgyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15C8C433B1;
	Sun, 24 Mar 2024 22:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319790;
	bh=tdPXBerBXov0spvfnNiuYzMsfFi3OFvV7DejymwhKRU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kxe0SgyRcQhmKr31ojXs7+HDR4RRt9HC7Z08qSW6Hm8qzIDQYb6lljEatsFPEbujd
	 BBJrZEH9K3YGxXyu8ZMI657BDp2vjnndUHlSoomrbl4u99QjKAUcD6YdEdnWDbDxI4
	 wAsk7zLGvdtByK9FWQHfZspIej6l1QX8MHWi8Y/tZ8XbQSlj+/56PuS0uYPqGqbMJH
	 shABi1M2VJp9lb1hVrgL0jYdNrFbok/cg0DKeDRa6cCOXiaNButq0HJzsI2ipRu+vG
	 h3/4B+8uUxuF9xUBCC+pf2/sb4ZhA4XRnfmxl/VwjEokdH2GeaGprMleEwruIqkl/1
	 ozELmkTxu9SnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 091/715] wifi: cfg80211: add RNR with reporting AP information
Date: Sun, 24 Mar 2024 18:24:30 -0400
Message-ID: <20240324223455.1342824-92-sashal@kernel.org>
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

[ Upstream commit 4d1d6b3f45999b1ddde53831d639a67e2655285f ]

If the reporting AP is part of the same MLD, then an entry in the RNR is
required in order to discover it again from the BSS generated from the
per-STA profile in the Multi-Link Probe Response.

We need this because we do not have a direct concept of an MLD AP and
just do the lookup from one to the other on the fly if needed. As such,
we need to ensure that this lookup will work both ways.

Fixes: 2481b5da9c6b ("wifi: cfg80211: handle BSS data contained in ML probe responses")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240102213313.4cb3dbb1d84f.I7c74edec83c5d7598cdd578929fd0876d67aef7f@changeid
[roll in off-by-one fix and test updates from Benjamin]
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c       | 135 ++++++++++++++++++++++++++++++++++++--
 net/wireless/tests/scan.c |  36 +++++++++-
 2 files changed, 163 insertions(+), 8 deletions(-)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 389a52c29bfc7..7c9dc52ed783e 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -2674,6 +2674,103 @@ cfg80211_tbtt_info_for_mld_ap(const u8 *ie, size_t ielen, u8 mld_id, u8 link_id,
 	return 0;
 }
 
+static struct element *
+cfg80211_gen_reporter_rnr(struct cfg80211_bss *source_bss, bool is_mbssid,
+			  bool same_mld, u8 link_id, u8 bss_change_count,
+			  gfp_t gfp)
+{
+	const struct cfg80211_bss_ies *ies;
+	struct ieee80211_neighbor_ap_info ap_info;
+	struct ieee80211_tbtt_info_ge_11 tbtt_info;
+	u32 short_ssid;
+	const struct element *elem;
+	struct element *res;
+
+	/*
+	 * We only generate the RNR to permit ML lookups. For that we do not
+	 * need an entry for the corresponding transmitting BSS, lets just skip
+	 * it even though it would be easy to add.
+	 */
+	if (!same_mld)
+		return NULL;
+
+	/* We could use tx_data->ies if we change cfg80211_calc_short_ssid */
+	rcu_read_lock();
+	ies = rcu_dereference(source_bss->ies);
+
+	ap_info.tbtt_info_len = offsetofend(typeof(tbtt_info), mld_params);
+	ap_info.tbtt_info_hdr =
+			u8_encode_bits(IEEE80211_TBTT_INFO_TYPE_TBTT,
+				       IEEE80211_AP_INFO_TBTT_HDR_TYPE) |
+			u8_encode_bits(0, IEEE80211_AP_INFO_TBTT_HDR_COUNT);
+
+	ap_info.channel = ieee80211_frequency_to_channel(source_bss->channel->center_freq);
+
+	/* operating class */
+	elem = cfg80211_find_elem(WLAN_EID_SUPPORTED_REGULATORY_CLASSES,
+				  ies->data, ies->len);
+	if (elem && elem->datalen >= 1) {
+		ap_info.op_class = elem->data[0];
+	} else {
+		struct cfg80211_chan_def chandef;
+
+		/* The AP is not providing us with anything to work with. So
+		 * make up a somewhat reasonable operating class, but don't
+		 * bother with it too much as no one will ever use the
+		 * information.
+		 */
+		cfg80211_chandef_create(&chandef, source_bss->channel,
+					NL80211_CHAN_NO_HT);
+
+		if (!ieee80211_chandef_to_operating_class(&chandef,
+							  &ap_info.op_class))
+			goto out_unlock;
+	}
+
+	/* Just set TBTT offset and PSD 20 to invalid/unknown */
+	tbtt_info.tbtt_offset = 255;
+	tbtt_info.psd_20 = IEEE80211_RNR_TBTT_PARAMS_PSD_RESERVED;
+
+	memcpy(tbtt_info.bssid, source_bss->bssid, ETH_ALEN);
+	if (cfg80211_calc_short_ssid(ies, &elem, &short_ssid))
+		goto out_unlock;
+
+	rcu_read_unlock();
+
+	tbtt_info.short_ssid = cpu_to_le32(short_ssid);
+
+	tbtt_info.bss_params = IEEE80211_RNR_TBTT_PARAMS_SAME_SSID;
+
+	if (is_mbssid) {
+		tbtt_info.bss_params |= IEEE80211_RNR_TBTT_PARAMS_MULTI_BSSID;
+		tbtt_info.bss_params |= IEEE80211_RNR_TBTT_PARAMS_TRANSMITTED_BSSID;
+	}
+
+	tbtt_info.mld_params.mld_id = 0;
+	tbtt_info.mld_params.params =
+		le16_encode_bits(link_id, IEEE80211_RNR_MLD_PARAMS_LINK_ID) |
+		le16_encode_bits(bss_change_count,
+				 IEEE80211_RNR_MLD_PARAMS_BSS_CHANGE_COUNT);
+
+	res = kzalloc(struct_size(res, data,
+				  sizeof(ap_info) + ap_info.tbtt_info_len),
+		      gfp);
+	if (!res)
+		return NULL;
+
+	/* Copy the data */
+	res->id = WLAN_EID_REDUCED_NEIGHBOR_REPORT;
+	res->datalen = sizeof(ap_info) + ap_info.tbtt_info_len;
+	memcpy(res->data, &ap_info, sizeof(ap_info));
+	memcpy(res->data + sizeof(ap_info), &tbtt_info, ap_info.tbtt_info_len);
+
+	return res;
+
+out_unlock:
+	rcu_read_unlock();
+	return NULL;
+}
+
 static void
 cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 				struct cfg80211_inform_single_bss_data *tx_data,
@@ -2687,13 +2784,14 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 		.source_bss = source_bss,
 		.bss_source = BSS_SOURCE_STA_PROFILE,
 	};
+	struct element *reporter_rnr = NULL;
 	struct ieee80211_multi_link_elem *ml_elem;
 	struct cfg80211_mle *mle;
 	u16 control;
 	u8 ml_common_len;
-	u8 *new_ie;
+	u8 *new_ie = NULL;
 	struct cfg80211_bss *bss;
-	int mld_id;
+	u8 mld_id, reporter_link_id, bss_change_count;
 	u16 seen_links = 0;
 	const u8 *pos;
 	u8 i;
@@ -2715,8 +2813,14 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 
 	ml_common_len = ml_elem->variable[0];
 
-	/* length + MLD MAC address + link ID info + BSS Params Change Count */
-	pos = ml_elem->variable + 1 + 6 + 1 + 1;
+	/* length + MLD MAC address */
+	pos = ml_elem->variable + 1 + 6;
+
+	reporter_link_id = pos[0];
+	pos += 1;
+
+	bss_change_count = pos[0];
+	pos += 1;
 
 	if (u16_get_bits(control, IEEE80211_MLC_BASIC_PRES_MED_SYNC_DELAY))
 		pos += 2;
@@ -2747,10 +2851,21 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	if (!mle)
 		return;
 
+	/* No point in doing anything if there is no per-STA profile */
+	if (!mle->sta_prof[0])
+		goto out;
+
 	new_ie = kmalloc(IEEE80211_MAX_DATA_LEN, gfp);
 	if (!new_ie)
 		goto out;
 
+	reporter_rnr = cfg80211_gen_reporter_rnr(source_bss,
+						 u16_get_bits(control,
+							      IEEE80211_MLC_BASIC_PRES_MLD_ID),
+						 mld_id == 0, reporter_link_id,
+						 bss_change_count,
+						 gfp);
+
 	for (i = 0; i < ARRAY_SIZE(mle->sta_prof) && mle->sta_prof[i]; i++) {
 		const struct ieee80211_neighbor_ap_info *ap_info;
 		enum nl80211_band band;
@@ -2860,7 +2975,16 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 
 		data.ielen += sizeof(*ml_elem) + ml_common_len;
 
-		/* TODO: Add an RNR containing only the reporting AP */
+		if (reporter_rnr && (use_for & NL80211_BSS_USE_FOR_NORMAL)) {
+			if (data.ielen + sizeof(struct element) +
+			    reporter_rnr->datalen > IEEE80211_MAX_DATA_LEN)
+				continue;
+
+			memcpy(new_ie + data.ielen, reporter_rnr,
+			       sizeof(struct element) + reporter_rnr->datalen);
+			data.ielen += sizeof(struct element) +
+				      reporter_rnr->datalen;
+		}
 
 		bss = cfg80211_inform_single_bss_data(wiphy, &data, gfp);
 		if (!bss)
@@ -2869,6 +2993,7 @@ cfg80211_parse_ml_elem_sta_data(struct wiphy *wiphy,
 	}
 
 out:
+	kfree(reporter_rnr);
 	kfree(new_ie);
 	kfree(mle);
 }
diff --git a/net/wireless/tests/scan.c b/net/wireless/tests/scan.c
index 77854161cd22b..f9ea44aee9952 100644
--- a/net/wireless/tests/scan.c
+++ b/net/wireless/tests/scan.c
@@ -2,7 +2,7 @@
 /*
  * KUnit tests for inform_bss functions
  *
- * Copyright (C) 2023 Intel Corporation
+ * Copyright (C) 2023-2024 Intel Corporation
  */
 #include <linux/ieee80211.h>
 #include <net/cfg80211.h>
@@ -406,9 +406,27 @@ static struct inform_bss_ml_sta_case {
 	const char *desc;
 	int mld_id;
 	bool sta_prof_vendor_elems;
+	bool include_oper_class;
 } inform_bss_ml_sta_cases[] = {
-	{ .desc = "no_mld_id", .mld_id = 0, .sta_prof_vendor_elems = false },
-	{ .desc = "mld_id_eq_1", .mld_id = 1, .sta_prof_vendor_elems = true },
+	{
+		.desc = "zero_mld_id",
+		.mld_id = 0,
+		.sta_prof_vendor_elems = false,
+	}, {
+		.desc = "zero_mld_id_with_oper_class",
+		.mld_id = 0,
+		.sta_prof_vendor_elems = false,
+		.include_oper_class = true,
+	}, {
+		.desc = "mld_id_eq_1",
+		.mld_id = 1,
+		.sta_prof_vendor_elems = true,
+	}, {
+		.desc = "mld_id_eq_1_with_oper_class",
+		.mld_id = 1,
+		.sta_prof_vendor_elems = true,
+		.include_oper_class = true,
+	},
 };
 KUNIT_ARRAY_PARAM_DESC(inform_bss_ml_sta, inform_bss_ml_sta_cases, desc)
 
@@ -515,6 +533,12 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	skb_put_u8(input, 4);
 	skb_put_data(input, "TEST", 4);
 
+	if (params->include_oper_class) {
+		skb_put_u8(input, WLAN_EID_SUPPORTED_REGULATORY_CLASSES);
+		skb_put_u8(input, 1);
+		skb_put_u8(input, 81);
+	}
+
 	skb_put_u8(input, WLAN_EID_REDUCED_NEIGHBOR_REPORT);
 	skb_put_u8(input, sizeof(rnr));
 	skb_put_data(input, &rnr, sizeof(rnr));
@@ -582,15 +606,21 @@ static void test_inform_bss_ml_sta(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, ies->tsf, tsf + le64_to_cpu(sta_prof.tsf_offset));
 	/* Resulting length should be:
 	 * SSID (inherited) + RNR (inherited) + vendor element(s) +
+	 * operating class (if requested) +
+	 * generated RNR (if MLD ID == 0) +
 	 * MLE common info + MLE header and control
 	 */
 	if (params->sta_prof_vendor_elems)
 		KUNIT_EXPECT_EQ(test, ies->len,
 				6 + 2 + sizeof(rnr) + 2 + 160 + 2 + 165 +
+				(params->include_oper_class ? 3 : 0) +
+				(!params->mld_id ? 22 : 0) +
 				mle_basic_common_info.var_len + 5);
 	else
 		KUNIT_EXPECT_EQ(test, ies->len,
 				6 + 2 + sizeof(rnr) + 2 + 155 +
+				(params->include_oper_class ? 3 : 0) +
+				(!params->mld_id ? 22 : 0) +
 				mle_basic_common_info.var_len + 5);
 	rcu_read_unlock();
 
-- 
2.43.0


