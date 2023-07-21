Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C983375D767
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 00:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGUWX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjGUWXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 18:23:25 -0400
X-Greylist: delayed 385 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Jul 2023 15:23:16 PDT
Received: from out-33.mta0.migadu.com (out-33.mta0.migadu.com [IPv6:2001:41d0:1004:224b::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD330DD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 15:23:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jookia.org; s=key1;
        t=1689977820;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g1Ehlui/zcIjjP1/gHDqt+MdaJf0yv94ClZD62kHOg8=;
        b=JyMK3ClfIc8quJPdjOxg1ypAPste7MSbrwQ5ftLnGQdSLJhcFGtiBy28qlMh1+k6gcDKIY
        UHNhfu/Kj/9HlP302JtWHQHetm/VDogr6bHcEkAPpitxEZuEco70n2JMDTwz2VJ2xFiOPQ
        dJs920SP0QKOKC48832jHUmgY6sqlsDhZZ3FXgKws+rizcw4jbawahYG7uHuONwEjPLB15
        4k4wY3JEnWDei0+sI7PZOXbCQTe0Sx4BhMOLCZQ8aXGaptAvNdQdo9Ndn23kNelKNWvAOk
        iHZ13p9YvdFc4l5RVGbrm6f0d2aNQewX+lDk4p8DewzDdevDn+n1flyT3vQcKg==
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
Subject: [PATCH v2 3/4] can: sun4i_can: Add acceptance register quirk
Date:   Sat, 22 Jul 2023 08:15:52 +1000
Message-ID: <20230721221552.1973203-5-contact@jookia.org>
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

The Allwinner D1's CAN controllers have the ACPC and ACPM registers
moved down. Compensate for this by adding an offset quirk for the
acceptance registers.

Signed-off-by: John Watts <contact@jookia.org>
---
 drivers/net/can/sun4i_can.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 0827830bbf28..1f90fe6dbb8b 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -205,9 +205,11 @@
  * struct sun4ican_quirks - Differences between SoC variants.
  *
  * @has_reset: SoC needs reset deasserted.
+ * @acp_offset: Offset of ACPC and ACPM registers
  */
 struct sun4ican_quirks {
 	bool has_reset;
+	int acp_offset;
 };
 
 struct sun4ican_priv {
@@ -216,6 +218,7 @@ struct sun4ican_priv {
 	struct clk *clk;
 	struct reset_control *reset;
 	spinlock_t cmdreg_lock;	/* lock for concurrent cmd register writes */
+	int acp_offset;
 };
 
 static const struct can_bittiming_const sun4ican_bittiming_const = {
@@ -338,8 +341,8 @@ static int sun4i_can_start(struct net_device *dev)
 	}
 
 	/* set filters - we accept all */
-	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR);
-	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR);
+	writel(0x00000000, priv->base + SUN4I_REG_ACPC_ADDR + priv->acp_offset);
+	writel(0xFFFFFFFF, priv->base + SUN4I_REG_ACPM_ADDR + priv->acp_offset);
 
 	/* clear error counters and error code capture */
 	writel(0, priv->base + SUN4I_REG_ERRC_ADDR);
@@ -768,10 +771,12 @@ static const struct ethtool_ops sun4ican_ethtool_ops = {
 
 static const struct sun4ican_quirks sun4ican_quirks_a10 = {
 	.has_reset = false,
+	.acp_offset = 0,
 };
 
 static const struct sun4ican_quirks sun4ican_quirks_r40 = {
 	.has_reset = true,
+	.acp_offset = 0,
 };
 
 static const struct of_device_id sun4ican_of_match[] = {
@@ -870,6 +875,7 @@ static int sun4ican_probe(struct platform_device *pdev)
 	priv->base = addr;
 	priv->clk = clk;
 	priv->reset = reset;
+	priv->acp_offset = quirks->acp_offset;
 	spin_lock_init(&priv->cmdreg_lock);
 
 	platform_set_drvdata(pdev, dev);
-- 
2.41.0

