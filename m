Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9078806B8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 11:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377609AbjLFKNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 05:13:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377562AbjLFKMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 05:12:54 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B240D6D;
        Wed,  6 Dec 2023 02:12:58 -0800 (PST)
Received: from [127.0.1.1] (91-158-149-209.elisa-laajakaista.fi [91.158.149.209])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id A42DA20EA;
        Wed,  6 Dec 2023 11:12:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1701857533;
        bh=VviOwphn+4RrO5iGwi9wzijWsSEuvXaefVURZe6+FbI=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=HEoiK+OCfToUQ64whKk44P2r0aabAUh7ob8T9Xy2/IgS89hQXw3AiyUW4bzf+pxPR
         NmPGAiTJutCi38fNSoGTAeQKDAoZ8GBY/1lGj936FruYpnDZnMP7WnGp6cyHGdcMPc
         wp2w1hBjt9iq9b8fNorJ/01mdEigFwdZy6yPGQuo=
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date:   Wed, 06 Dec 2023 12:12:30 +0200
Subject: [PATCH v2 3/4] media: rkisp1: Store IRQ lines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231206-rkisp-irq-fix-v2-3-6ba4185eeb1f@ideasonboard.com>
References: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
In-Reply-To: <20231206-rkisp-irq-fix-v2-0-6ba4185eeb1f@ideasonboard.com>
To:     Dafna Hirschfeld <dafna@fastmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Paul Elder <paul.elder@ideasonboard.com>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        kieran.bingham@ideasonboard.com, umang.jain@ideasonboard.com,
        aford173@gmail.com, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4211;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=VviOwphn+4RrO5iGwi9wzijWsSEuvXaefVURZe6+FbI=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBlcEkhINtZt/jrHcvd8PyxoqiGU8w5A9HQZ0mOF
 +aiJUoPTEWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZXBJIQAKCRD6PaqMvJYe
 9Ts5EACkSyWCPkI9IGqrr3Fxt4RlHxqx5t3XNKBKgBit8k0HzhBoILndDUENez6ZxzgCrOKPCq4
 n1w8oNKMxJ5kEouMU8sJUk3qZ/rewbb8E1JvisK4FdFWnrARFa1dv9LywMB9dwr1GklObpn6S9v
 /FGcdy0pG5J3ww2dMIQ7HEX1tZYSH0r1q7RhMEnFu2PZNxhjlt048pJq4YdqOuT+eGJxeiDHSwv
 3dBmSul27T5iRlOUSPd3r8+edm8N7s25AmpWuNxOcu8r6xwb9QvLACxcqQKOr5B+dbVZY1Eh/LL
 h/PxYAd8pEz6fbLo9OsTZikwLN0H9JD3nPKxZnPB/8qa+TU8ePAqMTzDISEIys9/s6qI3mn576Y
 n84vMqc5yOJ6+gBCwaN49yPaXR2iAzshb4lw9LFhnU1TEe+8w6aUfwqFXmGWUR5portRnbKM7dB
 zNvBYdXmzESUX6a9SPPCPpiMclWQ7GmcVv/tIExWm+m2l0QXlyzbV8oT/VpjBePsWtjWxYxHaEO
 43OYp2qQkj6NBxBtpDs+LeukBNCCgJGpWc7l1vU/tkJFb8wK7P+LR05OfpWsJ8yQM9MY04dAGdX
 5eeu77I9M0T1yhroWUBcHjTg7cnCYaUhK4LqXFCjQY8SPLCJNguYZWM+HwNQg6h9i3ulb+RiBEV
 Gqo1EBMeMEIt3NQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the IRQ lines used by the driver for easy access. These are needed
in future patches which fix IRQ race issues.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 .../media/platform/rockchip/rkisp1/rkisp1-common.h    | 11 ++++++++++-
 drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c   | 19 ++++++++++++++-----
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
index 960ab89c659b..ec28907d978e 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-common.h
@@ -62,6 +62,14 @@ struct regmap;
 						 RKISP1_CIF_ISP_EXP_END |	\
 						 RKISP1_CIF_ISP_HIST_MEASURE_RDY)
 
