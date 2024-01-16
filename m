Return-Path: <linux-kernel+bounces-28211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7DD82FBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0004B1F281FC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426F168986;
	Tue, 16 Jan 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="co+SQyGC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7131690B7;
	Tue, 16 Jan 2024 20:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435456; cv=none; b=DTZ7sBAwg0XspmIhjjZ7EjvBPG3iPyJPe3mWWZSN8svdaxRbPUBwU06aSOIrcIHJONvzmEj1OVguh3q2p/panLgPGAA1wvKDtsYYSuk5768yhmxdyKsXOq4xjCiFLhES4/PhCfM9VMpbBaTAyyfuiebiF7iF5dmvFXPT2i5d+Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435456; c=relaxed/simple;
	bh=ZacWzLCDX992GlzXe6YpXKHBw5JHUXKwxy/FO9FQ0JQ=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=Hzs716nCqdKHECrcvuR1B2UgtoFM03EUR+8MU+5lHTDPPKjEeQLXGfAVx7lGluCJhCCUV0wbr5+v1sJLkmBAsZ2Kn2BKeROhIVHSiR2WBP6YjnW/LdGeqCNZRiPZnP814OOjRwmzdnxJXdlJTeTl1vuSfDr6atJ0lca3biI6ASE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=co+SQyGC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69582C433F1;
	Tue, 16 Jan 2024 20:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435455;
	bh=ZacWzLCDX992GlzXe6YpXKHBw5JHUXKwxy/FO9FQ0JQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=co+SQyGC0Sq9vYIaE+6VKYvmUNjW+REajGpbD/co2qCg1dTJXD8DeYC8ZP62Y8ZVc
	 c6A2LhkhjmXfT4zOnK2BZp/C58nw7CoYX7dry/DbXNfngR3MByVGyjMb0fHCEmx0Eq
	 5tvNRi+bcv9KNIPN/sftKLIoVk0xMAA91aXKG2k78I9Xk80KBk2gAPp4fLVviuvOSX
	 rf5lBPFmWpQQ607wYZ3s7Olvk6eo9C58Zndr2UACOa/4UW0g6KzITjb7owFl/j+doC
	 t3jqW+v3OyR3okfx0FsV42q9W3wtIH3BmxqmQZYgLKVfY/R+RUQK9XIZq5zxPx6poR
	 vMderklFrZ3+w==
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
Subject: [PATCH AUTOSEL 5.4 31/31] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 15:02:40 -0500
Message-ID: <20240116200310.259340-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200310.259340-1-sashal@kernel.org>
References: <20240116200310.259340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
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
index e35c54ba2fd5..f3a957f2bc49 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1294,8 +1294,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
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


