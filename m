Return-Path: <linux-kernel+bounces-62838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E3338526C1
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A6731F22F93
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBED56A006;
	Tue, 13 Feb 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GqkbaK4W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D090D692E1;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786235; cv=none; b=d1fcEwN1bxO7hkX/x+XEachS6MEUWLsYTpeEb4Mq+KMzNIeDECLjG31A633ta2HFRAbIxt/cHrk7Z4kQHjeDAAi4EKOfZj1skp0WHQZQGIsQlFjx5wqGJOHxlcwjlHZmTd+2psAsaignxzQuJQ+Z66u538lmlxbN0qZEr89WeUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786235; c=relaxed/simple;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aJCfpnY57N8Rzks9vDKxLvahP+uDC7CchXlb6Yew+Z3sbjlgBDmO/2yxHFZS6Lnehse+WdKEW/qZOuInBZZqw+rovWbYW6/fgOmxHLWD7SIi2Wk1J0fgmRuuJ+PV/1WnfUa36Q0a3nXT4yiW3q5QzZ67swDL9JthP5mnXMJfw3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GqkbaK4W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DEC5C433A6;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=2Rf/qADjPS/HdwZc3ACrJCkDkpnzYWtpsvVoZxBWBCU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GqkbaK4WUXcgNjlkKobnKQtsKRdsfcYU85xHR9hKsf2DBO8DRfgnIi65mEp++HY4p
	 SSi2DYgaLGqSvyzuKlDykIqDnpBb+2l0ZtsxJQ0mCiYcaqlEBvROQo82y6JxzfoEZ2
	 +CXX3X/TZo0MqPOPIx9hkaPgewN9ptk6DzihEU6bsAGb6sCPP8zcObL2pNW33/95Do
	 9kg2GBshr3QFPaFw3smEGgDPN2xho3Bp5752EJdbA6Z2F5pmV+N2BKd+CKn41MHmwv
	 aew6563A9jMgc2ePs5kzU4CPqVnLgX9vLktaZ7jRH2Nc0LcaPpdD3p+ztVR8JkR7FS
	 6/7njCrgW2Jwg==
Received: by mercury (Postfix, from userid 1000)
	id 4E06A106D636; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
	Michael Yackavage <michaely@ips-yes.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 08/17] dt-bindings: fsl-imx-sdma: fix HDMI audio index
Date: Tue, 13 Feb 2024 02:00:57 +0100
Message-ID: <20240213010347.1075251-9-sre@kernel.org>
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

HDMI Audio has been added to the DT binding documentation with an
incorrect index. DT and the driver use index 26. This happened,
because the binding is missing MULTI_SAI type, which is using
index 25.

Reported-by: Michael Yackavage <michaely@ips-yes.com>
Fixes: 7bdbd87d4008 ("dt-bindings: fsl-imx-sdma: Convert imx sdma to DT schema")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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


