Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB947ECAFF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 20:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjKOTIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 14:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjKOS53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 13:57:29 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5882B98;
        Wed, 15 Nov 2023 10:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+RixhPMEH5/E8f3rgQsQWgygFhf967DHp5AmV/RX8sQa2N0+RmzyTJByTfPimvFhbnBZqSPSVnqy2YT7NlSWRyOq3CiGFIOz4hTvTazlmpp1n+EGz7DlBTlfe/RVUf1/z7uQrNofq9h7r6jYF7dQTSd+TqV02KY6B3cgW3fK9ciF5a0FEwnX0ZClegAQ2jGTIwe6vv8S700s5DnO4ws2jk1/DAVs6os4E9Rtz6dMiBaeprw7UGFshmsNwzkzUuxYcP7MM/+bpfQB8MQrUKC1TzyQnqjMPP5qPq6WHTTfCvK5PoqPoMjDS31cKPyLPtQkStAIt+2m4xnE5RumW/gRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcbRRdxprSVwE+2U8ptxeubeWc/95/tEROJs7itvBEk=;
 b=eY+WJWiWQclOCCZhaWos1rW3S/Muz6VWJuYjVw7sxPR1aDMnc3i9+cXY8cXyIWg3YwsScLprfVNatkCKI+afspKI3TChbMc5vKmgu5k1IvNQLNWgdJV9d28GGCsx5gX7j9P+mV6qJcDriSpUtJQFcj40wwxJK0WyS6apccD+zh/wIgQPMdr4OzFBLsI6lFSMB5Y4AJsonQSf8gYWz6/djS5tu7F/TMEfo+cr2lLbtYZjz8NxnnQtXh8XIxOIomj47k5LLRpYVrHH6nrhDVnCUUhQ2kkP91cAEpXhFM8RAjAV0Cs+hkhl2ysnC1MTddlLP350JKRnn9twU38J3LP1Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcbRRdxprSVwE+2U8ptxeubeWc/95/tEROJs7itvBEk=;
 b=j7l9+w5CDKaLKPtfrt7gfbwhqQWWsYKnzSY5xMDME45wQDMAqH7J02hPMU6n3wRf6sdEADESkNigGWVweGpsqtVepfNQ49PXG2VVlaadv96gC6A5Ulb4oEFgtutXGnNsqE5LFHxXFkcEPrLBYWzcAnaetYgp4gxLK81FEL7dOqM=
