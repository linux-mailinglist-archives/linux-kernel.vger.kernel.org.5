Return-Path: <linux-kernel+bounces-56681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE5284CD83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFFD1C25CE0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 14:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7627E77E;
	Wed,  7 Feb 2024 14:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUvUlMmO"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112B67E576;
	Wed,  7 Feb 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707317953; cv=none; b=WiwxlTSm81N6DjtyKwosH81q+4YzDiLE2+fhi6iKYzMkhaykvSyC4zttjGtQ5p3r9c7VkjRaL6+4h2sRFI0Hj7Ust3L68utFT7MRwNVool8PX94XrlBbykUjT8zsx/B2TJozSwhBGXCnQrGGAUxY5rapndkURwjG3i5xt2j7knc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707317953; c=relaxed/simple;
	bh=GPXSlwYiixoQscrKQneXqLxQNPyv7GTgiXwdLZGez6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VqlqhQpxlQOzyFjD70MXxbC4fx3xy0u3J4UuuoOqJCZOzZc2IFsuRDXBlNDZfTr0aARdTzdlqLh99TrXT7oyQciCiOBY41TU83Qjc/3TCwe6mMZvthVoUIoUmDgSTn1nTusH5HT+29gzTAhSuXH3IA32HcFQkpHYhCzHKxys4cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUvUlMmO; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707317952; x=1738853952;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPXSlwYiixoQscrKQneXqLxQNPyv7GTgiXwdLZGez6A=;
  b=BUvUlMmOt24xf90VsWCgb03ED9T/6K7zu5Q53Il5IdCM9nVXczOJgg8T
   mpvzTDwjttvNNKFt9JaRebxkbgbQwZp8jZi9/viSN0OoEUnwWn3AqBB6E
   FFQPzTjL7UZm+To2go2hOcH+TrldtfUA6pf7X3BAy+8OWFu1MdVvk3XuN
   1j+cC2/7q5/CexQi7XOU6DGvA4QkNomci1WxAMP7PHGH7TFQerRaZB9lU
   RpLFHbH4QBSBoOKnPNttfquFtlHHHEvbqeY1foaAx4di95VqkddsEL7OJ
   xFKjmEXdiY06QTLXMkZBIEMjUrsGry01AemapDe8hO6zGrPxqg6aYKr1m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1155027"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="1155027"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 06:59:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="933799197"
X-IronPort-AV: E=Sophos;i="6.05,251,1701158400"; 
   d="scan'208";a="933799197"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2024 06:58:56 -0800
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Prashant Malani <pmalani@chromium.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Emilie Roberts <hadrosaur@google.com>,
	"Nyman, Mathias" <mathias.nyman@intel.com>,
	"Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
	"Radjacoumar, Shyam Sundar" <ssradjacoumar@google.com>,
	Samuel Jacob <samjaco@google.com>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Uday Bhat <uday.m.bhat@intel.com>
Subject: [PATCH 1/2] usb: roles: Link the switch to its connector
Date: Wed,  7 Feb 2024 16:58:50 +0200
Message-ID: <20240207145851.1603237-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
References: <20240207145851.1603237-1-heikki.krogerus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is probable useful information to have in user space in
general, but it's primarily needed for the xHCI DbC (Debug
Capability). When xHCI DbC is being used, the USB port needs
to be muxed to the xHCI even in device role. In xHCI DbC mode,
the xHCI is the USB device controller.

Tested-by: Uday Bhat <uday.m.bhat@intel.com>
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 .../ABI/testing/sysfs-class-usb_role          |  6 +++
 drivers/usb/roles/class.c                     | 40 ++++++++++++++++++-
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-usb_role b/Documentation/ABI/testing/sysfs-class-usb_role
index 3b810a425a52..9fab3f06679e 100644
--- a/Documentation/ABI/testing/sysfs-class-usb_role
+++ b/Documentation/ABI/testing/sysfs-class-usb_role
@@ -19,3 +19,9 @@ Description:
 		- none
 		- host
 		- device
+
+What:		/sys/class/usb_role/<switch>/connector
+Date:		Feb 2024
+Contact:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+Description:
+		Optional symlink to the USB Type-C connector.
diff --git a/drivers/usb/roles/class.c b/drivers/usb/roles/class.c
index ae41578bd014..4ad03c93c17f 100644
--- a/drivers/usb/roles/class.c
+++ b/drivers/usb/roles/class.c
@@ -7,6 +7,7 @@
  *         Hans de Goede <hdegoede@redhat.com>
  */
 
+#include <linux/component.h>
 #include <linux/usb/role.h>
 #include <linux/property.h>
 #include <linux/device.h>
@@ -34,6 +35,32 @@ struct usb_role_switch {
 
 #define to_role_switch(d)	container_of(d, struct usb_role_switch, dev)
 
+static int connector_bind(struct device *dev, struct device *connector, void *data)
+{
+	int ret;
+
+	ret = sysfs_create_link(&dev->kobj, &connector->kobj, "connector");
+	if (ret)
+		return ret;
+
+	ret = sysfs_create_link(&connector->kobj, &dev->kobj, "usb-role-switch");
+	if (ret)
+		sysfs_remove_link(&dev->kobj, "connector");
+
+	return ret;
+}
+
+static void connector_unbind(struct device *dev, struct device *connector, void *data)
+{
+	sysfs_remove_link(&connector->kobj, "usb-role-switch");
+	sysfs_remove_link(&dev->kobj, "connector");
+}
+
+static const struct component_ops connector_ops = {
+	.bind = connector_bind,
+	.unbind = connector_unbind,
+};
+
 /**
  * usb_role_switch_set_role - Set USB role for a switch
  * @sw: USB role switch
@@ -352,6 +379,12 @@ usb_role_switch_register(struct device *parent,
 		return ERR_PTR(ret);
 	}
 
+	if (dev_fwnode(&sw->dev)) {
+		ret = component_add(&sw->dev, &connector_ops);
+		if (ret)
+			dev_warn(&sw->dev, "failed to add component\n");
+	}
+
 	/* TODO: Symlinks for the host port and the device controller. */
 
 	return sw;
@@ -366,8 +399,11 @@ EXPORT_SYMBOL_GPL(usb_role_switch_register);
  */
 void usb_role_switch_unregister(struct usb_role_switch *sw)
 {
-	if (!IS_ERR_OR_NULL(sw))
-		device_unregister(&sw->dev);
+	if (IS_ERR_OR_NULL(sw))
+		return;
+	if (dev_fwnode(&sw->dev))
+		component_del(&sw->dev, &connector_ops);
+	device_unregister(&sw->dev);
 }
 EXPORT_SYMBOL_GPL(usb_role_switch_unregister);
 
-- 
2.43.0


