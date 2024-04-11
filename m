Return-Path: <linux-kernel+bounces-139869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A8AF8A08B1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34E492859A2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA74A13DBAA;
	Thu, 11 Apr 2024 06:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/ZL7ede"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0283A8F55;
	Thu, 11 Apr 2024 06:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818002; cv=none; b=Fq783AnYss2tbHUUARj3IcfwbC/5U1K22NgHbrYB9/TbOpiBAYC6leh8xU5EwF7ky0l7hU9ERI3PnU2PCKcoRfWvbEVmIyiL0rCtO9yawB1+Gyg8WOTHYw61gTSw+tBuUBH2beh0zTChbGqUySr6905tr/VETtlcmQZjcKjihpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818002; c=relaxed/simple;
	bh=gMnoez56bAZd7APZvMyA7WH/YLAHsyDnpeBOij4GxtQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RSOIDfGvGwyomG6RqeT4pwR8UKtjqC86A5A6b60Z7OJNJuHDNe/j8HFgQdXIq0Y9+9voUSdJDguMIrS4yfUvVkvNCtRaF9tgHhK5TzSE/AtJx+H2kP4z2/u7qGuM4jf4YpzITMmSITH6XQWQvH2MVOiwGzSOJSJdBQ3EL0Bbg/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/ZL7ede; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6958DC433B1;
	Thu, 11 Apr 2024 06:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818001;
	bh=gMnoez56bAZd7APZvMyA7WH/YLAHsyDnpeBOij4GxtQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h/ZL7ededP7US0kHeZuRlSNuSKFS3IwH2l5s24Ojuq6QpEHY2CdCHDI5Cwy+3jyWz
	 ewWgz/a47Zp7cvDTnbKSl4BMrI/QWpnsCR3WqsqjR5xmV7gJWWaGrkD8yEv1iDeZue
	 HdflEQKF5uo4r1oi59xgDR5n/ZdIAy6ygI56+1A2a2VmPtwLvMC7RNO/zVfgpipMOd
	 juJ7kZn6prkM56sHUQQ7LtBKZV6+1fsoMhr4T3foqrxFTA6JQiFahjPgccmp17QvO+
	 BdDtOz6TPGiOOABg8TJlgeiY1yXMoHHM2GBLwC/Ibl7YrbF8+TsXBKLqMZ2ZIKZeVr
	 M5B2vBYEusCYg==
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
Subject: [PATCH v2 2/5] pinctrl: mediatek: fix module autoloading
Date: Thu, 11 Apr 2024 08:46:11 +0200
Message-Id: <20240411064614.7409-2-krzk@kernel.org>
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

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 drivers/pinctrl/mediatek/pinctrl-mt6765.c | 1 +
 drivers/pinctrl/mediatek/pinctrl-mt6779.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6765.c b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
index f6ec41eb6e0c..72609cf74760 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6765.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6765.c
@@ -1086,6 +1086,7 @@ static const struct of_device_id mt6765_pinctrl_of_match[] = {
 	{ .compatible = "mediatek,mt6765-pinctrl", .data = &mt6765_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mt6765_pinctrl_of_match);
 
 static struct platform_driver mt6765_pinctrl_driver = {
 	.driver = {
diff --git a/drivers/pinctrl/mediatek/pinctrl-mt6779.c b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
index 62d4f5ad6737..591905e4132a 100644
--- a/drivers/pinctrl/mediatek/pinctrl-mt6779.c
+++ b/drivers/pinctrl/mediatek/pinctrl-mt6779.c
@@ -762,6 +762,7 @@ static const struct of_device_id mt6779_pinctrl_of_match[] = {
 	{ .compatible = "mediatek,mt6779-pinctrl", .data = &mt6779_data },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, mt6779_pinctrl_of_match);
 
 static struct platform_driver mt6779_pinctrl_driver = {
 	.driver = {
-- 
2.34.1


