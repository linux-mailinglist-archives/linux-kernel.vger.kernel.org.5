Return-Path: <linux-kernel+bounces-144681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CED18A4923
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EB6F1C22173
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 07:35:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59D32D051;
	Mon, 15 Apr 2024 07:35:39 +0000 (UTC)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645D42C1AC;
	Mon, 15 Apr 2024 07:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713166539; cv=none; b=SJ3y6fKCzmqWDooQyj2c0bMAvBKPMg0Ed5tn+Ud+en+WQ3dv5q2DU39Ka8IiPLly+ARiotzHasEMqVqSJoFAWajYU29xS4Usw/zEES4Bdlvafsws7yM1CEm5XT4zzrajxiwEblq54Kz0LOUvvvdnYSGm4WRT+5225FgWoLmt+CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713166539; c=relaxed/simple;
	bh=HpCFmGx4NBaky7HFi3ZWGC0MRq8UUC7ntK4Evj+X6Cc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References; b=g6dCRJzYuDUrRykPIIQDHckDzN2pqMlUay2tKRbxZ6UcQ6IFNYmoj/1L8WW5Dtm63SE478BRWmvvrSSOF74XLgbKswTMrojtsqmyAKdJh8uuUNv+KY4bd96sxEtk2kJcmjq4wbHTFX4TjPRMK4yagmtijJBSdAoabmYkSOS33L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6C58E1A019F;
	Mon, 15 Apr 2024 09:35:30 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 354151A018D;
	Mon, 15 Apr 2024 09:35:30 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 55B60183AD15;
	Mon, 15 Apr 2024 15:35:28 +0800 (+08)
From: Shengjiu Wang <shengjiu.wang@nxp.com>
To: lgirdwood@gmail.com,
	broonie@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shengjiu.wang@gmail.com,
	linux-sound@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiubo.Lee@gmail.com,
	festevam@gmail.com,
	nicoleotsuka@gmail.com,
	perex@perex.cz,
	tiwai@suse.com,
	alsa-devel@alsa-project.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] ASoC: fsl-asoc-card: add wm8904 codec support
Date: Mon, 15 Apr 2024 15:17:35 +0800
Message-Id: <1713165456-3494-2-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
References: <1713165456-3494-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

wm8904 codec is used on i.MX95 Toradex board

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 sound/soc/fsl/fsl-asoc-card.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
index bc07f26ba303..f6d2564864c6 100644
--- a/sound/soc/fsl/fsl-asoc-card.c
+++ b/sound/soc/fsl/fsl-asoc-card.c
@@ -28,6 +28,7 @@
 #include "../codecs/wm8994.h"
 #include "../codecs/tlv320aic31xx.h"
 #include "../codecs/nau8822.h"
+#include "../codecs/wm8904.h"
 
 #define DRIVER_NAME "fsl-asoc-card"
 
@@ -709,6 +710,12 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
 		priv->dai_fmt |= SND_SOC_DAIFMT_CBM_CFM;
 		if (codec_dev)
 			priv->codec_priv.mclk = devm_clk_get(codec_dev, NULL);
+	} else if (of_device_is_compatible(np, "fsl,imx-audio-wm8904")) {
+		codec_dai_name = "wm8904-hifi";
+		priv->codec_priv.mclk_id = WM8904_FLL_MCLK;
+		priv->codec_priv.fll_id = WM8904_CLK_FLL;
+		priv->codec_priv.pll_id = WM8904_FLL_MCLK;
+		priv->dai_fmt |= SND_SOC_DAIFMT_CBP_CFP;
 	} else {
 		dev_err(&pdev->dev, "unknown Device Tree compatible\n");
 		ret = -EINVAL;
@@ -935,6 +942,7 @@ static const struct of_device_id fsl_asoc_card_dt_ids[] = {
 	{ .compatible = "fsl,imx-audio-si476x", },
 	{ .compatible = "fsl,imx-audio-wm8958", },
 	{ .compatible = "fsl,imx-audio-nau8822", },
+	{ .compatible = "fsl,imx-audio-wm8904", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_asoc_card_dt_ids);
-- 
2.34.1


