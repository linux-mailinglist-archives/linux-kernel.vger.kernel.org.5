Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F347CCC17
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 21:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344192AbjJQTTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 15:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344215AbjJQTTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 15:19:00 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43556100;
        Tue, 17 Oct 2023 12:18:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d9AZcE7H1lSsjF5ZUB9isiGS585b4ModscH58BGdS+em8gIls4r0o2M/qiabx6jiq6DSyHV4uAPHeLN2m3V9NqZuK44G7VJ0OZPvl6CdSLs5q+v4jNJUQnBmr3GhlF8xEPVQZPlxC1AQr89oIM+NvQVvpNMO/9nWTovrSqSdlLbABm1mInAsIwkextfR4VMIEu3MslknT43FF4E/c++gb907wqwmFCG1P5AqPbzrjAAq4M9Fu7Upn+aRtwDDtgNcyBau0PUfngwfD+WbUKCcHLPKQUnl3PHPMSvQJPZy5gOM8d0zr+fr8Sc6Gwp05j9+zFAZUugBrPiNped+Vie1RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxetk7tMRUWSDGGl+y7wFmIVkNfK1TBu7qOqNRapAXQ=;
 b=d+h9/pSQCX1fdDuC7ARoQQWNOH120RULvu4tTT8F4ZpnJQr4SRUwbaeoYuN5sTrQSLBKCbIeh+B1kVLN12POih+1zMPH/GlWYI27qaRysYe1Gmkdb0cqg6g1eAYGVfF3sKJeKf04pcbFGD/eFbmM48UsLMFAZ98WnqDpYLh6GQ1JJQCmW+ctQKEQj0Gckhyhmt8guGqErfM7hZ0cWB+PL7wA3FDFQ0VNHNQZcA+3TTO0T+eKH0DiHlhmanLiPEcLK3T1VrFfA7RDwopLa4jYJxw+l54ORFvD5/cOY1FO4QXgL0XILAmtakIQjSwUZEmUyZcEcGSws10q+kwU4LQXwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxetk7tMRUWSDGGl+y7wFmIVkNfK1TBu7qOqNRapAXQ=;
 b=no7NPmDgjjt+kmKhDaHMgA8NXIZ/kYoivJnkbtLXtuEurnaJzFSkxhqx8mVHSYEkRQ9VoxccPd7/g8QzhD8amEMSqCjQT/JFJRRzXTq0w1hRiJB3+KYG4UX7TgtdgKYWqU+yFOgLF0+1EIuZzeSuogZzdP83IhEpAu5YGBFYrS8=
