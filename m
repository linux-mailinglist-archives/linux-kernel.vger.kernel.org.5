Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511747B7880
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241372AbjJDHQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjJDHQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:16:47 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [71.19.156.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E5AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:16:43 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id DAF71DD9;
        Wed,  4 Oct 2023 00:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1696403803;
        bh=yFCKItcXGPE1Q+oFb43qALwVs7ooi/Pj1fioqFcF6gw=;
        h=From:To:Cc:Subject:Date:From;
        b=hadfSUMfsGJ2vkIP/x8ARWUdzgF/1O22W2p3kl7aFETYKCgQYjqWYD8dd+u5IMAAb
         QwIJfiO2YOrAUYq9LkkngRKjaINpWN+x9ECkRf7URPtuomY/zTeiNAxm2O2wvooZcE
         b7E7qQkbbCzfQW+29dD3HVZmiKypiBPXXo7HwIbY=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: aspeed: Allow changing hardware strap defaults
Date:   Wed,  4 Oct 2023 00:16:06 -0700
Message-ID: <20231004071605.21323-2-zev@bewilderbeest.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously we've generally assumed that the defaults in the hardware
strapping register are in fact appropriate for the system and thus
have avoided making any changes to its contents (with the exception of
the bits controlling the GPIO passthrough feature).

Unfortunately, on some platforms corrections from software are
required as the hardware strapping is simply incorrect for the system
(such as the SPI1 interface being configured for passthrough mode when
master mode is in fact the only useful configuration for it).  We thus
remove the checks preventing changes to the strap register so that the
pinctrl subsystem can be used for such corrections.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---
 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 21 ---------------------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 21 ---------------------
 drivers/pinctrl/aspeed/pinmux-aspeed.h     |  3 ---
 3 files changed, 45 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index bfed0e274643..7ecfe3e4280e 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2556,27 +2556,6 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		if (!ctx->maps[desc->ip])
 			return -ENODEV;
 
-		/*
-		 * Strap registers are configured in hardware or by early-boot
-		 * firmware. Treat them as read-only despite that we can write
-		 * them. This may mean that certain functions cannot be
-		 * deconfigured and is the reason we re-evaluate after writing
-		 * all descriptor bits.
-		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
-		 */
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
-			continue;
-
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-			continue;
-
 		ret = regmap_update_bits(ctx->maps[desc->ip], desc->reg,
 					 desc->mask, val);
 
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 4c0d26606b6c..3e57e76c2eb7 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2735,27 +2735,6 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 			return PTR_ERR(map);
 		}
 
-		/*
-		 * Strap registers are configured in hardware or by early-boot
-		 * firmware. Treat them as read-only despite that we can write
-		 * them. This may mean that certain functions cannot be
-		 * deconfigured and is the reason we re-evaluate after writing
-		 * all descriptor bits.
-		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
-		 */
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
-			continue;
-
-		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-			continue;
-
 		/* On AST2500, Set bits in SCU70 are cleared from SCU7C */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1) {
 			u32 value = ~val & desc->mask;
diff --git a/drivers/pinctrl/aspeed/pinmux-aspeed.h b/drivers/pinctrl/aspeed/pinmux-aspeed.h
index aaa78a613196..e9068acd5879 100644
--- a/drivers/pinctrl/aspeed/pinmux-aspeed.h
+++ b/drivers/pinctrl/aspeed/pinmux-aspeed.h
@@ -16,9 +16,6 @@
  * bits. Some difficulty arises as the pin's function bit masks for each
  * priority level are frequently not the same (i.e. cannot just flip a bit to
  * change from a high to low priority signal), or even in the same register.
- * Further, not all signals can be unmuxed, as some expressions depend on
- * values in the hardware strapping register (which may be treated as
- * read-only).
  *
  * SoC Multi-function Pin Expression Examples
  * ------------------------------------------
-- 
2.42.0

