Return-Path: <linux-kernel+bounces-100087-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F54F8791A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 154C3B22245
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C1AD7829E;
	Tue, 12 Mar 2024 10:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FM7kufMR"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E4233994;
	Tue, 12 Mar 2024 10:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237785; cv=none; b=PUFn1D1Y77N2KdL/oT0D31yDPU2PhCQSsYwTfQ/VKch5j/KaWMraD5U/w7KI41EojVWlZ83V+Yk8P6Q8pItZ8KhNfLQzJuOWUvQ4fbq7cq+YCxFgoBM8sErqOSn6L2U1QpiSYeAT6bpFHP54NvPZNYYB+cH4/YBpV2ws9wdubmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237785; c=relaxed/simple;
	bh=DskpTvr5tqLs+ZTEGN+HyiY1/Zyt8F2f0qn3bJEqEZg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gtQWOYHlMCuvMgAmewyC0haZs6eU09uybxCyMoz64WU2OSipVxbuhPpRs5AXn1z868/olRSGeWOe36kz0jLwDk4M/9rj2Hgw6oz60jyXFpBTdY3kptU1M2KNj+ZEyNtQLTEm9Jj8S7sTCzrMeu4EkzgUesW3TGLmQjClUDp7d84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FM7kufMR; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42CA2dAV114245;
	Tue, 12 Mar 2024 05:02:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710237759;
	bh=/xqGfD1xDzdX3pXWJ+m04kLd2BeOZdfT2Cv3ra7gfAA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=FM7kufMRnl+wuMybaEVJcnY5KMpByddtgtDJ3+F3puyPe8Nt1tsbUtn+Vu2MBeKjM
	 s7WdNQzP9al3R+GF+EwE/tctVn2XHK7cjBHZ+FrnE77xFowUsS8EWK6HZPyWXJaht1
	 z8Z8OvUCzxyZAWZfQ9FyXs+QdbvPxKRd1qXElRZ8=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42CA2d8C003925
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 12 Mar 2024 05:02:39 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 12
 Mar 2024 05:02:39 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 12 Mar 2024 05:02:39 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42CA2cDO087381;
	Tue, 12 Mar 2024 05:02:39 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Chintan Vankar
	<c-vankar@ti.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Grygorii
 Strashko" <grygorii.strashko@ti.com>,
        Andrew Lunn <andrew@lunn.ch>, "Roger
 Quadros" <rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        "Eric
 Dumazet" <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH v2 3/3] net: ethernet: ti: am65-cpsw-ethtool: Update rx_filters for device's timestamping
Date: Tue, 12 Mar 2024 15:32:33 +0530
Message-ID: <20240312100233.941763-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240312100233.941763-1-c-vankar@ti.com>
References: <20240312100233.941763-1-c-vankar@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Update supported hwtstamp_rx_filters values for device's
timestamping.

Signed-off-by: Chintan Vankar <c-vankar@ti.com>
---

Changes from v1 to v2:
- This patch is newly added in v2.

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


