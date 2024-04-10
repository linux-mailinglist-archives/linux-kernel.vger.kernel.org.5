Return-Path: <linux-kernel+bounces-138657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E8489F8C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99E541C26BC3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C894A16F0F1;
	Wed, 10 Apr 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="iUIcDvN6"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B027171679
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756479; cv=none; b=siHa1awucyCn5Dv0+mgrt4V7rr+4is4xnAmLZ0KV1XQNR0z0UEcOkN21hGMnWrvhW2ELoEIkM1z3AKre+jIv01atR8j69+zX098trh6hwSyw94faT6NBeW7KCJQbMY1rvNxO62Ieg36FqtUtbY7HEoYzzh3bdvnoZQG6oWvFniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756479; c=relaxed/simple;
	bh=zMATGWmbhje5tfDxfaCFVw5MU9tqi71sQIaQ5Z5dkgc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=k/pBO8A5u0msPbtbFDfCAStGNThRgVPa97xInxlO9KWPwS4kEOOfu4qpm0irKYdr/d10OTZwVDyxIQiUd5qJTjtwUjtIsNfFp+z8vo+0EsD/6xHh/FfZLvR0Y6y52RXmyDby1Oq0j8pmqEarWlOKIzAF6tlP6ItWPdwi2VOgvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=iUIcDvN6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-417c3296643so1633895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756476; x=1713361276; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N2oYKm4kbcjnrzOPJaN5bBfK4oadekuOvRl8x7PJBXU=;
        b=iUIcDvN64YVXTb5HYaGceOmKwVCq+ODcQ1JP1imInw3mQ3CbdlMhcJfXhtRd3AxyT7
         gtldnpxBU3a36FfLEQ8vJ3JNgcdPWMeW8RIzLjzkeQ/s1/0F9R5iNaECXxRuevwzQMkW
         2EgV0NVrmSiwrPkJG0Yro/z/cENoq8vKXgkw4pwM1eAMyXnRArRCN2Hicbv4x/u4MW4T
         a4ItlcZjJ+7VRMAR4T/fOH1Y99IsCA6YzLQmB6SQKlelm++SASD7OLA+YQW/hRffH+dD
         i1T9utHS4kRkr894ZGj2Udv9504/yEuMoHv5XgU0/P4My0FwT+HUoYPP0kPaa9dKywtS
         nSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756476; x=1713361276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2oYKm4kbcjnrzOPJaN5bBfK4oadekuOvRl8x7PJBXU=;
        b=NRDa5O0xx/6NHKnZwT0Wska0uMMnkfk1GiM4C7SIlBCQoVVhREi5SdhOI59+5PfT3J
         Nal9dKJXH88dQ05M4VQj2g+iYBllJnuYP+bMTo8pnS4ngNmexXBUB+3YLMu37+KXsyoF
         zFp503HqxYbWgOevgt5w3dUs4gbZpw+7pZUUSNLGjzKV6NHvnFhH1mjiwpXdLbQUiN1G
         7FAs4LBYHsxUKyU2urfG60WDIh/yGxP+EhpQyPn0VFFGBiF7GO9fY+B4AUmOxD+zwCEZ
         J3t35CDCvCVVCyyJa71+1zRyX1TuPCw2AmnEp3p+SEITGirbNNsITb6V+h7M8VeIh3WF
         /+xw==
X-Forwarded-Encrypted: i=1; AJvYcCURhIzh/GnJhCpo43we7Gih+CAF3Ibm+hv2/TCqdr+ORs4Etpc1EL2xjmpLhK/x+e8SSBYbLGetPvRxDCDQjRgYNMUAdewGRG3z120m
X-Gm-Message-State: AOJu0YzrAQ6jSJS6ZVP5DDf1TZUeYZPi3evoNHSrET2tYzSB4HuDnVGC
	bhNcJDXzGpAsyK45y2fBCVk1cPws8uRYqI9/HCfYeUlexV+K64u3BZhZacjNT4U=
X-Google-Smtp-Source: AGHT+IEwTzEScnNS/2gYDyhXczlf+j/6gr0ajyK8+LV1iGQ3yQNzLeDf3kEUCA4KCUIoIeLf+9AnRA==
X-Received: by 2002:a05:600c:1c2a:b0:416:9c03:62e0 with SMTP id j42-20020a05600c1c2a00b004169c0362e0mr1770271wms.33.1712756476470;
        Wed, 10 Apr 2024 06:41:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:16 -0700 (PDT)
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
Subject: [PATCH RESEND v8 06/10] watchdog: rzg2l_wdt: Remove comparison with zero
Date: Wed, 10 Apr 2024 16:40:40 +0300
Message-Id: <20240410134044.2138310-7-claudiu.beznea.uj@bp.renesas.com>
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

devm_add_action_or_reset() could return -ENOMEM or zero. Thus, remove
comparison with zero of the returning value to make code simpler.

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
- none


 drivers/watchdog/rzg2l_wdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 93a49fd0c7aa..29eb47bcf984 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -316,7 +316,7 @@ static int rzg2l_wdt_probe(struct platform_device *pdev)
 
 	watchdog_set_drvdata(&priv->wdev, priv);
 	ret = devm_add_action_or_reset(&pdev->dev, rzg2l_wdt_pm_disable, &priv->wdev);
-	if (ret < 0)
+	if (ret)
 		return ret;
 
 	watchdog_set_nowayout(&priv->wdev, nowayout);
-- 
2.39.2


