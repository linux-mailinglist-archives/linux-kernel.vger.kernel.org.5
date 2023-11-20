Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643477F0FC3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 11:04:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232948AbjKTKEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 05:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232897AbjKTKEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 05:04:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5025BA;
        Mon, 20 Nov 2023 02:04:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9812BC433CA;
        Mon, 20 Nov 2023 10:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700474661;
        bh=yhtiEMFwuaLH1CQ4Y4i0xRNvqFHq7Lfq0T521vGzkUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BzwGcWEbbgKPQ8UHf0+jJEb+MIwB+Ic9s4FuB1ZZrkXBp4/FzpIrxy0/dfvhVPjiR
         z9DH1L1lkYnF2xCrro5VTD4P/OfLSBCIy243z13SeCyWQgo18ie7tvnq7qVvJYyiGr
         oMyEt2ByVUjcfXJJz3Q1szmY0R6PlZLpLBO89yYs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 4.19.299
Date:   Mon, 20 Nov 2023 11:04:09 +0100
Message-ID: <2023112009-candy-puzzling-3241@gregkh>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <2023112009-overbite-slimy-421d@gregkh>
References: <2023112009-overbite-slimy-421d@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index 0c2244a514fc..84a44cc190ae 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 4
 PATCHLEVEL = 19
-SUBLEVEL = 298
+SUBLEVEL = 299
 EXTRAVERSION =
 NAME = "People's Front"
 
diff --git a/arch/arm/boot/dts/qcom-mdm9615.dtsi b/arch/arm/boot/dts/qcom-mdm9615.dtsi
index c852b69229c9..26d49f35331b 100644
--- a/arch/arm/boot/dts/qcom-mdm9615.dtsi
+++ b/arch/arm/boot/dts/qcom-mdm9615.dtsi
@@ -82,14 +82,12 @@
 		};
 	};
 
