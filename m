Return-Path: <linux-kernel+bounces-57935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 189DD84DF37
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DA801C285D1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D4BD77F0A;
	Thu,  8 Feb 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="jMq/2/HU"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99A276C72
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389914; cv=none; b=YgjMFqOX6H+ugLlaAkTGkhpMzeykDaq1MG26X7Ik4S4xfgpboJ6Es3v9fxuXtTaxqCKelTa6cx2Ug8qMbLmqxNhyGGIjIcxC22LXV95gN+NJubKzsNvqi5aziHAyTZcYssd2f2ovccWYQB5QuS2qOntF3+dAkNhPefu4zazFJSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389914; c=relaxed/simple;
	bh=HWCgsvNxvi1PMhDIDSuY5uijn2Hf6js/uFGwKOmMrQw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XEv8mFQObBFKt5sZIIhEPLzAm4er5M6EyOprSZvjSHOCNSc9EqlyujuE2T13nI6TNFxBzbD8cof2ciNaj6amqfGxKKTpqIju4sCVZzY/P6/ktvC7EG2lc8KFHheSuawN+xmsVW7/Dm/m0vW07y4/VhCL8fePXUy/x/sadj3/Ab0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=jMq/2/HU; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33b535c5d0fso727343f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707389911; x=1707994711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XPKcYnU4ipEIHzD42MIlmmNdH1yPY1cJ1iEVmcEoD4=;
        b=jMq/2/HUHSOeqOwi9e1qU1ca0WNcLws8fAHxVOVIjS0z+PHWkJ0LsBY6mV5D6nkj0i
         EXN7AJ1JaXUdxe8FAg24pft+H/mv2dQviLhp1mhD1AJMgcLwWdRkP+gt9KZCD97z02s8
         qRhbvwdAoUl9c6bMjz3Iuj4/EJrWCgW++p6OPSx8qkk/aIHjqNAK7MHb+PNvx5Qptkr2
         PnwyUGNVotPv6hgZEddz9B2oEQLp3gbivHhxr2XK1JYluxre/FvEFvKkSbVcVn5vh4Pf
         qdkOJUM7jC1P5mt/w6+mjbdY8VyEBIDVmjNrtxycXy98+BDR9At4DEMEJbASZdZ59px6
         BErw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389911; x=1707994711;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XPKcYnU4ipEIHzD42MIlmmNdH1yPY1cJ1iEVmcEoD4=;
        b=Q7XLalT2Nv3V+rI7ATgYoV0nD8GZtv3DTb0oU4QTs5jN7DEZlzG7kqa9TQS5Pdr7zU
         O2xzu3rscWDHdHEbwm+bX6fPibc8A9O6lUA42LogNQ+w8KN7uVmH4RzPzk+BP0cGyJq5
         gj3vWWjmoHW58y6OXvMP7aVEBVR73otuQ5yvFFZsczALl9HzEShKXD2dGDgDySxe5kJd
         u8BXWIXRQCmrfOcZr9VyHA0BMuh4u9tcCaj4dDd1tod4UQjM7NzFWED/iFV9DbZ5MX6D
         0RJ5t37Uj1unDQVHoZAo9H2NxkjstkO4rCdBKCO5dRdavhc6z8x8PmbGSCjwccMJlj7l
         GR/g==
X-Gm-Message-State: AOJu0YwYPOz1fpLE7NA1oY8NLscmT+wsnVrRzVdf2rq0E3dIPR9YXu6Y
	zLvgmQ7cZHB9TMB2AqY1px4/2ooY0OEtSpMBc1dClu5fMAYAV+/L2h5132DloOU=
