Return-Path: <linux-kernel+bounces-79873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F4358627D2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 22:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46FB01F22212
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736385336E;
	Sat, 24 Feb 2024 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qtbhlau5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6434E4F895;
	Sat, 24 Feb 2024 21:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708810396; cv=none; b=s429co1snvxgdbI4qi1eZLuhHA4UCIASB7vG/8DJ+CPV5DJuN5IuqTtF4bS27HC4M/XxXRo77p6ZiwGeWL+oozA/GHHO0xR2r36zHmgyJrzG82znJbvRLwH4+LrOaoT/fOr61bTxu+xi6j4aQQi0mwg7JcBt9gSJ+d0GUM4QBpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708810396; c=relaxed/simple;
	bh=f8ZOdPiqTOy6xCxg9gehc2swdQK2Ej/4a+drizyr6vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qmqRHfpsf3EfJ4ZJb4SGJh7F/QX6OOwanBhYQB+R2MWuySmfXjGHuuFu2w6Bz0AwEfAoRU946Kz59EWqWl4vJ7KvkSG2GEvAlnGYR020AOafz0RsGp4T49pLk0QPc6EOC9jXa4ktRm54GRkqsJp8hI/XUHlOSkX3V0hYt+OEvKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qtbhlau5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9B8C43399;
	Sat, 24 Feb 2024 21:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708810395;
	bh=f8ZOdPiqTOy6xCxg9gehc2swdQK2Ej/4a+drizyr6vU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qtbhlau5IYCg7dK0OT367gCDahi6NgLQmxBC5UY+fN8rYwVwvoW8FnkCHd8QsIuH/
	 VL42rgOn2AmQbUTNzz9E7oWaBP/k0YjspgXQ2KoalvkZzBvxk246GEJ8GL5z09C7s5
	 XzgPqJz7sHU4WUk96RbMj6LEMbbKRKmos+5JuHUwrLaZk9HBALnXnN915S0iypA9Vo
	 Nlpji1H7YAv+YLFpYdHzlC/H0pqQs5oROXaenYLngkNpb6yy4ygIL3y1HhL2xs3xRZ
	 dsfgrxTDcUdNARExzhXZhb5+iAMNRCB5wB17QrSQI7vCQPSSYauafQeE0Wr2ZlhNYT
	 QGDANE8OwhZCA==
Received: by mercury (Postfix, from userid 1000)
	id 331631060EFC; Sat, 24 Feb 2024 22:33:10 +0100 (CET)
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
Subject: [PATCH v4 12/16] ARM: dts: nxp: imx6ul: fix touchscreen node name
Date: Sat, 24 Feb 2024 22:29:44 +0100
Message-ID: <20240224213240.1854709-13-sre@kernel.org>
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

The canonical node name for touchscreens is "touchscreen",
so update the i.MX6UL "tsc" node accordingly.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Sebastian Reichel <sre@kernel.org>
---
 arch/arm/boot/dts/nxp/imx/imx6ul.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
index 45b7605ac381..8aa365f837ca 100644
--- a/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
+++ b/arch/arm/boot/dts/nxp/imx/imx6ul.dtsi
@@ -370,7 +370,7 @@ asrc: asrc@2034000 {
 				};
 			};
 
-			tsc: tsc@2040000 {
+			tsc: touchscreen@2040000 {
 				compatible = "fsl,imx6ul-tsc";
 				reg = <0x02040000 0x4000>, <0x0219c000 0x4000>;
 				interrupts = <GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-- 
2.43.0


