Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D4760AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbjGYGqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjGYGq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:46:28 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FC11B3;
        Mon, 24 Jul 2023 23:46:27 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 966991A1629;
        Tue, 25 Jul 2023 08:46:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 5E4921A1618;
        Tue, 25 Jul 2023 08:46:25 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 799B01802183;
        Tue, 25 Jul 2023 14:46:23 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     hverkuil@xs4all.nl, sakari.ailus@iki.fi, tfiga@chromium.org,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@gmail.com, Xiubo.Lee@gmail.com, festevam@gmail.com,
        nicoleotsuka@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org
Subject: [RFC PATCH v2 6/7] ASoC: fsl_asrc: register m2m platform device
Date:   Tue, 25 Jul 2023 14:12:19 +0800
Message-Id: <1690265540-25999-7-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
References: <1690265540-25999-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register m2m platform device, that user can
use M2M feature.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/fsl_asrc_common.h |  2 ++
 sound/soc/fsl/fsl_asrc.c        | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/sound/fsl_asrc_common.h b/include/sound/fsl_asrc_common.h
index 191302711ea6..0f3effa42308 100644
--- a/include/sound/fsl_asrc_common.h
+++ b/include/sound/fsl_asrc_common.h
@@ -69,6 +69,7 @@ struct fsl_asrc_pair {
  * @dma_params_rx: DMA parameters for receive channel
  * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
+ * @m2m_pdev: m2m platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
  * @mem_clk: clock source to access register
@@ -102,6 +103,7 @@ struct fsl_asrc {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
+	struct platform_device *m2m_pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
 	struct clk *mem_clk;
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 30190ccb74e7..0d1dfa30271e 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1198,6 +1198,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev);
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct fsl_asrc_m2m_pdata m2m_pdata;
 	struct fsl_asrc_priv *asrc_priv;
 	struct fsl_asrc *asrc;
 	struct resource *res;
@@ -1380,6 +1381,12 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	m2m_pdata.asrc = asrc;
+	asrc->m2m_pdev = platform_device_register_data(&pdev->dev,
+						       "fsl_asrc_m2m",
+						       PLATFORM_DEVID_AUTO,
+						       &m2m_pdata,
+						       sizeof(m2m_pdata));
 	return 0;
 
 err_pm_get_sync:
@@ -1392,6 +1399,11 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
 static void fsl_asrc_remove(struct platform_device *pdev)
 {
+	struct fsl_asrc *asrc = dev_get_drvdata(&pdev->dev);
+
+	if (asrc->m2m_pdev && !IS_ERR(asrc->m2m_pdev))
+		platform_device_unregister(asrc->m2m_pdev);
+
 	pm_runtime_disable(&pdev->dev);
 	if (!pm_runtime_status_suspended(&pdev->dev))
 		fsl_asrc_runtime_suspend(&pdev->dev);
-- 
2.34.1

