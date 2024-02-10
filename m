Return-Path: <linux-kernel+bounces-60222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A930985019E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 446E21F2616E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E040B383AF;
	Sat, 10 Feb 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKYz1ocl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E6171B1;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528081; cv=none; b=in9NdPxiileYh+y0cK1CgO0Gu1J8cDUYeyr/D6Ts3Wwv0+1UczS0uf3K/G37hHdsrDc3HgP7/NH/TWbAYE1Z1wTw3H5CChj/tzNbNbf+d2ZEojUbkE6QRd2XzAW5oLgS5/SyXdBSw6+KrpJgY3J3tJ3k4Qdkv2qpbzbfREVas6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528081; c=relaxed/simple;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nxDS4zAfBKyotkjPg5R0O/QdsmENRWv95BHrmVOjKYxyg+cM2qUXtNhFKDiYCFmVNNwKdo+IFfR/MRCYuJ9blDwZNhhtf1zMpJHIyahU4Z5+Bow9zvlvwQjPGBx7QHkuJ3MYOdG9xFPhBxpQuPqOWLASbhXL04dawAk+6r4zc5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKYz1ocl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E32AC433B1;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=pSvctDHxVCaAu+4cZjOT/I3a/3LHsGScFSRvh9RHyIQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKYz1oclt/g6a7DRDfuHt+Tu88+httySNUlWh7ZyUzyWE3YDK4rU9JP3dih6qDLfm
	 Vi3Xrg/Wqp3CAEQmGwR+tTUaYYxiDqUDL3y5qsw75coq8pDRhDugnkmax77EdCkIf2
	 JYUrYLJocAdML3oj7KAc9z20dJDiTNMbzDnRBzupAQcMMEkdCQD1pC4cOLKsFfZl28
	 bjgc+LyGaFg0A7dRk9n1DsSi7uOU1m8fKpoe61mRXglQLKHBXU6gsu4+5cksAAeRDa
	 yzKbe9KiCDAlcPfEadSvsxbg9sqvnfoNd1aLQGGf8kLfwoGU0q+Fu+NXANJMANoJQY
	 LX9crgJ+02xZA==
Received: by mercury (Postfix, from userid 1000)
	id EF2E210694AE; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
Subject: [PATCH v1 10/14] ARM: dts: imx6ul: Remove fsl,anatop from usbotg1
Date: Sat, 10 Feb 2024 02:18:14 +0100
Message-ID: <20240210012114.489102-11-sre@kernel.org>
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

fsl,anatop should only be added to the usbphy nodes.

Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index a27a7554c2e7..9eb4eee0c272 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -855,7 +855,6 @@ usbotg1: usb@2184000 {
 				clocks = <&clks IMX6UL_CLK_USBOH3>;
 				fsl,usbphy = <&usbphy1>;
 				fsl,usbmisc = <&usbmisc 0>;
-				fsl,anatop = <&anatop>;
 				ahb-burst-config = <0x0>;
 				tx-burst-size-dword = <0x10>;
 				rx-burst-size-dword = <0x10>;
-- 
2.43.0


