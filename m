Return-Path: <linux-kernel+bounces-79867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 226D48627CD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D131E2825FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD5E52F6E;
	Sat, 24 Feb 2024 21:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klIfjP51"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E939C4EB5C;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=lpYxPqXuc5Jw9C6Tm8iwD0OnMSBFnH+AEhMWKhE+7qAqeYEjD9qhud2d3ruXLd7CewyBCWV2jxXIAmQ+N9QqkUWCMaXQ+LECjM38Yqh1dAiZHzw5McC6dxKnqqwDmO8hB4tlaLAzVExxINe15FX0GQoX8r1Y/CkapSzN/XXDhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y3ma53HtXkZ1+1pkHPCgEpxav4jv1OCzky39rvVTAPe/9HwFOOB28OfSXoYzHfjTMtF1wMpxRBhhQFhogVsqK54Jv/1YV/jAkGDADy5GtT2XUxq4fLolI97yZ4ICsa6bAIlHRawMHb3uHv+Gko0ZLFBtFmbNKBXElCZRFC11vY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klIfjP51; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52AAEC433C7;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klIfjP51Mh7RZ5+C2clA7j6wOd8d2GqenlD+9Sj0PrJbzd4Gx9rUa0Z7vvuRvBGwM
	 wTDCO2+P0V5h0WB60rZhl1w4zimDGNDWdxs5pqw78g4cEEdkzF8riw5F8fAg2NiHFr
	 zDuRuEsqgRTAiBVRxGRUeCqZY2/+bAbJuGTbSw6IRoVXb+LsoSo6V+tcMsqu8KoXxz
	 m/UwvHZolhMi4wEz4ftPABo6ehmHE9/CeSB1haa4e2Tw3x4rFbC7kcrfvPgIgmTTbQ
	 JQBHQMcu2OflRbe5c7UYm91oEWDqHU1SMyRIjd3e+XLYUcm3qPYf1r/egqbNmkmwAu
	 uhCM5FC3cg4mg==
Received: by mercury (Postfix, from userid 1000)
	id 0B5B11060E89; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
Subject: [PATCH v4 06/16] dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
Date: Sat, 24 Feb 2024 22:29:38 +0100
Message-ID: <20240224213240.1854709-7-sre@kernel.org>
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


