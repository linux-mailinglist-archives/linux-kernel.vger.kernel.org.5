Return-Path: <linux-kernel+bounces-50392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 123C0847868
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27ED287F6F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C1213B290;
	Fri,  2 Feb 2024 18:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ntq6dsLz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9E154452;
	Fri,  2 Feb 2024 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899262; cv=none; b=tS/m0wkLkQuaffJytuAR//fYJrbwnQ5SLECFgQIMiaDVnP2zzV9I7HmfRPcaatranjrv7FbG6tzpYGDwJw/7hd2PtsQsUrUE6HcOPS6vsA6GE42DicyZ0oiHGGzlH8sH1e3d+Rp6yH0JLfhwdtTViWAtItafuBoADb3lSe9s/xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899262; c=relaxed/simple;
	bh=a3pj8sTNHKX+NfhRmjR1bXlXCMa5rRhYGMmjY++vbBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+iDPwQY2xkhznKId10CJ0KGb0muIf/NFNWGqJtifQuXVe8yWd7D7p0cLxS94BfSeaqsdpSenapMTLRo01W412Gqifvznfe6MqPaLkr6C38DDM0ZA+nBcWPTVp65+YK3b6T/NAdvNn0H0YMSvUhYhVIW40mG7PVJdUus3dovtdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ntq6dsLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EB0C433C7;
	Fri,  2 Feb 2024 18:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899262;
	bh=a3pj8sTNHKX+NfhRmjR1bXlXCMa5rRhYGMmjY++vbBs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ntq6dsLzseZfxyAfT30tzpWIleu3Hg5eVydVx8140weND1H8d6R5UjFmxxOEwhxmw
	 iW1kczQmFvow2fmpqhcI7IpePUzi8GTrHjd8dS5k8C4AkKNuaPKG9mBoTxOzksrucc
	 lEZ3VqyePoMnxKUM+0yU6htdZ5+nqYtA9KZpYEYvCT11Z2A7lz6+u0Sfl2PclElpqY
	 cul9W5I576N8e/cKdAzLxn74xDd+6BtJFjtDsKbsgbSiGOPVSdhCUv1qK0lPpLaWSa
	 PF9I30YsCo7pjl7Qr4E2fKICyQ3+KODTyUgo3wKbOBSNgoRUr2nyYeWrjJNu++G6mz
	 rBESA0rXWeRrw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/15] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:40:39 -0500
Message-ID: <20240202184057.541411-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184057.541411-1-sashal@kernel.org>
References: <20240202184057.541411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.76
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f ]

fast-xmit must only be enabled after the sta has been uploaded to the driver,
otherwise it could end up passing the not-yet-uploaded sta via drv_tx calls
to the driver, leading to potential crashes because of uninitialized drv_priv
data.
Add a missing sta->uploaded check and re-check fast xmit after inserting a sta.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://msgid.link/20240104181059.84032-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 2 ++
 net/mac80211/tx.c       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 49b71453dec3..c2b1a5d7e367 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -888,6 +888,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	if (sta->sta.valid_links)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 2db103a56a28..884ee55c284a 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3044,7 +3044,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


