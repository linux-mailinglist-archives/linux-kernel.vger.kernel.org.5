Return-Path: <linux-kernel+bounces-130447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F595897845
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3B6C1F21E43
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C99154BF0;
	Wed,  3 Apr 2024 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AmTBmM3B"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E11B53A7
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712169037; cv=none; b=DdDb5vKW8ODCjesClXb7/n5J8Mfzahc42ujXyqnoyzA8MReR5rlOdBOenDtwT90lyIDzCJLRdszyx9v3e0yqdRCbaw7w6n6efF1E1oOORGhZSGHYIcFJK/YBG7e3tQAkE44X17OjqIamGSZLJl6wvDxu539RvcIsEhU0SwMrVHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712169037; c=relaxed/simple;
	bh=X3gawQizTTZ2izaFT0MnlQyxFRjnWmFQBSZh9Jvcdpw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tuKElQ79Ot2ndciKXANUdpTIQTRwQWkFbLoCUCFe5/UY1GR9u2s6h6hq3H35kcWAQrnQPhmxT7nCtv/aY+LHAjV6PviWM2cbPxgOxhfU1lC0mcHaRi36nbNPFo4be2InXvHkk0dU3jJb21iVaYcOeqz34PNZ/17PIqboX/xnh6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AmTBmM3B; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712169033;
	bh=X3gawQizTTZ2izaFT0MnlQyxFRjnWmFQBSZh9Jvcdpw=;
	h=From:To:Cc:Subject:Date:From;
	b=AmTBmM3Bjo9n+afuIZfqGHOst3XC2oURKpvaNsUIq+gCXkNBiBQrx7K2jSL6vdVeS
	 mpTA8LNdX705fFs9Nek8/IvpOVhesw9n9sAWtO9DjCWkcRJj1YfqMVtKLzPSaNNQJQ
	 kS5YPp/vbg+dd01t8P2RSK2w2QRTcXiHyMS/SJezDmcqenIkX14SKxnK4PM29OZDCl
	 wrtBM8bNJeV2a7ev9wFY/Xwob2+7jQWDbWHgbmKtzeAya49/8IwZNpPX8dZDY+tMDj
	 2kmSQbillZk1vbXiMjh5GC2KxlCJqxwpZ9TmBm2KHKDqWedBVRjHMRab3+7ZhJzZMv
	 QxuXGkbciCslA==
Received: from localhost.localdomain (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: alarumbe)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 62EFA37813D7;
	Wed,  3 Apr 2024 18:30:32 +0000 (UTC)
From: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Hans de Goede <hdegoede@redhat.com>
Cc: kernel@collabora.com,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Christopher Healy <healych@amazon.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drm/sysfs: Add drm class-wide attribute to get active device clients
Date: Wed,  3 Apr 2024 19:29:39 +0100
Message-ID: <20240403182951.724488-1-adrian.larumbe@collabora.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Up to this day, all fdinfo-based GPU profilers must traverse the entire
/proc directory structure to find open DRM clients with fdinfo file
descriptors. This is inefficient and time-consuming.

This patch adds a new device class attribute that will install a sysfs file
per DRM device, which can be queried by profilers to get a list of PIDs for
their open clients. This file isn't human-readable, and it's meant to be
queried only by GPU profilers like gputop and nvtop.

Cc: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Tvrtko Ursulin <tursulin@ursulin.net>
Cc: Christopher Healy <healych@amazon.com>
Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
---
 drivers/gpu/drm/drm_internal.h       |  2 +-
 drivers/gpu/drm/drm_privacy_screen.c |  2 +-
 drivers/gpu/drm/drm_sysfs.c          | 89 ++++++++++++++++++++++------
 3 files changed, 74 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/drm_internal.h b/drivers/gpu/drm/drm_internal.h
index 2215baef9a3e..9a399b03d11c 100644
--- a/drivers/gpu/drm/drm_internal.h
+++ b/drivers/gpu/drm/drm_internal.h
@@ -145,7 +145,7 @@ bool drm_master_internal_acquire(struct drm_device *dev);
 void drm_master_internal_release(struct drm_device *dev);
 
 /* drm_sysfs.c */
-extern struct class *drm_class;
+extern struct class drm_class;
 
 int drm_sysfs_init(void);
 void drm_sysfs_destroy(void);
