Return-Path: <linux-kernel+bounces-126806-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7009893CEB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95C661F2202D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A56247772;
	Mon,  1 Apr 2024 15:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du60WaCv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8546452;
	Mon,  1 Apr 2024 15:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711985869; cv=none; b=VYnRd+buidxnTJel4x8tLqNcMavyUOFzVNItpAp4NfMlBH/vHjJmKv8Lwi0Nvi3VJ2EoANLYLyuMDs1X4EtFF2adMxiXsvi1pm/jRur6jNvsSmyO1UKxTL1/l5UyDsd+xaollMnF2D7eHfQMXC5jvixC6Zjvip2PSQarCh+yAgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711985869; c=relaxed/simple;
	bh=TWR2R9S8+YN5+h3vNn0SS/MXsQWwKa64KB0+vUd7Ous=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ck4s9RyKMIYUUdMDrwTYZXWZwRacPBerR2tTPVQXfdPKQThpaERTpmHYL5t+G6w2y5bc6t6PQH8SXnIb1pbdzbT4snsxsDWAhVHAbkXjt1bBbC9SO2Tsvmzc1uXyXU69wHqW4syI172fQYWhslaDhDvATpctQjoVWB1vYb/rZRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du60WaCv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D723C433F1;
	Mon,  1 Apr 2024 15:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711985869;
	bh=TWR2R9S8+YN5+h3vNn0SS/MXsQWwKa64KB0+vUd7Ous=;
	h=From:To:Cc:Subject:Date:From;
	b=Du60WaCvSlza/o1nfoaVwJ7uL4uMUa5xPlBqYRuLjDxl+NvPqsrllTs/78eCFL4zJ
	 vGXDS3cbpmTgrYbQyfXj4vgMFmiKjamez+pEUBT5kG/gexrtzjUV7QqkS7h/rLwpOj
	 jBT44BNTqympo1j+fSJET/euA1EKeBvCh+FQNzrdc95oGVQXhdMlfOUO4DX/Gq04FU
	 pUaPJRBKyfqp6HzlyxVG5dkMkRjsK8ZywLuGHQX15mUmtqLXskEkSdU/Gdq7A+TCMM
	 Psx7axzokNcvpG6NdFJsprYcZ1WuocRFZ87VbcnY57mnpt+GeMCu8YVBbAJygPaDRB
	 O/ClEeZ1kriUQ==
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
	"David S. Miller" <davem@davemloft.net>,
	Bjarni Jonasson <bjarni.jonasson@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH RFT 01/10] arm64: dts: microchip: sparx5: fix mdio reg
Date: Mon,  1 Apr 2024 17:37:31 +0200
Message-Id: <20240401153740.123978-1-krzk@kernel.org>
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
alerady node using the existing reg 0x110102d4.

  sparx5.dtsi:443.25-451.5: Warning (simple_bus_reg): /axi@600000000/mdio@6110102f8: simple-bus unit address format error, expected "6110102d4"

Fixes: d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware
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


