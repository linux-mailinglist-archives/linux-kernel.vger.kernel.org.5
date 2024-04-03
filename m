Return-Path: <linux-kernel+bounces-130619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48946897A9D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0387528583B
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 21:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD82A156679;
	Wed,  3 Apr 2024 21:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YctJEJAR"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF082C683;
	Wed,  3 Apr 2024 21:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712179483; cv=none; b=UPq6S231GHVd27CQLLdEiibB6kI9J6QGtHXBvIxAhCyY4I9o2FZotKRJ3J2nzd+Hk/J3ugrr7dYKI5lcLXZo++1L71Bwc3b4Tyz2sXmZabIBqNgYaw5hOZpi9qM1mvPImldDKlj8d6CPe5Z6k3IJnXPhIjoaaI+K2Mixk7mM370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712179483; c=relaxed/simple;
	bh=1TlP7tfuRkJTb4XoahhY0tQ8NEmaAo2KqRI7vJSzLcw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQReAAl5cCGLQo1Ogbv2LxfRTIMxXR5EVI2BNtAwHc4g8qVsF+5lcU9UXxnveplFHGuJurD4JZUzxAsr9v1hT7VjXXhqaJod28QNZcBVevlGp2MsA4ujjsptuDE5lkLCUR3lCVXmGFo+EYHVXpegEi26fh2DVj84BLW/cQY34Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=YctJEJAR; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 433LOQ5E048322;
	Wed, 3 Apr 2024 16:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712179466;
	bh=whB614MwmgUgmaq9BLDly5u4OTIz4n2TQUmWWW3dLy8=;
	h=From:To:Subject:Date;
	b=YctJEJAR6t2e7vYpRUWtEiDwRWp1thDBQta0cExuuxNEysrldae9jn1wRSmO88dwT
	 QUhD9CyBQB6ZR+nRzeegyDeknSiLMxTkU3ocS12f3wpeLKn9t81GC/S8xxlIM08A+4
	 z+Wu1knFJh0EYqCYL1YSPuR3cc4FNBrWKClD4jBA=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 433LOQwY005837
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 3 Apr 2024 16:24:26 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 3
 Apr 2024 16:24:26 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 3 Apr 2024 16:24:26 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 433LOQO3031686;
	Wed, 3 Apr 2024 16:24:26 -0500
From: Judith Mendez <jm@ti.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
	<linux@roeck-us.net>, <linux-watchdog@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate 5% safety margin
Date: Wed, 3 Apr 2024 16:24:26 -0500
Message-ID: <20240403212426.582727-1-jm@ti.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

On AM62x, the watchdog is pet before the valid window
is open. Fix min_hw_heartbeat and accommodate a 5% safety
margin with the exception of open window size < 10%,
which shall use <5% due to the smaller open window size.

Signed-off-by: Judith Mendez <jm@ti.com>
---
 drivers/watchdog/rti_wdt.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 8e1be7ba0103..0b16ada659cc 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -92,7 +92,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 	 * to be 50% or less than that; we obviouly want to configure the open
 	 * window as large as possible so we select the 50% option.
 	 */
-	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
+	wdd->min_hw_heartbeat_ms = 550 * wdd->timeout;
 
 	/* Generate NMI when wdt expires */
 	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
@@ -126,31 +126,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
 	 * be petted during the open window; not too early or not too late.
 	 * The HW configuration options only allow for the open window size
 	 * to be 50% or less than that.
+	 * To avoid any glitches, we accommodate 5% safety margin, with the
+	 * exception of open window size < 10%.
 	 */
 	switch (wsize) {
 	case RTIWWDSIZE_50P:
-		/* 50% open window => 50% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
+		/* 50% open window => 55% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 550 * heartbeat;
 		break;
 
 	case RTIWWDSIZE_25P:
-		/* 25% open window => 75% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
+		/* 25% open window => 80% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 800 * heartbeat;
 		break;
 
 	case RTIWWDSIZE_12P5:
-		/* 12.5% open window => 87.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
+		/* 12.5% open window => 92.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 925 * heartbeat;
 		break;
 
 	case RTIWWDSIZE_6P25:
-		/* 6.5% open window => 93.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
+		/* 6.5% open window => 96.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 965 * heartbeat;
 		break;
 
 	case RTIWWDSIZE_3P125:
-		/* 3.125% open window => 96.9% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
+		/* 3.125% open window => 97.9% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 979 * heartbeat;
 		break;
 
 	default:
-- 
2.43.2