-	regulators {
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
+	vsdcc_fixed: vsdcc-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "SDCC Power";
+		regulator-min-microvolt = <2700000>;
+		regulator-max-microvolt = <2700000>;
+		regulator-always-on;
 	};
 
 	soc: soc {
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index ed6d35d9cdb5..a68688f3f3b3 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -19,6 +19,7 @@
 ENTRY(mmioset)
 ENTRY(memset)
 UNWIND( .fnstart         )
+	and	r1, r1, #255		@ cast to unsigned char
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
 	bne	6f			@ 1
diff --git a/arch/sh/Kconfig.debug b/arch/sh/Kconfig.debug
index 71acd3d9b9e8..dfc784f89797 100644
--- a/arch/sh/Kconfig.debug
+++ b/arch/sh/Kconfig.debug
@@ -26,6 +26,17 @@ config STACK_DEBUG
 	  every function call and will therefore incur a major
 	  performance hit. Most users should say N.
 
+config EARLY_PRINTK
+	bool "Early printk"
+	depends on SH_STANDARD_BIOS
+	help
+	  Say Y here to redirect kernel printk messages to the serial port
+	  used by the SH-IPL bootloader, starting very early in the boot
+	  process and ending when the kernel's serial console is initialised.
+	  This option is only useful while porting the kernel to a new machine,
+	  when the kernel may crash or hang before the serial console is
+	  initialised.  If unsure, say N.
+
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
 	depends on DEBUG_KERNEL && (MMU || BROKEN) && !PAGE_SIZE_64KB
diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index f792b149a574..146be9cdeca5 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -164,8 +164,8 @@ static int create_pnp_modalias(struct acpi_device *acpi_dev, char *modalias,
 		return 0;
 
 	len = snprintf(modalias, size, "acpi:");
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
 
 	size -= len;
 
@@ -218,8 +218,10 @@ static int create_of_modalias(struct acpi_device *acpi_dev, char *modalias,
 	len = snprintf(modalias, size, "of:N%sT", (char *)buf.pointer);
 	ACPI_FREE(buf.pointer);
 
-	if (len <= 0)
-		return len;
+	if (len >= size)
+		return -ENOMEM;
+
+	size -= len;
 
 	of_compatible = acpi_dev->data.of_compatible;
 	if (of_compatible->type == ACPI_TYPE_PACKAGE) {
diff --git a/drivers/base/regmap/regmap-debugfs.c b/drivers/base/regmap/regmap-debugfs.c
index de706734b921..d114b614a3d1 100644
--- a/drivers/base/regmap/regmap-debugfs.c
+++ b/drivers/base/regmap/regmap-debugfs.c
@@ -53,7 +53,7 @@ static ssize_t regmap_name_read_file(struct file *file,
 		name = map->dev->driver->name;
 
 	ret = snprintf(buf, PAGE_SIZE, "%s\n", name);
-	if (ret < 0) {
+	if (ret >= PAGE_SIZE) {
 		kfree(buf);
 		return ret;
 	}
diff --git a/drivers/char/hw_random/geode-rng.c b/drivers/char/hw_random/geode-rng.c
index 207272979f23..2f8289865ec8 100644
--- a/drivers/char/hw_random/geode-rng.c
+++ b/drivers/char/hw_random/geode-rng.c
@@ -58,7 +58,8 @@ struct amd_geode_priv {
 
 static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 
 	*data = readl(mem + GEODE_RNG_DATA_REG);
 
@@ -67,7 +68,8 @@ static int geode_rng_data_read(struct hwrng *rng, u32 *data)
 
 static int geode_rng_data_present(struct hwrng *rng, int wait)
 {
-	void __iomem *mem = (void __iomem *)rng->priv;
+	struct amd_geode_priv *priv = (struct amd_geode_priv *)rng->priv;
+	void __iomem *mem = priv->membase;
 	int data, i;
 
 	for (i = 0; i < 20; i++) {
diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
index c5edf8f2fd19..f96e88310414 100644
--- a/drivers/clk/clk-npcm7xx.c
+++ b/drivers/clk/clk-npcm7xx.c
@@ -647,7 +647,7 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
 	return;
 
 npcm7xx_init_fail:
-	kfree(npcm7xx_clk_data->hws);
+	kfree(npcm7xx_clk_data);
 npcm7xx_init_np_err:
 	iounmap(clk_base);
 npcm7xx_init_error:
diff --git a/drivers/clk/clk-scmi.c b/drivers/clk/clk-scmi.c
index c65d30bba700..9d9eed597617 100644
--- a/drivers/clk/clk-scmi.c
+++ b/drivers/clk/clk-scmi.c
@@ -170,6 +170,7 @@ static int scmi_clocks_probe(struct scmi_device *sdev)
 		sclk->info = handle->clk_ops->info_get(handle, idx);
 		if (!sclk->info) {
 			dev_dbg(dev, "invalid clock info for idx %d\n", idx);
+			devm_kfree(dev, sclk);
 			continue;
 		}
 
diff --git a/drivers/clk/keystone/pll.c b/drivers/clk/keystone/pll.c
index 526694c2a6c9..a75ece599239 100644
--- a/drivers/clk/keystone/pll.c
+++ b/drivers/clk/keystone/pll.c
@@ -285,12 +285,13 @@ static void __init of_pll_div_clk_init(struct device_node *node)
 
 	clk = clk_register_divider(NULL, clk_name, parent_name, 0, reg, shift,
 				 mask, 0, NULL);
-	if (clk) {
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	} else {
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering divider %s\n", __func__, clk_name);
 		iounmap(reg);
+		return;
 	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_divider_clock, "ti,keystone,pll-divider-clock", of_pll_div_clk_init);
 
@@ -332,9 +333,11 @@ static void __init of_pll_mux_clk_init(struct device_node *node)
 	clk = clk_register_mux(NULL, clk_name, (const char **)&parents,
 				ARRAY_SIZE(parents) , 0, reg, shift, mask,
 				0, NULL);
-	if (clk)
-		of_clk_add_provider(node, of_clk_src_simple_get, clk);
-	else
+	if (IS_ERR(clk)) {
 		pr_err("%s: error registering mux %s\n", __func__, clk_name);
+		return;
+	}
+
+	of_clk_add_provider(node, of_clk_src_simple_get, clk);
 }
 CLK_OF_DECLARE(pll_mux_clock, "ti,keystone,pll-mux-clock", of_pll_mux_clk_init);
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index 4dda8988b2f0..00e52a94e34f 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -688,6 +688,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_fixed_clks(top_fixed_clks, ARRAY_SIZE(top_fixed_clks),
 								clk_data);
@@ -755,6 +757,8 @@ static void __init mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -781,6 +785,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
@@ -909,6 +915,8 @@ static int mtk_pericfg_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_PERI_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
 						clk_data);
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 5702bc974ed9..1ee45f32c1d4 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -396,6 +396,8 @@ static int mtk_topckgen_init(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	clk_data = mtk_alloc_clk_data(CLK_TOP_NR);
+	if (!clk_data)
+		return -ENOMEM;
 
 	mtk_clk_register_factors(top_fixed_divs, ARRAY_SIZE(top_fixed_divs),
 				 clk_data);
@@ -554,6 +556,8 @@ static void mtk_infrasys_init_early(struct device_node *node)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return;
 
 		for (i = 0; i < CLK_INFRA_NR; i++)
 			infra_clk_data->clks[i] = ERR_PTR(-EPROBE_DEFER);
@@ -578,6 +582,8 @@ static int mtk_infrasys_init(struct platform_device *pdev)
 
 	if (!infra_clk_data) {
 		infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR);
+		if (!infra_clk_data)
+			return -ENOMEM;
 	} else {
 		for (i = 0; i < CLK_INFRA_NR; i++) {
 			if (infra_clk_data->clks[i] == ERR_PTR(-EPROBE_DEFER))
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 04bd29d6aba1..8ac8915903e2 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -132,17 +132,11 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
-	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
-	}
+	if (hid_div)
+		rate = mult_frac(rate, 2, hid_div + 1);
 
-	if (mode) {
-		u64 tmp = rate;
-		tmp *= m;
-		do_div(tmp, n);
-		rate = tmp;
-	}
+	if (mode)
+		rate = mult_frac(rate, m, n);
 
 	return rate;
 }
diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 08ed3ff8b255..360e15339170 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -2071,7 +2071,7 @@ static void chtls_rx_ack(struct sock *sk, struct sk_buff *skb)
 
 		if (tp->snd_una != snd_una) {
 			tp->snd_una = snd_una;
-			tp->rcv_tstamp = tcp_time_stamp(tp);
+			tp->rcv_tstamp = tcp_jiffies32;
 			if (tp->snd_una == tp->snd_nxt &&
 			    !csk_flag_nochk(csk, CSK_TX_FAILOVER))
 				csk_reset_flag(csk, CSK_TX_WAIT_IDLE);
diff --git a/drivers/dma/pxa_dma.c b/drivers/dma/pxa_dma.c
index c54986902b9d..6dfd08dadb12 100644
--- a/drivers/dma/pxa_dma.c
+++ b/drivers/dma/pxa_dma.c
@@ -772,7 +772,6 @@ static void pxad_free_desc(struct virt_dma_desc *vd)
 	dma_addr_t dma;
 	struct pxad_desc_sw *sw_desc = to_pxad_sw_desc(vd);
 
-	BUG_ON(sw_desc->nb_desc == 0);
 	for (i = sw_desc->nb_desc - 1; i >= 0; i--) {
 		if (i > 0)
 			dma = sw_desc->hw_desc[i - 1]->ddadr;
diff --git a/drivers/dma/ti/edma.c b/drivers/dma/ti/edma.c
index 44158fa85973..3a1b37971bef 100644
--- a/drivers/dma/ti/edma.c
+++ b/drivers/dma/ti/edma.c
@@ -2303,7 +2303,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 0);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_irq_handler, 0, irq_name,
@@ -2319,7 +2319,7 @@ static int edma_probe(struct platform_device *pdev)
 	if (irq < 0 && node)
 		irq = irq_of_parse_and_map(node, 2);
 
-	if (irq >= 0) {
+	if (irq > 0) {
 		irq_name = devm_kasprintf(dev, GFP_KERNEL, "%s_ccerrint",
 					  dev_name(dev));
 		ret = devm_request_irq(dev, irq, dma_ccerr_handler, 0, irq_name,
diff --git a/drivers/firmware/ti_sci.c b/drivers/firmware/ti_sci.c
index 5e35a66ed0ae..46acc6440b9a 100644
--- a/drivers/firmware/ti_sci.c
+++ b/drivers/firmware/ti_sci.c
@@ -205,19 +205,6 @@ static int ti_sci_debugfs_create(struct platform_device *pdev,
 	return 0;
 }
 
-/**
- * ti_sci_debugfs_destroy() - clean up log debug file
- * @pdev:	platform device pointer
- * @info:	Pointer to SCI entity information
- */
-static void ti_sci_debugfs_destroy(struct platform_device *pdev,
-				   struct ti_sci_info *info)
-{
-	if (IS_ERR(info->debug_region))
-		return;
-
-	debugfs_remove(info->d);
-}
 #else /* CONFIG_DEBUG_FS */
 static inline int ti_sci_debugfs_create(struct platform_device *dev,
 					struct ti_sci_info *info)
@@ -1937,43 +1924,12 @@ static int ti_sci_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int ti_sci_remove(struct platform_device *pdev)
-{
-	struct ti_sci_info *info;
-	struct device *dev = &pdev->dev;
-	int ret = 0;
-
-	of_platform_depopulate(dev);
-
-	info = platform_get_drvdata(pdev);
-
-	if (info->nb.notifier_call)
-		unregister_restart_handler(&info->nb);
-
-	mutex_lock(&ti_sci_list_mutex);
-	if (info->users)
-		ret = -EBUSY;
-	else
-		list_del(&info->node);
-	mutex_unlock(&ti_sci_list_mutex);
-
-	if (!ret) {
-		ti_sci_debugfs_destroy(pdev, info);
-
-		/* Safe to free channels since no more users */
-		mbox_free_channel(info->chan_tx);
-		mbox_free_channel(info->chan_rx);
-	}
-
-	return ret;
-}
-
 static struct platform_driver ti_sci_driver = {
 	.probe = ti_sci_probe,
-	.remove = ti_sci_remove,
 	.driver = {
 		   .name = "ti-sci",
 		   .of_match_table = of_match_ptr(ti_sci_of_match),
+		   .suppress_bind_attrs = true,
 	},
 };
 module_platform_driver(ti_sci_driver);
diff --git a/drivers/gpu/drm/radeon/evergreen.c b/drivers/gpu/drm/radeon/evergreen.c
index 5712d63dca20..da728f7fc42b 100644
--- a/drivers/gpu/drm/radeon/evergreen.c
+++ b/drivers/gpu/drm/radeon/evergreen.c
@@ -4815,14 +4815,15 @@ int evergreen_irq_process(struct radeon_device *rdev)
 			break;
 		case 44: /* hdmi */
 			afmt_idx = src_data;
-			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
-				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
-
 			if (afmt_idx > 5) {
 				DRM_ERROR("Unhandled interrupt: %d %d\n",
 					  src_id, src_data);
 				break;
 			}
+
+			if (!(afmt_status[afmt_idx] & AFMT_AZ_FORMAT_WTRIG))
+				DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
+
 			afmt_status[afmt_idx] &= ~AFMT_AZ_FORMAT_WTRIG;
 			queue_hdmi = true;
 			DRM_DEBUG("IH: HDMI%d\n", afmt_idx + 1);
diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/rockchip/cdn-dp-core.c
index 3f992e5a75c9..579652f8b42b 100644
--- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
+++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c
@@ -1156,6 +1156,7 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	struct cdn_dp_device *dp;
 	struct extcon_dev *extcon;
 	struct phy *phy;
+	int ret;
 	int i;
 
 	dp = devm_kzalloc(dev, sizeof(*dp), GFP_KERNEL);
@@ -1196,9 +1197,19 @@ static int cdn_dp_probe(struct platform_device *pdev)
 	mutex_init(&dp->lock);
 	dev_set_drvdata(dev, dp);
 
-	cdn_dp_audio_codec_init(dp, dev);
+	ret = cdn_dp_audio_codec_init(dp, dev);
+	if (ret)
+		return ret;
+
+	ret = component_add(dev, &cdn_dp_component_ops);
+	if (ret)
+		goto err_audio_deinit;
 
-	return component_add(dev, &cdn_dp_component_ops);
+	return 0;
+
+err_audio_deinit:
+	platform_device_unregister(dp->audio_pdev);
+	return ret;
 }
 
 static int cdn_dp_remove(struct platform_device *pdev)
diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
index 69eb0de9973f..ea692046be61 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop.c
@@ -1091,7 +1091,8 @@ static struct drm_crtc_state *vop_crtc_duplicate_state(struct drm_crtc *crtc)
 	if (WARN_ON(!crtc->state))
 		return NULL;
 
-	rockchip_state = kzalloc(sizeof(*rockchip_state), GFP_KERNEL);
+	rockchip_state = kmemdup(to_rockchip_crtc_state(crtc->state),
+				 sizeof(*rockchip_state), GFP_KERNEL);
 	if (!rockchip_state)
 		return NULL;
 
diff --git a/drivers/hid/hid-cp2112.c b/drivers/hid/hid-cp2112.c
index 637a7ce281c6..6dc9ee8adb65 100644
--- a/drivers/hid/hid-cp2112.c
+++ b/drivers/hid/hid-cp2112.c
@@ -1163,8 +1163,6 @@ static unsigned int cp2112_gpio_irq_startup(struct irq_data *d)
 	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
 	struct cp2112_device *dev = gpiochip_get_data(gc);
 
-	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
-
 	if (!dev->gpio_poll) {
 		dev->gpio_poll = true;
 		schedule_delayed_work(&dev->gpio_poll_worker, 0);
@@ -1245,6 +1243,7 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	struct cp2112_device *dev;
 	u8 buf[3];
 	struct cp2112_smbus_config_report config;
+	struct gpio_irq_chip *girq;
 	int ret;
 
 	dev = devm_kzalloc(&hdev->dev, sizeof(*dev), GFP_KERNEL);
@@ -1348,6 +1347,17 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	dev->gc.can_sleep		= 1;
 	dev->gc.parent			= &hdev->dev;
 
+	girq = &dev->gc.irq;
+	girq->chip = &cp2112_gpio_irqchip;
+	/* The event comes from the outside so no parent handler */
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_simple_irq;
+
+	INIT_DELAYED_WORK(&dev->gpio_poll_worker, cp2112_gpio_poll_callback);
+
 	ret = gpiochip_add_data(&dev->gc, dev);
 	if (ret < 0) {
 		hid_err(hdev, "error registering gpio chip\n");
@@ -1363,17 +1373,8 @@ static int cp2112_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	chmod_sysfs_attrs(hdev);
 	hid_hw_power(hdev, PM_HINT_NORMAL);
 
-	ret = gpiochip_irqchip_add(&dev->gc, &cp2112_gpio_irqchip, 0,
-				   handle_simple_irq, IRQ_TYPE_NONE);
-	if (ret) {
-		dev_err(dev->gc.parent, "failed to add IRQ chip\n");
-		goto err_sysfs_remove;
-	}
-
 	return ret;
 
-err_sysfs_remove:
-	sysfs_remove_group(&hdev->dev.kobj, &cp2112_attr_group);
 err_gpiochip_remove:
 	gpiochip_remove(&dev->gc);
 err_free_i2c:
diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1b2f750577da..33371f7a4c0f 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -54,7 +54,7 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 #define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
 #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
-#define CORETEMP_NAME_LENGTH	19	/* String Length of attrs */
+#define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
 #define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
 #define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
 #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
diff --git a/drivers/infiniband/hw/hfi1/efivar.c b/drivers/infiniband/hw/hfi1/efivar.c
index d106d23016ba..75e39e403a58 100644
--- a/drivers/infiniband/hw/hfi1/efivar.c
+++ b/drivers/infiniband/hw/hfi1/efivar.c
@@ -152,7 +152,7 @@ int read_hfi1_efi_var(struct hfi1_devdata *dd, const char *kind,
 		      unsigned long *size, void **return_data)
 {
 	char prefix_name[64];
-	char name[64];
+	char name[128];
 	int result;
 	int i;
 
diff --git a/drivers/input/rmi4/rmi_bus.c b/drivers/input/rmi4/rmi_bus.c
index bd0d5ff01b08..02408487b442 100644
--- a/drivers/input/rmi4/rmi_bus.c
+++ b/drivers/input/rmi4/rmi_bus.c
@@ -279,11 +279,11 @@ void rmi_unregister_function(struct rmi_function *fn)
 
 	device_del(&fn->dev);
 	of_node_put(fn->dev.of_node);
-	put_device(&fn->dev);
 
 	for (i = 0; i < fn->num_of_irqs; i++)
 		irq_dispose_mapping(fn->irq[i]);
 
+	put_device(&fn->dev);
 }
 
 /**
diff --git a/drivers/leds/leds-pwm.c b/drivers/leds/leds-pwm.c
index 5d3faae51d59..107e635cac24 100644
--- a/drivers/leds/leds-pwm.c
+++ b/drivers/leds/leds-pwm.c
@@ -25,9 +25,8 @@
 struct led_pwm_data {
 	struct led_classdev	cdev;
 	struct pwm_device	*pwm;
+	struct pwm_state	pwmstate;
 	unsigned int		active_low;
-	unsigned int		period;
-	int			duty;
 };
 
 struct led_pwm_priv {
@@ -35,37 +34,23 @@ struct led_pwm_priv {
 	struct led_pwm_data leds[0];
 };
 
-static void __led_pwm_set(struct led_pwm_data *led_dat)
-{
-	int new_duty = led_dat->duty;
-
-	pwm_config(led_dat->pwm, new_duty, led_dat->period);
-
-	if (new_duty == 0)
-		pwm_disable(led_dat->pwm);
-	else
-		pwm_enable(led_dat->pwm);
-}
-
 static int led_pwm_set(struct led_classdev *led_cdev,
 		       enum led_brightness brightness)
 {
 	struct led_pwm_data *led_dat =
 		container_of(led_cdev, struct led_pwm_data, cdev);
 	unsigned int max = led_dat->cdev.max_brightness;
-	unsigned long long duty =  led_dat->period;
+	unsigned long long duty = led_dat->pwmstate.period;
 
 	duty *= brightness;
 	do_div(duty, max);
 
 	if (led_dat->active_low)
-		duty = led_dat->period - duty;
-
-	led_dat->duty = duty;
-
-	__led_pwm_set(led_dat);
+		duty = led_dat->pwmstate.period - duty;
 
-	return 0;
+	led_dat->pwmstate.duty_cycle = duty;
+	led_dat->pwmstate.enabled = true;
+	return pwm_apply_state(led_dat->pwm, &led_dat->pwmstate);
 }
 
 static inline size_t sizeof_pwm_leds_priv(int num_leds)
@@ -84,7 +69,6 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 		       struct led_pwm *led, struct device_node *child)
 {
 	struct led_pwm_data *led_data = &priv->leds[priv->num_leds];
-	struct pwm_args pargs;
 	int ret;
 
 	led_data->active_low = led->active_low;
@@ -108,17 +92,10 @@ static int led_pwm_add(struct device *dev, struct led_pwm_priv *priv,
 
 	led_data->cdev.brightness_set_blocking = led_pwm_set;
 
-	/*
-	 * FIXME: pwm_apply_args() should be removed when switching to the
-	 * atomic PWM API.
-	 */
-	pwm_apply_args(led_data->pwm);
-
-	pwm_get_args(led_data->pwm, &pargs);
+	pwm_init_state(led_data->pwm, &led_data->pwmstate);
 
-	led_data->period = pargs.period;
-	if (!led_data->period && (led->pwm_period_ns > 0))
-		led_data->period = led->pwm_period_ns;
+	if (!led_data->pwmstate.period)
+		led_data->pwmstate.period = led->pwm_period_ns;
 
 	ret = led_classdev_register(dev, &led_data->cdev);
 	if (ret == 0) {
diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index 66a626091936..19e068cadedf 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -1,14 +1,18 @@
 /*
  * ledtrig-cpu.c - LED trigger based on CPU activity
  *
- * This LED trigger will be registered for each possible CPU and named as
- * cpu0, cpu1, cpu2, cpu3, etc.
+ * This LED trigger will be registered for first 8 CPUs and named
+ * as cpu0..cpu7. There's additional trigger called cpu that
+ * is on when any CPU is active.
+ *
+ * If you want support for arbitrary number of CPUs, make it one trigger,
+ * with additional sysfs file selecting which CPU to watch.
  *
  * It can be bound to any LED just like other triggers using either a
  * board file or via sysfs interface.
  *
  * An API named ledtrig_cpu is exported for any user, who want to add CPU
- * activity indication in their code
+ * activity indication in their code.
  *
  * Copyright 2011 Linus Walleij <linus.walleij@linaro.org>
  * Copyright 2011 - 2012 Bryan Wu <bryan.wu@canonical.com>
@@ -130,7 +134,7 @@ static int ledtrig_prepare_down_cpu(unsigned int cpu)
 
 static int __init ledtrig_cpu_init(void)
 {
-	int cpu;
+	unsigned int cpu;
 	int ret;
 
 	/* Supports up to 9999 cpu cores */
@@ -149,7 +153,10 @@ static int __init ledtrig_cpu_init(void)
 	for_each_possible_cpu(cpu) {
 		struct led_trigger_cpu *trig = &per_cpu(cpu_trig, cpu);
 
-		snprintf(trig->name, MAX_NAME_LEN, "cpu%d", cpu);
+		if (cpu >= 8)
+			continue;
+
+		snprintf(trig->name, MAX_NAME_LEN, "cpu%u", cpu);
 
 		led_trigger_register_simple(trig->name, &trig->_trig);
 	}
diff --git a/drivers/media/pci/bt8xx/bttv-driver.c b/drivers/media/pci/bt8xx/bttv-driver.c
index 2a9d25431d73..fce894574c41 100644
--- a/drivers/media/pci/bt8xx/bttv-driver.c
+++ b/drivers/media/pci/bt8xx/bttv-driver.c
@@ -4300,6 +4300,7 @@ static void bttv_remove(struct pci_dev *pci_dev)
 
 	/* free resources */
 	free_irq(btv->c.pci->irq,btv);
+	del_timer_sync(&btv->timeout);
 	iounmap(btv->bt848_mmio);
 	release_mem_region(pci_resource_start(btv->c.pci,0),
 			   pci_resource_len(btv->c.pci,0));
diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/media/platform/s3c-camif/camif-capture.c
index c02dce8b4c6c..6e150fc64e0a 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1142,12 +1142,12 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 
 	ret = vb2_queue_init(q);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	vp->pad.flags = MEDIA_PAD_FL_SINK;
 	ret = media_entity_pads_init(&vfd->entity, 1, &vp->pad);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	video_set_drvdata(vfd, vp);
 
@@ -1179,8 +1179,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 	v4l2_ctrl_handler_free(&vp->ctrl_handler);
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
-err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
diff --git a/drivers/media/usb/dvb-usb-v2/af9035.c b/drivers/media/usb/dvb-usb-v2/af9035.c
index 8a83f27875ec..2ed29a99fee1 100644
--- a/drivers/media/usb/dvb-usb-v2/af9035.c
+++ b/drivers/media/usb/dvb-usb-v2/af9035.c
@@ -337,8 +337,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3 || msg[1].len < 1)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3 || msg[1].len < 1) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -398,8 +400,10 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 			ret = -EOPNOTSUPP;
 		} else if ((msg[0].addr == state->af9033_i2c_addr[0]) ||
 			   (msg[0].addr == state->af9033_i2c_addr[1])) {
-			if (msg[0].len < 3)
-				return -EOPNOTSUPP;
+			if (msg[0].len < 3) {
+				ret = -EOPNOTSUPP;
+				goto unlock;
+			}
 			/* demod access via firmware interface */
 			reg = msg[0].buf[0] << 16 | msg[0].buf[1] << 8 |
 					msg[0].buf[2];
@@ -474,6 +478,7 @@ static int af9035_i2c_master_xfer(struct i2c_adapter *adap,
 		ret = -EOPNOTSUPP;
 	}
 
+unlock:
 	mutex_unlock(&d->i2c_mutex);
 
 	if (ret < 0)
diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
index 37217e01f27c..fe614ba5fec9 100644
--- a/drivers/mfd/dln2.c
+++ b/drivers/mfd/dln2.c
@@ -800,7 +800,6 @@ static int dln2_probe(struct usb_interface *interface,
 	dln2_stop_rx_urbs(dln2);
 
 out_free:
-	usb_put_dev(dln2->usb_dev);
 	dln2_free(dln2);
 
 	return ret;
diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
index eda8d407be28..e5fbd61f69c8 100644
--- a/drivers/misc/ti-st/st_core.c
+++ b/drivers/misc/ti-st/st_core.c
@@ -28,6 +28,7 @@
 #include <linux/skbuff.h>
 
 #include <linux/ti_wilink_st.h>
+#include <linux/netdevice.h>
 
 extern void st_kim_recv(void *, const unsigned char *, long);
 void st_int_recv(void *, const unsigned char *, long);
@@ -436,7 +437,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	case ST_LL_AWAKE_TO_ASLEEP:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	case ST_LL_ASLEEP:
 		skb_queue_tail(&st_gdata->tx_waitq, skb);
@@ -445,7 +446,7 @@ static void st_int_enqueue(struct st_data_s *st_gdata, struct sk_buff *skb)
 	default:
 		pr_err("ST LL is illegal state(%ld),"
 			   "purging received skb.", st_ll_getstate(st_gdata));
-		kfree_skb(skb);
+		dev_kfree_skb_irq(skb);
 		break;
 	}
 
@@ -499,7 +500,7 @@ void st_tx_wakeup(struct st_data_s *st_data)
 				spin_unlock_irqrestore(&st_data->lock, flags);
 				break;
 			}
-			kfree_skb(skb);
+			dev_kfree_skb_irq(skb);
 			spin_unlock_irqrestore(&st_data->lock, flags);
 		}
 		/* if wake-up is set in another context- restart sending */
diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index 20856a7734a9..745a4b07faff 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -98,7 +98,7 @@ static int mmc_decode_cid(struct mmc_card *card)
 	case 3: /* MMC v3.1 - v3.3 */
 	case 4: /* MMC v4 */
 		card->cid.manfid	= UNSTUFF_BITS(resp, 120, 8);
-		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 8);
+		card->cid.oemid		= UNSTUFF_BITS(resp, 104, 16);
 		card->cid.prod_name[0]	= UNSTUFF_BITS(resp, 96, 8);
 		card->cid.prod_name[1]	= UNSTUFF_BITS(resp, 88, 8);
 		card->cid.prod_name[2]	= UNSTUFF_BITS(resp, 80, 8);
diff --git a/drivers/net/can/Makefile b/drivers/net/can/Makefile
index 44922bf29b6a..93e11f1fee5c 100644
--- a/drivers/net/can/Makefile
+++ b/drivers/net/can/Makefile
@@ -7,12 +7,7 @@ obj-$(CONFIG_CAN_VCAN)		+= vcan.o
 obj-$(CONFIG_CAN_VXCAN)		+= vxcan.o
 obj-$(CONFIG_CAN_SLCAN)		+= slcan.o
 
-obj-$(CONFIG_CAN_DEV)		+= can-dev.o
-can-dev-y			+= dev.o
-can-dev-y			+= rx-offload.o
-
-can-dev-$(CONFIG_CAN_LEDS)	+= led.o
-
+obj-y				+= dev/
 obj-y				+= rcar/
 obj-y				+= spi/
 obj-y				+= usb/
diff --git a/drivers/net/can/dev.c b/drivers/net/can/dev.c
deleted file mode 100644
index 8738d37f7273..000000000000
--- a/drivers/net/can/dev.c
+++ /dev/null
@@ -1,1324 +0,0 @@
-/*
- * Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
- * Copyright (C) 2006 Andrey Volkov, Varma Electronics
- * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the version 2 of the GNU General Public License
- * as published by the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/netdevice.h>
-#include <linux/if_arp.h>
-#include <linux/workqueue.h>
-#include <linux/can.h>
-#include <linux/can/dev.h>
-#include <linux/can/skb.h>
-#include <linux/can/netlink.h>
-#include <linux/can/led.h>
-#include <linux/of.h>
-#include <net/rtnetlink.h>
-
-#define MOD_DESC "CAN device driver interface"
-
-MODULE_DESCRIPTION(MOD_DESC);
-MODULE_LICENSE("GPL v2");
-MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
-
-/* CAN DLC to real data length conversion helpers */
-
-static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
-			     8, 12, 16, 20, 24, 32, 48, 64};
-
-/* get data length from can_dlc with sanitized can_dlc */
-u8 can_dlc2len(u8 can_dlc)
-{
-	return dlc2len[can_dlc & 0x0F];
-}
-EXPORT_SYMBOL_GPL(can_dlc2len);
-
-static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
-			     9, 9, 9, 9,			/* 9 - 12 */
-			     10, 10, 10, 10,			/* 13 - 16 */
-			     11, 11, 11, 11,			/* 17 - 20 */
-			     12, 12, 12, 12,			/* 21 - 24 */
-			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
-			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
-			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
-			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
-
-/* map the sanitized data length to an appropriate data length code */
-u8 can_len2dlc(u8 len)
-{
-	if (unlikely(len > 64))
-		return 0xF;
-
-	return len2dlc[len];
-}
-EXPORT_SYMBOL_GPL(can_len2dlc);
-
-#ifdef CONFIG_CAN_CALC_BITTIMING
-#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
-#define CAN_CALC_SYNC_SEG 1
-
-/*
- * Bit-timing calculation derived from:
- *
- * Code based on LinCAN sources and H8S2638 project
- * Copyright 2004-2006 Pavel Pisa - DCE FELK CVUT cz
- * Copyright 2005      Stanislav Marek
- * email: pisa@cmp.felk.cvut.cz
- *
- * Calculates proper bit-timing parameters for a specified bit-rate
- * and sample-point, which can then be used to set the bit-timing
- * registers of the CAN controller. You can find more information
- * in the header file linux/can/netlink.h.
- */
-static int can_update_sample_point(const struct can_bittiming_const *btc,
-			  unsigned int sample_point_nominal, unsigned int tseg,
-			  unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
-			  unsigned int *sample_point_error_ptr)
-{
-	unsigned int sample_point_error, best_sample_point_error = UINT_MAX;
-	unsigned int sample_point, best_sample_point = 0;
-	unsigned int tseg1, tseg2;
-	int i;
-
-	for (i = 0; i <= 1; i++) {
-		tseg2 = tseg + CAN_CALC_SYNC_SEG - (sample_point_nominal * (tseg + CAN_CALC_SYNC_SEG)) / 1000 - i;
-		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
-		tseg1 = tseg - tseg2;
-		if (tseg1 > btc->tseg1_max) {
-			tseg1 = btc->tseg1_max;
-			tseg2 = tseg - tseg1;
-		}
-
-		sample_point = 1000 * (tseg + CAN_CALC_SYNC_SEG - tseg2) / (tseg + CAN_CALC_SYNC_SEG);
-		sample_point_error = abs(sample_point_nominal - sample_point);
-
-		if ((sample_point <= sample_point_nominal) && (sample_point_error < best_sample_point_error)) {
-			best_sample_point = sample_point;
-			best_sample_point_error = sample_point_error;
-			*tseg1_ptr = tseg1;
-			*tseg2_ptr = tseg2;
-		}
-	}
-
-	if (sample_point_error_ptr)
-		*sample_point_error_ptr = best_sample_point_error;
-
-	return best_sample_point;
-}
-
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
-			      const struct can_bittiming_const *btc)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	unsigned int bitrate;			/* current bitrate */
-	unsigned int bitrate_error;		/* difference between current and nominal value */
-	unsigned int best_bitrate_error = UINT_MAX;
-	unsigned int sample_point_error;	/* difference between current and nominal value */
-	unsigned int best_sample_point_error = UINT_MAX;
-	unsigned int sample_point_nominal;	/* nominal sample point */
-	unsigned int best_tseg = 0;		/* current best value for tseg */
-	unsigned int best_brp = 0;		/* current best value for brp */
-	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
-	u64 v64;
-
-	/* Use CiA recommended sample points */
-	if (bt->sample_point) {
-		sample_point_nominal = bt->sample_point;
-	} else {
-		if (bt->bitrate > 800000)
-			sample_point_nominal = 750;
-		else if (bt->bitrate > 500000)
-			sample_point_nominal = 800;
-		else
-			sample_point_nominal = 875;
-	}
-
-	/* tseg even = round down, odd = round up */
-	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
-	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
-		tsegall = CAN_CALC_SYNC_SEG + tseg / 2;
-
-		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
-		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
-
-		/* choose brp step which is possible in system */
-		brp = (brp / btc->brp_inc) * btc->brp_inc;
-		if ((brp < btc->brp_min) || (brp > btc->brp_max))
-			continue;
-
-		bitrate = priv->clock.freq / (brp * tsegall);
-		bitrate_error = abs(bt->bitrate - bitrate);
-
-		/* tseg brp biterror */
-		if (bitrate_error > best_bitrate_error)
-			continue;
-
-		/* reset sample point error if we have a better bitrate */
-		if (bitrate_error < best_bitrate_error)
-			best_sample_point_error = UINT_MAX;
-
-		can_update_sample_point(btc, sample_point_nominal, tseg / 2, &tseg1, &tseg2, &sample_point_error);
-		if (sample_point_error > best_sample_point_error)
-			continue;
-
-		best_sample_point_error = sample_point_error;
-		best_bitrate_error = bitrate_error;
-		best_tseg = tseg / 2;
-		best_brp = brp;
-
-		if (bitrate_error == 0 && sample_point_error == 0)
-			break;
-	}
-
-	if (best_bitrate_error) {
-		/* Error in one-tenth of a percent */
-		v64 = (u64)best_bitrate_error * 1000;
-		do_div(v64, bt->bitrate);
-		bitrate_error = (u32)v64;
-		if (bitrate_error > CAN_CALC_MAX_ERROR) {
-			netdev_err(dev,
-				   "bitrate error %d.%d%% too high\n",
-				   bitrate_error / 10, bitrate_error % 10);
-			return -EDOM;
-		}
-		netdev_warn(dev, "bitrate error %d.%d%%\n",
-			    bitrate_error / 10, bitrate_error % 10);
-	}
-
-	/* real sample point */
-	bt->sample_point = can_update_sample_point(btc, sample_point_nominal, best_tseg,
-					  &tseg1, &tseg2, NULL);
-
-	v64 = (u64)best_brp * 1000 * 1000 * 1000;
-	do_div(v64, priv->clock.freq);
-	bt->tq = (u32)v64;
-	bt->prop_seg = tseg1 / 2;
-	bt->phase_seg1 = tseg1 - bt->prop_seg;
-	bt->phase_seg2 = tseg2;
-
-	/* check for sjw user settings */
-	if (!bt->sjw || !btc->sjw_max) {
-		bt->sjw = 1;
-	} else {
-		/* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
-		if (bt->sjw > btc->sjw_max)
-			bt->sjw = btc->sjw_max;
-		/* bt->sjw must not be higher than tseg2 */
-		if (tseg2 < bt->sjw)
-			bt->sjw = tseg2;
-	}
-
-	bt->brp = best_brp;
-
-	/* real bitrate */
-	bt->bitrate = priv->clock.freq / (bt->brp * (CAN_CALC_SYNC_SEG + tseg1 + tseg2));
-
-	return 0;
-}
-#else /* !CONFIG_CAN_CALC_BITTIMING */
-static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
-			      const struct can_bittiming_const *btc)
-{
-	netdev_err(dev, "bit-timing calculation not available\n");
-	return -EINVAL;
-}
-#endif /* CONFIG_CAN_CALC_BITTIMING */
-
-/*
- * Checks the validity of the specified bit-timing parameters prop_seg,
- * phase_seg1, phase_seg2 and sjw and tries to determine the bitrate
- * prescaler value brp. You can find more information in the header
- * file linux/can/netlink.h.
- */
-static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
-			       const struct can_bittiming_const *btc)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	int tseg1, alltseg;
-	u64 brp64;
-
-	tseg1 = bt->prop_seg + bt->phase_seg1;
-	if (!bt->sjw)
-		bt->sjw = 1;
-	if (bt->sjw > btc->sjw_max ||
-	    tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
-	    bt->phase_seg2 < btc->tseg2_min || bt->phase_seg2 > btc->tseg2_max)
-		return -ERANGE;
-
-	brp64 = (u64)priv->clock.freq * (u64)bt->tq;
-	if (btc->brp_inc > 1)
-		do_div(brp64, btc->brp_inc);
-	brp64 += 500000000UL - 1;
-	do_div(brp64, 1000000000UL); /* the practicable BRP */
-	if (btc->brp_inc > 1)
-		brp64 *= btc->brp_inc;
-	bt->brp = (u32)brp64;
-
-	if (bt->brp < btc->brp_min || bt->brp > btc->brp_max)
-		return -EINVAL;
-
-	alltseg = bt->prop_seg + bt->phase_seg1 + bt->phase_seg2 + 1;
-	bt->bitrate = priv->clock.freq / (bt->brp * alltseg);
-	bt->sample_point = ((tseg1 + 1) * 1000) / alltseg;
-
-	return 0;
-}
-
-/* Checks the validity of predefined bitrate settings */
-static int can_validate_bitrate(struct net_device *dev, struct can_bittiming *bt,
-				const u32 *bitrate_const,
-				const unsigned int bitrate_const_cnt)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	unsigned int i;
-
-	for (i = 0; i < bitrate_const_cnt; i++) {
-		if (bt->bitrate == bitrate_const[i])
-			break;
-	}
-
-	if (i >= priv->bitrate_const_cnt)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
-			     const struct can_bittiming_const *btc,
-			     const u32 *bitrate_const,
-			     const unsigned int bitrate_const_cnt)
-{
-	int err;
-
-	/*
-	 * Depending on the given can_bittiming parameter structure the CAN
-	 * timing parameters are calculated based on the provided bitrate OR
-	 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
-	 * provided directly which are then checked and fixed up.
-	 */
-	if (!bt->tq && bt->bitrate && btc)
-		err = can_calc_bittiming(dev, bt, btc);
-	else if (bt->tq && !bt->bitrate && btc)
-		err = can_fixup_bittiming(dev, bt, btc);
-	else if (!bt->tq && bt->bitrate && bitrate_const)
-		err = can_validate_bitrate(dev, bt, bitrate_const,
-					   bitrate_const_cnt);
-	else
-		err = -EINVAL;
-
-	return err;
-}
-
-static void can_update_state_error_stats(struct net_device *dev,
-					 enum can_state new_state)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	if (new_state <= priv->state)
-		return;
-
-	switch (new_state) {
-	case CAN_STATE_ERROR_WARNING:
-		priv->can_stats.error_warning++;
-		break;
-	case CAN_STATE_ERROR_PASSIVE:
-		priv->can_stats.error_passive++;
-		break;
-	case CAN_STATE_BUS_OFF:
-		priv->can_stats.bus_off++;
-		break;
-	default:
-		break;
-	}
-}
-
-static int can_tx_state_to_frame(struct net_device *dev, enum can_state state)
-{
-	switch (state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		return CAN_ERR_CRTL_ACTIVE;
-	case CAN_STATE_ERROR_WARNING:
-		return CAN_ERR_CRTL_TX_WARNING;
-	case CAN_STATE_ERROR_PASSIVE:
-		return CAN_ERR_CRTL_TX_PASSIVE;
-	default:
-		return 0;
-	}
-}
-
-static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
-{
-	switch (state) {
-	case CAN_STATE_ERROR_ACTIVE:
-		return CAN_ERR_CRTL_ACTIVE;
-	case CAN_STATE_ERROR_WARNING:
-		return CAN_ERR_CRTL_RX_WARNING;
-	case CAN_STATE_ERROR_PASSIVE:
-		return CAN_ERR_CRTL_RX_PASSIVE;
-	default:
-		return 0;
-	}
-}
-
-void can_change_state(struct net_device *dev, struct can_frame *cf,
-		      enum can_state tx_state, enum can_state rx_state)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	enum can_state new_state = max(tx_state, rx_state);
-
-	if (unlikely(new_state == priv->state)) {
-		netdev_warn(dev, "%s: oops, state did not change", __func__);
-		return;
-	}
-
-	netdev_dbg(dev, "New error state: %d\n", new_state);
-
-	can_update_state_error_stats(dev, new_state);
-	priv->state = new_state;
-
-	if (!cf)
-		return;
-
-	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
-		cf->can_id |= CAN_ERR_BUSOFF;
-		return;
-	}
-
-	cf->can_id |= CAN_ERR_CRTL;
-	cf->data[1] |= tx_state >= rx_state ?
-		       can_tx_state_to_frame(dev, tx_state) : 0;
-	cf->data[1] |= tx_state <= rx_state ?
-		       can_rx_state_to_frame(dev, rx_state) : 0;
-}
-EXPORT_SYMBOL_GPL(can_change_state);
-
-/*
- * Local echo of CAN messages
- *
- * CAN network devices *should* support a local echo functionality
- * (see Documentation/networking/can.rst). To test the handling of CAN
- * interfaces that do not support the local echo both driver types are
- * implemented. In the case that the driver does not support the echo
- * the IFF_ECHO remains clear in dev->flags. This causes the PF_CAN core
- * to perform the echo as a fallback solution.
- */
-static void can_flush_echo_skb(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
-	int i;
-
-	for (i = 0; i < priv->echo_skb_max; i++) {
-		if (priv->echo_skb[i]) {
-			kfree_skb(priv->echo_skb[i]);
-			priv->echo_skb[i] = NULL;
-			stats->tx_dropped++;
-			stats->tx_aborted_errors++;
-		}
-	}
-}
-
-/*
- * Put the skb on the stack to be looped backed locally lateron
- *
- * The function is typically called in the start_xmit function
- * of the device driver. The driver must protect access to
- * priv->echo_skb, if necessary.
- */
-void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
-		      unsigned int idx)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	BUG_ON(idx >= priv->echo_skb_max);
-
-	/* check flag whether this packet has to be looped back */
-	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
-	    (skb->protocol != htons(ETH_P_CAN) &&
-	     skb->protocol != htons(ETH_P_CANFD))) {
-		kfree_skb(skb);
-		return;
-	}
-
-	if (!priv->echo_skb[idx]) {
-
-		skb = can_create_echo_skb(skb);
-		if (!skb)
-			return;
-
-		/* make settings for echo to reduce code in irq context */
-		skb->pkt_type = PACKET_BROADCAST;
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-		skb->dev = dev;
-
-		/* save this skb for tx interrupt echo handling */
-		priv->echo_skb[idx] = skb;
-	} else {
-		/* locking problem with netif_stop_queue() ?? */
-		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
-		kfree_skb(skb);
-	}
-}
-EXPORT_SYMBOL_GPL(can_put_echo_skb);
-
-struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	if (idx >= priv->echo_skb_max) {
-		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
-			   __func__, idx, priv->echo_skb_max);
-		return NULL;
-	}
-
-	if (priv->echo_skb[idx]) {
-		/* Using "struct canfd_frame::len" for the frame
-		 * length is supported on both CAN and CANFD frames.
-		 */
-		struct sk_buff *skb = priv->echo_skb[idx];
-		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
-
-		/* get the real payload length for netdev statistics */
-		if (cf->can_id & CAN_RTR_FLAG)
-			*len_ptr = 0;
-		else
-			*len_ptr = cf->len;
-
-		priv->echo_skb[idx] = NULL;
-
-		return skb;
-	}
-
-	return NULL;
-}
-
-/*
- * Get the skb from the stack and loop it back locally
- *
- * The function is typically called when the TX done interrupt
- * is handled in the device driver. The driver must protect
- * access to priv->echo_skb, if necessary.
- */
-unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
-{
-	struct sk_buff *skb;
-	u8 len;
-
-	skb = __can_get_echo_skb(dev, idx, &len);
-	if (!skb)
-		return 0;
-
-	skb_get(skb);
-	if (netif_rx(skb) == NET_RX_SUCCESS)
-		dev_consume_skb_any(skb);
-	else
-		dev_kfree_skb_any(skb);
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(can_get_echo_skb);
-
-/*
-  * Remove the skb from the stack and free it.
-  *
-  * The function is typically called when TX failed.
-  */
-void can_free_echo_skb(struct net_device *dev, unsigned int idx)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	BUG_ON(idx >= priv->echo_skb_max);
-
-	if (priv->echo_skb[idx]) {
-		dev_kfree_skb_any(priv->echo_skb[idx]);
-		priv->echo_skb[idx] = NULL;
-	}
-}
-EXPORT_SYMBOL_GPL(can_free_echo_skb);
-
-/*
- * CAN device restart for bus-off recovery
- */
-static void can_restart(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	struct net_device_stats *stats = &dev->stats;
-	struct sk_buff *skb;
-	struct can_frame *cf;
-	int err;
-
-	BUG_ON(netif_carrier_ok(dev));
-
-	/*
-	 * No synchronization needed because the device is bus-off and
-	 * no messages can come in or go out.
-	 */
-	can_flush_echo_skb(dev);
-
-	/* send restart message upstream */
-	skb = alloc_can_err_skb(dev, &cf);
-	if (skb == NULL) {
-		err = -ENOMEM;
-		goto restart;
-	}
-	cf->can_id |= CAN_ERR_RESTARTED;
-
-	stats->rx_packets++;
-	stats->rx_bytes += cf->can_dlc;
-
-	netif_rx_ni(skb);
-
-restart:
-	netdev_dbg(dev, "restarted\n");
-	priv->can_stats.restarts++;
-
-	/* Now restart the device */
-	err = priv->do_set_mode(dev, CAN_MODE_START);
-
-	netif_carrier_on(dev);
-	if (err)
-		netdev_err(dev, "Error %d during restart", err);
-}
-
-static void can_restart_work(struct work_struct *work)
-{
-	struct delayed_work *dwork = to_delayed_work(work);
-	struct can_priv *priv = container_of(dwork, struct can_priv, restart_work);
-
-	can_restart(priv->dev);
-}
-
-int can_restart_now(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	/*
-	 * A manual restart is only permitted if automatic restart is
-	 * disabled and the device is in the bus-off state
-	 */
-	if (priv->restart_ms)
-		return -EINVAL;
-	if (priv->state != CAN_STATE_BUS_OFF)
-		return -EBUSY;
-
-	cancel_delayed_work_sync(&priv->restart_work);
-	can_restart(dev);
-
-	return 0;
-}
-
-/*
- * CAN bus-off
- *
- * This functions should be called when the device goes bus-off to
- * tell the netif layer that no more packets can be sent or received.
- * If enabled, a timer is started to trigger bus-off recovery.
- */
-void can_bus_off(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	netdev_info(dev, "bus-off\n");
-
-	netif_carrier_off(dev);
-
-	if (priv->restart_ms)
-		schedule_delayed_work(&priv->restart_work,
-				      msecs_to_jiffies(priv->restart_ms));
-}
-EXPORT_SYMBOL_GPL(can_bus_off);
-
-static void can_setup(struct net_device *dev)
-{
-	dev->type = ARPHRD_CAN;
-	dev->mtu = CAN_MTU;
-	dev->hard_header_len = 0;
-	dev->addr_len = 0;
-	dev->tx_queue_len = 10;
-
-	/* New-style flags. */
-	dev->flags = IFF_NOARP;
-	dev->features = NETIF_F_HW_CSUM;
-}
-
-struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
-{
-	struct sk_buff *skb;
-
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct can_frame));
-	if (unlikely(!skb))
-		return NULL;
-
-	skb->protocol = htons(ETH_P_CAN);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
-
-	*cf = skb_put_zero(skb, sizeof(struct can_frame));
-
-	return skb;
-}
-EXPORT_SYMBOL_GPL(alloc_can_skb);
-
-struct sk_buff *alloc_canfd_skb(struct net_device *dev,
-				struct canfd_frame **cfd)
-{
-	struct sk_buff *skb;
-
-	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
-			       sizeof(struct canfd_frame));
-	if (unlikely(!skb))
-		return NULL;
-
-	skb->protocol = htons(ETH_P_CANFD);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	skb_reset_mac_header(skb);
-	skb_reset_network_header(skb);
-	skb_reset_transport_header(skb);
-
-	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
-
-	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
-
-	return skb;
-}
-EXPORT_SYMBOL_GPL(alloc_canfd_skb);
-
-struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
-{
-	struct sk_buff *skb;
-
-	skb = alloc_can_skb(dev, cf);
-	if (unlikely(!skb))
-		return NULL;
-
-	(*cf)->can_id = CAN_ERR_FLAG;
-	(*cf)->can_dlc = CAN_ERR_DLC;
-
-	return skb;
-}
-EXPORT_SYMBOL_GPL(alloc_can_err_skb);
-
-/*
- * Allocate and setup space for the CAN network device
- */
-struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
-				    unsigned int txqs, unsigned int rxqs)
-{
-	struct net_device *dev;
-	struct can_priv *priv;
-	int size;
-
-	if (echo_skb_max)
-		size = ALIGN(sizeof_priv, sizeof(struct sk_buff *)) +
-			echo_skb_max * sizeof(struct sk_buff *);
-	else
-		size = sizeof_priv;
-
-	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
-			       txqs, rxqs);
-	if (!dev)
-		return NULL;
-
-	priv = netdev_priv(dev);
-	priv->dev = dev;
-
-	if (echo_skb_max) {
-		priv->echo_skb_max = echo_skb_max;
-		priv->echo_skb = (void *)priv +
-			ALIGN(sizeof_priv, sizeof(struct sk_buff *));
-	}
-
-	priv->state = CAN_STATE_STOPPED;
-
-	INIT_DELAYED_WORK(&priv->restart_work, can_restart_work);
-
-	return dev;
-}
-EXPORT_SYMBOL_GPL(alloc_candev_mqs);
-
-/*
- * Free space of the CAN network device
- */
-void free_candev(struct net_device *dev)
-{
-	free_netdev(dev);
-}
-EXPORT_SYMBOL_GPL(free_candev);
-
-/*
- * changing MTU and control mode for CAN/CANFD devices
- */
-int can_change_mtu(struct net_device *dev, int new_mtu)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	/* Do not allow changing the MTU while running */
-	if (dev->flags & IFF_UP)
-		return -EBUSY;
-
-	/* allow change of MTU according to the CANFD ability of the device */
-	switch (new_mtu) {
-	case CAN_MTU:
-		/* 'CANFD-only' controllers can not switch to CAN_MTU */
-		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
-			return -EINVAL;
-
-		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
-		break;
-
-	case CANFD_MTU:
-		/* check for potential CANFD ability */
-		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
-		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
-			return -EINVAL;
-
-		priv->ctrlmode |= CAN_CTRLMODE_FD;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
-	dev->mtu = new_mtu;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(can_change_mtu);
-
-/*
- * Common open function when the device gets opened.
- *
- * This function should be called in the open function of the device
- * driver.
- */
-int open_candev(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	if (!priv->bittiming.bitrate) {
-		netdev_err(dev, "bit-timing not yet defined\n");
-		return -EINVAL;
-	}
-
-	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
-	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
-	    (!priv->data_bittiming.bitrate ||
-	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {
-		netdev_err(dev, "incorrect/missing data bit-timing\n");
-		return -EINVAL;
-	}
-
-	/* Switch carrier on if device was stopped while in bus-off state */
-	if (!netif_carrier_ok(dev))
-		netif_carrier_on(dev);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(open_candev);
-
-#ifdef CONFIG_OF
-/* Common function that can be used to understand the limitation of
- * a transceiver when it provides no means to determine these limitations
- * at runtime.
- */
-void of_can_transceiver(struct net_device *dev)
-{
-	struct device_node *dn;
-	struct can_priv *priv = netdev_priv(dev);
-	struct device_node *np = dev->dev.parent->of_node;
-	int ret;
-
-	dn = of_get_child_by_name(np, "can-transceiver");
-	if (!dn)
-		return;
-
-	ret = of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
-	of_node_put(dn);
-	if ((ret && ret != -EINVAL) || (!ret && !priv->bitrate_max))
-		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
-}
-EXPORT_SYMBOL_GPL(of_can_transceiver);
-#endif
-
-/*
- * Common close function for cleanup before the device gets closed.
- *
- * This function should be called in the close function of the device
- * driver.
- */
-void close_candev(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	cancel_delayed_work_sync(&priv->restart_work);
-	can_flush_echo_skb(dev);
-}
-EXPORT_SYMBOL_GPL(close_candev);
-
-/*
- * CAN netlink interface
- */
-static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
-	[IFLA_CAN_STATE]	= { .type = NLA_U32 },
-	[IFLA_CAN_CTRLMODE]	= { .len = sizeof(struct can_ctrlmode) },
-	[IFLA_CAN_RESTART_MS]	= { .type = NLA_U32 },
-	[IFLA_CAN_RESTART]	= { .type = NLA_U32 },
-	[IFLA_CAN_BITTIMING]	= { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_BITTIMING_CONST]
-				= { .len = sizeof(struct can_bittiming_const) },
-	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
-	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
-	[IFLA_CAN_DATA_BITTIMING]
-				= { .len = sizeof(struct can_bittiming) },
-	[IFLA_CAN_DATA_BITTIMING_CONST]
-				= { .len = sizeof(struct can_bittiming_const) },
-	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
-};
-
-static int can_validate(struct nlattr *tb[], struct nlattr *data[],
-			struct netlink_ext_ack *extack)
-{
-	bool is_can_fd = false;
-
-	/* Make sure that valid CAN FD configurations always consist of
-	 * - nominal/arbitration bittiming
-	 * - data bittiming
-	 * - control mode with CAN_CTRLMODE_FD set
-	 */
-
-	if (!data)
-		return 0;
-
-	if (data[IFLA_CAN_CTRLMODE]) {
-		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-
-		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
-	}
-
-	if (is_can_fd) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
-			return -EOPNOTSUPP;
-	}
-
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
-			return -EOPNOTSUPP;
-	}
-
-	return 0;
-}
-
-static int can_changelink(struct net_device *dev, struct nlattr *tb[],
-			  struct nlattr *data[],
-			  struct netlink_ext_ack *extack)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	int err;
-
-	/* We need synchronization with dev->stop() */
-	ASSERT_RTNL();
-
-	if (data[IFLA_CAN_BITTIMING]) {
-		struct can_bittiming bt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->bittiming_const && !priv->do_set_bittiming)
-			return -EOPNOTSUPP;
-
-		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
-		err = can_get_bittiming(dev, &bt,
-					priv->bittiming_const,
-					priv->bitrate_const,
-					priv->bitrate_const_cnt);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
-			netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
-				   priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memcpy(&priv->bittiming, &bt, sizeof(bt));
-
-		if (priv->do_set_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->do_set_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
-
-	if (data[IFLA_CAN_CTRLMODE]) {
-		struct can_ctrlmode *cm;
-		u32 ctrlstatic;
-		u32 maskedflags;
-
-		/* Do not allow changing controller mode while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		ctrlstatic = priv->ctrlmode_static;
-		maskedflags = cm->flags & cm->mask;
-
-		/* check whether provided bits are allowed to be passed */
-		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
-			return -EOPNOTSUPP;
-
-		/* do not check for static fd-non-iso if 'fd' is disabled */
-		if (!(maskedflags & CAN_CTRLMODE_FD))
-			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
-
-		/* make sure static options are provided by configuration */
-		if ((maskedflags & ctrlstatic) != ctrlstatic)
-			return -EOPNOTSUPP;
-
-		/* clear bits to be modified and copy the flag values */
-		priv->ctrlmode &= ~cm->mask;
-		priv->ctrlmode |= maskedflags;
-
-		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD)
-			dev->mtu = CANFD_MTU;
-		else
-			dev->mtu = CAN_MTU;
-	}
-
-	if (data[IFLA_CAN_RESTART_MS]) {
-		/* Do not allow changing restart delay while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
-	}
-
-	if (data[IFLA_CAN_RESTART]) {
-		/* Do not allow a restart while not running */
-		if (!(dev->flags & IFF_UP))
-			return -EINVAL;
-		err = can_restart_now(dev);
-		if (err)
-			return err;
-	}
-
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming dbt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * data_bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
-			return -EOPNOTSUPP;
-
-		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
-		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt,
-					priv->data_bittiming_const,
-					priv->data_bitrate_const,
-					priv->data_bitrate_const_cnt);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
-			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
-				   priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
-
-		if (priv->do_set_data_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->do_set_data_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
-
-	if (data[IFLA_CAN_TERMINATION]) {
-		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
-		const unsigned int num_term = priv->termination_const_cnt;
-		unsigned int i;
-
-		if (!priv->do_set_termination)
-			return -EOPNOTSUPP;
-
-		/* check whether given value is supported by the interface */
-		for (i = 0; i < num_term; i++) {
-			if (termval == priv->termination_const[i])
-				break;
-		}
-		if (i >= num_term)
-			return -EINVAL;
-
-		/* Finally, set the termination value */
-		err = priv->do_set_termination(dev, termval);
-		if (err)
-			return err;
-
-		priv->termination = termval;
-	}
-
-	return 0;
-}
-
-static size_t can_get_size(const struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	size_t size = 0;
-
-	if (priv->bittiming.bitrate)				/* IFLA_CAN_BITTIMING */
-		size += nla_total_size(sizeof(struct can_bittiming));
-	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
-		size += nla_total_size(sizeof(struct can_bittiming_const));
-	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
-	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
-	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
-	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
-	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
-		size += nla_total_size(sizeof(struct can_berr_counter));
-	if (priv->data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
-		size += nla_total_size(sizeof(struct can_bittiming));
-	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
-		size += nla_total_size(sizeof(struct can_bittiming_const));
-	if (priv->termination_const) {
-		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
-		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
-				       priv->termination_const_cnt);
-	}
-	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
-		size += nla_total_size(sizeof(*priv->bitrate_const) *
-				       priv->bitrate_const_cnt);
-	if (priv->data_bitrate_const)				/* IFLA_CAN_DATA_BITRATE_CONST */
-		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
-				       priv->data_bitrate_const_cnt);
-	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-
-	return size;
-}
-
-static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-	struct can_ctrlmode cm = {.flags = priv->ctrlmode};
-	struct can_berr_counter bec = { };
-	enum can_state state = priv->state;
-
-	if (priv->do_get_state)
-		priv->do_get_state(dev, &state);
-
-	if ((priv->bittiming.bitrate &&
-	     nla_put(skb, IFLA_CAN_BITTIMING,
-		     sizeof(priv->bittiming), &priv->bittiming)) ||
-
-	    (priv->bittiming_const &&
-	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
-		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
-
-	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
-	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
-	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
-	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
-
-	    (priv->do_get_berr_counter &&
-	     !priv->do_get_berr_counter(dev, &bec) &&
-	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
-
-	    (priv->data_bittiming.bitrate &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
-		     sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
-
-	    (priv->data_bittiming_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
-		     sizeof(*priv->data_bittiming_const),
-		     priv->data_bittiming_const)) ||
-
-	    (priv->termination_const &&
-	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
-	      nla_put(skb, IFLA_CAN_TERMINATION_CONST,
-		      sizeof(*priv->termination_const) *
-		      priv->termination_const_cnt,
-		      priv->termination_const))) ||
-
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
-
-	    (priv->data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->data_bitrate_const) *
-		     priv->data_bitrate_const_cnt,
-		     priv->data_bitrate_const)) ||
-
-	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
-		     sizeof(priv->bitrate_max),
-		     &priv->bitrate_max))
-	    )
-
-		return -EMSGSIZE;
-
-	return 0;
-}
-
-static size_t can_get_xstats_size(const struct net_device *dev)
-{
-	return sizeof(struct can_device_stats);
-}
-
-static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	if (nla_put(skb, IFLA_INFO_XSTATS,
-		    sizeof(priv->can_stats), &priv->can_stats))
-		goto nla_put_failure;
-	return 0;
-
-nla_put_failure:
-	return -EMSGSIZE;
-}
-
-static int can_newlink(struct net *src_net, struct net_device *dev,
-		       struct nlattr *tb[], struct nlattr *data[],
-		       struct netlink_ext_ack *extack)
-{
-	return -EOPNOTSUPP;
-}
-
-static void can_dellink(struct net_device *dev, struct list_head *head)
-{
-	return;
-}
-
-static struct rtnl_link_ops can_link_ops __read_mostly = {
-	.kind		= "can",
-	.netns_refund	= true,
-	.maxtype	= IFLA_CAN_MAX,
-	.policy		= can_policy,
-	.setup		= can_setup,
-	.validate	= can_validate,
-	.newlink	= can_newlink,
-	.changelink	= can_changelink,
-	.dellink	= can_dellink,
-	.get_size	= can_get_size,
-	.fill_info	= can_fill_info,
-	.get_xstats_size = can_get_xstats_size,
-	.fill_xstats	= can_fill_xstats,
-};
-
-/*
- * Register the CAN network device
- */
-int register_candev(struct net_device *dev)
-{
-	struct can_priv *priv = netdev_priv(dev);
-
-	/* Ensure termination_const, termination_const_cnt and
-	 * do_set_termination consistency. All must be either set or
-	 * unset.
-	 */
-	if ((!priv->termination_const != !priv->termination_const_cnt) ||
-	    (!priv->termination_const != !priv->do_set_termination))
-		return -EINVAL;
-
-	if (!priv->bitrate_const != !priv->bitrate_const_cnt)
-		return -EINVAL;
-
-	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
-		return -EINVAL;
-
-	dev->rtnl_link_ops = &can_link_ops;
-	netif_carrier_off(dev);
-
-	return register_netdev(dev);
-}
-EXPORT_SYMBOL_GPL(register_candev);
-
-/*
- * Unregister the CAN network device
- */
-void unregister_candev(struct net_device *dev)
-{
-	unregister_netdev(dev);
-}
-EXPORT_SYMBOL_GPL(unregister_candev);
-
-/*
- * Test if a network device is a candev based device
- * and return the can_priv* if so.
- */
-struct can_priv *safe_candev_priv(struct net_device *dev)
-{
-	if ((dev->type != ARPHRD_CAN) || (dev->rtnl_link_ops != &can_link_ops))
-		return NULL;
-
-	return netdev_priv(dev);
-}
-EXPORT_SYMBOL_GPL(safe_candev_priv);
-
-static __init int can_dev_init(void)
-{
-	int err;
-
-	can_led_notifier_init();
-
-	err = rtnl_link_register(&can_link_ops);
-	if (!err)
-		printk(KERN_INFO MOD_DESC "\n");
-
-	return err;
-}
-module_init(can_dev_init);
-
-static __exit void can_dev_exit(void)
-{
-	rtnl_link_unregister(&can_link_ops);
-
-	can_led_notifier_exit();
-}
-module_exit(can_dev_exit);
-
-MODULE_ALIAS_RTNL_LINK("can");
diff --git a/drivers/net/can/dev/Makefile b/drivers/net/can/dev/Makefile
new file mode 100644
index 000000000000..cba92e6bcf6f
--- /dev/null
+++ b/drivers/net/can/dev/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_CAN_DEV)		+= can-dev.o
+can-dev-y			+= dev.o
+can-dev-y			+= rx-offload.o
+
+can-dev-$(CONFIG_CAN_LEDS)	+= led.o
diff --git a/drivers/net/can/dev/dev.c b/drivers/net/can/dev/dev.c
new file mode 100644
index 000000000000..3797d4de254d
--- /dev/null
+++ b/drivers/net/can/dev/dev.c
@@ -0,0 +1,1326 @@
+/*
+ * Copyright (C) 2005 Marc Kleine-Budde, Pengutronix
+ * Copyright (C) 2006 Andrey Volkov, Varma Electronics
+ * Copyright (C) 2008-2009 Wolfgang Grandegger <wg@grandegger.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/netdevice.h>
+#include <linux/if_arp.h>
+#include <linux/workqueue.h>
+#include <linux/can.h>
+#include <linux/can/dev.h>
+#include <linux/can/skb.h>
+#include <linux/can/netlink.h>
+#include <linux/can/led.h>
+#include <linux/of.h>
+#include <net/rtnetlink.h>
+
+#define MOD_DESC "CAN device driver interface"
+
+MODULE_DESCRIPTION(MOD_DESC);
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Wolfgang Grandegger <wg@grandegger.com>");
+
+/* CAN DLC to real data length conversion helpers */
+
+static const u8 dlc2len[] = {0, 1, 2, 3, 4, 5, 6, 7,
+			     8, 12, 16, 20, 24, 32, 48, 64};
+
+/* get data length from can_dlc with sanitized can_dlc */
+u8 can_dlc2len(u8 can_dlc)
+{
+	return dlc2len[can_dlc & 0x0F];
+}
+EXPORT_SYMBOL_GPL(can_dlc2len);
+
+static const u8 len2dlc[] = {0, 1, 2, 3, 4, 5, 6, 7, 8,		/* 0 - 8 */
+			     9, 9, 9, 9,			/* 9 - 12 */
+			     10, 10, 10, 10,			/* 13 - 16 */
+			     11, 11, 11, 11,			/* 17 - 20 */
+			     12, 12, 12, 12,			/* 21 - 24 */
+			     13, 13, 13, 13, 13, 13, 13, 13,	/* 25 - 32 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 33 - 40 */
+			     14, 14, 14, 14, 14, 14, 14, 14,	/* 41 - 48 */
+			     15, 15, 15, 15, 15, 15, 15, 15,	/* 49 - 56 */
+			     15, 15, 15, 15, 15, 15, 15, 15};	/* 57 - 64 */
+
+/* map the sanitized data length to an appropriate data length code */
+u8 can_len2dlc(u8 len)
+{
+	if (unlikely(len > 64))
+		return 0xF;
+
+	return len2dlc[len];
+}
+EXPORT_SYMBOL_GPL(can_len2dlc);
+
+#ifdef CONFIG_CAN_CALC_BITTIMING
+#define CAN_CALC_MAX_ERROR 50 /* in one-tenth of a percent */
+#define CAN_CALC_SYNC_SEG 1
+
+/*
+ * Bit-timing calculation derived from:
+ *
+ * Code based on LinCAN sources and H8S2638 project
+ * Copyright 2004-2006 Pavel Pisa - DCE FELK CVUT cz
+ * Copyright 2005      Stanislav Marek
+ * email: pisa@cmp.felk.cvut.cz
+ *
+ * Calculates proper bit-timing parameters for a specified bit-rate
+ * and sample-point, which can then be used to set the bit-timing
+ * registers of the CAN controller. You can find more information
+ * in the header file linux/can/netlink.h.
+ */
+static int can_update_sample_point(const struct can_bittiming_const *btc,
+			  unsigned int sample_point_nominal, unsigned int tseg,
+			  unsigned int *tseg1_ptr, unsigned int *tseg2_ptr,
+			  unsigned int *sample_point_error_ptr)
+{
+	unsigned int sample_point_error, best_sample_point_error = UINT_MAX;
+	unsigned int sample_point, best_sample_point = 0;
+	unsigned int tseg1, tseg2;
+	int i;
+
+	for (i = 0; i <= 1; i++) {
+		tseg2 = tseg + CAN_CALC_SYNC_SEG - (sample_point_nominal * (tseg + CAN_CALC_SYNC_SEG)) / 1000 - i;
+		tseg2 = clamp(tseg2, btc->tseg2_min, btc->tseg2_max);
+		tseg1 = tseg - tseg2;
+		if (tseg1 > btc->tseg1_max) {
+			tseg1 = btc->tseg1_max;
+			tseg2 = tseg - tseg1;
+		}
+
+		sample_point = 1000 * (tseg + CAN_CALC_SYNC_SEG - tseg2) / (tseg + CAN_CALC_SYNC_SEG);
+		sample_point_error = abs(sample_point_nominal - sample_point);
+
+		if ((sample_point <= sample_point_nominal) && (sample_point_error < best_sample_point_error)) {
+			best_sample_point = sample_point;
+			best_sample_point_error = sample_point_error;
+			*tseg1_ptr = tseg1;
+			*tseg2_ptr = tseg2;
+		}
+	}
+
+	if (sample_point_error_ptr)
+		*sample_point_error_ptr = best_sample_point_error;
+
+	return best_sample_point;
+}
+
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	unsigned int bitrate;			/* current bitrate */
+	unsigned int bitrate_error;		/* difference between current and nominal value */
+	unsigned int best_bitrate_error = UINT_MAX;
+	unsigned int sample_point_error;	/* difference between current and nominal value */
+	unsigned int best_sample_point_error = UINT_MAX;
+	unsigned int sample_point_nominal;	/* nominal sample point */
+	unsigned int best_tseg = 0;		/* current best value for tseg */
+	unsigned int best_brp = 0;		/* current best value for brp */
+	unsigned int brp, tsegall, tseg, tseg1 = 0, tseg2 = 0;
+	u64 v64;
+
+	/* Use CiA recommended sample points */
+	if (bt->sample_point) {
+		sample_point_nominal = bt->sample_point;
+	} else {
+		if (bt->bitrate > 800000)
+			sample_point_nominal = 750;
+		else if (bt->bitrate > 500000)
+			sample_point_nominal = 800;
+		else
+			sample_point_nominal = 875;
+	}
+
+	/* tseg even = round down, odd = round up */
+	for (tseg = (btc->tseg1_max + btc->tseg2_max) * 2 + 1;
+	     tseg >= (btc->tseg1_min + btc->tseg2_min) * 2; tseg--) {
+		tsegall = CAN_CALC_SYNC_SEG + tseg / 2;
+
+		/* Compute all possible tseg choices (tseg=tseg1+tseg2) */
+		brp = priv->clock.freq / (tsegall * bt->bitrate) + tseg % 2;
+
+		/* choose brp step which is possible in system */
+		brp = (brp / btc->brp_inc) * btc->brp_inc;
+		if ((brp < btc->brp_min) || (brp > btc->brp_max))
+			continue;
+
+		bitrate = priv->clock.freq / (brp * tsegall);
+		bitrate_error = abs(bt->bitrate - bitrate);
+
+		/* tseg brp biterror */
+		if (bitrate_error > best_bitrate_error)
+			continue;
+
+		/* reset sample point error if we have a better bitrate */
+		if (bitrate_error < best_bitrate_error)
+			best_sample_point_error = UINT_MAX;
+
+		can_update_sample_point(btc, sample_point_nominal, tseg / 2, &tseg1, &tseg2, &sample_point_error);
+		if (sample_point_error > best_sample_point_error)
+			continue;
+
+		best_sample_point_error = sample_point_error;
+		best_bitrate_error = bitrate_error;
+		best_tseg = tseg / 2;
+		best_brp = brp;
+
+		if (bitrate_error == 0 && sample_point_error == 0)
+			break;
+	}
+
+	if (best_bitrate_error) {
+		/* Error in one-tenth of a percent */
+		v64 = (u64)best_bitrate_error * 1000;
+		do_div(v64, bt->bitrate);
+		bitrate_error = (u32)v64;
+		if (bitrate_error > CAN_CALC_MAX_ERROR) {
+			netdev_err(dev,
+				   "bitrate error %d.%d%% too high\n",
+				   bitrate_error / 10, bitrate_error % 10);
+			return -EDOM;
+		}
+		netdev_warn(dev, "bitrate error %d.%d%%\n",
+			    bitrate_error / 10, bitrate_error % 10);
+	}
+
+	/* real sample point */
+	bt->sample_point = can_update_sample_point(btc, sample_point_nominal, best_tseg,
+					  &tseg1, &tseg2, NULL);
+
+	v64 = (u64)best_brp * 1000 * 1000 * 1000;
+	do_div(v64, priv->clock.freq);
+	bt->tq = (u32)v64;
+	bt->prop_seg = tseg1 / 2;
+	bt->phase_seg1 = tseg1 - bt->prop_seg;
+	bt->phase_seg2 = tseg2;
+
+	/* check for sjw user settings */
+	if (!bt->sjw || !btc->sjw_max) {
+		bt->sjw = 1;
+	} else {
+		/* bt->sjw is at least 1 -> sanitize upper bound to sjw_max */
+		if (bt->sjw > btc->sjw_max)
+			bt->sjw = btc->sjw_max;
+		/* bt->sjw must not be higher than tseg2 */
+		if (tseg2 < bt->sjw)
+			bt->sjw = tseg2;
+	}
+
+	bt->brp = best_brp;
+
+	/* real bitrate */
+	bt->bitrate = priv->clock.freq / (bt->brp * (CAN_CALC_SYNC_SEG + tseg1 + tseg2));
+
+	return 0;
+}
+#else /* !CONFIG_CAN_CALC_BITTIMING */
+static int can_calc_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			      const struct can_bittiming_const *btc)
+{
+	netdev_err(dev, "bit-timing calculation not available\n");
+	return -EINVAL;
+}
+#endif /* CONFIG_CAN_CALC_BITTIMING */
+
+/*
+ * Checks the validity of the specified bit-timing parameters prop_seg,
+ * phase_seg1, phase_seg2 and sjw and tries to determine the bitrate
+ * prescaler value brp. You can find more information in the header
+ * file linux/can/netlink.h.
+ */
+static int can_fixup_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			       const struct can_bittiming_const *btc)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	int tseg1, alltseg;
+	u64 brp64;
+
+	tseg1 = bt->prop_seg + bt->phase_seg1;
+	if (!bt->sjw)
+		bt->sjw = 1;
+	if (bt->sjw > btc->sjw_max ||
+	    tseg1 < btc->tseg1_min || tseg1 > btc->tseg1_max ||
+	    bt->phase_seg2 < btc->tseg2_min || bt->phase_seg2 > btc->tseg2_max)
+		return -ERANGE;
+
+	brp64 = (u64)priv->clock.freq * (u64)bt->tq;
+	if (btc->brp_inc > 1)
+		do_div(brp64, btc->brp_inc);
+	brp64 += 500000000UL - 1;
+	do_div(brp64, 1000000000UL); /* the practicable BRP */
+	if (btc->brp_inc > 1)
+		brp64 *= btc->brp_inc;
+	bt->brp = (u32)brp64;
+
+	if (bt->brp < btc->brp_min || bt->brp > btc->brp_max)
+		return -EINVAL;
+
+	alltseg = bt->prop_seg + bt->phase_seg1 + bt->phase_seg2 + 1;
+	bt->bitrate = priv->clock.freq / (bt->brp * alltseg);
+	bt->sample_point = ((tseg1 + 1) * 1000) / alltseg;
+
+	return 0;
+}
+
+/* Checks the validity of predefined bitrate settings */
+static int can_validate_bitrate(struct net_device *dev, struct can_bittiming *bt,
+				const u32 *bitrate_const,
+				const unsigned int bitrate_const_cnt)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	unsigned int i;
+
+	for (i = 0; i < bitrate_const_cnt; i++) {
+		if (bt->bitrate == bitrate_const[i])
+			break;
+	}
+
+	if (i >= priv->bitrate_const_cnt)
+		return -EINVAL;
+
+	return 0;
+}
+
+static int can_get_bittiming(struct net_device *dev, struct can_bittiming *bt,
+			     const struct can_bittiming_const *btc,
+			     const u32 *bitrate_const,
+			     const unsigned int bitrate_const_cnt)
+{
+	int err;
+
+	/*
+	 * Depending on the given can_bittiming parameter structure the CAN
+	 * timing parameters are calculated based on the provided bitrate OR
+	 * alternatively the CAN timing parameters (tq, prop_seg, etc.) are
+	 * provided directly which are then checked and fixed up.
+	 */
+	if (!bt->tq && bt->bitrate && btc)
+		err = can_calc_bittiming(dev, bt, btc);
+	else if (bt->tq && !bt->bitrate && btc)
+		err = can_fixup_bittiming(dev, bt, btc);
+	else if (!bt->tq && bt->bitrate && bitrate_const)
+		err = can_validate_bitrate(dev, bt, bitrate_const,
+					   bitrate_const_cnt);
+	else
+		err = -EINVAL;
+
+	return err;
+}
+
+static void can_update_state_error_stats(struct net_device *dev,
+					 enum can_state new_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (new_state <= priv->state)
+		return;
+
+	switch (new_state) {
+	case CAN_STATE_ERROR_WARNING:
+		priv->can_stats.error_warning++;
+		break;
+	case CAN_STATE_ERROR_PASSIVE:
+		priv->can_stats.error_passive++;
+		break;
+	case CAN_STATE_BUS_OFF:
+		priv->can_stats.bus_off++;
+		break;
+	default:
+		break;
+	}
+}
+
+static int can_tx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_TX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_TX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+static int can_rx_state_to_frame(struct net_device *dev, enum can_state state)
+{
+	switch (state) {
+	case CAN_STATE_ERROR_ACTIVE:
+		return CAN_ERR_CRTL_ACTIVE;
+	case CAN_STATE_ERROR_WARNING:
+		return CAN_ERR_CRTL_RX_WARNING;
+	case CAN_STATE_ERROR_PASSIVE:
+		return CAN_ERR_CRTL_RX_PASSIVE;
+	default:
+		return 0;
+	}
+}
+
+void can_change_state(struct net_device *dev, struct can_frame *cf,
+		      enum can_state tx_state, enum can_state rx_state)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	enum can_state new_state = max(tx_state, rx_state);
+
+	if (unlikely(new_state == priv->state)) {
+		netdev_warn(dev, "%s: oops, state did not change", __func__);
+		return;
+	}
+
+	netdev_dbg(dev, "New error state: %d\n", new_state);
+
+	can_update_state_error_stats(dev, new_state);
+	priv->state = new_state;
+
+	if (!cf)
+		return;
+
+	if (unlikely(new_state == CAN_STATE_BUS_OFF)) {
+		cf->can_id |= CAN_ERR_BUSOFF;
+		return;
+	}
+
+	cf->can_id |= CAN_ERR_CRTL;
+	cf->data[1] |= tx_state >= rx_state ?
+		       can_tx_state_to_frame(dev, tx_state) : 0;
+	cf->data[1] |= tx_state <= rx_state ?
+		       can_rx_state_to_frame(dev, rx_state) : 0;
+}
+EXPORT_SYMBOL_GPL(can_change_state);
+
+/*
+ * Local echo of CAN messages
+ *
+ * CAN network devices *should* support a local echo functionality
+ * (see Documentation/networking/can.rst). To test the handling of CAN
+ * interfaces that do not support the local echo both driver types are
+ * implemented. In the case that the driver does not support the echo
+ * the IFF_ECHO remains clear in dev->flags. This causes the PF_CAN core
+ * to perform the echo as a fallback solution.
+ */
+static void can_flush_echo_skb(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	int i;
+
+	for (i = 0; i < priv->echo_skb_max; i++) {
+		if (priv->echo_skb[i]) {
+			kfree_skb(priv->echo_skb[i]);
+			priv->echo_skb[i] = NULL;
+			stats->tx_dropped++;
+			stats->tx_aborted_errors++;
+		}
+	}
+}
+
+/*
+ * Put the skb on the stack to be looped backed locally lateron
+ *
+ * The function is typically called in the start_xmit function
+ * of the device driver. The driver must protect access to
+ * priv->echo_skb, if necessary.
+ */
+void can_put_echo_skb(struct sk_buff *skb, struct net_device *dev,
+		      unsigned int idx)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	BUG_ON(idx >= priv->echo_skb_max);
+
+	/* check flag whether this packet has to be looped back */
+	if (!(dev->flags & IFF_ECHO) || skb->pkt_type != PACKET_LOOPBACK ||
+	    (skb->protocol != htons(ETH_P_CAN) &&
+	     skb->protocol != htons(ETH_P_CANFD))) {
+		kfree_skb(skb);
+		return;
+	}
+
+	if (!priv->echo_skb[idx]) {
+
+		skb = can_create_echo_skb(skb);
+		if (!skb)
+			return;
+
+		/* make settings for echo to reduce code in irq context */
+		skb->pkt_type = PACKET_BROADCAST;
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		skb->dev = dev;
+
+		/* save this skb for tx interrupt echo handling */
+		priv->echo_skb[idx] = skb;
+	} else {
+		/* locking problem with netif_stop_queue() ?? */
+		netdev_err(dev, "%s: BUG! echo_skb is occupied!\n", __func__);
+		kfree_skb(skb);
+	}
+}
+EXPORT_SYMBOL_GPL(can_put_echo_skb);
+
+struct sk_buff *__can_get_echo_skb(struct net_device *dev, unsigned int idx, u8 *len_ptr)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (idx >= priv->echo_skb_max) {
+		netdev_err(dev, "%s: BUG! Trying to access can_priv::echo_skb out of bounds (%u/max %u)\n",
+			   __func__, idx, priv->echo_skb_max);
+		return NULL;
+	}
+
+	if (priv->echo_skb[idx]) {
+		/* Using "struct canfd_frame::len" for the frame
+		 * length is supported on both CAN and CANFD frames.
+		 */
+		struct sk_buff *skb = priv->echo_skb[idx];
+		struct canfd_frame *cf = (struct canfd_frame *)skb->data;
+
+		/* get the real payload length for netdev statistics */
+		if (cf->can_id & CAN_RTR_FLAG)
+			*len_ptr = 0;
+		else
+			*len_ptr = cf->len;
+
+		priv->echo_skb[idx] = NULL;
+
+		return skb;
+	}
+
+	return NULL;
+}
+
+/*
+ * Get the skb from the stack and loop it back locally
+ *
+ * The function is typically called when the TX done interrupt
+ * is handled in the device driver. The driver must protect
+ * access to priv->echo_skb, if necessary.
+ */
+unsigned int can_get_echo_skb(struct net_device *dev, unsigned int idx)
+{
+	struct sk_buff *skb;
+	u8 len;
+
+	skb = __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
+
+	skb_get(skb);
+	if (netif_rx(skb) == NET_RX_SUCCESS)
+		dev_consume_skb_any(skb);
+	else
+		dev_kfree_skb_any(skb);
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(can_get_echo_skb);
+
+/*
+  * Remove the skb from the stack and free it.
+  *
+  * The function is typically called when TX failed.
+  */
+void can_free_echo_skb(struct net_device *dev, unsigned int idx)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	BUG_ON(idx >= priv->echo_skb_max);
+
+	if (priv->echo_skb[idx]) {
+		dev_kfree_skb_any(priv->echo_skb[idx]);
+		priv->echo_skb[idx] = NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(can_free_echo_skb);
+
+/*
+ * CAN device restart for bus-off recovery
+ */
+static void can_restart(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	int err;
+
+	if (netif_carrier_ok(dev))
+		netdev_err(dev, "Attempt to restart for bus-off recovery, but carrier is OK?\n");
+
+	/*
+	 * No synchronization needed because the device is bus-off and
+	 * no messages can come in or go out.
+	 */
+	can_flush_echo_skb(dev);
+
+	/* send restart message upstream */
+	skb = alloc_can_err_skb(dev, &cf);
+	if (skb == NULL) {
+		err = -ENOMEM;
+		goto restart;
+	}
+	cf->can_id |= CAN_ERR_RESTARTED;
+
+	stats->rx_packets++;
+	stats->rx_bytes += cf->can_dlc;
+
+	netif_rx_ni(skb);
+
+restart:
+	netdev_dbg(dev, "restarted\n");
+	priv->can_stats.restarts++;
+
+	/* Now restart the device */
+	netif_carrier_on(dev);
+	err = priv->do_set_mode(dev, CAN_MODE_START);
+	if (err) {
+		netdev_err(dev, "Error %d during restart", err);
+		netif_carrier_off(dev);
+	}
+}
+
+static void can_restart_work(struct work_struct *work)
+{
+	struct delayed_work *dwork = to_delayed_work(work);
+	struct can_priv *priv = container_of(dwork, struct can_priv, restart_work);
+
+	can_restart(priv->dev);
+}
+
+int can_restart_now(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/*
+	 * A manual restart is only permitted if automatic restart is
+	 * disabled and the device is in the bus-off state
+	 */
+	if (priv->restart_ms)
+		return -EINVAL;
+	if (priv->state != CAN_STATE_BUS_OFF)
+		return -EBUSY;
+
+	cancel_delayed_work_sync(&priv->restart_work);
+	can_restart(dev);
+
+	return 0;
+}
+
+/*
+ * CAN bus-off
+ *
+ * This functions should be called when the device goes bus-off to
+ * tell the netif layer that no more packets can be sent or received.
+ * If enabled, a timer is started to trigger bus-off recovery.
+ */
+void can_bus_off(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	netdev_info(dev, "bus-off\n");
+
+	netif_carrier_off(dev);
+
+	if (priv->restart_ms)
+		schedule_delayed_work(&priv->restart_work,
+				      msecs_to_jiffies(priv->restart_ms));
+}
+EXPORT_SYMBOL_GPL(can_bus_off);
+
+static void can_setup(struct net_device *dev)
+{
+	dev->type = ARPHRD_CAN;
+	dev->mtu = CAN_MTU;
+	dev->hard_header_len = 0;
+	dev->addr_len = 0;
+	dev->tx_queue_len = 10;
+
+	/* New-style flags. */
+	dev->flags = IFF_NOARP;
+	dev->features = NETIF_F_HW_CSUM;
+}
+
+struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct can_frame));
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->protocol = htons(ETH_P_CAN);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	*cf = skb_put_zero(skb, sizeof(struct can_frame));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_can_skb);
+
+struct sk_buff *alloc_canfd_skb(struct net_device *dev,
+				struct canfd_frame **cfd)
+{
+	struct sk_buff *skb;
+
+	skb = netdev_alloc_skb(dev, sizeof(struct can_skb_priv) +
+			       sizeof(struct canfd_frame));
+	if (unlikely(!skb))
+		return NULL;
+
+	skb->protocol = htons(ETH_P_CANFD);
+	skb->pkt_type = PACKET_BROADCAST;
+	skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+	skb_reset_mac_header(skb);
+	skb_reset_network_header(skb);
+	skb_reset_transport_header(skb);
+
+	can_skb_reserve(skb);
+	can_skb_prv(skb)->ifindex = dev->ifindex;
+	can_skb_prv(skb)->skbcnt = 0;
+
+	*cfd = skb_put_zero(skb, sizeof(struct canfd_frame));
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_canfd_skb);
+
+struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
+{
+	struct sk_buff *skb;
+
+	skb = alloc_can_skb(dev, cf);
+	if (unlikely(!skb))
+		return NULL;
+
+	(*cf)->can_id = CAN_ERR_FLAG;
+	(*cf)->can_dlc = CAN_ERR_DLC;
+
+	return skb;
+}
+EXPORT_SYMBOL_GPL(alloc_can_err_skb);
+
+/*
+ * Allocate and setup space for the CAN network device
+ */
+struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
+				    unsigned int txqs, unsigned int rxqs)
+{
+	struct net_device *dev;
+	struct can_priv *priv;
+	int size;
+
+	if (echo_skb_max)
+		size = ALIGN(sizeof_priv, sizeof(struct sk_buff *)) +
+			echo_skb_max * sizeof(struct sk_buff *);
+	else
+		size = sizeof_priv;
+
+	dev = alloc_netdev_mqs(size, "can%d", NET_NAME_UNKNOWN, can_setup,
+			       txqs, rxqs);
+	if (!dev)
+		return NULL;
+
+	priv = netdev_priv(dev);
+	priv->dev = dev;
+
+	if (echo_skb_max) {
+		priv->echo_skb_max = echo_skb_max;
+		priv->echo_skb = (void *)priv +
+			ALIGN(sizeof_priv, sizeof(struct sk_buff *));
+	}
+
+	priv->state = CAN_STATE_STOPPED;
+
+	INIT_DELAYED_WORK(&priv->restart_work, can_restart_work);
+
+	return dev;
+}
+EXPORT_SYMBOL_GPL(alloc_candev_mqs);
+
+/*
+ * Free space of the CAN network device
+ */
+void free_candev(struct net_device *dev)
+{
+	free_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(free_candev);
+
+/*
+ * changing MTU and control mode for CAN/CANFD devices
+ */
+int can_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Do not allow changing the MTU while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* allow change of MTU according to the CANFD ability of the device */
+	switch (new_mtu) {
+	case CAN_MTU:
+		/* 'CANFD-only' controllers can not switch to CAN_MTU */
+		if (priv->ctrlmode_static & CAN_CTRLMODE_FD)
+			return -EINVAL;
+
+		priv->ctrlmode &= ~CAN_CTRLMODE_FD;
+		break;
+
+	case CANFD_MTU:
+		/* check for potential CANFD ability */
+		if (!(priv->ctrlmode_supported & CAN_CTRLMODE_FD) &&
+		    !(priv->ctrlmode_static & CAN_CTRLMODE_FD))
+			return -EINVAL;
+
+		priv->ctrlmode |= CAN_CTRLMODE_FD;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	dev->mtu = new_mtu;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_change_mtu);
+
+/*
+ * Common open function when the device gets opened.
+ *
+ * This function should be called in the open function of the device
+ * driver.
+ */
+int open_candev(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (!priv->bittiming.bitrate) {
+		netdev_err(dev, "bit-timing not yet defined\n");
+		return -EINVAL;
+	}
+
+	/* For CAN FD the data bitrate has to be >= the arbitration bitrate */
+	if ((priv->ctrlmode & CAN_CTRLMODE_FD) &&
+	    (!priv->data_bittiming.bitrate ||
+	     (priv->data_bittiming.bitrate < priv->bittiming.bitrate))) {
+		netdev_err(dev, "incorrect/missing data bit-timing\n");
+		return -EINVAL;
+	}
+
+	/* Switch carrier on if device was stopped while in bus-off state */
+	if (!netif_carrier_ok(dev))
+		netif_carrier_on(dev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(open_candev);
+
+#ifdef CONFIG_OF
+/* Common function that can be used to understand the limitation of
+ * a transceiver when it provides no means to determine these limitations
+ * at runtime.
+ */
+void of_can_transceiver(struct net_device *dev)
+{
+	struct device_node *dn;
+	struct can_priv *priv = netdev_priv(dev);
+	struct device_node *np = dev->dev.parent->of_node;
+	int ret;
+
+	dn = of_get_child_by_name(np, "can-transceiver");
+	if (!dn)
+		return;
+
+	ret = of_property_read_u32(dn, "max-bitrate", &priv->bitrate_max);
+	of_node_put(dn);
+	if ((ret && ret != -EINVAL) || (!ret && !priv->bitrate_max))
+		netdev_warn(dev, "Invalid value for transceiver max bitrate. Ignoring bitrate limit.\n");
+}
+EXPORT_SYMBOL_GPL(of_can_transceiver);
+#endif
+
+/*
+ * Common close function for cleanup before the device gets closed.
+ *
+ * This function should be called in the close function of the device
+ * driver.
+ */
+void close_candev(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	cancel_delayed_work_sync(&priv->restart_work);
+	can_flush_echo_skb(dev);
+}
+EXPORT_SYMBOL_GPL(close_candev);
+
+/*
+ * CAN netlink interface
+ */
+static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
+	[IFLA_CAN_STATE]	= { .type = NLA_U32 },
+	[IFLA_CAN_CTRLMODE]	= { .len = sizeof(struct can_ctrlmode) },
+	[IFLA_CAN_RESTART_MS]	= { .type = NLA_U32 },
+	[IFLA_CAN_RESTART]	= { .type = NLA_U32 },
+	[IFLA_CAN_BITTIMING]	= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_BITTIMING_CONST]
+				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_CLOCK]	= { .len = sizeof(struct can_clock) },
+	[IFLA_CAN_BERR_COUNTER]	= { .len = sizeof(struct can_berr_counter) },
+	[IFLA_CAN_DATA_BITTIMING]
+				= { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_DATA_BITTIMING_CONST]
+				= { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_TERMINATION]	= { .type = NLA_U16 },
+};
+
+static int can_validate(struct nlattr *tb[], struct nlattr *data[],
+			struct netlink_ext_ack *extack)
+{
+	bool is_can_fd = false;
+
+	/* Make sure that valid CAN FD configurations always consist of
+	 * - nominal/arbitration bittiming
+	 * - data bittiming
+	 * - control mode with CAN_CTRLMODE_FD set
+	 */
+
+	if (!data)
+		return 0;
+
+	if (data[IFLA_CAN_CTRLMODE]) {
+		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+
+		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
+	}
+
+	if (is_can_fd) {
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
+			return -EOPNOTSUPP;
+	}
+
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		if (!is_can_fd || !data[IFLA_CAN_BITTIMING])
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int can_changelink(struct net_device *dev, struct nlattr *tb[],
+			  struct nlattr *data[],
+			  struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	int err;
+
+	/* We need synchronization with dev->stop() */
+	ASSERT_RTNL();
+
+	if (data[IFLA_CAN_BITTIMING]) {
+		struct can_bittiming bt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->bittiming_const && !priv->do_set_bittiming)
+			return -EOPNOTSUPP;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
+		err = can_get_bittiming(dev, &bt,
+					priv->bittiming_const,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt);
+		if (err)
+			return err;
+
+		if (priv->bitrate_max && bt.bitrate > priv->bitrate_max) {
+			netdev_err(dev, "arbitration bitrate surpasses transceiver capabilities of %d bps\n",
+				   priv->bitrate_max);
+			return -EINVAL;
+		}
+
+		memcpy(&priv->bittiming, &bt, sizeof(bt));
+
+		if (priv->do_set_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
+	if (data[IFLA_CAN_CTRLMODE]) {
+		struct can_ctrlmode *cm;
+		u32 ctrlstatic;
+		u32 maskedflags;
+
+		/* Do not allow changing controller mode while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		cm = nla_data(data[IFLA_CAN_CTRLMODE]);
+		ctrlstatic = priv->ctrlmode_static;
+		maskedflags = cm->flags & cm->mask;
+
+		/* check whether provided bits are allowed to be passed */
+		if (cm->mask & ~(priv->ctrlmode_supported | ctrlstatic))
+			return -EOPNOTSUPP;
+
+		/* do not check for static fd-non-iso if 'fd' is disabled */
+		if (!(maskedflags & CAN_CTRLMODE_FD))
+			ctrlstatic &= ~CAN_CTRLMODE_FD_NON_ISO;
+
+		/* make sure static options are provided by configuration */
+		if ((maskedflags & ctrlstatic) != ctrlstatic)
+			return -EOPNOTSUPP;
+
+		/* clear bits to be modified and copy the flag values */
+		priv->ctrlmode &= ~cm->mask;
+		priv->ctrlmode |= maskedflags;
+
+		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
+		if (priv->ctrlmode & CAN_CTRLMODE_FD)
+			dev->mtu = CANFD_MTU;
+		else
+			dev->mtu = CAN_MTU;
+	}
+
+	if (data[IFLA_CAN_RESTART_MS]) {
+		/* Do not allow changing restart delay while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+		priv->restart_ms = nla_get_u32(data[IFLA_CAN_RESTART_MS]);
+	}
+
+	if (data[IFLA_CAN_RESTART]) {
+		/* Do not allow a restart while not running */
+		if (!(dev->flags & IFF_UP))
+			return -EINVAL;
+		err = can_restart_now(dev);
+		if (err)
+			return err;
+	}
+
+	if (data[IFLA_CAN_DATA_BITTIMING]) {
+		struct can_bittiming dbt;
+
+		/* Do not allow changing bittiming while running */
+		if (dev->flags & IFF_UP)
+			return -EBUSY;
+
+		/* Calculate bittiming parameters based on
+		 * data_bittiming_const if set, otherwise pass bitrate
+		 * directly via do_set_bitrate(). Bail out if neither
+		 * is given.
+		 */
+		if (!priv->data_bittiming_const && !priv->do_set_data_bittiming)
+			return -EOPNOTSUPP;
+
+		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
+		       sizeof(dbt));
+		err = can_get_bittiming(dev, &dbt,
+					priv->data_bittiming_const,
+					priv->data_bitrate_const,
+					priv->data_bitrate_const_cnt);
+		if (err)
+			return err;
+
+		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
+			netdev_err(dev, "canfd data bitrate surpasses transceiver capabilities of %d bps\n",
+				   priv->bitrate_max);
+			return -EINVAL;
+		}
+
+		memcpy(&priv->data_bittiming, &dbt, sizeof(dbt));
+
+		if (priv->do_set_data_bittiming) {
+			/* Finally, set the bit-timing registers */
+			err = priv->do_set_data_bittiming(dev);
+			if (err)
+				return err;
+		}
+	}
+
+	if (data[IFLA_CAN_TERMINATION]) {
+		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
+		const unsigned int num_term = priv->termination_const_cnt;
+		unsigned int i;
+
+		if (!priv->do_set_termination)
+			return -EOPNOTSUPP;
+
+		/* check whether given value is supported by the interface */
+		for (i = 0; i < num_term; i++) {
+			if (termval == priv->termination_const[i])
+				break;
+		}
+		if (i >= num_term)
+			return -EINVAL;
+
+		/* Finally, set the termination value */
+		err = priv->do_set_termination(dev, termval);
+		if (err)
+			return err;
+
+		priv->termination = termval;
+	}
+
+	return 0;
+}
+
+static size_t can_get_size(const struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	size_t size = 0;
+
+	if (priv->bittiming.bitrate)				/* IFLA_CAN_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->bittiming_const)				/* IFLA_CAN_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
+	size += nla_total_size(sizeof(struct can_clock));	/* IFLA_CAN_CLOCK */
+	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_STATE */
+	size += nla_total_size(sizeof(struct can_ctrlmode));	/* IFLA_CAN_CTRLMODE */
+	size += nla_total_size(sizeof(u32));			/* IFLA_CAN_RESTART_MS */
+	if (priv->do_get_berr_counter)				/* IFLA_CAN_BERR_COUNTER */
+		size += nla_total_size(sizeof(struct can_berr_counter));
+	if (priv->data_bittiming.bitrate)			/* IFLA_CAN_DATA_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->data_bittiming_const)				/* IFLA_CAN_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
+	if (priv->termination_const) {
+		size += nla_total_size(sizeof(priv->termination));		/* IFLA_CAN_TERMINATION */
+		size += nla_total_size(sizeof(*priv->termination_const) *	/* IFLA_CAN_TERMINATION_CONST */
+				       priv->termination_const_cnt);
+	}
+	if (priv->bitrate_const)				/* IFLA_CAN_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->bitrate_const) *
+				       priv->bitrate_const_cnt);
+	if (priv->data_bitrate_const)				/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->data_bitrate_const) *
+				       priv->data_bitrate_const_cnt);
+	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
+
+	return size;
+}
+
+static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_ctrlmode cm = {.flags = priv->ctrlmode};
+	struct can_berr_counter bec = { };
+	enum can_state state = priv->state;
+
+	if (priv->do_get_state)
+		priv->do_get_state(dev, &state);
+
+	if ((priv->bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_BITTIMING,
+		     sizeof(priv->bittiming), &priv->bittiming)) ||
+
+	    (priv->bittiming_const &&
+	     nla_put(skb, IFLA_CAN_BITTIMING_CONST,
+		     sizeof(*priv->bittiming_const), priv->bittiming_const)) ||
+
+	    nla_put(skb, IFLA_CAN_CLOCK, sizeof(priv->clock), &priv->clock) ||
+	    nla_put_u32(skb, IFLA_CAN_STATE, state) ||
+	    nla_put(skb, IFLA_CAN_CTRLMODE, sizeof(cm), &cm) ||
+	    nla_put_u32(skb, IFLA_CAN_RESTART_MS, priv->restart_ms) ||
+
+	    (priv->do_get_berr_counter &&
+	     !priv->do_get_berr_counter(dev, &bec) &&
+	     nla_put(skb, IFLA_CAN_BERR_COUNTER, sizeof(bec), &bec)) ||
+
+	    (priv->data_bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_DATA_BITTIMING,
+		     sizeof(priv->data_bittiming), &priv->data_bittiming)) ||
+
+	    (priv->data_bittiming_const &&
+	     nla_put(skb, IFLA_CAN_DATA_BITTIMING_CONST,
+		     sizeof(*priv->data_bittiming_const),
+		     priv->data_bittiming_const)) ||
+
+	    (priv->termination_const &&
+	     (nla_put_u16(skb, IFLA_CAN_TERMINATION, priv->termination) ||
+	      nla_put(skb, IFLA_CAN_TERMINATION_CONST,
+		      sizeof(*priv->termination_const) *
+		      priv->termination_const_cnt,
+		      priv->termination_const))) ||
+
+	    (priv->bitrate_const &&
+	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
+		     sizeof(*priv->bitrate_const) *
+		     priv->bitrate_const_cnt,
+		     priv->bitrate_const)) ||
+
+	    (priv->data_bitrate_const &&
+	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
+		     sizeof(*priv->data_bitrate_const) *
+		     priv->data_bitrate_const_cnt,
+		     priv->data_bitrate_const)) ||
+
+	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
+		     sizeof(priv->bitrate_max),
+		     &priv->bitrate_max))
+	    )
+
+		return -EMSGSIZE;
+
+	return 0;
+}
+
+static size_t can_get_xstats_size(const struct net_device *dev)
+{
+	return sizeof(struct can_device_stats);
+}
+
+static int can_fill_xstats(struct sk_buff *skb, const struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	if (nla_put(skb, IFLA_INFO_XSTATS,
+		    sizeof(priv->can_stats), &priv->can_stats))
+		goto nla_put_failure;
+	return 0;
+
+nla_put_failure:
+	return -EMSGSIZE;
+}
+
+static int can_newlink(struct net *src_net, struct net_device *dev,
+		       struct nlattr *tb[], struct nlattr *data[],
+		       struct netlink_ext_ack *extack)
+{
+	return -EOPNOTSUPP;
+}
+
+static void can_dellink(struct net_device *dev, struct list_head *head)
+{
+	return;
+}
+
+static struct rtnl_link_ops can_link_ops __read_mostly = {
+	.kind		= "can",
+	.netns_refund	= true,
+	.maxtype	= IFLA_CAN_MAX,
+	.policy		= can_policy,
+	.setup		= can_setup,
+	.validate	= can_validate,
+	.newlink	= can_newlink,
+	.changelink	= can_changelink,
+	.dellink	= can_dellink,
+	.get_size	= can_get_size,
+	.fill_info	= can_fill_info,
+	.get_xstats_size = can_get_xstats_size,
+	.fill_xstats	= can_fill_xstats,
+};
+
+/*
+ * Register the CAN network device
+ */
+int register_candev(struct net_device *dev)
+{
+	struct can_priv *priv = netdev_priv(dev);
+
+	/* Ensure termination_const, termination_const_cnt and
+	 * do_set_termination consistency. All must be either set or
+	 * unset.
+	 */
+	if ((!priv->termination_const != !priv->termination_const_cnt) ||
+	    (!priv->termination_const != !priv->do_set_termination))
+		return -EINVAL;
+
+	if (!priv->bitrate_const != !priv->bitrate_const_cnt)
+		return -EINVAL;
+
+	if (!priv->data_bitrate_const != !priv->data_bitrate_const_cnt)
+		return -EINVAL;
+
+	dev->rtnl_link_ops = &can_link_ops;
+	netif_carrier_off(dev);
+
+	return register_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(register_candev);
+
+/*
+ * Unregister the CAN network device
+ */
+void unregister_candev(struct net_device *dev)
+{
+	unregister_netdev(dev);
+}
+EXPORT_SYMBOL_GPL(unregister_candev);
+
+/*
+ * Test if a network device is a candev based device
+ * and return the can_priv* if so.
+ */
+struct can_priv *safe_candev_priv(struct net_device *dev)
+{
+	if ((dev->type != ARPHRD_CAN) || (dev->rtnl_link_ops != &can_link_ops))
+		return NULL;
+
+	return netdev_priv(dev);
+}
+EXPORT_SYMBOL_GPL(safe_candev_priv);
+
+static __init int can_dev_init(void)
+{
+	int err;
+
+	can_led_notifier_init();
+
+	err = rtnl_link_register(&can_link_ops);
+	if (!err)
+		printk(KERN_INFO MOD_DESC "\n");
+
+	return err;
+}
+module_init(can_dev_init);
+
+static __exit void can_dev_exit(void)
+{
+	rtnl_link_unregister(&can_link_ops);
+
+	can_led_notifier_exit();
+}
+module_exit(can_dev_exit);
+
+MODULE_ALIAS_RTNL_LINK("can");
diff --git a/drivers/net/can/dev/rx-offload.c b/drivers/net/can/dev/rx-offload.c
new file mode 100644
index 000000000000..5cf4171df1f4
--- /dev/null
+++ b/drivers/net/can/dev/rx-offload.c
@@ -0,0 +1,404 @@
+/*
+ * Copyright (c) 2014 David Jander, Protonic Holland
+ * Copyright (C) 2014-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the version 2 of the GNU General Public License
+ * as published by the Free Software Foundation
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include <linux/can/dev.h>
+#include <linux/can/rx-offload.h>
+
+struct can_rx_offload_cb {
+	u32 timestamp;
+};
+
+static inline struct can_rx_offload_cb *can_rx_offload_get_cb(struct sk_buff *skb)
+{
+	BUILD_BUG_ON(sizeof(struct can_rx_offload_cb) > sizeof(skb->cb));
+
+	return (struct can_rx_offload_cb *)skb->cb;
+}
+
+static inline bool can_rx_offload_le(struct can_rx_offload *offload, unsigned int a, unsigned int b)
+{
+	if (offload->inc)
+		return a <= b;
+	else
+		return a >= b;
+}
+
+static inline unsigned int can_rx_offload_inc(struct can_rx_offload *offload, unsigned int *val)
+{
+	if (offload->inc)
+		return (*val)++;
+	else
+		return (*val)--;
+}
+
+static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
+{
+	struct can_rx_offload *offload = container_of(napi, struct can_rx_offload, napi);
+	struct net_device *dev = offload->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	int work_done = 0;
+
+	while ((work_done < quota) &&
+	       (skb = skb_dequeue(&offload->skb_queue))) {
+		struct can_frame *cf = (struct can_frame *)skb->data;
+
+		work_done++;
+		stats->rx_packets++;
+		stats->rx_bytes += cf->can_dlc;
+		netif_receive_skb(skb);
+	}
+
+	if (work_done < quota) {
+		napi_complete_done(napi, work_done);
+
+		/* Check if there was another interrupt */
+		if (!skb_queue_empty(&offload->skb_queue))
+			napi_reschedule(&offload->napi);
+	}
+
+	can_led_event(offload->dev, CAN_LED_EVENT_RX);
+
+	return work_done;
+}
+
+static inline void __skb_queue_add_sort(struct sk_buff_head *head, struct sk_buff *new,
+					int (*compare)(struct sk_buff *a, struct sk_buff *b))
+{
+	struct sk_buff *pos, *insert = (struct sk_buff *)head;
+
+	skb_queue_reverse_walk(head, pos) {
+		const struct can_rx_offload_cb *cb_pos, *cb_new;
+
+		cb_pos = can_rx_offload_get_cb(pos);
+		cb_new = can_rx_offload_get_cb(new);
+
+		netdev_dbg(new->dev,
+			   "%s: pos=0x%08x, new=0x%08x, diff=%10d, queue_len=%d\n",
+			   __func__,
+			   cb_pos->timestamp, cb_new->timestamp,
+			   cb_new->timestamp - cb_pos->timestamp,
+			   skb_queue_len(head));
+
+		if (compare(pos, new) < 0)
+			continue;
+		insert = pos;
+		break;
+	}
+
+	__skb_queue_after(head, insert, new);
+}
+
+static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
+{
+	const struct can_rx_offload_cb *cb_a, *cb_b;
+
+	cb_a = can_rx_offload_get_cb(a);
+	cb_b = can_rx_offload_get_cb(b);
+
+	/* Substract two u32 and return result as int, to keep
+	 * difference steady around the u32 overflow.
+	 */
+	return cb_b->timestamp - cb_a->timestamp;
+}
+
+/**
+ * can_rx_offload_offload_one() - Read one CAN frame from HW
+ * @offload: pointer to rx_offload context
+ * @n: number of mailbox to read
+ *
+ * The task of this function is to read a CAN frame from mailbox @n
+ * from the device and return the mailbox's content as a struct
+ * sk_buff.
+ *
+ * If the struct can_rx_offload::skb_queue exceeds the maximal queue
+ * length (struct can_rx_offload::skb_queue_len_max) or no skb can be
+ * allocated, the mailbox contents is discarded by reading it into an
+ * overflow buffer. This way the mailbox is marked as free by the
+ * driver.
+ *
+ * Return: A pointer to skb containing the CAN frame on success.
+ *
+ *         NULL if the mailbox @n is empty.
+ *
+ *         ERR_PTR() in case of an error
+ */
+static struct sk_buff *
+can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
+{
+	struct sk_buff *skb = NULL, *skb_error = NULL;
+	struct can_rx_offload_cb *cb;
+	struct can_frame *cf;
+	int ret;
+
+	if (likely(skb_queue_len(&offload->skb_queue) <
+		   offload->skb_queue_len_max)) {
+		skb = alloc_can_skb(offload->dev, &cf);
+		if (unlikely(!skb))
+			skb_error = ERR_PTR(-ENOMEM);	/* skb alloc failed */
+	} else {
+		skb_error = ERR_PTR(-ENOBUFS);		/* skb_queue is full */
+	}
+
+	/* If queue is full or skb not available, drop by reading into
+	 * overflow buffer.
+	 */
+	if (unlikely(skb_error)) {
+		struct can_frame cf_overflow;
+		u32 timestamp;
+
+		ret = offload->mailbox_read(offload, &cf_overflow,
+					    &timestamp, n);
+
+		/* Mailbox was empty. */
+		if (unlikely(!ret))
+			return NULL;
+
+		/* Mailbox has been read and we're dropping it or
+		 * there was a problem reading the mailbox.
+		 *
+		 * Increment error counters in any case.
+		 */
+		offload->dev->stats.rx_dropped++;
+		offload->dev->stats.rx_fifo_errors++;
+
+		/* There was a problem reading the mailbox, propagate
+		 * error value.
+		 */
+		if (unlikely(ret < 0))
+			return ERR_PTR(ret);
+
+		return skb_error;
+	}
+
+	cb = can_rx_offload_get_cb(skb);
+	ret = offload->mailbox_read(offload, cf, &cb->timestamp, n);
+
+	/* Mailbox was empty. */
+	if (unlikely(!ret)) {
+		kfree_skb(skb);
+		return NULL;
+	}
+
+	/* There was a problem reading the mailbox, propagate error value. */
+	if (unlikely(ret < 0)) {
+		kfree_skb(skb);
+
+		offload->dev->stats.rx_dropped++;
+		offload->dev->stats.rx_fifo_errors++;
+
+		return ERR_PTR(ret);
+	}
+
+	/* Mailbox was read. */
+	return skb;
+}
+
+int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 pending)
+{
+	struct sk_buff_head skb_queue;
+	unsigned int i;
+
+	__skb_queue_head_init(&skb_queue);
+
+	for (i = offload->mb_first;
+	     can_rx_offload_le(offload, i, offload->mb_last);
+	     can_rx_offload_inc(offload, &i)) {
+		struct sk_buff *skb;
+
+		if (!(pending & BIT_ULL(i)))
+			continue;
+
+		skb = can_rx_offload_offload_one(offload, i);
+		if (IS_ERR_OR_NULL(skb))
+			continue;
+
+		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
+	}
+
+	if (!skb_queue_empty(&skb_queue)) {
+		unsigned long flags;
+		u32 queue_len;
+
+		spin_lock_irqsave(&offload->skb_queue.lock, flags);
+		skb_queue_splice_tail(&skb_queue, &offload->skb_queue);
+		spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+		if ((queue_len = skb_queue_len(&offload->skb_queue)) >
+		    (offload->skb_queue_len_max / 8))
+			netdev_dbg(offload->dev, "%s: queue_len=%d\n",
+				   __func__, queue_len);
+
+		can_rx_offload_schedule(offload);
+	}
+
+	return skb_queue_len(&skb_queue);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
+
+int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
+{
+	struct sk_buff *skb;
+	int received = 0;
+
+	while (1) {
+		skb = can_rx_offload_offload_one(offload, 0);
+		if (IS_ERR(skb))
+			continue;
+		if (!skb)
+			break;
+
+		skb_queue_tail(&offload->skb_queue, skb);
+		received++;
+	}
+
+	if (received)
+		can_rx_offload_schedule(offload);
+
+	return received;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
+
+int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
+				struct sk_buff *skb, u32 timestamp)
+{
+	struct can_rx_offload_cb *cb;
+	unsigned long flags;
+
+	if (skb_queue_len(&offload->skb_queue) >
+	    offload->skb_queue_len_max) {
+		dev_kfree_skb_any(skb);
+		return -ENOBUFS;
+	}
+
+	cb = can_rx_offload_get_cb(skb);
+	cb->timestamp = timestamp;
+
+	spin_lock_irqsave(&offload->skb_queue.lock, flags);
+	__skb_queue_add_sort(&offload->skb_queue, skb, can_rx_offload_compare);
+	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
+
+	can_rx_offload_schedule(offload);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_queue_sorted);
+
+unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
+					 unsigned int idx, u32 timestamp)
+{
+	struct net_device *dev = offload->dev;
+	struct net_device_stats *stats = &dev->stats;
+	struct sk_buff *skb;
+	u8 len;
+	int err;
+
+	skb = __can_get_echo_skb(dev, idx, &len);
+	if (!skb)
+		return 0;
+
+	err = can_rx_offload_queue_sorted(offload, skb, timestamp);
+	if (err) {
+		stats->rx_errors++;
+		stats->tx_fifo_errors++;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
+
+int can_rx_offload_queue_tail(struct can_rx_offload *offload,
+			      struct sk_buff *skb)
+{
+	if (skb_queue_len(&offload->skb_queue) >
+	    offload->skb_queue_len_max) {
+		dev_kfree_skb_any(skb);
+		return -ENOBUFS;
+	}
+
+	skb_queue_tail(&offload->skb_queue, skb);
+	can_rx_offload_schedule(offload);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
+
+static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+{
+	offload->dev = dev;
+
+	/* Limit queue len to 4x the weight (rounted to next power of two) */
+	offload->skb_queue_len_max = 2 << fls(weight);
+	offload->skb_queue_len_max *= 4;
+	skb_queue_head_init(&offload->skb_queue);
+
+	can_rx_offload_reset(offload);
+	netif_napi_add(dev, &offload->napi, can_rx_offload_napi_poll, weight);
+
+	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
+		__func__, offload->skb_queue_len_max);
+
+	return 0;
+}
+
+int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *offload)
+{
+	unsigned int weight;
+
+	if (offload->mb_first > BITS_PER_LONG_LONG ||
+	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
+		return -EINVAL;
+
+	if (offload->mb_first < offload->mb_last) {
+		offload->inc = true;
+		weight = offload->mb_last - offload->mb_first;
+	} else {
+		offload->inc = false;
+		weight = offload->mb_first - offload->mb_last;
+	}
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
+
+int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
+{
+	if (!offload->mailbox_read)
+		return -EINVAL;
+
+	return can_rx_offload_init_queue(dev, offload, weight);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
+
+void can_rx_offload_enable(struct can_rx_offload *offload)
+{
+	can_rx_offload_reset(offload);
+	napi_enable(&offload->napi);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_enable);
+
+void can_rx_offload_del(struct can_rx_offload *offload)
+{
+	netif_napi_del(&offload->napi);
+	skb_queue_purge(&offload->skb_queue);
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_del);
+
+void can_rx_offload_reset(struct can_rx_offload *offload)
+{
+}
+EXPORT_SYMBOL_GPL(can_rx_offload_reset);
diff --git a/drivers/net/can/rx-offload.c b/drivers/net/can/rx-offload.c
deleted file mode 100644
index 5cf4171df1f4..000000000000
--- a/drivers/net/can/rx-offload.c
+++ /dev/null
@@ -1,404 +0,0 @@
-/*
- * Copyright (c) 2014 David Jander, Protonic Holland
- * Copyright (C) 2014-2017 Pengutronix, Marc Kleine-Budde <kernel@pengutronix.de>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the version 2 of the GNU General Public License
- * as published by the Free Software Foundation
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include <linux/can/dev.h>
-#include <linux/can/rx-offload.h>
-
-struct can_rx_offload_cb {
-	u32 timestamp;
-};
-
-static inline struct can_rx_offload_cb *can_rx_offload_get_cb(struct sk_buff *skb)
-{
-	BUILD_BUG_ON(sizeof(struct can_rx_offload_cb) > sizeof(skb->cb));
-
-	return (struct can_rx_offload_cb *)skb->cb;
-}
-
-static inline bool can_rx_offload_le(struct can_rx_offload *offload, unsigned int a, unsigned int b)
-{
-	if (offload->inc)
-		return a <= b;
-	else
-		return a >= b;
-}
-
-static inline unsigned int can_rx_offload_inc(struct can_rx_offload *offload, unsigned int *val)
-{
-	if (offload->inc)
-		return (*val)++;
-	else
-		return (*val)--;
-}
-
-static int can_rx_offload_napi_poll(struct napi_struct *napi, int quota)
-{
-	struct can_rx_offload *offload = container_of(napi, struct can_rx_offload, napi);
-	struct net_device *dev = offload->dev;
-	struct net_device_stats *stats = &dev->stats;
-	struct sk_buff *skb;
-	int work_done = 0;
-
-	while ((work_done < quota) &&
-	       (skb = skb_dequeue(&offload->skb_queue))) {
-		struct can_frame *cf = (struct can_frame *)skb->data;
-
-		work_done++;
-		stats->rx_packets++;
-		stats->rx_bytes += cf->can_dlc;
-		netif_receive_skb(skb);
-	}
-
-	if (work_done < quota) {
-		napi_complete_done(napi, work_done);
-
-		/* Check if there was another interrupt */
-		if (!skb_queue_empty(&offload->skb_queue))
-			napi_reschedule(&offload->napi);
-	}
-
-	can_led_event(offload->dev, CAN_LED_EVENT_RX);
-
-	return work_done;
-}
-
-static inline void __skb_queue_add_sort(struct sk_buff_head *head, struct sk_buff *new,
-					int (*compare)(struct sk_buff *a, struct sk_buff *b))
-{
-	struct sk_buff *pos, *insert = (struct sk_buff *)head;
-
-	skb_queue_reverse_walk(head, pos) {
-		const struct can_rx_offload_cb *cb_pos, *cb_new;
-
-		cb_pos = can_rx_offload_get_cb(pos);
-		cb_new = can_rx_offload_get_cb(new);
-
-		netdev_dbg(new->dev,
-			   "%s: pos=0x%08x, new=0x%08x, diff=%10d, queue_len=%d\n",
-			   __func__,
-			   cb_pos->timestamp, cb_new->timestamp,
-			   cb_new->timestamp - cb_pos->timestamp,
-			   skb_queue_len(head));
-
-		if (compare(pos, new) < 0)
-			continue;
-		insert = pos;
-		break;
-	}
-
-	__skb_queue_after(head, insert, new);
-}
-
-static int can_rx_offload_compare(struct sk_buff *a, struct sk_buff *b)
-{
-	const struct can_rx_offload_cb *cb_a, *cb_b;
-
-	cb_a = can_rx_offload_get_cb(a);
-	cb_b = can_rx_offload_get_cb(b);
-
-	/* Substract two u32 and return result as int, to keep
-	 * difference steady around the u32 overflow.
-	 */
-	return cb_b->timestamp - cb_a->timestamp;
-}
-
-/**
- * can_rx_offload_offload_one() - Read one CAN frame from HW
- * @offload: pointer to rx_offload context
- * @n: number of mailbox to read
- *
- * The task of this function is to read a CAN frame from mailbox @n
- * from the device and return the mailbox's content as a struct
- * sk_buff.
- *
- * If the struct can_rx_offload::skb_queue exceeds the maximal queue
- * length (struct can_rx_offload::skb_queue_len_max) or no skb can be
- * allocated, the mailbox contents is discarded by reading it into an
- * overflow buffer. This way the mailbox is marked as free by the
- * driver.
- *
- * Return: A pointer to skb containing the CAN frame on success.
- *
- *         NULL if the mailbox @n is empty.
- *
- *         ERR_PTR() in case of an error
- */
-static struct sk_buff *
-can_rx_offload_offload_one(struct can_rx_offload *offload, unsigned int n)
-{
-	struct sk_buff *skb = NULL, *skb_error = NULL;
-	struct can_rx_offload_cb *cb;
-	struct can_frame *cf;
-	int ret;
-
-	if (likely(skb_queue_len(&offload->skb_queue) <
-		   offload->skb_queue_len_max)) {
-		skb = alloc_can_skb(offload->dev, &cf);
-		if (unlikely(!skb))
-			skb_error = ERR_PTR(-ENOMEM);	/* skb alloc failed */
-	} else {
-		skb_error = ERR_PTR(-ENOBUFS);		/* skb_queue is full */
-	}
-
-	/* If queue is full or skb not available, drop by reading into
-	 * overflow buffer.
-	 */
-	if (unlikely(skb_error)) {
-		struct can_frame cf_overflow;
-		u32 timestamp;
-
-		ret = offload->mailbox_read(offload, &cf_overflow,
-					    &timestamp, n);
-
-		/* Mailbox was empty. */
-		if (unlikely(!ret))
-			return NULL;
-
-		/* Mailbox has been read and we're dropping it or
-		 * there was a problem reading the mailbox.
-		 *
-		 * Increment error counters in any case.
-		 */
-		offload->dev->stats.rx_dropped++;
-		offload->dev->stats.rx_fifo_errors++;
-
-		/* There was a problem reading the mailbox, propagate
-		 * error value.
-		 */
-		if (unlikely(ret < 0))
-			return ERR_PTR(ret);
-
-		return skb_error;
-	}
-
-	cb = can_rx_offload_get_cb(skb);
-	ret = offload->mailbox_read(offload, cf, &cb->timestamp, n);
-
-	/* Mailbox was empty. */
-	if (unlikely(!ret)) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
-	/* There was a problem reading the mailbox, propagate error value. */
-	if (unlikely(ret < 0)) {
-		kfree_skb(skb);
-
-		offload->dev->stats.rx_dropped++;
-		offload->dev->stats.rx_fifo_errors++;
-
-		return ERR_PTR(ret);
-	}
-
-	/* Mailbox was read. */
-	return skb;
-}
-
-int can_rx_offload_irq_offload_timestamp(struct can_rx_offload *offload, u64 pending)
-{
-	struct sk_buff_head skb_queue;
-	unsigned int i;
-
-	__skb_queue_head_init(&skb_queue);
-
-	for (i = offload->mb_first;
-	     can_rx_offload_le(offload, i, offload->mb_last);
-	     can_rx_offload_inc(offload, &i)) {
-		struct sk_buff *skb;
-
-		if (!(pending & BIT_ULL(i)))
-			continue;
-
-		skb = can_rx_offload_offload_one(offload, i);
-		if (IS_ERR_OR_NULL(skb))
-			continue;
-
-		__skb_queue_add_sort(&skb_queue, skb, can_rx_offload_compare);
-	}
-
-	if (!skb_queue_empty(&skb_queue)) {
-		unsigned long flags;
-		u32 queue_len;
-
-		spin_lock_irqsave(&offload->skb_queue.lock, flags);
-		skb_queue_splice_tail(&skb_queue, &offload->skb_queue);
-		spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
-
-		if ((queue_len = skb_queue_len(&offload->skb_queue)) >
-		    (offload->skb_queue_len_max / 8))
-			netdev_dbg(offload->dev, "%s: queue_len=%d\n",
-				   __func__, queue_len);
-
-		can_rx_offload_schedule(offload);
-	}
-
-	return skb_queue_len(&skb_queue);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_timestamp);
-
-int can_rx_offload_irq_offload_fifo(struct can_rx_offload *offload)
-{
-	struct sk_buff *skb;
-	int received = 0;
-
-	while (1) {
-		skb = can_rx_offload_offload_one(offload, 0);
-		if (IS_ERR(skb))
-			continue;
-		if (!skb)
-			break;
-
-		skb_queue_tail(&offload->skb_queue, skb);
-		received++;
-	}
-
-	if (received)
-		can_rx_offload_schedule(offload);
-
-	return received;
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_irq_offload_fifo);
-
-int can_rx_offload_queue_sorted(struct can_rx_offload *offload,
-				struct sk_buff *skb, u32 timestamp)
-{
-	struct can_rx_offload_cb *cb;
-	unsigned long flags;
-
-	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max) {
-		dev_kfree_skb_any(skb);
-		return -ENOBUFS;
-	}
-
-	cb = can_rx_offload_get_cb(skb);
-	cb->timestamp = timestamp;
-
-	spin_lock_irqsave(&offload->skb_queue.lock, flags);
-	__skb_queue_add_sort(&offload->skb_queue, skb, can_rx_offload_compare);
-	spin_unlock_irqrestore(&offload->skb_queue.lock, flags);
-
-	can_rx_offload_schedule(offload);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_queue_sorted);
-
-unsigned int can_rx_offload_get_echo_skb(struct can_rx_offload *offload,
-					 unsigned int idx, u32 timestamp)
-{
-	struct net_device *dev = offload->dev;
-	struct net_device_stats *stats = &dev->stats;
-	struct sk_buff *skb;
-	u8 len;
-	int err;
-
-	skb = __can_get_echo_skb(dev, idx, &len);
-	if (!skb)
-		return 0;
-
-	err = can_rx_offload_queue_sorted(offload, skb, timestamp);
-	if (err) {
-		stats->rx_errors++;
-		stats->tx_fifo_errors++;
-	}
-
-	return len;
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_get_echo_skb);
-
-int can_rx_offload_queue_tail(struct can_rx_offload *offload,
-			      struct sk_buff *skb)
-{
-	if (skb_queue_len(&offload->skb_queue) >
-	    offload->skb_queue_len_max) {
-		dev_kfree_skb_any(skb);
-		return -ENOBUFS;
-	}
-
-	skb_queue_tail(&offload->skb_queue, skb);
-	can_rx_offload_schedule(offload);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_queue_tail);
-
-static int can_rx_offload_init_queue(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
-{
-	offload->dev = dev;
-
-	/* Limit queue len to 4x the weight (rounted to next power of two) */
-	offload->skb_queue_len_max = 2 << fls(weight);
-	offload->skb_queue_len_max *= 4;
-	skb_queue_head_init(&offload->skb_queue);
-
-	can_rx_offload_reset(offload);
-	netif_napi_add(dev, &offload->napi, can_rx_offload_napi_poll, weight);
-
-	dev_dbg(dev->dev.parent, "%s: skb_queue_len_max=%d\n",
-		__func__, offload->skb_queue_len_max);
-
-	return 0;
-}
-
-int can_rx_offload_add_timestamp(struct net_device *dev, struct can_rx_offload *offload)
-{
-	unsigned int weight;
-
-	if (offload->mb_first > BITS_PER_LONG_LONG ||
-	    offload->mb_last > BITS_PER_LONG_LONG || !offload->mailbox_read)
-		return -EINVAL;
-
-	if (offload->mb_first < offload->mb_last) {
-		offload->inc = true;
-		weight = offload->mb_last - offload->mb_first;
-	} else {
-		offload->inc = false;
-		weight = offload->mb_first - offload->mb_last;
-	}
-
-	return can_rx_offload_init_queue(dev, offload, weight);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_add_timestamp);
-
-int can_rx_offload_add_fifo(struct net_device *dev, struct can_rx_offload *offload, unsigned int weight)
-{
-	if (!offload->mailbox_read)
-		return -EINVAL;
-
-	return can_rx_offload_init_queue(dev, offload, weight);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_add_fifo);
-
-void can_rx_offload_enable(struct can_rx_offload *offload)
-{
-	can_rx_offload_reset(offload);
-	napi_enable(&offload->napi);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_enable);
-
-void can_rx_offload_del(struct can_rx_offload *offload)
-{
-	netif_napi_del(&offload->napi);
-	skb_queue_purge(&offload->skb_queue);
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_del);
-
-void can_rx_offload_reset(struct can_rx_offload *offload)
-{
-}
-EXPORT_SYMBOL_GPL(can_rx_offload_reset);
diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 43b83a3a2804..f0b5c8a4d29f 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -18217,7 +18217,8 @@ static void tg3_shutdown(struct pci_dev *pdev)
 	if (netif_running(dev))
 		dev_close(dev);
 
-	tg3_power_down(tp);
+	if (system_state == SYSTEM_POWER_OFF)
+		tg3_power_down(tp);
 
 	rtnl_unlock();
 
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index a908720535ce..75a553f4e26f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -14311,11 +14311,15 @@ static void i40e_remove(struct pci_dev *pdev)
 			i40e_switch_branch_release(pf->veb[i]);
 	}
 
-	/* Now we can shutdown the PF's VSI, just before we kill
+	/* Now we can shutdown the PF's VSIs, just before we kill
 	 * adminq and hmc.
 	 */
-	if (pf->vsi[pf->lan_vsi])
-		i40e_vsi_release(pf->vsi[pf->lan_vsi]);
+	for (i = pf->num_alloc_vsi; i--;)
+		if (pf->vsi[i]) {
+			i40e_vsi_close(pf->vsi[i]);
+			i40e_vsi_release(pf->vsi[i]);
+			pf->vsi[i] = NULL;
+		}
 
 	i40e_cloud_filter_exit(pf);
 
diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 92875a935eb1..d6b01f34cfa4 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -66,7 +66,7 @@
 
 /* Maximum number of multicast addresses to filter (vs. Rx-all-multicast).
    The RTL chips use a 64 element hash table based on the Ethernet CRC. */
-static const int multicast_filter_limit = 32;
+#define	MC_FILTER_LIMIT	32
 
 #define TX_DMA_BURST	7	/* Maximum PCI burst, '7' is unlimited */
 #define InterFrameGap	0x03	/* 3 means InterFrameGap = the shortest one */
@@ -4614,54 +4614,50 @@ static void rtl8169_set_magic_reg(struct rtl8169_private *tp, unsigned mac_versi
 
 static void rtl_set_rx_mode(struct net_device *dev)
 {
+	u32 rx_mode = AcceptBroadcast | AcceptMyPhys | AcceptMulticast;
+	/* Multicast hash filter */
+	u32 mc_filter[2] = { 0xffffffff, 0xffffffff };
 	struct rtl8169_private *tp = netdev_priv(dev);
-	u32 mc_filter[2];	/* Multicast hash filter */
-	int rx_mode;
-	u32 tmp = 0;
+	u32 tmp;
 
 	if (dev->flags & IFF_PROMISC) {
 		/* Unconditionally log net taps. */
 		netif_notice(tp, link, dev, "Promiscuous mode enabled\n");
-		rx_mode =
-		    AcceptBroadcast | AcceptMulticast | AcceptMyPhys |
-		    AcceptAllPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-	} else if ((netdev_mc_count(dev) > multicast_filter_limit) ||
-		   (dev->flags & IFF_ALLMULTI)) {
-		/* Too many to filter perfectly -- accept all multicasts. */
-		rx_mode = AcceptBroadcast | AcceptMulticast | AcceptMyPhys;
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
+		rx_mode |= AcceptAllPhys;
+	} else if (!(dev->flags & IFF_MULTICAST)) {
+		rx_mode &= ~AcceptMulticast;
+	} else if (netdev_mc_count(dev) > MC_FILTER_LIMIT ||
+		   dev->flags & IFF_ALLMULTI ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_35 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_46 ||
+		   tp->mac_version == RTL_GIGA_MAC_VER_48) {
+		/* accept all multicasts */
+	} else if (netdev_mc_empty(dev)) {
+		rx_mode &= ~AcceptMulticast;
 	} else {
 		struct netdev_hw_addr *ha;
 
-		rx_mode = AcceptBroadcast | AcceptMyPhys;
 		mc_filter[1] = mc_filter[0] = 0;
 		netdev_for_each_mc_addr(ha, dev) {
-			int bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			mc_filter[bit_nr >> 5] |= 1 << (bit_nr & 31);
-			rx_mode |= AcceptMulticast;
+			u32 bit_nr = ether_crc(ETH_ALEN, ha->addr) >> 26;
+			mc_filter[bit_nr >> 5] |= BIT(bit_nr & 31);
+		}
+
+		if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
+			tmp = mc_filter[0];
+			mc_filter[0] = swab32(mc_filter[1]);
+			mc_filter[1] = swab32(tmp);
 		}
 	}
 
 	if (dev->features & NETIF_F_RXALL)
 		rx_mode |= (AcceptErr | AcceptRunt);
 
-	tmp = (RTL_R32(tp, RxConfig) & ~RX_CONFIG_ACCEPT_MASK) | rx_mode;
-
-	if (tp->mac_version > RTL_GIGA_MAC_VER_06) {
-		u32 data = mc_filter[0];
-
-		mc_filter[0] = swab32(mc_filter[1]);
-		mc_filter[1] = swab32(data);
-	}
-
-	if (tp->mac_version == RTL_GIGA_MAC_VER_35)
-		mc_filter[1] = mc_filter[0] = 0xffffffff;
-
 	RTL_W32(tp, MAR0 + 4, mc_filter[1]);
 	RTL_W32(tp, MAR0 + 0, mc_filter[0]);
 
-	RTL_W32(tp, RxConfig, tmp);
+	tmp = RTL_R32(tp, RxConfig);
+	RTL_W32(tp, RxConfig, (tmp & ~RX_CONFIG_ACCEPT_MASK) | rx_mode);
 }
 
 static void rtl_hw_start(struct  rtl8169_private *tp)
diff --git a/drivers/net/ipvlan/ipvlan_core.c b/drivers/net/ipvlan/ipvlan_core.c
index 6b6c5a7250a6..ecb10fb249af 100644
--- a/drivers/net/ipvlan/ipvlan_core.c
+++ b/drivers/net/ipvlan/ipvlan_core.c
@@ -448,12 +448,12 @@ static int ipvlan_process_v4_outbound(struct sk_buff *skb)
 
 	err = ip_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
@@ -489,12 +489,12 @@ static int ipvlan_process_v6_outbound(struct sk_buff *skb)
 
 	err = ip6_local_out(net, skb->sk, skb);
 	if (unlikely(net_xmit_eval(err)))
-		dev->stats.tx_errors++;
+		DEV_STATS_INC(dev, tx_errors);
 	else
 		ret = NET_XMIT_SUCCESS;
 	goto out;
 err:
-	dev->stats.tx_errors++;
+	DEV_STATS_INC(dev, tx_errors);
 	kfree_skb(skb);
 out:
 	return ret;
diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
index 9fa3c0bd6ec7..6d2ff73b63f8 100644
--- a/drivers/net/ipvlan/ipvlan_main.c
+++ b/drivers/net/ipvlan/ipvlan_main.c
@@ -392,6 +392,7 @@ static void ipvlan_get_stats64(struct net_device *dev,
 		s->rx_dropped = rx_errs;
 		s->tx_dropped = tx_drps;
 	}
+	s->tx_errors = DEV_STATS_READ(dev, tx_errors);
 }
 
 static int ipvlan_vlan_rx_add_vid(struct net_device *dev, __be16 proto, u16 vid)
diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
index a913ba87209a..54b19977fb67 100644
--- a/drivers/net/macsec.c
+++ b/drivers/net/macsec.c
@@ -322,6 +322,19 @@ static struct macsec_rx_sa *macsec_rxsa_get(struct macsec_rx_sa __rcu *ptr)
 	return sa;
 }
 
+static struct macsec_rx_sa *macsec_active_rxsa_get(struct macsec_rx_sc *rx_sc)
+{
+	struct macsec_rx_sa *sa = NULL;
+	int an;
+
+	for (an = 0; an < MACSEC_NUM_AN; an++)	{
+		sa = macsec_rxsa_get(rx_sc->sa[an]);
+		if (sa)
+			break;
+	}
+	return sa;
+}
+
 static void free_rx_sc_rcu(struct rcu_head *head)
 {
 	struct macsec_rx_sc *rx_sc = container_of(head, struct macsec_rx_sc, rcu_head);
@@ -566,18 +579,28 @@ static void macsec_encrypt_finish(struct sk_buff *skb, struct net_device *dev)
 	skb->protocol = eth_hdr(skb)->h_proto;
 }
 
+static unsigned int macsec_msdu_len(struct sk_buff *skb)
+{
+	struct macsec_dev *macsec = macsec_priv(skb->dev);
+	struct macsec_secy *secy = &macsec->secy;
+	bool sci_present = macsec_skb_cb(skb)->has_sci;
+
+	return skb->len - macsec_hdr_len(sci_present) - secy->icv_len;
+}
+
 static void macsec_count_tx(struct sk_buff *skb, struct macsec_tx_sc *tx_sc,
 			    struct macsec_tx_sa *tx_sa)
 {
+	unsigned int msdu_len = macsec_msdu_len(skb);
 	struct pcpu_tx_sc_stats *txsc_stats = this_cpu_ptr(tx_sc->stats);
 
 	u64_stats_update_begin(&txsc_stats->syncp);
 	if (tx_sc->encrypt) {
-		txsc_stats->stats.OutOctetsEncrypted += skb->len;
+		txsc_stats->stats.OutOctetsEncrypted += msdu_len;
 		txsc_stats->stats.OutPktsEncrypted++;
 		this_cpu_inc(tx_sa->stats->OutPktsEncrypted);
 	} else {
-		txsc_stats->stats.OutOctetsProtected += skb->len;
+		txsc_stats->stats.OutOctetsProtected += msdu_len;
 		txsc_stats->stats.OutPktsProtected++;
 		this_cpu_inc(tx_sa->stats->OutPktsProtected);
 	}
@@ -607,9 +630,10 @@ static void macsec_encrypt_done(struct crypto_async_request *base, int err)
 	aead_request_free(macsec_skb_cb(skb)->req);
 
 	rcu_read_lock_bh();
-	macsec_encrypt_finish(skb, dev);
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
-	len = skb->len;
+	/* packet is encrypted/protected so tx_bytes must be calculated */
+	len = macsec_msdu_len(skb) + 2 * ETH_ALEN;
+	macsec_encrypt_finish(skb, dev);
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	rcu_read_unlock_bh();
@@ -765,6 +789,7 @@ static struct sk_buff *macsec_encrypt(struct sk_buff *skb,
 
 	macsec_skb_cb(skb)->req = req;
 	macsec_skb_cb(skb)->tx_sa = tx_sa;
+	macsec_skb_cb(skb)->has_sci = sci_present;
 	aead_request_set_callback(req, 0, macsec_encrypt_done, skb);
 
 	dev_hold(skb->dev);
@@ -805,15 +830,17 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsLate++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_dropped);
 		return false;
 	}
 
 	if (secy->validate_frames != MACSEC_VALIDATE_DISABLED) {
+		unsigned int msdu_len = macsec_msdu_len(skb);
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		if (hdr->tci_an & MACSEC_TCI_E)
-			rxsc_stats->stats.InOctetsDecrypted += skb->len;
+			rxsc_stats->stats.InOctetsDecrypted += msdu_len;
 		else
-			rxsc_stats->stats.InOctetsValidated += skb->len;
+			rxsc_stats->stats.InOctetsValidated += msdu_len;
 		u64_stats_update_end(&rxsc_stats->syncp);
 	}
 
