Return-Path: <linux-kernel+bounces-78653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0E0861692
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B78B01F24A96
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D5F484A3C;
	Fri, 23 Feb 2024 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GytQummD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF1A82D6F;
	Fri, 23 Feb 2024 15:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703869; cv=none; b=DNzEdqL97oc97DqhhjA9LWiwEkXUTbEMnQsKrhpIyk87gWJHoOwhuG+PjgMXwnv10uansY8sVw0sx5pDLSKqU6l8gbtHaYuBI3yIuT/Cg+XU3S2jfzjSuqRFSDyjMbTbOR2skw+ILgPYgVo2pKyLtYRFVdZCQkDjfJR9iW8CZNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703869; c=relaxed/simple;
	bh=JS1+T8ufpQOpwZXWCdmrwy3mHVd5UFm/zVDUtcRHl10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AATQ9B43h4PaIVLj6g2LvCuzYS37GD8ZugqnPvznhGw6f//gFq3d5C2kZ/o15vLwI55fVrIhXWLy12UjGryYgm5u97C3pCtz+LzaX7rfc2iIfamVb51y8bqdY0FnUTYRIk6MXN8EksQOB7Icb/MMWpg6csfGlgekU3dAPg9jS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GytQummD; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708703868; x=1740239868;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JS1+T8ufpQOpwZXWCdmrwy3mHVd5UFm/zVDUtcRHl10=;
  b=GytQummD9E/tbOD+x75dqnx2WYcOWDpKsgnyvwdBxjI6UXy+aFWLvtZT
   ghnVu0ZdaRMemg1CglJQRMs9GEE1+Id3f9HF68BmT3vHanGVdSaoQzMi3
   E3J9KqVF+Z9Rq/wIlgtWJD5EHK5a6ddtwfCSL54+gAezpQqB5QlddC4Uv
   UDvyRMWVez+Nzxc2mO1m9yIHnwr7rDi09lRpHeY7IrqmKirSdumvKaYN+
   pvv+EqxVtQ2mfgrtKes3jbxyvIJ7R8OQlaIa56BTuUBc/PjnmJ4MNhhVK
   uBC43/rk1bWrCY2a7Kkv9v7IkZ7F8Ri/3Oa0sLNjpE1yURx7nr1TmCfXx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="3187540"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="3187540"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 07:57:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="937025349"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="937025349"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2024 07:57:41 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 39E4680C; Fri, 23 Feb 2024 17:57:40 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Len Brown <lenb@kernel.org>
Subject: [PATCH v2 4/4] device property: Don't use "proxy" headers
Date: Fri, 23 Feb 2024 17:54:39 +0200
Message-ID: <20240223155731.858412-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
In-Reply-To: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
References: <20240223155731.858412-1-andriy.shevchenko@linux.intel.com>
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


