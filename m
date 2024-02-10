Return-Path: <linux-kernel+bounces-60224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306A8501A1
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4EB028AFEA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5266538F8F;
	Sat, 10 Feb 2024 01:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYhLMKUY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB4D1DFD9;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=iT74XHApHQRszBkvmMk/pt346gTKo0AB6UdYU5M/+rpVUZY+z8jtxyHQCllwDwzpjmEHlOZ8zGzgiRTuaMiG3xpamsIyla5QpjHz45+gUCEljDZhJy/EABDnZjywC7yUcq9JfdHn31vgsq6YZnH9Br0egqxolXYc8CfjTZ2R/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=4dEfl82ZwKQ7mXIpNreWb5CcjIFADyzlcxSDXtMAG3w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ox/A7y38A5KZryKvKNF4dda0eYJfqJ+1QFuT0Kt2IlN3/Y4gkXL825GFnqQzg8FPVmWdNOLX7k/+sIMjzRjGV+++3YSvjoJpbmLyhYFwbgJdeZABBzuyfQqOiBYRWByxT/MbRgUyHmTgBhQQ3v97+X6dTFdUzcjW4OTn1FXLSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYhLMKUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45141C41613;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=4dEfl82ZwKQ7mXIpNreWb5CcjIFADyzlcxSDXtMAG3w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QYhLMKUYT57awIlxgq+y4vxBVkRs8fQwiKsW+CgaDGhX0WRBjo5YbZacAmaDk955j
	 KBlKDtbYOI89AujFMspbXXKpDc7UC6Mb+PJcE+b/2k7AKyy5kCg2lC2f7r4AAf8U1X
	 9+/MwRvcchPnCPEdhHAsMczlW+S4IOmN5FpVFKD+QdPwTAdrWiYrwNqzWzOS9L+2Xg
	 OjQMIYSU4CEnqxb6mO57qNEJghrgt5pa4lF6LGRo768lXOvMcHC1kRJdN2wcsvpiiu
	 6K9ytl+dh8HdfNTpcKaouiKdJI8WK6fYngcpENfb5xOz499XQPVtPzXL21c7uPnCa8
	 pLxYPUe/JFUUA==
Received: by mercury (Postfix, from userid 1000)
	id EC70D1069300; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
Subject: [PATCH v1 09/14] ARM: dts: imx6ull: fix pinctrl node name
Date: Sat, 10 Feb 2024 02:18:13 +0100
Message-ID: <20240210012114.489102-10-sre@kernel.org>
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


