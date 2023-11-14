Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D63C7EB2CE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 15:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233534AbjKNOwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 09:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233490AbjKNOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 09:52:10 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F603CA;
        Tue, 14 Nov 2023 06:52:07 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9D8CC24001A;
        Tue, 14 Nov 2023 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699973526;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=svngh7gavoOsAoTd14KvI+aVm1JHod9n5Mvh72UXNZY=;
        b=l093DY4tY3uYI0h8I8HZT0q/eiUFB7NuJDDOQ8GuICv7vwFR5tDyIfaJCHrndUqkgXHBTW
        /Vra+Ug2i9GUHE/tyxWKJVHao/NfRCnQNu3L9Nm6YmFiDGKHZuImP3+zFB82qDaThoiRX3
        2zdp4Gcf8OMYREUS6RQwITSrPrcL9aQJkCnEKwKPgmQ3xzZbU3x2XIzS26emBQ6xXWsNc3
        IRkC9VUTojkXiifW+1RtQipJd1CkZpYLuMkS7kzZrTNoJRJv+wX6gu6tkPDl8FZ7Ynskzf
        Bx53oQxWb1PxzhVFMGPA6XGqLmmtUEUO4ncriX2cV7oTYxNc7VuPZhJyd1TQKg==
From:   Kory Maincent <kory.maincent@bootlin.com>
Date:   Tue, 14 Nov 2023 15:51:57 +0100
Subject: [PATCH v5 4/6] dmaengine: dw-edma: Add HDMA remote interrupt
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231114-b4-feature_hdma_mainline-v5-4-7bc86d83c6f7@bootlin.com>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only the local interruption was configured, remote interrupt was left
behind. This patch fix it by setting stop and abort remote interrupts when
the DW_EDMA_CHIP_LOCAL flag is not set.

Fixes: e74c39573d35 ("dmaengine: dw-edma: Add support for native HDMA")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/dma/dw-edma/dw-hdma-v0-core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-hdma-v0-core.c b/drivers/dma/dw-edma/dw-hdma-v0-core.c
index 108f9127aaaa..04b0bcb6ded9 100644
--- a/drivers/dma/dw-edma/dw-hdma-v0-core.c
+++ b/drivers/dma/dw-edma/dw-hdma-v0-core.c
@@ -237,6 +237,8 @@ static void dw_hdma_v0_core_start(struct dw_edma_chunk *chunk, bool first)
 		tmp = GET_CH_32(dw, chan->dir, chan->id, int_setup) |
 		      HDMA_V0_STOP_INT_MASK | HDMA_V0_ABORT_INT_MASK |
 		      HDMA_V0_LOCAL_STOP_INT_EN | HDMA_V0_LOCAL_ABORT_INT_EN;
+		if (!(dw->chip->flags & DW_EDMA_CHIP_LOCAL))
+			tmp |= HDMA_V0_REMOTE_STOP_INT_EN | HDMA_V0_REMOTE_ABORT_INT_EN;
 		SET_CH_32(dw, chan->dir, chan->id, int_setup, tmp);
 		/* Channel control */
 		SET_CH_32(dw, chan->dir, chan->id, control1, HDMA_V0_LINKLIST_EN);

-- 
2.25.1