Received: from MN2PR18CA0004.namprd18.prod.outlook.com (2603:10b6:208:23c::9)
 by DM4PR12MB5913.namprd12.prod.outlook.com (2603:10b6:8:66::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 18:57:19 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:23c:cafe::f6) by MN2PR18CA0004.outlook.office365.com
 (2603:10b6:208:23c::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18 via Frontend
 Transport; Wed, 15 Nov 2023 18:57:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7002.19 via Frontend Transport; Wed, 15 Nov 2023 18:57:18 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 12:57:18 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 15 Nov
 2023 10:57:17 -0800
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Wed, 15 Nov 2023 12:57:13 -0600
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <radhey.shyam.pandey@amd.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <michal.simek@amd.com>,
        <linux@armlinux.org.uk>, <anirudha.sarangi@amd.com>,
        <harini.katakam@amd.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Subject: [PATCH net-next v9 2/3] net: axienet: Preparatory changes for dmaengine support
Date:   Thu, 16 Nov 2023 00:26:52 +0530
Message-ID: <1700074613-1977070-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1700074613-1977070-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|DM4PR12MB5913:EE_
X-MS-Office365-Filtering-Correlation-Id: 55afe3b0-5b3d-41e3-e19b-08dbe60cb0fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ibUmfZqx3aGnSlBu17AMGuqdqR7iAbAeAM7VCHHyxXOh3cgT1L/hlAPqRbsu3V10kusSvRbit+kj/5e7CTdo4NFQ7sqFlTHS1ky2QG2ZNLSu5RZfYBSBQ823yQGA+RpsLQ7YVrYBkSzbgI02zpRa4bDjoQtktNJegnK0RBUBqhchHIdC5Q1EdiFDf7+of4AxXNFW5GcDnehJ1k994HNM3lgBWEHq/SuXooyTlQ0t2+b4VCPYSAr1UaItzhVWweFWQc1O6yOSFX4sYUKTE07FQSQhbYd31jaF1p8JVGccsUl9fNeFt3FOaeNDzoFRYOfsWIu7RjRUX/lhFmrqx0yEkGnQL7Q2rrYiFS7W3g9h26ORJdHgup8ulxBUWAKpnAh4DeTZzRKdGreZzRkRV1valQ+Vcsf2Jq7PMyz6VGrF3LyVxwy9WiclUetn/eZiTqB9+zOWIL3RpMDEH91PnZnaLspmYaNZYJODXMgt02xPweO7WxEHMmHs8h6hevZplgDGOMVS4kKJv/w/PxPDW+KKZvXPg2+pnXGDVT4cwNVjshTym4i8e6nM7bhVhrLyPs+BtjMRqeAOeg4Pp8m6A88oQm/nBGzBMzvGD4at2GQCphHyQZVXV0yDrZ/su4xps3bq36ZV6bWng2Ow9jDAViEg/IGd2AsglRX8cCl5gaKHs26724k7Q5XgPtUyLbomXR9JBCbpLg+M3Vqwd1ZxQpC1DzjkQZ16sQk2YqaBdv8FpAcy9bWkcutm73AJR7aRPLOzuiJCoAfc/rJtly4Rpts+zGun2x0lbZqV2OcwCyy8Mmo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(346002)(396003)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(82310400011)(36840700001)(40470700004)(46966006)(356005)(40480700001)(81166007)(6666004)(83380400001)(36860700001)(47076005)(82740400003)(8936002)(426003)(40460700003)(336012)(2616005)(41300700001)(5660300002)(7416002)(2906002)(30864003)(86362001)(70586007)(8676002)(36756003)(921008)(70206006)(54906003)(316002)(110136005)(4326008)(6636002)(26005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 18:57:18.6012
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55afe3b0-5b3d-41e3-e19b-08dbe60cb0fd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5913
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>

The axiethernet driver has inbuilt dma programming. In order to add
dmaengine support and make it's integration seamless the current axidma
inbuilt programming code is put under use_dmaengine check.

It also performs minor code reordering to minimize conditional
use_dmaengine checks and there is no functional change. It uses
"dmas" property to identify whether it should use a dmaengine
framework or inbuilt axidma programming.

Signed-off-by: Sarath Babu Naidu Gaddam <sarath.babu.naidu.gaddam@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v9:
- None

Changes for v8:
- Remove spurious new line and inline attribute from axienet_init_legacy_dma().
- Drop indirection for xmit() func. For dmaengine flow have separate
  netdev_ops.

Changes for v7:
- None

Changes for v6:
- None

Changes for v5:
- Fix git apply failure due to commit
  f1bc9fc4a06de0108e0dca2a9a7e99ba1fc632f9

Changes for v4:
- Renamed has_dmas to use_dmaegine.
- Removed the AXIENET_USE_DMA.
- Changed the start_xmit_** functions description.

Changes for v3:
- New patch
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |   2 +
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 284 ++++++++++--------
 2 files changed, 162 insertions(+), 124 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 575ff9de8985..3ead0bac597b 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -435,6 +435,7 @@ struct axidma_bd {
  * @coalesce_usec_rx:	IRQ coalesce delay for RX
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
+ * @use_dmaengine: flag to check dmaengine framework usage.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -499,6 +500,7 @@ struct axienet_local {
 	u32 coalesce_usec_rx;
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
+	u8  use_dmaengine;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 82d0d44b2b02..188b03e86263 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -589,10 +589,6 @@ static int axienet_device_reset(struct net_device *ndev)
 	struct axienet_local *lp = netdev_priv(ndev);
 	int ret;
 
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		return ret;
-
 	lp->max_frm_size = XAE_MAX_VLAN_FRAME_SIZE;
 	lp->options |= XAE_OPTION_VLAN;
 	lp->options &= (~XAE_OPTION_JUMBO);
@@ -606,11 +602,17 @@ static int axienet_device_reset(struct net_device *ndev)
 			lp->options |= XAE_OPTION_JUMBO;
 	}
 
-	ret = axienet_dma_bd_init(ndev);
-	if (ret) {
-		netdev_err(ndev, "%s: descriptor allocation failed\n",
-			   __func__);
-		return ret;
+	if (!lp->use_dmaengine) {
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			return ret;
+
+		ret = axienet_dma_bd_init(ndev);
+		if (ret) {
+			netdev_err(ndev, "%s: descriptor allocation failed\n",
+				   __func__);
+			return ret;
+		}
 	}
 
 	axienet_status = axienet_ior(lp, XAE_RCW1_OFFSET);
@@ -1125,41 +1127,21 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 static void axienet_dma_err_handler(struct work_struct *work);
 
 /**
- * axienet_open - Driver open routine.
- * @ndev:	Pointer to net_device structure
+ * axienet_init_legacy_dma - init the dma legacy code.
+ * @ndev:       Pointer to net_device structure
  *
  * Return: 0, on success.
- *	    non-zero error value on failure
+ *          non-zero error value on failure
+ *
+ * This is the dma  initialization code. It also allocates interrupt
+ * service routines, enables the interrupt lines and ISR handling.
  *
- * This is the driver open routine. It calls phylink_start to start the
- * PHY device.
- * It also allocates interrupt service routines, enables the interrupt lines
- * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
- * descriptors are initialized.
  */
-static int axienet_open(struct net_device *ndev)
+static int axienet_init_legacy_dma(struct net_device *ndev)
 {
 	int ret;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	dev_dbg(&ndev->dev, "axienet_open()\n");
-
-	/* When we do an Axi Ethernet reset, it resets the complete core
-	 * including the MDIO. MDIO must be disabled before resetting.
-	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
-	 */
-	axienet_lock_mii(lp);
-	ret = axienet_device_reset(ndev);
-	axienet_unlock_mii(lp);
-
-	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
-	if (ret) {
-		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
-		return ret;
-	}
-
-	phylink_start(lp->phylink);
-
 	/* Enable worker thread for Axi DMA error handling */
 	INIT_WORK(&lp->dma_err_task, axienet_dma_err_handler);
 
@@ -1193,13 +1175,61 @@ static int axienet_open(struct net_device *ndev)
 err_tx_irq:
 	napi_disable(&lp->napi_tx);
 	napi_disable(&lp->napi_rx);
-	phylink_stop(lp->phylink);
-	phylink_disconnect_phy(lp->phylink);
 	cancel_work_sync(&lp->dma_err_task);
 	dev_err(lp->dev, "request_irq() failed\n");
 	return ret;
 }
 
+/**
+ * axienet_open - Driver open routine.
+ * @ndev:	Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *	    non-zero error value on failure
+ *
+ * This is the driver open routine. It calls phylink_start to start the
+ * PHY device.
+ * It also allocates interrupt service routines, enables the interrupt lines
+ * and ISR handling. Axi Ethernet core is reset through Axi DMA core. Buffer
+ * descriptors are initialized.
+ */
+static int axienet_open(struct net_device *ndev)
+{
+	int ret;
+	struct axienet_local *lp = netdev_priv(ndev);
+
+	dev_dbg(&ndev->dev, "%s\n", __func__);
+
+	/* When we do an Axi Ethernet reset, it resets the complete core
+	 * including the MDIO. MDIO must be disabled before resetting.
+	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
+	 */
+	axienet_lock_mii(lp);
+	ret = axienet_device_reset(ndev);
+	axienet_unlock_mii(lp);
+
+	ret = phylink_of_phy_connect(lp->phylink, lp->dev->of_node, 0);
+	if (ret) {
+		dev_err(lp->dev, "phylink_of_phy_connect() failed: %d\n", ret);
+		return ret;
+	}
+
+	phylink_start(lp->phylink);
+
+	if (!lp->use_dmaengine) {
+		ret = axienet_init_legacy_dma(ndev);
+		if (ret)
+			goto err_phy;
+	}
+
+	return 0;
+
+err_phy:
+	phylink_stop(lp->phylink);
+	phylink_disconnect_phy(lp->phylink);
+	return ret;
+}
+
 /**
  * axienet_stop - Driver stop routine.
  * @ndev:	Pointer to net_device structure
@@ -1216,8 +1246,10 @@ static int axienet_stop(struct net_device *ndev)
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
-	napi_disable(&lp->napi_tx);
-	napi_disable(&lp->napi_rx);
+	if (!lp->use_dmaengine) {
+		napi_disable(&lp->napi_tx);
+		napi_disable(&lp->napi_rx);
+	}
 
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1225,18 +1257,18 @@ static int axienet_stop(struct net_device *ndev)
 	axienet_setoptions(ndev, lp->options &
 			   ~(XAE_OPTION_TXEN | XAE_OPTION_RXEN));
 
-	axienet_dma_stop(lp);
+	if (!lp->use_dmaengine) {
+		axienet_dma_stop(lp);
+		cancel_work_sync(&lp->dma_err_task);
+		free_irq(lp->tx_irq, ndev);
+		free_irq(lp->rx_irq, ndev);
+		axienet_dma_bd_release(ndev);
+	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
 
-	cancel_work_sync(&lp->dma_err_task);
-
 	if (lp->eth_irq > 0)
 		free_irq(lp->eth_irq, ndev);
-	free_irq(lp->tx_irq, ndev);
-	free_irq(lp->rx_irq, ndev);
-
-	axienet_dma_bd_release(ndev);
 	return 0;
 }
 
@@ -1412,14 +1444,16 @@ static void axienet_ethtools_get_regs(struct net_device *ndev,
 	data[29] = axienet_ior(lp, XAE_FMI_OFFSET);
 	data[30] = axienet_ior(lp, XAE_AF0_OFFSET);
 	data[31] = axienet_ior(lp, XAE_AF1_OFFSET);
-	data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
-	data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
-	data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
-	data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
-	data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
-	data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
-	data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
-	data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	if (!lp->use_dmaengine) {
+		data[32] = axienet_dma_in32(lp, XAXIDMA_TX_CR_OFFSET);
+		data[33] = axienet_dma_in32(lp, XAXIDMA_TX_SR_OFFSET);
+		data[34] = axienet_dma_in32(lp, XAXIDMA_TX_CDESC_OFFSET);
+		data[35] = axienet_dma_in32(lp, XAXIDMA_TX_TDESC_OFFSET);
+		data[36] = axienet_dma_in32(lp, XAXIDMA_RX_CR_OFFSET);
+		data[37] = axienet_dma_in32(lp, XAXIDMA_RX_SR_OFFSET);
+		data[38] = axienet_dma_in32(lp, XAXIDMA_RX_CDESC_OFFSET);
+		data[39] = axienet_dma_in32(lp, XAXIDMA_RX_TDESC_OFFSET);
+	}
 }
 
 static void
@@ -1880,9 +1914,6 @@ static int axienet_probe(struct platform_device *pdev)
 	u64_stats_init(&lp->rx_stat_sync);
 	u64_stats_init(&lp->tx_stat_sync);
 
-	netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
-	netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
-
 	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
@@ -2008,80 +2039,85 @@ static int axienet_probe(struct platform_device *pdev)
 		goto cleanup_clk;
 	}
 
-	/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
-	np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
-	if (np) {
-		struct resource dmares;
+	if (!of_find_property(pdev->dev.of_node, "dmas", NULL)) {
+		/* Find the DMA node, map the DMA registers, and decode the DMA IRQs */
+		np = of_parse_phandle(pdev->dev.of_node, "axistream-connected", 0);
 
-		ret = of_address_to_resource(np, 0, &dmares);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"unable to get DMA resource\n");
+		if (np) {
+			struct resource dmares;
+
+			ret = of_address_to_resource(np, 0, &dmares);
+			if (ret) {
+				dev_err(&pdev->dev,
+					"unable to get DMA resource\n");
+				of_node_put(np);
+				goto cleanup_clk;
+			}
+			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
+							     &dmares);
+			lp->rx_irq = irq_of_parse_and_map(np, 1);
+			lp->tx_irq = irq_of_parse_and_map(np, 0);
 			of_node_put(np);
+			lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		} else {
+			/* Check for these resources directly on the Ethernet node. */
+			lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
+			lp->rx_irq = platform_get_irq(pdev, 1);
+			lp->tx_irq = platform_get_irq(pdev, 0);
+			lp->eth_irq = platform_get_irq_optional(pdev, 2);
+		}
+		if (IS_ERR(lp->dma_regs)) {
+			dev_err(&pdev->dev, "could not map DMA regs\n");
+			ret = PTR_ERR(lp->dma_regs);
+			goto cleanup_clk;
+		}
+		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
+			dev_err(&pdev->dev, "could not determine irqs\n");
+			ret = -ENOMEM;
 			goto cleanup_clk;
 		}
-		lp->dma_regs = devm_ioremap_resource(&pdev->dev,
-						     &dmares);
-		lp->rx_irq = irq_of_parse_and_map(np, 1);
-		lp->tx_irq = irq_of_parse_and_map(np, 0);
-		of_node_put(np);
-		lp->eth_irq = platform_get_irq_optional(pdev, 0);
-	} else {
-		/* Check for these resources directly on the Ethernet node. */
-		lp->dma_regs = devm_platform_get_and_ioremap_resource(pdev, 1, NULL);
-		lp->rx_irq = platform_get_irq(pdev, 1);
-		lp->tx_irq = platform_get_irq(pdev, 0);
-		lp->eth_irq = platform_get_irq_optional(pdev, 2);
-	}
-	if (IS_ERR(lp->dma_regs)) {
-		dev_err(&pdev->dev, "could not map DMA regs\n");
-		ret = PTR_ERR(lp->dma_regs);
-		goto cleanup_clk;
-	}
-	if ((lp->rx_irq <= 0) || (lp->tx_irq <= 0)) {
-		dev_err(&pdev->dev, "could not determine irqs\n");
-		ret = -ENOMEM;
-		goto cleanup_clk;
-	}
 
