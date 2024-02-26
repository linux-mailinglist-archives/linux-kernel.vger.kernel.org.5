Return-Path: <linux-kernel+bounces-82339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADF8868305
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4139028E20F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 21:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A78131E45;
	Mon, 26 Feb 2024 21:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JY5YrDgF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6E7130AF9;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708982865; cv=none; b=A7bCIBkMJf7R4dRMw9kva2cWB9DItR7v1rGpkyCqv68xfKSvRzy0ZaXYSr7yoEUTT/LWd1DHPngWi1u6psBN4fIJe7ChzunIz/QRx+CroQz4wTIvwbgoZFkoX0qgamQ28/pDoVC/62fwuUSQzDou3IxCZs4b9pX3y5ytX2S5VRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708982865; c=relaxed/simple;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oB7sUbenAge1cIC+AU5sPuotRLlcthfeHiEImNSBkeKNOKKrTWz743gvblKImQfsedrb1heIM1n/UK7+fnS31wvhvqycT2vkvWZZ2CNVqnCThbnkq2RhGHXZaqgbmu9ODMW7Q8kFmUm1XW7NjOZHgv7bj27NxNC2e0ueJa/Ay0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JY5YrDgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E16EC43390;
	Mon, 26 Feb 2024 21:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708982865;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JY5YrDgFt0bRZUO5HdFGGeoQ99uGHzI7I/zSadrhV0hxKE4pjA3qkXPrNGAGI/wgM
	 LFDAvHQNMSZRuSSyjC4G5h3aKS+PhULlzRcq6D/2+eiRtHeoG2e4dyc7viVwCLP6WW
	 P1kiOJq62+C2kgdfFKItZEJPyU+J31jVn3I31hbD4s2XgxWIaoHv28YQYVnggvAYKN
	 jkrwOmh1122TndBGOYBwXn2ylyavN8kisXj+Xk19DUQ9fqlGN2G/GwqbO4/RibAsEp
	 ut/lIW4ih/ck7RdPj4HD1M1FPAlMi3O2VbjS1WKn2DQfupXO38O4GiNWDMp5Z9YbS0
	 qPyOywHAQ3QvQ==
Received: by mercury (Postfix, from userid 1000)
	id B978E1060E5B; Mon, 26 Feb 2024 22:27:41 +0100 (CET)
From: Sebastian Reichel <sre@kernel.org>
To: Sebastian Reichel <sre@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	imx@lists.linux.dev
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Dong Aisheng <aisheng.dong@nxp.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: [PATCH v5 4/6] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
Date: Mon, 26 Feb 2024 22:26:26 +0100
Message-ID: <20240226212740.2019837-5-sre@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240226212740.2019837-1-sre@kernel.org>
References: <20240226212740.2019837-1-sre@kernel.org>
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


