Return-Path: <linux-kernel+bounces-124581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C88891A36
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 070B01C25622
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDD015699D;
	Fri, 29 Mar 2024 12:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qX9i/f7U"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DD015697E;
	Fri, 29 Mar 2024 12:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715460; cv=none; b=GmqFanQ1Ase/2p+Jud9ASg4jza+4immW6/Kt3wL999H+VfmWR/vHq3BSGSoHmiZmECzBZwfS9V+8u6VsukY/bWHbK5glduONXeHJZZnQ5Elg+k/L3V8LIwBXQndGKvvc/yco12tYaF+2+jyIS8V7crQgKTdTc9ehIwDLk52EUd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715460; c=relaxed/simple;
	bh=cJLl/5YT8hRa+slFM39tOxmQdtagQbxhdmoB7z3z99I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cXfC487bYi4F34zVBV6fbu4xVNzBWNEYMUeWxFnZ8mpMlrFLwxTbHOL/sOelw+yJdaq5pjzBMH9vuDrfGi6Z9O/0fZGs1/a3OMEwRiPxvS0A2//MNA5SdsPql8gXcy+Gp4iFmSY4CIUDI8Y+02kWPF5v/xm+4TTvUsZSFtdbIvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qX9i/f7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA6EC433C7;
	Fri, 29 Mar 2024 12:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715459;
	bh=cJLl/5YT8hRa+slFM39tOxmQdtagQbxhdmoB7z3z99I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qX9i/f7U2JbIE0tEtWxJocj3Y+sCxcHEf9ljdr7kmOG7BsVnbBmJhEIH78z3VKdpC
	 gFKp5Eadt2TroAjeJWzjeTSW6kisypHQaPIYfx+SZQXexwQUalLzVSSS/kUA1JFcr6
	 aLfUJlUF0sOtcPM6LAGRXoEzMS4uRh7cmRhWxdsFbwx9NCzT8fJnARSywbfGaVKFb3
	 vodT2+jv3h1NQOdWMdwivS3eADCStM3Hy7oNrgrv/CubB9AiuMQ+IGUcAqPNMmOz1J
	 SCF67ylP0/OCFFrG/nEOtTsTrN6XaqC/oAh3Zf2rZxHzLH1AJopMZVkRDQKb6mP29d
	 21Wlanz3TpTiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	yi-chia.hsieh@mediatek.com,
	Bo.Jiao@mediatek.com,
	benjamin-jw.lin@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 30/52] wifi: mt76: mt7996: disable AMSDU for non-data frames
Date: Fri, 29 Mar 2024 08:29:00 -0400
Message-ID: <20240329122956.3083859-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329122956.3083859-1-sashal@kernel.org>
References: <20240329122956.3083859-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Peter Chiu <chui-hao.chiu@mediatek.com>

[ Upstream commit 5d5edc09197cd8c705b42a73cdf8ba03db53c033 ]

Disable AMSDU for non-data frames to prevent TX token leak issues.

Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 26d5675202ba9..066b5a494ef61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -757,6 +757,9 @@ mt7996_mac_write_txwi_8023(struct mt7996_dev *dev, __le32 *txwi,
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype);
 
 	txwi[2] |= cpu_to_le32(val);
+
+	if (wcid->amsdu)
+		txwi[3] |= cpu_to_le32(MT_TXD3_HW_AMSDU);
 }
 
 static void
@@ -887,8 +890,6 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		val |= MT_TXD3_PROTECT_FRAME;
 	if (info->flags & IEEE80211_TX_CTL_NO_ACK)
 		val |= MT_TXD3_NO_ACK;
-	if (wcid->amsdu)
-		val |= MT_TXD3_HW_AMSDU;
 
 	txwi[3] = cpu_to_le32(val);
 	txwi[4] = 0;
-- 
2.43.0


