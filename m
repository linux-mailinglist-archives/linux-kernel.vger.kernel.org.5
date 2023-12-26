Return-Path: <linux-kernel+bounces-11257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CC081E3BF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23AE1C21ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 875091859;
	Tue, 26 Dec 2023 00:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix5LB80A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1F59E46;
	Tue, 26 Dec 2023 00:24:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A59A2C433C8;
	Tue, 26 Dec 2023 00:24:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550263;
	bh=IXu3w1hIH5VlHvFJPhN0KkQphUYGmzFOAnbfy8HlK/w=;
	h=From:To:Cc:Subject:Date:From;
	b=Ix5LB80Ap6SNePnD/YDLXyNo6K8xM0cRQkGY6ARWKjw0k540eMAwWdoFP4TANu/3w
	 qh1wp7yK2tf/zrnT2C9LEA023dCycwjkAhayAG9Rn8jQ75x8mD02ki7KVZOjuO0kzO
	 0g99ccLIlt6R2J7bzSPAw4h4hlT+RjAWD2mnjDNbi8wSLWiPJMPqaNXR3fWpHO2+A4
	 uc5KULA27UzuojLxq10aqKJXeOcUhlqyguAWP3AtKeDeUiKBIpFMn9MRCfHK97uauh
	 OLdxbZKNda00yr4DbvNx/u2TqNtZFwJ9JXs1dO7qLZXt5XZ09hrRIpf6wYxtKnZ6uo
	 W0XWsREPVmctg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	Steen.Hegelund@microchip.com,
	dlemoal@kernel.org,
	robh@kernel.org
Subject: [PATCH AUTOSEL 5.15 01/11] reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning
Date: Mon, 25 Dec 2023 19:23:50 -0500
Message-ID: <20231226002420.6303-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.145
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

[ Upstream commit b5ec294472794ed9ecba0cb4b8208372842e7e0d ]

'type' is an enum, thus cast of pointer on 64-bit compile test with W=1
causes:

  hi6220_reset.c:166:9: error: cast to smaller integer type 'enum hi6220_reset_ctrl_type' from 'const void *' [-Werror,-Wvoid-pointer-to-enum-cast]

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230810091300.70197-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/reset/hisilicon/hi6220_reset.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/reset/hisilicon/hi6220_reset.c b/drivers/reset/hisilicon/hi6220_reset.c
index 5ca145b64e63d..30951914afac7 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -164,7 +164,7 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
+	type = (uintptr_t)of_device_get_match_data(dev);
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
-- 
2.43.0


