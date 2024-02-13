Return-Path: <linux-kernel+bounces-62839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F6E8526C2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D33C1F23275
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF7A6A009;
	Tue, 13 Feb 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NizeDhxj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DB466B55;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786235; cv=none; b=GVE5ssuwfWVSgihjTEr1nvtMCAuqkICWbsToUdM0F0zQpVnIGc7B6i4hVb9exlASD/3WiElevDFc2ebqAoovnpjCen6OSzxXLCWAFSisCgNziar7UwOoWruS+jBJ2TZ0CmGNo/EQt/uqO0k5/xYOO0kOb8dXhL5HjOZziviVPY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786235; c=relaxed/simple;
	bh=LccWUqgei2sBSg0YkmgZm3yt8IVqTllbhmxd2arkXLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUtY4fnCUXY4GMZAABSONusVSrdH1dWhhkt2yk0PQXEY+V0KHY0GYmHquk7ClBFs7X7ao4QX8rETBoCqrtma3QKZ2PTnhQMz9OYAVzR3O4m+3htxPcJRLmxCgUkCbEsf0NfTA2UXSBvrliT1fiv4s3huqmqaAOQMvmPAgGP0L3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NizeDhxj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31DAC433F1;
	Tue, 13 Feb 2024 01:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=LccWUqgei2sBSg0YkmgZm3yt8IVqTllbhmxd2arkXLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NizeDhxjItnujsP7YJPtrR9de5zxiLDOQ/J/nJlhkTwt+pkCNd7gvC0KedPwxAj+k
	 PtQmkHz+E8riV1jndRy2EkzDzRz2CkwjG5yU0PnnoUP7lIT6CyFEiuG3GVlKp647Wq
	 1uNgPwAbsPdKKa3VrZnS+gkvstGW32j+Xqmt/Vn099NP2fgFkco7b/flDSHhMv9yJg
	 PqK2/sFnuOIq8JSO+khW2fdoC6KrrA2/uGr1QNQEyoyDEf48y8yMzj1gaGkhpcXEHr
	 c3FWgb/v6Ln7L/QrDccGwx9lyUc4sPnW1FlP8Qmp50rVQHEiIEH9Q/oOC4qyEM4vEa
	 ASASWTfswmtkA==
Received: by mercury (Postfix, from userid 1000)
	id 3FE86106A851; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/17] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
Date: Tue, 13 Feb 2024 02:00:55 +0100
Message-ID: <20240213010347.1075251-7-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213010347.1075251-1-sre@kernel.org>
References: <20240213010347.1075251-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add compatibles used by different i.MX6 variants to the i.MX IOMUX
Controller GPR binding.

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


