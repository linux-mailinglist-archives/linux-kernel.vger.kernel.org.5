Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2D1C7A08ED
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240773AbjINPU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239524AbjINPU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:20:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2046.outbound.protection.outlook.com [40.107.220.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C411FCC;
        Thu, 14 Sep 2023 08:20:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dih+S/SBNNOSYyUBhsm9ktAkab6ea+yxSENwCdtNt+1hg3ypbst/FDV+3Tz4X/JeDx4xl7wuMAm/gupOxpzM2KF+hldJklvJm/IUzrYkaDimvMH/349y+Ia/mDAh12b0tc1KxBpXETKk29cyXE3BI3y1rskx3p4Cx0YDwK9g/CfKPsnSvxCj6xQaBdHINWoQU2l/eX5nznq03kjZOzosG3tz2qvN3qnB/qd5Tl4sb0PSrvq7sMDsHkKiEYoSzajgd4bHDC739R4EWcJamSwDbVtzJ6RSgYZvqv39b1dHiXvrIKP91Xyw1Mr+vbTzlj8D13XTvuOzWwrusYBqvdl8aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7rYXGvPzbMSrXYOJqxO3Qy46Yltf8R9K0xFSsYrDwYw=;
 b=O/8cW1NWqvFTrSGZmGF7+qt9ruWUZzWfcuMCKCvPOiOJwBJCu75d5lXsQ49HK/JlfguZHnqd6Qk/Ox0l3KBQ3dTQ1um+kcTrx5ALZxW5Nbji/oh8mIB+EitvpemrCjam0eWuQ3g5dGWc46XNtuf9VpvjpbqQxUiiyJpusUkv35pde5+SZLJUiDyUdeWqGmbDLTXBdzR7Eigr10YkgeuBcXtvCM+ek4XzluJ0zFCUHivxmoA7tyuOrrjB2moXC1A5F+6OY6oauNY+OtDA9za5lliG+5atWLQwaWxZFNR26h7mIJ0vurXfZE4fSl94oJEVVE3r03K9aKxeaSYXCtaLrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7rYXGvPzbMSrXYOJqxO3Qy46Yltf8R9K0xFSsYrDwYw=;
 b=d8hYobn7RxFFDtn+M2EB+9J4okcV6dDhG+CO8vqgQ6oDEREs2an8ZaDL0puO2nrxf/FxJLE81INVz0GLKZXI3/4v9OdS4jrsGBu+WeKrlFcopNWv9mzA/AuSywxgP1eWBJK6vHS1Z1Y6nAmtpj52ITHeL3ITIX4Ge2HILvPbBVU=
Received: from BYAPR08CA0026.namprd08.prod.outlook.com (2603:10b6:a03:100::39)
 by DM6PR12MB4943.namprd12.prod.outlook.com (2603:10b6:5:1bc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.19; Thu, 14 Sep
 2023 15:20:19 +0000
Received: from SA2PEPF000015CA.namprd03.prod.outlook.com
 (2603:10b6:a03:100:cafe::87) by BYAPR08CA0026.outlook.office365.com
 (2603:10b6:a03:100::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20 via Frontend
 Transport; Thu, 14 Sep 2023 15:20:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SA2PEPF000015CA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 14 Sep 2023 15:20:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 10:20:14 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 08:20:14 -0700
Received: from xcbalexaust40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 14 Sep 2023 10:20:13 -0500
From:   Alex Austin <alex.austin@amd.com>
To:     <netdev@vger.kernel.org>, <linux-net-drivers@amd.com>
CC:     <ecree.xilinx@gmail.com>, <habetsm.xilinx@gmail.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <linux-kernel@vger.kernel.org>, Alex Austin <alex.austin@amd.com>
Subject: [PATCH net-next] sfc: make coding style of PTP addresses consistent with core
Date:   Thu, 14 Sep 2023 16:19:16 +0100
Message-ID: <20230914151916.21044-1-alex.austin@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CA:EE_|DM6PR12MB4943:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0fb7b7-7a9b-4531-dbcb-08dbb5361ac4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: opJ5LCGIvXVe9JWoLrEx4rywVD8UnG6w2NvujgHAqXi8OwvC3W0angCFLnu/fHrfyM3KIazppHXoDTbf7AaPdWdKX5GNRkAa1REo5SFK18m9VywUdznX5wIy3vECNUGqHkXbhFiw4Y5FS54VAo+5+WUzM1JC2YDAX97WZXbHXbVqRCeV+MTHDYG+J0ZhIAZM74A0yqee8NuliGBkgSjVX9GhwxHPGA+JijXnM+W17UW1BgooKYvjGhb8xdkatCr1AvT7tdC2lH6V4XhlCHGlrK+OnDTWuKx9law9jJcRIQs3+pSHs0p8DJTiaDcv1BYKL/o9jN+tbj+++meh4o0aeN0OUierJZ39xkzveUp60PZHSpNE1RVTshKOSIDgEdcgnFeiFEwZ1R6S1nxXU7uyy+EwBWY8f/KvOe9pXh8nREYCvJqm2ULdxAVrlYAkxb5sfdacfYPMa5ev3tk8/79V/K/zvba1HwqVGIuar0ETZ9Vm+bUZY8BgcoV7DECbhVxoSqqpQd6VB9Q5N6s1ISHKp7ko7jRtBwBEKoDILql2oc9lSeMC0D8Xa6usONvR9iObpkh0cS7J1wFinUQHXpKl4EXns4LyfwsCXhI4AAZadyBx7ZbwvdIgmF7WcrUTRY7qpzJWCCqPF2MAH08niUgwEHqdbITHQRmRctcgD8qsOTSgwT/N6PNs0SHTd0K2RarreMXElaleeGWS1mX9s4UHzz7fy0swsCVwfm5L/nOF4wNFCpgKch48X+E7b3IWYX435ZA/0qACivwMPouqT3hnlg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(39860400002)(396003)(82310400011)(186009)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(26005)(5660300002)(4326008)(1076003)(8936002)(40460700003)(8676002)(2616005)(2906002)(83380400001)(86362001)(81166007)(356005)(82740400003)(36756003)(47076005)(336012)(36860700001)(426003)(40480700001)(70586007)(316002)(54906003)(6636002)(110136005)(70206006)(44832011)(41300700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2023 15:20:18.4402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0fb7b7-7a9b-4531-dbcb-08dbb5361ac4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4943
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow the style used in the core kernel (e.g.
include/linux/etherdevice.h and include/linux/in6.h) for the PTP IPv6
and Ethernet addresses. No functional changes.

Signed-off-by: Alex Austin <alex.austin@amd.com>
Reviewed-by: Edward Cree <ecree.xilinx@gmail.com>
---
 drivers/net/ethernet/sfc/ptp.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/sfc/ptp.c b/drivers/net/ethernet/sfc/ptp.c
index f54200f03e15..b04fdbb8aece 100644
--- a/drivers/net/ethernet/sfc/ptp.c
+++ b/drivers/net/ethernet/sfc/ptp.c
@@ -108,11 +108,17 @@
 #define	PTP_MIN_LENGTH		63
 
 #define PTP_ADDR_IPV4		0xe0000181	/* 224.0.1.129 */
-#define PTP_ADDR_IPV6		{0xff, 0x0e, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
-				0, 0x01, 0x81}	/* ff0e::181 */
+
+/* ff0e::181 */
+static const struct in6_addr ptp_addr_ipv6 = { { {
+	0xff, 0x0e, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x01, 0x81 } } };
+
+/* 01-1B-19-00-00-00 */
+static const u8 ptp_addr_ether[ETH_ALEN] __aligned(2) = {
+	0x01, 0x1b, 0x19, 0x00, 0x00, 0x00 };
+
 #define PTP_EVENT_PORT		319
 #define PTP_GENERAL_PORT	320
-#define PTP_ADDR_ETHER		{0x01, 0x1b, 0x19, 0, 0, 0} /* 01-1B-19-00-00-00 */
 
 /* Annoyingly the format of the version numbers are different between
  * versions 1 and 2 so it isn't possible to simply look for 1 or 2.
@@ -1296,7 +1302,7 @@ static int efx_ptp_insert_ipv4_filter(struct efx_nic *efx,
 
 static int efx_ptp_insert_ipv6_filter(struct efx_nic *efx,
 				      struct list_head *filter_list,
-				      struct in6_addr *addr, u16 port,
+				      const struct in6_addr *addr, u16 port,
 				      unsigned long expiry)
 {
 	struct efx_filter_spec spec;
@@ -1309,11 +1315,10 @@ static int efx_ptp_insert_ipv6_filter(struct efx_nic *efx,
 static int efx_ptp_insert_eth_multicast_filter(struct efx_nic *efx)
 {
 	struct efx_ptp_data *ptp = efx->ptp_data;
-	const u8 addr[ETH_ALEN] = PTP_ADDR_ETHER;
 	struct efx_filter_spec spec;
 
 	efx_ptp_init_filter(efx, &spec);
-	efx_filter_set_eth_local(&spec, EFX_FILTER_VID_UNSPEC, addr);
+	efx_filter_set_eth_local(&spec, EFX_FILTER_VID_UNSPEC, ptp_addr_ether);
 	spec.match_flags |= EFX_FILTER_MATCH_ETHER_TYPE;
 	spec.ether_type = htons(ETH_P_1588);
 	return efx_ptp_insert_filter(efx, &ptp->rxfilters_mcast, &spec, 0);
@@ -1346,15 +1351,13 @@ static int efx_ptp_insert_multicast_filters(struct efx_nic *efx)
 	 * PTP over IPv6 and Ethernet
 	 */
 	if (efx_ptp_use_mac_tx_timestamps(efx)) {
-		struct in6_addr ipv6_addr = {{PTP_ADDR_IPV6}};
-
 		rc = efx_ptp_insert_ipv6_filter(efx, &ptp->rxfilters_mcast,
-						&ipv6_addr, PTP_EVENT_PORT, 0);
+						&ptp_addr_ipv6, PTP_EVENT_PORT, 0);
 		if (rc < 0)
 			goto fail;
 
 		rc = efx_ptp_insert_ipv6_filter(efx, &ptp->rxfilters_mcast,
-						&ipv6_addr, PTP_GENERAL_PORT, 0);
+						&ptp_addr_ipv6, PTP_GENERAL_PORT, 0);
 		if (rc < 0)
 			goto fail;
 
@@ -1379,9 +1382,7 @@ static bool efx_ptp_valid_unicast_event_pkt(struct sk_buff *skb)
 			ip_hdr(skb)->protocol == IPPROTO_UDP &&
 			udp_hdr(skb)->source == htons(PTP_EVENT_PORT);
 	} else if (skb->protocol == htons(ETH_P_IPV6)) {
-		struct in6_addr mcast_addr = {{PTP_ADDR_IPV6}};
-
-		return !ipv6_addr_equal(&ipv6_hdr(skb)->daddr, &mcast_addr) &&
+		return !ipv6_addr_equal(&ipv6_hdr(skb)->daddr, &ptp_addr_ipv6) &&
 			ipv6_hdr(skb)->nexthdr == IPPROTO_UDP &&
 			udp_hdr(skb)->source == htons(PTP_EVENT_PORT);
 	}
-- 
2.17.1

