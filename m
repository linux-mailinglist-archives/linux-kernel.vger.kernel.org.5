Return-Path: <linux-kernel+bounces-139025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7046C89FD9C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E9A28376F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1947417F366;
	Wed, 10 Apr 2024 17:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="an6fpQQP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5377517BB00;
	Wed, 10 Apr 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768545; cv=none; b=bM9wREkysy6Q4uGC4aMYMlMR4aXvCfDjGiouUUUXBIGLMRdwSCeMCEV1NzbKWyPz2Ij3m8t1js76uVW5XKPs/Hfbtuv1F3TedLqJ5ft24yGh7kxiHftNNkfwxKe/KO3mIC/W551fRzKPluGyHwnHyUTK61JdL1G4nSoNptXSdTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768545; c=relaxed/simple;
	bh=QjOnUyfopFRRMcjgTW7txOdo+Ae88Ip/13leO2FO7/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tN8PaeWuKNi/IrNwoMsDi0o1ycOGy/BZOimPiJFUULCyRkjlww1x7GKlo4IGRcEAjqdI+VrY/MqNrgxiJiQ0hIVeq/TCv0xqZF/DnWgOgFA6IVDnEj/Li91auLlNah+YuYeDqkRnhw3Zu0ijcGhIx9H3SD7SPW6vHRVFmJHGt5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=an6fpQQP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86DDC43390;
	Wed, 10 Apr 2024 17:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768544;
	bh=QjOnUyfopFRRMcjgTW7txOdo+Ae88Ip/13leO2FO7/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=an6fpQQPjKNGuD77EbqSH2lJ37F5yaVuRShnLg5EpdBkj0jCqjrASa7BRLmolzFZO
	 IymiKzEkAhpZg7WE865Sg3BtlYm1Y3IZo5xEr2cIKPyA9pH3AULFNEUSaGikP8UIRQ
	 zpiQhRQkWVdduoDXcCGI9Nypuy0N4/mIAfqhQNnbPHuHzCaj2gbIei1AQZZ5iPtfwN
	 oWBB88KfTt1YqYzElCyMJw+DB806oMjcryH0JNwA3bP6om43Xw763sxs3J/LmL3BV0
	 mEA3CpgV3MYzUx0kkDiKXCs4j1FTvECLbGkkFxAskhX+jxKnl3hVJXzOAdac+DoQ2r
	 NyeDxzKNMxfjw==
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
Subject: [PATCH 4/5] pinctrl: qcom: sm7150: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:49 +0200
Message-Id: <20240410170150.248428-4-krzk@kernel.org>
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


