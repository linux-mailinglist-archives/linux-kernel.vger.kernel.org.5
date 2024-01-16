Return-Path: <linux-kernel+bounces-28048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D7CC82F989
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E9661C246E2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA58145334;
	Tue, 16 Jan 2024 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3TNBrDj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 694196027A;
	Tue, 16 Jan 2024 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434980; cv=none; b=tXehWCLEbIwvPlSQE7PA/J9p0om5YQPh+XpJ1jBtkZCyFlFnRzf9LEljYByweyH/V61Asioi+ydtPsPh/uiKrEXGQkwSMOreL/4jjpt4syIINKIXUwh7Cneso7ww9eKR0VHYIhoMFU+aH8ojopOgIN6QQSi7jSFByNIURG5f2F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434980; c=relaxed/simple;
	bh=fPkw5eb3zMl6IQEhSEcVnJa8xAm0OOdWnSuOkNjPXqY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=qLllYc+xxw65O13G2oSAq5ORxYpbNJWaBzgAR82W6dfPDiqMf3wmOnjex9qaepmCD8vn3/ahpnMr91R4SyNa/bz2vv5iHnw8s0gqJ6k5vZo8kvkMjpe9WzACKRIJolCAukoAWCKkR4z7bPIRlTFaqqLpXc7Sj5dPw309r7aklSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3TNBrDj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A6B6C43390;
	Tue, 16 Jan 2024 19:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434980;
	bh=fPkw5eb3zMl6IQEhSEcVnJa8xAm0OOdWnSuOkNjPXqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3TNBrDj1S/iCDTaLyNYgQl4YLWStxW3fTc3z4TIs4bOwg7xxSsCpmmh7oYyvf7Tt
	 YfOy3LZ/FjGb4x4xxcyBqIiGd1kY4+eYGzMADEQEUjTITd4c9jjFIc17dJZpVDvvUH
	 o97hxwTrAaeUh5B+HcaXCMWQ4N35MBRHvsKAVwzDwaAetnXJ2ODCneqQ8SVbhvSYd6
	 fuow1xnr3Kh1dcgW+AaazuCDRD0r5A/crm1HZLsj3Xxr5pnt1cnuZhZnHwd1oNXmd2
	 oaU+M6lrEPL2/OG6qnNAcE/xI8AR/xFZfqZA4vA4200kFvZwdXuMQa4goJei1KbRR8
	 3/lzNI1GP2XvQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 30/68] wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()
Date: Tue, 16 Jan 2024 14:53:29 -0500
Message-ID: <20240116195511.255854-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116195511.255854-1-sashal@kernel.org>
References: <20240116195511.255854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.73
Content-Transfer-Encoding: 8bit

From: Dmitry Antipov <dmantipov@yandex.ru>

[ Upstream commit fe0a7776d4d19e613bb8dd80fe2d78ae49e8b49d ]

Since 'ieee80211_beacon_get()' can return NULL, 'wfx_set_mfp_ap()'
should check the return value before examining skb data. So convert
the latter to return an appropriate error code and propagate it to
return from 'wfx_start_ap()' as well. Compile tested only.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
Tested-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Acked-by: Jérôme Pouiller <jerome.pouiller@silabs.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20231204171130.141394-1-dmantipov@yandex.ru
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/silabs/wfx/sta.c | 42 ++++++++++++++++-----------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/silabs/wfx/sta.c b/drivers/net/wireless/silabs/wfx/sta.c
index 626dfb4b7a55..073e870b2641 100644
--- a/drivers/net/wireless/silabs/wfx/sta.c
+++ b/drivers/net/wireless/silabs/wfx/sta.c
@@ -354,29 +354,38 @@ static int wfx_upload_ap_templates(struct wfx_vif *wvif)
 	return 0;
 }
 
-static void wfx_set_mfp_ap(struct wfx_vif *wvif)
+static int wfx_set_mfp_ap(struct wfx_vif *wvif)
 {
 	struct ieee80211_vif *vif = wvif_to_vif(wvif);
 	struct sk_buff *skb = ieee80211_beacon_get(wvif->wdev->hw, vif, 0);
 	const int ieoffset = offsetof(struct ieee80211_mgmt, u.beacon.variable);
-	const u16 *ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
-						 skb->len - ieoffset);
 	const int pairwise_cipher_suite_count_offset = 8 / sizeof(u16);
 	const int pairwise_cipher_suite_size = 4 / sizeof(u16);
 	const int akm_suite_size = 4 / sizeof(u16);
+	const u16 *ptr;
 
-	if (ptr) {
-		ptr += pairwise_cipher_suite_count_offset;
-		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
-		ptr += 1 + pairwise_cipher_suite_size * *ptr;
-		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
-		ptr += 1 + akm_suite_size * *ptr;
-		if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
-			return;
-		wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
-	}
+	if (unlikely(!skb))
+		return -ENOMEM;
+
+	ptr = (u16 *)cfg80211_find_ie(WLAN_EID_RSN, skb->data + ieoffset,
+				      skb->len - ieoffset);
+	if (unlikely(!ptr))
+		return -EINVAL;
+
+	ptr += pairwise_cipher_suite_count_offset;
+	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
+		return -EINVAL;
+
+	ptr += 1 + pairwise_cipher_suite_size * *ptr;
+	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
+		return -EINVAL;
+
+	ptr += 1 + akm_suite_size * *ptr;
+	if (WARN_ON(ptr > (u16 *)skb_tail_pointer(skb)))
+		return -EINVAL;
+
+	wfx_hif_set_mfp(wvif, *ptr & BIT(7), *ptr & BIT(6));
+	return 0;
 }
 
 int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
@@ -394,8 +403,7 @@ int wfx_start_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	ret = wfx_hif_start(wvif, &vif->bss_conf, wvif->channel);
 	if (ret > 0)
 		return -EIO;
-	wfx_set_mfp_ap(wvif);
-	return ret;
+	return wfx_set_mfp_ap(wvif);
 }
 
 void wfx_stop_ap(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.43.0


