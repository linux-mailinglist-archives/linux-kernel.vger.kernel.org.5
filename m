Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44F28784579
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237071AbjHVP2h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232678AbjHVP2h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 11:28:37 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3588CD8;
        Tue, 22 Aug 2023 08:28:35 -0700 (PDT)
Received: from pd956d63d.dip0.t-ipconnect.de ([217.86.214.61] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qYTJ3-0006li-UF; Tue, 22 Aug 2023 17:28:34 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/3] hwrng: imx-rngc - use polling to detect end of self test
Date:   Tue, 22 Aug 2023 17:25:51 +0200
Message-Id: <20230822152553.190858-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230822152553.190858-1-martin@kaiser.cx>
References: <20230822152553.190858-1-martin@kaiser.cx>
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

Active waiting is no disadvantage here. The self test is run during
probe, there's nothing we could do in parallel at this time.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index e4b385b01b11..85207535fd12 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -17,6 +17,7 @@
 #include <linux/hw_random.h>
 #include <linux/completion.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/bitfield.h>
 
 #define RNGC_VER_ID			0x0000
@@ -101,21 +102,19 @@ static inline void imx_rngc_irq_unmask(struct imx_rngc *rngc)
 
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
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
-	imx_rngc_irq_mask_clear(rngc);
-	if (!ret)
-		return -ETIMEDOUT;
+	ret = readl_poll_timeout(rngc->base + RNGC_STATUS, status,
+				 status & RNGC_STATUS_ST_DONE, 1000, RNGC_TIMEOUT * 1000);
+	if (ret < 0)
+		return ret;
 
-	return rngc->err_reg ? -EIO : 0;
+	return readl(rngc->base + RNGC_ERROR) ? -EIO : 0;
 }
 
 static int imx_rngc_read(struct hwrng *rng, void *data, size_t max, bool wait)
-- 
2.39.2

