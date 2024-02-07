Return-Path: <linux-kernel+bounces-56513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A55284CB16
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9BB3284FF0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B00A77F19;
	Wed,  7 Feb 2024 13:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="pDLC+FLf"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064797C082
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 13:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707311293; cv=none; b=HgfhOjMncP+EqY/9Z1Tp97dNvyZmeC7EQonZcCNvVderQ2WK3ZBQ3w1xD7vWOgFT2j4oGOkxBi1OaLMpYuDCOcZBChaJ1/bL+EZ6cirPZ4H479DfKbTF3BXbmryDhT5AVp9q2yw84Ino8nGtzblC8SqV7XO9ZVysi6ivbYDM2xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707311293; c=relaxed/simple;
	bh=0yYe2isV4O+U0xGShILWSjk2puDw/sFjq7PGbppMq9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eyyT7BN5VvTCRGuqcXX2iBYvearXTNzJiOLxEcW0qE/XtoHlz/89Zyf1mv1/9zu5IjPScNNZO3FmZJEPJRv0WdfldTdth1t8H+LMIEDH1USC9Kr8LT5h5aVbnBw4nZ2pcwYDQaTtV5XZv8o4A4EIoOSr/uB1shUt6N5oZ++gIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=pDLC+FLf; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c4300518bso2902296d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 05:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707311291; x=1707916091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsvoQxJKgykHPmELvvoo0iWdxFiWSLC86SAFUlR5Bv0=;
        b=pDLC+FLfeJjrKP0bZJlF3ydUYL+1VI32q39fxVeqnHlVGTcbm/p0H6u4eteACwTVR4
         OyvQR4SA6TLKMcLEk8nX4rtxRri2TcJFlzs8ztSm4Gb0o+VQG5BhLazzhVqfmjtDBuZE
         evYrPgrQgLNJ+e6Jfx6U+9kGf2ErptMA5/9UARZ3msRblIxG1NswpOtJ2+4k+3iLjvSo
         bnbfTKIWZL3bFV1LU5M6KOSIchinwEdaVGwlqU24XLUC6s2jbzsGE+D1HMqA6viZfGMA
         gjc+puOmtamXE4aT/R6R+vYuZubUxbAtT85RhwWrhXBH9CFbJXf5D4UOwVhb4RHEuhSg
         K6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707311291; x=1707916091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TsvoQxJKgykHPmELvvoo0iWdxFiWSLC86SAFUlR5Bv0=;
        b=KNydbmFNso++RQRCej1fbqaTvy4tC/sV546b2gyHUM/BLRvOfCPt9DQgZP1rgCNP9Y
         +9R0SG6QtgLaCGTAiVxRcWTNLxAyamV5mIWrO/seH3+GJBdWYgZHNS+xHz/+MgOkj0vV
         PD9tB7KE9KxvUvENIMFnLUGqITibhLFyVNBuVZnDpyJ6tPWMr06JiXKjbHfmyasWPtYQ
         S+65oEvOb7Gn9L6bhxvWwuDrMvOj5ZdtQSK15qdD2tHyfBssOe6AuPglXPepgyTM8rui
         Y+cRsdHi3E0lID6JnyR1f5pQSr2cPSZc5XATOfQVACPLEGXIMqe9xobxE5K0LgZJYVvq
         IIZQ==
X-Gm-Message-State: AOJu0YyoWhK2bRT7Yne9uBn7B5Fi0iPwdUksb0fm8y+IGFukUDi41Tl/
	sSErlltEsz7nW02EoiGhqQ1nke5qVQYWoitWD4QU37LrCwnPwr6hnrQOBVH8h7PFSUTkYA7zQcj
	a
X-Google-Smtp-Source: AGHT+IE+1BpA3a7UCsei6NH8TOTfZC9qzEwrFAKnlPA8aeHqcsri31Sbdl6+8CgI9cHbpcy4LG2yEA==
X-Received: by 2002:a05:6214:29c9:b0:68c:a6e3:4db9 with SMTP id gh9-20020a05621429c900b0068ca6e34db9mr7021485qvb.57.1707311290933;
        Wed, 07 Feb 2024 05:08:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXhGi7Rh/av6SAxjEZKo61ucV9ac9cE013IgHnUT4qbvYPO/o69rvKfzj1nKmYnBh8eIVWtftlmXfIWJiCfr1aNYD9mdnotCXqzvfRj11Qu5GtbQGS2R3qjMHxcV05DnGUZr+IcIL7i4fSwT8tAHbGoMe8i250QKEoCLy2IZYe+8TYDFbGF7uT1XG5BypZ93el7z68uGlVO4iiJd+QfgviHPhu3lpmKcx2izAe8gpj6Mc75aPG5+90qFBd3fEY8tNQkz4Jo700Qfz8W5hXb/cEQuakWWHYHHJW18eqOczNyWF4+BQP+HTl0TmPUFbLop0AXSy/yEOQGjbtcg5ayW42KUBUiYHKFmiaSaMjNw0bxrfEHCWJvOSPax8s6oBiQB6YlNNfK1VGeKSenb0Qa3t7FZyL1HfxryV0kDXXAOMeyqbPh7KxtNTEuTfbmSGYqzr7bmyv14GlwHzVlE6OeX7XnRuqSDv+d1JMQdar43tFGSqgREyjVBV5Vq2Ji4B1rpdYH9E8TuxlGWA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.114])
        by smtp.gmail.com with ESMTPSA id a17-20020a0ca991000000b0068c9cd2cf88sm565455qvb.60.2024.02.07.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 05:08:10 -0800 (PST)
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
Subject: [PATCH v5 4/9] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Wed,  7 Feb 2024 15:07:40 +0200
Message-Id: <20240207130745.1783198-5-claudiu.beznea.uj@bp.renesas.com>
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

pm_runtime_put() may return an error code. Check its return status.

Along with it the rzg2l_wdt_set_timeout() function was updated to
propagate the result of rzg2l_wdt_stop() to its caller.

Fixes: 2cbc5cd0b55f ("watchdog: Add Watchdog Timer driver for RZ/G2L")
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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


