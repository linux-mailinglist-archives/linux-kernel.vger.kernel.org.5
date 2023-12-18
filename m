Return-Path: <linux-kernel+bounces-3128-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC4D8167BD
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 08:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B74BFB2077E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96323101C9;
	Mon, 18 Dec 2023 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WsTNjODa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6AF9C6;
	Mon, 18 Dec 2023 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702885901; x=1734421901;
  h=from:to:cc:subject:date:message-id;
  bh=BdJBRBUvWJhAlj87MALaZbhkeiFmNqv5A5ngqArXaRY=;
  b=WsTNjODaGmX0mAcgG/EuUt4qMo6cDg0+Y4juvd0lUFPQxTw4GGAznH5O
   jNDCqFmqK/dtspyUWhZ85wGB+Ox9ccY8ljB6y8q8eQmBfCbryXZHXMXUg
   c378WxSHymFUFxnBzw25AELh/h9EL3BsopE6xELDg9/rCzNA1X8FzEs2F
   xTKPk4Og0BPFjlJ0pDLcHtdPFUM+4eFG3GGpQkVoXVmR8J5H0DpTO//wA
   Xu3hKpbXBRNCt6wdhmg9eU/Y+VyUxGXrq5n55mx1+OD8mldDUTInGIUmu
   gBWZ43xVAXPGf0zR6pOG9o2z55t49GZxCURi9fCdyRyktI5X9Onz8BQ/G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="461921482"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="461921482"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2023 23:51:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10927"; a="778999082"
X-IronPort-AV: E=Sophos;i="6.04,284,1695711600"; 
   d="scan'208";a="778999082"
Received: from ssid-ilbpg3.png.intel.com ([10.88.227.111])
  by fmsmga007.fm.intel.com with ESMTP; 17 Dec 2023 23:51:36 -0800
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
Subject: [PATCH net v2 1/1] net: stmmac: fix incorrect flag check in timestamp interrupt
Date: Mon, 18 Dec 2023 15:51:32 +0800
Message-Id: <1702885892-30369-1-git-send-email-jun.ann.lai@intel.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The driver should continue get the timestamp if STMMAC_FLAG_EXT_SNAPSHOT_EN
flag is set.

Fixes: aa5513f5d95f ("net: stmmac: replace the ext_snapshot_en field with a flag")
Cc: <stable@vger.kernel.org> # 6.6
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
---
v2 changelog:
 - Add fix tag and stable@vger.kernel.org in email cc list.
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


