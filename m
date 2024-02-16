Return-Path: <linux-kernel+bounces-69431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDFA08588F5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB384282276
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74FB14E2E4;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBz2ygPi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29114AD17;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123022; cv=none; b=EOLK9cQdDFuS24lbBKaA57A8pcHxSVhKqNIlY1UKkOCeEB7lmZC3sjCI6RX9FUV/8RKrEPutLCjzE3dDuk4KlWTnT4AroDfx4rADJnqBut5TbeqUm1+edMP5dA1U9HMasKEff5VVMhpami77pXWeRpPeaVnKt4kopelzJL4gNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123022; c=relaxed/simple;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qz6H4IMrXO9PUvwLsVYVQnIEWnKGUN1B7h5YlxP5ii2FhK1wuIS3k8fpLo+nfzHJXl67Y/QpRnplff0wJDo4N1zNh2BZQVXhAEyEac+px/znmvLXMqNyTOlaM71GNxxiNxYBT+2fn47XLX6VWQoj+c8B7qzb/Rlwaj9GLd+i2T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBz2ygPi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 014E5C433A6;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBz2ygPiSRL3nywOFIAA1iZ/b2KPRy/ikHsirFfTLr///xKwxl72uL776fmyZ6iKk
	 F2pHt50SBgGnMR9Kx0/2+n4BYttp3ln0BzhTQ29dLvO+MQ64yyKiLcQ1KogEzJ4dcg
	 /ZWImRvSB1uvmF/q6PE3Q84TtVVOSXIUy43s8SjzOMOrnLttmrrgAMdtBLr9hlGmaZ
	 VhsPC7ort74+vaEg8BrugZ3ISnENs5uUl3iFjvYTjShfjitTNzUQdrihuvcgL/OlQM
	 H4BYiXqIqyCfarmEVYm9vjTuHVGmx22WsiAjfahVnv/T1vXb0USsqsRVOCnLbr3CKH
	 6mpSrTBrSyWdA==
Received: by mercury (Postfix, from userid 1000)
	id AA6ED10633BF; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 06/16] dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
Date: Fri, 16 Feb 2024 23:34:25 +0100
Message-ID: <20240216223654.1312880-7-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240216223654.1312880-1-sre@kernel.org>
References: <20240216223654.1312880-1-sre@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
but has only very lightweight DISPLAY power domain. Its DISPLAY
power domain is not supported by the binding / Linux kernel at
the moment. Since the current setup is working, let's remove the
power-domain from being required for that platform to fix the warning
printed by CHECK_DTBS=y.

Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/display/fsl,lcdif.yaml | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
index 1c2be8d6f633..0681fc49aa1b 100644
--- a/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
+++ b/Documentation/devicetree/bindings/display/fsl,lcdif.yaml
@@ -120,13 +120,19 @@ allOf:
           maxItems: 1
         clock-names:
           maxItems: 1
+  - if:
+      properties:
+        compatible:
+          const: fsl,imx6sx-lcdif
+    then:
+      required:
+        - power-domains
   - if:
       properties:
         compatible:
           contains:
             enum:
               - fsl,imx6sl-lcdif
-              - fsl,imx6sx-lcdif
               - fsl,imx8mm-lcdif
               - fsl,imx8mn-lcdif
               - fsl,imx8mp-lcdif
-- 
2.43.0


