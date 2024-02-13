Return-Path: <linux-kernel+bounces-62936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6537852819
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 06:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B37284B7C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 05:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59A8E11725;
	Tue, 13 Feb 2024 05:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="y2UuGXq7"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5630911711;
	Tue, 13 Feb 2024 05:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707800588; cv=none; b=u/+goJl4PDu2pQMLM8jJPFtghNqnw/COOTZPLfPlGgscty+i7LsXs+FtnbmehiVLh1qeDXIx0ZQwNrTw/S+hNXgyI52mx73ulH4Jt762/q7LXt6jdTFV9G7o3X5FKqQx6VqepAt98n8JfnccbUzwbFQiHwwYJdJcWNFdWBixTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707800588; c=relaxed/simple;
	bh=7gBurt55rmqnev0iYzt5sjeYAJF23VKQewkN/k7zrfk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pYxwYU1u2Ogcv2SkFvAgWs0iDZqPiKTwypT74a1YIMseVK63dlR5ib/u0FpFQWlJQXZYeGycQfDPM9yaNTWlUSp20vT6fxK/sOJ81h72uoDT17AYTM49gXHOzIF7M2mjO26aaVr7dcww5AY5IyOA4loqlkUA6ErMF/+Khwfi4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=y2UuGXq7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=TtWttyee/5Vn7DkruIaUNFtX0dg5UyJYT71WtS68lvQ=; b=y2UuGXq7TVGkgDfbVqKyK6qZI0
	SzB9u73KS37xUZQNvk05H+/v1P90LfvWrA7Bf8fA1OncBax31UlMvFXTdeDTTpawE5ESXJh39j8gU
	QUow+QElY8Esw1Gb+l8UdNgLZW9l99ptUgQrk/JXPapsg/oSZljj+986pnmdUnDcjRSXcfLlTiPvL
	CT6AzLnpWX9DOBO+0aMoN2nfR+nxCtejpQhJtTI+aUHUT8HMH9hAY9b/gnRcLDLXHewA1t5XacgX7
	0t/QcHfUCnss3DoKpuNvXeMoHN4G5280CoJU6+nf05lEzPtMQWWLvBGNhQP/tknH28T/cippxKxwK
	YozeUPFA==;
Received: from [50.53.50.0] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rZkwg-00000007xyA-0pHe;
	Tue, 13 Feb 2024 05:03:02 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
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
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2] rtc: mt6397: select IRQ_DOMAIN instead of depending on it
Date: Mon, 12 Feb 2024 21:02:58 -0800
Message-ID: <20240213050258.6167-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
---
v2: add Rev-by: from AngeloGioacchino

 drivers/rtc/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff -- a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
--- a/drivers/rtc/Kconfig
+++ b/drivers/rtc/Kconfig
@@ -1858,7 +1858,8 @@ config RTC_DRV_MT2712
 
 config RTC_DRV_MT6397
 	tristate "MediaTek PMIC based RTC"
-	depends on MFD_MT6397 || (COMPILE_TEST && IRQ_DOMAIN)
+	depends on MFD_MT6397 || COMPILE_TEST
+	select IRQ_DOMAIN
 	help
 	  This selects the MediaTek(R) RTC driver. RTC is part of MediaTek
 	  MT6397 PMIC. You should enable MT6397 PMIC MFD before select

