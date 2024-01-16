Return-Path: <linux-kernel+bounces-28130-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB8482FA95
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB4328BACE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A35157E9D;
	Tue, 16 Jan 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ATq2f5Hk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EEC35EEE;
	Tue, 16 Jan 2024 20:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435203; cv=none; b=hRrDUUpzwoRFI1WyvD64yIkgXAiYzhlrZfFxf4qJkFaSoJ/i9Dn4cFJ+yiFXc0gPcQDqA3+LALsZzxP+5LoPBU8OSpqBHTjNqsEi7p7TTFgDobLUHvF6SnNy6S9o342IHngxErAwSb3iJmz9nSUiFAiKyp8uYPCOIkpXODxP8c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435203; c=relaxed/simple;
	bh=uHz31U3fFdNiHejwfXDBIef5JK1/K7iLDMNkJp7Q7RQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=K8W211xMBZ80fY8MbHVwNaMYM4EGkzLMxpM8VygPvin7xgaKEbSFxbCakMOayZro8iHmn0WW/O8DTvDgWSNwzCE2/6rVaJTAdK9IWBf+DYx02NvYoCx64V7fCGpo4QvtUY6jnyRz0z3pq1nFc2C71NGCso0u9ESkAMCFpbgZ/d8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ATq2f5Hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6993DC433A6;
	Tue, 16 Jan 2024 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435202;
	bh=uHz31U3fFdNiHejwfXDBIef5JK1/K7iLDMNkJp7Q7RQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATq2f5HkT3X0vVvsAhJnDJo29Z+tEMlfDqNh2vYfFz3+ozYmiUK+qAokR95J6tXL2
	 D434FBMh2JODbRe/qPr4fhecwZZcvf3X1oJJcIOg6PNZxZL/gz96cu/ah6uRJmZbYL
	 5hSruGl63M7w3MZOAgfRYyJibEY3zI2VLAbwKXlHhjLR0Jqd4Cl0U3x7sh3TagDJbv
	 4+ESbyIKiNql3adeGmNF4f08ye+0S/QFj413a0g8Fdy6TgS1GPLVVmlryZqNgHFg5t
	 JAwuU8yqi69FqvRRz/edmnETR9g4Xf98kxeUtQJUZfU6x27ejbkQHVY7Wz+A4R5u2R
	 OK1txCJxOZnWQ==
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
Subject: [PATCH AUTOSEL 5.15 42/47] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 14:57:45 -0500
Message-ID: <20240116195834.257313-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195834.257313-1-sashal@kernel.org>
References: <20240116195834.257313-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
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
index 4decdc2c601f..68c48970ebf7 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1808,8 +1808,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
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


