Return-Path: <linux-kernel+bounces-47471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8849844E63
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3868B1F2907F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CFC03A8EB;
	Thu,  1 Feb 2024 01:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h/N9d2Qn"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7623F568C;
	Thu,  1 Feb 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749673; cv=none; b=KIPnlmuB2MgHLRxDGZo4NVYFG3YcJB0q3HdKJti9TTK2x0ebckDeAYOxlYWVt+D86Hr8nzdMGlFuDx7eOi2mVszZa/B46XrNgEhZvV8Q1jJ8f7nptUKVlTXqwAMY9d5yrBeNFenM2pbY2Dw+t1wMDQjvmrdzLdqbi5+UbTtoL78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749673; c=relaxed/simple;
	bh=tsmNJuvJTUPKJwIw1JsNvBWJzwsEi0xNRBm9glWNJPE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FtWPXTgmL6sPh9LXqCukki7nlbIi4TzHmXwgEa5bZEqzinp7MzW+8jRnUlv+XEGZ0raTrW9AUKNpop9dxld1sqG205BoxpU+7SGofz+1rAOOQAd+30ODY2DuOQVPTypokHSMgIbpgMGKxgerShJdfh1RTjOdi/yv/6fVJ7pQ2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h/N9d2Qn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749672; x=1738285672;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tsmNJuvJTUPKJwIw1JsNvBWJzwsEi0xNRBm9glWNJPE=;
  b=h/N9d2QnUzHaQYPgyN5GzsDg9iJwBWjCf8JSqBYsZRRh9xYyHB8wNHei
   OJdU4Cb8CnDfxoUzyPOIkEbXq9Q4GBc7ta0sKuFPa7LHTbvanb9lzeruc
   p2KlVC19XMgCn0exUGWQo4SwKMOlacOONQFZeVwoU0OgY947RjxvDG1Qn
   BbIFhYVCb/AdTPrucoZqqJeUuCaBXP6YwcyGMUP9p9nB5rY+T57RYuEL1
   VBUZdSI6sstG9+oLR0VSJVj+PPxNx76QrWJ0vaE/HK8pbGIzoYzhx4N/M
   wClpWTFpKw8yxd7Yug0BzTvRA10qCJWFyQJ+TTixvxvScUNOc2bFkckq+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11145820"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11145820"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37057409"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:07:49 -0800
Received: from debox1-desk4.lan (unknown [10.212.205.115])
	by linux.intel.com (Postfix) with ESMTP id 8AFAC580E05;
	Wed, 31 Jan 2024 17:07:48 -0800 (PST)
From: "David E. Box" <david.e.box@linux.intel.com>
To: netdev@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com,
	david.e.box@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [PATCH 2/8] platform/x86/intel/sdsi: Combine read and write mailbox flows
Date: Wed, 31 Jan 2024 17:07:41 -0800
Message-Id: <20240201010747.471141-3-david.e.box@linux.intel.com>
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

The current mailbox commands are either read-only or write-only and the
flow is different for each. New commands will need to send and receive
data. In preparation for these commands, create a common polling function
to handle sending data and receiving in the same transaction.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/platform/x86/intel/sdsi.c | 79 +++++++++++++++++--------------
 1 file changed, 44 insertions(+), 35 deletions(-)

diff --git a/drivers/platform/x86/intel/sdsi.c b/drivers/platform/x86/intel/sdsi.c
index a70c071de6e2..05a35f2f85b6 100644
--- a/drivers/platform/x86/intel/sdsi.c
+++ b/drivers/platform/x86/intel/sdsi.c
@@ -15,6 +15,7 @@
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
@@ -156,8 +157,8 @@ static int sdsi_status_to_errno(u32 status)
 	}
 }
 
