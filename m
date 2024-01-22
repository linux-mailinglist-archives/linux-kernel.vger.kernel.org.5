Return-Path: <linux-kernel+bounces-32879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 524718361AC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8847CB284D7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF4A3FB04;
	Mon, 22 Jan 2024 11:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="UdjYkt5M"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565523F8F6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921911; cv=none; b=mbFyib6sIm9ct26y0/2VJdneK16IhNbrJki74GXLLW1whQ4nQdnbQPHNfEX/yvtNmrU0yrXF/PAIxDUEd4PwfvjnMCgqOjOR374+NzzrBWY19KKaU5Ns5+nrs5IoTc9ZOAyfdC3Ot+GH4pVyVBOGaljvWScI3Pxv5ymxUnsMdmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921911; c=relaxed/simple;
	bh=xaqBRK9EGIdJH9HHkMygHgD7aoVyRCxVtV2V46YhORc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZVamwM8bPoD9nWQ94ZP4Auj8aCwQLyq/1jf72Dst3wVovLQ/O0xtXuddqnUSF2VIXtIDf8eQlB35TPC7tCUSX1k5fEq9t/Ccua7D95JGMqI1W3aNoc1WotVg3iEOt1lLPwiTiKRBSt0lvwnyCgLNiSDy52840Jr/I0m+f75eghc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=UdjYkt5M; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a349cf29cso3366331a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1705921908; x=1706526708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TwcmiOqVIksAk67lqc9iZZkd3iM6L9ti8qSBC2scoWY=;
        b=UdjYkt5M5lRogzDrBHM88nRIj1jtzb+6EuRlt09+nklvcvhUDwqTObm71o5Qj1yGmI
         g9WszGakcpYoHgDZ7CoYKfkk+W3AmlzAiNTLVXNhS2fuLM5Cd/l5xUJIDAgWeQRVXvNE
         d77XXPftKJhh+olvjz95dk8Fw1OnyZVQXcernXS47wTDNwTcvG1BHoPNaBlABAkWYuhO
         tX7hRT4bxFvCQnnd+uGTT9cxGSceEIjr1ZJpwtLzZe+knSHM/5WIr//MvQ/ozVAlBmw7
         2T2OmrRa5NueYZG+yl5xvL/S8kq6zMd1dTsTyN5DbRg0Yh7KFXTgbkAK0TIxV+ae1p04
         2YWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705921908; x=1706526708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TwcmiOqVIksAk67lqc9iZZkd3iM6L9ti8qSBC2scoWY=;
        b=kLmyzID/ajXNWnhLKCXlhzZPwzuJDZPk2tuUuTfxyvxwGXY1Sc3Uln83x6NitvUHaV
         FEDKYj5GGPFvt3+HCFIOKYLAdeK1kShnorS9m5BWgOsdm+o1DUHI9DVcofT24HCFuD6q
         6PcsEG/Qihn5Z9mRb1z9VMqsz+9cHWDV7e+LjlLc/zU77tql7+XF738lh9MjYycOh1fS
         QXZssxcMgRBps680ab/i3u1+3EDZ6HzZQ5TTtTV5CACgs64yLX8hE/Ho6MxeXK60zNxQ
         aNTzqvteABGjgQSmkyvdcTFkl3oTySRILrCkVx0C+5jwEbNU4leUDfIAh/u4eadfkoij
         rjaw==
X-Gm-Message-State: AOJu0YyYktEnne3OIWn7/4nX9Ayw/b4RjUxzW1RP9KSdMDue7cHVErQ3
	J8JJpvN/1IMRLNXyZtVeVdaZtcfCByCx5HTFpUFJ0ACUtP2qTIG8rUTfyMfpe+w=
X-Google-Smtp-Source: AGHT+IGIabCWO88Pu8kLqsy9OECGdMHiSHXOfkdsobiN5qTeWf5eV/ONXAgZO6Grfcpvrb83g6mNKA==
X-Received: by 2002:a05:6402:12d6:b0:55a:2e1f:17e8 with SMTP id k22-20020a05640212d600b0055a2e1f17e8mr2064367edx.49.1705921908663;
        Mon, 22 Jan 2024 03:11:48 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.135])
        by smtp.gmail.com with ESMTPSA id t34-20020a056402242200b0055823c2ae17sm14194241eda.64.2024.01.22.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:11:48 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 06/10] watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
Date: Mon, 22 Jan 2024 13:11:11 +0200
Message-Id: <20240122111115.2861835-7-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240122111115.2861835-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The reset driver has been adapted in commit da235d2fac21
("clk: renesas: rzg2l: Check reset monitor registers") to check the reset
monitor bits before declaring reset asserts/de-asserts as
successful/failure operations. With that, there is no need to keep the
reset workaround for RZ/V2M in place in the watchdog driver.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 drivers/watchdog/rzg2l_wdt.c | 39 ++++--------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 38607673e1a5..9333dc1a75ab 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -8,7 +8,6 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/io.h>
-#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -54,35 +53,11 @@ struct rzg2l_wdt_priv {
 	struct reset_control *rstc;
 	unsigned long osc_clk_rate;
 	unsigned long delay;
-	unsigned long minimum_assertion_period;
 	struct clk *pclk;
 	struct clk *osc_clk;
 	enum rz_wdt_type devtype;
 };
 
-static int rzg2l_wdt_reset(struct rzg2l_wdt_priv *priv)
-{
-	int err, status;
-
-	if (priv->devtype == WDT_RZV2M) {
-		/* WDT needs TYPE-B reset control */
-		err = reset_control_assert(priv->rstc);
-		if (err)
-			return err;
-		ndelay(priv->minimum_assertion_period);
-		err = reset_control_deassert(priv->rstc);
-		if (err)
-			return err;
-		err = read_poll_timeout(reset_control_status, status,
-					status != 1, 0, 1000, false,
-					priv->rstc);
-	} else {
-		err = reset_control_reset(priv->rstc);
-	}
-
-	return err;
-}
-
 static void rzg2l_wdt_wait_delay(struct rzg2l_wdt_priv *priv)
 {
 	/* delay timer when change the setting register */
@@ -182,13 +157,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 			     unsigned long action, void *data)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	clk_prepare_enable(priv->pclk);
 	clk_prepare_enable(priv->osc_clk);
 
 	if (priv->devtype == WDT_RZG2L) {
-		int ret;
-
 		ret = reset_control_deassert(priv->rstc);
 		if (ret)
 			return ret;
@@ -200,7 +174,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
-		rzg2l_wdt_reset(priv);
+		ret = reset_control_reset(priv->rstc);
+		if (ret)
+			return ret;
 
 		wdev->timeout = 0;
 
@@ -292,13 +268,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
-	if (priv->devtype == WDT_RZV2M) {
-		priv->minimum_assertion_period = RZV2M_A_NSEC +
-			3 * F2CYCLE_NSEC(pclk_rate) + 5 *
-			max(F2CYCLE_NSEC(priv->osc_clk_rate),
-			    F2CYCLE_NSEC(pclk_rate));
-	}
-
 	pm_runtime_enable(&pdev->dev);
 
 	priv->wdev.info = &rzg2l_wdt_ident;
-- 
2.39.2


