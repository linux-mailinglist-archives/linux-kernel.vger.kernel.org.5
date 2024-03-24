Return-Path: <linux-kernel+bounces-113128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3038E8881AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7BEE1F20F9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:27:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CE015E5C1;
	Sun, 24 Mar 2024 22:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltpGnGpr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8147E15E5A4;
	Sun, 24 Mar 2024 22:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319935; cv=none; b=NQZVSs1gV2fVJ6xRqXaw344xFcstnVK4vIYKbjEpN9XfHDTSbYVOGEC72GIbr7c4/1LqICfEK7cFk9L9miqiu/vzMdNZSrWxNkJ321nIEshvoWD6yArXiNIc1TtyrGB4TjaHXvBCckvQzzyIAqKx+1po3cpHEDaO2dkGc1CF+HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319935; c=relaxed/simple;
	bh=1hQ0IocJrYAHyKor1VYE7+Z3UQNw34mx7Cz6RERCIpE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hZJM0W9u72XDlEQfDoHc1Blr18k8S8DHOwz/162bWIfRyjuDhnzzQGZB6D2tkT8U/z3YSCvYSDoZn7VpzdRCX3d5xBDDNfCE3a86VWwCJ/YrnJs3GR8+b0iaxZ2X8vVbhIIpnqHooSsM/PRvqOwMObaHzIXhbODtOtex8EB93C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltpGnGpr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F3CC433C7;
	Sun, 24 Mar 2024 22:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319935;
	bh=1hQ0IocJrYAHyKor1VYE7+Z3UQNw34mx7Cz6RERCIpE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ltpGnGpre26xCVxp6S16DbH2GHeQynTLCArcCuBBZ+UZ1Y22T6/QXqztyh0f0GiZK
	 1tOwGDX767zLjoeblA3aTevOWj5WW2J3FyeUs3i85UJbIJsPxXhPNK8kiihomRdNSs
	 8hYT4r0yX34Awrse1H6PcYlPSBdwjD0JB/wN4eXr5KTc9Q4AFfeyF6qy4p3LxoD3Zw
	 DXAAQBb4Dh0AgQlnrMQHbX6QPZJquwexXAO6t1Wg0sYofz0dqUXlDjkT/R2uhb1VJV
	 fMObFXXeQCAZRPT145j0LgBEQqzflGw6IMlWe4/12sgYmWe3I9pWVGaxuTptVUKUlx
	 7ShmG+qgOTV6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Zhou <quan.zhou@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 241/715] wifi: mt76: mt7925: add flow to avoid chip bt function fail
Date: Sun, 24 Mar 2024 18:27:00 -0400
Message-ID: <20240324223455.1342824-242-sashal@kernel.org>
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

From: Quan Zhou <quan.zhou@mediatek.com>

[ Upstream commit 9300ae0cd9e8f2407b20e0e67ee3ea03dc8b06af ]

A sub-process of Wifi L0.5 reset will make chip common partition
enter low power, and have chance lead to Bluetooth host-to-chip
command timeout, modify the software flow according to the chip's
design to solve the problem.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c  | 2 ++
 drivers/net/wireless/mediatek/mt76/mt792x_regs.h | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 1fd99a8565415..74cfba7675beb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -386,6 +386,8 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	mt76_rmw_field(dev, MT_HW_EMI_CTL, MT_HW_EMI_CTL_SLPPROT_EN, 1);
+
 	ret = mt792x_wfsys_reset(dev);
 	if (ret)
 		goto err_free_dev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
index a99af23e4b564..d7f9b24cd665f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x_regs.h
@@ -389,6 +389,9 @@
 #define MT_HW_CHIPID			0x70010200
 #define MT_HW_REV			0x70010204
 
+#define MT_HW_EMI_CTL			0x18011100
+#define MT_HW_EMI_CTL_SLPPROT_EN	BIT(1)
+
 #define MT_PCIE_MAC_BASE		0x10000
 #define MT_PCIE_MAC(ofs)		(MT_PCIE_MAC_BASE + (ofs))
 #define MT_PCIE_MAC_INT_ENABLE		MT_PCIE_MAC(0x188)
-- 
2.43.0


