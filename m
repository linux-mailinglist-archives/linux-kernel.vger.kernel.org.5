Return-Path: <linux-kernel+bounces-113736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C9D888653
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0D1C28C6A7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFB912AAFE;
	Sun, 24 Mar 2024 22:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mvd1mos8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B311DEA0C;
	Sun, 24 Mar 2024 22:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320740; cv=none; b=R1Wt2KsNZyyItuXvJWxxEW8P15WaK8zjXyEWn+hW4UVeFcBU2HY5zhdXFTAqzczLcsLwM0Xt1t/nXNgU9s+L8MQjfgSkVmcAdx8TIJKYwQRzQhaAwTz2vd5k8tXHLlyLuk9+4zNRPpgc11gbmz5C6MUVB1LNAbjCqiZLMVCTCXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320740; c=relaxed/simple;
	bh=TQXYspbfT+moCuXb5jEZWh2Vb5Vn0eF+7P6IyRXaoAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIkiV0Bphvb8GWW5EpbwSggiahXqXyyQHmy5xYW1kdunwq55qHZ93CpGfmYvYkVQmxFZwhMqN5RCPHgmj9qp/CAy9lgMKjXV4EF1MzV0+xwEUeiuKn/XzaXuoIUhWRhaVGqCkvxZCaIShZkpnLXgDOfwWNxYukfLhjh9Z4xHw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mvd1mos8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61903C433C7;
	Sun, 24 Mar 2024 22:52:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320739;
	bh=TQXYspbfT+moCuXb5jEZWh2Vb5Vn0eF+7P6IyRXaoAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvd1mos88x1TDU8EPJpxeN19C5Cgy7S9h6MFGJlSIFidM9Y+WrK26NF9GfA/ByDqO
	 8kmPxTP/7RE0duMHerrKycCKRvLw64mB6FaJp5ZZGWeN+7Q2Zfs57jwSz+U8GVtAUa
	 9wkrAFOUtiAcbsjF9iYvwj8SQ25A1T5XMfMwRpBxR+aJI9wqcNpOsbLkSdjRsViV9E
	 JybMMlX2mIle3F6Y3Yg7xjOL/anFnRnGH+ZijHig2dc2uVMKEjnhhsLJoqv+dQz31V
	 lvEAyKx7FHE4v2b4cb5kMJ1Mat9sm8FcU8CiD7uKLOyPjkH96ZDKoGQlOJgBkwV/9T
	 2+0hiMdz2qQOA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	kernel test robot <lkp@intel.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 302/713] wifi: mt76: mt7921: fix incorrect type conversion for CLC command
Date: Sun, 24 Mar 2024 18:40:28 -0400
Message-ID: <20240324224720.1345309-303-sashal@kernel.org>
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
index 399d7ca6bebcb..18056045d9759 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -1270,7 +1270,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 		.acpi_conf = mt792x_acpi_get_flags(&dev->phy),
 	};
 	int ret, valid_cnt = 0;
-	u16 buf_len = 0;
+	u32 buf_len = 0;
 	u8 *pos;
 
 	if (!clc)
@@ -1281,7 +1281,7 @@ int __mt7921_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
 	if (mt76_find_power_limits_node(&dev->mt76))
 		req.cap |= CLC_CAP_DTS_EN;
 
-	buf_len = le16_to_cpu(clc->len) - sizeof(*clc);
+	buf_len = le32_to_cpu(clc->len) - sizeof(*clc);
 	pos = clc->data;
 	while (buf_len > 16) {
 		struct mt7921_clc_rule *rule = (struct mt7921_clc_rule *)pos;
-- 
2.43.0


