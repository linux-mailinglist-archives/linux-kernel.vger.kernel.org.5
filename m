Return-Path: <linux-kernel+bounces-69435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F1A8588FC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:40:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52210B2BE57
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19041487D5;
	Fri, 16 Feb 2024 22:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdDwV0Li"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE014AD37;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708123023; cv=none; b=ceYwOYOybdkHv7PmwFE/oH4GDfoRrd1QKBJy8I1FDATCNahOEE/8lm4L2rbSp86HpJ07j7b5ZyXqhsqVUIn6iZbC34jgUdAbzpHPfcd1v7YaIbwNRYfmzgf+q15cr9FtCPd0AiMYwRwvdKoz0WQLX5Q7KV3kGG4RuFaQFx7pYr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708123023; c=relaxed/simple;
	bh=4H1ZrFfOVaDEHAHjW60y0L58eEE8NKGbyeReCL7ALCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fFuaPygP2JAjFMhfoB/razpsKVp6wtCKUJcCSBiV1tNYxPVBcFdxsmK3P+cwFX1DUJg/N8ms6XByHCHSRVPGOtm03/pG0+TB9Zb5JjbVHE7X36L4CRWW+E58wLw1rSOZQtqvG3Av1z1/fGBpO4TyB3WBokSYjp9XAinCj5Cya+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdDwV0Li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A1AC32782;
	Fri, 16 Feb 2024 22:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708123022;
	bh=4H1ZrFfOVaDEHAHjW60y0L58eEE8NKGbyeReCL7ALCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XdDwV0Li7CqUglRStOz6wBUvYuEjUmfjTnDP8NqBlSOHO/cRnnCLOwmj2Q+b48yXn
	 xANjuZYg5AZC0jnQDDkkPDI35L+rqJAe5/cf/xgfwEAQtbIfQt0gciGrEAR90FDR6Q
	 8Ahhwt1blgrom1cwU6zgjAQV14v9l+cQm5QymjmWx03jkWH0DDMh9LIPshTSc2+Sne
	 xcdFOj9/5ZtNp/N/w7aqu33pwMO9AGCwpAzc/dA6+Wp4HHAOiOQBg5muRLQkbaRYmi
	 ey6o6BxggZmJu60JmgiD4RbFmxHUtXMo+7w+tpADj054c7MlsfpW/9hEZ7w4asVhGJ
	 T6XR011XPptUg==
Received: by mercury (Postfix, from userid 1000)
	id CC79810633E5; Fri, 16 Feb 2024 23:36:56 +0100 (CET)
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
Subject: [PATCH v3 12/16] ARM: dts: nxp: imx6ul: fix touchscreen node name
Date: Fri, 16 Feb 2024 23:34:31 +0100
Message-ID: <20240216223654.1312880-13-sre@kernel.org>
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

The canonical node name for touchscreens is "touchscreen",
so update the i.MX6UL "tsc" node accordingly.

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


