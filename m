Return-Path: <linux-kernel+bounces-147146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC098A7018
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 17:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAC6E2847DD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8530F1311AA;
	Tue, 16 Apr 2024 15:47:34 +0000 (UTC)
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E76131196
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 15:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713282454; cv=none; b=LOWiaYy7UtfpN6o8oCUDCM7qRR+9lBGaBaulEZhIR1rLzM2OI325SvvdEyxhtqLw/HB/8OD1ZpdEh3+UynLobOZ4NW2RS1si5d2SmXzD67b2vajBJNSogM497uwFAM9TOgC+zIdIXPMxvHrvmXWvIaGxtFGF1y5sa33U9tbQsoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713282454; c=relaxed/simple;
	bh=/acYgz3kJaLA/vBHE8yKL25SRSKCtv2KUbyuhCBZmo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cEcga/fkjqINJrEjJSqlSdEQzir3O1QR4EyVOf+62EMFJzhjAsqK3P69zXo/QqkUQhv3YX8wJSZ1YmB8kqVFmupFergkoT08gISOgSG0+OD1TEul5ZU5wUIYt7dOZ3WQA4Rw18az6KX/7RP6jng0/GKAWMuHzvrbGef+/wO73A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:76d0:2bff:fec8:549])
	by michel.telenet-ops.be with bizsmtp
	id BrnV2C00L0SSLxL06rnVye; Tue, 16 Apr 2024 17:47:30 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwl1K-008J5u-9p;
	Tue, 16 Apr 2024 17:47:29 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1rwl1t-00Ebkf-Mw;
	Tue, 16 Apr 2024 17:47:29 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Cong Dang <cong.dang.xn@renesas.com>,
	linux-renesas-soc@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 1/2] pinctrl: renesas: r8a779h0: Fix IRQ suffixes
Date: Tue, 16 Apr 2024 17:47:22 +0200
Message-Id: <7d3c7498d9e8eda5583b15f9163eb25bb797ed24.1713282028.git.geert+renesas@glider.be>
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

The suffixes of the IRQ identifiers, as used for pins related to the
Interrupt Controller for External Devices (INTC-EX), are inconsistent.
Correct them to match the Pin Multiplex attachment in Rev.0.51 of the
R-Car V4M Series Hardware User's Manual.

Fixes: 291f7856fc451cbe ("pinctrl: renesas: Initial R8A779H0 (R-Car V4M) PFC support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/pinctrl/renesas/pfc-r8a779h0.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/renesas/pfc-r8a779h0.c b/drivers/pinctrl/renesas/pfc-r8a779h0.c
index afa8f06c85cf5bd6..0cbfe7637fc97743 100644
--- a/drivers/pinctrl/renesas/pfc-r8a779h0.c
+++ b/drivers/pinctrl/renesas/pfc-r8a779h0.c
@@ -75,10 +75,10 @@
 #define GPSR0_9		F_(MSIOF5_SYNC,		IP1SR0_7_4)
 #define GPSR0_8		F_(MSIOF5_SS1,		IP1SR0_3_0)
 #define GPSR0_7		F_(MSIOF5_SS2,		IP0SR0_31_28)
-#define GPSR0_6		F_(IRQ0,		IP0SR0_27_24)
-#define GPSR0_5		F_(IRQ1,		IP0SR0_23_20)
-#define GPSR0_4		F_(IRQ2,		IP0SR0_19_16)
-#define GPSR0_3		F_(IRQ3,		IP0SR0_15_12)
+#define GPSR0_6		F_(IRQ0_A,		IP0SR0_27_24)
+#define GPSR0_5		F_(IRQ1_A,		IP0SR0_23_20)
+#define GPSR0_4		F_(IRQ2_A,		IP0SR0_19_16)
+#define GPSR0_3		F_(IRQ3_A,		IP0SR0_15_12)
 #define GPSR0_2		F_(GP0_02,		IP0SR0_11_8)
 #define GPSR0_1		F_(GP0_01,		IP0SR0_7_4)
 #define GPSR0_0		F_(GP0_00,		IP0SR0_3_0)
@@ -265,10 +265,10 @@
 #define IP0SR0_3_0	F_(0, 0)		FM(ERROROUTC_N_B)	FM(TCLK2_B)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_7_4	F_(0, 0)		FM(MSIOF3_SS1)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_11_8	F_(0, 0)		FM(MSIOF3_SS2)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_15_12	FM(IRQ3)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_19_16	FM(IRQ2)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_23_20	FM(IRQ1)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
-#define IP0SR0_27_24	FM(IRQ0)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_15_12	FM(IRQ3_A)		FM(MSIOF3_SCK)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_19_16	FM(IRQ2_A)		FM(MSIOF3_TXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_23_20	FM(IRQ1_A)		FM(MSIOF3_RXD)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
+#define IP0SR0_27_24	FM(IRQ0_A)		FM(MSIOF3_SYNC)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 #define IP0SR0_31_28	FM(MSIOF5_SS2)		F_(0, 0)		F_(0, 0)	F_(0, 0)	F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0) F_(0, 0)
 
 /* IP1SR0 */		/* 0 */			/* 1 */			/* 2 */		/* 3		4	 5	  6	   7	    8	     9	      A	       B	C	 D	  E	   F */
@@ -672,16 +672,16 @@ static const u16 pinmux_data[] = {
 
 	PINMUX_IPSR_GPSR(IP0SR0_11_8,	MSIOF3_SS2),
 
-	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3),
+	PINMUX_IPSR_GPSR(IP0SR0_15_12,	IRQ3_A),
 	PINMUX_IPSR_GPSR(IP0SR0_15_12,	MSIOF3_SCK),
 
-	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2),
+	PINMUX_IPSR_GPSR(IP0SR0_19_16,	IRQ2_A),
 	PINMUX_IPSR_GPSR(IP0SR0_19_16,	MSIOF3_TXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1),
+	PINMUX_IPSR_GPSR(IP0SR0_23_20,	IRQ1_A),
 	PINMUX_IPSR_GPSR(IP0SR0_23_20,	MSIOF3_RXD),
 
-	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0),
+	PINMUX_IPSR_GPSR(IP0SR0_27_24,	IRQ0_A),
 	PINMUX_IPSR_GPSR(IP0SR0_27_24,	MSIOF3_SYNC),
 
 	PINMUX_IPSR_GPSR(IP0SR0_31_28,	MSIOF5_SS2),
-- 
2.34.1


