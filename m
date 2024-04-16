Return-Path: <linux-kernel+bounces-147148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B63118A701D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70ED72860CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20A9B13119E;
	Tue, 16 Apr 2024 15:47:41 +0000 (UTC)
Received: from albert.telenet-ops.be (albert.telenet-ops.be [195.130.137.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D1131756
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282460; cv=none; b=RTbpARYyj6cYamrMKrlOfU5T0SnLoPQygk1YTw7z58teIxR4LGE4Cj+pH5+NsaDUE8PJ5rrkD7MBwqeXy48wJHI9JQJIhfk2/YtutsjDEWjm1YaOoSu6CFFvWfUTiqLqvoo3HDck1YTFVUKkMHUesgYEWDu30GGfwLLpiA53Ek8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282460; c=relaxed/simple;
	bh=FdQr1h/L7g/vE47GLu19CgVt8kMTGmoLXr4TPLuHPec=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AtG09cdJP9zJSOjGcmhT1Gm2tkSMNWJrBK7xvr/FxH5DVlfuI3lPSqYDXWfnNlJ64TY8MCx5VJLQlJJh7flGGCivqffJ+re4VSLPVAuPIN5D03MpT++y0cjlURVn39Ots/yctxhUhg1syqdbug+pHY99TF/0pr4FIC09ruubeSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by albert.telenet-ops.be with bizsmtp
	id BrnW2C00J0SSLxL06rnWYW; Tue, 16 Apr 2024 17:47:30 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwl1K-008J68-TW;
	Tue, 16 Apr 2024 17:47:30 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwl1u-00Ebkk-B2;
	Tue, 16 Apr 2024 17:47:30 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/2] pinctrl: renesas: r8a779h0: Add INTC-EX pins, groups, and function
Date: Tue, 16 Apr 2024 17:47:23 +0200
Message-Id: <258d03b27b77f60cc03fc3257bb4c6715b612a61.1713282028.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1713282028.git.geert+renesas@glider.be>
References: <cover.1713282028.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add pins, groups, and function for the Interrupt Controller for External
Devices (INTC-EX) on the Renesas R-Car V4M (R8A779H0) SoC.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 112 +++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index 0cbfe7637fc97743..438d1f2739dd4bcd 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -1660,6 +1660,90 @@ static const unsigned int i2c3_mux[] = {
 	SDA3_MARK, SCL3_MARK,
 };
 
+/* - INTC-EX ---------------------------------------------------------------- */
+static const unsigned int intc_ex_irq0_a_pins[] = {
+	/* IRQ0_A */
+	RCAR_GP_PIN(0, 6),
+};
+static const unsigned int intc_ex_irq0_a_mux[] = {
+	IRQ0_A_MARK,
+};
+static const unsigned int intc_ex_irq0_b_pins[] = {
+	/* IRQ0_B */
+	RCAR_GP_PIN(1, 20),
+};
+static const unsigned int intc_ex_irq0_b_mux[] = {
+	IRQ0_B_MARK,
+};
+
+static const unsigned int intc_ex_irq1_a_pins[] = {
+	/* IRQ1_A */
+	RCAR_GP_PIN(0, 5),
+};
+static const unsigned int intc_ex_irq1_a_mux[] = {
+	IRQ1_A_MARK,
+};
+static const unsigned int intc_ex_irq1_b_pins[] = {
+	/* IRQ1_B */
+	RCAR_GP_PIN(1, 21),
+};
+static const unsigned int intc_ex_irq1_b_mux[] = {
+	IRQ1_B_MARK,
+};
+
+static const unsigned int intc_ex_irq2_a_pins[] = {
+	/* IRQ2_A */
+	RCAR_GP_PIN(0, 4),
+};
+static const unsigned int intc_ex_irq2_a_mux[] = {
+	IRQ2_A_MARK,
+};
+static const unsigned int intc_ex_irq2_b_pins[] = {
+	/* IRQ2_B */
+	RCAR_GP_PIN(0, 13),
+};
+static const unsigned int intc_ex_irq2_b_mux[] = {
+	IRQ2_B_MARK,
+};
+
+static const unsigned int intc_ex_irq3_a_pins[] = {
+	/* IRQ3_A */
+	RCAR_GP_PIN(0, 3),
+};
+static const unsigned int intc_ex_irq3_a_mux[] = {
+	IRQ3_A_MARK,
+};
+static const unsigned int intc_ex_irq3_b_pins[] = {
+	/* IRQ3_B */
+	RCAR_GP_PIN(1, 23),
+};
+static const unsigned int intc_ex_irq3_b_mux[] = {
+	IRQ3_B_MARK,
+};
+
+static const unsigned int intc_ex_irq4_a_pins[] = {
+	/* IRQ4_A */
+	RCAR_GP_PIN(1, 17),
+};
+static const unsigned int intc_ex_irq4_a_mux[] = {
+	IRQ4_A_MARK,
+};
+static const unsigned int intc_ex_irq4_b_pins[] = {
+	/* IRQ4_B */
+	RCAR_GP_PIN(2, 3),
+};
+static const unsigned int intc_ex_irq4_b_mux[] = {
+	IRQ4_B_MARK,
+};
+
+static const unsigned int intc_ex_irq5_pins[] = {
+	/* IRQ5 */
+	RCAR_GP_PIN(2, 2),
+};
+static const unsigned int intc_ex_irq5_mux[] = {
+	IRQ5_MARK,
+};
+
 /* - MMC -------------------------------------------------------------------- */
 static const unsigned int mmc_data_pins[] = {
 	/* MMC_SD_D[0:3], MMC_D[4:7] */
@@ -2416,6 +2500,18 @@ static const struct sh_pfc_pin_group pinmux_groups[] = {
 	SH_PFC_PIN_GROUP(i2c2),
 	SH_PFC_PIN_GROUP(i2c3),
 
+	SH_PFC_PIN_GROUP(intc_ex_irq0_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq0_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq1_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq1_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq2_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq2_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq3_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq3_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq4_a),
+	SH_PFC_PIN_GROUP(intc_ex_irq4_b),
+	SH_PFC_PIN_GROUP(intc_ex_irq5),
+
 	BUS_DATA_PIN_GROUP(mmc_data, 1),
 	BUS_DATA_PIN_GROUP(mmc_data, 4),
 	BUS_DATA_PIN_GROUP(mmc_data, 8),
@@ -2629,6 +2725,20 @@ static const char * const i2c3_groups[] = {
 	"i2c3",
 };
 
+static const char * const intc_ex_groups[] = {
+	"intc_ex_irq0_a",
+	"intc_ex_irq0_b",
+	"intc_ex_irq1_a",
+	"intc_ex_irq1_b",
+	"intc_ex_irq2_a",
+	"intc_ex_irq2_b",
+	"intc_ex_irq3_a",
+	"intc_ex_irq3_b",
+	"intc_ex_irq4_a",
+	"intc_ex_irq4_b",
+	"intc_ex_irq5",
+};
+
 static const char * const mmc_groups[] = {
 	"mmc_data1",
 	"mmc_data4",
@@ -2813,6 +2923,8 @@ static const struct sh_pfc_function pinmux_functions[] = {
 	SH_PFC_FUNCTION(i2c2),
 	SH_PFC_FUNCTION(i2c3),
 
+	SH_PFC_FUNCTION(intc_ex),
+
 	SH_PFC_FUNCTION(mmc),
 
 	SH_PFC_FUNCTION(msiof0),
-- 
2.34.1


