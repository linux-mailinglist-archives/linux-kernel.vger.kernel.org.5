Return-Path: <linux-kernel+bounces-54442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 157D884AF4D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 08:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A605AB22C4B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 07:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BA612BE9A;
	Tue,  6 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="V0FnSxEA"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1237912B163
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 07:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707205936; cv=none; b=ho80cj0Xg+bJrbXGQqqm2EbPe+1D9ER6bLsw8VIo4nzXKzfDvNAXimnd/kbe2h/NCPkiaFQArsAsETSTju+SIgLL1WRX60wNZQuydJPGvK3f/LCeaNRY1mMLKAe0zHFWhoSt+vNDXRovFMFsJ6Ys58S1M8H0wnzQgzZ/y5V+UPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707205936; c=relaxed/simple;
	bh=mLelyBkyuyFverkkcIquXrmPZYtG0kwJVVl+lchEO+M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TipPJ5us1jzbTFK8WT5uAIAn9J2c0S1sW657IIwrZq2S+zkGIbCnYAZlqKdghbNW4T26oCE2RmBG5svfGh8Kr/ZoHeg8ZYO2HAPcCkXL5J2mJI5pnxqobrlcjn0SG9jmJtZbz4VMIHVA/AXikqwhYE/0aEAEc4tHZOPHdncMcsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=V0FnSxEA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40fe282b8e2so2808745e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 23:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1707205933; x=1707810733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5TQVsyURVXYWvZQZ0JKh4DsPsNlPoBBRywd6S3RYjkk=;
        b=V0FnSxEAO3Oiad1V6n+WZqKSePRiHD8ed24hj34S/yXhmwCtB8CrumKEWKWP24jN41
         xs0EluvA89b+hOTXUw58eToLUfOlJdVbLJTwBohSx1FrlBCPfFZwZzrAHhpy4tPty9Dr
         JgICnQqlNXIudEgLJJevSoy6PjZtI68YgI3mJCw7CA3W/+vYAvgMQU1AmvROGJe8Jdxy
         XKUKM9MX1LXZJyZCJJ9dFLarBSFmI1m8Uvl3QWemF6S4G1FLEaCmcplZZ7TRbTxwbVIY
         IK7FE6NTCZoP7INepmxu2pE0KV3cVBWHoQHbP5Pc1FD6C+BKzctahURngDcPSVn/Yeaa
         FDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707205933; x=1707810733;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5TQVsyURVXYWvZQZ0JKh4DsPsNlPoBBRywd6S3RYjkk=;
        b=ez5xCtOgb1Gqy+Zx0u/IFv/ZC6RKg2O+XNaFkz2lnsXOTqUZmIpgohHiftWmh1h0E4
         urV1lSpccj1G5XkBmYIq1l2SqZR5Wcp5vIKuTPYBnSzhjR7csoKKXE1+d0MGt6ZZOoxZ
         xSgSYvtfYn6Ro9P3ylNutdq670YzAi4ZqOzCJDI+fFY95LOpuuh+nJzqjtMo2r/zCcGT
         9cXEv8lEiKT/SI4RgrPpsJVgtslU6zru6BFvP2yD01siBkHNwrE7ukyfa8hHATnKcyHC
         s0yP+HTVeBOuYWlO3xU4X/XxNmUrHy050ZZkVSoWIxJJaL+10LmvIHHDBp+YiX0qS+CH
         /NlA==
X-Forwarded-Encrypted: i=1; AJvYcCXwto5C9QNa/Wi8oXLaD7gBSgCAZKhcQvEdaIZcyc5Lu4U4sCP+ApeUs831SMoLY3Nv0oh8BdqGtOl0Ag/nJsHo5nhzxNjZisw507Um
X-Gm-Message-State: AOJu0YxYe+LeOUEgTZY4Yv3M0yH4Kee4+FxK0hQyx5ROpn43LWEEJJeC
	Ub/Rrd5vZM0B+aEsOHTmgUoByOamR6pPLoZMshptRCDza1Rgn1UsbcjikvawhQY=
X-Google-Smtp-Source: AGHT+IF2hu+HYTkUA3Xeq4/F0rpidNJKCMx9eLAyHCYr3GH++WApVdk9tGJXhZPoyIbM9o2+nQVyog==
X-Received: by 2002:a05:600c:4449:b0:40f:c234:1fd5 with SMTP id v9-20020a05600c444900b0040fc2341fd5mr1076050wmn.11.1707205933334;
        Mon, 05 Feb 2024 23:52:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWTBSd5+O4aUmf4Rowz1MTAnp5CW/gR3BNlTYDsW3bFIEXIIuVfmkNX0BHBYghmOuE5uYwOwTZVJ4ZgqPzimfIf4g+0GgFcPQH1dQBpp27HAsfnwexE+QoDr7sliyZdo+lc3r8dDu+0IALif+/5q2eEHJRQ6LwdENU/MWUQfNx/s8WHXYfvCBhgPc6BNKIbxBkeZfRWZsMAfp9MEvNJH8lcvmrjdxm7LRR2bSTEQUYIctobGDxcY5+R/bLsp6rWO+YUylv3P0/NDP2stnoFdm8D0Jz4c00SiIYJk10aVOvPxVmI7XuBGw60R1Lx0okyheXJQMeiVegwP2T3GOkYnFTqBQgIlBU4hgaAmPmwa4yZuBJm/Y6TgNsRWd5UUbrfnwpKS1WOqS9zIp/Ocy0K0qb+oOYNbOudfbMaVtiIkUXaw4lecAWOXuXC6FaUGvwnEFuBkNjVQaL9Jzq7/yA8uMgXU/DBrlmyfn8fjE6JVOoiDvyqBN8LZGQg0ssXZjgU8cfTh4NclpU1TA==
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.154])
        by smtp.gmail.com with ESMTPSA id j32-20020a05600c1c2000b0040fbad272f6sm1106843wms.46.2024.02.05.23.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 23:52:13 -0800 (PST)
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
Subject: [PATCH v4 4/9] watchdog: rzg2l_wdt: Check return status of pm_runtime_put()
Date: Tue,  6 Feb 2024 09:51:44 +0200
Message-Id: <20240206075149.864996-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
References: <20240206075149.864996-1-claudiu.beznea.uj@bp.renesas.com>
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


