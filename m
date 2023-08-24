Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1B0787876
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 21:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbjHXTYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 15:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243164AbjHXTXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 15:23:51 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB731BEB;
        Thu, 24 Aug 2023 12:23:48 -0700 (PDT)
Received: from dslb-188-097-211-187.188.097.pools.vodafone-ip.de ([188.97.211.187] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qZFvj-00036P-5D; Thu, 24 Aug 2023 21:23:43 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2 2/6] hwrng: imx-rngc - reasonable timeout for initial seed
Date:   Thu, 24 Aug 2023 21:20:55 +0200
Message-Id: <20230824192059.1569591-3-martin@kaiser.cx>
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

Set a more reasonable timeout for calculating the initial seed.

The reference manuals says that "The initial seed takes approximately
2,000,000 clock cycles." If the rngc peripheral clock runs at 66.5MHz,
this is approx. 30ms.

A timeout of 100ms is more appropriate that the current value of 3
seconds. We define the timeout in us to simplify the transition to
readl_poll_timeout.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
- adjust timeouts before we switch to polling

 drivers/char/hw_random/imx-rngc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 6024c923b67d..8ff3d46674fd 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -51,9 +51,8 @@
 
 #define RNGC_ERROR_STATUS_STAT_ERR	0x00000008
 
-#define RNGC_TIMEOUT  3000 /* 3 sec */
-
-#define RNGC_SELFTEST_TIMEOUT 1500 /* us */
+#define RNGC_SELFTEST_TIMEOUT   1500 /* us */
+#define RNGC_SEED_TIMEOUT     100000 /* us */
 
 static bool self_test = true;
 module_param(self_test, bool, 0);
@@ -184,7 +183,8 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
+		ret = wait_for_completion_timeout(&rngc->rng_op_done,
+						  usecs_to_jiffies(RNGC_SEED_TIMEOUT));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			goto err;
-- 
2.39.2

