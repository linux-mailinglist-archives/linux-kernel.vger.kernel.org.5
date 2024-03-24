Return-Path: <linux-kernel+bounces-115373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3EF889B29
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DED8929C881
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09681F23ED;
	Mon, 25 Mar 2024 02:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/Mg5/h1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD1E14389A;
	Sun, 24 Mar 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320630; cv=none; b=FWnwj2hZHO/KPFIjvSpPzQCBqEQAm+CS20sU99X5o4CcrYRbFOHucZObTXD8XvjiaNCvDBdqh9n2Hne/4hk2ztYrJHjvLzAwSqTc9ZANXA0gOcfbpXM8jitleF8I9ykEk+jj5kUNtZvB88BZCnp9ASGKKJu3MSP7w3HFp0NyJSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320630; c=relaxed/simple;
	bh=7vxP6PLAGfDXn8ffRJn+H+EcA1AEGDOTmyoiPNJ0bEI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo+krp8rN4NIwSSM2/5rugVuuC7vg4YAsc32zjmIP0IP2n8pOvgcno9vwgA1Q+IwRf4bHuzHi/PrGSXzjUv1S9FmzPAbt98A1nlxDCv0eZUsB8yT2h2wbL+yTf4V0F+q41TZlZz9I6hZqJ8cEmDQFgKoCHv9ZP1sfiumxi8aZo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/Mg5/h1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23D20C43394;
	Sun, 24 Mar 2024 22:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320629;
	bh=7vxP6PLAGfDXn8ffRJn+H+EcA1AEGDOTmyoiPNJ0bEI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G/Mg5/h1OkTXGxUxIeV+83XWOWqCI9fnPs759UjRfp0oAgFaaIfVc/d3hmBp7iZMq
	 dxg12SWzjVD1ZfF7EM5CSOKlhDzwnsQuZGMiuP1B/ucUdIiNjB4HCXrmEU4y+fslKw
	 s4XWEh3dtr02jPcfgIymbJ2b1abTiRTXV90ym1F1Zc7fJthXnuRe7EZhnI4sGO3vcQ
	 NequFCLNE7U+CLmjNbltmn6lmRFJFMgeF5+i4h+X4/12dr9V4RVeC87YM60s3W/Fii
	 5hHZNyxn9tpeOXgxl4/BGTE3kSn4T54TvNKrnM2yrPbN+upmHGCoxPsVRxupez30aq
	 qQYyjQGqEYmvA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 191/713] wifi: iwlwifi: mvm: initialize rates in FW earlier
Date: Sun, 24 Mar 2024 18:38:37 -0400
Message-ID: <20240324224720.1345309-192-sashal@kernel.org>
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
index 350dc6b8a3302..b87173bb61f24 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3684,6 +3684,19 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
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


