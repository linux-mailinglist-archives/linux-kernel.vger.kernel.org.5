Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1023E79D3D0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 16:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236067AbjILOe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 10:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236047AbjILOeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 10:34:50 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B12CC3;
        Tue, 12 Sep 2023 07:34:46 -0700 (PDT)
Received: from dslb-178-004-201-190.178.004.pools.vodafone-ip.de ([178.4.201.190] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <martin@kaiser.cx>)
        id 1qg4TU-0005wr-LB; Tue, 12 Sep 2023 16:34:44 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 2/2] hwrng: imx-rngc - reasonable timeout for initial seed
Date:   Tue, 12 Sep 2023 16:31:18 +0200
Message-Id: <20230912143117.55965-3-martin@kaiser.cx>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912143117.55965-1-martin@kaiser.cx>
References: <20230912143117.55965-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set a more reasonable timeout for calculating the initial seed.

The reference manuals says that "The initial seed takes approximately
2,000,000 clock cycles." The rngc peripheral clock runs at >= 33.25MHz,
so seeding takes at most 60ms.

A timeout of 200ms is more appropriate than the current value of 3
seconds.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 drivers/char/hw_random/imx-rngc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/imx-rngc.c b/drivers/char/hw_random/imx-rngc.c
index 127c292dfbbf..118a72acb99b 100644
--- a/drivers/char/hw_random/imx-rngc.c
+++ b/drivers/char/hw_random/imx-rngc.c
@@ -51,9 +51,8 @@
 
 #define RNGC_ERROR_STATUS_STAT_ERR	0x00000008
 
-#define RNGC_TIMEOUT  3000 /* 3 sec */
-
 #define RNGC_SELFTEST_TIMEOUT 2500 /* us */
+#define RNGC_SEED_TIMEOUT      200 /* ms */
 
 static bool self_test = true;
 module_param(self_test, bool, 0);
@@ -184,7 +183,8 @@ static int imx_rngc_init(struct hwrng *rng)
 		cmd = readl(rngc->base + RNGC_COMMAND);
 		writel(cmd | RNGC_CMD_SEED, rngc->base + RNGC_COMMAND);
 
-		ret = wait_for_completion_timeout(&rngc->rng_op_done, msecs_to_jiffies(RNGC_TIMEOUT));
+		ret = wait_for_completion_timeout(&rngc->rng_op_done,
+						  msecs_to_jiffies(RNGC_SEED_TIMEOUT));
 		if (!ret) {
 			ret = -ETIMEDOUT;
 			goto err;
-- 
2.39.2