-	/* Reset core now that clocks are enabled, prior to accessing MDIO */
-	ret = __axienet_device_reset(lp);
-	if (ret)
-		goto cleanup_clk;
+		/* Reset core now that clocks are enabled, prior to accessing MDIO */
+		ret = __axienet_device_reset(lp);
+		if (ret)
+			goto cleanup_clk;
+
+		/* Autodetect the need for 64-bit DMA pointers.
+		 * When the IP is configured for a bus width bigger than 32 bits,
+		 * writing the MSB registers is mandatory, even if they are all 0.
+		 * We can detect this case by writing all 1's to one such register
+		 * and see if that sticks: when the IP is configured for 32 bits
+		 * only, those registers are RES0.
+		 * Those MSB registers were introduced in IP v7.1, which we check first.
+		 */
+		if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
+			void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
 
-	/* Autodetect the need for 64-bit DMA pointers.
-	 * When the IP is configured for a bus width bigger than 32 bits,
-	 * writing the MSB registers is mandatory, even if they are all 0.
-	 * We can detect this case by writing all 1's to one such register
-	 * and see if that sticks: when the IP is configured for 32 bits
-	 * only, those registers are RES0.
-	 * Those MSB registers were introduced in IP v7.1, which we check first.
-	 */
-	if ((axienet_ior(lp, XAE_ID_OFFSET) >> 24) >= 0x9) {
-		void __iomem *desc = lp->dma_regs + XAXIDMA_TX_CDESC_OFFSET + 4;
-
-		iowrite32(0x0, desc);
-		if (ioread32(desc) == 0) {	/* sanity check */
-			iowrite32(0xffffffff, desc);
-			if (ioread32(desc) > 0) {
-				lp->features |= XAE_FEATURE_DMA_64BIT;
-				addr_width = 64;
-				dev_info(&pdev->dev,
-					 "autodetected 64-bit DMA range\n");
-			}
 			iowrite32(0x0, desc);
+			if (ioread32(desc) == 0) {	/* sanity check */
+				iowrite32(0xffffffff, desc);
+				if (ioread32(desc) > 0) {
+					lp->features |= XAE_FEATURE_DMA_64BIT;
+					addr_width = 64;
+					dev_info(&pdev->dev,
+						 "autodetected 64-bit DMA range\n");
+				}
+				iowrite32(0x0, desc);
+			}
+		}
+		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
+			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
+			ret = -EINVAL;
+			goto cleanup_clk;
 		}
-	}
-	if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
-		dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit archecture\n");
-		ret = -EINVAL;
-		goto cleanup_clk;
-	}
 
-	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
-	if (ret) {
-		dev_err(&pdev->dev, "No suitable DMA available\n");
-		goto cleanup_clk;
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
+		if (ret) {
+			dev_err(&pdev->dev, "No suitable DMA available\n");
+			goto cleanup_clk;
+		}
+		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
+		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
 	}
 
 	/* Check for Ethernet core IRQ (optional) */
@@ -2099,8 +2135,8 @@ static int axienet_probe(struct platform_device *pdev)
 	}
 
 	lp->coalesce_count_rx = XAXIDMA_DFT_RX_THRESHOLD;
-	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_count_tx = XAXIDMA_DFT_TX_THRESHOLD;
+	lp->coalesce_usec_rx = XAXIDMA_DFT_RX_USEC;
 	lp->coalesce_usec_tx = XAXIDMA_DFT_TX_USEC;
 
 	ret = axienet_mdio_setup(lp);
-- 
2.34.1

