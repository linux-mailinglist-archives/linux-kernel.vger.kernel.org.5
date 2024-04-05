Return-Path: <linux-kernel+bounces-133503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBE89A49C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1875C1F24111
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B750174EDE;
	Fri,  5 Apr 2024 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeIWe1cy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EA8172BB1;
	Fri,  5 Apr 2024 19:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343899; cv=none; b=h66SVi1X8YUY3TqW4YmzR+gXcFfhcGtT1pMXMZ4/XLKQ93iGaCQVIpATOvdGrlA0xU7T8SrA1q76tokhuxStGYMYcEwmBmLz7aLrHL1yvofXNIrlGbZ8Y8/YZvBx8Jte/0IbcQ+l8Ttos23Dz8bcVqkaFejbazdQNr/ABkGX10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343899; c=relaxed/simple;
	bh=zQdpjulsluV9rUl9IyOY6xmyruWz5vCIOqTtNNuT/5Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCe6QtPNTg0cHdSgO58MrvgBlUV0bpheFyCSFLAuz67HvI8fPDpqeoNRt9dWb1EWDG7d7jK0N6VUsa0Z9oPdROskOyRTV6OKXm4p44c/2bflbD1vYDWkBKD5aKtVSeziv+Rs0YnmXu7pTltks92jvnVFiKLA1oh+JIYtRuDhMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeIWe1cy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A31AC43390;
	Fri,  5 Apr 2024 19:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343898;
	bh=zQdpjulsluV9rUl9IyOY6xmyruWz5vCIOqTtNNuT/5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KeIWe1cykH4gA0U89Vv/BULCnsaCMTkvcAgex+vyqvIvMbDmxAr7Z85pPS/9i5uiM
	 yOEUJAMVwf6L68J0LcCwXyapNtUB2gCc+uThd5x05sS4TmjTJFYk/Cuz0dTmFtnS1l
	 YppF1pXld2ZQlmx/xCBmsJCZTx5hJjFgU7b23cewxV50O95lPaL7ps9enuqolxqJGH
	 GDPu2bTmiLddB7F1dUDBxpjiJyvmTBUFLvFNyGWK46wTchUkMpAxEaxKdUvXSKP6kU
	 azA8j64QvNqt5qxF5jcNAK589n8cFcouIrIR2swI0wyCM32eqFGOrPe0CPqSszo/oA
	 Pi/zVFyf+87nQ==
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Conor Dooley <conor@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: horatiu.vultur@microchip.com,
	steen.hegelund@microchip.com,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 06/10] arm64: dts: microchip: sparx5_pcb135: align I2C mux node name with bindings
Date: Fri,  5 Apr 2024 21:04:15 +0200
Message-Id: <20240405190419.74162-6-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240405190419.74162-1-krzk@kernel.org>
References: <20240405190419.74162-1-krzk@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DT schema expects node names to match certain.  This fixes dtbs_check
warnings like:

  sparx5_pcb135_emmc.dtb: i2c0-imux@0: $nodename:0: 'i2c0-imux@0' does not match '^(i2c-?)?mux'

and dtc W=1 warnings:

  sparx5_pcb135_board.dtsi:132.25-137.4: Warning (simple_bus_reg): /axi@600000000/i2c0-imux@0: missing or empty reg/ranges property

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes in v2:
1. None
---
 arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
index bf51a6e11cf1..860975ffe0a1 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb135_board.dtsi
@@ -129,7 +129,7 @@ &sgpio2 {
 };
 
 &axi {
-	i2c0_imux: i2c0-imux@0 {
+	i2c0_imux: i2c-mux {
 		compatible = "i2c-mux-pinctrl";
 		#address-cells = <1>;
 		#size-cells = <0>;
-- 
2.34.1


