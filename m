Return-Path: <linux-kernel+bounces-112979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8074B88803B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 015E2B22B79
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA512C536;
	Sun, 24 Mar 2024 22:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DX7AAySb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6DE12BF16;
	Sun, 24 Mar 2024 22:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319792; cv=none; b=MdWdVpGiMmd8m+TA1pykoYSk0PJvK2JVYW63LLhz7+NTXT4ZEmEFprTcujPBBa7G5TxKZms1q/08NO3ipjaUuZ3Ly5Gx4Q/OFCxi9M4AR5VkbGzKwAEJHLCMK6zalbIVE4OScgNOPHlfMtRbAtFkirnhhj3Q6VXpnoyx92aqtzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319792; c=relaxed/simple;
	bh=FWe9WRlEAvGjT19jcAwd238r8ebAAw8RYSXfaycOTi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K4en68KYkJvqm20Stjn3s2ZlCQ4YppDcA91FRC+kjbQyjivpFC1eqUZ0Z4+08998epfQVMADvUTDxUXP8cLkrxpCLGiB8PTysI47m62T0npolzrr3syBeGfPSJHncG7KXAnpctcWQyLpCuHPG2DsGP+jIcVYkIcqOIan9kX9aGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DX7AAySb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE8B9C43394;
	Sun, 24 Mar 2024 22:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319791;
	bh=FWe9WRlEAvGjT19jcAwd238r8ebAAw8RYSXfaycOTi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DX7AAySbcDl6ynvue4E5RWH/Id+rg1JyYFX6+azWIDfo1wgiE2eFHwcEO2IG1RDIh
	 RMjS8OF5sp3rGQnJmDOuWnem/YDbwNdWP10n0mZlHlDjvHi2exyOaSrrcSCIQ0T4+K
	 Ksnvtl/CT/p4ktn50M8F4zr96P0kVGvOih/hucGEz5f5TVPfooLtSmuY/g7otw3sjA
	 t2MIaa5agdKKGr4jxdx7qqszvSo/6ic0+i4/J+ZK5zDor66VGpnbM+WyRtfSiT2QHZ
	 3naRXf4OXKhqmDUEj8Vghc/rp076jHYpzVUvqdL+ubtCKXUrJiapkMtfwokCVA4mJz
	 P0DJFjUfr2O2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 092/715] wifi: mac80211: use deflink and fix typo in link ID check
Date: Sun, 24 Mar 2024 18:24:31 -0400
Message-ID: <20240324223455.1342824-93-sashal@kernel.org>
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

From: Benjamin Berg <benjamin.berg@intel.com>

[ Upstream commit e10322810ce0d0d4a5a319458c4e1e052c6fe9be ]

This does not change anything effectively, but it is closer to what the
code is trying to achieve here. i.e. select the link data if it is an
MLD and fall back to using the deflink otherwise.

Fixes: 0f99f0878350 ("wifi: mac80211: Print local link address during authentication")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
Reviewed-by: Ilan Peer <ilan.peer@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://msgid.link/20240111181514.4c4b1c40eb3c.I2771621dee328c618536596b7e56232df42a79c8@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/mlme.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 2022a26eb8811..20d863370796d 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7523,10 +7523,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
 	if (err)
 		goto err_clear;
 
-	if (req->link_id > 0)
+	if (req->link_id >= 0)
 		link = sdata_dereference(sdata->link[req->link_id], sdata);
 	else
-		link = sdata_dereference(sdata->link[0], sdata);
+		link = &sdata->deflink;
 
 	if (WARN_ON(!link)) {
 		err = -ENOLINK;
-- 
2.43.0


