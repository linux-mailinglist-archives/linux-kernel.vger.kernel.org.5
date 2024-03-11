Return-Path: <linux-kernel+bounces-99057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1998782F7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D500B20BCD
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333424EB38;
	Mon, 11 Mar 2024 15:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRzlxPY7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689A84D5AB;
	Mon, 11 Mar 2024 15:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169960; cv=none; b=YWXVrmGPbQsLutf+st5rEgl2WbTGSC8OeX3jmMCnSFyKjd3UvIdHP9n4XFGfZsZsF2OEkGXCclv5TBShi0VRDm8pub4BCgbyhTjViRdHY8sYcQVivsqQLi+KYO8wNO/mGgODEf44Lng1ss2U9Jsir4fGpA+NiaNauaLpteKJLAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169960; c=relaxed/simple;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CoAbyHJuZV5vyZ0og6siJEO30Q2sUmqqJ9BgEjKBFcaI3vL85v0L/7x1QTJAn5HoEG4757crFWR9dpiHqOvtNeh4hN/8WZxSL4XSe8ykSDeo9AohvyDnnjiqoq1xrxsHTzFrqcazrwsH3tSYSLhoUYJRkH1onRr/7mcuoFehr4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRzlxPY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA96BC433C7;
	Mon, 11 Mar 2024 15:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169960;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WRzlxPY7RJc8oKN38Ed0fqs3VQMWE3Caq7wpROnWkEOa/C9/d+3kXz22pqo7oltfN
	 +XyIKCMfdtI29ilQwVVxDEHKhk7pfBGFh+9KpJWqRV2Rsn7h5EmWYmwY5UiD+Lfk77
	 SZomocpblTunbjYbY7YY3HvsitVVBQnKfuB3NIjo/id463SZE6vypDi0hcLZmJqxAg
	 IL1NuknE/4VCafcRycDUsW+9a08RRwyQjuiA0zIQoAi9CfqlO1lPUk7Q+zDTSSp8Pc
	 1AEi/FSW4ZoIq0TZJyOPUYO7YM1YVtOD1rgxlyamJ1A/NkFA83Lx7xdGEuIdKrGPnu
	 st/fOnYH4rUKA==
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
Subject: [PATCH AUTOSEL 6.7 10/23] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Mon, 11 Mar 2024 11:11:50 -0400
Message-ID: <20240311151217.317068-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311151217.317068-1-sashal@kernel.org>
References: <20240311151217.317068-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.9
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


