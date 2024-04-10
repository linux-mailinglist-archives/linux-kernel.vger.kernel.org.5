Return-Path: <linux-kernel+bounces-139023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F87289FD96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 016191F218D1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B8917BB22;
	Wed, 10 Apr 2024 17:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3TiokUV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1017B514;
	Wed, 10 Apr 2024 17:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768532; cv=none; b=eSMzHcBLd4N4rECT8VpfyYLlhHIPHW50zDIT0beVzeNCnuOQgrifDpZtihf8qJfTPo3ot9Bqp3pLQmzv/BUQvCMFPIsAtXNXJprynBzhMNrSWL03c+Afe6Vi38kN0x2TaVd346xGUi5HNhn4tIFsC6fX1n+7ZnUkTqrMNxX1aTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768532; c=relaxed/simple;
	bh=UreIdQFDaJPTJRQHIFlJ3qYvDMdt0vj/yTnEoOJ3Q+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BD10QOnVnGlJdDBXS1dm90VmoZxp8EhwOumMQ1CQp0kAg7Bex7BFZ2Y484xg1x7s7hSu6Ucrh9mnWEqO2ThRpRy8gEcfLPMllyR1dWWbVYBIIHFvwD0kei5i8wjLCEvNAvPRFDnCltgQ3+9M6nzDZ9eED9a+yIrXwZMVENuNaTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3TiokUV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8B92C43394;
	Wed, 10 Apr 2024 17:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768531;
	bh=UreIdQFDaJPTJRQHIFlJ3qYvDMdt0vj/yTnEoOJ3Q+c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3TiokUVrqi6QazyAYeehv570Re+STaAnOo+2acOtaHn9CO3TXb+oWo1QllIJtcDI
	 SY7K7Y7BBnhSTy73+CdIcqBB0q65mWO8FuN/RIhTtbjhNvjuOszJ0mM5WZwxucYpRE
	 je2LSm7oW7MAFjL/uuxVpC8IU50C6JUcvc8gpwXVhiFVWBCXrBowsBgC9XaTVkGw88
	 d69GnjaWSWUXQIVr/929tead12fVRBEvUvtSnY9lWOwzQkGfxao2WSvB7nfMHbMFtO
	 kVtsCFSAqflOXBbhPP35X7Sd3x2ggwMClj11bQcXhe697BHmoiJYjUAYJnjbQEF3/1
	 xJ9Ho6eBQDhlQ==
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
Subject: [PATCH 2/5] pinctrl: mediatek: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:47 +0200
Message-Id: <20240410170150.248428-2-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410170150.248428-1-krzk@kernel.org>
References: <20240410170150.248428-1-krzk@kernel.org>
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


