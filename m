Return-Path: <linux-kernel+bounces-113057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B653F88811F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E26161C21452
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C35F145B36;
	Sun, 24 Mar 2024 22:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="os4uNrF2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFBC145B1B;
	Sun, 24 Mar 2024 22:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319865; cv=none; b=D6Mdh0Zt8HJkY/Cpim6x0W+h6QVrQBU2wlob4KvKpQzQ39djAH3lS7GR5rItOQoRHz7F2/VFfuk6sx7sC9dSlu5VodRDJKjnsqhBgw4ZnoUdUcmKuAeLTwcxysqTm+ywlfkfK+UuSqCo1XqsSLZQeTTy34dQiXwlRyaVIlacqdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319865; c=relaxed/simple;
	bh=2q6oHfjoHzX8gP5qDR5Um+xcUNC7XmVJXbcW1TFzcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0DADdATAv5G6tYgiVtK2NFKzGTM4QGUPV0CT6wBOn2vr4JgqhjglI4FRSbHn3PY5h8o3aulm2Nh6mPm9CMcGNwTEbfWQfF/YpO3uFnc50fWOYKBcomv0hI0MPAc9uCQj6Gf6mnhM89V2YVE1l0WkYyhORyTGhN70/RJ1ACSARw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=os4uNrF2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB32C433C7;
	Sun, 24 Mar 2024 22:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319865;
	bh=2q6oHfjoHzX8gP5qDR5Um+xcUNC7XmVJXbcW1TFzcOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=os4uNrF27X8vpdiUuNmGr7rHbMcQ7RgkCxYVv7uXmpoUwiHAjsPX/Bw+iLni4Z++v
	 RKFYnrlyRH6DprlgLPqi9TZTB5v7cj0+wHuAjPCd44vaMHENf66xaxywoEfqdJlg+Y
	 dvGqIcYTc1COLfmxdpVxkNQ4SOrZpe5G8SlYRG8wIQVWSFDAlaZwYM+lJ1b2vFkAbN
	 krrOGTMPIVX9Z06Hif6e3agEF0d+6NrCovGuoBNmhZ6+MyBI33oPanm59eO4An3whT
	 SBXph8xfEa92ui+t4Lkd4oB9BcywIPYhkZ11gknWDyuMWAnlk1I7twsAgdGRZi4ofM
	 VaBL70/d3qG7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 170/715] wifi: iwlwifi: properly check if link is active
Date: Sun, 24 Mar 2024 18:25:49 -0400
Message-ID: <20240324223455.1342824-171-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Miri Korenblit <miriam.rachel.korenblit@intel.com>

[ Upstream commit 556c7cd721b5262579ba1710c3b4e7ffdb5573ac ]

Before sending SESSION PROTECTION cmd the driver verifies that the
link for which the cmd is going to be sent is active.
The existing code is checking it only for MLD vifs,
but also the deflink (in non-MLD vifs) needs to be active in order
the have a session protection for it.
Fix this by checking if the link is active also for non-MLD vifs

Fixes: 135065837310 ("wifi: iwlwifi: support link_id in SESSION_PROTECTION cmd")
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Reviewed-by: Johannes Berg <johannes.berg@intel.com>
Link: https://msgid.link/20240205211151.c61820f14ca6.Ibbe0f848f3e71f64313d21642650b6e4bfbe4b39@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/time-event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
index 98c64ae315e68..da00ef6e4fbcf 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/time-event.c
@@ -706,8 +706,7 @@ static int iwl_mvm_get_session_prot_id(struct iwl_mvm *mvm,
 		 "Invalid link ID for session protection: %u\n", link_id))
 		return -EINVAL;
 
-	if (WARN(ieee80211_vif_is_mld(vif) &&
-		 !(vif->active_links & BIT(link_id)),
+	if (WARN(!mvmvif->link[link_id]->active,
 		 "Session Protection on an inactive link: %u\n", link_id))
 		return -EINVAL;
 
-- 
2.43.0


