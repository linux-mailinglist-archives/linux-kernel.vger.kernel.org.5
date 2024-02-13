Return-Path: <linux-kernel+bounces-62656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF185852410
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7B9B2519D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A103A612E3;
	Tue, 13 Feb 2024 00:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tt8CwhGz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC559612C9;
	Tue, 13 Feb 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783684; cv=none; b=FlDKglLVOJXRwKzryfeLQ0yeYwNIX0cGoWYtOTs6wk7+UrInYwxx8FDIZ52PkO1f3RNhVs5xAmF6oyqzbOcVRvPB3PDDessLq9+cks31Pc2GIJ+Y0eaj3COrrnmJpgWDRAqSyqNBNLMGcctpI1upvKSjt+zzqjDmKSQENsqimtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783684; c=relaxed/simple;
	bh=5fjtFvRXq8i+1QkarT25gVcXr9Rd0tLWnEMrGrtbh+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RE0EeK+RkeWrytZ6l3waIWI24NLLi6HbMK2n7RTzGywFqS75xYh2BHv0E6bvs8RLZpZBjVreZc2HaXjhxMOT+D2felZU7q+QRQsuraF09OoeZDCJUNLJ1kVkF8cAElVaai1+cwq6ES77ecPmt1lfNvJtUxprrxaiolBCaPzivPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tt8CwhGz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14AB2C43399;
	Tue, 13 Feb 2024 00:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783684;
	bh=5fjtFvRXq8i+1QkarT25gVcXr9Rd0tLWnEMrGrtbh+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tt8CwhGzKqj9Oa4xK3qdhuAvtXaMA3QWtawbbgOLIIbPNlJrKAe+VQHZzDoDoA9uB
	 GLP++i39d9L5vL9vPpgXWDp7tucJsQUpGB71IGVNuasA5SbTmm8nXyKDlFzCJLPmqU
	 Z5/Cb7SA/hN+42fXF0b0azOK4D9fBvSdNLPbzkFJEruKIpn/HaedDhe8JpH8mL9E5e
	 8gHkngYAPkOICgto1yhEVGmlBx09M4wfGASlnsrSWGg8SClo7O8w+gWRS/GjC/nmLM
	 B2LIx6YFpS7ap/O71cG93R8WebTJYXr3fKwbk0kZxE6zcw8T+znGNCqkJkRHgx7FH3
	 qz2iJjLKroVzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 25/51] wifi: mac80211: accept broadcast probe responses on 6 GHz
Date: Mon, 12 Feb 2024 19:20:02 -0500
Message-ID: <20240213002052.670571-25-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 62a6183c13319e4d2227473a04abd104c4f56dcf ]

On the 6 GHz band, probe responses are sent as broadcast to
optimise medium usage. However, without OCE configuration
we weren't accepting them, which is wrong, even if wpa_s is
by default enabling OCE. Accept them without the OCE config
as well.

Link: https://msgid.link/20240129200907.5a89c2821897.I92e9dfa0f9b350bc7f37dd4bb38031d156d78d8a@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/scan.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/net/mac80211/scan.c b/net/mac80211/scan.c
index 68ec2124c3db..a52813f2b08c 100644
--- a/net/mac80211/scan.c
+++ b/net/mac80211/scan.c
@@ -9,7 +9,7 @@
  * Copyright 2007, Michael Wu <flamingice@sourmilk.net>
  * Copyright 2013-2015  Intel Mobile Communications GmbH
  * Copyright 2016-2017  Intel Deutschland GmbH
- * Copyright (C) 2018-2023 Intel Corporation
+ * Copyright (C) 2018-2024 Intel Corporation
  */
 
 #include <linux/if_arp.h>
@@ -222,14 +222,18 @@ ieee80211_bss_info_update(struct ieee80211_local *local,
 }
 
 static bool ieee80211_scan_accept_presp(struct ieee80211_sub_if_data *sdata,
+					struct ieee80211_channel *channel,
 					u32 scan_flags, const u8 *da)
 {
 	if (!sdata)
 		return false;
-	/* accept broadcast for OCE */
-	if (scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP &&
-	    is_broadcast_ether_addr(da))
+
+	/* accept broadcast on 6 GHz and for OCE */
+	if (is_broadcast_ether_addr(da) &&
+	    (channel->band == NL80211_BAND_6GHZ ||
+	     scan_flags & NL80211_SCAN_FLAG_ACCEPT_BCAST_PROBE_RESP))
 		return true;
+
 	if (scan_flags & NL80211_SCAN_FLAG_RANDOM_ADDR)
 		return true;
 	return ether_addr_equal(da, sdata->vif.addr);
@@ -278,6 +282,12 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		wiphy_delayed_work_queue(local->hw.wiphy, &local->scan_work, 0);
 	}
 
+	channel = ieee80211_get_channel_khz(local->hw.wiphy,
+					    ieee80211_rx_status_to_khz(rx_status));
+
+	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
+		return;
+
 	if (ieee80211_is_probe_resp(mgmt->frame_control)) {
 		struct cfg80211_scan_request *scan_req;
 		struct cfg80211_sched_scan_request *sched_scan_req;
@@ -295,19 +305,15 @@ void ieee80211_scan_rx(struct ieee80211_local *local, struct sk_buff *skb)
 		/* ignore ProbeResp to foreign address or non-bcast (OCE)
 		 * unless scanning with randomised address
 		 */
-		if (!ieee80211_scan_accept_presp(sdata1, scan_req_flags,
+		if (!ieee80211_scan_accept_presp(sdata1, channel,
+						 scan_req_flags,
 						 mgmt->da) &&
-		    !ieee80211_scan_accept_presp(sdata2, sched_scan_req_flags,
+		    !ieee80211_scan_accept_presp(sdata2, channel,
+						 sched_scan_req_flags,
 						 mgmt->da))
 			return;
 	}
 
-	channel = ieee80211_get_channel_khz(local->hw.wiphy,
-					ieee80211_rx_status_to_khz(rx_status));
-
-	if (!channel || channel->flags & IEEE80211_CHAN_DISABLED)
-		return;
-
 	bss = ieee80211_bss_info_update(local, rx_status,
 					mgmt, skb->len,
 					channel);
-- 
2.43.0


