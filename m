Return-Path: <linux-kernel+bounces-116025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BB4889827
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B577B3B12B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F4322520E;
	Mon, 25 Mar 2024 03:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwHSZ4Gx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE921A845;
	Sun, 24 Mar 2024 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323375; cv=none; b=qY+Fl1vPv7uT8NQB7E4QneAIdUbLa4KOS3ZOG/X6IkL0hq+I5yJvlBMS8emCb0SzTVBNaUi09FrEWE/cG9jvRlCroUWizAbt2577qTOiae4Ua28e6u8vO4NluZTbsxhM6qJnxr4LWX6f04gJWB0EYFDIW7iXv72COYJ2yll91RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323375; c=relaxed/simple;
	bh=OS5zuo+iync0mDbQnZFjx0V3Vp7CnOy6d7KfG2EH3YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TzpN4PklohrhmW75rhXGim1vzeyUVjp7sjElzohgp0UCKJeRaUlHZ3eW4An2ecXT4D2QoSlKtIg1Qa00w9PnJKNSppq80cnN8KoL6lfE9qqoUqp/LrC4bg01GcNWxgsjPRPb4Q+ME+gJgjytQV0gt8fL77TdssQMFgyD8B24Ecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwHSZ4Gx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC7BC433C7;
	Sun, 24 Mar 2024 23:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323374;
	bh=OS5zuo+iync0mDbQnZFjx0V3Vp7CnOy6d7KfG2EH3YI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwHSZ4GxOoQxLLrhtQ+SHB0kalt+XeljAZzKHEZcvCQ0btRSxcMfU9cPL0Mb7DNze
	 LN+q0Rl9q/TrQEmo/HC3ncZVHyZwRBE1NA4uWZ+dRqGUBjDQBmL3HuJoGcEVsz+pBB
	 oVqADtYXOJp4gOQpujaW6pTytD5JL3zT+JaO/ov+BkLEIMTYNp0/dU+E1cj+Zx5OoZ
	 RqfHbAy0Ic0XsVGOIs1OszCaGYnS7B6Jcry90H247XtU3UnA1J+dGwtXfiWYjhs4g8
	 uGOSvPMnZhHLOpvryoCHEagce197EQiJorBGz8Vd+nxNwe3ZMQjtICoucl32/sBLzv
	 3R9PIfJOn6aCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Heiko Thiery <heiko.thiery@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 074/317] arm64: dts: imx8mm-kontron: Use the VSELECT signal to switch SD card IO voltage
Date: Sun, 24 Mar 2024 19:30:54 -0400
Message-ID: <20240324233458.1352854-75-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit eef2c0217e02b6c7ed5b10b82ea944127145e113 ]

It turns out that it is not necessary to declare the VSELECT signal as
GPIO and let the PMIC driver set it to a fixed high level. This switches
the voltage between 3.3V and 1.8V by setting the PMIC register for LDO5
accordingly.

Instead we can do it like other boards already do and simply mux the
VSELECT signal of the USDHC interface to the pin. This makes sure that
the correct voltage is selected by setting the PMIC's SD_VSEL input
to high or low accordingly.

Reported-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Heiko Thiery <heiko.thiery@gmail.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Stable-dep-of: 008820524844 ("arm64: dts: imx8mm-kontron: Disable pull resistors for SD card signals on BL board")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts    | 3 +++
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
index 25886622c8c40..00dff7c33310c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-s.dts
@@ -321,6 +321,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d0
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d0
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d0
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 
@@ -333,6 +334,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d4
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d4
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d4
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 
@@ -345,6 +347,7 @@ MX8MM_IOMUXC_SD2_DATA1_USDHC2_DATA1		0x1d6
 			MX8MM_IOMUXC_SD2_DATA2_USDHC2_DATA2		0x1d6
 			MX8MM_IOMUXC_SD2_DATA3_USDHC2_DATA3		0x1d6
 			MX8MM_IOMUXC_SD2_CD_B_GPIO2_IO12		0x019
+			MX8MM_IOMUXC_GPIO1_IO04_USDHC2_VSELECT		0x1d0
 		>;
 	};
 };
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index 1b9fc3a926fcb..646615ca4b48b 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -86,7 +86,6 @@ pca9450: pmic@25 {
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-		sd-vsel-gpios = <&gpio1 4 GPIO_ACTIVE_HIGH>;
 
 		regulators {
 			reg_vdd_soc: BUCK1 {
@@ -229,7 +228,6 @@ MX8MM_IOMUXC_I2C1_SDA_I2C1_SDA			0x40000083
 	pinctrl_pmic: pmicgrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO00_GPIO1_IO0		0x141
-			MX8MM_IOMUXC_GPIO1_IO04_GPIO1_IO4		0x141
 		>;
 	};
 
-- 
2.43.0


