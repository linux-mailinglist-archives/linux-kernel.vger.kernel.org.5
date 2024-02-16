Return-Path: <linux-kernel+bounces-69430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCBD8588F4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BD611F2272A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA1314E2E6;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f++lCVl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8020C14AD10;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123022; cv=none; b=oY0gilG/xf0znc5cnMPWOfAjfrBMVy32Isz9tb+zyBL/k5Vh7vVA1vZpib8m3gjjnAqUETnlRjVl+TSYdrIXLUWCatqliry6Wyh161Q1ue9hHxpPEaoQUD+8bx7JvSmvEKuSxr/fFLFlW01Eb2OUEpN533+TcMnprxHedrdD6Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123022; c=relaxed/simple;
	bh=p3O/rTbpZ8mvNEtwOodSEEupdVXpbmqLBGQRaauu05M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bGRJXSeE/KoDtlMQs2uQFobUotAxGmc0LIIe2TZIvqy+rd+mHVtFLG6DihGH/YT17vRsLOqwl3NtCi9dJOQEdb71jrK+QkgNIDB+6lAQLRA9gXab7stt4zp7bYWCAyfTHsLs72jXcUP17EnBl4npjlBwkw6BJ4uahnNYWdnaFVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f++lCVl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CC4C43390;
	Fri, 16 Feb 2024 22:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=p3O/rTbpZ8mvNEtwOodSEEupdVXpbmqLBGQRaauu05M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f++lCVl7nkeABZ52wxsMUUKeH9d6unCWvkl604l2vGRyvjyIGwTS8K8N1WL1zQhus
	 ww+DpnW1N8cgX4hlmVipDVf2Hk5gniS1SsNp97W5Ee5qmKGP21xJiA41wNfy1zZYZJ
	 Sb1LwNiDmDWFyIQsO6SrUdNtlg8xQ2xueuwnPi/eEyCGaYqQKRx1ur3Zv7Iesxp0Aa
	 7zcRyw4o9ltd5lU+i0tTGiYStZo0yE5AvjnS0Bb5CEzU1faOco1O//ec4S3xhpumtE
	 iuffLguZiR8C4rg4w+dC0t7SzGv4kieppoXWZSD0fhGKMG/fsne+Ofuj0tFrBVvxrV
	 lkpFF7Snwq6xQ==
Received: by mercury (Postfix, from userid 1000)
	id B5DCD10633CD; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 08/16] ARM: dts: imx6ull: fix pinctrl node name
Date: Fri, 16 Feb 2024 23:34:27 +0100
Message-ID: <20240216223654.1312880-9-sre@kernel.org>
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

pinctrl node name must be either pinctrl or pinmux.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
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