-static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
-			      size_t *data_size)
+static int sdsi_mbox_poll(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			  size_t *data_size)
 {
 	struct device *dev = priv->dev;
 	u32 total, loop, eom, status, message_size;
@@ -166,18 +167,10 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 
 	lockdep_assert_held(&priv->mb_lock);
 
-	/* Format and send the read command */
-	control = FIELD_PREP(CTRL_EOM, 1) |
-		  FIELD_PREP(CTRL_SOM, 1) |
-		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
-		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
-	writeq(control, priv->control_addr);
-
 	/* For reads, data sizes that are larger than the mailbox size are read in packets. */
 	total = 0;
 	loop = 0;
 	do {
-		void *buf = info->buffer + (SDSI_SIZE_MAILBOX * loop);
 		u32 packet_size;
 
 		/* Poll on ready bit */
@@ -195,6 +188,11 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		if (ret)
 			break;
 
+		if (!packet_size) {
+			sdsi_complete_transaction(priv);
+			break;
+		}
+
 		/* Only the last packet can be less than the mailbox size. */
 		if (!eom && packet_size != SDSI_SIZE_MAILBOX) {
 			dev_err(dev, "Invalid packet size\n");
@@ -208,9 +206,13 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 			break;
 		}
 
-		sdsi_memcpy64_fromio(buf, priv->mbox_addr, round_up(packet_size, SDSI_SIZE_CMD));
+		if (packet_size && info->buffer) {
+			void *buf = info->buffer + array_size(SDSI_SIZE_MAILBOX, loop);
 
-		total += packet_size;
+			sdsi_memcpy64_fromio(buf, priv->mbox_addr,
+					     round_up(packet_size, SDSI_SIZE_CMD));
+			total += packet_size;
+		}
 
 		sdsi_complete_transaction(priv);
 	} while (!eom && ++loop < MBOX_MAX_PACKETS);
@@ -230,16 +232,33 @@ static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *inf
 		dev_warn(dev, "Read count %u differs from expected count %u\n",
 			 total, message_size);
 
-	*data_size = total;
+	if (data_size)
+		*data_size = total;
 
 	return 0;
 }
 
-static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_cmd_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			      size_t *data_size)
+{
+	u64 control;
+
+	lockdep_assert_held(&priv->mb_lock);
+
+	/* Format and send the read command */
+	control = FIELD_PREP(CTRL_EOM, 1) |
+		  FIELD_PREP(CTRL_SOM, 1) |
+		  FIELD_PREP(CTRL_RUN_BUSY, 1) |
+		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
+	writeq(control, priv->control_addr);
+
+	return sdsi_mbox_poll(priv, info, data_size);
+}
+
+static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			       size_t *data_size)
 {
 	u64 control;
-	u32 status;
-	int ret;
 
 	lockdep_assert_held(&priv->mb_lock);
 
@@ -256,20 +275,7 @@ static int sdsi_mbox_cmd_write(struct sdsi_priv *priv, struct sdsi_mbox_info *in
 		  FIELD_PREP(CTRL_PACKET_SIZE, info->size);
 	writeq(control, priv->control_addr);
 
-	/* Poll on ready bit */
-	ret = readq_poll_timeout(priv->control_addr, control, control & CTRL_READY,
-				 MBOX_POLLING_PERIOD_US, MBOX_TIMEOUT_US);
-
-	if (ret)
-		goto release_mbox;
-
-	status = FIELD_GET(CTRL_STATUS, control);
-	ret = sdsi_status_to_errno(status);
-
-release_mbox:
-	sdsi_complete_transaction(priv);
-
-	return ret;
+	return sdsi_mbox_poll(priv, info, data_size);
 }
 
 static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
@@ -313,7 +319,8 @@ static int sdsi_mbox_acquire(struct sdsi_priv *priv, struct sdsi_mbox_info *info
 	return ret;
 }
 
-static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
+static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info,
+			   size_t *data_size)
 {
 	int ret;
 
@@ -323,7 +330,7 @@ static int sdsi_mbox_write(struct sdsi_priv *priv, struct sdsi_mbox_info *info)
 	if (ret)
 		return ret;
 
-	return sdsi_mbox_cmd_write(priv, info);
+	return sdsi_mbox_cmd_write(priv, info, data_size);
 }
 
 static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, size_t *data_size)
@@ -342,7 +349,7 @@ static int sdsi_mbox_read(struct sdsi_priv *priv, struct sdsi_mbox_info *info, s
 static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 			      enum sdsi_command command)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	int ret;
 
 	if (count > (SDSI_SIZE_WRITE_MSG - SDSI_SIZE_CMD))
@@ -364,7 +371,9 @@ static ssize_t sdsi_provision(struct sdsi_priv *priv, char *buf, size_t count,
 	ret = mutex_lock_interruptible(&priv->mb_lock);
 	if (ret)
 		goto free_payload;
-	ret = sdsi_mbox_write(priv, &info);
+
+	ret = sdsi_mbox_write(priv, &info, NULL);
+
 	mutex_unlock(&priv->mb_lock);
 
 free_payload:
@@ -408,7 +417,7 @@ static ssize_t
 certificate_read(u64 command, struct sdsi_priv *priv, char *buf, loff_t off,
 		 size_t count)
 {
-	struct sdsi_mbox_info info;
+	struct sdsi_mbox_info info = {};
 	size_t size;
 	int ret;
 
-- 
2.34.1


