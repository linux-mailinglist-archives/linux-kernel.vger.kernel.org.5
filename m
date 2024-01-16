Return-Path: <linux-kernel+bounces-28004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8801482F8F1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F788B281F4
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F2813C4C7;
	Tue, 16 Jan 2024 19:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gENFSvfk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE9E28DD0;
	Tue, 16 Jan 2024 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434820; cv=none; b=j5s8gjj21T/2gMYt5AHmXTvEnjyJui9GCmuBcj6xrJzT6APcZWbzQzywhb8UjArPYlJpa7YcWnUI0OVw360d8wrSz4MAMQDrMJoSdZl2tgITX7yOqb6cM9ID+fOjh6nghdgP3coYXknLy9CGhpqW70emwYKipTrKfkkCRyNhBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434820; c=relaxed/simple;
	bh=dNcP4OJVsNDmpycZn9j0ikf2VFArhZwzhvoPZmuu0IQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=p8pXnLStkk+RKSdYPFRsj1A/bjYz9yu0Zoq6AYbAwOz6e3/wl5Nl11RemmRDfPbHYuIcTMc2ZLLa4phbJptjbCnSuaTRieB6OYJ2I61JwYnpJh+ru0O+eVlzeQdksDumNN0CL4aoa7VUr/aSYKFpg1BMcghZwW0rOud8ug4LOxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gENFSvfk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEDAC43330;
	Tue, 16 Jan 2024 19:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434820;
	bh=dNcP4OJVsNDmpycZn9j0ikf2VFArhZwzhvoPZmuu0IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gENFSvfkaxNh9VWBWBInTFpYNWn5PYIiPmdD4DnvJp/tGUkmZKpu4RmKN3vBvWT12
	 +hO7tAGB00NEL5//LDItIg1USuH/wpSsf0JmNTELXYGVDqdTul8BUPFWxKEKHMPMD2
	 a7dZDOWNjTMT7gO1FgW4tVe/QQShmF6CNSy6DWk7vBUfH8DQLdZZdIkhI8aQkR8VNM
	 nht7HaKiEUJborWpr608YcqH9yJX+iBktF7F1CFOcYPWOH2HLcVXrv4qSH8vOZW607
	 rNiqutAfDND+aXwjKv9/kjt5Imo31L/0d4rzKUbtCbLeLEf0K2Pag/U5O0TnZOqlDY
	 iwvR5G1N4AOdA==
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
Subject: [PATCH AUTOSEL 6.6 092/104] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 14:46:58 -0500
Message-ID: <20240116194908.253437-92-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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
index e4cc6209c7b9..8ea7a8b4d64b 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1829,8 +1829,12 @@ __cfg80211_bss_update(struct cfg80211_registered_device *rdev,
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


