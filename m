Return-Path: <linux-kernel+bounces-138663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB8289F8CC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:51:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E11B1C2741A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F510181326;
	Wed, 10 Apr 2024 13:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="Lf0sUxq4"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06117180A7D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756485; cv=none; b=envp6JwtRpkOfw0AFKHl9c7JOZm66mYw1IOXC2SZOnyYxSpOR7kZ/e12m+LOCSqLC8kXCJjWdzlMct2PufjYDnSLL2py6hUtz/jXFbUhmdXckLiEA8FnaYIgI4gBxeIu95Ims7Z/i8PBp/o76ywIKGKhaG+PLkU0uuwm4nzQtZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756485; c=relaxed/simple;
	bh=CJ5Yg4Su25upi9PiRBilKHZBgxfV1yi9eo8lCkVdx7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a+ay+SeBWHRMg2zYjfYGFTQ5v8YgHYNcvAyIg33+7hAsvGjGk7l5PvHLLVtkIMCYnWM7+ujclFTSBH9LIPRlQ8HyKGnfoguhNV81Hsf+PU9kCOEsXBLyhJpfEv8UmmqhnOX4y3GNYfHDSF7Cjx1+NNTVzPnfV/7zf20YPDD9ZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=Lf0sUxq4; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4155819f710so53278055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1712756482; x=1713361282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bfpDELhZMXS3a+UUIPdr1Q+y0EuPmA52WesKgXwm+Ms=;
        b=Lf0sUxq4UOs3C7KQX9/jUbg4WWL0HxKQYtHJ0eVFePeuWxpcTGK3pjOSU9ihvt0xds
         IDvkGrSrzp4kcU0hbrEOlf2b3FkX+F4MBaEFz/Jo1EQU5pxHJpoA5TKi54fq79ooxF5t
         F6EUNFUCUZY5V0j+Q6546Fv9smaI9MAbA8tMFNZUsHUrvq2Y4dmdOH1P8nRiHDXBtzXp
         iEOb6a4+Vz3kZ3mzEYge9GcWqJljpC1ZJBZnzWXvnYnlAKcDDHUs38vrx+39zcSPRbaF
         mPg2p3RfZm9XtIxYT4lbx2XOiohQ8ViDok2YHvedZWWo6M7aC25cTz3AjGKQoiTfZegC
         a1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756482; x=1713361282;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bfpDELhZMXS3a+UUIPdr1Q+y0EuPmA52WesKgXwm+Ms=;
        b=vHYDYImtj9qS3nwEnrLQa5269GCp6iRGCYfAC99dYupLmJcnjuDpdfeYVRUBC/jsCB
         l+6A+JwdNJQ0/FNu6uW87g3r7h0zAQcwXln/2a7Ty4TA4gotJ3btX7GZs9GEWRi9Wuqd
         QrsEaJcHavliOsly6qF+2JNHqst4EEd2fxL7fkYApx+ZxI9mAE3eZWW1Rxr2zEjMJ0Te
         kAggOWeN475RQe0yDiDBzO57Np8Di2+iNR6270MmXZNcVAFAGKWExMejeY5mOQQ1qqxG
         bmZ7nP+L0ggk71mz779IvjElLJpbCf5/ti7e6Gpd2pMLq5fGk+6GR1tSVVXeyqMaclnU
         MzGg==
X-Forwarded-Encrypted: i=1; AJvYcCV6pLVIAO0/kQMT/1GdGh30cSY7pb1tOtZ8iRDdu0PUVBskUDTx9goWK+SFpFqQCFUI3TvZfv3k3ZstC3vLKVZelcdOh4fuq/eubyTH
X-Gm-Message-State: AOJu0YwDYP5h4OvwWmQf83jqBOMc3JVWyNzC7b37onc16yS7bBU0eaC0
	wMjuHSp3Jbh7vvUAyIiPHXe5LCHrp5piaCcGkQQSiF7Tb1Kb/S1hxbHRHkZTlvM=
X-Google-Smtp-Source: AGHT+IE/n16DpYEO2qqbI73ni/tWCneu2SaQzav7O3neyS/HYU4MN+sPx87irigmMT5RkxaFWg9p4Q==
X-Received: by 2002:a05:600c:1914:b0:415:6d51:8e2d with SMTP id j20-20020a05600c191400b004156d518e2dmr2247721wmq.13.1712756482533;
        Wed, 10 Apr 2024 06:41:22 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.8])
        by smtp.gmail.com with ESMTPSA id n15-20020a05600c500f00b00417c0fa4b82sm872528wmr.25.2024.04.10.06.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 06:41:22 -0700 (PDT)
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
Subject: [PATCH RESEND v8 09/10] watchdog: rzg2l_wdt: Power on the PM domain in rzg2l_wdt_restart()
Date: Wed, 10 Apr 2024 16:40:43 +0300
Message-Id: <20240410134044.2138310-10-claudiu.beznea.uj@bp.renesas.com>
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

The rzg2l_wdt_restart() is called from atomic context. Calling
pm_runtime_{get_sync, resume_and_get}() or any other runtime PM resume
APIs is not an option as it may lead to issues as described in commit
e4cf89596c1f ("watchdog: rzg2l_wdt: Fix 'BUG: Invalid wait context'")
that removed the pm_runtime_get_sync() and used directly the
clk_prepare_enable() APIs.

Starting with RZ/G3S the watchdog could be part of its own software
controlled power domain (see the initial implementation in Link section).
In case the watchdog is not used the power domain is off and accessing
watchdog registers leads to aborts.

To solve this the patch powers on the power domain using
dev_pm_genpd_resume() API before enabling its clock. This is not
sleeping or taking any other locks as the power domain will not be
registered with GENPD_FLAG_IRQ_SAFE flags.

Link: https://lore.kernel.org/all/20240208124300.2740313-1-claudiu.beznea.uj@bp.renesas.com
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v8:
- none, this patch is new

 drivers/watchdog/rzg2l_wdt.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/watchdog/rzg2l_wdt.c b/drivers/watchdog/rzg2l_wdt.c
index c8c20cfb97a3..98e5e9914a5d 100644
--- a/drivers/watchdog/rzg2l_wdt.c
+++ b/drivers/watchdog/rzg2l_wdt.c
@@ -12,6 +12,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/units.h>
@@ -164,6 +165,17 @@ static int rzg2l_wdt_restart(struct watchdog_device *wdev,
 	struct rzg2l_wdt_priv *priv = watchdog_get_drvdata(wdev);
 	int ret;
 
+	/*
+	 * The device may be part of a power domain that is currently
+	 * powered off. We need to power it up before accessing registers.
+	 * We don't undo the dev_pm_genpd_resume() as the device need to
+	 * be up for the reboot to happen. Also, as we are in atomic context
+	 * here there is no need to increment PM runtime usage counter
+	 * (to make sure pm_runtime_active() doesn't return wrong code).
+	 */
+	if (!pm_runtime_active(wdev->parent))
+		dev_pm_genpd_resume(wdev->parent);
+
 	clk_prepare_enable(priv->pclk);
 	clk_prepare_enable(priv->osc_clk);
 
-- 
2.39.2


