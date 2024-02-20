Return-Path: <linux-kernel+bounces-73345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D44485C143
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 17:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67221F2410A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9CB77649;
	Tue, 20 Feb 2024 16:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KUH1yyvS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4A97640F;
	Tue, 20 Feb 2024 16:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708446178; cv=none; b=MfvUvt3V0Kn7tI+YyHGqX7rob1aFGbXIUxKGw0Qaq/vLx7Sd1Yxlo9V6YlicHMbYphvesHjdlpdx7Fz3bNRK2Ko6mQ121MtVD0G6nTGehWd1YMwErskzZpWxYHHzSNa+MAKRXO0QqCKA3WiFH7SHjCiaCBGm/C/QmblAYTHlg7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708446178; c=relaxed/simple;
	bh=4EXMl5e7uXAcwic9xOAtMCb24DT48b9NpcADcBf9+fY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BVLZWDsMI2p5v/7HrgPV4FOrs3sB0yIVdRP4S+5Vbt7nwrHTNWWzniHpJ4fBLQ8/9/FMjck4VrfOeL8S1Ht6KooYl9bmvwCIbREX0R3Clyr5dK09cYjgsrCbwmnFReMSGandfBt6Kr0lvtMGzyRbZwnz3CRr31vrbSK32hvFAWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KUH1yyvS; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708446177; x=1739982177;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4EXMl5e7uXAcwic9xOAtMCb24DT48b9NpcADcBf9+fY=;
  b=KUH1yyvSKQSgLdPrNnI9R4n01LxoiCePXG1NMMLuO974zHhn0f8LKor/
   gE+l+lpknbHJ1fokxQs9Z5Lr94rrjz7m0FiM+UhXBrdjzr9hUL5XGMul6
   nh5TJ1mT3wJwS4ho6e4l8Kh8LGihD6y3W+CAZDvLWauvTQwBikapj/rNB
   tG6P3OwgBk+pbPE8YBS6yudayAzcHQ6lmJw2sQ6MBsmCevaUdVycKfUqQ
   QMOcxkDfKeM+AIDbKKZ9iGvWr2hoCGc4y8x2DRBMhc7/EcxwjYfZXDrhG
   jLXJPqsu072Cab1W5n83QLYwgB7d0hrfvzpBXuzwdfzRxv31OWgYSMclX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="3021833"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="3021833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 08:19:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="936472936"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="936472936"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 20 Feb 2024 08:19:35 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id E7399305; Tue, 20 Feb 2024 18:19:33 +0200 (EET)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Subject: [PATCH v1 1/1] device property: Don't use "proxy" headers
Date: Tue, 20 Feb 2024 18:18:50 +0200
Message-ID: <20240220161931.3091680-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.43.0.rc1.1.gbec44491f096
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update header inclusions to follow IWYU (Include What You Use)
principle.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

This one heavily depends on the 
https://lore.kernel.org/r/20240220161002.2983334-1-andriy.shevchenko@linux.intel.com

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


