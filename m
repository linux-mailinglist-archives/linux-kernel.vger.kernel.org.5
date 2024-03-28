Return-Path: <linux-kernel+bounces-122855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F61788FE79
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F30801F2304A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB967EF18;
	Thu, 28 Mar 2024 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mFU4EWgf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A2A5474B;
	Thu, 28 Mar 2024 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711627158; cv=none; b=ZCHpC5+hZ1Ed8fAxnPm/djL4jkCl/EZb6URMPC/Zqo4y/L9HvohVb0reUvs1EjKyhTHnd/7zAwJApQdv6l5p+1LSh5fXsFgTSQxvZu0i3q+Hxe784Zmugmn1IYIuz7YEQa4LnB6owfkS9rqDf/6+0Ffmy6hLYz8XmKuj4IZzYVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711627158; c=relaxed/simple;
	bh=8tDAHUDVfUVkniIhz2Tjlxyx9+yhjE02ZhpIawN3e88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gQe0mp66i1tDN4nvDnZs1Tai65z8wcSTcvh3kY3XEEYZLhtRK6UM96CXShfwTvlNFc0qVw9xjvg9/PF9PJSxIqCUZXguoFfR+TZxCDWOeg62bueBmzdlNLKEryyo1BJS+HevmxKJRzd3bpnCZnJydpr5GDq+mlpcec+s/eDZqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mFU4EWgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCF4FC43390;
	Thu, 28 Mar 2024 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711627157;
	bh=8tDAHUDVfUVkniIhz2Tjlxyx9+yhjE02ZhpIawN3e88=;
	h=From:To:Cc:Subject:Date:From;
	b=mFU4EWgfLkursYUxABDp9NsVLp90HdFN3faN6m/bgMh+UFLqHeoWncr753xBJjsJ4
	 X4d8z9pPBJng4tSxlbFZMtPQ4c+WILU9TySRjYPDSLvyu8e9bpbT4YQJedwQ3s2XEc
	 PsO8smAb94iIYyflRDvCcmlo0iKyA8Vjpr3OX45g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: lee@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	daniel.thompson@linaro.org,
	jingoohan1@gmail.com,
	deller@gmx.de,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 1/2] video: backlight: make backlight_class constant
Date: Thu, 28 Mar 2024 12:59:06 +0100
Message-ID: <2024032805-putdown-mushy-a0f9@gregkh>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 99
X-Developer-Signature: v=1; a=openpgp-sha256; l=3406; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=/aKgYyLp0Ixe4eLFmIE3xueHTfYuhhXATaHPaS0rmDA=; b=owGbwMvMwCRo6H6F97bub03G02pJDGms0Z17LUtTKjdU+utYFJ/gXeDZFML8gy2gcbVQF4P6f pacubUdsSwMgkwMsmKKLF+28RzdX3FI0cvQ9jTMHFYmkCEMXJwCMBHrRwzzvRJX//9SM8Uj8ERD xJWextUsf03dGBacODbL4ZtbYOoHf5cm9XNW5TftP28FAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

From: "Ricardo B. Marliere" <ricardo@marliere.net>

Since commit 43a7206b0963 ("driver core: class: make class_register() take
a const *"), the driver core allows for struct class to be in read-only
memory, so move the backlight_class structure to be declared at build time
placing it into read-only memory, instead of having to be dynamically
allocated at boot time.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Ricardo B. Marliere" <ricardo@marliere.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: rebased on 6.9-rc1

 drivers/video/backlight/backlight.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 86e1cdc8e369..d2feaebfd84a 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -317,8 +317,6 @@ static ssize_t scale_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(scale);
 
-static struct class *backlight_class;
-
 #ifdef CONFIG_PM_SLEEP
 static int backlight_suspend(struct device *dev)
 {
@@ -369,6 +367,12 @@ static struct attribute *bl_device_attrs[] = {
 };
 ATTRIBUTE_GROUPS(bl_device);
 
+static const struct class backlight_class = {
+	.name = "backlight",
+	.dev_groups = bl_device_groups,
+	.pm = &backlight_class_dev_pm_ops,
+};
+
 /**
  * backlight_force_update - tell the backlight subsystem that hardware state
  *   has changed
@@ -418,7 +422,7 @@ struct backlight_device *backlight_device_register(const char *name,
 	mutex_init(&new_bd->update_lock);
 	mutex_init(&new_bd->ops_lock);
 
-	new_bd->dev.class = backlight_class;
+	new_bd->dev.class = &backlight_class;
 	new_bd->dev.parent = parent;
 	new_bd->dev.release = bl_device_release;
 	dev_set_name(&new_bd->dev, "%s", name);
@@ -510,7 +514,7 @@ struct backlight_device *backlight_device_get_by_name(const char *name)
 {
 	struct device *dev;
 
-	dev = class_find_device_by_name(backlight_class, name);
+	dev = class_find_device_by_name(&backlight_class, name);
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
@@ -678,7 +682,7 @@ struct backlight_device *of_find_backlight_by_node(struct device_node *node)
 {
 	struct device *dev;
 
-	dev = class_find_device(backlight_class, NULL, node, of_parent_match);
+	dev = class_find_device(&backlight_class, NULL, node, of_parent_match);
 
 	return dev ? to_backlight_device(dev) : NULL;
 }
@@ -746,20 +750,19 @@ EXPORT_SYMBOL(devm_of_find_backlight);
 
 static void __exit backlight_class_exit(void)
 {
-	class_destroy(backlight_class);
+	class_unregister(&backlight_class);
 }
 
 static int __init backlight_class_init(void)
 {
-	backlight_class = class_create("backlight");
-	if (IS_ERR(backlight_class)) {
-		pr_warn("Unable to create backlight class; errno = %ld\n",
-			PTR_ERR(backlight_class));
-		return PTR_ERR(backlight_class);
+	int ret;
+
+	ret = class_register(&backlight_class);
+	if (ret) {
+		pr_warn("Unable to create backlight class; errno = %d\n", ret);
+		return ret;
 	}
 
-	backlight_class->dev_groups = bl_device_groups;
-	backlight_class->pm = &backlight_class_dev_pm_ops;
 	INIT_LIST_HEAD(&backlight_dev_list);
 	mutex_init(&backlight_dev_list_mutex);
 	BLOCKING_INIT_NOTIFIER_HEAD(&backlight_notifier);
-- 
2.44.0


