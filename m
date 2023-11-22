Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C697F4A5F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344366AbjKVPci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:32:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344260AbjKVPcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:32:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BF6DD53;
        Wed, 22 Nov 2023 07:32:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC25AC433CC;
        Wed, 22 Nov 2023 15:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700667149;
        bh=Vke/WsVUVdJfzO3oG5YqlpUBQ/G44MKFPXW5jDOVGBM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KKVL98SnNQuRB63QjXW0y6l8J0ukXcSIFKUkBaR2A8CAzGULLbtPqTdRPKBm7ddwa
         3qIWH1kQLAeSkb8Ie/MIbi3hQAsXvyiXYgkMAqdqvNDMvBPYRRcxDfFBqp4OBI2xnx
         IEMr3hdoHOLvCNfp1kn+0V65aocB41S47vHhVuTVSKTuNs/z8VfIaWHYBHcIBnitmQ
         F77cMv7k0w8Nu9ULH2vKuKdJ0x6hTDL34VOmfZ3KOFBlbGwII0mF/C2UYeFiipd0cO
         cHvZtAEPC+xQk+54c09y5gQp6Mhou2OGopQy9TYfqN6HHD6cq32aZGxKjItR2buRd6
         PryH6tEpMv5PA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samuel Holland <samuel.holland@sifive.com>,
        Peter Korsgaard <peter@korsgaard.com>,
        Andi Shyti <andi.shyti@kernel.org>,
        Wolfram Sang <wsa@kernel.org>, Sasha Levin <sashal@kernel.org>,
        andrew@lunn.ch, linux-i2c@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 05/17] i2c: ocores: Move system PM hooks to the NOIRQ phase
Date:   Wed, 22 Nov 2023 10:31:34 -0500
Message-ID: <20231122153212.852040-5-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231122153212.852040-1-sashal@kernel.org>
References: <20231122153212.852040-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.2
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel.holland@sifive.com>

[ Upstream commit 382561d16854a747e6df71034da08d20d6013dfe ]

When an I2C device contains a wake IRQ subordinate to a regmap-irq chip,
the regmap-irq code must be able to perform I2C transactions during
suspend_device_irqs() and resume_device_irqs(). Therefore, the bus must
be suspended/resumed during the NOIRQ phase.

Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
Acked-by: Peter Korsgaard <peter@korsgaard.com>
Reviewed-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-ocores.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-ocores.c b/drivers/i2c/busses/i2c-ocores.c
index 041a76f71a49c..e106af83cef4d 100644
--- a/drivers/i2c/busses/i2c-ocores.c
+++ b/drivers/i2c/busses/i2c-ocores.c
@@ -771,8 +771,8 @@ static int ocores_i2c_resume(struct device *dev)
 	return ocores_init(dev, i2c);
 }
 
-static DEFINE_SIMPLE_DEV_PM_OPS(ocores_i2c_pm,
-				ocores_i2c_suspend, ocores_i2c_resume);
+static DEFINE_NOIRQ_DEV_PM_OPS(ocores_i2c_pm,
+			       ocores_i2c_suspend, ocores_i2c_resume);
 
 static struct platform_driver ocores_i2c_driver = {
 	.probe   = ocores_i2c_probe,
-- 
2.42.0

