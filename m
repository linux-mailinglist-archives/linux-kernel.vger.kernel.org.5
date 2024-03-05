Return-Path: <linux-kernel+bounces-93051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BD60872A22
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 23:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB513B268FA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA86C12D768;
	Tue,  5 Mar 2024 22:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JLnwv52E"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E74F12D201
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709677325; cv=none; b=AzNRRXjmiBbr56eepf+WcVOmsFlU0z+2AAiGgSyvyho+buDOs9yd0dLCkVMB6FBdLwGO0boML3ORRhrnqobRDxqsbiKn9P4oKaeM1DqrJ440WnbWAeYTdZxIomGJd7Cp1JpbdBhn/tJe2yCOvC9EoEz8138AqNQCaMuC0xCinrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709677325; c=relaxed/simple;
	bh=DRDImxWl8vn15NlvIm9eIMlnD+dji8ldOjVhWtbbgSQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ovx7Hpr+VdbPDBAZXyhg08559MHKsqEB00pDcmXap1U6fYB2UqlGKe/aBa5zkuyOLwyUp+/sHwcvMtn6hmh8CktU8MbOgaYdX5aXGQwT0hg/UTPQllK4FBEn+EH9hS49K/x0EKUrEqJhNs+rbSLNaWJERxDvSDqSABvs9UKfD8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JLnwv52E; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709677321;
	bh=DRDImxWl8vn15NlvIm9eIMlnD+dji8ldOjVhWtbbgSQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JLnwv52E58pFQiAQQYV3pIwlCdxHeWne9Vmxa8yhIQFo6RR7b6qDKT15NuW2monqX
	 7WUJEh8+3bwiWRDZ9438U0vbcvv+htFCBNyv9GbGUAU54CIUtXyAPyWAlP6cDAapGj
	 BCkTEkr2JRWSpl3xMWe/vRdUIC6NlHoiYca+DeQgFELBur54n1/gpSHnTDAO3JTcGs
	 Cc5auHRH4USZgFzAiW5J3G0EGNXgQCpO0SD0kaYkxReW4YYAPsL6s96UNIqF/cakNH
	 vVV5oMAfbX8caDIEks42CW6oW408pGPaxNe+MuD5FqZWdTTNNknLI9Ks/DZ1FJNcgF
	 EAeU1IJKCDmHA==
Received: from [192.168.1.241] (zone.collabora.co.uk [167.235.23.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: nfraprado)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A769D3782089;
	Tue,  5 Mar 2024 22:22:00 +0000 (UTC)
From: =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
Date: Tue, 05 Mar 2024 17:21:37 -0500
Subject: [PATCH 2/3] driver: core: Use dev_* instead of pr_* so device
 metadata is added
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240305-device-probe-error-v1-2-a06d8722bf19@collabora.com>
References: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
In-Reply-To: <20240305-device-probe-error-v1-0-a06d8722bf19@collabora.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 =?utf-8?q?N=C3=ADcolas_F=2E_R=2E_A=2E_Prado?= <nfraprado@collabora.com>
X-Mailer: b4 0.13.0

Use the dev_* instead of the pr_* functions to log the status of device
probe so that the log message gets the device metadata attached to it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
---
 drivers/base/dd.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/base/dd.c b/drivers/base/dd.c
index 0b7cf4516796..d6e7933e2521 100644
--- a/drivers/base/dd.c
+++ b/drivers/base/dd.c
@@ -397,13 +397,12 @@ bool device_is_bound(struct device *dev)
 static void driver_bound(struct device *dev)
 {
 	if (device_is_bound(dev)) {
-		pr_warn("%s: device %s already bound\n",
-			__func__, kobject_name(&dev->kobj));
+		dev_warn(dev, "%s: device already bound\n", __func__);
 		return;
 	}
 
-	pr_debug("driver: '%s': %s: bound to device '%s'\n", dev->driver->name,
-		 __func__, dev_name(dev));
+	dev_dbg(dev, "driver: '%s': %s: bound to device\n", dev->driver->name,
+		__func__);
 
 	klist_add_tail(&dev->p->knode_driver, &dev->driver->p->klist_devices);
 	device_links_driver_bound(dev);
@@ -587,8 +586,8 @@ static int call_driver_probe(struct device *dev, struct device_driver *drv)
 		break;
 	case -ENODEV:
 	case -ENXIO:
-		pr_debug("%s: probe of %s rejects match %d\n",
-			 drv->name, dev_name(dev), ret);
+		dev_dbg(dev, "probe with driver %s rejects match %d\n",
+			drv->name, ret);
 		break;
 	default:
 		/* driver matched but the probe failed */
@@ -620,8 +619,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 	if (link_ret == -EPROBE_DEFER)
 		return link_ret;
 
-	pr_debug("bus: '%s': %s: probing driver %s with device %s\n",
-		 drv->bus->name, __func__, drv->name, dev_name(dev));
+	dev_dbg(dev, "bus: '%s': %s: probing driver %s with device\n",
+		drv->bus->name, __func__, drv->name);
 	if (!list_empty(&dev->devres_head)) {
 		dev_crit(dev, "Resources present before probing\n");
 		ret = -EBUSY;
@@ -644,8 +643,7 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 
 	ret = driver_sysfs_add(dev);
 	if (ret) {
-		pr_err("%s: driver_sysfs_add(%s) failed\n",
-		       __func__, dev_name(dev));
+		dev_err(dev, "%s: driver_sysfs_add failed\n", __func__);
 		goto sysfs_failed;
 	}
 
@@ -706,8 +704,8 @@ static int really_probe(struct device *dev, struct device_driver *drv)
 		dev->pm_domain->sync(dev);
 
 	driver_bound(dev);
-	pr_debug("bus: '%s': %s: bound device %s to driver %s\n",
-		 drv->bus->name, __func__, dev_name(dev), drv->name);
+	dev_dbg(dev, "bus: '%s': %s: bound device to driver %s\n",
+		drv->bus->name, __func__, drv->name);
 	goto done;
 
 dev_sysfs_state_synced_failed:
@@ -786,8 +784,8 @@ static int __driver_probe_device(struct device_driver *drv, struct device *dev)
 		return -EBUSY;
 
 	dev->can_match = true;
-	pr_debug("bus: '%s': %s: matched device %s with driver %s\n",
-		 drv->bus->name, __func__, dev_name(dev), drv->name);
+	dev_dbg(dev, "bus: '%s': %s: matched device with driver %s\n",
+		drv->bus->name, __func__, drv->name);
 
 	pm_runtime_get_suppliers(dev);
 	if (dev->parent)

-- 
2.44.0


