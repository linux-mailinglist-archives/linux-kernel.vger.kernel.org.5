Return-Path: <linux-kernel+bounces-69437-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BC8588F9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE491C2460A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3742C14F9CC;
	Fri, 16 Feb 2024 22:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+RVpscT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C3E14AD38;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123023; cv=none; b=KuGqMAmDCZtZaykxzhcxMLvvuWuhAw9xwMp7wqbl6bnlqhTazcu7Iq2/XUPrcBxR+bY5fT2gF8B9EGY5Xwd6LRQ2p958saE9usb2+8vRUkb9e6vL38DCNhDcILffnBchFyD0suJfJN1kxeJ8V63g7uw9Ty0BW0O+82ODGS4eX10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123023; c=relaxed/simple;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyF7yvAj9wGbu17pQ9+m77fN4u1yVJH7VOzihDfqeDrDxDkDUK2N1qnVQ6oJLDJosOOKhxGrTSvk0zX5vaPusbNovdam1pL7HWOsFkKm/cT3dAK88P5vBZJ4W8yl97poZzEyqCCrT/RmMLYya1OrHtmotkommGxwR/mUP0tZyGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+RVpscT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7677EC433B1;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=jWTFkWLAfHQn/N4QeNXzUQZEB7hyrlDD3WfPhQ90sdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E+RVpscT5QIuwdg4oqaWeniow5kPtqg/nwDnPm6JYFvY3GEtnWbu/wU9zTRwCUTQg
	 nUhNTfm7FUrw8OW0qOy5Ok8peA08ahsplcP8xgUegDg9mbtwBIoFhPPrXC9sNhZdum
	 z0HeJaO3Yh/kMHLlLfz8nTVE1qwMMXksZso7BantC7bB2/cvRo8yPL80I6wNe7MER2
	 Py7GR8Y3XXHDok/ZxIzKF25TXNyY5NL7lKWIKVXEA8lqFD4xqI76o+yMrSHeKKhLHU
	 C1K7fQqP6e0waWzpqCVApT0EmSZ9Ahbh+g5yMQpCHZ7LruG9fAwkCaMfbk9WHAxevL
	 9UFyGfKaY8n0Q==
Received: by mercury (Postfix, from userid 1000)
	id C14D810633D8; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 10/16] ARM: dts: imx6ul: add missing #thermal-sensor-cells
Date: Fri, 16 Feb 2024 23:34:29 +0100
Message-ID: <20240216223654.1312880-11-sre@kernel.org>
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


