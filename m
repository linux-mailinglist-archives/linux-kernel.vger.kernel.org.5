Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544D798118
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 06:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbjIHEBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 00:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjIHEBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 00:01:46 -0400
X-Greylist: delayed 398 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Sep 2023 21:01:38 PDT
Received: from smtp1.hiworks.co.kr (smtp1.hiworks.co.kr [121.254.168.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3631BDD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 21:01:37 -0700 (PDT)
Received: (qmail 127826 invoked from network); 8 Sep 2023 12:54:54 +0900
Received: from unknown (HELO hiworks.co.kr) (192.168.10.224)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        8 Sep 2023 12:54:54 +0900
Received: (qmail 154234 invoked from network); 8 Sep 2023 12:54:54 +0900
Received: from unknown (HELO saram-MINIPC-PN53..) (mwkim@gaonchips.com@220.88.49.178)
        by 0 (qmail 1.03 + ejcp v14) with SMTP;
        8 Sep 2023 12:54:54 +0900
X-Authinfo: HIWORKS SMTP authenticated <mwkim@gaonchips.com|220.88.49.178|mwkim@gaonchips.com|230908125454_7307154146>
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
        Myunguk Kim <mwkim@gaonchips.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] ASoC: dwc: Add Single DMA mode support
Date:   Fri,  8 Sep 2023 12:54:49 +0900
Message-Id: <20230908035449.2211723-1-mwkim@gaonchips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
 include/sound/designware_i2s.h |  1 +
 sound/soc/dwc/dwc-i2s.c        | 12 ++++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index f6803205a9fb..060e0cbcd55c 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -36,6 +36,7 @@ struct i2s_platform_data 
{ 	#define DW_I2S_QUIRK_COMP_REG_OFFSET	(1 << 0)
 	#define DW_I2S_QUIRK_COMP_PARAM1	(1 << 1)
 	#define DW_I2S_QUIRK_16BIT_IDX_OVERRIDE (1 << 2)
+	#define DW_I2S_QUIRK_NOT_SUPPORT_BURST	(1 << 3)
 	unsigned int quirks;
 	unsigned int i2s_reg_comp1;
 	unsigned int i2s_reg_comp2;
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 5ab1b3eb2d28..c4dd8c18beba 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -713,7 +713,10 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 		dev->play_dma_data.dt.addr = res->start + I2S_TXDMA;
 		dev->play_dma_data.dt.fifo_size = fifo_depth *
 			(fifo_width[idx2]) >> 8;
-		dev->play_dma_data.dt.maxburst = 16;
+		if (dev->quirks & DW_I2S_QUIRK_NOT_SUPPORT_BURST)
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
+		if (dev->quirks & DW_I2S_QUIRK_NOT_SUPPORT_BURST)
+			dev->capture_dma_data.dt.maxburst = 1;
+		else
+			dev->capture_dma_data.dt.maxburst = 16;
 	}
 
 	return 0;
@@ -979,6 +985,8 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		ret = dw_configure_dai_by_pd(dev, dw_i2s_dai, res, pdata);
 	} else 
{ 		clk_id = "i2sclk";
+		if (of_get_property(pdev->dev.of_node, "not-support-burst", NULL))
+			dev->quirks |= DW_I2S_QUIRK_NOT_SUPPORT_BURST;
 		ret = dw_configure_dai_by_dt(dev, dw_i2s_dai, res);
 	}
 	if (ret < 0)
-- 
2.34.1

