Return-Path: <linux-kernel+bounces-139871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5668A08B8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6C11F25D50
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E20A13D886;
	Thu, 11 Apr 2024 06:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U0GyO2FL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FE013D8BE;
	Thu, 11 Apr 2024 06:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818014; cv=none; b=LE4pDLohjVwnVVSW3tsNevp34bYrKQHuKVADTrRe8xLhr5uo2YbffBJ3zZIG9Oglp0loTFmxS4axF0HeGjuQwdAnh9qqqIoW5eiSKZVGoW57t/xzcR9fLG/XdoRw5I25BAeUJfgtkWFRctZVlrzV5soL4RECav4gIkS4HZY52sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818014; c=relaxed/simple;
	bh=saPqICVhCGR/yOaqVsxnFMPKByX7RX+rEnct888M6xY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nfbkE1BedYyOGYOChoAGBQ5OtYbTYRGe3x5dfzCi1u/2tCAqat5/alq/cZbjPusiqUYJYA1vBQS05SudSXCH3pmUaDT8jGbXNh5/NMF5jvzapqEJqbFb9FMJ76u+wYjC2qkqhe1/BrfSJwyyxE2n67XntsGV335QLnAGjFzHCm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U0GyO2FL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3F91C43390;
	Thu, 11 Apr 2024 06:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818014;
	bh=saPqICVhCGR/yOaqVsxnFMPKByX7RX+rEnct888M6xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0GyO2FL9vi7BGaiTFI/pHzFJusV4ihtgOSiDp8X1zfDRNDFgSi4O/5nbtmos5GCE
	 Kt+d0ZlQr+UhKv883e1MThO4g/glomoIx8NAdMKn1WoXHRRwnKj0NsjgimkVPclrcc
	 KG5FJQ2l4MJVOgwnZ3EI+VBSDJma+HNbjt2uxSe4njgvYCtaf1E9vQWU1Rt0OqgUhm
	 gyjRRmG1kB9aHESZTpKJKSHYNM44+ycP4BLcubHdbhh5U2QQU/1mPKfhxEuDpRjuyF
	 ImMANFtsng8KIM6g2A9GFDamV0zK/V0UUxlSSosEBdS27lMcztD/doX7DyjUplMHfz
	 VfPQUyCEEZVBA==
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
Subject: [PATCH v2 4/5] pinctrl: qcom: sm7150: fix module autoloading
Date: Thu, 11 Apr 2024 08:46:13 +0200
Message-Id: <20240411064614.7409-4-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240411064614.7409-1-krzk@kernel.org>
References: <20240411064614.7409-1-krzk@kernel.org>
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. Add ack
---
 drivers/pinctrl/qcom/pinctrl-sm7150.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/qcom/pinctrl-sm7150.c b/drivers/pinctrl/qcom/pinctrl-sm7150.c
index c25357ca1963..c542f9bc6bcd 100644
--- a/drivers/pinctrl/qcom/pinctrl-sm7150.c
+++ b/drivers/pinctrl/qcom/pinctrl-sm7150.c
@@ -1246,6 +1246,7 @@ static const struct of_device_id sm7150_tlmm_of_match[] = {
 	{ .compatible = "qcom,sm7150-tlmm", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, sm7150_tlmm_of_match);
 
 static struct platform_driver sm7150_tlmm_driver = {
 	.driver = {
-- 
2.34.1


