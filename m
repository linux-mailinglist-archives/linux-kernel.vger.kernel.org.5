Return-Path: <linux-kernel+bounces-139870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE4E8A08B5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E032D287A7F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9229513DDB4;
	Thu, 11 Apr 2024 06:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GvOlDXDp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4813D886;
	Thu, 11 Apr 2024 06:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712818007; cv=none; b=XGtEZ6GGotqUQ2/aMl/miH20Cat9DDIaJNYo+aGK6V2ehUEUaja2v4lKda9tu4OqxavxUkffPRSs65QDs6+5t0vGfPDRwzYlbzpxvKIp+YYAiGNlrGdtgpb3GjG8wTrznDdZ7FBhMfUBdZIEF9zjKQ6PTZgYf9zUKLvi3In54ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712818007; c=relaxed/simple;
	bh=21qdbRrqdGeNpdC7/Fy478NKAKlmZ/ysh6qtF4JrPnA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/BCl+dZhs7W4KkZUafnM5sdt2537xHCv07hoqen4jt3Z6Fxm9+OXz2Lw09mmH9jPedtsJQuG+rm9sS2SiHmG/dzjnhx4uTXNdm3bS/Kpm57+AdGo60m2kgwvhq0U/0UqOx3Pfr6Ouw7JRUKVezF30QjKydmZTPVHWMZgW4eWrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GvOlDXDp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C94C433C7;
	Thu, 11 Apr 2024 06:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712818007;
	bh=21qdbRrqdGeNpdC7/Fy478NKAKlmZ/ysh6qtF4JrPnA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GvOlDXDpmb5BZ1h0Yrf9VuMwYVPczU8wY65hiLQeXdcjBEqxT/jpUq+18+Fl5BMMF
	 bM2xJTDZCeV48U2HD8E2c8lj6hY7/sOWX6uNTG3GeDavIokun2bqbgtkViGJfRIsh5
	 l8xFi5MOzEsTz3CkonWwL2WTKdfVBVVsCe2BKASEvyPfF+aDoT+NQbIhHabTgqiF2R
	 Qt+Nndp4X1uwBcVTu5OcGX5SvxAwYAERA5vvInO+2FrIMjDPBMqX4qlbOoyqsyt96B
	 JBKVfSJZjyrRRnxD831cRlYVtXNWM5kfq2ysZP8ojDYXszLp2XVkzKxguuoDExdzeH
	 NjJCw3rd/s0Jg==
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
Subject: [PATCH v2 3/5] pinctrl: loongson2: fix module autoloading
Date: Thu, 11 Apr 2024 08:46:12 +0200
Message-Id: <20240411064614.7409-3-krzk@kernel.org>
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
 drivers/pinctrl/pinctrl-loongson2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pinctrl/pinctrl-loongson2.c b/drivers/pinctrl/pinctrl-loongson2.c
index a72ffeca26fb..4d4fbeadafb7 100644
--- a/drivers/pinctrl/pinctrl-loongson2.c
+++ b/drivers/pinctrl/pinctrl-loongson2.c
@@ -286,6 +286,7 @@ static const struct of_device_id loongson2_pinctrl_dt_match[] = {
 	},
 	{ }
 };
+MODULE_DEVICE_TABLE(of, loongson2_pinctrl_dt_match);
 
 static struct platform_driver loongson2_pinctrl_driver = {
 	.probe		= loongson2_pinctrl_probe,
-- 
2.34.1


