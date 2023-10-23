Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A03BC7D3B39
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232646AbjJWPrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232139AbjJWPrl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:47:41 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8E23101;
        Mon, 23 Oct 2023 08:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1698076059; x=1729612059;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IcLRsqXm3RrW6Za2geboSU2UmP+psDSYEwOcvrxgQTE=;
  b=xXheGG3IiXnnrypW4IEiTgZ57kW/rh+U/uAsXIn+VRwWBG357eo5wQyK
   R2XfpDhFswEroKpQKE9x7BV1WOzdIgeKiu2BXRr0XxHSODDKRZimSLwbH
   miCv1s3gEDNWsKMABy2DgfboTiQBfC1PpC12OTh/wup9m3c3XJU2OHhNL
   7ttL9VJS6ScUG+eN00E5MUAIpAM1nJQr2esGn5k1/xkzuLNGBvOFG7a+4
   YImK0bM1U6juHMs1toUpxYip01wEdLkW98yZpOlO0MJG7sR7S+hwOtk7M
   XNQsRLvxUrecyWAIaCDAfN2jYciNAifyy+SOEhdp1kYt0SFO+lWaN4DWr
   Q==;
X-CSE-ConnectionGUID: 4O8X7pv4TK2a1gqzb4d+ug==
X-CSE-MsgGUID: br4/HxjgT1+QYrysW4eXBQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="10448736"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Oct 2023 08:47:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 23 Oct 2023 08:47:34 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 23 Oct 2023 08:47:22 -0700
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
Subject: [PATCH net-next v2 2/9] net: ethernet: oa_tc6: implement mac-phy software reset
Date:   Mon, 23 Oct 2023 21:16:42 +0530
Message-ID: <20231023154649.45931-3-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
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

Reset complete bit is set when the MAC-PHY reset completes and ready for
configuration. When it is set, it will generate a non-maskable interrupt
to alert the SPI host. Additionally reset complete bit in the STS0
register has to be written by one upon reset complete to clear the
interrupt.

Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 64 ++++++++++++++++++++++++++++++++---
 include/linux/oa_tc6.h        |  9 +++++
 2 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index acedc327b05e..e4457569135f 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -6,6 +6,8 @@
  */
 
 #include <linux/bitfield.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
 #include <linux/oa_tc6.h>
 
 /* Opaque structure for MACPHY drivers */
@@ -169,10 +171,15 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
 	if (ret)
 		return ret;
 
-	/* Check echoed/received control reply for errors */
-	ret = oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr, prote);
-	if (ret)
-		return ret;
+	/* In case of reset write, the echoed control command doesn't have any
+	 * valid data. So no need to check for errors.
+	 */
+	if (addr != RESET) {
+		/* Check echoed/received control reply for errors */
+		ret = oa_tc6_check_control(tc6, tx_buf, rx_buf, len, wnr, prote);
+		if (ret)
+			return ret;
+	}
 
 	if (!wnr) {
 		/* Copy read data from the rx data in case of ctrl read */
@@ -191,6 +198,49 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 addr, u32 val[], u8 len,
 	return ret;
 }
 
+static int oa_tc6_sw_reset(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	/* Perform software reset with both protected and unprotected control
+	 * commands because the driver doesn't know the current status of the
+	 * MAC-PHY.
+	 */
+	regval = SWRESET;
+	ret = oa_tc6_perform_ctrl(tc6, RESET, &regval, 1, true, true);
+	if (ret)
+		return ret;
+
+	ret = oa_tc6_perform_ctrl(tc6, RESET, &regval, 1, true, false);
+	if (ret)
+		return ret;
+
+	/* The chip completes a reset in 3us, we might get here earlier than
+	 * that, as an added margin we'll conditionally sleep 5us.
+	 */
+	udelay(5);
+
+	ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, false, false);
+	if (ret)
+		return ret;
+
+	/* Check for reset complete interrupt status */
+	if (regval & RESETC) {
+		regval = RESETC;
+		/* SPI host should write RESETC bit with one to
+		 * clear the reset interrupt status.
+		 */
+		ret = oa_tc6_perform_ctrl(tc6, STATUS0, &regval, 1, true, false);
+		if (ret)
+			return ret;
+	} else {
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 /**
  * oa_tc6_write_register - function for writing a MACPHY register.
  * @tc6: oa_tc6 struct.
@@ -279,6 +329,12 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote)
 	tc6->spi = spi;
 	tc6->prote = prote;
 
+	/* Perform MAC-PHY software reset */
+	if (oa_tc6_sw_reset(tc6)) {
+		dev_err(&spi->dev, "MAC-PHY software reset failed\n");
+		return NULL;
+	}
+
 	return tc6;
 }
 EXPORT_SYMBOL_GPL(oa_tc6_init);
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 6284828bda42..8a838499da97 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -21,6 +21,15 @@
 #define TC6_FTR_SIZE		4	/* Ctrl command footer size ss per OA */
 #define TC6_CTRL_BUF_SIZE	1032	/* Max ctrl buffer size for 128 regs */
 
+/* Open Alliance TC6 Standard Control and Status Registers */
+/* Reset Control and Status Register */
+#define RESET			0x0003
+#define SWRESET			BIT(0)	/* Software Reset */
+
+/* Status Register #0 */
+#define STATUS0			0x0008
+#define RESETC			BIT(6)	/* Reset Complete */
+
 struct oa_tc6 *oa_tc6_init(struct spi_device *spi, bool prote);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 addr, u32 val);
 int oa_tc6_read_register(struct oa_tc6 *tc6, u32 addr, u32 *val);
-- 
2.34.1

