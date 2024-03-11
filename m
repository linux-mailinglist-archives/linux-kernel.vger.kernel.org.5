Return-Path: <linux-kernel+bounces-98672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D3877DA8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CB01C2147C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784682D781;
	Mon, 11 Mar 2024 10:10:21 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447132BB01;
	Mon, 11 Mar 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151821; cv=none; b=aNvNynC/mj7i+UGqydxkgx34+j8FATgiMvkQkQdJeCsFxj8gFENaHx9xr6lcNkpeUjFTzLZKF5n+4+JhXYOPOjk9gwOf2Hnwqqp6Yq9OCWThJKtxX/s7ZnRo/tJ+DtlC3+hdgCqchyKqt379girb00LJwH/HKX9NSJ3Gn0QzabY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151821; c=relaxed/simple;
	bh=ImzNxqs0xkj2U6J7gTa9sJdI5GGIwkLF3v5xPj/nHYQ=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=DaqWenAo7FbdFYfuSovI2tvC4RhUzQVuN7pjuvqt0oFyc2QsUGWrEH9RCtl5bW1beWpmjntEr9KJ2BY8o1CVDpOdX2FhCffvUBSaLzx75IMl6CQ001UvFWDrIez1w2/k5R7874x0x0bfHoADNKBeoVlRKsd+kEjAaFXhW6LoFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6E0951A022C;
	Mon, 11 Mar 2024 11:10:17 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D7F331A1960;
	Mon, 11 Mar 2024 11:10:16 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 97E0F180031A;
	Mon, 11 Mar 2024 18:10:14 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: hverkuil@xs4all.nl,
	sakari.ailus@iki.fi,
	tfiga@chromium.org,
	m.szyprowski@samsung.com,
	mchehab@kernel.org,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shengjiu.wang@gmail.com,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v14 05/16] ASoC: fsl_asrc: register m2m platform device
Date: Mon, 11 Mar 2024 17:53:50 +0800
Message-Id: <1710150841-26991-6-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
References: <1710150841-26991-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Register m2m platform device, that user can
use M2M feature.

Defined platform data structure and platform
driver name.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
---
 include/sound/fsl_asrc_common.h | 23 +++++++++++++++++++++++
 sound/soc/fsl/fsl_asrc.c        | 18 ++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/sound/fsl_asrc_common.h b/include/sound/fsl_asrc_common.h
index 3b53d366182f..c709b8906929 100644
--- a/include/sound/fsl_asrc_common.h
+++ b/include/sound/fsl_asrc_common.h
@@ -71,6 +71,7 @@ struct fsl_asrc_pair {
  * @dma_params_rx: DMA parameters for receive channel
  * @dma_params_tx: DMA parameters for transmit channel
  * @pdev: platform device pointer
+ * @m2m_pdev: m2m platform device pointer
  * @regmap: regmap handler
  * @paddr: physical address to the base address of registers
  * @mem_clk: clock source to access register
@@ -103,6 +104,7 @@ struct fsl_asrc {
 	struct snd_dmaengine_dai_dma_data dma_params_rx;
 	struct snd_dmaengine_dai_dma_data dma_params_tx;
 	struct platform_device *pdev;
+	struct platform_device *m2m_pdev;
 	struct regmap *regmap;
 	unsigned long paddr;
 	struct clk *mem_clk;
@@ -139,6 +141,27 @@ struct fsl_asrc {
 	void *private;
 };
 
+/**
+ * struct fsl_asrc_m2m_pdata - platform data
+ * @asrc: pointer to struct fsl_asrc
+ * @fmt_in: input sample format
+ * @fmt_out: output sample format
+ * @chan_min: minimum channel number
+ * @chan_max: maximum channel number
+ * @rate_min: minimum rate
+ * @rate_max: maximum rete
+ */
+struct fsl_asrc_m2m_pdata {
+	struct fsl_asrc *asrc;
+	u64 fmt_in;
+	u64 fmt_out;
+	int chan_min;
+	int chan_max;
+	int rate_min;
+	int rate_max;
+};
+
+#define M2M_DRV_NAME "fsl_asrc_m2m"
 #define DRV_NAME "fsl-asrc-dai"
 extern struct snd_soc_component_driver fsl_asrc_component;
 
diff --git a/sound/soc/fsl/fsl_asrc.c b/sound/soc/fsl/fsl_asrc.c
index 7d8643ee0ba0..5ecb5d869607 100644
--- a/sound/soc/fsl/fsl_asrc.c
+++ b/sound/soc/fsl/fsl_asrc.c
@@ -1187,6 +1187,7 @@ static int fsl_asrc_runtime_suspend(struct device *dev);
 static int fsl_asrc_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
+	struct fsl_asrc_m2m_pdata m2m_pdata;
 	struct fsl_asrc_priv *asrc_priv;
 	struct fsl_asrc *asrc;
 	struct resource *res;
@@ -1368,6 +1369,18 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 		goto err_pm_get_sync;
 	}
 
+	m2m_pdata.asrc = asrc;
+	m2m_pdata.fmt_in = FSL_ASRC_FORMATS;
+	m2m_pdata.fmt_out = FSL_ASRC_FORMATS | SNDRV_PCM_FMTBIT_S8;
+	m2m_pdata.rate_min = 5512;
+	m2m_pdata.rate_max = 192000;
+	m2m_pdata.chan_min = 1;
+	m2m_pdata.chan_max = 10;
+	asrc->m2m_pdev = platform_device_register_data(&pdev->dev,
+						       M2M_DRV_NAME,
+						       PLATFORM_DEVID_AUTO,
+						       &m2m_pdata,
+						       sizeof(m2m_pdata));
 	return 0;
 
 err_pm_get_sync:
@@ -1380,6 +1393,11 @@ static int fsl_asrc_probe(struct platform_device *pdev)
 
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


