Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C620878BD4C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 05:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235596AbjH2DhU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 28 Aug 2023 23:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235597AbjH2DhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 23:37:07 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59918110
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 20:37:02 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id AC0AC809C;
        Tue, 29 Aug 2023 11:36:59 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 11:36:59 +0800
Received: from localhost.localdomain (113.72.145.245) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 29 Aug
 2023 11:36:58 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Walker Chen <walker.chen@starfivetech.com>,
        Xingyu Wu <xingyu.wu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>
Subject: [PATCH v1] ASoC: dwc: Fix the warnnings about JH7110 ops
Date:   Tue, 29 Aug 2023 11:36:58 +0800
Message-ID: <20230829033658.225713-1-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.245]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check of CONFIG_OF before the JH7110 ops to fix the warnings
that the JH7110 ops are defined but not used when CONFIG_OF is disabled.

Fixes: 1a512d13837a ("Add I2S support for the StarFive JH7110 SoC")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202308250433.nhzrhYEo-lkp@intel.com/
Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
Hi Mark,

This patch fixes the issue about the warning of JH7110 ops when CONFIG_OF
is disabled. So add a check of CONFIG_OF before defining JH7110 ops.

Thanks,
Xingyu Wu
---
 sound/soc/dwc/dwc-i2s.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index 5ab1b3eb2d28..329015ef1d1e 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -729,6 +729,7 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 }
 
+#ifdef CONFIG_OF
 /* clocks initialization with master mode on JH7110 SoC */
 static int jh7110_i2s_crg_master_init(struct dw_i2s_dev *dev)
 {
@@ -912,6 +913,7 @@ static int jh7110_i2stx0_clk_cfg(struct i2s_clk_config_data *config)
 
 	return clk_set_rate(dev->clk, bclk_rate);
 }
+#endif
 
 static int dw_i2s_probe(struct platform_device *pdev)
 {
-- 
2.25.1

