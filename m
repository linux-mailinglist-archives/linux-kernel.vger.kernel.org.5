Return-Path: <linux-kernel+bounces-67053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0ED85656C
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55063287800
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB238132C19;
	Thu, 15 Feb 2024 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="fLtDfOR7"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF5C132C0C
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708006143; cv=none; b=oTxP4AOID/doaplu/92VTwx0mBTto4w1Ann091pb7knqCGA+2m/d9IFLgKjnRe9gs77GjBfN42NqGa2XxIqqDb9Vr8Go1s61LYnPwRr1BSHPOj80hEr2vKTYMmebDkxGYAp6QgqqR7Kqilv+Lb/g/B7xBPC4xikgzyx9dP4kp5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708006143; c=relaxed/simple;
	bh=8AsK5mIJBGZIHLJAmDvX4jfuEJ1mMOpuX9MBHmSxx/g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OW/0PrOcnVPEhQwYqS2s2ehTrztawGm1GRtuZ+pGa14UVQE5E1bX6/eKo62IjO0tqTr/jjCZZurYV/gEIoqHq2u1T05T+LQzIsQ49irXpq8Q1ZK8cvFW02gN5wuznGN86QMf41h1YgbKl8j6ZjIrm9JsumcxO7KJJ3NTdfJP3dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=fLtDfOR7; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4122acb7e56so2155755e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 06:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708006140; x=1708610940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qPUYiNHqZhUoHd+sZ4RJHnQ1CmF+Xdz4uH6uUdJNI+c=;
        b=fLtDfOR7zzKxOgfJBJUe7kJsm9PU7bmips5thzkXG0R3kUrM9GA4PodvdQTHaMbP6t
         +JScrNIJWDgVoXG921m8D8X/6Pbn5qILVqyxrN9Dhc8lJHeWCntABDxzzFdjbA3nppNh
         FE6LH/+ZLFn/lNTz/o0QHSx+hp1x3S/OmWqLJC7GChodNsb8TdE/G3IjAeQepsoMYj8d
         H/t16yL/nP9+EqL7Hapm3nTi7ApvbJm/6dYqX4mQ2s1hpU0YpSzEPtusVdRDTIIXjSnC
         Z9jMCxKsrhMW+zQ4HiKkE4a35vcIPG2CAZQcK8weZI3X7AxKZkndvzzO3hbOJo0o0yv7
         xNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708006140; x=1708610940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qPUYiNHqZhUoHd+sZ4RJHnQ1CmF+Xdz4uH6uUdJNI+c=;
        b=j/BSRbONUgW5KnyVJxvrxurYI1zlUIaGa8WrJaLuCVFf/lgmHlURXlWmL3lR76k9Ip
         7nYhh9ZGI1paScbOY4F+xjjrJSTReVc0PfbfIAUJsXCnZCbjNU112sctz/Mp19rzHe/B
         nowIEiNgSSk9DsKiHA/V1wOTLmx5N1bpP0wOQ148pZ0PLS4iPew+40LVO0nEulzdPy+S
         d3SEWRNNDDsZVb9Djv0L0oomKt+z9DpJVYrZm8FFzwq9AxPZKsy2M9XXwQ4RDIaGuPGO
         jFdzRk4khlymY/LVtB2V/yTleAibx4vAdTVLWekfj0Vdc1QHImuuzeSD10CPDLxvd/5m
         D2wA==
X-Forwarded-Encrypted: i=1; AJvYcCVPxGhIiaKbSMVuYluEHRwhl5ygdzAyK3A0uPEUvemEE0A5UYkjXJox/d6bLcBUORzRE4SdRymCJjCEAr3m+O1vfl2QCp68CJ7DDOfX
X-Gm-Message-State: AOJu0YzltMpP/vqzRPHta91Bmbf7nvt91m0386eEMsxtCgeHbdB13lu7
	uCTSjsP40JiPjjUYovuFxLbRoAFnZlg7C6GpeMDe1JpjSwgGmvgKLlv8HUU/cqM=
X-Google-Smtp-Source: AGHT+IFvZldNhSxzrdf2RQwJQa0TZBuItKWFMIhreW4M/KLv1wZjBxMoQDKWYNl1lU0a79AgB9qAPg==
X-Received: by 2002:a05:600c:1d26:b0:411:da90:89c0 with SMTP id l38-20020a05600c1d2600b00411da9089c0mr1565047wms.10.1708006140040;
        Thu, 15 Feb 2024 06:09:00 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.20])
        by smtp.gmail.com with ESMTPSA id h17-20020a05600c261100b0040fe4b733f4sm5120950wma.26.2024.02.15.06.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 06:08:58 -0800 (PST)
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
Subject: [PATCH v7 4/9] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Thu, 15 Feb 2024 16:08:36 +0200
Message-Id: <20240215140841.2278657-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240215140841.2278657-1-claudiu.beznea.uj@bp.renesas.com>
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


