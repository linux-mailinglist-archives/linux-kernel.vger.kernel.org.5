Return-Path: <linux-kernel+bounces-69432-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A858588F2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 631871F22C19
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A749814E2E3;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npRb8dF1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801D314AD0F;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123022; cv=none; b=n2fXUJ3CLD811l2FjkJDBoh08alMPDAFqFou7OUSxSrsdHVi3NnTSWabG6yQDOfTiLsawcSc7xoYhCc9VcTZxgLnvF+sy/MXkeZ//Ascgq6C65sxYnofxLOcD7pqRN9sRfBUaO/pr0M9hj+dbkOJe/PpDYIIo/1n2SRQHjk+1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123022; c=relaxed/simple;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ERBCDqf/xgrYQNbg+4G1LT9ElqMIcsFgsbanhmkuCNKqZ04Mm1aT6lvDuDhn9tTxL3YsY5EpMzyaHDtmO37ExdjpuzYmaPxlxdsQxCzbu6rZz4ZGdD+KxOrY7fUjR6CUR467e1ITIlI2RGI1fLCzuDFxvW23JhJ7oc+IFLf7jvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npRb8dF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E923CC43399;
	Fri, 16 Feb 2024 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=RJWvlSP6BsU9o2+sb1U+a07qsHtOTURxzuqmLpqHlu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=npRb8dF1SKdmfEUlo5/b6a84TpIL+aqdP+HGihE08VCbwo7hZE4ooa5T6h///oylj
	 qben2EZwjgyZfL5s9gqKKYwQIfLYm1EYuOfuF1r7++6cwVHpz2oBK3D6V7RldNMdoT
	 XeISDEP3N9++f8BtlxVn8DgN5pK3qCEuq/cyA17Gl+dGAAuiCpAQiTuPFh2sqMNnya
	 GzkF490qJxl2wNF6qTJaTL2gfIBonTlcQ92eOR5IUeFq40iDw2shr19VBYQmzfJrRe
	 rF5rYI+qkW6aXurEdRH4NxDzqCLu+n/dEqlHSR8kYOA2iPxZhEi66rdiIMZoqmvbXl
	 G5ueZPFWwOpmQ==
Received: by mercury (Postfix, from userid 1000)
	id A463410633BC; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 05/16] dt-bindings: soc: imx: fsl,imx-iomuxc-gpr: add imx6
Date: Fri, 16 Feb 2024 23:34:24 +0100
Message-ID: <20240216223654.1312880-6-sre@kernel.org>
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


