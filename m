Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6520782C48
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbjHUOmT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 21 Aug 2023 10:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236071AbjHUOmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:42:13 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42972F5;
        Mon, 21 Aug 2023 07:41:58 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 306067FD3;
        Mon, 21 Aug 2023 22:41:55 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 22:41:55 +0800
Received: from localhost.localdomain (113.72.145.205) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Aug
 2023 22:41:54 +0800
From:   Xingyu Wu <xingyu.wu@starfivetech.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Claudiu Beznea <Claudiu.Beznea@microchip.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxim Kochetkov <fido_max@inbox.ru>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     Jose Abreu <joabreu@synopsys.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Walker Chen <walker.chen@starfivetech.com>,
        "Xingyu Wu" <xingyu.wu@starfivetech.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <linux-riscv@lists.infradead.org>
Subject: [PATCH v2 3/5] ASoC: dwc: i2s: Add StarFive JH7110 SoC support
Date:   Mon, 21 Aug 2023 22:41:49 +0800
Message-ID: <20230821144151.207339-4-xingyu.wu@starfivetech.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
References: <20230821144151.207339-1-xingyu.wu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.145.205]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX061.cuchost.com
 (172.16.6.61)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add StarFive JH7110(TX0/TX1/RX channels) SoC support in the
designware I2S driver and a flag to check if it is on the JH7110 SoC.

These channels need to enable clocks, resets and syscon register on the
JH7110 SoC. So add init ops in platform data for the JH7110 SoC to do this.

Their resets should be deassert before changing the parent of clocks so
these are done in the init ops of platform data.

The I2S controllers use DMA controller by platform data on the JH7110
and their settings about snd_dmaengine_dai_dma_data() should be added
in the dw_configure_dai_by_pd(). And use dmaengine PCM registration if
these do not have IRQ on the JH7110 SoC.

Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
---
 include/sound/designware_i2s.h |   3 +
 sound/soc/dwc/dwc-i2s.c        | 304 ++++++++++++++++++++++++++++++---
 sound/soc/dwc/local.h          |   1 +
 3 files changed, 287 insertions(+), 21 deletions(-)

diff --git a/include/sound/designware_i2s.h b/include/sound/designware_i2s.h
index 80d275b9ae0d..f6803205a9fb 100644
--- a/include/sound/designware_i2s.h
+++ b/include/sound/designware_i2s.h
@@ -21,6 +21,8 @@ struct i2s_clk_config_data {
 	u32 sample_rate;
 };
 
