Return-Path: <linux-kernel+bounces-115301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F9D889A90
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98ACF1C333DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687831D5677;
	Mon, 25 Mar 2024 02:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A42dBByA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E327FBD2;
	Sun, 24 Mar 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320498; cv=none; b=QLyFLWTe+lnZE2vDY9BwhiFzArPLxUblXQSsWJYJv3El0XhOljrcnFloa30Xe9CsY+Kf293FEspJHPA+kgxYjdiPURiIRUsWNPzohonukMgUl6YtB4MXdn6cbhOtMFI0Vi4vAZS0mtVWIvaxADiafgSlQdBsfpjfp082JvpAeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320498; c=relaxed/simple;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N++JXEKSteaggI7ej9qVLQvBFBjIAoI9/+Ad8OLlNM91BNs9kKOp35h+3AbP3mBPn4MmNvXk/jWrVGI+/ZM+3xrnRhPx9f6eettgNyYUO8cSzHcsqci5h3k9YdfFzZ/vrzwOFZhZsuaum1WI5f1CVsIEj1nQ/mBk6I1Uc38kArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A42dBByA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB92C433F1;
	Sun, 24 Mar 2024 22:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320497;
	bh=S9i6rVDTLrc92ZdyKfg4Ixk7H6eGpB3PH6E05e+MPh0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A42dBByAGWn8aDqIx1S5EbWtO1GukNi3nlv+TQOOUKkpWjiO2uBMa5VYKqv7ZyVlz
	 0YIbZHUXlfM+C7EcNta2DcuUejeJQgWT3MkTiAWe4Y9lNA6X84AyZC+aCkwBSiYi56
	 fUtLWPIOgxpgzr/WYqhkkwoUpCQHlgoLzId71ztEQVrQ3oVCshuEE6ALUgLMThywhE
	 xF0viWq+xMb04B7WETuiz1mE2z3CMcqJUb4Jiq5osrJFozz8oQQtm6iypt8pLnjKY8
	 vVHeVHIsFsz7LnoU2ggqu3kMcqxePLn/jw3wpX9YtJUHymhGU04xyFS1kEf5PUB2Pg
	 KbWFjGmHyjJEg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 057/713] wifi: mac80211: only call drv_sta_rc_update for uploaded stations
Date: Sun, 24 Mar 2024 18:36:23 -0400
Message-ID: <20240324224720.1345309-58-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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


