Return-Path: <linux-kernel+bounces-3079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CDB816705
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C82B11C222F4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D728679F4;
	Mon, 18 Dec 2023 07:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pueusg+U"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31AD479CB;
	Mon, 18 Dec 2023 07:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702883211; x=1734419211;
  h=from:to:cc:subject:date:message-id;
  bh=RiZsRpMsjJgcAKI9/RPFJRFk2jM24l/0sJABnqjwbyw=;
  b=Pueusg+U63zpiAN25hVa9I1SZIRZJZhZpwUkaPdy04GoOUujcz1yTerg
   O8gk35j/jXcOU+iOG5JMyuK36AOwOgZdKk2fTk1ezEDqf1EX9SLQROdJ5
   vuqtCpsQi/UuqgZvrQBUO2e7rpAdN/A6kZ74jDcUQV70TmJfqUZfJYyad
   z1hcD1PTnO3uQbenmuQV3ID+am0PihjMJQISFADyrWCyKuyw7mjlWzh3z
   uB3OJHphQdiVbqIgp6KWj9yDE6EJerbwaQeFh8jbdx3L/oFQBYqLRpxy2
   tmuL8fFkL19fbvJZtqs8otZrBGqv3lIHue+gbo6W/5s9QIXYt4+/f2nI2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="2555118"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="2555118"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:06:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="845843049"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="845843049"
Received: from ssid-ilbpg3.png.intel.com ([10.88.227.111])
  by fmsmga004.fm.intel.com with ESMTP; 17 Dec 2023 23:06:45 -0800
From: Lai Peter Jun Ann <jun.ann.lai@intel.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Song Yoong Siang <yoong.siang.song@intel.com>,
	Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net 1/1] net: stmmac: fix incorrect flag check in timestamp interrupt
Date: Mon, 18 Dec 2023 15:06:41 +0800
Message-Id: <1702883201-29632-1-git-send-email-jun.ann.lai@intel.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The driver should continue get the timestamp if STMMAC_FLAG_EXT_SNAPSHOT_EN
flag is set.

Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
index 540f6a4..f05bd75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c
@@ -237,7 +237,7 @@ static void timestamp_interrupt(struct stmmac_priv *priv)
 	 */
 	ts_status = readl(priv->ioaddr + GMAC_TIMESTAMP_STATUS);
 
-	if (priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN)
+	if (!(priv->plat->flags & STMMAC_FLAG_EXT_SNAPSHOT_EN))
 		return;
 
 	num_snapshot = (ts_status & GMAC_TIMESTAMP_ATSNS_MASK) >>
-- 
1.9.1


