Return-Path: <linux-kernel+bounces-27963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3EC82F868
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 21:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB6D288D4C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91CAE132420;
	Tue, 16 Jan 2024 19:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyWxOIXQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CA0131E40;
	Tue, 16 Jan 2024 19:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705434694; cv=none; b=bTH+NpZw2mpkXWZynJQepfJKf8ZxqgdPOshZuRoTSbxS8ZpSBmwGwJqkEkTo5jkg43Zfpy0YvJ2H9NnpmjMm15QvBFpj7x3UIr8jZ+YvCpeBkoeiGJzwihv87/5LrzT/ISMyFmz4XEPg5twseIr8MG5gYs904bmKWLiJU4cWe6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705434694; c=relaxed/simple;
	bh=fPkw5eb3zMl6IQEhSEcVnJa8xAm0OOdWnSuOkNjPXqY=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:X-stable:
	 X-Patchwork-Hint:X-stable-base:Content-Transfer-Encoding; b=ZH03kAE/+nr2LC1cw4VXrhI2NAbS3biWwN9R6PY9f8UnE6kQo7/qotwLc0JCyD2EBwe3Mybsk6u+ya+fXeJh9sNDEEY8SmeIgxQx8unOgIFPGivxbqwSpeYwBsDFJYyFpNNAcFoouqQTqmBiAt+k6KUmAVfE9LffYMlxlh0avFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyWxOIXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F60C43399;
	Tue, 16 Jan 2024 19:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705434694;
	bh=fPkw5eb3zMl6IQEhSEcVnJa8xAm0OOdWnSuOkNjPXqY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyWxOIXQaYBRsHfzgEk3uj2luDUBOUjCxjyxgsN+69onBW0doIPGMBgmUUhVCDog9
	 6aPR3l3wB2fucyN8FPCIh8HDBdocdrBOlW5mk0skP/4AgdPt3bclBppcJ4hQwMPZBo
	 Jvhx9joJk1DNvFJYVtatbtKlNAz8g8pIxKVnOxYN05kU4l5gZoTQpfgdfP4GPbqiCp
	 DUOUX7L3+BkvT6wQKf2m7WYWU1JPIuVB1pwUsUhVsOqYYc9pATVbbTph+UrErdPUZa
	 sM3jLQn6BPSh1sb4/h3x4865abSQBHl3LqqYskHVR6C4+4+GlKNGnitoTRi3tb7hYN
	 HqQHuGnEkC+Uw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Antipov <dmantipov@yandex.ru>,
	=?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= <jerome.pouiller@silabs.com>,
	Kalle Valo <kvalo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-wireless@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 052/104] wifi: wfx: fix possible NULL pointer dereference in wfx_set_mfp_ap()
Date: Tue, 16 Jan 2024 14:46:18 -0500
Message-ID: <20240116194908.253437-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116194908.253437-1-sashal@kernel.org>
References: <20240116194908.253437-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
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


