Return-Path: <linux-kernel+bounces-108773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D19880FCA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F75728520A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556D75472A;
	Wed, 20 Mar 2024 10:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eFfApwmk"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F723C6BA;
	Wed, 20 Mar 2024 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710930393; cv=none; b=c0adCvGUZkFhpHEr/yqBG/zuoLAOMlvdtgwApr8F65xs/3RXXvC1K3ahPTa5kuzFkBWDEYUjTaL7UJex2mH0EvaetXWLkGxht42Gvk/BI76fYLzg85AfOht6Jmw896wmhzUI3zr3/CX6jOMZv5IYQ2+SfLQ7+4NVrI+aFjv4w/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710930393; c=relaxed/simple;
	bh=1nf02/vEkZYbkFN5gKLcw5ZVzmyCxjl1ABPBLG8C7iM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z+HwZQp07IYwT5zSQssiVZ9R66Tma/wj00f6tHdSerbW+sqWspbhWgd0UuvsIigtAgBMmC/O4jidZGcQ5lzvHqoXZ1jkrvNjnVxltOY335BaLLb5LdxW1Czd1PzJsPwn6fIds+kEXtEPWCRfyNSAhO1a8n2HilpgLQDMUqJd1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=eFfApwmk; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42KAQ7US106856;
	Wed, 20 Mar 2024 05:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710930367;
	bh=UUZdi4/sY1MJsyLXe3Xa+C2fU9LjVvRBmi6+IClBhM4=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=eFfApwmkOzBzwHzhxzghLK3wJedAVSsKCjiHkRGK6f8HgIAgjctSHgQ8tXygxT4XW
	 LVU4RLD9acIY6CC+7PdmiV9GooElBc7Ikz4e3fjdzk19FI9yG78KE4zk4Vu1W3T9OR
	 5NiuDWbfCprNz1BPvbxElzXsG6ttHNgoXzya6zqI=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42KAQ7bQ081668
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 20 Mar 2024 05:26:07 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 20
 Mar 2024 05:26:07 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 20 Mar 2024 05:26:07 -0500
Received: from localhost (chintan-thinkstation-p360-tower.dhcp.ti.com [172.24.227.220])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42KAQ6Sj074866;
	Wed, 20 Mar 2024 05:26:06 -0500
From: Chintan Vankar <c-vankar@ti.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        Siddharth Vadapalli
	<s-vadapalli@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Heiner
 Kallweit" <hkallweit1@gmail.com>,
        Chintan Vankar <c-vankar@ti.com>,
        "Vladimir
 Oltean" <vladimir.oltean@nxp.com>,
        Andrew Lunn <andrew@lunn.ch>, Roger
 Quadros <rogerq@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
        Eric
 Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: [PATCH net-next v3 3/3] net: ethernet: ti: am65-cpsw-ethtool: Update rx_filters for CPSW's timestamping capability
Date: Wed, 20 Mar 2024 15:56:00 +0530
Message-ID: <20240320102600.3418248-3-c-vankar@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240320102600.3418248-1-c-vankar@ti.com>
References: <20240320102600.3418248-1-c-vankar@ti.com>
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

Changes from v2 to v3:
- No changes from v2 to v3.

Link to v2:
https://lore.kernel.org/r/20240312100233.941763-3-c-vankar@ti.com/

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


