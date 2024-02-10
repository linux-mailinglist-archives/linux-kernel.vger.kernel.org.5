Return-Path: <linux-kernel+bounces-60230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 113138501A9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 02:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D056B27665
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 01:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E7D3A8C9;
	Sat, 10 Feb 2024 01:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iNJOIP+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDDD1EF03;
	Sat, 10 Feb 2024 01:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707528082; cv=none; b=KTtjJf0Wg8WXv/TWXxM85yYrJzsU7FVxzuulc2T4NyZAkzsN589XLNYwfsTlGYd75hfk9LAGItQtwYP5sHBrqKMxqHeLbbLKpF6G2DSMRWxXA2PKeIJUl7UGGYrBfWxkzucgDc98EDTBRz+XpaHAxNvARxpLfHGDlJPAGHaQxwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707528082; c=relaxed/simple;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaEFcXWDPU202B8ZMHVrJ/PCfFug25k/jQ2kqepvT8Yl6rZ/4muDBcV8fA1L3c3kk4sXkNadltCcj323Z+xYHEGX4wESs47hFSe8lCN8Gy6UpoyR+vFijB5ujnO8MQBxCfaLgIKhjdQXvFBIM1BgBiT9Aczb/gH83B6mW893BvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iNJOIP+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80EA5C43143;
	Sat, 10 Feb 2024 01:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707528081;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iNJOIP+BqS4hU6+0fCPaA1pA85TWIf3FihYKqWKonRJprmuTQXwxhwLh02OsLJOpm
	 eYXq1oJcz+K+aIG0EqnTsMZXXv566A85Eita6+qvnT77utfj0zkzB4svRW8M3pxhW4
	 HZclm8jf9pq/QFiVLQY480XQkK0RdjvQ2jW6pJGvnkn2JPzR8adMZhXAhXUxwq7Avz
	 DycqTmm1Koq3T69Cz2VmAdYBQ6GRlFdqnpbrs4D28Dz0c4ZIGleTMBoIA0DDskzBIG
	 jlnSivPDv6tJMyUO47zejQfKduka+BX1u4qI7lF9rsAYtidG+VtjPq6buoPX9iBeox
	 siroZp+SCL7pg==
Received: by mercury (Postfix, from userid 1000)
	id F1E0010694EE; Sat, 10 Feb 2024 02:21:15 +0100 (CET)
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
Subject: [PATCH v1 11/14] ARM: dts: imx6ul: add missing #thermal-sensor-cells
Date: Sat, 10 Feb 2024 02:18:15 +0100
Message-ID: <20240210012114.489102-12-sre@kernel.org>
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


