Return-Path: <linux-kernel+bounces-79877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2EE68627D9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CA20281D94
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B24E4D58A;
	Sat, 24 Feb 2024 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NRqOpcrv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDFA53391;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810398; cv=none; b=aMkigSyh8pHm8MBaTQLtoGfU88pXejJK5wtU/fh7I/DOYs46bDH4gRiOH4QVW/24zXGHsOJlK54m3xc+PiOXv4zj6i7CpFGVwDb8LsWdfllSBRF+Ga0Xor3/LucovKjELDLs5n2x84E6drP9jqB2pa9vtVtvpWzo8KiV29+gjBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810398; c=relaxed/simple;
	bh=JzqwkQRLgk7k3EhjNENSRph/tpijOyPkAp/qgI/FbTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/iwbPnp0vsWWRPBw2yNmLPYQ3BvfyTbGEL3Yoc/pFrHamHYk1Ik2p+o25RTMryn4LEE8Vw81wI322iAu05P6urHTW4iFWCY/S1CufJ2ruHK3gncpBxUGhnf7DrkS8+L5w72qnfrBdjDq+TZHmUIsCuvcerhMCtrUFF2AI90gu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NRqOpcrv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32E8FC43141;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810398;
	bh=JzqwkQRLgk7k3EhjNENSRph/tpijOyPkAp/qgI/FbTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NRqOpcrv68im30SahywHhKVh6UtBgd42RFGW9T6/sGbZvlO7CrHGkrhIAPwdJ8xCz
	 43QAE1TqS0ArwKg/Q59pcrUlNF35ulQ5NoswD/jqnhnrjZYify1u1IthNs9UemjuLc
	 ztqrCTvSxnKGpxjwMJdLJCBMeOn7jgbE293aIfz9Qyri7mmHFb1eQdR+9U4KnHjK7O
	 Ou86Hr5ikvRIf41oDc+Z66sqysNm9iKSVa8uLy9IPLxMyeTT3ieaUahIZc27NaKSLq
	 cWTsCKJl6wcPwZBt2ztpOE6ZgPLpXuzS646ZyR2lYX2gXxPkF6GjE1+0L/JAY+sgAA
	 s4VBlH7kgS/hg==
Received: by mercury (Postfix, from userid 1000)
	id 45B681061142; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
Subject: [PATCH v4 15/16] dt-bindings: arm: add UNI-T UTi260B
Date: Sat, 24 Feb 2024 22:29:47 +0100
Message-ID: <20240224213240.1854709-16-sre@kernel.org>
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

Add compatible value for i.MX6ULL based UNI-T UTi260B thermal camera.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..7b65f9c9c1a5 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -708,6 +708,7 @@ properties:
               - toradex,colibri-imx6ull      # Colibri iMX6ULL Modules
               - toradex,colibri-imx6ull-emmc # Colibri iMX6ULL 1GB (eMMC) Module
               - toradex,colibri-imx6ull-wifi # Colibri iMX6ULL Wi-Fi / BT Modules
+              - uni-t,uti260b             # UNI-T UTi260B Thermal Camera
           - const: fsl,imx6ull
 
       - description: i.MX6ULL Armadeus Systems OPOS6ULDev Board
-- 
2.43.0


