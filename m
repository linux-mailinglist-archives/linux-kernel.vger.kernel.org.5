Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4427BC169
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 23:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbjJFVny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 17:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjJFVnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 17:43:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E41BE;
        Fri,  6 Oct 2023 14:43:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E698C433C8;
        Fri,  6 Oct 2023 21:43:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696628630;
        bh=JxKvTUqfP6X/thRxp0Sb58Y81IsFbCSSCaPiysJgstc=;
        h=From:To:Cc:Subject:Date:From;
        b=LhFD1pSzwcoyLl85ZonWuOjB1KhaBmVEOgnb47R4hiNxz94poqXgpgWkib513rpw6
         pVC/EhJLj6eBsph2dD/wZlPtVmxyBVJnm1O+chHjuGABKiW9NhQcARcNSxAOFrAGAm
         IYUOZMz4qc+JNqdRbC3GcyPKMmL/vat6PMccQNPkaZfGHh9xbAX1cCDO02A2nDWbmC
         J9r0GK+E4mCUDmG8A6hTvBw3Q+4KimdWtX6IwtsqNUWYRoq3dRla6PTDXnCx2D/7LX
         8nYvreOxjLs57esLH2iK/1z/G+aRso4ay2klkJ76NCFO/qWyxASIsVcb3RT1MPprvY
         RjfM46TkTPmSg==
Received: (nullmailer pid 338802 invoked by uid 1000);
        Fri, 06 Oct 2023 21:43:49 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwrng: n2: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 16:43:40 -0500
Message-Id: <20231006214340.338620-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/char/hw_random/n2-drv.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/char/hw_random/n2-drv.c b/drivers/char/hw_random/n2-drv.c
index 73e408146420..aaae16b98475 100644
--- a/drivers/char/hw_random/n2-drv.c
+++ b/drivers/char/hw_random/n2-drv.c
@@ -14,7 +14,8 @@
 #include <linux/hw_random.h>
 
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 
 #include <asm/hypervisor.h>
 
@@ -695,20 +696,15 @@ static void n2rng_driver_version(void)
 static const struct of_device_id n2rng_match[];
 static int n2rng_probe(struct platform_device *op)
 {
-	const struct of_device_id *match;
 	int err = -ENOMEM;
 	struct n2rng *np;
 
-	match = of_match_device(n2rng_match, &op->dev);
-	if (!match)
-		return -EINVAL;
-
 	n2rng_driver_version();
 	np = devm_kzalloc(&op->dev, sizeof(*np), GFP_KERNEL);
 	if (!np)
 		goto out;
 	np->op = op;
-	np->data = (struct n2rng_template *)match->data;
+	np->data = (struct n2rng_template *)device_get_match_data(&op->dev);
 
 	INIT_DELAYED_WORK(&np->work, n2rng_work);
 
-- 
2.40.1

