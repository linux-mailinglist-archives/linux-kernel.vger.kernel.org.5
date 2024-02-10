Return-Path: <linux-kernel+bounces-60221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE09085019D
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958FC28AFD7
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9215837168;
	Sat, 10 Feb 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qMgxRLFx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D62F16435;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528081; cv=none; b=p7q7XkSWoH+YcP4xlyva9e85EFxzupy83SW0I3KswfJDNEbtCThYXs2BKvXiWhOXtGds70Ud3w9fhLrfkQxhdtdLxNDSqw5MCjxiqW+kVFsfYLUJAA4l2oorhSgRTpEfqt4vd9ntjVfUxzDIv/+YSfpQBmydp/H9J1tcxZpKb28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528081; c=relaxed/simple;
	bh=u/ecgRYQOkLBlRn/VtTePYv4M68IaY7mn8if9/vLcSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t+TzsCbW11miyiVuzGDo1DchLCx8UXK3R61rH6LMXPkfl3HCIe9IhIO9Q1rxHWWTiKaFcGhbvdAKYi5BW5bQzQ/gVYUFZjwsQ22GTKrjfRMUWZqtt/uycrvT42JoM0SX23Bbkx/bgmMXznmeZfX3NHQjRLpEHQKTJcMhU+weUVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qMgxRLFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 449B5C41612;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=u/ecgRYQOkLBlRn/VtTePYv4M68IaY7mn8if9/vLcSk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qMgxRLFxy5zos/lUwR/xfKurLYOThw4OYp6s30K6hvrXdvFBnaciLFLlLgTimPCZV
	 65L+5ZuIagx44mEMi+hknKH9W6SZlUo5m536Ik+Nwvck0kzDxjlzXa2dK4EQiF0+9L
	 ePoai+L09Sijd9nWoQFffLGaaSLtc0VgJCi8id1iMNzETy3yIgVnERHbQR1qwgVnid
	 TG7/7eiYC19DFwcXyhTWxPP1SkIWI2Xp0AwGoqBo/Q4j201IXshRoq2or+APMeM5nv
	 l8r/zQPdaprEUo1SksEOhgGhAvqDKU15UEnplN7JKjsY8Sug+99GOHLhhrfE87aA+e
	 dTHc83OZtXGBw==
Received: by mercury (Postfix, from userid 1000)
	id E61751068F4B; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
Subject: [PATCH v1 07/14] dt-bindings: lcdif: Do not require power-domains for i.MX6ULL
Date: Sat, 10 Feb 2024 02:18:11 +0100
Message-ID: <20240210012114.489102-8-sre@kernel.org>
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

i.MX6UL(L) uses "fsl,imx6sx-lcdif" as fallback compatible string,
but has only very lightweight DISPLAY power domain. Its DISPLAY
power domain is not supported by the binding / Linux kernel at
the moment. Since the current setup is working, let's remove the
power-domain from being required for that platform to fix the warning
printed by CHECK_DTBS=y.

Fixes: f62678a77d58 ("dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property")
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


