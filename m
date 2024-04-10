Return-Path: <linux-kernel+bounces-138661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3EA89F8CA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EDA1F2E458
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE1180A8A;
	Wed, 10 Apr 2024 13:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="JIll+PFo"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B240C17334A
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756483; cv=none; b=AehCKbKAQgxfT0JkMg/vYc9/Wq8aKPuXxvbXh5RgxX95zwWCW69/ao3bik3e9XTu4C68ePp3W2fHy5Cvuh/DeOyUpIjoEno4tnfw8bkHgmt4P0wgCwoXVJjJ6gKqBPJxT7HdBQG43LUZMVIQM45lbW+qch3s2E44pw9RxZYz77Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756483; c=relaxed/simple;
	bh=xpEy60wLCww6Rzj9qsFI342NwmQkdCt2ZTEg/Fiucao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oXf/anz/LRdlJPl8E5nFBiIab1KY5Ts/NXpy4rW0fqzrW6xfG6oW/Rp8Cs/pOBcF6qiuOp0cFOKyi3tor2OXQBnYW2d86/Oy1crnDRMsl3GG4gCjFNobR2nlYIY3oV5Mazs1URSrQxFHKd1AAl0Ti3FF4Zw37U7yL7GLly4Toic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=JIll+PFo; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-416a208d496so13758845e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756480; x=1713361280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjCAC+2PerafieMHV8RN2guxKuMHo8tOwc6kR6Aqv5E=;
        b=JIll+PFotOkQjwaGFtvMv6Czl14XjVA1lwLSlRnY8OhOBoso+cZoLut4N+d7Eep1my
         mlZu5aHg/2UGh2YdcRN+ST5S8e0L6CSu+mchtq4Vxzy3huraJX7/Vl3GUmLQKs5cMu18
         xPlmFNcQM1f7vfw5fEixArMySyLF1EUKz1Hu+mHzwH6ys2oYPcZa/yWgTKC8JMxglrdx
         iXoCzBAUACAtMCzlP1Y91fFRA1vOn157rqYfYGQCBeHab6PP8pT+eQq6lTvSKcI9XoJT
         6i7323tKi68kd6aV+Vv+TdaooSYZixRVieoHQvmNcAQU83O0ARr9VmrK11DZ8SCrFeay
         W+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756480; x=1713361280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjCAC+2PerafieMHV8RN2guxKuMHo8tOwc6kR6Aqv5E=;
        b=cEdq4JQ2m3MS8zomi9VyR1jPGxSN5gsQLijigKtWFLWcjGvizqNkTi9hjwxJCEaAsd
         k/j42ingn4sGW0X+CMCeTLWwp7uiV3zfPjCnXjSQrPsF4NhGdKXqhPzSP5HCD3y7bADW
         J287dYv288vhTsMTexTU2rmICWztrrqGaKRkpUuZ04+I5f19wr5eqjKH4DF3ZGp0Wd97
         TFOx3kOZfvsOrlJxJKo2XaGQTqexX5nfKH6UydffU8BDA+s7J8fzeNIVjbmo+MyK0ASk
         JeCtI3nPA0q122r7cZfGg6kJjdoExkEqJmM61pbR97OFINRKrc2ZeDpKwlgRLwbWV9dV
         xKvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXTYMLv009PEG+DJLwLlX8YeATrUAnHPMwDafl78Zk0zQ7jPQKIoTshaPew0YKsj3EjojCYvdP/7ytZx9PTXHEkxNyvOLtcswZPtA4r
X-Gm-Message-State: AOJu0YysZRbdJZmLmm9MMi7BQ/XJUwCVmmyTL+05iIKC+Dr7fVMIboq2
	iaz8nmEnnYD7IesimQK71LUi6XKki3peG5BYJWlS6RF2U9SsapXVguahoKGaMcs=
X-Google-Smtp-Source: AGHT+IEFj8V+GjPPGimKfeXFxBrabqAeiLAm4xEJjfKHrlCzLWu0SvFIk2Dhlg1MICOPvwFyYzbskQ==
X-Received: by 2002:a05:600c:1c95:b0:416:9b8f:1e5d with SMTP id k21-20020a05600c1c9500b004169b8f1e5dmr2226160wms.35.1712756480162;
        Wed, 10 Apr 2024 06:41:20 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:19 -0700 (PDT)
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
Subject: [PATCH RESEND v8 08/10] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Wed, 10 Apr 2024 16:40:42 +0300
Message-Id: <20240410134044.2138310-9-claudiu.beznea.uj@bp.renesas.com>
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

The RZ/G3S supports deep sleep states where power to most of the IP blocks
is cut off. To ensure proper working of the watchdog when resuming from
such states, the suspend function is stopping the watchdog and the resume
function is starting it. There is no need to configure the watchdog
in case the watchdog was stopped prior to starting suspend.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none

Changes in v7:
- none

Changes in v6:
- none

Changes in v5:
- none

Changes in v4:
- none

Changes in v3:
- none

Changes in v2:
- remove the usage of pm_ptr()


 drivers/watchdog/rzg2l_wdt.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 42f1d5d6f07e..c8c20cfb97a3 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -284,6 +284,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 	priv->wdev.timeout = WDT_DEFAULT_TIMEOUT;
 
 	watchdog_set_drvdata(&priv->wdev, priv);
+	dev_set_drvdata(dev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
 	if (ret)
 		return ret;
@@ -305,10 +306,35 @@ static const struct of_device_id rzg2l_wdt_ids[] = {
 };
 MODULE_DEVICE_TABLE(of, rzg2l_wdt_ids);
 
+static int rzg2l_wdt_suspend_late(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_stop(&priv->wdev);
+}
+
+static int rzg2l_wdt_resume_early(struct device *dev)
+{
+	struct rzg2l_wdt_priv *priv = dev_get_drvdata(dev);
+
+	if (!watchdog_active(&priv->wdev))
+		return 0;
+
+	return rzg2l_wdt_start(&priv->wdev);
+}
+
+static const struct dev_pm_ops rzg2l_wdt_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(rzg2l_wdt_suspend_late, rzg2l_wdt_resume_early)
+};
+
 static struct platform_driver rzg2l_wdt_driver = {
 	.driver = {
 		.name = "rzg2l_wdt",
 		.of_match_table = rzg2l_wdt_ids,
+		.pm = &rzg2l_wdt_pm_ops,
 	},
 	.probe = rzg2l_wdt_probe,
 };
-- 
2.39.2


