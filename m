Return-Path: <linux-kernel+bounces-46206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F514843C30
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2A0284AED
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41D417317D;
	Wed, 31 Jan 2024 10:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cIRbSaQr"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AABE6A35F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696437; cv=none; b=l4WPFtL/UL0X5Z3xTZN9aMK08hnvS9u43+jD8we2b65dxfdP3fX8KdI97puukmnr1pOTO385/U4rSuwDXWF73FYx2Mcjrmf+r/n0rnU/jc1fD49rSMG5OaGZaJ64jh8758VP9XqoVgUPcO4LY96/H1tu4bKxpQncjDlfeeGChA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696437; c=relaxed/simple;
	bh=MgFJpUbvEVQLvjB4o3otMQmxO0bDiV3ePLWOTxj5V98=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qm+kGLJEIdlSLIBaFdjvOXPEQgx48zdGZmZKhABREgqF2wGUTD0loDxsD/IcZOf0I1m+keSb8DFvjVAKJD694/iKh8CGF19UH2JTk54+9GioNf+RMBOhwjGhZljxTgHI2xQ4KnkmymL4yDGO1aWhAqLKyhgksREl/pn0qIRgL3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cIRbSaQr; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55f7b91ce4fso1061800a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706696434; x=1707301234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjn1b7iVWG/Dzeqv8I89FpnvUEwnwwybhoCYxf02VwU=;
        b=cIRbSaQrPMsqjN2PW72K7GHlHTT1dBisTXfg6YPtGREJNKVNr442ql3N1XDg0LJ4Pn
         CjxcpvfgrCateO9+Si7WUFN0qzOvTdoo5Kbzz5uydRTMsW+emmzci3ul68PU3Vwy5+rp
         ZVHGfGJyFLKOM/tVYcMkuzg8CB29hF0S/1KtLkXvA28SBPaDE3EOyOD7tKOgkLy+tXiG
         X2F1yOLCnrz3UZth+Yn8uOjYWj6TamJJL+TmnyczRvRF8RwHA+weck8fpBNg1qIDxRKx
         cWX6h9V3kcOU7alXIQiNWATT1oqjCDeSBDWbWAoHbD4bMd8y0e08iNmEW3CjR71QszVD
         vIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696434; x=1707301234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjn1b7iVWG/Dzeqv8I89FpnvUEwnwwybhoCYxf02VwU=;
        b=Jmiv0yKDxONXvBsMUzk0+nxWnylZuKSIv6c8QxU/o/KtHnLhfa5dt8f+vGX3pQtIEF
         Ah9jfYCuCCsR9qa59IZ/1pO2tjmKUO1cZtJO1s7lK44H/QFn4K+/o5BzSQna6ieubuo7
         qlWQHVs1+ReUOn974cug/TLadt0ArnjQyKPpi/UidCfwrweLRrvNGrc294r2GFNOstJR
         7+eal+cfkrqTrHyo0eREF61qwBp+0XkCS8pKb4HZUMSz3DoIAAsL+vDJ3SyK0KCKiLLC
         9be+3zP7D5ZIHH+SSYDR/PphZgVWkXjj8xa40nwlYyuL6ikVhSlP5h4I74I3QlX2riJX
         RtJg==
X-Gm-Message-State: AOJu0Yx5szq97fZ60+4w7quokh2t0MUWsWW+W5abt3mpjdI6QBtRUIZj
	bjuTGaX3buytGyBhVFP0EpICM/Giq4VFctaL5TA+SzfFhdLrB0w7OqHwJ8xKbwM=
X-Google-Smtp-Source: AGHT+IG+eOp30gtNaX+htNFsrhr7HfwkQ/jQilxw4Lgk8ccm9txX2BL9vh+6gRnwuRIVSGBqWFWh5g==
X-Received: by 2002:a17:906:7192:b0:a35:3faf:c8d1 with SMTP id h18-20020a170906719200b00a353fafc8d1mr1208954ejk.22.1706696433795;
        Wed, 31 Jan 2024 02:20:33 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVdsfWILXBviMW9OR93BKPBurDeJwQf6Oui9NzsTpZNfcE3wC8/qMTH4nNhWGnLKAz0s3W5ZoCN+QoAvaniaKgj5e4ewMU0trSGK+HQzaeqoyHC3vT78T3r3SGyUEpVPvuW9MemSpjjbqjHGaUUop3csxowBP44acauzGdUDesn5dubiD+z3LV5kGziv954qiZgrqlNUW5Gy1q4cC3TCDbUfOK/d0tzrYPoKJS7o/tCIz8dhimL5UpsZfYxLe6EB6h2K5bsHuE97qzwE5IF+zkJY7X+K+wDePZe+MpMK866N7f1IzgZ6osQSKXv/11bn/hw5NcwkmrWCb7qkCpJ2eRcPKT5oF50J3RcULP5TMZoiTS1pdJxPLwd4xdIHBUjyyOdIXVMa7mCXlBDVNwE8W5Yexl8zfraiG4fM+cxqi5RITojecESa1qmy4kYYlz6hDD222JBDd6OKqG06L92hBdVv86RyWCtoDoV7dEaDVVUf/J/WoMXAtxkhvY1WoHKobq6eW7leO9ExBkb/pLwrenIeLzNq0LQ+4R45ra/nCiJBvIOWJxOMYcT5o/AFmuB7WRl8Rh5hnQlNIZv21WnfmeW2feF/tZSu/sL5jm+KgkR0eM=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b00a3524be5a86sm5212966ejc.103.2024.01.31.02.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:20:33 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: wim@linux-watchdog.org,
	linux@roeck-us.net,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	p.zabel@pengutronix.de,
	biju.das.jz@bp.renesas.com
Cc: linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	claudiu.beznea@tuxon.dev,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 04/11] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Wed, 31 Jan 2024 12:20:10 +0200
Message-Id: <20240131102017.1841495-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240131102017.1841495-1-claudiu.beznea.uj@bp.renesas.com>
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


