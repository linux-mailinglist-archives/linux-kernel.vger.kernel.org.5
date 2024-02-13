Return-Path: <linux-kernel+bounces-63550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 355BF853121
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 672E11C26A2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A0750A99;
	Tue, 13 Feb 2024 13:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nyIsDATi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF895024A;
	Tue, 13 Feb 2024 13:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829229; cv=none; b=mL0qV+EM5tSGB6IuLxRd5D9oDDxalBCuVw06cI/iNna2YkBz55xnlFZdNWM11U3q2k8ZAFKthplXPC7iP9kzK5uKULxVST72s1eBJZRo4GTIpLlP1x6oPBf/03fHHuh+uwGsdmanLAkl6KZHa2bn34nwJwk+hpjmr2sRwXtzPPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829229; c=relaxed/simple;
	bh=GPXSlwYiixoQscrKQneXqLxQNPyv7GTgiXwdLZGez6A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtSA7KWIhKAKqfuf346jyAgOuGdbIrtc9EUU7HHKlAMqrfxk7YpNjqp6aniOMkbzLYlbH6tesb7aLvXkdpOTJ/dgVEq8YN/ULOh+XGxChxmLmeyCCiW+5F3b9c1FjbLnmguTGsXvfoH0jIfVuoT3dfMxNA3s8rGHHr9MbKbB9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nyIsDATi; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707829228; x=1739365228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GPXSlwYiixoQscrKQneXqLxQNPyv7GTgiXwdLZGez6A=;
  b=nyIsDATitK9+bInlP9qABfewtbzMs2zWdotgBNBq5M3dYi+vzn9UX2Xt
   ez2sUozyZu7rsMkLMASJxEA7bod/iIMgFgX6uLDoNdmJF2H8FVha8hGEm
   ZnBV4JVPXGhXFXUASmjctfzmNYpHMboipvBxL/MuF+Arb66wPwBKaGeZ3
   XjJsAQVTst0MR49qAwut6JKYTThc2oJZIqYEIVwmYTC17qt3Q6Cf1ZzB1
   yXkQ71gkK2/lj370shF70BVQSKpiPXgTk0f+5PsyUpvzD6Ru4OG6orVRJ
   N2ZeFHsq2MghbCckT48QFlo0JoMWKoTQYjjz4QeL/PEQDyer9DXKPhM3q
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="1708886"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="1708886"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2024 05:00:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="935348370"
X-IronPort-AV: E=Sophos;i="6.06,157,1705392000"; 
   d="scan'208";a="935348370"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 13 Feb 2024 05:00:23 -0800
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
	Uday Bhat <uday.m.bhat@intel.com>,
	linux-usb@vger.kernel.org,
	chrome-platform@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] usb: roles: Link the switch to its connector
Date: Tue, 13 Feb 2024 15:00:17 +0200
Message-ID: <20240213130018.3029991-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
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


