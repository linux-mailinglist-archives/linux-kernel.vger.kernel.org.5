Return-Path: <linux-kernel+bounces-50370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19931847820
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3ED1F2F63D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7236C12D742;
	Fri,  2 Feb 2024 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNOP4W3f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44E12D75D;
	Fri,  2 Feb 2024 18:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899220; cv=none; b=HqyUE7G0uohUYOi/uzHAZSNBPOxexMkmCWHKmI0no6T8WkIT7+VuaQAa7QQD0XNpPNRkALIn6LvUAoiQcosa6+CS9+hY9KVW3jl4QK79eMXAuqKX9HViNzAJ0iqb5OwG6XMNWOrINtlfssptpq/flN0z7TR+rgAZ9/QsCCgTFkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899220; c=relaxed/simple;
	bh=C61fLAMBijvMAuoKNkl7wDd8NcaJ29+iQ3vFRERufYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pp4OkdZ2aPhHrwTLf6fWpp+eF+R9Sf3Qgarq6Xdpf3e9zhxMNZgUr/+JvbshdTf4q0WspMiIfehlkzZn5e2EmHG3wyIrxCVc0QNXJ33mh+RBd6PNCrWtZdz+qCwVZ7o07mynEN76gCk0Z9/sy/AQhjhgV3IoeUkLEcNoRGWi/Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNOP4W3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94ACC433C7;
	Fri,  2 Feb 2024 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899220;
	bh=C61fLAMBijvMAuoKNkl7wDd8NcaJ29+iQ3vFRERufYk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lNOP4W3f+o8urwNtqVBjEiG0HSLa9zd3lAt+VHivySs6U6pn14CXL4O3vpa+pZYxq
	 BpRSk5ceD/OWCcUCCEZfgWd9dsL8Dr5NUY2xBlEevU1dEuohfyCfnONNY4LcBpCx2M
	 IH/0clotcvpUwwfXGKqna3aVYedtTkyeqHgeCBZDpqXqfu72mIYlFcb+cNcYnK/W7W
	 9jFI6RswHkS1f0wJU4Kay1bA4xp/Rga49wT+8hTQWbDANyxXS2kaMkqM1dqPrJI1Mh
	 FgH6JO12/52eUNbaOakUocSD6iaHq1KzUiAbUGTcZrpu7Ma8RjRE0pUcoWVX6IcYYC
	 AdN2vQ/3w7UkA==
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
Subject: [PATCH AUTOSEL 6.6 02/21] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:39:49 -0500
Message-ID: <20240202184015.540966-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
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
index 0c5cc75857e4..9c6c5dce0ffb 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -911,6 +911,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	if (sta->sta.valid_links)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d45d4be63dd8..001a60d1fd07 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3034,7 +3034,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


