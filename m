Return-Path: <linux-kernel+bounces-50419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D0088478BB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5E321F224C1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819EC154078;
	Fri,  2 Feb 2024 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swKOrlzA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBBD41509AA;
	Fri,  2 Feb 2024 18:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899320; cv=none; b=BdOgMRtnq8BV/b/r/dAardb5zLL50UUieG3CVl2RDYYmTTw+gWh8LUjinYYVQQR4Jil7qAEaQwGn+fV8k7lrYZZiLE0g/4aD9WB5kC2gA2uhTbIsE1rUt6+VRiyAlUGB64pyAdwr3lG7SpckQx6AhNXUALfwNhmx0OjkNBryvN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899320; c=relaxed/simple;
	bh=8isM7WwDv6SKtIgEUqc5d1RVPq769TyKyZX5u6wTQMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KVm1BEPUvtSrDJ/ZwY8WdQ3iwL/Z4PoqgISxaY++mrEwMKPoN6sOJtEP3cjt5dZeLyvDjojFes9cVnEp6JLHjbF30XIcaJU2hboCVB391GBYeSds2WRvbMGAx3YNVBOlJvUkdy0/PqM2QC3kX4nOvULNc6uUOg+zelATkhxMP7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swKOrlzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EEB6C433C7;
	Fri,  2 Feb 2024 18:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899320;
	bh=8isM7WwDv6SKtIgEUqc5d1RVPq769TyKyZX5u6wTQMw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swKOrlzAVub92QIQibJCserWWXDOqF0AXT83QeFdx09saRVdzP7p1+SUGEzusisR2
	 700ZxOJRg/2eBo+XuGhz/pMEgxIISMQhhXzwugKihh8HihA0rqV6ERmnzj0Y0puF/N
	 QZtJSmoCeKjCaw2+MQeIQhyIrnm6I0ZRhPjZ+ZENqRZEbJuc85i8zhaYE1ff0nahM3
	 ugF3PrzACv4loh82GPnV0J221pLvbVEmUFYqBMmgUkrnzJKcgkskxG5h8qDhhqE4V4
	 pD7cQlOZol0WxW00UZBypChxXkfz6V92mXFHg2oxE9syhPqHbX4iyEBcqsEQdyZc2w
	 wlWvLLhMf4sNw==
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
Subject: [PATCH AUTOSEL 5.10 2/8] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:41:46 -0500
Message-ID: <20240202184156.541981-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184156.541981-1-sashal@kernel.org>
References: <20240202184156.541981-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 2e84360990f0..44bd03c6b847 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -700,6 +700,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 788b6a3c1419..8b35c27c9f9f 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2959,7 +2959,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


