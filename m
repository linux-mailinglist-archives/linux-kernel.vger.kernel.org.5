Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367D798D04
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 20:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbjIHSTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 14:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344020AbjIHSSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 14:18:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A832700;
        Fri,  8 Sep 2023 11:18:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4DAC433D9;
        Fri,  8 Sep 2023 18:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694196991;
        bh=RYRmrWQTvyij/zWXElDHxZmWLF6F412HkZFzxXaFk5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a9XDlBEvdrDtlqcXNIwIidBlVTrHeLER62tT9rrzAPY2BI2A4pJyroY6t9YHglF+J
         Hr5vGw9UZLZWbieABFDeEraUoNo2QI/y+lSJzgrtJOFS7Dk7fjFyGMtUtaW4VoBnjd
         a9EhVRvyp5POgjGxKxiFDy8O3Z9fOsaALzoAwYohBApSecins1yIqZEerIauSVktMM
         /5IIitbXFnD/hhAHTqGJtSWUBrBfvt6C6oMdWWTjIOS5j+bOr/OBmJOmDTicm74bxH
         NFqU+1+B5s1Y/ZAM5cSlSIUHWLEYesHtPksx6TfGyFJFc7osgJKxUJzDNc0jm4yI5Y
         P6YIS5ouMREEw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     John Watts <contact@jookia.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Sasha Levin <sashal@kernel.org>, wg@grandegger.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, wens@csie.org, jernej.skrabec@gmail.com,
        samuel@sholland.org, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH AUTOSEL 6.4 12/41] can: sun4i_can: Add support for the Allwinner D1
Date:   Fri,  8 Sep 2023 14:15:26 -0400
Message-Id: <20230908181555.3459640-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230908181555.3459640-1-sashal@kernel.org>
References: <20230908181555.3459640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.15
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: John Watts <contact@jookia.org>

[ Upstream commit 8abb95250ae6af2d51993da8fcae18da2ce24cc4 ]

The controllers present in the D1 are extremely similar to the R40
and require the same reset quirks, but An extra quirk is needed to support
receiving packets.

Signed-off-by: John Watts <contact@jookia.org>
Link: https://lore.kernel.org/all/20230721221552.1973203-6-contact@jookia.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/Kconfig     |  4 ++--
 drivers/net/can/sun4i_can.c | 12 +++++++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig
index b190007c01bec..a3ee9d18ea33d 100644
--- a/drivers/net/can/Kconfig
+++ b/drivers/net/can/Kconfig
@@ -186,10 +186,10 @@ config CAN_SLCAN
 
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
index dd0c6cd76c5f5..c3a6b028ea4d6 100644
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
@@ -915,4 +925,4 @@ module_platform_driver(sun4i_can_driver);
 MODULE_AUTHOR("Peter Chen <xingkongcp@gmail.com>");
 MODULE_AUTHOR("Gerhard Bertelsmann <info@gerhard-bertelsmann.de>");
 MODULE_LICENSE("Dual BSD/GPL");
-MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20)");
+MODULE_DESCRIPTION("CAN driver for Allwinner SoCs (A10/A20/D1)");
-- 
2.40.1

