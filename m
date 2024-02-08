Return-Path: <linux-kernel+bounces-57937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FF184DF40
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DD5D1C28A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8AF7A713;
	Thu,  8 Feb 2024 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RaRK7Y5/"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894627869D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389919; cv=none; b=VXKEaYkT9X8tC/bWaEZyEZ4yyHOvpfeAapIsM6C9QbNESKgQrwIlSi4w2caiw9/HnjAvlAa+IjtrC10limGyqbpYvqLtxrQmk7XY1+xfTms1LMS5WO0zGflF8AXs5TJv6tDIbhXSlQLqqdfn62l4jWVDFfi4+PSTqIMGF/MhPFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389919; c=relaxed/simple;
	bh=MXG1y8PfM5IXzSZkb/NwZc6HuMvBHL04QNzISCsR8ak=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LY9V0lXerIiYcbP4LijNaIv42OuEnFt1XOtvfNVCS5/710phvb1zJ10eEG/P6bnEg4pPLOAbi42EFHIXo3/DXdlORQXNo3jgk7SUI5IZJU/xraRB8CQ/Ij1UysItTiY0KwQh809qPKWynYEWPunseWetZ4+o/7Y68O9LSdRy8Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RaRK7Y5/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33b2960ff60so410265f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707389915; x=1707994715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ImoQ02P0Si8qV/A28I2lyqywOWzgxBkR3jS/ih8KYo=;
        b=RaRK7Y5/YmSGbP+97NunLzKgkiHPSR+ar3obtcSqtPvJhT5eR+V40uyb99kYYkkHm4
         b1LaNAsgXVKgpBg1JKVO7L2f4sAAFJ275PYH3HTbEnUig+JV5FisRUjT+9wWyhwt7KF9
         QYujZlHlrmn2B4G1/VrdcvvF3BSlSdH/55D3e9jyMtO46DjpYNLgWrB3A9rZD2dSDesK
         ETCT+KqBW3MogqV6GfvwlxF72AmXiv0ZrBGBhNgWQeid4GJXcTm5dDRbTd+vEPQGDHw+
         PFI/3MOY3Y1cvwC4eY1X9UWOIPanRd7UP0Q6HVIZ5XKzMFXvrf74x/xXq0CRTnxRMsUc
         +FiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389915; x=1707994715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ImoQ02P0Si8qV/A28I2lyqywOWzgxBkR3jS/ih8KYo=;
        b=sO2QbHh41FWelU8X1CcPI0+pJE/3iaE7g7emXVjUQDGX4xvQdQm63pkr9/Nt2j19xn
         QkQUsq4J0FbtyKEcHb6EqZIiCZtpDqA91e42levxrBcJzt4bF3SsSPe1glipaQXlTgw4
         tqDdIMBgm+vL+G2KsZ0WS3vPDse5nfxZEvrPQ5DdfoW6O1JT1HEKjD9vzF5GqFOIRWDG
         BN/D15GAVksUvxYj/8jyVXkW8aJmpAFLxu76nIROFfgcTtlUZnYypSYRYXyb6Oq4gICc
         xsyuloxP2sC6MRHMt200k69d8N4SphC8qC63kqAISi5nav4d1ols9kEi+gLoNsKkF2AD
         URpA==
X-Forwarded-Encrypted: i=1; AJvYcCUXsJTVeIVd9adGwN2qHS218AW1oYj2ZeDV7VIQ2zCtQVWcE/pPbrQk6fLWRZY/DizCb3SptZGycmAzZycXuECtTVg39c53nPgAYE8q
X-Gm-Message-State: AOJu0YxezlVLtsp0iCzMYauBiNB9YSAdZ8IfpkEC6XaFB2Y+pveTdVJw
	IJWErcDw0xSmT4UcWOjMUg9NNoTeX9W1kahxETB3pF80RNqrEhOydtQ63er3CWI=
X-Google-Smtp-Source: AGHT+IEK1MF1/8hHsbMU13XizYDSH9I2mgQstC7me03pDcwbFlU+oScQ3D9IlvlmfhmijIxoR1IQ0g==
X-Received: by 2002:adf:ce88:0:b0:33b:58e1:d281 with SMTP id r8-20020adfce88000000b0033b58e1d281mr1081502wrn.32.1707389914893;
        Thu, 08 Feb 2024 02:58:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVwm68MRi6LNIQPvqHGwzlyGaD1JahBgHFCGWgmNkqsoImd+jOjc2WzQRwgu+ItcZ+Yy31ESVGz3jf2dY+2wsG+DQTCRJDgI1O5QBwdHfysC3m0b5389D2gUexfgzsI90x5MO6CfubnIf0yOjr2r+cSRTv0KTL7LS4FYpA5lVLTLae+DiwI8QyqLr3G/7vo3xoI4S+m6XWNw+H6T8GEAMYRJ+42rHG+9dcotI1koo8m6VAqiaQFVVv/fP+jVkR/XQ8N9J6N3LOrgWjlaRk+2NOiul7w/TorTy/uwvmkNO/zVeLZqHy71A6/G25YNuktvqb7iRy9L45+p+ZGUEP6GCnKO2mtaAHS0rqC9E3b+b2loCxPs8lK1VxvlEtanmXgDykDxH7NsJyRel91Ty4fLfWG72JsxnUT7R63qTdKyoGBUAwJoEEz0qBLwJV/RghwIkKPue5RRflRXRyM6HVXxxdXyPYwlKgXt4NA4LfwlbSTmukENzpLkZKedgYRuKFHFjMOJgHyYMwNQ==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id a6-20020adffac6000000b0033b4a52bfbfsm3344153wrs.57.2024.02.08.02.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:58:34 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v6 7/9] watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
Date: Thu,  8 Feb 2024 12:58:15 +0200
Message-Id: <20240208105817.2619703-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240208105817.2619703-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240208105817.2619703-1-claudiu.beznea.uj@bp.renesas.com>
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
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
---

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- collected tag

Changes in v3:
- none

Changes in v2:
- none

 drivers/watchdog/rzg2l_wdt.c | 39 ++++--------------------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 29eb47bcf984..42f1d5d6f07e 100644
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
@@ -187,13 +162,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
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
@@ -205,7 +179,9 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 		rzg2l_wdt_write(priv, PEEN_FORCE, PEEN);
 	} else {
 		/* RZ/V2M doesn't have parity error registers */
-		rzg2l_wdt_reset(priv);
+		ret = reset_control_reset(priv->rstc);
+		if (ret)
+			return ret;
 
 		wdev->timeout = 0;
 
@@ -297,13 +273,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
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


