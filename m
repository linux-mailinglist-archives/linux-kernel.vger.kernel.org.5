Return-Path: <linux-kernel+bounces-115634-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5E3889CF2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA71F35D17
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8227534D45F;
	Mon, 25 Mar 2024 02:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G1fO2aqS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE49132C37;
	Sun, 24 Mar 2024 23:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321472; cv=none; b=UTVYF3JZcwyT+Gk3fxNW/kglmmM0IBMgqWf/VLKuu7mUAJ2jFuD4o3gKCJcXUwhs1trA0mzTwg+dL0zcsqCZ1WjA1VZsJ6lwtYnTmnT4f3hI3RY2WmfVJ8GE8zKSnJ22Gt1Wjar0EjpESHPMfCFioiLu3QIgb5CRH/wE8v2RUlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321472; c=relaxed/simple;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IMOkWZlEd0FKE+tZ93xxBN93OkRv7H1UgnyWiuno1BYKc/EyikvJ92AdmNgCUkgki2mcPazH+aq7xffCE9ugefgwJwOuNV2tU5Dl4FRUeKCgAO401LoMWYCuVudKQppmRIsbbOZhDcE2o3A9H3otkQRfGQWyg5liQR900p1uZJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G1fO2aqS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730FBC433C7;
	Sun, 24 Mar 2024 23:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321472;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G1fO2aqSrjRzqyFIXNa4OzgIUy8jXNGB9tldZEnaz0iquAcBlT6psk4KHLYxTTT0Z
	 p0BYAng+dL56QuQkIeDC5P8lrBUPBiWP5McvVzFgpm2Xy0HxggSgR4SWvdezQ5GWKy
	 1955xHgraJej3M5oir0U4tiPQoG3T1PhGNCYBkthcG7NmAwcIad2kf+DgSAONQ24dh
	 O7OvaVVPDwNKPlyiwzQ0jU5wjiGJhWJzybozKQif12qENSvQOh79tS8xPSpEdLGqvy
	 keIlvmzx6Kw9mwwLAfAq8pgJ1ucyF9CRYU14lsVSExXenAt8344eSqxxl0oIC/kJQS
	 pGBQZf8opffGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 197/638] wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
Date: Sun, 24 Mar 2024 18:53:54 -0400
Message-ID: <20240324230116.1348576-198-sashal@kernel.org>
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

From: Emmanuel Grumbach <emmanuel.grumbach@intel.com>

[ Upstream commit e35f316bce9e5733c9826120c1838f4c447b2c4c ]

The firmware doesn't need the MFP flag for the GTK, it can even make the
firmware crash. in case the AP is configured with: group cipher TKIP and
MFPC. We would send the GTK with cipher = TKIP and MFP which is of course
not possible.

Fixes: 5c75a208c244 ("wifi: iwlwifi: mvm: support new key API")
Signed-off-by: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240206175739.2f2c602ab3c6.If13b2e2fa532381d985c07df130bee1478046c89@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c   | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
index ea3e9e9c6e26c..fe4b39b19a612 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mld-key.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 /*
- * Copyright (C) 2022 - 2023 Intel Corporation
+ * Copyright (C) 2022 - 2024 Intel Corporation
  */
 #include <linux/kernel.h>
 #include <net/mac80211.h>
@@ -62,11 +62,13 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 			  struct ieee80211_key_conf *keyconf)
 {
 	struct iwl_mvm_vif *mvmvif = iwl_mvm_vif_from_mac80211(vif);
+	bool pairwise = keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE;
+	bool igtk = keyconf->keyidx == 4 || keyconf->keyidx == 5;
 	u32 flags = 0;
 
 	lockdep_assert_held(&mvm->mutex);
 
-	if (!(keyconf->flags & IEEE80211_KEY_FLAG_PAIRWISE))
+	if (!pairwise)
 		flags |= IWL_SEC_KEY_FLAG_MCAST_KEY;
 
 	switch (keyconf->cipher) {
@@ -96,12 +98,14 @@ u32 iwl_mvm_get_sec_flags(struct iwl_mvm *mvm,
 	if (!sta && vif->type == NL80211_IFTYPE_STATION)
 		sta = mvmvif->ap_sta;
 
-	/* Set the MFP flag also for an AP interface where the key is an IGTK
-	 * key as in such a case the station would always be NULL
+	/*
+	 * If we are installing an iGTK (in AP or STA mode), we need to tell
+	 * the firmware this key will en/decrypt MGMT frames.
+	 * Same goes if we are installing a pairwise key for an MFP station.
+	 * In case we're installing a groupwise key (which is not an iGTK),
+	 * then, we will not use this key for MGMT frames.
 	 */
-	if ((!IS_ERR_OR_NULL(sta) && sta->mfp) ||
-	    (vif->type == NL80211_IFTYPE_AP &&
-	     (keyconf->keyidx == 4 || keyconf->keyidx == 5)))
+	if ((!IS_ERR_OR_NULL(sta) && sta->mfp && pairwise) || igtk)
 		flags |= IWL_SEC_KEY_FLAG_MFP;
 
 	return flags;
-- 
2.43.0


