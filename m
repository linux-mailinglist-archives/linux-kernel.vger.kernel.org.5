Return-Path: <linux-kernel+bounces-112949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1EF3887FFC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CFFD1C210F5
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED7810A36;
	Sun, 24 Mar 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VinzE83B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CAB82D9A;
	Sun, 24 Mar 2024 22:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319762; cv=none; b=G0SUOsFZO9uNsOIfPH+Qxu/UHaoKmwNGoKVlj0GPDZufHdDnWSkEmY6FCTgYyD+GXe1BVwdS4FxpCFsGry9hZTqlYYY+ERj58SSOiRGRA+I1MefemOUJv7FvADDrrZ67LgMGWTAYyNyZSITNvk1ZPmVmGajYbM7WBOKE7WFxJzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319762; c=relaxed/simple;
	bh=yPEpggvVYgRTK+qo2VSDS2wmWg/PsKskHvQIgsYNqI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FkKZuDBRoMjz+1Vi8q1neSIz8THwNk/EK9MRQmJ5xqP15Twfyg6OcunUj60s2Z5nEUqLY+LSb3LyZ4ZcsY+uCM0Gx6Wkn2Uct5J69wlpPz/fnNT48tCPAfnkUEpYRKR91PP1snp+CWNM8Hn0ghBCqfc6S1+HDW+zMuzi2W1LMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VinzE83B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D7EC433C7;
	Sun, 24 Mar 2024 22:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319761;
	bh=yPEpggvVYgRTK+qo2VSDS2wmWg/PsKskHvQIgsYNqI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VinzE83Bpg3AaZKT9SAJFbXxVcEZGb06Aq3iVV9EEgqKEuAChRIFDfJd7aDebOJoo
	 Dfxoj7e7FJkFSc+qBUxLoHsUItn21WuhziJroUyJZMtZHgolfPuiRdnuSoyFDFTP1j
	 Oz/uKUwQYDjp2vHUDmC26bNm1L9qIC6X7gq5glDu0Gn+ux6cqV2i+srth+fbaYsL4N
	 a9yzLQbj3AHAsLsOg/zlhosffmGdOoAUMpcqMdTHl3a4cFy+gWhOsdGE4Y4aWIwgus
	 KyuxsLr6m6S8a++ltYQ4HENxV76LgXXBPJBHttJEDpTQJbNcOzLclYEDY7NwEFKCrK
	 nRxVHirrhn37A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wen Gong <quic_wgong@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 062/715] wifi: ath11k: add support to select 6 GHz regulatory type
Date: Sun, 24 Mar 2024 18:24:01 -0400
Message-ID: <20240324223455.1342824-63-sashal@kernel.org>
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

From: Wen Gong <quic_wgong@quicinc.com>

[ Upstream commit e3d373ec4f02bf41379d91707e3e3f2a46464cd7 ]

