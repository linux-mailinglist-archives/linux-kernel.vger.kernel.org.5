Return-Path: <linux-kernel+bounces-139026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE5789FDA1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC6A1C20979
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BF9117F381;
	Wed, 10 Apr 2024 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eaaofxEP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DBE17BB03;
	Wed, 10 Apr 2024 17:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768550; cv=none; b=fWjrHW1n0nqFgVHvzZHdoEgc7Hd/+Gyj90LqK2sO5k/lYpmqH7c2yfzsAYttybqGkGqZFDr8IdpVzW6tILq721dTjUL+CObdciVw2PPbhF0yR/SDJ2+OZqnnHryAUetursbg84St3xrxX7192Jqo6OtWVLzSs7W1fhDFRcnEfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768550; c=relaxed/simple;
	bh=X5Xl+Apo8HTXG6kNLMLPU23egnj69bbwrAOoPVmLBzw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pfeIfNlM6i5JSLa9TP8SL1/S5eWlS9i/JfE64B2adVCiWXvNaXQAxx3c8FpFMoAfcTGqeaHZMlfcFIvC2bd5FBJGCIb//UQFZPyXRUj4sntmI/FJQE81irKMAExmc1OR7XkCBlzISqyTs0w/ApKWFIDWRW47QYwO/YN8xRJH0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eaaofxEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E12C433B1;
	Wed, 10 Apr 2024 17:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768550;
	bh=X5Xl+Apo8HTXG6kNLMLPU23egnj69bbwrAOoPVmLBzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eaaofxEPTrlwI7/JwDfIgCY4I/zqZCAz4yDo9ua+4mP5AxSehSI2PP5pBwe1W14Wt
	 RiaFNXRqtw3/EGbbeduCBluKm/YbSLbsh8jhiHrGfN6MSYVqBcrN/kwwYVQdvFeO3o
	 3ia8P70evuxbLmjkHFFvXcNYtYpfEwDclm9DMIUfd9TATx+rE1lcSB2MV++DrTtVB1
	 3hDBo6NHfBi0+YNjsQjKWb0lNuI7ai2tRvbDl/8VIqjJCm/URcK52tsYbt9oilL3HW
	 8NkPCkdXKSCrhAQcbzTq0AOv3a0RaUJyswXOsndrhHcP3IOBh/YEyKACwS5Xd5wnzW
	 CpIbQRycVkNLw==
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
Subject: [PATCH 5/5] pinctrl: realtek: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:50 +0200
Message-Id: <20240410170150.248428-5-krzk@kernel.org>
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

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/pinctrl/realtek/pinctrl-rtd1315e.c | 1 +
 drivers/pinctrl/realtek/pinctrl-rtd1319d.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1315e.c b/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
index 10afc736a52b..86f919122bed 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1315e.c
@@ -1414,6 +1414,7 @@ static const struct of_device_id rtd1315e_pinctrl_of_match[] = {
 	{ .compatible = "realtek,rtd1315e-pinctrl", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rtd1315e_pinctrl_of_match);
 
 static struct platform_driver rtd1315e_pinctrl_driver = {
 	.driver = {
diff --git a/drivers/pinctrl/realtek/pinctrl-rtd1319d.c b/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
index b1a654ac30dc..474c337d2d05 100644
--- a/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
+++ b/drivers/pinctrl/realtek/pinctrl-rtd1319d.c
@@ -1584,6 +1584,7 @@ static const struct of_device_id rtd1319d_pinctrl_of_match[] = {
 	{ .compatible = "realtek,rtd1319d-pinctrl", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, rtd1319d_pinctrl_of_match);
 
 static struct platform_driver rtd1319d_pinctrl_driver = {
 	.driver = {
-- 
2.34.1


