Return-Path: <linux-kernel+bounces-114856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305F1889271
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA7A11F2ECE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B34F2C7901;
	Mon, 25 Mar 2024 00:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ByPB6DLU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3013B13C681;
	Sun, 24 Mar 2024 23:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323498; cv=none; b=UEIosC+otVD8lAGGSK6hq/Y4LFnvJ9reOI1RnrZx1fWuMMozYLJShYjCCK859ae+QoKYs8tovOyBLy+q3mYYTg+mly1pa5sVSj/QF2U6tt+UxTqPVJ0EfIRM5Uy5ZQtbjLHqkoZJgoK5NAv8ogt5wavn+DMSfTtsaczdrVXaCzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323498; c=relaxed/simple;
	bh=7hbWTUPCJquy2fKqhgCABsd6LUQRy3Rai4i++CpOixM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEhfEE/ddLFvTs5PXzUUgEyOBOAxLRl+XPmE5ZDW19oKls9mTz3XLIrtcgATiuGd5ooAmR9hkXMQiWKaITv6aJcbxNn+P1OZRJBFk9LO9tQzD2kZk4CVl/HLzfRO4aiM3qrqAEba3vxDtwfk7tcN4MT7GmtvsaYd6LnbP6nbpZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ByPB6DLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40879C43399;
	Sun, 24 Mar 2024 23:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323497;
	bh=7hbWTUPCJquy2fKqhgCABsd6LUQRy3Rai4i++CpOixM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ByPB6DLUY4kiHgXrE9VSOb68IhEzayxVZqgjyJ47Drageec9g0DixAQEiJ14MMuUY
	 iy48fUvUEMtZQfLAToPy5a8OsVmudB/ZciMF1CRuvUJhb0uW1Yg66QYad0m8BtpVoG
	 Z7iV2v/WPsRd1aNI0LP9ff10MS34fMtz1b3IpTjoXmh75GNQeihbhVj6UN+YO5Z4Rm
	 10E267NUssQ3RGb+hs6O7uiRqzeAKyKnpBiYNquAcLD6tYwAUuM3ofZMWAhAAvY5v+
	 w6Q+H8yW+b3w7SqBRcyE3TT+pUrUQ3G8Y6uGdP85GFwyyWEni4VO/sEcdM07L2KuQy
	 OjpFqCHTcX0Fw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jerome Brunet <jbrunet@baylibre.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Justin Stitt <justinstitt@google.com>,
	Mark Brown <broonie@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 202/317] ASoC: meson: t9015: fix function pointer type mismatch
Date: Sun, 24 Mar 2024 19:33:02 -0400
Message-ID: <20240324233458.1352854-203-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 5ad992c71b6a8e8a547954addc7af9fbde6ca10a ]

clang-16 warns about casting functions to incompatible types, as is done
here to call clk_disable_unprepare:

sound/soc/meson/t9015.c:274:4: error: cast from 'void (*)(struct clk *)' to 'void (*)(void *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
  274 |                         (void(*)(void *))clk_disable_unprepare,

The pattern of getting, enabling and setting a disable callback for a
clock can be replaced with devm_clk_get_enabled(), which also fixes
this warning.

Fixes: 33901f5b9b16 ("ASoC: meson: add t9015 internal DAC driver")
Reported-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Reviewed-by: Justin Stitt <justinstitt@google.com>
Link: https://msgid.link/r/20240213215807.3326688-3-jbrunet@baylibre.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/meson/t9015.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/sound/soc/meson/t9015.c b/sound/soc/meson/t9015.c
index a9b8c4e77d405..0571549a88206 100644
--- a/sound/soc/meson/t9015.c
+++ b/sound/soc/meson/t9015.c
@@ -48,7 +48,6 @@
 #define POWER_CFG	0x10
 
 struct t9015 {
-	struct clk *pclk;
 	struct regulator *avdd;
 };
 
@@ -250,6 +249,7 @@ static int t9015_probe(struct platform_device *pdev)
 	struct t9015 *priv;
 	void __iomem *regs;
 	struct regmap *regmap;
+	struct clk *pclk;
 	int ret;
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
@@ -257,26 +257,14 @@ static int t9015_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, priv);
 
-	priv->pclk = devm_clk_get(dev, "pclk");
-	if (IS_ERR(priv->pclk))
-		return dev_err_probe(dev, PTR_ERR(priv->pclk), "failed to get core clock\n");
+	pclk = devm_clk_get_enabled(dev, "pclk");
+	if (IS_ERR(pclk))
+		return dev_err_probe(dev, PTR_ERR(pclk), "failed to get core clock\n");
 
 	priv->avdd = devm_regulator_get(dev, "AVDD");
 	if (IS_ERR(priv->avdd))
 		return dev_err_probe(dev, PTR_ERR(priv->avdd), "failed to AVDD\n");
 
-	ret = clk_prepare_enable(priv->pclk);
-	if (ret) {
-		dev_err(dev, "core clock enable failed\n");
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(dev,
-			(void(*)(void *))clk_disable_unprepare,
-			priv->pclk);
-	if (ret)
-		return ret;
-
 	ret = device_reset(dev);
 	if (ret) {
 		dev_err(dev, "reset failed\n");
-- 
2.43.0


