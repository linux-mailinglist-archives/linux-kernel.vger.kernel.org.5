Return-Path: <linux-kernel+bounces-149228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E53B8A8D5F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 22:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA42A1F2172D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5999F481BB;
	Wed, 17 Apr 2024 20:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FDJTSrq2"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F15F52F6B;
	Wed, 17 Apr 2024 20:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713387440; cv=none; b=Cgxq0ZJQMC21qAT5sHki0CtyYltuh9xDsx67Vp+M6pucgHaYl0i5FcOlmGoNG1yBIizKMuXxFxyGZBKodnMPyV7EArnrr3ytbgEgrWFGIr5oyq4HpDUsScVbot7p/x0MB2WTAFSe7hwAsp1wLoC+xrYtROetbxvySlPYhlV8BBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713387440; c=relaxed/simple;
	bh=BPdpGyW1F/Eojz4Os/i9vRYjSRgNet0NXz4BiUZ19RY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nqSl+iGxbH6jAEM9jaSpk8YP+LswIK5W0apGQ4ChJoj72IpW9bS11TnfPbgCq4Bh7U7PyRCgOHMESbVK/ZIyo+aw/dqDMBs3gs46jky0C0SX1nQze/FbsaOAAUVDMKUxzMbayNmlgrR6tBF7BcNvmQMqpepOks17wYjNQpU6VDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FDJTSrq2; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 43HKv0uN005769;
	Wed, 17 Apr 2024 15:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1713387420;
	bh=S95d30u0MX9I2P7CepbqjsFGIsPWOe4MadM11Qo/Kn4=;
	h=From:To:CC:Subject:Date;
	b=FDJTSrq2FlVPCa0YMrynwY/rYGqFP9yVdlkOL6S5VCm+In+tjTXnWucWWcEGuNGLK
	 302z+bQcX6W9ilJ+WdJFVxGYRmggFPlkI8HhLzuwTLxxbLGvykS0CPnBWbL8E0siUT
	 m1ozGP16IiLBdE9fzYiPZsyB08UqHOSB6dokPHlM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 43HKv0gJ005616
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 17 Apr 2024 15:57:00 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 17
 Apr 2024 15:57:00 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 17 Apr 2024 15:57:00 -0500
Received: from judy-hp.dhcp.ti.com (judy-hp.dhcp.ti.com [128.247.81.105])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 43HKv0ad071011;
	Wed, 17 Apr 2024 15:57:00 -0500
From: Judith Mendez <jm@ti.com>
To: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck
	<linux@roeck-us.net>
CC: <linux-watchdog@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rafael
 Beims <rafael.beims@toradex.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nick
 Saulnier <nsaulnier@ti.com>
Subject: [PATCH v3] watchdog: rti_wdt: Set min_hw_heartbeat_ms to accommodate a safety margin
Date: Wed, 17 Apr 2024 15:57:00 -0500
Message-ID: <20240417205700.3947408-1-jm@ti.com>
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

On AM62x, the watchdog is pet before the valid window is open. Fix
min_hw_heartbeat and accommodate a 2% + static offset safety margin.
The static offset accounts for max hardware error.

Remove the hack in the driver which shifts the open window boundary,
since it is no longer necessary due to the fix mentioned above.

cc: stable@vger.kernel.org
Fixes: 5527483f8f7c ("watchdog: rti-wdt: attach to running watchdog during probe")
Signed-off-by: Judith Mendez <jm@ti.com>
---
Changes since v2:
- Change safety margin to 2% + max hardware error
- remove hack that shifts open window boundary
---
 drivers/watchdog/rti_wdt.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/watchdog/rti_wdt.c b/drivers/watchdog/rti_wdt.c
index 8e1be7ba01039..c7d4de28e1891 100644
--- a/drivers/watchdog/rti_wdt.c
+++ b/drivers/watchdog/rti_wdt.c
@@ -59,6 +59,8 @@
 #define PON_REASON_EOF_NUM	0xCCCCBBBB
 #define RESERVED_MEM_MIN_SIZE	12
 
+#define MAX_HW_ERROR		250
+
 static int heartbeat = DEFAULT_HEARTBEAT;
 
 /*
@@ -92,7 +94,7 @@ static int rti_wdt_start(struct watchdog_device *wdd)
 	 * to be 50% or less than that; we obviouly want to configure the open
 	 * window as large as possible so we select the 50% option.
 	 */
-	wdd->min_hw_heartbeat_ms = 500 * wdd->timeout;
+	wdd->min_hw_heartbeat_ms = 520 * wdd->timeout + MAX_HW_ERROR;
 
 	/* Generate NMI when wdt expires */
 	writel_relaxed(RTIWWDRX_NMI, wdt->base + RTIWWDRXCTRL);
@@ -126,31 +128,33 @@ static int rti_wdt_setup_hw_hb(struct watchdog_device *wdd, u32 wsize)
 	 * be petted during the open window; not too early or not too late.
 	 * The HW configuration options only allow for the open window size
 	 * to be 50% or less than that.
+	 * To avoid any glitches, we accommodate 2% + max hardware error
+	 * safety margin.
 	 */
 	switch (wsize) {
 	case RTIWWDSIZE_50P:
-		/* 50% open window => 50% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 500 * heartbeat;
+		/* 50% open window => 52% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 520 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_25P:
-		/* 25% open window => 75% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 750 * heartbeat;
+		/* 25% open window => 77% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 770 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_12P5:
-		/* 12.5% open window => 87.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 875 * heartbeat;
+		/* 12.5% open window => 89.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 895 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_6P25:
-		/* 6.5% open window => 93.5% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 935 * heartbeat;
+		/* 6.5% open window => 95.5% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 955 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	case RTIWWDSIZE_3P125:
-		/* 3.125% open window => 96.9% min heartbeat */
-		wdd->min_hw_heartbeat_ms = 969 * heartbeat;
+		/* 3.125% open window => 98.9% min heartbeat */
+		wdd->min_hw_heartbeat_ms = 989 * heartbeat + MAX_HW_ERROR;
 		break;
 
 	default:
@@ -228,14 +232,6 @@ static int rti_wdt_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	/*
-	 * If watchdog is running at 32k clock, it is not accurate.
-	 * Adjust frequency down in this case so that we don't pet
-	 * the watchdog too often.
-	 */
-	if (wdt->freq < 32768)
-		wdt->freq = wdt->freq * 9 / 10;
-
 	pm_runtime_enable(dev);
 	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {

base-commit: 860bbe8e618fd62446309e286ab4a83d38201c0a
-- 
2.43.2


