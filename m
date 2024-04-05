Return-Path: <linux-kernel+bounces-133506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7BF89A4A2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A0981C22177
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C1CC173335;
	Fri,  5 Apr 2024 19:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDrj+u/f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B5D172BDC;
	Fri,  5 Apr 2024 19:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712343917; cv=none; b=qczudMPp18gOiJjkdFc8z1aORn2ZIh9zcXZkRPQvJYUUnog5NjrLeG+QAMVFap7BXy8oh7Ep0uLUHQiMucmTqXHlnapFcOsLHwor3LxiBmcDMNzI3QSa0H4nQfIg1rQuCYFxvIGBGWIA42leJAvZ48sYJ3Blx44+ergze3K9NCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712343917; c=relaxed/simple;
	bh=Nylk1K3x9Z1w82iqtiWjQN83jq94phFmb6oCsVTo8zU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OkEj0WH+rbpLy6u7DiugSMhN903zaj1I6oeHB9NQCB8EjzKqN7vhMtq7OoBtIbUUocfBTox1u/onNlF24Tb5HWpxDxjiqsNQssS0wsg/eRMf6ydirPbXlWlQTVXuw4/OEcryDG5xMo11fpXvpGY6FilReGgwicv4C6pBiwWEfvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDrj+u/f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50075C43601;
	Fri,  5 Apr 2024 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712343917;
	bh=Nylk1K3x9Z1w82iqtiWjQN83jq94phFmb6oCsVTo8zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PDrj+u/frEuhoQGEeSoxHjzLcP+Yxq5csXLh//2R2fLdBwSAtWjbEFamkq+ysST3X
	 jUnS5niqV1+C9NXO1RbMmv+GF7kMQTGjncK5DlvSbkvgei8XMNqbcvxHSAtq6QR4bp
	 H+2bR4KfCvblxKUYCc78D3gd90MLb3PHuKh02AJVcke0kWQIrSHN1BGrBeIwxhOXbB
	 hacRH1argX6VHjJG3TEBryfO5/XzqUo8lA37fuuppbuQmj+LIqc7nVHyKFQ9Lbetsp
	 KL7DE02LZB3UX5PdBx7bKULzC0m2RoSzB0Nk7kNoZVzNWFO1dNdB9GchNpybS4yXNS
	 V/XvYacbqHrzw==
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
Subject: [RFT PATCH v2 09/10] arm64: dts: microchip: sparx5_pcb134: drop duplicated NOR flash
Date: Fri,  5 Apr 2024 21:04:18 +0200
Message-Id: <20240405190419.74162-9-krzk@kernel.org>
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

Since beginning the DTS extended the SPI0 in two places adding two SPI
muxes, each with same SPI NOR flash.  Both used exactly the same
chip-selects, so this was clearly buggy code.  Then in commit
d0f482bb06f9 ("arm64: dts: sparx5: Add the Sparx5 switch node") one SPI
mux was removed, while keeping the SPI NOR flash node.

This still leaves duplicated SPI nodes under same chip select 0,
reported by dtc W=1 warnings:

  sparx5_pcb134_board.dtsi:277.10-281.4: Warning (unique_unit_address_if_enabled): /axi@600000000/spi@600104000/flash@0: duplicate unit-address (also used in node /axi@600000000/spi@600104000/spi@0)

Steen Hegelund confirmed that in fact there is a SPI mux, thus remove
the duplicated node without the mux.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not tested on hardware

Changes in v2:
1. Remove SPI node without mux.
---
 arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
index f165a409bc1d..2c5574734c9e 100644
--- a/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5_pcb134_board.dtsi
@@ -272,15 +272,6 @@ gpio@1 {
 	};
 };
 
-&spi0 {
-	status = "okay";
-	flash@0 {
-		compatible = "jedec,spi-nor";
-		spi-max-frequency = <8000000>;
-		reg = <0>;
-	};
-};
-
 &spi0 {
 	status = "okay";
 	spi@0 {
-- 
2.34.1


