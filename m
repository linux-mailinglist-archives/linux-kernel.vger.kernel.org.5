Return-Path: <linux-kernel+bounces-62655-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFC685240C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E61231F21430
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:41:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07E3860EEB;
	Tue, 13 Feb 2024 00:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3tn+FQo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34E3060ECF;
	Tue, 13 Feb 2024 00:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783683; cv=none; b=lJ1/EaATaVpu9nTysI58ogVNnlG6frlG9xZ58kzR0lP56k16iGTL+ojgXPFW1jw2XweLm4+/csLu4HVbtx/Qqa1/qOBCle5CBTQ94D+E1ISiPdUvXLzvVazthxRg8F403giltjmj15O6QaIyn0N9Z1i6A1MtSAjWCR+g5yW1OkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783683; c=relaxed/simple;
	bh=/TfWKThQJFPt8KZ38t3VNYYG+CATQljjNccbMRtXnjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ANv/MEsL4aeqwhgNCB3ETeek0l1Q6om58J6VOZGoMJL9oyNnEePEwQy/9r//cIBjA016B9KjaIOkDRbN1xChuDiQ/+boF1T5qacL3vcKwMnsvgsRY+RtoKswlbJFmRAnnjgUlMvntQwe05acBvuWhat89T3JWvt0YunVXyBw++k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3tn+FQo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C1F7C433C7;
	Tue, 13 Feb 2024 00:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783682;
	bh=/TfWKThQJFPt8KZ38t3VNYYG+CATQljjNccbMRtXnjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c3tn+FQoNnDyqYQxyb1b7HGx5IYCwcLaV4TM+uyMEdze/5UWsLrcFDPDc8YBmHBvG
	 qn4UYeldxWECeLikt4nnCUgUlruS6nSb97A1d4IlCR06HGKVAFpbLh7zVf9zJXC1fy
	 cZxtCBHtD7/1en5R4zA9EXs5COXgpVP3/0jy/GK+cKfI40lRmjii9rHMw8R/cpMA6J
	 jkJhhCnyTCpZQ7upgYNs+N+MAlGM80CEEmwW/5ubGWKIfEb5ze8ZMuckfM1t7odVc4
	 nhlalgeThgig2ws70++3hu4yVcpl75hEBjfgyh2Aik/UFCP1PW2FNpO4WCX6KL9783
	 V4rja856usvZQ==
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
Subject: [PATCH AUTOSEL 6.6 24/51] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Mon, 12 Feb 2024 19:20:01 -0500
Message-ID: <20240213002052.670571-24-sashal@kernel.org>
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

[ Upstream commit c042600c17d8c490279f0ae2baee29475fe8047d ]

There's a call to drv_mgd_prepare_tx() and so there should
be one to drv_mgd_complete_tx(), but on this path it's not.
Add it.

Link: https://msgid.link/20240131164824.2f0922a514e1.I5aac89b93bcead88c374187d70cad0599d29d2c8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 73f8df03d159..64a458458f45 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7801,6 +7801,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0


