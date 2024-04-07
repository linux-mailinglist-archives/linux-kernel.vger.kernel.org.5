Return-Path: <linux-kernel+bounces-134446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3326589B199
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91CA28198D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3EE80028;
	Sun,  7 Apr 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxSeF1gI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645147FBB1;
	Sun,  7 Apr 2024 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495568; cv=none; b=Vs1xugn0CxRFvW5zz126Odd8wGWaXOkFgAWBMOEAJi96x1G48GQgcCxkfITdtQYCrtlwd4aj3PEiX2lyozmd1cS9urDY5g7XD7tchff9zgiz7qvUhYvfB0TPy78HZCn7r+ksva1eqW5dnZyA09ULjvrc9x3WZXJNX432KXZzdYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495568; c=relaxed/simple;
	bh=Jf7feS/UB0VznT++N82lhjZNjXkq0Yt9Nk+Ij4Oo4gU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pks8a9SexUGbfiDYR+5GFgQKNUzNSzE1hO2MF8J3DAukFM91Fsa41ovUrso4374LqaqKU6LVfo9hFNzMxiLrxt50IDizSzXwgmDhHbyhvNGLzqitDVsza9yMZ9cbb4b/5U2na/3OuahMg7WhxfrWPDQSnTCYTEBfGnJR1E/KihE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxSeF1gI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CEB2C43390;
	Sun,  7 Apr 2024 13:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495568;
	bh=Jf7feS/UB0VznT++N82lhjZNjXkq0Yt9Nk+Ij4Oo4gU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NxSeF1gI/3ac1uqKsCMrYUyUcB0V9pKTGuW2tlpckCgkqIU9knU0Qlaw8CmAzFC7h
	 UOb4sJMavo43STbi2lxA4caOg5L25E/9vqmF46DRvuX10XkiZHHmFMjvGJdFVRxQXc
	 iz5vYPG4mKp86RFyXtf1oxXt9Q/TDWkr07mdxBW0A+WR85S1McbF/EySyzZkUH7dm/
	 cVXx+ALNa28NGsIGIjuKwgNOYyhOO4+tyKw1476oNTm8DRwump9Un8MkK8NjBNAC42
	 t0ASfUf/duH6ylt5TNV7zom6ZXAxzs/sUQ1TshzIoEVVmjje17ucQW0WpYwnLYk6Zh
	 /MW0vUP0+oNRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 11/22] wifi: mac80211: fix prep_connection error path
Date: Sun,  7 Apr 2024 09:12:10 -0400
Message-ID: <20240407131231.1051652-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131231.1051652-1-sashal@kernel.org>
References: <20240407131231.1051652-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.25
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 2e6bd24339a6ff04413b2e49c0f2672d6f0edfa5 ]

If prep_channel fails in prep_connection, the code releases
the deflink's chanctx, which is wrong since we may be using
a different link. It's already wrong to even do that always
though, since we might still have the station. Remove it
only if prep_channel succeeded and later updates fail.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240318184907.2780c1f08c3d.I033c9b15483933088f32a2c0789612a33dd33d82@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index c6044ab4e7fc1..5739556443833 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7077,7 +7077,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "failed to insert STA entry for the AP (error %d)\n",
 				   err);
-			goto out_err;
+			goto out_release_chan;
 		}
 	} else
 		WARN_ON_ONCE(!ether_addr_equal(link->u.mgd.bssid, cbss->bssid));
@@ -7088,8 +7088,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
 	return 0;
 
+out_release_chan:
+	ieee80211_link_release_channel(link);
 out_err:
-	ieee80211_link_release_channel(&sdata->deflink);
 	ieee80211_vif_set_links(sdata, 0, 0);
 	return err;
 }
-- 
2.43.0


