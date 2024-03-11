Return-Path: <linux-kernel+bounces-99095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B010F878363
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A964284A53
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C6A627F8;
	Mon, 11 Mar 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LJ8SIlLL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26EFC626DD;
	Mon, 11 Mar 2024 15:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710170042; cv=none; b=Hzfg7tPsnfYQgj0JuTmUwjd16xQ5NZ+WuBQuX3wmCbHJh7KNreaCjkpoJbAmyPvBYFHuTiRB0suYjV2qoHJKzB4EWk0rlDOh7UlVwqg59t0dAajrf9d0e4rNEdEzsrmgOOqt/Mccafriw00897FO4BrzX+Uo8GMpme/UgdifcA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710170042; c=relaxed/simple;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XmfUgjS7Qa4lVSPXFIlEYVay/a+5/dNRSDVANRdKSxJ37gH0pNI9ZDhGZvaLeWeYBF5Ys3CGFeZk+AfVl0BIMgvbgHq29F/dC2LK5O1OahmTuSQ7MztpUnKD6Vs4NiYQC0UPOeWYXHyWfEVTpNkJR1RyGrsN3xAOz9o+rqjfyvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LJ8SIlLL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE5C43394;
	Mon, 11 Mar 2024 15:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710170042;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LJ8SIlLLJNBLgbNtaeZomfFWNjpDebvVzUG2itxNxNhpP9lcAWN5JiNIMqaEqN+qa
	 iyFIam55NRPCNrBurXddfb9tTZpK0+XXj80AQ4oMYYnkoEysrX4k5p38yYg+sicYVW
	 QQzSj/YdWNM4FGTFiBwDwGDM8kqTs4q/30m2OfgkGENvo4/iKm1Je2Ku2vmH10eHhr
	 sxk918SFqyVyJcNbqUVRK2CtyQcXKMZGGL5pt0qdnZiaoQvWK9KgVxZtT6Rg/eMzvk
	 0QYI/RrSrzQS4AgY7fmVarMU23zQJtIwY2OAdaDz3dbBauSCJRgdmuaSbjPeUkN8ZD
	 s9G5SdpSpurYg==
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
Subject: [PATCH AUTOSEL 6.1 04/13] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Mon, 11 Mar 2024 11:13:39 -0400
Message-ID: <20240311151354.318293-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151354.318293-1-sashal@kernel.org>
References: <20240311151354.318293-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.81
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit 413dafc8170fcb925fb17af8842f06af305f8e0b ]

When a station has not been uploaded yet, receiving SMPS or channel width
notification action frames can lead to rate_control_rate_update calling
drv_sta_rc_update with uninitialized driver private data.
Fix this by adding a missing check for sta->uploaded.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://msgid.link/20240221140535.16102-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/rate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/rate.c b/net/mac80211/rate.c
index d5ea5f5bcf3a0..9d33fd2377c88 100644
--- a/net/mac80211/rate.c
+++ b/net/mac80211/rate.c
@@ -119,7 +119,8 @@ void rate_control_rate_update(struct ieee80211_local *local,
 		rcu_read_unlock();
 	}
 
-	drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
+	if (sta->uploaded)
+		drv_sta_rc_update(local, sta->sdata, &sta->sta, changed);
 }
 
 int ieee80211_rate_control_register(const struct rate_control_ops *ops)
-- 
2.43.0


