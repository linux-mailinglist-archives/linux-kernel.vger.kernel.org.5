Return-Path: <linux-kernel+bounces-84681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AF86AA0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF8A6289A21
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF0736AFF;
	Wed, 28 Feb 2024 08:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="j4kAJdY4"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2569833CC2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109204; cv=none; b=UDTWue9WAvSOKIIjDxZkCH4wxzihJE1PSojTAFJ43aIl+SEn9cEGjV3JAfPSPUoxID+nFArzeIioMKQ3ickDL7Oo6NHYPwqaJsIdZ/VqgqvcD3J/bUDa9MBqtmZwlU/FZtO5FMFSzfQ4IeNQYXWz8/IPDtEGbe8EiWASjrVvO34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109204; c=relaxed/simple;
	bh=7mOWThEj82No40O+j4Gsb3EPCVrROElgn/WJZB/tenc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aK2p6tCv9kSfMYoEsC6mWIq0e4WAk3mrUrQ3yYwdklqmaWFSrxz/xtDpI94nuQzSeyeBJpQ/0pdfswrm7oZh3Z4/pVNgHWnea/bpY3r2LZGjGbbH4uvTByM1dNgRggHTpRlCheVKrEnU9s3E9XBy8cmA/I969TNSkAI5b7OzKi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=j4kAJdY4; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e552eff09so572223166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709109201; x=1709714001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ndAfnruplO82J5rjSW4lZ2fxdaHakj0g3zjVmUjCmY8=;
        b=j4kAJdY4AjOkaeG95g3U/zInfUz8gFGvpYwA30ZdtRD5VVkh9oF7I2ujI6nQqYS8pi
         +FmMrzW1kSkibMEFtw/ys6GcZASiQhHLBclBK3itjZ+aGd8MM70V1refXFtmFr25cnWF
         aqrDCstybUCcBdEL8kPyaWbysG+IeIvg9zXVpgDeoFDvvoJtLah2403sFjN3WtrC/L6a
         MkHj0bGzgxPhqOZsi10mL++3ZsSFzDYoJ26kDZBe7kLJ5LkR/I+23KitUu26c/pWX/gH
         su9groFdkSAe0Xwj3Vh/taUuFRaZsTm5kn6H9SBlbDvpM5Y8a4O2mPaRmfF4FNES03g8
         wHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109201; x=1709714001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ndAfnruplO82J5rjSW4lZ2fxdaHakj0g3zjVmUjCmY8=;
        b=bWcaMhqkmNDUGm6BfCBMnat4YKVUMc/DJzRnNpP9viHRpnagDPEbJ4+7SDoJnGzva/
         SEELMmKcc6OGP9I1VZtbQU898F229J+kKiLDQJtxlwX2s3qZUL+qayLjSCBAzLCCrshJ
         Auw9WiUriHvVtxjfjaVw58QAjgDntGrILZLZxNZ+uuhegPLRBJen4+yLV/mlqYxUHSNo
         fiRP0u42fIvjb5Lbrm38FQGoU8UfIM024dTMGV2BL1zc4PdJgE3bvigFRb5pBT00EF0I
         mky/tE/c9RehVdhZjeWCkF6yPS01eHp/pD69Dqo3V3He+qm1xKFHAuTqAYut7LUPm6rq
         gVLA==
X-Forwarded-Encrypted: i=1; AJvYcCWnADv7K40L0qf7FH24e+LpPg7WstrsUzmYUKCc0/ghYhcfTvgbiVeY9jMOaf3KrokLq3d3rwjkvDiHMTc1XeZTZC4JwSDSJVt6K8c/
X-Gm-Message-State: AOJu0YwiQAJnaAkNhWbw08wh1gV+48S7ER6XemR5c68vWgJnGiMXgx+3
	SfS4iW2pgZnpK01ETsnrP/dfBjTA7g9CTRcV/KF435fkwnkUhjTYvo6D09+Whe8=
X-Google-Smtp-Source: AGHT+IGBYc9/H6gBjxqY7ROH5qdMiC1eXeqvO1B5E2LbdTz7U+qfIjqdBkvvWX0RZuVokkHb5gmabQ==
X-Received: by 2002:a17:906:f9d4:b0:a43:4c31:c4f1 with SMTP id lj20-20020a170906f9d400b00a434c31c4f1mr5491767ejb.11.1709109201694;
        Wed, 28 Feb 2024 00:33:21 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id qh16-20020a170906ecb000b00a432777eb77sm1593987ejb.60.2024.02.28.00.33.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:33:21 -0800 (PST)
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
Subject: [PATCH v8 05/10] watchdog: rzg2l_wdt: Remove reset de-assert from probe
Date: Wed, 28 Feb 2024 10:32:48 +0200
Message-Id: <20240228083253.2640997-6-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240228083253.2640997-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240228083253.2640997-1-claudiu.beznea.uj@bp.renesas.com>
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


