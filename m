Return-Path: <linux-kernel+bounces-139024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EDF89FD99
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3CD1F21952
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8883117BB34;
	Wed, 10 Apr 2024 17:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZACkiovP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAF917BB08;
	Wed, 10 Apr 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712768538; cv=none; b=NRpMphFvNcNOD9+px7Lm/0guLlYRfQRRm4WCVX+6PBRQcS4bPL1fvnOsuSOio5OC0NvkQh9T+f8WGIO3K+ewBuFA728+/9U7/0ELNQStolgcstKB9PaNAw1K+2XdYj2NH9QzujPeLJGFK7AFsZCZw/bUbKJI2oYEmsHYu6N1+Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712768538; c=relaxed/simple;
	bh=J8Xz0tO7wTFJkDIRc8XHLYUNNwxXvSfpj3JcT9M6hUo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PCfOSbSdmmtGOkprZv6i9ay4Mk4QEZqrUmb1RPEijKtIG783UEUC3ZYjBgfswmrY0i8I96Rkwp4bp64zrxvnCHzM4EUb0sYvUiRwI02fO0nB4zbDzaUkgO7/7lBqttrCs7G0ggtjPUvC3M81yfD2tJypDHzUp9OvoOshSIEi5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZACkiovP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49A5BC433C7;
	Wed, 10 Apr 2024 17:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712768538;
	bh=J8Xz0tO7wTFJkDIRc8XHLYUNNwxXvSfpj3JcT9M6hUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZACkiovPiGAvRBWw0ptxzDvez/h/OO9ESEpjSpxcblWyNi8XG5hw6rSN0T8jO7Ztv
	 qNSb/TVDDZGnyYwLmv0S6BNnqWDnRluQh52PV1ER1KzulQCG8y0ZqJovttvtgenbGZ
	 +Y6ahqjQ5hK6ZdZSL37/EASTHl3YlFSkpOv/oqCrbZTfQ1s82s4MYFUwqDWI4GQjQd
	 6ITbtEspXCEjlyY9jRsN7qsNYh9g7HJC7aPcJGu9JK4s4OkOMeeyNI3obYx6c/tPot
	 +9dUiEowanr2b+hHORsbTnvY5fk+csFAQoQnHysD/IMls9R+5Sm9NDQ7+h18lzkQL5
	 ALkigSot+8hMA==
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
Subject: [PATCH 3/5] pinctrl: loongson2: fix module autoloading
Date: Wed, 10 Apr 2024 19:01:48 +0200
Message-Id: <20240410170150.248428-3-krzk@kernel.org>
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


