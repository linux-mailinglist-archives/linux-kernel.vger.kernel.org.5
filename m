Return-Path: <linux-kernel+bounces-141661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCEF08A2191
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 00:04:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A373B24466
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 22:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A883D38D;
	Thu, 11 Apr 2024 22:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i4PcjDAg"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245712DF84
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 22:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712873056; cv=none; b=RgM/+8tI7hxPmG+zV5lkmoC7h4E8lsnxQTNmcnx+u4sMTkOcQWV+yNMYIqUtSFU4UQiTJdDAvhexon5nadCvOqLVV/bVJX/EG+p8QoHugkIvczYgbR6xDJ1d/gPC+HVSUPdYJUOGuUR24YkcQIZe5B9hWPD3wgr3O0HXCNu5+8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712873056; c=relaxed/simple;
	bh=Ce+sLxB+bKAO8PQRuGuuQgg9YRCcopuTEH7q54dMPaE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oKgXDk2+cqVKcHsZAE/kowLldX3qpGd9YUsv7t8Gczrv60JwHcMtf4ul1whOpciEkI2LYGBy3CAGQsOUmtoE+o5g5xNxuCRXQowySlTG1dxCwTd+N4DY77IReCMFlUAX6UAscgUh23A/jdrDFLU06Mx9n6Pm8hTTBRRAw4uILYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i4PcjDAg; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712873048;
	bh=Ce+sLxB+bKAO8PQRuGuuQgg9YRCcopuTEH7q54dMPaE=;
	h=From:Date:Subject:To:Cc:From;
	b=i4PcjDAg3T42Xm4W5PCVHeE1PpyxgNP5hB5n2JaL+uc5xfVLzPPWCPKjfGpYmblm0
	 z8iSg8ikZqfS8CiasmOx8hUwB/TsXQdmj9XZeGBJq9hagyUcKNqno7nwkJO7UOvFvZ
	 cLEFxvwAqbj8mKgcBqiVc9wJRRZ1IDHXNBxSwnS4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 12 Apr 2024 00:03:57 +0200
Subject: [PATCH RFC v2] misc/pvpanic: add support for normal shutdowns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-pvpanic-shutdown-v2-1-5e544417bc17@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAExeGGYC/3WNwQ6CMBBEf4Xs2RqWSgBPJCZ+gFfDoZbF7qWQL
 hQN4d9tuHt8M5k3GwgFJoFrtkGgyMKjT1CcMrDO+Dcp7hNDkRcaMb+oKU7Gs1XilrkfV6/Kwej
 a1FVjeoQ0mwIN/DmUT3jcb9Cl0LHMY/geNxGP6r8xokJVElW2eWnSObYrsYhYt7izpxm6fd9/T
 ACwmLoAAAA=
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712873048; l=4194;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=Ce+sLxB+bKAO8PQRuGuuQgg9YRCcopuTEH7q54dMPaE=;
 b=4XUTk4ceVJMDX7YBXcqR1TkJ3fgvk189paQaTxpVeW3tUvMB5nJn5uq9y0JRfp7etR0TmjAGl
 xFIMxPE5+2tDIamB6iBLEYqaV/+uuhrVMc+Pz3TxSheK9TU/gduK49g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
To: Arnd Bergmann <arnd@arndb.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Changes in v2:
- Drop RFC status
- Drop define from header file as it was submitted on its own
- Handle disabling of handler through sysfs
- Link to v1: https://lore.kernel.org/r/20231104-pvpanic-shutdown-v1-1-5ee7c9b3e301@weissschuh.net
---
This patch is based on char-misc/char-misc-testing as it depends on
commit ad76f3e8f57c ("misc/pvpanic: add shutdown event definition")

The corresponding patch to qemu has also been submitted[0].
General discussions about the feature should happen on the other thread.

[0] https://lore.kernel.org/qemu-devel/20231104-pvpanic-shutdown-v1-0-02353157891b@t-8ch.de/
---
 drivers/misc/pvpanic/pvpanic.c | 43 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/pvpanic/pvpanic.c b/drivers/misc/pvpanic/pvpanic.c
index df3457ce1cb1..17c0eb549463 100644
--- a/drivers/misc/pvpanic/pvpanic.c
+++ b/drivers/misc/pvpanic/pvpanic.c
@@ -19,6 +19,7 @@
 #include <linux/module.h>
 #include <linux/panic_notifier.h>
 #include <linux/platform_device.h>
+#include <linux/reboot.h>
 #include <linux/spinlock.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
@@ -35,6 +36,7 @@ struct pvpanic_instance {
 	void __iomem *base;
 	unsigned int capability;
 	unsigned int events;
+	struct sys_off_handler *sys_off;
 	struct list_head list;
 };
 
@@ -78,6 +80,39 @@ static struct notifier_block pvpanic_panic_nb = {
 	.priority = INT_MAX,
 };
 
+static int pvpanic_sys_off(struct sys_off_data *data)
+{
+	pvpanic_send_event(PVPANIC_SHUTDOWN);
+
+	return NOTIFY_DONE;
+}
+
+static void pvpanic_synchronize_sys_off_handler(struct device *dev, struct pvpanic_instance *pi)
+{
+	/* The kernel core has logic to fall back to system halt if no
+	 * sys_off_handler is registered.
+	 * When the pvpanic sys_off_handler is disabled via sysfs the kernel
+	 * should use that fallback logic, so the handler needs to be unregistered.
+	 */
+
+	struct sys_off_handler *sys_off;
+
+	if (!(pi->events & PVPANIC_SHUTDOWN) == !pi->sys_off)
+		return;
+
+	if (!pi->sys_off) {
+		sys_off = register_sys_off_handler(SYS_OFF_MODE_POWER_OFF, SYS_OFF_PRIO_LOW,
+						   pvpanic_sys_off, NULL);
+		if (IS_ERR(sys_off))
+			dev_warn(dev, "Could not register sys_off_handler: %pe\n", sys_off);
+		else
+			pi->sys_off = sys_off;
+	} else {
+		unregister_sys_off_handler(pi->sys_off);
+		pi->sys_off = NULL;
+	}
+}
+
 static void pvpanic_remove(void *param)
 {
 	struct pvpanic_instance *pi_cur, *pi_next;
@@ -91,6 +126,8 @@ static void pvpanic_remove(void *param)
 		}
 	}
 	spin_unlock(&pvpanic_lock);
+
+	unregister_sys_off_handler(pi->sys_off);
 }
 
 static ssize_t capability_show(struct device *dev, struct device_attribute *attr, char *buf)
@@ -123,6 +160,7 @@ static ssize_t events_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 
 	pi->events = tmp;
+	pvpanic_synchronize_sys_off_handler(dev, pi);
 
 	return count;
 }
@@ -156,12 +194,15 @@ int devm_pvpanic_probe(struct device *dev, void __iomem *base)
 		return -ENOMEM;
 
 	pi->base = base;
-	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED;
+	pi->capability = PVPANIC_PANICKED | PVPANIC_CRASH_LOADED | PVPANIC_SHUTDOWN;
 
 	/* initlize capability by RDPT */
 	pi->capability &= ioread8(base);
 	pi->events = pi->capability;
 
+	pi->sys_off = NULL;
+	pvpanic_synchronize_sys_off_handler(dev, pi);
+
 	spin_lock(&pvpanic_lock);
 	list_add(&pi->list, &pvpanic_list);
 	spin_unlock(&pvpanic_lock);

---
base-commit: dc806bd48abc1b8a4ae72709a37e65db42a32048
change-id: 20231104-pvpanic-shutdown-5fa38a879ad1

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


