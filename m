Return-Path: <linux-kernel+bounces-11277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1153D81E3F6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 01:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D110B21FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 00:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF6F47A5C;
	Tue, 26 Dec 2023 00:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiLPg63C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB4E22586;
	Tue, 26 Dec 2023 00:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F24CC433C8;
	Tue, 26 Dec 2023 00:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703550371;
	bh=TeQaQnsO6915RwwJY/9Q2qFh7xzsResAP29MHypNO9U=;
	h=From:To:Cc:Subject:Date:From;
	b=LiLPg63CDwLFxDCXOQEPyamjv6imGsjLOjxO1iALygoBIvYidoqB3jJCABu/0QD3i
	 MxSXC5teN0EzaDdQZvW9glE8hArMfcZicQY8ScN/bxOim48SHcmsihb+3ewiXLVhld
	 yO09AOozRlzEB1r7H8Nsya/tqrd8+rxST+eMaRUcCDPUf9MOqqiOeL1JB4TdSxaEUJ
	 VFCXEzp3IZapMkiF78lQmeSwvvBPwbnvTyC8IgV8MxizbxS5i0pkq1AyBpWrudBMqk
	 o5jbPcvQbWRR2nbCArPXRGuGzc4f9WefRtMkSnosJ9cRQmUDkqwGbUI8wF2v7WuikM
	 dS+4iuMcbABPg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	robh@kernel.org,
	Steen.Hegelund@microchip.com,
	dlemoal@kernel.org
Subject: [PATCH AUTOSEL 5.4 1/8] reset: hisilicon: hi6220: fix Wvoid-pointer-to-enum-cast warning
Date: Mon, 25 Dec 2023 19:25:44 -0500
Message-ID: <20231226002608.7089-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.265
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
index 24e6d420b26b7..84e761f454b63 100644
--- a/drivers/reset/hisilicon/hi6220_reset.c
+++ b/drivers/reset/hisilicon/hi6220_reset.c
@@ -104,7 +104,7 @@ static int hi6220_reset_probe(struct platform_device *pdev)
 	if (!data)
 		return -ENOMEM;
 
-	type = (enum hi6220_reset_ctrl_type)of_device_get_match_data(dev);
+	type = (uintptr_t)of_device_get_match_data(dev);
 
 	regmap = syscon_node_to_regmap(np);
 	if (IS_ERR(regmap)) {
-- 
2.43.0


