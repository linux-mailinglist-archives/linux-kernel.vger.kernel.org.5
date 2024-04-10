Return-Path: <linux-kernel+bounces-138656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACD189F8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9D96B2D20D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB67F171642;
	Wed, 10 Apr 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="nlDRevBp"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51816F26E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756476; cv=none; b=T8qJNxVOdjcKHwoPwsqnW9Jd+I15i9mrLGSjIHsluHS0e/3hMdoOKxLYlOSGoboQ/LDbD06R2x07YPuOM3pM4n7liO+rz1zcssUGdlSX3mRp44fEeiFVeXKs0vN+eqmFNSJuBMBVfVYdQhHBMM/9EjTVUfmLSFJSonC5Er8z9qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756476; c=relaxed/simple;
	bh=7mOWThEj82No40O+j4Gsb3EPCVrROElgn/WJZB/tenc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lukqxGoVozIoi+smSNKenoDjc2poL4Yp9AcDnFhiIjks4dfh/q8DgtkYnZC75RSMsbl1CDeylbWbXbimvfdEsQH3vhDhbXAGGoy/H1qyeLO04dPhpfgtsr0ebSPCpUgqdvfC4hn+W4WVFhSYnImKFmJw/fzGE+JLk5TXuw73lGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=nlDRevBp; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d8129797fcso91567671fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756473; x=1713361273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndAfnruplO82J5rjSW4lZ2fxdaHakj0g3zjVmUjCmY8=;
        b=nlDRevBpG+M5hSfzdDl4xJXtJhw+R1UURSSLubtOoMRuQ5dKguPE9CtyUG/64dZbjO
         dtO+DpPxmntw0pJ6MfZ2obr1tFP4mCaY+GSxwiVhhyjajDbhIfJJqp5m/QBQnJhqT/Nk
         +bk7pSkJojyLYes+n59M8NkfxLAB6IoOCSgRZ42iaJuh6CMM0LBHgOzL6Ysq8YKMcwpY
         0dQtHSU52RW9cacN5uxnAy/WclQZNCk+TTOByQPIHIVEW7fEI2Un0G8jvI8ptN3Wn0N1
         1YGg7iinYUkvpI7pC9/suAiOLgqwnpqOrjXla/c35ki0zxZ07CGS5OT9H6tKTj1mrwn8
         T5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756473; x=1713361273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndAfnruplO82J5rjSW4lZ2fxdaHakj0g3zjVmUjCmY8=;
        b=jh7Z2C38e5ugj0smVbIxLsfFZt5EYhhZm79c/KAg7E/CEbpOxJOOCUH+YyvO49TJAa
         Ns2+JUMslAdPmX7qGje1kgh1F8UsLnHbuPR5MtjFT4FBLBYkpp4qyamPTTX9bIuY4IBm
         /dBFZPV+xCnWxXrWoWcmBGAJxA0UHfjgOadMHbKSksSQcXIWZZ2SwtkGU3Tqitp4OMPD
         LypaPU58papCL0v6BqfGJ3kGtCWhzeUyrHQSuWeo7Q2RJ8GIpteKMh6qnNijMkKMbW9V
         BsjPoVz8SYIbDGmMjwqDSgRKrzd6+HL6ppE965+xpdF1fmEEi3K3kUDFsKmWALVfR7NU
         OE6w==
X-Forwarded-Encrypted: i=1; AJvYcCXMZjp+4Ns769CPFdvlheW8mypKUiI45z1W7t2hxxYxC1GvPFKS5vta8f9XDysfofgO5FIS0HDR/OY91yqZFuUvlqXrUOkOnYY4Rv6r
X-Gm-Message-State: AOJu0YzNwzVQcFYWn8dglcYH/7Gs9FcQaKL6tIIqcGEVzejrp5IkE4tU
	vpwQreX9vYjqXAkowWip7tOZ8JpmcLR+V0N2WKPNhAh6tYrOCGH3fj/alzrTTZk=
X-Google-Smtp-Source: AGHT+IHBch3z46eIpwIMrlag3ucoQRtxLPxfE5oWrDfrZwGW8hkURhoSdNwL3iOwO/2g13RlmD+IZA==
X-Received: by 2002:a2e:7c0c:0:b0:2d8:52b2:2002 with SMTP id x12-20020a2e7c0c000000b002d852b22002mr2025805ljc.47.1712756473412;
        Wed, 10 Apr 2024 06:41:13 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:12 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh@kernel.org,
	krzk+dt@kernel.org,
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
Subject: [PATCH RESEND v8 05/10] watchdog: rzg2l_wdt: Remove reset de-assert from probe
Date: Wed, 10 Apr 2024 16:40:39 +0300
Message-Id: <20240410134044.2138310-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
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

Changes in v8:
- none

Changes in v7:
- none

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


