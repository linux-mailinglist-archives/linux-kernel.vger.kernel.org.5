Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECC27BA51C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241256AbjJEQNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240959AbjJEQMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:12:20 -0400
Received: from thorn.bewilderbeest.net (thorn.bewilderbeest.net [IPv6:2605:2700:0:5::4713:9cab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658C910D3;
        Wed,  4 Oct 2023 20:09:06 -0700 (PDT)
Received: from hatter.bewilderbeest.net (unknown [IPv6:2602:61:7e5d:5300::2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: zev)
        by thorn.bewilderbeest.net (Postfix) with ESMTPSA id 5DDAE224;
        Wed,  4 Oct 2023 20:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bewilderbeest.net;
        s=thorn; t=1696475343;
        bh=jhW/GPSan/u14E5ed+1vqJkRblZ4OlBm+NkX/QKFAVY=;
        h=From:To:Cc:Subject:Date:From;
        b=cN/CuYrP1UDn3bJhJ7G8Di0ztdAFDtjbcP3bpeecFQ01bwwnxIertZ5eLxUFNqXwM
         EYBalbsSMgxxMG9pzSsl6yFMqFmgE78XfOVuOXBnROZCnmGLevKW5pVOuw1ZNIOcc5
         Jci94/J1+ZzoQ3UXA0Vr5K5D4v++GqR6G8ZB2fYc=
From:   Zev Weiss <zev@bewilderbeest.net>
To:     Andrew Jeffery <andrew@codeconstruct.com.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Joel Stanley <joel@jms.id.au>, linux-aspeed@lists.ozlabs.org
Cc:     Zev Weiss <zev@bewilderbeest.net>, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] pinctrl: aspeed: Allow changing SPI mode from hardware strap defaults
Date:   Wed,  4 Oct 2023 20:08:50 -0700
Message-ID: <20231005030849.11352-2-zev@bewilderbeest.net>
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

Some platforms unfortunately have their SPI mode selection bits
strapped incorrectly (such as being configured for passthrough mode
when master mode is in fact the only useful configuration for it) and
thus require correction in software.  Add the SPI mode bits to the
GPIO passthrough bits as the exceptions to the read-only rule for the
hardware strap register so that the pinctrl subsystem can be used for
such corrections.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
---

Changes since v1 [1]:
 - Refined to an additional per-bit exception instead of allowing
   arbitrary strap register alterations [Andrew]

[1] https://lore.kernel.org/lkml/20231004071605.21323-2-zev@bewilderbeest.net/

 drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c | 19 ++++++++++++-------
 drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c | 19 ++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
index bfed0e274643..774f8d05142f 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g4.c
@@ -2563,15 +2563,20 @@ static int aspeed_g4_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		 * deconfigured and is the reason we re-evaluate after writing
 		 * all descriptor bits.
 		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
+		 * We make two exceptions to the read-only rule:
+		 *
+		 * - The passthrough mode of GPIO ports D and E are commonly
+		 *   used with front-panel buttons to allow normal operation
+		 *   of the host if the BMC is powered off or fails to boot.
+		 *   Once the BMC has booted, the loopback mode must be
+		 *   disabled for the BMC to control host power-on and reset.
+		 *
+		 * - The operating mode of the SPI1 interface is simply
+		 *   strapped incorrectly on some systems and requires a
+		 *   software fixup, which we allow to be done via pinctrl.
 		 */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
+		    !(desc->mask & (BIT(22) | BIT(21) | BIT(13) | BIT(12))))
 			continue;
 
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
diff --git a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
index 4c0d26606b6c..5bb8fd0d1e41 100644
--- a/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
+++ b/drivers/pinctrl/aspeed/pinctrl-aspeed-g5.c
@@ -2742,15 +2742,20 @@ static int aspeed_g5_sig_expr_set(struct aspeed_pinmux_data *ctx,
 		 * deconfigured and is the reason we re-evaluate after writing
 		 * all descriptor bits.
 		 *
-		 * Port D and port E GPIO loopback modes are the only exception
-		 * as those are commonly used with front-panel buttons to allow
-		 * normal operation of the host when the BMC is powered off or
-		 * fails to boot. Once the BMC has booted, the loopback mode
-		 * must be disabled for the BMC to control host power-on and
-		 * reset.
+		 * We make two exceptions to the read-only rule:
+		 *
+		 * - The passthrough mode of GPIO ports D and E are commonly
+		 *   used with front-panel buttons to allow normal operation
+		 *   of the host if the BMC is powered off or fails to boot.
+		 *   Once the BMC has booted, the loopback mode must be
+		 *   disabled for the BMC to control host power-on and reset.
+		 *
+		 * - The operating mode of the SPI1 interface is simply
+		 *   strapped incorrectly on some systems and requires a
+		 *   software fixup, which we allow to be done via pinctrl.
 		 */
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP1 &&
-		    !(desc->mask & (BIT(21) | BIT(22))))
+		    !(desc->mask & (BIT(22) | BIT(21) | BIT(13) | BIT(12))))
 			continue;
 
 		if (desc->ip == ASPEED_IP_SCU && desc->reg == HW_STRAP2)
-- 
2.42.0

