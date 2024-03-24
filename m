Return-Path: <linux-kernel+bounces-113059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31E888123
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB5D1C214A3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3E91474A0;
	Sun, 24 Mar 2024 22:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OBKO+7sl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33FB146003;
	Sun, 24 Mar 2024 22:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319868; cv=none; b=itb1twZ4+Q8LzaHorA7Z1awJSq3978NIr9OrR9axgQLYHqQSlkpigjWf2mu+Qq30Lk0p/3vC/+uFMHQTErLWUs719S6Jo24LGXKH8t2YV3R42dz3diVetx/T0jp56W3qlKZYDh0Q0po4pTKNW7wNXYZmknRg809keXkrdrEvNDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319868; c=relaxed/simple;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5xxcvEev1YFNY6B0zlZfJqNmbryQkRGtXvjbEvMetrtojd5yx6DAUaTKbrYBdz+ouxYF2WDYKHYfdDjkABCxQTTEBDsvdOkNAYXhvQudPpNQmmhl1v3ekgGj0Af1T38bECf4ktvB//h2HoJ3EcXZ7GXA7PKoRCFAy90wqdR/gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OBKO+7sl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA12CC433F1;
	Sun, 24 Mar 2024 22:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319867;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OBKO+7slTxKBCgh9Vz7djSdm2L9URXoOneQvozyb1s5rJ6zMn4g7deAAsCZdMdr+/
	 l3x9jXT3IJ4k99hnzlkBFDyBqWCqFtwN1LgION4Aj30HLXYbUro+rnuwBr+fGebvg5
	 D3VEWxinlTaBfAVWL2ifUO2IhJbw4xtElreJ9SUlIHswYpHglvJlMor/rwN6Mw9iED
	 YkTimyA8pQaButRKuT6A13sg6XZnCanh64ENkB+IdxnRUywt6yLB5RY0nXf08oqMyY
	 DGZtI8JxWXv6yV3hQY7zS/0/qf2LVCIq7XtoOr/s8umsGPmCcdvr6mLSzuAe7dXx3+
	 brPFbRaRi4HLg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 172/715] wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
Date: Sun, 24 Mar 2024 18:25:51 -0400
Message-ID: <20240324223455.1342824-173-sashal@kernel.org>
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


