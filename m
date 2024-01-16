Return-Path: <linux-kernel+bounces-27867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B536C82F6F3
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D77F284A83
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF056350C;
	Tue, 16 Jan 2024 19:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rL8vFnix"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC64C634ED;
	Tue, 16 Jan 2024 19:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434401; cv=none; b=u0RxLtkpE+oIuMCfTRt5NY3WVlUEjtWq5MGCN56fC6z3C+GAu0SQ6dHRtwR8KluU3ZAF6DQxXcaxlf1LqimDWKbokVNCGCJctI0LeB/269fCwLVve2riBI3tNMp7t4NQ7B2yMfWSUB10lp4vI6zrk61xwWNMmMT+T22Ia6PHhzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434401; c=relaxed/simple;
	bh=ypxpYxlz/wmJ+C/VY5hpQ0JDvDRuNBhniaq+lt8fbVQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ktpupVn5xop0g20/R1Pwf7gX2YLtMR8m+64tTBCLtch1ID7II0GuOUXNuVXiqjTmEqDsh8cPoY1USDBi8+2D6OtAz9uXO92daGlLYvqBlZiwUT9YY8FX2A3+6E6Ej9KIcv8b42ZEtuuaPvrBGRxog+hghRnPDcZQF8jm+aHOj4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rL8vFnix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04CEAC43390;
	Tue, 16 Jan 2024 19:46:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434401;
	bh=ypxpYxlz/wmJ+C/VY5hpQ0JDvDRuNBhniaq+lt8fbVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rL8vFnixFTFpOdCNn0eVJIzyQZkf5LCy7+F6q6YelksccJXn9HHrM9BZr9BPbuGbL
	 IsqlZizS+KuNC6g3l9A4rGCZW3opEF3+af20wzdHu1WLFYgk6l3EcmrTykP8txctYV
	 3peYBNy2JCCZWZPKP7D9U45lWEpdY/sGRfdszYKQNHrXkasPXQakcPJ0LksVAiKi17
	 8aWOI7gphKWo6adr9/52weJX4Atv4jiZwJJ5A+SvyJv4bhn4Wcu0QH6Xmqo1khkg5w
	 Wfkrye/HdPR9UqivIYyYDHicLABEhNDKYC4+CV2ldAe/9GThkX9IjyrikDf/zUhfep
	 bHmXufGBmZ2ew==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.7 095/108] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 14:40:01 -0500
Message-ID: <20240116194225.250921-95-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194225.250921-1-sashal@kernel.org>
References: <20240116194225.250921-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7
Content-Transfer-Encoding: 8bit

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit 32af9a9e1069e55bc02741fb00ac9d0ca1a2eaef ]

This is a more of a cosmetic fix. The branch will only be taken if
proberesp_ies is set, which implies that beacon_ies is not set unless we
are connected to an AP that just did a channel switch. And, in that case
we should have found the BSS in the internal storage to begin with.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20231220133549.b898e22dadff.Id8c4c10aedd176ef2e18a4cad747b299f150f9df@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/wireless/scan.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/wireless/scan.c b/net/wireless/scan.c
index 9e5ccffd6868..1114358e65ae 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1864,8 +1864,12 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
 				list_add(&new->hidden_list,
 					 &hidden->hidden_list);
 				hidden->refcount++;
+
+				ies = (void *)rcu_dereference(new->pub.beacon_ies);
 				rcu_assign_pointer(new->pub.beacon_ies,
 						   hidden->pub.beacon_ies);
+				if (ies)
+					kfree_rcu(ies, rcu_head);
 			}
 		} else {
 			/*
-- 
2.43.0


