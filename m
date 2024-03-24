Return-Path: <linux-kernel+bounces-113960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9361288879A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F55E28848E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EEE21C19D;
	Sun, 24 Mar 2024 23:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j5EiQQ8G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2FF1F10B0;
	Sun, 24 Mar 2024 22:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321071; cv=none; b=h4GnwaNA7/rg/xvfdEONfj96K0EYPtWXol50RFTCe46CoTyXQXQPLy/hMay37nkdce3IwtiVMDm73+0LqQeGvnQRvrE9ey4FIJp3FYlzNdtumhi635s6FAbrZs6jWV8516vodSfuvyu5ZdtKcnJej/f8HJFB0vGgt7j9bQwz5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321071; c=relaxed/simple;
	bh=auK8R9Pko+8qzyQY9/nghXInMkBIXsa2OBgChzHHXdM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDv6WC81eXP1CXxcimpTNkIaU/+oUNYeet83blq7r0o+dP01JPf4EcuMxGEkROPjwMw5nOjIzSaSWrWGzU2g//9aUuRr3dM6OtWIqdeK80GxnECxH+ywvf3XPJarFXcJif7bK9+sN4WJLZp073+jzx297zlIh7csgjlcuQEQtGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5EiQQ8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F080C433C7;
	Sun, 24 Mar 2024 22:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321070;
	bh=auK8R9Pko+8qzyQY9/nghXInMkBIXsa2OBgChzHHXdM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j5EiQQ8GwKbok3hH+PEt6h+naJ9md59vvthaC7XO2XP39UqMQgN47xe56GLgNX0V5
	 fByjIV2hTpBZOYlrNmf52Cn6Q1ZTo6eSTtax4zIGPUPhREwUIWFERALn4G/V5OlzPR
	 M8Dn6P7PoyOit0wUkZpXxGldfyxBOTN0NJnZciIv5jUZlQynyl3GfU8ELdBV443ZBL
	 0J40AKmYdjTBbv9cYmuzef2g91Q9035YFBHbUm7oq8G5bOrdPhIzdjsiVgA8zbPWAN
	 mk1+yZoBMKOjjLG63FN+NTXsG64TdIeyq3x8XMlk1UIYq5tBsJz4KGW6wYHKS62ddr
	 bbvUO0FC35uKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Eddie Huang <eddie.huang@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-rtc@vger.kernel.org,
	Marc Zyngier <maz@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Peter Rosin <peda@axentia.se>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 633/713] rtc: mt6397: select IRQ_DOMAIN instead of depending on it
Date: Sun, 24 Mar 2024 18:45:59 -0400
Message-ID: <20240324224720.1345309-634-sashal@kernel.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 544c42f798e1651dcb04fb0395219bf0f1c2607e ]

IRQ_DOMAIN is a hidden (not user visible) symbol. Users cannot set
it directly thru "make *config", so drivers should select it instead
of depending on it if they need it.
Relying on it being set for a dependency is risky.

Consistently using "select" or "depends on" can also help reduce
Kconfig circular dependency issues.

Therefore, change the use of "depends on" for IRQ_DOMAIN to
"select" for RTC_DRV_MT6397.

Fixes: 04d3ba70a3c9 ("rtc: mt6397: add IRQ domain dependency")
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Eddie Huang <eddie.huang@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org
Cc: Alessandro Zummo <a.zummo@towertech.it>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-rtc@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Peter Rosin <peda@axentia.se>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240213050258.6167-1-rdunlap@infradead.org
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
index 3814e0845e772..b1e1d277d4593 100644
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1832,7 +1832,8 @@ config RTC_DRV_MT2712
 
 config RTC_DRV_MT6397
 	tristate "MediaTek PMIC based RTC"
-	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
+	depends on MFD_MT6397 || COMPILE_TEST
+	select IRQ_DOMAIN
 	help
 	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select
-- 
2.43.0


