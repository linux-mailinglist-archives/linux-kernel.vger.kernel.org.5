Return-Path: <linux-kernel+bounces-124580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F823891A33
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:55:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6001F29444
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E90E156978;
	Fri, 29 Mar 2024 12:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPCdzIR6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880BB13D242;
	Fri, 29 Mar 2024 12:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711715456; cv=none; b=mhS3jKuCeJQ79cm74kVN65HEiWOFFqmlieu/2Zn1cTpMisd8cJ+Vrrt7IoLtGzAweC/JSDqA7ckRxtUSPIN6jXKUPXqHjrg6tUuA+e6t5aCJcXizpJKF5bzr4+wdV5fw4RkUmN8i23VxusFnJ1gpWZW+no6dfMstRw0HGnH8xJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711715456; c=relaxed/simple;
	bh=lYOurb1ek4UEAheQSUK+tDAdSlQf/haXtxCE5vnI4fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ExWPEucuNu7alchsQ3N+GLq2WFHmcz4JsJWJzMOjsBOFZEUgyeZdtIdUSdYTMWvOfn3BMFYccNKW3zV/TtCltuSppF0RHJf2OZUKVR5UHYowQIbVN6ACsIxV6kZxavwX65GvebtyVIBcizJirC0UuL4AMO1OIOnyTOMAP4EfKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPCdzIR6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2369C433C7;
	Fri, 29 Mar 2024 12:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711715456;
	bh=lYOurb1ek4UEAheQSUK+tDAdSlQf/haXtxCE5vnI4fs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TPCdzIR6zyX338MvkxpvcRGVuCoHIwwV7zSK5PM92A7U7Q0ZDWP4JphO98GpsUue7
	 TumJJYvDzKhPaBZwNEOidBHIx8yE/DrlYCaGqA4X1K8MuN59i6LH7iszh6CNZv89fw
	 pi4Fe+2fB4b9MqlwUYNUq1RhUEkE10xwSD/z0xPEl0dxgYx5oCol2HolwpBhlyKwyb
	 aspxmIO9nfJcH0TT3UiFhMXSfuVEuNY54WXNLP4AusLZq3QCGwnLdVSyiXjKzYemn5
	 6FyD96gxOrBeVilmOSnFUNjoB/ws7a1NrU4dsDBPEtw07kUECIeNv3Y7G3TbiSOQtP
	 b/oluEKSkuxhQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shayne Chen <shayne.chen@mediatek.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	Felix Fietkau <nbd@nbd.name>,
	Sasha Levin <sashal@kernel.org>,
	lorenzo@kernel.org,
	ryder.lee@mediatek.com,
	kvalo@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	leitao@debian.org,
	lynxis@fe80.eu,
	sujuan.chen@mediatek.com,
	meichia.chiu@mediatek.com,
	linux-wireless@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 29/52] wifi: mt76: mt7915: add locking for accessing mapped registers
Date: Fri, 29 Mar 2024 08:28:59 -0400
Message-ID: <20240329122956.3083859-29-sashal@kernel.org>
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

From: Shayne Chen <shayne.chen@mediatek.com>

[ Upstream commit 0937f95ab07af6e663ae932d592f630d9eb591da ]

Sicne the mapping is global, mapped register access needs to be protected
against concurrent access, otherwise a race condition might cause the reads
or writes to go towards the wrong register

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7915/mmio.c  | 45 ++++++++++++++++---
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  1 +
 2 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
index f4ad7219f94f4..a306a42777d78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mmio.c
@@ -490,6 +490,11 @@ static u32 __mt7915_reg_addr(struct mt7915_dev *dev, u32 addr)
 		return dev->reg.map[i].maps + ofs;
 	}
 
+	return 0;
+}
+
+static u32 __mt7915_reg_remap_addr(struct mt7915_dev *dev, u32 addr)
+{
 	if ((addr >= MT_INFRA_BASE && addr < MT_WFSYS0_PHY_START) ||
 	    (addr >= MT_WFSYS0_PHY_START && addr < MT_WFSYS1_PHY_START) ||
 	    (addr >= MT_WFSYS1_PHY_START && addr <= MT_WFSYS1_PHY_END))
@@ -514,15 +519,30 @@ void mt7915_memcpy_fromio(struct mt7915_dev *dev, void *buf, u32 offset,
 {
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+	if (addr) {
+		memcpy_fromio(buf, dev->mt76.mmio.regs + addr, len);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	memcpy_fromio(buf, dev->mt76.mmio.regs +
+			   __mt7915_reg_remap_addr(dev, offset), len);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7915_rr(struct mt76_dev *mdev, u32 offset)
 {
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
-	u32 addr = __mt7915_reg_addr(dev, offset);
+	u32 addr = __mt7915_reg_addr(dev, offset), val;
 
-	return dev->bus_ops->rr(mdev, addr);
+	if (addr)
+		return dev->bus_ops->rr(mdev, addr);
+
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rr(mdev, __mt7915_reg_remap_addr(dev, offset));
+	spin_unlock_bh(&dev->reg_lock);
+
+	return val;
 }
 
 static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
@@ -530,7 +550,14 @@ static void mt7915_wr(struct mt76_dev *mdev, u32 offset, u32 val)
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	dev->bus_ops->wr(mdev, addr, val);
+	if (addr) {
+		dev->bus_ops->wr(mdev, addr, val);
+		return;
+	}
+
+	spin_lock_bh(&dev->reg_lock);
+	dev->bus_ops->wr(mdev, __mt7915_reg_remap_addr(dev, offset), val);
+	spin_unlock_bh(&dev->reg_lock);
 }
 
 static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
@@ -538,7 +565,14 @@ static u32 mt7915_rmw(struct mt76_dev *mdev, u32 offset, u32 mask, u32 val)
 	struct mt7915_dev *dev = container_of(mdev, struct mt7915_dev, mt76);
 	u32 addr = __mt7915_reg_addr(dev, offset);
 
-	return dev->bus_ops->rmw(mdev, addr, mask, val);
+	if (addr)
+		return dev->bus_ops->rmw(mdev, addr, mask, val);
+
+	spin_lock_bh(&dev->reg_lock);
+	val = dev->bus_ops->rmw(mdev, __mt7915_reg_remap_addr(dev, offset), mask, val);
+	spin_unlock_bh(&dev->reg_lock);
+
+	return val;
 }
 
 #ifdef CONFIG_NET_MEDIATEK_SOC_WED
@@ -813,6 +847,7 @@ static int mt7915_mmio_init(struct mt76_dev *mdev,
 
 	dev = container_of(mdev, struct mt7915_dev, mt76);
 	mt76_mmio_init(&dev->mt76, mem_base);
+	spin_lock_init(&dev->reg_lock);
 
 	switch (device_id) {
 	case 0x7915:
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 21984e9723709..e192211d4b23e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -287,6 +287,7 @@ struct mt7915_dev {
 
 	struct list_head sta_rc_list;
 	struct list_head twt_list;
+	spinlock_t reg_lock;
 
 	u32 hw_pattern;
 
-- 
2.43.0


