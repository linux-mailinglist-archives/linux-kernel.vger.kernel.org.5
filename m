Return-Path: <linux-kernel+bounces-50433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1EC8478EA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCF5C1F212E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A57215CB8E;
	Fri,  2 Feb 2024 18:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IaNETuLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DE315CB74;
	Fri,  2 Feb 2024 18:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899353; cv=none; b=jvlQRk/gN6dUwOTTdCho3pDK2am4GbAeiMjmP+gm/J3TucARolmXRXGVoYWvDCTUCbsPo96HvZEBHLwrbbjov9q5AP4zflSys3EZqxicLa+iwnKqcndW6bzP4yV22bQ7CVlEKMAn86dkuq0jwgP3CwrQsrGWVlAA7Tq5F/RczJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899353; c=relaxed/simple;
	bh=jEiw8BhY0l8FEObtYsQOR2XZcG4iTyOyOqSzcE2pnBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LEdUY+pVnqyHjjEXqOu749I1tOmCck9C6I7OMYZbn8pALezPoOYbubSlyE1KfGcg9RbUincEPGbsGZpSijDhHvHcfRr/pS+M6/7wsQXQUF7rjglhTDILh0tiJ5pVbUuhPOGyAM7ywyZiUBwddl22GfwvcC+A/+05MJF2lT7km6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IaNETuLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F1DC433C7;
	Fri,  2 Feb 2024 18:42:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899353;
	bh=jEiw8BhY0l8FEObtYsQOR2XZcG4iTyOyOqSzcE2pnBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IaNETuLQu0bRt4kkcw4ArSvMoe5jK/wGInlrzP74hvYlueqO8Wj1JvuLF9l9Rze2b
	 KxzuOZ9jrTEJnCE1j0bhNt+G3lVkFFRHZ6xWPT/Z9KCfM9XVxDCy7Mw9Z53GrDe15P
	 USBtw9ucHKQAAUoDn2P8oiSgy4xPT8fMH7is6AGoxruZ0gL2wKXe/Fykhb9snU06+e
	 O8/f/PVEA8ER+LjZWOAHVoMevWQ74webQm5A5iOPDURprOsD0GUWZk9Q4qOnDq/Iyc
	 Sdkg2R6RzFC3G1PEBFAc85hyHkQ+BYbXtJtF2SQK/Gx0WRw4gwZTmGCjezVy1TsXrS
	 bLDqH/LJz4nWw==
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
Subject: [PATCH AUTOSEL 4.19 2/5] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:42:23 -0500
Message-ID: <20240202184229.542298-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184229.542298-1-sashal@kernel.org>
References: <20240202184229.542298-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index 5c209f72de70..714d0b01ea62 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -629,6 +629,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 3a0aadf881fc..89500b1fe301 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2868,7 +2868,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


