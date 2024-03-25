Return-Path: <linux-kernel+bounces-118088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 478D588B5E4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 01:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106ECB3A17A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 22:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EC573506;
	Mon, 25 Mar 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPfBkMcQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBA5D737
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 22:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711404854; cv=none; b=CiqFJRr3CjjI3i5bSVQ6qxVaBQZt8svMMfr1KJBR9WpLTv3mJf92Vf6ZWGnUyVl46Mh3tuoQpdw7floPExy3+jkPZWOnn0h3t/IgKURM7GJmXP3Yhw7/0WKkg7z8p8XmtlbaVvOlCKXwqAa1unbD83Rcso8RvZrlGTbun7mg1j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711404854; c=relaxed/simple;
	bh=Dq91DUOv3LbPewimm3YVR7sgRj5Hcl1z/IZXjKreQxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jrH7ZVWk3/ymhAUaobfuydtGu/nmDVURCMUx5NYFpYig0TW8AL9VtNO3glJEhi5FEXVy0wBmNp1xMZSAWyDBc19TikQ6KB3a1rlOAohtHm3ewke2kC9tSQD4pJ1GBZjVMy+hM+giJiBCUOhqK/nrtvX3uopCsYravYellbHm51g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPfBkMcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8167C433F1;
	Mon, 25 Mar 2024 22:14:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711404854;
	bh=Dq91DUOv3LbPewimm3YVR7sgRj5Hcl1z/IZXjKreQxo=;
	h=From:To:Cc:Subject:Date:From;
	b=RPfBkMcQNrTErKXKdRqaMRotVmmPyyTNTDikF7xG/VYdELsxR+e2BHM9mvwi3EexN
	 v/iVfM7nPfvnbQQXg0Lsa/ME1RCKAreNw6Eaq1YyLM9gLXpvDp33RpHoXSU3rE0AQs
	 BKYjuWfinkYGyxQ/IBg/ENtPf0gLAGm/D21w6411NBEisNXpmAYMSg7RlW7I9qJi64
	 smzcZL8rXsNYs4VVV78G7Q3aWtFtYNmsGKOzy2AELPlPG+2nyCU3zhBWNp6NTXSqAG
	 Dv5ngqQHZ9BzvTz1fD1z4mjtrJi0stW5OWm3MsKevt8wr/sdNix6hf6g0h+DSxID+m
	 DWaJ2zFYp4N0Q==
From: Bjorn Helgaas <helgaas@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] driver core: Remove unused platform_notify, platform_notify_remove
Date: Mon, 25 Mar 2024 17:14:09 -0500
Message-Id: <20240325221409.1457036-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bjorn Helgaas <bhelgaas@google.com>

The "platform_notify" and "platform_notify_remove" hooks have been unused
since 00ba9357d189 ("ARM: ixp4xx: Drop custom DMA coherency and bouncing").

Remove "platform_notify" and "platform_notify_remove".  No functional
change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/base/core.c    |  8 --------
 include/linux/device.h | 11 -----------
 2 files changed, 19 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index b93f3c5716ae..78dfa74ee18b 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2331,8 +2331,6 @@ static void fw_devlink_link_device(struct device *dev)
 
 /* Device links support end. */
 
-int (*platform_notify)(struct device *dev) = NULL;
-int (*platform_notify_remove)(struct device *dev) = NULL;
 static struct kobject *dev_kobj;
 
 /* /sys/dev/char */
@@ -2380,16 +2378,10 @@ static void device_platform_notify(struct device *dev)
 	acpi_device_notify(dev);
 
 	software_node_notify(dev);
-
-	if (platform_notify)
-		platform_notify(dev);
 }
 
 static void device_platform_notify_remove(struct device *dev)
 {
-	if (platform_notify_remove)
-		platform_notify_remove(dev);
-
 	software_node_notify_remove(dev);
 
 	acpi_device_notify_remove(dev);
diff --git a/include/linux/device.h b/include/linux/device.h
index 97c4b046c09d..c515ba5756e4 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1206,17 +1206,6 @@ int __must_check devm_device_add_groups(struct device *dev,
 int __must_check devm_device_add_group(struct device *dev,
 				       const struct attribute_group *grp);
 
-/*
- * Platform "fixup" functions - allow the platform to have their say
- * about devices and actions that the general device layer doesn't
- * know about.
- */
-/* Notify platform of device discovery */
-extern int (*platform_notify)(struct device *dev);
-
-extern int (*platform_notify_remove)(struct device *dev);
-
-
 /*
  * get_device - atomically increment the reference count for the device.
  *
-- 
2.34.1


