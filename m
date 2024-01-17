Return-Path: <linux-kernel+bounces-28883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 34C1683042F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 12:07:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A16B1282385
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B8A91DDCA;
	Wed, 17 Jan 2024 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="TlIFCO74"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B471CD3C
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 11:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705489630; cv=none; b=taEvJ68Wg4YOm8d1CzZlWeXVznN0+ignhsKWrrSnWD7lsQs6yIevPpQf0KRa991oKQsVF1Uf2lglVsj9DudVoR6tFGDVa33ypXrZE2tlLgfnHI8Lv+pCa8QTz6pyZQ7QA9hAU/Yh6qgerjluYh8xpsUVDwH46b4X1qJVeN+LNPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705489630; c=relaxed/simple;
	bh=v5+Ge9DiXT3H7faW4TGcGMHF1mMQuvWjRR+pudvMcxw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding; b=IuFx1YIeWX+PDX7ffVmC4zM7yuM6xZIgqD5pg3H+9TM1a9eLll7kmcBJd4raMjP6+5t8tKyW431d0lDnkoRFO2NBdyOvnbmzaASUb5udh6vgQg1dpQvh6/u1X9gxGTtLQ6FA8gnV4i3TfheYXK1gOZ65mxgTgQYx2B/N333XEtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=TlIFCO74; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-559533e2503so3519421a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 03:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705489626; x=1706094426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R1l13jxklcj6ocWX0a3Ly3/CT9gAZzXpNlWPOErxQaU=;
        b=TlIFCO74r2AeByll2KI82dRtuVwEoUHTju4tK+3oppz3rwIMeWxGTC4N5RysrktAUT
         AmDGLm1QsJ2hN2kcgd8YGA0ubEbl15LgV0BuQ0IFfI0aBLh7GabouvKoWHfCF6MWHGCK
         rJBUxUu3g8oOoWLNVIN/vv46vsZEILp45v4PLjRLuF78uXFaa8Jdq82NsrNSVxhUM6PY
         0if1FpBX05N/PNP2/ZCsSV3RX6vhGI7JSjQOtOFxV55pdlQYWbYJJpAhcUYBEuAEhhcO
         PNXqrX3PVy4r5PldTsshwo7brd/1hT2CXzWchC9D4+eLHrjGQ8wbfMQsGaxxu4k6wWiB
         F78w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705489626; x=1706094426;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1l13jxklcj6ocWX0a3Ly3/CT9gAZzXpNlWPOErxQaU=;
        b=sPbMI3oem7edJU8vsERURGyfOae/jZKJIJOUiLD4JL7yn8TfdTzET4HJxkcRkmB9c7
         T7NFpJXNdq1u6OdeK8Kjjt4c5u/WyKqAt3dTDaPJGZpGlwlJ70FRZq/ADvvGejeYwS+s
         7rkaOSRhRAL9uKd/uOXHz+LpMrWN+E9R8XKhusK8XcIR/WTZXAABtRnZF4Gld0U4mz6N
         NyXwh9IbT+FLROVVFWtwx2VoQjjBXzYfz1dr1WQ35R2Sh6+8uBICmMIR3PWbNXsFF9Lc
         j6apMlZpb9GIqewc7Gt7Dc8GvL/uOM+zgyfJxBc+i9E4SkMIPwQUyt450Hi5GSQrdloD
         usqQ==
X-Gm-Message-State: AOJu0YwKv1Wm5d5HRVegMJGsRdWRju81kEf42luWPy/k5QGfYJOOaFH0
	AbbSAKKbSEa9bTrHy0QrqB0hiVKwHDSXqQ==
X-Google-Smtp-Source: AGHT+IHyhj3tLdPX6jYD2e9zd76aFIsg85FfzeEPeSqtE0OCU9oQgtZuWeWXteRNvrHJEuxKYmE/yw==
X-Received: by 2002:a17:907:7a93:b0:a2d:595:b179 with SMTP id mm19-20020a1709077a9300b00a2d0595b179mr4094371ejc.93.1705489625894;
        Wed, 17 Jan 2024 03:07:05 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709061c5200b00a2ed534f21esm558341ejg.63.2024.01.17.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 03:07:05 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: wsa+renesas@sang-engineering.com,
	ulf.hansson@linaro.org,
	takeshi.saito.xv@renesas.com,
	masaharu.hayakawa.ry@renesas.com,
	yoshihiro.shimoda.uh@renesas.com
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2] mmc: renesas_sdhi: Fix change point of data handling
Date: Wed, 17 Jan 2024 13:06:46 +0200
Message-Id: <20240117110646.1317843-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

On latest kernel revisions it has been noticed (on a RZ/G3S system) that
when booting Linux and root file system is on eMMC, at some point in
the booting process, when the systemd applications are started, the
"mmc0: tuning execution failed: -5" message is displayed on console.
On kernel v6.7-rc5 this is reproducible in 90% of the boots. This was
missing on the same system with kernel v6.5.0-rc1. It was also noticed on
kernel revisions v6.6-rcX on a RZ/G2UL based system but not on the kernel
this fix is based on (v6.7-rc5).