There are 3 types of regulatory rules for AP mode and 6 type for
station mode. Add wmi_vdev_type and ieee80211_ap_reg_power to
select the exact reg rules.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231218085844.2658-2-quic_bqiang@quicinc.com
Stable-dep-of: cf2df0080bd5 ("wifi: ath11k: fix a possible dead lock caused by ab->base_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/reg.c | 70 +++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/reg.h |  6 ++-
 drivers/net/wireless/ath/ath11k/wmi.c |  3 +-
 3 files changed, 62 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index b4fd4d2107c71..78b99ab10c634 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -618,25 +618,68 @@ ath11k_reg_update_weather_radar_band(struct ath11k_base *ab,
 	*rule_idx = i;
 }
 
+enum wmi_reg_6ghz_ap_type
+ath11k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type)
+{
+	switch (power_type) {
+	case IEEE80211_REG_LPI_AP:
+		return WMI_REG_INDOOR_AP;
+	case IEEE80211_REG_SP_AP:
+		return WMI_REG_STANDARD_POWER_AP;
+	case IEEE80211_REG_VLP_AP:
+		return WMI_REG_VERY_LOW_POWER_AP;
+	default:
+		return WMI_REG_MAX_AP_TYPE;
+	}
+}
+
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
-		      struct cur_regulatory_info *reg_info, bool intersect)
+		      struct cur_regulatory_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type)
 {
 	struct ieee80211_regdomain *tmp_regd, *default_regd, *new_regd = NULL;
-	struct cur_reg_rule *reg_rule;
+	struct cur_reg_rule *reg_rule, *reg_rule_6ghz;
 	u8 i = 0, j = 0, k = 0;
 	u8 num_rules;
 	u16 max_bw;
-	u32 flags;
+	u32 flags, reg_6ghz_number, max_bw_6ghz;
 	char alpha2[3];
 
 	num_rules = reg_info->num_5ghz_reg_rules + reg_info->num_2ghz_reg_rules;
 
-	/* FIXME: Currently taking reg rules for 6 GHz only from Indoor AP mode list.
-	 * This can be updated after complete 6 GHz regulatory support is added.
-	 */
-	if (reg_info->is_ext_reg_event)
-		num_rules += reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP];
+	if (reg_info->is_ext_reg_event) {
+		if (vdev_type == WMI_VDEV_TYPE_STA) {
+			enum wmi_reg_6ghz_ap_type ap_type;
+
+			ap_type = ath11k_reg_ap_pwr_convert(power_type);
+
+			if (ap_type == WMI_REG_MAX_AP_TYPE)
+				ap_type = WMI_REG_INDOOR_AP;
+
+			reg_6ghz_number = reg_info->num_6ghz_rules_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+
+			if (reg_6ghz_number == 0) {
+				ap_type = WMI_REG_INDOOR_AP;
+				reg_6ghz_number = reg_info->num_6ghz_rules_client
+						[ap_type][WMI_REG_DEFAULT_CLIENT];
+			}
+
+			reg_rule_6ghz = reg_info->reg_rules_6ghz_client_ptr
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+			max_bw_6ghz = reg_info->max_bw_6ghz_client
+					[ap_type][WMI_REG_DEFAULT_CLIENT];
+		} else {
+			reg_6ghz_number = reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP];
+			reg_rule_6ghz =
+				reg_info->reg_rules_6ghz_ap_ptr[WMI_REG_INDOOR_AP];
+			max_bw_6ghz = reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP];
+		}
+
+		num_rules += reg_6ghz_number;
+	}
 
 	if (!num_rules)
 		goto ret;
@@ -683,13 +726,10 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 			 * per other BW rule flags we pass from here
 			 */
 			flags = NL80211_RRF_AUTO_BW;
-		} else if (reg_info->is_ext_reg_event &&
-			   reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP] &&
-			   (k < reg_info->num_6ghz_rules_ap[WMI_REG_INDOOR_AP])) {
-			reg_rule = reg_info->reg_rules_6ghz_ap_ptr[WMI_REG_INDOOR_AP] +
-				   k++;
-			max_bw = min_t(u16, reg_rule->max_bw,
-				       reg_info->max_bw_6ghz_ap[WMI_REG_INDOOR_AP]);
+		} else if (reg_info->is_ext_reg_event && reg_6ghz_number &&
+			   k < reg_6ghz_number) {
+			reg_rule = reg_rule_6ghz + k++;
+			max_bw = min_t(u16, reg_rule->max_bw, max_bw_6ghz);
 			flags = NL80211_RRF_AUTO_BW;
 		} else {
 			break;
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index f28902f85e419..989b27b16bea0 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -34,7 +34,11 @@ void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *
 ath11k_reg_build_regd(struct ath11k_base *ab,
-		      struct cur_regulatory_info *reg_info, bool intersect);
+		      struct cur_regulatory_info *reg_info, bool intersect,
+		      enum wmi_vdev_type vdev_type,
+		      enum ieee80211_ap_reg_power power_type);
 int ath11k_regd_update(struct ath11k *ar);
 int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait);
+enum wmi_reg_6ghz_ap_type
+ath11k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 8a65fa04b48d9..75c79c99faa9f 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -7151,7 +7151,8 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
 		intersect = true;
 
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect);
+	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
+				     WMI_VDEV_TYPE_AP, IEEE80211_REG_LPI_AP);
 	if (!regd) {
 		ath11k_warn(ab, "failed to build regd from reg_info\n");
 		goto fallback;
-- 
2.43.0


