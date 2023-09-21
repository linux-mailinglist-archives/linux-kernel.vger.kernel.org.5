Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF787AA271
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjIUVRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232649AbjIUVQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:16:07 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E973D1FF7;
        Thu, 21 Sep 2023 10:09:28 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LBWej4026620;
        Thu, 21 Sep 2023 17:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=/9F9IPv8bKefYH1bhnlKnLSsSeMujGUyOaDFDQ+NMFI=; b=Xp
        aZmfbSHUgfgOttnVqy92Ub18iTgJWNcqmKeZEt4PMWWAIACo+JB2HgyTxKIfgkBq
        wbwRmsB7ATJ8PRtTVDdUamo8MCMdK9dRKCgvNba338wHBhsBzeD9xVivYSxs9ri0
        e0D/dqVyR6QCSjkZpKPXJ+P+ie8Cbdybq699LVuxFjRIPNAmaOJ61A1r921+ZlPp
        vpeX0Exln82csHepTZCNtYEbkgrZDeR3C6GX0Aw/4UVK0QD9xr0+QFEN9wL01iQ4
        5iIqLzexe5GT8NC+MlfqZ0vVsrEi7J/jJ4eqaAyOFe59Fx+MDAYKQA/Jh+/dB0zl
        BiXNn0S6O3pxTyKufJgw==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t53px4sqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:06:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5A216100057;
        Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 522D4252250;
        Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 17:06:51 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] net: ethernet: stmmac: add management of stm32mp13 for stm32
Date:   Thu, 21 Sep 2023 17:06:18 +0200
Message-ID: <20230921150622.599232-4-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921150622.599232-1-christophe.roullier@foss.st.com>
References: <20230921150622.599232-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Ethernet support for STM32MP13.
STM32MP13 is STM32 SOC with 2 GMACs instances.
GMAC IP version is SNPS 4.20.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 762c5256398f..0f843ab3822f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -584,9 +584,30 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	}
 };
 
+static struct stm32_ops stm32mp13_dwmac_data = {
+	.set_mode = stm32mp1_set_mode,
+	.clk_prepare = stm32mp1_clk_prepare,
+	.suspend = stm32mp1_suspend,
+	.resume = stm32mp1_resume,
+	.parse_data = stm32mp1_parse_data,
+	.syscfg_clr_off = 0x08,
+	.pmcsetr = {
+		.eth1_clk_sel		= BIT(16),
+		.eth1_ref_clk_sel	= BIT(17),
+		.eth1_selmii		= 0,
+		.eth1_sel_rgmii		= BIT(21),
+		.eth1_sel_rmii		= BIT(23),
+		.eth2_clk_sel		= BIT(24),
+		.eth2_ref_clk_sel	= BIT(25),
+		.eth2_sel_rgmii		= BIT(29),
+		.eth2_sel_rmii		= BIT(31)
+	}
+};
+
 static const struct of_device_id stm32_dwmac_match[] = {
 	{ .compatible = "st,stm32-dwmac", .data = &stm32mcu_dwmac_data},
 	{ .compatible = "st,stm32mp1-dwmac", .data = &stm32mp1_dwmac_data},
+	{ .compatible = "st,stm32mp13-dwmac", .data = &stm32mp13_dwmac_data},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, stm32_dwmac_match);
-- 
2.25.1

