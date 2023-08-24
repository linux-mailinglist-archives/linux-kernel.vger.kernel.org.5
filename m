Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C9478786F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243172AbjHXTYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243158AbjHXTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:23:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFBBF1BEC;
        Thu, 24 Aug 2023 12:23:48 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZFvj-00036P-Ud; Thu, 24 Aug 2023 21:23:44 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 3/6] hwrng: imx-rngc - use polling to detect end of self test
Date:   Thu, 24 Aug 2023 21:20:56 +0200
Message-Id: <20230824192059.1569591-4-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230824192059.1569591-1-martin@kaiser.cx>
References: <20230824192059.1569591-1-martin@kaiser.cx>
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

Use polling to detect the end of the rngc self test. This is much simpler
than using an interrupt and a completion.

The selftest should take approx. 450us. Keep the overhead to a minimum
by polling every 500us. (We've already lowered the timeout to 1.5ms.)

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- use shorter timeout and polling interval

 drivers/char/hw_random/imx-rngc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 8ff3d46674fd..09523936d2af 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -17,6 +17,7 @@
 #include <linux/hw_random.h>
 #include <linux/completion.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/bitfield.h>
 
 #define RNGC_VER_ID			0x0000
@@ -101,22 +102,19 @@ static inline void imx_rngc_irq_unmask(struct imx_rngc *rngc)
 
 static int imx_rngc_self_test(struct imx_rngc *rngc)
 {
-	u32 cmd;
+	u32 cmd, status;
 	int ret;
 
-	imx_rngc_irq_unmask(rngc);
-
 	/* run self test */
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done,
-					  usecs_to_jiffies(RNGC_SELFTEST_TIMEOUT));
-	imx_rngc_irq_mask_clear(rngc);
-	if (!ret)
-		return -ETIMEDOUT;
+	ret = readl_poll_timeout(rngc->base + RNGC_STATUS, status,
+				 status & RNGC_STATUS_ST_DONE, 500, RNGC_SELFTEST_TIMEOUT);
+	if (ret < 0)
+		return ret;
 
-	return rngc->err_reg ? -EIO : 0;
+	return readl(rngc->base + RNGC_ERROR) ? -EIO : 0;
 }
 
 static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
-- 
2.39.2

