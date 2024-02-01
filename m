Return-Path: <linux-kernel+bounces-47470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A932844E60
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:09:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E0C71C2798B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C245D39FF9;
	Thu,  1 Feb 2024 01:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IujJueKh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321544C75;
	Thu,  1 Feb 2024 01:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749672; cv=none; b=k8SRgiBOiBq5uo8ID7VKJMUKo4ZklfR3ocHJiZxF3nIKeD38UZcA+S6tWLiuqSBOUZR6tcOmPpitOdNB5duJ9keM1jKqzcwYNTfIhSkBU6iV4+UNcgLxMj/wXDHEJyD0nZtETDq0urHbt4zsf21iWgdpKfv1s28ouvOu2nbtZ/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749672; c=relaxed/simple;
	bh=HQqVP5qs3cQCmLjUe703sRStc+w/AM27AwAqsgg0OhI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GoSjVji1ofXf+Ux/zj+hcitONnVt1LH+Utmz++FFtfRQlqO9nJUlBgQFF8ZHo6wtvo96SITSkn50Qb9L3SGFMQMK/VOQkYI3iz5MOlCBwCP9KRyjuKybDgfIP/tYTgXGh6RC4tyJyiqcZ4IbYSXiBMsSRXmeAV5CvrZmAg6ItSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IujJueKh; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749671; x=1738285671;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HQqVP5qs3cQCmLjUe703sRStc+w/AM27AwAqsgg0OhI=;
  b=IujJueKhqoOZVhZ+E/FmdMLxLaCbv+VEXRsmhDvORAjD+YABchzMK7Md
   8X9gr7nvaCwPHxwyEwrKXKmunTDHknHp5DGvKxhYBwvLKbJ6kk40270IH
   t3aY64f8RfhoCAeyrsZvp3HMBT2d3Cf1FuB30A0DdCLyZruFUUAguZem1
   O7TCSblFy5t41ZnnBHXWVCLJw7Ia04T0p6wOxsdsFIU7K2a/txV2Bkq+G
   ubnHLrxFRWP1K0j0zMCwhwRoiHnDDjXUS56o5JJfVY9NLlLDaYP7rFZzM
   aWW2PZpHVlpg4pyGXrYh1nnV7UtMsDaXZEo9KvGLSD/K2RD1L+0LrOt8z
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10533014"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="10533014"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="4265160"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id B8435580201;
	Wed, 31 Jan 2024 17:07:48 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/8] platform/x86/intel/sdsi: Add header file
Date: Wed, 31 Jan 2024 17:07:42 -0800
Message-Id: <20240201010747.471141-4-david.e.box@linux.intel.com>
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

In preparation for new source files, move common structures to a new
header flie.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 MAINTAINERS                       |  1 +
 drivers/platform/x86/intel/sdsi.c | 23 +----------------------
 drivers/platform/x86/intel/sdsi.h | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 22 deletions(-)
 create mode 100644 drivers/platform/x86/intel/sdsi.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a69..09ef8497e48a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11042,6 +11042,7 @@ INTEL SDSI DRIVER
 M:	David E. Box <david.e.box@linux.intel.com>
 S:	Supported
 F:	drivers/platform/x86/intel/sdsi.c
+F:	drivers/platform/x86/intel/sdsi.h
 F:	tools/arch/x86/intel_sdsi/
 F:	tools/testing/selftests/drivers/sdsi/
 
diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index 05a35f2f85b6..d48bb648f0b2 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -22,24 +22,16 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 
+#include "sdsi.h"
 #include "vsec.h"
 
 #define ACCESS_TYPE_BARID		2
 #define ACCESS_TYPE_LOCAL		3
 
 #define SDSI_MIN_SIZE_DWORDS		276
-#define SDSI_SIZE_MAILBOX		1024
 #define SDSI_SIZE_REGS			80
 #define SDSI_SIZE_CMD			sizeof(u64)
 
-/*
- * Write messages are currently up to the size of the mailbox
- * while read messages are up to 4 times the size of the
- * mailbox, sent in packets
- */
-#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
-#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
-
 #define SDSI_ENABLED_FEATURES_OFFSET	16
 #define SDSI_FEATURE_SDSI		BIT(3)
 #define SDSI_FEATURE_METERING		BIT(26)
@@ -103,19 +95,6 @@ struct disc_table {
 	u32	offset;
 };
 
-struct sdsi_priv {
-	struct mutex		mb_lock;	/* Mailbox access lock */
-	struct device		*dev;
-	void __iomem		*control_addr;
-	void __iomem		*mbox_addr;
-	void __iomem		*regs_addr;
-	int			control_size;
-	int			maibox_size;
-	int			registers_size;
-	u32			guid;
-	u32			features;
-};
-
 /* SDSi mailbox operations must be performed using 64bit mov instructions */
 static __always_inline void
 sdsi_memcpy64_toio(u64 __iomem *to, const u64 *from, size_t count_bytes)
diff --git a/drivers/platform/x86/intel/sdsi.h b/drivers/platform/x86/intel/sdsi.h
new file mode 100644
index 000000000000..d0d7450c7b2b
--- /dev/null
+++ b/drivers/platform/x86/intel/sdsi.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __PDx86_SDSI_H_
+#define __PDx86_SDSI_H_
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#define SDSI_SIZE_MAILBOX		1024
+
+/*
+ * Write messages are currently up to the size of the mailbox
+ * while read messages are up to 4 times the size of the
+ * mailbox, sent in packets
+ */
+#define SDSI_SIZE_WRITE_MSG		SDSI_SIZE_MAILBOX
+#define SDSI_SIZE_READ_MSG		(SDSI_SIZE_MAILBOX * 4)
+
+struct device;
+
+struct sdsi_priv {
+	struct mutex			mb_lock;	/* Mailbox access lock */
+	struct device			*dev;
+	void __iomem			*control_addr;
+	void __iomem			*mbox_addr;
+	void __iomem			*regs_addr;
+	int				control_size;
+	int				maibox_size;
+	int				registers_size;
+	u32				guid;
+	u32				features;
+};
+#endif
-- 
2.34.1


