Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42F267B0C23
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjI0SrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 14:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjI0SrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 14:47:05 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD3DD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:47:04 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-7740729ae12so778896485a.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 11:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hefring-com.20230601.gappssmtp.com; s=20230601; t=1695840423; x=1696445223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xGsoS6S76d+wc39dHVr5d6LqZuXhI4/2gCLnqm1TcHs=;
        b=Tx6qmdJGqtbLxKKG5F+TQKLy+Lu9Fwv2VXVv/6UJfBoiUtTyQ+PyalRanal+PiXSlX
         3UqmZWpygyX2Z2dPgBMmr4whJX1R8MKrQiSgFD+AAm/YRMMeWFq0yZZ3auJS37OqNchP
         QtLg5+yydBTjGGnj7/EC0Y5Zub3y7SGEx6ntAJ9q3MjSV1Zd34TLfiXkjKARqqvJ7CQW
         fYwCSNPTBQtSfXFlzJeMzNoPedxf9cFU/GOp+NRPWq1GwV0xW0DQCHjD2ZswhSLR5dLe
         WgbeSRYIHHl6akaEglgpSnEF4pevEbvP3cRVpYdFF0jDWc7BpyUVluQ7dZC/RmMZzn2S
         CXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695840423; x=1696445223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGsoS6S76d+wc39dHVr5d6LqZuXhI4/2gCLnqm1TcHs=;
        b=JqiHbM6ljvTE/PaSDPW6iFYDaDPV/HwQ9rqydNR0Y9bHzkGY09KY8Wm6Jf2ItCFZU1
         pqnbWerwnKFqpoyfMQ3rfRuCLAGL4Dcruidpb4/veZ5fmgTSgr/KHIZugM4DcJnIl9zR
         VUMfIM4Bdz1g5vHn81WYMoYfKomMmpfK1Lk6KUQ6rX5+YIyBIZAyHIRuZNhPFJlz5c6L
         xAdHJi4YuXuLX5w2tt076zqoVFmXnNoP4jLCWbfrL/YfH61yjmHXwtUO3rDUU5X5Um/E
         ius1QlvTFiY5tLz6FC91w+g8KoOX59VkebbCFG5Bct02+P17jk3icM6vOVCHnMvfbzft
         cpig==
X-Gm-Message-State: AOJu0YxvuAe8vyZNWGGFtwA5+2YgPhuS3AA3MrK61yZkrkSFfYBluCqE
        5njqhDbqliLFb5saNowDiGNfmw==
X-Google-Smtp-Source: AGHT+IG7+8cNxtjYaW8DLvuAzwkpFnOPp3GRgfoPosS/SSNgOQZqBfvWW6vOfnDQFgGdZtkac5nPfA==
X-Received: by 2002:a05:620a:8325:b0:774:2893:3f25 with SMTP id pa37-20020a05620a832500b0077428933f25mr2602290qkn.25.1695840423687;
        Wed, 27 Sep 2023 11:47:03 -0700 (PDT)
Received: from localhost.localdomain ([50.212.55.89])
        by smtp.gmail.com with ESMTPSA id d8-20020ac81188000000b00411fcc18cc1sm5522232qtj.64.2023.09.27.11.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 11:47:03 -0700 (PDT)
From:   Ben Wolsieffer <ben.wolsieffer@hefring.com>
To:     linux-stm32@st-md-mailman.stormreply.com,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Yann Gautier <yann.gautier@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
Subject: [PATCH] mmc: mmci: use peripheral flow control for STM32
Date:   Wed, 27 Sep 2023 14:45:56 -0400
Message-ID: <20230927184556.1422122-1-ben.wolsieffer@hefring.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>

The STM32 SDMMC peripheral (at least for the STM32F429, STM32F469 and
STM32F746, which are all the currently supported devices using periphid
0x00880180) requires DMA to be performed in peripheral flow controller
mode. From the STM32F74/5 reference manual, section 35.3.2:

"SDMMC host allows only to use the DMA in peripheral flow controller
mode. DMA stream used to serve SDMMC must be configured in peripheral
flow controller mode"

This patch adds a variant option to control peripheral flow control and
enables it for the STM32 variant.

Signed-off-by: Ben Wolsieffer <Ben.Wolsieffer@hefring.com>
---
 drivers/mmc/host/mmci.c | 3 ++-
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 769b34afa835..90e32f18abbc 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -249,6 +249,7 @@ static struct variant_data variant_stm32 = {
 	.f_max			= 48000000,
 	.pwrreg_clkgate		= true,
 	.pwrreg_nopower		= true,
+	.dma_flow_controller	= true,
 	.init			= mmci_variant_init,
 };
 
@@ -1012,7 +1013,7 @@ static int _mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 		.dst_addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES,
 		.src_maxburst = variant->fifohalfsize >> 2, /* # of words */
 		.dst_maxburst = variant->fifohalfsize >> 2, /* # of words */
-		.device_fc = false,
+		.device_fc = variant->dma_flow_controller,
 	};
 	struct dma_chan *chan;
 	struct dma_device *device;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 253197f132fc..9a81f30f6748 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -332,6 +332,7 @@ enum mmci_busy_state {
  * @opendrain: bitmask identifying the OPENDRAIN bit inside MMCIPOWER register
  * @dma_lli: true if variant has dma link list feature.
  * @stm32_idmabsize_mask: stm32 sdmmc idma buffer size.
+ * @dma_flow_controller: use peripheral as flow controller for DMA.
  */
 struct variant_data {
 	unsigned int		clkreg;
@@ -378,6 +379,7 @@ struct variant_data {
 	u8			dma_lli:1;
 	u32			stm32_idmabsize_mask;
 	u32			stm32_idmabsize_align;
+	u8			dma_flow_controller:1;
 	void (*init)(struct mmci_host *host);
 };
 
-- 
2.42.0