+struct dw_i2s_dev;
+
 struct i2s_platform_data {
 	#define DWC_I2S_PLAY	(1 << 0)
 	#define DWC_I2S_RECORD	(1 << 1)
@@ -42,6 +44,7 @@ struct i2s_platform_data {
 	void *capture_dma_data;
 	bool (*filter)(struct dma_chan *chan, void *slave);
 	int (*i2s_clk_cfg)(struct i2s_clk_config_data *config);
+	int (*i2s_pd_init)(struct dw_i2s_dev *dev);
 };
 
 struct i2s_dma_data {
diff --git a/sound/soc/dwc/dwc-i2s.c b/sound/soc/dwc/dwc-i2s.c
index e70d41d57dfd..5ab1b3eb2d28 100644
--- a/sound/soc/dwc/dwc-i2s.c
+++ b/sound/soc/dwc/dwc-i2s.c
@@ -16,6 +16,7 @@
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
+#include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/reset.h>
 #include <linux/slab.h>
@@ -198,7 +199,8 @@ static void i2s_start(struct dw_i2s_dev *dev,
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 1);
 
-	if (dev->use_pio)
+	/* I2S needs to enable IRQ to make a handshake with DMAC on the JH7110 SoC */
+	if (dev->use_pio || dev->is_jh7110)
 		i2s_enable_irqs(dev, substream->stream, config->chan_nr);
 	else
 		i2s_enable_dma(dev, substream->stream);
@@ -216,7 +218,7 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	else
 		i2s_write_reg(dev->i2s_base, IRER, 0);
 
-	if (dev->use_pio)
+	if (dev->use_pio || dev->is_jh7110)
 		i2s_disable_irqs(dev, substream->stream, 8);
 	else
 		i2s_disable_dma(dev, substream->stream);
@@ -227,6 +229,21 @@ static void i2s_stop(struct dw_i2s_dev *dev,
 	}
 }
 
+static int dw_i2s_startup(struct snd_pcm_substream *substream,
+			  struct snd_soc_dai *cpu_dai)
+{
+	struct dw_i2s_dev *dev = snd_soc_dai_get_drvdata(cpu_dai);
+
+	if (dev->is_jh7110) {
+		struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+		struct snd_soc_dai_link *dai_link = rtd->dai_link;
+
+		dai_link->trigger_stop = SND_SOC_TRIGGER_ORDER_LDC;
+	}
+
+	return 0;
+}
+
 static void dw_i2s_config(struct dw_i2s_dev *dev, int stream)
 {
 	u32 ch_reg;
@@ -453,6 +470,7 @@ static int dw_i2s_dai_probe(struct snd_soc_dai *dai)
 
 static const struct snd_soc_dai_ops dw_i2s_dai_ops = {
 	.probe		= dw_i2s_dai_probe,
+	.startup	= dw_i2s_startup,
 	.hw_params	= dw_i2s_hw_params,
 	.prepare	= dw_i2s_prepare,
 	.trigger	= dw_i2s_trigger,
@@ -637,17 +655,39 @@ static int dw_configure_dai_by_pd(struct dw_i2s_dev *dev,
 
 	if (dev->quirks & DW_I2S_QUIRK_16BIT_IDX_OVERRIDE)
 		idx = 1;
-	/* Set DMA slaves info */
-	dev->play_dma_data.pd.data = pdata->play_dma_data;
-	dev->capture_dma_data.pd.data = pdata->capture_dma_data;
-	dev->play_dma_data.pd.addr = res->start + I2S_TXDMA;
-	dev->capture_dma_data.pd.addr = res->start + I2S_RXDMA;
-	dev->play_dma_data.pd.max_burst = 16;
-	dev->capture_dma_data.pd.max_burst = 16;
-	dev->play_dma_data.pd.addr_width = bus_widths[idx];
-	dev->capture_dma_data.pd.addr_width = bus_widths[idx];
-	dev->play_dma_data.pd.filter = pdata->filter;
-	dev->capture_dma_data.pd.filter = pdata->filter;
+
+	if (dev->is_jh7110) {
+		/* Use platform data and snd_dmaengine_dai_dma_data struct at the same time */
+		u32 comp2 = i2s_read_reg(dev->i2s_base, I2S_COMP_PARAM_2);
+		u32 idx2;
+
+		if (COMP1_TX_ENABLED(comp1)) {
+			idx2 = COMP1_TX_WORDSIZE_0(comp1);
+			dev->play_dma_data.dt.addr = res->start + I2S_TXDMA;
+			dev->play_dma_data.dt.fifo_size = dev->fifo_th * 2 *
+				(fifo_width[idx2]) >> 8;
+			dev->play_dma_data.dt.maxburst = 16;
+		}
+		if (COMP1_RX_ENABLED(comp1)) {
+			idx2 = COMP2_RX_WORDSIZE_0(comp2);
+			dev->capture_dma_data.dt.addr = res->start + I2S_RXDMA;
+			dev->capture_dma_data.dt.fifo_size = dev->fifo_th * 2 *
+				(fifo_width[idx2] >> 8);
+			dev->capture_dma_data.dt.maxburst = 16;
+		}
+	} else {
+		/* Set DMA slaves info */
+		dev->play_dma_data.pd.data = pdata->play_dma_data;
+		dev->capture_dma_data.pd.data = pdata->capture_dma_data;
+		dev->play_dma_data.pd.addr = res->start + I2S_TXDMA;
+		dev->capture_dma_data.pd.addr = res->start + I2S_RXDMA;
+		dev->play_dma_data.pd.max_burst = 16;
+		dev->capture_dma_data.pd.max_burst = 16;
+		dev->play_dma_data.pd.addr_width = bus_widths[idx];
+		dev->capture_dma_data.pd.addr_width = bus_widths[idx];
+		dev->play_dma_data.pd.filter = pdata->filter;
+		dev->capture_dma_data.pd.filter = pdata->filter;
+	}
 
 	return 0;
 }
@@ -689,6 +729,190 @@ static int dw_configure_dai_by_dt(struct dw_i2s_dev *dev,
 
 }
 
+/* clocks initialization with master mode on JH7110 SoC */
+static int jh7110_i2s_crg_master_init(struct dw_i2s_dev *dev)
+{
+	static struct clk_bulk_data clks[] = {
+		{ .id = "mclk" },
+		{ .id = "mclk_ext" },
+		{ .id = "mclk_inner" },
+		{ .id = "apb" },
+		{ .id = "i2sclk" },
+	};
+	struct reset_control *resets = devm_reset_control_array_get_exclusive(dev->dev);
+	int ret;
+	struct clk *pclk;
+	struct clk *bclk_mst;
+	struct clk *mclk;
+	struct clk *mclk_ext;
+	struct clk *mclk_inner;
+
+	if (IS_ERR(resets))
+		return dev_err_probe(dev->dev, PTR_ERR(resets), "failed to get i2s resets\n");
+
+	ret = clk_bulk_get(dev->dev, ARRAY_SIZE(clks), clks);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "failed to get i2s clocks\n");
+
+	mclk = clks[0].clk;
+	mclk_ext = clks[1].clk;
+	mclk_inner = clks[2].clk;
+	pclk = clks[3].clk;
+	bclk_mst = clks[4].clk;
+
+	ret = clk_prepare_enable(pclk);
+	if (ret)
+		goto exit;
+
+	/* Use inner mclk first and avoid uninitialized gpio for external mclk */
+	ret = clk_set_parent(mclk, mclk_inner);
+	if (ret)
+		goto err_dis_pclk;
+
+	ret = clk_prepare_enable(bclk_mst);
+	if (ret)
+		goto err_dis_pclk;
+
+	/* deassert resets before set clock parent */
+	ret = reset_control_deassert(resets);
+	if (ret)
+		goto err_dis_all;
+
+	/* external clock (12.288MHz) for Audio */
+	ret = clk_set_parent(mclk, mclk_ext);
+	if (ret)
+		goto err_dis_all;
+
+	/* i2sclk will be got and enabled repeatedly later and should be disabled now. */
+	clk_disable_unprepare(bclk_mst);
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+	dev->is_jh7110 = true;
+
+	return 0;
+
+err_dis_all:
+	clk_disable_unprepare(bclk_mst);
+err_dis_pclk:
+	clk_disable_unprepare(pclk);
+exit:
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+	return ret;
+}
+
+/* clocks initialization with slave mode on JH7110 SoC */
+static int jh7110_i2s_crg_slave_init(struct dw_i2s_dev *dev)
+{
+	static struct clk_bulk_data clks[] = {
+		{ .id = "mclk" },
+		{ .id = "mclk_ext" },
+		{ .id = "apb" },
+		{ .id = "bclk_ext" },
+		{ .id = "lrck_ext" },
+		{ .id = "bclk" },
+		{ .id = "lrck" },
+		{ .id = "mclk_inner" },
+		{ .id = "i2sclk" },
+	};
+	struct reset_control *resets = devm_reset_control_array_get_exclusive(dev->dev);
+	int ret;
+	struct clk *pclk;
+	struct clk *bclk_mst;
+	struct clk *bclk_ext;
+	struct clk *lrck_ext;
+	struct clk *bclk;
+	struct clk *lrck;
+	struct clk *mclk;
+	struct clk *mclk_ext;
+	struct clk *mclk_inner;
+
+	if (IS_ERR(resets))
+		return dev_err_probe(dev->dev, PTR_ERR(resets), "failed to get i2s resets\n");
+
+	ret = clk_bulk_get(dev->dev, ARRAY_SIZE(clks), clks);
+	if (ret)
+		return dev_err_probe(dev->dev, ret, "failed to get i2s clocks\n");
+
+	mclk = clks[0].clk;
+	mclk_ext = clks[1].clk;
+	pclk = clks[2].clk;
+	bclk_ext = clks[3].clk;
+	lrck_ext = clks[4].clk;
+	bclk = clks[5].clk;
+	lrck = clks[6].clk;
+	mclk_inner = clks[7].clk;
+	bclk_mst = clks[8].clk;
+
+	ret = clk_prepare_enable(pclk);
+	if (ret)
+		goto exit;
+
+	ret = clk_set_parent(mclk, mclk_inner);
+	if (ret)
+		goto err_dis_pclk;
+
+	ret = clk_prepare_enable(bclk_mst);
+	if (ret)
+		goto err_dis_pclk;
+
+	ret = reset_control_deassert(resets);
+	if (ret)
+		goto err_dis_all;
+
+	/* The sources of BCLK and LRCK are the external codec. */
+	ret = clk_set_parent(bclk, bclk_ext);
+	if (ret)
+		goto err_dis_all;
+
+	ret = clk_set_parent(lrck, lrck_ext);
+	if (ret)
+		goto err_dis_all;
+
+	ret = clk_set_parent(mclk, mclk_ext);
+	if (ret)
+		goto err_dis_all;
+
+	/* The i2sclk will be got and enabled repeatedly later and should be disabled now. */
+	clk_disable_unprepare(bclk_mst);
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+	dev->is_jh7110 = true;
+
+	return 0;
+
+err_dis_all:
+	clk_disable_unprepare(bclk_mst);
+err_dis_pclk:
+	clk_disable_unprepare(pclk);
+exit:
+	clk_bulk_put(ARRAY_SIZE(clks), clks);
+	return ret;
+}
+
+/* Special syscon initialization about RX channel with slave mode on JH7110 SoC */
+static int jh7110_i2srx_crg_init(struct dw_i2s_dev *dev)
+{
+	struct regmap *regmap;
+	unsigned int args[2];
+
+	regmap = syscon_regmap_lookup_by_phandle_args(dev->dev->of_node,
+						      "starfive,syscon",
+						      2, args);
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev->dev, PTR_ERR(regmap), "getting the regmap failed\n");
+
+	/* Enable I2Srx with syscon register, args[0]: offset, args[1]: mask */
+	regmap_update_bits(regmap, args[0], args[1], args[1]);
+
+	return jh7110_i2s_crg_slave_init(dev);
+}
+
+static int jh7110_i2stx0_clk_cfg(struct i2s_clk_config_data *config)
+{
+	struct dw_i2s_dev *dev = container_of(config, struct dw_i2s_dev, config);
+	u32 bclk_rate = config->sample_rate * 64;
+
+	return clk_set_rate(dev->clk, bclk_rate);
+}
+
 static int dw_i2s_probe(struct platform_device *pdev)
 {
 	const struct i2s_platform_data *pdata = of_device_get_match_data(&pdev->dev);
@@ -712,15 +936,25 @@ static int dw_i2s_probe(struct platform_device *pdev)
 	if (IS_ERR(dev->i2s_base))
 		return PTR_ERR(dev->i2s_base);
 
-	dev->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
-	if (IS_ERR(dev->reset))
-		return PTR_ERR(dev->reset);
+	dev->dev = &pdev->dev;
+	dev->is_jh7110 = false;
+	if (pdata) {
+		if (pdata->i2s_pd_init) {
+			ret = pdata->i2s_pd_init(dev);
+			if (ret)
+				return ret;
+		}
+	}
 
-	ret = reset_control_deassert(dev->reset);
-	if (ret)
-		return ret;
+	if (!dev->is_jh7110) {
+		dev->reset = devm_reset_control_array_get_optional_shared(&pdev->dev);
+		if (IS_ERR(dev->reset))
+			return PTR_ERR(dev->reset);
 
-	dev->dev = &pdev->dev;
+		ret = reset_control_deassert(dev->reset);
+		if (ret)
+			return ret;
+	}
 
 	irq = platform_get_irq_optional(pdev, 0);
 	if (irq >= 0) {
@@ -779,7 +1013,7 @@ static int dw_i2s_probe(struct platform_device *pdev)
 		goto err_clk_disable;
 	}
 
-	if (!pdata) {
+	if (!pdata || dev->is_jh7110) {
 		if (irq >= 0) {
 			ret = dw_pcm_register(pdev);
 			dev->use_pio = true;
@@ -821,8 +1055,36 @@ static void dw_i2s_remove(struct platform_device *pdev)
 }
 
 #ifdef CONFIG_OF
+static const struct i2s_platform_data jh7110_i2stx0_data = {
+	.cap = DWC_I2S_PLAY | DW_I2S_MASTER,
+	.channel = TWO_CHANNEL_SUPPORT,
+	.snd_fmts = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.snd_rates = SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_48000,
+	.i2s_clk_cfg = jh7110_i2stx0_clk_cfg,
+	.i2s_pd_init = jh7110_i2s_crg_master_init,
+};
+
+static const struct i2s_platform_data jh7110_i2stx1_data = {
+	.cap = DWC_I2S_PLAY | DW_I2S_SLAVE,
+	.channel = TWO_CHANNEL_SUPPORT,
+	.snd_fmts = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.snd_rates = SNDRV_PCM_RATE_8000_192000,
+	.i2s_pd_init = jh7110_i2s_crg_slave_init,
+};
+
+static const struct i2s_platform_data jh7110_i2srx_data = {
+	.cap = DWC_I2S_RECORD | DW_I2S_SLAVE,
+	.channel = TWO_CHANNEL_SUPPORT,
+	.snd_fmts = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
+	.snd_rates = SNDRV_PCM_RATE_8000_192000,
+	.i2s_pd_init = jh7110_i2srx_crg_init,
+};
+
 static const struct of_device_id dw_i2s_of_match[] = {
 	{ .compatible = "snps,designware-i2s",	 },
+	{ .compatible = "starfive,jh7110-i2stx0", .data = &jh7110_i2stx0_data, },
+	{ .compatible = "starfive,jh7110-i2stx1", .data = &jh7110_i2stx1_data,},
+	{ .compatible = "starfive,jh7110-i2srx", .data = &jh7110_i2srx_data,},
 	{},
 };
 
diff --git a/sound/soc/dwc/local.h b/sound/soc/dwc/local.h
index 4ce96bac2f39..dce88c9ad5f3 100644
--- a/sound/soc/dwc/local.h
+++ b/sound/soc/dwc/local.h
@@ -123,6 +123,7 @@ struct dw_i2s_dev {
 	u32 fifo_th;
 	u32 l_reg;
 	u32 r_reg;
+	bool is_jh7110; /* Flag for StarFive JH7110 SoC */
 
 	/* data related to DMA transfers b/w i2s and DMAC */
 	union dw_i2s_snd_dma_data play_dma_data;
-- 
2.25.1

