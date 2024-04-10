Return-Path: <linux-kernel+bounces-139022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB8A889FD92
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A494281DE1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629B117BB07;
	Wed, 10 Apr 2024 17:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ocnr0wxS"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5F217B503;
	Wed, 10 Apr 2024 17:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768524; cv=none; b=Edf4eau+tTDsXxWnl556CD8Js3qoHivD5CFI2FPySnSXyt6XzBt7dURV8+nIzA+5Buoa6Lst2/cVANsGKkTLZ31ug9UHDDhKau97adS//ezKvLLGAFsJVDS/oF1qVexve42FTz57SWB9JpTY2K0e1doMzddpCs8NswmcGZAB/fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768524; c=relaxed/simple;
	bh=nfO7BhOr35ZNDar/Pmam3BamoEiQ6+6qfGd93yRI2Iw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GrAJtw5mu6tbqjqN5NSfM9fVR5fJJAQuvNg1PE/QV6WhGyUumL5oDhkePy33RQBKwrBUC+gm5kQ1n0k55V5ghSEF74erE2PYstTpRXoRynvEMDcm/HlC+dYljnSnrA51WrmqtE2GtH2fESU+s7mkXiyXxu32wanBpUjAciB0aSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ocnr0wxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86249C433F1;
	Wed, 10 Apr 2024 17:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768524;
	bh=nfO7BhOr35ZNDar/Pmam3BamoEiQ6+6qfGd93yRI2Iw=;
	h=From:To:Cc:Subject:Date:From;
	b=ocnr0wxSgG0VHuixPUnewtVTdrpXKREAJATiYstPXiA6ckwuxFE/T265Ecu3MmGZp
	 cUhd3UCcCswUl4cAWN4j0KuGATYzzAqzCVZ7IFErSkDo0LluDagpGoAHs3nVmSxFqd
	 f7POFdR5JNIx9PuFeKiQZYwe9F0iE+FZzhdUBjWPu5QhYSIA4/tEziWa/LZLt4luTw
	 AOr+Oc/Qok9e36AsqOTaE2WaM8JG4d2wikipPSl31qP3vwXp0qpA/6gU0qyf4JvuaD
	 kF41OSTsMtzN5EloWkPnYzywlAcnIGf/1khnTgbA+8+FfoYNcrDWL9aSmTHKWffA4q
	 6nNb/sv9XVNMA==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Sean Wang <sean.wang@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	zhanghongchen <zhanghongchen@loongson.cn>,
	Yinbo Zhu <zhuyinbo@loongson.cn>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-msm@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 1/5] pinctrl: freescale: imx8ulp: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:46 +0200
Message-Id: <20240410170150.248428-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MODULE_DEVICE_TABLE(), so the module could be properly autoloaded
based on the alias from of_device_id table.  Pin controllers are
considered core components, so usually they are built-in, however these
can be built and used as modules on some generic kernel.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/freescale/pinctrl-imx8ulp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx8ulp.c b/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
index 2e86ca9fc7ac..5632c7285147 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx8ulp.c
@@ -252,6 +252,7 @@ static const struct of_device_id imx8ulp_pinctrl_of_match[] = {
 	{ .compatible = "fsl,imx8ulp-iomuxc1", },
 	{ /* sentinel */ }
 };
+MODULE_DEVICE_TABLE(of, imx8ulp_pinctrl_of_match);
 
 static int imx8ulp_pinctrl_probe(struct platform_device *pdev)
 {
-- 
2.34.1


