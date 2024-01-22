Return-Path: <linux-kernel+bounces-33004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 233F683631E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C731C23C12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBB13DBA8;
	Mon, 22 Jan 2024 12:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jb3dmfnL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA26C3DB93;
	Mon, 22 Jan 2024 12:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926045; cv=none; b=oty4Tg8+AUA+4QdULl3jqEQz62Uc1ao+mm89MBCcZj9BZynkCyRxNfHtbvVAULLRZUIgPy7dp7qdc5moIEMZXUjNe063QBR0Hs50V439d5zEtF7cNhFS7Qy+dbeHKsxCrawK6e0HtASyvu+XPWu57ZxdocR7mj66dxgyMyVzrKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926045; c=relaxed/simple;
	bh=GT65QrRSZZI/JIdwPBcys6eLLwNLwpPSE/DJ6auIUks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rl9Q87iHcWVUJgCDsOxwWTUMzCHGJnjrTDatYIbP/u/EVLMQ+ioMy+DCRYjtQpAjrfm/pky94/ygVK+IYYS9WoaJc7GH9EyyK0EEOfnOIsJnF2x62gLPZ9Oz3l5RDDyIvj4MEdhX+UA37p1Jn3CTHM1nDUIj6Vtt1+1c3CXnmTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jb3dmfnL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B1FC433C7;
	Mon, 22 Jan 2024 12:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705926045;
	bh=GT65QrRSZZI/JIdwPBcys6eLLwNLwpPSE/DJ6auIUks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jb3dmfnLIjra2EvCeWTQURVArpunSXQ8WZ7SvOrjHrcqnIRO5bLN1bGYZZ/fwYmsc
	 6Ir67jWsLHwz1/2EYI0irVemtunm2SMWpxgnOoA1UBRM0ane3xizfMUd1xb5sK2mZY
	 0qOheNB4lcGneWBomX5Yg7lGZOYJTGR6c0UNDDEJsCbzWckfPr14Qn8zBst4GCCB3D
	 Y9rMCRDy46UsioPfKTAUAKNTq99J2hlXSmBoDaxuVNXiLanJenqJR/AZf7Iz/5239v
	 sPNu1DBIuqjTE5ZBs7wCYyAo+5VFS1cfkS/+hy4H9VWOseqEYxwEH+vGEycXOvEREF
	 0nOuQWwkl4/+w==
From: Conor Dooley <conor@kernel.org>
To: linux-riscv@lists.infradead.org
Cc: conor@kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: [PATCH v2 7/7] riscv: dts: microchip: add missing CAN bus clocks
Date: Mon, 22 Jan 2024 12:19:55 +0000
Message-ID: <20240122-splice-poncho-18a369c7dbc7@spud>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122-catty-roast-d3625dbb02fe@spud>
References: <20240122-catty-roast-d3625dbb02fe@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1347; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=pLA+R73nzpZMSjL5ZIEEpNbYsZjEzmZPe5bK/xmNjSY=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnrYlPleT5Wn+6OL38lGp3sdiX9kvjzCpZLh79GzvM5s zmRq2ByRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACZS+YmRYZunivptLuErjQu/ N1lXLrlwi/XW5XCGE7N82m+Ic7Ruv83wz+SeTKeekUOK973a71eDBd/2iDnWPnL2uLo3PEXiktF WJgA=
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit

From: Conor Dooley <conor.dooley@microchip.com>

The CAN controller on PolarFire SoC has an AHB peripheral clock _and_ a
CAN bus clock. The bus clock was omitted when the binding was written,
but is required for operation. Make up for lost time and add to the DT.

Fixes: 38a71fc04895 ("riscv: dts: microchip: add mpfs's CAN controllers")
Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---
 arch/riscv/boot/dts/microchip/mpfs.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/boot/dts/microchip/mpfs.dtsi b/arch/riscv/boot/dts/microchip/mpfs.dtsi
index 266489d43912..4d70df0f908c 100644
--- a/arch/riscv/boot/dts/microchip/mpfs.dtsi
+++ b/arch/riscv/boot/dts/microchip/mpfs.dtsi
@@ -416,7 +416,7 @@ i2c1: i2c@2010b000 {
 		can0: can@2010c000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010c000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN0>;
+			clocks = <&clkcfg CLK_CAN0>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <56>;
 			status = "disabled";
@@ -425,7 +425,7 @@ can0: can@2010c000 {
 		can1: can@2010d000 {
 			compatible = "microchip,mpfs-can";
 			reg = <0x0 0x2010d000 0x0 0x1000>;
-			clocks = <&clkcfg CLK_CAN1>;
+			clocks = <&clkcfg CLK_CAN1>, <&clkcfg CLK_MSSPLL3>;
 			interrupt-parent = <&plic>;
 			interrupts = <57>;
 			status = "disabled";
-- 
2.43.0


