Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2FE7FBB52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:21:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344738AbjK1NU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343821AbjK1NU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:20:57 -0500
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2813D62;
        Tue, 28 Nov 2023 05:21:01 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 39C60C000C;
        Tue, 28 Nov 2023 13:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701177660;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uG7hIl7at36uWKJHQ21nTIZih0E8GqWucxRcdCXoYHQ=;
        b=OL2Gbi/I03qzlLOdV3y8RDkLDr2fYDmcARSVxreMVGFgfnRLhaHz4RuRSWXvKPfJSYFFvG
        KPrfiTjtSTHyf/JVyg+I9TZ1LT8u17m+OhCOkzC2SGmc0B3qpxN9VkyxqzMUXyVVyCCwDO
        J/4CcWDr0p2HU958mwSRHlcWWDAH3rr+W/5RJ38FBZCNH1+KWcO882LqRlFfkyfhEKRxkL
        c25599glt9Nit566C56v3UM9e/V8NYIT/uFmp8zvtb3rF4VVRTuMz37+RbXYLB7LMEHkxz
        Aj8vNYR7yBj9DMgyaTh+WngIkTSasROcHKGwJKsa339hipUODpV9XpjfaZ29jA==
From:   Thomas Richard <thomas.richard@bootlin.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        s-vadapalli@ti.com, rogerq@kernel.org, grygorii.strashko@ti.com,
        dan.carpenter@linaro.org, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, u-kumar1@ti.com,
        Thomas Richard <thomas.richard@bootlin.com>
Subject: [PATCH] net: ethernet: ti: am65-cpsw: improve suspend/resume support for J7200
Date:   Tue, 28 Nov 2023 14:19:36 +0100
Message-Id: <20231128131936.600233-1-thomas.richard@bootlin.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>

On J7200 the SoC is off during suspend, so the clocks have to be
completely power down, and phy_set_mode_ext must be called again.

Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 25 ++++++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpts.c      | 11 +++++++++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index ece9f8df98ae..e95ef30bd67f 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2115,6 +2115,27 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 	return ret;
 }
 
+static int am65_cpsw_nuss_resume_slave_ports(struct am65_cpsw_common *common)
+{
+	struct device *dev = common->dev;
+	int i;
+
+	for (i = 1; i <= common->port_num; i++) {
+		struct am65_cpsw_port *port;
+		int ret;
+
+		port = am65_common_get_port(common, i);
+
+		ret = phy_set_mode_ext(port->slave.ifphy, PHY_MODE_ETHERNET, port->slave.phy_if);
+		if (ret) {
+			dev_err(dev, "port %d error setting phy mode %d\n", i, ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
 static void am65_cpsw_pcpu_stats_free(void *data)
 {
 	struct am65_cpsw_ndev_stats __percpu *stats = data;
@@ -3087,6 +3108,10 @@ static int am65_cpsw_nuss_resume(struct device *dev)
 	if (common->rx_irq_disabled)
 		disable_irq(common->rx_chns.irq);
 
+	ret = am65_cpsw_nuss_resume_slave_ports(common);
+	if (ret)
+		dev_err(dev, "failed to resume slave ports: %d", ret);
+
 	am65_cpts_resume(common->cpts);
 
 	for (i = 0; i < common->port_num; i++) {
diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
index c66618d91c28..e6db5b61409a 100644
--- a/drivers/net/ethernet/ti/am65-cpts.c
+++ b/drivers/net/ethernet/ti/am65-cpts.c
@@ -1189,7 +1189,11 @@ void am65_cpts_suspend(struct am65_cpts *cpts)
 	cpts->sr_cpts_ns = am65_cpts_gettime(cpts, NULL);
 	cpts->sr_ktime_ns = ktime_to_ns(ktime_get_real());
 	am65_cpts_disable(cpts);
-	clk_disable(cpts->refclk);
+
+	/* During suspend the SoC can be power off, so let's not only
+	 * disable but also unprepare the clock
+	 */
+	clk_disable_unprepare(cpts->refclk);
 
 	/* Save GENF state */
 	memcpy_fromio(&cpts->sr_genf, &cpts->reg->genf, sizeof(cpts->sr_genf));
@@ -1204,8 +1208,11 @@ void am65_cpts_resume(struct am65_cpts *cpts)
 	int i;
 	s64 ktime_ns;
 
+	/* During suspend the SoC can be power off, so let's not only
+	 * enable but also prepare the clock
+	 */
+	clk_prepare_enable(cpts->refclk);
 	/* restore state and enable CPTS */
-	clk_enable(cpts->refclk);
 	am65_cpts_write32(cpts, cpts->sr_rftclk_sel, rftclk_sel);
 	am65_cpts_set_add_val(cpts);
 	am65_cpts_write32(cpts, cpts->sr_control, control);
-- 
2.39.2

