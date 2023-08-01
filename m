Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93B4376B8ED
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbjHAPpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234948AbjHAPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:45:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD949FD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:45:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY8-0003zK-QC; Tue, 01 Aug 2023 17:44:40 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY5-000Q2g-5s; Tue, 01 Aug 2023 17:44:37 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY4-00Bf3I-6O; Tue, 01 Aug 2023 17:44:36 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Date:   Tue, 01 Aug 2023 17:44:30 +0200
Subject: [PATCH v3 2/2] net: stmmac: dwmac-imx: enable MAC propagation
 delay correction for i.MX8MP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230719-stmmac_correct_mac_delay-v3-2-61e63427735e@pengutronix.de>
References: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
In-Reply-To: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the i.MX8MP supports reading MAC propagation delay and correcting the
Hardware timestamp counter for additional delays [1], enable the feature
for this SoC.

This reduces phase error of the PPS output from the PTP Hardware Clock
from approx 150ns to 100ns.

[1] i.MX8MP Reference Manual, rev.1 Section 11.7.2.5.3 "Timestamp
correction"

Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
index 92e06a96757a..645a9454a490 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c
@@ -42,6 +42,7 @@
 
 struct imx_dwmac_ops {
 	u32 addr_width;
+	u32 flags;
 	bool mac_rgmii_txclk_auto_adj;
 
 	int (*fix_soc_reset)(void *priv, void __iomem *ioaddr);
@@ -311,6 +312,9 @@ static int imx_dwmac_probe(struct platform_device *pdev)
 		goto err_parse_dt;
 	}
 
+	if (data->flags & STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY)
+		plat_dat->flags |= STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY;
+
 	plat_dat->host_dma_width = dwmac->ops->addr_width;
 	plat_dat->init = imx_dwmac_init;
 	plat_dat->exit = imx_dwmac_exit;
@@ -350,6 +354,7 @@ static struct imx_dwmac_ops imx8mp_dwmac_data = {
 	.addr_width = 34,
 	.mac_rgmii_txclk_auto_adj = false,
 	.set_intf_mode = imx8mp_set_intf_mode,
+	.flags = STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY,
 };
 
 static struct imx_dwmac_ops imx8dxl_dwmac_data = {

-- 
2.39.2