+/* IRQ lines */
+enum rkisp1_irq_line {
+	RKISP1_IRQ_ISP = 0,
+	RKISP1_IRQ_MI,
+	RKISP1_IRQ_MIPI,
+	RKISP1_NUM_IRQS,
+};
+
 /* enum for the resizer pads */
 enum rkisp1_rsz_pad {
 	RKISP1_RSZ_PAD_SINK,
@@ -437,7 +445,6 @@ struct rkisp1_debug {
  * struct rkisp1_device - ISP platform device
  *
  * @base_addr:	   base register address
- * @irq:	   the irq number
  * @dev:	   a pointer to the struct device
  * @clk_size:	   number of clocks
  * @clks:	   array of clocks
@@ -457,6 +464,7 @@ struct rkisp1_debug {
  * @stream_lock:   serializes {start/stop}_streaming callbacks between the capture devices.
  * @debug:	   debug params to be exposed on debugfs
  * @info:	   version-specific ISP information
+ * @irqs:          IRQ line numbers
  */
 struct rkisp1_device {
 	void __iomem *base_addr;
@@ -479,6 +487,7 @@ struct rkisp1_device {
 	struct mutex stream_lock; /* serialize {start/stop}_streaming cb between capture devices */
 	struct rkisp1_debug debug;
 	const struct rkisp1_info *info;
+	int irqs[RKISP1_NUM_IRQS];
 };
 
 /*
diff --git a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
index 030eb8c79546..492ff5e6770d 100644
--- a/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
+++ b/drivers/media/platform/rockchip/rkisp1/rkisp1-dev.c
@@ -115,6 +115,7 @@
 struct rkisp1_isr_data {
 	const char *name;
 	irqreturn_t (*isr)(int irq, void *ctx);
+	u32 line_mask;
 };
 
 /* ----------------------------------------------------------------------------
@@ -473,9 +474,9 @@ static const char * const px30_isp_clks[] = {
 };
 
 static const struct rkisp1_isr_data px30_isp_isrs[] = {
-	{ "isp", rkisp1_isp_isr },
-	{ "mi", rkisp1_capture_isr },
-	{ "mipi", rkisp1_csi_isr },
+	{ "isp", rkisp1_isp_isr, BIT(RKISP1_IRQ_ISP) },
+	{ "mi", rkisp1_capture_isr, BIT(RKISP1_IRQ_MI) },
+	{ "mipi", rkisp1_csi_isr, BIT(RKISP1_IRQ_MIPI) },
 };
 
 static const struct rkisp1_info px30_isp_info = {
@@ -496,7 +497,7 @@ static const char * const rk3399_isp_clks[] = {
 };
 
 static const struct rkisp1_isr_data rk3399_isp_isrs[] = {
-	{ NULL, rkisp1_isr },
+	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) | BIT(RKISP1_IRQ_MIPI) },
 };
 
 static const struct rkisp1_info rk3399_isp_info = {
@@ -517,7 +518,7 @@ static const char * const imx8mp_isp_clks[] = {
 };
 
 static const struct rkisp1_isr_data imx8mp_isp_isrs[] = {
-	{ NULL, rkisp1_isr },
+	{ NULL, rkisp1_isr, BIT(RKISP1_IRQ_ISP) | BIT(RKISP1_IRQ_MI) | BIT(RKISP1_IRQ_MIPI) },
 };
 
 static const struct rkisp1_info imx8mp_isp_info = {
@@ -574,6 +575,9 @@ static int rkisp1_probe(struct platform_device *pdev)
 	if (IS_ERR(rkisp1->base_addr))
 		return PTR_ERR(rkisp1->base_addr);
 
+	for (unsigned int il = 0; il < RKISP1_NUM_IRQS; ++il)
+		rkisp1->irqs[il] = -1;
+
 	for (i = 0; i < info->isr_size; i++) {
 		irq = info->isrs[i].name
 		    ? platform_get_irq_byname(pdev, info->isrs[i].name)
@@ -581,6 +585,11 @@ static int rkisp1_probe(struct platform_device *pdev)
 		if (irq < 0)
 			return irq;
 
+		for (unsigned int il = 0; il < RKISP1_NUM_IRQS; ++il) {
+			if (info->isrs[i].line_mask & BIT(il))
+				rkisp1->irqs[il] = irq;
+		}
+
 		ret = devm_request_irq(dev, irq, info->isrs[i].isr, 0,
 				       dev_driver_string(dev), dev);
 		if (ret) {

-- 
2.34.1

