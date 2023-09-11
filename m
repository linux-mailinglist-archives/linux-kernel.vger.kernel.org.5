Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D63B79A177
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 04:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbjIKClB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 22:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIKClA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 22:41:00 -0400
Received: from smtp3.hiworks.co.kr (smtp3.hiworks.co.kr [121.254.168.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9D4B0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 19:40:51 -0700 (PDT)
Received: (qmail 187497 invoked from network); 11 Sep 2023 11:40:45 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.38)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        11 Sep 2023 11:40:45 +0900
Received: (qmail 28400 invoked from network); 11 Sep 2023 11:40:45 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        11 Sep 2023 11:40:45 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230911114045_542828023>
X-MailFrom-INFO: Info <country_code:KR|rbl_level:0>
From:   Myunguk Kim <mwkim@gaonchips.com>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        =?UTF-8?q?Uw=20e=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Myunguk Kim <mwkim@gaonchips.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jose Abreu <joabreu@synopsys.com>, devicetree@vger.kernel.org
Subject: [PATCH] ASoC: dwc: Add Single DMA mode support
Date:   Mon, 11 Sep 2023 11:40:23 +0900
Message-Id: <20230911024023.43833-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a SoC between dwc and DMA block (ie. PL330)
that does not have a burst signal and supports only single.

So write not-support-burst property on dts, it support single DMA mode.

Signed-off-by: Myunguk Kim <mwkim@gaonchips.com>
---
 .../bindings/sound/snps,designware-i2s.yaml          |  3 +++
 include/sound/designware_i2s.h                       |  1 +
 sound/soc/dwc/dwc-i2s.c                              | 12 ++++++++++--
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
index a48d040b0a4f..43a46ba2a70c 100644
--- a/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
+++ b/Documentation/devicetree/bindings/sound/snps,designware-i2s.yaml
@@ -86,6 +86,9 @@ properties:
       The phandle to System Register Controller syscon node and the I2S-rx(ADC)
       enabled control offset and mask of SYS_SYSCONSAIF__SYSCFG register.
 
+  no-burst:
+    description: Use single transaction only between DesignWare I2S and DMA IP.
+
 allOf:
   - $ref: dai-common.yaml#
   - if:
diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index f6803205a9fb..f0207f21f09d 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -36,6 +36,7 @@ struct i2s_platform_data 
{ 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
 	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
 	#define DW_I2S_QUIRK_16BIT_IDX_OVERRIDE (1 << 2)
+	#define DW_I2S_QUIRK_NO_BURST		(1 << 3)
 	unsigned int quirks;
 	unsigned int i2s_reg_comp1;
 	unsigned int i2s_reg_comp2;
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 5ab1b3eb2d28..71ff894035a4 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -713,7 +713,10 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 		dev->play_dma_data.dt.addr = res->start + I2S_TXDMA;
 		dev->play_dma_data.dt.fifo_size = fifo_depth *
 			(fifo_width[idx2]) >> 8;
-		dev->play_dma_data.dt.maxburst = 16;
+		if (dev->quirks & DW_I2S_QUIRK_NO_BURST)
+			dev->play_dma_data.dt.maxburst = 1;
+		else
+			dev->play_dma_data.dt.maxburst = 16;
 	}
 	if (COMP1_RX_ENABLED(comp1)) 
{ 		idx2 = COMP2_RX_WORDSIZE_0(comp2);
@@ -722,7 +725,10 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 		dev->capture_dma_data.dt.addr = res->start + I2S_RXDMA;
 		dev->capture_dma_data.dt.fifo_size = fifo_depth *
 			(fifo_width[idx2] >> 8);
-		dev->capture_dma_data.dt.maxburst = 16;
+		if (dev->quirks & DW_I2S_QUIRK_NO_BURST)
+			dev->capture_dma_data.dt.maxburst = 1;
+		else
+			dev->capture_dma_data.dt.maxburst = 16;
 	}
 
 	return 0;
@@ -979,6 +985,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else 
{ 		clk_id = "i2sclk";
+		if (of_get_property(pdev->dev.of_node, "no-burst", NULL))
+			dev->quirks |= DW_I2S_QUIRK_NO_BURST;
 		ret = dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
 	}
 	if (ret < 0)
-- 
2.34.1

