Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A5D7DAD60
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbjJ2RBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjJ2RBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:01:20 -0400
Received: from hutie.ust.cz (hutie.ust.cz [IPv6:2a03:3b40:fe:f0::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60517F1;
        Sun, 29 Oct 2023 10:01:14 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1698598869; bh=3obvFsIjM96yZObtxW8n9rYv9PO/4hd8o4iHKP3fPHU=;
        h=From:To:Cc:Subject:Date;
        b=oy969q+11rxbPH9cmRXxn2HzOTPuGmb0VMsz2ddR9KK/ynvf7bXNiYZ59vwv4s2By
         i0bAABtuznqJQtxeSHwIhKUpL9GgtlZLi2tLJi4Es2OLo/FehsMGXHRSPmEROM6Cj2
         9/C9VVpp43XUb2TQFXhnEdPFw/Geu2MCQp+l5uZE=
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Alyssa Rosenzweig <alyssa@rosenzweig.io>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik@cutebit.org>
Subject: [PATCH] dmaengine: apple-admac: Keep upper bits of REG_BUS_WIDTH
Date:   Sun, 29 Oct 2023 18:00:53 +0100
Message-Id: <20231029170053.82146-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hector Martin <marcan@marcan.st>

For RX channels, REG_BUS_WIDTH seems to default to a value of 0xf00, and
macOS preserves the upper bits when setting the configuration in the
lower ones. If we reset the upper bits to 0, this causes framing errors
on suspend/resume (the data stream "tears" and channels get swapped
around). Keeping the upper bits untouched, like the macOS driver does,
fixes this issue.

Signed-off-by: Hector Martin <marcan@marcan.st>
Reviewed-by: Martin Povišer <povik@cutebit.org>
Signed-off-by: Martin Povišer <povik@cutebit.org>
---
 drivers/dma/apple-admac.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/apple-admac.c b/drivers/dma/apple-admac.c
index 5b63996640d9..9588773dd2eb 100644
--- a/drivers/dma/apple-admac.c
+++ b/drivers/dma/apple-admac.c
@@ -57,6 +57,8 @@
 
 #define REG_BUS_WIDTH(ch)	(0x8040 + (ch) * 0x200)
 
+#define BUS_WIDTH_WORD_SIZE	GENMASK(3, 0)
+#define BUS_WIDTH_FRAME_SIZE	GENMASK(7, 4)
 #define BUS_WIDTH_8BIT		0x00
 #define BUS_WIDTH_16BIT		0x01
 #define BUS_WIDTH_32BIT		0x02
@@ -740,7 +742,8 @@ static int admac_device_config(struct dma_chan *chan,
 	struct admac_data *ad = adchan->host;
 	bool is_tx = admac_chan_direction(adchan->no) == DMA_MEM_TO_DEV;
 	int wordsize = 0;
-	u32 bus_width = 0;
+	u32 bus_width = readl_relaxed(ad->base + REG_BUS_WIDTH(adchan->no)) &
+		~(BUS_WIDTH_WORD_SIZE | BUS_WIDTH_FRAME_SIZE);
 
 	switch (is_tx ? config->dst_addr_width : config->src_addr_width) {
 	case DMA_SLAVE_BUSWIDTH_1_BYTE:
-- 
2.38.3

