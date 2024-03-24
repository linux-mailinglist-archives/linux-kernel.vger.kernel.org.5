Return-Path: <linux-kernel+bounces-112950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA12887FFF
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 049A0B22A5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9962683CA1;
	Sun, 24 Mar 2024 22:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HT6oKMJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B2839F7;
	Sun, 24 Mar 2024 22:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319763; cv=none; b=twC7r0l5xnnTD7AqbgBR/r1BHRphJzKjrNpjhaNXsm7bEnfOl419BTgkyyhASONaZd/cwnTitZcb6tABKrCeLHPGpdOFBf58EfLDUsCnZtE3JciV+QNM9CrIxnVNk6dKMs6+xpIYo1b4kYXm4fhwX3Zt7iPENw5iJcLFGElMwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319763; c=relaxed/simple;
	bh=ij/exhe6MxlvYzSaAUW5lT8UHw3ffcYZANUvmXuzxr4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDUyQH5qocBvcggd3MiFAzSGUe8rcyz2p7fk+eW0xz3eCxDj2RnAmW27oqhZTaRfTuRtaf3QFNQfLIiCvXkT/A1Vq5HRQwp/DgxQnMuhXu3n0mqLivnaPwwLRxxXoPzBOWIXVsAD8YS6OSLrxJk4cVI+X/fhlGAJll2EN9T8Ax8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HT6oKMJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78EDC43390;
	Sun, 24 Mar 2024 22:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319762;
	bh=ij/exhe6MxlvYzSaAUW5lT8UHw3ffcYZANUvmXuzxr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HT6oKMJEZecihl8jkWlr/mSx2WKyO+SYFVYNJbzGZKP30bGeI3brhTxONQutrScvJ
	 GjPtCn95/tA0GibveLaWO2UI+cDE1CACcA0Ow+UFeADFUrTfj9ZrvKJq83Mf+92U0v
	 eNoYRgEhmFEm+FRu1RrjHa+uNOqne8yJUB2W8rzQgVGKUpOC1W+j6T5AtFptA2cgpe
	 sP9U3+4KXIwoTpRs5tWNiculrBs723nORdjtsJZfEdKi3gguNg0Kx43WM4Ci9VGusY
	 ta/3E0LOB7B39U2GT/ThFy9GvagULT9rdh7jSC/Yu0fZD/GtYqpXlyyGd7XBDprsnp
	 zRSUbC6SiNHBg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Wen Gong <quic_wgong@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Baochen Qiang <quic_bqiang@quicinc.com>,
	Kalle Valo <quic_kvalo@quicinc.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 063/715] wifi: ath11k: store cur_regulatory_info for each radio
Date: Sun, 24 Mar 2024 18:24:02 -0400
Message-ID: <20240324223455.1342824-64-sashal@kernel.org>
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

[ Upstream commit 7004bdceef605e5c1c5ab4aaf282002ad7523ddd ]

The regulatory info of WMI_REG_CHAN_LIST_CC_EXT_EVENTID is not saved
in ath11k now, the info should be saved in ath11k. Save the info for
each radio and support switch regulatory rules dynamically.

