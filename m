Return-Path: <linux-kernel+bounces-111871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD568871F1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD63284A9D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:39:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3545FBB9;
	Fri, 22 Mar 2024 17:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFI5vZR/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773435FEE6;
	Fri, 22 Mar 2024 17:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129176; cv=none; b=b40SPkjzN6x7DiMsxu1sEUEn4ChrLfABbNxaS/wr80hTYCOh4DCW0ctZ5yZYrJLwe3ECd8xja+BfLqj7WAAJ09R1jgqwKO+H2hutTlebkOCzRZxHKuWe8FH5cic5PsMcbPh80D74CujjErBLhEuu19lut14QvExaWF/dI6mcER8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129176; c=relaxed/simple;
	bh=w1ndyQPRVEkESqxTtzlozDY0rYnFTowv6+FXfKHJPwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TmictZZM5KzbztmRXXS+dRDEGEI5CPyUrj5V+OpKo5q5Pf1w0xyQQLFsRc4qx6ItZVp4qJnc6jqKF1f3xfq4t+EMLbRSzyZ8IyT9mjjFIpaKu2gKKeMkGN4KuhZghciWzxk/c3KVW9vfbMRh6SUgF1+D3ZBMFFvxpK/cpPYfaK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFI5vZR/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF09C433F1;
	Fri, 22 Mar 2024 17:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711129176;
	bh=w1ndyQPRVEkESqxTtzlozDY0rYnFTowv6+FXfKHJPwQ=;
	h=From:To:Cc:Subject:Date:From;
	b=qFI5vZR/3vV2wLP2KYYzi/2ogK54fqoP4AVzAElJuDdKQqxHmzqoxtLhqRj9NH5qw
	 +qa3NMM576H82cLwdL9dP5khNF47b6c4Fj6jnWHVrIZVxp61wSD6mEGfAAxKfuqrHK
	 b+LPLGRkez75Cf81jY/O0tTGQ5dXL9ROrkL5/UMLCOOHohrJbhUQ9BLklhMKn8mcxH
	 dHSe41163ULrfesfzVgIKQ2N8JvfVxtMDXaQu2iH6eYMbFL3NEb8wP7a3KVkQF5zyC
	 6KuXV7zoyAJoPv4+0zsNxWIc3irW/USOekBOQicKoZXXsL9VTZD0GfZg0HfHTTgLjz
	 MJUD0mle49iRw==
From: Arnd Bergmann <arnd@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-modules@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] module: don't ignore sysfs_create_link() failures
Date: Fri, 22 Mar 2024 18:39:11 +0100
Message-Id: <20240322173930.947963-1-arnd@kernel.org>
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
v2: rework to actually handle the error. I have not tested the
    error handling beyond build testing, so please review carefully.
---
 drivers/base/base.h   |  2 +-
 drivers/base/bus.c    |  7 ++++++-
 drivers/base/module.c | 42 +++++++++++++++++++++++++++++++-----------
 3 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/drivers/base/base.h b/drivers/base/base.h
index 0738ccad08b2..0e04bfe02943 100644
--- a/drivers/base/base.h
+++ b/drivers/base/base.h
@@ -192,7 +192,7 @@ extern struct kset *devices_kset;
 void devices_kset_move_last(struct device *dev);
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_SYSFS)
-void module_add_driver(struct module *mod, struct device_driver *drv);
+int module_add_driver(struct module *mod, struct device_driver *drv);
 void module_remove_driver(struct device_driver *drv);
 #else
 static inline void module_add_driver(struct module *mod,
diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index daee55c9b2d9..7ef75b60d331 100644
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
+		goto out_del_list;
+	}
 
 	error = driver_create_file(drv, &driver_attr_uevent);
 	if (error) {
diff --git a/drivers/base/module.c b/drivers/base/module.c
index 46ad4d636731..61282eaed670 100644
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
+	if (ret && ret != -EEXIST)
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
+	if (ret && ret != -EEXIST)
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


