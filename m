Return-Path: <linux-kernel+bounces-134991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA04989B9AC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:06:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272021C220A4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627542C69A;
	Mon,  8 Apr 2024 08:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="envx6Q6E"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADEB29CEA;
	Mon,  8 Apr 2024 08:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712563582; cv=none; b=MqUXX8T45H9EXQ3OLB5VeIcJU8+LcaVga11O/BVEsD9oJcPQMl6hKUGPf05aK8Ia2WcRfQRIqDEwPirI0ZDiihxECWZcQpsx62LldePllfCT6uiafabsFoX2rpFCjgVzigOsqG9IEJzJGNY/x+pieo7wQVQiqs+A8zE1eBPVvVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712563582; c=relaxed/simple;
	bh=TX+FD3p3l4+7566GyF6jvv4HQftl4YsdRmMDigxumnI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bHS2Md8K5wTEFOmuzq92nYCy8nTSCi3AKlJY+KUh3C+n7iRahxZQGZaRopAyh7kSZZ2QcmHld5jvr8MJauYgzV2F8K4LY1Cg0wMqZn6V659/cIo+NLEg5zkr0sUVWQ88HSK/Ubsd9qFKxYDW+ApOre5HKt/LvZ2g5Gv3WsV2NZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=envx6Q6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88523C433C7;
	Mon,  8 Apr 2024 08:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712563582;
	bh=TX+FD3p3l4+7566GyF6jvv4HQftl4YsdRmMDigxumnI=;
	h=From:To:Cc:Subject:Date:From;
	b=envx6Q6EeNU7r/yDittBuydlGFZHg1q9TRqI3a8eYuSgjFbvPSjV9GkUQI9DK1NKn
	 SLcEDCGzL+6XMElann/g66gzeMHFuAz9zS7DzRwe72KIsDeMShgTJMINGjAGRmKXic
	 5DQJDWTFTw/QBf9cnYnPt5Zz078eeHUmJa74t/RRXhkkrs34XcRGbcnrhJ0gWkZ0jV
	 YKfKCMdHOPm8nwXO9r8Zzv2zQFLaQIa7y0pE50v2up1ubs4qF8XOo5wkY6RcVNDEIL
	 qaCvA0veEG4oK7qjfW75lXK6cOiZXJ08LF48K+F5hAoRp34vx9pdG0GqOyu8qdhFsk
	 KGEe9X7cVgxwA==
From: Arnd Bergmann <arnd@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v4] module: don't ignore sysfs_create_link() failures
Date: Mon,  8 Apr 2024 10:05:58 +0200
Message-Id: <20240408080616.3911573-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The sysfs_create_link() return code is marked as __must_check, but the
module_add_driver() function tries hard to not care, by assigning the
return code to a variable. When building with 'make W=1', gcc still
warns because this variable is only assigned but not used:

drivers/base/module.c: In function 'module_add_driver':
drivers/base/module.c:36:6: warning: variable 'no_warn' set but not used [-Wunused-but-set-variable]

Rework the code to properly unwind and return the error code to the
caller. My reading of the original code was that it tries to
not fail when the links already exist, so keep ignoring -EEXIST
errors.

Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
See-also: 4a7fb6363f2d ("add __must_check to device management code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Luis, can you merge this through the modules-next tree?

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
---
v4: minor style changes, based on feedback from Andy Shevchenko
v3: make error handling stricter, add unwinding,
     fix build fail with CONFIG_MODULES=n
v2: rework to actually handle the error. I have not tested the
    error handling beyond build testing, so please review carefully.
---
 drivers/base/base.h   |  9 ++++++---
 drivers/base/bus.c    |  9 ++++++++-
 drivers/base/module.c | 42 +++++++++++++++++++++++++++++++-----------
 3 files changed, 45 insertions(+), 15 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0738ccad08b2..db4f910e8e36 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -192,11 +192,14 @@ extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
-void module_add_driver(struct module *mod, struct device_driver *drv);
+int module_add_driver(struct module *mod, struct device_driver *drv);
 void module_remove_driver(struct device_driver *drv);
 #else
-static inline void module_add_driver(struct module *mod,
-				     struct device_driver *drv) { }
+static inline int module_add_driver(struct module *mod,
+				    struct device_driver *drv)
+{
+	return 0;
+}
 static inline void module_remove_driver(struct device_driver *drv) { }
 #endif
 
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index daee55c9b2d9..ffea0728b8b2 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -674,7 +674,12 @@ int bus_add_driver(struct device_driver *drv)
 		if (error)
 			goto out_del_list;
 	}
-	module_add_driver(drv->owner, drv);
+	error = module_add_driver(drv->owner, drv);
+	if (error) {
+		printk(KERN_ERR "%s: failed to create module links for %s\n",
+			__func__, drv->name);
+		goto out_detach;
+	}
 
 	error = driver_create_file(drv, &driver_attr_uevent);
 	if (error) {
@@ -699,6 +704,8 @@ int bus_add_driver(struct device_driver *drv)
 
 	return 0;
 
+out_detach:
+	driver_detach(drv);
 out_del_list:
 	klist_del(&priv->knode_bus);
 out_unregister:
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..a1b55da07127 100644
--- a/drivers/base/module.c
+++ b/drivers/base/module.c
@@ -30,14 +30,14 @@ static void module_create_drivers_dir(struct module_kobject *mk)
 	mutex_unlock(&drivers_dir_mutex);
 }
 
-void module_add_driver(struct module *mod, struct device_driver *drv)
+int module_add_driver(struct module *mod, struct device_driver *drv)
 {
 	char *driver_name;
-	int no_warn;
 	struct module_kobject *mk = NULL;
+	int ret;
 
 	if (!drv)
-		return;
+		return 0;
 
 	if (mod)
 		mk = &mod->mkobj;
@@ -56,17 +56,37 @@ void module_add_driver(struct module *mod, struct device_driver *drv)
 	}
 
 	if (!mk)
-		return;
+		return 0;
+
+	ret = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
+	if (ret)
+		return ret;
 
-	/* Don't check return codes; these calls are idempotent */
-	no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
 	driver_name = make_driver_name(drv);
-	if (driver_name) {
-		module_create_drivers_dir(mk);
-		no_warn = sysfs_create_link(mk->drivers_dir, &drv->p->kobj,
-					    driver_name);
-		kfree(driver_name);
+	if (!driver_name) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	module_create_drivers_dir(mk);
+	if (!mk->drivers_dir) {
+		ret = -EINVAL;
+		goto out;
 	}
+
+	ret = sysfs_create_link(mk->drivers_dir, &drv->p->kobj, driver_name);
+	if (ret)
+		goto out;
+
+	kfree(driver_name);
+
+	return 0;
+out:
+	sysfs_remove_link(&drv->p->kobj, "module");
+	sysfs_remove_link(mk->drivers_dir, driver_name);
+	kfree(driver_name);
+
+	return ret;
 }
 
 void module_remove_driver(struct device_driver *drv)
-- 
2.39.2


