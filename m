Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C633A7EB2C7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233525AbjKNOwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbjKNOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:52:10 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 072B6122;
        Tue, 14 Nov 2023 06:52:05 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3735E240016;
        Tue, 14 Nov 2023 14:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699973524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MG/EpR8bVcQceln2f1UmgAvAjO7ip8LLXAJEWchyMuQ=;
        b=l5h/4CDAZVV5CoIlDpdVV6jLbP0J4DWNgbBA/qnRgpSxqda1WfnLl89euNEhdfwBUDOMG3
        aPgSR8ubD1TvbGfsz39HZSrz9yfmAsikpDgdfuKdhHl+VNQIQ0aXJzaRWVqSiaO6+ZdGGp
        O9kQkY47IV3NUClmmX5kT5yKEnGhDL86YksknaXDT6DwQJcRjd+WjSa8PKhv9ph3NvkPlB
        CkSqSnRn7VzmxYL50NNdmLY6doiLojnqor7609PKi9yK2k8iK1IkZGEkQsXTOOiYKdcULO
        AN4AvYud2IaxP2Kj0O8uIG5oJhOF7RVgMfOMby5TPp/dGHZcf9qfHNVUZKj1nw==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 15:51:54 +0100
Subject: [PATCH v5 1/6] dmaengine: dw-edma: Fix the ch_count hdma callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-feature_hdma_mainline-v5-1-7bc86d83c6f7@bootlin.com>
References: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
In-Reply-To: <20231114-b4-feature_hdma_mainline-v5-0-7bc86d83c6f7@bootlin.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Cai Huoqing <cai.huoqing@linux.dev>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Herve Codina <herve.codina@bootlin.com>,
        Kory Maincent <kory.maincent@bootlin.com>,
        Manivannan Sadhasivam <mani@kernel.org>
X-Mailer: b4 0.12.4
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current check of ch_en enabled to know the maximum number of available
hardware channels is wrong as it check the number of ch_en register set
but all of them are unset at probe. This register is set at the
dw_hdma_v0_core_start function which is run lately before a DMA transfer.

The HDMA IP have no way to know the number of hardware channels available
like the eDMA IP, then let set it to maximum channels and let the platform
set the right number of channels.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

See the following thread mail that talk about this issue:
https://lore.kernel.org/lkml/20230607095832.6d6b1a73@kmaincent-XPS-13-7390/

Changes in v2:
- Add comment

Changes in v3:
- Fix comment style.
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 00b735a0202a..1f4cb7db5475 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -65,18 +65,12 @@ static void dw_hdma_v0_core_off(struct dw_edma *dw)
 
 static u16 dw_hdma_v0_core_ch_count(struct dw_edma *dw, enum dw_edma_dir dir)
 {
-	u32 num_ch = 0;
-	int id;
-
-	for (id = 0; id < HDMA_V0_MAX_NR_CH; id++) {
-		if (GET_CH_32(dw, id, dir, ch_en) & BIT(0))
-			num_ch++;
-	}
-
-	if (num_ch > HDMA_V0_MAX_NR_CH)
-		num_ch = HDMA_V0_MAX_NR_CH;
-
-	return (u16)num_ch;
+	/*
+	 * The HDMA IP have no way to know the number of hardware channels
+	 * available, we set it to maximum channels and let the platform
+	 * set the right number of channels.
+	 */
+	return HDMA_V0_MAX_NR_CH;
 }
 
 static enum dma_status dw_hdma_v0_core_ch_status(struct dw_edma_chan *chan)

-- 
2.25.1

