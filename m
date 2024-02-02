Return-Path: <linux-kernel+bounces-49397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CA68469F6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:59:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2B7728E3C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479E718AF6;
	Fri,  2 Feb 2024 07:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="go0oeR3l"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC34318046
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706860748; cv=none; b=J7eqLLXCWn8tJLGl+BitplxY0/gNngRPJeYAfSnhvTKicNaN7DA01vEemisaIrqnC8biA2zPc4iBA+VuXUKYldU2nat5CibJJfwcGPsFty4BVjpDl9E0PSqjRcCxyCMQiXU86+tZjuD3zYdbkhoaVwrrMlAhOte2Zbyob91jH2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706860748; c=relaxed/simple;
	bh=CWt9OYHw/poJzADJ9gjXdNYtv1VEWdyf3zZw14VJsuE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LsGHqlzCHKbotDQS/SjNaCxXrMxI5wTkguJn3B+i2Z0/GTpGs4wOXozVnrKGodzph8XYvsbEBS1ROkwKOBl4rxNJ9n3EXMM3QggPd93dBuUxowaivWlpSX1u2aXC/e0gnF2YP7kaNRGi0Ph1YMlFXJd/e6i4JMr+NFpj67u/cTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=go0oeR3l; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3604697d63so273375866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706860744; x=1707465544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E28h8UOWdGbHYCD2Q/GcdEN9vZw1F8khK8fuudVwako=;
        b=go0oeR3lV/vh7kY2f0bhFnUG+9aY+y+KXz97Q8i7p21w079dad7qhH6een3YE88f++
         wGu1K6tkx1NAJ2XbQY/W0zYlQyJWhOizEbErsToz0e07UKI1NcS0EKxd/IjZVPS9PWeM
         alvdWwFV+kdSNQWv/LYIj9qgeOD0WSwV2uBz4ruq2UaENHwpvK3M7Wkxs1cCPKwSSaoV
         J2uDzln+yJIvdPOXGEFV6Tc5y13UIhqqmNA3moINT9nU6cCi4VUk9bvWF6RrJBIdUtvj
         cGqjp/KfJcfrC1omrFPl5NWEKXibh/43DVJOLTqKphTX/4lY0zTn0BKbRj8ygY20zu/b
         H8rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706860744; x=1707465544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E28h8UOWdGbHYCD2Q/GcdEN9vZw1F8khK8fuudVwako=;
        b=oxRBt34nfO15a+Iwgv053L9jzOAz5DgkeG4/pd27CYlQlZYPFRRP4e8VvOumKEi1xH
         HuNiZE1QwwE4UN/pm3v6sJhfA2Evi1M0oUls8VTpTJEj6d2yspiTMPFxYpTJpuAozKqV
         bakpEfC2ZUGjmPw9fx2G9pqwu/sl4vXTERNqrDA8LPitDZvYdQwy6Tr7n7AIeEUqhsFe
         WI3oAO77l+IVaYB2h9J01JgtUxW82jV6sRHxhV5ZJhg8aTzGlt7tV2EW3A4Wv9VTZ/fm
         Al6jXthmG7dhsPK5N5AEsZpOuWCmFQWmoNsM0Uoh8arsJZWCxGpY5ysSXjKOvW9OiPA/
         dAgw==
X-Gm-Message-State: AOJu0YweNqbatg9KumfsZUURmN0K2CiBzMtK4h80zhq/HeuSrhM9jvAb
	fYtwYZevUk0fVF+4jD7eO3iOJrlOuuN0kJfQ/eS8DyGNEorNNSBhjv9Ndwv5S4Q=
X-Google-Smtp-Source: AGHT+IGirvaP7NXLR30QhMN6kNU4F5oCT/JVNOiF67mif4i+N9aGC057AVcZXmmaCdh4LYwarZg0vg==
X-Received: by 2002:a17:906:1c2:b0:a36:fc15:c6d2 with SMTP id 2-20020a17090601c200b00a36fc15c6d2mr826777ejj.5.1706860744034;
        Thu, 01 Feb 2024 23:59:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVix0ihpdOec/L7vK4fRSeO+izEcKXBhidmesrR3EXH0mVdoJMYbHVDQ0r2qyoHV4TbaippImQa7G2Ot8keg45J7cBHFWxWXSeFpv7K3UtK+aXAqfcwgjwW+zxxiqqUV8T+U7f+Zf1cONPlxvXW4hZZND+o8WAZQH6NUjUfzr1hft/IBNcLgojXSf0ijIc9+d0geEIxSiY4lCbF6Os+9n5nmwdWZ4v2vvKR9iIfVxj9xBkXcRkUDTa+jzcVKdTLRGerdWMHieXDWVgUR+WksZZlI3oeVqyTihdLk3A8fkbPdZ5r+/+9tIA+k06Yz+WrUKpz9f9LkQHK/kW3AvBEuSwywTdrRTLLsFrT4rsrqU588ujMnxWZw2Thk6mfh0xBDSJEUaN8VX7xr51C29LniFzB9U6TrqSWJgXyIPHG8+KF+WEeS2oXposmP9+xydCMVeOMswrTS7UguM07U0XgHvuVDWCWWeg+2A3l0TPDmAnzI0rnxR64ClUhbLmOQlTLC2RGn8wtM6gzig==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id ty13-20020a170907c70d00b00a3715be38c4sm185544ejc.210.2024.02.01.23.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 23:59:03 -0800 (PST)
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
Subject: [PATCH v3 3/8] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Fri,  2 Feb 2024 09:58:44 +0200
Message-Id: <20240202075849.3422380-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240202075849.3422380-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

pm_runtime_put() may return an error code. Check its return status.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_stop() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- none

Changes in v2:
- propagate the return code of rzg2l_wdt_stop() to it's callers

 drivers/watchdog/rzg2l_wdt.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index d87d4f50180c..7bce093316c4 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -144,9 +144,13 @@ static int rzg2l_wdt_start(struct watchdog_device *wdev)
 static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
 	rzg2l_wdt_reset(priv);
-	pm_runtime_put(wdev->parent);
+
+	ret = pm_runtime_put(wdev->parent);
+	if (ret < 0)
+		return ret;
 
 	return 0;
 }
@@ -163,7 +167,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 * to reset the module) so that it is updated with new timeout values.
 	 */
 	if (watchdog_active(wdev)) {
-		rzg2l_wdt_stop(wdev);
+		ret = rzg2l_wdt_stop(wdev);
+		if (ret)
+			return ret;
+
 		ret = rzg2l_wdt_start(wdev);
 	}
 
-- 
2.39.2


