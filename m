Return-Path: <linux-kernel+bounces-139868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D36BB8A08AD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:46:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A9281F21DDE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E255613D888;
	Thu, 11 Apr 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfihvtP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228273EA72;
	Thu, 11 Apr 2024 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817996; cv=none; b=lbTw991qbJKzBU88mrVE8QZx58/pm8LFSrCU4UzZF9IPzqMYUFOLDIYjDLhOLW5JYi2pmOM10h2lF4+jqDdYJtRFq6NLvHKRzioydS4sstjsk8WeqcMhmnJjyJ/0D+Y5B/ivL11fvmJWv9JIaQqp58sva55J/zPyWFnXWRvlrRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817996; c=relaxed/simple;
	bh=WbLKltYK/s7kUm98XICzKNUnpZwUdIqRk1dgonQu5Yc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Knj0P6peRoFIfA75WC/UEGZ3HL3AxOqj2KVF+eCHXq8prnJ9PBOhpGOADXQQwKFoULvRPbveGecFZdx9LTxMhqKh0ng9pAOWEIqeIJl/rrSDf/VQcB8pjyyXwo02RhHoj2rmVw4NE4iyIVHue0ZyOxLFP2aJhAweYhzS7s0GWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfihvtP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E487C433C7;
	Thu, 11 Apr 2024 06:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712817996;
	bh=WbLKltYK/s7kUm98XICzKNUnpZwUdIqRk1dgonQu5Yc=;
	h=From:To:Cc:Subject:Date:From;
	b=kfihvtP24X739EE/kTEzwc2BdjlE2pfwBwO6OonyFbHsJNJCR1SdBGZlouBbwK7HJ
	 +yErPp4MIvHGDfdln/y2MYCyZzDP0KsCGKYE+oiQtJxin+o6DL/1z3/6GKNRU6UAZF
	 Esbb8FdcOechMyx53FoLOXcFwEFAM7uEVidM1vLBuJY01Sbk3EU9Iwzkfbrh5PzfAb
	 lOpRpWe4EemuLChfxRE1gY2mLalzr3U4aPmKYlRl8x213dEy20XMsIpcsg29SXm7/o
	 0eWmm3qJ+gyJ+oXhR/zE6dao+mZ8PTf7qRk/7QBbQQCmqmNXkJa1qLshIEYVIb8+4i
	 4N4M4Q7KZ3/RQ==
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
Subject: [PATCH v2 1/5] pinctrl: freescale: imx8ulp: fix module autoloading
Date: Thu, 11 Apr 2024 08:46:10 +0200
Message-Id: <20240411064614.7409-1-krzk@kernel.org>
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

Changes in v2:
1. None
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


