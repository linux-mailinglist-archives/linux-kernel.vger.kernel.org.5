Return-Path: <linux-kernel+bounces-105732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585B887E397
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 07:07:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40A531C20E39
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 06:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57067249FA;
	Mon, 18 Mar 2024 06:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="W35K4ywy"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1148922EE0;
	Mon, 18 Mar 2024 06:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710742014; cv=none; b=diEss45mhLaf+upXgrMSDiosLHZMJtEm/zfqwC1bqlUmD5GjA1bZnVNRQxQsOtptMcRvEHFmUJ2nUSySOUKIJU2+P/vQ0KGugN/G89Bh8UPRJGGijbeVYXu2pMXV/TGjjYTJVOcX9zfuZaG/ysG4EP56wcO4mlF4tzDzsToVKQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710742014; c=relaxed/simple;
	bh=jaZkv8i6NdJT+wHMF9ub75fSWECjyHOvXBytAWOA6+I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S+DaVBAABvcQYH7NZnf7yQcTJ4VZKHXmn+ARvgtM7NggLcsRTA+3JLEIcc4ti3LHQ8cej34RaRE+S9dmGSec4w8xQjTE1A7vbryo2qdP5JgXkiIAZWP8dEzIHS0Iy4VRlE1BXVZ1X/WxXzRSCMpW1d+4tJs57Uw1KnVM5Pi2Ge0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=W35K4ywy; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tVCW053441;
	Mon, 18 Mar 2024 00:55:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710741331;
	bh=IIMeYQhVJsMjHJOrO1EdAXLf7xCV4g1QUz3hfpcGY/A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=W35K4ywypteT3P3yrYzqpECRvbU8xZwd+e/ZAmGW/bc8CCfEK8vtTd48hP1gNPyfq
	 oR4OTqJ4ZuVw7Fgmk3TxxMfDNiA+LYmNl/TH1EXrgSd5fMqK7VuTI606pbbwof4fPm
	 c9U7T7JAQR1zGA5C6aE6f4S4ZAzUmh3swquGUlYs=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42I5tVNx016614
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 00:55:31 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 00:55:30 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 00:55:30 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42I5tKiF082113;
	Mon, 18 Mar 2024 00:55:27 -0500
From: Dhruva Gole <d-gole@ti.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        "Rafael J. Wysocki"
	<rafael@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH 1/3] PM: wakeup: make device_wakeup_disable return void
Date: Mon, 18 Mar 2024 11:20:52 +0530
Message-ID: <20240318055054.1564696-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318055054.1564696-1-d-gole@ti.com>
References: <20240318055054.1564696-1-d-gole@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

The device_wakeup_disable call only returns an error if no dev exists
however there's not much a user can do at that point.
Rather make this function return void.

Signed-off-by: Dhruva Gole <d-gole@ti.com>
---
 drivers/base/power/wakeup.c | 11 +++++++----
 include/linux/pm_wakeup.h   |  5 ++---
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index a917219feea6..752b417e8129 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -451,16 +451,15 @@ static struct wakeup_source *device_wakeup_detach(struct device *dev)
  * Detach the @dev's wakeup source object from it, unregister this wakeup source
  * object and destroy it.
  */
-int device_wakeup_disable(struct device *dev)
+void device_wakeup_disable(struct device *dev)
 {
 	struct wakeup_source *ws;
 
 	if (!dev || !dev->power.can_wakeup)
-		return -EINVAL;
+		return;
 
 	ws = device_wakeup_detach(dev);
 	wakeup_source_unregister(ws);
-	return 0;
 }
 EXPORT_SYMBOL_GPL(device_wakeup_disable);
 
@@ -502,7 +501,11 @@ EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
  */
 int device_set_wakeup_enable(struct device *dev, bool enable)
 {
-	return enable ? device_wakeup_enable(dev) : device_wakeup_disable(dev);
+	if (enable)
+		return device_wakeup_enable(dev);
+
+	device_wakeup_disable(dev);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_enable);
 
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 6eb9adaef52b..428803eed798 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -107,7 +107,7 @@ extern void wakeup_sources_read_unlock(int idx);
 extern struct wakeup_source *wakeup_sources_walk_start(void);
 extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
-extern int device_wakeup_disable(struct device *dev);
+extern void device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
 extern int device_set_wakeup_enable(struct device *dev, bool enable);
 extern void __pm_stay_awake(struct wakeup_source *ws);
@@ -154,10 +154,9 @@ static inline int device_wakeup_enable(struct device *dev)
 	return 0;
 }
 
-static inline int device_wakeup_disable(struct device *dev)
+static inline void device_wakeup_disable(struct device *dev)
 {
 	dev->power.should_wakeup = false;
-	return 0;
 }
 
 static inline int device_set_wakeup_enable(struct device *dev, bool enable)
-- 
2.34.1


