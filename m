Return-Path: <linux-kernel+bounces-115654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B198889460
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA88728D4F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:55:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 061AA207E61;
	Mon, 25 Mar 2024 02:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5V5JUN2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB571514CC;
	Sun, 24 Mar 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321527; cv=none; b=o8oisPB5uKlbhKfkocEPP5klp8J8SV8aeekE+egfFI4GtVHBBhiIe2sbqc1PHw4PxaDJK7d7yMK8Db90be5l5dzQ0Dp4/jBIBQuAJ4NHHIflPl2DAXPwxEgWS4tmyv7nSigbhqSaAP4r20CB8h0Z8i/8TAvR3/mF+fE6aHhBj/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321527; c=relaxed/simple;
	bh=nSr7b2uTkn/7dZtBoetN/blKXW6NY8/MtrK9mjN0nGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EksGhLJnl6a3fuMZfvg1EMZF50XZ9/HPN4M/LhEDzxGFztH+0FMjizAxelnCw8Rbz2SsyCX94GIvUYIA5ADxU1fR/unU9d0j60JmZQ3i9AEqhAq0tXx7/bTNJ3/annx+EQvEwTPMOeAv+bbK0+0gWCXfae1YKO7yKxacjRgs+aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5V5JUN2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6B63C43394;
	Sun, 24 Mar 2024 23:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321527;
	bh=nSr7b2uTkn/7dZtBoetN/blKXW6NY8/MtrK9mjN0nGo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m5V5JUN25smPUD8e8efx/7z+ANOatWLUwYpL8R4GchYp3gPyo94gTdJ1d73UnykOg
	 X3HC5zlhWQPN+rrObWe59dFfMMaIQdax5AkQRkQtB8KWadNzYj6mOdH3r+SAzC7NT7
	 FILXr4m3M2JmZjDH5z4S2Kp0dJIW1yxfmRFdHSRgD3FmXOJGKfOLl3tjp00CPWnOMb
	 dMc/+ML1Gqw7JxF1Lh7H+yg2OrQNHq+GESHWoJOTeqwv6DJZ51SPN2A8m58pa283Y+
	 t02+ZF7h/X8g95cOdjsboQ8tukO9tLGMkJwFVj34e0SuzOM09wrHJeKEgPRXhIsLud
	 rtXm3e7Cl4x3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Howard Hsu <howard-yh.hsu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 254/638] wifi: mt76: mt7996: fix HE beamformer phy cap for station vif
Date: Sun, 24 Mar 2024 18:54:51 -0400
Message-ID: <20240324230116.1348576-255-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index 66d8cc0eeabee..e843d40df5bb4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -557,11 +557,12 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
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


