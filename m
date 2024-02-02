Return-Path: <linux-kernel+bounces-50408-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 560F784789A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 19:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE40F1F2187A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 18:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2CA15697D;
	Fri,  2 Feb 2024 18:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CjMI0VLQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B4B14F9F7;
	Fri,  2 Feb 2024 18:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899295; cv=none; b=I2p5N1QQMtA4PufQ8Mk8E5E4rhJPxzGpMr9gaGwEStiQap30V1r3Q24LTvRltDg1E6gLlf39srbl8bFj1EbVMdIZNy75gHbaJn4UKHl2cTL3FEvugEOgKyZhVRVj4dpJQXvY0nxoKsDslGFyHLGAarwvTgDF7+xFQ98Go4L8lms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899295; c=relaxed/simple;
	bh=7A194sjGwh2ymh0J7yf+dtHgssgekM2JRQ/YgIOyOrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e30pIdy0foy7woNmi6DWlsXx+AxCaaoD6j371O86wZOQ/Xn7DsaRRX2a9zS7+wYwk6O8WHsDWtaFfW7LXQm+mNnSH2D9hKHiodBoyynJa6xeVUkUvMBiZV0tpiV3EWlaeBo+TF5rrug8nr+J5247Rj4uog3YDWLhcKySwA/a2a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CjMI0VLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA078C43390;
	Fri,  2 Feb 2024 18:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899295;
	bh=7A194sjGwh2ymh0J7yf+dtHgssgekM2JRQ/YgIOyOrQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CjMI0VLQ4E0OtckLunPlM+lRkGxNUoQOJKRNGYS7wbW+kREQn7635t+kg9lOzrIyf
	 VcgfZI+FvtPamv0JKZCWLzoMV1ueO1avfoAvM15tJ47ZmAIN3UFn/4Wwcpq4y5G0Kz
	 vu4HdkMplQ+fmb5I4rC1XrYeNEk4I7KlkhTv3cuBdBhJ4RlGBH3rG7JxxYCyp1Pzdv
	 Dy5E/T/d7NsiinKly4FgFROXUUKjwgNq1EUJufrKXULU/HAe4FD2EVFIEYTRsJeLRp
	 hUhMfqNxvDC3/imRXb8t7Sl2IKRcgYKEj6SvnJEtCt26Z1xkFr/yztY0/AFEWSVrNq
	 HZDz1GqZ49Byw==
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
Subject: [PATCH AUTOSEL 5.15 02/11] wifi: mac80211: fix race condition on enabling fast-xmit
Date: Fri,  2 Feb 2024 13:41:16 -0500
Message-ID: <20240202184130.541736-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184130.541736-1-sashal@kernel.org>
References: <20240202184130.541736-1-sashal@kernel.org>
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
index e10bcfa20526..f4deee1926e5 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -696,6 +696,8 @@ static int sta_info_insert_finish(struct sta_info *sta) __acquires(RCU)
 	if (ieee80211_vif_is_mesh(&sdata->vif))
 		mesh_accept_plinks_update(sdata);
 
+	ieee80211_check_fast_xmit(sta);
+
 	return 0;
  out_remove:
 	sta_info_hash_del(local, sta);
diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index d5c89c6758f2..2ea0cdc1b506 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -2965,7 +2965,7 @@ void ieee80211_check_fast_xmit(struct sta_info *sta)
 	    sdata->vif.type == NL80211_IFTYPE_STATION)
 		goto out;
 
-	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED))
+	if (!test_sta_flag(sta, WLAN_STA_AUTHORIZED) || !sta->uploaded)
 		goto out;
 
 	if (test_sta_flag(sta, WLAN_STA_PS_STA) ||
-- 
2.43.0


