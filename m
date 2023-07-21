Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104A075D76B
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbjGUWXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjGUWX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:23:27 -0400
Received: from out-44.mta1.migadu.com (out-44.mta1.migadu.com [IPv6:2001:41d0:203:375::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4008B3C03
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:23:18 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689977827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gyIMbXR0OMPT1XfXDY8rkRHULGyYtVbg/Gm0FnqZe2E=;
        b=AWarFzCbMDr3V+FB5IMpmHCu4/bKtqmJHKflB6ecOCwKj8g9ppLPEcfmBz1Cs8u4yaag7v
        1e3VSEHJZloDKB48cg9i7Q1ZCAWpNum+64+bFnBxzZwb4IoaCH7rnuAgtAKZCibRG0mV8O
        V2FdUT0XsFd5hYPU237fRpc7AS8izdzk1HAGacUele2kU+35IiGP5O0ej/F4WYXof6q2pw
        pZeh3PvbEhsZsh3UrCSifndCtbRW3Na1Pd2b/J+Wgz8wXg0WGy3jA5Dg9YFN3j9xaS4eJK
        PR9WvWIVOj4ygevxAmOQEOmFQk6xjIflat/QcjnuFz7fou/KVXXk3wSaqks36g==
From:   John Watts <contact@jookia.org>
To:     linux-sunxi@lists.linux.dev
Cc:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, John Watts <contact@jookia.org>
Subject: [PATCH v2 4/4] can: sun4i_can: Add support for the Allwinner D1
Date:   Sat, 22 Jul 2023 08:15:53 +1000
Message-ID: <20230721221552.1973203-6-contact@jookia.org>
In-Reply-To: <20230721221552.1973203-2-contact@jookia.org>
References: <20230721221552.1973203-2-contact@jookia.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The controllers present in the D1 are extremely similar to the R40
and require the same reset quirks, but An extra quirk is needed to support
receiving packets.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/net/can/Kconfig     |  4 ++--
 drivers/net/can/sun4i_can.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index a5c5036dfb94..e626de33e735 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -185,10 +185,10 @@ config CAN_SLCAN
 
 config CAN_SUN4I
 	tristate "Allwinner A10 CAN controller"
-	depends on MACH_SUN4I || MACH_SUN7I || COMPILE_TEST
+	depends on MACH_SUN4I || MACH_SUN7I || RISCV || COMPILE_TEST
 	help
 	  Say Y here if you want to use CAN controller found on Allwinner
-	  A10/A20 SoCs.
+	  A10/A20/D1 SoCs.
 
 	  To compile this driver as a module, choose M here: the module will
 	  be called sun4i_can.
diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 1f90fe6dbb8b..c508a328e38d 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -91,6 +91,8 @@
 #define SUN4I_REG_BUF12_ADDR	0x0070	/* CAN Tx/Rx Buffer 12 */
 #define SUN4I_REG_ACPC_ADDR	0x0040	/* CAN Acceptance Code 0 */
 #define SUN4I_REG_ACPM_ADDR	0x0044	/* CAN Acceptance Mask 0 */
+#define SUN4I_REG_ACPC_ADDR_D1	0x0028	/* CAN Acceptance Code 0 on the D1 */
+#define SUN4I_REG_ACPM_ADDR_D1	0x002C	/* CAN Acceptance Mask 0 on the D1 */
 #define SUN4I_REG_RBUF_RBACK_START_ADDR	0x0180	/* CAN transmit buffer start */
 #define SUN4I_REG_RBUF_RBACK_END_ADDR	0x01b0	/* CAN transmit buffer end */
 
@@ -779,6 +781,11 @@ static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.acp_offset = 0,
 };
 
+static const struct sun4ican_quirks sun4ican_quirks_d1 = {
+	.has_reset = true,
+	.acp_offset = (SUN4I_REG_ACPC_ADDR_D1 - SUN4I_REG_ACPC_ADDR),
+};
+
 static const struct of_device_id sun4ican_of_match[] = {
 	{
 		.compatible = "allwinner,sun4i-a10-can",
@@ -789,6 +796,9 @@ static const struct of_device_id sun4ican_of_match[] = {
 	}, {
 		.compatible = "allwinner,sun8i-r40-can",
 		.data = &sun4ican_quirks_r40
+	}, {
+		.compatible = "allwinner,sun20i-d1-can",
+		.data = &sun4ican_quirks_d1
 	}, {
 		/* sentinel */
 	},
@@ -913,4 +923,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");
-- 
2.41.0

