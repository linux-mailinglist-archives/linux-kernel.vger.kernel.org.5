Return-Path: <linux-kernel+bounces-28177-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A40B82FB31
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD04C1F2AF77
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939A365E89;
	Tue, 16 Jan 2024 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Necg0rEE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1178405E6;
	Tue, 16 Jan 2024 20:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435352; cv=none; b=uWRpBd4C3WsDvVtuFgZtKpg5oNgziQ3ieE023mwLCPmUCwOCreKrHYZXjxHdp4cetKSyxKf7xAa17xjX954nZtmkuZ6OZpJc86MPaZ/73MJl6tstkAR/y7XD75g70Gu3pJeDlVMaleUh7dgAQvhzUlOo7FOlKpYAK7B1SiMkPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435352; c=relaxed/simple;
	bh=egSa5tJ2mSWuFOSUJP5Qu6ngNzkm6171tTfglGZlplo=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=HN/i7AxFPlA0R9Fs1ponf7IUm8TGpUcE2RCQCoAiGlhde8ckw5dRSrWIL0EPeQ8lKg4M42QOBgUMz1yRVFcUSudXm1Ja3XY4Tgdl/FYhIjUJb3UaYcieyQ8ZTBWmQvj38+aip6CvNj1ZovHkR3YBetO95Maghqzr78AAQO4Uiz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Necg0rEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05237C433C7;
	Tue, 16 Jan 2024 20:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705435352;
	bh=egSa5tJ2mSWuFOSUJP5Qu6ngNzkm6171tTfglGZlplo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Necg0rEEpALv60xUxFkjfKrnTD6lagutPIfdNXaQ+DVWSqDDz0dZ6IGbexj0G/lpM
	 f1EFRxxtbX/sBx82Jo0R4OkCk133zRVEbU/sGW2opihT/OZ/Gdrds201T+nZ/S3QdE
	 ZynBJ9W8TupZ+xy2jzdH9uTVwiP+JU9BwYwnoyGPGMe9U7dTZ9M6367BUxa74sczZ8
	 8ncc9/KUUl3v0mQEr9AY7+/R6LTQsRgGjdZ1KwhgyJxBSXBxhno128Lya4/OAyfVU8
	 1Mmg714Ypk5s7cuRajujzG45bP9DqovwtHD8zYNThmvokvU09NTOXArxar7eLYURRO
	 Javd1V5tn04pw==
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
Subject: [PATCH AUTOSEL 5.10 41/44] wifi: cfg80211: free beacon_ies when overridden from hidden BSS
Date: Tue, 16 Jan 2024 15:00:10 -0500
Message-ID: <20240116200044.258335-41-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116200044.258335-1-sashal@kernel.org>
References: <20240116200044.258335-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
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
index 1e6dfe204ff3..6f0a01038db1 100644
--- a/net/wireless/scan.c
+++ b/net/wireless/scan.c
@@ -1801,8 +1801,12 @@ cfg80211_bss_update(struct cfg80211_registered_device *rdev,
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


