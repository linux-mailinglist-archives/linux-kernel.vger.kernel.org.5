Return-Path: <linux-kernel+bounces-131730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95367898B2F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:33:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 838801C25D95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD07129A75;
	Thu,  4 Apr 2024 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="xP+IHdHo"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F21CB32C8E;
	Thu,  4 Apr 2024 15:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712244816; cv=none; b=pQ/vqhaTen38XjwyLYRt93bW7OY8QFy2BYbLWfC1S4+nOMKCTvw2wIIWZYCpzpyu6s72W23OI1+YCAUyr85lfo/SofC9X5Vo99Q9UqsaQriVFQ38TRPqvC5r5YTD6uogpuIli+lvhVKDiGy0is4TQnd79RDD24SKKOqgmTW8Bks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712244816; c=relaxed/simple;
	bh=mMkr/dYqLpU1MsD5m4UuvQAkxg99rgTMBcVYr7tcEA4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sIfyiUMsiLuH77jwJ7TwKWpaD5qRcNltGWgDf+/6INA+ekr1J1FpZeS4WH32aKJ+qSUwaiyFpdEMzrwLxv290fdscimOiqGS/tKdWUJiraaZDKyNTNlOjz1oDmmxHiMR9Z7B8Nt1/Gs+IkDOSLWKEH3fqiKAiaBuXgFQZnPiZIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=xP+IHdHo; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 434FXJMJ074202;
	Thu, 4 Apr 2024 10:33:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1712244799;
	bh=ML1mhSa9Q7+kMHMImeTyEWgHXR1D+6Svt3w13mxjqjY=;
	h=From:To:CC:Subject:Date;
	b=xP+IHdHov6//Cdt7T63m8IxZ9iVzgWpfDZjn4k2bj7gi/ygts2ChwLLVkXgziY0tk
	 iQ+o7BPY9jf4IdwsmfgYuofAzfmAHgvTmT/K24EJJY4EQfAHFF2KMoEd8zSgHktwDt
	 yliNm3iersUonXNLqivAp07N0WX25TgVw/95Obos=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 434FXJ9U057162
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 4 Apr 2024 10:33:19 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 4
 Apr 2024 10:33:19 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 4 Apr 2024 10:33:19 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 434FXJma015284;
	Thu, 4 Apr 2024 10:33:19 -0500
From: Judith Mendez <jm@ti.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
	<linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Francesco Dolcini <francesco@dolcini.it>
Subject: [PATCH v2] watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate 5% safety margin
Date: Thu, 4 Apr 2024 10:33:19 -0500
Message-ID: <20240404153319.1088644-1-jm@ti.com>
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

cc: stable@vger.kernel.org
Fixes: 5527483f8f7c (" watchdog: rti-wdt: attach to running watchdog during probe")
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

base-commit: 860bbe8e618fd62446309e286ab4a83d38201c0a
-- 
2.43.2


