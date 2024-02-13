Return-Path: <linux-kernel+bounces-62725-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7BE8524DA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EE0DB2888D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7BC12837A;
	Tue, 13 Feb 2024 00:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dnSwQ2Cn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4695812836B;
	Tue, 13 Feb 2024 00:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783828; cv=none; b=AkTqNrgNzRzMAlFbjDlnb94NIG1kecNsvP33dwIZsAgwYQGT18uqVZgZZWUe9mEtOG1BOVmRzOGhNEmGST4rkiMC5UiztQUpLhVGjkNyzpyYGIIE+rK+yIZSKS9gmzmY1Q/IQWaE62sL3UzHzU223FO9k/ys2yh5z84mTCSkSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783828; c=relaxed/simple;
	bh=cBm2UBuJTG5yTg3NrSywZMdNfQKwSwm2BxLFtbcWarI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BS7M6I5mjDjqdS/LJCYcgXylrUZoXTHWTy999eK15ToVEhS6BnhKnLZzGAYpI4gkZr/VZ07lo/rDHQBOuJvXMoCxgZcIFNYoeJXiuKrDL40v/uqWem40sG/VJBZbjt6lZg24ors5DJmqwQ1u/2UnCysG5WhQK4GF/lBvGhhkeD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnSwQ2Cn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D503BC43399;
	Tue, 13 Feb 2024 00:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783828;
	bh=cBm2UBuJTG5yTg3NrSywZMdNfQKwSwm2BxLFtbcWarI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dnSwQ2CnRctiX1f7chLSG239QZHL18Xt6eoqc8FIBOaathpaX/2NeJtTkVVOs5YH3
	 nmFjlQ3DtOwaLsfCnB7hSiSk2/4O7CtxOrEfgFmM1a8Mu0PDcQKM4ngFQQLUjlwOgZ
	 gHHblCvtWgkje/nW5igsCaiL61uzjRF5CewHg+Ulkr135/GOotGxRB/LhM+Kcw9whz
	 H1WTFKpi1Cx8+pXIBtnYsSlDVPKkVu8UrQ4X2sE9/1mhPP+9nmhU66gDJ38/ZG/H0e
	 dI+Fssw8e7n73Wc35G1Ot7ihNgZymg1Kx6Pg4zAY9h5y/RUefHos0JrH/T16rtaVzU
	 BjcVq+rdHQ2Bg==
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
Subject: [PATCH AUTOSEL 5.15 13/22] wifi: mac80211: adding missing drv_mgd_complete_tx() call
Date: Mon, 12 Feb 2024 19:23:15 -0500
Message-ID: <20240213002331.672583-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002331.672583-1-sashal@kernel.org>
References: <20240213002331.672583-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index cc6d38a2e6d5..5da0c2a2e293 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5923,6 +5923,7 @@ int ieee80211_mgd_deauth(struct ieee80211_sub_if_data *sdata,
 		ieee80211_report_disconnect(sdata, frame_buf,
 					    sizeof(frame_buf), true,
 					    req->reason_code, false);
+		drv_mgd_complete_tx(sdata->local, sdata, &info);
 		return 0;
 	}
 
-- 
2.43.0