@@ -826,6 +853,8 @@ static bool macsec_post_decrypt(struct sk_buff *skb, struct macsec_secy *secy, u
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotValid++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			this_cpu_inc(rx_sa->stats->InPktsNotValid);
+			DEV_STATS_INC(secy->netdev, rx_errors);
 			return false;
 		}
 
@@ -911,9 +940,9 @@ static void macsec_decrypt_done(struct crypto_async_request *base, int err)
 
 	macsec_finalize_skb(skb, macsec->secy.icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, macsec->secy.netdev);
 
-	len = skb->len;
 	if (gro_cells_receive(&macsec->gro_cells, skb) == NET_RX_SUCCESS)
 		count_rx(dev, len);
 
@@ -1055,6 +1084,7 @@ static void handle_not_macsec(struct sk_buff *skb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoTag++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			continue;
 		}
 
@@ -1165,6 +1195,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&secy_stats->syncp);
 		secy_stats->stats.InPktsBadTag++;
 		u64_stats_update_end(&secy_stats->syncp);
+		DEV_STATS_INC(secy->netdev, rx_errors);
 		goto drop_nosa;
 	}
 
@@ -1175,11 +1206,15 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		/* If validateFrames is Strict or the C bit in the
 		 * SecTAG is set, discard
 		 */
