Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFD17988BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243986AbjIHOah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243970AbjIHOab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:30:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFA51FE8;
        Fri,  8 Sep 2023 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694183422; x=1725719422;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o/4kIOJ9QiV558+OQwsWtdlftTAaBUFLv7BslVDZoe4=;
  b=cOvNhMNNqGnG95Cwno7D/374xXDT7shCCSWKWykYCsdzyvZ4PbPgcOSu
   mbOQtp7jV8hRF9xRa1LB6scSdIhSAlnZ+ZNYN9dAXWTf//68zxocQAz66
   ZsqjpO4YyQRdAlqsxc/O0BTB8Gnc8cjDX46ISRcNTfhqoPoGnguL71IzF
   C3mHNNpRbTdHiZKH0cyAYV3WtLcNiVJnhlmz8pOw3QB+gVm6tWOB+1ytd
   V9P/MYCW9EvycO725eLuT5wJ0406VyVINgQAN1t88Sw8RtzjCaUZs9Z55
   6IgH0wWtsOCy/RbzPFWulqnCN8B+f8o5GqccoRpyDe6LRsstaWNNJHoDY
   Q==;
X-CSE-ConnectionGUID: 0oM0WiPjTKynEvbCqNPq+Q==
X-CSE-MsgGUID: Vkq0kZYKRvy3VwWmZvV6yQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,237,1688454000"; 
   d="scan'208";a="170641771"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Sep 2023 07:30:20 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 8 Sep 2023 07:30:16 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Fri, 8 Sep 2023 07:30:09 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <corbet@lwn.net>, <steen.hegelund@microchip.com>,
        <rdunlap@infradead.org>, <horms@kernel.org>,
        <casper.casan@gmail.com>, <andrew@lunn.ch>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <horatiu.vultur@microchip.com>, <Woojung.Huh@microchip.com>,
        <Nicolas.Ferre@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <Thorsten.Kummermehr@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [RFC PATCH net-next 3/6] net: ethernet: implement OA TC6 configuration function
Date:   Fri, 8 Sep 2023 19:59:16 +0530
Message-ID: <20230908142919.14849-4-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
References: <20230908142919.14849-1-Parthiban.Veerasooran@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Read STDCAP register for the MAC-PHY capability and check against the
configuration parameters such as chunk payload, tx cut through and rx cut
through to configure the MAC-PHY. It also configures the control command
protected/unprotected mode.

In cut through mode configuration the MAC-PHY doesn't buffer the incoming
data. In tx case, it passes the data to the network if the configured cps
of data available. In rx case, it passes the data to the SPI host if the
configured cps of data available from the network. Also disables all the
errors mask in the IMASK0 register to check for the errors.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 39 +++++++++++++++++++++++++++++++++++
 include/linux/oa_tc6.h        | 28 ++++++++++++++++++++++---
 2 files changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 0019f70345b6..65a7317f768d 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -287,6 +287,45 @@ int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len)
 }
 EXPORT_SYMBOL_GPL(oa_tc6_read_register);
 
+int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr,
+		     bool rx_cut_thr)
+{
+	u32 regval;
+	int ret;
+
+	/* Read and configure the IMASK0 register for unmasking the interrupts */
+	ret = oa_tc6_read_register(tc6, OA_TC6_IMASK0, &regval, 1);
+	if (ret)
+		return ret;
+
+	regval &= TXPEM & TXBOEM & TXBUEM & RXBOEM & LOFEM & HDREM;
+	ret = oa_tc6_write_register(tc6, OA_TC6_IMASK0, &regval, 1);
+	if (ret)
+		return ret;
+
+	/* Configure the CONFIG0 register with the required configurations */
+	regval = SYNC;
+	if (ctrl_prot)
+		regval |= PROTE;
+	if (tx_cut_thr)
+		regval |= TXCTE;
+	if (rx_cut_thr)
+		regval |= RXCTE;
+	regval |= FIELD_PREP(CPS, ilog2(cps) / ilog2(2));
+
+	ret = oa_tc6_write_register(tc6, OA_TC6_CONFIG0, &regval, 1);
+	if (ret)
+		return ret;
+
+	tc6->cps = cps;
+	tc6->ctrl_prot = ctrl_prot;
+	tc6->tx_cut_thr = tx_cut_thr;
+	tc6->rx_cut_thr = rx_cut_thr;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_configure);
+
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi)
 {
 	struct oa_tc6 *tc6;
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 315f061c2dfe..fa29c4e09720 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -19,11 +19,28 @@
 
 /* Open Alliance TC6 Standard Control and Status Registers */
 #define OA_TC6_RESET	0x0003		/* Reset Control and Status Register */
+#define OA_TC6_CONFIG0	0x0004		/* Configuration Register #0 */
 #define OA_TC6_STS0	0x0008		/* Status Register #0 */
+#define OA_TC6_IMASK0	0x000C		/* Interrupt Mask Register #0 */
 
 /* RESET register field */
 #define SW_RESET	BIT(0)		/* Software Reset */
 
+/* CONFIG0 register fields */
+#define SYNC		BIT(15)		/* Configuration Synchronization */
+#define TXCTE		BIT(9)		/* Tx cut-through enable */
+#define RXCTE		BIT(8)		/* Rx cut-through enable */
+#define PROTE		BIT(5)		/* Ctrl read/write Protection Enable */
+#define CPS		GENMASK(2, 0)	/* Chunk Payload Size */
+
+/* Unmasking interrupt fields in IMASK0 */
+#define HDREM		~BIT(5)		/* Header Error Mask */
+#define LOFEM		~BIT(4)		/* Loss of Framing Error Mask */
+#define RXBOEM		~BIT(3)		/* Rx Buffer Overflow Error Mask */
+#define TXBUEM		~BIT(2)		/* Tx Buffer Underflow Error Mask */
+#define TXBOEM		~BIT(1)		/* Tx Buffer Overflow Error Mask */
+#define TXPEM		~BIT(0)		/* Tx Protocol Error Mask */
+
 /* STATUS0 register field */
 #define RESETC		BIT(6)		/* Reset Complete */
 
@@ -31,15 +48,20 @@
 #define TC6_FTR_SIZE	4		/* Ctrl command footer size ss per OA */
 
 struct oa_tc6 {
-	struct spi_device *spi;
-	bool ctrl_prot;
+	struct completion rst_complete;
 	struct task_struct *tc6_task;
 	wait_queue_head_t tc6_wq;
+	struct spi_device *spi;
+	bool tx_cut_thr;
+	bool rx_cut_thr;
+	bool ctrl_prot;
 	bool int_flag;
-	struct completion rst_complete;
+	u8 cps;
 };
 
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
 int oa_tc6_deinit(struct oa_tc6 *tc6);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 value[], u8 len);
+int oa_tc6_configure(struct oa_tc6 *tc6, u8 cps, bool ctrl_prot, bool tx_cut_thr,
+		     bool rx_cut_thr);
-- 
2.34.1

