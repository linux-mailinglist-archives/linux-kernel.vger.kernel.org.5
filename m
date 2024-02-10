Return-Path: <linux-kernel+bounces-60225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FBF8501A2
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FBF1C2488B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5291938F94;
	Sat, 10 Feb 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BIA1TsYX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F1B1DFE3;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=SyKB5HZO7MLkpxPwBOyaftjWrbgjahz2kU7c/tgTjUPC/UcE1FJ1exU0SvUEsy0mBhj5T3pLsD3mCFycmR+Js4D5vAsrpC6dVawDrjWH3VywxUtfPlTqjoSbIKSPqHI6oiTaYCii2L7GGs5G2DBmeBYopGMs880G31FpJxaSVMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=DxzhpBvZC4XIJ/zrK/9Rp7rDX+xEn6PPcc37xAyAdsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oQtFoWN8XK8lLMkC3z1JAGFitzufHHEqcprRF0dI/iuBuEgjG2+FEZw16IuGG5lIklaqreOzo/rPmerDA+n1xO22SGCAc8IhTeLre36HI5omqXMrDznQ0t84iGcQYah0rtJKBochX9aSck+JsKaFeRzmLgFlNL5MmHYLWN+Nepc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BIA1TsYX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F4EC32780;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=DxzhpBvZC4XIJ/zrK/9Rp7rDX+xEn6PPcc37xAyAdsU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BIA1TsYXietJ6HpV3P6+Bz9kn2iMrxAdV2m82pI4ZcTKUxqcYlZsV+WW1N3I4b76n
	 JBUY+5ZJF4QpegxrWmCTfh6uJ1WapKSPEH1KznXOPptdVqTgBRn7Ls1n6fjAlnt1CH
	 tCtDqGr9zOhn//aPVk4zDefXkg+//EOCDW99cAt2hXQsmtSUIKASjxvLWDZVGgrn2J
	 TNjMDqUjpLEBtThHd5tk+RShbD3uRK1Mylf+Ma7ILE6HGObL90WGbSCgCHJ/aQdWQz
	 Z/qLeOb3Z/nQ95lU/jV2dSEl2+Vi/8ZBYNomrddPFcqG3Ub4c6kLpuMeJMj84IURII
	 cBhvTYerlCdQg==
Received: by mercury (Postfix, from userid 1000)
	id E97B6106910A; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Yackavage <michaely@ips-yes.com>
Subject: [PATCH v1 08/14] dt-bindings: fsl-imx-sdma: fix HDMI audio index
Date: Sat, 10 Feb 2024 02:18:12 +0100
Message-ID: <20240210012114.489102-9-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240210012114.489102-1-sre@kernel.org>
References: <20240210012114.489102-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDMI Audio has been added to the DT binding documentation with an
incorrect index. DT and the driver use index 26. This happened,
because the binding is missing MULTI_SAI type, which is using
index 25.

Reported-by: Michael Yackavage <michaely@ips-yes.com>
Fixes: 7bdbd87d4008 ("dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema")
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
index b95dd8db5a30..37135fa024f9 100644
--- a/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
+++ b/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml
@@ -92,7 +92,8 @@ properties:
               description: needs firmware more than ver 2
           - Shared ASRC: 23
           - SAI: 24
-          - HDMI Audio: 25
+          - Multi SAI: 25
+          - HDMI Audio: 26
 
        The third cell: transfer priority ID
          enum:
-- 
2.43.0


