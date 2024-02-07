Return-Path: <linux-kernel+bounces-56516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3BA84CB22
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 236B828CD30
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FE76C9E;
	Wed,  7 Feb 2024 13:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="euSYdHtG"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151E47E111
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311304; cv=none; b=GIV4OF10PfTNj5K/OEiA81sUCiKOfIZ4xsDQL86p6c8P2UGifo0EjJ+vV3pcashrEmPxScmsU9qQsg1RqAJMuoKmQ1iSS9bcEffuF36wM0zxmy0pMoZYHLHJECl86RUXy/sATDN5RIGF1om7G1YtYrot2tto7I1XPdqx2QpC2dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311304; c=relaxed/simple;
	bh=VjRgEzn+RWBPQdaD+8b4HRFQviXjhD/e8LrJBJoKCQY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hsbeyVtRCOe+B6ZAYVeYeheK8yBAOnv1q+AqQZA9fL0Y2CzfQPcZbZHLPObinjHVt7orh1+U7BW0IXm74Hqr7q38ey4EFAVe9g/xBSBoRU9AfQ98hh/+Ar0j7uR6jMP/55O7E6Akgk2jnP6jo7zA09C7h7gyvWiRLSk1l+O7R20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=euSYdHtG; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e1226b30ffso298435a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707311302; x=1707916102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DdZmyBQABHXS5RYhtmrbY7TulTRRnEOQvfA6Wg9RTq0=;
        b=euSYdHtGo2TMd2aMAJ0C8J6FSy72tc/O0mnWWDyEr49OO4Di6W+rpqWxQuqx5NUkUN
         0T3Mrmbfi5tE+JFd7WEiieq/B9pQC18MQA6WqmUBVUEWIabIb4iLp11Gl8uip7QXFIMF
         0HHIxScxgPcCnavtAdov7JQ2oXnhQjPniF0MAnaJwQaEr4oUoVoUf74MkBt1NebcnnLy
         alv+tiIVl5hN097oEXPDZL/G+NlpPJVwy/4SV+AL6dwL9lLBhK70Ajs2kx6ZNgmeC8/r
         vYag9kX9lMeeOGO7uzqio3R+F62ExlA17UtM6adZau+g2JYVVCpV5uVsNy+Jp+42FFno
         CnLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311302; x=1707916102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DdZmyBQABHXS5RYhtmrbY7TulTRRnEOQvfA6Wg9RTq0=;
        b=HRgG/9IvzEKpPcXJU8JMqeMaWtjQCZwE7uD+42fR1JaO0wMbqanWK34CUqtPwE/BTA
         fiCYj37zWtnv9dCkHw9wmrrxvjO8B3DNrVADXUaEKdiFITXSp4pE58V+bQqYCAkG94dp
         4kybrFPSyBovb39yg5gvsrXV3T6cqB6OIQ51z5wsteYa2WxQFtzVOdoJdpR695NwgL9d
         odGVYSzlI+xQW9d5tlZNT6j/41SS2+cUpdgxIzOSZ/ssSNxOngz7t2qt2VutlzdnUDW0
         cBY701wIy++z5nLqUzaP4/FT1Oy07PRqLFx8/L2kQ8m+wtT9V+iFuaaPmRiusMmdm+cm
         lC8A==
X-Gm-Message-State: AOJu0YxWWHyBTwwpV8M8vp8fI0l/oK22DyXhoHuwEP+DwfP+UDTRALrn
	Ir+cn2wAev1o7ramh2XA3crFcMspmBsApXTclEyYzVbJ9mOltRubGuRnA5C41iB3nkhArkj/BbX
	J
X-Google-Smtp-Source: AGHT+IFVgKEds4t4hdKuX9e94KjUmgo3FcUvH04I5pj25ESTbsxG/VO2e9usj8SzaBGee5t8pFEW1Q==
X-Received: by 2002:a9d:730d:0:b0:6e0:b1ee:d98f with SMTP id e13-20020a9d730d000000b006e0b1eed98fmr5356348otk.8.1707311302126;
        Wed, 07 Feb 2024 05:08:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXmPYgG5IXLGv+c46earNTcKmwx81v47nDgjJJ0ia25XOsuHzDieGDZELb8ZeIr2p2i5h+FSvnLYyBPsiTfx/RKwo9YR8Y7haz3wsHJq0Qc9w29NHyarGib4wqy3osl5wJDntkZpkXznUl+2ZR2uAjpFgMBySzI7Mo99bXbl3iUPyT0ybyxxhvBxzT++T4v3tcDTE7O3E7d9b5XBT5rWq9p792iHYJeUUYfMFTrDxDn43Lu2JhXVGIe4GFBgkSBrNTQdMiHMckK2yEWcoBU7OuUuzpUfhrqr3zWLj3sgMECgY2tVleJN48pJGJGhEmgtokY2eOpqFRrXwYXFclp0U1DGwgVRpR/rviQQIJPqB0R1/bHkbW+291gXGiTfkINLf/qrb/3t9YQG4McbIgP4auf6ruC8+0VrkHpLingg4auYBGb/dlS6NxoB4nOjFgLqevxrMUaqJK6r6BUhq4NS6HGk+mu7dtY8LHhx0RdKo2ct5IFDkIPnWjzGe9RgzGCqPdfxiOu5IYNLA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ca991000000b0068c9cd2cf88sm565455qvb.60.2024.02.07.05.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:08:21 -0800 (PST)
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
Subject: [PATCH v5 7/9] watchdog: rzg2l_wdt: Rely on the reset driver for doing proper reset
Date: Wed,  7 Feb 2024 15:07:43 +0200
Message-Id: <20240207130745.1783198-8-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240207130745.1783198-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240207130745.1783198-1-claudiu.beznea.uj@bp.renesas.com>
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


