Return-Path: <linux-kernel+bounces-5245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4949E818872
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 14:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD8E1F2389F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8FAF18E21;
	Tue, 19 Dec 2023 13:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vtjsv4H2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4105E18E16
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 13:15:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 257A8C433C7;
	Tue, 19 Dec 2023 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702991712;
	bh=9eXFc0NMwtRCOlj8YbmAE3FjrOz7Fufp7aizqjfZxT4=;
	h=From:To:Cc:Subject:Date:From;
	b=Vtjsv4H2aiRYE3YLsDWGQEndsXQ0WY7ce8SyMNwKi+ShAb9fPuGQpjox27H9ONHNp
	 oppy0WB+M5b6M5W8fO03Age/0vP/n8317yZgv63BJKhKLvo27Zs/kg6yRMot+e5n4q
	 6xWq9HnXG7aFi/mSEImfhEfrkscjjR53ipibPmro=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] driver core: bus: constantify subsys_register() calls
Date: Tue, 19 Dec 2023 14:15:09 +0100
Message-ID: <2023121908-grove-genetics-f8af@gregkh>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Lines: 74
X-Developer-Signature: v=1; a=openpgp-sha256; l=2932; i=gregkh@linuxfoundation.org; h=from:subject:message-id; bh=9eXFc0NMwtRCOlj8YbmAE3FjrOz7Fufp7aizqjfZxT4=; b=owGbwMvMwCRo6H6F97bub03G02pJDKmN02Oy9yd9rb28at6RDa/+GpTfPWZYpLQ3Le53//HDn p8u8DC96YhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJsPgyzNM23607O75qrUXy Sn6eFLtp9Qqr+BgWHI2PPTSrJnBCXvvtlweb/3CWR4Z+AwA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit

The functions subsys_register() and subsys_virtual_register() should be
taking a constant pointer to a struct bus_type, as they do not actually
modify anything in it, so fix up the function definitions to do so
properly.

This also changes the pointer type in struct subsys_interface to be
constant as well, as again, that's the proper signature of it.

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/base/bus.c     | 6 +++---
 include/linux/device.h | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/base/bus.c b/drivers/base/bus.c
index 84a21084d67d..dddbaa024583 100644
--- a/drivers/base/bus.c
+++ b/drivers/base/bus.c
@@ -1194,7 +1194,7 @@ static void system_root_device_release(struct device *dev)
 	kfree(dev);
 }
 
-static int subsys_register(struct bus_type *subsys,
+static int subsys_register(const struct bus_type *subsys,
 			   const struct attribute_group **groups,
 			   struct kobject *parent_of_root)
 {
@@ -1264,7 +1264,7 @@ static int subsys_register(struct bus_type *subsys,
  * directory itself and not some create fake root-device placed in
  * /sys/devices/system/<name>.
  */
-int subsys_system_register(struct bus_type *subsys,
+int subsys_system_register(const struct bus_type *subsys,
 			   const struct attribute_group **groups)
 {
 	return subsys_register(subsys, groups, &system_kset->kobj);
@@ -1282,7 +1282,7 @@ EXPORT_SYMBOL_GPL(subsys_system_register);
  * There's no restriction on device naming.  This is for kernel software
  * constructs which need sysfs interface.
  */
-int subsys_virtual_register(struct bus_type *subsys,
+int subsys_virtual_register(const struct bus_type *subsys,
 			    const struct attribute_group **groups)
 {
 	struct kobject *virtual_dir;
diff --git a/include/linux/device.h b/include/linux/device.h
index 4aa34c8d1361..aefc5ca7f1cf 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -63,7 +63,7 @@ struct msi_device_data;
  */
 struct subsys_interface {
 	const char *name;
-	struct bus_type *subsys;
+	const struct bus_type *subsys;
 	struct list_head node;
 	int (*add_dev)(struct device *dev, struct subsys_interface *sif);
 	void (*remove_dev)(struct device *dev, struct subsys_interface *sif);
@@ -72,9 +72,9 @@ struct subsys_interface {
 int subsys_interface_register(struct subsys_interface *sif);
 void subsys_interface_unregister(struct subsys_interface *sif);
 
-int subsys_system_register(struct bus_type *subsys,
+int subsys_system_register(const struct bus_type *subsys,
 			   const struct attribute_group **groups);
-int subsys_virtual_register(struct bus_type *subsys,
+int subsys_virtual_register(const struct bus_type *subsys,
 			    const struct attribute_group **groups);
 
 /*
-- 
2.43.0


