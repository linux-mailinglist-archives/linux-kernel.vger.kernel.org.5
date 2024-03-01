Return-Path: <linux-kernel+bounces-88883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9E486E7ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:02:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7294A28749C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CDE282E3;
	Fri,  1 Mar 2024 18:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AW8e37CR"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D05418C05;
	Fri,  1 Mar 2024 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709316130; cv=none; b=XSd42mCng1RuTzdTShBxKKnbsLEXXU5eNP9PSqiFaO+SUbULj9ujsqIUNn/WTQBamYVEg5AC0aZfo/upTw5K+r5UMDe9yiBZmkILFl1Gi445sLx8gwyMbBsNsSS161ua8jc5mH0dA41EeeZtpEYGapzRQXrTMI5VeG98F3Vfx1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709316130; c=relaxed/simple;
	bh=M6HgetbOB4Qie85fj5S+id3KjUoO4wwWwiWoU9zE7fw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P3GaFJwpoOljpBuLrkM4AnwhM415YKpP4K+RtcvnoJVTXPiYqZw1YHgzQ4sYlhnbdqzrhhM+mBVG99q7sqCvaxIe8hQq5JBG8XklLN+zrZDehRDmwfm1GiL7joePvcP9ctRQ6PNTNTFMB/SRvGqkaBjOxLVvGvUNBCQI1YRbTuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AW8e37CR; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709316129; x=1740852129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M6HgetbOB4Qie85fj5S+id3KjUoO4wwWwiWoU9zE7fw=;
  b=AW8e37CRvhpseyqX3RkoAzoZIacm7uaEehgoLHnxPXqa1wpj72uMA0zV
   npAQm3QP37Gy7aa+jHIY30q1+h54xFWbcs3/dcyIRG9Lz2cYjsCJfK6qZ
   e2gey7OjJ77BJa5eUo0WlNVuZA3N49MTgkD5HBpYO+PfA5vWrFmVOJ0Io
   Ng6p02f/hVTUgbuxfy+zub76ggwcZ/bt5wC/J44blO0w9Pbi5qJmovOko
   74+3W7Tnpsl2FCDigpP/LjA2gpkiQB1Wvg3dDMv1iuSmN+aL/vWc8NkYf
   j7PrOsBUUIYUYDtNNtUqDsGo6zCmzMuKQZo9DfFA81DI5L+6rnWIqwujN
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="7684811"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="7684811"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:01:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="937037845"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="937037845"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 01 Mar 2024 10:01:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 517B05F5; Fri,  1 Mar 2024 20:01:41 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>
Subject: [PATCH v4 4/4] device property: Don't use "proxy" headers
Date: Fri,  1 Mar 2024 20:00:08 +0200
Message-ID: <20240301180138.271590-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
References: <20240301180138.271590-1-andriy.shevchenko@linux.intel.com>
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
index afa1bf2b3c5a..7324a704a9a1 100644
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
index 1f0135e24d00..3a1045eb786c 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -11,6 +11,7 @@
 #define _LINUX_PROPERTY_H_
 
 #include <linux/args.h>
+#include <linux/array_size.h>
 #include <linux/bits.h>
 #include <linux/fwnode.h>
 #include <linux/stddef.h>
-- 
2.43.0.rc1.1.gbec44491f096


