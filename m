Return-Path: <linux-kernel+bounces-134422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E641289B14E
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BBCD1C203F6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C59839FF2;
	Sun,  7 Apr 2024 13:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrtXiP+C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA9B58103;
	Sun,  7 Apr 2024 13:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495509; cv=none; b=SELEXwoZ8dvgA6iTOJquJfZG1kzzx2MIWg0t5ZjKyc6nNEyWa8M9tJgov0GhVIs3DM2BulDFhzrhGrkQ7tUxPaM0jzu8/i+3P88AEQfRDDJsY2ecb6oYeIwc9frY1NHuX53gXemCkxq+I+MHoCZPcG8Ilb0ayO8eBLNsRQRViBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495509; c=relaxed/simple;
	bh=M1yzLoqZVuRA7rZnbbq1aUBko3Z/ImPKtOozDZr5hZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uz5Ez3WujMhHBUvas+AWgVsWWYHO+0e+TJGZh7XCXfuIjrNaYp9sUMc1du7RTjaEQWhedGA+Y2COzHOWhvnz2dG3D1aiO96hZKT6OhQpS+3Gj78g+zPTxeMcqoigWeiS2N2bHaihEfZ0dinChZaRVELoImmaQFt/hO+BIcHYcKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrtXiP+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEC7C43390;
	Sun,  7 Apr 2024 13:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495508;
	bh=M1yzLoqZVuRA7rZnbbq1aUBko3Z/ImPKtOozDZr5hZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZrtXiP+Cb3ToH3VVB+PggR0s7zejuUQyNJ/IeECbAitA2t6mUvZVuqly2HECTjH7w
	 BXCTyU3BTUi/yd+UqZO9g92SLdtOT0dgvZ+6xqOeU15yOxtphvlz1ExFXLcYvoukgo
	 EYnddYip1blQP4BcM48X6nq/TtBTYS0RUWp4xofPMzV1mvq9jZRkkS0tnGmAZhYpQL
	 daAtmnc2ALR0/Ij5p6K8K5PFGGDT5MCYTvNwGj1hbRhTYxomzmx3etersjO0N7FXt+
	 JKQ7OeuLNGSEakuQQLlQUVXItJ5UC+T0t84Ee7uSB8NcVui7V7dksh0QkgPRqdFvAg
	 OhOfXKGc33IbA==
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
Subject: [PATCH AUTOSEL 6.8 12/25] wifi: mac80211: fix prep_connection error path
Date: Sun,  7 Apr 2024 09:11:00 -0400
Message-ID: <20240407131130.1050321-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
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
index 20d863370796d..90531ff2590c1 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7291,7 +7291,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 			sdata_info(sdata,
 				   "failed to insert STA entry for the AP (error %d)\n",
 				   err);
-			goto out_err;
+			goto out_release_chan;
 		}
 	} else
 		WARN_ON_ONCE(!ether_addr_equal(link->u.mgd.bssid, cbss->bssid));
@@ -7302,8 +7302,9 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 
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


