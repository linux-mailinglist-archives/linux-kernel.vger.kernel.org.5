Return-Path: <linux-kernel+bounces-115491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284DB889BE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:05:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB6A61F358C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0822308A0;
	Mon, 25 Mar 2024 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AxUnvCpx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174B1DD2C9;
	Sun, 24 Mar 2024 22:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320728; cv=none; b=MpJ2GuoD7iFCPMlsTZyqKgRxYshXiLr//vwSsACtAuCC1PjSCnsLt+ISxQMpbY+DPxv3gYnuaL2IiC6nHpp9bN4Pnke6jOUXqKxzvDONf02tmaHX1O7Ly6tgI330l5dtqRr70o3YwNSJNTPogOHwWRMjP751dxrsLFuiBQxCO0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320728; c=relaxed/simple;
	bh=CP1TSSKoiKiCEQKLsdxI576zDse1KHJj9eW0u99lzW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3pOhi3czuXZz7WgKsSDQ8yyv0BpYUG6jljWREsx6V2RU5P0jh20CoYnDlNP8b/4onWyvgflV5Y0kb6NXx0eC0iCsA2xUwiSFxqBOeTHET5kBp3ZJZCDpclEigxxfY5zdHfYDYQsQazxXS26THGBYak/9nHyx3d/7wYyfb5zM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AxUnvCpx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FCC2C433F1;
	Sun, 24 Mar 2024 22:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320727;
	bh=CP1TSSKoiKiCEQKLsdxI576zDse1KHJj9eW0u99lzW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AxUnvCpxXv7OvKgEXVRCmHRSAf9dMjFYOj1/8QYArmP8QR/04EP7kfswH4II/IpxU
	 +O/CofX3JUF5mQPTf21l2N9im9fmHP9Yh/xFBeVIYwaaza7IUgmRdvouBgz1/LqqQH
	 8UU2uqDTIuNzLV9Ke4x3356+ZUJ3YCLIRC2eVUbFD/+zBZ5gOG9+R6RHy5V9Tk1M5x
	 so5xKJ+gGyY8qh2uLK5ajoVZziRnrHjxBV6r6eLvQxUS8V0y48qf1+wJJMBAnTI/3R
	 28f7T+YY0PoFTFJdiXgFBUhKwHSEwAOj1GRfdfTNXSRAyAMC1wJTPTOWliSokhe/eO
	 +DBOi+L2W3bIA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Quan Zhou <quan.zhou@mediatek.com>,
	Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 290/713] wifi: mt76: mt7925: add flow to avoid chip bt function fail
Date: Sun, 24 Mar 2024 18:40:16 -0400
Message-ID: <20240324224720.1345309-291-sashal@kernel.org>
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
index 08ef75e24e1cf..c16d683e4891e 100644
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


