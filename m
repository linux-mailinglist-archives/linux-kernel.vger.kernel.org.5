Return-Path: <linux-kernel+bounces-115431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A74D889B84
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:55:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEFD21F2789D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F134620F24F;
	Mon, 25 Mar 2024 02:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnLBPfpG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA8B1DE9E8;
	Sun, 24 Mar 2024 22:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320738; cv=none; b=tPZDCBfxCOCFUN+PSDBf24+iaqOpifvNcYnnqw1gLDGQLuDnyzeS+0Luu7qj6onu2QBiJy25dod4vtg09/UDfpD1RQcLJF/u6ARVkAsT6yCMyCfdVpGi2idBHYt77FXMMXOYNyc6uFfSoKWHiy+oDKppzT04YCVSdtAvUW0nUUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320738; c=relaxed/simple;
	bh=GWhucM3UOWCf+Jn0EA1zuh0UWwbQen1v+fnZzq9n2WQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6zjRb+d4H9zsUTJ87VPWIjgfnoiHCaojL6j51lzJRi/WbbX6bMNTEDFvWj4heU8Z+GnNC4cb7p3Vk22c8hfqnvyivUDi9RwHUXC2Qv6py1zGRmK4TFh8GUUTSS67yeLPakVXrGVewfr6Cu57jzMPDIFaLYDqoy67KaBeKve4KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnLBPfpG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773CFC43390;
	Sun, 24 Mar 2024 22:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320738;
	bh=GWhucM3UOWCf+Jn0EA1zuh0UWwbQen1v+fnZzq9n2WQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nnLBPfpGlPrMQKk7XWpGZJ0QMKJwQeoaBhHAiBq9HTWn0yOrZKm1PBJZL5faJiLjo
	 qqkSNYatNzAzNVp7dku2Ajkld6XVrf99BG0rmzrGAEUA/3yLes2UTekndLHpS8Cgjc
	 VPUI5lQCS4PcJ6T9PvO4rZl+GDnAo9iIKEdPnxZDvbJu0YAMJsMafJTgW7UP152Wye
	 Xw5NGbhwQHge2HSua19Py5tIY4WMf4eRi3Fpq4rNsTPmPEGVk+Uxlc7aiBxm+Kh80m
	 DhBt36WE5snhJTlI7+7/29z3wtWn5n/QZ5PT4UTIggdNoYpnF+q4eLu9NMMEh+SnQt
	 rcR/WmsectB4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 301/713] wifi: mt76: mt7925e: fix use-after-free in free_irq()
Date: Sun, 24 Mar 2024 18:40:27 -0400
Message-ID: <20240324224720.1345309-302-sashal@kernel.org>
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

From: Deren Wu <deren.wu@mediatek.com>

[ Upstream commit a5a5f4413d91f395cb2d89829d376d7393ad48b9 ]

From commit a304e1b82808 ("[PATCH] Debug shared irqs"), there is a test
to make sure the shared irq handler should be able to handle the unexpected
event after deregistration. For this case, let's apply MT76_REMOVED flag to
indicate the device was removed and do not run into the resource access
anymore.

Fixes: c948b5da6bbe ("wifi: mt76: mt7925: add Mediatek Wi-Fi7 driver for mt7925 chips")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7925/pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c16d683e4891e..bf02a15067ef6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -427,6 +427,7 @@ static void mt7925_pci_remove(struct pci_dev *pdev)
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 
 	mt7925e_unregister_device(dev);
+	set_bit(MT76_REMOVED, &mdev->phy.state);
 	devm_free_irq(&pdev->dev, pdev->irq, dev);
 	mt76_free_device(&dev->mt76);
 	pci_free_irq_vectors(pdev);
-- 
2.43.0


