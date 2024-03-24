Return-Path: <linux-kernel+bounces-115422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8BA889B78
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E24E21F2FECF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2162092F6;
	Mon, 25 Mar 2024 02:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWk8FhZk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645061D7907;
	Sun, 24 Mar 2024 22:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320601; cv=none; b=D/N8YmfDMXY6VmCL91nYuI84Vd8we1wGTbxE/jfZ6x68gO345fSd8k9OVBmSChk9QYN+gJtxC8jYddTr3Ph4VgFTQj9f18g3fZaJx6upGMvk+/jHxe4Kx0L6nR1IDkf7twvqJUkTA2nObrGZ/a51WbJAAAKpW2t4n6YNtH3xGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320601; c=relaxed/simple;
	bh=X7TKjqsL4zk+BSxoRctPiFstPwVin85Sm/10EgBHCfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+fMurVoMby3mcGT9prq5nYp77rmR+vn0DI2EcHtThJq4v5HlD0lRxbq5YvCCOYiKGxYGSeWzd3fvZZ1P44PWpOoXxzX8/8PGEGTgzhrvktEkPye5HJ8XkpGUySXbkQ3I67/oHr4qhRQL1Ve5h8WOn1DspMbVhu/Esi0IVwH2Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWk8FhZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77358C433B2;
	Sun, 24 Mar 2024 22:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320600;
	bh=X7TKjqsL4zk+BSxoRctPiFstPwVin85Sm/10EgBHCfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SWk8FhZkzbTZZmMcEJ2fjrcuYconAvVyHZo5Y0dcFVnHEjPmJwaBdvDZxzkwX+RFo
	 +aJ6Iy4QtmIJnTRMUNdTdYICnWI4S2wEpN/RJ+1/L3/n2UxShskv91NuhP7ZoraRvm
	 9RwYdvDdyt6Xt6oCr55LjAO0eUahGop8v9n+7incIplPZqpHym1AAUQoPrxaggvFzS
	 oD84+jNsFI2RJftdORlGabQeEUgjKGj2hTjf5ygUyPWF3GfvqpAaGcfLinYSTbdD8m
	 IBphZKE7uyHtmE4ou9+3qWlKhGxfjoS8YFaAX2QSwYuk6mb/SNd12txT/xzGFd9Cil
	 N3Jqx/e25oNoA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Benjamin Berg <benjamin.berg@intel.com>,
	Ilan Peer <ilan.peer@intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 161/713] wifi: mac80211: use deflink and fix typo in link ID check
Date: Sun, 24 Mar 2024 18:38:07 -0400
Message-ID: <20240324224720.1345309-162-sashal@kernel.org>
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
index 241e615189244..6cfc07aaa1b6c 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -7502,10 +7502,10 @@ int ieee80211_mgd_auth(struct ieee80211_sub_if_data *sdata,
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


