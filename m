Return-Path: <linux-kernel+bounces-50345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D7038477C5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD15283432
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E346151CE5;
	Fri,  2 Feb 2024 18:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dwJYjqbX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DA15147F;
	Fri,  2 Feb 2024 18:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899171; cv=none; b=nWrEzWqZ3JS7j766Z/DwpCgw4w7BWnY5U9BbdtjxNs5p0wi2RDe7AUsoI2oVF7VUBgqUvFhScCUEYzyj2DMBaa/kUfJJ6Y/F+1aT7P4O0VxnMOmJzr+UndeGhkeogXttTcwyeWoX2lUp14P/3vAxbJSAJGyfgsl+op5FoN7+dm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899171; c=relaxed/simple;
	bh=rTiMzZumFkAMwgLLb/3XmyG868+z7oI8xdqdDsyYiqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5XPxmMpdtZD2zEuSiicVx73jHTNZ90AUwZ9hyqscor4DrGjJJmaftreYyzxFDQHt9DVZdX6iSjQgRUOM7IbwwkT9rwMeAgl9S5abHOT02XzdH7waRNY8Sfad6nl6qdE/OKqZfMIHMruGqvGIoQk6cIoFIb7wpauB3VgnQN5x5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dwJYjqbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1BCC43390;
	Fri,  2 Feb 2024 18:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899171;
	bh=rTiMzZumFkAMwgLLb/3XmyG868+z7oI8xdqdDsyYiqI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dwJYjqbXF/ym1WXtUmtQT9U6yUqHq0mEcL403Qk7zCuK602cDkfM004TFQAAfIL5S
	 ZG84rhzE0cRo8t+lEZNvgatpmW+b3NCorr23nlOMbWmejkK72J38yPhTJDaedrta6N
	 HC09L4rn074eCxzU5YVHXdrvmq2YopyxqB0YDgHqnyxSJloajH/Wp2RscYi2ZvPkKo
	 lW4zGDFsaLws/ymifjHPOy24ZXrZ2B4mM7Ef47Jk69ENcJeGktuSOSuZ5g+w5EtUvk
	 TMu4CG4YW45pjuu3jAGl0OHbucIDthruJnnhy3LBG5QInr+tC4nm5ZQlZlDvKYw/Cw
	 x0RiGO/HIaCFg==
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
Subject: [PATCH AUTOSEL 6.7 02/23] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:38:58 -0500
Message-ID: <20240202183926.540467-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202183926.540467-1-sashal@kernel.org>
References: <20240202183926.540467-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.3
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
index 0ba613dd1cc4..b62b21749f52 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -910,6 +910,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	if (sta->sta.valid_links)
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index ed4fdf655343..4b2823e36a37 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -3048,7 +3048,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


