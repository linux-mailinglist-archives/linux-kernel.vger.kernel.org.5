Return-Path: <linux-kernel+bounces-113690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 300D988860D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B0B31F24790
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49B2E1E304A;
	Sun, 24 Mar 2024 22:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PiFxs/Pp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6685279;
	Sun, 24 Mar 2024 22:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320667; cv=none; b=fejY1QwvbtFe0O2WDrEWFdkfq+6WiYnroWTfDsuk6TR4Wu3WIEdCET7QQDqgyj7Uz4FpQBCinO6KEaBVVBt5MlcbnENnWWziuqzuP3TipQrRKyD6QohpHYf+2x0Zsu1CWnQOsGsIavYQ+ehYjmRU6RQcigHdHz40LePJu8a/Ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320667; c=relaxed/simple;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k2Pr7RFtu+/jdcJp1PGqlN3w/XftgMIPxghbKKOMn2yuOu5HgsV0q0ezNyJ7FMIAnSdxKdw20ezkvf88FsU3rrlukthJfNTtyZSwnSMFE4K64GMW0xddAvePVlgROxNj7CQUAtNv4AftN6cDJOh5LRNgdFN1hrLrbMD3WwyLV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PiFxs/Pp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F80C433F1;
	Sun, 24 Mar 2024 22:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320666;
	bh=qBDDt3UEpEEh1v+s/AaZiH9vTDwgz70LlK5QGjZqtYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PiFxs/PpL1rxV15WRXiS0kF1w9PL7sDoBHZVDojtXyDr8WBo5lB24L8FD88yZUKq0
	 p0juc95Pk32EdiVF5X4+/c1U9cqf19GFfoEQmROGN2UZgUkIepGf9S4BfFuy6N/ANG
	 dBOOddIBvHCfmHKLPk53AxR8jcaqdRQ+Mt2EPcgikDtUM3A9aD0cJzT3zzuQHYxOkg
	 yOj4sAJ0xpeR0D7NGpWRyd9S51q/f7YbS2HGqrZ1jpcWhRuqpfbXa6mkcTq37+bgaY
	 C4j0g8BUXycf2I/X+/6I4uFkn1av42idiia6qCkERpcy3izmtCmtqSAWR5uZjcrhh4
	 SgB+NtgXuDaCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 229/713] wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
Date: Sun, 24 Mar 2024 18:39:15 -0400
Message-ID: <20240324224720.1345309-230-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