+		struct macsec_rx_sa *active_rx_sa = macsec_active_rxsa_get(rx_sc);
 		if (hdr->tci_an & MACSEC_TCI_C ||
 		    secy->validate_frames == MACSEC_VALIDATE_STRICT) {
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsNotUsingSA++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(secy->netdev, rx_errors);
+			if (active_rx_sa)
+				this_cpu_inc(active_rx_sa->stats->InPktsNotUsingSA);
 			goto drop_nosa;
 		}
 
@@ -1189,6 +1224,8 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 		u64_stats_update_begin(&rxsc_stats->syncp);
 		rxsc_stats->stats.InPktsUnusedSA++;
 		u64_stats_update_end(&rxsc_stats->syncp);
+		if (active_rx_sa)
+			this_cpu_inc(active_rx_sa->stats->InPktsUnusedSA);
 		goto deliver;
 	}
 
@@ -1206,6 +1243,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&rxsc_stats->syncp);
 			rxsc_stats->stats.InPktsLate++;
 			u64_stats_update_end(&rxsc_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 			goto drop;
 		}
 	}
@@ -1234,6 +1272,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 deliver:
 	macsec_finalize_skb(skb, secy->icv_len,
 			    macsec_extra_len(macsec_skb_cb(skb)->has_sci));
