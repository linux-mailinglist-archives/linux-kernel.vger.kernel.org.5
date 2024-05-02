Return-Path: <linux-kernel+bounces-166823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A288BA005
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 20:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 694A51F22918
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC17171E71;
	Thu,  2 May 2024 18:08:17 +0000 (UTC)
Received: from mailout06.t-online.de (mailout06.t-online.de [194.25.134.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134D16FF2B;
	Thu,  2 May 2024 18:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.25.134.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714673297; cv=none; b=IyDyDswhaUtYcqL/njMfk1xYNm/TibufLoUcG2KRQRRRfgWdZUbOb2//wSEuFy+aNd2T0r9qc/pcSwR+15uTHJxjMfPEExtVi1K6tVnMxqZ0CesJZepoN7sbw5dX1gRoeo3gKI5KAsafzgFzW3yto8UGGU6huUg9VGDeRfnraDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714673297; c=relaxed/simple;
	bh=e3YLMIQIvdxhBBSMKk4ioEXXnAYqSPIZQKGl0Ph+Nps=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WrCv22k2WkZkBF0erBXog0RXPJdXMR/NcQF5LLVNg/HEshNp6uxRfQL0RNuFmIt+ok2mH+uhbVmIV7ggRiz4sBIolIm+1RfRKWv4EtUb+Omkcm3igcKkd/F/iMesiWJwZ7X/UMw2mrgVaHFOnD3TNjYweUBr5TmGv6XYRpl271M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de; spf=pass smtp.mailfrom=t-online.de; arc=none smtp.client-ip=194.25.134.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=t-online.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-online.de
Received: from fwd79.aul.t-online.de (fwd79.aul.t-online.de [10.223.144.105])
	by mailout06.t-online.de (Postfix) with SMTP id BFCDAF41E;
	Thu,  2 May 2024 20:08:07 +0200 (CEST)
Received: from dino2.dhome ([77.47.123.226]) by fwd79.t-online.de
	with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
	esmtp id 1s2aqk-1HSaDx0; Thu, 2 May 2024 20:08:06 +0200
From: Alois Fertl <a.fertl@t-online.de>
To: a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com,
	wens@csie.org,
	jernej.skrabec@gmail.com,
	samuel@sholland.org,
	linux-rtc@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Alois Fertl <a.fertl@t-online.de>
Subject: [PATCH v3 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC Clock
Date: Thu,  2 May 2024 20:07:36 +0200
Message-Id: <20240502180736.7330-1-a.fertl@t-online.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1714673287-68D8B3C7-D18CE117/0/0 CLEAN NORMAL
X-TOI-MSGID: 0047e4c5-c64c-4673-96e8-5d78ab731061

I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618 SOC.
On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
operate correctly. Without this change the clock from the SOC is
~29kHz and BT module does not start up. The patch enables the Internal
OSC Clock Auto Calibration of the H616/H618 which than provides the
necessary 32kHz and the BT module initializes successfully.
Add a flag and set it for H6 AND H616. The H618 is the same as H616
regarding rtc.

Signed-off-by: Alois Fertl <a.fertl@t-online.de>
---

v1->v2
- add flag and activate for H6 AND H616

v2->v3
- correct findings from review

I was hoping to get some feedback regarding the situation on H6,
where an external 32k crystal can be present.
From what I understand from the H6 manual there should be no
conflict as one can select which souce will drive the output.
Should certainly be tested but I don`t have H6 hardware.

 drivers/rtc/rtc-sun6i.c | 17 ++++++++++++++++-

 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
index e0b85a0d5645..20e81ccdef29 100644
--- a/drivers/rtc/rtc-sun6i.c
+++ b/drivers/rtc/rtc-sun6i.c
@@ -42,6 +42,11 @@
 
 #define SUN6I_LOSC_CLK_PRESCAL			0x0008
 
+#define SUN6I_LOSC_CLK_AUTO_CAL			0x000c
+#define SUN6I_LOSC_CLK_AUTO_CAL_16MS		BIT(2)
+#define SUN6I_LOSC_CLK_AUTO_CAL_ENABLE		BIT(1)
+#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL		BIT(0)
+
 /* RTC */
 #define SUN6I_RTC_YMD				0x0010
 #define SUN6I_RTC_HMS				0x0014
@@ -126,7 +131,6 @@
  *     registers (R40, H6)
  *   - SYS power domain controls (R40)
  *   - DCXO controls (H6)
- *   - RC oscillator calibration (H6)
  *
  * These functions are not covered by this driver.
  */
@@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
 	unsigned int has_losc_en : 1;
 	unsigned int has_auto_swt : 1;
 	unsigned int no_ext_losc : 1;
+	unsigned int has_auto_cal : 1;
 };
 
 #define RTC_LINEAR_DAY	BIT(0)
@@ -268,6 +273,14 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
 	}
 	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
 
+	if (rtc->data->has_auto_cal) {
+		/* Enable internal OSC clock auto calibration */
+		reg = SUN6I_LOSC_CLK_AUTO_CAL_16MS |
+			SUN6I_LOSC_CLK_AUTO_CAL_ENABLE |
+			SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL;
+		writel(reg, rtc->base + SUN6I_LOSC_CLK_AUTO_CAL);
+	}
+
 	/* Yes, I know, this is ugly. */
 	sun6i_rtc = rtc;
 
@@ -380,6 +393,7 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
 	.has_out_clk = 1,
 	.has_losc_en = 1,
 	.has_auto_swt = 1,
+	.has_auto_cal = 1,
 };
 
 static void __init sun50i_h6_rtc_clk_init(struct device_node *node)
@@ -395,6 +409,7 @@ static const struct sun6i_rtc_clk_data sun50i_h616_rtc_data = {
 	.has_prescaler = 1,
 	.has_out_clk = 1,
 	.no_ext_losc = 1,
+	.has_auto_cal = 1,
 };
 
 static void __init sun50i_h616_rtc_clk_init(struct device_node *node)
-- 
2.39.2


