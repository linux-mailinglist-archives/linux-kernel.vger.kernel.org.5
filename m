Return-Path: <linux-kernel+bounces-113140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 307AE8881C6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61A7B1C21ECA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607CC16EC03;
	Sun, 24 Mar 2024 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9ZCoII8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8594D16EBE4;
	Sun, 24 Mar 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319947; cv=none; b=qrelHRpGuKmhfcvF2nAsfo3QXcCKQCswtSPeL+YnpOJaOTTkauo7/qccvvo8d0h6U1sM1ZYoKWNyZke01gid3EAj+c4at69X0wwXK88HeGCmrDjJNevuoQoZPca6E/0aN7RtzjuH5fNd+qcAZMROl3VZTl2eTrzG4SOjggatq08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319947; c=relaxed/simple;
	bh=sv4/1oKiZ1NfQVtAx8ws3BB1smFkKwt+29gB5TTjeXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aT7jZcuPuBPZ7+czREXuVCxmEmf7lEdZfARA0YzD2pXCgbqUdrK47eHF2oBWmc6zSzT2UGknUJntDZWJK3Ga+/CAIMdZAOkaGGrkAl7aCJKi25z2oj0AJW1OMcVF3Y9sD2FRNbHHqrOvTvxlH77uHFquPdSDtlZupfcfLqDfVlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9ZCoII8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E69C433F1;
	Sun, 24 Mar 2024 22:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319947;
	bh=sv4/1oKiZ1NfQVtAx8ws3BB1smFkKwt+29gB5TTjeXo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y9ZCoII8VoQ2xVAp6bKD7t7aow+N/YrgNTe/wonLjn0CSUOQr0AfojkToUIuehMn6
	 sBc6ZpEMSlGTYqirVIXjnxXxg+Zu+ofEBE2GfqDiu0Dn0LnhKD7qY5Duupwn0jGKAq
	 x6jJEDj9q3ynHa4Z3Bm+UqxWd0SIyFvDEYzaoBeC4989hMALJx3RPtsc2OvfHV7BZB
	 zsIpSRc6+/+ape9lD/bC+XsIiNR/xfd6m4VDc6pjLvme0CILQwHNXLePJd5Hx7kufs
	 uxbsodQ0bRCqpTFGlLY4h70k+jO/ElO1a1hbJlUf6wSJCrsbxVWEY4eXc+m1KOv3kI
	 /Lexnf09uNqCA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	kernel test robot <lkp@intel.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 253/715] wifi: mt76: mt7921: fix incorrect type conversion for CLC command
Date: Sun, 24 Mar 2024 18:27:12 -0400
Message-ID: <20240324223455.1342824-254-sashal@kernel.org>
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

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

[ Upstream commit b6351ef9994ccb93b2447d396a0c517964dff2bc ]

clc->len is defined as 32 bits in length, so it must also be
operated on with 32 bits, not 16 bits.

Fixes: fa6ad88e023d ("wifi: mt76: mt7921: fix country count limitation for CLC")
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202312112104.Zkc3QUHr-lkp@intel.com/
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index f5582477c7e4c..8b4ce32a2cd12 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1272,7 +1272,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.mtcl_conf = mt792x_acpi_get_mtcl_conf(&dev->phy, alpha2),
 	};
 	int ret, valid_cnt = 0;
-	u16 buf_len = 0;
+	u32 buf_len = 0;
 	u8 *pos;
 
 	if (!clc)
@@ -1283,7 +1283,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (mt76_find_power_limits_node(&dev->mt76))
 		req.cap |= CLC_CAP_DTS_EN;
 
-	buf_len = le16_to_cpu(clc->len) - sizeof(*clc);
+	buf_len = le32_to_cpu(clc->len) - sizeof(*clc);
 	pos = clc->data;
 	while (buf_len > 16) {
 		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
-- 
2.43.0


