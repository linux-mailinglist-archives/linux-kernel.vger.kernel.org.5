Return-Path: <linux-kernel+bounces-113015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6A08880C9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:05:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8371D1F25EA1
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195B51369AC;
	Sun, 24 Mar 2024 22:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mJUXivtc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5647A136665;
	Sun, 24 Mar 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319826; cv=none; b=GNFp7AzFHc9g8+cmChD+05fVndVHBOA0dhgTy0WzjoHQwPCsSXfzCV/FDumBMJR4bsTcyUFBcfMvGziyMuifzt4v93IJwlwgvqNTb9TeP1a+X0UDM7r4l0BschUD/4BUy8pBYrl3v5Nq01QaO7V2tRlSuGz1d09mPXYkbBxpaHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319826; c=relaxed/simple;
	bh=Sq1yoVc+QhRAvCHnEwpkbv8UNUqdJphlqJF9/OpnzFY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeufralqTNuJfiJqxytRfjNv4k6EA1RyFxPzLHELj2bP3l5sBAGqNuKHdFTlwICpRvAjMwLJQX/K79SIPE2qQ4mPUaKE4a/yW7nAHY7szvL2/13n2Wwc+9YBdp7AfZMEso6S608v1zG8I3ekQEg3b4CnJVrF5NFhP0hgD5Jns8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mJUXivtc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500F1C43394;
	Sun, 24 Mar 2024 22:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319825;
	bh=Sq1yoVc+QhRAvCHnEwpkbv8UNUqdJphlqJF9/OpnzFY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mJUXivtcn1s3EToq+Zduqj+4VHF+n7IBJtM27GXTxnGMmSjQScdbBlID72amVjYZ7
	 vJ+l5gpeYUZxi1caQkKcZmi5rZNKlSVbs5+NDlHwSWLQ+xTyIciZoWNpoc2ef1Tnhl
	 lDCl/N+i9I/nPkJP4txytw2w3ZhQwd86B/mFDLTxoXtN19Ka9A3xblEPZTNZ0Fvebe
	 9Uqx5mD8yDXfkdJroKRIbJgYuB691s0cX8pUSGLyCI0xSOV07gWSuFXNtwnfdp+OBf
	 5jNldwQOaSWkxQ+LBtwAF8zWIC3x2b99+SeH4uwMez1wOdr1p539DO7MtCX3ZPfwGT
	 jJlkGCX9NKfIQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 128/715] wifi: iwlwifi: mvm: initialize rates in FW earlier
Date: Sun, 24 Mar 2024 18:25:07 -0400
Message-ID: <20240324223455.1342824-129-sashal@kernel.org>
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

[ Upstream commit d3b2c6c65bfd3b9616084e91bd0d402964ea7cef ]

When connecting to an AP, we currently initialize the rate
control only after associating. Since we now use firmware
to assign rates to auth/assoc frames rather than using the
data in the station and the firmware doesn't know, they're
transmitted using low mandatory rates. However, if the AP
advertised only higher supported rates we want to use them
to be nicer (it still must receive mandatory rates though),
so send the information to the firmware earlier to have it
know about it and be able to use it.

Fixes: 499d02790495 ("wifi: iwlwifi: Use FW rate for non-data frames")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240128084842.ed7ab1c859c2.I4b4d4fc3905c8d8470fc0fee4648f25c950c9bb7@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
index 53e26c3c3a9af..346512696bd1c 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3698,6 +3698,19 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
 		mvmvif->ap_sta = sta;
 
+	/*
+	 * Initialize the rates here already - this really tells
+	 * the firmware only what the supported legacy rates are
+	 * (may be) since it's initialized already from what the
+	 * AP advertised in the beacon/probe response. This will
+	 * allow the firmware to send auth/assoc frames with one
+	 * of the supported rates already, rather than having to
+	 * use a mandatory rate.
+	 * If we're the AP, we'll just assume mandatory rates at
+	 * this point, but we know nothing about the STA anyway.
+	 */
+	iwl_mvm_rs_rate_init_all_links(mvm, vif, sta);
+
 	return 0;
 }
 
-- 
2.43.0


