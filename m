Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAEA8035E8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 15:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344946AbjLDOEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 09:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344944AbjLDOEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 09:04:32 -0500
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED6106;
        Mon,  4 Dec 2023 06:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1701698645;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EauQ2wrK+wrLp0dftTWFW30qJjPlPW+KVuBL537ybvE=;
        b=sqhSiRUnlnoXtZWveiRp1jISoIWmyTlvKkcLmp5C07pvU84zyl6Q7NTsW13auL+QliM2WW
        9dKbELEL5y50o0nee7w61mwRwS8281vbiyKKMzADxg67OuPkfkADEvvCZGd3aM7S9YYVvl
        ZgkPq4XbNTsdIdVtknno/FA3aKeaRoY=
From:   Paul Cercueil <paul@crapouillou.net>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <noname.nuno@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH 4/4] dmaengine: axi-dmac: Use only EOT interrupts when doing scatter-gather
Date:   Mon,  4 Dec 2023 15:03:52 +0100
Message-ID: <20231204140352.30420-5-paul@crapouillou.net>
In-Reply-To: <20231204140352.30420-1-paul@crapouillou.net>
References: <20231204140352.30420-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of notifying userspace in the end-of-transfer (EOT) interrupt
and program the hardware in the start-of-transfer (SOT) interrupt, we
can do both things in the EOT, allowing us to mask the SOT, and halve
the number of interrupts sent by the HDL core.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/dma/dma-axi-dmac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index 5109530b66de..beed91a8238c 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -415,6 +415,7 @@ static bool axi_dmac_transfer_done(struct axi_dmac_chan *chan,
 			list_del(&active->vdesc.node);
 			vchan_cookie_complete(&active->vdesc);
 			active = axi_dmac_active_desc(chan);
+			start_next = !!active;
 		}
 	} else {
 		do {
@@ -1000,6 +1001,7 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	struct axi_dmac *dmac;
 	struct regmap *regmap;
 	unsigned int version;
+	u32 irq_mask = 0;
 	int ret;
 
 	dmac = devm_kzalloc(&pdev->dev, sizeof(*dmac), GFP_KERNEL);
@@ -1067,7 +1069,10 @@ static int axi_dmac_probe(struct platform_device *pdev)
 
 	dma_dev->copy_align = (dmac->chan.address_align_mask + 1);
 
-	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, 0x00);
+	if (dmac->chan.hw_sg)
+		irq_mask |= AXI_DMAC_IRQ_SOT;
+
+	axi_dmac_write(dmac, AXI_DMAC_REG_IRQ_MASK, irq_mask);
 
 	if (of_dma_is_coherent(pdev->dev.of_node)) {
 		ret = axi_dmac_read(dmac, AXI_DMAC_REG_COHERENCY_DESC);
-- 
2.42.0

