Return-Path: <linux-kernel+bounces-106281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD22087EBDF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:18:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3315EB2140C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A594F206;
	Mon, 18 Mar 2024 15:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ovQlWTwu"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B1D4EB46;
	Mon, 18 Mar 2024 15:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775069; cv=none; b=q5HzFGtP33FoKrt+IurBCnMnxVjVgHsleGsf7FoDqUQDO9fs2IU91Wm4Ug5wXoK2YR5NSCL+ypqPYDVzSz04whLSWAvqHuIfx+PjDqvelOaar+idgWgS/63xEYpxP+dHHK3+zzWIHLO2jcdAipLXiSPva35yveUwv2SHh3RU+wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775069; c=relaxed/simple;
	bh=y/KV7IDnVF/uSieuLOjwbN5xyNqyrgWGuEXefd4dk3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jNL0cqyevKRWPOp8UTE3n6HaxZKro07C3obLUKz3jb/5tcrUY+D4bUYeqApwCl2yLhjYoCsnXfgE34xHXuWtZl6+g26Dz9zwbSTxXJ+yP7dsDqIImza7fkzJqWtMswiGYzS/GZcyF8orD4hOlcFpUUPfXlE1WcuNUj7+xB8JvCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ovQlWTwu; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 42IFHSPQ031688;
	Mon, 18 Mar 2024 10:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1710775048;
	bh=s1A/rACeOI/xak+PzvcBoHYT3X7oUiCFIvMILHl9lXA=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=ovQlWTwujoUGCVcLSgXopVVmVcYrjLS4zBi39wPHWh7YuE6S5moH7otiWad6Q22gP
	 PMFIRUtxgydCfnELFQ9B2U/aoqRlft1v/hJU5xHEVK7q39tXKhvgWnYpOMhOua94Dy
	 snp9i/fVkLZvkFQt97WYHe2jA2Rerfa+B2LvV0sM=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 42IFHSuo031947
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Mar 2024 10:17:28 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Mar 2024 10:17:28 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Mar 2024 10:17:28 -0500
Received: from dhruva.dhcp.ti.com (dhruva.dhcp.ti.com [172.24.227.68])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 42IFH8GS095329;
	Mon, 18 Mar 2024 10:17:25 -0500
From: Dhruva Gole <d-gole@ti.com>
To: "Rafael J . Wysocki" <rafael@kernel.org>
CC: Tony Lindgren <tony@atomide.com>, Len Brown <len.brown@intel.com>,
        Pavel
 Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, <theo.lebrun@bootlin.com>,
        Dhruva
 Gole <d-gole@ti.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
Subject: [PATCH V2 1/2] PM: wakeup: make device_wakeup_disable return void
Date: Mon, 18 Mar 2024 20:46:32 +0530
Message-ID: <20240318151631.1621881-2-d-gole@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240318151631.1621881-1-d-gole@ti.com>
References: <20240318151631.1621881-1-d-gole@ti.com>
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
 drivers/base/power/wakeup.c       | 11 +++++++----
 drivers/mmc/host/sdhci-pci-core.c |  2 +-
 include/linux/pm_wakeup.h         |  5 ++---
 3 files changed, 10 insertions(+), 8 deletions(-)

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
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 025b31aa712c..ef89ec382bfe 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -63,7 +63,7 @@ static int sdhci_pci_init_wakeup(struct sdhci_pci_chip *chip)
 	if ((pm_flags & MMC_PM_KEEP_POWER) && (pm_flags & MMC_PM_WAKE_SDIO_IRQ))
 		return device_wakeup_enable(&chip->pdev->dev);
 	else if (!cap_cd_wake)
-		return device_wakeup_disable(&chip->pdev->dev);
+		device_wakeup_disable(&chip->pdev->dev);
 
 	return 0;
 }
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