As mac.c will also call ath11k_reg_handle_chan_list() in next patches move the
function to reg.c.

Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23

Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
Link: https://msgid.link/20231218085844.2658-3-quic_bqiang@quicinc.com
Stable-dep-of: cf2df0080bd5 ("wifi: ath11k: fix a possible dead lock caused by ab->base_lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/ath/ath11k/core.h |   1 +
 drivers/net/wireless/ath/ath11k/reg.c  | 179 +++++++++++++++++++++++++
 drivers/net/wireless/ath/ath11k/reg.h  |   5 +
 drivers/net/wireless/ath/ath11k/wmi.c  | 148 +++-----------------
 drivers/net/wireless/ath/ath11k/wmi.h  |   1 +
 5 files changed, 207 insertions(+), 127 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 02e160d831bed..cd829ec70d76b 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -918,6 +918,7 @@ struct ath11k_base {
 	 * This may or may not be used during the runtime
 	 */
 	struct ieee80211_regdomain *new_regd[MAX_RADIOS];
+	struct cur_regulatory_info *reg_info_store;
 
 	/* Current DFS Regulatory */
 	enum ath11k_dfs_region dfs_region;
diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
index 78b99ab10c634..adcd9063a59c3 100644
--- a/drivers/net/wireless/ath/ath11k/reg.c
+++ b/drivers/net/wireless/ath/ath11k/reg.c
@@ -798,6 +798,159 @@ ath11k_reg_build_regd(struct ath11k_base *ab,
 	return new_regd;
 }
 
+static bool ath11k_reg_is_world_alpha(char *alpha)
+{
+	if (alpha[0] == '0' && alpha[1] == '0')
+		return true;
+
+	if (alpha[0] == 'n' && alpha[1] == 'a')
+		return true;
+
+	return false;
+}
+
+static enum wmi_vdev_type ath11k_reg_get_ar_vdev_type(struct ath11k *ar)
+{
+	struct ath11k_vif *arvif;
+
+	/* Currently each struct ath11k maps to one struct ieee80211_hw/wiphy
+	 * and one struct ieee80211_regdomain, so it could only store one group
+	 * reg rules. It means multi-interface concurrency in the same ath11k is
+	 * not support for the regdomain. So get the vdev type of the first entry
+	 * now. After concurrency support for the regdomain, this should change.
+	 */
+	arvif = list_first_entry_or_null(&ar->arvifs, struct ath11k_vif, list);
+	if (arvif)
+		return arvif->vdev_type;
+
+	return WMI_VDEV_TYPE_UNSPEC;
+}
+
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type)
+{
+	struct ieee80211_regdomain *regd;
+	bool intersect = false;
+	int pdev_idx;
+	struct ath11k *ar;
+	enum wmi_vdev_type vdev_type;
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg handle chan list");
+
+	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
+		/* In case of failure to set the requested ctry,
+		 * fw retains the current regd. We print a failure info
+		 * and return from here.
+		 */
+		ath11k_warn(ab, "Failed to set the requested Country regulatory setting\n");
+		return -EINVAL;
+	}
+
+	pdev_idx = reg_info->phy_id;
+
+	/* Avoid default reg rule updates sent during FW recovery if
+	 * it is already available
+	 */
+	spin_lock(&ab->base_lock);
+	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
+	    ab->default_regd[pdev_idx]) {
+		spin_unlock(&ab->base_lock);
+		goto retfail;
+	}
+	spin_unlock(&ab->base_lock);
+
+	if (pdev_idx >= ab->num_radios) {
+		/* Process the event for phy0 only if single_pdev_only
+		 * is true. If pdev_idx is valid but not 0, discard the
+		 * event. Otherwise, it goes to fallback. In either case
+		 * ath11k_reg_reset_info() needs to be called to avoid
+		 * memory leak issue.
+		 */
+		ath11k_reg_reset_info(reg_info);
+
+		if (ab->hw_params.single_pdev_only &&
+		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
+			return 0;
+		goto fallback;
+	}
+
+	/* Avoid multiple overwrites to default regd, during core
+	 * stop-start after mac registration.
+	 */
+	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
+	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
+		    (char *)reg_info->alpha2, 2))
+		goto retfail;
+
+	/* Intersect new rules with default regd if a new country setting was
+	 * requested, i.e a default regd was already set during initialization
+	 * and the regd coming from this event has a valid country info.
+	 */
+	if (ab->default_regd[pdev_idx] &&
+	    !ath11k_reg_is_world_alpha((char *)
+		ab->default_regd[pdev_idx]->alpha2) &&
+	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
+		intersect = true;
+
+	ar = ab->pdevs[pdev_idx].ar;
+	vdev_type = ath11k_reg_get_ar_vdev_type(ar);
+
+	ath11k_dbg(ab, ATH11K_DBG_WMI,
+		   "wmi handle chan list power type %d vdev type %d intersect %d\n",
+		   power_type, vdev_type, intersect);
+
+	regd = ath11k_reg_build_regd(ab, reg_info, intersect, vdev_type, power_type);
+	if (!regd) {
+		ath11k_warn(ab, "failed to build regd from reg_info\n");
+		goto fallback;
+	}
+
+	if (power_type == IEEE80211_REG_UNSET_AP) {
+		ath11k_reg_reset_info(&ab->reg_info_store[pdev_idx]);
+		ab->reg_info_store[pdev_idx] = *reg_info;
+	}
+
+	spin_lock(&ab->base_lock);
+	if (ab->default_regd[pdev_idx]) {
+		/* The initial rules from FW after WMI Init is to build
+		 * the default regd. From then on, any rules updated for
+		 * the pdev could be due to user reg changes.
+		 * Free previously built regd before assigning the newly
+		 * generated regd to ar. NULL pointer handling will be
+		 * taken care by kfree itself.
+		 */
+		ar = ab->pdevs[pdev_idx].ar;
+		kfree(ab->new_regd[pdev_idx]);
+		ab->new_regd[pdev_idx] = regd;
+		queue_work(ab->workqueue, &ar->regd_update_work);
+	} else {
+		/* This regd would be applied during mac registration and is
+		 * held constant throughout for regd intersection purpose
+		 */
+		ab->default_regd[pdev_idx] = regd;
+	}
+	ab->dfs_region = reg_info->dfs_region;
+	spin_unlock(&ab->base_lock);
+
+	return 0;
+
+fallback:
+	/* Fallback to older reg (by sending previous country setting
+	 * again if fw has succeeded and we failed to process here.
+	 * The Regdomain should be uniform across driver and fw. Since the
+	 * FW has processed the command and sent a success status, we expect
+	 * this function to succeed as well. If it doesn't, CTRY needs to be
+	 * reverted at the fw and the old SCAN_CHAN_LIST cmd needs to be sent.
+	 */
+	/* TODO: This is rare, but still should also be handled */
+	WARN_ON(1);
+
+retfail:
+
+	return -EINVAL;
+}
+
 void ath11k_regd_update_work(struct work_struct *work)
 {
 	struct ath11k *ar = container_of(work, struct ath11k,
@@ -821,10 +974,36 @@ void ath11k_reg_init(struct ath11k *ar)
 	ar->hw->wiphy->reg_notifier = ath11k_reg_notifier;
 }
 
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info)
+{
+	int i, j;
+
+	if (!reg_info)
+		return;
+
+	kfree(reg_info->reg_rules_2ghz_ptr);
+	kfree(reg_info->reg_rules_5ghz_ptr);
+
+	for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++) {
+		kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
+
+		for (j = 0; j < WMI_REG_MAX_CLIENT_TYPE; j++)
+			kfree(reg_info->reg_rules_6ghz_client_ptr[i][j]);
+	}
+
+	memset(reg_info, 0, sizeof(*reg_info));
+}
+
 void ath11k_reg_free(struct ath11k_base *ab)
 {
 	int i;
 
+	for (i = 0; i < ab->num_radios; i++)
+		ath11k_reg_reset_info(&ab->reg_info_store[i]);
+
+	kfree(ab->reg_info_store);
+	ab->reg_info_store = NULL;
+
 	for (i = 0; i < ab->hw_params.max_radios; i++) {
 		kfree(ab->default_regd[i]);
 		kfree(ab->new_regd[i]);
diff --git a/drivers/net/wireless/ath/ath11k/reg.h b/drivers/net/wireless/ath/ath11k/reg.h
index 989b27b16bea0..64edb794260ab 100644
--- a/drivers/net/wireless/ath/ath11k/reg.h
+++ b/drivers/net/wireless/ath/ath11k/reg.h
@@ -30,6 +30,7 @@ enum ath11k_dfs_region {
 
 /* ATH11K Regulatory API's */
 void ath11k_reg_init(struct ath11k *ar);
+void ath11k_reg_reset_info(struct cur_regulatory_info *reg_info);
 void ath11k_reg_free(struct ath11k_base *ab);
 void ath11k_regd_update_work(struct work_struct *work);
 struct ieee80211_regdomain *
@@ -41,4 +42,8 @@ int ath11k_regd_update(struct ath11k *ar);
 int ath11k_reg_update_chan_list(struct ath11k *ar, bool wait);
 enum wmi_reg_6ghz_ap_type
 ath11k_reg_ap_pwr_convert(enum ieee80211_ap_reg_power power_type);
+int ath11k_reg_handle_chan_list(struct ath11k_base *ab,
+				struct cur_regulatory_info *reg_info,
+				enum ieee80211_ap_reg_power power_type);
+
 #endif
diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 75c79c99faa9f..442afda7ec885 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -4749,6 +4749,14 @@ static int ath11k_wmi_tlv_ext_soc_hal_reg_caps_parse(struct ath11k_base *soc,
 		soc->pdevs[0].pdev_id = 0;
 	}
 
+	if (!soc->reg_info_store) {
+		soc->reg_info_store = kcalloc(soc->num_radios,
+					      sizeof(*soc->reg_info_store),
+					      GFP_ATOMIC);
+		if (!soc->reg_info_store)
+			return -ENOMEM;
+	}
+
 	return 0;
 }
 
@@ -7060,32 +7068,15 @@ static void ath11k_wmi_htc_tx_complete(struct ath11k_base *ab,
 		wake_up(&wmi->tx_ce_desc_wq);
 }
 
-static bool ath11k_reg_is_world_alpha(char *alpha)
-{
-	if (alpha[0] == '0' && alpha[1] == '0')
-		return true;
-
-	if (alpha[0] == 'n' && alpha[1] == 'a')
-		return true;
-
-	return false;
-}
-
-static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
-				      struct sk_buff *skb,
+static int ath11k_reg_chan_list_event(struct ath11k_base *ab, struct sk_buff *skb,
 				      enum wmi_reg_chan_list_cmd_type id)
 {
-	struct cur_regulatory_info *reg_info = NULL;
-	struct ieee80211_regdomain *regd = NULL;
-	bool intersect = false;
-	int ret = 0, pdev_idx, i, j;
-	struct ath11k *ar;
+	struct cur_regulatory_info *reg_info;
+	int ret;
 
 	reg_info = kzalloc(sizeof(*reg_info), GFP_ATOMIC);
-	if (!reg_info) {
-		ret = -ENOMEM;
-		goto fallback;
-	}
+	if (!reg_info)
+		return -ENOMEM;
 
 	if (id == WMI_REG_CHAN_LIST_CC_ID)
 		ret = ath11k_pull_reg_chan_list_update_ev(ab, skb, reg_info);
@@ -7093,119 +7084,22 @@ static int ath11k_reg_chan_list_event(struct ath11k_base *ab,
 		ret = ath11k_pull_reg_chan_list_ext_update_ev(ab, skb, reg_info);
 
 	if (ret) {
-		ath11k_warn(ab, "failed to extract regulatory info from received event\n");
-		goto fallback;
-	}
-
-	ath11k_dbg(ab, ATH11K_DBG_WMI, "event reg chan list id %d", id);
-
-	if (reg_info->status_code != REG_SET_CC_STATUS_PASS) {
-		/* In case of failure to set the requested ctry,
-		 * fw retains the current regd. We print a failure info
-		 * and return from here.
-		 */
-		ath11k_warn(ab, "Failed to set the requested Country regulatory setting\n");
-		goto mem_free;
-	}
-
-	pdev_idx = reg_info->phy_id;
-
-	/* Avoid default reg rule updates sent during FW recovery if
-	 * it is already available
-	 */
-	spin_lock(&ab->base_lock);
-	if (test_bit(ATH11K_FLAG_RECOVERY, &ab->dev_flags) &&
-	    ab->default_regd[pdev_idx]) {
-		spin_unlock(&ab->base_lock);
+		ath11k_warn(ab, "failed to extract regulatory info\n");
 		goto mem_free;
 	}
-	spin_unlock(&ab->base_lock);
 
-	if (pdev_idx >= ab->num_radios) {
-		/* Process the event for phy0 only if single_pdev_only
-		 * is true. If pdev_idx is valid but not 0, discard the
-		 * event. Otherwise, it goes to fallback.
-		 */
-		if (ab->hw_params.single_pdev_only &&
-		    pdev_idx < ab->hw_params.num_rxmda_per_pdev)
-			goto mem_free;
-		else
-			goto fallback;
-	}
-
-	/* Avoid multiple overwrites to default regd, during core
-	 * stop-start after mac registration.
-	 */
-	if (ab->default_regd[pdev_idx] && !ab->new_regd[pdev_idx] &&
-	    !memcmp((char *)ab->default_regd[pdev_idx]->alpha2,
-		    (char *)reg_info->alpha2, 2))
+	ret = ath11k_reg_handle_chan_list(ab, reg_info, IEEE80211_REG_UNSET_AP);
+	if (ret) {
+		ath11k_warn(ab, "failed to process regulatory info %d\n", ret);
 		goto mem_free;
-
-	/* Intersect new rules with default regd if a new country setting was
-	 * requested, i.e a default regd was already set during initialization
-	 * and the regd coming from this event has a valid country info.
-	 */
-	if (ab->default_regd[pdev_idx] &&
-	    !ath11k_reg_is_world_alpha((char *)
-		ab->default_regd[pdev_idx]->alpha2) &&
-	    !ath11k_reg_is_world_alpha((char *)reg_info->alpha2))
-		intersect = true;
-
-	regd = ath11k_reg_build_regd(ab, reg_info, intersect,
-				     WMI_VDEV_TYPE_AP, IEEE80211_REG_LPI_AP);
-	if (!regd) {
-		ath11k_warn(ab, "failed to build regd from reg_info\n");
-		goto fallback;
-	}
-
-	spin_lock(&ab->base_lock);
-	if (ab->default_regd[pdev_idx]) {
-		/* The initial rules from FW after WMI Init is to build
-		 * the default regd. From then on, any rules updated for
-		 * the pdev could be due to user reg changes.
-		 * Free previously built regd before assigning the newly
-		 * generated regd to ar. NULL pointer handling will be
-		 * taken care by kfree itself.
-		 */
-		ar = ab->pdevs[pdev_idx].ar;
-		kfree(ab->new_regd[pdev_idx]);
-		ab->new_regd[pdev_idx] = regd;
-		queue_work(ab->workqueue, &ar->regd_update_work);
-	} else {
-		/* This regd would be applied during mac registration and is
-		 * held constant throughout for regd intersection purpose
-		 */
-		ab->default_regd[pdev_idx] = regd;
 	}
-	ab->dfs_region = reg_info->dfs_region;
-	spin_unlock(&ab->base_lock);
 
-	goto mem_free;
+	kfree(reg_info);
+	return 0;
 
-fallback:
-	/* Fallback to older reg (by sending previous country setting
-	 * again if fw has succeeded and we failed to process here.
-	 * The Regdomain should be uniform across driver and fw. Since the
-	 * FW has processed the command and sent a success status, we expect
-	 * this function to succeed as well. If it doesn't, CTRY needs to be
-	 * reverted at the fw and the old SCAN_CHAN_LIST cmd needs to be sent.
-	 */
-	/* TODO: This is rare, but still should also be handled */
-	WARN_ON(1);
 mem_free:
-	if (reg_info) {
-		kfree(reg_info->reg_rules_2ghz_ptr);
-		kfree(reg_info->reg_rules_5ghz_ptr);
-		if (reg_info->is_ext_reg_event) {
-			for (i = 0; i < WMI_REG_CURRENT_MAX_AP_TYPE; i++)
-				kfree(reg_info->reg_rules_6ghz_ap_ptr[i]);
-
-			for (j = 0; j < WMI_REG_CURRENT_MAX_AP_TYPE; j++)
-				for (i = 0; i < WMI_REG_MAX_CLIENT_TYPE; i++)
-					kfree(reg_info->reg_rules_6ghz_client_ptr[j][i]);
-		}
-		kfree(reg_info);
-	}
+	ath11k_reg_reset_info(reg_info);
+	kfree(reg_info);
 	return ret;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index ff0a9a92beeb0..cd2098d78e861 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -4951,6 +4951,7 @@ struct ath11k_targ_cap {
 };
 
 enum wmi_vdev_type {
+	WMI_VDEV_TYPE_UNSPEC =  0,
 	WMI_VDEV_TYPE_AP      = 1,
 	WMI_VDEV_TYPE_STA     = 2,
 	WMI_VDEV_TYPE_IBSS    = 3,
-- 
2.43.0


