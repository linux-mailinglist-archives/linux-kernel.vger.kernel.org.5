Return-Path: <linux-kernel+bounces-60228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5017A8501A5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE486287AF3
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE2339FDA;
	Sat, 10 Feb 2024 01:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X01Vmrk8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CAE91EB52;
	Sat, 10 Feb 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=imB14D+NHKYYfaloAxpWkIvrKBrJ81VgFHIajEaBhR8+MqEM5Pruxp/dMYQ0dhL5sFNcYOuOr4lG9GpLOjp6wo2qnNX0yzpA1OLW37sSXYMLWGGJ/vfaz58EcAQs0jvy5QqCBdsLTxbaEhtNLpXx3wHkSeKnVk057gmzXivgiCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=Y5IW8ADYOtYmKJQ9aKyOOeCxY2K3OJ0dda2ewLKI2KE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnHjZ5CX097crwUZV8a5sgmrDPb0xZ+wVcmH21aSttR/S8lyb3fSGGR3g2SyXRv9YWWlJbLTJjGejZ+zClwW0IQawcxAFQ45Y7ikrQV0CXHMRw6lkUbM5SMoI2RFavvyWavjh9w3o9uw2FFCMSPqKH8PYYT4N2xv/EHlQLN01os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X01Vmrk8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AAC3C4163B;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=Y5IW8ADYOtYmKJQ9aKyOOeCxY2K3OJ0dda2ewLKI2KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=X01Vmrk8IuhkJpV2ssl+o6U75XyoF0KVmHsvJiVQhYBNhX3uPq9kNFDT4JOTfdtwm
	 hwylG2l5ItFRo5QDzh/dK29ICN6QRD1KBNgtX7codfva8Y348Zd5k2S/It+KCKfxOc
	 K0dSVcqYbvbZyZwNzjkA0FfEHD/J0jnu2KNJOO1ntU/yUf8ycz9xqq2AS/vlVv02qg
	 CxFCjdxlAjv4mbQo++nqP11047L3ntIpums27fsymUvrHtBraPUg+GAGcXHP2QYGrq
	 2AUK7bm0cGuNFqYhxvj4Em+6/GTPgeopoxlL+mP+4EdGelJPj303nWCe2mTUfVKYG9
	 A57cafUagj0vA==
Received: by mercury (Postfix, from userid 1000)
	id 0338310697B4; Sat, 10 Feb 2024 02:21:16 +0100 (CET)
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
Subject: [PATCH v1 13/14] dt-bindings: arm: add UNI-T UTi260b
Date: Sat, 10 Feb 2024 02:18:17 +0100
Message-ID: <20240210012114.489102-14-sre@kernel.org>
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

Add compatible value for i.MX6ULL based UNI-T
UTi260b thermal camera.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..fa20c2699530 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -708,6 +708,7 @@ properties:
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
               - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
+              - uni-t,imx6ull-uti260b   # UNI-T UTi260b
           - const: fsl,imx6ull
 
       - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
-- 
2.43.0


