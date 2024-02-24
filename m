Return-Path: <linux-kernel+bounces-79868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 588C68627CF
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1244528253F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2752F77;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjOqLu+u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93CF4EB5D;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=MHizt+UyeAnIKc0UH47cL2CB+Rtl56PIQ3DavYBTK5hidkhaCP5wuMQkvz2LYFOcHezoEqNvODd8KrsOxbcMwFV+FHLQnRjw+whHQpWNX5zZFr0v1VY/nv6bXsiVQ84qrxXyKG/L7Ep1TIHb8jWz6bMhRCiitV6F237gaJE9oyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NniliG8a0HWjvFNEmSc6JFc6ukB7RlpBdioitwwXqPAyunde5L78vg/3ufrGGEBXIFgPSYOODJ3X9Xk4wolD7ufN227jIKkjtn8OFKGFRQLUhf9O3cgieQ6uDz4xy67x5zj/prF33G+XqbLbUB8v0H4/eSSwvj7mEB+SNbFYR/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjOqLu+u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF45C43394;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kjOqLu+uHM4d+W/Se6odN4WXKol5SbtQaPSmwK6EF3keW++qBVeySz/+qSPoU7uSW
	 CcqNf2tZOs4uK3R76Cv8Xn7LA86SUyIbKpAfWn3xf8/6Isq0uDXP8BCQ+Y6IDIRghU
	 rLdYhY3I8kdxKsCe9sOFKYZnN/qEZnvF/OmNdkBWAYDAi2al/XskajzvMjZ6Xx9xh/
	 WBEc2ULY/6iRi58Y5Mj23oH1LWe9027Ymcxo3sToCZzj3aItp+yOTZqsWP8z1j7YNN
	 xpFvOwauScsZQCcrjEosnx0IsVJBUFU22bHlgO5S6NNFCGCJhPg00E2nhQIIJ7OKHr
	 FKRroXtW7wDwA==
Received: by mercury (Postfix, from userid 1000)
	id 05B3E1060E5B; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
	Rob Herring <robh@kernel.org>
Subject: [PATCH v4 05/16] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
Date: Sat, 24 Feb 2024 22:29:37 +0100
Message-ID: <20240224213240.1854709-6-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224213240.1854709-1-sre@kernel.org>
References: <20240224213240.1854709-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles used by different i.MX6 variants to the i.MX IOMUX
Controller GPR binding.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 .../bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml   | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
index 1da1b758b4ae..8451cb4dd87c 100644
--- a/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx-iomuxc-gpr.yaml
@@ -17,7 +17,23 @@ properties:
   compatible:
     oneOf:
       - items:
-          - const: fsl,imx8mq-iomuxc-gpr
+          - enum:
+              - fsl,imx6q-iomuxc-gpr
+              - fsl,imx8mq-iomuxc-gpr
+          - const: syscon
+          - const: simple-mfd
+      - items:
+          - enum:
+              - fsl,imx6sl-iomuxc-gpr
+              - fsl,imx6sll-iomuxc-gpr
+              - fsl,imx6ul-iomuxc-gpr
+          - const: fsl,imx6q-iomuxc-gpr
+          - const: syscon
+      - items:
+          - enum:
+              - fsl,imx6sx-iomuxc-gpr
+              - fsl,imx7d-iomuxc-gpr
+          - const: fsl,imx6q-iomuxc-gpr
           - const: syscon
           - const: simple-mfd
       - items:
-- 
2.43.0


