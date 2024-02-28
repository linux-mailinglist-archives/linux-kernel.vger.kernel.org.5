Return-Path: <linux-kernel+bounces-84248-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A2986A431
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4B4BB2A00A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA75231A81;
	Wed, 28 Feb 2024 00:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YPO6Qff9"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C579E33CC;
	Wed, 28 Feb 2024 00:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078422; cv=none; b=ntw9/8RNIa0wawuXWHJeMbbt0/IquTAdPaARZ/abdm++FVOxw15D5OislvXHhcjsUQsYLzLzi/A9PyBDB7UDVH/pMeAhKAfpJ+EPBj0e6B1y0+D5vPsyS8QubQCDCjZaYX9UQj/llofagaLperv5rFSTzzQAgoJDv74ftz6Kg8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078422; c=relaxed/simple;
	bh=H/oVc0/R243WLhuh35k20xoR6ierm4mlpBoLWVy2YYA=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kjHkY6Q55jVkp+kExPNeBRyqBKqEa0KONd3ZndLoIShaito6O2myhsngk9zGtsjoHyfu9vWCICHJ5ahGKbM/7UwmssQtjZaZsGK74jc4NjkmjKQq35zfjgMsSLZbbrdl0TTo5qlDxLw4ERg2emcfkDH9DGDv7yOmpUW+9Z+K3zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YPO6Qff9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709078421; x=1740614421;
  h=from:to:subject:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=H/oVc0/R243WLhuh35k20xoR6ierm4mlpBoLWVy2YYA=;
  b=YPO6Qff9DIGG1P/5TaAa/jFyoxD7X+9fkvBFPkFhTUZ0pP90pkqvrmVj
   i+flQJhfJry7wvVDU7yGRroEsj6nLY9fjDN9QiVzgobwyxPmyMdvnlJbI
   jsH/BMC+0sFRFZobnWtQrtLEJmFa2/Jxu70r1AIsjbjdmmVRjo93+pmWB
   r4ZLRMxEvRmgHYqPlSlpEmeiC5wTTDMfPnSM10xzINJN9q9XOM8DKJ04n
   zo6HngSz4GQ6u9Rv1wdhebqDSiO5r+65d62yXkk7mMjr5GJqDBCO4okuU
   hR7uQWyU0ej0KVImY4y+J3exHLcWeElcqPulUfZbowhHW/NL4oHL84Qms
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="25919835"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="25919835"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="7439168"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 16:00:17 -0800
Received: from debox1-desk4.lan (unknown [10.251.6.149])
	by linux.intel.com (Postfix) with ESMTP id 1231B580D7F;
	Tue, 27 Feb 2024 16:00:17 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: david.e.box@linux.intel.com,
	rajvi.jingar@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Subject: [PATCH V2 4/9] platform/x86/intel/sdsi: Add attribute to read the current meter state
Date: Tue, 27 Feb 2024 16:00:11 -0800
Message-Id: <20240228000016.1685518-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228000016.1685518-1-david.e.box@linux.intel.com>
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The meter_certificate file provides access to metering information that may
be attested but is only updated every 8 hours. Add new attribute,
meter_current, to allow reading an untested snapshot of the current values.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2 - make control_flags a parameter to be eventually passed to
     sdsi_mbox_cmd_read(). This removes the need for a lock which had been
     added to protect control_flags when it was a member of the private
     struct.

 drivers/platform/x86/intel/sdsi.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index bb3eaf5eb382..277e4f4b20ac 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -68,6 +68,7 @@
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
 #define CTRL_INBAND_LOCK		BIT(32)
+#define CTRL_METER_ENABLE_DRAM		BIT(33)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -95,6 +96,7 @@ enum sdsi_command {
 struct sdsi_mbox_info {
 	u64	*payload;
 	void	*buffer;
+	u64	control_flags;
 	int	size;
 };
 
@@ -250,7 +252,8 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 	control = FIELD_PREP(CTRL_EOM, 1) |
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size) |
+		  info->control_flags;
 	writeq(control, priv->control_addr);
 
 	return sdsi_mbox_poll(priv, info, data_size);
@@ -424,8 +427,8 @@ static ssize_t provision_cap_write(struct file *filp, struct kobject *kobj,
 static BIN_ATTR_WO(provision_cap, SDSI_SIZE_WRITE_MSG);
 
 static ssize_t
-certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
-		 size_t count)
+certificate_read(u64 command, u64 control_flags, struct sdsi_priv *priv,
+		 char *buf, loff_t off, size_t count)
 {
 	struct sdsi_mbox_info info = {};
 	size_t size;
@@ -441,6 +444,7 @@ certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
 
 	info.payload = &command;
 	info.size = sizeof(command);
+	info.control_flags = control_flags;
 
 	ret = mutex_lock_interruptible(&priv->mb_lock);
 	if (ret)
@@ -472,7 +476,7 @@ state_certificate_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
 
-	return certificate_read(SDSI_CMD_READ_STATE, priv, buf, off, count);
+	return certificate_read(SDSI_CMD_READ_STATE, 0, priv, buf, off, count);
 }
 static BIN_ATTR_ADMIN_RO(state_certificate, SDSI_SIZE_READ_MSG);
 
@@ -484,10 +488,23 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
 
-	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+	return certificate_read(SDSI_CMD_READ_METER, 0, priv, buf, off, count);
 }
 static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
 
+static ssize_t
+meter_current_read(struct file *filp, struct kobject *kobj,
+		   struct bin_attribute *attr, char *buf, loff_t off,
+		   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+
+	return certificate_read(SDSI_CMD_READ_METER, CTRL_METER_ENABLE_DRAM,
+				priv, buf, off, count);
+}
+static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
+
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr, char *buf, loff_t off,
 			      size_t count)
@@ -518,6 +535,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
 	&bin_attr_meter_certificate,
+	&bin_attr_meter_current,
 	&bin_attr_provision_akc,
 	&bin_attr_provision_cap,
 	NULL
@@ -537,7 +555,7 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
 	if (!(priv->features & SDSI_FEATURE_SDSI))
 		return 0;
 
-	if (attr == &bin_attr_meter_certificate)
+	if (attr == &bin_attr_meter_certificate || attr == &bin_attr_meter_current)
 		return (priv->features & SDSI_FEATURE_METERING) ?
 				attr->attr.mode : 0;
 
-- 
2.34.1


