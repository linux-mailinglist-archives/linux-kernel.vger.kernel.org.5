Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10747EEFAA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 11:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345824AbjKQKEP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 05:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjKQKEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 05:04:12 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B6AD;
        Fri, 17 Nov 2023 02:04:08 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B02BFFF80F;
        Fri, 17 Nov 2023 10:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1700215447;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FAldIdFOcM6TSQgoc+utZ58ITzn88qsDQysRSDWf7aE=;
        b=CWRbqMYkcicpcthfaTaZUOscd6Wt623MOsiQdZmUgWhnIc1T6SfQvhnfkr9w3z6sXRvzZg
        +jSHd2ucjSFwLUtWTWNGpsEnB4irS2FCwHUNlJP6teX085KkgGMNBUVjMvxFIR565ru+la
        /pdox0q4vBvNZsO9cPSteGHeJrfRWfEQEnVAhODfmwHcOo2ePeGqoeYYB7xoGCz4QHFiBK
        gCm8GgfaA4CSOPTPjURP8gquTjdy8KBee5gEgBO55CaMj5ckVon35OBdD8YGy4cgr0WlL5
        7Smf8QWcZf/zm6gSKw07/HBe6OQ5Y0RoccMolikPqPVtcjPnnIgJbkIqnxK4bw==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Fri, 17 Nov 2023 11:03:50 +0100
Subject: [PATCH v6 2/6] dmaengine: dw-edma: Fix wrong interrupt bit set for
 HDMA
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231117-b4-feature_hdma_mainline-v6-2-ebf7aa0e40d7@bootlin.com>
References: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
In-Reply-To: <20231117-b4-feature_hdma_mainline-v6-0-ebf7aa0e40d7@bootlin.com>
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
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of setting HDMA_V0_LOCAL_ABORT_INT_EN bit, HDMA_V0_LOCAL_STOP_INT_EN
bit got set twice, due to which the abort interrupt is not getting generated for
HDMA. Fix it by setting the correct interrupt enable bit.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---

Changes in v3:
- Split the patch in two to differ bug fix and simple harmless typo.

Changes in v6:
- Update commit message
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 1f4cb7db5475..108f9127aaaa 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -236,7 +236,7 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		/* Interrupt enable&unmask - done, abort */
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
-		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_STOP_INT_EN;
+		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1

