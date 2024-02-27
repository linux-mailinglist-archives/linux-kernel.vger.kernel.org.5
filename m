Return-Path: <linux-kernel+bounces-82864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5C9868AC1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 09:29:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A3231C21775
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:29:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ECA651B4;
	Tue, 27 Feb 2024 08:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VfQGuUZ8"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BBC55E78;
	Tue, 27 Feb 2024 08:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709022533; cv=none; b=mXUx0D3Ib6utVaRTPTt+8q4wqmXwu+6BwUXWunCuAeZ2FOMHxM5l+W9PZTuWSWQ/o56w/WhMc7RmE0RwaTpX6lS9eKlyIOApNy+JlASE60PHrUuQpdmkosvfKfMxTXXSernnoP8Kec+eYH60YeLd0ybrg1efPfpmY6YntKJ6ImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709022533; c=relaxed/simple;
	bh=Wo13l8NJVHR+LxKSyxLQCzQ+Y5u7XXhp9Pc+haG57NM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=mR/dL0H1Cuz1TCqQpvVT2GcoE2KBEinA5gOCqWNPfn2X8L8BONIMI21sRxtq2OPZuD02KuPtJD5ZhmqPJ0bXNcGgFWLD48UDMrzqRmaeqKV2+h6XUgrEE3BGcpjcgNt8f7vXk6cWEDN+ANeUVT15uDfu1KY5hCnVPI3zSytu/I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=VfQGuUZ8; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41R8SL4m016693;
	Tue, 27 Feb 2024 02:28:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709022501;
	bh=UvEz58JiJybT1iV4zwOdxj9BOekP3Yr+3ULHGrmn0T8=;
	h=From:To:CC:Subject:Date;
	b=VfQGuUZ8330zfn5j095nj7dWo8JP9A6KNzPc4HMsaSZEhlA8J0j7Kq+sjKiQZGNFV
	 FIXS31eTrUvgIKRCraes1LDzLoXUkHFlbuemf77eyEotZh7tsgOKvOQCvgyL5Hi0Nh
	 7k2YaZnUiIxuZGMvaN3P0HTfaVReW4J7Xdqbs7hc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41R8SLVL021600
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 27 Feb 2024 02:28:21 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 27
 Feb 2024 02:28:21 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 27 Feb 2024 02:28:21 -0600
Received: from uda0492258.dhcp.ti.com (uda0492258.dhcp.ti.com [172.24.227.9])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41R8SGWT053517;
	Tue, 27 Feb 2024 02:28:17 -0600
From: Siddharth Vadapalli <s-vadapalli@ti.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <rogerq@kernel.org>, <andrew@lunn.ch>,
        <vladimir.oltean@nxp.com>, <hkallweit1@gmail.com>,
        <dan.carpenter@linaro.org>, <horms@kernel.org>,
        <yuehaibing@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <srk@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH net-next] net: ethernet: ti: am65-cpsw: Add priv-flag for Switch VLAN Aware mode
Date: Tue, 27 Feb 2024 13:58:15 +0530
Message-ID: <20240227082815.2073826-1-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The CPSW Ethernet Switch on TI's K3 SoCs can be configured to operate in
VLAN Aware or VLAN Unaware modes of operation. This is different from
the ALE being VLAN Aware and Unaware. The Ethernet Switch being VLAN Aware
results in the addition/removal/replacement of VLAN tag of packets during
egress as described in section "12.2.1.4.6.4.1 Transmit VLAN Processing" of
the AM65x Technical Reference Manual available at:
https://www.ti.com/lit/ug/spruid7e/spruid7e.pdf
In VLAN Unaware mode, packets remain unmodified on egress.

The driver currently configures the Ethernet Switch in VLAN Aware mode by
default and there is no support to toggle this capability of the Ethernet
Switch at runtime. Thus, add support to toggle the capability by exporting
it via the ethtool "priv-flags" interface.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---

Hello,

This patch is based on net-next main branch's commit:
55a7246025cd Merge branch 'mptcp-various-small-improvements'

Regards,
Siddharth.

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c |  9 ++++++++-
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    | 12 +++++++++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |  1 +
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index d6ce2c9f0a8d..42c317874b75 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -374,6 +374,8 @@ static const struct am65_cpsw_ethtool_stat am65_slave_stats[] = {
 static const char am65_cpsw_ethtool_priv_flags[][ETH_GSTRING_LEN] = {
 #define	AM65_CPSW_PRIV_P0_RX_PTYPE_RROBIN	BIT(0)
 	"p0-rx-ptype-rrobin",
+#define	AM65_CPSW_PRIV_VLAN_AWARE		BIT(1)
+	"cpsw-vlan-aware",
 };
 
 static int am65_cpsw_ethtool_op_begin(struct net_device *ndev)
@@ -720,15 +722,19 @@ static u32 am65_cpsw_get_ethtool_priv_flags(struct net_device *ndev)
 	if (common->pf_p0_rx_ptype_rrobin)
 		priv_flags |= AM65_CPSW_PRIV_P0_RX_PTYPE_RROBIN;
 
+	if (common->cpsw_vlan_aware)
+		priv_flags |= AM65_CPSW_PRIV_VLAN_AWARE;
+
 	return priv_flags;
 }
 
 static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
-	int rrobin;
+	int rrobin, cpsw_vlan_aware;
 
 	rrobin = !!(flags & AM65_CPSW_PRIV_P0_RX_PTYPE_RROBIN);
+	cpsw_vlan_aware = !!(flags & AM65_CPSW_PRIV_VLAN_AWARE);
 
 	if (common->usage_count)
 		return -EBUSY;
@@ -740,6 +746,7 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
 	}
 
 	common->pf_p0_rx_ptype_rrobin = rrobin;
+	common->cpsw_vlan_aware = cpsw_vlan_aware;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 9d2f4ac783e4..fec2a5968a12 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -451,9 +451,14 @@ static int am65_cpsw_nuss_common_open(struct am65_cpsw_common *common)
 		return 0;
 
 	/* Control register */
-	writel(AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
-	       AM65_CPSW_CTL_VLAN_AWARE | AM65_CPSW_CTL_P0_RX_PAD,
-	       common->cpsw_base + AM65_CPSW_REG_CTL);
+	val = AM65_CPSW_CTL_P0_ENABLE | AM65_CPSW_CTL_P0_TX_CRC_REMOVE |
+	      AM65_CPSW_CTL_P0_RX_PAD;
+
+	if (common->cpsw_vlan_aware)
+		val |= AM65_CPSW_CTL_VLAN_AWARE;
+
+	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
+
 	/* Max length register */
 	writel(AM65_CPSW_MAX_PACKET_SIZE,
 	       host_p->port_base + AM65_CPSW_PORT_REG_RX_MAXLEN);
@@ -2977,6 +2982,7 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	init_completion(&common->tdown_complete);
 	common->tx_ch_num = AM65_CPSW_DEFAULT_TX_CHNS;
 	common->pf_p0_rx_ptype_rrobin = false;
+	common->cpsw_vlan_aware = true;
 	common->default_vlan = 1;
 
 	common->ports = devm_kcalloc(dev, common->port_num,
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index 7da0492dc091..91f625ea3859 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -147,6 +147,7 @@ struct am65_cpsw_common {
 	u32			cpsw_ver;
 	unsigned long		bus_freq;
 	bool			pf_p0_rx_ptype_rrobin;
+	bool			cpsw_vlan_aware;
 	struct am65_cpts	*cpts;
 	int			est_enabled;
 	bool			iet_enabled;
-- 
2.34.1