X-Google-Smtp-Source: AGHT+IF1wZXRiI2LHu3Y3JZPvQhQyKiI/56rFEURHWHM6WvnZtkebTvut1a1CED7eVtjmEpxZ4/NPQ==
X-Received: by 2002:a5d:5912:0:b0:33b:295f:4e6 with SMTP id v18-20020a5d5912000000b0033b295f04e6mr5181533wrd.55.1707389911031;
        Thu, 08 Feb 2024 02:58:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWzF1irxcQBWAeQVyAG3xK5FeGJU0UfLCI9SBof7h1aQis2QOsMD8syUi1D1z7iNgR/AATdRT3Tga8cnQSyhgQrRA69/gsseD/RD8fX3xrh3Iy/3cME7zYaTQtHvBvUyJ0+NNhdB6pOdX2Z1qVCF1v2o/3Bm3VVl20G7yr3JlaqtYcjKMPYzcziu3UUAPWl+1nYIAgxHGMitrre0Pxlavm37gPrLRqdFWg4yFAtK7j8HUgPHj0ro78QySZRWQEjXnau79kzWYu05enKPYSKGttyZMKvXG0Lf+PHfcGEYpDjh3VMZwEBWuDIHFO0yYBMmk61CyDiNillYahw7B9S02KSK8RYjTY9RyCED3uwUykNAXUis2OQ/yE9kPxtgR1dKYmoGvFEmzFN/dzznYjQGR61dDdw8olPgeYJdnKP94UUIyfoV9Dq5Qt7C2KoMfgbE+SQtiSn2DGqu8aQnqDvLRrXzDBWIAMIMZU97RrZCxVEGJSCbclbDiYjOw74eIeMG90jM3yK5rAT4g==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.45])
        by smtp.gmail.com with ESMTPSA id a6-20020adffac6000000b0033b4a52bfbfsm3344153wrs.57.2024.02.08.02.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:58:30 -0800 (PST)
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
Subject: [PATCH v6 5/9] watchdog: rzg2l_wdt: Remove reset de-assert from probe
Date: Thu,  8 Feb 2024 12:58:13 +0200
Message-Id: <20240208105817.2619703-6-claudiu.beznea.uj@bp.renesas.com>
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

There is no need to de-assert the reset signal on probe as the watchdog
is not used prior executing start. Also, the clocks are not enabled in
probe (pm_runtime_enable() doesn't do that), thus this is another indicator
that the watchdog wasn't used previously like this. Instead, keep the
watchdog hardware in its previous state at probe (by default it is in
reset state), enable it when it is started and move it to reset state
when it is stopped. This saves some extra power when the watchdog is
unused.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v6:
- none

Changes in v5:
- update patch title

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- none

 drivers/watchdog/rzg2l_wdt.c | 26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 7bce093316c4..93a49fd0c7aa 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -129,6 +129,10 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 	if (ret)
 		return ret;
 
+	ret = reset_control_deassert(priv->rstc);
+	if (ret)
+		return ret;
+
 	/* Initialize time out */
 	rzg2l_wdt_init_timeout(wdev);
 
@@ -146,7 +150,9 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	int ret;
 
-	rzg2l_wdt_reset(priv);
+	ret = reset_control_assert(priv->rstc);
+	if (ret)
+		return ret;
 
 	ret = pm_runtime_put(wdev->parent);
 	if (ret < 0)
@@ -186,6 +192,12 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	clk_prepare_enable(priv->osc_clk);
 
 	if (priv->devtype == WDT_RZG2L) {
+		int ret;
+
+		ret = reset_control_deassert(priv->rstc);
+		if (ret)
+			return ret;
+
 		/* Generate Reset (WDTRSTB) Signal on parity error */
 		rzg2l_wdt_write(priv, 0, PECR);
 
@@ -236,13 +248,11 @@ static const struct watchdog_ops rzg2l_wdt_ops = {
 	.restart = rzg2l_wdt_restart,
 };
 
-static void rzg2l_wdt_reset_assert_pm_disable(void *data)
+static void rzg2l_wdt_pm_disable(void *data)
 {
 	struct watchdog_device *wdev = data;
-	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 
 	pm_runtime_disable(wdev->parent);
-	reset_control_assert(priv->rstc);
 }
 
 static int rzg2l_wdt_probe(struct platform_device *pdev)
@@ -285,10 +295,6 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, PTR_ERR(priv->rstc),
 				     "failed to get cpg reset");
 
-	ret = reset_control_deassert(priv->rstc);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to deassert");
-
 	priv->devtype = (uintptr_t)of_device_get_match_data(dev);
 
 	if (priv->devtype == WDT_RZV2M) {
@@ -309,9 +315,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rzg2l_wdt_reset_assert_pm_disable,
-				       &priv->wdev);
+	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.2


