Return-Path: <linux-kernel+bounces-142032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 864B28A2688
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:27:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B7332846C5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5102E821;
	Fri, 12 Apr 2024 06:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="RiLQlRpp"
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C3241E2
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903212; cv=none; b=E6ERa7bW5hEXNIE1KX+W/IOXCL598Ap9LtIOMGKLhVvwSeehdakdxqmuGtF+gbRqx4RcGqUCVUpjnGqcpeq4geSGCaiqUk476nqxR4CjtBPPjSWh5nE9+Ajjso7dd4CDnvWsL4L5QIkRvLxX0a7/+2/F3EAWoNsDjZP3AtHL/Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903212; c=relaxed/simple;
	bh=sDNbtYIHNde4yzG+mtMhm+CHahPBxWrK+Dlok/Vea98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RQWZHYMIdGCBPiUkIXOEQZhaqFc3lPm+EyyDtTrjg4iVoOxju38MWzFegHSkVm87C8cTtXUrclg/XkhyaO5HN6X5Ye8KOv/B686PnG4QfDzYYNbUNbatbLriFcJRzR0RzysuF+LhBppWs7/8IZf1UiPrTsZO2zzusMwLzNYIQOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=RiLQlRpp; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1712903204;
	bh=sDNbtYIHNde4yzG+mtMhm+CHahPBxWrK+Dlok/Vea98=;
	h=From:Date:Subject:To:Cc:From;
	b=RiLQlRpps2T9fke3w6Z+3tl8V6PyZ+y5k0F+0wLS9m3R2YWj6Jav2aOFUCbeZfuCY
	 Nn8Stg73mfG34a9r8OYh4Zt60IiGhdlejRLTkqaENnaaoylJODQrSWdDkz89gdvd/+
	 Ulij/frWTbxuXo43JIyNlzErgJiyI6JzIl3ruhPg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 12 Apr 2024 08:26:40 +0200
Subject: [PATCH v3] misc/pvpanic: add support for normal shutdowns
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240412-pvpanic-shutdown-v3-1-c214e9873b3f@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAB/UGGYC/33NQQ6CMBCF4auQrq3ptCUFV97DuChlsLMphELRE
 O5uIXGlcfm/ZL5ZWcSRMLJLsbIRE0XqQw51KpjzNjyQU5ubSSEVgNB8SIMN5Hj089T2S+BlZ1V
 lK1PbFlg+G0bs6HmQt3tuT3Hqx9fxIcG+/sEScOAlonF1o1AJuC5IMUbnZ38OOLFdTPKjaKFB/
 lDkoZRaazCNA/OlbNv2BpfJIPf7AAAA
To: Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712903203; l=4209;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=sDNbtYIHNde4yzG+mtMhm+CHahPBxWrK+Dlok/Vea98=;
 b=4YJRC57gy8imlh/CoUA02y9HpGnd1FsYP8tRND2I6cJb7HztQThDH7FdRI3HcDzne2ns6NPgU
 QQi3nDOVtsSDpMsCvh+v2RaFq0PxQqdW0elJbEXw0JDER1sWUvoAH6P
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

Shutdown requests are normally hardware dependent.
By extending pvpanic to also handle shutdown requests, guests can
submit such requests with an easily implementable and cross-platform
mechanism.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v3:
- Really drop RFC status
- Update link to current revision of qemu patchset
- Link to v2: https://lore.kernel.org/r/20240412-pvpanic-shutdown-v2-1-5e544417bc17@weissschuh.net

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

[0] https://lore.kernel.org/qemu-devel/20240323-pvpanic-shutdown-v7-0-4ac1fd546d6f@t-8ch.de/
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


