Return-Path: <linux-kernel+bounces-114137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C633A8888AC
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82959287A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F494161326;
	Sun, 24 Mar 2024 23:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NvckwecM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E182036F1;
	Sun, 24 Mar 2024 23:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321448; cv=none; b=Nc8s/OYUWOYkZetIf0gSjTTZhQzNVQaO6ov43qVVf9NXsBPou4lXMS5Jn9L3wQtVr5UR6Z2a7XO6HlP/7JXo7ZcehGwAPLqRnOU8+UObJe1slowjy1s0SYxb4mAYcWDV7cFvLPpax/5wlDYReykR73Xj3Fb7C+UNuOPr5q72y/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321448; c=relaxed/simple;
	bh=43WdgCSPZo0+IeFhl/e2013WXv4p2treUau15qmUiq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1SgmwKo6BhLgHfWgF0tL1Zf/UyKJAN56etL9Gv2uM9YHqNZa/4/QNgZyjF04PBIdNNSHLZgKGUOnd1Hp8nk5nicpmOwCAKFCTdjB9VVQeuX5LJBpfpuV/WSK8ufTmG/KkTH6ISCnA21V5Le4qkq9ENPfq/cgae41JxQcR6MKyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NvckwecM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC5FC43394;
	Sun, 24 Mar 2024 23:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321447;
	bh=43WdgCSPZo0+IeFhl/e2013WXv4p2treUau15qmUiq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NvckwecM8vCYOHxExzH6YgSxVAI5KCSVZcxZ9VtJjv4ptrSaaRsW4gKwsy9gMHOkS
	 15SZ7Edvfp2eqP420UjLnRsRwyX2sxjvzWngMnbwZIDEKqpdWdHrG1uusqbJ48QOUJ
	 hccCv8w/K/SO9odDPvosGqiUfh9bzLe9V3TD1RXu6JJaxOG26sVgc2dQ2vVWdLdesP
	 ihXsOGtDpmD1zhR11kTd9630kqJyKgMvyh4E+Pfbq+C3i3AV388EpjFEfNyNc4yzUk
	 qxtQxrKarIHa8S8IsFsx8HrFkf+GcLxYlXRNFqxgLiPGF8cqlrkvfDJQF0p5PJU2lW
	 /ptbX2N1bYQ7Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 171/638] wifi: iwlwifi: mvm: initialize rates in FW earlier
Date: Sun, 24 Mar 2024 18:53:28 -0400
Message-ID: <20240324230116.1348576-172-sashal@kernel.org>
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
index 0aeca64725da6..42da8e94900cf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/mac80211.c
@@ -3677,6 +3677,19 @@ iwl_mvm_sta_state_notexist_to_none(struct iwl_mvm *mvm,
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


