Return-Path: <linux-kernel+bounces-47472-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9F5844E64
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 505571C21A45
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14D63B194;
	Thu,  1 Feb 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GU3F8raB"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC598EAE3;
	Thu,  1 Feb 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749673; cv=none; b=uf5vNHWuLL1uWWHLvRBtVBMwTvxVf//bSXRM9y7a5MbuFA05Xn0EcaRHxjeIWy8IjJgU6ompMCyE/vOMGjCYIqerQ72n7CxttVN0NfKDm9/WvdLyzBwpfJFgvkaEYNtjnn3rX7vrb4MEt+omSMzuVUZtGAy8at8jVz0/q43l6Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749673; c=relaxed/simple;
	bh=/sbcQrFxPD3yMhBX/Ocbb8dAANHobtfGIw+UodSoVjg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IC1bmQiX9jayQejDcRXdhoeqyIYdwD72/w8yyV6SnoZ1qYlf6chgaDGiJKzyoATUFL68QMUnFBzNJUJsRMN3pNpd32UlEieeyxSJrrFFKsVKo/P0gXNqygdwVMQQCHvk+JyK61tZ3ZAkyfK1uGgsM9EfUUz34+aG6q4z0wTcAFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GU3F8raB; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749672; x=1738285672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/sbcQrFxPD3yMhBX/Ocbb8dAANHobtfGIw+UodSoVjg=;
  b=GU3F8raBSkwRn2Yyg8MIEIgO628ztiNWWco2tJklkb6kkm1kkpbNO657
   uc20lDiR/7ZZpLTBfE4cNgLekjBRikq/NzKjPdCCHgJtyiJbsLnBbPpaV
   fvhLaPwQFLODvBC1smlv//eEwaaYqMSYRXiF7U1hGl0JEcZJCMDcBQGiM
   5rbNnEnGPkdHeBCiFAzkGJ3SkSWWf8F/Gnvw6MuU/GS5ce/mMwEjhVy/m
   4v2vQYvWCenQ0pEmE3cAkyAAVR4JRdzQaA/0LxsXrS0fdf/gP2JG7Rhbd
   DmKfnwk2nexFWjQAupaGZOPBvc/hxa8193yUuAovr+Vg3FamxdFciahNx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10533016"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10533016"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4265162"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 55E10580DF0;
	Wed, 31 Jan 2024 17:07:49 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 6/8] platform/x86/intel/sdsi: Add attribute to read the current meter state
Date: Wed, 31 Jan 2024 17:07:45 -0800
Message-Id: <20240201010747.471141-7-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201010747.471141-1-david.e.box@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
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
 drivers/platform/x86/intel/sdsi.c | 42 ++++++++++++++++++++++++++++---
 drivers/platform/x86/intel/sdsi.h |  2 ++
 2 files changed, 41 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 287780fe65bb..171899b4a671 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -62,6 +62,7 @@
 #define CTRL_COMPLETE			BIT(6)
 #define CTRL_READY			BIT(7)
 #define CTRL_INBAND_LOCK		BIT(32)
+#define CTRL_METER_ENABLE_DRAM		BIT(33)
 #define CTRL_STATUS			GENMASK(15, 8)
 #define CTRL_PACKET_SIZE		GENMASK(31, 16)
 #define CTRL_MSG_SIZE			GENMASK(63, 48)
@@ -235,8 +236,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 	control = FIELD_PREP(CTRL_EOM, 1) |
 		  FIELD_PREP(CTRL_SOM, 1) |
 		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size) |
+		  priv->control_flags;
 	writeq(control, priv->control_addr);
+	priv->control_flags = 0;
 
 	return sdsi_mbox_poll(priv, info, data_size);
 }
@@ -468,11 +471,42 @@ meter_certificate_read(struct file *filp, struct kobject *kobj,
 {
 	struct device *dev = kobj_to_dev(kobj);
 	struct sdsi_priv *priv = dev_get_drvdata(dev);
+	int ret;
 
-	return certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+	ret = mutex_lock_interruptible(&priv->meter_lock);
+	if (ret)
+		return ret;
+
+	ret = certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+
+	mutex_unlock(&priv->meter_lock);
+
+	return ret;
 }
 static BIN_ATTR_ADMIN_RO(meter_certificate, SDSI_SIZE_READ_MSG);
 
+static ssize_t
+meter_current_read(struct file *filp, struct kobject *kobj,
+		   struct bin_attribute *attr, char *buf, loff_t off,
+		   size_t count)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct sdsi_priv *priv = dev_get_drvdata(dev);
+	int ret;
+
+	ret = mutex_lock_interruptible(&priv->meter_lock);
+	if (ret)
+		return ret;
+
+	priv->control_flags = CTRL_METER_ENABLE_DRAM;
+	ret = certificate_read(SDSI_CMD_READ_METER, priv, buf, off, count);
+
+	mutex_unlock(&priv->meter_lock);
+
+	return ret;
+}
+static BIN_ATTR_ADMIN_RO(meter_current, SDSI_SIZE_READ_MSG);
+
 static ssize_t registers_read(struct file *filp, struct kobject *kobj,
 			      struct bin_attribute *attr, char *buf, loff_t off,
 			      size_t count)
@@ -503,6 +537,7 @@ static struct bin_attribute *sdsi_bin_attrs[] = {
 	&bin_attr_registers,
 	&bin_attr_state_certificate,
 	&bin_attr_meter_certificate,
+	&bin_attr_meter_current,
 	&bin_attr_provision_akc,
 	&bin_attr_provision_cap,
 	NULL
@@ -522,7 +557,7 @@ sdsi_battr_is_visible(struct kobject *kobj, struct bin_attribute *attr, int n)
 	if (!(priv->features & SDSI_FEATURE_SDSI))
 		return 0;
 
-	if (attr == &bin_attr_meter_certificate)
+	if (attr == &bin_attr_meter_certificate || attr == &bin_attr_meter_current)
 		return (priv->features & SDSI_FEATURE_METERING) ?
 				attr->attr.mode : 0;
 
@@ -725,6 +760,7 @@ static int sdsi_probe(struct auxiliary_device *auxdev, const struct auxiliary_de
 	priv->dev = &auxdev->dev;
 	priv->id = auxdev->id;
 	mutex_init(&priv->mb_lock);
+	mutex_init(&priv->meter_lock);
 	auxiliary_set_drvdata(auxdev, priv);
 
 	/* Get the SDSi discovery table */
diff --git a/drivers/platform/x86/intel/sdsi.h b/drivers/platform/x86/intel/sdsi.h
index 256618eb3136..e20cf279212e 100644
--- a/drivers/platform/x86/intel/sdsi.h
+++ b/drivers/platform/x86/intel/sdsi.h
@@ -18,12 +18,14 @@ struct device;
 
 struct sdsi_priv {
 	struct mutex			mb_lock;	/* Mailbox access lock */
+	struct mutex			meter_lock;
 	struct device			*dev;
 	struct intel_vsec_device	*ivdev;
 	struct list_head		node;
 	void __iomem			*control_addr;
 	void __iomem			*mbox_addr;
 	void __iomem			*regs_addr;
+	u64				control_flags;
 	int				control_size;
 	int				maibox_size;
 	int				registers_size;
-- 
2.34.1


