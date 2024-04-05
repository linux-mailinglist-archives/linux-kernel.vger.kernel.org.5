Return-Path: <linux-kernel+bounces-133498-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C217889A492
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE791C21129
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38916172BAE;
	Fri,  5 Apr 2024 19:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFSKwGAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF716D328;
	Fri,  5 Apr 2024 19:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343872; cv=none; b=oHP3AEqSfXouEX43/FT6OF5bBQKgV2QMcP+3Zom5Szww5eo56n7OR2FPLnvoAH+qF8WLDD7dhLkDWch79tYzvyt8XEM/8D7wifmdC5gXME8q3Hk87grYZ+1BvTnaSB+fk2f/cF/p2vlqiaGG1WW2zds1bjAYTYPDx4He9QmV25s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343872; c=relaxed/simple;
	bh=g7uPO9ttLyZhSAK7lXz1159bKTI5S7lMGIJMDuOXNng=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DClMq/A0hijPeS0YQDF8Uk8BPvX94lscyoMMvCZmkfQJ7voEcDm1w1z8bCIJU+FL4BcbM+hs+GR4/ZfSIVe7sREceZP7JOpYyI1xujDaljwKRskS5tECUsl2Lt1KKBQdepus/gtrwp1bDliCoWQ7Z3Pkl60+v1avrRYXUlKjF6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFSKwGAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6884C43390;
	Fri,  5 Apr 2024 19:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343872;
	bh=g7uPO9ttLyZhSAK7lXz1159bKTI5S7lMGIJMDuOXNng=;
	h=From:To:Cc:Subject:Date:From;
	b=FFSKwGAHZRG+BHzUpWfK7y0nHzMpdm+sZUcfJW4QUY2MRY09Nlx7Wt1b/qZi2G8aV
	 iRkvOOT4NmK52JlRYBo6VCKbKs2/d/1lwIOx7N+H8QnuFnJM9icIRQsoA1heXtTj0d
	 SWl5/W6rGC3p5mmZNrU2wDvlqhe2aEQHWprSXyp0rRJJU2HNQ+nMOlYnsPaMeMstSa
	 5h3jXmNbmoRlCaK08OPfGCpDKTeHayTw/hnzhCSA4RWXknrSb153Hv7X9HYIqexIN0
	 0+GL3vPrx/x6nvSfSJAv+pnivzjSEL2A7kmA820FxHV/7TbMKfMny9wnqtsTGDq71u
	 +1VVBXaxr1QJw==
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
Subject: [PATCH v2 01/10] arm64: dts: microchip: sparx5: fix mdio reg
Date: Fri,  5 Apr 2024 21:04:10 +0200
Message-Id: <20240405190419.74162-1-krzk@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the reg address of mdio node to match unit address.  Assume the
reg is not correct and unit address was correct, because there is
already node using the existing reg 0x110102d4.

  sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg): /axi@600000000/mdio@6110102f8: simple-bus unit address format error, expected "6110102d4"

Fixes: d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node")
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---

Not tested on hardware

Changes in v2:
1. Add tags.
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index 24075cd91420..5d820da8c69d 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -447,7 +447,7 @@ mdio2: mdio@6110102f8 {
 			pinctrl-names = "default";
 			#address-cells = <1>;
 			#size-cells = <0>;
-			reg = <0x6 0x110102d4 0x24>;
+			reg = <0x6 0x110102f8 0x24>;
 		};
 
 		mdio3: mdio@61101031c {
-- 
2.34.1


