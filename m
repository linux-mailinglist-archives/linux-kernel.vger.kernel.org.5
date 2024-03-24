Return-Path: <linux-kernel+bounces-113139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DC98881C4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:29:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 033A21C21EAA
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748D16FF5D;
	Sun, 24 Mar 2024 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux/1ZNf/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B313C3ED;
	Sun, 24 Mar 2024 22:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319946; cv=none; b=SwnJZ6kMIcGixawWWAEwgnJoCgVA1Rl/BsKh6qeUOOG85eqhfcOu1T1JEE4dE4WWqAeJ2WXTkrhICHudjwJ8RFEn6Gdjpk7ylJXGHA1toY1a+QBfyMmuRN1nHr28e46unCO8IGE3INHGUnB9RULvR4mxhXl+NZV4Hokfe20JN8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319946; c=relaxed/simple;
	bh=Q4+ByOQI6AC/hRIgafFeNoLkyAsC2er0jPK3iWRch10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DV5JKPx4unxtOgwSBuzhRS8V3o1AkX3tjWs126rLFfsehKe0ID2HEX5erdXfgMm/WAwIxY255/4YO21wYkJVui3YZqgZyb0t54MpVofK5fmhSyO7uua/q1JkHPyVz6qoWKsXc44s053ezmIZM45DQWfEM4sl2xEtmmlgF9NmEvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=fail (0-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux/1ZNf/ reason="key not found in DNS"; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3B1BC433B1;
	Sun, 24 Mar 2024 22:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319946;
	bh=Q4+ByOQI6AC/hRIgafFeNoLkyAsC2er0jPK3iWRch10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ux/1ZNf/bgR6ROWRWO9mviR+2OFYvVB0fJ0Bsq/YjWfnqU3r3w3Rwpk3AfDvzE+EN
	 0s/x2EqQOCofqQzi+50V9L6Ja+vxXu3/i+mvIIXC5e1Tv122kkOC2MoN3kKTLk87Sn
	 qE3RcloRljtKC1Codb64t46KZevrXmYeWpPuIgXCtileP5IAuEzSFSWZ9tbYU7MsMF
	 nhQ9dcFJt0r1fsRjISLnwHm3midh35+QOCJZadx5EizOkvryJViI8Vy2Ab32QoWZrc
	 RRQyV2BaiRDONq9O8pKCOT8Si4sfiLBKiz4ytpWa2qtVXpF9ScwyIOxCoQedUYPVKa
	 QI6kbdeCjPamA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Deren Wu <deren.wu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 252/715] wifi: mt76: mt7925e: fix use-after-free in free_irq()
Date: Sun, 24 Mar 2024 18:27:11 -0400
Message-ID: <20240324223455.1342824-253-sashal@kernel.org>
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
index 74cfba7675beb..07b74d492ce15 100644
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


