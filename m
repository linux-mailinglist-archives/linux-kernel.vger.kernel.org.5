Return-Path: <linux-kernel+bounces-119242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6844E88C60E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C271C65F2B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B0913C802;
	Tue, 26 Mar 2024 14:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+fL4Pd0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3471413C696;
	Tue, 26 Mar 2024 14:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711465059; cv=none; b=Z+kgmbLE+L0wnsYKgApQS0gEJ/x4zxNWQPWUjxMhHC6SpFt9dqvpNLOgvPSxiXQdTdZEIarOQz7QZbSnFvyC3dUc11Ol8Lx7zRlfxKXGpSKE8nwl4se2uxeyubup7TfnKSj/xBmtUls5LbRiVsMSPnurHqhB5DBP79T7p420ZiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711465059; c=relaxed/simple;
	bh=D/D7xFW3Ns/95BX0XjxxVeG1+4Tl3hXAWQiMRnjcwMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kxLKNba5hdyo9lJ91NEcDalMgU/Nx9z/cHujpkzhUSEYEvAf1A2rg1SYOW07MbV2WXFjSSYamg9vJ7X6c07MZvY+GZ3G2mFU4KG9kCpJ5lWasYY2eoewfXDWWL5/LSvVpayO4OBGvcVfypZRtsPbn2keETiiI1IvG2Kv55dQDIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+fL4Pd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86D13C433F1;
	Tue, 26 Mar 2024 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711465058;
	bh=D/D7xFW3Ns/95BX0XjxxVeG1+4Tl3hXAWQiMRnjcwMg=;
	h=From:To:Cc:Subject:Date:From;
	b=i+fL4Pd0BYS1PoAvRDXvMzGEITB2SiYsXZg4lWjmwbo0YtkEa4WfIE3jkBqA5HeX/
	 81v81okQB39H/KM74PpvbIQj7ZXTX7xNBZdWyFkYryjd4SlS03xweo5752Zaw1xHKS
	 lG4b9F+mN56kK8bgt2zpiA0+A6fTijrEZN75MZ+nbyHxNWNYdQzXNzbwv+GreHfqTw
	 KLFP5EryVqMvUtbuw/cXv0bADcegFtpRWR7HRNIozoKgHaJBgqK1+mcmTdnt3ys4wA
	 TQJaDH9nMrYrZ9KTFpI3fZU6yaj6qWn1d/CtmFtioM42MDB3tF+IRe1Cn4AeC/YHzg
	 1PBFQFMncEyiw==
From: Arnd Bergmann <arnd@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v3] module: don't ignore sysfs_create_link() failures
Date: Tue, 26 Mar 2024 15:57:18 +0100
Message-Id: <20240326145733.3413024-1-arnd@kernel.org>
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

Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: linux-modules@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Fixes: e17e0f51aeea ("Driver core: show drivers in /sys/module/")
See-also: 4a7fb6363f2d ("add __must_check to device management code")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
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
index 46ad4d636731..d16b5c8e5473 100644
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
+	int ret;
 	struct module_kobject *mk = NULL;
 
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