+	len = skb->len;
 	macsec_reset_skb(skb, secy->netdev);
 
 	if (rx_sa)
@@ -1241,12 +1280,11 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 	macsec_rxsc_put(rx_sc);
 
 	skb_orphan(skb);
-	len = skb->len;
 	ret = gro_cells_receive(&macsec->gro_cells, skb);
 	if (ret == NET_RX_SUCCESS)
 		count_rx(dev, len);
 	else
-		macsec->secy.netdev->stats.rx_dropped++;
+		DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 
 	rcu_read_unlock();
 
@@ -1283,6 +1321,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			u64_stats_update_begin(&secy_stats->syncp);
 			secy_stats->stats.InPktsNoSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
+			DEV_STATS_INC(macsec->secy.netdev, rx_errors);
 			continue;
 		}
 
@@ -1301,7 +1340,7 @@ static rx_handler_result_t macsec_handle_frame(struct sk_buff **pskb)
 			secy_stats->stats.InPktsUnknownSCI++;
 			u64_stats_update_end(&secy_stats->syncp);
 		} else {
-			macsec->secy.netdev->stats.rx_dropped++;
+			DEV_STATS_INC(macsec->secy.netdev, rx_dropped);
 		}
 	}
 
@@ -2733,21 +2772,21 @@ static netdev_tx_t macsec_start_xmit(struct sk_buff *skb,
 
 	if (!secy->operational) {
 		kfree_skb(skb);
-		dev->stats.tx_dropped++;
+		DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
+	len = skb->len;
 	skb = macsec_encrypt(skb, dev);
 	if (IS_ERR(skb)) {
 		if (PTR_ERR(skb) != -EINPROGRESS)
-			dev->stats.tx_dropped++;
+			DEV_STATS_INC(dev, tx_dropped);
 		return NETDEV_TX_OK;
 	}
 
 	macsec_count_tx(skb, &macsec->secy.tx_sc, macsec_skb_cb(skb)->tx_sa);
 
 	macsec_encrypt_finish(skb, dev);
-	len = skb->len;
 	ret = dev_queue_xmit(skb);
 	count_tx(dev, ret, len);
 	return ret;
@@ -2960,8 +2999,9 @@ static void macsec_get_stats64(struct net_device *dev,
 		s->tx_bytes   += tmp.tx_bytes;
 	}
 
-	s->rx_dropped = dev->stats.rx_dropped;
-	s->tx_dropped = dev->stats.tx_dropped;
+	s->rx_dropped = DEV_STATS_READ(dev, rx_dropped);
+	s->tx_dropped = DEV_STATS_READ(dev, tx_dropped);
+	s->rx_errors = DEV_STATS_READ(dev, rx_errors);
 }
 
 static int macsec_get_iflink(const struct net_device *dev)
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
index e05af7d60830..d54ecbe717e7 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8188ee/dm.c
@@ -827,7 +827,7 @@ static void rtl88e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
index 0b5a06ffa482..ed3ef78e5394 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8192c/dm_common.c
@@ -663,7 +663,7 @@ static void rtl92c_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
index 42a6fba90ba9..fedde63d9bc5 100644
--- a/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
+++ b/drivers/net/wireless/realtek/rtlwifi/rtl8723ae/dm.c
@@ -592,7 +592,7 @@ static void rtl8723e_dm_check_edca_turbo(struct ieee80211_hw *hw)
 	}
 
 	if (rtlpriv->btcoexist.bt_edca_dl != 0) {
-		edca_be_ul = rtlpriv->btcoexist.bt_edca_dl;
+		edca_be_dl = rtlpriv->btcoexist.bt_edca_dl;
 		bt_change_edca = true;
 	}
 
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index 609fc450522a..89539a078623 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -947,7 +947,8 @@ unsigned int nd_region_acquire_lane(struct nd_region *nd_region)
 {
 	unsigned int cpu, lane;
 
-	cpu = get_cpu();
+	migrate_disable();
+	cpu = smp_processor_id();
 	if (nd_region->num_lanes < nr_cpu_ids) {
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
@@ -966,16 +967,15 @@ EXPORT_SYMBOL(nd_region_acquire_lane);
 void nd_region_release_lane(struct nd_region *nd_region, unsigned int lane)
 {
 	if (nd_region->num_lanes < nr_cpu_ids) {
-		unsigned int cpu = get_cpu();
+		unsigned int cpu = smp_processor_id();
 		struct nd_percpu_lane *ndl_lock, *ndl_count;
 
 		ndl_count = per_cpu_ptr(nd_region->lane, cpu);
 		ndl_lock = per_cpu_ptr(nd_region->lane, lane);
 		if (--ndl_count->count == 0)
 			spin_unlock(&ndl_lock->lock);
-		put_cpu();
 	}
-	put_cpu();
+	migrate_enable();
 }
 EXPORT_SYMBOL(nd_region_release_lane);
 
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 182e5ef4ab83..e99ef7b745ae 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -608,6 +608,7 @@ static int pccardd(void *__skt)
 		dev_warn(&skt->dev, "PCMCIA: unable to register socket\n");
 		skt->thread = NULL;
 		complete(&skt->thread_done);
+		put_device(&skt->dev);
 		return 0;
 	}
 	ret = pccard_sysfs_add_socket(&skt->dev);
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index a9258f641cee..3701887be32e 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -521,9 +521,6 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 	/* by default don't allow DMA */
 	p_dev->dma_mask = DMA_MASK_NONE;
 	p_dev->dev.dma_mask = &p_dev->dma_mask;
-	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
-	if (!dev_name(&p_dev->dev))
-		goto err_free;
 	p_dev->devname = kasprintf(GFP_KERNEL, "pcmcia%s", dev_name(&p_dev->dev));
 	if (!p_dev->devname)
 		goto err_free;
@@ -581,8 +578,15 @@ static struct pcmcia_device *pcmcia_device_add(struct pcmcia_socket *s,
 
 	pcmcia_device_query(p_dev);
 
-	if (device_register(&p_dev->dev))
-		goto err_unreg;
+	dev_set_name(&p_dev->dev, "%d.%d", p_dev->socket->sock, p_dev->device_no);
+	if (device_register(&p_dev->dev)) {
+		mutex_lock(&s->ops_mutex);
+		list_del(&p_dev->socket_device_list);
+		s->device_count--;
+		mutex_unlock(&s->ops_mutex);
+		put_device(&p_dev->dev);
+		return NULL;
+	}
 
 	return p_dev;
 
diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 387358af685c..136347a195ec 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -172,7 +172,7 @@ static int get_subobj_info(acpi_handle handle, const char *pathname,
 
 static acpi_status wmi_method_enable(struct wmi_block *wblock, int enable)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	char method[5];
 	acpi_status status;
 	acpi_handle handle;
@@ -246,8 +246,8 @@ EXPORT_SYMBOL_GPL(wmi_evaluate_method);
 acpi_status wmidev_evaluate_method(struct wmi_device *wdev, u8 instance,
 	u32 method_id, const struct acpi_buffer *in, struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
-	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
+	struct wmi_block *wblock;
 	acpi_handle handle;
 	acpi_status status;
 	struct acpi_object_list input;
@@ -294,7 +294,7 @@ EXPORT_SYMBOL_GPL(wmidev_evaluate_method);
 static acpi_status __query_block(struct wmi_block *wblock, u8 instance,
 				 struct acpi_buffer *out)
 {
-	struct guid_block *block = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	acpi_status status, wc_status = AE_ERROR;
 	struct acpi_object_list input;
@@ -409,8 +409,8 @@ EXPORT_SYMBOL_GPL(wmidev_block_query);
 acpi_status wmi_set_block(const char *guid_string, u8 instance,
 			  const struct acpi_buffer *in)
 {
-	struct guid_block *block = NULL;
 	struct wmi_block *wblock = NULL;
+	struct guid_block *block;
 	acpi_handle handle;
 	struct acpi_object_list input;
 	union acpi_object params[2];
@@ -793,21 +793,13 @@ static int wmi_dev_match(struct device *dev, struct device_driver *driver)
 }
 static int wmi_char_open(struct inode *inode, struct file *filp)
 {
-	const char *driver_name = filp->f_path.dentry->d_iname;
-	struct wmi_block *wblock = NULL;
-	struct wmi_block *next = NULL;
-
-	list_for_each_entry_safe(wblock, next, &wmi_block_list, list) {
-		if (!wblock->dev.dev.driver)
-			continue;
-		if (strcmp(driver_name, wblock->dev.dev.driver->name) == 0) {
-			filp->private_data = wblock;
-			break;
-		}
-	}
+	/*
+	 * The miscdevice already stores a pointer to itself
+	 * inside filp->private_data
+	 */
+	struct wmi_block *wblock = container_of(filp->private_data, struct wmi_block, char_dev);
 
-	if (!filp->private_data)
-		return -ENODEV;
+	filp->private_data = wblock;
 
 	return nonseekable_open(inode, filp);
 }
@@ -827,8 +819,8 @@ static long wmi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	struct wmi_ioctl_buffer __user *input =
 		(struct wmi_ioctl_buffer __user *) arg;
 	struct wmi_block *wblock = filp->private_data;
-	struct wmi_ioctl_buffer *buf = NULL;
-	struct wmi_driver *wdriver = NULL;
+	struct wmi_ioctl_buffer *buf;
+	struct wmi_driver *wdriver;
 	int ret;
 
 	if (_IOC_TYPE(cmd) != WMI_IOC)
@@ -1131,8 +1123,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 	struct wmi_block *wblock, *next;
 	union acpi_object *obj;
 	acpi_status status;
-	int retval = 0;
 	u32 i, total;
+	int retval;
 
 	status = acpi_evaluate_object(device->handle, "_WDG", NULL, &out);
 	if (ACPI_FAILURE(status))
@@ -1143,8 +1135,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		return -ENXIO;
 
 	if (obj->type != ACPI_TYPE_BUFFER) {
-		retval = -ENXIO;
-		goto out_free_pointer;
+		kfree(obj);
+		return -ENXIO;
 	}
 
 	gblock = (const struct guid_block *)obj->buffer.pointer;
@@ -1165,8 +1157,8 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 
 		wblock = kzalloc(sizeof(struct wmi_block), GFP_KERNEL);
 		if (!wblock) {
-			retval = -ENOMEM;
-			break;
+			dev_err(wmi_bus_dev, "Failed to allocate %pUL\n", &gblock[i].guid);
+			continue;
 		}
 
 		wblock->acpi_device = device;
@@ -1205,9 +1197,9 @@ static int parse_wdg(struct device *wmi_bus_dev, struct acpi_device *device)
 		}
 	}
 
-out_free_pointer:
-	kfree(out.pointer);
-	return retval;
+	kfree(obj);
+
+	return 0;
 }
 
 /*
diff --git a/drivers/pwm/pwm-brcmstb.c b/drivers/pwm/pwm-brcmstb.c
index 8063cffa1c96..5d7842a62d59 100644
--- a/drivers/pwm/pwm-brcmstb.c
+++ b/drivers/pwm/pwm-brcmstb.c
@@ -307,7 +307,7 @@ static int brcmstb_pwm_suspend(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_disable(p->clk);
+	clk_disable_unprepare(p->clk);
 
 	return 0;
 }
@@ -316,7 +316,7 @@ static int brcmstb_pwm_resume(struct device *dev)
 {
 	struct brcmstb_pwm *p = dev_get_drvdata(dev);
 
-	clk_enable(p->clk);
+	clk_prepare_enable(p->clk);
 
 	return 0;
 }
diff --git a/drivers/pwm/pwm-sti.c b/drivers/pwm/pwm-sti.c
index 2b7c31c9d1ab..059650d8118e 100644
--- a/drivers/pwm/pwm-sti.c
+++ b/drivers/pwm/pwm-sti.c
@@ -83,6 +83,7 @@ struct sti_pwm_compat_data {
 	unsigned int cpt_num_devs;
 	unsigned int max_pwm_cnt;
 	unsigned int max_prescale;
+	struct sti_cpt_ddata *ddata;
 };
 
 struct sti_pwm_chip {
@@ -318,7 +319,7 @@ static int sti_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 {
 	struct sti_pwm_chip *pc = to_sti_pwmchip(chip);
 	struct sti_pwm_compat_data *cdata = pc->cdata;
-	struct sti_cpt_ddata *ddata = pwm_get_chip_data(pwm);
+	struct sti_cpt_ddata *ddata = &cdata->ddata[pwm->hwpwm];
 	struct device *dev = pc->dev;
 	unsigned int effective_ticks;
 	unsigned long long high, low;
@@ -421,7 +422,7 @@ static irqreturn_t sti_pwm_interrupt(int irq, void *data)
 	while (cpt_int_stat) {
 		devicenum = ffs(cpt_int_stat) - 1;
 
-		ddata = pwm_get_chip_data(&pc->chip.pwms[devicenum]);
+		ddata = &pc->cdata->ddata[devicenum];
 
 		/*
 		 * Capture input:
@@ -599,61 +600,55 @@ static int sti_pwm_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	if (!cdata->pwm_num_devs)
-		goto skip_pwm;
-
-	pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
-	if (IS_ERR(pc->pwm_clk)) {
-		dev_err(dev, "failed to get PWM clock\n");
-		return PTR_ERR(pc->pwm_clk);
-	}
+	if (cdata->pwm_num_devs) {
+		pc->pwm_clk = of_clk_get_by_name(dev->of_node, "pwm");
+		if (IS_ERR(pc->pwm_clk)) {
+			dev_err(dev, "failed to get PWM clock\n");
+			return PTR_ERR(pc->pwm_clk);
+		}
 
-	ret = clk_prepare(pc->pwm_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		ret = clk_prepare(pc->pwm_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 	}
 
-skip_pwm:
-	if (!cdata->cpt_num_devs)
-		goto skip_cpt;
+	if (cdata->cpt_num_devs) {
+		pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
+		if (IS_ERR(pc->cpt_clk)) {
+			dev_err(dev, "failed to get PWM capture clock\n");
+			return PTR_ERR(pc->cpt_clk);
+		}
 
-	pc->cpt_clk = of_clk_get_by_name(dev->of_node, "capture");
-	if (IS_ERR(pc->cpt_clk)) {
-		dev_err(dev, "failed to get PWM capture clock\n");
-		return PTR_ERR(pc->cpt_clk);
-	}
+		ret = clk_prepare(pc->cpt_clk);
+		if (ret) {
+			dev_err(dev, "failed to prepare clock\n");
+			return ret;
+		}
 
-	ret = clk_prepare(pc->cpt_clk);
-	if (ret) {
-		dev_err(dev, "failed to prepare clock\n");
-		return ret;
+		cdata->ddata = devm_kzalloc(dev, cdata->cpt_num_devs * sizeof(*cdata->ddata), GFP_KERNEL);
+		if (!cdata->ddata)
+			return -ENOMEM;
 	}
 
-skip_cpt:
 	pc->chip.dev = dev;
 	pc->chip.ops = &sti_pwm_ops;
 	pc->chip.base = -1;
 	pc->chip.npwm = pc->cdata->pwm_num_devs;
 
-	ret = pwmchip_add(&pc->chip);
-	if (ret < 0) {
-		clk_unprepare(pc->pwm_clk);
-		clk_unprepare(pc->cpt_clk);
-		return ret;
-	}
-
 	for (i = 0; i < cdata->cpt_num_devs; i++) {
-		struct sti_cpt_ddata *ddata;
-
-		ddata = devm_kzalloc(dev, sizeof(*ddata), GFP_KERNEL);
-		if (!ddata)
-			return -ENOMEM;
+		struct sti_cpt_ddata *ddata = &cdata->ddata[i];
 
 		init_waitqueue_head(&ddata->wait);
 		mutex_init(&ddata->lock);
+	}
 
-		pwm_set_chip_data(&pc->chip.pwms[i], ddata);
+	ret = pwmchip_add(&pc->chip);
+	if (ret < 0) {
+		clk_unprepare(pc->pwm_clk);
+		clk_unprepare(pc->cpt_clk);
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, pc);
diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 6c7825c581b5..efed0736546d 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -734,7 +734,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto release_ida;
 
-	sprintf(dev->attr_name, "cdev%d_trip_point", dev->id);
+	snprintf(dev->attr_name, sizeof(dev->attr_name), "cdev%d_trip_point",
+		 dev->id);
 	sysfs_attr_init(&dev->attr.attr);
 	dev->attr.attr.name = dev->attr_name;
 	dev->attr.attr.mode = 0444;
@@ -743,7 +744,8 @@ int thermal_zone_bind_cooling_device(struct thermal_zone_device *tz,
 	if (result)
 		goto remove_symbol_link;
 
-	sprintf(dev->weight_attr_name, "cdev%d_weight", dev->id);
+	snprintf(dev->weight_attr_name, sizeof(dev->weight_attr_name),
+		 "cdev%d_weight", dev->id);
 	sysfs_attr_init(&dev->weight_attr.attr);
 	dev->weight_attr.attr.name = dev->weight_attr_name;
 	dev->weight_attr.attr.mode = S_IWUSR | S_IRUGO;
diff --git a/drivers/tty/tty_jobctrl.c b/drivers/tty/tty_jobctrl.c
index ffcab80ba77d..73fdd55c6bef 100644
--- a/drivers/tty/tty_jobctrl.c
+++ b/drivers/tty/tty_jobctrl.c
@@ -290,12 +290,7 @@ void disassociate_ctty(int on_exit)
 		return;
 	}
 
-	spin_lock_irq(&current->sighand->siglock);
-	put_pid(current->signal->tty_old_pgrp);
-	current->signal->tty_old_pgrp = NULL;
-	tty = tty_kref_get(current->signal->tty);
-	spin_unlock_irq(&current->sighand->siglock);
-
+	tty = get_current_tty();
 	if (tty) {
 		unsigned long flags;
 
@@ -310,6 +305,16 @@ void disassociate_ctty(int on_exit)
 		tty_kref_put(tty);
 	}
 
+	/* If tty->ctrl.pgrp is not NULL, it may be assigned to
+	 * current->signal->tty_old_pgrp in a race condition, and
+	 * cause pid memleak. Release current->signal->tty_old_pgrp
+	 * after tty->ctrl.pgrp set to NULL.
+	 */
+	spin_lock_irq(&current->sighand->siglock);
+	put_pid(current->signal->tty_old_pgrp);
+	current->signal->tty_old_pgrp = NULL;
+	spin_unlock_irq(&current->sighand->siglock);
+
 	/* Now clear signal->tty under the lock */
 	read_lock(&tasklist_lock);
 	session_clear_tty(task_session(current));
diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cfda88318583..91fa831328fc 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4845,8 +4845,8 @@ static int _dwc2_hcd_urb_enqueue(struct usb_hcd *hcd, struct urb *urb,
 	if (qh_allocated && qh->channel && qh->channel->qh == qh)
 		qh->channel->qh = NULL;
 fail2:
-	spin_unlock_irqrestore(&hsotg->lock, flags);
 	urb->hcpriv = NULL;
+	spin_unlock_irqrestore(&hsotg->lock, flags);
 	kfree(qtd);
 	qtd = NULL;
 fail1:
diff --git a/drivers/usb/usbip/stub_dev.c b/drivers/usb/usbip/stub_dev.c
index c64964c32cc9..ebcb8d52d1e3 100644
--- a/drivers/usb/usbip/stub_dev.c
+++ b/drivers/usb/usbip/stub_dev.c
@@ -497,8 +497,13 @@ static void stub_disconnect(struct usb_device *udev)
 	/* release port */
 	rc = usb_hub_release_port(udev->parent, udev->portnum,
 				  (struct usb_dev_state *) udev);
-	if (rc) {
-		dev_dbg(&udev->dev, "unable to release port\n");
+	/*
+	 * NOTE: If a HUB disconnect triggered disconnect of the down stream
+	 * device usb_hub_release_port will return -ENODEV so we can safely ignore
+	 * that error here.
+	 */
+	if (rc && (rc != -ENODEV)) {
+		dev_dbg(&udev->dev, "unable to release port (%i)\n", rc);
 		return;
 	}
 
diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index bc9eb8afc313..0a86a9161408 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -495,7 +495,7 @@ static enum fsl_diu_monitor_port fsl_diu_name_to_port(const char *s)
  * Workaround for failed writing desc register of planes.
  * Needed with MPC5121 DIU rev 2.0 silicon.
  */
-void wr_reg_wa(u32 *reg, u32 val)
+static void wr_reg_wa(u32 *reg, u32 val)
 {
 	do {
 		out_be32(reg, val);
diff --git a/drivers/video/fbdev/imsttfb.c b/drivers/video/fbdev/imsttfb.c
index 4a3f89b22360..30ba79d3dbea 100644
--- a/drivers/video/fbdev/imsttfb.c
+++ b/drivers/video/fbdev/imsttfb.c
@@ -1493,8 +1493,8 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	if (!request_mem_region(addr, size, "imsttfb")) {
 		printk(KERN_ERR "imsttfb: Can't reserve memory region\n");
-		framebuffer_release(info);
-		return -ENODEV;
+		ret = -ENODEV;
+		goto release_info;
 	}
 
 	switch (pdev->device) {
@@ -1511,34 +1511,39 @@ static int imsttfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 			printk(KERN_INFO "imsttfb: Device 0x%x unknown, "
 					 "contact maintainer.\n", pdev->device);
 			ret = -ENODEV;
-			goto error;
+			goto release_mem_region;
 	}
 
 	info->fix.smem_start = addr;
 	info->screen_base = (__u8 *)ioremap(addr, par->ramdac == IBM ?
 					    0x400000 : 0x800000);
 	if (!info->screen_base)
-		goto error;
+		goto release_mem_region;
 	info->fix.mmio_start = addr + 0x800000;
 	par->dc_regs = ioremap(addr + 0x800000, 0x1000);
 	if (!par->dc_regs)
-		goto error;
+		goto unmap_screen_base;
 	par->cmap_regs_phys = addr + 0x840000;
 	par->cmap_regs = (__u8 *)ioremap(addr + 0x840000, 0x1000);
 	if (!par->cmap_regs)
-		goto error;
+		goto unmap_dc_regs;
 	info->pseudo_palette = par->palette;
 	ret = init_imstt(info);
-	if (!ret)
-		pci_set_drvdata(pdev, info);
-	return ret;
+	if (ret)
+		goto unmap_cmap_regs;
+
+	pci_set_drvdata(pdev, info);
+	return 0;
 
-error:
-	if (par->dc_regs)
-		iounmap(par->dc_regs);
-	if (info->screen_base)
-		iounmap(info->screen_base);
+unmap_cmap_regs:
+	iounmap(par->cmap_regs);
+unmap_dc_regs:
+	iounmap(par->dc_regs);
+unmap_screen_base:
+	iounmap(info->screen_base);
+release_mem_region:
 	release_mem_region(addr, size);
+release_info:
 	framebuffer_release(info);
 	return ret;
 }
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index e3f18edc1afe..23beabb48923 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2045,7 +2045,7 @@ static noinline int key_in_sk(struct btrfs_key *key,
 static noinline int copy_to_sk(struct btrfs_path *path,
 			       struct btrfs_key *key,
 			       struct btrfs_ioctl_search_key *sk,
-			       size_t *buf_size,
+			       u64 *buf_size,
 			       char __user *ubuf,
 			       unsigned long *sk_offset,
 			       int *num_found)
@@ -2177,7 +2177,7 @@ static noinline int copy_to_sk(struct btrfs_path *path,
 
 static noinline int search_ioctl(struct inode *inode,
 				 struct btrfs_ioctl_search_key *sk,
-				 size_t *buf_size,
+				 u64 *buf_size,
 				 char __user *ubuf)
 {
 	struct btrfs_fs_info *info = btrfs_sb(inode->i_sb);
@@ -2249,7 +2249,7 @@ static noinline int btrfs_ioctl_tree_search(struct file *file,
 	struct btrfs_ioctl_search_key sk;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
+	u64 buf_size;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
@@ -2283,8 +2283,8 @@ static noinline int btrfs_ioctl_tree_search_v2(struct file *file,
 	struct btrfs_ioctl_search_args_v2 args;
 	struct inode *inode;
 	int ret;
-	size_t buf_size;
-	const size_t buf_limit = SZ_16M;
+	u64 buf_size;
+	const u64 buf_limit = SZ_16M;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 6c492fca60c4..d931252b7d0d 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -997,6 +997,11 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		ix = curp->p_idx;
 	}
 
+	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
+		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
+		return -EFSCORRUPTED;
+	}
+
 	len = EXT_LAST_INDEX(curp->p_hdr) - ix + 1;
 	BUG_ON(len < 0);
 	if (len > 0) {
@@ -1006,11 +1011,6 @@ static int ext4_ext_insert_index(handle_t *handle, struct inode *inode,
 		memmove(ix + 1, ix, len * sizeof(struct ext4_extent_idx));
 	}
 
-	if (unlikely(ix > EXT_MAX_INDEX(curp->p_hdr))) {
-		EXT4_ERROR_INODE(inode, "ix > EXT_MAX_INDEX!");
-		return -EFSCORRUPTED;
-	}
-
 	ix->ei_block = cpu_to_le32(logical);
 	ext4_idx_store_pblock(ix, ptr);
 	le16_add_cpu(&curp->p_hdr->eh_entries, 1);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 2a7249496c57..043ce96ac127 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2892,6 +2892,7 @@ int f2fs_precache_extents(struct inode *inode)
 		return -EOPNOTSUPP;
 
 	map.m_lblk = 0;
+	map.m_pblk = 0;
 	map.m_next_pgofs = NULL;
 	map.m_next_extent = &m_next_extent;
 	map.m_seg_type = NO_CHECK_TYPE;
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index 744017475b1d..ac87fcc4d44b 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -4853,5 +4853,6 @@ do {								\
 #define DEV_STATS_INC(DEV, FIELD) atomic_long_inc(&(DEV)->stats.__##FIELD)
 #define DEV_STATS_ADD(DEV, FIELD, VAL) 	\
 		atomic_long_add((VAL), &(DEV)->stats.__##FIELD)
+#define DEV_STATS_READ(DEV, FIELD) atomic_long_read(&(DEV)->stats.__##FIELD)
 
 #endif	/* _LINUX_NETDEVICE_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index c01813c3fbe9..abeec72b4d35 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -325,4 +325,34 @@ static inline void preempt_notifier_init(struct preempt_notifier *notifier,
 
 #endif
 
+/**
+ * migrate_disable - Prevent migration of the current task
+ *
+ * Maps to preempt_disable() which also disables preemption. Use
+ * migrate_disable() to annotate that the intent is to prevent migration,
+ * but not necessarily preemption.
+ *
+ * Can be invoked nested like preempt_disable() and needs the corresponding
+ * number of migrate_enable() invocations.
+ */
+static __always_inline void migrate_disable(void)
+{
+	preempt_disable();
+}
+
+/**
+ * migrate_enable - Allow migration of the current task
+ *
+ * Counterpart to migrate_disable().
+ *
+ * As migrate_disable() can be invoked nested, only the outermost invocation
+ * reenables migration.
+ *
+ * Currently mapped to preempt_enable().
+ */
+static __always_inline void migrate_enable(void)
+{
+	preempt_enable();
+}
+
 #endif /* __LINUX_PREEMPT_H */
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 8e586858bcf4..d25edbb87119 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -466,16 +466,16 @@ unsigned int irq_matrix_reserved(struct irq_matrix *m)
 }
 
 /**
- * irq_matrix_allocated - Get the number of allocated irqs on the local cpu
+ * irq_matrix_allocated - Get the number of allocated non-managed irqs on the local CPU
  * @m:		Pointer to the matrix to search
  *
- * This returns number of allocated irqs
+ * This returns number of allocated non-managed interrupts.
  */
 unsigned int irq_matrix_allocated(struct irq_matrix *m)
 {
 	struct cpumap *cm = this_cpu_ptr(m->maps);
 
-	return cm->allocated;
+	return cm->allocated - cm->managed_allocated;
 }
 
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
diff --git a/mm/readahead.c b/mm/readahead.c
index 4e630143a0ba..96d0f652222a 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -593,7 +593,8 @@ ssize_t ksys_readahead(int fd, loff_t offset, size_t count)
 	 */
 	ret = -EINVAL;
 	if (!f.file->f_mapping || !f.file->f_mapping->a_ops ||
-	    !S_ISREG(file_inode(f.file)->i_mode))
+	    (!S_ISREG(file_inode(f.file)->i_mode) &&
+	    !S_ISBLK(file_inode(f.file)->i_mode)))
 		goto out;
 
 	ret = vfs_fadvise(f.file, offset, count, POSIX_FADV_WILLNEED);
diff --git a/net/dccp/ipv4.c b/net/dccp/ipv4.c
index 892fbd1f650d..5281ac3260f6 100644
--- a/net/dccp/ipv4.c
+++ b/net/dccp/ipv4.c
@@ -612,9 +612,6 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	sk_rcv_saddr_set(req_to_sk(req), ip_hdr(skb)->daddr);
 	sk_daddr_set(req_to_sk(req), ip_hdr(skb)->saddr);
@@ -622,6 +619,9 @@ int dccp_v4_conn_request(struct sock *sk, struct sk_buff *skb)
 	ireq->ireq_family = AF_INET;
 	ireq->ir_iif = sk->sk_bound_dev_if;
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	/*
 	 * Step 3: Process LISTEN state
 	 *
diff --git a/net/dccp/ipv6.c b/net/dccp/ipv6.c
index 9b8c6cf0e5ee..72ceefbf2312 100644
--- a/net/dccp/ipv6.c
+++ b/net/dccp/ipv6.c
@@ -349,15 +349,15 @@ static int dccp_v6_conn_request(struct sock *sk, struct sk_buff *skb)
 	if (dccp_parse_options(sk, dreq, skb))
 		goto drop_and_free;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto drop_and_free;
-
 	ireq = inet_rsk(req);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
 	ireq->ireq_family = AF_INET6;
 	ireq->ir_mark = inet_request_mark(sk, skb);
 
+	if (security_inet_conn_request(sk, skb, req))
+		goto drop_and_free;
+
 	if (ipv6_opt_accepted(sk, skb, IP6CB(skb)) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 7bbd9125b500..60619b1f4acd 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -466,11 +466,15 @@ void tcp_init_metrics(struct sock *sk)
 	u32 val, crtt = 0; /* cached RTT scaled by 8 */
 
 	sk_dst_confirm(sk);
+	/* ssthresh may have been reduced unnecessarily during.
+	 * 3WHS. Restore it back to its initial default.
+	 */
+	tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	if (!dst)
 		goto reset;
 
 	rcu_read_lock();
-	tm = tcp_get_metrics(sk, dst, true);
+	tm = tcp_get_metrics(sk, dst, false);
 	if (!tm) {
 		rcu_read_unlock();
 		goto reset;
@@ -484,11 +488,6 @@ void tcp_init_metrics(struct sock *sk)
 		tp->snd_ssthresh = val;
 		if (tp->snd_ssthresh > tp->snd_cwnd_clamp)
 			tp->snd_ssthresh = tp->snd_cwnd_clamp;
-	} else {
-		/* ssthresh may have been reduced unnecessarily during.
-		 * 3WHS. Restore it back to its initial default.
-		 */
-		tp->snd_ssthresh = TCP_INFINITE_SSTHRESH;
 	}
 	val = tcp_metric_get(tm, TCP_METRIC_REORDERING);
 	if (val && tp->reordering != val)
@@ -913,7 +912,7 @@ static void tcp_metrics_flush_all(struct net *net)
 			match = net ? net_eq(tm_net(tm), net) :
 				!refcount_read(&tm_net(tm)->count);
 			if (match) {
-				*pp = tm->tcpm_next;
+				rcu_assign_pointer(*pp, tm->tcpm_next);
 				kfree_rcu(tm, rcu_head);
 			} else {
 				pp = &tm->tcpm_next;
@@ -954,7 +953,7 @@ static int tcp_metrics_nl_cmd_del(struct sk_buff *skb, struct genl_info *info)
 		if (addr_same(&tm->tcpm_daddr, &daddr) &&
 		    (!src || addr_same(&tm->tcpm_saddr, &saddr)) &&
 		    net_eq(tm_net(tm), net)) {
-			*pp = tm->tcpm_next;
+			rcu_assign_pointer(*pp, tm->tcpm_next);
 			kfree_rcu(tm, rcu_head);
 			found = true;
 		} else {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index ff4d349e13f7..0872df066a4e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -153,7 +153,13 @@ ip6_finish_output_gso_slowpath_drop(struct net *net, struct sock *sk,
 		int err;
 
 		skb_mark_not_on_list(segs);
-		err = ip6_fragment(net, sk, segs, ip6_finish_output2);
+		/* Last GSO segment can be smaller than gso_size (and MTU).
+		 * Adding a fragment header would produce an "atomic fragment",
+		 * which is considered harmful (RFC-8021). Avoid that.
+		 */
+		err = segs->len > mtu ?
+			ip6_fragment(net, sk, segs, ip6_finish_output2) :
+			ip6_finish_output2(net, sk, segs);
 		if (err && ret == 0)
 			ret = err;
 	}
diff --git a/net/ipv6/syncookies.c b/net/ipv6/syncookies.c
index ca291e342900..ab073ac3d7ac 100644
--- a/net/ipv6/syncookies.c
+++ b/net/ipv6/syncookies.c
@@ -184,14 +184,15 @@ struct sock *cookie_v6_check(struct sock *sk, struct sk_buff *skb)
 	treq->af_specific = &tcp_request_sock_ipv6_ops;
 	treq->tfo_listener = false;
 
-	if (security_inet_conn_request(sk, skb, req))
-		goto out_free;
-
 	req->mss = mss;
 	ireq->ir_rmt_port = th->source;
 	ireq->ir_num = ntohs(th->dest);
 	ireq->ir_v6_rmt_addr = ipv6_hdr(skb)->saddr;
 	ireq->ir_v6_loc_addr = ipv6_hdr(skb)->daddr;
+
+	if (security_inet_conn_request(sk, skb, req))
+		goto out_free;
+
 	if (ipv6_opt_accepted(sk, skb, &TCP_SKB_CB(skb)->header.h6) ||
 	    np->rxopt.bits.rxinfo || np->rxopt.bits.rxoinfo ||
 	    np->rxopt.bits.rxhlim || np->rxopt.bits.rxohlim) {
diff --git a/net/llc/llc_input.c b/net/llc/llc_input.c
index f9e801cc50f5..f4fb309185ce 100644
--- a/net/llc/llc_input.c
+++ b/net/llc/llc_input.c
@@ -127,8 +127,14 @@ static inline int llc_fixup_skb(struct sk_buff *skb)
 	skb->transport_header += llc_len;
 	skb_pull(skb, llc_len);
 	if (skb->protocol == htons(ETH_P_802_2)) {
-		__be16 pdulen = eth_hdr(skb)->h_proto;
-		s32 data_size = ntohs(pdulen) - llc_len;
+		__be16 pdulen;
+		s32 data_size;
+
+		if (skb->mac_len < ETH_HLEN)
+			return 0;
+
+		pdulen = eth_hdr(skb)->h_proto;
+		data_size = ntohs(pdulen) - llc_len;
 
 		if (data_size < 0 ||
 		    !pskb_may_pull(skb, data_size))
diff --git a/net/llc/llc_s_ac.c b/net/llc/llc_s_ac.c
index 9fa3342c7a82..df26557a0244 100644
--- a/net/llc/llc_s_ac.c
+++ b/net/llc/llc_s_ac.c
@@ -153,6 +153,9 @@ int llc_sap_action_send_test_r(struct llc_sap *sap, struct sk_buff *skb)
 	int rc = 1;
 	u32 data_size;
 
+	if (skb->mac_len < ETH_HLEN)
+		return 1;
+
 	llc_pdu_decode_sa(skb, mac_da);
 	llc_pdu_decode_da(skb, mac_sa);
 	llc_pdu_decode_ssap(skb, &dsap);
diff --git a/net/llc/llc_station.c b/net/llc/llc_station.c
index c29170e767a8..64e2c67e16ba 100644
--- a/net/llc/llc_station.c
+++ b/net/llc/llc_station.c
@@ -77,6 +77,9 @@ static int llc_station_ac_send_test_r(struct sk_buff *skb)
 	u32 data_size;
 	struct sk_buff *nskb;
 
+	if (skb->mac_len < ETH_HLEN)
+		goto out;
+
 	/* The test request command is type U (llc_len = 3) */
 	data_size = ntohs(eth_hdr(skb)->h_proto) - 3;
 	nskb = llc_alloc_frame(NULL, skb->dev, LLC_PDU_TYPE_U, data_size);
diff --git a/net/netfilter/xt_recent.c b/net/netfilter/xt_recent.c
index cb58bc7ae30d..2dbf92346a7e 100644
--- a/net/netfilter/xt_recent.c
+++ b/net/netfilter/xt_recent.c
@@ -566,7 +566,7 @@ recent_mt_proc_write(struct file *file, const char __user *input,
 {
 	struct recent_table *t = PDE_DATA(file_inode(file));
 	struct recent_entry *e;
-	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:5afe:c0de")];
+	char buf[sizeof("+b335:1d35:1e55:dead:c0de:1715:255.255.255.255")];
 	const char *c = buf;
 	union nf_inet_addr addr = {};
 	u_int16_t family;
diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index dcd00b514c3f..ad0ac657fe12 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -141,34 +141,34 @@ static int smc_release(struct socket *sock)
 
 	if (!smc->use_fallback) {
 		rc = smc_close_active(smc);
-		sock_set_flag(sk, SOCK_DEAD);
+		smc_sock_set_flag(sk, SOCK_DEAD);
 		sk->sk_shutdown |= SHUTDOWN_MASK;
-	}
-
-	sk->sk_prot->unhash(sk);
-
-	if (smc->clcsock) {
-		if (smc->use_fallback && sk->sk_state == SMC_LISTEN) {
+	} else {
+		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
+			sock_put(sk); /* passive closing */
+		if (sk->sk_state == SMC_LISTEN) {
 			/* wake up clcsock accept */
 			rc = kernel_sock_shutdown(smc->clcsock, SHUT_RDWR);
 		}
-		mutex_lock(&smc->clcsock_release_lock);
-		sock_release(smc->clcsock);
-		smc->clcsock = NULL;
-		mutex_unlock(&smc->clcsock_release_lock);
-	}
-	if (smc->use_fallback) {
-		if (sk->sk_state != SMC_LISTEN && sk->sk_state != SMC_INIT)
-			sock_put(sk); /* passive closing */
 		sk->sk_state = SMC_CLOSED;
 		sk->sk_state_change(sk);
 	}
 
+	sk->sk_prot->unhash(sk);
+
+	if (sk->sk_state == SMC_CLOSED) {
+		if (smc->clcsock) {
+			release_sock(sk);
+			smc_clcsock_release(smc);
+			lock_sock(sk);
+		}
+		if (!smc->use_fallback)
+			smc_conn_free(&smc->conn);
+	}
+
 	/* detach socket */
 	sock_orphan(sk);
 	sock->sk = NULL;
-	if (!smc->use_fallback && sk->sk_state == SMC_CLOSED)
-		smc_conn_free(&smc->conn);
 	release_sock(sk);
 
 	sock_put(sk); /* final sock_put */
@@ -852,7 +852,7 @@ static int smc_clcsock_accept(struct smc_sock *lsmc, struct smc_sock **new_smc)
 		if (new_clcsock)
 			sock_release(new_clcsock);
 		new_sk->sk_state = SMC_CLOSED;
-		sock_set_flag(new_sk, SOCK_DEAD);
+		smc_sock_set_flag(new_sk, SOCK_DEAD);
 		sock_put(new_sk); /* final */
 		*new_smc = NULL;
 		goto out;
@@ -1013,13 +1013,13 @@ static void smc_listen_out(struct smc_sock *new_smc)
 	struct smc_sock *lsmc = new_smc->listen_smc;
 	struct sock *newsmcsk = &new_smc->sk;
 
-	lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 	if (lsmc->sk.sk_state == SMC_LISTEN) {
+		lock_sock_nested(&lsmc->sk, SINGLE_DEPTH_NESTING);
 		smc_accept_enqueue(&lsmc->sk, newsmcsk);
+		release_sock(&lsmc->sk);
 	} else { /* no longer listening */
 		smc_close_non_accepted(newsmcsk);
 	}
-	release_sock(&lsmc->sk);
 
 	/* Wake up accept */
 	lsmc->sk.sk_data_ready(&lsmc->sk);
@@ -1215,6 +1215,9 @@ static void smc_listen_work(struct work_struct *work)
 	int rc = 0;
 	u8 ibport;
 
+	if (new_smc->listen_smc->sk.sk_state != SMC_LISTEN)
+		return smc_listen_out_err(new_smc);
+
 	if (new_smc->use_fallback) {
 		smc_listen_out_connected(new_smc);
 		return;
diff --git a/net/smc/smc.h b/net/smc/smc.h
index adbdf195eb08..c3b0e1e3f505 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -268,4 +268,9 @@ static inline bool using_ipsec(struct smc_sock *smc)
 struct sock *smc_accept_dequeue(struct sock *parent, struct socket *new_sock);
 void smc_close_non_accepted(struct sock *sk);
 
+static inline void smc_sock_set_flag(struct sock *sk, enum sock_flags flag)
+{
+	set_bit(flag, &sk->sk_flags);
+}
+
 #endif	/* __SMC_H */
diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
index 333e4353498f..c657fd29ff5d 100644
--- a/net/smc/smc_cdc.c
+++ b/net/smc/smc_cdc.c
@@ -304,7 +304,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
 		smc->sk.sk_shutdown |= RCV_SHUTDOWN;
 		if (smc->clcsock && smc->clcsock->sk)
 			smc->clcsock->sk->sk_shutdown |= RCV_SHUTDOWN;
-		sock_set_flag(&smc->sk, SOCK_DONE);
+		smc_sock_set_flag(&smc->sk, SOCK_DONE);
 		sock_hold(&smc->sk); /* sock_put in close_work */
 		if (!schedule_work(&conn->close_work))
 			sock_put(&smc->sk);
diff --git a/net/smc/smc_close.c b/net/smc/smc_close.c
index 092696d738c0..4ea28ec7ad13 100644
--- a/net/smc/smc_close.c
+++ b/net/smc/smc_close.c
@@ -21,6 +21,22 @@
 
 #define SMC_CLOSE_WAIT_LISTEN_CLCSOCK_TIME	(5 * HZ)
 
+/* release the clcsock that is assigned to the smc_sock */
+void smc_clcsock_release(struct smc_sock *smc)
+{
+	struct socket *tcp;
+
+	if (smc->listen_smc && current_work() != &smc->smc_listen_work)
+		cancel_work_sync(&smc->smc_listen_work);
+	mutex_lock(&smc->clcsock_release_lock);
+	if (smc->clcsock) {
+		tcp = smc->clcsock;
+		smc->clcsock = NULL;
+		sock_release(tcp);
+	}
+	mutex_unlock(&smc->clcsock_release_lock);
+}
+
 static void smc_close_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
@@ -148,7 +164,7 @@ static void smc_close_active_abort(struct smc_sock *smc)
 		break;
 	}
 
-	sock_set_flag(sk, SOCK_DEAD);
+	smc_sock_set_flag(sk, SOCK_DEAD);
 	sk->sk_state_change(sk);
 }
 
@@ -331,6 +347,7 @@ static void smc_close_passive_work(struct work_struct *work)
 						   close_work);
 	struct smc_sock *smc = container_of(conn, struct smc_sock, conn);
 	struct smc_cdc_conn_state_flags *rxflags;
+	bool release_clcsock = false;
 	struct sock *sk = &smc->sk;
 	int old_state;
 
@@ -415,10 +432,15 @@ static void smc_close_passive_work(struct work_struct *work)
 	if (old_state != sk->sk_state) {
 		sk->sk_state_change(sk);
 		if ((sk->sk_state == SMC_CLOSED) &&
-		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket))
+		    (sock_flag(sk, SOCK_DEAD) || !sk->sk_socket)) {
 			smc_conn_free(conn);
+			if (smc->clcsock)
+				release_clcsock = true;
+		}
 	}
 	release_sock(sk);
+	if (release_clcsock)
+		smc_clcsock_release(smc);
 	sock_put(sk); /* sock_hold done by schedulers of close_work */
 }
 
diff --git a/net/smc/smc_close.h b/net/smc/smc_close.h
index 19eb6a211c23..e0e3b5df25d2 100644
--- a/net/smc/smc_close.h
+++ b/net/smc/smc_close.h
@@ -23,5 +23,6 @@ void smc_close_wake_tx_prepared(struct smc_sock *smc);
 int smc_close_active(struct smc_sock *smc);
 int smc_close_shutdown_write(struct smc_sock *smc);
 void smc_close_init(struct smc_sock *smc);
+void smc_clcsock_release(struct smc_sock *smc);
 
 #endif /* SMC_CLOSE_H */
diff --git a/net/tipc/netlink.c b/net/tipc/netlink.c
index 9b36163d951e..bf11d57ef3ae 100644
--- a/net/tipc/netlink.c
+++ b/net/tipc/netlink.c
@@ -87,7 +87,7 @@ const struct nla_policy tipc_nl_net_policy[TIPC_NLA_NET_MAX + 1] = {
 
 const struct nla_policy tipc_nl_link_policy[TIPC_NLA_LINK_MAX + 1] = {
 	[TIPC_NLA_LINK_UNSPEC]		= { .type = NLA_UNSPEC },
-	[TIPC_NLA_LINK_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_LINK_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_LINK_NAME },
 	[TIPC_NLA_LINK_MTU]		= { .type = NLA_U32 },
 	[TIPC_NLA_LINK_BROADCAST]	= { .type = NLA_FLAG },
@@ -116,7 +116,7 @@ const struct nla_policy tipc_nl_prop_policy[TIPC_NLA_PROP_MAX + 1] = {
 
 const struct nla_policy tipc_nl_bearer_policy[TIPC_NLA_BEARER_MAX + 1]	= {
 	[TIPC_NLA_BEARER_UNSPEC]	= { .type = NLA_UNSPEC },
-	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_STRING,
+	[TIPC_NLA_BEARER_NAME]		= { .type = NLA_NUL_STRING,
 					    .len = TIPC_MAX_BEARER_NAME },
 	[TIPC_NLA_BEARER_PROP]		= { .type = NLA_NESTED },
 	[TIPC_NLA_BEARER_DOMAIN]	= { .type = NLA_U32 }
diff --git a/sound/soc/intel/skylake/skl-sst-utils.c b/sound/soc/intel/skylake/skl-sst-utils.c
index 2ae405617876..9e1e9bac1790 100644
--- a/sound/soc/intel/skylake/skl-sst-utils.c
+++ b/sound/soc/intel/skylake/skl-sst-utils.c
@@ -317,6 +317,7 @@ int snd_skl_parse_uuids(struct sst_dsp *ctx, const struct firmware *fw,
 		module->instance_id = devm_kzalloc(ctx->dev, size, GFP_KERNEL);
 		if (!module->instance_id) {
 			ret = -ENOMEM;
+			kfree(module);
 			goto free_uuid_list;
 		}
 
diff --git a/sound/soc/omap/ams-delta.c b/sound/soc/omap/ams-delta.c
index 4dce494dfbd3..ef9fda16ce13 100644
--- a/sound/soc/omap/ams-delta.c
+++ b/sound/soc/omap/ams-delta.c
@@ -300,7 +300,7 @@ static int cx81801_open(struct tty_struct *tty)
 static void cx81801_close(struct tty_struct *tty)
 {
 	struct snd_soc_component *component = tty->disc_data;
-	struct snd_soc_dapm_context *dapm = &component->card->dapm;
+	struct snd_soc_dapm_context *dapm;
 
 	del_timer_sync(&cx81801_timer);
 
@@ -312,6 +312,8 @@ static void cx81801_close(struct tty_struct *tty)
 
 	v253_ops.close(tty);
 
+	dapm = &component->card->dapm;
+
 	/* Revert back to default audio input/output constellation */
 	snd_soc_dapm_mutex_lock(dapm);
 
diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
index 84545666a09c..ca9f33fa51c9 100644
--- a/tools/iio/iio_generic_buffer.c
+++ b/tools/iio/iio_generic_buffer.c
@@ -53,12 +53,15 @@ enum autochan {
  * Has the side effect of filling the channels[i].location values used
  * in processing the buffer output.
  **/
-int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
+static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 {
-	int bytes = 0;
-	int i = 0;
+	unsigned int bytes = 0;
+	int i = 0, max = 0;
+	unsigned int misalignment;
 
 	while (i < num_channels) {
+		if (channels[i].bytes > max)
+			max = channels[i].bytes;
 		if (bytes % channels[i].bytes == 0)
 			channels[i].location = bytes;
 		else
@@ -68,11 +71,19 @@ int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
 		bytes = channels[i].location + channels[i].bytes;
 		i++;
 	}
+	/*
+	 * We want the data in next sample to also be properly aligned so
+	 * we'll add padding at the end if needed. Adding padding only
+	 * works for channel data which size is 2^n bytes.
+	 */
+	misalignment = bytes % max;
+	if (misalignment)
+		bytes += max - misalignment;
 
 	return bytes;
 }
 
-void print1byte(uint8_t input, struct iio_channel_info *info)
+static void print1byte(uint8_t input, struct iio_channel_info *info)
 {
 	/*
 	 * Shift before conversion to avoid sign extension
@@ -89,7 +100,7 @@ void print1byte(uint8_t input, struct iio_channel_info *info)
 	}
 }
 
-void print2byte(uint16_t input, struct iio_channel_info *info)
+static void print2byte(uint16_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -112,7 +123,7 @@ void print2byte(uint16_t input, struct iio_channel_info *info)
 	}
 }
 
-void print4byte(uint32_t input, struct iio_channel_info *info)
+static void print4byte(uint32_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -135,7 +146,7 @@ void print4byte(uint32_t input, struct iio_channel_info *info)
 	}
 }
 
-void print8byte(uint64_t input, struct iio_channel_info *info)
+static void print8byte(uint64_t input, struct iio_channel_info *info)
 {
 	/* First swap if incorrect endian */
 	if (info->be)
@@ -171,9 +182,8 @@ void print8byte(uint64_t input, struct iio_channel_info *info)
  *			      to fill the location offsets.
  * @num_channels:	number of channels
  **/
-void process_scan(char *data,
-		  struct iio_channel_info *channels,
-		  int num_channels)
+static void process_scan(char *data, struct iio_channel_info *channels,
+			 int num_channels)
 {
 	int k;
 
@@ -242,7 +252,7 @@ static int enable_disable_all_channels(char *dev_dir_name, int enable)
 	return 0;
 }
 
-void print_usage(void)
+static void print_usage(void)
 {
 	fprintf(stderr, "Usage: generic_buffer [options]...\n"
 		"Capture, convert and output data from IIO device buffer\n"
@@ -261,12 +271,12 @@ void print_usage(void)
 		"  -w <n>     Set delay between reads in us (event-less mode)\n");
 }
 
-enum autochan autochannels = AUTOCHANNELS_DISABLED;
-char *dev_dir_name = NULL;
-char *buf_dir_name = NULL;
-bool current_trigger_set = false;
+static enum autochan autochannels = AUTOCHANNELS_DISABLED;
+static char *dev_dir_name = NULL;
+static char *buf_dir_name = NULL;
+static bool current_trigger_set = false;
 
-void cleanup(void)
+static void cleanup(void)
 {
 	int ret;
 
@@ -298,14 +308,14 @@ void cleanup(void)
 	}
 }
 
-void sig_handler(int signum)
+static void sig_handler(int signum)
 {
 	fprintf(stderr, "Caught signal %d\n", signum);
 	cleanup();
 	exit(-signum);
 }
 
-void register_cleanup(void)
+static void register_cleanup(void)
 {
 	struct sigaction sa = { .sa_handler = sig_handler };
 	const int signums[] = { SIGINT, SIGTERM, SIGABRT };
@@ -347,7 +357,7 @@ int main(int argc, char **argv)
 	ssize_t read_size;
 	int dev_num = -1, trig_num = -1;
 	char *buffer_access = NULL;
-	int scan_size;
+	unsigned int scan_size;
 	int noevents = 0;
 	int notrigger = 0;
 	char *dummy;
@@ -617,7 +627,16 @@ int main(int argc, char **argv)
 	}
 
 	scan_size = size_from_channelarray(channels, num_channels);
-	data = malloc(scan_size * buf_len);
+
+	size_t total_buf_len = scan_size * buf_len;
+
+	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
+		ret = -EFAULT;
+		perror("Integer overflow happened when calculate scan_size * buf_len");
+		goto error;
+	}
+
+	data = malloc(total_buf_len);
 	if (!data) {
 		ret = -ENOMEM;
 		goto error;
