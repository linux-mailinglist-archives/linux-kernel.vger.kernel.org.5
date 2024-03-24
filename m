Return-Path: <linux-kernel+bounces-113731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01A488864C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69DA328D32E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504C712AAC3;
	Sun, 24 Mar 2024 22:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3Kby8No"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6452E1DE124;
	Sun, 24 Mar 2024 22:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320734; cv=none; b=NlIHfLhJXxeWLpNBnfovU8frofUiPQWnyIiWCutliVzpaAWjd3ub8XQwYl+MekYH7s/iftbHUGm6XSV9BZxxHLZxniVFz2NelbB9nSWV2SCVKVBuiZ2T4czIfHL+pufhLa3erorniptteShj+QG2/xAfowGbryhyAJfGDW+f2qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320734; c=relaxed/simple;
	bh=9dvy687CtwURzfVHw6lTuPxhxIja+b8C9bxt43jmUvw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOKhF9HWKVSrnn/a5ZUWKyZaMU9qUTSGZXe9M3uJhUNbHNRxONcckSl1yjGd1CLvrprweZlh/CEd/6XYGT8I5L0EdwJ8fS5y7stbE+gfAErzoP7zx0xLz83xwGu9oibA1ac21w5c/9SIBon3a249xxVZq63fXWO+mLC3REQTbzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3Kby8No; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DA3C433C7;
	Sun, 24 Mar 2024 22:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320733;
	bh=9dvy687CtwURzfVHw6lTuPxhxIja+b8C9bxt43jmUvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R3Kby8NogT9NJA4agJjV3n0WJ7CuNuZjCBYXCxyZ98lSdhYgDrM8nxFCu42TtxIUL
	 Ape/sVJWrtCX2k96iIjqACFhMbcTFhXxyLVNSyJcBLONhuw05514/Ez3nYcSa4wNYZ
	 5xJhe4gL4xJAKv0ClTiGWnXflroxgxorVStIRw9iWOCp38ApDdv5ONdunIAuRxIBhr
	 U9X59FdTc/KlntaYnJ17YSYlJ0ow67ew9PHVzHAqA/reIU6nEOdMQgPAoEFJS948pq
	 9QDU0v9JUodGn4Cae7OwiWkT0cn+StoVMIcGMRZ31MP+V8nAX0WbOQEHwZUnRfSi7u
	 Hg4kMgcmqt73g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Howard Hsu <howard-yh.hsu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 296/713] wifi: mt76: mt7996: fix HE beamformer phy cap for station vif
Date: Sun, 24 Mar 2024 18:40:22 -0400
Message-ID: <20240324224720.1345309-297-sashal@kernel.org>
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
index 55cb1770fa34e..1d75bf23a02d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/init.c
@@ -578,11 +578,12 @@ mt7996_set_stream_he_txbf_caps(struct mt7996_phy *phy,
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


