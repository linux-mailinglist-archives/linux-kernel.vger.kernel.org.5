Return-Path: <linux-kernel+bounces-87081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F71F86CF2C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFE4F1F26F78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7264F16065F;
	Thu, 29 Feb 2024 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hPUpE9ty"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8CA160657;
	Thu, 29 Feb 2024 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709224077; cv=none; b=ocZ9hH0129KY62tnz4Hhzn7jDtXJTd5rg1n66AL1sIOG6Nb45BELjJshb+Gq3YbXDDSlsHr4D3jtQCIfxZtrlnJGTmPHTXL99sSs9IY2fw0Hbpv6lyrnA4WPBU1AvXxPzcNyEeV1owugLJakoeGWFJrisMhkjAovWHsbT57+2ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709224077; c=relaxed/simple;
	bh=FZ4hzcjZ3N2IVSb6CQTAkW7bY97q2ac7mesHQV4f33s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H22IJbaS9p8DbmJ/GNrdHPmbgVmZE7IkIYrFhssPD22dwF1fADwcTznP08iMNC1OupL3Su/kzcd0F/PlfaseYyty7mjfsTuzXBz7wDyHA/PtkClb9aIM0icb+3G6JP5mfWyCzYkhf0RFRkVTEX+saM4DnzXvVLrX0P0wJp/8z8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hPUpE9ty; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709224075; x=1740760075;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FZ4hzcjZ3N2IVSb6CQTAkW7bY97q2ac7mesHQV4f33s=;
  b=hPUpE9tyZf54LEKYI69bmcQZi1kTQDHVxQ2Gd9GnzokOvdmwpdg/zrNf
   HF26moOhPO/GqjMAeHCxIzdg8rU7+Ypu00XYxiMwBcZWtNbsnTPSL61yo
   D4DTKevR0v6tMwpO9KwMAanLefTuvx4sez6tO8yvclENTQCyXcu4eQs2h
   vnes3gcheYwjWwkM73Z1+Iq0v2Wl55AUGgDDKIs2sR/f9eJargUynG4Ra
   oZIKnbdUD2m4pqK0RWVuXL2TkziX3XYH2Aqwj2LCG8P/jMqw+PdgHSSHO
   qmROu/9VpBLmxDfdzKmqyNmPK9cjNcHgrDeVq4lUqDepHZmDVbscuiZXK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="6660709"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6660709"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 08:27:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="937036137"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="937036137"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 29 Feb 2024 08:27:45 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id BB8384E9; Thu, 29 Feb 2024 18:27:44 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v3 4/4] device property: Don't use "proxy" headers
Date: Thu, 29 Feb 2024 18:23:46 +0200
Message-ID: <20240229162741.3854912-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
References: <20240229162741.3854912-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Reviewed-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c  | 11 ++++++-----
 drivers/base/swnode.c    | 13 ++++++++++++-
 include/linux/fwnode.h   |  4 ++--
 include/linux/property.h |  1 +
 4 files changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index d983a4dea105..6a3a434d0d6f 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -7,15 +7,16 @@
  *          Mika Westerberg <mika.westerberg@linux.intel.com>
  */
 
-#include <linux/acpi.h>
+#include <linux/device.h>
+#include <linux/err.h>
 #include <linux/export.h>
-#include <linux/kernel.h>
+#include <linux/kconfig.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_graph.h>
-#include <linux/of_irq.h>
 #include <linux/property.h>
 #include <linux/phy.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/types.h>
 
 struct fwnode_handle *__dev_fwnode(struct device *dev)
 {
diff --git a/drivers/base/swnode.c b/drivers/base/swnode.c
index 36512fb75a20..eb6eb25b343b 100644
--- a/drivers/base/swnode.c
+++ b/drivers/base/swnode.c
@@ -6,10 +6,21 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/container_of.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/export.h>
+#include <linux/idr.h>
+#include <linux/init.h>
+#include <linux/kobject.h>
+#include <linux/kstrtox.h>
+#include <linux/list.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include "base.h"
 
diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4228c45d5ccc..80f3cd91b471 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -9,10 +9,10 @@
 #ifndef _LINUX_FWNODE_H_
 #define _LINUX_FWNODE_H_
 
-#include <linux/types.h>
-#include <linux/list.h>
 #include <linux/bits.h>
 #include <linux/err.h>
+#include <linux/list.h>
+#include <linux/types.h>
 
 enum dev_dma_attr {
 	DEV_DMA_NOT_SUPPORTED,
diff --git a/include/linux/property.h b/include/linux/property.h
index 5761878d42c7..61fc20e5f81f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -11,6 +11,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/args.h>
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/fwnode.h>
-- 
2.43.0.rc1.1.gbec44491f096