diff --git a/drivers/gpu/drm/drm_privacy_screen.c b/drivers/gpu/drm/drm_privacy_screen.c
index 6cc39e30781f..2fbd24ba5818 100644
--- a/drivers/gpu/drm/drm_privacy_screen.c
+++ b/drivers/gpu/drm/drm_privacy_screen.c
@@ -401,7 +401,7 @@ struct drm_privacy_screen *drm_privacy_screen_register(
 	mutex_init(&priv->lock);
 	BLOCKING_INIT_NOTIFIER_HEAD(&priv->notifier_head);
 
-	priv->dev.class = drm_class;
+	priv->dev.class = &drm_class;
 	priv->dev.type = &drm_privacy_screen_type;
 	priv->dev.parent = parent;
 	priv->dev.release = drm_privacy_screen_device_release;
diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index a953f69a34b6..56ca9e22c720 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -58,8 +58,6 @@ static struct device_type drm_sysfs_device_connector = {
 	.name = "drm_connector",
 };
 
-struct class *drm_class;
-
 #ifdef CONFIG_ACPI
 static bool drm_connector_acpi_bus_match(struct device *dev)
 {
@@ -128,6 +126,62 @@ static const struct component_ops typec_connector_ops = {
 
 static CLASS_ATTR_STRING(version, S_IRUGO, "drm 1.1.0 20060810");
 
+static ssize_t clients_show(struct device *cd, struct device_attribute *attr, char *buf)
+{
+	struct drm_minor *minor = cd->driver_data;
+	struct drm_device *ddev = minor->dev;
+	struct drm_file *priv;
+	ssize_t offset = 0;
+	void *pid_buf;
+
+	if (minor->type != DRM_MINOR_RENDER)
+		return 0;
+
+	pid_buf = kvmalloc(PAGE_SIZE, GFP_KERNEL);
+	if (!pid_buf)
+		return 0;
+
+	mutex_lock(&ddev->filelist_mutex);
+	list_for_each_entry_reverse(priv, &ddev->filelist, lhead) {
+		struct pid *pid;
+
+		if (drm_WARN_ON(ddev, (PAGE_SIZE - offset) < sizeof(pid_t)))
+			break;
+
+		rcu_read_lock();
+		pid = rcu_dereference(priv->pid);
+		(*(pid_t *)(pid_buf + offset)) = pid_vnr(pid);
+		rcu_read_unlock();
+
+		offset += sizeof(pid_t);
+	}
+	mutex_unlock(&ddev->filelist_mutex);
+
+	if (offset < PAGE_SIZE)
+		(*(pid_t *)(pid_buf + offset)) = 0;
+
+	memcpy(buf, pid_buf, offset);
+
+	kvfree(pid_buf);
+
+	return offset;
+
+}
+static DEVICE_ATTR_RO(clients);
+
+static struct attribute *drm_device_attrs[] = {
+	&dev_attr_clients.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(drm_device);
+
+struct class drm_class = {
+	.name		= "drm",
+	.dev_groups	= drm_device_groups,
+};
+
+static bool drm_class_initialised;
+
 /**
  * drm_sysfs_init - initialize sysfs helpers
  *
@@ -142,18 +196,19 @@ int drm_sysfs_init(void)
 {
 	int err;
 
-	drm_class = class_create("drm");
-	if (IS_ERR(drm_class))
-		return PTR_ERR(drm_class);
+	err = class_register(&drm_class);
+	if (err)
+		return err;
 
-	err = class_create_file(drm_class, &class_attr_version.attr);
+	err = class_create_file(&drm_class, &class_attr_version.attr);
 	if (err) {
-		class_destroy(drm_class);
-		drm_class = NULL;
+		class_destroy(&drm_class);
 		return err;
 	}
 
-	drm_class->devnode = drm_devnode;
+	drm_class.devnode = drm_devnode;
+
+	drm_class_initialised = true;
 
 	drm_sysfs_acpi_register();
 	return 0;
@@ -166,12 +221,12 @@ int drm_sysfs_init(void)
  */
 void drm_sysfs_destroy(void)
 {
-	if (IS_ERR_OR_NULL(drm_class))
+	if (!drm_class_initialised)
 		return;
 	drm_sysfs_acpi_unregister();
-	class_remove_file(drm_class, &class_attr_version.attr);
-	class_destroy(drm_class);
-	drm_class = NULL;
+	class_remove_file(&drm_class, &class_attr_version.attr);
+	class_destroy(&drm_class);
+	drm_class_initialised = false;
 }
 
 static void drm_sysfs_release(struct device *dev)
@@ -372,7 +427,7 @@ int drm_sysfs_connector_add(struct drm_connector *connector)
 		return -ENOMEM;
 
 	device_initialize(kdev);
-	kdev->class = drm_class;
+	kdev->class = &drm_class;
 	kdev->type = &drm_sysfs_device_connector;
 	kdev->parent = dev->primary->kdev;
 	kdev->groups = connector_dev_groups;
@@ -550,7 +605,7 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
 			minor_str = "card%d";
 
 		kdev->devt = MKDEV(DRM_MAJOR, minor->index);
-		kdev->class = drm_class;
+		kdev->class = &drm_class;
 		kdev->type = &drm_sysfs_device_minor;
 	}
 
@@ -579,10 +634,10 @@ struct device *drm_sysfs_minor_alloc(struct drm_minor *minor)
  */
 int drm_class_device_register(struct device *dev)
 {
-	if (!drm_class || IS_ERR(drm_class))
+	if (!drm_class_initialised)
 		return -ENOENT;
 
-	dev->class = drm_class;
+	dev->class = &drm_class;
 	return device_register(dev);
 }
 EXPORT_SYMBOL_GPL(drm_class_device_register);

base-commit: 45c734fdd43db14444025910b4c59dd2b8be714a
-- 
2.44.0


