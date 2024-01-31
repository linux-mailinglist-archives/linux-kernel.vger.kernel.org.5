Return-Path: <linux-kernel+bounces-46205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE33F843C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7027C283C0A
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A56556A34B;
	Wed, 31 Jan 2024 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qpUCd6tT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C786169DF1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706696436; cv=none; b=XBLtNBn6P54YypWjwwcgptkoNHHYsTj7zdNEQ1UtSrwkPaa2ek2+5pCX+usljlQ1QeyBYaiR5X53IyQdT/X67hjmdMExoAqkNRIvGBuRqagSPJf/Vo1aht3Br7r3YDm9GBtApmIeE/iVt3pTXG3nzt+6QnR2wQm6fBLo93aQLnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706696436; c=relaxed/simple;
	bh=CY3M8Mqn/0y6afBKiHgCJuC3vNLB9ACfKqOSd3IKujQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YTTl+B6QU3wKzLCfCrmVPDABZ0MEnpyU4Og3W34o4WqgTZ+RiM5XEfcf09NUV/RKok+ZwEM2OoqqY5wyxFHFCZoyBc05numCGcEX6DJCvNzGmtXDDTd6lIBukK9bWQxfs+SLQXapqgSGDkXxtL4wXWJ4Rutky0pScQLXJR7GPLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qpUCd6tT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a26ed1e05c7so624599666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1706696432; x=1707301232; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GfK76c+CeJJpi/mnBQSES3HfUMfPSrEdlrzGwMFX1s=;
        b=qpUCd6tTPkhr6SujqqqQT/wQhPXMGYqI5pML8cVAMFcThkCA/1u4OuraTVt68Le8gn
         esxiIB9uCXi52CH6/409kRNa2uh9TpE3OvmSqx5PXZT0vOj5W01KwxGq+8AWNFcRI2LZ
         Xgw/feTaN0X4sx8uOC3KqHHF52ODj37PpKbmJUOlUIQ/Ey7Go888ikrZ4R0yPYm5h30N
         WN0/qPRSq0VcL6arc9fLevVHxn+I68JsxXGVbLWck2Csn2a9Z1XlvscE53TqdKKR4uCo
         mH0Vk+Y2Hoxr8kYW8NPGtkgBaARHMPrr71MibCxtN7xlQZ1gmolFc9JxYZJ+O4L9oxM0
         ocTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706696432; x=1707301232;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GfK76c+CeJJpi/mnBQSES3HfUMfPSrEdlrzGwMFX1s=;
        b=RmUKa16eR0F8muFXGDGeknSCj2yPMiurBqDTr8jtgSs8MmzLi9b+sqk3IF45K8Ub/j
         Br0dVo5IpAG4LLJmF7fRTRQiUqc3Kzrl+eGWB5F5zj9sZwlqYDU/xRcJhF7jQDEtAozk
         PlBF9CVxeghsyOdPTTc8sA/6RRLKbjNUzhCbCD+oAs8Krby70tayxkJ/fVvKgebsjJy2
         zNr8jm7oHAZbnVfAFoYuMSwjZOZp0C0cBfPX560nm6Zx3nBx8UbGM93WsQtU4WDZbinS
         u4Cyu6ZiIupeIuF6bNLYuxXbNNmM0TOynDl2maoNQTId52qANT3XHZ7Dc9nv21ONCs9I
         AsXw==
X-Gm-Message-State: AOJu0YyTRufVuDRdBT51ihCsqBC4jqVv4TTIZucFPf3eGYZM9CnL6C0F
	DKCJn4xy0PdhMXpQooWQGGQe0WpDkcQLGL65WQCZh9CLJtFtAQOZ3Lv7qN9MOhc=
X-Google-Smtp-Source: AGHT+IHzPHy+qdQe/q58ShWyFgXeWZqck2cqAo1fNEDXkylgIBaQCNpA4FPlUUb5yes/cmJ7w/KjQw==
X-Received: by 2002:a17:906:351a:b0:a36:1fa0:d3db with SMTP id r26-20020a170906351a00b00a361fa0d3dbmr734026eja.77.1706696432122;
        Wed, 31 Jan 2024 02:20:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXSlWpXySGgao+txGilt269F0iC5Ov34B1iA/1bCVpG9blouMV3UnKSby+Kay8prZAnQO0mef6WRXR0TkeHHQmZqbYkovtXZ2/oNjhKnK+aZ6X/nOJZH4rONjBEdXNI95jOhJIOa2yut+zMwZDIwoQB6unC33SFxYqz1SKIcx4Gho7MYLdvCJ4TrkgnQr+oJH3wtKstqQRhYvc2fah1JCLNNZyoxUwffRIFQpFKCBe2VmMEzGUaK2p5w7nm1xfrsYBnZcclHSvWz6sp/V7tVNUCPoCEEM1qicVtbBkhv7+sVdwBivdpRt6GI6Y4ncunXNyPb/jkk4Ff549jEue0kYPEcFIN8lnuzMJbFKeX2km9WSmVPO8XdJoAdSPg4nB4+FDo5auoR3kiRhT8kvzw0F/ls49LtRPgYIMSD4ZR1BRMP2TqLPb+WjcwO7qORDah9ByGGVGrvdZr9kmPbKFdDWpX9PTjoeDEoRs3yTLAVJD0XlAScPpeFekGzTNpXX1JsViSrRt1yv80g8E7T3/XsUnONuR4LvHHI28lq1ci1/Gxj9D9iOkPiMfMlYy8yvpyJNoKiu2lmZoNEFFW+eogRBVsQdlQr5c2YUzNgCd/xYKPlPY=
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.87])
        by smtp.gmail.com with ESMTPSA id vk6-20020a170907cbc600b00a3524be5a86sm5212966ejc.103.2024.01.31.02.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 02:20:31 -0800 (PST)
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
Subject: [PATCH v2 03/11] watchdog: rzg2l_wdt: Use pm_runtime_resume_and_get()
Date: Wed, 31 Jan 2024 12:20:09 +0200
Message-Id: <20240131102017.1841495-4-claudiu.beznea.uj@bp.renesas.com>
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

pm_runtime_get_sync() may return with error. In case it returns with error
dev->power.usage_count needs to be decremented. pm_runtime_resume_and_get()
takes care of this. Thus use it.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_start() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v2:
- propagate the return code of rzg2l_wdt_start() to it's callers

 drivers/watchdog/rzg2l_wdt.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index 1741f98ca67c..d87d4f50180c 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -123,8 +123,11 @@ static void rzg2l_wdt_init_timeout(struct watchdog_device *wdev)
 static int rzg2l_wdt_start(struct watchdog_device *wdev)
 {
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
+	int ret;
 
-	pm_runtime_get_sync(wdev->parent);
+	ret = pm_runtime_resume_and_get(wdev->parent);
+	if (ret)
+		return ret;
 
 	/* Initialize time out */
 	rzg2l_wdt_init_timeout(wdev);
@@ -150,6 +153,8 @@ static int rzg2l_wdt_stop(struct watchdog_device *wdev)
 
 static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int timeout)
 {
+	int ret = 0;
+
 	wdev->timeout = timeout;
 
 	/*
@@ -159,10 +164,10 @@ static int rzg2l_wdt_set_timeout(struct watchdog_device *wdev, unsigned int time
 	 */
 	if (watchdog_active(wdev)) {
 		rzg2l_wdt_stop(wdev);
-		rzg2l_wdt_start(wdev);
+		ret = rzg2l_wdt_start(wdev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int rzg2l_wdt_restart(struct watchdog_device *wdev,
-- 
2.39.2


