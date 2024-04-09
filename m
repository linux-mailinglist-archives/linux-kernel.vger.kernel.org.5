Return-Path: <linux-kernel+bounces-137363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9C789E10B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 19:05:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2E81C22707
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B16E156C50;
	Tue,  9 Apr 2024 17:03:17 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22408153BCA
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 17:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712682196; cv=none; b=Gdb9NiDmOvOoVffb1+xfUMh/6aZ6Yat4DyourUcPweapupjRlrf20bvaBa91UNhRdlXF50gVOC0s0jesc/s3xCT/aFUDPbuL7HxgVyT+7wsg8KyA8K+yOyGd81BZPflbUuR0aF297s8WNFsTo0mSdjRdkIWnKgfvAfLnKhbjXIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712682196; c=relaxed/simple;
	bh=ABndG8JIksgn48cHu77uEqYHzKk3gEHosBYrXk4plOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=igc6hPYCKT928XTpZ2YW+rKbqvgxcDYF6y9L8bjaz+sW6QxxGHOJSE0qZEmcFsDrwggqZPojrIv3VNQFQHo+XcOPfLgScJqHTIUr9i32GFHOTCRbsid5W2j5WPupLLZ90l8OLUrrWh2qlDXVPo2UsgicnBF0ny7gPV60r8jH4sE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsE-0003vV-DQ; Tue, 09 Apr 2024 19:03:06 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00BKyA-Jo; Tue, 09 Apr 2024 19:03:04 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1ruEsC-00H4tU-1i;
	Tue, 09 Apr 2024 19:03:04 +0200
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Frank Binns <frank.binns@imgtec.com>,
	Matt Coster <matt.coster@imgtec.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] drm/imagination: Convert to platform remove callback returning void
Date: Tue,  9 Apr 2024 19:02:48 +0200
Message-ID:  <4cf10e420863f40a268f26b9bdb0c4b53dbf3406.1712681770.git.u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1930; i=u.kleine-koenig@pengutronix.de; h=from:subject:message-id; bh=ABndG8JIksgn48cHu77uEqYHzKk3gEHosBYrXk4plOk=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBmFXS5X1/FCHSCExcxL8LS22tGseaxbhq9NOL98 FBKiUipqg+JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCZhV0uQAKCRCPgPtYfRL+ TjLgB/9k5p+S6KQ0pkU977hoEldzuUg+zcI+5nFrOVDWJGuHprzAZbbgprrZPcfAnruCB+7DGEd mEgiOBQyoxufd92gxPAbBhctNrqsloBJ07VFrqLJHrRzrd+ICnfQTV9HxDM4VWHbtEC8wcWqJZV YtiUks7oIkqszeSeXgkR81+L2H+BdeYZSnjlOdiAga2XIN//JlFPUUOWNhxdwYFxbEiSKVtFKzY m6/zSwgO7XwGJszab7LafKaui5qyjF5H7unKO3M5KoPFtXCLcu/QAjsyQZAondPwNrxBvjTgw9D mNkJlSYwn81/LTudj46UUA1bnSyD4c+ypRCdZaDVorl4sSgD
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

Trivially convert this driver from always returning zero in the remove
callback to the void returning variant.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/gpu/drm/imagination/pvr_drv.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 5c3b2d58d766..1a0cb7aa9cea 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -1451,8 +1451,7 @@ pvr_probe(struct platform_device *plat_dev)
 	return err;
 }
 
-static int
-pvr_remove(struct platform_device *plat_dev)
+static void pvr_remove(struct platform_device *plat_dev)
 {
 	struct drm_device *drm_dev = platform_get_drvdata(plat_dev);
 	struct pvr_device *pvr_dev = to_pvr_device(drm_dev);
@@ -1469,8 +1468,6 @@ pvr_remove(struct platform_device *plat_dev)
 	pvr_watchdog_fini(pvr_dev);
 	pvr_queue_device_fini(pvr_dev);
 	pvr_context_device_fini(pvr_dev);
-
-	return 0;
 }
 
 static const struct of_device_id dt_match[] = {
@@ -1485,7 +1482,7 @@ static const struct dev_pm_ops pvr_pm_ops = {
 
 static struct platform_driver pvr_driver = {
 	.probe = pvr_probe,
-	.remove = pvr_remove,
+	.remove_new = pvr_remove,
 	.driver = {
 		.name = PVR_DRIVER_NAME,
 		.pm = &pvr_pm_ops,
-- 
2.43.0


