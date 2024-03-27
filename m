Return-Path: <linux-kernel+bounces-120336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E719488D5F6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 06:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 248841C23ECC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 05:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0CF1B94F;
	Wed, 27 Mar 2024 05:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Z0LipRbe"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF60134A5;
	Wed, 27 Mar 2024 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711518174; cv=none; b=MqTQZch4Pz9Y1ml3rdJ9pJrIDYSh4zQkFTGQ1/uxhSiDeWT0GvfSahseX0s0B2nt0tR1yrVSovRuPX+7JhapTX6zeJnj0axNFlA7/3QqpMIE+dylOZ/BzCze6SVPeWAaynzwg3kQJmW+kIn5iaH5rXUhPjQ+6pE2r2JVA/LKEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711518174; c=relaxed/simple;
	bh=gT9JMuRKI4jdYdmjO6l0bHa8hzlKAHE36LSilQNd0+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sh7N8JS4uI5MOvlPWdKGcjHI/s2z3lJJDeWHeOTbj2NCpjEzpXD0Y5FPY/OjY5l1col77qgHfDYWZTML8s+cYv//MD67cbysIUCx0TyW50oFN+m5cPAkzADPT7d1m9oPd8dt2AiMXpvhioMvaK0CT2h5W3RHz4SvGBwjfW8TjQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Z0LipRbe; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42R5gePk100705;
	Wed, 27 Mar 2024 00:42:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1711518160;
	bh=SXnJ/nkGq8MQYcYDTq+gWGEJI4HADRdErVvMi57hR1I=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=Z0LipRbe5T1/SMI6BuPT3e8pgGXiyRlE1WaHsmz7hxny5GVafYQTSrDfsebiIsOdR
	 BeVLP8d61XCfg1kZRR9XxbQvFlzdyy7Jc5C+uoHWPJNb40aB2TuRUPN8NsPxlG60/h
	 NSZrAwRlnZkEqE47UFtTuTOsGBxs9woYvuEGKeOg=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42R5geoK002234
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 27 Mar 2024 00:42:40 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 27
 Mar 2024 00:42:39 -0500
Received: from fllvsmtp8.itg.ti.com (10.64.41.158) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 27 Mar 2024 00:42:39 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by fllvsmtp8.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42R5gc1N018526;
	Wed, 27 Mar 2024 00:42:39 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Chintan Vankar <c-vankar@ti.com>, Andrew Lunn <andrew@lunn.ch>,
        Roger Quadros
	<rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni
	<pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet
	<edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v4 3/3] net: ethernet: ti: am65-cpsw-ethtool: Update rx_filters for CPSW's timestamping capability
Date: Wed, 27 Mar 2024 11:12:34 +0530
Message-ID: <20240327054234.1906957-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240327054234.1906957-1-c-vankar@ti.com>
References: <20240327054234.1906957-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update supported hwtstamp_rx_filters values for CPSW's timestamping
capability.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Changes from v3 to v4:
- No changes in v4.

Link to v3:
https://lore.kernel.org/r/20240320102600.3418248-3-c-vankar@ti.com/

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index d6ce2c9f0a8d..a1d0935d1ebe 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -695,6 +695,17 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 					 struct ethtool_ts_info *info)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	unsigned int ptp_v2_filter;
+
+	ptp_v2_filter = BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
+			BIT(HWTSTAMP_FILTER_PTP_V2_EVENT)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_SYNC)	 |
+			BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
 
 	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
 		return ethtool_op_get_ts_info(ndev, info);
@@ -708,7 +719,7 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = am65_cpts_phc_index(common->cpts);
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
-	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | BIT(HWTSTAMP_FILTER_ALL);
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | ptp_v2_filter;
 	return 0;
 }
 
-- 
2.34.1


