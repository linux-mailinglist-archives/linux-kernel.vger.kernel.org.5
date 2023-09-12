Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBDC979D3CE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235951AbjILOex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236033AbjILOeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:34:46 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7688CCC;
        Tue, 12 Sep 2023 07:34:42 -0700 (PDT)
Received: from dslb-178-004-201-190.178.004.pools.vodafone-ip.de ([178.4.201.190] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qg4TQ-0005wr-0k; Tue, 12 Sep 2023 16:34:40 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 1/2] hwrng: imx-rngc - reasonable timeout for selftest
Date:   Tue, 12 Sep 2023 16:31:17 +0200
Message-Id: <20230912143117.55965-2-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912143117.55965-1-martin@kaiser.cx>
References: <20230912143117.55965-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a more reasonable timeout for the rngc selftest.

According to the reference manual, "The self test takes approximately
29,000 cycles to complete." The lowest possible frequency of the rngc
peripheral clock is 33.25MHz, the selftest would then take about 872us.

2.5ms should be enough for the selftest timeout.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index e4b385b01b11..127c292dfbbf 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -53,6 +53,7 @@
 
 #define RNGC_TIMEOUT  3000 /* 3 sec */
 
+#define RNGC_SELFTEST_TIMEOUT 2500 /* us */
 
 static bool self_test = true;
 module_param(self_test, bool, 0);
@@ -110,7 +111,8 @@ static int imx_rngc_self_test(struct imx_rngc *rngc)
 	cmd = readl(rngc->base + RNGC_COMMAND);
 	writel(cmd | RNGC_CMD_SELF_TEST, rngc->base + RNGC_COMMAND);
 
-	ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
+	ret = wait_for_completion_timeout(&rngc->rng_op_done,
+					  usecs_to_jiffies(RNGC_SELFTEST_TIMEOUT));
 	imx_rngc_irq_mask_clear(rngc);
 	if (!ret)
 		return -ETIMEDOUT;
-- 
2.39.2

