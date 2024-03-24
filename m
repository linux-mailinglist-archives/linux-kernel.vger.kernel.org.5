Return-Path: <linux-kernel+bounces-113134-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB158881BA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45AD7B21020
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6827F16FF54;
	Sun, 24 Mar 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvEdY1/M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D8D16FF3B;
	Sun, 24 Mar 2024 22:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319941; cv=none; b=VLXqk6gAlfutGtyk7PxlYNe1w1UbenvQNxAUqTWXTcjpR21JGj4iXX+zWIE0+Rl7Q0hL63Sg4Ynt3yiZV1QyrZ52L6YGDPUdEgnLT9kRGtW6PklXzs3wP1P8vTe4OeaPzdwJEhp2K2qcKyLDFMyS8t395DvOsC4GjG2FpTez+4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319941; c=relaxed/simple;
	bh=c+3EJWvAEmgGLHgnQsMuUKcHVuSIgMWz435MQegGdok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=POBOK73JgXX6iV4jt0O0ocVlKMYTkEWUC4ywNcctCf57ruN+Vk4A7XTo2iPvAci01sheR8q3X8DK+xipe7/yGOZ4d+wLPY4xKPJoik8Tl+NZpjfc1QFWuqYXPpzid5OnU/JoovSvSwbPc5eUNqYeO6UI3uWtskQu+B+VlsDKPQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvEdY1/M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B291AC433B1;
	Sun, 24 Mar 2024 22:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319941;
	bh=c+3EJWvAEmgGLHgnQsMuUKcHVuSIgMWz435MQegGdok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VvEdY1/MuqEJFDEV435SZ8KWwAZaWof1oQdh/OB1ch00WFgU30rgz5sQhRswqBV+J
	 gF/8670fqh69q/kkfLfUPSNHR0Lt0i0JzL02cjjlXY7bCWfH/3guLBNuEX2CJFf4hs
	 hSW73iBNiRvK+vjlS5U56xExZQqFNzVSM12OveXe2XomaiScCPIS0Efz0z+8goVmef
	 7tVAUHdVNU10x6q0zIPq2NFWD6ofgaiRcQRWrTMe838T5RDxl7l9IkyE9ymb7Q4c62
	 2y0UwpTzGyUQ7XeaKoRrcUkm7wt/eBb76BUL6d7L+dFXO0NvmjBCnJpQcth/q5+LaC
	 oq4TMHwOnsarQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Howard Hsu <howard-yh.hsu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 247/715] wifi: mt76: mt7996: fix HE beamformer phy cap for station vif
Date: Sun, 24 Mar 2024 18:27:06 -0400
Message-ID: <20240324223455.1342824-248-sashal@kernel.org>
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

From: Howard Hsu <howard-yh.hsu@mediatek.com>

[ Upstream commit e1a491e856a8a36c46b39ecd07f3bba5a119d83a ]

Set correct beamformer capabilities for station vif in HE PHY
capability IE.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: Howard Hsu <howard-yh.hsu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/init.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/init.c b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
index 0cf0d1fe420a2..1a1a60744272d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -1012,11 +1012,12 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
 	/* the maximum cap is 4 x 3, (Nr, Nc) = (3, 2) */
 	elem->phy_cap_info[7] |= min_t(int, sts - 1, 2) << 3;
 
-	if (vif != NL80211_IFTYPE_AP)
+	if (!(vif == NL80211_IFTYPE_AP || vif == NL80211_IFTYPE_STATION))
 		return;
 
 	elem->phy_cap_info[3] |= IEEE80211_HE_PHY_CAP3_SU_BEAMFORMER;
-	elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
+	if (vif == NL80211_IFTYPE_AP)
+		elem->phy_cap_info[4] |= IEEE80211_HE_PHY_CAP4_MU_BEAMFORMER;
 
 	c = FIELD_PREP(IEEE80211_HE_PHY_CAP5_BEAMFORMEE_NUM_SND_DIM_UNDER_80MHZ_MASK,
 		       sts - 1) |
-- 
2.43.0


