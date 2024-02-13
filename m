Return-Path: <linux-kernel+bounces-62841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74028526C0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 02:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3CAA287C9B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 01:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78C869E1D;
	Tue, 13 Feb 2024 01:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZErKdlR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D089A67E97;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707786235; cv=none; b=W+dAu3H9frWd8NP+w9YtHR7d7qgvggxxbkekZ1UnCO8o7rRRhkAH0Zo65NnF4JWjQp/sY8sfoDK4zchvlITmYCwPrevrdzQhQDaeMi/+V0X2YbMyYBiGDMZWey9ATpFfSBu5ES+KLBscCc7udvsOfT4gIHuO2batyyWfhd0w+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707786235; c=relaxed/simple;
	bh=4dEfl82ZwKQ7mXIpNreWb5CcjIFADyzlcxSDXtMAG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=trtJQdBxNYBfcFA2s/2xr935TmFQFx8P+pN/jIOQF5wyb6gpjmyqaBjTY2Lf2luhBp195VXCdp2wHRMWk60QdHwzmaSU8TogEhT2Qw8moBEKhjFcIg+piys6MydCEWPreFeIeFqp7PFopBY/8DBMPg+c/2NkDoZMXsAACC5RdkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZErKdlR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 419B3C433C7;
	Tue, 13 Feb 2024 01:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707786235;
	bh=4dEfl82ZwKQ7mXIpNreWb5CcjIFADyzlcxSDXtMAG3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HZErKdlRR/fMWxh89IBb8dkrJ3qxrlPRMiSiHMDQo0onkUO4hGYnipB7Pzi4JobHs
	 ZccsU+lCidwB7p+Oa2Cwa8XRwHXU4C4dFnefOT0uT/2WKRgVVixNveBjWiDRIBA1Dh
	 dWT6zZWhy6BlEKV22X+fhsuLknG83MbVFO3HM3Yy3xuIh2gi6H6qAiPENJ7YBKllo7
	 umMHl67B44daavl0w6BF8uukls3pozN5hCW9HIIGEBb7ES1ZoNBkQJ3f/U8YVQY4Ds
	 pzPmDh6Ek0zy4SCNlBg8z4KNm7EvmkA0te+udLkmOtFAhF8tn/YFhS7oXy1tyYky9C
	 Z9yD1FxqBAMwQ==
Received: by mercury (Postfix, from userid 1000)
	id 53429106D637; Tue, 13 Feb 2024 02:03:49 +0100 (CET)
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
Subject: [PATCH v2 09/17] ARM: dts: imx6ull: fix pinctrl node name
Date: Tue, 13 Feb 2024 02:00:58 +0100
Message-ID: <20240213010347.1075251-10-sre@kernel.org>
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

pinctrl node name must be either pinctrl or pinmux.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ull.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
index 2bccd45e9fc2..8a1776067ecc 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ull.dtsi
@@ -75,7 +75,7 @@ rngb: rng@2284000 {
 				clocks = <&clks IMX6UL_CLK_DUMMY>;
 			};
 
-			iomuxc_snvs: iomuxc-snvs@2290000 {
+			iomuxc_snvs: pinctrl@2290000 {
 				compatible = "fsl,imx6ull-iomuxc-snvs";
 				reg = <0x02290000 0x4000>;
 			};
-- 
2.43.0


