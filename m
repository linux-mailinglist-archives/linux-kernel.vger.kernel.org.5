Return-Path: <linux-kernel+bounces-115389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 209F08893C3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F471C2E5D8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AF1FC108;
	Mon, 25 Mar 2024 02:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQY4wiRm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF42614431A;
	Sun, 24 Mar 2024 22:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320664; cv=none; b=UAlamrzPUCxcY1qD29NJkskNmuI6btFoBXSWPeozdC89yTKJUwnAtia8XVF4/tBUez9edUYAm4yQ1/aKoQiJUOKyqPwAlZNN2/G6C6NwUVsh/3G/9V5c4OJVU+Bp5N2yjNLSx7xcDZncWnjNXTZ1dLvxjthj0Cy34IpUH2Wi73E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320664; c=relaxed/simple;
	bh=2q6oHfjoHzX8gP5qDR5Um+xcUNC7XmVJXbcW1TFzcOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyrzWMofztJ1E0AfGYoCO2oJXvVTljKlK/GSgK98XlOjrSGK0JLeyx62JXlGz2F4kj5ZPNWNnhn+riRfFIftlGwtJGyYS+lCs/c001ymQ5gwLqvte9L2jIh8aWTqsNItf2WD6x336SU/1BzW1MC+bYN4w6RTE+14bGf1BzzE6bU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQY4wiRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16537C43394;
	Sun, 24 Mar 2024 22:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320664;
	bh=2q6oHfjoHzX8gP5qDR5Um+xcUNC7XmVJXbcW1TFzcOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQY4wiRmVMqfjIPKGNg4ALH0wX9nb77esHWI32Hnu363IqmKwUU77OVB2PQYsbF2G
	 8k1URSekz9V8H9nyFrxOK66TnkkohBkgcyy+9SIL9sdXfQ5YvCv86VtvfjhAiaKh17
	 Ofl6gnbXtf5Wm39JqiSmGJbvb/iOqm4CJOlJl/lSUmHIvA5zaNpRTKGDBRH4Ik7Xij
	 SyYXnh7Sv/DDk5G6TFz49hhACijb9tVunZhTZNAAWcdc9vfVM87TwRVJEFO+hWv90C
	 TC4Xszia87tg9eJ/aQC03dlfhoZHzFZOwPVO8ka/8WF+MWJffcbaOiV6KDxt/L56Go
	 S1pJtpVAZO2eQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 227/713] wifi: iwlwifi: properly check if link is active
Date: Sun, 24 Mar 2024 18:39:13 -0400
Message-ID: <20240324224720.1345309-228-sashal@kernel.org>
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


