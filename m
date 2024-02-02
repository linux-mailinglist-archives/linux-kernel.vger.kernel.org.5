Return-Path: <linux-kernel+bounces-50427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5F28478D5
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1734D28B86D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0561159CA9;
	Fri,  2 Feb 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1/pHSuS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0850E159C88;
	Fri,  2 Feb 2024 18:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899340; cv=none; b=crzgGx6ULJ2A0u2URuqgAhOa31xzIZgz2tKFIknvGeSjAhOXQPRi2KYxyYNvHU3acIwaLoS+1IpaS0oYK2me2xz1c+a6XmKCmqe3kt+LOmp8sxyvIwnoYr7hQmQTibaimLGdUlSvYfPWzkIEWYSKEQUcaSasacZl1Oapqq0lCx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899340; c=relaxed/simple;
	bh=Gdc2I7i5JEkHocibM+yybNafm4ZVrKVYQ/o4/jaK2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRN2yRWaiVRZBPC6rlFz2RJ+EDQdYpthxzfK6cDlY0KbarnBO7ovS5q7Wyoz3rfShM0n0p/aFCjv4p364y1Fa7AOYdBf+nn1SzWRd25VjJaIrk26wDpLH0kgzKVZK+frIWaXUsYE83MpQy4wmzHPle+3PCYaVIEGBrCq5zYO5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1/pHSuS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB75C433F1;
	Fri,  2 Feb 2024 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899339;
	bh=Gdc2I7i5JEkHocibM+yybNafm4ZVrKVYQ/o4/jaK2q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F1/pHSuSbp2+2a/rTtmywEGB+mAd9gIr+k9m/QBVjRDlFXUNFWFFJAqfjc1lGmtD5
	 Pqe3BqRst9tvY3amSYFhgYXA9n+NpOKJzNkFaNyBnf4BsEc8pI+/zqWc38Wtz8aGdn
	 A33e2D62C1cTRyMPsU3FKE30jTIlPcn9120LGD71pUMnLTJVBqRUVdMvVcaK1SaeQf
	 BpVVRw0hvmZ7OYx3dGkv1KwQUOSA0jX5LJ+CyCJVD0SsuoNT63dhOVjWZOWbijhBim
	 Yqv+G0TrEaasDCnx4MPVO4fhXerlqrAndLaPh5uj2KZPzRbO0+bfTjzMiM5C3PSpqB
	 bfIM24DDxGYZg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Felix Fietkau <nbd@nbd.name>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 2/6] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:42:08 -0500
Message-ID: <20240202184215.542162-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184215.542162-1-sashal@kernel.org>
References: <20240202184215.542162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
Content-Transfer-Encoding: 8bit

From: Felix Fietkau <nbd@nbd.name>

[ Upstream commit bcbc84af1183c8cf3d1ca9b78540c2185cd85e7f ]

fast-xmit must only be enabled after the sta has been uploaded to the driver,
otherwise it could end up passing the not-yet-uploaded sta via drv_tx calls
to the driver, leading to potential crashes because of uninitialized drv_priv
data.
Add a missing sta->uploaded check and re-check fast xmit after inserting a sta.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Link: https://msgid.link/20240104181059.84032-1-nbd@nbd.name
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/sta_info.c | 2 ++
 net/mac80211/tx.c       | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index 0f97c6fcec17..e330036e02ea 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -683,6 +683,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 8bd01dfa75cb..5fd9a6f752a1 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2919,7 +2919,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