Received: from DS0PR17CA0005.namprd17.prod.outlook.com (2603:10b6:8:191::6) by
 SN7PR12MB8604.namprd12.prod.outlook.com (2603:10b6:806:273::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.34; Tue, 17 Oct
 2023 19:18:52 +0000
Received: from DS3PEPF000099D8.namprd04.prod.outlook.com
 (2603:10b6:8:191:cafe::8b) by DS0PR17CA0005.outlook.office365.com
 (2603:10b6:8:191::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36 via Frontend
 Transport; Tue, 17 Oct 2023 19:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D8.mail.protection.outlook.com (10.167.17.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Tue, 17 Oct 2023 19:18:51 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:51 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 17 Oct
 2023 14:18:50 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 17 Oct 2023 14:18:46 -0500
From:   Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <michal.simek@amd.com>, <linux@armlinux.org.uk>,
        <f.fainelli@gmail.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <git@amd.com>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v8 3/3] net: axienet: Introduce dmaengine support
Date:   Wed, 18 Oct 2023 00:47:54 +0530
Message-ID: <1697570274-798170-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1697570274-798170-1-git-send-email-radhey.shyam.pandey@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D8:EE_|SN7PR12MB8604:EE_
X-MS-Office365-Filtering-Correlation-Id: bb28500d-0ad2-4e67-d079-08dbcf45e5e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gjo75MP/E4MhABImbtv482+wJagvRf/xNvyzI9kXs944DsnnV2VvwiqlQgUhq+Oni2Wk0akdeMrON+6QWz3svh1TgspcHA/Oa+Aoa28tdWUIuXI/4GSLBiCzNl4l2hzKSJdlVEP/UjRDaGpC8Rt7ia4WjhIGD6mn47NF0a6T6vp2diotIj46OWjYbv7LwXhn14CtoW1Mbc/NaCWd/azyNVb/ZBavspk04g7fxgKLS2Tli8MKYodcj5GRO29OccBI1PDIqm3Ame0W3YN/PHJIqw6A4lISzy9eEb5gtQYKo5BcyganPW28X4+fnBf7BuH6ayYT7fDoX4KRz1KyuU7/kaSKciYta8sgr6zqjvOA2sC49TdoilJR8zSKLSKdsOMNlEabq+A8NLUJe22Oxd3f5HpVJxNGKDHSo12SH9s0IRetFDwVaK4aZqPzZWShdi+EBtOgdLld+Dg+zj+Mi3FAY8+AFKfglxk0rVQI9h7KpAIpdhJ5G3iMcV32qvmQF7gAcThYayX9kpftQgIckwAFY0aoAjsC8tVBvL+NGU54hswLFJ1vkwXP7VzMk3LEqurD/TqHvT5GLhqmSLDKZ3NQ8Mdgc6sUtb1tnZAsl51pLX/hLexjNrv6jnQ7FNf9wj1p+NqQxGRtsep4tEOHN+Po2pyOtsisbS6B8fZi82SwZ2R0Xc1vMH9xqRXjMGXbbfT06dOryRTelxJ9GMj86MkxuvbUy+ActkQxh/2EdLcaymVg4Qj+Gw3b/4DOL4IKH1s78PXKajQ/AM3iKZMvXEjEx3Sfsy9tdpiVXKdnDfBCCj8=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(356005)(921005)(82740400003)(86362001)(478600001)(83380400001)(81166007)(40460700003)(36860700001)(47076005)(70206006)(54906003)(70586007)(426003)(316002)(110136005)(30864003)(336012)(6666004)(2616005)(36756003)(5660300002)(8936002)(41300700001)(7416002)(4326008)(2906002)(8676002)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 19:18:51.9143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb28500d-0ad2-4e67-d079-08dbcf45e5e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF000099D8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8604
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmaengine framework to communicate with the xilinx DMAengine
driver(AXIDMA).

Axi ethernet driver uses separate channels for transmit and receive.
Add support for these channels to handle TX and RX with skb and
appropriate callbacks. Also add axi ethernet core interrupt for
dmaengine framework support.

The dmaengine framework was extended for metadata API support.
However it still needs further enhancements to make it well suited for
ethernet usecases. The ethernet features i.e ethtool set/get of DMA IP
properties, ndo_poll_controller,(mentioned in TODO) are not supported
and it requires follow-up discussions.

dmaengine support has a dependency on xilinx_dma as it uses
xilinx_vdma_channel_set_config() API to reset the DMA IP
which internally reset MAC prior to accessing MDIO.

Benchmark with netperf:

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t TCP_STREAM
MIGRATED TCP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Recv   Send    Send
Socket Socket  Message  Elapsed
Size   Size    Size     Time     Throughput
bytes  bytes   bytes    secs.    10^6bits/sec

131072  16384  16384    10.03     915.55

xilinx-zcu102-20232:~$ netperf -H 192.168.10.20 -t UDP_STREAM
MIGRATED UDP STREAM TEST from 0.0.0.0 (0.0.0.0) port 0 AF_INET
to 192.168.10.20 () port 0 AF_INET
Socket  Message  Elapsed      Messages
Size    Size     Time         Okay Errors   Throughput
bytes   bytes    secs            #      #   10^6bits/sec

212992   65507   10.00       18192      0     953.35
212992           10.00       18192            953.35

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v8:
- Use dev_consume_skb_any() in transmit callback.
- Fix queue stop logic in _xmit_dmaengine().
- Fix skb leak in _xmit_dmaengine() error path.
- In dmaengine tx path use dma_device pointer to call prep_slave_sg.
- In rx submit use rate limiting for mapping errors and fix error
  handling.
- Revert dev_err_probe from _init_dmaengine().
- Remove unnecessary new line after call to _init_dmaengine().
- Move free_irq(lp->eth_irq) to error path.
- Have separate netdev_ops for dmaengine flow.
- Improve axienet_dma_tx_cb and axienet_rx_submit_desc documentation.

Changes for v7:
- Fix comment spaces.
- In xmit use correct XAE_FEATURE_PARTIAL_TX_CSUM define.
- Rename app to app_metadata.
- Switch to __netif_rx.
- In axienet_rx_submit_desc() add mapping error handling.

Changes for v6:
- Rename struct axi_skbuff to skbuf_dma_descriptor and removed
  __packed attribute.
- Drop kmem_cache implementation and switch to using ring buffers.
- Remove __inline from axienet_init_dmaengine().
- Name labels after the target.
- Add error check for platform_get_irq_optional().
- Fix double space and no empty lines between call and its error check.

Changes for v5:
- Switch to amd.com email
- Modified commit description. Remove lore link, mention reset API,
  add performance numbers.
- Fix kmem_cache resource leak on stop.
- Use dmaengine_terminate_sync instead of deprecated
  dmaengine_terminate_all API.

Changes for v4:
- Remove the AXIENET_USE_DMA.
- Add dev_err_probe for dma_request_chan error handling.
- Add kmem_cache_destroy for create in axienet_setup_dma_chan.
- Add XILINX_DMA dependency in ethernet drier Kconfig file.
- move setup_dma_channel to init_dmaengine func
- Remove unlikely
	if (unlikely(ret < 0))
- if (ret == 0) to if (!ret)
- Rename DMA_MEM_TO_DEV to DMA_TO_DEVICE
- Remove else check for lp->use_dmaengine = 1; in the probe.

Changes in V3:
- New patch for dmaengine framework support.
---
 drivers/net/ethernet/xilinx/Kconfig           |   1 +
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  33 ++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 392 +++++++++++++++++-
 3 files changed, 424 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/Kconfig b/drivers/net/ethernet/xilinx/Kconfig
index 0014729b8865..35d96c633a33 100644
--- a/drivers/net/ethernet/xilinx/Kconfig
+++ b/drivers/net/ethernet/xilinx/Kconfig
@@ -26,6 +26,7 @@ config XILINX_EMACLITE
 config XILINX_AXI_EMAC
 	tristate "Xilinx 10/100/1000 AXI Ethernet support"
 	depends on HAS_IOMEM
+	depends on XILINX_DMA
 	select PHYLINK
 	help
 	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 3ead0bac597b..807ead678551 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -14,6 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/if_vlan.h>
 #include <linux/phylink.h>
+#include <linux/skbuff.h>
 
 /* Packet size info */
 #define XAE_HDR_SIZE			14 /* Size of Ethernet header */
@@ -378,6 +379,22 @@ struct axidma_bd {
 
 #define XAE_NUM_MISC_CLOCKS 3
 
+/**
+ * struct skbuf_dma_descriptor - skb for each dma descriptor
+ * @sgl: Pointer for sglist.
+ * @desc: Pointer to dma descriptor.
+ * @dma_address: dma address of sglist.
+ * @skb: Pointer to SKB transferred using DMA
+ * @sg_len: number of entries in the sglist.
+ */
+struct skbuf_dma_descriptor {
+	struct scatterlist sgl[MAX_SKB_FRAGS + 1];
+	struct dma_async_tx_descriptor *desc;
+	dma_addr_t dma_address;
+	struct sk_buff *skb;
+	int sg_len;
+};
+
 /**
  * struct axienet_local - axienet private per device data
  * @ndev:	Pointer for net_device to which it will be attached.
@@ -436,6 +453,14 @@ struct axidma_bd {
  * @coalesce_count_tx:	Store the irq coalesce on TX side.
  * @coalesce_usec_tx:	IRQ coalesce delay for TX
  * @use_dmaengine: flag to check dmaengine framework usage.
+ * @tx_chan:	TX DMA channel.
+ * @rx_chan:	RX DMA channel.
+ * @tx_skb_ring: Pointer to TX skb ring buffer array.
+ * @rx_skb_ring: Pointer to RX skb ring buffer array.
+ * @tx_ring_head: TX skb ring buffer head index.
+ * @tx_ring_tail: TX skb ring buffer tail index.
+ * @rx_ring_head: RX skb ring buffer head index.
+ * @rx_ring_tail: RX skb ring buffer tail index.
  */
 struct axienet_local {
 	struct net_device *ndev;
@@ -501,6 +526,14 @@ struct axienet_local {
 	u32 coalesce_count_tx;
 	u32 coalesce_usec_tx;
 	u8  use_dmaengine;
+	struct dma_chan *tx_chan;
+	struct dma_chan *rx_chan;
+	struct skbuf_dma_descriptor **tx_skb_ring;
+	struct skbuf_dma_descriptor **rx_skb_ring;
+	int tx_ring_head;
+	int tx_ring_tail;
+	int rx_ring_head;
+	int rx_ring_tail;
 };
 
 /**
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 188b03e86263..36c43b555921 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -38,6 +38,10 @@
 #include <linux/phy.h>
 #include <linux/mii.h>
 #include <linux/ethtool.h>
+#include <linux/dmaengine.h>
+#include <linux/dma-mapping.h>
+#include <linux/dma/xilinx_dma.h>
+#include <linux/circ_buf.h>
 
 #include "xilinx_axienet.h"
 
@@ -47,6 +51,9 @@
 #define TX_BD_NUM_MIN			(MAX_SKB_FRAGS + 1)
 #define TX_BD_NUM_MAX			4096
 #define RX_BD_NUM_MAX			4096
+#define DMA_NUM_APP_WORDS		5
+#define LEN_APP				4
+#define RX_BUF_NUM_DEFAULT		128
 
 /* Must be shorter than length of ethtool_drvinfo.driver field to fit */
 #define DRIVER_NAME		"xaxienet"
@@ -55,6 +62,8 @@
 
 #define AXIENET_REGS_N		40
 
+static int axienet_rx_submit_desc(struct net_device *ndev);
+
 /* Match table for of_platform binding */
 static const struct of_device_id axienet_of_match[] = {
 	{ .compatible = "xlnx,axi-ethernet-1.00.a", },
@@ -120,6 +129,16 @@ static struct axienet_option axienet_options[] = {
 	{}
 };
 
+static struct skbuf_dma_descriptor *axienet_get_rx_desc(struct axienet_local *lp, int i)
+{
+	return lp->rx_skb_ring[i & (RX_BUF_NUM_DEFAULT - 1)];
+}
+
+static struct skbuf_dma_descriptor *axienet_get_tx_desc(struct axienet_local *lp, int i)
+{
+	return lp->tx_skb_ring[i & (TX_BD_NUM_MAX - 1)];
+}
+
 /**
  * axienet_dma_in32 - Memory mapped Axi DMA register read
  * @lp:		Pointer to axienet local structure
@@ -727,6 +746,122 @@ static inline int axienet_check_tx_bd_space(struct axienet_local *lp,
 	return 0;
 }
 
+/**
+ * axienet_dma_tx_cb - DMA engine callback for TX channel.
+ * @data:       Pointer to the axienet_local structure.
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for TX channel to notify
+ * that the transmit is done.
+ */
+static void axienet_dma_tx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axienet_local *lp = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+
+	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_tail++);
+	u64_stats_update_begin(&lp->tx_stat_sync);
+	u64_stats_add(&lp->tx_bytes, skbuf_dma->skb->len);
+	u64_stats_add(&lp->tx_packets, 1);
+	u64_stats_update_end(&lp->tx_stat_sync);
+	dma_unmap_sg(lp->dev, skbuf_dma->sgl, skbuf_dma->sg_len, DMA_TO_DEVICE);
+	dev_consume_skb_any(skbuf_dma->skb);
+	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) > MAX_SKB_FRAGS + 1)
+		netif_wake_queue(lp->ndev);
+}
+
+/**
+ * axienet_start_xmit_dmaengine - Starts the transmission.
+ * @skb:        sk_buff pointer that contains data to be Txed.
+ * @ndev:       Pointer to net_device structure.
+ *
+ * Return: NETDEV_TX_OK on success or any non space errors.
+ *         NETDEV_TX_BUSY when free element in TX skb ring buffer
+ *         is not available.
+ *
+ * This function is invoked to initiate transmission. The
+ * function sets the skbs, register dma callback API and submit
+ * the dma transaction.
+ * Additionally if checksum offloading is supported,
+ * it populates AXI Stream Control fields with appropriate values.
+ */
+static netdev_tx_t
+axienet_start_xmit_dmaengine(struct sk_buff *skb, struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_tx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	u32 app_metadata[DMA_NUM_APP_WORDS] = {0};
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct dma_device *dma_dev;
+	u32 csum_start_off;
+	u32 csum_index_off;
+	int sg_len;
+	int ret;
+
+	dma_dev = lp->tx_chan->device;
+	sg_len = skb_shinfo(skb)->nr_frags + 1;
+	if (CIRC_SPACE(lp->tx_ring_head, lp->tx_ring_tail, TX_BD_NUM_MAX) <= sg_len) {
+		netif_stop_queue(ndev);
+		if (net_ratelimit())
+			netdev_warn(ndev, "TX ring unexpectedly full\n");
+		return NETDEV_TX_BUSY;
+	}
+
+	skbuf_dma = axienet_get_tx_desc(lp, lp->tx_ring_head);
+	if (!skbuf_dma) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	lp->tx_ring_head++;
+	sg_init_table(skbuf_dma->sgl, sg_len);
+	ret = skb_to_sgvec(skb, skbuf_dma->sgl, 0, skb->len);
+	if (ret < 0) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	ret = dma_map_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	if (!ret) {
+		dev_kfree_skb_any(skb);
+		return NETDEV_TX_OK;
+	}
+
+	/* Fill up app fields for checksum */
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (lp->features & XAE_FEATURE_FULL_TX_CSUM) {
+			/* Tx Full Checksum Offload Enabled */
+			app_metadata[0] |= 2;
+		} else if (lp->features & XAE_FEATURE_PARTIAL_TX_CSUM) {
+			csum_start_off = skb_transport_offset(skb);
+			csum_index_off = csum_start_off + skb->csum_offset;
+			/* Tx Partial Checksum Offload Enabled */
+			app_metadata[0] |= 1;
+			app_metadata[1] = (csum_start_off << 16) | csum_index_off;
+		}
+	} else if (skb->ip_summed == CHECKSUM_UNNECESSARY) {
+		app_metadata[0] |= 2; /* Tx Full Checksum Offload Enabled */
+	}
+
+	dma_tx_desc = dma_dev->device_prep_slave_sg(lp->tx_chan, skbuf_dma->sgl,
+			sg_len, DMA_MEM_TO_DEV,
+			DMA_PREP_INTERRUPT, (void *)app_metadata);
+	if (!dma_tx_desc)
+		goto xmit_error_unmap_sg;
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->sg_len = sg_len;
+	dma_tx_desc->callback_param = lp;
+	dma_tx_desc->callback_result = axienet_dma_tx_cb;
+	dmaengine_submit(dma_tx_desc);
+	dma_async_issue_pending(lp->tx_chan);
+
+	return NETDEV_TX_OK;
+
+xmit_error_unmap_sg:
+	dma_unmap_sg(lp->dev, skbuf_dma->sgl, sg_len, DMA_TO_DEVICE);
+	return NETDEV_TX_OK;
+}
+
 /**
  * axienet_tx_poll - Invoked once a transmit is completed by the
  * Axi DMA Tx channel.
@@ -893,6 +1028,42 @@ axienet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 	return NETDEV_TX_OK;
 }
 
+/**
+ * axienet_dma_rx_cb - DMA engine callback for RX channel.
+ * @data:       Pointer to the skbuf_dma_descriptor structure.
+ * @result:     error reporting through dmaengine_result.
+ * This function is called by dmaengine driver for RX channel to notify
+ * that the packet is received.
+ */
+static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
+{
+	struct axienet_local *lp = data;
+	struct skbuf_dma_descriptor *skbuf_dma;
+	size_t meta_len, meta_max_len, rx_len;
+	struct sk_buff *skb;
+	u32 *app_metadata;
+
+	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
+	skb = skbuf_dma->skb;
+	app_metadata = dmaengine_desc_get_metadata_ptr(skbuf_dma->desc, &meta_len,
+						       &meta_max_len);
+	dma_unmap_single(lp->dev, skbuf_dma->dma_address, lp->max_frm_size,
+			 DMA_FROM_DEVICE);
+	/* TODO: Derive app word index programmatically */
+	rx_len = (app_metadata[LEN_APP] & 0xFFFF);
+	skb_put(skb, rx_len);
+	skb->protocol = eth_type_trans(skb, lp->ndev);
+	skb->ip_summed = CHECKSUM_NONE;
+
+	__netif_rx(skb);
+	u64_stats_update_begin(&lp->rx_stat_sync);
+	u64_stats_add(&lp->rx_packets, 1);
+	u64_stats_add(&lp->rx_bytes, rx_len);
+	u64_stats_update_end(&lp->rx_stat_sync);
+	axienet_rx_submit_desc(lp->ndev);
+	dma_async_issue_pending(lp->rx_chan);
+}
+
 /**
  * axienet_rx_poll - Triggered by RX ISR to complete the BD processing.
  * @napi:	Pointer to NAPI structure.
@@ -1126,6 +1297,150 @@ static irqreturn_t axienet_eth_irq(int irq, void *_ndev)
 
 static void axienet_dma_err_handler(struct work_struct *work);
 
+/**
+ * axienet_rx_submit_desc - Submit the rx descriptors to dmaengine.
+ * allocate skbuff, map the scatterlist and obtain a descriptor
+ * and then add the callback information and submit descriptor.
+ *
+ * @ndev:	net_device pointer
+ *
+ *Return: 0, on success.
+ *          non-zero error value on failure
+ */
+static int axienet_rx_submit_desc(struct net_device *ndev)
+{
+	struct dma_async_tx_descriptor *dma_rx_desc = NULL;
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	struct sk_buff *skb;
+	dma_addr_t addr;
+	int ret;
+
+	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_head);
+	if (!skbuf_dma)
+		return -ENOMEM;
+	lp->rx_ring_head++;
+	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
+	if (!skb)
+		return -ENOMEM;
+
+	sg_init_table(skbuf_dma->sgl, 1);
+	addr = dma_map_single(lp->dev, skb->data, lp->max_frm_size, DMA_FROM_DEVICE);
+	if (unlikely(dma_mapping_error(lp->dev, addr))) {
+		if (net_ratelimit())
+			netdev_err(ndev, "DMA mapping error\n");
+		ret = -ENOMEM;
+		goto rx_submit_err_free_skb;
+	}
+	sg_dma_address(skbuf_dma->sgl) = addr;
+	sg_dma_len(skbuf_dma->sgl) = lp->max_frm_size;
+	dma_rx_desc = dmaengine_prep_slave_sg(lp->rx_chan, skbuf_dma->sgl,
+					      1, DMA_DEV_TO_MEM,
+					      DMA_PREP_INTERRUPT);
+	if (!dma_rx_desc) {
+		ret = -EINVAL;
+		goto rx_submit_err_unmap_skb;
+	}
+
+	skbuf_dma->skb = skb;
+	skbuf_dma->dma_address = sg_dma_address(skbuf_dma->sgl);
+	skbuf_dma->desc = dma_rx_desc;
+	dma_rx_desc->callback_param = lp;
+	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	dmaengine_submit(dma_rx_desc);
+
+	return 0;
+
+rx_submit_err_unmap_skb:
+	dma_unmap_single(lp->dev, addr, lp->max_frm_size, DMA_FROM_DEVICE);
+rx_submit_err_free_skb:
+	dev_kfree_skb(skb);
+	return ret;
+}
+
+/**
+ * axienet_init_dmaengine - init the dmaengine code.
+ * @ndev:       Pointer to net_device structure
+ *
+ * Return: 0, on success.
+ *          non-zero error value on failure
+ *
+ * This is the dmaengine initialization code.
+ */
+static int axienet_init_dmaengine(struct net_device *ndev)
+{
+	struct axienet_local *lp = netdev_priv(ndev);
+	struct skbuf_dma_descriptor *skbuf_dma;
+	int i, ret;
+
+	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+	if (IS_ERR(lp->tx_chan)) {
+		dev_err(lp->dev, "No Ethernet DMA (TX) channel found\n");
+		return PTR_ERR(lp->tx_chan);
+	}
+
+	lp->rx_chan = dma_request_chan(lp->dev, "rx_chan0");
+	if (IS_ERR(lp->rx_chan)) {
+		ret = PTR_ERR(lp->rx_chan);
+		dev_err(lp->dev, "No Ethernet DMA (RX) channel found\n");
+		goto err_dma_release_tx;
+	}
+
+	lp->tx_ring_tail = 0;
+	lp->tx_ring_head = 0;
+	lp->rx_ring_tail = 0;
+	lp->rx_ring_head = 0;
+	lp->tx_skb_ring = kcalloc(TX_BD_NUM_MAX, sizeof(*lp->tx_skb_ring),
+				  GFP_KERNEL);
+	if (!lp->tx_skb_ring) {
+		ret = -ENOMEM;
+		goto err_dma_release_rx;
+	}
+	for (i = 0; i < TX_BD_NUM_MAX; i++) {
+		skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
+		if (!skbuf_dma) {
+			ret = -ENOMEM;
+			goto err_free_tx_skb_ring;
+		}
+		lp->tx_skb_ring[i] = skbuf_dma;
+	}
+
+	lp->rx_skb_ring = kcalloc(RX_BUF_NUM_DEFAULT, sizeof(*lp->rx_skb_ring),
+				  GFP_KERNEL);
+	if (!lp->rx_skb_ring) {
+		ret = -ENOMEM;
+		goto err_free_tx_skb_ring;
+	}
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++) {
+		skbuf_dma = kzalloc(sizeof(*skbuf_dma), GFP_KERNEL);
+		if (!skbuf_dma) {
+			ret = -ENOMEM;
+			goto err_free_rx_skb_ring;
+		}
+		lp->rx_skb_ring[i] = skbuf_dma;
+	}
+	/* TODO: Instead of BD_NUM_DEFAULT use runtime support */
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		axienet_rx_submit_desc(ndev);
+	dma_async_issue_pending(lp->rx_chan);
+
+	return 0;
+
+err_free_rx_skb_ring:
+	for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+		kfree(lp->rx_skb_ring[i]);
+	kfree(lp->rx_skb_ring);
+err_free_tx_skb_ring:
+	for (i = 0; i < TX_BD_NUM_MAX; i++)
+		kfree(lp->tx_skb_ring[i]);
+	kfree(lp->tx_skb_ring);
+err_dma_release_rx:
+	dma_release_channel(lp->rx_chan);
+err_dma_release_tx:
+	dma_release_channel(lp->tx_chan);
+	return ret;
+}
+
 /**
  * axienet_init_legacy_dma - init the dma legacy code.
  * @ndev:       Pointer to net_device structure
@@ -1216,7 +1531,19 @@ static int axienet_open(struct net_device *ndev)
 
 	phylink_start(lp->phylink);
 
-	if (!lp->use_dmaengine) {
+	if (lp->use_dmaengine) {
+		/* Enable interrupts for Axi Ethernet core (if defined) */
+		if (lp->eth_irq > 0) {
+			ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,
+					  ndev->name, ndev);
+			if (ret)
+				goto err_phy;
+		}
+
+		ret = axienet_init_dmaengine(ndev);
+		if (ret < 0)
+			goto err_free_eth_irq;
+	} else {
 		ret = axienet_init_legacy_dma(ndev);
 		if (ret)
 			goto err_phy;
@@ -1224,6 +1551,9 @@ static int axienet_open(struct net_device *ndev)
 
 	return 0;
 
+err_free_eth_irq:
+	if (lp->eth_irq > 0)
+		free_irq(lp->eth_irq, ndev);
 err_phy:
 	phylink_stop(lp->phylink);
 	phylink_disconnect_phy(lp->phylink);
@@ -1243,6 +1573,7 @@ static int axienet_open(struct net_device *ndev)
 static int axienet_stop(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
+	int i;
 
 	dev_dbg(&ndev->dev, "axienet_close()\n");
 
@@ -1263,6 +1594,21 @@ static int axienet_stop(struct net_device *ndev)
 		free_irq(lp->tx_irq, ndev);
 		free_irq(lp->rx_irq, ndev);
 		axienet_dma_bd_release(ndev);
+	} else {
+		dmaengine_terminate_sync(lp->tx_chan);
+		dmaengine_synchronize(lp->tx_chan);
+		dmaengine_terminate_sync(lp->rx_chan);
+		dmaengine_synchronize(lp->rx_chan);
+
+		for (i = 0; i < TX_BD_NUM_MAX; i++)
+			kfree(lp->tx_skb_ring[i]);
+		kfree(lp->tx_skb_ring);
+		for (i = 0; i < RX_BUF_NUM_DEFAULT; i++)
+			kfree(lp->rx_skb_ring[i]);
+		kfree(lp->rx_skb_ring);
+
+		dma_release_channel(lp->rx_chan);
+		dma_release_channel(lp->tx_chan);
 	}
 
 	axienet_iow(lp, XAE_IE_OFFSET, 0);
@@ -1365,6 +1711,18 @@ static const struct net_device_ops axienet_netdev_ops = {
 #endif
 };
 
+static const struct net_device_ops axienet_netdev_dmaengine_ops = {
+	.ndo_open = axienet_open,
+	.ndo_stop = axienet_stop,
+	.ndo_start_xmit = axienet_start_xmit_dmaengine,
+	.ndo_get_stats64 = axienet_get_stats64,
+	.ndo_change_mtu	= axienet_change_mtu,
+	.ndo_set_mac_address = netdev_set_mac_address,
+	.ndo_validate_addr = eth_validate_addr,
+	.ndo_eth_ioctl = axienet_ioctl,
+	.ndo_set_rx_mode = axienet_set_multicast_list,
+};
+
 /**
  * axienet_ethtools_get_drvinfo - Get various Axi Ethernet driver information.
  * @ndev:	Pointer to net_device structure
@@ -1897,7 +2255,6 @@ static int axienet_probe(struct platform_device *pdev)
 	SET_NETDEV_DEV(ndev, &pdev->dev);
 	ndev->flags &= ~IFF_MULTICAST;  /* clear multicast */
 	ndev->features = NETIF_F_SG;
-	ndev->netdev_ops = &axienet_netdev_ops;
 	ndev->ethtool_ops = &axienet_ethtool_ops;
 
 	/* MTU range: 64 - 9000 */
@@ -2118,8 +2475,39 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
+	} else {
+		struct xilinx_vdma_config cfg;
+		struct dma_chan *tx_chan;
+
+		lp->eth_irq = platform_get_irq_optional(pdev, 0);
+		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
+			ret = lp->eth_irq;
+			goto cleanup_clk;
+		}
+		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
+		if (IS_ERR(tx_chan)) {
+			ret = PTR_ERR(tx_chan);
+			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
+			goto cleanup_clk;
+		}
+
+		cfg.reset = 1;
+		/* As name says VDMA but it has support for DMA channel reset */
+		ret = xilinx_vdma_channel_set_config(tx_chan, &cfg);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "Reset channel failed\n");
+			dma_release_channel(tx_chan);
+			goto cleanup_clk;
+		}
+
+		dma_release_channel(tx_chan);
+		lp->use_dmaengine = 1;
 	}
 
+	if (lp->use_dmaengine)
+		ndev->netdev_ops = &axienet_netdev_dmaengine_ops;
+	else
+		ndev->netdev_ops = &axienet_netdev_ops;
 	/* Check for Ethernet core IRQ (optional) */
 	if (lp->eth_irq <= 0)
 		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");
-- 
2.34.1

