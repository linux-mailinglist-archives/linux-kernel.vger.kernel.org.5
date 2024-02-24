Return-Path: <linux-kernel+bounces-79869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8882D8627D0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9F191C20D6D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9A252F78;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GNTIYTLp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93F04EB5E;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=tE/aEsqvqTtY+ZPqt2oCR5gLoCqe5q/2DdjKopPN3c4qSat2SIZtuLTsjlNTRPNtZCFv6WO39piA/xu01Silrfy1J9p3pEfi1pr/jyh0vcZ8yoKGSjkAfnZuL18lN6s64kFFqGzFBeoqaVBNxDDN+PY0638+jNY7sP4mqtHT8ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYYt8XYNf6pm113GhvYVjIcAbr+60r+kJ5xC6MUDSb83Ogl/gxxdba0OH9dZQjKii7/MjnpowK7y2d9VL945ui6lRNO2CmafmhlZyp+RdQTDu8Me1WVNiNGpzZNz5m8Pd1gg99t/c1goB4vzweaKghPPSXJ5SqnOEZZ8D4Q0PGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GNTIYTLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81332C43390;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GNTIYTLp21L8vVOD+pJU45PCPk9yav+0yCRZ1m8oA2vuxEhxF+QdPp5cY8Y0HkXkP
	 WRNa6tv5Rk8XBPOxpdLOxf49zOhnIzDV0ZCNUkMPN/6cowFCsHgADNFfkxuY2WK7rV
	 JUDpoPqOabMrgnUak6BK8SKlZE5LaqxHH2yRZld8DaNhaw3otnFDsd10EKJ9KZPMip
	 63FZ82IsBWI0vmySro3dbaySU2TV8ph/lfsiDLwSNZyyQ4Zi7PDsYrJXGFqkE0ffV9
	 e8rPVY+rq9g19UwqBDw8Vzy56UdDtIQRCTYoCXWq162s8FLkx2PfGU0JC3hEsOwYGs
	 kUY4UrnwZAH4Q==
Received: by mercury (Postfix, from userid 1000)
	id 26F261060EF5; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
Subject: [PATCH v4 10/16] ARM: dts: imx6ul: add missing #thermal-sensor-cells
Date: Sat, 24 Feb 2024 22:29:42 +0100
Message-ID: <20240224213240.1854709-11-sre@kernel.org>
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

Fix the following warning found via CHECK_DTBS:

tempmon: '#thermal-sensor-cells' is a required property

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 9eb4eee0c272..45b7605ac381 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -638,6 +638,7 @@ tempmon: tempmon {
 					nvmem-cells = <&tempmon_calib>, <&tempmon_temp_grade>;
 					nvmem-cell-names = "calib", "temp_grade";
 					clocks = <&clks IMX6UL_CLK_PLL3_USB_OTG>;
+					#thermal-sensor-cells = <0>;
 				};
 			};
 
-- 
2.43.0


