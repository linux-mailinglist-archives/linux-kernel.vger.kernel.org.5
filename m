Return-Path: <linux-kernel+bounces-114041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A746988880D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42B3A1F23B86
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C0022D8B8;
	Sun, 24 Mar 2024 23:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXjzIX/i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5953B14EC6E;
	Sun, 24 Mar 2024 23:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321324; cv=none; b=FyBcKeAsq8LREPANyB5WJSyJUKwzr1lYvpY3vd1AcEGVnfrc5ciYuALuiqo7Sa+7gjE6eelxcgkazI8S3RLqXjN/PZqaRuzGTpapP1x+XRwDC5IuZWyOYEU//fbfYKkuhrTdAAQygPE/ukTxmj3t+C7x8JkPKiDoYlJz3z2PI1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321324; c=relaxed/simple;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m9V5ERgnMijAd9vB4prs9mllnDYQC+SjJstWjz0WO4wysPV1NJ5zq/V1aKOUlAUtmVD4A6Pv6JoMZZrdUvTKonvtB59lMNwz8cEpGB64wG/FrF09EauNBBHjuMKmsJOQqLS+tiuiSYSS2LI+xP7SlMoS4BrxgBmCdoyWygzZKHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXjzIX/i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3D4C43394;
	Sun, 24 Mar 2024 23:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321323;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXjzIX/iH6QFscj9a1f9+LtfwqGB/fwcUqRBJIGZravSle0gLegkGHzFqfn9rZ7Qc
	 T/k+r7vm+9wOgsJekqivTXUHhGB99SMTwCB4WJ2LB0+6oHbOz5BOGsQSImikE5UGTO
	 54o/45L2TssKziCLToJ3tNHWlBpAdin7H0Nlutk9bzOqXh1zE9TxZUYww9BpvQy+GA
	 RoTZVrKO578aW3CeaBQKLZUQ21Q3v8Cmul4U6UkarpQ5srTxsY95VnWaRow6ty2c5b
	 h2kMqMX1G1Y31f6SehJWYmQFAmaz1/6Q1RrNe2jp8mDHtGmJALjbAVB3OCdRksdFQF
	 pzQgJHEUsc2jw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 046/638] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Sun, 24 Mar 2024 18:51:23 -0400
Message-ID: <20240324230116.1348576-47-sashal@kernel.org>
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


