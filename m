Return-Path: <linux-kernel+bounces-84684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868FC86AA1C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:35:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C312844AF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9022E85D;
	Wed, 28 Feb 2024 08:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Tc6OO+fU"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A54374EA
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709109209; cv=none; b=P7NbFefbsnmjCvARffsKnObbOu/c4K4Dww5bscJg+vbRmHfWuxZPON5Uwd7U7OcxIcCTlBedz28b24LoJEB4hoWAcwQce074l6D8SV+lAfl5aut5LJQV+ayX2R7s+w+bvHmzdSBHMARwbLPGDgmxp2rcPKa5hO3pNMaOsXinMNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709109209; c=relaxed/simple;
	bh=xpEy60wLCww6Rzj9qsFI342NwmQkdCt2ZTEg/Fiucao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mZ2Zf6yn2JDKH7xDLSdeYdoYs9+dygQs44GejsCQ4EqsW+kO7/0ubbkyPzHJBO7K1Fx5jdl6XGtCnoMe3aPVvTKy+4d3XbKXVzo71YvD4KpHVT3iGXsOaH3D6xK6oehEjAr+hKWA0brMt0Aw5wuUxD6X2WxNEUL4HGXTqZlIAYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Tc6OO+fU; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3d5e77cfbeso109069966b.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 00:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1709109206; x=1709714006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjCAC+2PerafieMHV8RN2guxKuMHo8tOwc6kR6Aqv5E=;
        b=Tc6OO+fUTOKmKwLJsUx13q2P9pAcQaEPdAnUsBsvfA6iC5HsVbxYFtIR3J9E4lgq7l
         yHGuSDXfqG8UiKZOVAKbErSDtjicSmbukP7g+iR5vOvHYSVr6B7UHZZvJ8lPfBnzY6L8
         o0tnPe/sCrvmAu/QpxZA1An3KX/Z+t6gPP87yDVnx+GYJyN3XIeSEzflXmr9hEl6jOU/
         rNz54GIniDUtKlaNzDuqXDMRAwyIZG6c0ItWa/DRFeGwmwnCKYhELwnjy9CPGTGt7bv7
         NgN7ygBjzS1ZXRWx09xssZ2X1n+SwArysj61yPO5k86dJ4nD13IVMW+Q/eL8cG2wgJKV
         a5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709109206; x=1709714006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GjCAC+2PerafieMHV8RN2guxKuMHo8tOwc6kR6Aqv5E=;
        b=HFwXlrlTnTyRXJEgRFB6f2GrGh4aXpndx6pZ52Up6DlzlMUbscG3p2NTJe7IaM/z0V
         XnXdTPtd6g1tW7AgbiPO3VIxB2omCuvqkWPB1UHAljysSuWgBYMQTbCssyi7nfRL3lrO
         bbOW8YbkyUFfD2BSxr2w5Ot6YcEMAWO9PGHJg4GKff7hnByo05Mu5lkKMuaFG2aVm3y8
         xKtQZ6zsNsUJK8rbSslFvPmJFToEejTJOJ3++0yR0HMiZ8Fn5kRVcdlDkAub3MKhURbA
         QCBTBFq6qI5xafCjRVu/rYysZWF5kGL2si1wFFSE3aDXOEf/tgX2iaOZUBA8WrJ/eTn9
         1WfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXbdVwssrRRUunH9VsQpmj9xHaZAwNZsoNFctcLmRYiecPLm5LxyAaCpStvuwSKR+BiPBMqRzBWZfyLAAsRy+H7nFpsSwn3fib6uQat
X-Gm-Message-State: AOJu0Yy6VCwtTbiPi5sHjRvHyIM2n6LtCf0jb01ERDohi7iX5XEr+JsB
	fxULfxVhAy6zJKIKqTA1+Cm6Xx3T3b7AULTg8SOl+hF6zu3mqH9INBKWKeUcNuY=
X-Google-Smtp-Source: AGHT+IHvM27UyNUUHNyHnRcMcuAN9lM0k5m646RjUKSPsYCZAH4M+FrTQdBc1dhFZZVDQrbV+zdgxg==
X-Received: by 2002:a17:906:f357:b0:a44:591:a3d8 with SMTP id hg23-20020a170906f35700b00a440591a3d8mr669462ejb.31.1709109205764;
        Wed, 28 Feb 2024 00:33:25 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.83])
        by smtp.gmail.com with ESMTPSA id qh16-20020a170906ecb000b00a432777eb77sm1593987ejb.60.2024.02.28.00.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 00:33:25 -0800 (PST)
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
Subject: [PATCH v8 08/10] watchdog: rzg2l_wdt: Add suspend/resume support
Date: Wed, 28 Feb 2024 10:32:51 +0200
Message-Id: <20240228083253.2640997-9-claudiu.beznea.uj@bp.renesas.com>
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