Investigating it on RZ/G3S lead to the conclusion that every time the issue
is reproduced all the probed TAPs are OK. According to datasheet, when this
happens the change point of data need to be considered for tuning.

Previous code considered the change point of data happens when the content
of the SMPCMP register is zero. According to RZ/V2M hardware manual,
chapter "Change Point of the Input Data" (as this is the most clear
description that I've found about change point of the input data and all
RZ hardware manual are similar on this chapter), at the time of tuning,
data is captured by the previous and next TAPs and the result is stored in
the SMPCMP register (previous TAP in bits 22..16, next TAP in bits 7..0).
If there is a mismatch b/w the previous and the next TAPs, it indicates
that there is a change point of the input data.

To comply with this, the code checks if this mismatch is present and
updates the priv->smpcmp mask.

This change has been checked on the devices with the following DTSes by
doing 50 consecutive reboots and checking for the tuning failure message:
- r9a08g045s33-smarc.dts
- r8a7742-iwg21d-q7.dts
- r8a7743-iwg20d-q7.dts
- r8a7744-iwg20d-q7.dts
- r8a7745-iwg22d-sodimm.dts
- r8a77470-iwg23s-sbc.dts
- r8a774a1-hihope-rzg2m-ex.dts
- r8a774b1-hihope-rzg2n-ex.dts
- r8a774c0-ek874.dts
- r8a774e1-hihope-rzg2h-ex.dts
- r9a07g043u11-smarc-rzg2ul.dts
- r9a07g044c2-smarc-rzg2lc.dts
- r9a07g044l2-smarc-rzg2l.dts
- r9a07g054l2-smarc-rzv2l.dts

On r8a774a1-hihope-rzg2m-ex, even though the hardware manual doesn't say
anything special about it in the "Change Point of the Input Data" chapter
or SMPCMP register description, it has been noticed that although all TAPs
probed in the tuning process are OK the SMPCMP is zero. For this updated
the renesas_sdhi_select_tuning() function to use priv->taps in case all
TAPs are OK.

Fixes: 5fb6bf51f6d1 ("mmc: renesas_sdhi: improve TAP selection if all TAPs are good")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- read the SH_MOBILE_SDHI_SCC_SMPCMP register only on success path of
  mmc_send_tuning()

 drivers/mmc/host/renesas_sdhi_core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index c675dec587ef..0090228a5e8f 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -18,6 +18,7 @@
  *
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/iopoll.h>
@@ -312,6 +313,8 @@ static int renesas_sdhi_start_signal_voltage_switch(struct mmc_host *mmc,
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQDOWN	BIT(8)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_REQUP	BIT(24)
 #define SH_MOBILE_SDHI_SCC_SMPCMP_CMD_ERR	(BIT(8) | BIT(24))
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA	GENMASK(23, 16)
+#define SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA	GENMASK(7, 0)
 
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400OSEL	BIT(4)
 #define SH_MOBILE_SDHI_SCC_TMPPORT2_HS400EN	BIT(31)
@@ -641,7 +644,14 @@ static int renesas_sdhi_select_tuning(struct tmio_mmc_host *host)
 	 * identifying the change point of data.
 	 */
 	if (bitmap_full(priv->taps, taps_size)) {
-		bitmap = priv->smpcmp;
+		/*
+		 * On some setups it happens that all TAPS are OK but
+		 * no change point of data. Any tap should be OK for this.
+		 */
+		if (bitmap_empty(priv->smpcmp, taps_size))
+			bitmap = priv->taps;
+		else
+			bitmap = priv->smpcmp;
 		min_tap_row = 1;
 	} else {
 		bitmap = priv->taps;
@@ -706,11 +716,18 @@ static int renesas_sdhi_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		if (mmc_send_tuning(mmc, opcode, &cmd_error) == 0)
 			set_bit(i, priv->taps);
 
-		if (sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP) == 0)
-			set_bit(i, priv->smpcmp);
-
-		if (cmd_error)
+		if (cmd_error) {
 			mmc_send_abort_tuning(mmc, opcode);
+		} else {
+			u32 val, cmpngu_data, cmpngd_data;
+
+			val = sd_scc_read32(host, priv, SH_MOBILE_SDHI_SCC_SMPCMP);
+			cmpngu_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGU_DATA, val);
+			cmpngd_data = FIELD_GET(SH_MOBILE_SDHI_SCC_SMPCMP_CMPNGD_DATA, val);
+
+			if (cmpngu_data != cmpngd_data)
+				set_bit(i, priv->smpcmp);
+		}
 	}
 
 	ret = renesas_sdhi_select_tuning(host);
-- 
2.39.2


