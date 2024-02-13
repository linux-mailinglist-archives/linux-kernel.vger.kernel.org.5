Return-Path: <linux-kernel+bounces-62843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 175488526C5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82BD284DF0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F1E6A33E;
	Tue, 13 Feb 2024 01:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fcZyXGBv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0504D69953;
	Tue, 13 Feb 2024 01:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786236; cv=none; b=ge6qs1ee71z3DQbtn07FrJok4ersRPNIzDWnJF5DiCUdREL1bxtdmKfOMmQy9L/CQQ4YYEr2D6mOgDI+wxmNu13OkUpVat7MW75CTGeVDIN2gZn/p7ISTkxEZG74WHgAo1czcY4ggAmPIOSZgbyfeO/GasAyUvIbqHLfhMJNdxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786236; c=relaxed/simple;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+z5ov3ldAqKzkW7J+npsOvOg7+QofFc+l6zfetqQwfjP6wQpi7iF0C86yyU8mHrZ7s97mRn4NC3S5L3Qv8yVGUbA7IOzLXAZEtvBLaKx5K7ko/NBt4vXSdeLF1i2z/L+DtQ8xsG6r1BeQtdFzrXPh1CmoK54hpmrc8mb3Aqk24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fcZyXGBv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 925CCC4166A;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=rUmJV8kGaEHJUfJDmv7OgUPHvh7znQWSM5zbc3u5TGM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fcZyXGBvYyPxvMGxP6sQPcoStEP9d84MovkhPd7L0h2xN4XmGz3UNg4JDNwQmuqIu
	 5N6RWdcFLw80LLYMkq5+MzIJdsuW5GOdwLWmn2IFGZGSg5w2scL3c2jinZU9O1g653
	 qpcjwp8jN7RWEPP2YidOldw7rjvvFGEOingg1PqPHrLVNqVLFfjjtEwJ2egH6FCWyP
	 CiWGhVPVWiyyMboZnztTEbGknrvOV0CL4oamus1tDR+z9lGy6HA4Pqkfr1SslLDgbC
	 U0jRlQmFbXHuYxzZ39M5j0W7bRZ+q/xJlZWVYBIsF07II3/XqGOpZ/UtR/cPnRrNbY
	 28Y3c1Ds96xWA==
Received: by mercury (Postfix, from userid 1000)
	id 46B97106A85F; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 07/17] dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
Date: Tue, 13 Feb 2024 02:00:56 +0100
Message-ID: <20240213010347.1075251-8-sre@kernel.org>
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


